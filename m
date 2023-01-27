Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE64067DDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjA0Gku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjA0GkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781169505;
        Thu, 26 Jan 2023 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jkGU4nbyYTo0PHUSwa4F1L9prs0zbYb2bk1PtblxpjA=; b=ebXTMeKRptI2/jgaxUPED6UveF
        di7olaXSKh9w+LsfprF/LkUB6nL4jY7FPtvS2Otq6JJk4UvfeQTaDhBriswXtitt32o2VDY9AIuAD
        97tweo5hiB1ctKjt5xiYplW4niUE/OGq7mog/7AnA1cTo+V+IJVVx2i25x9lqU+wyWegoMMb5B+Gk
        qrn/yVQas5kMlm0TiXogiO9YzB2j/MWuAgUZohq7FEiw1oyilgeetQXHRTeZPvQJ7LtmdBObeUKrc
        YZ/Q3O/i9HJAy70uKzTibmcirWLlMnUcDLVqebN/t9y18Gl0WR0yPdyL1V2/FfzbP/IGK1A5kuL0j
        TQ1CwF6g==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPI-00DM0u-Cw; Fri, 27 Jan 2023 06:40:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 14/35] Documentation: leds: correct spelling
Date:   Thu, 26 Jan 2023 22:39:44 -0800
Message-Id: <20230127064005.1558-15-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/leds/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/leds/leds-qcom-lpg.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/leds/leds-qcom-lpg.rst b/Documentation/leds/leds-qcom-lpg.rst
--- a/Documentation/leds/leds-qcom-lpg.rst
+++ b/Documentation/leds/leds-qcom-lpg.rst
@@ -34,7 +34,7 @@ Specify a hardware pattern for a Qualcom
 
 The pattern is a series of brightness and hold-time pairs, with the hold-time
 expressed in milliseconds. The hold time is a property of the pattern and must
-therefor be identical for each element in the pattern (except for the pauses
+therefore be identical for each element in the pattern (except for the pauses
 described below). As the LPG hardware is not able to perform the linear
 transitions expected by the leds-trigger-pattern format, each entry in the
 pattern must be followed a zero-length entry of the same brightness.
@@ -66,7 +66,7 @@ Low-pause pattern::
         +----------------------------->
         0    5   10   15  20   25   time (100ms)
 
-Similarily, the last entry can be stretched by using a higher hold-time on the
+Similarly, the last entry can be stretched by using a higher hold-time on the
 last entry.
 
 In order to save space in the shared lookup table the LPG supports "ping-pong"
