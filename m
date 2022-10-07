Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDE5F80D8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJGWlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJGWlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 18:41:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E277557
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665182466; x=1696718466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EjRssl1daDe09JoKN81W40Eva9O4vDDRqQJOMhoSowk=;
  b=LgyILYWyKX0Yejbk/BPN4OzCJ06GSaFYVy2E3XnCBTgW5sZOqXLfSbz2
   tVhCfF3caOLJTGfGMKfoxUQwrTfMnrnrZQb0ueRVEvWKpi3b+nY9L2NPb
   efPRw+qxs5wBJHy1CxWv7JlZo6dRsKvfl8YteE1bn+X8emMTrJ/FntKd8
   PNH67KCJFrJatM2yzBXA2FyaBH0+K43nXNxSIO9OomB2wtcT0UVA4J2O5
   hnCwfSsDUR13hXVD9NQl5TeGYe2Us4X3brjbu719aj9WjD7ShPtMlme/0
   0zQkYgWdlN1n+dvc207bqDYtUU6NPaISOy4rvMXv0mIP7KT/x8z8CA6BB
   g==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="211610068"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 06:41:04 +0800
IronPort-SDR: GDuoZWhKbVsOv0SGT27kvSWVAk9C87SL6veIIgCEeO185C4Zdsz2VL7YH5ATnFnfEVp+qUTRz8
 pb3CY3tMwLMZUEN/JMh42bKaCDbiTmQgbfPStoIz09F0zNYmFhNSqGYSN512scc9V/MbwVm7BD
 wSKIzxhPF++kDDsi62pFiAkaFELFtzLDFlIsU0e0nO4alcSeoN7i0KVGcoWG3UJOBj7apElZ2U
 Jmlv3ivplQvSdR2uPaQqwLSjbwVydk0q5t5SX5flZXZehY7InNhyflKo9DtP7XdvBmlGbtq4AW
 SymS9u+DjOx8SoLar7ayy/Em
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 14:55:13 -0700
IronPort-SDR: r7OKcVm9d1gnaF0d6eAgZXB6WJmwuyICFxXz2vkFe5EuM06ltlmKEdsCCE7wP1mxUq/bOeNKI1
 RdSNhgPeCmrQSagnpJmnyO89R4ifChUieLe/ZVO6bo4c4XKswcE90TbPUqtSorbvn8YmiAKWRH
 d/0sXjPD0+wmX7IfGj1Rv2Ct84o0Lj1XmCV6oHdfje+QmemnA+DNVqhlp1eZkKiUw2jsqTdhXl
 jMxH8O4Tk4IqePBW3dix8mPJlpgBicMh3DzsJYD+ZhaN7hI2a6C6Em+be1ZUUq124FiEQOnhJO
 Tzc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 15:41:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mkjvh0SsWz1RvTr
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 15:41:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665182463; x=1667774464; bh=EjRssl1daDe09JoKN81W40Eva9O4vDDRqQJ
        OMhoSowk=; b=RO5s+zASK0PXbEWTgJwhuwA9Yb6rxc0+6XDTWj0g8pCt2bFCUDh
        VNIiBZZOZ1nl/BNtNQhNJL1pnivfKKi8vza//46FTpy1+IKn7fyj8TKdJgAgY6Nm
        YO+Ri5i3b6lHO6/E9WmWCexoXW2fjJP1vFeoqDvGwhtF5wUPzvO5zpBxRztgwHO8
        VgGPLStSKNOhHzb1/5T7zzn9/rNc6UEySas4CGl3/8FB1HY1c/jJROjZqa7ENp8T
        CTTDAteZM1q2iTGX6fIU2QtLaxN/AXcwZD57YxHnFxBlK4ARyKK11/GBHJ43RhYI
        wHPso3tER7d4/xARGBEmB7efXNAdgPxhTxg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SEnzTiB5XX0g for <linux-kernel@vger.kernel.org>;
        Fri,  7 Oct 2022 15:41:03 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mkjvf6dDSz1RvLy;
        Fri,  7 Oct 2022 15:41:02 -0700 (PDT)
Message-ID: <cb78be0f-633c-29ee-a3c8-cc05d8108cf9@opensource.wdc.com>
Date:   Sat, 8 Oct 2022 07:41:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
 <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
 <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
 <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
 <7cf5744e-78ec-79c3-98af-2a716167ea1a@opensource.wdc.com>
 <31f8c4d1-1575-e64d-f42a-ce864e060975@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <31f8c4d1-1575-e64d-f42a-ce864e060975@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 23:14, Maciej S. Szmigiero wrote:
