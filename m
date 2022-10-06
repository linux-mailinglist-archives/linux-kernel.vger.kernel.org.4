Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A865F610D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJFGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJFGay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:30:54 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1B3AE51
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665037853; x=1696573853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x7kTAo4qP3/SnUW9k2mZ8CbPne03lLNrJUiyWWlRBzs=;
  b=OXXDmLEZ/p+4GckVYnLrLW5c8Gyai9jeFfDOMmSXZWhRL80/pw7/rLaS
   37HaQIBX/4C9fUoK3d37AZGOzfSVSbne0hzIZh28hcIvnJqLJSz2KYsz7
   0RDC03BWRFad8IjjDQJawaRAuapMK84XvKTTAV22s8SCoedW0sxpewDN5
   xO267QBk7YVxTjF4J95SfyG9hs8B4OMyYP3dpxhmDPe8ZxKRwG3i+7V46
   bWdWz/w0vlGDsgzwlwvzcUug3sBd5dCil0fos15Oy7vXy8Lr1xzwkvnKm
   AT+ZMv3umd9CVz+CyAxuw3nzaITDyRxK8agFXyNxQBeVNpm1Q/yMr4x/H
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="211457006"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 14:30:52 +0800
IronPort-SDR: +oXSmFXVtIBE6+8qjMgZ6BEZDHeHzN74NH2zhVaaMsUrMMA2fbcznPgQg/a5K5B7Bynwzzq85z
 gWjKDMyZmLNYK2/qyMYGpMl10WacxrzSuPmvufTGr1dgxQnIvdKSlKoBFLC4/LkQ34QrB+5aKB
 XhhnsqjM8plV0yc35Kcbnopre9DxzjnDmuSmwlEi8MFbCXaJNSZtww0AaNAMsiSfpX8tVn9kJw
 iIIZKZyX+4YnpTBkB9zqqtpwDwgHSUMn/LagpH23ayQj0kQO8YiUqvMym0+9lTAscR/MaYsjlr
 NOwolvYK/E4NY16s0CfoieW9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 22:45:03 -0700
IronPort-SDR: E4OjPmQwaB01+ppkRq3W01q3wrjLBd8VwlK+76H8uV0LJEJqWS0OLLxYSeSkJobi/T+HTItedR
 P1OHZrWfq+Zn56jeuQoOQge6y+E3LZnWDCUpV7UBJU4S3l9xi4Xee0Mkvz4xO0jmcdp3CDBuIN
 qM7jkcP1ZY/TOj0kbAw9U0gztsDkiZP3txzioWKh+T6HHdSmCVu7Qp0PCzr7cmImDzsd5siked
 ZeknmClDoVImmMmKOdKdIXkEvj5k9tXqRbGpvf/Q79e9/Obe0BdIHh54Ea8JTs1O42tMPYbTLC
 WBw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 23:30:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjhQh0Z6rz1RvTr
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:30:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665037851; x=1667629852; bh=x7kTAo4qP3/SnUW9k2mZ8CbPne03lLNrJUi
        yWWlRBzs=; b=ozGb8CeM8yxm6fW3xag9MQAVtqvSsWoZjyAGS5zRcRTzurLYnXB
        H9G9p1p2w9KITvFSgnQ2IMJ0h+kME2E/4AELn4KY6SfxAsByDJYXr8Wg4HBA+d6/
        RuuxNEDOBXfQco2XhTntt6lqGhTHc0xbC6v9ERODNbtCLqgV+q8tph1rV2Gwi5dF
        bRkUSo8yC+0pDrnBJxedE1bbrLnmpJEG2gIIbhPsin5hHv2PwKFExnjTa8gOCp5T
        fU61UYxrsiWcfFx47M92xRPp1z46cQOPUk/ZFZka10A4wT45g56z8JuzHKErCdvN
        GjOvF+YmwvsDYIpYHcrjF4ETdYvSAd/c/Ug==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lv6Uk59ra8bn for <linux-kernel@vger.kernel.org>;
        Wed,  5 Oct 2022 23:30:51 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjhQg0DJxz1RvLy;
        Wed,  5 Oct 2022 23:30:50 -0700 (PDT)
Message-ID: <fcf05af6-fce0-0ac9-c4ff-7b8960bcacc6@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 15:30:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
 <60557988-a5e5-8c81-72f9-c0f3ab9ed573@opensource.wdc.com>
 <14fa0e63-1a43-6c80-5ffe-1c7100ed88ba@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <14fa0e63-1a43-6c80-5ffe-1c7100ed88ba@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 14:49, Christophe Leroy wrote:
>=20
>=20
> Le 06/10/2022 =C3=A0 07:45, Damien Le Moal a =C3=A9crit=C2=A0:
>> On 10/6/22 14:17, Christophe Leroy wrote:
>>> NO_IRQ is used to check the return of irq_of_parse_and_map().
>>>
>>> On some architecture NO_IRQ is 0, on other architectures it is -1.
>>>
>>> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
>>>
>>> So use 0 instead of using NO_IRQ.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>
>> Doesn't this need fixes and cc:stable tags ?
>=20
> I don't think so, because the only user of this driver is powerpc and=20
> powerpc has NO_IRQ set to 0.
>=20
> I'm sending this because I was to remove NO_IRQ in powerpc in a second =
step.

OK. Got it. So queuing this for 6.2 is OK ? Or do you prefer seeing this
as a "fix" in 6.1 ?

>=20
>>
>>> ---
>>>   drivers/ata/pata_mpc52xx.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
>>> index 6559b606736d..3ebd6522a1fd 100644
>>> --- a/drivers/ata/pata_mpc52xx.c
>>> +++ b/drivers/ata/pata_mpc52xx.c
>>> @@ -731,7 +731,7 @@ static int mpc52xx_ata_probe(struct platform_devi=
ce *op)
>>>   		udma_mask =3D ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
>>>  =20
>>>   	ata_irq =3D irq_of_parse_and_map(op->dev.of_node, 0);
>>> -	if (ata_irq =3D=3D NO_IRQ) {
>>> +	if (!ata_irq) {
>>>   		dev_err(&op->dev, "error mapping irq\n");
>>>   		return -EINVAL;
>>>   	}

--=20
Damien Le Moal
Western Digital Research

