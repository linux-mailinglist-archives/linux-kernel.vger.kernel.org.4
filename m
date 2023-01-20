Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9726675F14
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjATUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:46:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7FD9D291
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:46:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KJwpxd007194;
        Fri, 20 Jan 2023 20:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g+PIVrCX9gLiod0PC1DWKdSqTvXUs5sPPaBa7pIyix8=;
 b=OWT90zSmV4sR2dknIqlYB+h4+eS49hNu9A4/b3F24EHRbZvpZZ7Eby1BJE8T/uNaUbtb
 woS4NCLMyruGnWXHF0lJ6J4M62l7En7UdHMtKedbtnLBSq8yF7big3vjJD/dhrnau5rw
 gfheQU4lu2PQW6jCbq8TGFYI5rvfD7eOdbsvTxflFCBiwMfp6Uzr7DD5KTebRRMWp3ls
 hqrotL0sP9OXSiRHcOx9yZQKpxeMskESqI9Lq9cgoMmza6uKBQV6v8dwbQyrFb3B2oqg
 eeYsTU8eGEAN+Kux8G5Mr8ffCim9q2j2xAPbm0qI0dMGqAK4WNu4YJSCOI9nGBYx3+0O UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6cdpb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 20:45:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KJpdEG013559;
        Fri, 20 Jan 2023 20:45:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfn1gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 20:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtChr3/PKzXTc2TVa7xRUmsiNTMyVzQzG4midYacxHD0etsLZ6ObH+/sxVYCb/wjGfYnPAyV6XSD+k0dBz4xjhUwBLg/m6LHSTbhTlVfkBpbnqUHFNixOU1VuCewCr7QTLpMRFGuN3FRGbKk94Tqwz8X6r4uJVL55MQI71Kk4X9bkvcLo4rHuyGykaYZPoZQlo8WlG45TEfvcLPBK75UbbBCNXXOERPsutC8QmDBv7aO9elDQG1hmHDa15a5sMBwUs1/nb9pcnb5+Bx9cVTsgnzJDdOwwsQD8So6ooZiGttVXy/gv6Wulq1/uXKQMeyn16//v0Xs9oo0TDP1U1l0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+PIVrCX9gLiod0PC1DWKdSqTvXUs5sPPaBa7pIyix8=;
 b=OE12K2JrVTeTu51R5PIpaHOJPsdPutxnm6lX63zWvbdzy07fvN71TFL5rj7xzQeLJuCR0OXV+ir2J8myWtwTc+IVy5B1L4IE7dHkIm+5cU3aq1CRTBQeWnuroT4GuXUcx2ogGT3WnYQ3LKAxqD3crRLOofnjoF3ShFbk8uxyxIx2HKdWRcJvaWpQudP+kdgz4HlI3Vojkc6P9U6+5e0Och0dItd7fOrYn1LJTFK7ek4oGeS4yJdOoUXpk/+8kJ+dwxFxhyfCN9a+jbui6AVU57d+vEjO0fZdGJnk2a/2S5igisWv0y03JatmlRXf+0p8NFTcO8Kjh4i8MoJ4A4KtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+PIVrCX9gLiod0PC1DWKdSqTvXUs5sPPaBa7pIyix8=;
 b=lRvFsScAs8hpxdJbp3m+SUTfF9jN3M8UeRwcaInV2FULxW++dd17SX3RckuuSVZPHAojOJYYiqEyvnbp+BfFYPkWlThj1DHu8b13SswL0LzPQ4imtVfki42aFFlWEABp1zQfQ8W65uSBmpsHVOZCOInO6c7IB1a8odzWBXKkxzM=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA1PR10MB6760.namprd10.prod.outlook.com (2603:10b6:208:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Fri, 20 Jan
 2023 20:45:39 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 20 Jan 2023
 20:45:39 +0000
Message-ID: <9c276d01-379f-9bd7-0a7a-6a831b7b4571@oracle.com>
Date:   Fri, 20 Jan 2023 12:45:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/9] mm/rmap: change hugepage_add_new_anon_rmap to take in
 a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-5-sidhartha.kumar@oracle.com>
 <Y8ot5Y01TWmB4sBj@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y8ot5Y01TWmB4sBj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA1PR10MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eff732b-1abf-4010-b261-08dafb2749f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdEpZn/v9/gTCvae39MAU0fyLkUws1KkND/QNWxWZbGlYFRRf/JIvtZm3TKBAB74ZJn04E4K8rO6nv6hWacRViO5tIapEFrEDAJ+d55sGMslAiKX9pB/7ZZ0bn57oiFTBo2wH/W1Z5y5IyKATJgEbNpWnN+9JfPIjCde5l6GjYS6sakr7n3E1ie43SOx6TVFMXP4HkBfAtiB25KiSZ7SfuOlem0cxR7YieAG5MBoaZ8YFvOX88544vtbBjwpuXfMQP3IZ7xCp1F2PIavw1a4/UHHbV9pofhHYQZsSCtpczvfYWP/PgOG6cc3fSyWR9dY1i5HeGDDU0R/YiZioiaFM1hBiYVdNckTBq+qhHjELRRzW95KZB2CdMShZ0wwXAA3Cm+8exiduDvLf4u/krZgr51idS9Y5YsgJup412dC0ilBF8JALclyfHjK/9xtAUaHj0quHXsFt0hcvLH5s1FNKR/9qfqZaypV9+V7Zkd+TxYVp4PF5Ovlcm1A1+txZ9/rhEsqXIUiHksd96N3pRF8nB6wkVM7F8hMvhCO2BB3uDSKrG2aPgCPxuqwoQOVBdQyyN6lcFGNSf+nXlnjpp68n/TJw2RJS+6xBpDeJS7Yleezy+lKttEss6iLM1vTIRi+xhlxeIRh7jfvYUuXUi2/s/lG0MeBkxtDxltWQUeR6x52zK/oY9nFKm/7GJdtwSL6Y6be6gYTdzhgId4QQbQk1t7KWnrK3Cm+rNgwaXANSNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(2906002)(83380400001)(41300700001)(66476007)(66556008)(4326008)(8676002)(66946007)(36756003)(8936002)(44832011)(5660300002)(2616005)(6916009)(316002)(38100700002)(186003)(26005)(53546011)(6506007)(31686004)(86362001)(31696002)(478600001)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZGcEdTWEdEby9rQ3VUTjFUM0JpRXNQcy90YVY2bUNaQTFsSkhxQkNCYTBu?=
 =?utf-8?B?L0NaQzJ4c2hwb0ZNSWFSbDEwSkpUWWZnZzlHMFMzMHFYQjFyRE4rMUwzYmc1?=
 =?utf-8?B?YkZndmRXQnRCTVlRYnZwbVlWTy96VUpOSmwzTXovMVBuQzc0TWFNVXEwbnVV?=
 =?utf-8?B?bHpHVFIvTlhJSUV3Z3N1YlE4RzhRenpKVTNrT2hMalUrV1ZPN1A1Mk82Y2JM?=
 =?utf-8?B?TE8xd1hkQ0VOM1pSREtwT0hNL0wwRVlzTDZEMmtxL212UXlVUjlIS3oxSmNu?=
 =?utf-8?B?R3ptSDBDUk5POURqWXhMUkpxUEllUG8xU0hjazNSQ1ViZWRrQVovRGptV1BO?=
 =?utf-8?B?VWlJelVMNjhHTm50cG1xUkx6eGFRNjFhU1AyZnh6RkpReFAxQXpWMzRheVZT?=
 =?utf-8?B?cDNYdXppRUprUFFucURLZmtidDZHTnp3K095aW56eTZoUzBCcExlMFZaOHRs?=
 =?utf-8?B?TTZDbEdjMTk2amNQRHV2SjZKWHBybkZRQVVXNjBSNVovb0V5YVNvQXFYdS8r?=
 =?utf-8?B?N2F0UkhabHN4WVJGZE9TSytMaDlKbDNyZjBPaFp0UUU3OGtmME9TQmxIL05y?=
 =?utf-8?B?WVJLYlM1Nzl4OTJhdFI1OVZVUUk1Z3NVUXpUbmUzbThCU0RzUlo4aGx3bG54?=
 =?utf-8?B?VHE0N3JSZ0wwRHlMUUxpM1BOYnFpRnFGcWlaUGYwR3Q2Vnp4ai93S1B5b0g4?=
 =?utf-8?B?MzVGR1lmaW8yTGhUSmwvV1BLVDNDRTVHdHpmZzJuU254VThtbndtcEJhMVA5?=
 =?utf-8?B?M05TYmRTTDF3NTVsZFZ0elliL0Rvb3FwanFlcmZQSzdHamxoRC9LMUFlMjFz?=
 =?utf-8?B?RE5mS2daUlg0cWtsSHNWeFlGWFVaTndxSVV2UXRwdHV1MWNWSTdpUTdkYkND?=
 =?utf-8?B?WFFMS3UwRzUzZVpKa29rb3JHb0hJNk14bG9jQVptTVZQa0VMVG9ZbjEwVlVI?=
 =?utf-8?B?SUFsU05tZHB1VVBucjdoRHJVOGpuN3Q4cmpaMEFJZ0hVcFExR3NRUHpaYS83?=
 =?utf-8?B?d2l5SzlnWWxRZkJhU1FVZi9leVlqWXRiaDY0Wkx1cDI3T3A5OFUxREQ1U3I2?=
 =?utf-8?B?VFNaejlFZDd6R1Z0SmpNUjh3R052anhERUI5dnNXVUxuTk8vQWlabTNzOGhk?=
 =?utf-8?B?c2IwMWs4YllpS3FtaEMvRWpQTmhiMVZIV0lWV3Z1MWJoY3dpYUgxc0RvOS9k?=
 =?utf-8?B?Qjgva3hzaTM5cEsvUEM2ODRMa1Q4YlE5OXloWUxLaWNIdGMxZmg2c1RzcElz?=
 =?utf-8?B?LzhxeTQ0YUFVd1doc3kyTUxVM05QMkxxSVRpeFV6dEN0ZFkvell4UWIyYmhw?=
 =?utf-8?B?a2czUzdFQ3EzcmlrMks2dGVYckJaK0dtUkx3MUhTc0xUVEUwSWJkNlBXMy9t?=
 =?utf-8?B?ZGxjdnRMMk12SnVtOFk5aGVNbHV3dUFTSFRnUVlxR1VkMkVER3ZWUnVwOFk1?=
 =?utf-8?B?YkNUdThvNG5BQ1FZYXl4Nm9YRVg5UXdtVnlSVUVrK1JxcTA3UWRqNmVHOEJt?=
 =?utf-8?B?Q0VMWFR1a2c2eVFkT3VHekhVWE54eFRUaXhzLzk1Z3J1TEJ5L2JjRWtGcDg2?=
 =?utf-8?B?R01RblVxOEZZdVI1RXJWdm9EUUYycDBPZ2l6U0ZEbGw2akIxa1ZLeUlhMmUv?=
 =?utf-8?B?K0xYZlFKVVFqb0I3MmtZNzdrbk12YS85M3NCMVhXTHB3TkE3a0diZElKd3FC?=
 =?utf-8?B?YkhldmlQZEdhNXAyZlM4R1RVZnhXc1h0QWFyaHZFaWFjVHoxR0hzcEduSmw2?=
 =?utf-8?B?RlBUbzUxeE5mZEpCd05nYkpJalArMEZ5N3J3WitSbTI2TmhxYnhCT3hUTVZS?=
 =?utf-8?B?MnNUOG96K1hISHQvL3FNNGlvMWNOU1JOSEMyN1A0SmEwbnNDTDAzVzlJWGxv?=
 =?utf-8?B?SkQwVFlsNUFhTTdiQXVqdFVvQ2NuZ2s4ZVZoLzl6L1RYVGNwRTRreGVqbEF6?=
 =?utf-8?B?eElYR2t5bHNrZWczNXdsc2dwS0QwQWdWcURZc2tlMHJiQ0JTdkxOdVd3alZ1?=
 =?utf-8?B?M2RjRVYyQjdmR29OaWZFYnRoNjVPdGRYc3ZhNUQ3MmlNc2t3MENwYWtQaE9I?=
 =?utf-8?B?L0NyanhxcTJtNDVLdUZJUUU0VFBLVW9RcnRLcUo4aGN5WFpIcGpoYzl1dkhD?=
 =?utf-8?B?WjJLenhzVGxFY1Q3SUhxbFAyQkVtYVM5WCtJME1NUmw1YXdIV3hDQThZV1lM?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d0loUkhCT0IvenRKMkxoaE9pTmxDZG1INHRDQ1c1eWFyS1VNd21XeWkwOUxQ?=
 =?utf-8?B?M0hTMDlicnJFbHYwUTY1R1VoN2FOSHFibHc0dlRUS3JyZUgvVVRoMlpwaVQw?=
 =?utf-8?B?Q1NLWUJBbEYxWFM0STk0ZWFNeUhYZFc3TkJ5dlo3V1l3cG44K0VaejNNRFBq?=
 =?utf-8?B?SmZDMFlHNTZLQ0tTSG13c2dWakZlZ1VwaENrY2RjcG5YMTRjeXFXSVBrNFVP?=
 =?utf-8?B?Qy9MYnhRdGhRd29mT2NscWVnTTUwME9iMUp6dVZlVCtVVDRjN3FLcnlPcm5O?=
 =?utf-8?B?MyszNEFocldzT2xXVlVPelB0bkIzejhET08xeXNrOStucElZU09yeTliS3Ar?=
 =?utf-8?B?MVZldEhiTnk0ejMyWkc3OHJBeGxBWU0xQjNiRkVKQ3RDTjM2VHltRW95RlpB?=
 =?utf-8?B?TEFBZXNsVUlWd3NsZ2VqMktUL1FKQXQwMFpqS0JaTzlHSkRPNEsrUEllTW85?=
 =?utf-8?B?WWUrMU9oUVY1MG1MdzloMkxqYTRDMnZXU2t0RGFEd3FLdUxqT0ZOMHRMWWVK?=
 =?utf-8?B?UFc2MFdEaE01T2tPcURocmd3STNXYkx1Q1AwTEZiaGc4REVMZ2FRaE9zdkx3?=
 =?utf-8?B?d3lmTlhWeSs1SkljdlUxZHhDdlltQ2cvVEM2NHgrVWhhNzlPYVQ2T1k2dEU2?=
 =?utf-8?B?MzIxVVI2VzM3QXYxYmpwSklNb2VnUkpXeW01eE8rOW1tMGdpbnFyeFZXL3B1?=
 =?utf-8?B?VzhPSFlqNGE4OXU3ckpvL2ZtRlNlempDeHQ3TjFLb2k0cTU3RWJwaDh0M003?=
 =?utf-8?B?eSt3cWpCRVVLTEF0MDhRTU9IS0hQeWM0UXNzT084VEtIZnRqeEJvVWFPaXly?=
 =?utf-8?B?dmR5bzFTUTZyekFwSzJRaUNTNCtPRGFPZGxxckhzem91QXRBaWM4emMweGpK?=
 =?utf-8?B?dXExRkN4ZDVHTEhXa0Nrek8zLzJpemQwbGlZdXUyTGVCdnlwaEVaeWM1UllY?=
 =?utf-8?B?VWxVWGc5SXJ0ckpTQzZoNmF2RnpMYm5WNEZxS1Ivd2s2UGFQK1pmZ1BwTDNu?=
 =?utf-8?B?eVVkbjFUK2h3OCtldmpVUGtJM1J4cEhEWnFERTlaNmxCRUlsNlQ4K0ovSVFs?=
 =?utf-8?B?dXlPbU5oSXhPUml6QVMxZFBqb0RhdXpLZGE3Y1Mxb2RubURCbmNtUkhqSFg0?=
 =?utf-8?B?ZVlhUEk3RGx0YnBQdEJDb1RTeENlRHpOL2lUZXhsM3hrUklCaGNXcC9Ncno3?=
 =?utf-8?B?RWRibzd6cUU3QkpJRDY0ODh1T1J2Sk9HOGJZMDJFaERQRjRwZHVxbWszVDJl?=
 =?utf-8?Q?/79cCf8nZrcCSAz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eff732b-1abf-4010-b261-08dafb2749f4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 20:45:39.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqmXTl1YAnuLMferFG2orHefMwC8IXu8zbbOWea5QP0yPzlTPK93utFKxyEdizBrhdUzuY9O2ehEKqRpJ65kZNRssVc9fd5oK4F1nqydqgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=948 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200197
