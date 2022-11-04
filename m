Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21F61A2F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKDVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKDVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:13:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EE49B6B;
        Fri,  4 Nov 2022 14:13:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 629EA5C01BC;
        Fri,  4 Nov 2022 17:13:12 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Fri, 04 Nov 2022 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667596392; x=1667682792; bh=Sk
        nWElFGQrKj2Y6Gc1B4daARkHu6ii7Foz6LPOLkcCo=; b=JsRuJ4qyv1Dlri29Ns
        ZikS/SX8AInhIfQPwYQLKs1QloAzvV1ehsAVWhe13TnUoltE2SXtKdxM4XBFpzSE
        TjUpCygYa1/mLn9P3Njmom7B45JhjXR++2dXcXZB7a2A70oOolwEdVGq1A7i5eHs
        B2ip3eX+AOmSGlKwdzF9x9xAK6VXsNK+j+onoO8pCbg73WGzcna1V3qpxKEHdYH5
        QRW5uyOFJZBmtozom8eCSV3Umy5SKt79avYB57FVRZyhSsxoi6vv0RxhUuNFxP9N
        3UTjdV3i5ZL0UBrcBsw704jwj0RO4MHadMbfvuyU2n3ehH9FWOLDFFtrDEPSBshU
        OgHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667596392; x=1667682792; bh=SknWElFGQrKj2Y6Gc1B4daARkHu6
        ii7Foz6LPOLkcCo=; b=Uqdhlz37yxzJsJvmL+FdlJQV6D/jKGk9ZxGyv0oYqOPb
        smiv5AwpwtsUAL33qkppwwDexDUj7/aEOs/raWubncVM0+BtNfpKmVCNRHjtU7Gq
        HgkANEV+sP6peIc2reBVe9GAfaKuR3dZi4D0X0QGHxC+fOdgwhLcM7sD8bIfcWa1
        V8ZckkiWSJ/zyQKbmBsziW5p1ee7aihigiNyt3+XLhM3aX2N0+QKjdcYuqZmV3IV
        ThJOM0APzQpCtTrKmanUw9ZRxg0iIxPma79lvGDf1xRtHPFUdNMzxzX1cWC30nqq
        IcAnOuGGD+RwkvBpQb3yywv034gudemwpZ9E55Ss8g==
X-ME-Sender: <xms:Z4BlYwMhipq2foxBgotckdCjfG1OtZq9jLxhZRMemN1qIMnk9ySCrw>
    <xme:Z4BlY2_cMjeHo9DwukAf4Te6NjD95Jg_cKguoxueVn9_xb2cACF9MePbGO_w6MxVQ
    -8B_OB4gGZ7Ip55yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsth
    hmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeekfefhgfdutdeggeejtdev
    tddvvdekvedvheefheeijefhhffhjeekjefgleevgeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssehjohhhnhhthhhomhhsohhn
    rdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:Z4BlY3TtZ6ITB3Kc_OWwP9JgOB9wIXQoLeZMxwY7ECtbP-T4dYE_Zg>
    <xmx:Z4BlY4u-aUlE6f4VXh9LQCidiSzd1P-tUwqkF2QIdYP14E9L5zfxrw>
    <xmx:Z4BlY4fHnrE67TRN7r0kyta9t1S-I7TACB5dTcolUwB0MKr7Z-OBMg>
    <xmx:aIBlYw7tglr-LqzNMz5lgGJgDNpF-Pfpifb-ycdI-ekqjCHMoMIBYw>
Feedback-ID: ia7894244:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C489B2A20080; Fri,  4 Nov 2022 17:13:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <a828cd9a-4fb2-4cb1-b5a4-7506da10f5dd@app.fastmail.com>
In-Reply-To: <CAMhs-H-Eo0ELMpy0iPakTA-3nHdY_mYQG-rrqgSotBKKED=eOg@mail.gmail.com>
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
 <20221103050538.1930758-4-git@johnthomson.fastmail.com.au>
 <26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com>
 <CAMhs-H9VW=6fPNAjBukmBkFFnLYCekE_QJV_ewE_H1vOGrb+Xw@mail.gmail.com>
 <CAMhs-H-Eo0ELMpy0iPakTA-3nHdY_mYQG-rrqgSotBKKED=eOg@mail.gmail.com>
Date:   Fri, 04 Nov 2022 21:12:27 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Sergio Paracuellos" <sergio.paracuellos@gmail.com>
Cc:     =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        "John Crispin" <john@phrozen.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mips: ralink: mt7621: do not use kzalloc too early
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022, at 12:29, Sergio Paracuellos wrote:

