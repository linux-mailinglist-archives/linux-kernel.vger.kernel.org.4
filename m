Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3B73994A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjFVITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:19:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7A2107;
        Thu, 22 Jun 2023 01:19:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1203D5C0050;
        Thu, 22 Jun 2023 04:19:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 04:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687421978; x=1687508378; bh=hH
        5vwg3g4lUW3WmAdhq/KzkSN793TkjIdYbcki+6e+w=; b=OXIy2i50Tz5HGVbJFi
        DIhaQBTjDkFzVMALCr5fRCcm61jknGTDPDuzPloUnOYcWPg9Q+QU1TpID/dgSk88
        dcABXsiNfBKwHEC+evQPO8wCKn6XQyYTtNCFFYbJWEJDvaQl1slR2gmVHGmiHMfz
        CNvH6r+AX31uDmM+kYT0yv1oiFXz4pWZ+G14DVLaMlHhd4DMZV2BJfcWnyTs1f9m
        jZE5n76RltClHzRln41/FTuT2VGw/KVb3z1cGiuk3K1qLCAjI1/wFCnbiM0XT9Vp
        a9zqqjMUvzue+6CPbQjOQhUtLnMTZfuZCEDdY/g+SjN3cWcv/Eo1qYn5Th31varM
        8THQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687421978; x=1687508378; bh=hH5vwg3g4lUW3
        WmAdhq/KzkSN793TkjIdYbcki+6e+w=; b=Ao+L34WB7V+0i7miCDQlBM67jy3K1
        p6XdD9YgSsDuUGkPgRFjIQJwDQBQTGWjHlg0X0Gdd3aUd4dalQXVx3W/oEjrMbYP
        I4ixCXHUGIbkjjy5GdWzCUcSSSe0cSMq6LW0rhwoCrCcJEd7zDMa4d7T+CLkOClH
        jaYfE+UCVYBVAkisE30v5FR469hQV95oMUx+pByOoinMBDhgKFmqbLDtfuf6vqrP
        XZWsdYmyozfbgC6muoOMKu5VGaloz7Vq1pWRpcPmCPX0hODR2urAtTmJml8v9mA6
        Ao5dFuVlbWzS6UyDfc/p0S7hLJ0VHGijm/Li3mTvBcvML5g0oFeHOQvxA==
X-ME-Sender: <xms:GQSUZCj4mtnORLxM-BazYgnhP7TSiNTnxUt_EscqfJO5jUxB8LkLGA>
    <xme:GQSUZDC1xZ5tIbRxqOmkVOMaYUdXpwNAudaUayDok5QaiLDAc4Paogsz-SxIZ7rtr
    np15-KgjI4fRFvQcwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GQSUZKGdl9oCjOvdVx9gluYXok0_6FW8LNJM9TpjzI-9j3CI7aKv6Q>
    <xmx:GQSUZLQvfH3ThMxfyMdjV0qiHJ_Mhh-AyCi_Jf59TG_tNErUDxxJNA>
    <xmx:GQSUZPzL706tMl5J33ZAmj1n9uh7ezvycovGGSm5VUwSUx55vr9ZvA>
    <xmx:GgSUZBtrUpLok7qyGimZiFrl-MSIbH5C0EzjgPCqBIZ68CgjiKJrkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9465FB60086; Thu, 22 Jun 2023 04:19:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <afeb9fad-0d3b-48ac-82da-218dcd8010e7@app.fastmail.com>
In-Reply-To: <20230622104810.30055fb1@canb.auug.org.au>
References: <20230622104810.30055fb1@canb.auug.org.au>
Date:   Thu, 22 Jun 2023 10:19:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     "Rob Herring" <robh@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: linux-next: build warning after merge of the arm-soc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 02:48, Stephen Rothwell wrote:
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> arch/arm/boot/dts/marvell/armada-390-db.dts:84.10-106.4: Warning 
> (spi_bus_reg): /soc/spi@10680/flash@1: SPI bus unit address format 
> error, expected "0"
>
> I am not sure why this has only shown up now.

Thanks for the report, I also just ran into the same thing.
It's probably instroduced by 89e73afc3f540 ("ARM: dts: marvell:
align SPI NOR node name with dtschema"), but I don't know why
there was no warning before.

Added the fixup patch now.

    Arnd

---
commit 7dc3be1745d05c1ed7d385487238ec06a07f4f29
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Jun 22 10:14:02 2023 +0200

    ARM: mvebu: fix unit address on armada-390-db flash
    
    The unit address needs to be changed to match the reg property:
    
    arch/arm/boot/dts/marvell/armada-390-db.dts:84.10-106.4: Warning (spi_bus_reg): /soc/spi@10680/flash@1: SPI bus unit address format error, expected "0"
    
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/boot/dts/marvell/armada-390-db.dts b/arch/arm/boot/dts/marvell/armada-390-db.dts
index 792d0a0184e82..20f518dbac971 100644
--- a/arch/arm/boot/dts/marvell/armada-390-db.dts
+++ b/arch/arm/boot/dts/marvell/armada-390-db.dts
@@ -81,7 +81,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	pinctrl-names = "default";
 
-	flash@1 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "n25q128a13",
