Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4886E8BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjDTHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjDTHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:54:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78E2710;
        Thu, 20 Apr 2023 00:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuQnRpYG9OHggigYROKT2fM+mFcxirECu5fpDaO2cZGzRCAcjENo15DH4zupuSQjHbgYrtW2kpI8OWnByAkbsPuYr2A+5FrbBLPb10HTKRACFM6uo8MMR3Vl1cSzBpvDLmqQRX7+7xKcq/jvZ+c16mU9bgQ4RD+sHz/Ym/JjmtJsLq8fNtJuThAts8PBJAcTl9Px2RaNrWXT0BVIabqBMLZjt/ZzOebYGWy1+v6PiDA2plsy8fZvgs+tJYa5gTe5vOEP3cf3IIi6r0lkrV3xZkXyOr3kS9WcmAzSkufhA2Bjkep3GKs0mDRU3X6rD02sdcmXg7jx2tfgOKpbTNcFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2GpTgs2bxwtpph/Z5vXW6DDYRIOjDvi4nNY/Ms9G6U=;
 b=f64SfdY0XPti2Ue/B4TR04jgIDFemxjayc4MFkhU3F87qKyRj9MNh6475civlI6UHPSqYBFo7Kk5frpfTApxCY7m26B+5KzP2JOA2uTzPnCHnR4Pywy5O2d2MS0pR7nfb1xO5BuActxnKT62YhOkvL4svhQ7nyyfYGATSwKyo57o+EbGj0GuPLMHf3AqhEYYzBtV6RXq5Vv67aX8fwazN4B9cBgH7Z+JG525X8AvIhcf5c6guWnb5TCW++LS9gV4+ka6IGmtrtgfdvOLaZ1xY3f3WHqC6P1z1otGIaZQHvFkx3QbGp+snhA+G6Jy7YlUtIhCYhOY9N4GGZapIllxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2GpTgs2bxwtpph/Z5vXW6DDYRIOjDvi4nNY/Ms9G6U=;
 b=KGUSjG5H0HsE3X6IdMzm/iA+wErg8/2WlFrYzsWCfcYvV8P4CBLF8sOt+uSy4zXf0X1uinEuk+AKrgsBcoVHHi4q23t8lXD0k09CjMs2/mJvMavoQnozpKNsFqc3DtWlpNlKG9pfyb7mCC8rcNJ4WNgzJmSXd0JW1K0eM6UTywU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 07:54:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 07:54:19 +0000
