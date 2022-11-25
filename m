Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51F2638E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKYQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKYQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:40:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4663D91F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:40:55 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221125164050epoutp01f21c680e5ee7404357703aa6086d584c~q4Wh5dMsP2831728317epoutp01U
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:40:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221125164050epoutp01f21c680e5ee7404357703aa6086d584c~q4Wh5dMsP2831728317epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669394450;
        bh=x9WaHarhEiy9sckdGNr5J1jaICTZoKpfCbdIcjqPPUY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aU2SRw1DkwqNv4HKHscb1wM39BGuFfnYUIfqTDNJUqYjkujmrWm1y8zNzKjm3tNyS
         AtAKu9Rfu6F5bLL2NoLnJTMTznjVwfnu+u5sNagH6kbJGAsc/Dc7mn/uihvM525RLX
         SUflAJnRyCYHJrdySCTeNOusNm0EwpAVSSqpWLPU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221125164049epcas5p25e1b2fbd997100a4922fc8ec3380bc02~q4WgjfEqq1127511275epcas5p2p;
        Fri, 25 Nov 2022 16:40:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NJgbM4mkjz4x9Pv; Fri, 25 Nov
        2022 16:40:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.9F.56352.F00F0836; Sat, 26 Nov 2022 01:40:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221125164046epcas5p22a5fba71d4c39ea4bb246e2100e9cc1f~q4Wd15DA51127511275epcas5p2o;
        Fri, 25 Nov 2022 16:40:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125164046epsmtrp24b31540b526d313b505b5dcc7807762e~q4Wd1Fgrc3038430384epsmtrp2c;
        Fri, 25 Nov 2022 16:40:46 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-66-6380f00f9b83
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.50.14392.E00F0836; Sat, 26 Nov 2022 01:40:46 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125164042epsmtip27f4567976c3ed9f62e46009d26c7bc2b~q4Wae56HA2485824858epsmtip2H;
        Fri, 25 Nov 2022 16:40:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
Cc:     "'Lee Jones'" <lee@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <016293da-92b1-16e9-9a8d-ecab34c2f0c6@linaro.org>
Subject: RE: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
Date:   Fri, 25 Nov 2022 22:10:40 +0530
Message-ID: <01a201d900ec$aaaf5740$000e05c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIt87tfTwup8v8WQwS48SHvnyDBrAHgnMUHAkbd/d0Bcz2GTwF+lQpiAr6nA3gCgQusgK1DJvFw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhi7/h4Zkg7c/5S0u79e2mH/kHKtF
        34uHzBZ7X29lt9jRtpDFYtPja6wWl3fNYbOYcX4fk0Xr3iPsFs/7gKzbb9axOnB7bFrVyeZx
        59oeNo/NS+o9+rasYvT4vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJc
        SSEvMTfVVsnFJ0DXLTMH6DAlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5x
        Ym5xaV66Xl5qiZWhgYGRKVBhQnbGu0VXWAvWiVfsObeErYHxmnAXIyeHhICJxKeGZrYuRi4O
        IYHdjBJHrn1ihnA+MUocOn2KEcL5xiix78Q0JpiWL7Mfs0Mk9jJKtJ1/yQLhvGSUOHmzgRGk
        ik1AV2LH4jY2EFtEIE9i+s3NYEXMAl+YJF7cmAuW4BSwkzg8ZwNQgoNDWKBY4t4RaZAwi4Cq
        xIlFh8HCvAKWEnOORICEeQUEJU7OfMICYjMLaEssW/iaGeIgBYmfT5exQsTFJV4ePcIOsTZK
        oufJDbDfJAS2cEi0HZnDBtHgInHk/AsoW1ji1fEt7BC2lMTnd3vZQPZKCHhILPojBRHOkHi7
        fD0jhG0vceDKHLDTmAU0Jdbv0odYyyfR+/sJE0Qnr0RHmxBEtapE87urLBC2tMTE7m5WCNtD
        4tqxVewTGBVnIXlsFpLHZiF5ZhbCsgWMLKsYJVMLinPTU4tNC4zzUsvh0Z2cn7uJEZxqtbx3
        MD568EHvECMTB+MhRgkOZiUR3oTjDclCvCmJlVWpRfnxRaU5qcWHGE2BgT2RWUo0OR+Y7PNK
        4g1NLA1MzMzMTCyNzQyVxHkXz9BKFhJITyxJzU5NLUgtgulj4uCUamDSdhaVyMll4DHg337M
        +6jlU47C1cs6VwdNduAu2S3Kd+eOfExrs4+1WsVW106ZT5OmmVzJ977+92ndjI9hnd0eTvue
        bTDlqp80qyxehUmrcMX3dQfX7vcNuzQln3GL7tG5brlnc18xJ+qfqlz2b320mFiGdO/JPs55
        ckIHiy8fM7azNgxd5DRr2gzjaUrlAu3/rDSWmXP++bX50ibjCcbrL/3edHEqj9OC/Me5QrH/
        5asYA9g/Kpg7VLVMXTrzynGGt/Vvu/Ue/e5alHrj7sf0l1/M9kQdONTIrTTdYEHZV5sNmo5r
        2tbr9i3+N+Xz0k2NXRovC/u4WT99Sq1f6J2/80fstHDHz1eNXYzMGYSVWIozEg21mIuKEwFR
        MbtvPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvC7fh4Zkg56lfBaX92tbzD9yjtWi
        78VDZou9r7eyW+xoW8hisenxNVaLy7vmsFnMOL+PyaJ17xF2i+d9QNbtN+tYHbg9Nq3qZPO4
        c20Pm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlXHp+k7GgkniFROObWRuYFwl3MXI
        ySEhYCLxZfZjdhBbSGA3o0Rbcy5EXFri+sYJ7BC2sMTKf8+hap4zStxoCAWx2QR0JXYsbmMD
        sUUE8iSuHdnI2sXIxcEs8ItJ4ur/D2COkMBeZonr/5Yzg1RxCthJHJ6zgaWLkYNDWKBQYvqH
        JJAwi4CqxIlFh8HCvAKWEnOORICEeQUEJU7OfMICYjMLaEv0PmxlhLGXLXzNDHGbgsTPp8tY
        IeLiEi+PHmGHuCdKoufJDbYJjMKzkIyahWTULCSjZiFpX8DIsopRMrWgODc9t9iwwDAvtVyv
        ODG3uDQvXS85P3cTIzjetDR3MG5f9UHvECMTB+MhRgkOZiUR3oTjDclCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MJVdtJCpfStxYZeChsXL6/sKn1Se
        3Gbw7YGbVRjb250bN3ibu/vfC7/wNJdLmHXJ9ni1lM+H3durjF8fW3Pe1GjurssywsGODXnT
        5uqdsL39a4aMR9of1oYM79IDesf3zzA99UNDamW5XoW54kZz7b8persPz5tn8vDv27Ld2ulJ
        jmV36tMk5+ts987enZiZv+dN2VG1dpu+42IO980D/k+ztw7cyHaQvbssrDP42qc36yb1TzB4
        LKLy7xcfR/7LkCf3/jFtuH9NdcUshU6u4ga96zLc854HezP0TG9mWVQRXhDosGrd8cevHmxV
        KTzce01wf4Bm3a+4BdXe29nevoyz2Txd5V/trCDnl/84nimxFGckGmoxFxUnAgDmm2ALJgMA
        AA==
