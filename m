Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7420C67B6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjAYQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjAYQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:27:10 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2026.outbound.protection.outlook.com [40.92.107.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB0E13D5F;
        Wed, 25 Jan 2023 08:26:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh5nNppO+f925Lyv9uT34oZkGTsqJY+a1PZTinCvhA8Cyi/zp5IyAcslVkjEOw3Y0jzrt7U/fK68rjOThsHjRS+5qwLlI2WFmFwwzcagUYLWgxslPIumsbQp2l4lW22gNywa+R5dYR9MJ84OcGObnjT7xt0OmDx7jdIhdoFxJm0KtjSVU9mtv8LjbVm0CZqEVkfwUohK6uvdA99Fjzr84DPT8EN2zDzB+X5XpeK8SdyQwOZrPOMEq94CRiqKdvqWuNIjmIysPRBaQTKuC8Mfdxz//fJQOHVfg4YWFeJxxanusIRnGBevEfkczufTmIrMnpFXZdlHOXV/x4y8392DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/x2N2jdglW/FWBEjKI4Idb/FU5Fp+Ub0dKji/v8rSc=;
 b=WRuEJFubRY2ygbM2hDJgZ413Q6ueVLKNt55GJAg3/Mc6iobMn/d9kwOtXYuNNbgMtwK+p/sTGbxSsRtFs83pR/tXwUVEvbVc896GjLr/AcyzwWXxwaAtN77QY8hentuzAxQT4/GWAhjN+XLi625m2+TqB/rwvcAD2iRNAU74rUS10iB5beuyUzC1hwgauQVxU5IsP0ugApOko2e+Hct3mXguQys9l2Z/4ptPCQ87u+uy4QVkiQY92lX78IYlg9Q70IcYZ9p5OaX02mRoi/Z99wAX4xRr+7gPbqgT/oc9k4xjKdyEu2aBsiravKzFss+pE0tRAksWwZEiDFRm/9Ezjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/x2N2jdglW/FWBEjKI4Idb/FU5Fp+Ub0dKji/v8rSc=;
 b=inQI0HQjckybmrxg5nu0ER38FAHZVWxRg6oaqqcFiMJEBleFsg589UwbHKip9VGEBG0+gyi35YpNdDW8AKugARMOMEdLyw5+aNteLQSa9y4UxlK/Vn+zffR+1FNvURs9frjCprwLOiMwNeeHmHJ3SAKZxe3VpIC9w884r/y0z5SJ3JUxh2NBjzJ2juQcSHsvEyKiT/McweF1BzxipdrRrXKhz8m0HzzmSKzE2bgXOf0EwyOQiufZZ5dD1SNMDON0Xdr01XvHhD24KHLvPvbNnkNWDB9bOmGfUHanhKhIiYcJ4JbawnMlqtbbcwZR6RXP6YRh1y0YmLesT29K4/k/PA==
Received: from SG2PR02MB4090.apcprd02.prod.outlook.com (2603:1096:4:a4::16) by
 TYZPR02MB5868.apcprd02.prod.outlook.com (2603:1096:400:1f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 16:26:55 +0000
Received: from SG2PR02MB4090.apcprd02.prod.outlook.com
 ([fe80::ef9f:f14:b935:7b92]) by SG2PR02MB4090.apcprd02.prod.outlook.com
 ([fe80::ef9f:f14:b935:7b92%6]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 16:26:55 +0000
Message-ID: <SG2PR02MB40905C54F83BE73B4E6E17EFD7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
Date:   Thu, 26 Jan 2023 00:26:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: BUG: crash after suspending
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <SG2PR02MB4090B1F3E5EC0B7FCCC01807D7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
 <Y9DpQGj+9FZglZjo@kuha.fi.intel.com>
Content-Language: en-US
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Fan Chengwei <fancieux@outlook.com>
In-Reply-To: <Y9DpQGj+9FZglZjo@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [1FkdXx34a1JyG5LcKsEpepcI1OfMIVTCINJu6SJEUKUwZqqQtLM+UgUdypjzpwIA]
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To SG2PR02MB4090.apcprd02.prod.outlook.com
 (2603:1096:4:a4::16)
X-Microsoft-Original-Message-ID: <70f0dc21-bd19-82d4-b5e3-78e5772eeafc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR02MB4090:EE_|TYZPR02MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c305e3e-024a-46a7-4296-08dafef0f927
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYKdbd2AA1iXCYMG2ZyOJQn860MS8VTN7TykyJsdChfwd5mUqiWYMeV1IiKTa3aOCmIPcds7ennwsJvDNzRuC6NZqaZgsgJHEeVHMwmuK3Cy+mJM9AnTRJnxOCtGgbTjcx9G4kwshtdMIArGqNKH7gxISllRsMQMvXFnhj3CpZwBe5MYSJiV73opQfE+IB+lH7V7kUhwvouF8tAPJGaF0dX1jI29GbXy/vQ1O1Xj7TX4xuVgzPAAxQEDlddroyJ6mTSetxHFgQFRUEHAAIAGFAWV36K+q9hqPDGKdzjFBMJ32ekHY/QksHFjQkH8fl8RKZJM6g5Ro3s5GiJrbLLzJpTXf0ohXNA5/BhmuLw7NcC3gBWWgFG768UZwRjJh5dow8NPlfu7kBflV69hjvs7DG4jJcdfYDWwPdkV8Zxtwg6X0GJVVHX6lMO/OnmHHKL4NsaaZevUyONF2OLfZbhoLI4ryPt+HDx6WbOpl9fcE861wGMT1uj3EoG7Ea+nUg5HropwpztGsqcK9nnOiRraKp8bHvyiGPYCjyHW6SJFDsUrdfh4Bs+ZfvKd96oZjwxBkf9bQRPWScmEr9qvjGejlQ29QjXdJZdxVV92Qu+OPi5wRMw4wR2TNgWmtt1YWG5upc4haJ27SobNWuSPxpdtwg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnoxQjBDWEx5Y1NQRjZSNTNtb2d4amZhZGF4OEw2MG1mbnVNWm1NeVFEUmNz?=
 =?utf-8?B?eWFzMDQybm82NFlRTUdERm5rZ3J6U2s1RTdhZEgxSGRJZldObmFvWS8xTmNz?=
 =?utf-8?B?eEI5UWdNTWlHdEhMdXlib21wcVRNRTJkUlRhV3ExMCtnQlNvOW92S0kvU1hQ?=
 =?utf-8?B?dFI4K2hIV3hKa2M4YnJBd3gvZ1dZdlBKdFlmdWNqVnhMbG9oNHFiWFM4TXdY?=
 =?utf-8?B?YUs1TWZ2Q1A2QmkvVXdVZGg2ZmFtTUNWbm8rb0lrQmFwNXJZT3RqQStyTzg5?=
 =?utf-8?B?UWxCRlkwMEJUeTZWd3JxbXVRK0g1UnVNS0xaQ09mak94SEVWcWg2d0dwZlQ2?=
 =?utf-8?B?N01IRW55bDg1MTA5cXlPei9JL2RpTHBpWDhSN2QvQVE3VUYwVTZxMmd5Q1VE?=
 =?utf-8?B?akVxcnk0ZEVJeG9JenFKN0FzN0FFazJvU1YxKzA0M0V6ajhIZEdSYVZrZ0dE?=
 =?utf-8?B?M015TzF1ZHI0bUcrT0RnZjRyZjRzcHpLQ1g4ZUE0RStzQnhvM2JhVGFHR2Vi?=
 =?utf-8?B?bDJxdkZXSUxoYzh3b1RRVSthWThmS1ozMURWMG5tWHEwRTdOWFdHdmlUSTFo?=
 =?utf-8?B?TmtxM1k5UWdMOTNwZDlWMzJHUUdmakZTSXZnSDh2dTdrckFtK05PVWVGQ28x?=
 =?utf-8?B?UHhBVzhMT2xUSzBmQ1JHYVBGcW5vaWRIeDd6VGpXQ1VYR2oramhXbXo0RU8y?=
 =?utf-8?B?U3VrM2hVMWs1cjhaY3Q3emd2RzhFR2doRHBWaXFVdzRLZGtsekpNYXFCZk1s?=
 =?utf-8?B?V2lKTjIxWmM3WlMwR2J0RUkwL0V1eThSaTA1bnFucW9Qb0xURWFpY1RoYmNX?=
 =?utf-8?B?MWdUZE1rWXMvK2hyNHVndi81R0ZzUXdHOG1HYW9XQ3hrYVlzeVN0dllwVzRq?=
 =?utf-8?B?UUZKQUpZU1ViTE5rY2tId2wwSGNpcFJjK0hsMUttY0xHMjZ5YWJuRDd4TlZ1?=
 =?utf-8?B?WnpvTnFvaEtMV2JtS3Y1NTZPQ0dDTExpOVJzZlc2SGgycXkwejJNUnA0UmZV?=
 =?utf-8?B?Q3pMMWIvQnMybytEVVBQTlEwYS8vVitlc25rc1R1c05IVEROa050SFZsR0xH?=
 =?utf-8?B?V2pMamN1YkV4cTNGcmJuYm9DOHN2U1RrUEd4ZkhuVnEwYWVtUWRKQms0RUIz?=
 =?utf-8?B?TEFpWFZ0Vllhem9aU2dhNHg2ekRMMWRBcWt0YmQyMGMxRC9kd0l4UWFTT2NU?=
 =?utf-8?B?VnZyRHNyYmV5cWxGdE1qUnY2dW03U3U4dk4raHUraHdNZk9OWkREVEZxZlQv?=
 =?utf-8?B?MjQ1TFZhMHlWU21kajBwQzM2Vjh0SmJDeVlmc1drMXNPQ3M2K1dhVDdsRG5w?=
 =?utf-8?B?am1EQlcyZk9RRkRLQ29DcEZjczh6OHBuTzRvVlVuVE9nU2ovSmVoc0dOM1dt?=
 =?utf-8?B?WjNoMURxU09LbUR0VTlEenBFU2Fac2hlVkcxeGg4bjBZNWtzN2ZjdHlyTXlN?=
 =?utf-8?B?THg2MGVraVhMeFJHUGoxY1QzUzJ6WW9hT0xTRExNVk5vanJrdWx2Ykl1Wmpy?=
 =?utf-8?B?bXZCZU9NUXNaV2N1ZTJZKytuN3RFK2NYR0pyVHQ4QkhrTlQ5VHV3cTNlNmhZ?=
 =?utf-8?B?K1UwOWljWElYc01qL2lzMllPWk1Fc2syQm9nTTZVU0FRY2o3UVNrb2Y5c21J?=
 =?utf-8?B?M1AyWFA3aUhJVXZFdGVXYkdpK2p3b0Yzbk1kQWNHelhaZXg0cXFLOWR4N2Nj?=
 =?utf-8?B?di9aMVJSaEFoem9td0piblJBY2JSdDJVL3FaQWZiSTFSTm94V1JzRHlyczY4?=
 =?utf-8?B?ampmS1pOdzBmWnpaV2loWDhvLzkvR095U3YrTE92dkoxRy9EdkQ0ODZsSkUv?=
 =?utf-8?B?WTkvTDlzV0FlalhEbDhwUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c305e3e-024a-46a7-4296-08dafef0f927
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4090.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 16:26:55.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5868
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/23 16:33, Heikki Krogerus wrote:
> Hi,
> 
> The information you just gave is very useful. Thank you!
> 
> I'm still not completely sure if I understand the problem, but I'm
> attaching a patch. Can you test it?
> 
> I'll also attach it to the bug.
> 
> thanks,
> 
It looks like the patch worked, and the original bug doesn't show up on 
my laptop. Thank you.
