Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF446DF495
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjDLL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjDLL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:58:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEC7ABA;
        Wed, 12 Apr 2023 04:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVuHAEq2xD+SOUxOyQjiNvlcq0JhSt/DuD7VES6VYspklV1RakoG8hkHzGlcoYCc2GzlK16ITPEzs5qG5DVHMNBdZazTfAUEtzPF5MIvl7I4piR+fHBI3lD4nZ7rveLJvl+Rg68fOKILugpBw/6nv+RjYOOab8A6MBKrsEKuaJx5Z2lRSCiZC6rNkd1KjfKoznkg3Mn0zdkoStfZizV4PWuroKnlsMpYs92U9kgj9kqLU7jzmunihZhGCz79EdQbwtgnVZPiMCFqkFINQXADozwwpWFl9EKBZxCwyPZw6uCTbCIetuZQ5SeXC1AXaGq2ifVOwjp/ertx7kWpCJepMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggl+rPwLCtwKP7eyHLvj+vpcJ3IiUI0obGJOxcvOuXA=;
 b=T2WhgKBJnflAR2bhoxj77mEIE0QqvQaHPr51kHRBHBGj6HMrL2Nx8FxoPpldLCiwJDV2M9gPFVC2+AyT9LkdFDHiFUlGTkQhg91u5TQ0lNauQebwn5fcQWC/ALvFv58T3STC/pkqFwPiw7tnjw8MC7BMDQnGrOnfrMEbwFZY0s2O3LdP9L3Dqw/V7D9E1HsHCmviJRCnCwWskPfRLYD3qIcdopv32hPXgNQbyUod4JJQu8PEfLq0PrtO4swGmgxACLLv9cWR7LKLhl0+zwoaeFcb5p3OR1GWW+O+lOIC5oyF9m4egwdMswWKWxDyfRzFqe+9F30MgaE78jEuYpl4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggl+rPwLCtwKP7eyHLvj+vpcJ3IiUI0obGJOxcvOuXA=;
 b=o+tiwQbyn5x71GFkt4ZvizWp15ePRADZYJWtzQKvco1mFfaZIgJXXMBUc+bnBBzHW3Oz5yfxbvCA5v5sJ5+wa1BDmmV5xemcPqKviIZKEyio0lyjVMXE7Da2xKRHGegOwChfgGhhvrbZcxz+iu1Ld2rmmlGklVGRPexTlxRmBB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV2PR08MB8076.eurprd08.prod.outlook.com (2603:10a6:150:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 11:57:38 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 11:57:38 +0000
Message-ID: <8fe5c9c5-6eb0-86ae-9e5d-fbaa72be25fe@wolfvision.net>
Date:   Wed, 12 Apr 2023 13:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
 <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
 <ZDaa+qhoZxZ5ymxL@kekkonen.localdomain>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZDaa+qhoZxZ5ymxL@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0501CA0042.eurprd05.prod.outlook.com
 (2603:10a6:800:60::28) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV2PR08MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b6efd6-65a8-4d83-8c7e-08db3b4d1ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFtqGz4VYpOZNb3B6ozSKtaDlpEbsMMkYow4g8ua7+ZtpRj1JclJD/z3v+Danab6A7tbdbm8dF3YbfuiNFWHMe+Mo+p8wwk5eJY7LdN/PecFR/jQ7oXzyB5Wb8yJFOpx2pJV6D3AgjwngtOLwqWfLxhJBcpZU8ElpcoPyck++1xt5SYlq9hY9aIvs4RI5xafDvEvfKgyG+UxrA2A/R3ZUdSUOx28ddLexeBn3kq+sbkOAYhX8zUp7eB4bf/fBSZOMSQ6HjUV8Kb5R+G/jPQ9EWEpzwyDCm6Q/zhaCKCfK0yTvaWZz2GlD0xgkxo1BsgBws0ocXjKlBgg5eGgfiOJW9LMSgmVefaoTQepqpT04YtcAZdfxDFS81vz0S+dMlkTQp5BbmKZbJ/3dcLQpPFcGOEZe2aXbnyBp3kwBNQYw1wqOgiwNy5McNWwZq7OmTKWGVYPsMxC03GN/A1KG6AJGGpB2ozUQSdrWjo4E/EenENl1MqKYewHayXd2QfBMubOHDLMMNFlEpI+e6zrFDnqCLdneqrIq59+17U3ro3LwI3zebDWTQDh1AVLPpdMoPA306uvhNTT2sQaJXWgOTVtKusHV6RkA3iRXA65VXoZxanUgl6/IWyJeLavAHnqUNYXrSBy+9HQpEwO3n+XeO1R6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39850400004)(451199021)(36756003)(86362001)(31696002)(316002)(6486002)(41300700001)(8676002)(36916002)(4326008)(66476007)(54906003)(6916009)(478600001)(66556008)(66946007)(5660300002)(8936002)(2906002)(4744005)(44832011)(186003)(38100700002)(6512007)(6506007)(26005)(2616005)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdyQUxEa21pMmFkNDJrOUdFMVJyMVdTeGpZb0VaRWIvTm55alhlTkpDdTJr?=
 =?utf-8?B?dm9YZEp0emlLK2F5bTU0bHZTeDdxcDBPM2lLM0FJbVdweEtPeTdIM1BtN1B3?=
 =?utf-8?B?aHI0ZWJkSVpSNU9jRGJVREh5cEUzaU8rUVV2WlRlcjkwUlRHYldXaFRjMlZO?=
 =?utf-8?B?NkRLeVdheHQzc3RQekdxSmNlekhZc1dTKzlTS0xhdUszVnZreENKUW1FdCsw?=
 =?utf-8?B?bTM2bHEyd2Z1MnlTYWRUQ2laUUw0VFdVYnNvb2tsRXdaZjR3dGdZbTB4RnR0?=
 =?utf-8?B?RDNvbzdYUmFlUlVHUlVZcVlaZXZlUFcwVDgxbTBPYlBYYWZpbytPeS9PaXhj?=
 =?utf-8?B?VGNlS1I3b0dTcjNKOHE2c2EyYXBhejhMV2ZORStQbDJCSS9kZ0dwb1N2cWY5?=
 =?utf-8?B?SXJXUG1JWVNldU1JRUlvNldGdzk1a1dkTDd1SjZaOE9MSExwV3I1QldOa2RK?=
 =?utf-8?B?cXFUbTVLeWx4MEpqQU1KelpIZWlLMXpxemptUnVpcWE5YVlnblR4U3kzdXVM?=
 =?utf-8?B?b1FCcU1JRFViYUhaYnlrZC8vMkpkbXZ1VUlVQlJiRHBHSjdZcXRoUzBTS3Nt?=
 =?utf-8?B?ekxNNWVMbjJmL1NZM2p4elhoR2o1bEp3Ui90VUI1ZTNnVTlpRVhJSjNFZkVP?=
 =?utf-8?B?YWtsNmgrL1MySGFDZDFCLzg1NWRHMHRCb25tVHoxcHE4K3IvU21JUE5kbXI1?=
 =?utf-8?B?L2FBZSsxa1c5aXdGeWt3TkdkbDdTY3JYY3JGZWlPWUlEQlkyWTRmM1hlWGM2?=
 =?utf-8?B?S0s2a1YzeGc1N2VMK0Yxb1NDT2wrb3F2dG4zK0tTRnR2RUpEa2NUdUtOTWh5?=
 =?utf-8?B?emN1RGFha0M3ckx1OXBvb1Z0VWUyZHgxVzhnYlNsQUpZM0g4eTNzZzQrbDgv?=
 =?utf-8?B?cDBUWFJlN01QVWwrWmhEWVpoZDE0SVVaaG53V1QyMFpWMVR3UzIyZ2tTbTFS?=
 =?utf-8?B?bWNmdTZUZGViNVVKK1phbUdTTlVKTnZpeTZRcWp2eWdpb1JqVHh4ZUV2cTdI?=
 =?utf-8?B?Q21Sc2FIc2VHeHZ1MVE1SjIyMC9ZOXdrVHRlK0gxeGhmNHR6SzJvbGFMOVJL?=
 =?utf-8?B?aGlZcWpSNzhaR0g1NzhMUER5VFdlRDZ4NDJEeFhlcVlDRmFSM0pXbU9HY1Bh?=
 =?utf-8?B?bWdmVmtyL0o0VGlTemdFZHhkbUgvYSsyMWdZb0QycWlvQUVHMHFQVmRnZW03?=
 =?utf-8?B?UkJYNkxwYndtbUtNL3JLY016d3dya0cxQ0RsdUFUNy8xa2VDbm8yMEpCcEx4?=
 =?utf-8?B?dWpRMk94cmRxbUlJOEw3d0hIN0orZHVsOXZRWjY0bFZTWXB0ZkRieENCemcy?=
 =?utf-8?B?TXNCOVlLaXhLalRsR0FIMU54UlZUWDhzVDVrSjhqcFgzOXBOc3BjWVVoOG1F?=
 =?utf-8?B?T1N4eHVQZ05oRk5YKzJTQ01pSE8xVXViei9Yai8zT0pKTTJnZ2Y3T1J2aGNk?=
 =?utf-8?B?SGRGZk8yU3lJdjBDM3RNQm81b1FFeXYzaEpuQTVRSFBZOHhKT1pqZXJlN0c5?=
 =?utf-8?B?YWRqVXMwbmZibXNpcjJaSmExcnJjNUdscUhFcjF5MVkvYlhiMzQ3Z2ZUYmRO?=
 =?utf-8?B?cHYrRXFteFlYQWluejg3TnZOT0wzbEpQZ1A4ZWxhcW5ubmRhY24xVkh0bXd6?=
 =?utf-8?B?OGxycXV4THFIOEpQL1RuaStoVDFWVGlkOUlNWnNCMzNMazlPZEgyYzhBT0dB?=
 =?utf-8?B?M3VkZ2dPWDlRMDhZbHlOOWxnemtTK2xPOFJRTEZmTHg5QWMrWFZGUEJyT1dh?=
 =?utf-8?B?ZXlpVkVnWVpYSXRXbkFsOTBESWhDNnpucWExTklOL3kyb3hDMG9IVVBza0NM?=
 =?utf-8?B?VDZieFViWTlUUmU5M1VQN3cwWmZXQVJ0TkJwUSs4NzVGMHFzV0NnQVBqN3B5?=
 =?utf-8?B?WjJnUTFhYWQwN3hhL0dVZDZCYWx4T3hyTmZNTVRPcXFoUVJnS0E4T3FxRDNP?=
 =?utf-8?B?T1ZZeFQzTERkcUNzRDFrdk1CbThsZ2RRak0yQzI4ZS95M1IyNk14d2tTdXIv?=
 =?utf-8?B?WXd0NWNydFJXQjE2WDNMblF2NkxFSVBPQWtKRjUxdEgyTHZjWXY1RklkeXR2?=
 =?utf-8?B?WFd5OXNWWTk4bXcvcEhiWFdMUGRCR3k1QWZDbmZlNHBsN0prTHRYaURPR244?=
 =?utf-8?B?SWJUc1lIc2RLSUIwSjNlcWUyNHVCOHhJVlhBczl5dUVhc3pqVmowRzVPY0RN?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b6efd6-65a8-4d83-8c7e-08db3b4d1ca5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 11:57:38.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vGarHXEyGttMNr4wm8d+T2b0kNY+af8kBU4AJCCU+L6eaixMh2QPo5GtQPhLb8NScm2XUQGTrlA+y0AvmYFXJxvIqlqc5UFNyAumX7GFlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8076
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/12/23 13:50, Sakari Ailus wrote:
> Hi Michael,
> 
> On Wed, Apr 12, 2023 at 10:00:26AM +0200, Michael Riesch wrote:
>>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
>>    then what happens if the application performs a
>>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
>>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
>>    the application's point of view.
> 
> Would there be a reason to implement both of these controls in a single
> driver? AFAIU, the relative one should be used if there absolute value
> isn't known to the driver.

Probably not, but on the other hand there is nothing the prevents a
driver developer from doing so, right? Point is that should there be a
driver which does implement both controls, we are in trouble AFAIU.

Best regards,
Michael
