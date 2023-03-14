Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6A6B9EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCNSpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:45:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21CDA7692
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f16so16993789ljq.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819483;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=casSMFcL0bdZR+xSUTOixiwe/HQpvarVg0OsB5EQ+uk=;
        b=VRpHVUdw+PX4ki5MVpyNIHdTyQpnV3Ir5ZB50XU6IH/DDNGW7NxjO35C+DzY1gk3N0
         jLZq9ThnO3zmbJLXfx2vZMd8AkJkXkpT/4i11CfrAZ35z2dL0PEqAgIwi2dTaP3sqvJ4
         J1xHqHAeny4frccIkAdv1klekcIsNK7/KYaQ2jwDC1YeAAsxGBX5ifW3oJDC9rPI1d7c
         tiLw3qXcYfYsKHtAH3ZQCDY2ECrhohAiCwUxF9oQPkSSBUp+fw+Z697LudO6uFmT8Wug
         XBH34yp7U7AuGcrn7li1Foy60UyQOQI30GSkp1VJ7mpQrFC7L0WY/7tNqe1PsEWDMP+g
         BgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819483;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=casSMFcL0bdZR+xSUTOixiwe/HQpvarVg0OsB5EQ+uk=;
        b=CXJwxD40bHOCqa+x0YLhNZDgCrMhZU3nTnKCeBUUhGEW05c5cM2K6cYL5lONUaoFkH
         ynut/dP1HkVLq/xPviW4fkUg7dFLG0g1cq1UboFEv7dl5ebYhuDHzBNDhsxRE6ZBG+0A
         4xkTQ+MAF1/K3szY0H5WIjYNbde1q+01rQXHrU41/NqVyzHmMHvvWRgrmgEcDBdQ/oxd
         D7DfIzZVR1f+UQH60QZM7eRWYOTloKRwHQ+aPJRohQ0mZe2SfL+AqjbwYuCOXFmea1fC
         saZfr6+JXY88sm7tmHiEq492Nt7eFmBm16yASO89PlaDs+Ohjl0U0ur4oHIofyd8959k
         Sw7A==
X-Gm-Message-State: AO0yUKUNhL7vwgHo56HoXVJspAh1BoA0AXx0y1iNAZVYXJSzn5z0/KHe
        9Ki/MPo51D752sDzDikWTZc+JAbfZw3UzBJ875Z73w==
X-Google-Smtp-Source: AK7set8fdhwduFhySycSkVXxE4FxmLfgk8tR4QH2xestJ2syywoI84QbAvcsPzKtOicz8X3tBczWpA==
X-Received: by 2002:a05:651c:b26:b0:295:a3a1:4ab2 with SMTP id b38-20020a05651c0b2600b00295a3a14ab2mr31741ljr.15.1678819482794;
        Tue, 14 Mar 2023 11:44:42 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id f7-20020a2eb5a7000000b00295b80aa93csm551046ljn.110.2023.03.14.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:44:42 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:44:41 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix spell error in OP-TEE driver for v6.3
Message-ID: <20230314184441.GA2936721@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch fixing a spell error in an error message in
the OP-TEE driver.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-fix-for-v6.3

for you to fetch changes up to 172fa6366c0c84eda31f1bc34e6c3e4698786215:

  tee: optee: Fix typo Unuspported -> Unsupported (2023-03-14 11:57:03 +0100)

----------------------------------------------------------------
Fixes a spell error in an error message in the OP-TEE driver

----------------------------------------------------------------
Jules Maselbas (1):
      tee: optee: Fix typo Unuspported -> Unsupported

 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
