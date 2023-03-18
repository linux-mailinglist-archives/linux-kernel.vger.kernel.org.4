Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29926BFAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCROF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCROF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:05:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C4D1EBC0;
        Sat, 18 Mar 2023 07:05:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C16325C01D9;
        Sat, 18 Mar 2023 10:05:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 18 Mar 2023 10:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679148320; x=1679234720; bh=ne/ZkURyOBnvQZJfA/dZ5P1GHL8xeaXDuo7
        2X96mUAI=; b=PWikUWM3nRrwrVKDkhGUG4yZLKM+qv3w0qRH8+aP7kRH0GCOXso
        x5/MwfoaRCPs+GSEE64L3II+XIY5u0api+BlU23UP7NEdV6YwrBxtpCVsmC7PwL8
        KIIPmUVDa2cSrq9xVNaQ0TFFMQthZJKbzSTTlhDnqH7FUDHRqjGv/TWO1+C3sTmK
        FqP6rOAiLT/xXWXU5ouibhWu0MPxHCYxjL9dZD1sILy9v11+udYxqTTSE5VBAV1a
        12CmZpql/aowC44Ikmdu0an3RYUFJT0OqcSE3h0WiKBBbJGOlYKnGNdYkGksQA2I
        HngjLuZ5SNSx9NzlPmqV7UG6JZyQuJCsQpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679148320; x=1679234720; bh=ne/ZkURyOBnvQZJfA/dZ5P1GHL8xeaXDuo7
        2X96mUAI=; b=n2roBARfoflGRnl+aYU+hQ9zC7+YjssGLD9gcVAxfhISvUNwI9P
        0R9Smd4ErRI5sWHRgsQQgg4Zm9leBCSlOI6bnCAKJQtT1mzT0wn8aOgx5JJj/nSS
        cMPq5Xm4hDIxWL/XYk/kx8nxSO18g3WRLDKGjC6ntxJp0s1aL6YzZKOdikFLOHI6
        ADKeoHSpJo/IAlDsXfiQxzVxt9o0faH+FqlWJq7D6A9p4FOdKzX1+O8msnJNk9Ho
        +c9xndLcxLIrcI8AeercVpKUrL819JfskKtE+2UYbfu8wM98BtYaH84Vg8iBwPqQ
        UetYHJM07UueJI/UV1w1HhlOHW2SfGyM0Kg==
X-ME-Sender: <xms:H8UVZKO5hsePPBXygggc8Se1Mc17WDUEan853sWl8vGRPZWY1LuYbA>
    <xme:H8UVZI-YX8PoBNdK14Hb22aPkgbDV3OLFKKXnLRridBDQIB2JP2XD5aLC-Jap7Jlx
    MGPCEIdOgpOX72RHEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:H8UVZBTH-K8trWBZHXlwQI6WJ_h5tYCXamdoN-EXBElRubJRjCZcRQ>
    <xmx:H8UVZKsnHJMHCk7mQgtMJfnf3oyTFZfAOnXSTJf_Oqq9G5jzuz6JLQ>
    <xmx:H8UVZCdKiAaM_7T-eIkluqlpzhN5E81HI07nO5mU73A9Wpm3R7zvpA>
    <xmx:IMUVZI22ozlqtFOxaEyopgNB_2_sLPE_g6q-hUAUMIdAb3vD5FLm4Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A542B60086; Sat, 18 Mar 2023 10:05:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <12298b67-3012-4902-9dcc-61c3c9907a47@app.fastmail.com>
In-Reply-To: <7cc8258c-3a77-5387-aaa4-658761fbb0ae@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
 <7cc8258c-3a77-5387-aaa4-658761fbb0ae@gmail.com>
Date:   Sat, 18 Mar 2023 15:04:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023, at 14:17, Jacky Huang wrote:
> On 2023/3/16 =E4=B8=8B=E5=8D=88 10:17, Arnd Bergmann wrote:
>> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>>> +	mem: memory@80000000 {
>>> +		device_type =3D "memory";
>>> +		reg =3D <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
>>> +	};
>>> +};
>> In most machines, the memory size is detected by the boot loader
>> and filled in the dtb in memory before starting the kernel, so
>> you should not need two separate files here for the two common
>> memory configurations.
>
>
> On ma35d1, memory size is determined early before uboot.
>
> BL1 (MaskROM boot code) -> BL2 (arm-trust-firmware) -> BL32 (op-tee) &=20
> BL33 (uboot).
> The DDR was initialized in BL2 stage with a selected DDR setting, which
> is hard coded, including DDR size.
>
> We searched the arm64 dts and found that almost all vendors claimed
> memory size in board level dtsi/dts. This seems to be common.
>
> So, can we have it unchanged?

I see the memory size encoded in about one out of three .dts files,
which is more than I expected. It's clearly not harmful to have it
listed in the dts, it just shouldn't be necessary.

If it helps you with your current u-boot, then leave it in, but
consider adding detection logic into u-boot so it can override
the value in the dtb file at boot time.

>> Since the machine is called 'som', I would assume that this is a
>> module that is integrated on another board, so more commonly one
>> would have a dtsi file for the som in addition to the one for the
>> soc, and have all the components of the module listed in this
>> file, while the dts file that includes the som.dtsi lists the
>> devices on the carrier board and enables the on-chip devices
>> that are connected to the outside.
>>
>
> You are right, ma35d1 som have a base board, and a cpu board on it.
>
> It is a good suggestion that we should have a dtsi for som base board.
>
> Consider that we are in the initial submit, and such a dtsi will be an=
 empty
> file at this stage. So, I would like to do it when peripheral drivers
> upstream started. Is it ok?

It's not a big deal either way. I if you want to keep it only with
one dts file and one dtsi file, that's fine, but maybe rename the dts
file based on the name of the carrier rather than the SoM in this
case.

     Arnd
