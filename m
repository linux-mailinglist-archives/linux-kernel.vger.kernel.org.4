Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61916ED1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjDXPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDXPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:54:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2074.outbound.protection.outlook.com [40.92.98.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11D422A;
        Mon, 24 Apr 2023 08:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeNUFHBx6T3LsQ2+af8X/pnLo3QI+vNop9Yvy7xVMsHdPFvzjWXrqJjp47MiN+ekA4Vkqe9xLGUDw6bapaFmUpVHYij3Eeds9NNuinhskZaXQMJp3cjjAPki52YGtcb4G5GfcQZhOmrVQaOA/+DhJI+w3dtnmnbYJucNsHr0hZ7pxaw9Dmt4ioelJIT5IcDFddgDLdrK4aZQflWcM01RlRixKGoyAxgSWsKjlrZXV2p/luIODNmNxedkPeNjP7pdv/wszrtE9fIUUUKjjoPylzipHgiudKGAAg3cdZPQmEEjYDbQwF5iRfOCZoDBPUtHuA/LOgIlPgMWn/2T2oz5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S11wN6n4I8NRjTa38Exj4Z5in7evttcTsfi6XE5G7aQ=;
 b=c9e00aApxrY6CiPnu8FSD/na8vh1UWcB+ROQ3hnJAaa+Kxrv92q6fovWCuC/F+/madjhvmITSP6ZenA72oo3Sig945+4wYBfKlKyNiHGskwW9Uqb432zM3o12Ca3t1Dpr71Ae/v1CCiNx9yi0it1oSTPWGc/O+1U24cojUDpBoRU1F97s/rWOlKTvjqKYE7dgy/15nwJ/y7CqZGx0+iaMG21QW9/hqM8ayEQO+tK2LKMEynYbZRH0hKW5ExT7LywEDMiNwMS2/UNwI2lveqDz5JbMfI8scziyIwtxkL5RhLNgobPSXK3M0FDMEm6HRRVG2q1a7t6KgpiW/bXBzDGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S11wN6n4I8NRjTa38Exj4Z5in7evttcTsfi6XE5G7aQ=;
 b=u8MzqFZG74H3b5Dai/9a8cGbE2iRkl44bbhaCwCDrH2n9KRzLx9U19te1nEC5FEiL4KeowMKxuyPYvqGg26I0hE1LnqUJihUYupxP6RC7Oosid693CEbDeCxemD5Nb+ZwMgG5XsCWXRXlc4AjNaVKCt6QFjuRgrt3T/EF+19a3wANDqIo1kfpHxIlLPc/LjGvm9bxoZ+ipVdvrJ2CjGla3duFxh+oiWkgfKKwPluwa82pAqomyoJaxVFC2MEL1rqqDZR0Ew6OFt0sVIlZUrwLFe4TB6CXGn6K/HqI6pbahJ88b2m/SNFbJaNa2KNyBQZAxjwGsZn1LhnbkqN1i6mXA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB1677.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 15:54:42 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Mon, 24 Apr 2023
 15:54:42 +0000
Message-ID: <TY3P286MB2611CE0EA6C2E68DE64DA03798679@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 24 Apr 2023 23:54:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     wiagn233@outlook.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: x-powers,axp152: Document the
 AXP15060 variant
To:     Lee Jones <lee@kernel.org>
References: <20230417090537.6052-1-wiagn233@outlook.com>
 <TY3P286MB2611439E0FA49C224D639062989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230424120837.GA50521@google.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230424120837.GA50521@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [d6rO/Jvcu+lfYOiKqOx3lQj98dBfg8z4j+GUnzhg5R4=]
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <8962427b-9e67-d794-81b2-e7daf5284011@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1677:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec22811-0030-4a3e-3df2-08db44dc3792
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT8wRrMOmTC7gIiazLgnsCtwc0nksGTj4nbD3mUX18ZxoLbxpOtclPmeAk8X1kqhb7llsOrXxPekmERKuwVHOrRs1KCxqeFjrT8SUm8b4pD+TZVUV4AXW38YKGapdspDqqZz04gAj3SDa88npHqtlg6n+657zrRN+ZRnh6DcA7xXaTboGdl+KePYDO8JnJjzAi6R07mcAm2qqCLIsyPob0kGFzH+Xcg9RsH176BW72c2nikonxUJihkUSllBpKjrWj9dnuXOUJreUfUfZwzg//xajgEvL+/bTMOx/PQGx0lwF9dcIIQjjy34R2XL5+1quE1sxJfuUS4/VPJIrs1G3zBQZ7oqLEfdKJP9c6dQLYLL2BmUdiaIiIYP2LTX5hjgqJKppJQhRmfMfm+jQghlMlUOXoWQWMDRDIX6YsVOb2Rg3954KOzBCydKM0IT/L7y2hU5EPy2649oWxj14eMoEw8Y1hPYymfwy3xnRGZ/zth30Lx7GrWSV8IDlYYszid7QFtk+Uq7JK2gDae3mt+5aYAL00WXeFXpjcMXdAKFipl6lmd06yE80j8nfZ+65zYSaIS4D1xfVfwg0MCdh3CNay6RT7co5Rv0LvWRAjtbamoTIpoaY+si7AVrxCOcFoGm1w1EcNfR0dFm0jYvOwwR9RDkxvI0jsmvrGovwD37LLhEIY9XYKubcv3sAp+71uzpIKuLDexqMVKbce+birjAy6vCT81H/08TJubNJla+P5mn1E50+iL78VVaUUX1pA/bU4GDLNfTvIVaIx7czgvqq+yfKygMVTYwWGxlpQ8kV7cF56dkAH/QtP2N
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dvpaZbtdkGV2JZXiNxEXz7KhY3tteAw2rHWccF/GnLtMnlMmI3pI7GFt0mCn1vMz/bIeUWZAmNHvqd5c1QD9P9k2OP4tEbNQ6CAYppUol+LK9MRzkdTKc1onnFr2VAU7GtMPqm6ey5RBLDARUd1FjqH+pL24eSVOG1MaOg+nV/6AitvnlMruGxTw2sMYkWEhhz+b62i7iOq4f4s+hs7mFu1qoF78FavqNn5o2clY9xHv1yOKsHnGwpKuuFCA22Ui2oktSHpcIEIPfokdCBA/XYN9fmlRWgKclyseozY6hxZtjiS2Yd8IliBMXTc5eD8avL19Obtvr/2HkcudF2CPW9hT/PVBUdF10IYG/VqszbolfOJDB/aj9uqK++/nwolf5Uf4dAncrZYNQU9mZoh+3Xj1y1RiFaIsxKan/tC8iZeY++A0wMr9qrM0/Mz5vOEsZMpmBAfSmUpxiRNbzgvbh8xuk2rGuv7w8fhoMD40jT695kN5KmdeN2JkCvzhepyGmlBgWu17te2sVI9Pz8Xavz/nQqIaZKTVE5DHJs19v2GnRP7OwzuGUXdPyihZCl2YorVlPsl/tHW/izwQG3zvN2xoZ1wCdbdq5x00SmbcfX/6+7Y9hsq21OwzYAnPWxR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0k3cW5yR2ZlWWxHTndLSHRaSnVhQTNFMDUvQlcrSFE2TXgyOFRycnA5VHFq?=
 =?utf-8?B?dkJZRi93QzFlaEpGRFRGZVlVTWx1cUJ5ZUtja21ld1RuYjFGbnhLeGJYNHcr?=
 =?utf-8?B?QzdTMk5vTGl0ZkFxRUhoMThtNXhPQW9EYVpGR2VYeU8rMUVaRFRNRUVHTS9k?=
 =?utf-8?B?U0dCZTQwbXVLSG1uUXhRYWtLaUdLb0F1U3BoNWUwZU9rWERaeGdLcGMyRTBh?=
 =?utf-8?B?dlpKYTNxU29LTjc4dUttMjFhSUVGbkxYQW5PWG9MVlVBYXU4Y2dhMG10ZStP?=
 =?utf-8?B?RmE5N3EraXBxTVZPaHV6T0ZLYm9kbWd4YmF6NHE3OXdIR0pPdTM1QjNsc0JY?=
 =?utf-8?B?dzlOZ1BsR1UyZDBrcEhWMmV2dVZUdTdvSC9aVEcrNzM4K3lYUnhwemNnM20x?=
 =?utf-8?B?SU90bFcrK3k2ZklDams0ek05UEk2QkV6YUpVUk4xSEV6bFFXWERnV1hReHNj?=
 =?utf-8?B?MjJnWVYveEhDYXRYWkJUcVFzR0MrYkNQMHhKcWFuTTZ2Sis2RkJmYTc0ZGxD?=
 =?utf-8?B?WUk3V2hOS3F2RG4ybzBQMnRSbGIraG1Ub2hBV1NBS2dZeE9tQk1sOU9sdWtD?=
 =?utf-8?B?TW5aZjhPT0dMaVphMkx5bW0xZVpwcUFDWGV4RkFVUzRHRFN6WnhiWElXcFlO?=
 =?utf-8?B?MVZPYlFtWUlhVC92NDV5RFlRN0pMdTB4YzFHa2pFNWp5Mjc3R1NpYTk3U0xm?=
 =?utf-8?B?azYrYTFyQmkzazE2VkZ5eDY2UnJaVU95OGJkUXlYUklMd1ZkOUpuSG1ydjVi?=
 =?utf-8?B?OTI1dHdadTZmenB3Z21MY3JNcmdaWExJMlJuRGpGQlB0UlcwRGJWcStaaFJG?=
 =?utf-8?B?aVd6bndITVhVM1VMMGFjWXNxZG9mYU9MajBkR3lvcEZBTzFEb0RveXBxOFVs?=
 =?utf-8?B?RFhDSmNYMzdiUnplbXZVYWR4UlgvK0trSkhxWm5pSk1EMHVEU3VET29PZXVy?=
 =?utf-8?B?WkN1SkIrUkwxWE9oRzdoTEl0T2R5cmlUZmplaUpVWFoyOTdjM3o4RlJwcmdS?=
 =?utf-8?B?d2w4anNHVXBzdFRpcElRTFNPbWI4eGxTdE5BalpxYUxINUpmbWhWSHNtaThv?=
 =?utf-8?B?cHVrNWtaOFFlWHNEcVdiWGZrSUhqOEFKd0pmRkpmNjBLY29XZVFlVHR1dVFl?=
 =?utf-8?B?V1EyMkVMT2FmVi9Eaml2RFZyNy9ScWkyU29Ia3VxU2F1MnQ4bGhIU0l6aWFS?=
 =?utf-8?B?K013ckVCQzZrVEliNU1lV1lTck1JL1hVVk55UjE4bnI2N0VydWJBSFdGdkZt?=
 =?utf-8?B?TVA4RTZvYk9WcDFHcWJ0WGd0ZDZpbmcxS2hDNTN0Qkd3OGV0TXlkSkphQ1Bx?=
 =?utf-8?B?Vnh1U0gveGM1T0gyZjVJZDhMSEYvdXlEem14QklZc1pWYkZsNHlOZWlOdmlG?=
 =?utf-8?B?RzZOMnJiQ2RtU1JQRmpnK05mVlZJWkJUUXllMTUxOUZkZCtHK1pyWkdSckt0?=
 =?utf-8?B?YzAwV25rZEJpd2NSckYremN1R2wwaWlZOWRBMW9LWmRuMVZPUjJoV2x4L1d2?=
 =?utf-8?B?TWlWMkFDNDlOYlczaE9ENFhROFMxTXdCd2pyamcrSjR1a1pzOEZPK0V3V01D?=
 =?utf-8?B?SmUwbUJydlNjVFBlSUkveWo5V3BDRXNwNWkyMnhVY1BhajQ2dTU2blMwUGE2?=
 =?utf-8?Q?lEVO43N1tCCnBja5u5aADDdIgBxMdh8Kt3j3olr+hCTY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec22811-0030-4a3e-3df2-08db44dc3792
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:54:42.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1677
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

V3 already sent [1] few days ago, with patch 1 modified, please change 
to v3.

Shengyu

---

I didn't use reply all for the previous mail, so I sent it again.

---

[1] 
https://lore.kernel.org/all/TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/T/#m0d1b78a5f561c4192cc2e9d409ba552ae60af986


> On Mon, 17 Apr 2023, Shengyu Qu wrote:
>
>> The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
>> relative compatible item and CPUSLDO support for it.
>>
>> Changes since v1:
>> - Move cpusldo before drivevbus (Krzysztof Kozlowski)
>>
>> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> Applied, thanks
>
