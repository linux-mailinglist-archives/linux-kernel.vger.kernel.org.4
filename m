Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FA6640BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiLBRIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLBRId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:08:33 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CEC8D2A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:08:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fc4so6036426ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=8e6/xEdGfO2q8PFDjOCWiWUmQhOjfRbND0AvATMyTXk=;
        b=N/vF1ukPZIOeU+nn/grMVfizomwwC+fkYuIUsLLhdbDHhEaWqW378EIfTq0+FPWNeH
         O3R8JqR+26HP5xyOkIsXOdVPmbdA21xFJQ2MXdHw65ihPH8ZXdB+DAcxT18Mo2cqB8PK
         cgJBc6sjJQk1YQrQKDmwF3z9wlCJSa04bwLY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8e6/xEdGfO2q8PFDjOCWiWUmQhOjfRbND0AvATMyTXk=;
        b=zcpfQ818Nun7S5iPf0nQSgDoiKpSkSiQzhm6cn3aZiQhKdQndR9dFnWy1411iEfQi6
         fvvonETBiLgy2quKy0hwl8y9x8OW+C39AprBzilrAUDf/TaJoOyDIdLDHWfDzuxPBz14
         COPcVpEIEwJ5gboJyxoWVLbNUhhON4jp76ynrUHHc4Yg4ypBQQCCGp1gBIKnOAktcScS
         XJopZh25ZMyiObIYmknqEymPdV3YH8lBPTCnhd6/jz4MrnO45WVF4zkFkK4nt8Egowd/
         mBn1wSQ47IFhgMjg1m+oO+0rfS/k4yutQacEE87sjGRU1dhOU5/lnmQi3vhuqeDm85Cp
         PYvw==
X-Gm-Message-State: ANoB5pnjRP2IZ0Jwcj0WTdsNXcllrpPHA2i3RLWfP2z9M0gj1zA8IPbe
        axnNIajSpg8gI4iucKG9km0J9Q==
X-Google-Smtp-Source: AA0mqf4Ipyre/1uHT4giSVABOVaYnQh3XWF9QR5AhAZQ8wgv36NZJ1zZtLaCA0FK1qma2Jyxo0RiYQ==
X-Received: by 2002:a17:906:a0d9:b0:78d:b912:6a6c with SMTP id bh25-20020a170906a0d900b0078db9126a6cmr62026281ejb.124.1670000908639;
        Fri, 02 Dec 2022 09:08:28 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7d317000000b00461cdda400esm3168080edq.4.2022.12.02.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:08:28 -0800 (PST)
Subject: [PATCH v4 0/3] Add Meta: to Metadata devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAximMC/22NwQqDMBBEf0X23C1r1EN76n+UHmJcTUAT2GigSP
 692557GubBvDkhswTOcG9OEC4hhxS19JcGnLdxYQyTdjBkDN0MoXDmOOHGu8W+G1xHX94NoIvRZs
 ZRbHReN/FYV4U+5D3J+/dQWo3nf1lpkXCa3Txa9RnqH85L2sKxXZMs8Kq1fgBwy4oargAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:08:16 +0100
Message-Id: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=LW+YCLH6/51gvCjG3C+b0rUFF/hKAINhoJrPn2BRST8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijEEfGkkfeYEtkDGFVlGPk2dZS0LOIYaDm1KKYSB
 zfA8WuSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4oxBAAKCRDRN9E+zzrEiB+cEA
 CVIAwH1oJV8K/bHdwKL/obk2QagHri47Aq0xk/MYxwpYsY4nJryLoFRLB2m6voNiNfry8kaAGWFVTP
 srpMEy4FOJVS6Mz+MdjTNim/g/AWcYnniSfm3exWztdOkkglfAEAh9uZ0cdNOHPQ/27kNgDrF3DSuB
 o6p7o3BVjOtuW2jTdAdD6R+2UK2alVlTu3JSK3WcbKgb323N4QfP6vLZw2eCbYcrruyTrJ8izWRo15
 r6HTkWfsuqbCwACePalicT7h/uyD8Fyl9mC4HK6Aut8RJno2dMaiSB9UKY+XnxE/PBhYoGX/Jz2n7r
 y6AylHE/AGNuX+DWvn8i/FcjsyXny3kuYg9KjVXXyec7CuJ9thl5gcJCHLbyDjp4X190YmVlbyFg+C
 +KFrtyTtU/XI74kCrnb+2GL6pp5I1oXJOftfqLApj96vaIWNhblUpbRYtAEk8BUM3ZG1ou3YR6D+gr
 YY96jKHTJeiVnnkoQq0NS9AdSpqkLUE8ThHPOc3Pr3zktPEFKqpxSoj0oKTH5HZ+GzVv0ZcC1CSl4A
 CfyMu4IzWpF74svrWtiKysQPqhUl+9N4e6ASlZfrxzaldWxoA76iw7ypTYU7uiVgQUEEOPcc3mXl4y
 ecQJe0Zhm/eaG0dcEYJvR8r4vYXAoPDb3pZFnAFlNQLE8wBzEQem/lE4ldEA==
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

Metadata devices usually companion "real" devices. In order to
distinguish them properly, add the Meta: prefix to their names.

Also, add a unique suffix to all the uvc devices, to multisensor cameras
do not show the same names for all their devices (IR, RBG....).

v4:
- Rebase to latest master

v3:

- Add the meta logic to the core

v2: uvc: Restore old vdev name

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Yunke Cao <yunkec@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v4:
- Link to v3: https://lore.kernel.org/r/20220920-resend-meta-v1-0-dfcfba923204@chromium.org

---
Ricardo Ribalda (3):
      media: v4l2-dev.c: Add Meta: to the name of metadata devices
      media: Documentation/driver-api: Document device name
      media: uvcvideo: Add a unique suffix to camera names

 Documentation/driver-api/media/v4l2-dev.rst | 4 +++-
 drivers/media/usb/uvc/uvc_driver.c          | 3 ++-
 drivers/media/v4l2-core/v4l2-dev.c          | 9 +++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)
---
base-commit: a4412fdd49dc011bcc2c0d81ac4cab7457092650
change-id: 20220920-resend-meta-435c30209235

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
