Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7767666D995
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjAQJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjAQJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:14:05 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6B30B24
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:06:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F6295C00E4;
        Tue, 17 Jan 2023 04:06:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 17 Jan 2023 04:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1673946375; x=1674032775; bh=bBFBHdgUEx
        DtLc/7PnHuZCFolfc8GR5+frlbC+WuxQ4=; b=BKpkK/uu5m1z1sNkezqUciat0Z
        KCxQJIb8Uqfsca0VG2Hq1sKEJYBpKQ5S5Zd2AKuodusHQ4F7KczG7NBQD0AyBPWE
        Om1HJOFqA6c6BnpILuW5eTr70Y+NAXGVCbDYAos416zhrr10Dxhlq6Y8Ay6vQZMb
        Bzw440eknpSGWtpww9t83FiRT0RDmzLzN+rjU4VdM/V4ei6L8m34n/kPu5IIEWjz
        vVjOO8lsCbeXMMtBJN3t2F23sS6atOEOw+Gp/K3CH1TM8ohfJhVkFTi9wy2/s5Al
        h1vw4jKrcc6JhMWt8wtPwMExwGQ56DFVNM9jUB0DcEMPTl2NDlUwv1/HG1YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1673946375; x=1674032775; bh=bBFBHdgUExDtLc/7PnHuZCFolfc8GR5+frl
        bC+WuxQ4=; b=KXodEdAgLxLnX5G0K3mUsjlOBNf5clBOSH7kW8zTuZVzun+LG5I
        fFn2BZ+QLh7ahpiFcmCsmHP22HDavDgrpSjkiBdx2XfFctWb0RsbByFua0eOxMOl
        qzePwDrad0fG4n7eWk07XyX4NC4fpf8/8WhfSVqTOvvsR3ozz+9ugnZZcF5Kum9G
        Mc/vLZAASa5MJG6pVzv1Y6Q+5am3nOyjndFs0eVCqp5yJWYPtKkjuunLgmXsZuXO
        wZ3o6uEDnOlI13pylrCDJFp3ebsu/LzGZinjuWtIozTiI1jJgcYZaeWW/dqmXgJ9
        IQc8zddcn4fpRxov00Mz95+jC3kpyt3MaBw==
X-ME-Sender: <xms:BmXGY9nYlvb3T1sNjzAcBwreLwH5fmMcHuU8OfcXeNoZ2DvkBP9GgA>
    <xme:BmXGY41mD-MTV-u4bgAK_FN8-i_gw70_jMbJHGdVL5l_BDEO3DJzipJa1mpgQ7bwS
    rSjBQkHba_UUkW5xbE>
X-ME-Received: <xmr:BmXGYzqwDUugU_Oeqeg8dBjvCzmmf7yZFwtJQtUp45AcqW1HvKwTi-5RQ6oSxuw4SC7XkIU1Mj1JjyuktzWw4fQp-r9VVF3P1_-gtCkSOCWI09QQmmgRSaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddthedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelff
    evkeduhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:BmXGY9mQg0d_jSwkaIVRtzdcPNaGMzsznzqNXQPhFpN9MBVIIlEBGQ>
    <xmx:BmXGY71md5kfUijFt804Yxo97Bu87av6gMt7LziVvovdTycF4jfU4Q>
    <xmx:BmXGY8soR7utB0zHDzNI_WH1_LSAvZO9Zlnq4ABEr3Ai6KStYu3vNA>
    <xmx:B2XGY5CuT-p34ph1JC6Cha2StnKOWmaw9Peq9FQbw-N5Iw0zWtA4DA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 04:06:13 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     tiwai@suse.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/1] firewire: fix memory leak for payload of request subaction to IEC 61883-1 FCP region
Date:   Tue, 17 Jan 2023 18:06:09 +0900
Message-Id: <20230117090610.93792-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This single patch fixes a bug of Linux FireWire subsystem for kernel
v2.6.33 or later. In detail, please refer patch comment.

My intension of this cover-letter is to request sound subsystem maintainer
to send it to mainline since upstream of Linux FireWire subsystem is
already inactive.

To Iwai-san, I would be pleased if you alternatively send it to mainline.


Thanks

Takashi Sakamoto (1):
  firewire: fix memory leak for payload of request subaction to IEC
    61883-1 FCP region

 drivers/firewire/core-cdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.37.2

