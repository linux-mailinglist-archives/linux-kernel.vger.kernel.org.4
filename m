Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993985FD954
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJMMlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJMMlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:41:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD921759F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:41:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so3640810ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEUb5Rb4yDgrdEzo1wzTJ5kjOY9s+BXnnzPastL8HKw=;
        b=EwdIcF4cxB7mxAlKSpCiZNW6DU+rzmaF5hNVxFWyAv7MxWW8ZG5644DHPhOWkvQKlN
         q3up6g8SR7/msYkKMZUAd/+w7itaOJNumBJVstNJ5ny/H8kUvTEjArsRrCPxci/GxvBy
         scqPsnb7fchuCkdb53mSv+jvdz4CSW6+Pe5S6wBYsQtmwJ+q16uhInJhUEJh69hH0RKx
         cCj1X/OC3RU+gjH+POcRi7Yhomew8gIE3V8uUR+0kaTbecFu4oQWA7/cO1ezhK7R7EKB
         Oc610VM7OA2xbW7qj/NDuSZ3kKg2iCGfy2gqyTE/kIA2CVNqr1SB1nHOgMBMFfhzMslO
         unwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GEUb5Rb4yDgrdEzo1wzTJ5kjOY9s+BXnnzPastL8HKw=;
        b=OvVHN4DMxJZXM2swz2QNWjJC2GmsEgWSa6fDQk+hCtiO0OxgWaKRd1INTUF94et1WO
         0Ch26BkKI7QXe96gM3NR88e1vW7bR2F5RtQuyVltqdLN/BNyuiYW8L+moRkfd2qxs1hW
         SuZfz54OslrqC7Xs1dFOouHspAkV8QycqTNgKHe0Ib4CqM+MBTlT5lGPnEcv6MVH6t/i
         nMdE/mT7RYbUlB1DsztbJSoyVveo3iXIVYuntFeXpR3Gs31dvB4WrIypj9VbqhQiVs/G
         cm5Mg8dvNawwGaYPJGQY3heWp/Ob21aaSAVw8qy1LxvxhIOxTXFcCWfbco0wTAS/NzkW
         ekjg==
X-Gm-Message-State: ACrzQf3kH3fByDzgRSPyfmelfi5uuZKYvYe0gMLrE5+P0BrnZZUc2f5V
        oyqx8XM4tyho2cJWbsgJB5w=
X-Google-Smtp-Source: AMsMyM77b/Iob0FFfj4jC2QN20U55LraGmglSAxMEiqDOETdxHOC8aHEDiu3f3emVQSr47vhLZBRxw==
X-Received: by 2002:a17:907:3f27:b0:78d:ad42:f733 with SMTP id hq39-20020a1709073f2700b0078dad42f733mr17696383ejc.320.1665664859673;
        Thu, 13 Oct 2022 05:40:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709061d4400b0073d7bef38e3sm2949793ejh.45.2022.10.13.05.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Oct 2022 05:40:58 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:40:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] XArray: make xa_dump output more friendly to read
Message-ID: <20221013124058.fpjgfrgyqm2lbw2k@master>
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

Hi, Matthew

Do you get time slot for this?

-- 
Wei Yang
Help you, Help me
