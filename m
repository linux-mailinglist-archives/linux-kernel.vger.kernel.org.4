Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F270EFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbjEXHp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbjEXHpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:45:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2095.outbound.protection.outlook.com [40.107.105.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425421A8;
        Wed, 24 May 2023 00:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7UrFqZGpzHPKTVtmaORZ5k7xcTu1JfiShQBF9I7NsHxHYngG1WOf7mukv8LVMuuwF+poOFx3YkLRrWgqqsKge+d1f/2bw0BLJOwh38z+MbuDBLTZNjOYpGTmRxJlLTWVEbLw4DE9B6qrGZCVu+z+2G8fII13GIxv8FBNfxm0fXINUb/mcdRHR/qYenS1b4mwbs3Azl3cP/kYGjZ3ZWAgl1SXPLZTX+j+Fy1/BTUhaUH1iY1Cho/m4xeptRGd00hNmBSsfFO4MZ847CvlXomysWkclHtUv3XEEpKvWx1q8gkkwc62LwSYSclq4fBcWIeTLCGaFIVBPU0cPidyocZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhdrjWthq7IOXZ9EZdnDGAu/l7lGobaT9W+qzkKF6PM=;
 b=HS9zviYUrH+usFPN7xutd4L6RDlhwRRD+eAPoX0GCXZLszlxMR4Y0OYfteZKF45INYFvWTKGAE+IS+BTWfB7VbSHpma4uiljwY70/B3oTgyTYe626NkbJagIguFPZ0WUaVb+DhbUXRODqKntiMv9SK2RRrPhTW/cWoTqP+rvRKJFL9HZIP3REimCX/MUd3DyFb5xwJMDlaaTyCTjvsgWDNy1LKXHiyiQ03iiqC50by5BbwOGo9M+WfRzEZfcyTzVpvSJduEY3iQ8SM1nd2CYXn0D4UdjIjbBZrO6lP27pE0bcz6pVbo73b12YRBI0+GRObp4rFzvfgpZIKJFuGTOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhdrjWthq7IOXZ9EZdnDGAu/l7lGobaT9W+qzkKF6PM=;
 b=AMKErKMi9wdxTMmazjgOPwrmgqjrlAdfBlG1kiGzJsoRw40NkvIkc5Mz7SIeqjyTxYzc+4xp5FKsseTeZqV7VEX3/PhL1E4/UvDTzW+cEHRG5kCpK+u4BqYghdw603eeGBhOSrsXrqd+H1ZQwi0cS9tU9PbE4OLbSTRm86U+goA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR02MB10265.eurprd02.prod.outlook.com (2603:10a6:800:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 07:45:29 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 07:45:29 +0000
Message-ID: <3d51a79e-faa3-5a7e-6ce6-372684e0f14a@axentia.se>
Date:   Wed, 24 May 2023 09:45:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Content-Language: sv-SE, en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
From:   Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0071.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::25) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|VI1PR02MB10265:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c05466-d7a4-448e-4cac-08db5c2ad85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRfikwLaYpd+VDp5dCGkn0HXWIM4GZLWTuod9ihyD4S2TXbi+JV/K57uVt7MrMwBCXVpiQOD2BkUXUKXhsVRumFp9ujFf+0w1hwoPhqCG73KP8QyVk2cHYW7MfwzXF0krrMLvMBZBKSkKu52kalH7q031RcvKJI320k5EJNVd63RfsEUQLJOE63pVZ9HwYdsw1omEZHG1BM8Dsppb9rdvY1sd+nAJxO4BaTaR0zF4spVTUmWr55kaFG/aCke9NHCJYoAOrjunqgoivMlMS20LxCE6A3nppMbLakmlEzD4cpEE54+EdG89bdvG/U66kVqOGqKsfJbapLs0GO+tFM66lBfTKeicwfr3PgpBJJ1mNA4Q/E69nq8K3RPg1zn0xbj4AxfJnsYocDKuY7VrrP2H9Q7Q3SXKmXFzYZMLsto4D406d8c4tDvO/HShbZF48ZntVLX1XgwiSzTf7u65gS7gfLgK1Fw9hNoW7pP34x6Wa4bHsoEYGspUW2oErQmhUsjBlG7fgUKlON+Fx4RPrCe3UNkZhgDp2MVhBt/m1m04bcXh35KkHRRMEJZpIS/BN7hQnD4/TslWW16CDpbkL7JxX8PIFrPACXUlyvvb4JWuG8Y3vpkg8QMZnJDEUE1fYbTWp4Kc7XZn4h0Y1e/iSPsug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(376002)(396003)(136003)(346002)(451199021)(83380400001)(8936002)(8676002)(5660300002)(66574015)(6506007)(26005)(6512007)(86362001)(186003)(2616005)(31696002)(38100700002)(6916009)(478600001)(6486002)(966005)(66946007)(66556008)(41300700001)(4326008)(316002)(36756003)(66476007)(54906003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVdYUVZGNmdESmVERngzaDBHZTk5bE9KWitYcU50L2M5UU5hRThTWTNBZEI1?=
 =?utf-8?B?ZlY1YUF0WkJMUC8wZk44NDRsdFpDQjg5NitNMmNNM1RJV0NXVzVwY0NOU2xu?=
 =?utf-8?B?bnRDcU51eFJzYUl1UmZZVkQ5R2ZadkNybEFXamJZWFJMcUU0V1Y2V2hBb3R3?=
 =?utf-8?B?YXp5bUNFSHk4VnlzeHFOamY5VGhQOHllRHRHVDBMdkpUbFllTWYxQVAxZkEy?=
 =?utf-8?B?akd4T01jcVpxZjJlOHg2T2ZVQXJwN1EvTTdRcXIwWTd4d1NEaFYwRFh5U2l3?=
 =?utf-8?B?Vy9rQmhuTDJBQnFxZzVLaWhFRmh0V0drcXhSTEY5VlYvaDAxMmNuS29BL0lr?=
 =?utf-8?B?MTVuNys0UWV4ZnlsdTJDQkZZQ01RYm43MW5CMEh6Q1N1TnhrUjRtY3VhY0ky?=
 =?utf-8?B?ODY1Q3M5VER4T1BST0N5VklJNmdYTGc4ZVVIQTZRNXRCWFhpNzY0eDNtR1ZF?=
 =?utf-8?B?bml6bDFDRkdWMkw2WGNDNHFETCtIcHJ6Y2VKS0RhOUF0Yitmd1B3SndOTHRv?=
 =?utf-8?B?SDJVUHlQblhlN3puRlp2V0xxckJkV3UyTkVJZXh2V2JKTmRRcDF4MVIrZWd5?=
 =?utf-8?B?ZUlJSEg5WG93TU9GWGtqa1ZOV2RwUXdJT3N2bXlGU3BZT3o2dm50dFBCNEFJ?=
 =?utf-8?B?Ym9QY1hQYnd1Y0hFSjRYQWdydmY1OTU5Z29DTVpLZWoyKzhqbHhJQWRTU1Bz?=
 =?utf-8?B?Njd4eFBxdWZtVzNCR3BwT1ZYdnhrYzRTQ3crYXhaclAvZkFLK0VCUnZDY0ZE?=
 =?utf-8?B?UzlubElOSG9HYmFWbThqN0hjalVjc1c4WTFIbys5dFVyYktpS1hrbjhVTk9l?=
 =?utf-8?B?TjU2VnBNRmthTnE3NENsRStzQWVLRTR1MUZjaUJUZ0dmTldBa1VickZsN1RX?=
 =?utf-8?B?SEJTbWJsSjUwTTJ2YUpzQSt4RWkzcmlzZEhBTlAxTDZ6RmY3NldmMk9IUXc5?=
 =?utf-8?B?Z3FHT2pCaHJ6SWd5UkRUcW5VaGlmUmdhY3ZWRE4weU9aZmtZaWFsWnBTZlM1?=
 =?utf-8?B?MU1lU1FJOFNvMnpXZ0pTWkpyZEVUOFdmcVJDaUcwK2NLV3E0VmVBcFU0d2J3?=
 =?utf-8?B?M0ZtYk5BMzdUcHNqQ20zTUFxbllJREQweGZ0OXlpcEZiUitYVnNlSHpiRXpo?=
 =?utf-8?B?N0IvdDRLUVoxUlZCU29kMEVCU2NTSVZWOUJQSDJ5Q3VWK0QzZzA1N3FrR1o4?=
 =?utf-8?B?NHJLamFZUUNVdy9RNWJDRjZMdUxGaS9pNkFTWlFBWEVZZWY2K1NKT2dxMHU1?=
 =?utf-8?B?VTdQamtzWURnUVRYTk8xL1Y1Y1ovRXpHMTFzcnBaN1NaN3RBY0REelg0U0dy?=
 =?utf-8?B?N01leVVOM241RnEySUlzRkZxZkU2MFFSWXVKTklnckNBdWlIQ0hwMnBFSGd2?=
 =?utf-8?B?Skc0OExGbVFVNGNVb3Fia2YvN2pGeFNCa2JrdElDN0dxaUhEWTRCS3c0RmZR?=
 =?utf-8?B?ZkozLzVITGdvWVFhTTA3Zkd1ZFlSdk9MNk5kcXhxMXhLdUE1a21OcUpjOWF1?=
 =?utf-8?B?MWdCM0FmZG1HM3RTWjRTZ0c2M2l6KzNXQ0dQWlNJd0hzUEZwTUJBZjBMQ002?=
 =?utf-8?B?dTc3QVhlNHdYejBxbVQ0NVNTYitZYzBvVDJnWkpPVjE5MHcwUGRWMkU1Umh4?=
 =?utf-8?B?U3Bvdy92dVJhb1dEWE5rZnA5TFUwcEpON1VlTkRTUHVjU1luWHROQ3NHSkxv?=
 =?utf-8?B?MU90cEtrV0NOTlkydzNHTStwaWdjcXZiVFFBMFVXWlJOUjlvQk80T1pEajYw?=
 =?utf-8?B?cXBlejc5ZmJaVXp1MmVZVE5hM3NCcDBXYlJBVlBnQW9FWlNaQUdWeUNCSVlv?=
 =?utf-8?B?RFRYeUhxak80U0Q5Tk14eU1Mb0tXZUhQci93UVBpNDUvdzZOakFwTnJnWHkz?=
 =?utf-8?B?WnZaODk5RjRyaFEyVE96ZEJjSWNYSzdNWitQSkJzbGkvdmpnQzhjckFweUNI?=
 =?utf-8?B?MUh3TlZWUmhmMGlQdnBoOVBRN3M3ZnZrVmxVR0J6azh0OTUzVHFjZWE0bW5C?=
 =?utf-8?B?U05WdVZUTG9hWS91RFlTZ3BzTTc3Uzl6RnB0V09FYXNseHMrcVJSMlB3K05n?=
 =?utf-8?B?aXpYbnN3RG10bjkvSktpMTVMR2dCdWQ2NDU5UGgvVGZET3BHelM2NzQ5OTha?=
 =?utf-8?Q?BO5TpggigqqJp5Hn2iUlR66ov?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c05466-d7a4-448e-4cac-08db5c2ad85d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 07:45:29.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRctRt/pE6Z9rj++i3KYi7NPbW7kD7EaPg7+KvT1nR0Cd8kQptNjIct2bcQv0T9K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-05-24 at 08:07, Uwe Kleine-König wrote:
> On Tue, May 23, 2023 at 10:42:34PM +0200, Peter Rosin wrote:
>> 2023-05-23 at 01:34, Peter Rosin wrote:
>>> So, I took a step back and can only conclude that there must be some
>>> another regression to find, and I was confused by that other regression.
>>> In short, I was on 6.1.<foo> and everything was fine, and then I bumped
>>> to 6.3 and a process crashed. I went to 6.2 and that same process also
>>> crashed. I then totally focused on v6.1..v6.2 to figure out the problem.
>>> I simply assumed v6.3 had the same problem because the symptom from
>>> 30.000ft was the same (that process died). I failed to go back to v6.3
>>> to confirm that it was indeed the same problem as I had found in the
>>> v6.1..v6.2 range.
>>>
>>> My bad, it seems I have another day of bisections lined up.
>>
>> For closure, I ended up with this:
>> https://lore.kernel.org/lkml/221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se/
>>
>> I.e. another v6.1..v6.2 regression that caused sound failures.
>> The two problems looked very similar to the suffering application.
>>
>> Anyway, sorry again for the noise.
> 
> OK. After your first mail I had the impression there is another PWM
> releated problem to be reported, but it seems this isn't the case.
> 
> Just to have that explicit: Did I understand you right?

The PWM regression was already solved by 1271a7b98e79 ("pwm: Zero-
initialize the pwm_state passed to driver's .get_state()") and I failed
to notice that. I was simply confused by that other totally unrelated
DMA problem that made me think the PWM problem persisted into the
present when in fact it didn't.

All is well.

Cheers,
Peter

#regzbot fixed-by: 1271a7b98e79
