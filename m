Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E87350E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjFSJuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjFSJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:49:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7819A3;
        Mon, 19 Jun 2023 02:48:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BAAB5C0237;
        Mon, 19 Jun 2023 05:48:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Jun 2023 05:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1687168119; x=1687254519; bh=z
        JY/iV7+ES1OmJWQ+83GG8v0G8S0/h77ZUcKq66Jqq4=; b=VpDON8/XGH6cDK+nC
        EazLZnr78R2pg5PxOl5aimsf4gifvUFRfbJWi/axYsG7LpjCJCkDyppQ0cYeCj7y
        Wbr9VWwbvYXcGRPP8IyKux5nulChsVhGuqBIx9NaGVe4WPuT4ciwbRJ21IFq1M2T
        BCv0p323Q0234p8KlwnLUqCZasQVPe8ngViTT2kcRPxGnkgYq58fK2A0jS/Ery22
        9EV5ccvXABmW0CmXgmg7QCLsxKonlwSo5v+EwVSqDsCDG1Xqb2fqoXYUP4sL9nj/
        UHmo9j8entyH9vBD4P21uDd23YXER2bl9WzvH+fmoFxAOKud568bSnJXe4fp8S55
        AWD9g==
X-ME-Sender: <xms:diSQZEV7XVWFA57zlfwJ4MtUERNBd9kzmcoQZ2sOTloBA-yufJWTWQ>
    <xme:diSQZImWHxf3NbjLJySBdeSdpxrdtQmWC8CR3F6aCcPPZzifY0EFMX2wF3M9FgqTo
    -RdBgSILDzzvz-c-mc>
X-ME-Received: <xmr:diSQZIaGXsXdB3I_P3lHV6cqx-sOsBrtX3xFXfn2ebVGF4gHQfdnRfRi5fObEu7bTcS7zs7MM9pkIQ2Ewfye3E_-JdS3drvE8ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:diSQZDUXh3JMihR71YFm7wqwlcPs0RZV8eGFBCdRzO3IkGqwC9-ySg>
    <xmx:diSQZOlDfrnRT88OX_0dZIP4zyZLyb0orp_DA4Al5opW910gjAXRUQ>
    <xmx:diSQZIfceJX721lySNGD-pwdiVSPMsBxTku7Ov7NgzgqtML1yZyKpw>
    <xmx:dySQZFvy5VNH8pk2LM91s8yeuvIKB0sq1vLHhDU6FUbWo62odhF-vQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 05:48:36 -0400 (EDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Kees Cook" <keescook@chromium.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Date:   Mon, 19 Jun 2023 19:41:57 +1000
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Contribution Maturity Model methodology is notionally based on
the Open source Maturity Model (OMM) which was in turn based on the
Capability Maturity Model Integration (CMMI).

According to Petrinja et al., the goal of the OMM was to extend the CMMI
so as to be useful both for companies and for communities [1][2]. However,
the Linux Contribution Maturity Model considers only companies and
businesses.

This patch addresses this bias as it could hinder collaboration with
not-for-profit organisations and individuals, which would be a loss to
any stakeholder.

Level 5 is amended to remove the invitation to exercise the same bias
i.e. employees rewarded indirectly by other companies.

[1] Petrinja, E., Nambakam, R., Sillitti, A.: Introducing the
OpenSource Maturity Model. In: 2nd Emerging Trends in FLOSS Research
and Development Workshop at ICSE 2009, Vancouver, BC, Canada (2009)

[2] Wittmann, M., Nambakam, R.: Qualipso Deliverable A6.D1.6.3
CMM-like model for OSS.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 Documentation/process/contribution-maturity-model.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/contribution-maturity-model.rst b/Documentation/process/contribution-maturity-model.rst
index b87ab34de22c..863a2e4c22e2 100644
--- a/Documentation/process/contribution-maturity-model.rst
+++ b/Documentation/process/contribution-maturity-model.rst
@@ -62,8 +62,8 @@ Level 3
 =======
 
 * Software Engineers are expected to review patches (including patches
-  authored by engineers from other companies) as part of their job
-  responsibilities
+  authored by contributors from outside of the organization) as part of
+  their job responsibilities
 * Contributing presentations or papers to Linux-related or academic
   conferences (such those organized by the Linux Foundation, Usenix,
   ACM, etc.), are considered part of an engineer’s work.
@@ -103,7 +103,6 @@ Level 5
 
 * Upstream kernel development is considered a formal job position, with
   at least a third of the engineer’s time spent doing Upstream Work.
-* Organizations will actively seek out community member feedback as a
-  factor in official performance reviews.
 * Organizations will regularly report internally on the ratio of
-  Upstream Work to work focused on directly pursuing business goals.
+  Upstream Work to work focused on directly pursuing the organisation's
+  other goals.
-- 
2.39.3

