Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C66897FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBCLpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjBCLpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:45:15 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C329D5B1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:45:12 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230203114510euoutp02f07437ced78e76d0c5a7bf5115c5fdc1~ATeXLuBo03251232512euoutp02g
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230203114510euoutp02f07437ced78e76d0c5a7bf5115c5fdc1~ATeXLuBo03251232512euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675424710;
        bh=TQbVO+0KP3RO9F1tFhbBC1CX0+ACxulibijgd3d0IQg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=NpsGrhNo5N3KMrqGuL3ixt6NKZlHU5qR7knud+9Ls9prI4x9KEReeUQm/sxqn3OHf
         WdGUI3tCimwFq9vNFs31N3o6sEPf9nteaADImeMx0MLxh7rK81p8vhYDFR6Lt1hsgp
         7IwovvBV3x57t2itENgnK6ezWUwkzX+Pm/0YD7Ec=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230203114510eucas1p2307505363e993d4ed4fd63f720cc6022~ATeW8SUfq1597515975eucas1p2I;
        Fri,  3 Feb 2023 11:45:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.5E.13597.6C3FCD36; Fri,  3
        Feb 2023 11:45:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230203114509eucas1p1c605d0104b14b10ba536f12078269ca9~ATeWfMdbb3259232592eucas1p1V;
        Fri,  3 Feb 2023 11:45:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230203114509eusmtrp15392633bc7c2f632876753a8d8ad3efa~ATeWZgr8M2465424654eusmtrp1n;
        Fri,  3 Feb 2023 11:45:09 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-28-63dcf3c66209
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D6.40.00518.5C3FCD36; Fri,  3
        Feb 2023 11:45:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230203114509eusmtip261d0f1bcf8fed3ef1d7b436d1066f624~ATeVqnq8B3089630896eusmtip2I;
        Fri,  3 Feb 2023 11:45:09 +0000 (GMT)
Message-ID: <b3f31e71-fa1a-e0c0-fdfa-f65674ccc5cd@samsung.com>
Date:   Fri, 3 Feb 2023 12:45:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 5/9] ARM: dts: exynos: move exynos-bus nodes out of soc
 in Exynos4412
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <29841f64-360b-1426-e1fd-dd4c64ee5455@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7rHPt9JNlg8W8LiwbxtbBbXvzxn
        tZh/5Byrxdsluxgt+h+/Zrboe/GQ2WLv663sFpseX2O1uLxrDpvFjPP7mCzO/JvKYrHgj53F
        ujWCFq17j7BbbP7+l9GB32PnrLvsHkev3GP12LSqk83jzrU9bB6bl9R7/L+zlt3jS3M3q0ff
        llWMHp83yQVwRnHZpKTmZJalFunbJXBlzD+1g7HguUTFqhV7WRsYl4l0MXJySAiYSFzsecwM
        YgsJrGCU6F7j1MXIBWR/YZR4/207M4TzmVFiyrsLzDAdR58+Z4FILGeUmL2rE6rqI6PE/ue/
        GEGqeAXsJB51zmfrYuTgYBFQkVhxPwYiLChxcuYTFpCwqECKxKY/ZSBhYYFoiUV/77CC2MwC
        4hK3nsxnAhkpIvCMSWLm1lYmiMRzRonbf9lAbDYBQ4mut11gNifQqo4tjxghauQlmrfOBrtH
        QmAzp8TKW0/ZIa52kdj/8ScjhC0s8er4Fqi4jMTpyT0sEA3tjBILft9ngnAmMEo0PL8F1WEt
        cefcL7BvmAU0Jdbv0ocIO0o83PIXLCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u
        7cELl5gnMCrNQgqWWUj+n4XknVkIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQI
        THqn/x3/soNx+auPeocYmTgYDzFKcDArifAuP30nWYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv
        tu3JZCGB9MSS1OzU1ILUIpgsEwenVAOTj/xXMw4/jYwah8fbfZu92KcpzV7CMi3JWyTGXiig
        1r7fxdi7ZfvNPqaFN7/YtJ9pnqzMecTfW+Oxzetrybu3JR9+y2R0ajN35IflipqFTO1nurQV
        5105wmpn/VjU5LOkqesDA7d1uX5h7QuidrJs+mfyIfNflsflGV/bdyUsylh66V1QZupEZjWX
        iVOFnq2WMH2WdvtPft3Wv0uXOcVVanFsf7tIvvtUkoHvr91zUyXvllhkhwn1rP0qf/1Giv31
        +Sw+P4rUotJ+v8xfd68u9FqL56ZlH+1nNxdw5cmuzdVlENw73XWGaLZ/SU9Le/qPVTcCf08S
        sDl8SWG6EfM6346D5geM09VOXVhYzabEUpyRaKjFXFScCACk4jnR6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7pHP99JNliw38jiwbxtbBbXvzxn
        tZh/5Byrxdsluxgt+h+/Zrboe/GQ2WLv663sFpseX2O1uLxrDpvFjPP7mCzO/JvKYrHgj53F
        ujWCFq17j7BbbP7+l9GB32PnrLvsHkev3GP12LSqk83jzrU9bB6bl9R7/L+zlt3jS3M3q0ff
        llWMHp83yQVwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
        FunbJehlzD+1g7HguUTFqhV7WRsYl4l0MXJySAiYSBx9+pyli5GLQ0hgKaPErg8XGSESMhIn
        pzWwQtjCEn+udbFBFL1nlJi96SgTSIJXwE7iUed8oAQHB4uAisSK+zEQYUGJkzOfsIDYogIp
        Es3PT4LNERaIlljz/AhYK7OAuMStJ/OZQGaKCDxjknj8fBvYFcwCzxkl7m9tYoXY1s4k0bBw
        N1gLm4ChRNdbkDM4OTiBNndsecQIMcpMomtrF5QtL9G8dTbzBEahWUgumYVk4ywkLbOQtCxg
        ZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGOvbjv3csoNx5auPeocYmTgYDzFKcDArifAu
        P30nWYg3JbGyKrUoP76oNCe1+BCjKTA0JjJLiSbnA5NNXkm8oZmBqaGJmaWBqaWZsZI4r2dB
        R6KQQHpiSWp2ampBahFMHxMHp1QDk5tb/cfwJJ3NKWavv2+qTlyVkdt4N9Vx66PabUx9xSe/
        h3SsMvdWk7yY+Vf7b2JcmY5757yEr3sfZV393di3UV3eWTF9luHbVRJfjv7yO9FavMLoUtYv
        Cf0T1ibsHhvjI642ubDu3Mals6ornZF92UMOxnM7OPd3h8zvEQveOPPvy8V357CvcDHN//iS
        w+Tp2Qx7y9UCfkJ2JX+8avg9+lYk3ingfvj/UZoU5wxR7ZYDV462TOA8cGh6xVmz1R93F0Wx
        vJ8jvEvlZckhtk4peasbkkEaq/adT71btY1DxnDzU5sf3TVPPmX8sN/E6TtF0pAxoaX1PkP+
        4kLFCa4Lvv8zfOhkrsYUcWzWL5lNSizFGYmGWsxFxYkA39nxin4DAAA=
