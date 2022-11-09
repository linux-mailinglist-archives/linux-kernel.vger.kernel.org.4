Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5776227DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKIKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKIKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:01:59 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505EDD13A;
        Wed,  9 Nov 2022 02:01:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v28so16219339pfi.12;
        Wed, 09 Nov 2022 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jWb3rEDYYu05FX2EdvpMst1+CvG5FlXLf7h69zzjhw=;
        b=eBY4QNDxwf8uOPLRmT5d6Z/+j0cSTDhDUNgn+Mu6PfU54J+OA0TKdAfu0VAn90kX6v
         bb7h9VWSngJiNia2NUwtma6lPC7KV1IiZdkNtf/dE73GFfC+izezfLQ8jwCWx8eoSDNM
         adyGr6JXweZ9WxxHWSddeX9vKOH21Sobft2DmDAJzIYBy8e5QRnCUsz2Yl/z3cgyX+XS
         C5cmrshldU8TofKtRuTqRutxeVec75k8kG+NSEbxu9HXFU2kxfb+xE71RQd+tzKWauyp
         SLFsHXGgwOuzIDWA+G1CBhV5DTTYOOTz9uvORTI6B+9rkFVrl4b7H3/ItgSTiBjf+CR3
         dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jWb3rEDYYu05FX2EdvpMst1+CvG5FlXLf7h69zzjhw=;
        b=mvY0DUyndFxb8qNCwgbhvlKxDRiPAmqS9KdkKO0kB1EwC+oT/zOxoa/eiszs66UuqD
         61umMmdXD3gditwlNkbMsJjBHZIabLTHv/WlUUsz8Y34Ke38UXtbrwjgvDAnXDxcMvhV
         LuxKQeX9qndQ7G5ZcoVPykQmRkP6VWHwHfWuBJ71nYSPC2I8asRWkA2FSsVHMOqFXHU5
         a/G1DImQFY/YXuFFpzw/suz3lywpih+zeEXm01ZSu1yE2QHG+nfVphm7oBgA59JOcqp4
         AcdMHCatj/q97lQqi+apEnLbhff2Bkycz0Z3N4MiXckvyckkZOsqu36S4A/Hi7zeiFPo
         nrLw==
X-Gm-Message-State: ACrzQf1YxU/ELnqIrQDkGLvlifHRgjQ484d0KMxYuLn1NiFj7PW75nJy
        yVhzX/wZCZM46s35aBA6wX4y6OLBpuE4tw==
X-Google-Smtp-Source: AMsMyM4WvxFihsVNx5Lu4TdyEARu/gbijY3nDQ1yIino20ltMmFghzJtXLZZKTpYr1Mg8XigYv8gvw==
X-Received: by 2002:a05:6a00:1823:b0:56b:f348:998f with SMTP id y35-20020a056a00182300b0056bf348998fmr59967518pfa.28.1667988117604;
        Wed, 09 Nov 2022 02:01:57 -0800 (PST)
Received: from debian.. (subs32-116-206-28-40.three.co.id. [116.206.28.40])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902c40400b001869581f7ecsm8711645plk.116.2022.11.09.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:01:57 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: media: Add ST VGXY61 driver documentation to userspace API table of contents
Date:   Wed,  9 Nov 2022 17:01:47 +0700
Message-Id: <20221109100147.218947-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=bagasdotme@gmail.com; h=from:subject; bh=XeGaCzt2k4NhEKIDZjyXWzO/o2Not0CUk8FRuA1z7Ds=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMnZVd0TqyUl1e+u3XfD6Zn6f4/WSfMd2rkf1i6wKLG7XZmQ bP2ro5SFQYyDQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5dYPhf/KbL/ldPCmNGSbzOJgMLN 43LS2fvnpupYhAWvqmM885YxkZuhVbPp5lX8Yza+2PqVVXyuQ6W4KyNvzfvrXggPz3+Nx/PAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reported missing toctree entry for ST VGXY61 documentation:

Documentation/userspace-api/media/drivers/st-vgxy61.rst: WARNING: document isn't included in any toctree

Add the entry to fix the warning.

Link: https://lore.kernel.org/linux-next/20221109162013.293250a2@canb.auug.org.au/
Fixes: 2378be892b6ff5 ("media: Documentation: Add ST VGXY61 driver documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/media/drivers/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
index 32f82aed47d915..0f758c8d45235a 100644
--- a/Documentation/userspace-api/media/drivers/index.rst
+++ b/Documentation/userspace-api/media/drivers/index.rst
@@ -38,4 +38,5 @@ For more details see the file COPYING in the source distribution of Linux.
 	max2175
 	meye-uapi
 	omap3isp-uapi
+	st-vgxy61
 	uvcvideo

base-commit: 1e284ea984d3705e042b6b07469a66f1d43371e3
-- 
An old man doll... just what I always wanted! - Clara

