Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6B64294D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLENYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiLENYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:24:30 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D521AF0C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670246669; x=1701782669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eIuVPi2oKlmfmwkWcq2jyJdIlCtdykKp0CE/vjbqIHc=;
  b=mV1N6HVlLVX4ZqBUdig3WlXDrmGlRq4O5xYOFMBXrx5AxH+ZJJfliyMI
   H6vpcXWHmukbmjNfyLorUjzseuE+fLyNw7hf3JEXdH0VWYV+EiCpOFM8n
   UTPoW3N0RQgvmabqh0ddMW7TwFFqepq//2U3C0r8tBDeYCSzSMvcA5FZC
   75G/BezpFvnzdGOAlGLeNkbiu8oNjMYhKH/xDAI9IS+F7CP71TsEuKPCa
   lo4AdKAKf39fYlsSLBUMa2NJpvfu8LTXmCk5a2oGx6fSeEWpY/Cf12AjT
   WLhhaxacEg2XmukqJG3DXim8VW4CyQoZvfE3DlD9EHV5MK4TAFmOZvOCC
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665417600"; 
   d="scan'208";a="322277618"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 21:24:27 +0800
IronPort-SDR: ScDLH6KvzKaUUg3ze4pxGRJEl7uiQvAIfCBQZewqEVR1ep1vZWLrb0vhzRNS81bNHknTQmCSWD
 7MMWQZKu2DSkfHCiMPdfI/kNsufORp7xpuTNYuNIaXopSwD+c8W0Omi0Qx0/7Oq6hVpT6KkL+w
 QYuft0qrlL5kL+2NYOTpjX15OAgreL5Ix6K5mofhmi6uYChkpzdykYmnETbZuIN36eZ+wMJtlu
 aODK2VCundbiItZ2NKYlYNb/vj9bSsPurQFxiMIuEzLHwIUB3LeeDWYYrfH6Sea068Y9mECgpt
 Las=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 04:43:00 -0800
IronPort-SDR: c5+6BPxXicLZW46NxcI1HCpEucip1AwUaaO4qGB2rDiRsnB3Mbtmi4EZoYAq5We7LLMZqO0RIA
 gEdp1tAr4zSLfBrtJ/erE2r1S7xghggsFVvrANqEgM69fmviznHOuqXOch3u7cv8/V7cH0QhP7
 PX7crEvSt1ezFgH6hyHSXTPf4Gh0GVndQ0Rvwbsj59GeJNzK+xUnc0FpMR6NlnqPXUJWTE/6V2
 t/ncyMon5PnCdAqd/GDbjQz6f0C/VcMrjTOM5mnsu9pn5LnZi8CYfs/hRkhana0lClaFa4RSR0
 4c0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 05:24:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQkmC11Ynz1Rwtm
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:24:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670246666; x=1672838667; bh=eIuVPi2oKlmfmwkWcq2jyJdIlCtdykKp0CE
        /vjbqIHc=; b=Ecs0n0q1JF4Cx8NoxRMgMJtMXrKuW5Q0cv0SaH2nQVL9z4d2Ksw
        oXbrqsUEPpNvntcx7VwaNyBirMaNJS7u6cxvS+6r6SdY0IDZvFdaEnJskr7PVtWr
        gHK5ubpd82Muow3h6emPVVyTAINaxclwgIQalI/+3b57j4xK9Q0+jsckqpd4Ii1H
        +BDqqFFoSkq6T41xsJpOp2mBPDUGNPTws4LYze04nhIRaWGPAIswyb8xC0qSMLq7
        rnpIGvaYv4IYho1sv5tWhQyD6SEuRMgvGW1FKEtCwC+pID4Zkc0A6gfv0I+pxHvK
        Nn8gTg7NPDm23gcFTGFUnNHWvjrxAbt/esA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Iy7ulSKxNn5U for <linux-kernel@vger.kernel.org>;
        Mon,  5 Dec 2022 05:24:26 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQkm75kCwz1RvLy;
        Mon,  5 Dec 2022 05:24:23 -0800 (PST)
Message-ID: <f440a8ff-7657-c1be-e733-4ad69b6b7b0b@opensource.wdc.com>
Date:   Mon, 5 Dec 2022 22:24:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Carlos Hernandez <ceh@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
 <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
 <20221205011105.4do4trbytq4bfw5b@mobilestation>
 <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <98670e23-6553-4788-8662-9403c480af82@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 19:08, Arnd Bergmann wrote:
> On Mon, Dec 5, 2022, at 02:11, Serge Semin wrote:
>> On Thu, Dec 01, 2022 at 12:48:32PM +0100, Anders Roxell wrote:
> 
>>>
>>>   for (i = 0; i < hpriv->n_clks; i++) {
>>> - if (!strcmp(hpriv->clks[i].id, con_id))
>>> + if (hpriv->clks && hpriv->clks[i].id &&
>>> +    !strcmp(hpriv->clks[i].id, con_id))
>>>   return hpriv->clks[i].clk;
>>>   }
>>
>> Indeed I should have taken into account that devm_clk_bulk_get_all()
>> can get unnamed clocks too. But checking the hpriv->clks pointer for
>> being not null is redundant, since the ahci_platform_get_resources()
>> procedure makes sure that the array is always allocated. At the very
>> least you shouldn't check the pointer in the loop, but can make sure
>> that the clks array is available before it.
> 
> Do you think this is otherwise the correct fix then? Any chance we
> can still get a version of it into 6.1?

If someone sends me a proper patch to apply, I can send a last PR for 6.1
to Linus before week end.


> 
>      Arnd

-- 
Damien Le Moal
Western Digital Research

