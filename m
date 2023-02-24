Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601FA6A14AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBXBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:47:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F965D45B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:47:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44688B81BC6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB6DC433EF;
        Fri, 24 Feb 2023 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677203252;
        bh=zzRw/v1ng+pojf1uAyigINzDHbGNtBXhe5jrQ23dYn0=;
        h=Date:To:From:Subject:From;
        b=IrUYQcYMLRIVQ+haABhWp7/Aevi3xSgA5qyx9pYUEr66BEeHpuFpeM5ZUXB5pZMOi
         ssm2zKt1+oU4YBKO6FeUv6EINy4tR9NoR/uyl+UJ17zryOsVTUwcK0y12qkqOcv05l
         kq3UCf8F0VND5wzGG+yFm6YVaVa/LFNcli2CnOJQ=
Date:   Thu, 23 Feb 2023 17:47:31 -0800
To:     rdunlap@xenotime.net, joe@perches.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] submitting-patches.rst: suggest a Link: after Reported-by:
Message-Id: <20230224014731.ECB6DC433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Subject: submitting-patches.rst: suggest a Link: after Reported-by:
Date: Thu Feb 23 05:41:49 PM PST 2023

It seems to be the new way and I find it super useful.

Cc: Joe Perches <joe@perches.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/Documentation/process/submitting-patches.rst~submitting-patchesrst-suggest-a-link-after-reported-by
+++ a/Documentation/process/submitting-patches.rst
@@ -501,6 +501,12 @@ the bug was reported in private, then as
 Reported-by tag. The tag is intended for bugs; please do not use it to credit
 feature requests.
 
+Where possible, please include a Link: to the report on the line
+immediately following the Reported-by:.  For example,
+
+Reported-by: John Doe <john.doe@gmail.com>
+  Link: https://lkml.kernel.org/r/02f796c7@gmail.com
+
 A Tested-by: tag indicates that the patch has been successfully tested (in
 some environment) by the person named.  This tag informs maintainers that
 some testing has been performed, provides a means to locate testers for
_
