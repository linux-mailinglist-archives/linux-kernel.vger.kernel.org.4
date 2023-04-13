Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB9E6E0DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDMMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDMMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:52:37 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F67A5F7;
        Thu, 13 Apr 2023 05:52:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 5A7EC2B066F8;
        Thu, 13 Apr 2023 08:52:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 13 Apr 2023 08:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681390322; x=1681397522; bh=NR
        7qDHxvmrn4O6C7ghCGmkwcCMB9CqvbPSwmBqWhNIE=; b=ZXclSBnVVRa8vpoYG+
        Nh7NGI1Sfo/+IhOueSX6qtWqFgLpX1O7kGpe874+9lPVAkHB/MzUC6Ip3Qt5J4S1
        bo+Igz4vPJgrOb5hGwvGzYSyD9RAM686r7y8aQw66DlT4Mt340zXnCYSOX2rluiN
        l6kWpyNhBIXZQ/WjHlR82CZljPrL2zeVzs/VKz/0NnIUPr0YWmnDYjaoDj48NIs+
        UFfZMJaZFIZIs03gVqCq4iH3pg/lZtVMlR8XIkQ70K5m2tAxwHrPsotuz4IugI93
        6XX70k3nZhX+AhqXZznQyr38x7nSAEkpDTOnIVRV2ikChkz1k3AGDfv3Jf0wEK6q
        B4Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681390322; x=1681397522; bh=NR7qDHxvmrn4O
        6C7ghCGmkwcCMB9CqvbPSwmBqWhNIE=; b=gqOA+P8sXOuT1JOfKkqGPELz//AFF
        f2eiDN24y3pX47Aau9zsWL6E8P7Knx1xYRVsUHNfPuY3xLBDKbzMqkoi7VrJfZ+o
        W2mfsUlFecf2kgDULdtR2hU7Te44ccwG0sZJJ62Vj9KlDW/g2YbNj73dSar7sZor
        Lalym6dR+k04Z8y/YiYW1TKtaKYCSHw8QkHRYjo8Tdd4ZZV+YIE/S2VHOdNo6IMp
        Z1kBRS94su8sb72OzoxxZQuCPo8irGFKsthakuC3qSU4fnAaIq/6lBOlIe4lj5le
        uqmU2YzZXlg34GD8AxHkIBUzub0qWgTia98RBKzwE2Iz+p4RVnYEoo8Ig==
X-ME-Sender: <xms:8fo3ZIGGcweoBIf29WNloFKKsICMp7uD7W3WGDtwvAzEbureoRK3kQ>
    <xme:8fo3ZBVH6htlD2rv7m0KIlRDqt5H_xpJqhWk8H5XXhJ6hTi8Y46KqzYekT6ZEcvP-
    iySV_XAsUXsef2fpLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8fo3ZCJ6WRNY0qBjN-s19TED1hDYTi9JrZ1EWdX72x5Uz5tiomDupw>
    <xmx:8fo3ZKH4DvlQ_zzGPiQu2mlSLPVJsJocFs7o5u97ykj5S3RFQKqVIQ>
    <xmx:8fo3ZOVGcI2r7KyDnkTbNlptbOhRxQn3piCwIrpYa2EmmVt1L7apJg>
    <xmx:8vo3ZLLx-tSRguyqR96OdIBkL35NPK3OPhvrjBvWAq6rBkTuILKinq3Ygk0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A89EB60086; Thu, 13 Apr 2023 08:52:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <66899d69-1339-4a61-8612-6f8e452b0b26@app.fastmail.com>
In-Reply-To: <OS0PR01MB5922EDAFCD6DA0313DB99C5E86989@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-22-arnd@kernel.org>
 <OS0PR01MB5922EDAFCD6DA0313DB99C5E86989@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Date:   Thu, 13 Apr 2023 14:51:40 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
        "Brian Cain" <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 21/21] dma-mapping: replace custom code with generic implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023, at 14:13, Biju Das wrote:
> Hi all,
>
> FYI, this patch breaks on RZ/G2L SMARC EVK board and Arnd will send V2 
> for fixing this issue.
>
> [10:53] <biju> [    3.384408] Unable to handle kernel paging request at 
> virtual address 000000004afb0080

Right, sorry about this, I accidentally removed the 'phys_to_virt()'
conversion on arm64.

     Arnd