X-Proofpoint-GUID: E2p1wBBRuH2SgQWvd8VPcIdg0Qnc21Al
X-Proofpoint-ORIG-GUID: E2p1wBBRuH2SgQWvd8VPcIdg0Qnc21Al
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 10:00 PM, Matthew Wilcox wrote:
> On Thu, Jan 19, 2023 at 01:14:41PM -0800, Sidhartha Kumar wrote:
>> @@ -5599,9 +5603,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>>   		goto out_release_all;
>>   	}
>>   
>> -	copy_user_huge_page(new_page, old_page, address, vma,
>> +	copy_user_huge_page(&new_folio->page, old_page, address, vma,
>>   			    pages_per_huge_page(h));
> 
> We have a folio_copy(), but it feels to me like we need a
> folio_copy_user() so that we can use copy_user_page() on machines
> with virtual caches.
> 
>> @@ -6176,6 +6186,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>   	spinlock_t *ptl;
>>   	int ret = -ENOMEM;
>>   	struct page *page;
>> +	struct folio *folio = NULL;
>>   	int writable;
>>   	bool page_in_pagecache = false;
>>   
>> @@ -6251,12 +6262,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>   		*pagep = NULL;
>>   	}
>>   
>> +	if (page)
>> +		folio = page_folio(page);
>> +
>>   	/*
>> -	 * The memory barrier inside __SetPageUptodate makes sure that
>> +	 * The memory barrier inside __folio_mark_uptodate makes sure that
>>   	 * preceding stores to the page contents become visible before
>>   	 * the set_pte_at() write.
>>   	 */
>> -	__SetPageUptodate(page);
>> +	__folio_mark_uptodate(folio);
> 

Hi Matthew,

In the snippet:

page = alloc_huge_page(dst_vma, dst_addr, 0);
if (IS_ERR(page)) {
	put_page(*pagep);
	ret = -ENOMEM;
	*pagep = NULL;
	goto out;
}
copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
		pages_per_huge_page(h));

I thought the IS_ERR() call does not handle the NULL case and is a check 
for high memory addresses, and copy_user_huge_page() path does not seem 
to handle the NULL case as well but alloc_huge_page() can possibly 
return NULL so I was unsure about how to handle the folio conversion.

> I suggest that "page" can never be NULL or __SetPageUptodate() would
> have crashed.
> 

