Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5EF5BE82A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiITOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiITOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:09:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9436050E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id go34so6505301ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=2PCHXmpS3a4cpm6Nvunds7hNUWRumI4ZR//08i+61VY=;
        b=D2wAPJISTcLpYO4j2hX8z2YoGvo4E0F/zz8vRLrSJoy4irorQeC/xtj4aqJVfZToxH
         u6iuorVsRURTRKKXDP7+mG0egL1MKc2yY0Rc8IKbHNZShB1qfaYEbU7CX7Sdt9AjcXhh
         vo5qkcqJLiZcZ3mdVDV//q3ouHqQmyi/HnQ78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2PCHXmpS3a4cpm6Nvunds7hNUWRumI4ZR//08i+61VY=;
        b=gyPgcYS5w25HJHeK1pAf6aWj/3OgnuYOfYtV4VKqCQSVy3bts6YGg/vcosXXbr5MwE
         zQWK085x3wS1ZjRQv68q8L1VjKfaQ+2RJ/8Kpy+Hjh9nF9HX0oX3V0zca+AnBCenmEyJ
         rFpG/mSN+MiKh0KmIX3zwCS6yUyGzS7ia27JrAJYndzhSCf02Pt6FWlKDS25XunZGrVu
         AGQMyMBGqklYKRuNL7TDZY9R0TV7Gwx2PYVYCaUKgROlQ28pbdnLALvDDzLVpcm25n4C
         q4/wU0XuMx5xJs2hBV6x9JDNs/TB9j76tm+qmhYCx0JtHiIFbXEiZW3zzlPQu15Z7dDf
         XiVw==
X-Gm-Message-State: ACrzQf2XB7EBQNAynpkulkTRebr+KGQVpguNr0q0XtAORrurORvhFy3v
        zXadJCMxI7D9yI/IriZwvhhZVOnGzexGUxxvung=
X-Google-Smtp-Source: AMsMyM4wUO5alvyyaOIrWcEMfcGIZotOLC8BzY1nvMaz1PDnulMCev9vwBb8p9IGjcntBsopXkuRMw==
X-Received: by 2002:a17:906:328c:b0:780:7574:ced2 with SMTP id 12-20020a170906328c00b007807574ced2mr17218545ejw.634.1663682955943;
        Tue, 20 Sep 2022 07:09:15 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0077f324979absm927133ejf.67.2022.09.20.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:09:15 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:04 +0200
Subject: [PATCH v1 2/3] media: Documentation/driver-api: Document device name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-meta-v1-2-dfcfba923204@chromium.org>
References: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
In-Reply-To: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=HciaCCHyEvIeKVlrlc8/DyoOKo+/6DQ85iWol0LXRbE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcmFzWpUkjaI0rM9439zD7utogdFtHDytIIQ715s
 163jHKSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJhQAKCRDRN9E+zzrEiCrOD/
 99Ws+U83b/ujdRcBlQC/bTHWwpmOlA1KQrDTD6BrJNb6Mxv1/A5387x6PF7xMkHPGdE8YR1aqgymPS
 6fu1WgeVlvdlcqYjHhYd+i7Mm4/2IKyFHEUcKfHXDjn4mpomb0RL17/3wrsiKsGbfFo/aMLAnKUbE/
 iUYwioRJLg/3VTLu1je93hWsardGfR1Nja3ABreq8YmQpMwzyIr/GAXuJkcpZVEMLUj7eZSSHwVm6X
 aJ8cyoOGRudSpfpcLgZkltZHOUTZRL8E1VEwZKbHRpK4en4ZnYOXtFgMB4PjSF5SflDQKKI9s2e0zu
 +D3GcSL8LD1VZhdVVunho+fXh+c8ocjkr1YQ+VGVmYiV5crKOFCRtq1JmdQe02i6devgvEvQlmslH+
 a/o5bk9VmUXqQts38YWVX9aHV6cpD7AJdCiaNPZgXOvpIhY14k+/ygiMHkRHa0qRqOKyulTOhlmOHX
 I+dj4jOExZYH/OGtp0gBft1im3iVTlfAUSE2isru0pViuBhHn6eLoDOz2D5SV2OKcWfgK0M0ZUJObu
 rdylqzKd/LvZxm92UTdPDWaaCOg2bG/BKtlBRtNAXvG2ZpujFVUY4GAE/vmWDcFbj7ed3SHEMNqZEs
 V7X3bklXy2T56G5DDAMdFAtWhL81RPuYKrEEuB0quBBeDJks+A502yS1iJmg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document how the name of the metadata devices is modified.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/Documentation/driver-api/media/v4l2-dev.rst b/Documentation/driver-api/media/v4l2-dev.rst
index 99e3b5fa7444..935a46e29c5e 100644
--- a/Documentation/driver-api/media/v4l2-dev.rst
+++ b/Documentation/driver-api/media/v4l2-dev.rst
@@ -42,7 +42,9 @@ You should also set these fields of :c:type:`video_device`:
 - :c:type:`video_device`->v4l2_dev: must be set to the :c:type:`v4l2_device`
   parent device.
 
-- :c:type:`video_device`->name: set to something descriptive and unique.
+- :c:type:`video_device`->name: set to something descriptive and unique. If the
+  device has the `V4L2_CAP_META_CAPTURE` or `V4L2_CAP_META_OUTPUT` capabilities,
+  the string `Meta:` will be inserted before the original name.
 
 - :c:type:`video_device`->vfl_dir: set this to ``VFL_DIR_RX`` for capture
   devices (``VFL_DIR_RX`` has value 0, so this is normally already the

-- 
b4 0.11.0-dev-d93f8
