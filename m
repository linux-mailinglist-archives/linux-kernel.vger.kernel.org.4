Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB6602909
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJRKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJRKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:09:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70121.outbound.protection.outlook.com [40.107.7.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903017AAA;
        Tue, 18 Oct 2022 03:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSoTqCWmmg/0Wfcvf/5RhNDacMIW2ERTqfDvSJ5xhrGbHUKt58D3akuI+D+2QPKghyH/DiGacE2vcxLRt+Mz8qaANM5n+C2taNT4bPGUryeKv4xHU/wzu+Wcw6iGs4GmOpncN2Ju7SDFlHUaGnfOi4SFB0GlZHk608gpxOESzUshEjRhsNVqC51lbxJRXp2Qp8cXZl20ZTEQIpY3lU7GhlIMbhcvnTAVQKRW8D8wux6eyn5A4516FLCG2rr6GjL3Gpc76ANrjwuKhNZmZfjIzPcUBprBi0dk62IcJ5MEcNcJ/RXxiMq0J9qekCmOCNd1RBqbyT+HHuNVwKRhUfcNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8coLbl25z8hD6xbbQVrK0iMsPWOBTInuzT4mtPlhTiE=;
 b=dszrD8D8EsWCeVjBiJn2+e2KGq+6OTdp7ikthNWQjHR8Cd9JgNV7367cjJNe+Dy2GGBX6fPM+suN34ex9AWcJHZPh/NVc+fQfpB04Ay2aUKpC/h566U4rVXbXU0RrRTQ6NbE4cs4b7OUd7PU3iH0dLnVSDNSf3uGGnuZzGLFnXIqJG9qYP3hyJDe6cU/iC1rViw87di+YiMQ3osLdgnmXRa5V72JHZlSVYN+e1521bqy+EUxB69XmcHDJfm9ab0k7nadV/qcMnE01Y1lVSDnb8Vadiy1/bsvTK7oz5TVf5IQJoP19qt2yn0FptUDxNuK+Yl3ncP72YuJfboaGlY2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8coLbl25z8hD6xbbQVrK0iMsPWOBTInuzT4mtPlhTiE=;
 b=AoA32/TBnVJ0gJZvAFaVBowtwZyHX5sXseZPRsriniJ0wR1mlE/Kirz82op0v8+5SO+fUP3tJTXErxtDJEqEBVZ3qMl8br5ED4NXYIbLspMWTFQfM77a0LO5yRk/MUZWB1IXyDaj19HRHUqXc8Az09DML7eF8Rvjf1DQ3XNmfIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS8PR10MB5879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:527::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 10:09:33 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 10:09:33 +0000
Message-ID: <d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk>
Date:   Tue, 18 Oct 2022 12:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] driver core: Add __alloc_size hint to devm allocators
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221018073430.never.551-kees@kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20221018073430.never.551-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::34) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AS8PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5a1167-b5d1-44cc-54ba-08dab0f0dab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTM5N6JVXqPg7vQ2j/aLaDBeFpGkmdhRTKMess3bhZNuxhRlocu4OPqsjbJi9/e1Wr1bvZDIgAHgsrlc1Z26EkpDdq+cVlWVdkj7GJFLQoNF6PmOD3+Z+StvOvnGn2PPqcjpwLMA1UDV1NnhfZtt135v5uFYM12vc3rL/JCAQF/1xsLNt8ChsqN+AwGzvDus1dEGghsig95q5Ulsie8QY0d15L9TZqtMRNNNDjD7LgGIa0gAmiODx4JtCy/+9do1PRLOH9IufVqF0o8XDIpeRkfxb65yyB502yaGJCEd1C9vTz+9p9+t2lPWac6UmFvtbnlLLGsEzk1Dp+Jd8WBnsy1LrFcP4uk0sncXdchD94xpCHimcEvO6xBqSNMCbLGNOuoR5dwJgoIltAYODlWFb+AZZ/PJb1vaSxb0kFrfx64tCq4TNSAj1GFyyUl4cNISysnNWroGHFrVkvalmyMOmcwF6Zj5qroNm/8G0JB89QPubwF/XuzZm+suZbbso3IzhYviZuV15nRv/cWFNCwhcp8KqY4EVvAcs/5E3vr0dYqsrNo/YxL6UwMZwsQVSU+zEjuhZnoUmaC9Ug9H/8oLSPG0VcPerfKiwVIx/w/Eova34trmkF4fGA5JpL6uJv0laP3oZNAMmlD5XxrD/+UPe/UH+IBm22k0IjqKZcc0hHPkIgf8m8OMYBBalrQk3WJQbA7274azQzHJkxGQAQLmkublQFU2Gs7OX59D2xrAE+QVJBCAClXV4YMX6qWelwfwmagR++Ey47StPiuhIJQ7C76SFZhX/vIcZVYrYa4ZqupROvp8tcYi73Y7HWMOy2hm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39850400004)(396003)(136003)(376002)(451199015)(31696002)(316002)(54906003)(8936002)(110136005)(8976002)(6512007)(2906002)(5660300002)(2616005)(7416002)(44832011)(66946007)(66556008)(66476007)(86362001)(8676002)(26005)(52116002)(41300700001)(186003)(4326008)(36756003)(6506007)(31686004)(38100700002)(38350700002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2F2aFc3Qy9kOHdSRkNkSUJadmx3T25VUTVvb1ZheEdOcVVGT1RyWk1rYTdI?=
 =?utf-8?B?QmdLYW1pbzZZaUNOODF5VXBHZXBPRDEzRitNM0hHZlJ2ano4Z3ZpRjdlRGtl?=
 =?utf-8?B?eDZ0T244d2ZCK2Z2NlZqQmtyVHJscmx4YWpNc0FGZTNydExRRG14MmZPZ1Vh?=
 =?utf-8?B?WXBEZkkwNjZQY1NVOFRPYlQrQnlINHFIMmRVaTFlR2p6WVlRTGdGMlh2NStG?=
 =?utf-8?B?Qm9pb1FweEVzUVB1Z1lYTmZaclI0alFsOUttaXlVMERINHlMano4L2FWZ3E5?=
 =?utf-8?B?SWI5cjBEZmh3N2VqU1BSMTRWMENPNXNhL25tSG9YdGxOd0o1ODhGazh2YTNK?=
 =?utf-8?B?U2Raa3d6SU5leGJrODFSQXRZZU9RT2N0aW1VZi9qYVJxQlRoR1BCSk14TUpD?=
 =?utf-8?B?eDhtL0JQWklpdCtIK25ZSGs1UDBxd2R2Rk1JZDhwbnJGb0F1eG5JZTczNG9R?=
 =?utf-8?B?Q1lWNEdJOEluRGRZMThBV0FSMmptd1NERUtJUTBCVVZBVEdPSE5VdmEyTTNS?=
 =?utf-8?B?OGlLZGNMSm1HSUhiZ01zZUp5RzcySFZFVnM1ak1DeThXMVA0ZSttOW96RS8x?=
 =?utf-8?B?alV1WGxzTzZiYUp0WGNOb1NEN3hvSFFyVXRHb1ozSVVMZ3lnMFFRUWk1aEV5?=
 =?utf-8?B?THRYaXVXT28ycU0weDlRVERKTGtSaWtGYnowYkRoclNPdnNRTHluVDdYYjZy?=
 =?utf-8?B?S1E5MThnMmlMR0J1S0pmM3FOUC8rd2JQUmhCYkxtbUhmM3l3c21GdlZFV2lN?=
 =?utf-8?B?VEdpV1B0Wm51TVdiVkpHUmpHTmJpK21PQmFYV0wvOTF6S1hzZC85WGdkVGlT?=
 =?utf-8?B?NkxmL0l5MnRxeENVMjlaT0Z3R3NVV1I0S3RpMlY2cEhjWUxyVG0zTkg3OWlD?=
 =?utf-8?B?elB6RVNYT3lselBOenRDaVcxdFVzdWJyK1FTZjB5S1phQzlVbXlKV1lEcU1m?=
 =?utf-8?B?eHhYTmNIYXhqajRJUTA5Zjl6NnBFZERnd1ZXdWhCeUtKRmJzUHBDckJZOHdG?=
 =?utf-8?B?dUQ5MndtREd1RHR6K1NUWjJqVSt3dDR6a0NCNjAvVHovQnQ2Vy81YmF3ZWZB?=
 =?utf-8?B?Wjl1OFRZU1g1SG5LRGVTRFNNczB3Z1h2M1FtcVhLL1U2SVZrNEQ2cUljNWpT?=
 =?utf-8?B?aG9LNUM1Rlc1M0JvbUxydnYxVlB4NnpBc1NyMXNsUGpCdHlBSTRNYXRxRDFm?=
 =?utf-8?B?MHZ1MnFFVjZKL2pwVzVyZGdFaXd2a0F4QWJPY01FVm12anlvUFN1MUFFVjRZ?=
 =?utf-8?B?VUNwZXBJT1V0S1JwaGxhOTl1LzU0QnFrYjBxQ2FFY0gxZk5kdW93bmp3SVJT?=
 =?utf-8?B?Tm11WCtqaTJ4c1plWnBuTm9hY00xN0RLNU41Sk5SWVNhTFk4N29KQ3JQT0hl?=
 =?utf-8?B?UXVzaHkvZ2NQYUVuK2l4c1lDWDdEQ3dnK0JDMTJrQVJEeFEyMTZUQ0JQbjVW?=
 =?utf-8?B?KzdrWmU2TnZoS2FCbWlRaXVtNVpkZmo3WTJLRVJaZWtsZ0JYMWVKbEN0Rnhq?=
 =?utf-8?B?WTZNaTZRcStuZlFiY1Z2RG5od3ZxR281eUJmbS9CajFMWG5jV0JFSVgwS3Zx?=
 =?utf-8?B?bHpYTWV0TEh4TTNpUSsyZXBMS2hqR0Y4ZmREMExkOElPajhoOWdCNWpORHhV?=
 =?utf-8?B?QkZYanJTS0tqUzBmdk16aTYwb0FpRDY2M0lBTlV3RXB3L3ZqUlUxNlJSeGlQ?=
 =?utf-8?B?ZTIwZ1hLTHFTZEE5b2pkbUgzemtEZ0FLdXFOL2kzV0ZMV0s5cllSaUcyWHdk?=
 =?utf-8?B?ZGNHaWk2Yi9lcDZMa1FWUXhsSitTT1FMQjlJSzJtV0R5N3hrcEUzMkZsWWt2?=
 =?utf-8?B?NlNUczJGRFE1NkNGWVRuU0Flb2Z3cDlrdFRkbDVyWmdGdXFwNjIxTVU2Y2Fp?=
 =?utf-8?B?ay9uYmpkdEdFWWcvdk9PNEt1UlRHQkw5ZVFSVjR4RjQxYTVvdkpMaFpDclVX?=
 =?utf-8?B?aDFDQ25ScXNZNkEvMGZhUm9mNUNaRjM2U3UvWVRRQzhNb1Jxak5JOXltdHBE?=
 =?utf-8?B?SXFMblhzc0VEbWZwdHkrWHgwRXhDOEY1SHpPdU5ET29zb3diZzRNYWVlV2VO?=
 =?utf-8?B?RTNabTEwbmhPL3pEQW1HWXF6NWZ5VGQ3SElzY2ZhVkZqcENLWVhyMzI5RFgy?=
 =?utf-8?B?Q1ZHSjNCMkVMYUVVRysvZG5pbkZQN0drNEVYVFAwdmJmTjRBZ2duMkZnS2Q4?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5a1167-b5d1-44cc-54ba-08dab0f0dab3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 10:09:33.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/Owg3RK3+3x3X+y6vOjbhUqytO5fd9NwEYRjjn6ohRDLYnwGtoahMqRkzeZmoHRq+Ne/yln0Xb5ES9Z8xHbKUNdJExcT/cFXUVyUesgX4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 09.34, Kees Cook wrote:
> Mark the devm_*alloc()-family of allocations with appropriate
> __alloc_size() hints so the compiler can attempt to reason about buffer
> lengths from allocations.
> 

> @@ -226,7 +226,8 @@ static inline void *devm_kcalloc(struct device *dev,
>  void devm_kfree(struct device *dev, const void *p);
>  char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
>  const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
> -void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
> +void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
> +	__alloc_size(3);

I think it's wrong to apply the __malloc attribute to kmemdup() and
variants.

'malloc'
     This tells the compiler that a function is 'malloc'-like, i.e.,
     that the pointer P returned by the function cannot alias any other
     pointer valid when the function returns, and moreover no pointers
     to valid objects occur in any storage addressed by P.

See also commit d64e85d3e1c5, introducing __malloc in the first place.
Maybe worth lifting some of that to a comment somewhere.

Rasmus
