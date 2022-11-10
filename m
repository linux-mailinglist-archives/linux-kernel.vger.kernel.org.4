Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3F624387
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKJNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiKJNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:48:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C16B236
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:47:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so4080298wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYeie/ZZSPiqzVcmz3SigR7Giv2tjj7giPYVI0G/E7k=;
        b=ijXWAxem5lTKOYMl4Uihwu7Ix7IWDEene5SYiyg6yPx1m5qOEjycw2TplST+FxOVoa
         0qLOgswgxdTHYoz8hzDAwwCrg2T0NA8TFO1mbnKIks0areBtVKTQ4ZbCL879SX7uPBMt
         2ugCYEHFMlVfGQzlXQrRx/FuIBEE0uXjfST+CAksmVoqeKK0+yEKRaQwl+QKTpZG4821
         HQGlY8xAoApEAcaVo2LX72xPeI+Ew1pyB+UE/+CDGCBVehy9MRblM20LLxNpjoHl/SIL
         UhLN7l/82+5QjXxL5ZkO7OqGe4ra4SjbW7vA0TNDe6GonjHDTWOF8xlxw7SnpqAx5gyy
         mCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYeie/ZZSPiqzVcmz3SigR7Giv2tjj7giPYVI0G/E7k=;
        b=VgecDNDL1lfTjndyLYdS8PM7TvOLW4ydOUaOOp4tW0QD7ZkX/D5owWmL8USfDho2Oj
         9MYUwiVCMy+1do5r0VBy/a/Vi4h1ApmKWyf/eg5VmT7Ko72e9hkVAcRPhwGWyc01lNA/
         Jjkl2lHPTz4d201cFoWUDh7L6EdcAg2DDLEmDlccqn0xnf5phjRHTTPiPeiIP4ek1IID
         Kzq/Z/juR7QYS8/VgocfDAvASeDCKoqiEapnWo92DRdI17VHqYAqgf2afBL8vBcXWgxW
         cdfLP64/WaHn7JfaR0NF6o6MR/5CWppfsyfQKmbwIcnPTvvPbxR5cgx1Dl8Mraao7OCK
         gTaA==
X-Gm-Message-State: ACrzQf025EZwqL7tLaJnnsTmWpgqtRZ25aVeyY8H8gsPOZ3yFm8BosoG
        KVu+RH+XKgvPd5tFoQsedHhtWz5eI8M=
X-Google-Smtp-Source: AMsMyM5wZZolV5Ko0Lr4iFvKUS2cxb3BGICIu49AM+D2kZAEymvE0C9TZtyWklq/EpOgs/qY6rY6/w==
X-Received: by 2002:a05:600c:414b:b0:3cf:94a5:6564 with SMTP id h11-20020a05600c414b00b003cf94a56564mr23266536wmm.65.1668088077197;
        Thu, 10 Nov 2022 05:47:57 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0022ae0965a8asm15717060wrq.24.2022.11.10.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:47:56 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mripard@kernel.org
Cc:     emma@anholt.net, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/2] drm/vc4: hdmi: Fix pointer dereference before check
Date:   Thu, 10 Nov 2022 14:47:50 +0100
Message-Id: <20221110134752.238820-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:

As suggested by Maxime, I simplified a bit vc4_hdmi_supports_scrambling()
making it receive a struct vc4_hdmi as argument instead of a struct
drm_encoder.

Also, variables are initialized close to where they are used in the
second patch.

José Expósito (2):
  drm/vc4: hdmi: Pass vc4_hdmi to vc4_hdmi_supports_scrambling()
  drm/vc4: hdmi: Fix pointer dereference before check

 drivers/gpu/drm/vc4/vc4_hdmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1

