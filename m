Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0F5BF1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiIUAHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiIUAHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:07:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC26113E;
        Tue, 20 Sep 2022 17:07:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KLO6Fe019476;
        Wed, 21 Sep 2022 00:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wxAj1dsooMLWYa9kQGpGQGYctB2FsJobVOJeISzzBiQ=;
 b=CABg12kTLUKg88/DYHAPt9wNl8vBmJe637wjpxgI6sUPVEuQPnyPsBL9VyZoxdS+qmW0
 wyfXyVttVBmnjdDJsROQXGcG/XY822m+uAFk8CZpmBykTDEo0pKWpihgoZ8pmSkpeJuF
 EThMkjGRhtfIqRROis8/O7g0WyuqSVVzifiZ7hSRE/GFfxjisY35Ty+5YlRm5MNiMjAZ
 O166WQ9RP7RK+IflOu5gBosMUkXQzXUMF0ExMhdoLcpt0V0alLaw/h0lrl8yy91q5lYA
 MSR9UpeJbikwCXxHsyJuo5pVLP92GJ/UMD8b3JLH/Fmu60NPRZtoBkq1bNH22Ma9pLyn 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m8qsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 00:07:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28KML2UQ010044;
        Wed, 21 Sep 2022 00:07:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c9j8xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 00:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENv2E60xm7mvnRSUw2Uwm9PEy+jTVG3Unpy6/EyXOuEM3AngvpqS81IG/iq9zNy22ohgZ1B7/+GcE+8SjaEMKjXJJ9b4Zz90Sifkp/egQeaP5EWCp7m+now+2lFCS2o1DnGfTM7HQvrfYtbzEo+aMSXE3Kjbk+OO0QQFK7muywoFd47vzjjlBh476D9tX9fT7VO1VipARW1IYaB5PRkCVKgSuTD7L3NfA1rWkOzEeeEDSP8PKFGcEe68jz2GLJuUInsI1cmYYg7jQlNKzgZGza4PMLM4VreWAP8lH4XSqC4LucipOGSdW5dCc5+FD/NpBlsv335Jt3gVCF4RWN/YZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxAj1dsooMLWYa9kQGpGQGYctB2FsJobVOJeISzzBiQ=;
 b=AdqobtVAo90/oGD5DdrGx0EtNRrU3pz1Ya7umfZTphC7jWw2NynkXdMHT5UJUwTVaFY1LPVQp6ggJsUBMfO42us1kIruVYxOAzhJCTWwkMg0tnb+gxl44uFt9HGsKg38IKeGDdSykmcfPfXH39xKMF/VnKswPkLbnp0MYemgW/9caZHRn5MxtbhTPT/C9aezsqQsQJUkRthQArOZ5W5pI9oWtwRVaDJ9PyecJ1RUom/QVIRyBEdIPwFcQgX3eTc3E5jVN56na46sEZPzllInT1OZQ244O7h5y/TihprKW6n4amX8UklgbBwpbqhHGFM/Et2+sv6M7/kvov+q//9yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxAj1dsooMLWYa9kQGpGQGYctB2FsJobVOJeISzzBiQ=;
 b=HwlRHzmBM2ti7c5qUSR45PCmOAU/dXPS+Vl4eVYe7MIOq8ZC58yh4y/nmgeKOPVlXKiLDQecH87tF3R/kLZyVivRpyjhkpyXeF7X1IMxoXcKWGgUHaTodECKa5X9S83IGpkrj2dQ+dEewvqClTgnw4M2klWrmkoCP2ZPVlxkAPI=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by IA0PR10MB6891.namprd10.prod.outlook.com (2603:10b6:208:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 00:07:13 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::dcc6:79b8:7480:2ecf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::dcc6:79b8:7480:2ecf%3]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 00:07:13 +0000
