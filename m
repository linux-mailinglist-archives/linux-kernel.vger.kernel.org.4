Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC86AD63E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCGEiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCGEiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:38:02 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD4EFB1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:38:01 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p6so6933188pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 20:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678163880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VGm/0OBe4lAdq+mNIj50o86iCXlM99JOVqeZjGU0HM=;
        b=m5q7tcYe74Q04eb+DWS1HqvwG/PBGlBslHW8GZAqGwsClnIDujkyvISWnWWCbflmwZ
         WDAUN+8G+H7TI5VTUc7o1fNZkV1cgve4hbWNyFjb9gdBaZxrVa/T3TTxwt6s2R6Vap9g
         XeYrEzdNb0jzc6TyyNEP+0nE1PQOtC6z6+JH3kMH+jE3nPCrtj9P4n5nYMgNgYyg+2a/
         IJH3an43VvtEOw6L29SS0sNdePyo1vtrmc3gJkZp6m5WUig6sHXaUmf2IrO8LmcvUCKu
         acStDk/B60RMILSiW0LaMygus62FX75WlMBVaZ55fisUfw+nMokmFmZUOHSnym4f+eJG
         9J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678163880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VGm/0OBe4lAdq+mNIj50o86iCXlM99JOVqeZjGU0HM=;
        b=NtyMocAfFNqCoiOPc5ot72kUKwO/S3ba5nDPAmz7Eym+bXIAZ7t/yj6K01zjtRP9q6
         DZ/jt9/+etUxqdIprDFTJXJOReWTHfAm3hnUiNlwOAao90HCn5A/S/2CD02k413KDztf
         1+7LJgCk/lVPS7AKYbQYcXimpue1HV90B/5xT80efVoFliuTANs4zp3y51sBTdkC7W9p
         KePNa85JW3h3ClBgMifH2VR1QxqX1AuObec1qmb5TUidsKusl5GINyWE7mY6VOAhaamV
         zM/XondlLiL9BWDv/pnajS747aWqtS9kLzEH/gAKJgVj9d0O0gflTcpVq1XSY14+16Lp
         8qmg==
X-Gm-Message-State: AO0yUKUnfCYR9Tafqkn+L2maswCtXpco9tEw1rzjmOjAOPwadB9Cqo0t
        6qOB3XgcbGMm0l9a5UIbOk0=
X-Google-Smtp-Source: AK7set9afnIGTS0xOCj4X8sTfiQbfNLMSVLqqBUh+gnE+PeMAE0EGzcvQYKlYAlMFhtVVEiS50PW3g==
X-Received: by 2002:aa7:973d:0:b0:5a8:ab21:be2e with SMTP id k29-20020aa7973d000000b005a8ab21be2emr9435881pfg.18.1678163880487;
        Mon, 06 Mar 2023 20:38:00 -0800 (PST)
Received: from debian.me (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b005dd975176c3sm7062459pfn.53.2023.03.06.20.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 20:38:00 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B283110541F; Tue,  7 Mar 2023 11:37:55 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Airlie <airlied@redhat.com>, Dylan Le <self@dylanle.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] accel: Link to compute accelerator subsystem intro
Date:   Tue,  7 Mar 2023 11:35:26 +0700
Message-Id: <20230307043525.25660-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=bagasdotme@gmail.com; h=from:subject; bh=bamdze7HsRu/UGKK7VIjGzsdYb1bczhaTZM9tydpM3c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCls+3l2OtQ6+tawi7mdXM3DqLUvsHGqXMeVi2GCv0OLVs3d E9fdUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlMl2JkeBU/1aIjbs6DPrcbx0ze8M 4qFz24a8H935MzYtyENk16OJeR4XVi3uHPp2KSPgqm8N0+3lLsy3Jgu9OEmex/5kz4H6zJyQEA
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

Commit 2c204f3d53218d ("accel: add dedicated minor for accelerator
devices") adds link to accelerator nodes section of DRM internals doc
(Documentation/gpu/drm-internals.rst), but the target doesn't exist.
Instead, there is only an introduction doc for computer accelerator
subsytem.

Link to that doc until there is documentation of accelerator internals.

Fixes: 2c204f3d53218d ("accel: add dedicated minor for accelerator devices")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 This comes from discussion on Dylan Le's attempted fix, where Jeffrey
 Hugo suspected that the proper target should be accelerator subsystem
 doc [2].

 [1]: https://lore.kernel.org/linux-doc/7799513f0fb5aee27b64752c037980471be669c5.1677120686.git.self@dylanle.dev/
 [2]: https://lore.kernel.org/linux-doc/CAOCk7NrAKZ2G-VbQW3MJUZmkKkO1Ccrs2wo12kg6QHysH-d=Yg@mail.gmail.com/

 include/drm/drm_file.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab8a..ecffe24e2b1b0a 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -408,7 +408,8 @@ static inline bool drm_is_render_client(const struct drm_file *file_priv)
  * Returns true if this is an open file of the compute acceleration node, i.e.
  * &drm_file.minor of @file_priv is a accel minor.
  *
- * See also the :ref:`section on accel nodes <drm_accel_node>`.
+ * See also :doc:`Introduction to compute accelerators subsystem
+ * </accel/introduction>`.
  */
 static inline bool drm_is_accel_client(const struct drm_file *file_priv)
 {

base-commit: 5c8cf1664f288098a971a1d1e65716a2b6a279e1
-- 
An old man doll... just what I always wanted! - Clara

