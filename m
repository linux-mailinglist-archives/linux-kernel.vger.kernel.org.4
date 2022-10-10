Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F125FA06A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJJOru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJJOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:47:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3893761133;
        Mon, 10 Oct 2022 07:47:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 108BA32001FC;
        Mon, 10 Oct 2022 10:47:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 10 Oct 2022 10:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665413265; x=1665499665; bh=XBBYtTJT3f
        u3050JNCv4u7dVMEfnQsHU3OS3x5Ym9d4=; b=XXE4ZODVP+jz3lD7kmVqPPUFPA
        3oCdLtm3dTcMUAdINjqdapPX2FNMEO/WpAdbjJvHAGaexMN+dLUUyWy3UP9nDdGs
        BK7Q3qX11OK0dhJlYWO++uJR23O7d2IJjOGJ7lVCz2ejOKEKyZMZT6gnb8JxKo+u
        /o9EGnVAEZM5XK1Bu4Ibcs0eewRCu0knTLHVuy/TNFS4dPxcPjoK5VWP+yRjJP9W
        RNf69sxmgURwk6VRhj078+VIBQK2nxkeIfWBqATwR7OKr3B0gVPWfY3GzzyanpIG
        xGKwyebcSySMoyLhO0eiEERXDVnMwpZlWYWyhJfz9CSklik3WuUCyhkT5mZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1665413265; x=1665499665; bh=XBBYtTJT3fu30
        50JNCv4u7dVMEfnQsHU3OS3x5Ym9d4=; b=q3WoF3gzmdiNiZVqk7hN+RYy+Nfqi
        qEJg7drCuQ4QHabaQdV+dh1sVcJy4x5Gx9E5VqLP17mHQFYkj+UXkZF2CubvQizN
        Ou2CwEpsMpDaPTaic+SZ3h7XmDObigwpbWbHYjzEn7VjtZ9x9vfCwArgcEKiS2mw
        nYg9f35uEmU4t67x4uBTNm/5wvEYnNlvUI6psnLWlQbCpY/OHuuhA7DdGM0XiEYx
        DN8l/+gAYLPRNDFGK9RcDQQw9C8BzjrABdVytBJJl33MjDeUyZX8CT5xRZHWqFFn
        rE0BioaVTrZ0dG41Y4BipittNb2zf91DK17L0a14BrsrZwm7M7zv71ROQ==
X-ME-Sender: <xms:kDBEY0cZoY2bpPdXedszdu-0K7nDDwnBIFkAqncxayQu6oAF9U6gRA>
    <xme:kDBEY2OptzEVx3TUWWLP-beN5SXS2M_bO3O4BO0cEaOibrDpjPiKIE8-LBuy0EJiC
    2VywqQcWfz40Liqros>
X-ME-Received: <xmr:kDBEY1hpBiYLivc1bEA6f-H-E72mUJfODD3b0ErVe8EcFVaZejaMA83s2mt3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepufggtgfghfffkffvvefosehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepieegfeehleekkeduteefheejgfeiffejgeefheeugedtfeekgfdvveegtdev
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:kDBEY59WY6W5UvyEwChCkrQfGr-84wTXD8_IN8_84Uw8Z2EzZ3yXzA>
    <xmx:kDBEYwuA9qNjyJbKR9uCA9KIsB9uA-PxpqomYEiZLfoPzAHV1drMMQ>
    <xmx:kDBEYwEDCVxCnCD7e9bk3X8wWgmavlKF7H4GAPGG92MbeZK3oqmA1A>
    <xmx:kTBEY6U1xBI6mt_-H1cbRs2CKFCSQCQJFZH334IuLz9n3Nu_IJ8Tpw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 10:47:44 -0400 (EDT)
Subject: [PATCH 0/2] clk: More Range Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAIkwRGMC/w3LQQqAMAwAwa9IzgbagqD+JtaowRKlQRHEv5vjsOwLxlXYYGxeqHyLyaGO2DaQN9
 KVUWY3pJBSDDFgPQVz2XGRhw1pJVGkoYt94MV7D35OZIxTJc2bv3qV8n0/2rANVGoAAAA=
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Mon, 10 Oct 2022 16:47:37 +0200
Message-Id: <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=TFa7qcW7NCwE1LLk8e+al5tmxEiAYshiaEnShrmJHI0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkuBn2+b/+eCGtZvmKy9Le858HJ8zzXZO/M3bzUN82vSabq
 wtzwjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzExpbhn1HjUrML28rUdyfXM7z6pp
 YxubNsU9KKT9sb8hoEp+xZv5Lhn7pb4o/Vm08kzipbZCo490H5/cwYyxMiOoxLJp45fW3KF24A
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are patches that might address the issues reported by Marek and Mark,
according to Stephen's intuition :)

Either way, it's still fixing and adding test coverage for a regression
introduced by my recent work.

If it's easier for you to test, this series is also pushed here:
https://github.com/mripard/linux/tree/rpi/clk-fixes-again

Maxime

To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---
Maxime Ripard (2):
      clk: Update req_rate on __clk_recalc_rates()
      clk: tests: Add tests for notifiers

 drivers/clk/clk.c      |  39 ++++---------
 drivers/clk/clk_test.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 28 deletions(-)
---
base-commit: cd9fd78f5c11b5e165d9317ef11e613f4aef4dd1
change-id: 20221010-rpi-clk-fixes-again-a95180ef0108

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>
