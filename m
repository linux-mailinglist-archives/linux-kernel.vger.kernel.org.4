Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1965B4E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIKLzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIKLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:54:57 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB301276E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662897295; x=1694433295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nEn8hKjiKoJTls+Eq+dMQFIVcEgOZT1PN3pCw0YzqBA=;
  b=L76eqDwiwOnZyiWUmtldwL7YjdTvkIJsU/oxCl0sQSZI99muhuIPCmaJ
   9tzEVQfaWy4PnBNK8E5BoNy1RDGVkHnyuw3L7M1zmAp9piZKkswGUOgYo
   nGMhTmU0RoUL1Ykey+dyDHBfDomxcq8ALuFHYAjPZ1a+1b2XNLMfjIXaD
   MhkWXVYGoxkh8gdpm0qly/EeEEjaWogP6FqyKFFN1YAd0ORua1UDW+vSr
   EdlY6xEB5ZyRPW/sOixuufwrbXc+8bd/5/timfePz0//XT8MTRPsn8ie3
   dJuanIFhvV58XGxOmC5u8t7Woq/oIRb3lVVV+x5+wLDrHScjXI2I10V57
   g==;
X-IronPort-AV: E=Sophos;i="5.93,307,1654531200"; 
   d="scan'208";a="211518608"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2022 19:54:53 +0800
IronPort-SDR: hTkFQDrU1o7RwuYb1Sl6dtiKoc3Z5YXbX6oKPJliRnagFIDQnh13fLJwLiGXlRcGfTfs0XSjO9
 fWJKoNxTw/iFzayQULXDiiOWqwCDphtgCeFoX+0fnLoueu5p98Y+tGCpMDVtY1Ebv9ztCoAsJm
 KJoE1FERUmbd58fYJvGcD+VHsAruAKrd+5wYhNjalKbD7cw2uEWlmEzdKaCWn+KssWFq+hVo57
 HdY1wfaciCE3hKlvjQm1GeOYTAFcheotr73W7I/CibyUYzb27HJGZcJxXgpTdUT4zUDsZAtEfX
 mx3KMYZ3nP/Z1sxagVXVlE5T
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2022 04:09:43 -0700
IronPort-SDR: 1mnUHHepEJLCFhb8lnxdId8plX1yCiq/hhjjVsCoheQF0c2Umr6xneRT5A5o81Vj2jhFSe+KZy
 PlvcysCHuBcIhDTGHvL9X9bjv5dyd29N9t2VpZWypCxpzWtonML2ns4IMUDQZ50VEsg9+yBaHl
 sy5cj+zrHGWKOZe37p/idBc2yrvrhoKgefeRBSNt8qEFC7BCPH7vkXRvkEzDYPbyg/aKBJCyld
 bTVVBmuvrMsBpc4vKSq7J0/1PoXoguPkzf9hH8HY0wgnukJVHukmJepAy80GGfFevvVUwoPHEN
 uLo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2022 04:54:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MQSp44rcRz1Rwtl
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:54:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662897291; x=1665489292; bh=nEn8hKjiKoJTls+Eq+dMQFIVcEgOZT1PN3p
        Cw0YzqBA=; b=b//d1NznLH7uqx+zxu1XKsgYvHK8cvddlO+X+BrUSrpC87lFG91
        d3Vpv+9exCjXUjTAyd427GRKpmiNPyT2b9ve5safOQicRcqnk8seOSfw0t5vEtEG
        uXzVFBxsWwS96iWcRmvCeD0eSxpQl3dz6I0l0JNgDulN1P1mneK+Tg87iEeoahbF
        E0ai0CUigyfjV+fLc8Dq5u6w7HkhzulnuoiqNxFeAyrRpWhxFJ1lbpw6WH0t9g36
        JRWFHb8gEZD/cyRGXAAGMtE9m0qpcNcteDCN8do3aa2CcnsazsuLPok4r5Iz1YQA
        iAE/27eukv59/gckzsodmDUuzxrZPBDt0EA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bQTHDmnOycZF for <linux-kernel@vger.kernel.org>;
        Sun, 11 Sep 2022 04:54:51 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MQSp04Wlsz1RvLy;
        Sun, 11 Sep 2022 04:54:48 -0700 (PDT)
Message-ID: <0ad5f339-de31-2849-34a1-928ae65cc696@opensource.wdc.com>
Date:   Sun, 11 Sep 2022 20:54:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of
 creating a PPC dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
 <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
 <2379456e-4f18-d619-10bf-022327de0463@csgroup.eu>
 <4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/09 20:31, Arnd Bergmann wrote:
> On Fri, Sep 9, 2022, at 1:19 PM, Christophe Leroy wrote:
>> Le 09/09/2022 =C3=A0 13:09, Arnd Bergmann a =C3=A9crit=C2=A0:
>>> On Fri, Sep 9, 2022, at 11:03 AM, Lukas Bulwahn wrote:
>>>
>>> I don't see a single powerpc machine that creates a
>>>   name=3D"pata_platform" platform_device. I suspect this was
>>> only needed bwfore 2007 commit 9cd55be4d223 ("[POWERPC] pasemi:
>>> Move electra-ide to pata_of_platform"), so the "|| PPC"
>>> bit should just get removed without adding the HAVE_PATA_PLATFORM
>>> bit.
>>
>> But that was added in 2008 by commit 61f7162117d4 ("libata:=20
>> pata_of_platform: OF-Platform PATA device driver")
>=20
> Ah, I see. In that case, I think we should probably just always
> allow PATA_OF_PLATFORM to be enabled regardless of
> HAVE_PATA_PLATFORM, something like
>=20
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 1c9f4fb2595d..c93d97455744 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1102,8 +1102,7 @@ config PATA_PCMCIA
>  	  If unsure, say N.
> =20
>  config PATA_PLATFORM
> -	tristate "Generic platform device PATA support"
> -	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
> +	tristate "Generic platform device PATA support" if EXPERT || HAVE_PAT=
A_PLATFORM

Shouldn't this be:

	tristate "Generic platform device PATA support" if EXPERT || PPC

?

And while at it, it would be nice to add "|| COMPILE_TEST" too.

>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems.
> @@ -1112,7 +1111,8 @@ config PATA_PLATFORM
> =20
>  config PATA_OF_PLATFORM
>  	tristate "OpenFirmware platform device PATA support"
> -	depends on PATA_PLATFORM && OF
> +	depends on OF
> +	select PATA_PLATFORM
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems with OpenFirmware
>=20
> and then also drop the "select HAVE_PATA_PLATFORM" from
> arm64 and arm/versatile.
>=20
> Or we can go one step further, and either split out the
> 'pata_platform_driver' into a separate file from
> '__pata_platform_probe', or merge pata_of_platform.c
> back into pata_platform.c.
>=20
>       Arnd

--=20
Damien Le Moal
Western Digital Research

