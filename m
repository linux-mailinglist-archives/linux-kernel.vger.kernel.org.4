Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39662E27A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKQRCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiKQRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:01:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312514877C;
        Thu, 17 Nov 2022 09:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcFg1Zg5wd/SVPSC763YKhyhOGvqIZk2qlYnJbRILKR5SeCAq65UB9j/BKZVj6+dsN6nZyPAMAGTsa326mxjz1NmYBsJHzJ24Bn1nK9BCCc9+rVK2uhViZYfpjl42TH1qzHLILHD1mVbTJ/WG4w5JiCkJRISiO13A7tjroRl87Ga1PaLJKb3X65cWnMA8J+6Qrb+ts1ZtrdsioPMLTtj+ljRtbumrRnGvT1jjFSXuu1ZsssnEQa3MBfP9IJPOt/83F9wQ/PZHtIq36YzDstvVQZuR1J8G9m5ntkYr3NGDqghBhgRv5f7QaCpp2Vp64ZRtpmmcwJcwPTZItGRLjLGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtZ4BF0ghpqq+VYMOMjxDZUzrTvkxQk4Giy3vs5J/jg=;
 b=LbzhcJzkjxj+GeJTz8VGLF14oA+Kan9mJ5wMtNn/MvxO4rFQpfPZqxYhpPgQgAgMayGwnK4NaE1W3wDAfuoIES5ATl+w/n1BQKFxK1Zg7ExIV7sB+AQZL13qYMec6COke2ryjGxdhq22W1VMb2jRIVLWl37nQ3SjHI9QXcLhC7Pcg66qOhZPQ7gqu5xId9IUye8yd5ID60djdox85ONQ13A8LhPvMLUBqIGBZ1fDixtGBLgrDV2WcpV4+zvTtOhNjh6mPAl4sdyqYJJHwf5G3r6Trl0qPjAoK0CejFzOPFzvNHjGan9SXI/1//nFxSZsc9P0MpVQO1bm4c+htDN3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtZ4BF0ghpqq+VYMOMjxDZUzrTvkxQk4Giy3vs5J/jg=;
 b=mCgDhvsTRZIius9YhOZ/dV6vqEZyFBX47WyLvbhUjkaqxveGf9csZ/LBBVNuWGqEU6t7hAVtNpv2fbAh+9M66oFrAL1/QzxtWNBrcY9QXkSM3FtDTG+kLkjCtEYWEROJSLrDzqOhn9KaS5EbpOca0ABXAO5vF5PclfwPYbiFZVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS4PR08MB7479.eurprd08.prod.outlook.com (2603:10a6:20b:4e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.6; Thu, 17 Nov
 2022 17:01:27 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5834.007; Thu, 17 Nov 2022
 17:01:27 +0000
Message-ID: <467929c1-b405-507b-033d-bdc7abce703f@wolfvision.net>
Date:   Thu, 17 Nov 2022 18:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
 <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
 <20221115174355.00004a01@Huawei.com>
 <f52dcb6d-30ec-3d49-7e28-9761462d4799@wolfvision.net>
 <8c2da24c-ae10-40c9-bb3e-b300975a86d7@linaro.org>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <8c2da24c-ae10-40c9-bb3e-b300975a86d7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0701CA0040.eurprd07.prod.outlook.com
 (2603:10a6:800:90::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS4PR08MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 14308967-667b-4422-c7d8-08dac8bd5d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un3KyWpQtnAC2SwH6xuNansDbXCnAQYr5pSTJ8eR+d25co/sdL7nAJGMsZQMA0XCMrRAWyuTPE95hdcLWo0nEOHrODw266zjr5Y8fIrZmf8wbxOqJn6p225Vr/9jTmhAPLUQo3uWTCeKzNKttsmTFHgRz5hdrmEn9kLkjdW5/tAu3TCx4l9sQA8+fIco0L5wE3p/cpt+UmdOX42MuezVU1XLKdZhvCbz3nlarf78UoeRZVDsKqg3n9zLD7TjrOhyy5UQI4xZ0b++x/hGXnX23vZiBdod8AIF8fVSokmLjpIDkTqfpyxWiV8vw8B62jDVj0y0HPa6GJP7ODj4qiXY4/wBZhnnHMLo1o+b9xKyV5R8UqHtJFQXFdI1mmynrtRmD1JUjtaKbHHSvxn0RhZCjcyTe4fKyIa/0t9B44MvXWln0UlrTO+IlTxqZVr9HyChKXKunqN/kYq3QTJmI0iqcpS5FxIRhiKZC4JjBDiGLLo7SjKoQIXahCfzvK9jtWKxr4dYv5As28eqCd27q1L81eDmMBU/L9LDso05FcIyT/YPPHKwNJMyXrlaN/OPAa6yyGGvuSNc+LCrk938AIeqlhYU6WHq9HcOHX03h7y9KsRlpMHA4ay/J7S0VGWkdBgr9ZIE8t6JgaUmuJhD2E8Pys2sXjqOzNb6DGVn1Je7UiEUEvlN8WISIjxiRACC0fS2JiET9DghzPkylOdEa3ZEi+mjlc/CmCb6m19sYcpH7jXksozXVZpbsLncewqruf/A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(451199015)(6512007)(6666004)(52116002)(86362001)(26005)(6506007)(31696002)(36916002)(53546011)(6486002)(110136005)(316002)(478600001)(36756003)(186003)(38350700002)(38100700002)(2906002)(2616005)(8936002)(31686004)(54906003)(7416002)(44832011)(66946007)(41300700001)(66556008)(8676002)(4326008)(66476007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm54Y3RSeVA1dmFEOS91ejJwL3ErUFlVekg3Nm1DY2pmNXBTWi9aVWt0Qmds?=
 =?utf-8?B?dWhlM29wdzRVWFpnVHVmWDhWcmlwenpxYkNyVUp6Qm4rWjFjZVJYSmx4Tmtv?=
 =?utf-8?B?U1JOeVJQUG80SVREenZxMDJmRWE3eW9aS1QrT2JkSzZzMFZyTzYzRGo0WEFs?=
 =?utf-8?B?MDdveSs3d1p3NmdkaHBNVnVSdGxETEcxckV4Y2ZtaE8yK2NjSGtLVFVYN0ta?=
 =?utf-8?B?eEpIbXdxTkRrRUFRNFRtOXR5dmF6c04yOXFpYjFvMTc3a3JTcTdWRzAwMTE5?=
 =?utf-8?B?dkxoTkljVmVaVDduSVh2OFU0SzRtekQwWkl4NFJMczl6MTJ5K0R2b24vU0ZT?=
 =?utf-8?B?Y3pIQlNJbFVQMTQ2SndMbGVRVjhYU1Z0VGtnSjU1V2xEVkNwc25MQmJlcjRW?=
 =?utf-8?B?ZzcxVkpzeDdLVmlacUJkaUdTYzVvVGEzQ2VoZ01peGc0MmYwLzFOWThqemRa?=
 =?utf-8?B?aXVzNDRua2dTcmEvbHdXYkZaNFZ4bTNVRWorbDlSQ3JjZjMraDFKUDhMVzhE?=
 =?utf-8?B?Z245OUpDRUNVNDdwYjVZSXdiSm1sdDlxK2dNV2lJOGJsMnJ3clVIM3YvTmww?=
 =?utf-8?B?cm5hMmpZK2d3cWdlc0kxZkkrclE4MUMyTTdyNHdZQ0pSN253Si8wdlFpMnZS?=
 =?utf-8?B?RmpobUQyaWxZRXdUWkZEWkJabnlzSk1LMktpNkp0TGpoK0p2dU5iem0vT3pq?=
 =?utf-8?B?dHdqOUxuOTJIQlVobDdERkhkdzFtaVFmbU45VlNuSlNkR2M0bW1CWkJjQkxv?=
 =?utf-8?B?OUZka1JHYStTc1pYMy9XRkxtdGExR0tLbWRBbWFzN2RUam4rd1YyeHVoQkxZ?=
 =?utf-8?B?UVJFbW1HazhqRzhSZjN3T3hVK0dxTEZxam9BWVY5RkM5bnlCTU40OXAyMTQ5?=
 =?utf-8?B?M1RiU3pxUzIyelNXN2hGL0ljRXBIcTQvZUlEUlI1T0RPUE01WTNQWVVjYXkr?=
 =?utf-8?B?bUpaUURmQ1ZITmFHWkt6M2R6eTJ5TEtuc3F3a3BLazdnNDkrdmRmOTlDS0dM?=
 =?utf-8?B?Ymt4WnRpZ0pabFJ3d2UrV2c5Y2Nqb09nYlNNcEpQNlE2dXhQWU9zV2dzTVNu?=
 =?utf-8?B?OVBERytEUUpodkN1U3RBSVB0aWFIMmZxYlBsbU1UQVN1Rys1OWxyWEwvdDJi?=
 =?utf-8?B?Tm9id0tMZzJadlE4aEtYRmh5UzZSdFlRNGNqUEVqTklpeXgrcm1VN1lJeHZ4?=
 =?utf-8?B?blpraGpVc3UyNTdOTHJCNU94a3pYeDNyay84TTIwNVpwU0VIUndDSnJnS3Y5?=
 =?utf-8?B?WHhVeTBRYnZ3OG1tcktmKzhMdVJ1NThMWGxBNjlvMkpJRWV6cjdDbFdleGdB?=
 =?utf-8?B?bHJDcEJ5SHJKTVB4UkV6VVhyS0tETXVEeGNxaFYwSnQxeE5rcEpWcU9vb0Rj?=
 =?utf-8?B?UXlDd3JiMFVYQWZyb3VGaEFMSXpNZjhoTTJqZXpSNXZQSVkxTk44UGppTWhE?=
 =?utf-8?B?UXh0MnZSYk80T0grNFk3MmpnUTNJOUZkczE1WCtPNDJERWcraXdWM0podEJO?=
 =?utf-8?B?VjdQVkdyZzA3L1NGM3dYWm5SNXRORHdMN2JBUkF3RGZjYUg5ZmdtNjhWWXBv?=
 =?utf-8?B?ODlyVjE1RW54ZDZ5YkhpSXk2N2h6enVUQUMyc200d3VyS1FhWkRvczRSNkFP?=
 =?utf-8?B?Yk1PNzl4ajNEWTRGZ1Vmb2crcXpRbThiQUJHU3U1TEZycisyenoybng1c2t6?=
 =?utf-8?B?VU1oTitmL3E3TE81K3owdGp1M0JtRVRqdDdEUnhZZG9pZ2NZL3RtMWhjYWcz?=
 =?utf-8?B?VzQzVmNjMkRqTldFdHpRMTl6cERDNFJLdkF6WTVXV0FQelAwclorTWRRWks5?=
 =?utf-8?B?ZjBGUjJXZUJyRUc2dFlIaWhMZ0YwaENLQ1JETGdkUkpkb0JoVW9sb2liU3By?=
 =?utf-8?B?b21aVzdRR2dlRWR3b082d1N2QlZOQ0Q3anJQYUJodWxKbklwTDMwNHd2TzZF?=
 =?utf-8?B?am5RVEliR2tmYjU4OGN1NWNXS2J0Z0ZsdmhVRERNNGR4RDFvU1BmZGNEWStl?=
 =?utf-8?B?MW1POGpQeTNrTzJpZzZ1WHFjcEtZUVM1cTFsSWdVWlVYZGNPWDZoOXRhaGpT?=
 =?utf-8?B?WkZVVnZhMXVHVWtiaFZIY09qditJUXNzb2w3MjlRSVgyTnZ4TjJnMHVuVHo4?=
 =?utf-8?B?eTJQUjk4L1h2YTlCUTFGVGJ1UmJ5ZFRPT3RrNlArOFFGcHdXZ2ZFNktNaCs2?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 14308967-667b-4422-c7d8-08dac8bd5d0b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:01:27.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mq9LQs8qlX6+rWQDeHWQhLy2cqwmwzt7z9bZMpaqvIdI6OBdieEf4Bskv5JeTICdpm3Jtmtq0y3n/8UbD0Lt9zQBSI86AEM5gRRrqHQXs1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11/17/22 17:17, Krzysztof Kozlowski wrote:
> On 17/11/2022 17:12, Gerald Loacker wrote:
>>>
>>>> +
>>>> +  compatible:
>>>> +    const: ti,tmag5273
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#io-channel-cells":
>>>> +    const: 1
>>>> +
>>>> +  ti,angle-enable:
>>>> +    description:
>>>> +      Enables angle measurement in the selected plane.
>>>> +      0 = OFF
>>>> +      1 = X-Y (default)
>>>> +      2 = Y-Z
>>>> +      3 = X-Z
>>>
>>> This feels like something we should be configuring at runtime rather that
>>> DT, or is it driven by board design or similar?
>>>
>>
>> We use this sensor for a zoom wheel application, there is an EVM from TI
>> for this as well. So this is for setting the mounting position of the wheel.
> 
> That's ok, but does not explain why choice of angle measurement should
> be a property of the hardware. I could imagine configuring device to
> measure sometimes X-Y and sometimes X-Z, depending on the use case. Use
> case can change runtime.

If I may chime in here: in our use case the angle channel is used
directly as an input to adc-joystick, so that the combination of the two
is an input device. We feel that in this scenario this angle measurement
setting *has* to be a hardware property because the correct function of
the input device depends on the correct choice of the angle property
(which does not change during runtime, of course).

If we were to create a different input device in which the magnetometer
was tilted by 90° (for example), then the angle property could be easily
changed in the device tree. The user space, on the other hand, couldn't
possibly know the correct angle property.

That said, I agree that there may be use cases in which the angle
property should be changed during runtime. Would it be acceptable to
create an IIO property that is initialized by the device tree property?
(Please note that the implementation of the IIO property may not be in
our scope, though)

Best regards,
Michael