Message-ID: <fcfd3b04-ce51-af95-5d94-cc244d75727f@oss.nxp.com>
Date:   Thu, 20 Apr 2023 15:54:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] input: imx_sc_key: add wakeup support
To:     Ulf Hansson <ulf.hansson@linaro.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
 <20230323093141.4070840-2-peng.fan@oss.nxp.com> <ZDN00vwyCOzFrDYt@google.com>
 <DU0PR04MB94172C2BBB554E472576B2BA889B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417185EB8243ED2D60A6E43889B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFruZOP65k0SEEmCGtopp8ywJA92ChGZs2ZR=nVxqUC0OQ@mail.gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <CAPDyKFruZOP65k0SEEmCGtopp8ywJA92ChGZs2ZR=nVxqUC0OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 28106c7e-61af-4721-94c3-08db4174725d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4ZS767jC+vx+f3T5OKpTLwMIaqrmtvAcpSgIQstk3I9gTS8cYIzdAZL/PwQyXUJbMdeUZghyhrT281h7Qwd0aKiols5pZRiyDP7haqkmJ0weCExaxfQd1Qg7tw16gfIy8S1+fPhHLuhkzpL6LvpR3SxXpU7fHmSKrDT2+nu1oRrtSldZWLtbDovEOvWwuUpPTQhWKz5lyP9zDu85E6vOaI7FdKWWdajoBH9Gs8ijqbTRCaDxgtTX9I9VIAcK0lEyPFBqN0NkxOaKNGkYDlNBETu9tY3GWC27Ky5YuOEk/5iYvXXOezwfeJ3NjYALyD838U6QLh1XJgJYwJ6F40BVPHAfCVKp6C2NGnA0FMfqPbzOsPay9mbIa/rxsihu+qVR2XxTzYiELozBkm/YIlVELdljrbHBxJyFUeVf7VaGNJYGjfU+KaDxuaelVz+cog+xI69mDDWzC1Q5FgRWwAmlqG4fFHkRD7IaXLdhjth5VJa/HwHmFFxXjcI2VvAj63Xl8zqLVnzgjwuiRsm0WR+rj22pzbSp6gMYBtPjNZ8RTPy+9UuvjQ5ek1ZqO6hrTlvfusM+1wm6AcO4lw2NchA8ZIKMR8cOyGgc06il4c0BtbKS20tTH9nQZXGDq2w2cErZTHGVTiyyO0eKICCj96xSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(31686004)(44832011)(2906002)(5660300002)(83380400001)(8936002)(8676002)(41300700001)(7416002)(6666004)(478600001)(6486002)(316002)(66476007)(66946007)(66556008)(110136005)(54906003)(38100700002)(31696002)(86362001)(53546011)(186003)(6512007)(26005)(6506007)(2616005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXp6L3Y4cEROZzBFRW9IRmE1R05NSWxONmk4R3BONUNKMFBvS2tucEVEaEFu?=
 =?utf-8?B?MnpZWFZuaUlmSGs0SGFzeWd2bER4MjBWQ0VpQ3VVSTVXMVJyL1V1amZxL2RU?=
 =?utf-8?B?UkU2U0VQNjFMcytuRGx2T2xPZThRQnRmWXNISEtZSGhIai9Kd1VVeWRacVU0?=
 =?utf-8?B?YU90M2M5ZnlpSjhvM0puT0ZIN3UwU29IKzFQWXJmdWw1cU8xYlFKY2gxb3h6?=
 =?utf-8?B?UDZSMUdKMldZVWNCbkFPTnlOdHBLUlpuc2tpUlF4RHFWZFEweTM0WkxDRHJu?=
 =?utf-8?B?NDdFS2o2SFlUbkZMbEgxcllBSTNMd0lBWGl5WjdHdkY2clYySGNmc0g3ejYr?=
 =?utf-8?B?R2dvamFTQlN5MER3Y0RuZ3pmU3pYd2swY0RKUlk3QmV0WnZ0ZTRGMVhyWjZw?=
 =?utf-8?B?eVVtaDlpaGJzUEpneTl1SEMzcTdtTklDZ2U0aE5nSUNVaDVoVkZnQ3ZHUWl3?=
 =?utf-8?B?Wk9pak5BMmljVXJyUlViSjRiL2NpMWFBWnh0MWpWV25pNEJaSURrWjlHbmdn?=
 =?utf-8?B?NEVydkprMGVEZjFnU0F2REFRbG4vTFBUdnIxRWd4dzA1YWx0MUpoRFVCanRm?=
 =?utf-8?B?emxxcGlsQVY4ZXMrRXM2UWJLWkxXemo0aEg5WC9aRnZFaEhlSU5lM0VJVTZi?=
 =?utf-8?B?OG1xb0FEeHlHWjROaUtJejg4b3ErZkEydlhoMFdqaGNHT0JSWGlkSW5xWS9j?=
 =?utf-8?B?aUJzeFZpUENTV3NJSlVzc1gxNytFdmZrL25kT2hzeldEM0IxMlpIQlZlRS9I?=
 =?utf-8?B?cXlSdEwwejQyalpyczFUMFNPdUpFcXU2ZUM5bzlUb1pENHM4NlZ3QUtYODFS?=
 =?utf-8?B?NTBWdS9ocEJGZFpCU0ZNVmFrUlVIM0gzMGJZYXdybi8zSExkOVNJOU1xQ3VI?=
 =?utf-8?B?b0dxU25RTjFXa0FpSjJnalBzVDlrMUZNMVRLdHlCYUtRVVJydzlBdzlMb0cz?=
 =?utf-8?B?cXZOWjl3S21FMzVCeXNlSmZyQUg0QURQWlpjVmRZSkR2MXBrdUo5WFYzK0pz?=
 =?utf-8?B?dmx2WERjOHBkSXJCU08yaEsyQzRlQTYwc2FMQWdiOWpBVmtIbGhKTjc4M3Ns?=
 =?utf-8?B?cm9mQkoyazUvdi9BUHZGVjQ2WmE5TW9JeURLeDkxc3pzS0pvK1lRUzlxcUg4?=
 =?utf-8?B?NWNoNEQzWDgyM1BmQnYvektud21JN0F0SllvakVBYk9qNW9MQWt0TGFEU0FX?=
 =?utf-8?B?VEdYNVhlWnBYcWlWam9CUGdtc0VWYnhkYXZURDJIYjhOcjIvWW9GYkwwVWxz?=
 =?utf-8?B?TlRvWWhyWEIwOVVVaml6V0sray9MZ1N2SXcxR1RQWW9NeWpNYTlRQ0Y0c2Fq?=
 =?utf-8?B?a3JjdnFTV25rdytpK3RJaWordDQwMVpHZzJNZEd3Zlo2YktEcThhazNJbUFP?=
 =?utf-8?B?czlJQkNISkR0VzJJVlRKZVJnNFJQdVkyZlM2WUVpV2dnZHEwRFdMS0dDNy9H?=
 =?utf-8?B?bUNEOTRHKzNxbUdwenNXejBLUFd4M3VueWpLMGc1eTNpSFN2MDFHQWNKamtF?=
 =?utf-8?B?TlExOHFmMDB3cExnRzlnMUFoRUtUNFpEY3BIaENmbWV5UktLTk9uSDIybmxI?=
 =?utf-8?B?UG8xdWx1czdleTFjL0E0YmR6Y2NxTXBkZXBkczZ4bThPMnpJRkZZcTNLcklh?=
 =?utf-8?B?dEFSSko3RTRkRFhEN1kvN3p6UkdBczJHL0FmYWt4bFRMQzVMa2lCbHhPbjI3?=
 =?utf-8?B?L1IxakdmMERSbEhWeUVKbVFIYmhZOVdxd2R4WDFQQ3YvUjExSFZhVys1VU1y?=
 =?utf-8?B?RnUwUmtRbnI0WTBmV3owMjRyckJPekx3b2kxTnQwb3BlYmhJVXNiRXRYeFZP?=
 =?utf-8?B?ZjhOOE1IV2Uvei9yalJPVnN1NHI4YzhwQkpTa29MQUxRVk9LSnRjUGd3ZEVh?=
 =?utf-8?B?dE11QXp5OHhiNk1tN1lESllsMVcxL2huTlZnanBBR0dpN3RwcUk4SHdNUFhj?=
 =?utf-8?B?SUUrRUwvRkw2aFUyQklOY0RxSTZZN21qVTJsMFF3NkN3Y1dDT3hLeThma25o?=
 =?utf-8?B?UXNUbXpBZWM1NUlMTmM3MTY3T2ZkZlNBVDR3SlJsK1VGSmgzeVNlRlpFd2Rh?=
 =?utf-8?B?WC9OamNpWnhuQ25rOVo3MzlBakYyR3ZuR0MwWU56V0RaZXVUKzlmZGNDeVJB?=
 =?utf-8?Q?PXkoEURyADFeB1Mm3UpllumV3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28106c7e-61af-4721-94c3-08db4174725d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 07:54:19.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Hru37FxY3A4gfe2s2VPyFCfvkwVB0C5YBOTKRKvfehI+Dza9NSCZF1xO5LiCfWvtALFIOBNS0ukLfD6lQmwTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,Ulf

On 4/18/2023 4:32 PM, Ulf Hansson wrote:
> On Wed, 12 Apr 2023 at 17:58, Peng Fan <peng.fan@nxp.com> wrote:
>>
>> +Ulf
>>
>>> Subject: RE: [PATCH 2/2] input: imx_sc_key: add wakeup support
>>>
>>>> Subject: Re: [PATCH 2/2] input: imx_sc_key: add wakeup support
>>>>
>>>> On Thu, Mar 23, 2023 at 05:31:41PM +0800, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Add support for waking up from system wide suspend.
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>   drivers/input/keyboard/imx_sc_key.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/input/keyboard/imx_sc_key.c
>>>> b/drivers/input/keyboard/imx_sc_key.c
>>>>> index d18839f1f4f6..234f23cf9990 100644
>>>>> --- a/drivers/input/keyboard/imx_sc_key.c
>>>>> +++ b/drivers/input/keyboard/imx_sc_key.c
>>>>> @@ -151,6 +151,8 @@ static int imx_sc_key_probe(struct
>>>> platform_device *pdev)
>>>>>    priv->input = input;
>>>>>    platform_set_drvdata(pdev, priv);
>>>>>
>>>>> + device_init_wakeup(&pdev->dev,
>>>> device_property_read_bool(&pdev->dev, "wakeup-source"));
>>>>> +
>>>>
>>>> I wonder - could we move this to the device core?
>>>
>>> I see lots device drivers parse wakeup-source, so I also follow That. Not sure
>>> whether could move this feature to device core, but anyway I could give a
>>> try.
>>
>> Do you think it is feasible to move device_init_wakeup into device core
>> part?
> 
> Not sure it would really improve things that much. Subsystems/drivers
> need to make additional configurations based upon whether this DT
> property is set anyway.
> 
> Perhaps an option is to make this a part of the common input subsystem
> helper functions instead? Other subsystems do this, but I am not sure
> how feasible that would be in the input case.

How do you think of below patch?

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 37e876d45eb9..a98a9f37e1f5 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2402,6 +2402,10 @@ int input_register_device(struct input_dev *dev)
                         __func__, dev_name(&dev->dev));
                 devres_add(dev->dev.parent, devres);
         }
+
+       if (device_property_read_bool(input->dev.parent, "wakeup-source"))
+               device_init_wakeup(&pdev->dev, true);
+
         return 0;

  err_device_del:

Thanks,
Peng.

> 
> Kind regards
> Uffe
