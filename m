Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EDD6940AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBMJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:18:16 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2108.outbound.protection.outlook.com [40.107.247.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129113DE1;
        Mon, 13 Feb 2023 01:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzerTYGhcKKhsJZXr6Q+f/qLAffLSVsXUTLfmcejOtoX9Oo9vUkGEOhuA1tXM193sInM/WWQQoIx5T13UVk8tu4cqTstETxEBRzIEVvYYS4pVJG4BzrQsTPz8l62k1S+cL5euvmYK2SCap+3ZAoe1cGk/DrCJRsu/VRKDsbwJ0QWduogFv3jPny3ZsktghSPhT5znQZH7Awi2ERxD+BDGc/gDvc4W7S4/Cf9G+Ed8UW/V47OTWPoQ9cPK2rDC8+zpuwfpZuQQbxzQd8eB0WPi2zAvRVcXklEeY3hrJ29TAk9eNIu7kEtNse5gzIDFHDs+9Bs6Gh3PSwb678WLmqpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzUmuCoO+0lm7dHOJA+BodOBYy38nILjT8XCBROWSuQ=;
 b=TU8c8drxiA3pMCY0BCmeKSft85nwtmby66IH0oVv99adX4fRp7ySg79mHg/yQRChn1o2Wyi6ULvQXj4PuN6ip/YbYqpDMO9Qf+tO3tAX8+XNt9Iy4pyc21p10R2T0ZKQ5G8HZ3sRdfi7qdHTgPmmc4cG8EEJVnucs7UKdK0Bci5tUDmEmur+KmImXQC0b+0OBgofhCAz/ZSMdpo56EEYyhxDo2h5rW1RGwH5IB2AXNUqbOsETVdrhR/ebSUR3cC3m0AJlcHSCIzxWbkq03mlCkR8olWZiswPV0prUKMH99jW64ruHYuJa6OcJBY9JyySUap7WVtaKDal7coQtyLYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzUmuCoO+0lm7dHOJA+BodOBYy38nILjT8XCBROWSuQ=;
 b=eM8JLmXzAQhDZI8jgG2/9MIfZ42GjoFLoVLu9cDdRfmDBgxGy4qxchlXhnV1z2s8NZvDc8TPOuF/v47wGj+vE9AY8kZT4XkxHGV6lFIIM0wNP/SYj4mp2mmYlxRA3RCYWmbY5RMAth4yEyY/hUfjPmF3Ghi1MHfgRga3pgM7e2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV1PR10MB6075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:18:10 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 09:18:09 +0000
Message-ID: <7268b05b-bbb1-ec4d-6a05-f5ccbdfeed90@kontron.de>
Date:   Mon, 13 Feb 2023 10:18:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
In-Reply-To: <b58f5e31-f13f-6d90-774c-2017ee3de121@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f50f52c-f0dc-4d2e-079d-08db0da3395d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1tgSUSSPLzFVxLn6mVnejDrhQJ7PNUtrHwIhIoKseXrg5lMDlek7L1aKtrUzjNN9Jjv/Bsz7dIYkir9POOtZXlylt48tbBZBdVUStQwiekAVnDNl2DLIiGbbPqINLyKHDxdT2KwK4xgZRVRPaeoLhuxC3FxkfOxfRuyh+yEsaIEYXVWUvlVHsfWB6Xl4fuwDiMy+IwoY2jRiYAH/HiTbBI90OqjjCiga/q9x2Dyu7vl4PUiCD/YB944AKQZGUji5nVoIqKOhjXFOT6O3eYm7yvfBv3bh7M/IEkk5IYcdZaz4Z+Evo3ohI/T1beEX6RVCJXIWnIxdF+snOb0t8RqdD7YRxDEE1As69N/oz3uTTl3o4ejCXUSVtM3En7rfpXoxHiVs+D+8uboiLsSr1gXXkRS9bKHGHHp+TyRIVEhUj9BtS5EpQYfkKSlxIVzSFR0KPRIyuZsI4RP4qfGU9WBmlae2fPekFt/wKF/BqsoMpDBlAPjcrd5VABhJyzTzIwB57IDernd0fXlAzz3hlFzA8pbhlejmZFP/59sZgHxwVXakw5RxUmnCJuxZGUreOIT9kgvxhO8mOMuHJVkVzIhegCDBPpA0NQVYIfRdxqaaxE2kh2yVZ6IG1K8THzXR5EjnFk9DxK0rrKXgsDjgTeMNJud+dJz8y4i2f/+Jf5eFHKe5xE6sHbhKS8LcMewbbgv4mXw8tO/fPI84P8zfidiZ+YZRMjtGWT18zg3fpuiKhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199018)(6512007)(26005)(186003)(31686004)(2616005)(478600001)(6486002)(8676002)(66946007)(66556008)(66476007)(4326008)(53546011)(6506007)(54906003)(110136005)(316002)(7416002)(5660300002)(38100700002)(8936002)(41300700001)(44832011)(2906002)(66899018)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm8xODU1RXRHM2tKeG8vbjN5ZzdBRUY3SnFJK2lBU2piZGQwaGltNXNNSk5Y?=
 =?utf-8?B?WXZDVmZxNzhCeHVNTG9LMVp6UU9ESVFWY3k2cXhVZW5yZDVHTU1HcmthUUtK?=
 =?utf-8?B?NUZta3hnVGhLVlBrd0RuOUtFVnR4S0REME5RQWRRVW9HeHpSRjdmbUtIYkNk?=
 =?utf-8?B?d0R5blcwT0J1SXUvNGJLUjBhaURlc2QrOXFTSFFNbldodFJNQ1grZk5qUnV2?=
 =?utf-8?B?SVM4R0prbVdRNWpOU1hLYjFwTFBNRkIyRVE4QXRFdy9BVVFmRkNOK0VDNTdh?=
 =?utf-8?B?dEQrZ1pZUXNML0p0VEdyZk94V0s0K0lYZ0podmJaWDhiOTNHRkhUdkVmNFlt?=
 =?utf-8?B?SGZYUzFYTDlVRWtJV1Q0SlBKS216MEZMQUF3QzhScGlkMHJpSzVmZEY3NmZo?=
 =?utf-8?B?SVlCaGRlcWMrRWg2bUpSZWxtNGRFK0JzOFZDcExrWTlJQXo0TmxXVTZzNlFp?=
 =?utf-8?B?bVpnL2NSMTFLVGoxL2FDTFAvbFZtSjVzeURVRWZKR2hBNS9kWjJzQmViMnRj?=
 =?utf-8?B?L1F6enRVMmFhdDVoVlYzK05kWE5uVXBmZllMT2paV2F5QndmSGh0eHBDUnhV?=
 =?utf-8?B?d285RHdMOXhiNWxWZExCQlZ0dzUvYk52VER6Yk84K1Z3eHQrT3RiQUlwOHds?=
 =?utf-8?B?L3FrWnlLTmU4M0YxaE1rYVhPVVZuYlZpSVNnc0JSbmFmb3FvZ1pseHhOZmZQ?=
 =?utf-8?B?VXF5c3p2d1JhK3owT2NzOFZtejR3ME4wK0xZNEJJU2RKbmZtNWJQbWtBNm1O?=
 =?utf-8?B?OHEwWDc1NFVQMWxYSnZQNEZEUmRHUjRpbzJGOFczaklER0twNnRMeWxERlBz?=
 =?utf-8?B?Qk9rR0cza1p2MndETUZxTlFmMGZwNkhHaFNDVElXbHVMbDBESzkyWTAxS00y?=
 =?utf-8?B?RmNwb3hLOHIvdjYrQ3Y0Y1BTVVhVS2dGaDgrRDFZZVZCREI0bW1qVTJxa1BH?=
 =?utf-8?B?UDIycGJ2NnVSRHJZRnhDZzE1aHRhYXVmSERHdHVKZWdjMjNhZFBBaTdzQkhE?=
 =?utf-8?B?RXV0VUdvdTJ6ZWNPd2tDRFpxUUpjNTY1QTA4Q0tLVEhSSkdzR1RndlpjOUc0?=
 =?utf-8?B?b28wL1JNUlZGMkxtb09lZDlVczV6YmtOY3lOYUQ5OGhGR3V6V2xtUG02MEJI?=
 =?utf-8?B?TFBOQS9tbEt3eHcxdGkyQ2pLMFRSMURrcTZUQ2lrTk9odFlaV2hRNEpTUTVD?=
 =?utf-8?B?T29TYmxWL242OE5aV2NrUWZpK2hZWGNFM0JDUk0vU1pDVFk3Q2Nua0F3bDBW?=
 =?utf-8?B?SjBqOEgrR09aUFJMZDROVXNRckk3Tit0dU9EdHRMS3ZmdTdKOXcrYmhwWllp?=
 =?utf-8?B?bENWdTk2Z0dtcjBSc2ZRSStNZmVBWHJnOG9JbnduQWtTZEo5alY1NzlSMzVz?=
 =?utf-8?B?dzRweTdVMW1Qa1J1Vk9iWnFjMmtkSTFaVG1CK1BsRTQ0SlVsc3NUMzFYV2RW?=
 =?utf-8?B?QkFsNU93TDNSc2poc2Q4alNxR2FIejNLM0dEK29SOFNFeGpSemFoWEc5QWlF?=
 =?utf-8?B?dUc0ODBhR2ZjWU5kb28zRzFnZkk2MERQNjJybVJWKzI4eVBwbkwzZXlkdEZD?=
 =?utf-8?B?SG1HTkNSZHd1cVFsOGtiYjZyd2llaHFjclVkVEFYOElIS1hhMS9PdFZ1dm5M?=
 =?utf-8?B?eG1VSHlDamhXZURRa1g1N0EvdnE2dm10S3N2NzFBYUFJZDFLSEZyaTQrU3Nq?=
 =?utf-8?B?UWowMVRkZkdBYjNDajhNVzdXNU1lajNEbnV6VWpWTkRmSGIvS0dCNko1UmFj?=
 =?utf-8?B?YUo0dG8zeVBINGU4bVQ5WTVvcldmU1lSY0J2VFFsTFFrSlhweVNyL24yWUZD?=
 =?utf-8?B?RmhyaE1FbWNGT1Rib3o4Z0NnZkk2SmZwMzJTcktzZjlZTzBhNmg3M1BtL2xC?=
 =?utf-8?B?QmtSKzhzTVZKb1p3UTA2UTZnOU1RK2tmekdRZ0gxMUh3bGVnWHZEYmg2VGI3?=
 =?utf-8?B?NEkwTGpWUTZQd0FGeFlzWUJISUI2VlBnQnEyK1JNSURSSjhPaXYwV05MUUJj?=
 =?utf-8?B?NVJLQlY2TjJlSjEyTFFaTzdURnBrREVReWMyL1U3RlU1NCszajYxK1JtVG5X?=
 =?utf-8?B?RGNpeG43WGlJVHZJT0YvR0I1c3JpVGRVSXl1K1lmVVVMUTBXUGEvZ1F0ZnJB?=
 =?utf-8?B?bTVKb3Y4Qit0VzJ2TW9aNG9JaG1sQ1FQOWJyUHJ0OGh4SXdhUDNvYnlhNkYx?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f50f52c-f0dc-4d2e-079d-08db0da3395d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:18:09.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9A7oUSNbrWIWmgR5NgxXRk5kLdydEdjS74aGmImEK3nQUVB2r150ni+em5pHOoMW9N7F+zPdhN+cXutWssGbLBwXu0hfILq9K7ibcQsczA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6075
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 01.02.23 17:26, Frieder Schrempf wrote:
> On 01.02.23 17:15, Alexandre Belloni wrote:
>> Hello,
>>
>> You can't do that, this breaks an important use case and it is the
>> reason why I didn't use device tree in the beginning. What is wrong with
>> setting BSM from userspace? You will anyway have to set the time and
>> date from userspace for it to be saved.
> 
> Ok, I was already afraid there is something I missed. Can you give a
> short explanation of what use case this would break?
> 
> There is nothing wrong with setting BSM from userspace. It's just the
> fact that users expect BSM to be enabled in any case as there is a
> battery on the board. It is much more effort to ensure that production,
> user, etc. are aware of an extra step required than to let the kernel
> deal with it behind the scenes.

Would you mind elaborating on your argument that this would break stuff?
I currently don't see how an additional optional devicetree property
would break anything.

Thanks
Frieder
