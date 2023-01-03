Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53165B889
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbjACBJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjACBJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:09:12 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636B6462;
        Mon,  2 Jan 2023 17:09:10 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AA81E3200913;
        Mon,  2 Jan 2023 20:09:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 Jan 2023 20:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672708146; x=1672794546; bh=frVBfqgdXyytW4RDcsNsr65XW
        bIE8IRHvES+ci0D9gk=; b=TbcNQ6hMRQ0js7MXzWW/XTV0UCtSym6MDqyCGKWSO
        iE7WvW/paXk/HtvkQrNJ+EZLKY4Hg1kkZWdSxz9B/d5mHOwksUHco4JI9bYrM9gx
        ZbV3TNjMXQBOBm5fbpgh8yHaEiMf68RUmzzgo5JUZ55WV9QsVQ6h5TqAwM7/8Duu
        ynMjxXhPrR835PmjojpXfa9J1Llpq5oNpvuiucEziWK+KWeuy0rZgvF3QL6KnHtd
        DhX7hOnxwmPdxs1q/fFadcXmgswt9Z/QPcTxnp8CzCG1O9NSd9nx3YmYXQuYs789
        6LQtmv5Dk7+9MRFIZ6F2fZbygb6/hckbWtgXD4jPv2+KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672708146; x=1672794546; bh=frVBfqgdXyytW4RDcsNsr65XWbIE8IRHvES
        +ci0D9gk=; b=H3+bytyQighzU75PalWI9Uc+ZVdCAoTS6wDS8ONekmGfvArKteG
        TMI9UR4hR96V7sfddq3/5F+oVALiAHomElZVGya+iWwwLURlBqedHJA2SVo5CRxp
        NZA0YUIO83QOs3Vvz4giBtjYEefQhZNMuNFlw195uYPnpLk+nuAsXehVcuXUzQcG
        ruiETmgIYumrwadvP3H/akBRjGVc7Un+YiIsj4bxY+O7FkhAMbwnjM17eOP2scIO
        ON3nhv+Rb3DvrifbDrCgwghVgepDEXFaJKd9gtynabHKzyW4vptYUU8hxYg1sCbs
        +CBb0Bpr0Vf4R1/LUMyGsBvNKyZRDzhcQZw==
X-ME-Sender: <xms:MYCzY4chcK9aPrGiDc1M6mQiBBdnDtnZXWRKRP2CJaDNSsAcVLSM_Q>
    <xme:MYCzY6OsR7PQkCisJKesEcpLkRmvSewtJCU1uOp_stMnxIdduJJjp4HfdRmLoqmeF
    30nZB-uqSTPMIn1nA>
X-ME-Received: <xmr:MYCzY5hLQzJBIdYZdcCZPHefBzzHwa9CMZkkzD5FtLkkNm8XXjXV6fnaVKgVIi9ivoFCwjy4ZCUXveoe6pOvSmEChuM3hVrB5w0LlTHhxJ_Ad-WBn0K5luLo7z_b4MPH-mVN2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:MYCzY98rlaFHqgdsIqR3G8SSgmIiglY_3ViHRAo64It5XsSPmPIMHQ>
    <xmx:MYCzY0vMxeEKicSGbfapf2P2Ln_w1um7HeZBkD5Du4q5Tq5gIzWfuQ>
    <xmx:MYCzY0H6zbYfBGIYiSUWZGxFcm79aJheVR7WSSdy9Q9E4KP-0TRW6Q>
    <xmx:MoCzY1E4x_YztRQAtpqcWYWn0PgyP3tq8L-y7cn0diLfiMZ9bwPVeA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:04 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/6] iommu/sun50i: Allwinner D1 support
Date:   Mon,  2 Jan 2023 19:08:57 -0600
Message-Id: <20230103010903.11181-1-samuel@sholland.org>
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

D1 is a RISC-V SoC from Allwinner's sunxi family. This series adds IOMMU
binding and driver support. The RISC-V architecture code still needs
some small updates to use an IOMMU for DMA[1][2]. I will send those
separately.

[1]: https://lore.kernel.org/linux-riscv/20220428010401.11323-1-samuel@sholland.org/
[2]: https://lore.kernel.org/linux-riscv/7b09e989-0aa1-a557-485e-572f69caf881@arm.com/

Changes in v2:
 - Disallow the 'resets' property for the D1 variant
 - Set bypass based on attached devices instead of using a fixed value

Samuel Holland (6):
  dt-bindings: iommu: sun50i: Add compatible for Allwinner D1
  iommu/sun50i: Track masters attached to the domain
  iommu/sun50i: Keep the bypass register up to date
  iommu/sun50i: Support variants without an external reset
  iommu/sun50i: Add support for the D1 variant
  riscv: dts: allwinner: d1: Add the IOMMU node

 .../iommu/allwinner,sun50i-h6-iommu.yaml      | 20 +++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 10 +++
 drivers/iommu/sun50i-iommu.c                  | 68 ++++++++++++++-----
 3 files changed, 79 insertions(+), 19 deletions(-)

-- 
2.37.4

