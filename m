Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2811762D1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiKQDzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKQDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:55:06 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146FF27FE7;
        Wed, 16 Nov 2022 19:55:06 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AA74F5C052C;
        Wed, 16 Nov 2022 22:55:02 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 16 Nov 2022 22:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=burrougc.net; h=
        cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1668657302; x=1668743702; bh=0ZEgeVT+oI3oXeM3fZ+gXETlz/hMiPIPN86
        q/rG1RNw=; b=G5gqw7jFwgW+sDZo4RWrBaAIyVRCQvaRzOhYicwml1XnVUKFV6Y
        7VVVawRudYza67jv+Ds8LJMr4XdB0PXAjRAcf99/OR4g69WBzktBtAzWfV9bP0hp
        9n3snptJ8vsOdJ/Vm8LFbysTxzntx+4Rfo+HQfhnGgFx70u5NZN1ME9FuTnL5Py8
        EFyqRbO5K3dHTScvX9SrvuXLEQxmLJcfQ6iiyQTG1FBbtTiqGwMcH/kiASA7Ly3S
        HCADiY+h+k/NVZP0Seqec8YQuiBncUfxaHXwRtORU7f6QJ3qKP3uZMya+EGYbJvr
        mICOyyjmqarBFla8m1T18uUWRllKaj6/Vxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668657302; x=
        1668743702; bh=0ZEgeVT+oI3oXeM3fZ+gXETlz/hMiPIPN86q/rG1RNw=; b=C
        8nerXUJ+t+g3kU6O7NLNQv0DdK7zk6rly7738g5fU5ArnT4mE5tZd6Mja/DBwyra
        MCR7OIeowB3yo6LYjlbWS30rTaFPuLmmysbVHr8VTHiSBGNQQtlYB7HjWnUS8CRR
        Oi79LenpDXMGntt6d5Frr679+5WKyDH4AMyPPFE9kgqYLM7aU8pWlz4rK/dNNM9E
        jR8N2AN+iJqbW1x9DH4yPQLY3ibgExaj3jJu+bNcoG9OPnXWdUjbvTpKo62/Pwq8
        b0fynySb7RWrMtxf3C60/kkFrxX8VKsS9lcLprvgfOqEvkKnSalcBae1uHxOrWSF
        ytClkHbWDf/vgSglC5P+Q==
X-ME-Sender: <xms:lrB1Y-t1nUK6mv49AorzCHlvEyWi8H-aTqg1JZ22vCkipZNJbdCRAQ>
    <xme:lrB1YzdzlptkygDo7sCSii1IsN7FrdvlLesy1IplLQvB7ZtOByCYx_or58R7PXaNi
    xo8lgKIlGTEWfZNkUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepveholhhlihhnuceotgholhhlihhnsegsuhhrrhhouhhgtgdrnhgv
    theqnecuggftrfgrthhtvghrnhephfefjeeitdfhjeeltdehuedtgeduheevffeuhfefke
    egvdevhefgkeegjeekvefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheptgholhhlihhnsegsuhhrrhhouhhgtgdrnhgvth
X-ME-Proxy: <xmx:lrB1Y5zQpkoOl5BRBilHHqtXJG67JUJDWcVwJfbMH-SXIn50W3IyrQ>
    <xmx:lrB1Y5NmJoWTyzwGLBuqUfP3hB9tk2kjho_C-XS5RiKnTYqfIK8ZFA>
    <xmx:lrB1Y--CSXd0436NJrc3v-uGhmHnSvNtedOhcU88_hBuYVUOQWtA9A>
    <xmx:lrB1Y_I1q7-t7pX6Q9T-9-Akfs3mbY1ovCXgQP8UNPfm1sja8j5GHw>
Feedback-ID: i6db1472c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7ED2631A0063; Wed, 16 Nov 2022 22:55:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <40386821-902a-4299-98c8-cbf60dbd4c2c@app.fastmail.com>
Date:   Wed, 16 Nov 2022 22:54:41 -0500
From:   Collin <collin@burrougc.net>
To:     linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: Missing generic netlink controller operations
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While messing around with libnl and netlink I noticed that despite existing in an enum in linux/genetlink.h, the CTRL_CMD_{NEW,DEL,GET}OPS operations (and in fact, all operations except for CTRL_CMD_{NEWFAMILY,DELFAMILY,NEWMCAST_GRP,DELMCAST_GRP}) are unimplemented, and have been around, untouched, since the introduction of the generic netlink family. Is there a reason these exist without implementation, or has it simply not been done?
