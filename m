Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40685FE9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJNHxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJNHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:53:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D551B94C6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665734022; x=1697270022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e43rx5lrlAT5OV5I6ek/4TNY/F1pHFYbWzrhPY/2w98=;
  b=cag+e3g0f0n0rFhiWnpA/d0ZwsRcwoSHRRNhRSGa4HZKi0iFxziI8d0n
   YWRW+h7dEKKbI+wEyPzq7jW15ViPGMMLBsSp3r8ktZhZUp0NHNBf9KvPH
   LUFYg5E97Bq2ABhNYHwyyei6gkTzTyfg1r7GvZhBJFeaGgUHCBjpj97Uk
   owwPRyXZ/ivBPwZX0FgJzeC5BpkcaXuqLalXiMugX78mT8VFZkY96Uy5/
   O+5YrBUSfh5U6LIQkJaXnr8qd0OHis4oZG4VL35U3LnqWqh8zLln5xini
   NW5t1iI7RCAvt/1MOPbedhYEKSVYueya+4r2LKfScHcLNda/iMIPRqleO
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661788800"; 
   d="scan'208";a="214178936"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2022 15:53:40 +0800
IronPort-SDR: q6AoVqi2/uxjJt4hgjZy1OCUquhvjMOpeP4/ccHLzWtKvm7MxeLDcAKnp43KWRYEKXiIC+FdtP
 kxlE5S7MPy4eriRo9dwtezMV5iHLk8lIMC6ElKW8mZkOY8T5fsWr7tUQOWIVBVvkDKQMKLWqSA
 HFC3HJqCbhDZ+164D90HkLgddfvg2MkD0fZSCbk+g5DMILa6pWlTpu5A42CHTFnVFoMKemuqdy
 q3wR2AIVIqNyruvRzII9V47ZDtGYN1Dhkg93XdNUThDs/VZ+Uy7SOzJNmdv//kMaOlGw1U6b8z
 YPg9Rw8uUEhXDXoz10oVIzNN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2022 00:07:39 -0700
IronPort-SDR: S4KCt52vfDtcGQ6BMhdGy8DogJCMaG6iXYNRxjw9KUHcFT1oVUtKhPYh7qhLTolVO7TMW0/vG0
 iZEeUZqJYT65ESC+ZQ3NopgvlFCPt5kKm4t9Dpa4i2vKBSxAgOUALNBT6FoWeOzROAyJpARLbj
 qZom/hYpbkrD3sEUNC/raQxOhon8sL5s0BKq5Gqw9bA+o1BtaUS4ha2GUR1r8WKWMpEFnpAwXF
 Zl0JXsk79Lcu6oKrTw7oQdwKL+B0/YnLAgrjmy4oxMa2+EP2K71osduY5e/8h2EtRL212CJUJF
 6KE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2022 00:53:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MpdtW1Xw6z1Rwt8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:53:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665734017; x=1668326018; bh=e43rx5lrlAT5OV5I6ek/4TNY/F1pHFYbWzr
        hPY/2w98=; b=ZTiK/j8LiDrFrYQOd7HxyM5cMqE5uz+yNC4GEjFhtf2+wCIRQW6
        zzNi6YjPUrTmFAoGxHiT4jQbNBKxjDG64kaUU/ksyjSxIO7f4MVMCGO+/WOzsqA6
        LFLEBj06NRiV+pG7k5Yckl0OKagqyX/m/6PZ6edAwbZa/CRrNDZC+b6iJ6CW/Abz
        TZZNzOTY9ONH3vdKHFPSLuu1CwTD5wcLdyS2mGBU+vxjf2DwBRQY7N4vd6FeDHTg
        GadKmMeCIfeDUs2fV2M4hqvMA3d8M6/iT6Y7UAcmdgSo7lUvu5My/A1bPCjzcSuv
        IbOMvnoqXn1pXr5US+zL3mNqu5ElzjBTAJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bhCAAQMpLU2U for <linux-kernel@vger.kernel.org>;
        Fri, 14 Oct 2022 00:53:37 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MpdtS2PLzz1RvLy;
        Fri, 14 Oct 2022 00:53:36 -0700 (PDT)
Message-ID: <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 16:53:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 16:31, Arnd Bergmann wrote:
> On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
>> On 10/14/22 07:07, Anders Roxell wrote:
>> [...]
>>>> 8)
>>>>> If reverting these patches restores the eSATA port on this board, then you need
>>>>> to fix the defconfig for that board.
>>>>
>>>> OTOH,
>>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
>>>> device failed to boot.
>>>
>>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
>>
>> As mentioned in my previous reply to Naresh, this is a new driver added in
>> 6.1. Your board was working before so this should not be the driver needed
>> for it.
>>
>>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
>>> controller support")
>>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
>>> successful.
>>
>> Which is very strange... There is only one hunk in that commit that could
>> be considered suspicious:
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 9b56490ecbc3..8f5572a9f8f1 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>>  static const struct of_device_id ahci_of_match[] = {
>>         { .compatible = "generic-ahci", },
>>         /* Keep the following compatibles for device tree compatibility */
>> -       { .compatible = "snps,spear-ahci", },
>>         { .compatible = "ibm,476gtr-ahci", },
>> -       { .compatible = "snps,dwc-ahci", },
>>         { .compatible = "hisilicon,hisi-ahci", },
>>         { .compatible = "cavium,octeon-7130-ahci", },
>>         { /* sentinel */ }
>>
>> Is your board using one of these compatible string ?
> 
> The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> with the new driver if that is loaded, but it's possible that the
> driver does not work on all versions of the dwc-ahci hardware.
> 
> Anders, can you provide the boot log from a boot with the new driver
> built in? There should be some messages from dwc-ahci about finding
> the device, but then not ultimately working.
> 
> Depending on which way it goes wrong, the safest fallback for 6.1 is
> probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> strings back into the old driver, and leave the new one only for 
> the "baikal,bt1-ahci" implementation of it, until it has been
> successfully verified on TI am5/dra7, spear13xx and exynos.

OK. So a fix patch until further tests/debug is completed would be this:

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 8fb66860db31..7a0cbab00843 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
 };

 static const struct of_device_id ahci_dwc_of_match[] = {
-       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
-       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
        { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
        {},
 };
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 8f5572a9f8f1..9b56490ecbc3 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static const struct of_device_id ahci_of_match[] = {
        { .compatible = "generic-ahci", },
        /* Keep the following compatibles for device tree compatibility */
+       { .compatible = "snps,spear-ahci", },
        { .compatible = "ibm,476gtr-ahci", },
+       { .compatible = "snps,dwc-ahci", },
        { .compatible = "hisilicon,hisi-ahci", },
        { .compatible = "cavium,octeon-7130-ahci", },
        { /* sentinel */ }

Anders, Naresh,

Can you try this ?

-- 
Damien Le Moal
Western Digital Research

