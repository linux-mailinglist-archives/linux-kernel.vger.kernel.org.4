Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56165EC912
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiI0QIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiI0QHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:07:32 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F7A2A8A;
        Tue, 27 Sep 2022 09:06:16 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 8F5EA823;
        Tue, 27 Sep 2022 16:06:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8F5EA823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664294776; bh=iwHrGHGlM3+zgEEEw8s3BogUveCH90vBib0d9fdqPx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBzHBDXG0gi3tUzS/vpeTcqmjlhCtBbR+gJwNbTj+cveOmVrOlBaP6zMTuvodUPFS
         a2lxN1eT0DSbDj8seqkMSBxySuX8tciysAYCJrwPDR4k5QGIOHiCL3iTs1ZUmjshef
         8dxpvmpHh77iFLHNLuAl3e/PhalgXJrkioIHKyTsaZZeMOd3Axqj/3wzrtbQakVWfh
         bYdyXD2cEV4ne4+RWe5oUX6fd9W8thTP7r75VO1iYzSD9VjDYZpytYW5JZBDtHQsYF
         w0p/jwAqApAom5dmYpfKDWBLiERSbayqw1fqosM9CMxFgJWuMRbcwDXFAy4Ey/Ei0m
         Yh/L5Wc2BH0+w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 4/7] docs: remove some index.rst cruft
Date:   Tue, 27 Sep 2022 10:05:56 -0600
Message-Id: <20220927160559.97154-5-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927160559.97154-1-corbet@lwn.net>
References: <20220927160559.97154-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some useless boilerplate text that was added by sphinx when this
file was first created; take it out.

Reviewed-by: David Vernet <void@manifault.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index bc492e79f1be..da80c584133c 100644
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

