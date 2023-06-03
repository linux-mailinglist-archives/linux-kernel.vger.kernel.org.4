Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8355A72109E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjFCOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFCOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:53:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D0A2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 07:53:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 00C155C00CE;
        Sat,  3 Jun 2023 10:53:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 03 Jun 2023 10:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685803988; x=1685890388; bh=XTRiEXC0hJ
        uFUbypDKl52aPAQLwWCJPaXPAmCQQTCu4=; b=lBydP/ccutXAtieqnl+EWmcf87
        fR/wqnWzGPOEygQCrxEv1MVIIiuSSayoJeKj339a8hkECWQVfBpwhU2bRpNVQk2l
        DduJhuiI/cKOiQ4R3KHtIAI3TlmSDXP9lEBc2hHWuR4X0C6RDez53mCyEHFc0Tbd
        6BsZSK0QXEdAawt6RLqsjh0n54D+VsnvKG7D1IF7Wb0goCY30D6C9V/HyVzse5Fz
        tv+XDf5KCm1FCpH0zFlK0OFoeiMQ41BJOC1HhUEf9GJoP3TgZahMxEFFLb8Jeh8m
        LceHQzKuSbbGFMffuheGqTw1TJkCPMlAseAj+BgierpCIx4mBNQ1hTzVJM3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685803988; x=
        1685890388; bh=XTRiEXC0hJuFUbypDKl52aPAQLwWCJPaXPAmCQQTCu4=; b=Y
        MNMJlvr03psqYltvkbWVcQDz7aUp4h+68Tnin6gSkBDFE8qnaFo2uL/0b9EmC0rI
        rMiGeWYgfRJpkrvMXzwyhPEQbklO3mkeMLfyQbUzoj8pJ/CuJ9uf+/DdKQd7u6p8
        LEImr53UDSSxB5+VH3DeGOfFMSzjVFdBPq2M0oG5WZawKQCSAbMeXN+Auhv1a1D8
        h8axfWn4QkstEP3ck/6KrVPh2m7UMrgR7hwzu5LP7M3vkN4tY0MKSg2XupyP8/4b
        QuYXuVpfFL8bi/y1L26NM28UfmV2+84NuNUDmRhAywW8pea46BChWAOjlOcNX6gt
        DT1Cues+smgFk+AdKflEQ==
X-ME-Sender: <xms:1FN7ZHNkI96pAi3U8oJryJMbMVD7qbXmBORwMK9wkJ75pZ60LXG58A>
    <xme:1FN7ZB8zS_0cZnWj0GCKnfwGnJBHgWrQwY7DMp_n0od0Ib1dEA94o-CasVdbe7Vcv
    F-_1ECPL3e9bHk>
X-ME-Received: <xmr:1FN7ZGT25mJAUswA6-WbvwV3mjJ7xmgkd2MMZ7MLLtSNlC1MV_c7toz6VgDSn2tQxvVUOsjWhyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:1FN7ZLssyL5GUT9C5kfCxPGVqhz6ZN848vS6BeLBNenuxpSy0hjZng>
    <xmx:1FN7ZPfRErbm921ZJx60OzCDsuqn0L-yJLQsEnsWAPKnFHwfeq5DiQ>
    <xmx:1FN7ZH3sQbEesb-FYB7OpP8jZSBkSVR6nxPfc4xrOEHvg-5-LiU_XQ>
    <xmx:1FN7ZAqHU6f3IlSLmOHO9xQk1KT4gAOag9YzY1UXPDgK2sbsBQFaNQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:53:08 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Several device-mapper fixes
Date:   Sat,  3 Jun 2023 10:52:38 -0400
Message-Id: <20230603145244.1538-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601212456.1533-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains several miscellaneous fixes to input validation in
device-mapper.  The only potentially controversial commits should be the
last two, which prevent creating devices named ".", "..", or "control".
The other patches fix input validation problems that have existed since
at least the beginning of git history.

Changes since v1:

- Fix silly mistake (using sizeof() on a pointer) caught by 0day bot.

Demi Marie Obenour (6):
  device-mapper: Check that target specs are sufficiently aligned
  device-mapper: Avoid pointer arithmetic overflow
  device-mapper: structs and parameter strings must not overlap
  device-mapper: Avoid double-fetch of version
  device-mapper: Refuse to create device named "control"
  device-mapper: "." and ".." are not valid symlink names

 drivers/md/dm-ioctl.c | 91 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 19 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

