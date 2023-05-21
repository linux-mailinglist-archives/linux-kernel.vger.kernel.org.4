Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB470B1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjEUWc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEUWc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:32:56 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E3E41;
        Sun, 21 May 2023 15:32:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A766C5C00DA;
        Sun, 21 May 2023 18:31:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 21 May 2023 18:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1684708289; x=1684794689; bh=AVS9Bz+ypq
        s9Uyk6cW0VJh8RYEp87Ys6KMR0AX8tGt0=; b=AS1kagr5q3RwvGd67auBzuneMv
        ewU8ZFTF7R+Ykj2PRsdM+X63Ox2ASD8PWrv7Y94UW5qyn2BB7lVZLC6HByxdGwDR
        qPXpLX6S2YWZPDqSNzdjp6o//RCvzoCq2kuZxmQEZX/KmFkKP1af2FKpbVIJAeRA
        UoUQNLGhS9x/fCxCf5SKHNwnaxdlwrpZ5rnLGJ/lbH0IlyYWjKI9KzsVfX0XWhXB
        jhWQFb08q8D4GE75NLyysa7QTqHbdnA0IB/dkKKVa1u2NhZlGxrNJ6Fv1C3Psmq8
        LbdgHSPhkUboRTvgPsppRRnmB713d3cqRwuw4etjC7uYOMJE/A776qPt67Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684708289; x=1684794689; bh=AVS9Bz+ypqs9U
        yk6cW0VJh8RYEp87Ys6KMR0AX8tGt0=; b=uD2M+XkVMXdLUUWUXOLNxc/FV22Sr
        dY5mPbvV+WJPYds97Emifft/CzkR1+x+HR1GvbNLKvUyY3kZu6i8kEJyxINaeZ4w
        SOiWP+dK8jETiVKYjGuQpK5LkaS6J4XNT/Y41QxiFl99suvwsTHgHecZXfEzqgx1
        /hri8BduDbEspL9tlkWnOoMfIlaYmyOXhApDKPEfr2n3NUk07FQsG2UBT0lWY9vh
        5xRBpI9SdxCZaRKTjsOmjnCj1DNpjfxwXWIfpaLXq0ukppePNQQ46k00IvDO+npU
        ihUx7I54Cm2OKjzDam75jw+TETmQ3rlNbA+Hw8eMdaq+lFJW7Uw7T5G/g==
X-ME-Sender: <xms:wZtqZJmQ2V1tbTz6ZYzFpHpieNaU0GM-8p5pm5Nf2AHHJVOcsV8miQ>
    <xme:wZtqZE0jjrDWnUN8xMgAS7yCkDPGmggzOVN4CtqkWXb2L0Hqu424Fi-S9y_1J1B6Y
    CzsEtLt6nlEhtgr3QE>
X-ME-Received: <xmr:wZtqZPqNmCj29iAZAGVj9cLBXbFIgxrjGhUXmTb3wP_9n7bpzpgvn1s5PLfS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:wZtqZJl73ksWEmqfA8KSSNjcVKUnaGmsd9kG5DA9_7fJEAocYzeWWg>
    <xmx:wZtqZH3aFQyizaTMUuMNIGO_sVPqYlsvco5gyPgPlxyGx_LEqMol-g>
    <xmx:wZtqZIvxvBmgQu5d0PFo7uPwK3cNJ6XU0qF6pSTcu-PdpLaeJJkdMA>
    <xmx:wZtqZCS8QE_no4q97jk-fwLGao1Hl1eU4nAGr7ujO-xQ9ie9B6LXpw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 18:31:28 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] MIPS: Enhancements on usage and documentation of parameters
Date:   Sun, 21 May 2023 23:31:21 +0100
Message-Id: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

This patchset is to enhance the usage and documentation of some parameters.

Please review.
Thanks
- Jiaxun

Jiaxun Yang (3):
  MIPS: Rework smt cmdline parameters
  MIPS: Select CONFIG_GENERIC_IDLE_POLL_SETUP
  Documentation: kernel-parameters: Add some MIPS parameters

 .../admin-guide/kernel-parameters.txt         | 37 +++++++++++++++++--
 arch/mips/Kconfig                             |  1 +
 arch/mips/include/asm/smp.h                   |  2 +
 arch/mips/kernel/smp-cps.c                    | 13 +------
 arch/mips/kernel/smp-mt.c                     |  3 +-
 arch/mips/kernel/smp.c                        | 18 +++++++++
 6 files changed, 57 insertions(+), 17 deletions(-)

-- 
2.39.2 (Apple Git-143)

