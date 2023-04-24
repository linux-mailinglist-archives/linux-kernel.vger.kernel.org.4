Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DC6EC37E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjDXBwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDXBw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:52:29 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B531B3;
        Sun, 23 Apr 2023 18:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZT7xF/HGq8R3dfjrSmZsrezU0fyYKnTPyXVTesaFR4nYHACZ53Cm+GztXoDVwQYdIuw/TzKtzMOeIxKn6t7Hs55fsnS7zuwl4a41/6oqCtIHaUcSym1u9qNvpQQpo+ENIZg47PfYxqdDslIzm105/S3K/FAilz3hx+B2XC6T7qMreoiRYXqNhhqv7w6Z+gDzdAG88z9uDxumvxuMcEN1O5eYPqfFJI4iHDuwKwXTfqKnRB1o4LwHcfbIG1fn8mdBDsCBIXAkEbqC1darBzHiJ3ewNHk8cUPLmMLQirkiyKdNp6lXjuE8eWvA36q7yhbZubQ2VFpe4zY2cz36niSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPO8JJE5W3cZaRFUWkKxZdKmEMWhM0nvE6XGoqfryiA=;
 b=BqxAwamU1oZKsU0YiW/M/we0BSmFWzPk+J1ZnTakAnea0+IguUGvSeoapuw51leDeMZQxq1TkIzQqq+2i/pwqx+gV/dv7fcerExVXj1V32UVT4+rp2Zm4bzX/+5s36CW1PDvSGL9O3ryZDxHiCjWFtaTnPPZIYPdkfog4Iyd6Zx9dIayDdqDN1VWEgnFwQavL/3c1TZkcmSVZEpCi8VImHrRseRQKHAsfCRdF0iwwOhRLN2gFydk+M5QtjJs46GTghc4Yp5FSxVj5BiTYfYu2VIgkXzI7wByo/XdM4Hd7q09+DxCfLgYrnCLYKgBJ0uVZmQJfCcYfRalK3wuXQTwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPO8JJE5W3cZaRFUWkKxZdKmEMWhM0nvE6XGoqfryiA=;
 b=Z4Efg34I5+LnrACVdEylnPgVC2UTvY8JLecFHS7kjZll6RY1YoGQn5TXfLwmf/VoZxYhP1+BR7h9IR4DKlt3NizEsrWHHk7O8vIiMQm9LJ6Jt+hsXH6BGkrtAZXXQtq+nx7VxnB01XtY1nwkFQeqoLdRTXCmuDX9pK8OVOEpQEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 01:52:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 01:52:19 +0000
