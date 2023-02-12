Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B78693593
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 03:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBLCPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 21:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBLCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 21:15:37 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19676166F4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 18:15:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 65F925C00AF;
        Sat, 11 Feb 2023 21:15:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 11 Feb 2023 21:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1676168131; x=1676254531; bh=8u+zNk0AjPoNWDX5vvoNZoLkc
        vhYyKyvuQLWFPq8Xw4=; b=P3VcwyR/XPyQzZsLPQf3+70PgeCLSVPNbRlAS5Ui5
        8LAhd9a26Ebs5Bz50oX28oG76XqKnHqRVyhPH/59ewT/FS6+WavRRqxgG2v6L1H2
        x7nQh87PAiONAsZzG6tJSMWKOWcqCEiwBIMIRUMcv3jn3zkrwSoE2r+XIaQ/9S71
        vhw9z0c33lI5U58wcq1aI92VCcKmTAF11O5U+Tzl0a2+1leUh8YMz4i3DAVkqwnk
        yjDfL+V/CpMOffghO3NNGH4CET3o/NNqjMucZ/S1OKGQZWDX1sWbQdZQvl2YRuMu
        FL8yRM+u2PyjteMTHO08aNETeZAOulbvo0bJttzwMWQzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676168131; x=1676254531; bh=8u+zNk0AjPoNWDX5vvoNZoLkcvhYyKyvuQL
        WFPq8Xw4=; b=XjK4iBkh7EXNhYDVHsnD8BQby4izoyDlSQWZDWXHMLeXkEzNHXN
        YHV+H8Rw9+NaMpMJbq3+85R1xHpzoVxyjKTv0JOLWzyrH488dfD73HPBbWB+myfW
        aTXp8cRncZ5iWi3dC7SYD8BXkEJecnWquk2LV+0eiQbfeEZY86tTr52PPMvTjb8u
        BLH/VgHOKKKPehCVz+E7/dr6OMCbi9bhC1BDTTqhrBMZv4DgjiVeZgcTUehTwxyn
        Fmxi037Gpjoe3wCChDSZAEW0iP8BZkWkKFij8Kzl9xaFX/p3U9Cn9l1MMQgUJIZQ
        Am3A1oisCG6gKc8DBz/I7gKR93SM0UCEbLw==
X-ME-Sender: <xms:wkvoYzjTecigdPNONtT-oLT0WKFPT1HDCGkiW1j-BQD4GifJPZAtUA>
    <xme:wkvoYwBbOV8qx1U-6Ib0UwMm6UcUxnx0rSk_qNVESgb_j-gpacWLqjjdfUxKpfC_J
    uOnhSraf8IjCjVGEg>
X-ME-Received: <xmr:wkvoYzEXju6zIYH3PUaMfUL6VMc_K2Tmpl8SZxYdlVh0xOXysdZGQMyp3bIVbz0beo330QqNe5exQMZPtnC0-USOk0fvX9ruptY5eRRlkXsB1yWgvflVlCGzbdaLnkzs2WHdZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:wkvoYwRSZV9GlhaL0K5uzuEPcMb2AkNE9BENfFodP404t66tNCoEWQ>
    <xmx:wkvoYwxIx_XioTZXMCCKav8hSt5qwIuXrm7gXPza6LyAvdmy6ojfyA>
    <xmx:wkvoY24RiwSXEKsvqQedv6-f0_YWw29PKXHW-zPSw7YFeGBRqt3s_A>
    <xmx:w0voY1r1_6sfHR0pQGYEUzw8a9Ox6MZuXUmKw8EIdduUMHStmihJWw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Feb 2023 21:15:29 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: Fix alternatives issues on for-next
Date:   Sat, 11 Feb 2023 20:15:31 -0600
Message-Id: <20230212021534.59121-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

Several people have reported that D1 fails to boot on linux-next.
Patch 1 fixes a bug where early alternative patching used the wrong
address. Patch 2 fixes a separate issue where the Zbb alternatives
are incorrectly applied based on the 'C' extension instead of Zbb.


Samuel Holland (2):
  riscv: Fix early alternative patching
  riscv: Fix Zbb alternative IDs

 arch/riscv/errata/thead/errata.c     | 4 +---
 arch/riscv/include/asm/errata_list.h | 5 -----
 arch/riscv/lib/strcmp.S              | 2 +-
 arch/riscv/lib/strlen.S              | 2 +-
 arch/riscv/lib/strncmp.S             | 2 +-
 5 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.37.4

