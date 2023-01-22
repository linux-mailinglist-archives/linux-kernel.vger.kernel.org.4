Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C66772CC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjAVVhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjAVVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:37:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA95216AF6;
        Sun, 22 Jan 2023 13:37:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A9EDB80B11;
        Sun, 22 Jan 2023 21:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42FCC4339B;
        Sun, 22 Jan 2023 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674423419;
        bh=xYY56q/NOYtWLx3UCg0xiwtiRUBIUTj1fjBJJaoBYTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3/jYW3w/cpAjTs8G7nMWsJOkXRVR/PbLY8zaYMyfpUmMCxl4JghwHVKNf4rscqer
         c++h/3m3FHpIzQbzUTtK5wRnWEP7ouoVyX8WYHJlMOX8wiXKgWAa6Pg6/XRUu5BFXV
         WKxK8DDjaWPrvxhjrPQWf9GfWM/xE6N4fAXMcg7jsmHOHMuH6ZmSzzZ9wb/mAXXSkR
         X3TNyqan2qMvaUKwrVbq8Ihm5KLRDv8rDYOHud1PAFlX6HGdWTMXhlnYM4WsJYBBQo
         zlCPj1qJeI3+T+x+9/ZpsGGyBwU3KVQpS040RMdaJbdytjq4L97RwRIHN7NaE4DqbO
         yQzfbMr7+dsVA==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] Docs/input/index: Add missing SPDX License Identifier
Date:   Sun, 22 Jan 2023 21:36:47 +0000
Message-Id: <20230122213650.187710-6-sj@kernel.org>
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

Add missing SPDX License Identifier for input documentation index file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/input/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index 35581cd18e91..d60bf9cfe005 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 Input Documentation
 ===================
-- 
2.25.1