Message-ID: <b9eca9a4-f4b6-b98c-2861-eb14380d2d5f@oss.nxp.com>
Date:   Mon, 24 Apr 2023 09:52:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <6dc456ff-7fc6-3b73-3727-dd048e9a9629@oss.nxp.com>
 <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c14d2dc-c507-4164-1b8e-08db4466897e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDWh+iwkyYgAFsZrD+gc5ZqQhEP+bBBS094eaikLGcPD9mIR4kzHVSE5xTEsb+rb+uOtQ3vMVPafdxRASO8y45HgQDK5p+bwHRDrfZeU9zYCcVQG2SPqo7Ffr2M/61otmfzCkT5PFJvJZLSzNuhZ/bZbxIyMHn+0b1woM2Um6IW+xrFUeju3Rjld2yzAt0+U7bkVSwLHR0E7CAlO3womTr7EQWILVh15YyJOrAaUn/U3xp4VaOQHsIP9eMraIYqrm5nydDbCD+AcBL/x7lVZai428hpxIaPoWC7390nc1kyk2fVt/wCZVopzKKe0iL1g9BhvT/LCa9kA25U8/MLhcFHDQaENVW45A/5N9SKFRgMggqFGXQ2v7pVjoQBCCzbHKMkga0ghZ3W8ISVvlqfIIQfXHGGgSCWJxeXNTrLXCd/PBkWPqMroDg54aSgz49QQkYDGRKcc0+Wyk9B97VzJ4y7yF41Hu37UxG7qJ8hHYMJ5B7dHnnAbCs4z++86RStT0IVrbrUIu2zQz4z9/7hiJyqRzpoJPdILWkZYkDEOoM6MxCKs8hHAQvlZ+kp+3mxg6qEVbcIcqOrybAW8vQrNXzxlsR/GluLD/+iTZOCBa/wrYBTMj/W3eu6+96qFiM2cSbMUWC/6uXpFZQ5Hue8Gc9QJ4BvF2n5TOtlGEHD8mA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(30864003)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(44832011)(7416002)(8676002)(8936002)(5660300002)(41300700001)(31696002)(86362001)(6512007)(26005)(186003)(53546011)(38100700002)(478600001)(6486002)(6666004)(966005)(83380400001)(31686004)(2616005)(6506007)(110136005)(54906003)(45980500001)(43740500002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hrcUptSm5ITzRNT3RNOXJ6TE9qSUJNYTVXMUd5eEpqZS9JSHN2WDE0L0FW?=
 =?utf-8?B?UHFmQ1NYc29Wd3pIMlBLbTdpbGpVSU1pR0oxV0grSndmMENlbmt2ejhxNjNm?=
 =?utf-8?B?aGpKc1orNjlEczJFbTd5Y0czRnhJOVl1R1krZHc4aVc2eENxTld3QXhPWW1q?=
 =?utf-8?B?alIzNjV2QUZ4MGVsbzJ1VXMzQko5QzRsM09ZQjhlend0aVBsWi9KeVJhQlk4?=
 =?utf-8?B?Nkx5c2lHZUo1V2d5cEJ2ekFyWmpoTGt6RzRWYXRZSkZZZWphbVplNldwb0ht?=
 =?utf-8?B?VER0bnNqNU5zNmpJN2Nyek5oeFBrS0NoV2JiT3p2YzFuQnhRcTJWcDJtVVMv?=
 =?utf-8?B?SG9GR0lwMTBuMWhEL2JsZlVsNlBzMWlMT3p3QWIyaXk3U1RFNmh3bmdxVWJJ?=
 =?utf-8?B?QUtnVFN1MUpOblZHWGQyaXh5L3VxV2hCb1FWR3JEbzBFYllIY2lndnVDcmdl?=
 =?utf-8?B?Q2FNTzVJZUY5ZzBUT0RVaFRRWFFWNFNLSGdSaWZCMW00VERXaXJNQkVWM1FK?=
 =?utf-8?B?S0RMVXBMaXkyc01LWlFLNnV0UllobGJsS3dmSVRhRHVRMDgybFZ0M3daNlpZ?=
 =?utf-8?B?ckUxS0krZnJQN1hWQU5UeFFscmJkcEl3NGpicDBMY3FlcVE1dGJ5OVc4cmVy?=
 =?utf-8?B?UFE2b0pBZDdpRUlTNzRCQzdzM1VwUWF2OXZJRkRIcFoyYmZGSk1oSTI2ZzRX?=
 =?utf-8?B?VE9YQ3VWYjRUenBKTjk2TVpVand0a1VtWHdtUGJyZkF6c0V5TjNWcmVHRzJH?=
 =?utf-8?B?eXVJcU9TVXJNUGZUbnFldzQ0UVRJSmRGaFA2RkhIZitLUERpb1YzRUh1ZG9x?=
 =?utf-8?B?WmlvU0hna0x6Sjl3OXNGNmZQYWxSQjNBV2lFRSt1MlhvNkNzQVBTNk1CMnlT?=
 =?utf-8?B?NmJUYjE1aG5mT0pGSnZYNXlRZ0d4STBxbnlVNWtMKzMvNVFMWlh1K2txUWI1?=
 =?utf-8?B?VUVtZ1JTYUFUYmNuYW5sQkQvL2JFTE5yVDFzV0h1NFJJT0RGUEQ2QmNiWDk1?=
 =?utf-8?B?Q2NzZU9CWnNYRUJETmRBS1dnWFZuaWhMT2VUbTE5Y0RibVpPajErWVFxUktK?=
 =?utf-8?B?Wi8vTlBJejVaT0lxZlJ6SEtueFFwR3dKTFRmZTFXcG5vaElUUU1ERUttYUpR?=
 =?utf-8?B?dUdBOFFHVzBlMG41MVRMMUJ3NXJoNnNBTExqK3dOcXBubWJvamRmYktDTEZ3?=
 =?utf-8?B?RXJoM0d4SmtGbHJUUnlXTnRiZWMxMW00ODkvSzFrak5ycjEyZkppcllwTHJN?=
 =?utf-8?B?QVFOaCtPYVE4Yk9JM3VxZFpFR0k3UjYyZktjSjQvVjNnRnZRUVpkQmRwQnFp?=
 =?utf-8?B?bWN5UlNLTjE2VnRlTGxaekxIaUtLV3R3RzIvUWR5U1pMU2pHVDFVcVNWeVFC?=
 =?utf-8?B?bi9kc0tkYWdFbG1FbTBtRWxQVCt3K2ZzWURiNVdITXVxUDhkRXFLN3pkRHYr?=
 =?utf-8?B?WXhuRnluWEFSR1VCMmVaYStDY2hCT21rek9obmVEQ0FiWEJWR2JQZG1lWUd4?=
 =?utf-8?B?N1MvNE0xVzFnUjBlK0lzcHpLVlpkTWlScXpCRVhNQ0tvWXBaU0U0QmJYTmlE?=
 =?utf-8?B?YnhUOVVOREZUYnhxeW1uV3JxMEdYNkZrdUZhTklQMGE1azJSd2tNUWR4OWYx?=
 =?utf-8?B?YTZuSGJYVjdmZmNObTVmc01zbWM1QStvNHJwdFBNaG1YTDljUHBFMWNsM1VO?=
 =?utf-8?B?Q0tNbndzRGI0S3ZGWi9uMUFlVDdXUEtUdjRXUUgzVHY4RHlReXNkQkR6aWx6?=
 =?utf-8?B?eXFZTmRjUXh3TGE0QjFvYkpHdGpmWEN2cmxZaldEMGMvaUtSZjV1U0JrVG5F?=
 =?utf-8?B?SjF4bUl6Z0VleFRLVGRCbnhvUzF5TDYrcVRkWHBOZERZL3hobmNSb2NQS29V?=
 =?utf-8?B?alNDMVh0UFg5NXlRaFJUcThOQ3dLU0FIUS9nMEg4a1pyTFdFMjRDT3RKMjNk?=
 =?utf-8?B?WFBWK0QzelBrQ1ErL0RMMCt0bm1DTW0waTV1K3pySEMvVE1Cc0I4UHhVYjJ2?=
 =?utf-8?B?OWZCY1hTY2N6Y01HeVZXQjJXOWhJMWpJeVcvTTNkUFJQRndzanpOSU0rSVFR?=
 =?utf-8?B?RndxQml0cy9mV2RyTHJnZ3JCa2lzOWZPTHVXRW84RHBsUlZSZE5tOVp1Yy92?=
 =?utf-8?Q?xd3xfs0+p26Dy3+KBbpnL0UWx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c14d2dc-c507-4164-1b8e-08db4466897e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 01:52:19.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAPMyQB4t9+VLBFzAsNZkpoq2vEKvUndp/+nvp+FccDhbkluVYb3LPnjlRlFDNqu1UWCxdUHWjzCfinfv/2Xug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2023 4:40 PM, Oleksii Moisieiev wrote:
> Hi Peng Fan,
> 
> On 17.04.23 05:55, Peng Fan wrote:
>>
>>
>> On 4/13/2023 6:04 AM, Cristian Marussi wrote:
>>> On Fri, Apr 07, 2023 at 10:18:27AM +0000, Oleksii Moisieiev wrote:
>>>> Implementation of the SCMI client driver, which implements
>>>> PINCTRL_PROTOCOL. This protocol has ID 19 and is described
>>>> in the latest DEN0056 document.
>>>
>>> Hi,
>>>
>>>> This protocol is part of the feature that was designed to
>>>> separate the pinctrl subsystem from the SCP firmware.
>>>> The idea is to separate communication of the pin control
>>>> subsystem with the hardware to SCP firmware
>>>> (or a similar system, such as ATF), which provides an interface
>>>> to give the OS ability to control the hardware through SCMI protocol.
>>>> This is a generic driver that implements SCMI protocol,
>>>> independent of the platform type.
>>>>
>>>> DEN0056 document:
>>>> https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!y2hR3PEGGxiPjVeXBcgGyV03DPDhzgUKR0uHvsTpiafKgBar8Egc6oOOs-IkFIquhSf-qBzltqEMyzRZHq8eC4g$
>>>> [developer[.]arm[.]com]
>>>>
>>>
>>> No need to specify all of this in the commit message, just a note that
>>> you are adding a new SCMIv3.2 Pincontrol protocol, highlighting anything
>>> that has been left out in this patch (if any) will be enough.
>>
>> Is it possible to extend the spec to support multilple uint32_t for PIN
>> CONFIG SET?
>>
>> With only one uint32_t could not satisfy i.MX requirement.
>>
>> Thanks,
>> Peng.
>>
> IIUC you are expecting to have an ability to set some kind of array of
> uint32_t config values to some specific ConfigType?
> 
> I'm not sure if it's supported by pintctrl subsystem right now. I was
> unable to find an example in the existing device-tree pinctrl bindings.
> This makes me think that this kind of binding is OEM specific.

Look at arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts

Take lpuart for example:
MX93_PAD_UART1_RXD__LPUART1_RX                  0x31e

The macro MX93_PAD_UART1_RXD__LPUART1_RX is an array.

i.MX pinctrl driver use
mux reg, mux value, select reg, select value, pad reg, pad value

pinctrl driver will be handled by SCMI firmware for new i.MX SoC.

With current spec, only one uint32 is low speed. So if the spec
could extended to support more uint32 with pin config set,
we could use one SCMI call to support i.MX pinctrl.

Thanks
Peng.

> 
> Maybe it can be implemented by adding new IDs to OEM specific range
> (192-255) which is reserved for OEM specific units (See Table 23 of
> DEN0056E).
> 
> Best regards,
> 
> Oleksii
> 
> 
>>> You can look at the very first commit logs of existing protos as an
>>> example like: drivers/firmware/arm_scmi/powercap.c
>>>
>>> Some more comments down below, I'll mostly skip anything related to the
>>> SCMI API change I mentioned before...
>>>
>>> I'll also wont comment on more trivial stuff related to style, BUT there
>>> are lots of them: you should run
>>>
>>> ./scripts/checkpatch.pl --strict <your-git-format-patch-file>
>>>
>>> for each patch in the series. (and fix accordingly..spacing,
>>> brackets...etc)
>>>
>>>> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>>>> ---
>>>>    MAINTAINERS                         |   6 +
>>>>    drivers/firmware/arm_scmi/Makefile  |   2 +-
>>>>    drivers/firmware/arm_scmi/common.h  |   1 +
>>>>    drivers/firmware/arm_scmi/driver.c  |   3 +
>>>>    drivers/firmware/arm_scmi/pinctrl.c | 905
>>>> ++++++++++++++++++++++++++++
>>>>    drivers/pinctrl/Kconfig             |   9 +
>>>>    include/linux/scmi_protocol.h       |  58 +-
>>>>    7 files changed, 982 insertions(+), 2 deletions(-)
>>>>    create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 281de213ef47..abc543fd7544 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -16961,6 +16961,12 @@ F:    drivers/reset/reset-scmi.c
>>>>    F:    include/linux/sc[mp]i_protocol.h
>>>>    F:    include/trace/events/scmi.h
>>>>    +PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE
>>>> (SCPI/SCMI)
>>>> +M:    Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>>>> +L:    linux-arm-kernel@lists.infradead.org
>>>> +S:    Maintained
>>>> +F:    drivers/firmware/arm_scmi/pinctrl.c
>>>> +
>>>>    SYSTEM RESET/SHUTDOWN DRIVERS
>>>>    M:    Sebastian Reichel <sre@kernel.org>
>>>>    L:    linux-pm@vger.kernel.org
>>>> diff --git a/drivers/firmware/arm_scmi/Makefile
>>>> b/drivers/firmware/arm_scmi/Makefile
>>>> index bc0d54f8e861..5cec357fbfa8 100644
>>>> --- a/drivers/firmware/arm_scmi/Makefile
>>>> +++ b/drivers/firmware/arm_scmi/Makefile
>>>> @@ -4,7 +4,7 @@ scmi-driver-y = driver.o notify.o
>>>>    scmi-transport-y = shmem.o
>>>>    scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
>>>>    scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
>>>> -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
>>>> system.o
>>>> +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
>>>> system.o pinctrl.o
>>>>    scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y)
>>>> $(scmi-protocols-y) \
>>>>                $(scmi-transport-y)
>>>>    obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
>>>> diff --git a/drivers/firmware/arm_scmi/common.h
>>>> b/drivers/firmware/arm_scmi/common.h
>>>> index 65063fa948d4..8bbb404abe8d 100644
>>>> --- a/drivers/firmware/arm_scmi/common.h
>>>> +++ b/drivers/firmware/arm_scmi/common.h
>>>> @@ -170,6 +170,7 @@ DECLARE_SCMI_REGISTER_UNREGISTER(power);
>>>>    DECLARE_SCMI_REGISTER_UNREGISTER(reset);
>>>>    DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
>>>>    DECLARE_SCMI_REGISTER_UNREGISTER(system);
>>>> +DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
>>>>      #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(id, name) \
>>>>    int __init scmi_##name##_register(void) \
>>>> diff --git a/drivers/firmware/arm_scmi/driver.c
>>>> b/drivers/firmware/arm_scmi/driver.c
>>>> index 3dfd8b6a0ebf..fb9525fb3c24 100644
>>>> --- a/drivers/firmware/arm_scmi/driver.c
>>>> +++ b/drivers/firmware/arm_scmi/driver.c
>>>> @@ -743,6 +743,7 @@ static struct scmi_prot_devnames devnames[] = {
>>>>        { SCMI_PROTOCOL_CLOCK,  { "clocks" },},
>>>>        { SCMI_PROTOCOL_SENSOR, { "hwmon" },},
>>>>        { SCMI_PROTOCOL_RESET,  { "reset" },},
>>>> +    { SCMI_PROTOCOL_PINCTRL,  { "pinctrl" },},
>>>>    };
>>>>      static inline void
>>>> @@ -947,6 +948,7 @@ static int __init scmi_driver_init(void)
>>>>        scmi_reset_register();
>>>>        scmi_sensors_register();
>>>>        scmi_system_register();
>>>> +    scmi_pinctrl_register();
>>>>          return platform_driver_register(&scmi_driver);
>>>>    }
>>>> @@ -962,6 +964,7 @@ static void __exit scmi_driver_exit(void)
>>>>        scmi_reset_unregister();
>>>>        scmi_sensors_unregister();
>>>>        scmi_system_unregister();
>>>> +    scmi_pinctrl_unregister();
>>>>          platform_driver_unregister(&scmi_driver);
>>>>    }
>>>> diff --git a/drivers/firmware/arm_scmi/pinctrl.c
>>>> b/drivers/firmware/arm_scmi/pinctrl.c
>>>> new file mode 100644
>>>> index 000000000000..037270d7f39b
>>>> --- /dev/null
>>>> +++ b/drivers/firmware/arm_scmi/pinctrl.c
>>>> @@ -0,0 +1,905 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * System Control and Management Interface (SCMI) Pinctrl Protocol
>>>> + *
>>>> + * Copyright (C) 2021 EPAM.
>>>
>>> nitpick: update (C) years
>>>
>>>> + */
>>>> +
>>>> +#define pr_fmt(fmt) "SCMI Notifications PINCTRL - " fmt
>>>> +
>>>
>>> This is not needed, no notifs in this proto.
>>>
>>>> +#include <linux/scmi_protocol.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include "common.h"
>>>> +#include "notify.h"
>>>
>>> Notifs not needed, and in the new API world you'll just need a:
>>>
>>>    #include "protocols.h"
>>>
>>>> +
>>>> +#define SET_TYPE(x) ((x) & 0x3)
>>>> +
>>>
>>> Even if trivial better to use std bitfield.h macros like
>>> FIELD_GET() BIT() ... etc
>>>
>>>> +enum scmi_pinctrl_protocol_cmd {
>>>> +    PINCTRL_ATTRIBUTES = 0x3,
>>>> +    PINCTRL_LIST_ASSOCIATIONS = 0x4,
>>>> +    PINCTRL_CONFIG_GET = 0x5,
>>>> +    PINCTRL_CONFIG_SET = 0x6,
>>>> +    PINCTRL_FUNCTION_SELECT = 0x7,
>>>> +    PINCTRL_REQUEST = 0x8,
>>>> +    PINCTRL_RELEASE = 0x9,
>>>> +    PINCTRL_NAME_GET = 0xa,
>>>> +    PINCTRL_SET_PERMISSIONS = 0xb
>>>> +};
>>>> +
>>>> +enum scmi_pinctrl_selector_type {
>>>> +    PIN_TYPE = 0,
>>>> +    GROUP_TYPE,
>>>> +    FUNCTION_TYPE
>>>> +};
>>>> +
>>>> +struct scmi_group_info {
>>>> +    bool present;
>>>> +    char *name;
>>>> +    unsigned int *group_pins;
>>>> +    unsigned int nr_pins;
>>>> +};
>>>> +
>>>> +struct scmi_function_info {
>>>> +    bool present;
>>>> +    char *name;
>>>> +    unsigned int *groups;
>>>> +    unsigned int nr_groups;
>>>> +};
>>>> +
>>>> +struct scmi_pin_info {
>>>> +    bool present;
>>>> +    char *name;
>>>> +};
>>>> +
>>>> +struct scmi_pinctrl_info {
>>>> +    u32 version;
>>>> +    u16 nr_groups;
>>>> +    u16 nr_functions;
>>>> +    u16 nr_pins;
>>>
>>> Since these vars are not related to stricly spaced message fields
>>> (even though
>>> derived from such messages) do not use sized types, you can just
>>> stick with
>>> unsigned int. (it is also better not to mix sized and unsized types
>>> in the same
>>> struct). This also could come handy if these will be exposed to the user
>>> in scmi_protocol.h in the future (more on this down below)
>>>
>>>> +    struct scmi_group_info *groups;
>>>> +    struct scmi_function_info *functions;
>>>> +    struct scmi_pin_info *pins;
>>>> +};
>>>> +
>>>> +struct scmi_conf_tx {
>>>> +    __le32 identifier;
>>>> +#define SET_TYPE_BITS(attr, x) (((attr) & 0xFFFFFCFF) | (x & 0x3)
>>>> << 8)
>>>> +#define SET_CONFIG(attr, x) (((attr) & 0xFF) | (x & 0xFF))
>>>
>>> Use bitfield.h like FIELD_SET / GENMASK etc
>>>
>>>> +    __le32 attributes;
>>>> +};
>>>> +
>>>> +static int scmi_pinctrl_attributes_get(const struct scmi_handle
>>>> *handle,
>>>> +                       struct scmi_pinctrl_info *pi)
>>>> +{
>>>> +    int ret;
>>>> +    struct scmi_xfer *t;
>>>> +    struct scmi_msg_pinctrl_protocol_attributes {
>>>> +#define GROUPS_NR(x) ((x) >> 16)
>>>> +#define PINS_NR(x) ((x) & 0xffff)
>>>> +        __le32 attributes_low;
>>>> +#define FUNCTIONS_NR(x) ((x) & 0xffff)
>>>> +        __le32 attributes_high;
>>>> +    } *attr;
>>>
>>> For consistency with the rest of the stack (mostly :D), please move
>>> this struct
>>> definition and related macros outside in the global scope right after
>>> command
>>> enum. (and use bitfield macros ...)
>>>
>>>> +
>>>> +    if (!pi)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
>>>> +                 SCMI_PROTOCOL_PINCTRL, 0, sizeof(*attr), &t);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    attr = t->rx.buf;
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +    if (!ret) {
>>>> +        pi->nr_functions =
>>>> + le16_to_cpu(FUNCTIONS_NR(attr->attributes_high));
>>>> +        pi->nr_groups = le16_to_cpu(GROUPS_NR(attr->attributes_low));
>>>> +        pi->nr_pins = le16_to_cpu(PINS_NR(attr->attributes_low));
>>>> +    }
>>>> +
>>>> +    scmi_xfer_put(handle, t);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_groups_count(const struct scmi_handle
>>>> *handle)
>>>> +{
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv)
>>>> +        return -ENODEV;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    return pi->nr_groups;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_pins_count(const struct scmi_handle
>>>> *handle)
>>>> +{
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv)
>>>> +        return -ENODEV;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    return pi->nr_pins;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_functions_count(const struct
>>>> scmi_handle *handle)
>>>> +{
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv)
>>>> +        return -ENODEV;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    return pi->nr_functions;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_validate_id(const struct scmi_handle *handle,
>>>> +                    u32 identifier,
>>>> +                    enum scmi_pinctrl_selector_type type)
>>>> +{
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv)
>>>> +        return -ENODEV;
>>>> +
>>>> +    switch (type) {
>>>> +    case PIN_TYPE:
>>>> +        pi = handle->pinctrl_priv;
>>>> +
>>>> +        return (identifier < pi->nr_pins) ? 0 : -EINVAL;
>>>> +    case GROUP_TYPE:
>>>> +        return (identifier <
>>>> +            scmi_pinctrl_get_groups_count(handle)) ?
>>>> +            0 : -EINVAL;
>>>> +    case FUNCTION_TYPE:
>>>> +        return (identifier <
>>>> +            scmi_pinctrl_get_functions_count(handle)) ?
>>>> +            0 : -EINVAL;
>>>> +    default:
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>> Here I would just pick the right value to compare, break and then
>>> compare and exit, something aroundf the lines of:
>>>
>>>      case PIN_TYPE:
>>>          ...
>>>              val = pi->nr_pins;
>>>          break;
>>>          ...
>>>      case GROUP_TYPE:
>>>          val = scmi_pinctrl_get_groups_count());
>>>          break;
>>>
>>>      ....
>>>      ....
>>>          default:
>>>          return -EINVAL;
>>>      }
>>>
>>>      if (identifier >= val)
>>>          return -EINVAL;
>>>
>>>      return 0;
>>> }
>>>
>>> ... it's easier to read. What do you think ?
>>>
>>>
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_name(const struct scmi_handle *handle,
>>>> +                 u32 identifier,
>>>> +                 enum scmi_pinctrl_selector_type type,
>>>> +                 char **name)
>>>> +{
>>>
>>> As said, there is common helper for this, but it will need some small
>>> adaptation in the SCMI core to work here so keep it as it is, and
>>> I'll take
>>> care of this later, if it sounds fine for you.
>>>
>>>> +    struct scmi_xfer *t;
>>>> +    int ret = 0;
>>>> +    struct scmi_name_tx {
>>>> +        __le32 identifier;
>>>> +        __le32 flags;
>>>> +    } *tx;
>>>> +    struct scmi_name_rx {
>>>> +        __le32 flags;
>>>> +        u8 name[64];
>>>> +    } *rx;
>>>> +
>>>> +    if (!handle || !name)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, identifier, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_NAME_GET,
>>>> +                 SCMI_PROTOCOL_PINCTRL,
>>>> +                 sizeof(*tx), sizeof(*rx), &t);
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    rx = t->rx.buf;
>>>> +    tx->identifier = identifier;
>>>> +    tx->flags = SET_TYPE(cpu_to_le32(type));
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +    if (ret)
>>>> +        goto out;
>>>> +
>>>> +    if (rx->flags) {
>>>> +        ret = -EINVAL;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    *name = kasprintf(GFP_KERNEL, "%s", rx->name);
>>>> +    if (!*name)
>>>> +        ret = -ENOMEM;
>>>> + out:
>>>> +    scmi_xfer_put(handle, t);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_attributes(const struct scmi_handle *handle,
>>>> +                   enum scmi_pinctrl_selector_type type,
>>>> +                   u32 selector, char **name,
>>>> +                   unsigned int *n_elems)
>>>> +{
>>>> +    int ret = 0;
>>>> +    struct scmi_xfer *t;
>>>> +    struct scmi_pinctrl_attributes_tx {
>>>> +        __le32 identifier;
>>>> +        __le32 flags;
>>>> +    } *tx;
>>>> +    struct scmi_pinctrl_attributes_rx {
>>>> +#define EXT_NAME_FLAG(x) ((x) & BIT(31))
>>>> +#define NUM_ELEMS(x) ((x) & 0xffff)
>>>> +        __le32 attributes;
>>>> +        u8 name[16];
>>>> +    } *rx;
>>>
>>> Ditto. Move these defs outside, bitfield.h for macros and try to use the
>>> same naming style for message structs as in other protos, i.e.
>>>
>>>      for commands:     struct scmi_msg_pinctrl_attributes
>>>      for replies:     struct scmi_resp_pinctrl_attributes
>>>
>>> (or some variations around that...
>>>      scmi_msg_cmd_*  scmi_msg_resp_*
>>>
>>>     we have not been fully consistent really, so I dont want to be
>>>     pedantic here, but we never used tx/rx in message context since it is
>>>     already (mis)-used in SCMI channel context...)
>>>
>>>> +
>>>> +    if (!handle || !name)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, selector, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_ATTRIBUTES,
>>>> +             SCMI_PROTOCOL_PINCTRL, sizeof(*tx), sizeof(*rx), &t);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    rx = t->rx.buf;
>>>> +    tx->identifier = selector;
>>>> +    tx->flags = SET_TYPE(cpu_to_le32(type));
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +    if (ret)
>>>> +        goto out;
>>>> +
>>>> +    *n_elems = NUM_ELEMS(rx->attributes);
>>>> +
>>>> +    if (!EXT_NAME_FLAG(rx->attributes)) {
>>>> +        *name = kasprintf(GFP_KERNEL, "%s", rx->name);
>>>> +        if (!*name)
>>>> +            ret = -ENOMEM;
>>>> +    } else
>>>> +        ret = scmi_pinctrl_get_name(handle, selector, type, name);
>>>> + out:
>>>> +    scmi_xfer_put(handle, t);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_list_associations(const struct scmi_handle
>>>> *handle,
>>>> +                      u32 selector,
>>>> +                      enum scmi_pinctrl_selector_type type,
>>>> +                      uint16_t size, unsigned int *array)
>>>> +{
>>>
>>> This is the other functionalities you could implement straight away
>>> using
>>> ph->hops helpers (iterators) but just leave it this way, and I'll
>>> port it later
>>> (once we retested all of this as working with the new API but without
>>> any
>>> ph->hops usage..I think it is safer to change one bit at time... :P)
>>>
>>>> +    struct scmi_xfer *t;
>>>> +    struct scmi_pinctrl_list_assoc_tx {
>>>> +        __le32 identifier;
>>>> +        __le32 flags;
>>>> +        __le32 index;
>>>> +    } *tx;
>>>> +    struct scmi_pinctrl_list_assoc_rx {
>>>> +#define RETURNED(x) ((x) & 0xFFF)
>>>> +#define REMAINING(x) ((x) >> 16)
>>>> +        __le32 flags;
>>>> +        __le16 array[];
>>>> +    } *rx;
>>>
>>> Ditto, about struct naming and macros.
>>>
>>>> +    u16 tot_num_ret = 0, loop_num_ret;
>>>> +    u16 remaining_num_ret;
>>>> +    int ret, loop;
>>>> +
>>>> +    if (!handle || !array || !size)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (type == PIN_TYPE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, selector, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_LIST_ASSOCIATIONS,
>>>> +                 SCMI_PROTOCOL_PINCTRL, sizeof(*tx),
>>>> +                 0, &t);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    rx = t->rx.buf;
>>>> +
>>>> +    do {
>>>> +        tx->identifier = cpu_to_le32(selector);
>>>> +        tx->flags = SET_TYPE(cpu_to_le32(type));
>>>> +        tx->index = cpu_to_le32(tot_num_ret);
>>>> +
>>>> +        ret = scmi_do_xfer(handle, t);
>>>> +        if (ret)
>>>> +            break;
>>>> +
>>>> +        loop_num_ret = le32_to_cpu(RETURNED(rx->flags));
>>>> +        remaining_num_ret = le32_to_cpu(REMAINING(rx->flags));
>>>> +
>>>> +        for (loop = 0; loop < loop_num_ret; loop++) {
>>>> +            if (tot_num_ret + loop >= size) {
>>>> +                ret = -EMSGSIZE;
>>>> +                goto out;
>>>> +            }
>>>> +
>>>> +            array[tot_num_ret + loop] =
>>>> +                le16_to_cpu(rx->array[loop]);
>>>> +        }
>>>> +
>>>> +        tot_num_ret += loop_num_ret;
>>>> +
>>>> +        scmi_reset_rx_to_maxsz(handle, t);
>>>> +    } while (remaining_num_ret > 0);
>>>> +out:
>>>> +    scmi_xfer_put(handle, t);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_request_config(const struct scmi_handle
>>>> *handle,
>>>> +                       u32 selector,
>>>> +                       enum scmi_pinctrl_selector_type type,
>>>> +                       u32 *config)
>>>> +{
>>>> +    struct scmi_xfer *t;
>>>> +    struct scmi_conf_tx *tx;
>>>> +    __le32 *packed_config;
>>>> +    u32 attributes = 0;
>>>> +    int ret;
>>>> +
>>>> +    if (!handle || !config || type == FUNCTION_TYPE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, selector, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_CONFIG_GET,
>>>> +                 SCMI_PROTOCOL_PINCTRL,
>>>> +                 sizeof(*tx), sizeof(*packed_config), &t);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    packed_config = t->rx.buf;
>>>> +    tx->identifier = cpu_to_le32(selector);
>>>> +    attributes = SET_TYPE_BITS(attributes, type);
>>>> +    attributes = SET_CONFIG(attributes, *config);
>>>> +
>>>> +    tx->attributes = cpu_to_le32(attributes);
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +
>>>> +    if (!ret)
>>>> +        *config = le32_to_cpu(*packed_config);
>>>> +
>>>> +    scmi_xfer_put(handle, t);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_config(const struct scmi_handle
>>>> *handle, u32 pin,
>>>> +                   u32 *config)
>>>> +{
>>>> +    return scmi_pinctrl_request_config(handle, pin, PIN_TYPE, config);
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_apply_config(const struct scmi_handle *handle,
>>>> +                     u32 selector,
>>>> +                     enum scmi_pinctrl_selector_type type,
>>>> +                     u32 config)
>>>> +{
>>>> +    struct scmi_xfer *t;
>>>> +    struct scmi_conf_tx *tx;
>>>> +    u32 attributes = 0;
>>>> +    int ret;
>>>> +
>>>> +    if (!handle || type == FUNCTION_TYPE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, selector, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_CONFIG_SET,
>>>> +                 SCMI_PROTOCOL_PINCTRL,
>>>> +                 sizeof(*tx), 0, &t);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    tx->identifier = cpu_to_le32(selector);
>>>> +    attributes = SET_TYPE_BITS(attributes, type);
>>>> +    attributes = SET_CONFIG(attributes, config);
>>>> +    tx->attributes = cpu_to_le32(attributes);
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +
>>>> +    scmi_xfer_put(handle, t);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_set_config(const struct scmi_handle
>>>> *handle, u32 pin,
>>>> +                   u32 config)
>>>> +{
>>>> +    return scmi_pinctrl_apply_config(handle, pin, PIN_TYPE, config);
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_config_group(const struct scmi_handle
>>>> *handle,
>>>> +                     u32 group, u32 *config)
>>>> +{
>>>> +    return scmi_pinctrl_request_config(handle, group, GROUP_TYPE,
>>>> config);
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_set_config_group(const struct scmi_handle
>>>> *handle,
>>>> +                     u32 group, u32 config)
>>>> +{
>>>> +    return scmi_pinctrl_apply_config(handle, group, GROUP_TYPE,
>>>> config);
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_function_select(const struct scmi_handle
>>>> *handle,
>>>> +                    u32 identifier,
>>>> +                    enum scmi_pinctrl_selector_type type,
>>>> +                    u32 function_id)
>>>> +{
>>>> +    struct scmi_xfer *t;
>>>> +    struct scmi_func_set_tx {
>>>> +        __le32 identifier;
>>>> +        __le32 function_id;
>>>> +        __le32 flags;
>>>> +    } *tx;
>>>
>>> Ditto.
>>>
>>>> +    int ret;
>>>> +
>>>> +    if (!handle || type == FUNCTION_TYPE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, identifier, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_FUNCTION_SELECT,
>>>> +                 SCMI_PROTOCOL_PINCTRL,
>>>> +                 sizeof(*tx), 0, &t);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    tx->identifier = cpu_to_le32(identifier);
>>>> +    tx->function_id = cpu_to_le32(function_id);
>>>> +    tx->flags = SET_TYPE(cpu_to_le32(type));
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +    scmi_xfer_put(handle, t);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_request(const struct scmi_handle *handle,
>>>> +                u32 identifier,
>>>> +                enum scmi_pinctrl_selector_type type)
>>>> +{
>>>> +    struct scmi_xfer *t;
>>>> +    int ret;
>>>> +    struct scmi_request_tx {
>>>> +        __le32 identifier;
>>>> +        __le32 flags;
>>>> +    } *tx;
>>>> +
>>>
>>> Ditto.
>>>
>>>> +    if (!handle || type == FUNCTION_TYPE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, identifier, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_REQUEST,
>>>> SCMI_PROTOCOL_PINCTRL,
>>>> +                 sizeof(*tx), 0, &t);
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    tx->identifier = identifier;
>>>> +    tx->flags = SET_TYPE(cpu_to_le32(type));
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +    scmi_xfer_put(handle, t);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_request_pin(const struct scmi_handle
>>>> *handle, u32 pin)
>>>> +{
>>>> +    return scmi_pinctrl_request(handle, pin, PIN_TYPE);
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_free(const struct scmi_handle *handle, u32
>>>> identifier,
>>>> +                 enum scmi_pinctrl_selector_type type)
>>>> +{
>>>> +    struct scmi_xfer *t;
>>>> +    int ret;
>>>> +    struct scmi_request_tx {
>>>> +        __le32 identifier;
>>>> +        __le32 flags;
>>>> +    } *tx;
>>>> +
>>> Ditto.
>>>
>>>> +    if (!handle || type == FUNCTION_TYPE)
>>>> +        return -EINVAL;
>>>> +
>>>> +    ret = scmi_pinctrl_validate_id(handle, identifier, type);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = scmi_xfer_get_init(handle, PINCTRL_RELEASE,
>>>> SCMI_PROTOCOL_PINCTRL,
>>>> +                 sizeof(*tx), 0, &t);
>>>> +
>>>> +    tx = t->tx.buf;
>>>> +    tx->identifier = identifier;
>>>> +    tx->flags = SET_TYPE(cpu_to_le32(type));
>>>> +
>>>> +    ret = scmi_do_xfer(handle, t);
>>>> +    scmi_xfer_put(handle, t);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_free_pin(const struct scmi_handle *handle,
>>>> u32 pin)
>>>> +{
>>>> +    return scmi_pinctrl_free(handle, pin, PIN_TYPE);
>>>> +}
>>>> +
>>>> +
>>>> +static int scmi_pinctrl_get_group_info(const struct scmi_handle
>>>> *handle,
>>>> +                       u32 selector,
>>>> +                       struct scmi_group_info *group)
>>>> +{
>>>> +    int ret = 0;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !group)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    ret = scmi_pinctrl_attributes(handle, GROUP_TYPE, selector,
>>>> +                      &group->name,
>>>> +                      &group->nr_pins);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (!group->nr_pins) {
>>>> +        dev_err(handle->dev, "Group %d has 0 elements", selector);
>>>> +        return -ENODATA;
>>>> +    }
>>>> +
>>>> +    group->group_pins = devm_kmalloc_array(handle->dev,
>>>> group->nr_pins,
>>>> +                           sizeof(*group->group_pins),
>>>> +                           GFP_KERNEL);
>>>
>>> I think you can just use for the array allocation
>>>
>>>      devm_kcalloc(dev, n, size, flags)
>>>
>>> and it will add also __GFP_ZERO internally to clear it.
>>> (indeed it calls in turn devm_kmalloc_array)
>>>
>>> ...BUT I think there is a further tricky issue here related to memory
>>> allocation...
>>>
>>> You call this and others function of this kind from some
>>> scmi_pinctrl_ops,
>>> like in scmi_pinctrl_get_group_pins (scmi_pinctrl_ops->get_group_pins),
>>> and then this is in turn called by the SCMI Pinctrl driver via
>>> pinctrl_ops->get_group_pins AND you set a present flag so that you
>>> issue a
>>> PINCTRL_LIST_ASSOCIATIONS and allocate here a new group_pins array just
>>> the first time: but these are never released anywhere, since, even
>>> though
>>> lazily dynamically allocated when asked for, these are static data that
>>> you pass to the caller/user of this protocol and so you cannot release
>>> them anytime soon, indeed.
>>>
>>> The core SCMI stack usually takes care to track and release all the
>>> devm_
>>> resources allocated by the protocol ONLY if they were allocated with
>>> devres
>>> while inside scmi_pinctrl_protocol_init() function.
>>> (see
>>> drivers/firmware/arm-scmi/driver.c:scmi_alloc_init_protocol_instance()
>>>    and scmi_protocol_release)
>>>
>>> BUT you do not allocate these arrays inside the protocol-init function,
>>> you allocate them the first time these ops are called at runtime.
>>>
>>> If you unbind/unload all the drivers using this protocol and then reload
>>> them, all the devm_ allocations in protocol_init will be freed and
>>> reallocated BUT these arrays will never be freed (they are boudn to
>>> handle->dev)
>>> and instead they will be reallocated multiple times (present flag
>>> will be cleared
>>> on unload), remained unused and freed finally only when the whole
>>> SCMI stack is
>>> unbind/unloaded.
>>>
>>> You use a present flag to avoid reissuing the same query and
>>> reallocating all the arrays each time a driver calls these
>>> protocol_ops one, but really all these data is available early on at
>>> protocol init time and they are not supposed to change at runtime,
>>> dont they ?
>>>
>>> Even in a virtualized environment, you boot an agent and the SCMI
>>> platform server provides to the agent the list of associations when
>>> queried but then this does not change until the next reboot right ?
>>> (indeed you do not query more than once...)
>>>
>>> The agent can only change the PIN status with CONFIG_SET or
>>> FUNCTION_SELECT or REQUEST the exclusive use of a pin/group, but it is
>>> not that the platform can change the pin/groups associaion for the same
>>> agent at run time, this are static data for the whole life of the agent.
>>>
>>> Am I right ?
>>>
>>> IOW I think there is some potential memory leak on unbind/bind and it
>>> would
>>> be better to query and allocate all of these resources at init time
>>> and keep
>>> them ready to be retrieved by subsequent operations, since the lifetime
>>> of these resources is pretty long and they are basically representing
>>> static data that does not change after the init/probe phases.
>>>
>>> Indeed, all the other protocols usually allocate all the needed
>>> resources and query all the available SCMI resources once for all during
>>> the protocol_init, storing all the retrieved info in some struct *_info
>>> exposed in scmi_protocol.h and then provide some related protocol_ops to
>>> get the number of resources and to retrieve specific domain info
>>> descriptors.
>>> (voltage.c is an example and more on this down below...)
>>>
>>> This way, any dynamic allocation is done during protocol_init, so
>>> it can be automatically freed by the SCMI core once there are no more
>>> users of that protocol, and all of this static info data is queried
>>> and retrieved once for all at protocol initialization time, avoiding
>>> unneeded message exchanges to retrieve always the same data.
>>> (which you avoid anyway with the present flag)
>>>
>>> If you have a good reason to instead perform this sort of lazy
>>> allocation/query performed only at the last minute when someone ask for
>>> that specific resource, you will  have to provide also a
>>> .instance_deinit
>>> function to clean anything you allocated out of the .instance_init
>>> routine; but this would seem strange to me since any resource that is
>>> discovered at init will be eventually immediately queried by a driver
>>> which uses this protocol...am I missing something ?
>>>
>>>> +    if (!group->group_pins) {
>>>> +        ret = -ENOMEM;
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    ret = scmi_pinctrl_list_associations(handle, selector, GROUP_TYPE,
>>>> +                         group->nr_pins, group->group_pins);
>>>> +    if (ret)
>>>> +        goto err_groups;
>>>> +
>>>> +    group->present = true;
>>>> +    return 0;
>>>> +
>>>> + err_groups:
>>>> +    kfree(group->group_pins);
>>>> + err:
>>>> +    kfree(group->name);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_group_name(const struct scmi_handle
>>>> *handle,
>>>> +                       u32 selector, const char **name)
>>>> +{
>>>> +    int ret;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !name)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    if (selector > pi->nr_groups)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!pi->groups[selector].present) {
>>>> +        ret = scmi_pinctrl_get_group_info(handle, selector,
>>>> +                          &pi->groups[selector]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    *name = pi->groups[selector].name;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_group_pins(const struct scmi_handle
>>>> *handle,
>>>> +                       u32 selector, const unsigned int **pins,
>>>> +                       unsigned int *nr_pins)
>>>> +{
>>>> +    int ret;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !pins || !nr_pins)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    if (selector > pi->nr_groups)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!pi->groups[selector].present) {
>>>> +        ret = scmi_pinctrl_get_group_info(handle, selector,
>>>> +                          &pi->groups[selector]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    *pins = pi->groups[selector].group_pins;
>>>> +    *nr_pins = pi->groups[selector].nr_pins;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_function_info(const struct scmi_handle
>>>> *handle,
>>>> +                      u32 selector,
>>>> +                      struct scmi_function_info *func)
>>>> +{
>>>> +    int ret = 0;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !func)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    ret = scmi_pinctrl_attributes(handle, FUNCTION_TYPE, selector,
>>>> +                      &func->name,
>>>> +                      &func->nr_groups);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (!func->nr_groups) {
>>>> +        dev_err(handle->dev, "Function %d has 0 elements", selector);
>>>> +        return -ENODATA;
>>>> +    }
>>>> +
>>>> +    func->groups = devm_kmalloc_array(handle->dev, func->nr_groups,
>>>> +                      sizeof(*func->groups),
>>>> +                      GFP_KERNEL);
>>>> +    if (!func->groups) {
>>>> +        ret = -ENOMEM;
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    ret = scmi_pinctrl_list_associations(handle, selector,
>>>> FUNCTION_TYPE,
>>>> +                         func->nr_groups, func->groups);
>>>> +    if (ret)
>>>> +        goto err_funcs;
>>>> +
>>>> +    func->present = true;
>>>> +    return 0;
>>>> +
>>>> + err_funcs:
>>>> +    kfree(func->groups);
>>>> + err:
>>>> +    kfree(func->name);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_function_name(const struct scmi_handle
>>>> *handle,
>>>> +                      u32 selector, const char **name)
>>>> +{
>>>> +    int ret;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !name)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    if (selector > pi->nr_functions)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!pi->functions[selector].present) {
>>>> +        ret = scmi_pinctrl_get_function_info(handle, selector,
>>>> + &pi->functions[selector]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    *name = pi->functions[selector].name;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_function_groups(const struct
>>>> scmi_handle *handle,
>>>> +                        u32 selector,
>>>> +                        unsigned int *nr_groups,
>>>> +                        const unsigned int **groups)
>>>> +{
>>>> +    int ret;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !groups || !nr_groups)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    if (selector > pi->nr_functions)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!pi->functions[selector].present) {
>>>> +        ret = scmi_pinctrl_get_function_info(handle, selector,
>>>> + &pi->functions[selector]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    *groups = pi->functions[selector].groups;
>>>> +    *nr_groups = pi->functions[selector].nr_groups;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_set_mux(const struct scmi_handle *handle,
>>>> u32 selector,
>>>> +                u32 group)
>>>> +{
>>>> +    return scmi_pinctrl_function_select(handle, group, GROUP_TYPE,
>>>> +                        selector);
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_pin_info(const struct scmi_handle *handle,
>>>> +                     u32 selector, struct scmi_pin_info *pin)
>>>> +{
>>>> +    int ret = 0;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +    unsigned int n_elems;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !pin)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    ret = scmi_pinctrl_attributes(handle, PIN_TYPE, selector,
>>>> +                      &pin->name,
>>>> +                      &n_elems);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (n_elems != pi->nr_pins) {
>>>> +        dev_err(handle->dev, "Wrong pin count expected %d has %d",
>>>> +            pi->nr_pins, n_elems);
>>>> +        return -ENODATA;
>>>> +    }
>>>> +
>>>> +    if (*(pin->name) == 0) {
>>>> +        dev_err(handle->dev, "Pin name is empty");
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    pin->present = true;
>>>> +    return 0;
>>>> +
>>>> + err:
>>>> +    kfree(pin->name);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int scmi_pinctrl_get_pin_name(const struct scmi_handle
>>>> *handle, u32 selector,
>>>> +                     const char **name)
>>>> +{
>>>> +
>>>> +    int ret;
>>>> +    struct scmi_pinctrl_info *pi;
>>>> +
>>>> +    if (!handle || !handle->pinctrl_priv || !name)
>>>> +        return -EINVAL;
>>>> +
>>>> +    pi = handle->pinctrl_priv;
>>>> +
>>>> +    if (selector > pi->nr_pins)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!pi->pins[selector].present) {
>>>> +        ret = scmi_pinctrl_get_pin_info(handle, selector,
>>>> +                        &pi->pins[selector]);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    *name = pi->pins[selector].name;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +
>>>> +static const struct scmi_pinctrl_ops pinctrl_ops = {
>>>> +    .get_groups_count = scmi_pinctrl_get_groups_count,
>>>> +    .get_group_name = scmi_pinctrl_get_group_name,
>>>> +    .get_group_pins = scmi_pinctrl_get_group_pins,
>>>> +    .get_functions_count = scmi_pinctrl_get_functions_count,
>>>> +    .get_function_name = scmi_pinctrl_get_function_name,
>>>> +    .get_function_groups = scmi_pinctrl_get_function_groups,
>>>> +    .set_mux = scmi_pinctrl_set_mux,
>>>> +    .get_pin_name = scmi_pinctrl_get_pin_name,
>>>> +    .get_pins_count = scmi_pinctrl_get_pins_count,
>>>> +    .get_config = scmi_pinctrl_get_config,
>>>> +    .set_config = scmi_pinctrl_set_config,
>>>> +    .get_config_group = scmi_pinctrl_get_config_group,
>>>> +    .set_config_group = scmi_pinctrl_set_config_group,
>>>> +    .request_pin = scmi_pinctrl_request_pin,
>>>> +    .free_pin = scmi_pinctrl_free_pin
>>>> +};
>>>> +
>>>> +static int scmi_pinctrl_protocol_init(struct scmi_handle *handle)
>>>> +{
>>>> +    u32 version;
>>>> +    struct scmi_pinctrl_info *pinfo;
>>>> +    int ret;
>>>> +
>>>> +    if (!handle)
>>>> +        return -EINVAL;
>>>> +
>>>> +    scmi_version_get(handle, SCMI_PROTOCOL_PINCTRL, &version);
>>>> +
>>>> +    dev_dbg(handle->dev, "Pinctrl Version %d.%d\n",
>>>> +        PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
>>>> +
>>>> +    pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
>>>> +    if (!pinfo)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    ret = scmi_pinctrl_attributes_get(handle, pinfo);
>>>> +    if (ret)
>>>> +        goto free;
>>>> +
>>>> +    pinfo->pins = devm_kmalloc_array(handle->dev, pinfo->nr_pins,
>>>> +                     sizeof(*pinfo->pins),
>>>> +                     GFP_KERNEL | __GFP_ZERO);
>>>
>>>    devm_kcalloc() zeroes on its own
>>>
>>>> +    if (!pinfo->pins) {
>>>> +        ret = -ENOMEM;
>>>> +        goto free;
>>>> +    }
>>>> +
>>>> +    pinfo->groups = devm_kmalloc_array(handle->dev, pinfo->nr_groups,
>>>> +                       sizeof(*pinfo->groups),
>>>> +                       GFP_KERNEL | __GFP_ZERO);
>>>
>>> Ditto.
>>>> +    if (!pinfo->groups) {
>>>> +        ret = -ENOMEM;
>>>> +        goto free;
>>>> +    }
>>>> +
>>>> +    pinfo->functions = devm_kmalloc_array(handle->dev,
>>>> pinfo->nr_functions,
>>>> +                          sizeof(*pinfo->functions),
>>>> +                          GFP_KERNEL | __GFP_ZERO);
>>>> +    if (!pinfo->functions) {
>>>> +        ret = -ENOMEM;
>>>> +        goto free;
>>>> +    }
>>>> +
>>>> +    pinfo->version = version;
>>>> +    handle->pinctrl_ops = &pinctrl_ops;
>>>> +    handle->pinctrl_priv = pinfo;
>>>> +
>>>> +    return 0;
>>>> +free:
>>>> +    if (pinfo) {
>>>> +        devm_kfree(handle->dev, pinfo->pins);
>>>> +        devm_kfree(handle->dev, pinfo->functions);
>>>> +        devm_kfree(handle->dev, pinfo->groups);
>>>> +    }
>>>
>>> These frees are really not needed...if this function return failure any
>>> devres allocated in it is freed by the SCMI core. (as said above...in a
>>> recent kernel with the new API of course)
>>>
>>>> +
>>>> +    devm_kfree(handle->dev, pinfo);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_PINCTRL,
>>>> pinctrl)
>>>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>>>> index 815095326e2d..68add4d06e8c 100644
>>>> --- a/drivers/pinctrl/Kconfig
>>>> +++ b/drivers/pinctrl/Kconfig
>>>> @@ -431,4 +431,13 @@ config PINCTRL_EQUILIBRIUM
>>>>          pin functions, configure GPIO attributes for LGM SoC pins.
>>>> Pinmux and
>>>>          pinconf settings are retrieved from device tree.
>>>>    +config PINCTRL_SCMI
>>>> +    bool "Pinctrl driver controlled via SCMI interface"
>>>> +    depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
>>>> +    help
>>>> +      This driver provides support for pinctrl which is controlled
>>>> +      by firmware that implements the SCMI interface.
>>>> +      It uses SCMI Message Protocol to interact with the
>>>> +      firmware providing all the pinctrl controls.
>>>> +
>>>
>>> This does NOT belong to this patch, but to the next right ?
>>>
>>>>    endif
>>>> diff --git a/include/linux/scmi_protocol.h
>>>> b/include/linux/scmi_protocol.h
>>>> index 9cd312a1ff92..6a909ef3bf51 100644
>>>> --- a/include/linux/scmi_protocol.h
>>>> +++ b/include/linux/scmi_protocol.h
>>>> @@ -12,7 +12,8 @@
>>>>    #include <linux/notifier.h>
>>>>    #include <linux/types.h>
>>>>    -#define SCMI_MAX_STR_SIZE    16
>>>> +#define SCMI_MAX_STR_SIZE 16
>>>> +#define SCMI_MAX_STR_EXT_SIZE 64
>>>
>>> This is handled as part of how the extended names are handled with
>>> ph->hops
>>> in a common way, as I was saying, so please move this if you need it in
>>> the protocol code, then I'll port to the ph->hops interface and clean
>>> up.
>>>
>>>>    #define SCMI_MAX_NUM_RATES    16
>>>>      /**
>>>> @@ -252,6 +253,55 @@ struct scmi_notify_ops {
>>>>                         struct notifier_block *nb);
>>>>    };
>>>>    +/**
>>>> + * struct scmi_pinctrl_ops - represents the various operations
>>>> provided
>>>> + * by SCMI Pinctrl Protocol
>>>> + *
>>>> + * @get_groups_count: returns count of the registered groups
>>>> + * @get_group_name: returns group name by index
>>>> + * @get_group_pins: returns the set of pins, assigned to the
>>>> specified group
>>>> + * @get_functions_count: returns count of the registered fucntions
>>>> + * @get_function_name: returns function name by indes
>>>> + * @get_function_groups: returns the set of groups, assigned to the
>>>> specified
>>>> + *    function
>>>> + * @set_mux: set muxing function for groups of pins
>>>> + * @get_pins: returns the set of pins, registered in driver
>>>> + * @get_config: returns configuration parameter for pin
>>>> + * @set_config: sets the configuration parameter for pin
>>>> + * @get_config_group: returns the configuration parameter for a
>>>> group of pins
>>>> + * @set_config_group: sets the configuration parameter for a groups
>>>> of pins
>>>> + * @request_pin: aquire pin before selecting mux setting
>>>> + * @free_pin: frees pin, acquired by request_pin call
>>>> + */
>>>> +struct scmi_pinctrl_ops {
>>>> +    int (*get_groups_count)(const struct scmi_handle *handle);
>>>> +    int (*get_group_name)(const struct scmi_handle *handles, u32
>>>> selector,
>>>> +                  const char **name);
>>>> +    int (*get_group_pins)(const struct scmi_handle *handle, u32
>>>> selector,
>>>> +                  const unsigned int **pins, unsigned int *nr_pins);
>>>> +    int (*get_functions_count)(const struct scmi_handle *handle);
>>>> +    int (*get_function_name)(const struct scmi_handle *handle, u32
>>>> selector,
>>>> +                 const char **name);
>>>> +    int (*get_function_groups)(const struct scmi_handle *handle,
>>>> +                   u32 selector, unsigned int *nr_groups,
>>>> +                   const unsigned int **groups);
>>>> +    int (*set_mux)(const struct scmi_handle *handle, u32 selector,
>>>> +               u32 group);
>>>> +    int (*get_pin_name)(const struct scmi_handle *handle, u32
>>>> selector,
>>>> +                const char **name);
>>>> +    int (*get_pins_count)(const struct scmi_handle *handle);
>>>> +    int (*get_config)(const struct scmi_handle *handle, u32 pin,
>>>> +              u32 *config);
>>>> +    int (*set_config)(const struct scmi_handle *handle, u32 pin,
>>>> +              u32 config);
>>>> +    int (*get_config_group)(const struct scmi_handle *handle, u32 pin,
>>>> +              u32 *config);
>>>> +    int (*set_config_group)(const struct scmi_handle *handle, u32 pin,
>>>> +              u32 config);
>>>> +    int (*request_pin)(const struct scmi_handle *handle, u32 pin);
>>>> +    int (*free_pin)(const struct scmi_handle *handle, u32 pin);
>>>> +};
>>>> +
>>>
>>> As mentioned above, here you could drop a lot of this
>>> get_X_count/name/pins
>>> and instead expose a few of the internal proocol struct scmi__X_info
>>> and then
>>> provide just a mean to query how many resource are there and then get
>>> the info
>>> descriptor you want for the specific domain_id, i.e.:
>>>
>>>       int (*num_domains_get)(ph, type)
>>>       void *(*info_get)(ph, type, domain_id);
>>>
>>> Thanks,
>>> Cristian
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!GF_29dbcQIUBPA!y2hR3PEGGxiPjVeXBcgGyV03DPDhzgUKR0uHvsTpiafKgBar8Egc6oOOs-IkFIquhSf-qBzltqEMyzRZrZi7qlk$
>>> [lists[.]infradead[.]org]
