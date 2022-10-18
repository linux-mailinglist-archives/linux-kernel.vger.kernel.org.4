Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4078A602F27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJRPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJRPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:05:54 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A4C2CA0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:05:52 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I37Er3014257
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:05:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=PvPpEzTdSXLQwkmIxeUwgoK5RtaGUnpkQlyMVsJERRw=;
 b=mzkscL6lvY0q61sIU8zJ9uZVCnlMEBjEoPLTOaeI+/8KBdtMDx50p9LlFP/598Bgcwa4
 p8UrHecnjF24a3ayini+bUXzP0nbrir/I813dctlKCCZdlUMUp5tdv7ip+zsTqwcXLel
 1ImWJL6Ou4H8HHN54a0+KNwQxt2u5XOQYqAy9vwGzV6TjZmHAyak33PskJlVSd34ESqq
 6IJszPfzMn5dPZZdQLbZLmMgSdFMspHofzymRTlFSmUacGptR9YeatvPgUj45MCvv71y
 +Z54yG7LVBoXVmVgGO8lUUuBO7+2gclLM+wBL3S9ImbnNHb3/r3q5KHaTG70accGXqL0 Eg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9ky5du81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdi2UkO3PMQ0lzmUUZqWz6TiFgCVGjv0ZqxZGo1wp8N8i/ds+fqLWuO/tmCOZpZl1Cr6FLS1Aoc2WdvS5H8GbOkHxizAlV0UeHvK6Ds1ic76y/Cho1x2ZUSAZGDT05nD9r7U3bNWWMXmfEWA6A1Fv39u/1Y84bE4lvvdrDkC7TY8sqHocxSoBxiHxpQ7sZGtVjI8iOhb+hcX9gAIbednw8NDdMl91VATqF43WKrho4PrC0O5Gn+nNT8jcbE2APgS9RwhqUgdIgWQ9ZW7MpnmkBQSTRXCTohgh4m/PECJ7ccuSDYqrDhyvoPx0BUi1taDhm5jHIxfKUfUTLhfV8wvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvPpEzTdSXLQwkmIxeUwgoK5RtaGUnpkQlyMVsJERRw=;
 b=Y8Dm2kr++YO7BmVWD//pVLoZEXX+s3ogfjJxeUGgFgft1Lhz0Xpl0fHl8IOaC2NOkhPYPeO9Ho6oUQdhvw/j7RU0Vh2f439ZacVKCJc3mDW77iSezR+tvNBW9dzEv3re18R+yU6X9r9kXxZHJHwznsbkcg8OH8BoM9cdEWWd4s0zhMshdato4U2um+07tjFea83oQuTC/kRwjBSKOzBBntOFGjN7AL4RLwZy+D1/hrx4F4y0v7eun6z+jB/h1MmCtnrIxo1kWhK4aZeYTInkGYehAueNsSNtokZMu+gSb3aAs8Af2aKLW/Azn6SvhOkzdiF+NgVkJK7XYfWqXGlVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3660.namprd15.prod.outlook.com (2603:10b6:5:1fd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 15:05:24 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 15:05:24 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Index: AQHY2qb9UHFHCXXpukKxiSq7OlxGX64SPiOAgACWPoCAAXg1gIAABDOA
Date:   Tue, 18 Oct 2022 15:05:24 +0000
Message-ID: <9A9A2DFD-45FA-45EA-95FB-5FC0DC5A9E2E@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221017072607.GA30977@lst.de> <E8A7DEAE-C1C6-4821-A3A3-FD4996414AFD@fb.com>
 <20221018145021.GC20131@lst.de>
