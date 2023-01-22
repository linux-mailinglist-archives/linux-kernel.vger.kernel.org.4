Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4996772C0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjAVVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAVVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:37:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C816AE5;
        Sun, 22 Jan 2023 13:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CA560CA4;
        Sun, 22 Jan 2023 21:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2893CC433A1;
        Sun, 22 Jan 2023 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674423417;
        bh=mjT5HyfVWuQ9qPsnmeirI8u/EIvVyfvfGP/qw6kfgyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1BlawAvBv+/slEpknH0YdhR1WriSmtSkV5iz/dLWTjuMJjkx/UdwtFlylB/RAYG/
         bD+tEs0zj+Xt0hIDVu4xN7kexsT2TvRoMusUQUzt4tNQ517VpQM4KMENQDijNXVq90
         NJBYzoOdrZQIGw7I513XlUwLPWbp+Cdiq/QSpwlCEYwLWzWJdfnkmkr7tKi7WnmVUt
         ZGbz2S+2OVbEc57nqQBxYXX4NKb3X+IU1ioB+xnLSJGJP9O2RT4KjFRqWuuCjEhd5m
         dvSs3ukw2W9Y+CPYEM+liZipLWrWv9joFP2Uc3Neu1bCZewcWAzkmrCX6M0k/lgiAE
         4QFNiG02isuKw==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] Docs/gpu/index: Add missing SPDX License Identifier
Date:   Sun, 22 Jan 2023 21:36:45 +0000
Message-Id: <20230122213650.187710-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122213650.187710-1-sj@kernel.org>
References: <20230122213650.187710-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing SPDX License Identifier for gpu documentation index file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/gpu/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index eee5996acf2c..9a6c7831d7fe 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: MIT
+
 ============================
 GPU Driver Developer's Guide
 ============================
-- 
2.25.1

