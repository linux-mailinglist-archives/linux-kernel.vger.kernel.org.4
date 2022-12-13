Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421664B757
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiLMO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:29:08 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9EA183AF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:29:05 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221213142902euoutp01e372810c5fcb9ebe8282629ac21594aa~wYKlhV80m2753227532euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:29:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221213142902euoutp01e372810c5fcb9ebe8282629ac21594aa~wYKlhV80m2753227532euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670941742;
        bh=A0aMYzhvxttoR0ntW0RUwD+aMshHkFSR+FGPq6TJT3A=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=UXyBaxCBl+1P4vygYl24hEomJYFypF7UvGGTzEL0uyu2UEIm8LJlNNfGE5ZHb+XVI
         l234JSS4nmkRH5ZEDSq5m2dWTK6OEIjEGsjGIZJNKruRkUU5eQyvzbwFdS9hj6cHTO
         PO8Af14KORuBEuubL2rh7Bj3HLjH3qKdFgmYXY3o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221213142901eucas1p15c2b76a11df701dfe7e95780b4e6d92d~wYKlCMoxe0169101691eucas1p1A;
        Tue, 13 Dec 2022 14:29:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.8B.09549.D2C88936; Tue, 13
        Dec 2022 14:29:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221213142901eucas1p1ced478d962433fd4cdbb21e61f1a26c4~wYKkaZ_r20174701747eucas1p1y;
        Tue, 13 Dec 2022 14:29:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221213142901eusmtrp1f8fd575c3e326846efd2d13d3cc69789~wYKkZRRKO3072130721eusmtrp1S;
        Tue, 13 Dec 2022 14:29:01 +0000 (GMT)
X-AuditID: cbfec7f5-f5dff7000000254d-fb-63988c2d6bb3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.36.09026.C2C88936; Tue, 13
        Dec 2022 14:29:00 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221213142900eusmtip132c7b7564ddd5f685cc741ed2db1b13d~wYKjiJNFo0100401004eusmtip1J;
        Tue, 13 Dec 2022 14:29:00 +0000 (GMT)