In-Reply-To: <20221018145021.GC20131@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3660:EE_
x-ms-office365-filtering-correlation-id: 83ccfb87-2477-460d-1bba-08dab11a2f49
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BiecpKn7QG6gLRjgqN/yZaTkZWWU01LpnhTBxAIFoF7QK1XvU3NRrlO4cOHkR6VzdHQmsAD7AiwzFp4v5bV/dWn0WrvkE0W7RsGWmLG/Iyw1sZ8dIvcnE2a2bifK6KYk+ManVVcB6o56EsPbZZsOdljhuGu0bOhCe9t+eOwaCGXoppX1M++1I3cIq/HbTXLdGj6F+UUAs6F/IH3sDfLfBD0e5TwWTbW6+hHrSXo7Mp8vNjWWf6gFJOpkc9UJ94YvHtX3YpRFSoxkp/CXa2Y3urYUyTavKLkr+oV/OwAcwfnHY+6oV1mwFgA0lzEi+bfsiorIeA+L4L5y/QqpNasPkpgdrPG2XCePapH3BCdXWDj657KM5Ik//Zds+uDOr4134AbCql0Dci+3hg7NX49FKIKeyooW4D+VHAX3uE9O9BAqvEnV/VJxsYpOTlmZlQzehJRmU0SfiSMDMTkgrWLwDAohQptCki1QcVcAIYIhRJZfjl9YNmvcP4VqchPSdlUZ0YVaHbv0zJ/8vwnFS7e66Bbil8bl8O7n0UQhQcQXKTKNayFKFbmxyTVFv2nx7wJg5RjYSAhTzmOPKmpnFuNYkm01bZpVXVo7E08/kHPjj92h5f6Ysu9MHgk+o/ZNS2b1H2N45UsK8rLGln0S0nHd3ssTsdPZLDUwMhK+pwsmRFj0gaw7XpMuxM8+UaydTX5p0yBDTB1RBvAWjA7o+a6fFHiA/TKIZNgBxgCFS20h9CykLMD1FgoZ7jwNrxvKhkNc1CwKcyTWXZ/6Uv8YamMxjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(41300700001)(9686003)(6512007)(478600001)(186003)(38070700005)(2906002)(6506007)(36756003)(33656002)(7416002)(5660300002)(8936002)(53546011)(86362001)(38100700002)(91956017)(316002)(122000001)(54906003)(6916009)(6486002)(66946007)(71200400001)(4326008)(66446008)(64756008)(8676002)(66476007)(76116006)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+tvND6pP3Im13O0YcISmMyOL2aHlNaMQrlUEiEykBnjYC5zh1Vi3m6YEl7L?=
 =?us-ascii?Q?MCJh8rA3ku97qspH8ibVjisX7yN/I3q9EjNbvwxj9Yj/7VgeWBiPVCf1jtym?=
 =?us-ascii?Q?iXXN+w1Td5McFgXkxCnHxi3g2liwCeaJXWp7MULRDTU++97ahvXtYUqHvt1a?=
 =?us-ascii?Q?rKxB2miGEM7SBk5H7m6Ryd2JbExnVLGSMJGkv69zYrpIXnDCvig/RmJv5r2M?=
 =?us-ascii?Q?y4ZEB+rSMyX8UCr8AkTPXNGuRVZ74qAybgX+gAXaDArTDD9qZsMZH3riL6xK?=
 =?us-ascii?Q?BW9EfE1EWLR2RLB03uJzBItLTLX4URxKp+C5fxBtsKOA6awm6h7MSDA0YY7J?=
 =?us-ascii?Q?Gx+Pi2yK6vCuf61afqyGfX5vDX2lKt4EAcA5i6JALJeJxR7G7EBeDw75vW6B?=
 =?us-ascii?Q?g+V9P1mEKWBuU0FpzA+llDRH3OwgUWgByv1asOeY3FHhynWc3N+qzm8+wuqT?=
 =?us-ascii?Q?iNF8yoW2jlkcmTJcxxvyxf1N9uWGaaWsRI2oWCk+zx0Z4h5WD8M5wc7YjZev?=
 =?us-ascii?Q?SWZMO1pkkkRh+EaaaVP35g6KY5d2gw8CBXnOKigo8N88+OR6DGcFSqy8OAw1?=
 =?us-ascii?Q?sLswkwdGckDSEGPy6hzl35y2TYmnMAJeiLcrVLIJWy9cqeBbk+3g/NoGwx+r?=
 =?us-ascii?Q?EfRWsLuGQHd/hATkCh+bWhn4xMkTelGIvXiRvz0qzskKvhLwscQPyv5sYr0S?=
 =?us-ascii?Q?+BVrX7r39Qv910aDGgfJvdzMhHHE+wAZmnem4MTR5orfqhpiF//pxUeYj6bA?=
 =?us-ascii?Q?WfBHcpQsJKOiIdS81+fIDpYABGDqtWqcrbPk53p1+SG3sPr1YTdlpPNC8kHf?=
 =?us-ascii?Q?z50bQOgQ0uhRPie3iRth0wnfKvPTQWTLxxtYtJZq48pOcHZf9rh70DNFJrIq?=
 =?us-ascii?Q?cMLzD16Jx63mXlX6zCcOv90X3Fyr+NKEOCyiro/9WPWBwSS4dTQ6mjeqcz9J?=
 =?us-ascii?Q?U6i5/O58v4ABx54bLtgE3lmKCp1F4wnG8V3DURwaID7PHDjmRPt0ViItcqTS?=
 =?us-ascii?Q?HcqafCav8xIDv2rSpe2X+QlxFtJlCvpQzl5Uegb5MpjkSgHlRTRORocuX94g?=
 =?us-ascii?Q?We7aeoGoekutZOaw9/BMaoBfZGoR37TDm+akDTjoGQqFw3oQjdUAO9szaLzC?=
 =?us-ascii?Q?3uQA4r2lC+FpJ3s9j01JEggfGn6BJfsQK+pH5YXccLwxSL0pXvE/QH0OaSUk?=
 =?us-ascii?Q?JMDiu8DLDmFNkm4n9o3kxlor4bG5NAcMMbtpL4uS+GaU8zT6reR6TId79KV5?=
 =?us-ascii?Q?JwvXDvdBb52swGzBk/P1IodyIzmmpdP3w1UlL2WSgXaQ5nEuwmWN/axcba5o?=
 =?us-ascii?Q?xgcN+y9c/sYW9fzYnKKv83mrZeHt83XanN9ERobt2exxow4Wv4+FW1WOki0w?=
 =?us-ascii?Q?lKL7HRoIGSLCSwwrG9ZkaAB1RJ6x53cc11VnMHhOJAOgb+j+wnVeLXeRdg3C?=
 =?us-ascii?Q?BASWTQL2zzUKIV+G8lW5Mh9blt+o25GqhAY4pJTm+b7rhRYU9xt1TnvFtFnz?=
 =?us-ascii?Q?WuJQbfyQgjkkYeUDT/PM4IUpHDEWOSlWzbMdi32vUIasmAc0RtjNSPWP40Ot?=
 =?us-ascii?Q?/KoNFilA/JAREYtMt8Vn7SirKD/WDJNeibR7K1zzBGnNkxA0r2AquJpXKQ7O?=
 =?us-ascii?Q?qmVgDJP+GD4iRMftXWLGXftP0wLRdGnNYCd1TaJojXoF?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4321C318FF5BA4281685B7DECA0B576@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ccfb87-2477-460d-1bba-08dab11a2f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 15:05:24.5849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ERTVdNY+NETsx+DIAyNpT8pMUDwO0A5zG82gW7ckk4eCazZ6hc6zHzmHjPJ5qaLyZ7gPxCzlEp18xWqtYm/4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3660