Message-ID: <41527d69-e8ab-3f86-ff37-6b298c01d5bc@oracle.com>
Date:   Tue, 20 Sep 2022 20:07:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] x86/entry: Work around Clang __bdos() bug
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        xen-devel@lists.xenproject.org, llvm@lists.linux.dev,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-2-keescook@chromium.org>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220920192202.190793-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:4:ad::42) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|IA0PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1786657e-a9db-43f6-6fc1-08da9b653c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQ3q2iMwh06Y/xszLhiFw4SqLGhS59p3u22PKIViQqyZJ2OtROWExE/K4CfJrUa3r/NbtBwTy12NXvmYiBEjifIHtQieHWKbpV/soK0WC4Ij0md6UGhEuicLA2ydXwg6fmcEoGpfWslhJINtHElxMFTDxS2kvX5Qbko3npnkmvWcWV8IHMf098Vh/NYd/5SLm64Yu9zDF9XID+ucdBZMmZa4ofKqBVCdMj7XFv6qAIVbCC/jD/jazk+0uv/w3db4Awinr7lAZa4yG97mZCf3Ssa9fYqPzkEHbrhkkGb/SJYXmTOwCr9iqyce9aoDTLK0kcfWYNWopKJsnrj0695Th6rvisg/2K4FruVJe4k08s9G1+k8JCM8u9QHOjSKL0YzFeLZG2SeCWS+y12hatOJUgXNCEOoAhIvdqzlfLNBgma0RdYOneeIo0nEkPFJNfiImmOExWrUF1GuwL3IgpOQ8lfkqp4pz2Y04atvCBzjt9GyiQTthTsFFZHujreDj79lHgqkxtu0I1WtBUeouSGKliJ0BRaSC3sXPEVfhHVBlPRBSJdw/HHIYiu0X7LmYBecz3CZNJaWkUSYeRvntJGUChNwYxuVgOkUpfoViWGpqb0sLvZwJUrgmBJweeuDb786VstkCluZJDsjKsfXfAIsDU2ltp9shxiONAGIFwes4nr4Vc5JygaSWqanEzdkLgk+Rf4uyugLdakdNeAfOx6lwlrhI9+2d2+52AbzmiBR7RTPWAoB5gclRc7cOwZyTOkukEysmDnbFQVmzPevWyb63cIFY6Sm9Q5rSabeOcDYK6lDluXtVuwljBxF8BOT5qTmXxzPOdQTiMCS/q5DCJTxPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(8676002)(38100700002)(6666004)(26005)(53546011)(478600001)(6512007)(54906003)(6506007)(6486002)(316002)(966005)(186003)(83380400001)(36756003)(5660300002)(2906002)(44832011)(41300700001)(66476007)(66946007)(4326008)(8936002)(7416002)(2616005)(66556008)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhCbHJTQS94MUhVS0VTZzNrdEk3QTBPang4eE05MHdHRUJJSTJMSHJvMHAx?=
 =?utf-8?B?WFAxeThZeGhVcXd2ZHpaWG9XQkRieEMzVTg3bmNzVy94b3UvRExLRVpSdEpa?=
 =?utf-8?B?cjhyTlhKQUZOTXU3NFdpQUxSR0M0eU10WGdtWGNqQjJBM0czMHl2dlBrTDNN?=
 =?utf-8?B?YUNSSlZ0cjdma1JHTFQyeXFIVXRqdEF5Rm9SSFhWd25FTXprSFI4UTY0dTZC?=
 =?utf-8?B?UGRZUEtvL0lvVitLQ3pRWElRNnZtT2ZZUkxuY29lZUl0em5lWmJNNXlMZFk2?=
 =?utf-8?B?SHRiVUpNaWhwdzl3Z1B4QjNuWTF4Njl2SFgwWlhZbmloV2IyOUhEQXFVSm54?=
 =?utf-8?B?S0tGZXl0cGlzZFB5RGpveXhjSC84RHFxQnpLOEF2cG5CTUpHMkhpVG9Hbnhy?=
 =?utf-8?B?dXp1OGhkTVFBTXlrMi9pNTJFSGRSTVo4dlAza0t0SHMyTHNReG5oa1dkdlhy?=
 =?utf-8?B?amJYdXZZb3JldE1id0laVDFDME5NU0NlYk40cEVnT0tNUWZmY29McytyZFFp?=
 =?utf-8?B?TXcvcWpHa0hJeVpzcDVlMVlZVE4yS2V3TU1WSjVaMHNQY3JGQ2oxWmVaUldW?=
 =?utf-8?B?VVI4MW5OYU5lVlh2ZkpVQXJiaU9TbnFmNXJZWS9ObXpCclRkYWxPUTJGRXAr?=
 =?utf-8?B?YXZiZUlmRlgrVEtWYlJBQXhOZ1p6TkhoaExtYnY2WDVjOU1sZXBHUEl0UUpX?=
 =?utf-8?B?b0Z5VFBLeVh5VFlZQUcyR2owWUhRNitvWkZKY25GenVyMkpNa0VzSWtubWZl?=
 =?utf-8?B?YWpJWDFuYzdVU3ZqdUR0OEFIeGN6aUNzR1BINi9Gd1hQeWFxamJaanBsNk9Y?=
 =?utf-8?B?K2w0c3luUUhoVXYzK2tQOG9oMGUvYnpWa3p2T0x5bFpXNDFxd29WK3NLV0Zl?=
 =?utf-8?B?YlV2NHpzdmNYcDV2dWZuTnpTeVRPeDRvdmhVdklYeldZaEk4dnM3a3kzWkN4?=
 =?utf-8?B?YUpQd1V6L2FxOG12b0hjajVjZ0VZaWJLamVMUFczVG90U3NWQ1J6eWR3aHVM?=
 =?utf-8?B?RG5sVzVYOHdWbmlQaWd1QWVzd0FrKzQ4R3pQYnVPTFlhVS9iOFV3eHArRWVL?=
 =?utf-8?B?bW1mR2ZFa2FlcWNhUVZZeUttMHc3QkE4RDlGSlEweXRrTmNlRUlyaWlxOUpT?=
 =?utf-8?B?bmYrakNsUGpxOG9LbHZpZ1I1cVpDcy9MbzUrNXhqeWlRMER5SlNmSzRDRjJT?=
 =?utf-8?B?bUNjSXBnL29JM2VETVNaM3A1WW9naGtYaXFtSy9MVkczZDZjMUg0UmVlZml3?=
 =?utf-8?B?WklDd1hPU0lJVmdvUHYyRUg3T3FLNE1qQVVwaWJtMVE5N2tvS1UreEV3aUhB?=
 =?utf-8?B?cC9KclVsdS9DWTljNjVWQUladkZXdXptcE5NSE9tejdkb2ZOZ0VCRXNCU0pK?=
 =?utf-8?B?RjlyL0UySGdmUDlHRjVYdFQzS0NzdS9oRkZOQVRIRzVidGlqM1I5OWNQdXUv?=
 =?utf-8?B?V1Q4OStBb0tFenlvdGhaOTFqblhBWkpJeWFUUGJuNDZVK1pJT3VsZXhJOWs4?=
 =?utf-8?B?TzdOdDRhSHZDYnhpY0pHVkFBUzVCVUFKZnB6cjNQQTlKSGQzUHJSUFJ5K3My?=
 =?utf-8?B?QWZQazZoRTdTQzhwZHZYVTE0Mms3a095N0t6amZrNDA1NkZOeEsyMVVNanh4?=
 =?utf-8?B?UlU0M01ORHByRmZnb2FCZFlMT3I0cmR3MTNCMHU5T1U2TUNuR3ZvcEU3VzFO?=
 =?utf-8?B?YUN6ZEYxdmpWQ0xlcEFHdjNOVStzeS90dy9CRHdqQno3SE9mQnVUL1VkbVBo?=
 =?utf-8?B?ZTNQYjBVTHluYTFPUnFKZGl3R0t4UTYrQjBzL0JWYnNWSmkwbStveFViTTlv?=
 =?utf-8?B?aVlHMmYvVTlCc0RuYUlCcWFOK0w5VndJNitsc1VOV294YXN5azB3Q2puMGNi?=
 =?utf-8?B?QUkrZUlrWEl3d2xqU3R2SjJmaktjWjROWllLLzBLbitUK3ladUFEM2FTUDdW?=
 =?utf-8?B?Y3QxenRmUzk0Z0RMSmpFNXRZYlk4MmpvNzdYQlNuaWUwTmtXWENDWUxuRER4?=
 =?utf-8?B?MTZVY242Z005VnMzdm0xSWRtNWpNTHZCaDRGUmw4d2ZUM2RzN3ByR2lvWklN?=
 =?utf-8?B?azF1UmZvN1ROKy9CcjRhWEFQNW52M1pQcGJPUUtrVUlLVjZlT3dKdXYyYzd5?=
 =?utf-8?B?b25DUmEyWWhQdCttL2RHQVpGdVVhTFJjdncwMjl1TmtvR2FsTGhIYW1vZDJ1?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1786657e-a9db-43f6-6fc1-08da9b653c90
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 00:07:13.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHSQ69TMww8xNJvDKiAbm2oUkIgIUDjTZjYQbHILRaXdQMVIQfkYuTPLnVwfgxkKOM3FH9C95dNclkCcEmNxu/HkOSdnDEmQBNKs1OYqP/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_12,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200147
X-Proofpoint-ORIG-GUID: IbdjaRH1e6CGFm4opeqXs-DwiVPJV2R3
X-Proofpoint-GUID: IbdjaRH1e6CGFm4opeqXs-DwiVPJV2R3
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/22 3:21 PM, Kees Cook wrote:
> After expanding bounds checking to use __builtin_dynamic_object_size(),
> Clang produces a false positive when building with CONFIG_FORTIFY_SOURCE=y
> and CONFIG_UBSAN_BOUNDS=y when operating on an array with a dynamic
> offset. Work around this by using a direct assignment of an empty
> instance. Avoids this warning:
>
> ../include/linux/fortify-string.h:309:4: warning: call to __write_overflow_field declared with 'warn
> ing' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wat
> tribute-warning]
>                          __write_overflow_field(p_size_field, size);
>                          ^
>
> which was isolated to the memset() call in xen_load_idt().
>
> Note that this looks very much like another bug that was worked around:
> https://github.com/ClangBuiltLinux/linux/issues/1592
>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