Message-ID: <dc6c80f1-f34d-eaab-d561-32caa7fa140c@samsung.com>
Date:   Tue, 13 Dec 2022 15:29:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2] regulator: core: Use different devices for resource
 allocation and DT lookup
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     broonie@kernel.org, djrscally@gmail.com, hdegoede@redhat.com,
        markgross@kernel.org, lgirdwood@gmail.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        yangyingliang@huawei.com, gene_chen@richtek.com,
        chiaen_wu@richtek.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CADiBU39-FUD787RmV9Z+jsSrb2Se66A6FrLWGxf78q2Ud-SrjA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djPc7q6PTOSDd4c1rb4+XIao8XUh0/Y
        LNae1Lf4sqef1WLb4XesFk96zrFavDk+ncni25UOJotNj6+xWlzeNYfNouvaE1aLA1OnMVvM
        +7uW1WL1nhfMFpPW3WOy2PLpGpODgMfT/q3sHjtn3WX3aDnyltVj06pONo/NS+o93u+7yuYx
        49MUNo+D+ww9Pm+SC+CM4rJJSc3JLEst0rdL4Mr42f6KqeCNUsXel1tZGhhfS3YxcnBICJhI
        nP8MZHJxCAmsYJRY3PCLpYuRE8j5wiix7IwXROIzo8TvPUtZQRIgDWvO3mSFSCxnlPg6s5cZ
        wvnIKHH94Rewdl4BO4mdD+ewgdgsAqoSX05shYoLSpyc+QTMFhVIkTiw8ywTiC0skCbxbH8r
        WD2zgLjErSfzweIiAmoSa35fYQFZwCywkVni3/OPYGewCRhKdL3tAmvgFAiU2HdvMgtEs7xE
        89bZYBdJCOzmlOjp/MYCcbeLxJozXewQtrDEq+NboGwZidOTe1ggGtoZJRb8vs8E4UxglGh4
        fosRospa4s65X2ygIGMW0JRYv0sfIuwocfT9MTZISPJJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDV
        ahKzjq+DW3vwwiXmCYxKs5DCZRaS/2cheWcWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS
        9ZLzczcxAhPg6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8qhrTkoV4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzrpjSkSwkkJ5YkpqdmlqQWgSTZeLglGpg4pi55K/EnQ+5c/wFT1fKqM3vczGW7Drb
        o+aiybT8F6+/lNb/tz5aObcerZgSsZEvIb6yJ9T81plrVpr/DKaaqkifvH5BweRw+cF02RsX
        Lbe2HJR2d1o3eX9A2oZ7J9NnXgm8qDzn59Z696BXyT1R7ur1B5aqJy5X/dTqPkH/fvS6TUuP
        CDBK7rijzLru2cUDT78f6MzeuFK1vnLeoc9CjQY5N/8vn3RHsuJK1U++VYG5v6NYPY8zV9Z5
        TfYw+bmyb2VSQVXyhkXV3g4hvAJG1+/dv3bL+X/B1V3fk/eU2Ad2K0q+V9wqfNZVbHcf18PK
        SdN+sa3ZKrf0yFHT6IXt5w0ks3kOJ3x5ve7wEaFb85VYijMSDbWYi4oTAVSuyFjvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7q6PTOSDRpULX6+nMZoMfXhEzaL
        tSf1Lb7s6We12Hb4HavFk55zrBZvjk9nsvh2pYPJYtPja6wWl3fNYbPouvaE1eLA1GnMFvP+
        rmW1WL3nBbPFpHX3mCy2fLrG5CDg8bR/K7vHzll32T1ajrxl9di0qpPNY/OSeo/3+66yecz4
        NIXN4+A+Q4/Pm+QCOKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJS
        czLLUov07RL0Mn62v2IqeKNUsfflVpYGxteSXYycHBICJhJrzt5k7WLk4hASWMoosaPzCAtE
        Qkbi5LQGVghbWOLPtS42iKL3jBL/vu9hBknwCthJ7Hw4hw3EZhFQlfhyYisLRFxQ4uTMJ2C2
        qECKRHvPPyYQW1ggTeLZ/lawemYBcYlbT+aDxUUE1CTW/L7CArKAWWAjs0TzuxXMENsmMUl8
        XfQe7Aw2AUOJrrddYN2cAoES++5NZoGYZCbRtbWLEcKWl2jeOpt5AqPQLCSHzEKycBaSlllI
        WhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjPltx35u2cG48tVHvUOMTByMhxglOJiV
        RHhVNaYlC/GmJFZWpRblxxeV5qQWH2I0BYbGRGYp0eR8YNLJK4k3NDMwNTQxszQwtTQzVhLn
        9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgUvfZLOdmd8Hlpsv5mNfqZ1jqp0a7zpv2pnXVy4nV
        pS8LO67eOrC1PuJgN1/t3E83e2zfLJ3LdGPN4cXvRdlOaYZP/WxTcvDVtNkLjV90n6/t32C/
        d4J8q9ilWY6pCh0Kzxd7bE+5/6UrveVk59te547k93wWvbVTi7ds8N03m/+O7vfDH6rfP2bc
        pNR8dpXYMhPvpur5wqdSfnlELXmjyhL36KNeh+DitRV6RmVpfDodU94xcF16Ub7+neX7TdK/
        DPbzTojbK3Zu041mzW9ZF+Mb5C/mLxeNZH62lGuliuk7tq+SYlZNs/WOvN66QevrPWaLi7VX
        lRewbt98itufSyInq+JXSubi1gWbbX6zblViKc5INNRiLipOBACDiw0nggMAAA==
