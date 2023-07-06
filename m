Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32B574A71C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGFWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGFWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:33:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C01FC7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:33:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0FB3C5C0175;
        Thu,  6 Jul 2023 18:33:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jul 2023 18:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1688682814; x=1688769214; bh=m6ZU15+A5S
        e185bgDa4M0ECoqRG+8tqnWq5OsuXQJ58=; b=mu4XxkQyxFUPF4qW+/RHfw7STG
        gCpjmayNa52zGdDV8M/i9ALlDvIpYMfz3z6OhSZ9QxmUaS1phk4FLBsK+JwKQrDX
        pBSg/d6rbivsglFhctsCT9kpwHaMTaNsljR0YSJXh80YRImHUY+0lfgsluMmIPyF
        jQO5n3IjfBNXEwv6dqjT+bWG811A0NK4F5eJmj58Z/8BSSnkzGsvNviZIPZZCC73
        vqQnMAseoTzDyl2Eopiai9gWs5VDxCtG1QZs5CGo3m+IEE0EPYetlVObdOZTwBv/
        avzAogcBjfnz33jGH9kkXr/dWtKW62EhtU2XUbpDv/pf0vFehVn1hKcO5i6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688682814; x=1688769214; bh=m6ZU15+A5Se18
        5bgDa4M0ECoqRG+8tqnWq5OsuXQJ58=; b=E552/sEhXTQm3LKtLVBqP0oNMxN1s
        Hh+5Zm1bLUZ3isUvK8DUsbxxqaY+FScoLYS2VWrXH1OAn0oiaokyv25/a9Cng0Lj
        oRiAZ1csrHQokEp8/tbMR+DXy8lLamLCDDoI3GPRri15VFe/3GAZRlfwWcxwWyj8
        INkKvHZM5hrzNEK3OqLYr4xXQA1MlRRMmtsAcniNhTDGv2Yo2GjRcbVsb7+AF7I3
        OHX/cBN6l45/mR/l/RnS5ncVwmxaELQ9V8k28Kr5fcHH6OrDMb15NKQmziHS7bDU
        kOjLzc1YUvkPThe3oCAt5497vG1QiXZYfzsNPXFuGMbhKW0Y1i278uttw==
X-ME-Sender: <xms:PEGnZC3mnPS_3Jn2BwNJ7B7wejkY_pzpGFuaOQegVsiBGa-Q22deow>
    <xme:PEGnZFGLDJ3xnwo-mGxEvalIH-FTULZaIqpSw50pm6ecUJWxQ8qTR5wsdMpbxpivp
    -pq-Nyn4uczBjvyLbI>
X-ME-Received: <xmr:PEGnZK5vjscDAW8LCkW71_yxtpDc6Kcp6Est5-3aCMx0JoTHuxQoQH7lKjzo920kDMpLqkkh7FysCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:PEGnZD1NRw0OecWydRLmosALfUl5-zFHgYkJb3YOhIzSsTijS_gyzQ>
    <xmx:PEGnZFF1QA34RdvGZvgamx7Vfu4xu8Ro8nXBngwODnTQVwbPfVSAPA>
    <xmx:PEGnZM9Va3N6siDFu51Nuapq86J4qo1kAHZtHkmMF5oTrcB2nNSBsQ>
    <xmx:PkGnZM2LY2xb8VK0uzXzIYryxiaCPQDhzKMOh0NtIec2mHBVi-OSRw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 18:33:29 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V
Date:   Fri,  7 Jul 2023 10:33:22 +1200
Message-ID: <20230706223323.30871-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
- V2
  - Remove Makefile change

Luke D. Jones (1):
  ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.41.0

