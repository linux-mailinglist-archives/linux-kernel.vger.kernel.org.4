Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A85B3660
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIILb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIILb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:31:26 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFEC12D566;
        Fri,  9 Sep 2022 04:31:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 028BB2B059B4;
        Fri,  9 Sep 2022 07:31:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 09 Sep 2022 07:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662723083; x=
        1662726683; bh=5R1+DzB9xgEFDOh7VH5ISCJa4USSB/0TKRv6qwq5aCg=; b=T
        Tf1IDbyUmCDbKUYkNGUms/JSr9K9APixQZoocBSfKXoWdTOvLONAqVJBeuvTpVPj
        604W5qI94BbXj1Qz+1XTDidt1AkjeT2BXZ8jHVPdXopgkkNgCR/2Jx5HFqEgI8Tb
        IDAYBYybd1fzdXaPVBQ3bioIOLraspTk2Qft65sYJ7teAOlVZ0moAWJAW346m9qR
        I5rMMIANdDLC/Br0cjaOmvzbIKIZyKwkC/sDQUO7GlhZ/ARtIZinMegR6caxCmqS
        nFVfhY0PkPsFUpc2BlkBfCi129QPzCZu77bhT8EvV8sqj1yHN0ey4afUqq7We6VJ
        9oxcUHdZ/Rp0KIgjoeHIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662723083; x=
        1662726683; bh=5R1+DzB9xgEFDOh7VH5ISCJa4USSB/0TKRv6qwq5aCg=; b=k
        BuWlqU4+q+x1e4kqx4F8sfl/YuKcSk/mo7hxja6co+MKhQj8QNQDDF7SiZC5A15S
        J8E8hetQXvn7TonIzmkGjzjIcmjHmB19iYABEtxzSb4Tfo6050H8PnQbq8s4lyT5
        LdASqRqL5es8J0Uwktw+DFUlNOzivrLTBXodYG6fo+Q4m4rt4hCB+IVnVnBlUxdj
        V0m8rAB7pYYz74l/zfJItCwQZa8HXlrhXamnqY2j/lvz9IoX5FpYmRc4ms1TkWHE
        dPQXDC7k40lhSPOs6IcGwmPw18+BlSuModslE1kDDUkYRnXAdg+ZlHm4A9HWg1hg
        auXEweyXhmTgBj5TNy7pQ==
X-ME-Sender: <xms:CiQbYyE4J5hpWHgf1_d67VINqIJPxK5JXcvFaZK3KVs0RgoyDkDo-Q>
    <xme:CiQbYzWogqknTkRAWUzlAYTAzeno3C6_uxPHND4zx-ezsNig4m9dUku-kkLQw6Diz
    zGhhGFqYiplR_pAuOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CiQbY8KU_Y2bpM4TB3y0WKTLRv0dy0UpHIoCwCU4J1BDc8UlZ4hoiA>
    <xmx:CiQbY8EOWuyo7qH68WnYe1-9KRowyJVYkmA2hUFeq1k4EUffS1KYgg>
    <xmx:CiQbY4Vyyb-4p3Odiat9bBlvEGl8Pzz8ZjArhvwdDw8XkPDuGhHDsw>
    <xmx:CyQbY6LnxmpSbZxx0KpifBzD9yUE_hMgWUYe1Ya5eqwTZZgzROA-eIoxEE0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D99EBB60086; Fri,  9 Sep 2022 07:31:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com>
In-Reply-To: <2379456e-4f18-d619-10bf-022327de0463@csgroup.eu>
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
 <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
 <2379456e-4f18-d619-10bf-022327de0463@csgroup.eu>
Date:   Fri, 09 Sep 2022 13:31:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of creating a
 PPC dependency
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022, at 1:19 PM, Christophe Leroy wrote:
> Le 09/09/2022 =C3=A0 13:09, Arnd Bergmann a =C3=A9crit=C2=A0:
>> On Fri, Sep 9, 2022, at 11:03 AM, Lukas Bulwahn wrote:
>>=20
>> I don't see a single powerpc machine that creates a
>>   name=3D"pata_platform" platform_device. I suspect this was
>> only needed bwfore 2007 commit 9cd55be4d223 ("[POWERPC] pasemi:
>> Move electra-ide to pata_of_platform"), so the "|| PPC"
>> bit should just get removed without adding the HAVE_PATA_PLATFORM
>> bit.
>
> But that was added in 2008 by commit 61f7162117d4 ("libata:=20
> pata_of_platform: OF-Platform PATA device driver")

Ah, I see. In that case, I think we should probably just always
allow PATA_OF_PLATFORM to be enabled regardless of
HAVE_PATA_PLATFORM, something like

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c9f4fb2595d..c93d97455744 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1102,8 +1102,7 @@ config PATA_PCMCIA
 	  If unsure, say N.
=20
 config PATA_PLATFORM
-	tristate "Generic platform device PATA support"
-	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
+	tristate "Generic platform device PATA support" if EXPERT || HAVE_PATA=
_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
@@ -1112,7 +1111,8 @@ config PATA_PLATFORM
=20
 config PATA_OF_PLATFORM
 	tristate "OpenFirmware platform device PATA support"
-	depends on PATA_PLATFORM && OF
+	depends on OF
+	select PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems with OpenFirmware

and then also drop the "select HAVE_PATA_PLATFORM" from
arm64 and arm/versatile.

Or we can go one step further, and either split out the
'pata_platform_driver' into a separate file from
'__pata_platform_probe', or merge pata_of_platform.c
back into pata_platform.c.

      Arnd
