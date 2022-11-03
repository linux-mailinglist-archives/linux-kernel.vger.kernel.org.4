Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48D7617885
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKCISL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:18:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8DE48
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:18:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so3221505ejn.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5YK3vQWyxcwOjRj9COIEdcB67OfbwwMJalFd05s2/E=;
        b=Sz1hhPuen2bbFcdVZ/A6Y2KVwenJ1WxzVHazFXVQPjmNLQ5peJsLpl/MtucSp4iqBo
         u0Ow97SkZxWARoHW1SHJV62VbIEfECiO9wHo4Io+MRKvUBUKueNxDmeIHGzoq/VKXnMb
         tHHgTRsnyMPRomtBNInym/OUDYbPrQGn55FFdKdD1Tmno7djI4BHEXp9Ko9IIlJE8Aco
         u2BKvhBCbd/Q/f6gyOSa+T7TqQn+PJh990Llpo9BJJr1uiBWmoKHlZn3wSS6b6mW4RN0
         ghGpgeIpS1EuztZHjgVKx3lTlQ5yYWHX6Po5I88D0Vra+xxOj7KH2GggSH1TQIsPxYqu
         LwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5YK3vQWyxcwOjRj9COIEdcB67OfbwwMJalFd05s2/E=;
        b=hVNYkfT11t6/dBbNApS/IefrFiPdN+ZzCy+fcYsM3tqoxtbwQZjNWUWpAiqayQkT+l
         luMipcGHcm62aLKFI8/DoFJfgDVI4Tl9kLKidRuf5Y4Of8E3m7qYGQtUu9VUddjKQqYd
         m+7VOlypGLXBOnmE4gV1rszlHUqjQbSZBUDHrbgjJkchWcS5gAe6MWVWxsy5QDr5O+KM
         xJSl6IuMcg50eYGOJq+a1KJhEQvwmjQCW/NzwUkoyDNG+qgNFPTmwTWmFO5xD9sHJ3nj
         3fxETw/iDww2m6+ycpxESRVgAzFVRqTxdxhitWlCH0S2zoekq+ennEmuGOVnoxSOrpbo
         TgxA==
X-Gm-Message-State: ACrzQf1XdZgHahzQ18E73bmcmYImNlDS6v8h7QErq3VKvTeHPhGz7ZSM
        QQ//yzStmibokwh5L90tHmo=
X-Google-Smtp-Source: AMsMyM4k2PYGOb7STs3URIN3I7M7j6DbsmFpzvoNPj8UN+YekJKNW4VW7BXX/V5DSQpOxd5rfzIJGQ==
X-Received: by 2002:a17:907:703:b0:78e:25be:5455 with SMTP id xb3-20020a170907070300b0078e25be5455mr26701774ejb.630.1667463486145;
        Thu, 03 Nov 2022 01:18:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402044400b00461cf924029sm185089edw.42.2022.11.03.01.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Nov 2022 01:18:05 -0700 (PDT)
Date:   Thu, 3 Nov 2022 08:18:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] XArray: make xa_dump output more friendly to read
Message-ID: <20221103081804.3waqv7xsb4kn3k5m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220912124647.17164-1-richard.weiyang@gmail.com>
 <Yx9vxqmBR5rtMm2o@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx9vxqmBR5rtMm2o@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 06:43:34PM +0100, Matthew Wilcox wrote:
>On Mon, Sep 12, 2022 at 12:46:46PM +0000, Wei Yang wrote:
>> This patch helps to adjust xa_dump output by:
>
>Thanks for the patches.  I'm at Plumbers right now, and then I'm taking
>a week off, so I don't really have time to look at them properly.
>I'll try to remember to look at them when I'm back on the 26th.  If I
>haven't responded by the beginning of October, please remind me.

Hello, Matthew

Do you get some time for this?

-- 
Wei Yang
Help you, Help me
