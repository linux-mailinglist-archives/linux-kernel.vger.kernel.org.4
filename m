Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3F726283
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjFGOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbjFGOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:15:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7888E;
        Wed,  7 Jun 2023 07:15:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F272E5C01FA;
        Wed,  7 Jun 2023 10:15:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Jun 2023 10:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1686147340; x=1686233740; bh=kV54xPBWSO
        6jMRDaa0Nz4NRiwXl2hA/6yyw97A8fySA=; b=rClrL9xg4oWeWdx/QDG/GMl+D5
        s3uH/2yHFup5Hylu3zYmRHQZ/U/cvBlMdWHKXV8dlV1CW1RhGLxP84FokE+Y0Pte
        sE15lwqmlAAYLFyoasuLnrt2fc9scdIL1Uk/kHoR+Au4V6OnyHTEFDd2ciOv4oH/
        ivQ+++TAQhFFXzF8CEu6ryudeCCTg4cQONoo6egJ0+1Vg6neEVb5cY/9N25N1WI6
        ItjHcqufcgbe3L3Y2D3rhgr1cKAnMuOXS02MXESLlSxZC326oHHGxaxJpKjtsmyi
        ljxLXOK57IoaUq0mERgzQF4rFXkViqyCyR1JR6o1nnhBTLaEVGbXfaXX2jgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686147340; x=1686233740; bh=kV54xPBWSO6jM
        RDaa0Nz4NRiwXl2hA/6yyw97A8fySA=; b=mQ7UPclt+8YsRjJ8OMuoVy7mZbEV1
        t6VKMJi46vysfr7Q0T6qc3h1e/5npznxqQoIwi3sKhqPSB4EvPJQ8p/qMD1bmhxn
        MvGjkVeaZvY37venlZH1IuzRnx9nkCDYuFemnq3Q1NU4uFvFnlH36I4+MfCnq+pz
        /sZuvZslYssOTHjPCfCB+WG9t3l24nX4W6D/WZdn9fTeUOwoB+ZGnJyi7UN8MdK1
        KEZsRjiZyiaXHnMkF65mrayWrNi0j3cAKYRD3yFc6xX2bZi/AalhsmDLoAwB0JFR
        sDhdbBQ/M0dZgB2u6d9sdC5LrkXEx396Ckf6xLoBsaSvLEOHFB8YYLewA==
X-ME-Sender: <xms:DJGAZE-DQAzuL8l8JyKcPTzZZR0lTkuyXsJzXwvMZLIpKHLjJU85rA>
    <xme:DJGAZMv-OgThk8SzwGoovDsg4OWsxNqno3ImlTlb_QwO61b0IBwqrcfO1IQ_lzo5k
    57j1vyrQOekovPT8gw>
X-ME-Received: <xmr:DJGAZKA2jbKIC4B7tE7LoKaXMYLUviVsnjPuXgve9ewbvryAuT2_lz6rkVVhNsZcwYKnU_mn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepheeffeehleeftdfgjeegheelieefvdfghfeuudeuheehuefhhffhtefhiedv
    geegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
    ihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:DJGAZEdul0Wf-CGFYbs6muLf3RGIh39JpPTBeUjuay8fSb2LRm2eEg>
    <xmx:DJGAZJOCRSZt7jHq19Wq8SqqcLEguZUAZ3siM9A5nev-RBBKWQZI9w>
    <xmx:DJGAZOlGUxm-9rlydG_ORy9-hIU_rlhhv_Fk1jp3Q8Z9LUTrma5zCQ>
    <xmx:DJGAZM08tfyy-gdiPMhj99OLtffOd2qlu0z0KT0fek4ENShuVwPNqA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 10:15:39 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>,
        Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH] documentation/rcu: fix typo
Date:   Wed,  7 Jun 2023 08:15:21 -0600
Message-Id: <20230607141521.539828-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tandersen@netflix.com>

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 Documentation/RCU/lockdep-splat.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/lockdep-splat.rst b/Documentation/RCU/lockdep-splat.rst
index 2a5c79db57dc..bcbc4b3c88d7 100644
--- a/Documentation/RCU/lockdep-splat.rst
+++ b/Documentation/RCU/lockdep-splat.rst
@@ -10,7 +10,7 @@ misuses of the RCU API, most notably using one of the rcu_dereference()
 family to access an RCU-protected pointer without the proper protection.
 When such misuse is detected, an lockdep-RCU splat is emitted.
 
-The usual cause of a lockdep-RCU slat is someone accessing an
+The usual cause of a lockdep-RCU splat is someone accessing an
 RCU-protected data structure without either (1) being in the right kind of
 RCU read-side critical section or (2) holding the right update-side lock.
 This problem can therefore be serious: it might result in random memory

base-commit: a4d7d701121981e3c3fe69ade376fe9f26324161
-- 
2.34.1

