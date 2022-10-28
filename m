Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE786119A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJ1RwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1RwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:52:07 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F0D2CEA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:52:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b5so5458667pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxp1g2Xmt0Uo27W8SXGteSZYRsjJHqr727Tb4bslW3E=;
        b=Q9qKuLvADx6+71DawtNgaRF3zchoRqnNiuk6IX+f40y37ACZJgi6NLu+oGOI2eFiK+
         8hP+One9mDmr9BTk00yjw23BDLUQRVWDOpjd+yVfNMRh/wA8YROkn9yUlYd8yfjMmoiK
         dmF7xbBaMflNW7OC8JvugJ2AjI62AbiDcEJp4vEWGg0d93Hcewpq2GTbe6YZCpqxxLdX
         Tmu3qxRWbZeZyq2eKTYfu9qE26a8OVrAlxU20IXpadzcfMSLcxR/Uo1rTs7FMSAsiL8X
         bbusGg2u8x6jjuOPys5zIrpjtEaDRQV4eWYlVkv17KVwDEAYziscBrPOyGrPKB/uhsDx
         ld3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxp1g2Xmt0Uo27W8SXGteSZYRsjJHqr727Tb4bslW3E=;
        b=K016u5NEb8saHlRLPJ1YBS9QSpq2BhSZKCjAXEiOMDvucBzXv8sicyf0xi4hjkZfTt
         DdKrH+Co97Ln8XkAfs0vlmN5wtVy1acdRvRlfplL9rdzLxS+iRJb5SEZw9wJ1yewIIPF
         V8ELcbXY93tsbAw+iNSi7Z4HtYdIYauC5TECZSEkuXhc3+AW1nS490KX5TDKbSCDZ+Ng
         d2D6vJn7yjizDafLuzr7cojaRBHcNBJzx2xzlpTE1rU55nELcBJp5Zamwrxn7FkTehcL
         15BXKBfH/DY0N85MoIW8mmr+bamgdKtj9SusLFmu+GN/0UTDQj85R6tF0DNiha09NwtI
         yuhQ==
X-Gm-Message-State: ACrzQf2ZHFn14cOP2750vECyMrozZ9tOudb0Ik+0gr+FINuXZUIHOKaP
        XpZ5AMb+krzsBbdEvr0X4fY=
X-Google-Smtp-Source: AMsMyM7wdKJlMh5bMtecumc1yFHyIUOROjCTgEhBgc689Omkh7ENzstbEvgi16kBYjXnqoPapl8qkw==
X-Received: by 2002:a63:85c8:0:b0:46f:5bbb:737f with SMTP id u191-20020a6385c8000000b0046f5bbb737fmr607990pgd.93.1666979526328;
        Fri, 28 Oct 2022 10:52:06 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b00186a2274382sm3364286plx.76.2022.10.28.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:52:04 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:52:01 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace ternary statement with min
 function
Message-ID: <Y1wWwZdlXNil/lug@marshmallow>
References: <Y1neXqVYZ8mq8jH+@marshmallow>
 <Y1oz/w9qfwQ+8gWt@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1oz/w9qfwQ+8gWt@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:32:15AM +0300, Dan Carpenter wrote:
> On Wed, Oct 26, 2022 at 06:26:54PM -0700, Emily Peri wrote:
> > Ternary statements that pick the min of two values can be replaced by
> > the built-in min() function. This improves readability, since its quicker
> > to understand min(x, y) than x < y ? x : y. Issue found by coccicheck.
> > 
> > Signed-off-by: Emily Peri <eperi1024@gmail.com>
> 
> This breaks the build.  Use min_t(uint, wps_ielen, MAX_WPS_IE_LEN);
> 
> regards,
> dan carpenter

Oh! Thanks for the feedback, that makes sense! When you say 'breaks the
build,' do you mean it didn't compile, or the module didn't load (or
something else)? I'm trying to figure out what I did wrong when testing
it.

Best,
Emily
