Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B95E9115
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 07:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIYFGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 01:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYFGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 01:06:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940AE3D599
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 22:06:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w10so3527390pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 22:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=+hF2iRaC8IwIsQwNG2CBaYdzZGOTAXTx4/lHRlsiuzc=;
        b=jv4KKGWkKkIq512ndX4nKTtjG4XrjJbLxVL06117qJ+I0Xm9IvyOF33yFL2yCMkT5w
         Fxr73rJYZ0yGupKFvbOCuSWXRglw34svpFSj2ZR+NTD98r9R2nKyZ7OV/byUgNDMPuWA
         n12xWQ/oGyITJ7XxydUu7bqbaRuSJTcP1zo0ZtIYbEELTEu8an9bP9pk5l0ruU5P7m/j
         q+kH5idzaF/sDR8LlHZEaWwn2WXjs8ccZNKNxEQhq2+zYivfMcj3Hej1tX51/en6ACMc
         xgNG28EX/v7hw1mWSB2esMYmJU9Z0pbSh2/+3Bi91HKJblrgtCYqGKXXwQDHxy2d4+9t
         A6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+hF2iRaC8IwIsQwNG2CBaYdzZGOTAXTx4/lHRlsiuzc=;
        b=MR+bD0f6VvDx2YR9cUTnJ2SNlIq0le4WmXCIojkVwifymnQ1Z6V+DG/tyD2HTaM1rn
         6pZTe8qOGSNRuyJISWeS3O1qC7fzRlDR1atx+mCW8n415sVIQRskGCwTsWwI9mJDYXOU
         XDsYhSjxmrvbq16J/ndSto4FufkpMY0ULOFsFEJK3l3qV1olfZ8K+v+d4XtBjkcW0lUd
         ePb/FEXU19vjNlQ/v3p1Odc588RYUfduULJrxhWho/PY0Gm2H9YKdp7jRSSphnx37qGU
         7R0Bizya2ULpYt3rutTvDEU7hVhWB9TYB03cTlD55JgcR9SGpHQtDmU/4jTLLvWB9bvd
         Obkg==
X-Gm-Message-State: ACrzQf1to9vnrjKy5L8fHKs7+yXhlrEMo+cPxBtJutXa+OtWxtLTbrtK
        Xmz46CN2oEYucSkJEwcchVw=
X-Google-Smtp-Source: AMsMyM66KSNWmGU9MaV1h6icVVQeJXcHFgyUNZUjSSQXwQRU5yNzpVeQLbsx3vXKtyM388kCZLUbsg==
X-Received: by 2002:a17:903:2443:b0:178:221d:c599 with SMTP id l3-20020a170903244300b00178221dc599mr16471698pls.100.1664082370927;
        Sat, 24 Sep 2022 22:06:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:37c:3916:9a45:14cc])
        by smtp.gmail.com with ESMTPSA id 7-20020a621507000000b0053e80515df8sm9167942pfv.202.2022.09.24.22.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 22:06:10 -0700 (PDT)
Date:   Sat, 24 Sep 2022 22:06:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Is PPC 44x PIKA Warp board still relevant?
Message-ID: <Yy/hv2fOLzdWOuvT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Nick,

I was wondering if PIKA Warp board still relevant. The reason for my
question is that I am interested in dropping legacy gpio APIs,
especially OF-specific ones, in favor of newer gpiod APIs, and
arch/powerpc/platforms/44x/warp.c is one of few users of it.

The code in question is supposed to turn off green led and flash red led
in case of overheating, and is doing so by directly accessing GPIOs
owned by led-gpio driver without requesting/allocating them. This is not
really supported with gpiod API, and is not a good practice in general.
Before I spend much time trying to implement a replacement without
access to the hardware, I wonder if this board is in use at all, and if
it is how important is the feature of flashing red led on critical
temperature shutdown?

Thanks.

-- 
Dmitry
