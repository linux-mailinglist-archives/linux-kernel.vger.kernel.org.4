Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76265A756
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiLaWCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiLaWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:01:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B55F84;
        Sat, 31 Dec 2022 14:01:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B5BA5C00AB;
        Sat, 31 Dec 2022 17:01:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 17:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672524109; x=1672610509; bh=uEGwd78iouIBfqIK3t/RRS7S+
        +4GQDRNvKIt4E61Pgc=; b=T7zIRNB7y343XX5YH2dmlezUMp+hc2shyHwqMfd6S
        1lRhKykBUE5ynNXNfY5JEe56s6/drHw+pGSUWkE30nl/ZE7BjxuTi5voaPkt70CJ
        ytfzZVNPmpj8xqNPeUrAjULzx5LYcCaT9cheOg9D9dRMRjb7aHF6rHFSxiVIJ4uO
        PcRgBeEwpo4KeKwZyM1KWq7cRPAt5KxcPw8WkILDzgbEss7HBo++dng4FFxEgBiH
        2UBozlU6oBiaCg0r4gk57NeugKJh39z5y2IOMZCF9saG6WRfLCLNpmCMorA5G4tj
        re2w/xl9lN8pfGajmfyomJtp9GpbsWu3Ksqgr/vMKTCNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672524109; x=1672610509; bh=uEGwd78iouIBfqIK3t/RRS7S++4GQDRNvKI
        t4E61Pgc=; b=G7lOHcQgKBoGMWpvwy6cOD6JEJzXzdc26/du93Hn6fwYmzDaDlr
        QPjwWVFCfcp8vmAiEjaOzQzVEms/AVZKoHZMM9q4sTRBQ3LaFHgQBdj/9CumLqdK
        uYkPcmFH1xVWJygQww7+4smC3sAohtXsoVjhj0HPo0G4G+ti88CXmWNV72OIq3bq
        er2bcNVxlWhNbGiwvclg0eD/rZItnLeqlk0A5nQ4Lozr5apJjgzLaf94cKhbQuZZ
        pLyKfNMHofkpryOUCxQt97KxY8wg8cmkvZr/X+RmhEJCrQQZIqILYFYDNzKOhRvb
        fI/EUNWStiEPWV7unPNGqe/1ZbB1L6jALkg==
X-ME-Sender: <xms:S7GwY6FQd6hZJEG4YIRcIq-0J7QcwvL0LZI70BYVYc3sxQ5CaG67yA>
    <xme:S7GwY7UWoCcAeDdOarYJoHUhTzBufT8U8e9bojz6NlbeU6DrQDZ3kELA9yWsF_5sX
    GXokwZPxn3ATtiNlw>
X-ME-Received: <xmr:S7GwY0KhzI81Va4aLI6SCksAv4w2zCruZVNDjyS8wGmNIMaxrAtvTtE7KgRV9sLctzbxhNXDCDUtxg0Y3iGqdWyEwT5uH4I7CIPYKjetMZDxlmvcBf1_u_7pMwhDY75qamkWpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:S7GwY0FhvTw1JxpLhzraacJm7Uby1ptVkwc_xqWU9fHGEpq9z-zbhw>
    <xmx:S7GwYwWTMkRDvIzRhCJu-8q8ysKNwu74KYpBwJQrYIhJGIqbLazqiQ>
    <xmx:S7GwY3OzIdkhZUpR--lWaCybgzz0u19jz3uHkb0XbYVgW8hzb72-mQ>
    <xmx:TbGwY8mHggTyKBxh-0GO0wvPyIIv5VTAA1jdtcrZpLAzkGYZQShSQQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 17:01:46 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/3] crypto: Allwinner D1 crypto support
Date:   Sat, 31 Dec 2022 16:01:42 -0600
Message-Id: <20221231220146.646-1-samuel@sholland.org>
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

This series finishes adding crypto support for the Allwinner D1 SoC. The
driver patch from v1 was merged, but not the binding[1]. This turned out
to be a good thing, because I later found that the TRNG needed another
clock reference in the devicetree. That is fixed in v2. I include the DT
update here too, since the SoC DT has been on the list for a while[2].

[1]: https://lore.kernel.org/all/20211119051026.13049-1-samuel@sholland.org/T/
[2]: https://lore.kernel.org/lkml/20221208090237.20572-1-samuel@sholland.org/

Changes in v2:
 - Add TRNG clock

Samuel Holland (3):
  dt-bindings: crypto: sun8i-ce: Add compatible for D1
  crypto: sun8i-ce - Add TRNG clock to the D1 variant
  riscv: dts: allwinner: d1: Add crypto engine node

 .../bindings/crypto/allwinner,sun8i-ce.yaml   | 33 ++++++++++++++-----
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 12 +++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  2 +-
 4 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.37.4

