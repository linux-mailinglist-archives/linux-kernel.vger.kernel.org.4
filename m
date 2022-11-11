Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F4625573
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiKKIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiKKIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:37:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C0363142
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so10994356ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QRcKVfIS8NDafd59OlyUFdzDuB31g5yY5UyB64GKppc=;
        b=SyvdF3FbMU8xxvtzWNKLFujAL/SkyCinpdysIw+4QBwISd7ANJfgSeWN+jfDXJXkdu
         5APNx5TeLxTQ6PyGMl2MxqO0y3MVka/YypI1qgGto/Ciday9F57hFisf0cWQdjxRYcXh
         FMO8YgnvK99GoYJy3ZcyhTBWR7c0aJx4Me/S4sptvnaSjKSKJW4vFLXNaN61CT24mKZb
         Vl42J9QpTGalvPOiY8Udw+dkc5n5k8/0fEpf9lC5zdQciS3XqOLcbsU0yv/UJTQDaXft
         9+kXPwwkDWlyLBp7i+NI+VWLEiaMLMpROkV6vygm3e6cyQ6Uc/0jLGtTkWiMEdA2/BxV
         6eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRcKVfIS8NDafd59OlyUFdzDuB31g5yY5UyB64GKppc=;
        b=hEvzmgnDHWxJbCCKRv85d0RQife8bu4+eoDMJp+4xsODBkAbZMJRmAlO3ZM9nqpJW8
         jjS3P2d121+FJVp0ISpRCYGCz3/sMtpvneRkcEPERdOvXWIlBdvRxDasf30lFulXojVJ
         lZ6GOX/UX6y7UM1BTPMjPXPAya2RMicXnY0BphVaQNTl5TBo8ragFeDaseyWj78laXMT
         mVpaDRO5VRu9J8jN9QtkLkUbMwt+45tqsM7xWQlMNdIF/jkhC74wnSQ5MFRqGVt/0lFL
         /OrWfXzd2jarXwjtJ4Znu6PaQa5OEWOuCF5SI0QBjsSDWM+EIDD83yEVQC5MYNr+Qkak
         22rw==
X-Gm-Message-State: ANoB5plgd4u8eR9vXx8RddSaPkSKvjr3NQGEd2BZcwXn/0Qbd5ntE/95
        0E1j8Y9+hMcELfUNj/afQs8=
X-Google-Smtp-Source: AA0mqf5EOz8LdwplhrJ1YQ0zy9XkFlFd9VEaRauyBvfRrYu9Hn+N7W6MWtKOYca0QissDU/Oq/WnMQ==
X-Received: by 2002:a17:907:2348:b0:78d:f796:c00d with SMTP id we8-20020a170907234800b0078df796c00dmr1042024ejb.251.1668155861940;
        Fri, 11 Nov 2022 00:37:41 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007ae566edb8bsm643190ejh.73.2022.11.11.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:37:41 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: some _FAIL, _SUCCESS removals
Date:   Fri, 11 Nov 2022 09:37:29 +0100
Message-Id: <20221111083733.3144-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some more uses of _FAIL and _SUCCESS.
Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: convert aes_cipher() to void
  staging: r8188eu: convert rtw_xmit_resource_alloc() to common error
    logic
  staging: r8188eu: convert _rtw_init_xmit_priv() to common error logic
  staging: r8188eu: binstallGrpkey is set to _FAIL

 drivers/staging/r8188eu/core/rtw_security.c |  4 +--
 drivers/staging/r8188eu/core/rtw_xmit.c     | 37 +++++++--------------
 drivers/staging/r8188eu/include/rtw_xmit.h  |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c   |  4 +--
 4 files changed, 16 insertions(+), 31 deletions(-)

-- 
2.38.1

