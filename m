Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E35E6D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIVUmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIVUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55292BE03;
        Thu, 22 Sep 2022 13:42:01 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 56A42846;
        Thu, 22 Sep 2022 20:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 56A42846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879321; bh=6sP6TgEn0oAnSqDQCNMm+wTqmFofLWhnY9PfhVjPR6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bA1vQkR7rycquO3nVRijtKMGdn4y5OwIK6pzfTYrRw8Rj+QOJzmu6R84dbo+V1vuj
         Q7ZOnZ6pS5A9d3jsqL9L0+iZeI3u8FYeCOp00V4DWJUPQTCZ4SbeeegsnuawtTNWU+
         b1WaT6Il7y/pahhKPWzeNivOi9k6nyam+l/pNFa4vYu3gMb8MXVLi7EvDxdQKZATTn
         P1cOAoHgJxn6cJYbucV1MlsdJ/Ef5M8KX9XWTcijZyVTSwwPVbdWMpaIGQqcqnzUVo
         MAWTWIdnweJ0EiV2omLmXvhTJxSA30GGDZjJzqeXPJgirUUcMOXPjDvuP6ZM1LFkWW
         c+NJ40kKvg/UQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 4/7] docs: remove some index.rst cruft
Date:   Thu, 22 Sep 2022 14:41:35 -0600
Message-Id: <20220922204138.153146-5-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922204138.153146-1-corbet@lwn.net>
References: <20220922204138.153146-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some useless boilerplate text that was added by sphinx when this
file was first created; take it out.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e0b593486e7d..7f63f70bb8d6 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -1,11 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-
-.. The Linux Kernel documentation master file, created by
-   sphinx-quickstart on Fri Feb 12 13:51:46 2016.
-   You can adapt this file completely to your liking, but it should at least
-   contain the root `toctree` directive.
-
 .. _linux_doc:
 
 The Linux Kernel documentation
-- 
2.37.2

