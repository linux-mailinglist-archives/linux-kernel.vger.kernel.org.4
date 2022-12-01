Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91EE63F44C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiLAPkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiLAPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:39:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52893A54;
        Thu,  1 Dec 2022 07:39:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t1so1442042wmi.4;
        Thu, 01 Dec 2022 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOkjJ49YydlvCDY0afffT99zYYKtrxdz8Sf40U74Enc=;
        b=j9oLbiNRaXpnHIje9VKE4nLcb7+6czmhJN4g3RnHkAh16pmeBwJSme6IimLjBggE8o
         T5jUcdoPk4+n5jmxiJ6cxIpXqJk8Ia7iyQbT0WH15JN/LI/D58gYwuxKm+ohgRCpc4A4
         gHshTm+tITLuYPqv5LmhUrn7bd7xfx7bS2CJqY/G+rqfgdQgCSzB8eVMXBzffAJq0uVi
         DPUqgUcVvzNdZ8fnHhRqBcqqWqcw6uA18xg9Ci55dpZFTdOMhz8kBmdrsDqRbtipxuqI
         y4G11VZAlqJQ6DOIAhCNXtsmfNGJU7XTy37OfpZfWnOQOqpelBchjxQAVjnPc8hbd0k5
         RgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOkjJ49YydlvCDY0afffT99zYYKtrxdz8Sf40U74Enc=;
        b=db9PLX7HYivnxCzX46yEYRGLWptuTmfkEOg/AGMzMAke5PnoD2RWAkFglE+9Bxqxpl
         WJvPS/7ymEyDJ1Fwa48v761WK5xrFDdVvhomCfQuPmLiT38zzO5fUIArQaPbFBw6I77u
         ez9JCXGosWJbkKRDXGkMPTdMAF202kemNVUmx1rwnZYxnEH8DQUeLU8ufTkn/GWvbCPe
         mI+t7yCL8zBcwiNQeuasdcXqxjREcCY+e3tXyrxo1Qoi00FaqMMGPy/SQQnEYOp6bzWr
         mQY+tOXhNaURSpdpdrZjHNA/Y1uLwSCLdkZF7plRWniLS6VLQ2v741BU5JgcRSeZq9Bt
         xfEQ==
X-Gm-Message-State: ANoB5plsSOVUt7rO7ZO6jluMyFfKZTbxLNLVuSipBAFm0sXvrEqDoIU+
        3iSNZngQMT7iQGYU35ze7wXcL4N1pjc=
X-Google-Smtp-Source: AA0mqf4yPSTXLm0ri7Bg8PiPcSSS0dFxtztOpvXhzUoK76TcINL8V/D9Zo+enxFgpf63HDNxnZhGcg==
X-Received: by 2002:a05:600c:1d23:b0:3d0:8193:c1c with SMTP id l35-20020a05600c1d2300b003d081930c1cmr1156702wms.143.1669909149638;
        Thu, 01 Dec 2022 07:39:09 -0800 (PST)
Received: from wlan-cl-kit-cs-172-17-20-201.scc.kit.edu ([2a00:1398:9:fb03:6341:588f:5b6d:9173])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm5523597wmb.42.2022.12.01.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:39:09 -0800 (PST)
From:   Peter Maucher <bellosilicio@gmail.com>
To:     alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Maucher <bellosilicio@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu: add GART and GTT to glossary
Date:   Thu,  1 Dec 2022 16:38:22 +0100
Message-Id: <20221201153820.257570-3-bellosilicio@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201153820.257570-1-bellosilicio@gmail.com>
References: <20221201153820.257570-1-bellosilicio@gmail.com>
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

GART and GTT are two abbreviations that should be mentioned in the
glossary.

Signed-off-by: Peter Maucher <bellosilicio@gmail.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 326896e9800d..d86bea7926dc 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -30,6 +30,12 @@ we have a dedicated glossary for Display Core at
     EOP
       End Of Pipe/Pipeline
 
+    GART
+      Graphics Aperture Table
+
+    GTT
+      Graphics Translation Table, mostly synonymous to GART
+
     GC
       Graphics and Compute
 
-- 
2.38.1

