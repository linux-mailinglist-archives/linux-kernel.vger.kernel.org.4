Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA45565AAFB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjAASdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAASdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:33:21 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B66126DD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:33:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7D1163200063;
        Sun,  1 Jan 2023 13:33:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 01 Jan 2023 13:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672597998; x=1672684398; bh=pPNQpVYlTQwtH0yI7fJJtR/ei
        bnG2GO2Hpnu03U2DyM=; b=hdkXIt0xOz1sN6hcmzvTTXltEtOX/MMA5wiTlDKXK
        Fb32J6qxOJnkbd77qlS2hRH1RS2u2viUtf0+vJcDPF6e2qIYsNKgTuB6Un8jYTLI
        +5f75QvMSzXulfcHx7mWZJPFolP7IHnQ/p/22ZrvSkhWPJeay5Np7no7M2Paj3+C
        CF17SZfh63F9U9XV/f4KOk56LxDpJgd8/+TwnJxZXr0trBcwfF9M57TRJuVOOoz9
        Gq0YZuAtEVQuUH+/E1iCJljiE4lKYWkqpBea5AnfG4h/8T9ND2WAy3EW2o1bOer9
        yDUsH5fglVH0yLlQap1i9RqPnF79JCcZOJR/cbx4EHM4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672597998; x=1672684398; bh=pPNQpVYlTQwtH0yI7fJJtR/eibnG2GO2Hpn
        u03U2DyM=; b=mjbqwFpik4dHPjLxAK/ac+hMDG4JjQWVd1CPfQDLOuaAvkBJcVC
        9yySN6v2Xv6wuA7XeUK62tdYyXoUy4EEPRW2mw5Xjpj+sQa86ZRKa4fPZHrwvgB4
        uH6ph1W1P9IoAPltRiHnC4CVwR+e+HN4H4jplpUwv4Nz6pjxZuR2Jd+BBtaHoCsg
        bTDW04O8unntozPEF05mfHqbhq/uTf9fPX7ASS13e+rth/7fpJnJPNeFYkHX74VA
        HdvPcD7zqVLcdcysdDUJlJpWZVXehzb+kFPycnhT1yVkemo3NUb0r80c07vemGt1
        FSPqQnDtNOVlJGFKPcic5S365AvsfswGY4w==
X-ME-Sender: <xms:7dGxY-kmRyQ8cwLYoS-s9WqmTNiM2_pG0qwAkMX_WZnjyMXQdw-mpA>
    <xme:7dGxY10DA5QxxlhVlF-ZrMpwgsWDAnwnW4EBdFeXv4RsjGW9UZikesXo8ASjrwkW2
    9gmeWfle6Wv6LjUDQ>
X-ME-Received: <xmr:7dGxY8pUanGBqIjWu17m853MESZgYPpun1f8hSB9blrLPQic-z1XGU5gdI4hPztH2HO4Yng3Ji80jjWzN7X72JT1yiOCMBOJ5OYmhjGwWvE56omJCSsnjqRaRGGn5hGr7LYkIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:7dGxYykCj20wWLpQ0FQxF055FSG5RqEAD4kruLLvD206F_qeQGPITg>
    <xmx:7dGxY82F5OmAQOIIbDT3C4IOi6HBBe_llvUZzsq-iVd3fE-MeFvObA>
    <xmx:7dGxY5vCZYab2J1c1C3BwqdnfLOYEhQhyDcbn_Hr5-y2TpZqz8mwxQ>
    <xmx:7tGxY2oYYHHkJchwXt9AJoukf2FP8f4jZ5GUM7zh77zA9Fx9DPRf9Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 13:33:17 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/2] nvmem: sunxi_sid: Fix for D1 variant
Date:   Sun,  1 Jan 2023 12:33:14 -0600
Message-Id: <20230101183316.43642-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first two patches from [1], with the stable CC added.
The first patch fixes a bug causing incorrect values to be read; the
second is a cleanup. I split the series since this bug needs to be
fixed regardless of the DT binding discussion.

[1]: https://lore.kernel.org/lkml/20220814173656.11856-1-samuel@sholland.org/

Changes in v2:
 - Split out the driver fix from the other changes

Samuel Holland (2):
  nvmem: sunxi_sid: Always use 32-bit MMIO reads
  nvmem: sunxi_sid: Drop the workaround on A64

 drivers/nvmem/sunxi_sid.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

-- 
2.37.4