X-CMS-MailID: 20221213142901eucas1p1ced478d962433fd4cdbb21e61f1a26c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0
References: <CGME20221213113259eucas1p1c224898772bc5e59de90c1aa65a34de0@eucas1p1.samsung.com>
        <1670311341-32664-1-git-send-email-u0084500@gmail.com>
        <dd329b51-f11a-2af6-9549-c8a014fd5a71@samsung.com>
        <CADiBU39-FUD787RmV9Z+jsSrb2Se66A6FrLWGxf78q2Ud-SrjA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.12.2022 15:19, ChiYuan Huang wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> 於 2022年12月13日 週二 晚上7:33寫道：
>> On 06.12.2022 08:22, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Following by the below discussion, there's the potential UAF issue
>>> between regulator and mfd.
>>> https://lore.kernel.org/all/20221128143601.1698148-1-yangyingliang@huawei.com/
>>>
>>> >From the analysis of Yingliang
>>>
>>> CPU A                         |CPU B
>>> mt6370_probe()                        |
>>>     devm_mfd_add_devices()     |
>>>                                |mt6370_regulator_probe()
>>>                                |  regulator_register()
>>>                                |    //allocate init_data and add it to devres
>>>                                |    regulator_of_get_init_data()
>>> i2c_unregister_device()               |
>>>     device_del()                       |
>>>       devres_release_all()     |
>>>         // init_data is freed  |
>>>         release_nodes()                |
>>>                                |  // using init_data causes UAF
>>>                                |  regulator_register()
>>>
>>> It's common to use mfd core to create child device for the regulator.
>>> In order to do the DT lookup for init data, the child that registered
>>> the regulator would pass its parent as the parameter. And this causes
>>> init data resource allocated to its parent, not itself. The issue happen
>>> when parent device is going to release and regulator core is still doing
>>> some operation of init data constraint for the regulator of child device.
>>>
>>> To fix it, this patch expand 'regulator_register' API to use the
>>> different devices for init data allocation and DT lookup.
>>>
>>> Reported-by: Yang Yingliang <yangyingliang@huawei.com>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>
>> This patch landed in linux-next 202212 as commit 8f3cbcd6b440
>> ("regulator: core: Use different devices for resource allocation and DT
>> lookup"). Unfortunately it causes serious regression on my test systems.
>> It looks that some supplies are not resolved correctly and then turned
>> off as 'unused', even if they provide power to other core regulators in
>> the system. I've observed this issue on Samsung Chromebook Peach-Pit and
>> Peach-Pi (ARM 32bit Exynos based). The symptoms are somehow similar to
>> the issue reported here some time ago:
>>
>> https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsung.com/
>>
>> I've post more information once I analyze this issue further.
>>
> It seems the issue occurs in 'regulator register' resolve supply.
> Due to the parent device don't have the of_node, to resolve the
> supply, it may need to get the
> dt node by recursively finding child regulator.
> Like this
> parent {
>    regulators {
>       xxx-supply = <&vdd12-ldo>;
>       vdd12-ldo: vdd12-ldo {
>           regulator-name = "xxx";
>           regulator-min-microvolts = <xxxxx>;
>           regulator-max-microvolts = <xxxxx>;
>        }
>    };
> };
> >From this case, 'resolve supply' need to parse at least the more top
> level like 'regulators'.
> But now, it only take 'vdd12-ldo' as the node or its child to parse its supply.
>
> Below's the fix I guess.
> It'll make the parent of the regulator the same as the dev parameter
> in 'regulator_config'.
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index ea4a720..7c5036e 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5526,7 +5526,7 @@ regulator_register(struct device *dev,
>
>          /* register with sysfs */
>          rdev->dev.class = &regulator_class;
> -       rdev->dev.parent = dev;
> +       rdev->dev.parent = config->dev;
>          dev_set_name(&rdev->dev, "regulator.%lu",
>                      (unsigned long) atomic_inc_return(&regulator_no));
>          dev_set_drvdata(&rdev->dev, rdev);
>
> I don't have the board. Could you help to test this change to see
> whether it's been fixed or not?

The above change fixes the issue. Thanks! Feel free to add following 
tags to the final patch:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

