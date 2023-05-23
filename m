Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7570E6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbjEWUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbjEWUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:42:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85A185;
        Tue, 23 May 2023 13:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtxUlWayNh1grOLR0QPD9irmJjVL6/Irw/vdTPFJVNeZRqn8bQJPDmL9Lq0X+zoafjAM5sBDG1TBL0mHUTcxiPQpDB1iCTwtxxyPQ2pxgT4fdrSwUZ/fIxxXgSDOHVbdsNpTiQyZcOYQsP0sFLfZ1mT4bwAC5l+DHcolHJJRjQ1jqEHAMdYgQ6AIixgrA/2y5LWmFcRcmqaSf4m4EgUh0sTpatEA+hK93DrpJhTL0tIWm3k/Y1pcxE4JfoVtesjH58LGTVZ2z5THQdKaL4gbiNZsOC2QlAQ+3DthIJvnVOX6KdalE28Ww81cyiJilw+xRwqUN/6GTHUlkMTU5J5CPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cZSilln5igG1MiFmy53Oit5AWPJABHQ3FQ8QgO5BV0=;
 b=ZEdZAk1VgofoGaHVV4R4xJEqEQKMulCNNzHplBQ3POcvS1V6MOgz1kHCg9uEsR9iJNlqZIyfOCvf1IuJRwIWWdWt/ZAP4V+DqN0nEIhS90L97XdY2QD/jMf7TJ3j7J78C+N+LSTts3HBH216Ssv4hbpF4JMjPiL+IqxMMtJlLzqK+vXzwNdlDWgOyz2cuBufeiMlrW/Bs9yUu7BnweP8zLKbzvRQQ3j5z87LWRZtiMcW6QAy9EZkt/moQlH/4+ek5wofvppDSpzBb5eM6XzmdFrBGjGWKS1p32BpCdHjeIuV8w4iJNe4K/k0aU2HJEKFSCA1nzUh8zH+Lt30vXaIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cZSilln5igG1MiFmy53Oit5AWPJABHQ3FQ8QgO5BV0=;
 b=CnxW+A9imBhUEye03ugdBORJVMOw71LA2QbG6Mk4b/UU1iCaU6N7K2nO202Y3S5Yt2fkQRGZCWk43QvDTWrfpfWWQAdn2xt2v+98zVE9j1sWb/bbWkTO7eL566CMQGW/JEFZ0QVCP2TLiFSv1ZjBGnWdL3kLApcltIvf7ZiUKrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by AS4PR02MB8694.eurprd02.prod.outlook.com (2603:10a6:20b:58d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 20:42:38 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 20:42:38 +0000
Message-ID: <a2ed99b3-ee2a-6393-de98-3305c57dacc4@axentia.se>
Date:   Tue, 23 May 2023 22:42:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Content-Language: sv-SE
From:   Peter Rosin <peda@axentia.se>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::21) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|AS4PR02MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe9cc2-719f-45ea-4deb-08db5bce3ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqxujE81FamuiofiDHQ5SI5sYbN+DP6K6Tbx4Wm6o40OfrxiQIFSRAOYE2KvUuZKHD7X9ePXEVklKj6iJarxwP78XdS0HCeqESCv0xZIo/Evy2TYmq59IksmaQdcjxffb167cjrXdBjwZHBSAlmBtF5ZQQcJdQsqzsgt9MEuUabW07TfXA0iiMi8TKBlHdDGcunEFzCAdWCpAa0jl1UJFocraVnqKnlJEg8XRjPBLZKTUj0QJre3cBC+4p/m7xd6kq7Gig1jP4zpBnd9kr2WCuPgY354Jaz/Y9B5W0sVCkU63Cpek/qC2osjimXq9WKzCYDp0c3sJkJVBzvW15kAqdYKUb3TWZJZk442394ca0pjR5HiEvDbVbsK8il7q0n6VU7j/z3XybdF+MdyatlxgN0cx6z+Ho3ETA1gp6pZl50xTP61O/Gs4d35Mg709qfVKZcPyHyv0mjua14lKpFfvuFP7kbuUEjKDWe7F1dWsWXP+rOtHTv/gDAaaUzLGqNUW/96mEpC069Hb72M9WcExrS5pi485UJZHJrQCkNJLq9ZrYUdAjRIvqrDn2uS/QdWIGFcG2kEH900XGPmI+R8xfTss4HtxFx3qdCBgRo0Xeog61o6EBeSBqhrZAIEHyOUP2JZ4Jv0yYlHy3Czz2tJfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39840400004)(136003)(451199021)(86362001)(38100700002)(31696002)(36756003)(31686004)(8676002)(8936002)(966005)(26005)(6506007)(5660300002)(6512007)(6486002)(4744005)(186003)(2616005)(2906002)(83380400001)(316002)(41300700001)(6666004)(66556008)(66946007)(54906003)(66476007)(4326008)(6916009)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJrbldCZ0lReVMvS1N5V2MzcGxGeXVvZk0rZ0VRQ2FxSzllOTBvem82d3FN?=
 =?utf-8?B?bllXUXEvVEZueEdkS05UbStWa1QvVW53bG1IVk8zVWx4RHBBLzNoajA2MlJ6?=
 =?utf-8?B?Rll5a1Jsc1J6bVI5aUNSMFN2ZU1mMS8rVXVJZ2V3Rmc0dHVmNDJMenJQQmQ2?=
 =?utf-8?B?WlptbUxvZlozLzFmQzZib3NnRlBEVEJOQm1GdlZhWmpZRHlQRFp1cURZUC9L?=
 =?utf-8?B?ZklLNWRObTV1TWNBcWkrU2M3UU1SeXRtNDFpd3pseFcwb3pCb09nTEdZYVJx?=
 =?utf-8?B?TkhCYlhFN1pyZzRLekRFSHN6WGduZ2gvZHdBQS9PemlzQ0p1Z2NYTGpOaUJH?=
 =?utf-8?B?aEd3YkR5cVY5V3pVYnJaN2xMMVk0ZXl5Ui93TEdXYnBlK0Z6Y2lmMml0ZGpx?=
 =?utf-8?B?WDJHM0RTcmxLWFJhRzFzeEpMOTNIQTZ4a1ovU1F2cFVHMlJLYnVPY0p5OFdk?=
 =?utf-8?B?RU02OC9KUm1tWnVaaGErTzY1eGpnS2hJT1cyWWJmWTJuaTNSd0Q2aUZLODVK?=
 =?utf-8?B?Sy82V2kvcHFtUmFuMlRiekhieW9PaVIxa2x5NGFqWlpIRjFrK1hBdGJKVUJr?=
 =?utf-8?B?K1lyM2swaHc2V0tINXVsQUgrakhVeWtzZnVpQXVOa2xYSmVZQ3dDcGZxemxJ?=
 =?utf-8?B?dDMvREFQY25rc3pJOW5EdlRyNlBKckdGalh4NjR0S2lpWlZqbkl1YjFCVDQ4?=
 =?utf-8?B?ZjE5RUtVKzRRRE5jQU9RYWhXOWo3MStkU29HS21nUGZmdFIyZjZ2ekYxejd5?=
 =?utf-8?B?Ty9QejdlREttU2VRUXRmTlh3bzQ3cnA3MUdGZ3VxUVBwZnp6UENJWldVYW15?=
 =?utf-8?B?WDVSci8zMGNDTCtUU1A1QTF5dXJySGQrd0JUWEFFSkZvYktZcThuYTd4eHdq?=
 =?utf-8?B?R2tPTURXd2RUbHRxSE5yS3VEUDdqU085ZUJNWktNTmlRbDBCTUdnQkt2RTV1?=
 =?utf-8?B?bVJaemhwOWJkcTJyS21kNXE4K1VsZVlMb1J6MDQ3QWI0TklIU2tTQUF0aG9n?=
 =?utf-8?B?TFo3NjBzU2JHTWFrQXJpam1hU0RoalhIVXVHdERPaGZmK29oU1M3TzRjR1FB?=
 =?utf-8?B?b0hBbktxaGM0UkFkV1U3ZEdoVm1OeVU5UFVSTUpTUmVJT1hxdXkxcEpsWS9m?=
 =?utf-8?B?NEg4a1N6dlcvOTFXTzN4NHpTUGZpMDhvMkxSZ0l6LzBxUFovNlpYY1FGRlNC?=
 =?utf-8?B?R0hkU1J1T3ZvVEJBVEdKQ1pHQWZPa1E0UHdudktOeTRCK3FjNTNMbWdNNVh3?=
 =?utf-8?B?UmVtR1EzMk1sN0RtWXYxZnF2MldlT1NEWWI4MktFbDlxT25uTzM4RXMyRENu?=
 =?utf-8?B?N05KWEYvVnBGOWFzdnYwQjRlUTNHdmsxVkJmZjY0QkVQMEQzWTV2bTVmcmVy?=
 =?utf-8?B?NmFUbmh5ekRBN1R5bG1ORjBzWlR2RXB4TFRETVlEVDIxVUxNOWlZVWJVS3pU?=
 =?utf-8?B?RVN1SmM2Uy9vTkZORTEyTmNabXFoaHNscFdUVGVqVE5VNis5eDVGQ1ZmQmh5?=
 =?utf-8?B?bU5qd1dYRDFEeUVydFBWc21tNWdyYkFQKytXZXFzV3NEUTFxK0Nja2szYUtC?=
 =?utf-8?B?S3ZsRUxveHQybmx6REJRK0tVemplcW9kZFFZendyY0RyUm1HU2RhZEk1YUc0?=
 =?utf-8?B?MFZIZzZoTjA3SzdXN1ZCeXFkM25SY3ZMUHhGejFFei8yZSt2Y0w3OHljY2Rh?=
 =?utf-8?B?cW9qK1JibXR3ZmFkK0taZVcwNlc0TGhrSXd5TTJzclJLQzdkZ1I0WjFMY3hk?=
 =?utf-8?B?SC9OLy9kZWdFVkgrS1lCRXVyYzArNm9seHozdExGcmtJbkZiYWxFa3ZCbnFm?=
 =?utf-8?B?WmxIaU1Db3g4ZFk5MTQyVllLaDFabzdEWEgwSTNiVkVubnppQU8zZnFBSDBC?=
 =?utf-8?B?aEZVWitiNnB3a2NVK2FDTXVyMXltL0hYMStFbFBOZ3pBQmZTaWRUV0Z3bmFO?=
 =?utf-8?B?L0JFdkhjOFJqMERHVDIrOGRXMWtzTkhlTzE0Z3V3VFZhUmR2RUhlOSs5V2NR?=
 =?utf-8?B?dE05djFJMjZaMUlsbTJ1Y3lIK1hHWW5jaldmbXJlVjcyenFyMm1YOE11Ly9a?=
 =?utf-8?B?eGlrUDJnTTZCZG5pNWJIVjVLbk9oM1lsZ3VSbU41eTNzcmZwZGUrNmpoanBa?=
 =?utf-8?Q?ZBE3551+qVcK+ouPF/cBmoMkt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe9cc2-719f-45ea-4deb-08db5bce3ead
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:42:37.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TV4H1axEvgXR5EzVQMmqPOExdQmZusIZgk1Xc8YFH/DD8miA/ng3RSY9zB8qnfr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-23 at 01:34, Peter Rosin wrote:
> So, I took a step back and can only conclude that there must be some
> another regression to find, and I was confused by that other regression.
> In short, I was on 6.1.<foo> and everything was fine, and then I bumped
> to 6.3 and a process crashed. I went to 6.2 and that same process also
> crashed. I then totally focused on v6.1..v6.2 to figure out the problem.
> I simply assumed v6.3 had the same problem because the symptom from
> 30.000ft was the same (that process died). I failed to go back to v6.3
> to confirm that it was indeed the same problem as I had found in the
> v6.1..v6.2 range.
> 
> My bad, it seems I have another day of bisections lined up.

For closure, I ended up with this:
https://lore.kernel.org/lkml/221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se/

I.e. another v6.1..v6.2 regression that caused sound failures.
The two problems looked very similar to the suffering application.

Anyway, sorry again for the noise.

Cheers,
Peter