> I have verified with 6.1.0-rc1 system does not boot as you was pointed out here.
> After adding your patches the system boots and got an Oops because
> soc_device_match_attr:
>
> [   20.569959] CPU 0 Unable to handle kernel paging request at virtual
> address 675f6b6c, epc == 80403dec, ra == 804ae11c
> [   20.591060] Oops[#1]:
> [   20.595462] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1+ #148
> [   20.608265] $ 0   : 00000000 00000001 82262a00 00000000
> [   20.618615] $ 4   : 675f6b6c 808dea04 00000000 804ae138
> [   20.628983] $ 8   : 00000000 808787ba 00000000 821f4b00
> [   20.639351] $12   : 0000005b 0000005d 0000002d 0000005c
> [   20.649735] $16   : 82253580 807b4034 807b4034 804ae138
> [   20.660087] $20   : fffffff4 82c382b8 809e1094 00000008
> [   20.670455] $24   : 0000002a 0000003f
> [   20.680823] $28   : 82050000 82051c30 80a0d638 804ae11c
> [   20.691190] Hi    : 00000037
> [   20.696891] Lo    : 5c28f6a0
> [   20.702610] epc   : 80403dec glob_match+0x1c/0x240
> [   20.712100] ra    : 804ae11c soc_device_match_attr+0xac/0xc8
> [   20.723330] Status: 11000403 KERNEL EXL IE
> [   20.731626] Cause : 40800008 (ExcCode 02)
> [   20.739576] BadVA : 675f6b6c
> [   20.745277] PrId  : 0001992f (MIPS 1004Kc)
> [   20.753414] Modules linked in:
> [   20.759448] Process swapper/0 (pid: 1, threadinfo=(ptrval),
> task=(ptrval), tls=00000000)
> [   20.775520] Stack : fffffff4 80496ab8 820c6010 828c8518 80950000
> ffffffea 80950000 80496b48
> [   20.792106]         00000000 828c8400 820c6010 821f4880 1e160000
> 821bc754 82253734 7f8268e6
> [   20.808707]         809c6a94 807b4034 804ae138 809c8e88 819a0000
> 804ae1d8 80a0d638 80438e10
> [   20.825282]         821f3e70 80950000 808c0000 828c8400 820c6000
> 828c8548 820c6010 80456608
> [   20.841879]         821f3dc0 821d32c0 819a0000 801d8768 821f3dc0
> 821d32c0 828c8540 80950000
> [   20.858473]         ...
> [   20.863298] Call Trace:
> [   20.868137] [<80403dec>] glob_match+0x1c/0x240
> [   20.876955] [<804ae11c>] soc_device_match_attr+0xac/0xc8
> [   20.887500] [<80496b48>] bus_for_each_dev+0x7c/0xc0
> [   20.897176] [<804ae1d8>] soc_device_match+0x98/0xc8
> [   20.906869] [<80456608>] mt7621_pcie_probe+0x90/0x7b8
> [   20.916876] [<8049b46c>] platform_probe+0x54/0x94
> [   20.926206] [<80499058>] really_probe+0x200/0x434
> [   20.935538] [<80499520>] driver_probe_device+0x44/0xd4
> [   20.945732] [<80499ae0>] __driver_attach+0xb8/0x1b0
> [   20.955428] [<80496b48>] bus_for_each_dev+0x7c/0xc0
> [   20.965089] [<80497f18>] bus_add_driver+0x100/0x218
> [   20.974763] [<8049a338>] driver_register+0xd0/0x118
> [   20.984438] [<80001590>] do_one_initcall+0x8c/0x28c
> [   20.994115] [<809e21c8>] kernel_init_freeable+0x254/0x28c
> [   21.004845] [<80781070>] kernel_init+0x24/0x118
> [   21.013830] [<800034f8>] ret_from_kernel_thread+0x14/0x1c
> [   21.024522]
> [   21.027457] Code: 240f005c  2418002a  2419003f <80820000> 24a90001
> 90a70000  104c006f  24860001  2843005c
> [   21.046810]
> [   21.049830] ---[ end trace 0000000000000000 ]---
> [   21.058935] Kernel panic - not syncing: Fatal exception
> [   21.069310] Rebooting in 1 seconds..
>
> I have fixed this adding two sentinels in the following files:
>
> drivers/pci/controller/pcie-mt7621.c
> drivers/phy/ralink/phy-mt7621-pci.c
>
> sergio@camaron:~/GNUBEE-SERGIO-TEST/linux$ git diff
> drivers/pci/controller/pcie-mt7621.c
> drivers/phy/ralink/phy-mt7621-pci.c
> diff --git a/drivers/pci/controller/pcie-mt7621.c
> b/drivers/pci/controller/pcie-mt7621.c
> index 4bd1abf26008..ee7aad09d627 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct
> pci_host_bridge *host)
>  }
>
>  static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
> -       { .soc_id = "mt7621", .revision = "E2" }
> +       { .soc_id = "mt7621", .revision = "E2" },
> +       { /* sentinel */ }
>  };
>
>  static int mt7621_pcie_probe(struct platform_device *pdev)
> diff --git a/drivers/phy/ralink/phy-mt7621-pci.c
> b/drivers/phy/ralink/phy-mt7621-pci.c
> index 5e6530f545b5..85888ab2d307 100644
> --- a/drivers/phy/ralink/phy-mt7621-pci.c
> +++ b/drivers/phy/ralink/phy-mt7621-pci.c
> @@ -280,7 +280,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct
> device *dev,
>  }
>
>  static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
> -       { .soc_id = "mt7621", .revision = "E2" }
> +       { .soc_id = "mt7621", .revision = "E2" },
> +       { /* sentinel */ }
>  };
>
>  static const struct regmap_config mt7621_pci_phy_regmap_config = {
>
> With this two minor changes and your patches the system properly boots
> and behaves properly.

Thank you for finding time, and testing and verifying this.

>
> So FWIW feel free to add my:
>
> Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Acked-by:  Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Please, let me know if you want me to send any patches or if you are
> going to create a complete patchset with all the needed changes.

I sent in these two patches with Fixes tags, and some queries about getting
those pci & phy changes in before this fix, and also possibly in the 5.10 and 5.15 stable trees,
in case we want this kzalloc change too early backported as well? Please let me know what you think.

>
> Thank you very much for doing this!
>
> Best regards,
>     Sergio Paracuellos
>
> [snip]

Some more queries here:
I should add a note in this commit message that this boot failure only happens with CONFIG_SLUB=y
Fixes reference or not?
Fixes 71b9b5e0130d ("MIPS: ralink: mt7621: introduce 'soc_device' initialization")
I used device_initcall, but postcore_initcall also works fine, and I am not sure of the difference here.


Cheers,
-- 
  John Thomson