X-CMS-MailID: 20221125164046epcas5p22a5fba71d4c39ea4bb246e2100e9cc1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125150130epcas5p3ce8a3b75cf80ea9df35093db4d684eb2
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
        <20221125112201.240178-3-krzysztof.kozlowski@linaro.org>
        <CAPLW+4kwFCLaiowajdCnA09eT4emOB-3d-6cbA=ZYyRLwYuCxw@mail.gmail.com>
        <dfd956d5-d62d-52ac-c485-afc71c441df5@linaro.org>
        <CAPLW+4mWq5Q4Ht1Upx2Xw3fMfNvvSK6fEPbLFru1NLpKHLbKOg@mail.gmail.com>
        <CGME20221125150130epcas5p3ce8a3b75cf80ea9df35093db4d684eb2@epcas5p3.samsung.com>
        <016293da-92b1-16e9-9a8d-ecab34c2f0c6@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
>Sent: Friday, November 25, 2022 8:31 PM
>To: Sam Protsenko <semen.protsenko=40linaro.org>
>Cc: Lee Jones <lee=40kernel.org>; Rob Herring <robh+dt=40kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski+dt=40linaro.org>; Alim Akhtar
><alim.akhtar=40samsung.com>; devicetree=40vger.kernel.org; linux-
>kernel=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-
>samsung-soc=40vger.kernel.org; Sriranjani P <sriranjani.p=40samsung.com>;
>Chanho Park <chanho61.park=40samsung.com>
>Subject: Re: =5BPATCH 3/4=5D dt-bindings: soc: samsung: exynos-sysreg: add
>dedicated SYSREG compatibles to Exynos5433
>
>On 25/11/2022 15:57, Sam Protsenko wrote:
>> On Fri, 25 Nov 2022 at 08:47, Krzysztof Kozlowski
>> <krzysztof.kozlowski=40linaro.org> wrote:
>>>
>>> On 25/11/2022 15:22, Sam Protsenko wrote:
>>>> On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski=40linaro.org> wrote:
>>>>>
>>>>> Exynos5433 has several different SYSREGs, so use dedicated
>>>>> compatibles for them.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
>>>>>
>>>>> ---
>>>>>
>>>>> Cc: Sriranjani P <sriranjani.p=40samsung.com>
>>>>> Cc: Chanho Park <chanho61.park=40samsung.com>
>>>>> Cc: Sam Protsenko <semen.protsenko=40linaro.org>
>>>>> ---
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> Just curious: what is the rationale for adding those more specific
>>>> sysregs? AFAIR, e.g. in Exynos850, different SysReg instances have
>>>> pretty much the same register layout.
>>>>
>>>
>>> On Exynos5433 all these blocks have different registers. Are you
>>> saying that Exynos850 has four (or more) sysregs which are exactly the
>same?
>>> Same registers? Why would they duplicate it?
>>>
>>
>> Ah, no, you are right. Just checked it, they are different. Just first
>> couple of registers are similar between blocks, that's why I memorized
>> it wrong.
>>
>> So as I understand, adding those new compatibles follows =22describe HW,
>> not a driver=22 rule? Because AFAIU, right now it'll fallback to
>> =22syscon=22 compatible anyway.
>
>Yes, they describe hardware. Of course all of these sysregs are similar as=
 they
>are just bunch of SFR/MMIO-region, but they have different roles/features.
>For example some other devices (users) of syscon/sysreg should reference
>specific device, not any sysreg.
>
Yes, these are dedicated / extended SFR region to provide IP/Block specific=
 side-band signals / configurations.

>On several other architectures we use specific compatibles, so I think for
>Samsung we should do the same.
>
Yes, most of the SoC's sysreg are dedicated/included in the IP block itself=
 now a day, so make sense to have a dedicated compatible.

>Different case was for Exynos 3/4/5 where there was only one SYSREG.
>
AFAIR, this is correct.

>Best regards,
>Krzysztof