> On 7.10.2022 00:53, Damien Le Moal wrote:
>> On 10/7/22 07:20, Damien Le Moal wrote:
>>> On 10/6/22 22:06, Maciej S. Szmigiero wrote:
>>>> On 6.10.2022 01:38, Damien Le Moal wrote:
>>>>> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> Currently, if one wants to make use of FUA support in libata it is
>>>>>> necessary to provide an explicit kernel command line parameter in order to
>>>>>> enable it (for drives that report such support).
>>>>>>
>>>>>> In terms of Git archaeology: FUA support was enabled by default in early
>>>>>> libata versions but was disabled soon after.
>>>>>> Since then there were a few attempts to enable this support by default:
>>>>>> [1] (for NCQ drives only), [2] (for all drives).
>>>>>> However, the second change had to be reverted after a report came of
>>>>>> an incompatibility with the HDD in 2011 Mac Mini.
>>>>>>
>>>>>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>>>>>> flush for every request that have this flag set.
>>>>>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>>>>>> supports LBA48 and so these days should be pretty widespread let's provide
>>>>>> an ability to enable it by default in Kconfig.
>>>>>
>>>>> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
>>>>> I do not see the need to add yet another config option.
>>>>
>>>> A specific Kconfig option is more structured than a free-form
>>>> CONFIG_CMDLINE (which is also technically a per-arch option, but seems
>>>> to be widely supported across arches).
>>>>
>>>> That's why there is a lot (100+) of similar Kconfig default-changing
>>>> options, a quick sample of these (in no particular order):
>>>> SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
>>>> SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
>>>> SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
>>>> MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
>>>> DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...
>>>>
>>>> libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
>>>> so it's not like a person performing kernel configuration is
>>>> overloaded with questions here.
>>>>
>>>> But at the same time, I respect your decision as a maintainer of
>>>> this code.
>>>
>>> I am not dead set on pushing back on this, but as usual, whenever we can
>>> avoid adding config options, we should. Given that libata has had fua
>>> disabled forever, I am not convinced yet that there is a strong need for
>>> that new option. But if distros prefer the config option approach, we can
>>> make that happen.
>>>
>>> If anything, I would be tempted to switch fua support to on by default
>>> after some time if we do not get many reports of broken drives. You did
>>> mention that old mac minis drives did not like it, but these are not even
>>> blacklisted in libata-scsi. They should. Only one model of maxtor drives
>>> is. We should add an ATA_HORKAGE_NO_FUA flag and start a proper blacklist
>>> of drives not liking fua. Without that in place, switching to on by
>>> default as your config option allows could break many (old) systems.
>>
>> To be extra clear, I think that this fua module parameter is silly. If a
>> drive says it supports fua, we should use it and not have a global
>> parameter to disable it for all drives. So no config option needed for it.
>>
>> That is also why I am not keen on taking that config option. It is not
>> really improving anything at all and would prefer nuking the fua module
>> argument and have a proper blacklisting of buggy drives.
>>
>> But such a change is painful as we'll be able to update the blacklist with
>> users getting corrupted FSes on buggy drives. The time may have come to do
>> this change though as the number of buggy drives out there is hopefully
>> small enough now.
> 
> So your proposal is basically to switch the existing fua option default
> to "on" and deal with the fallout (hopefully minimal) by blacklisting
> misbehaving drives as they get reported, right?

Yes. The risk though is that if the fallout are not minimal and we get too
many bug reports, we'll likely have to revert. So this needs to be
attempted early at the beginning of a cycle to get plenty of testing.

> In this case, my vote would be to still keep the "libata.fua" parameter
> available (at least for the time being) so people have some way of
> working broken drives around without having to recompile their kernel
> (maybe also print a kernel log message if libata.fua=0 is provided asking
> people to report these drive models to linux-ide@).

If we add a proper "nofua" horkage flag to blacklist buggy drives, we need
to move the fua parameter to be an argument of the force parameter so that
disabling fua can be done per drive (port) or for all drives, similarly to
other tweak (noncq, nodmalog, etc)

> 
> Thanks,
> Maciej
> 

-- 
Damien Le Moal
Western Digital Research

