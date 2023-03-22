Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1123A6C4B73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCVNPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCVNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:14:57 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2139.outbound.protection.outlook.com [40.107.249.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F37580C0;
        Wed, 22 Mar 2023 06:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O18V8jpk7ncKeLurs7XF35/tyhEuamk+UV48MkV+lBNTk+oDBdqejN0I8arxFtQgVfFdlwy8mgp+Q/uQJiDACGNvxwltf4ilPwAZ4g+2OfCJdnfy1ZyPvafkCIdGxMEHoqWq4M4PxxdrXcOcaZKI/i7xp25ebJMgUVyM4kWU5qk4yedLo3tr0kXn+dZG5lYj6wIgs4TanDxccMg2N13CudY1Io2RRqGgrOxNZtEsWXldBlAlB+/3aKhRK1vuW/VOQdf/nB+BiuZmDm+rSMN9ED36/+hNcr+cJvMRZ8FdiVIVqwkVljMiyKUaruxpXg/wWlYK8Aehbv8cb6/ndjwE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUZSU1zIh6lqw41Re528v62AZuD/Zs0FmEsUv7M2Qls=;
 b=SfzVDzBRCBK7qdGk0lI8B+3qRqLa3ISFCy1f3NrSMVd3nlWItoLYFB3ze1kXF9XLDGfYV3yb952y5HulPGo66aUVZSvnGcxCo0xbhDMUafR52Y/NS1J7/+3PvPyOFlZZNuC5gea15N8Mjse+H8/3rSYFFW4XndDKKsrFfvafqkk4MO60xNvgwYOO9FBqOzW3nY7s7Oo0LZRTenDWjN7NxmuxnAIRUGSYzI6Pnm9imy3GriAeFCl4hAzHcdWxyeVyZzb/14yxIX9vK0gk0bw7CXKs52z1allXz5ipthb5gyYM6MHFwXAmokJrAxKBkg3XxvqEU4tE9HvopfJsUD1m8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUZSU1zIh6lqw41Re528v62AZuD/Zs0FmEsUv7M2Qls=;
 b=l6jtvxyZzFK6KrUfwQpJOEgIHQ8l+quNCn4FTt/Yzs5w764Ej6PtSRrC/Bm00Ml2hmzCJdmPWwmxk8Izs9mPDwDLioQm8wVY6FdO3dByZ1346LwsAp7qfw0XNSqeM6yGE69EW8yIuF4tMusMpnyGsFw2DHM2wrYRBjf7v4h16HA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Wed, 22 Mar
 2023 13:14:53 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%3]) with mapi id 15.20.6222.010; Wed, 22 Mar 2023
 13:14:52 +0000
Message-ID: <31b0a8b1-d027-d47a-e10d-614c09211734@kontron.de>
Date:   Wed, 22 Mar 2023 14:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230201143431.863784-1-frieder@fris.de>
 <Y9qQHpySbrFcBB0P@mail.local>
 <b58f5e31-f13f-6d90-774c-2017ee3de121@kontron.de>
 <7268b05b-bbb1-ec4d-6a05-f5ccbdfeed90@kontron.de>
 <da83fdd0-9eae-09ce-ff6f-47cc012f9628@kontron.de>
