Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDF5B82E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiINI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiINI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:26:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874E6525D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663144007; x=1694680007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RJasnKN4AtekG0e84CcrCtN7mNyviZ5IxOBZ9H57Yko=;
  b=C3Mvafy4fIidIF1cwKjsl8abOCjEVoMCU6J/aSs6hbdWPl+mDSc9Saav
   HKcCrIk0H+2ljQiHxVZ/cP0A938fL4sRgLukutpeQhe0Hm6OZBiAlDTby
   U7Vw7B4Nn56E2e1lfQRWdukeMhXr5BZzwm3CLBtuD2GD1XxjNh9Sm3n1t
   FJvo/I8eoNayASDr/ONjYV57f4aT8shZEAMuaLThkq+ra7e0UCqvjATaA
   iqlbQCRB4oxBFqGOnpEx1C+lwfvdBo3c07OB1c+xrFR6T4hw3Eb8uVmAQ
   kwCUI6up17x6gOuqg9iRvVEFqmxHXWO8loYSPm5kA1ZI6URpam9/TqLGU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654531200"; 
   d="scan'208";a="211308800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2022 16:26:45 +0800
IronPort-SDR: oRJaH0H/AD77XK5v5nND6lPO2SoQxSNqpdK4lwvmM84sEclWhcuje+yzgrY5RqtDhRJiKO52Vi
 9bHPqGI5MEswdlHBMjddhZJ9IzHGjYrHW90t7ncN4m73us5C/EM223I3ReoRXJFJyjaQiBjKlP
 MfpPKIo78DAjexOqtOshX9znmP+XKn7DvKn1uKK1TUDeu2bNITQMj/m6gpTvuwz/ySgYA2x+ru
 dNhAvR2kk6xL+cNQ+gHTHfqXcRhNwCvnTcQaao3LdMMsNQEc3YW9403lH5gLV22vOvTe27Z1ME
 YzhVdtgr2fOKZB1FDjpAa3q5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2022 00:41:31 -0700
IronPort-SDR: H7VXO/1bDs7nJMvtjTVxb6V8Yq23j5zlsgjGJHe5D7lea1cmhu0FBv4piR4lToOMHRCyxXUKVi
 6cgNKOsrBsWZuVsxt/krL1jzz3eZHSkQ5AOLsRdoYwZwFfSjVVKGWL/eSKLgSBIw/33jf8h9lM
 mjgKHsT6UOm6HeTwBGAP7nmCjDApNEgAZ9Rr6BiqZgI4WGnu8x4qpOx2jx4L6fAq+JjcJFhWfg
 pMfR7O6BmeqsR4KeVW2wETIVqJ4Kz5HWnYMAn9WbO8MZPip4y134A0OI7A0xlNGO3zxjRpD3sD
 gE4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2022 01:26:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MSD2X6jR1z1Rwt8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:26:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663144004; x=1665736005; bh=RJasnKN4AtekG0e84CcrCtN7mNyviZ5IxOB
        Z9H57Yko=; b=MpdAg3XTmwqZojJ77pIHJ79RsChaErgzrD62Ndby1qVqZvCqfeW
        kF5GduMTaB7sx2+8OFwsH2NY/bkJg0T1tCGsNZsyQKWgq8QP84pAhbk9F508rXr4
        keCJOgy/q3V7sK8B2pLtjgtbqgzl/qv9w92xtAueBYhCCKOj6M4x7KdaEmZsH/6o
        2hsraGocKXym4xMmkPR9hsfg/xuHtEdMrfP/SSVeQC3+rMc/6Oz7iI+HEuk3k8iz
        NScMpOuy4gSZfC0JdLmzuSEmM8hFohULnZ5VAWXCe12qCExpkblNQi8WQJhIate9
        sHV2PPH5G22q5S2iJQihZhP1Se7RFnlacJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bL5DH_rgvF63 for <linux-kernel@vger.kernel.org>;
        Wed, 14 Sep 2022 01:26:44 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MSD2W0tTYz1RvLy;
        Wed, 14 Sep 2022 01:26:42 -0700 (PDT)
Message-ID: <fa09ed5b-9c56-267e-6d13-0e020b8887e4@opensource.wdc.com>
Date:   Wed, 14 Sep 2022 09:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
 <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
 <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
 <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
 <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
 <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
 <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
 <893fe832-d522-112e-53ec-0f030c15af0d@molgen.mpg.de>
 <318b0452-9814-6276-95a5-10478e5a1b7d@opensource.wdc.com>
 <178704d0-b5fd-f750-b77e-fece6c6d81dd@molgen.mpg.de>
 <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/13 16:28, Limonciello, Mario wrote:
