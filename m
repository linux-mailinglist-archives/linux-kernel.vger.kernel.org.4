Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBCC5BE827
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiITOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiITOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:09:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992D5FAFC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y17so6472167ejo.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=DL+DMnb7d7T4v2mYEqU9/NWNU/Gc7dq0fF20fEmVfnU=;
        b=EB1eInntsJw+0hxN3J732M+4yPQZi5jdBTxHCfQXBOAFUhSm3IaaMHzuZ7Q/bWuEPy
         0xUw03/1OsZj32c4pyrphOlm3gp/8Sacn4aiSwLI3RlnF+Ur3h3e8TFDetee4zcVrFai
         jr8yrS9MCXQtbTep/Rm140rfl8ldDypm/DHTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=DL+DMnb7d7T4v2mYEqU9/NWNU/Gc7dq0fF20fEmVfnU=;
        b=BWgH6gVzMb6L6R5S6Zcz0DGsu8mw+jRffUVL8ZSJ+kmoDTpL3H9j40eomn0D9PunHz
         Km0ji7CqdMtOSm4Y6JroGHiSB8EVPJJusnnpxJ/TICtsPXlUa04uKxHdj8R3N3eR4ckW
         NbwQktfmNlNwZt75OQI9JupcHP9vi+rDsr1xElzW04fEy7JLSIRlopHnmnqs88su7vOW
         +Ifm1VgIEXegp+zrp84EYnE3eXQCOO1I13tJS+8A0j6g4WTvhvJGOAoPlPOulIUQ2bG3
         DSgHLLtvNvhBy3OblZqqb0rWr/kdXmeMshYIOFqttu9SezFejlIrrYNkz/ds3RSlkDUW
         FTOg==
X-Gm-Message-State: ACrzQf0WzlsQmFs2PWwDSvCDswZQYZSDWLl1tQDtuR1NYbM1eV+o4N6E
        7WzWi2mCTGACGpvCZ53NhzGFyw==
X-Google-Smtp-Source: AMsMyM53Q/Gb87mon15hblhJwE5Srq8XS/IfiSKe8A3//xvDFz1Htqn4ii01mk/jOGgxrSrMCwTyAQ==
X-Received: by 2002:a17:907:2d8a:b0:781:cef1:2ceb with SMTP id gt10-20020a1709072d8a00b00781cef12cebmr2040730ejc.470.1663682954206;
        Tue, 20 Sep 2022 07:09:14 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0077f324979absm927133ejf.67.2022.09.20.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:09:13 -0700 (PDT)
Subject: [PATCH v1 0/3] [RESEND] Add Meta: to Metadata devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAH7JKWMC/xXLTQqAIBBA4avIrBswzUXdxp8hBZvAqTbS3bPl9+B1EGqFBDbVodFTpJw8ME8KYv
 a8E5Y0DEYbo1ejsZEQJzzo8rhYF63+u3UwjuCFMDTPMY+H71rf9wPCQOAuYgAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:02 +0200
Message-Id: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=jUROzOVne+8M9v4jhjdjpgM+d3+EtG5f+sbzCqW7Gec=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcmBLUM3d6IjqArbX4n592lFFAdujEYNOuA7qOI3
 KuTBdAeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJgQAKCRDRN9E+zzrEiLFJD/
 9MiXV2ymNrm4XkHYHmCWoB42jnjrbHLIMdQe9DrOUueM4l+sSl9gQaHIDLm/Bk3/Q4kJkyRTKaQQkL
 FrDM7ZoHuLfB58ZLUnxZ/cy3T0y1AA3ZbRbLdbZEerK7Om2hsmAiv2owNXUjhnLu5G85gSGcvhQR+e
 PupOmQ5UZOT0lGid3t3nuFAivKcEuRef2X01SZRzJmRhLROq+HKr131ybbZ0QN1siLn6OKIizhK8nq
 7wIVJVKTMJwxGtWxgtvviIOjx5SLGf0sf/K18lqCrS8BTLdZy3Vh3+ds4q7oj6N9bOmwN8oEKCkkwv
 9FhyUj0lRm9Z2u+Pmt0QhI3ubpUjf3IAcjlOmpu8Pa7P2xRD6W4PekFA67EVsXt+Z0hfsTXaiZjUZC
 6GBwX8f8BVd2+fKQxtwZY6WvFgWKeS9rMr3KTTTxT7r4NIGK1WX+rPn1NbCRSmmYxO0jgN9/ZYJikQ
 GirftvAprDMxxJgsGM8yL38Xm/hhp99qBgMeck8SMNdUXbcX1GkmkbfZbfNAvSb/2ykCn4jSGiOdcV
 1ZF/1k1bO2qoCcDLck7FhPpWTmGUmGEOWjZtDAC93iGERP/sT+/t+X1afi4CswdGcJjFJw3X6vijQi
 CUlLBLLhfRTwHF3FAg6Zcxlv5iM6u7M64eh796+odqYcQcgQ4UmCw9cJ8tsw==
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

v3:

- Add the meta logic to the core

v2: uvc: Restore old vdev name

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-meta-435c30209235

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
