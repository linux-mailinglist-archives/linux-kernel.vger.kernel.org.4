Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB38872936D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjFIIkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbjFIIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:40:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA6B9;
        Fri,  9 Jun 2023 01:39:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso1877390e87.2;
        Fri, 09 Jun 2023 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686299991; x=1688891991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7KaDvTnSiAOhtxrXI9e8hMyb073N1sL1o/KOoe1nTE=;
        b=SfbPH9cruR9dotCW+msb0IPgb0ZkIkiwSYD6FkssF3SKcA03WufipUvsO93SujLTgR
         VDYAIbYSy2N6zKdy8zBPoEeoowKMrvZZ1j2qiib8zRWJk3Yy068xuaSuC5/NAbqFT4ny
         DMCqiL4bAE1TyK0qUGJb2BhDsBbUEupZ4JjQwZMA17pObSI9FllmDfhtFGZB31RVw/KQ
         Nt6o3FBL27+SHSggzJTkDuvRCFJnJgzQUCz8zohGAK9c0A3yn1i2ZKQNeIUKHt4ShLli
         eqomdVDcOi1p1Nj+BsdoRjzwFbgbkuj8jZIE7+Xz1tqICwMVx0Tj3iQtxn7e7BalX2YH
         oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299991; x=1688891991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7KaDvTnSiAOhtxrXI9e8hMyb073N1sL1o/KOoe1nTE=;
        b=jByHbs+1O4mFTMlf5qLRbu6+DfhSsNu6z/OSID0meSKj3Kh8SFDjkNKNth6f1qTL82
         54rzaRB22E6P9drPUERkU3HYDPGLo3cJIhF/auyynNXdbNLrZV8/nvYyKXTnD2W6Fc1u
         CWIMCQ2ERiLhvLQJONRQjiENWUiARhZGKd81vY7Bg2gwV/j1pk7osYWXdfjGhgTZOSH/
         5dadOmdRje8RT9g62VuMORNW34bbLINtXXz0seyEq0Efyyq2Fks7FUzah7r0dqY3R4uY
         fFBjPzUKxGPUvyLu4twtU6e5qaF5iiuigSSiAAapo3IBvJ9Aby9J6PwgDnBwRTETunHr
         Cs3g==
X-Gm-Message-State: AC+VfDxquSo/ijOTxQymhhB1bdTyisOAIfzTRXhuk16j2utYOFrdy4vZ
        K2ABCNGUQSRXP1vDlju41Pg=
X-Google-Smtp-Source: ACHHUZ5b2lXvg8Y2AGqYGWqPf+6jSt6zYXUwI8SAye1fksrRg33WvFhKbs2Bqa0QwlMR1jDaSfubYA==
X-Received: by 2002:ac2:505a:0:b0:4f4:db63:239f with SMTP id a26-20020ac2505a000000b004f4db63239fmr522757lfm.24.1686299991486;
        Fri, 09 Jun 2023 01:39:51 -0700 (PDT)
Received: from localhost.localdomain (bba-2-50-150-163.alshamil.net.ae. [2.50.150.163])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm3810587wrr.18.2023.06.09.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:39:50 -0700 (PDT)
From:   Yongsheng Yang <iyysheng@gmail.com>
To:     corbet@lwn.net
Cc:     iyysheng@gmai.com, iyysheng@gmail.com, jdelvare@suse.com,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH] Documentation/hwmon: Fix description of devm_hwmon_device_unregister
Date:   Fri,  9 Jun 2023 12:39:35 +0400
Message-ID: <20230609083935.1340-1-iyysheng@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <871qilqglv.fsf@meer.lwn.net>
References: <871qilqglv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> YYang <iyysheng@gmail.com> writes:
> 
> > From: YYang <iyysheng@gmai.com>
> >
> > Use devm_hwmon_device_register_with_info to replace
> > hwmon_device_register_with_info in description of
> > devm_hwmon_device_unregister.
> >
> > Signed-off-by: YYang <iyysheng@gmai.com>
> > ---
> >  Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> > index c2d1e0299d8d..6cacf7daf25c 100644
> > --- a/Documentation/hwmon/hwmon-kernel-api.rst
> > +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> > @@ -66,7 +66,7 @@ hwmon_device_register_with_info.
> >  
> >  devm_hwmon_device_unregister does not normally have to be called. It is only
> >  needed for error handling, and only needed if the driver probe fails after
> > -the call to hwmon_device_register_with_info and if the automatic (device
> > +the call to devm_hwmon_device_register_with_info and if the automatic (device
> >  managed) removal would be too late.
> 
> If, while you're at it, you add the trailing parentheses() to the
> function name, then the docs build will automatically make a cross-link
> to the documentation.
> 
> Thanks,
> 
> jon

Sure, I have modfied the commit message and post the updated version. Thanks
for your advice.

Thanks

Yongsheng