In-Reply-To: <da83fdd0-9eae-09ce-ff6f-47cc012f9628@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0031.eurprd05.prod.outlook.com (2603:10a6:205::44)
 To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: b399645c-2299-4e4d-897f-08db2ad76c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxe6Naq/+jNOercSZV9z7Cwmit3/UlxGNsaWePUvua5/luVNg7wAMURNyxADyJu6eghaOscdEgBZShJbGT1gJG7q60D3rox9/YET9V4dw0RddF5/nMQGk/P3Qs1tosOVRmOZAFihQ7MPH/JLt0pZAbaUPVewZ49yzk3pwGekRH5jkUMQrc7c7RbJ2vdJawaqTJ4+lAuV8+8bQs1NTnwoOP1MnsirU1o0ZhLZ0jIXAosFAfxJiPQ6Om6aSEdGLovzFbbVvwTri+rnU2boS799ZQ9l/lHTFIxxoLf+IxJ7jb81jVNoOcSaJg70YxRuhVxJDYZK9Pzs8fLLU3AOOYxRuDwMzPlAzNtuA7UBgJu/Rx24Vh46dpp6F6IuQSQEvAMKkI+bOoCp/Ei9p9MkRKY9UpT2g0cJlT1aRdmxYlx5JUPtkedItw4tenpDFOZJ1eA6bbtviAGyeMMch9vCMcL/keiunxdw4AnFzirPG7hkMw/u34B6Hwe1TONlGUlVb6+nLRu8+WmdMbJH7K3Z3O2Cw9dinXnWyFyBUMcEkx5mCMm6RCgGqA7bHeL82H3930ADGfUUd+Z+vG1mSKt5a+cxnDRplqXLTozH4Sst6NUDDMXxG5L5k87dt8Gv5CzgKcfqNRJjgvSkw290iDrSUoPFWBMqtKdiai8WSebiKbfl18yKn7rjwnHMGu86jSTXV9J/R5gQB7FWZuQ+ez3XKtVwl7gAntUIvgAZWHV6NxFQGEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199018)(41300700001)(31686004)(66899018)(31696002)(7416002)(8936002)(8676002)(2906002)(44832011)(5660300002)(36756003)(86362001)(38100700002)(478600001)(66556008)(66476007)(6486002)(66946007)(6512007)(54906003)(53546011)(110136005)(2616005)(316002)(186003)(6506007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZhRzJ0blZncW9LVUNud1dZOCsrNGtYYWJiZE1ncWFBTXNWcHRKWXJXVGFP?=
 =?utf-8?B?eFFWL0lOZ0VncWJKeHB6L1FSMmdqZjdmOGlXdU9YdFdQUkJWOTB6WkpsdFpi?=
 =?utf-8?B?dkRudHc0Smx5a2VhVFphRmx0NmxCa09YSW1nTXpWQXNLL09wMUNzcVNZRmJO?=
 =?utf-8?B?WDZ5M1ZsWElnZkxOM01iQkI1VlBCaGhqMUdwaHBRT0ZheFVtbUJlWlpnR2Q5?=
 =?utf-8?B?M2lxNnlMNWZDKy9CeWVHN0t3L1I2RlQvSGxrbFI5QlZvLzZWNkJVK1IwMnVz?=
 =?utf-8?B?d0NwMklSSG51S0hicWozNXNNTVIwdWVKRWFWZDRhTi9TZGFuQlFPamNQMXhn?=
 =?utf-8?B?RzZOVmZmS1BmbTB2WkdxVTc1MEtVRjlBTlJ3U1dFREN2czduM2U1SGoxekhH?=
 =?utf-8?B?Wmp2VnpuUVYyR2FuYnlVNDhMOExXNkVOZ2tMMjRadGNqOGF2RFd0eWpBYTRp?=
 =?utf-8?B?U3Qyc3hHd1ZHdzVZaHBxODFWaGJ4cXlpMDhRYlZMSWJjRXpOdHhmcmhJM1pH?=
 =?utf-8?B?UCtCdXZCWUhicXNtVng0djhwTElhb3UrWmlxKzVWNWp1UDZMQ0RGcTNxQ0k5?=
 =?utf-8?B?em1nWG5MVC9aWHk1OVJ0ZDg4eFplMTZSWTJuaDVHRDI1T2IxYitwaEVINFFL?=
 =?utf-8?B?SHQ0M0JlVXdqMmVCSmYxbUVtb1JMTHpvaUN0bGgzMXdtOFU5bjZtem8wT1lR?=
 =?utf-8?B?b2dNcEtQTDUwakZDQXkrTXpiUTBqVjlqWmZFbUxkN3pkU2VPaXpibWs1Z1JV?=
 =?utf-8?B?WlN0aWVSVlpqa1lOeWNIVTJyUHlHWUpralRyMm8yTnpSUk9JZzd0L1czWFFL?=
 =?utf-8?B?SHN0b1J4aXNGbzZsZEVFM1NSUEdEVjZ1Y3Npd3lqOEs1L2p6ai8wYU96dFdr?=
 =?utf-8?B?K05KbngzWUxVNnBuanpGRERoQlJkTzNOZXBWRU03c0N4VFF6YU9DakRJN1By?=
 =?utf-8?B?ZUljNmZEMHppU1lsR29NUDlFeUhwUnRReTFSSllFd0tCcyt1ZS9aTWJFUjhI?=
 =?utf-8?B?d1k4L0xEMkd5bDJIQmoyUGthMTIwRjE2bU54Ti9jcG5iSHplTzkwcmV3V24v?=
 =?utf-8?B?OFNLODl4NlZiUnNPNmdEYjgyQXdpVGhMbWlpTEpudUZmamtpUHJnL3pyVTQ2?=
 =?utf-8?B?bDdmQ1M3V1dEbG5IVlp2dXZENFBzWGpGVVdBcUhDVDN0ZHUxZ2Y5b0VOYUlH?=
 =?utf-8?B?dnFxK1g4WHgrMUVHdTVLc2IzbUI1N2E0ZTZ1OEw4TzNrckdOdUNEVDBHRVdG?=
 =?utf-8?B?QjB4Ym13dHJvNEM3cUxtZjlxK1c5UVFZRXVDNFBTSVlEU1ZVOEp2U0hiSGtz?=
 =?utf-8?B?aklnajdPL1dnZ25iekdCTlY3UUtpN3czVWtGa1UxSHlscU9tTVN1WjZvUW9E?=
 =?utf-8?B?SllwazFqNFAzdzhhSWs2a2JDWTNJUFNuZEljbTN6UDNhZWRwT0tld0pQa29W?=
 =?utf-8?B?cytid2R6V1F5VEwxZFBnQlRWZVE5M1pjYXR1WUVQaWprb2o2RzBVWXlVWFJD?=
 =?utf-8?B?NElVS1EyTlNpQWR1NFhwRTF1ajNtdVpldWlJWjYxVXVWTHhoY0RtWU55QzN6?=
 =?utf-8?B?K09vUHJMK3ZSYmxzRWpERDBuRklTMHZtcVFUbklrQ1ZIWXhvWUFhc1dQQTVS?=
 =?utf-8?B?K05YVXRkWTJzNEo3ZnJKNG1lUUNqcWhOM2tEN0xNajE1MVdGcktFeGdQMnVM?=
 =?utf-8?B?NmR1STFqZDA4WnFuMXhpQXBWbGxITWhseVRFdVNUcGdzcUtvWlV5U0pMRUto?=
 =?utf-8?B?M25lcUx5OXpqU0RDaTJiSXV4RnZ3a1F2V0t4aDJGZ2h2ZTJmUklic2d4UmxY?=
 =?utf-8?B?WHZaWW53TTFkb2FROGVnUThIM2FiREszdE14bzJsOGpsQVFYVjVSUnRLZkxt?=
 =?utf-8?B?eE9aZ0NYbUkvRkZMVUpQQ3orWHoxa2FJQ3hZZmwwSDRYb1Fnb3dYV1FZV3hR?=
 =?utf-8?B?eGZZZnBSdVJjWmdOcStlQkFpZk5HZ2NtWm1DN3lqZW5FL0ozZ2FOSEh3VWJH?=
 =?utf-8?B?aDZhOU9kVkYzVHM4NmNCaTY5ay9KaGxtN0RBL1ppOUwrWnMwYmZQS1hHUkNI?=
 =?utf-8?B?N3pta055WHFHcmNGbmhnK2kwQTBXWWhlakRDVzI1NDIyMVpPNVZWSmRuOElV?=
 =?utf-8?B?TTRNdVRxck5DM3laN3EyTWhURC9NYzE5MXdqRVJPU2xzTWg3dWpFMk4yMEdI?=
 =?utf-8?Q?K30gmseLbzpPNhlc0c2ZNDGfkg+c3ajFIgV3wzR9r4oI?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b399645c-2299-4e4d-897f-08db2ad76c3a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 13:14:52.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPHjknMUALQ/Uo9Im6L4BLkuh7tJHnFfqlZhufQ+Ad7fCDJq+/0OYSTeiAcIjS4OLpe3fV32gvIQJwoxtxm2JGlO3ZRFjCHDrszSjUARWsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7997
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 06.03.23 14:27, Frieder Schrempf wrote:
> On 13.02.23 10:18, Frieder Schrempf wrote:
>> Hi Alexandre,
>>
>> On 01.02.23 17:26, Frieder Schrempf wrote:
>>> On 01.02.23 17:15, Alexandre Belloni wrote:
>>>> Hello,
>>>>
>>>> You can't do that, this breaks an important use case and it is the
>>>> reason why I didn't use device tree in the beginning. What is wrong with
>>>> setting BSM from userspace? You will anyway have to set the time and
>>>> date from userspace for it to be saved.
>>>
>>> Ok, I was already afraid there is something I missed. Can you give a
>>> short explanation of what use case this would break?
>>>
>>> There is nothing wrong with setting BSM from userspace. It's just the
>>> fact that users expect BSM to be enabled in any case as there is a
>>> battery on the board. It is much more effort to ensure that production,
>>> user, etc. are aware of an extra step required than to let the kernel
>>> deal with it behind the scenes.
>>
>> Would you mind elaborating on your argument that this would break stuff?
>> I currently don't see how an additional optional devicetree property
>> would break anything.
> 
> Ping!?

It seems like you decided to ignore me for whatever reasons there are.
I'm sure we can sort it out in some way if you would respond, please.

Thanks
Frieder
