Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3CF602982
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJRKnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJRKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:43:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60125.outbound.protection.outlook.com [40.107.6.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45094B44BC;
        Tue, 18 Oct 2022 03:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWXsO8jZkWX8DLJ6838s32K5SOSvFmrloFnROEWkQvZTbbE1lUKuVBE/lO8OdumIzuDtJNaB+weYilC3Nhp2jck3w8XDsgDT3pWM0oOBDW8HEJPwT2v4bCqQ8gF8zHY8i/Ce3dkYIPhkj0DlhnpxyvBC5vgPQOLYCtES30w25VibEqgc97l1t2gH7JW9YZrzjd77cyDKXufhRj6Yf59cKL14VDDdzO6y+dGsx5mMgdKT5BfJGnrMyuVTl0YpLGMl6NR+LNy94NoRWCz4Myd/rIcjcUkYBC94nY5sSEFlacCC+pC7SwB90BliO/HILnFiOcBpK3GsSo3pBjrF5oYNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbtd4vmjQG+cxMecYvCUhpl5nFIJvQ7q9HgNKSPXIik=;
 b=RpFOjXrvtWnL5iMIExp8iEPfet8z6tQK/jY9ZKZA71WjomuWuCNWRmClLLKoT133ZhaDQ6x6obGB8iwwWsVjHi4LdKl245y4ZsFQiBXwgFFfwoBUz7DBjWkQZcHsh5cpr3KnWQjky+jw9wZYbTZpwGdVjdVp2SRp9SvDpGy917LmhOCt2zBXYw7kwauQP3VANOcVBNmGYiOgtd+W8TZ689CuVrN83pqeZcjrmDAbDne7aZ5/YhQEYT/7s3YvuWkXl92OrgiAP57/0+gka9E4ZHLYB6BW3FDYVdfL2Wl0UpvAZTc0/sXu37PP5QJeZUb5Ie6ZmPXRCzm+RVA/cqeRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbtd4vmjQG+cxMecYvCUhpl5nFIJvQ7q9HgNKSPXIik=;
 b=J2phiAnfx/6/B//Ki7YO7jUfXDimMIDCypJvUYrDrfJo03PEyrc2GR4OLDOvL8mfV29JkygkATWZXr4lZ1MjTeLHWxvFhEO2y0eLjl+WqB+pUq1VIN63aJVdTV0+nDOMHnDUfYWpCRkkJcpNUeaNI9Cz/PuJ4kuOjSnHEzf2oQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS8PR10MB7065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 10:43:11 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 10:43:11 +0000
Message-ID: <71dfb645-430a-07d8-62c9-a95a8fdd5ed1@prevas.dk>
Date:   Tue, 18 Oct 2022 12:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] driver core: Add __alloc_size hint to devm allocators
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221018073430.never.551-kees@kernel.org>
 <d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk>
 <202210180310.A13EAA7@keescook>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <202210180310.A13EAA7@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AS8PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: be5c422d-2682-49a0-313b-08dab0f58d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c473RkjX8bFIAoZEMcYTgFK+i111xlwQmNk26xFNXfmRR+NSnpcLL/it7hG7kamr8Rhy9dZyzayjL67jQ7d65WIjpNfGtA9pYOSJ+wPNY8EsznSIMW0VBXSkGINlGvgYOjue16Vjh5+qFIGe/LqCtiHWPm7iUxogI+kYvF/jnpnkLmTO37qcP/9zAkJskA/t0eL+tDkSGctoQr9OKNW+4IDB6f247XN30Ld4qpSaJLSweuZIbA9LPtL4VuSGxXNv6580R2rSRC+DnHMprvaaw6tgGyXC3Vq38bhb3Vbm69w/iUd8sXphJWD5hW/cTaNC7ABlRdh3ZD+espYbCcHMrOJezhPeaT63G3ik0o3x6G2tbmVdQ8VFa4hh+NkK+E7xBtbfBfGxnnyVWMY9bojZsF0zv/yTXMuZNJFGgQF3v9jAxeg7EX/8ekOJLo7S+g2PvysbOMbpUl/KBxLmEhcvU/RifirVgKEkLQuvGzdNTGzaqyak+Vsm8wowHxfNzH0d2DhlUTrScltD1yD7+0RBj2G3gf+vjpdankRM48hbJlM62hWOANx6aFWo5lVsNXSC3i/u+5h6u1Z8tJ8B4fW//Bd9aBLThEoLriRm8iqvS/v/OjJVJKqlmD3n5BFPtVoG+hstEqRnkEV42509wWBauOIPC7VDFNIrFpYbb2VrhIpjIpsH5wuXofum0qskcIeMEWer9k5eUFGY6dIUVe6LdayNz6dXV1Ywzj6gsUDIZP5U9up1OzgOCzI0Vdhxa+WGC+A7zwXOisxdPnSRuJeEhE1/dO19GQwZ1EQLw7Q2MHyN3dVREDdRkIGclis9x0lID8MkSeAf2okONA0kmIxTI1p4oXV/6vl3oZovjOPGXtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39840400004)(376002)(136003)(451199015)(6916009)(6486002)(2616005)(186003)(86362001)(31696002)(38350700002)(38100700002)(7416002)(2906002)(5660300002)(44832011)(4326008)(8976002)(41300700001)(8676002)(8936002)(6666004)(966005)(6512007)(478600001)(6506007)(26005)(316002)(52116002)(66476007)(66946007)(66556008)(54906003)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5lL3RvVyt2cUdWY3VvcUVCbkRyYlo3MDMrMk1jUWdwSjdBcDZVcDF4dy9w?=
 =?utf-8?B?dm5VaThYVStoTjNnTkMrWnRVb2dONVF6aWRzQlRjSU9JRFdVYWVBZ1B6N2c3?=
 =?utf-8?B?bU1mSVpSVlZRMjBuWGIwakRDb0pycmVha1pxaWtYMVpnRFhnNmwrWE9qd0JM?=
 =?utf-8?B?b2J4SmhXR09LTTBFZ3NiMkxIVzI2eXRpamxSNFdhbUFZNGt4aU1Fc21MTHFk?=
 =?utf-8?B?OTYwaWJzMlVFaFFOKzk5VG5lMFdGdXJUSHRkcEl3QWRtMHoybnkxWXR1RE9N?=
 =?utf-8?B?MWk4VEEvejZxTklTcmJTaktIdjlBdUtIcXJZRmZqdUgxU3Bmdm1pOEZDaFlT?=
 =?utf-8?B?dWVrbVNjMUcybEtJMXA1eHh2cnFRSlNNRlhWYjFHN0YwTkdmV3Z4ZDRmK1l3?=
 =?utf-8?B?UmRLNStrbFQwdHFWZVdoalNTUUJEWGZGQUplaldUOVNJYmM0VWpsUUtZRERM?=
 =?utf-8?B?L0NYOUFwY3VBaGdrdnRVL3FMR0VUTDFOQkVzYStuU0hveDdURHFrcnErUHl0?=
 =?utf-8?B?WW1MK0UrNFgzN2laWkp5cm5tL0VoTWhxZFFQQXRnMFpYSldZQ3lrcjJnc2hN?=
 =?utf-8?B?a3J0T3E5MlRMcEFLR3JoQnNDQzZpZGtCUHF1SGFLMlBydG93YXIzYjJKNkpl?=
 =?utf-8?B?am4vNExXQ3lidEJhTE9rekxTRko1ZG1HSlhHYzFOY210N01uTmkyTnVkQmZz?=
 =?utf-8?B?c0lkRlRmNjZkNXQwMkpRckNucGJ4NmZONEZUMnk3eW1NNXdwSERLZzNVdHlP?=
 =?utf-8?B?Rm5JQUIxQUVvdmZIdVZuVm93N25vRVcyL1NRcndSOE9NSGorR0VIQWlQK3pH?=
 =?utf-8?B?bTJERjcyK3hxbmppbVYzc2pzSmYyQk9jbEM0ZVZ6cENlb1l6bk92Qkh6UXA4?=
 =?utf-8?B?YzVVdkczU0xUWHNRQVNCK2tDL1hwTnNkV3VCRm1pYWtVUDEvWnBnTkRhYm5l?=
 =?utf-8?B?V2NqWm1JaUxpQWhrbnhnSThKd0h0TkZBYWJmQ05keHV6WmVwS1M1bjdTUDIv?=
 =?utf-8?B?RldwK3VGSDZoNW1Ob2tTQTRkVkJkWjMxUXh1ZlZzVmRkRDJRSHFKOU5nVm1E?=
 =?utf-8?B?T0ZjYkRQazluclVFWTVxWmNiK0J0K2ovWmtJZ3dRUWZ2VW1oT2MvK2o1T3hu?=
 =?utf-8?B?QnEvdSthZi9TU2RSdHNpY2NjT2xHN3BSN1hxd0ZWblFmWlFCSUJFZm1CUDlX?=
 =?utf-8?B?Z3U5ZzBmZlZLOFJwWTMwOW9OUmpjU3hZWGdHMHpUV1dOZGM1V2xmK0ErNEJ6?=
 =?utf-8?B?UWVKYmFlL25GWld6aTR1Zklkek42eVp5NHEvRzQzelhRZmNBYWFzNkFKMXJP?=
 =?utf-8?B?anZ1SkM3QkxMWDd1Zm4vYzlvYmU4dS9ub1VaSEcvRk43UU1zWHFZek5sNkla?=
 =?utf-8?B?dEUyeldtVi9lUmVRV1lTY0dDQ1hncG1MaE41cHVsRWp0dkJGRDFJanlxS0l2?=
 =?utf-8?B?aDI3cVdlSmtOeko5M2RTMVFpMC9NNmxXd0J2TWYxb2xkNUdwZlduaytQcURz?=
 =?utf-8?B?N3BJdHlIL1FpMWNidTNyOVdFR3NNbFh4elcxbFFqS0s0M3MzMkluMEJ3eDV0?=
 =?utf-8?B?TzZKd2JjcWcrUVlsQ0Rwa1RhV3pzNVd3blBiVTRaOTVFRktPaFB6bGpWc2NL?=
 =?utf-8?B?L0d5ZVZvenZ4bTZZYkFBMU14WGNmSWtIT0xtTGF3Y21YL1Y0UTU5SHpqT1Mx?=
 =?utf-8?B?MmJtRUNSQ0xnWHdZbzF1Z1NxTXFraVRMS0U5NCtCWlRjcEtKc2M0UUgyVGo4?=
 =?utf-8?B?SlRVc0loQmdkWklHMzA0REh2VnpsVVJ3U3RQaHJ1em5FMTZtN3hqZ2tpRmVV?=
 =?utf-8?B?cCtybDNJc0thc1FDVjBNbFM5Z21kbXJwTVFJeUgxSFhUTiswdjlNYVVQWHVY?=
 =?utf-8?B?bUpPL0t3WFNqc244TGN6bzlabytJak5yMVA4WXVoekRjc2Q1OS83aUVOTCs1?=
 =?utf-8?B?MUJFZDlXKzJFYTdGcFRRZGtEcFVCQ1FkZGtCWGNtRVZzVW5jd3hxNkxGYmtm?=
 =?utf-8?B?cDVqZ1drMzNlVTVWdTgrVE4rR1pDUGM4bGs4cTVWVnBrSzZvaStxNGRnV2VV?=
 =?utf-8?B?cFIzMzdjRE9BdHhpUXhiYXdxVkpjNjlKTmJHWmRqdEk5VWVLcWduNFBuRmUr?=
 =?utf-8?B?eEhFYXpubWd3ckpLUk02QjkwTDJDUStHbkF2VVBkSmtnYWtXcmZ0azdBNlMy?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: be5c422d-2682-49a0-313b-08dab0f58d2c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 10:43:11.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYClegX/EEQVBYvdNMxEsiGZqhRefxOgUsOAyAxcXSFiSj3fXwQP4zef8Ybynz3J6rotkGNIHDNnCkyXZrEv0rD4bLUhagP/EHUQAbWYt1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 12.15, Kees Cook wrote:
> On Tue, Oct 18, 2022 at 12:09:30PM +0200, Rasmus Villemoes wrote:
>> On 18/10/2022 09.34, Kees Cook wrote:
>>> Mark the devm_*alloc()-family of allocations with appropriate
>>> __alloc_size() hints so the compiler can attempt to reason about buffer
>>> lengths from allocations.
>>>
>>
>>> @@ -226,7 +226,8 @@ static inline void *devm_kcalloc(struct device *dev,
>>>  void devm_kfree(struct device *dev, const void *p);
>>>  char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
>>>  const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
>>> -void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
>>> +void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
>>> +	__alloc_size(3);
>>
>> I think it's wrong to apply the __malloc attribute to kmemdup() and
>> variants.
>>
>> 'malloc'
>>      This tells the compiler that a function is 'malloc'-like, i.e.,
>>      that the pointer P returned by the function cannot alias any other
>>      pointer valid when the function returns, and moreover no pointers
>>      to valid objects occur in any storage addressed by P.
> 
> Oh, ew, it defines rules about _contents_ as well. Thank you for
> pointing that out!
> 
> I suppose we can use __realloc_size for these cases then?

Probably, but it's gonna be mighty confusing for people reading the code.

I was never really a fan of including __malloc in __alloc_size in the
first place, this is the kind of confusion that comes from having one
attribute include another without having the developer forced to think
about whether both actually apply in a given situation.

And that malloc documentation (both the old and the fixed) even came up
in what I assume is the thread that led up to that

    Since anything marked with __alloc_size would also qualify for marking
    with __malloc, just include __malloc along with it to avoid redundant
    markings.  (Suggested by Linus Torvalds.)

in commit 86cffecd, namely
https://lore.kernel.org/mm-commits/202109101138.53FCADF5C@keescook/ .

Rasmus
