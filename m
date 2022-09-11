Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68225B4FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIKQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIKQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814CF13CDA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r17so14955213ejy.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/TGKUFp4Rbs92WA6usXfMvWSPRyltn47twUf2C6Q1X8=;
        b=dFVmMNfXALglYwsdXIPXJ68QMJ+5jyaUzrAQjh/6vqEMm4zRioMty4Lo1Ognup+iN6
         Zr4XDH9A94lnq2XU1fPZ0NWHA8yx7ZBE2VsiGjoy5A2XYdSArtc7zdYg4LOofggNGKg2
         VwYNaXYZZD1xhZUd80lmS5rJWB4USHD47COJ6mm0pVNgaUDTy1GoL/iW92S36Ul9fMjM
         dsh7DlfPwnBexHuNnb7gmLGUuEEx8HvWk1sPOwE7x7/5BJ3HRmw8V8CHD73AuEk9Ga23
         Jwi+zgTbsYpTzm/mwibI1j4+dKm3b/cHoR33ErGubybdxZcrCrb6FamGjHvldTEGJNYv
         wB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/TGKUFp4Rbs92WA6usXfMvWSPRyltn47twUf2C6Q1X8=;
        b=II9KY5PAjV6WwuE1zSUtOkKpFpnEyvlxrajqkPG4wXUfrKr2PFXedYZ13GhzvRSxmY
         tPbbNqnElYwdhQSo9OrZPG6WQycHzqyN9ozwwhYt/j0W5cwwhn8FGV7CI1chfj2g/KBJ
         toQ6+2CeQg8FirrVMrxwVn5I3s9ERjHWI/d3Hdcbka6D+t/SSLzYAcmf3AsncJuGP6Ej
         CuOYTllJiGCuM1ZxYLwD1e9aHfNTJiXIYuYgYN+raDQtmrHpPGvvxIxy/hFThoi2VLsT
         K/zRzveeA5QbsoNCmWyrq+SDttFmyMPLL/N9E06vENOIpocNmZMXOX9egbCGkzNC+fou
         vYnQ==
X-Gm-Message-State: ACgBeo0H5wSrpDNpuUbbgz560uKXma9zUTsU9Ywti49erNT45v0UUbGd
        lSO+g5S4vnZ/S3qQNIlR6k4=
X-Google-Smtp-Source: AA6agR47JfPP+uvrRjdrr/oVnIhSpbAwANtcJA58FfLAKIwHgzOZMKtxFA+ojR5DelxbWeaQSW7cug==
X-Received: by 2002:a17:907:782:b0:740:7120:c6e7 with SMTP id xd2-20020a170907078200b007407120c6e7mr15968189ejb.313.1662913200091;
        Sun, 11 Sep 2022 09:20:00 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:19:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: some coding style cleanups
Date:   Sun, 11 Sep 2022 18:19:43 +0200
Message-Id: <20220911161949.11293-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some coding style cleanups in the file
odm_HWConfig.c.

Michael Straube (6):
  staging: r8188eu: rename odm_SignalScaleMapping()
  staging: r8188eu: clean up camel case in odm_signal_scale_mapping()
  staging: r8188eu: remove unnecessary initialization
  staging: r8188eu: rename odm_QueryRxPwrPercentage()
  staging: r8188eu: clean up camel case in odm_query_rxpwrpercentage()
  staging: r8188eu: replace tabs with space in
    odm_query_rxpwrpercentage()

 drivers/staging/r8188eu/hal/odm_HWConfig.c | 60 +++++++++++-----------
 1 file changed, 30 insertions(+), 30 deletions(-)

-- 
2.37.3

