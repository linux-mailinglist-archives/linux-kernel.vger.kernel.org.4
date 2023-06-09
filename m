Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF87472A555
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjFIV0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:26:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2073.outbound.protection.outlook.com [40.92.91.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AAD35BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoyD1ojLdBcTV0Id4uwbBBsdPrL8c9s1VPWEm31p2QdVdTu2kVG0xJMHU7GzowiWmbnn3+Gn0/lKuc+dSd5c2K6lFV1d9xuPqmJZ3if//iTyobXp6w0MgnFXXqMeNamuLov6WNi2zMTvP9t3CWhK6cVRCl0H2hrsjv3K6XdvCTQJuObU6HX3npXIAlHMw0lzOrSIqcmX/0AWERoqtxNWmNU/DP3XGSEh8sd4ugOkkQXP4zZ9TljJwFENboIPvW9JWX39xg3oMIhLCxcaqKdasTUfgXO2GiWm2J+swRUCKLlmVUuGh1MylqXYlIErMi0u6fCmin2c3yfKAGyt/jDlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lNnQMRfFdafvsSHcLlKlIHDmDQuwkYDD5Axbl0Q0J0=;
 b=A5OIPowfdqxC0dUEs2JAk0XDYZClTt5Cf9ccCitiqjjMKvPgzvBwhjsYESMLDiMVALLiYsMpbybjWbq5Ppu5kXi/UIPld6ztQG/Hj1afzm4VUJ5zQ8hCzFd6RDv2JY2P07TP3mLFU4Jm64lmChxdfm2+mbjFN3mGYE3wHnhDTKixsnrlXqP0unsJ+cIMKaOd/lCcNj/BhniP4O4eOoRE+hNSfGFB1VaneK4gbJBg3+6aHIVBRdPZvy9KsagMI5E2vzCItuo2uGBX8EDUY2Bsxesrltk+T6pzjy41g0YPF4v15tX1R2/6YpOvlfLEdQPZKFDAzjuL8YlAmcqM5j21GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lNnQMRfFdafvsSHcLlKlIHDmDQuwkYDD5Axbl0Q0J0=;
 b=OcmCs73Wk9nLIfKur49kzDy7cPGrqF2Yz/LJQfPBYSL6RuV3teUuJAhUPbnfHHFzO9++IRsPO2Cet6Zmli68p8U+YhHjWxX3zuaMQgctkuuQa8HFNxwiefhOKmOfMPKYTQJk4wnKg2GtsVsk/+qmRAyRCWZfBevt6G1MbXsHeeDK+7hw4Gb5ydW4ykRSjUoitMl+w1ryQsbBB0Uo0kNyNLliizqffNCdC95ADx7EjTA9Fe+v6H7jNgcw3/RpTtpLl4JBmLl9x3a/zORnDUDDT3PFzanOc2XgeNR3hHt5NWq8SgtSyasj3iNWFTikSCwN4dIRwmu/XZ7e+u0Xs+gVdQ==
Received: from AM6PR03MB5282.eurprd03.prod.outlook.com (2603:10a6:20b:c4::23)
 by VI1PR03MB6544.eurprd03.prod.outlook.com (2603:10a6:800:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 21:26:44 +0000
Received: from AM6PR03MB5282.eurprd03.prod.outlook.com
 ([fe80::2e46:ca8c:a902:5824]) by AM6PR03MB5282.eurprd03.prod.outlook.com
 ([fe80::2e46:ca8c:a902:5824%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 21:26:45 +0000
Message-ID: <AM6PR03MB52825C77EB320DA9AED1E7049351A@AM6PR03MB5282.eurprd03.prod.outlook.com>
Date:   Fri, 9 Jun 2023 22:26:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Albergaria_Coelho?= <andre1coelho@outlook.com>
Subject: stuff
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [DQaYwA2Bew1+J8d27iyLP/zNxQci6P2QFwRJqHZSECT4QiOxbU1TohFPmhQL9h83]
X-ClientProxiedBy: PAZP264CA0065.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::12) To AM6PR03MB5282.eurprd03.prod.outlook.com
 (2603:10a6:20b:c4::23)
X-Microsoft-Original-Message-ID: <195aef28-7ebc-aea4-47ac-c3c0c8a55ef5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5282:EE_|VI1PR03MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 716bc9d8-ab08-41dd-0c68-08db693039cd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XqU8RndYekhxMgAyfLBVE4oIPuFNh+tdd6MTMd641OgrZqkvNHjze540vckXQ07LdqSb61WXfyDcyth/8808KSsl0BbRH75vatRq2EQsHz//Ive9X329GuaSVBO/0mhuAbDDinszhl9mVQ1dBkSCPzKkojRJY4BuPCpTwRMSIZ7TqF5ZDNfZfDgIpLoDyp2vp+GWcl/pUjXV6u9yh+GR9xZz59N5zH3TPnpNLea0RgvpLP4XnuAHeeCFwDZx4c4BK7ULTPPK/i6DGQVYhb9OLaykDlG9Mg78+E7H1APpTJVERSLdW6V669vu810XYOZ7uGeUeVz7tnziJ/YuSKnf80qGIuCFxXfrBOdlLqS/FuegWdK9ohnq6ugg6+yytzBG/QaVh4DNB6U/mB/TIlu1oPp9zER/BG3fOdez4KKftP6Ricl7Vlv5ZmDp7n98L/ZgrzfDQkDn6bxUqpLsuYQ9f2Bcg6Vxp9gFlt2roc/1tbf6eBgoR6faVuulwrg9+8cnJMTZiY2UAscBQB9gezcvgELbsvGhmfm3GHHxNZYMGfJJJ9UcnuV0mJT0cEaJcZA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW83Q3pJRGxNZ2hTcVBBN2p3U3pNdTRBMzRQUy9CYVB0WjBCSXVLaGVTdFZi?=
 =?utf-8?B?c2ZKUXdTQ0F0KzkvUVlWRFhGVzZEVjVWelpSZHZpNktCT3d1M3FrWm5YSnlU?=
 =?utf-8?B?UUc0YVdFUlprRkpCaERLRS9vVTNPbWJiNU1oaURRZHB0VTVxeDRqMlprZkpH?=
 =?utf-8?B?YUFIUFhxTENkQnVTdmZlM3V0M1RCYUNKM1VpMXQvOUt5UTRKWXc1VkZhYTJq?=
 =?utf-8?B?Yjltb0QwZHNlNStnK3l0VzZzblpKWTNYT082UVcxTktzR2dKVUE4aGhhWWNH?=
 =?utf-8?B?TkIwc2EwTkVDV1BRc003RnFqRmZGNFBDOGlYUG10SG16SG9vY01yT3NKYy94?=
 =?utf-8?B?NXBQQ3BGaEFHWWs2ZEhITm15N3hnQk8yWmxoWDFzbWF3Q2JyWWRYb0FmSGZy?=
 =?utf-8?B?T2FpblZpdjhZMTRFeUZtL21xbE9Qbi90VDc1V3Q4M01aVzFLbXZuK2NPMEJH?=
 =?utf-8?B?SVpqVFk3NGhsZWFXY2lsZ1lyc29XS3hnZklUUHVrbEp6S1VRdTVvbWxOUGgx?=
 =?utf-8?B?WEluMHE3UWYzYVZKSE9Qb3k5M3ViZ2dlRys0UU81K2kyRFlMNXpvUUlOR2V2?=
 =?utf-8?B?QThRZjZQWE4yamJVbWRsQ3h3M1hES0drYkFYdlFRQ2ExZWVIcnJpYWhSMUs3?=
 =?utf-8?B?L3dpV1Z3WUMycXQvMHlnVWNZYmVmdTJza0s4QklnNlRYV3M2TDVXZytpL053?=
 =?utf-8?B?eU5TcTRIMkRkZXZDSlJRSUVrc0VaT05wUlBLSFNqWWFGQmUzWVRuY0xTNnJB?=
 =?utf-8?B?aDJxaFBWT2NmdW9JYmJCK3ExZnV3ZzB1WlRrSjRNY2dudzJwOWNNa2thUVFC?=
 =?utf-8?B?SUhpc1h6YURuczJYYmVuVzlCOHE1eDlNZEF3VTlIb3RPc0FabGhBZzgweE1U?=
 =?utf-8?B?aFYrbkdKSGdxc25hL0Y2alhlU3IvTmkrbUtiL1ZVa3EvbnZKSW1maGJZQlRr?=
 =?utf-8?B?aTM4ejJnQUxkTXZDZ1FQTjUxbFo0eXJ1NXRQeHFhREdSQkdZcnFndDk5SFR6?=
 =?utf-8?B?WlBSL2lqL3AyU1dpN3MwdkdvK0VqeUVqdXdvcE9PbUdYQWp1M2JaazRqOFN1?=
 =?utf-8?B?cUtXUEpORHNIRkJPUzlNRURYQzNsUTVJbDJ4Yk9SRW51aEMwaEtwK1ZmNlkx?=
 =?utf-8?B?WkI4NmdCT2ZNMFBmcGlpNXlSeVNCTUtTM0VzcW5IOFFrK3JuSVhpb1BVNWJP?=
 =?utf-8?B?Q3ZBWUVKRmhVK3VVUDJ0MVczeUlHQ2FYMG9HYjhvb3UzS0hyQlhUS3pRdTN6?=
 =?utf-8?B?WUx4cTgrS213Q0tZQjcxTzFHOGZNOHExS1VBck1jY3VHT3ZQS1NPNjRocStQ?=
 =?utf-8?B?cjFCSHh3aDdONnJKSzVsMWdBb3JmY2ZJaHBHcjVHb2xsOHNsQnROZW1sVEdE?=
 =?utf-8?B?WnNGcGdGUThpUlRFSDJ1NTVDejY3M1grclRySGIxRnpWT0ozS3hoSWdVRHFn?=
 =?utf-8?B?K1k4cWlUS3p2YXA2VmFnYzdOSjBKeVN0V0tjbWszUldsZEx2b0ZmZXdwSnNM?=
 =?utf-8?B?VEtrSzhKeHcvQmJvaTRoeDBmNHZKOTlFdjZxN0J5SzJzQytKOE80OXFkYVlS?=
 =?utf-8?B?VTFBN1JQVklCeDN4NEdydmlUbFFIa0NOa2hkK0lWbFZBa2pnUXc1VG5wcGpk?=
 =?utf-8?B?a3F1SkdBMENjUmNUUHJEaGphZUQ3MnRIZkFRdTJTVTBoL2g4QlVLQUNkTDBs?=
 =?utf-8?B?dVc5dFJLbjJOaVBDZGlMeTdkeWphQ1hLS3UvdHlJVzNrU0R4KzVFRXFHSXVD?=
 =?utf-8?Q?mYLfXwciQKwHaNJGSI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716bc9d8-ab08-41dd-0c68-08db693039cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5282.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 21:26:45.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6544
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What about many functions to read/write memory

for example

malloc()

allocate_directly_ram()


etc....

And what about use cpu resources, for other purpose?!


like, page table -> cryptography?


thanks


andre

