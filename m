Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DA9640C00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiLBRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiLBRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:52 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A17F8AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vp12so13064320ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=EUT7U16Zxb0ZExEemxBABTNFCTWV0UDUspkxIn18yIE=;
        b=drXtVNEuJUKG6Rn5oWMJuVDBprzGYqkBiuKjcVAm2S+z+3a1A8PDVzUb7u9IUomrkA
         uMohpS+QUKm+GEGFYQO1fs+xVU6eAHPiKY4Rb8QtgXDAT7IjeCwbzkJHjSsUgOcTBfS8
         etO1jwi7BUJPLc3t6BJ5CFGNiYlgz2nFBbiTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUT7U16Zxb0ZExEemxBABTNFCTWV0UDUspkxIn18yIE=;
        b=Ihc/ByE/hJ/OJQckB+U3YrIqahTuZ0+g8rqOuOg4QTOmLtcX+lKxp5tpxxthWzq4sG
         WFRPG+7FT36p9OgdDCFk6IURRzSIbQ6ufML5sisOj2P5gKqFlW4oXI8U777zW1vZMN3G
         jW+F0c/W1gAZ7AaQXwn9+DTI11uc7QfrdGt8sz1FednmhvHuZNlypZSMiwMwFQWrzyag
         TYNKvm2lW8nHswYE65CzmhzQo+3GDwNt19g92O0x+RPLUzAI6jS8HgVsFM4/6BHaMhhz
         LLnJ3TcjpguBEfqLFpsbQUiBDa5YXfTTz4YeBauTJNOaeeEPkS3tAIoJMiLhOxeT4UpE
         +bNg==
X-Gm-Message-State: ANoB5pm2QOxkL/TLiFFF2COOMlKSt7s20PgddIT4lnIaCL0Ct6G65UMD
        Cb8M2oaz2fGdwiM7a/81wz64Zg==
X-Google-Smtp-Source: AA0mqf43LZH6x9Uwy/BiANEImPAtt8onJ4hqMs+FPq0Ulm14XIOQlqhArcM9ArnSK7CM1fTGhQhCpw==
X-Received: by 2002:a17:907:6daa:b0:7ba:e537:c64b with SMTP id sb42-20020a1709076daa00b007bae537c64bmr39049220ejc.180.1670001710227;
        Fri, 02 Dec 2022 09:21:50 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:49 -0800 (PST)
Subject: [PATCH RESEND v2 0/7] Follow-up patches for uvc v4l2-compliance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:34 +0100
Message-Id: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=MMjSLZT6eS0B8Bc0AeIXpf2+IIYhod4p4XLb8hr5I+8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQg/4yEs2VVNFqf9D/S4kUVxjIXJYSDnctHJ1w8
 Pr4dGYqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0IAAKCRDRN9E+zzrEiIauD/
 4sSaJRRGaWTln8hC5xBxXsCGPWImJnu24llAedLRT9eLX/wWJ0A6HYWAtYiUUEuMCpWosiQEMCbfCX
 OXu0sJt/mQsK2WFxIWMUvcivXZmM+R8sMITZPRFRj3drutsHeY5xWwSNkWq+B0cPcRR4QCXsja7yu7
 zCmlmzMu+Gfu7zOYa8OLfrKaX9ROwy0MDXoFj8JTUP+3/DEXLwaWii1FZVqRxBAVoB3QKFI+DuNthu
 4TKmnPin6pz91jOzyw4m6LjsOE6F5+FGW3qAtDt3OIC+0NY45lmcyMfpVx6AC/hmEmtFuPfJ546yQt
 T9szSlurIGdU4v39YL1TOCuLqnzDHeU5Zw0N/wH7XE+S19ldaMik84SR3euTZTh7H05eAnvtvyZp+y
 EtgADKZX1Fa8JVMvvT3jHc1kR9I1aNv4kvmUJ59e+RpsQPQtCsZiinG7zbRSu3iRCbSAbmixM4i5no
 wRrnZdY61CBaZgSQIHZRc648CDA85uKNII6uGufn0FsLfOiqas/HkSZZa/EAJKNRea/9sFJSZiwdiK
 5i0/82DX48TspJ6FdpWMp4JW8fMX1CGXxVFt6ljh/iwaEAWDbtJ6unQL67ELTpWbtv4gcMG3Vei2bD
 vQqu6nNQUQtgUXzeb+i40K3YwPQwUwVaTF5dSp33vUZ1G7JDQnN2Y4ipguvA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains the fixes for the comments on "v10 of Fix
v4l2-compliance errors series". In particular to the patches

-uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
-uvcvideo: improve error handling in uvc_query_ctrl()

And the patch:
-uvcvideo: Fix handling on Bitmask controls

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Include "Get menu names from framework series"
  https://lore.kernel.org/r/20220920-standard-menues-v2-0-a35af3243c2f@chromium.org
- Link to v1: https://lore.kernel.org/r/20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org

---
Hans Verkuil (2):
      media: uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
      media: uvcvideo: improve error logging in uvc_query_ctrl()

Ricardo Ribalda (5):
      media: uvcvideo: Return -EACCES for Wrong state error
      media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
      media: uvcvideo: Fix handling on Bitmask controls
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Use standard names for menus

 drivers/media/usb/uvc/uvc_ctrl.c   | 230 ++++++++++++++++++++++++++++---------
 drivers/media/usb/uvc/uvc_driver.c |   9 +-
 drivers/media/usb/uvc/uvc_v4l2.c   |  85 ++++++++++----
 drivers/media/usb/uvc/uvc_video.c  |  15 +--
 drivers/media/usb/uvc/uvcvideo.h   |   8 +-
 include/uapi/linux/uvcvideo.h      |   3 +-
 6 files changed, 258 insertions(+), 92 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