> [Public]
>=20
>=20
>=20
>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Tuesday, September 13, 2022 10:23
>> To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Hans de Goede
>> <hdegoede@redhat.com>; linux-ide@vger.kernel.org; LKML <linux-
>> kernel@vger.kernel.org>
>> Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for =
AMD 300
>> Series Chipset SATA Controller
>>
>> Dear Damien,
>>
>>
>> Am 01.09.22 um 00:13 schrieb Damien Le Moal:
>>> On 8/30/22 18:05, Paul Menzel wrote:
>>
>> [=E2=80=A6]
>>
>>>> Am 01.06.22 um 10:58 schrieb Damien Le Moal:
>>>>> On 6/1/22 01:18, Paul Menzel wrote:
>>>>>>>>> With that in mind, I am not planning to apply your previous pat=
ches
>>>>>>>>> for 5.18, as they would conflict and would only end up being ch=
urn
>>>>>>>>> since the delay removal by default will undo your changes.
>>>>>>>> Obviously, I do not agree, as this would give the a little bit m=
ore
>>>>>>>> testing already, if changing the default is a good idea. Also, i=
f the
>>>>>>>> conflict will be hard to resolve, I happily do it (the patches c=
ould
>>>>>>>> even be reverted on top =E2=80=93 git commits are cheap and easy=
 to handle).
>>>>>>>
>>>>>>> The conflict is not hard to resolve. The point is that my patches=
 changing
>>>>>>> the default to no debounce delay completely remove the changes of=
 your
>>>>>>> patch to do the same for one or some adapters. So adding your pat=
ches
>> now
>>>>>>> and then my patches on top does not make much sense at all.
>>>>>>>
>>>>>>> If too many problems show up and I end up reverting/removing the
>> patches,
>>>>>>> then I will be happy to take your patches for the adapter you tes=
ted. Note
>>>>>>> that *all* the machines I have tested so far are OK without a deb=
ounce
>>>>>>> delay too. So we could add them too... And endup with a long list=
 of
>>>>>>> adapters that use the default ahci driver without debounce delay.=
 The
>> goal
>>>>>>> of changing the default to no delay is to avoid that. So far, the=
 adapters
>>>>>>> I have identified that need the delay have their own declaration,=
 so we
>>>>>>> only need to add a flag there. Simpler change that listing up ada=
pters
>>>>>>> that are OK without the delay.
>>>>>>>
>>>>>>>> Anyway, I wrote my piece, but you are the maintainer, so it=E2=80=
=99s your call
>>>>>>>> and I stop bothering you.
>>>>>>
>>>>>> I just wanted to inquire about the status of your changes? I do no=
t find
>>>>>> them in your `for-5.19` branch. As they should be tested in linux-=
next
>>>>>> before the merge window opens, if these are not ready yet, could y=
ou
>>>>>> please apply my (tested) patches?
>>>>>
>>>>> I could, but 5.19 now has an updated libata.force kernel parameter =
that
>>>>> allows one to disable the debounce delay for a particular port or f=
or all
>>>>> ports of an adapter. See libata.force=3Dx.y:nodbdelay for a port y =
of
>>>>> adapter x or libata.force=3Dx:nodbdelay for all ports of adapter x.
>>>>
>>>> This is commit 3af9ca4d341d (ata: libata-core: Improve link flags fo=
rced
>>>> settings) [1]. Thank you, this is really useful, but easily overlook=
ed. ;-)
>>>>
>>>>> I still plan to revisit the arbitrary link debounce timers but I pr=
efer to
>>>>> have the power management cleanup applied first. The reason is that=
 link
>>>>> debounce depends on PHY readiness, which itself depends heavily on =
power
>>>>> mode transitions. My plan is to get this done during this cycle for
>>>>> release with 5.20 and then fix on top the arbitrary delays for 5.21=
.
>>>>
>>>> Nice. Can you share the current status?
>>>
>>> No progress. I need to put together a series with all the patches tha=
t
>>> were sent already. Unless Mario can resend something ?
>>
>> No reply from Mario.
>=20
> I think what happened here is there was related patches from another pa=
rty
> that got tangled up with this.

Yes, patches from Runa touch the same area. We need to put everything tog=
ether i
a nice series. Will try to do so, but busy this week and next (Plumbers a=
nd
vacation). If you can Mario, that would be welcome too :)



--=20
Damien Le Moal
Western Digital Research

