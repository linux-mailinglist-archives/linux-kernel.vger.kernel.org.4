Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80876F8CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjEEX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjEEX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:58:36 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2359F4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:58:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C4E853200124;
        Fri,  5 May 2023 19:58:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 19:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1683331114; x=1683417514; bh=SZidY0yAnO
        LfMRTCrpi+LMj3JN/8GMYrcCtqR+SI0v0=; b=ew9iek3DYP0QR82PVXdp1c50H9
        odhFrcVyhHRJ+L2N304E29WoMdwbMxvzxTiqiXQ/z2FVZUu2aMOmppGTrc5XAq2M
        b3ha1IThVZJk3j/WZzcVrwFFGEPxT2s9ByHVtJ94qAT/8g6oPsmI1SucEP/7MhSh
        AL5sOsgwlSbCB7OJqoQH0VTmIMUzVwqoPUOOsZcxWnuxaHexTr/P1QbAjXxfAKZ1
        ma4pZR588/p12qBYrJYVumExhvyI49dnYJQCxmsO7t5CREIXHvEzpVPCP2lCubzv
        npK4IJe65WiGMM2YNOZZ8TSJyyPffE78Uq4d+hkpgWlEkJJnWpv+T+TOrNdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683331114; x=1683417514; bh=SZidY0yAnOLfM
        RTCrpi+LMj3JN/8GMYrcCtqR+SI0v0=; b=YKhRQwiBeGW8nlYxLtK/GWCLKMNjY
        uO38mZ+jiT96TQYMj0ZdKhwvm+hYGy+/LgyOespFOWE/P/yu14bRKSAnczJESSp+
        dzWMDX5mP78LRmpfbGpRyBODhEySy/JnLuM6GP4In16+Xl3DJ7HntL8gQQWS7BsQ
        F5TvKPckFDueMvpGhbz/aFA4zznKGB7nIEbXn6y+dvNKcRFKYS6+GZlSqaPleOxQ
        K+mQy9abo+NWOS01c4BDPKNDsy64LKDKzPW+ZIzlcVxpt1FFFCJ0l5IGG5MLlDXZ
        jcE6+irdWLN0zoJwoqpN+jPylR6DB0M7iqWP+6ebK4BYkQh+PNqJV1gJw==
X-ME-Sender: <xms:KZhVZB_YGVssXNWLvf5SXf_CetUMpPJEbxfpuUYDEGBU8FyssRXQaQ>
    <xme:KZhVZFv7tmj0L6vZ52HiOe8kf3nJViZmeWZBsK6ZUjTnpJEji6m2JgcqMyYZfupQm
    I2f_yeddscIGacZ2JE>
X-ME-Received: <xmr:KZhVZPAfAZXooY6m1zdkgUku6k1Wdykq6Z1WV1Ge6no3c4DCC0ZSac3FiOVt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:KZhVZFelT0oz8ieZVfzrfzqk4gO4uOw0-gD6VvNJL3XsrI-pvo-cgQ>
    <xmx:KZhVZGNU7UycFX_NZntL6OFPJH2CTTF5AQHogecod78zXkbsL_lzrg>
    <xmx:KZhVZHl8CCFLVafkLVeXDem6BH0lWZCwV9Aff32Neprhyu7fwbKo6Q>
    <xmx:KphVZPZqG74ZyibNtDo7Slbaai9BOhMikqBbNgU0PEXNYyuJSnkxPQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 19:58:30 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] ALSA: hda/realtek: Add quirk for 2nd ASUS GU603
Date:   Sat,  6 May 2023 11:58:23 +1200
Message-Id: <20230505235824.49607-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
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

Add quirk for GU603 with alt codec ID.

Changelog:
- V2
  - Move line to correct place in order

Luke D. Jones (1):
  ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.40.0