X-CMS-MailID: 20230203114509eucas1p1c605d0104b14b10ba536f12078269ca9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230129104220eucas1p15b70f73be86fa5600cfe170d22869836
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230129104220eucas1p15b70f73be86fa5600cfe170d22869836
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
        <20230125094513.155063-5-krzysztof.kozlowski@linaro.org>
        <CGME20230129104220eucas1p15b70f73be86fa5600cfe170d22869836@eucas1p1.samsung.com>
        <29841f64-360b-1426-e1fd-dd4c64ee5455@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 29.01.2023 11:42, Krzysztof Kozlowski wrote:
> On 25/01/2023 10:45, Krzysztof Kozlowski wrote:
>> The soc node is supposed to have only device nodes with MMIO addresses,
>> as reported by dtc W=1:
>>
>>    exynos4412.dtsi:407.20-413.5:
>>      Warning (simple_bus_reg): /soc/bus-acp: missing or empty reg/ranges property
>>
>> and dtbs_check:
>>
>>    exynos4412-i9300.dtb: soc: bus-acp:
>>      {'compatible': ['samsung,exynos-bus'], 'clocks': [[7, 456]], 'clock-names': ['bus'], 'operating-points-v2': [[132]], 'status': ['okay'], 'devfreq': [[117]]} should not be valid under {'type': 'object'}
>>
>> Move the bus nodes and their OPP tables out of SoC to fix this.
>> Re-order them alphabetically while moving and put some of the OPP tables
>> in device nodes (if they are not shared).
>>
> Applied.

I don't have a good news. It looks that this change is responsible for 
breaking boards that were rock-stable so far, like Odroid U3. I didn't 
manage to analyze what exactly causes the issue, but it looks that the 
exynos-bus devfreq driver somehow depends on the order of the nodes:

(before)

# dmesg | grep exynos-bus
[    6.415266] exynos-bus: new bus device registered: soc:bus-dmc 
(100000 KHz ~ 400000 KHz)
[    6.422717] exynos-bus: new bus device registered: soc:bus-acp 
(100000 KHz ~ 267000 KHz)
[    6.454323] exynos-bus: new bus device registered: soc:bus-c2c 
(100000 KHz ~ 400000 KHz)
[    6.489944] exynos-bus: new bus device registered: soc:bus-leftbus 
(100000 KHz ~ 200000 KHz)
[    6.493990] exynos-bus: new bus device registered: soc:bus-rightbus 
(100000 KHz ~ 200000 KHz)
[    6.494612] exynos-bus: new bus device registered: soc:bus-display 
(160000 KHz ~ 200000 KHz)
[    6.494932] exynos-bus: new bus device registered: soc:bus-fsys 
(100000 KHz ~ 134000 KHz)
[    6.495246] exynos-bus: new bus device registered: soc:bus-peri ( 
50000 KHz ~ 100000 KHz)
[    6.495577] exynos-bus: new bus device registered: soc:bus-mfc 
(100000 KHz ~ 200000 KHz)

(after)

# dmesg | grep exynos-bus

[    6.082032] exynos-bus: new bus device registered: bus-dmc (100000 
KHz ~ 400000 KHz)
[    6.122726] exynos-bus: new bus device registered: bus-leftbus 
(100000 KHz ~ 200000 KHz)
[    6.146705] exynos-bus: new bus device registered: bus-mfc (100000 
KHz ~ 200000 KHz)
[    6.181632] exynos-bus: new bus device registered: bus-peri ( 50000 
KHz ~ 100000 KHz)
[    6.204770] exynos-bus: new bus device registered: bus-rightbus 
(100000 KHz ~ 200000 KHz)
[    6.211087] exynos-bus: new bus device registered: bus-acp (100000 
KHz ~ 267000 KHz)
[    6.216936] exynos-bus: new bus device registered: bus-c2c (100000 
KHz ~ 400000 KHz)
[    6.225748] exynos-bus: new bus device registered: bus-display 
(160000 KHz ~ 200000 KHz)
[    6.242978] exynos-bus: new bus device registered: bus-fsys (100000 
KHz ~ 134000 KHz)

This is definitely a driver bug, but so far it worked fine, so this is a 
regression that need to be addressed somehow...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

