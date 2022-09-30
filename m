Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAED75F0EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiI3PRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiI3PRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:17:24 -0400
X-Greylist: delayed 8398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 08:17:19 PDT
Received: from 6.mo561.mail-out.ovh.net (6.mo561.mail-out.ovh.net [188.165.43.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63ED161CD6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:17:19 -0700 (PDT)
Received: from player157.ha.ovh.net (unknown [10.108.4.200])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 8AA952745E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:30:14 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id DA51A2F30295C;
        Fri, 30 Sep 2022 10:30:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R0052101a6af-e51e-47df-a03f-556930440260,
                    C05B2F2BD13FA39C9993548B485976379164E02D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 0/5] Update the sysctl/fs documentation
Date:   Fri, 30 Sep 2022 12:29:32 +0200
Message-Id: <20220930102937.135841-1-steve@sk2.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14210545676090574470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepleegteeujeffjeefjeevhfdtudefjefgteelgedtudekleeiledvvdetudevjedtnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates the sysctl/fs in line with similar changes
made previously to sysctl/kernel and sysctl/abi:

* add an automatically-generated table of contents,
* order the entries alphabetically,
* use consistent markup.

In addition, obsolete entries are removed, and the two aio sections
are merged.

Changes since v2:
* added a cover letter
* request review from linux-fsdevel
* fix the link to core_pattern

Stephen Kitt (5):
  docs: sysctl/fs: remove references to inode-max
  docs: sysctl/fs: remove references to dquot-max/-nr
  docs: sysctl/fs: merge the aio sections
  docs: sysctl/fs: remove references to super-max/-nr
  docs: sysctl/fs: re-order, prettify

 Documentation/admin-guide/sysctl/fs.rst     | 240 ++++++++------------
 Documentation/admin-guide/sysctl/kernel.rst |   2 +
 2 files changed, 97 insertions(+), 145 deletions(-)


base-commit: c3e0e1e23c70455916ff3472072437b3605c6cfe
-- 
2.31.1