X-Proofpoint-ORIG-GUID: JPFabpDUaReEATIMZbqAL49GjivK6_Cr
X-Proofpoint-GUID: JPFabpDUaReEATIMZbqAL49GjivK6_Cr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2022, at 7:50 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Mon, Oct 17, 2022 at 04:23:52PM +0000, Song Liu wrote:
>>> Well, nothing explains what the method is to avoid having memory
>>> that is mapped writable and executable at the same time, which really
>>> could use some explanation here (and in the main patch as well).
>> 
>> Thanks for the feedback. I will add this. 
>> 
>> Does the code look good to you? I personally think patch 1, 2, 4 could
>> ship with a little more work. 
> 
> I only took a quick look and I'm not sure how the W^X actually works.
> Yes, it alls into the text poke helpers, but how do these work on
> less than page sized allocations?

Aha, I guess I understand your point (and concern) now. 

It is the same as text poke into static kernel text: we create a local 
writable mapping to the memory we need to update. For less than page
sized allocation, this mapping does have access to X memory that may 
belong to a different allocation, just like text poke into static 
kernel text. 

Maybe we need something like vcopy_exec(x_mem, tmp_buf, size), where
we explicitly check the allowed memory of x_mem is bigger or equal to
size. And users of vmalloc_exec should only use vcopy_exec to update
memory from vmalloc_exec. 

Does this make sense? Did I understand your concern correctly? 

Thanks,
Song
