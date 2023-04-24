Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E906ECA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDXKcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDXKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:32:24 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523B26BD;
        Mon, 24 Apr 2023 03:32:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8438B320093A;
        Mon, 24 Apr 2023 06:32:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Apr 2023 06:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1682332340; x=1682418740; bh=tdIAU1QeGG
        0LMr63T+Ys43nJbPa8UgQj9W1zWge6JMM=; b=AxRCJ31CHjixpVL64UiWBEaYGP
        Jh0Qw+ASKQUQb+Yf8t8IK9cgkERQjgP4qS6QpkDZxU/Z73JWqP2LLnbG68ZkvinS
        eVbc1d/tDVqwmMl0ivDf7ViuOHcRlSJFIJkCtOV54rt7RzSy65r51KzfqrecJW+X
        ezoSVR0ho+AbI240uPRBIp7FS3z35fWf/4zzH/h/PS09kILtkWVSYO977QdiL3EG
        L1sbjQ51alseebnK+26UVZo7bS15lGiPP5zSUwn5hbtjpqpZJLStlAdzRbxDBGxv
        amjTWbPkoPy717zgqbzUFdVmS/V28Ps4tAM/OiILYxbqV0T47dzteTje4fyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682332340; x=1682418740; bh=tdIAU1QeGG0LM
        r63T+Ys43nJbPa8UgQj9W1zWge6JMM=; b=gyARfQGnU6+VHHPQOsg9O9QhucwuP
        jg/3eXun6Mj9XIVPdPU2DVrRGSBAwkzQbtwLWVTk4Q+qWZYH2/3E9VtXMBgdXt1f
        N/c1dO9EjVburbz6o+xd1ZUTDyX/PQ9PZtHtcDTA5RwutuRhYmnSgKGNstwmtDEQ
        p30a1jg/el/3/LMvdjpZb7KXxSr+zw5rymNm+ZHvJpsdHowVkRxg1K5wb8KuIouf
        EPq2ENaPbnHex5hs3oWqOKSDRA+eUizTPrXoAtMZep/tVmn91zys1x0qvf94CXxl
        idEWXyU36o0aQxxXb96EDW2MUXXd81k4XigO2czO6GhBaBOdbHEU7yVoA==
X-ME-Sender: <xms:s1pGZJFDtcVfwQ0B8GfvcyLyu-DIyKUi0BydIG9yWL_xc7TGe1LcsA>
    <xme:s1pGZOUmhFjI-TUvF6J7EVj_J2YC70jmxFRPV4_hEKpOH1cOtLRrjDPHidlcK3Fym
    NQixYexdj3AZuQVlmE>
X-ME-Received: <xmr:s1pGZLKlstMEwSMJUcQAXz7a-jY-MCNiHyTxiVE3DPA-Db5LXlTUC2kp-dn6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:s1pGZPHk6QTopxYaRtSpb8FXvdnXsYR-JKw5BcozYmd90L-rn2CerQ>
    <xmx:s1pGZPXEtoNNsOI_2VzcjhlKPr7v3glky0KjJwbfrZhYnUjH8JnwwQ>
    <xmx:s1pGZKOWiNK5aulMQONsKf664q6sR_aBquCi4rujBzdxL1DeC7XKtQ>
    <xmx:tFpGZFcTGMFdyUaRGnwzGtwFU8T6zIxCbHwj1Qjrk3-vz--aHIVJNw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Apr 2023 06:32:18 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     tsbogend@alpha.franken.de, fancer.lancer@gmail.com,
        tglx@linutronix.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] irqchip/mips-gic fixes
Date:   Mon, 24 Apr 2023 11:31:54 +0100
Message-Id: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset fixes two issues in the MIPS GIC driver that may block
booting on some systems.

Please review.

Thanks

Jiaxun Yang (2):
  irqchip/mips-gic: Don't touch vl_map if a local interrupt is not
    routable
  irqchip/mips-gic: Use raw spinlock for gic_lock

 drivers/irqchip/irq-mips-gic.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
2.34.1

