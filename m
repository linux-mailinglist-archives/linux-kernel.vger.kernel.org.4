Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E55EB1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIZUKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiIZUKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:10:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E717057
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:10:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHXxEn022227;
        Mon, 26 Sep 2022 20:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hRnBlewc2lAS7P5loXEiLEevIB2bbEGGk7sp/0MSKeI=;
 b=l+WCs9nhS4anq0hS0c9uRXm6z/ro0un41I/cx1ejH0xx6scl1JRMVZwtPSMiKBlg7ZOU
 WKlP/9iO5pnPJE6EiQ44PVXimhokHjriKMwMwnJ4XOFAy5WbJ0LvTySJ9svo9J/RZ5Uc
 +be6DnlL+B3CD+F+ftC4CdyrTd+YXmW0zm8ve+H1Dc32WNTimFUHYYoQUH2k8HuQR7ft
 xzrnxUVM7Mw5wvi+EiUBEgdpfaOb7ejBvqR2cKNsUzdm1BKJUkzClB26iw1qnzxtl3gw
 TvPCpD86w4FIfa3VDqvXrLnTyeM5FbE+bM39MZCiRw1tzctVzDWiEminz7ZEx8Cd2/Xi cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwcspj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 20:09:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QK08YO019670;
        Mon, 26 Sep 2022 20:09:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpu9347t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 20:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqLDVqFCOlmTGkfb0rPdETFnx+4XRXSXSxA68i86ElvZjerV6rqeqcjMKuJHx2+9V0S6PLlfcmO4eJ3aw9O1wJ5g8sUGZAPPQ62cnsfjSHARLHLzfeuQ+MwsDUbJe1LWehdo1oaT4giXCv6GUetIniFSD1cSwkDcTOGJq/JFYDAAIkr5yw7jXou/DWZsLvFxM8ogDtKeygYAfksMV0tUmhwuss/Rbav5clodPwW93KdUuMdjAYzGc2w3HA7vkenVCXpsvJKdCI4+gNbOhFLc+Yn7TfkbCZ08QF+v723v8SIcRTCpyKcoYckAZRdycxREHXQcZpf832yY+AtgFkJvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRnBlewc2lAS7P5loXEiLEevIB2bbEGGk7sp/0MSKeI=;
 b=EaLP/HttTQETQOF/dKczsursKRhTkjSKqd7x/euQq/5ABVgZrEai4UudN9qa6BnL+MqbxDKzqcgCT+vewaMTuN1H5rkdWuNfDGAmkMo2o04h2tm90HEQ68j8C7KoZbpr4apDTJgxuFFDwvcWRsbWxHGFt5j9PS9jOpuWD2YO4g4q/hOpZacOqyOBEB2Ib25SebuU0WRasgnsdU6j7dQf+piKOK9euN0gQSZQNy3Vgeb/h6MaEQ2Fww46sH0kAfaRp6W2TCn5z7s0vhtrUG8zfDBIg9uLsoCIYLs8RNYxT9w5qoSHzdtpyzDTym8i/M2Hj18Nlpe6eYVLpfw9UxcbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRnBlewc2lAS7P5loXEiLEevIB2bbEGGk7sp/0MSKeI=;
 b=k9Lcecn2hlHQrh+0mLHrQS7N1lc+4rL/zkZty7qVWd/FtR/7Y68KTETFHAteMN2ZRyF5beE4NKu7hQlYU9L531uVf08EuCLUEE+/AU1EtVvX+ET1d8VcDMxX3gwQZ3kJXpb4yH1w0Vz+jpRQ5poOQWn8BFI35Bb+5+qvG1SnZ74=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 20:09:19 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2b18:d3d0:c806:401f]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2b18:d3d0:c806:401f%7]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 20:09:19 +0000
Message-ID: <b9c7a953-dbfa-164f-7a18-1e230c70e124@oracle.com>
Date:   Mon, 26 Sep 2022 16:09:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/3] xen/pv: allow pmu msr accesses to cause GP
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220926141849.21805-1-jgross@suse.com>
 <20220926141849.21805-2-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220926141849.21805-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:5:80::34) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: a1511a3c-115f-41bd-7a1f-08da9ffafe96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2fyhE9XxNme5YJFLySZtutoV16dBO1USjeIa3rQoDHdgoGXHRivzkdonCLFMSRjWTTua70qGjcHqbuHjeiq1bE9RFyXoOqNxZzsJqGy3Y/vdXNs89ulpiYpsM6C3RVQIpM2a9ZMGDBA/Kaa37EDII98J/Mi3UHhHqJELKJ2usalPEkTvMOuO/IFeABHQRx9nVdmvTtrvknD6rzQE8R4OwNytJExXpJELZFdRpskG7od6AHWKimDxvgsZnn/A6ZA1+PUcElh9T9uC6Cbd/PK4Ye6dYZOP+Q3XGhZNr5vloYNikLE5I+kiLBYRddw1SWAyyZfxuqZYUnhsc1CbXOz2tDd8/Qe7QzDXSSmBgrcAf0FvaccvECQlgKBvGMBt0cUw9GLC+RFIAdMivm7RGS93yAROXLAU+EBo6mFBgUIgOd3gsoaIFLDorVouwgiRCSzdkkVHCLjHObRv/MdpeQI2U6h2YyBQZjfAmKMEHfqftG9O3jn1AUtDgoxKMk+A+N1Zrz9fJzpT4FqN6V+csv0zvnM7J02mPAexwuBzXMNAqHTbDAMQKQXZxUeDVrXpOs6YoqosFiSzeg4ypusbtfV/MlUJyfNENo8xgZA72K6R25tBn+Ql0AnvxXoSeaRKITIk/9MN0n7jw4z9+La0secShN2xgNXfAmPG1EMLkrl11ehkNBju8mHexVZrAFGTAS84Y+oD2awz4cLQFwqrPztabzsH9uMEwIoRJxxbe2Vu752Gly+zXqdum+/nP6nehJb+BsPJGpAqYwt2OzHII9FvlZ633AlL/VBJGqWD6x0wsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(5660300002)(8936002)(8676002)(4326008)(66476007)(66556008)(53546011)(6506007)(66946007)(31686004)(38100700002)(478600001)(54906003)(186003)(2616005)(6486002)(316002)(36756003)(2906002)(44832011)(41300700001)(6512007)(6666004)(26005)(4744005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Npc0t4YXllbm5VUk82eUZlTHQ4bWFidXEyenQ3VUtXUnR4V2FvYUhUMWxn?=
 =?utf-8?B?SURYZ3lXTStFRlpxUmpYa29wT2xxemczUE1Gb0lXM0xzb1MyNSs5K3lVU1kv?=
 =?utf-8?B?Q3ZJb3N0bm84b3hzSnpnall4ZkFIYmNiUVdnQVIyeGdTa2hTQXlHRUxPSG8w?=
 =?utf-8?B?SytMZm9PR1MyWDZtelI0eDRmakswVG9IVWFuTCtPNGErWGdHWG4xdmI2RWFl?=
 =?utf-8?B?bkRtK3F1VHpseWdyVm5wQ3MyK0U5ZXVGbU5zMitxWElLVjludWZVbU5qejVC?=
 =?utf-8?B?LzIvaEhTekMwYmRzUVExUklONklBV3E3aStrSXRwQ2w1enN1TW4wYW5hdUNK?=
 =?utf-8?B?aForTGc4N0ZDZUMrSi9ocmt3RThIS1dJOFZtelFENGNHUkkrNDcrTmthY3NR?=
 =?utf-8?B?NVZVNXJMT0pnT3ZzSmdCejB6UVE3cG9Rd09NUWhqT1pwbThOdy9LRmFHbGxz?=
 =?utf-8?B?aitabTBxa2VuNzdPb25CdmJhR2s2UlNsbnNWM3BkTmNKNmlPMm1aU1pYUWpG?=
 =?utf-8?B?REdiMmJ3bEJEN0tSNkNVVm16S1haREhuMjBJNzRiaXREcEJNWndMVlVsSTg3?=
 =?utf-8?B?RWFvRlgxNndYK3VwUFVtRzFkNmRYR05SM0cxblFDbnRkdVQ2d2tIYkhZdUZN?=
 =?utf-8?B?Qk4yMVBOZ2h5WHNsaDFhVlZiMTNoOGpIZjJ4RGFCcjR2WWFFUGlvNmhmSk40?=
 =?utf-8?B?b3lvMjkvRG8xVVlXYlhzeVNlYzhraVRBOGVwRzFPb3VNNHN5QkxzSWp5WHA1?=
 =?utf-8?B?MWRTMmI3aTZnTGQvSlJXaFBaSjZjbUJOYzlHdmswZkxxR3B4NnJiaFNJVVRu?=
 =?utf-8?B?STM2bG9iQVdDQVBlKzFkVCs3RDc5Sk9JOVVmaGk3cWJSdmNSeHc5dWg5VGt0?=
 =?utf-8?B?ZlcxaHB2OUs3WHBFWHFIczNIWnBTc3BBT09Ka2lUbHZxUWl0ZHZSd1hqOXdS?=
 =?utf-8?B?bjE0allaMWFmL0Mzb3RkOFdJTVJkNnpET2Jqb1ZsMHRvYTZWeHM2YSt3bjdy?=
 =?utf-8?B?ODUxRzhTTmIyOVFwUDM0WEFoR1BqajRzMlFDSS9tRmkvNnFVbzNBNWZlcGY4?=
 =?utf-8?B?eGJ5SW00bnVMY2c3NlpJZU85bXE0WDl2cGRLaUtQS1hPNkZRNi9CYzdmREtm?=
 =?utf-8?B?dVFtdENkN2hxY0c1ZklBZyt2UVJMZ3hhNXpheEw4dG9sT0xQU2hjZTdEb1Jq?=
 =?utf-8?B?b01VSldJRlJRUmFZajVuamtmYlQrcFJLMzgvZDVMMWlDNUY5V0tVdWtEbXcz?=
 =?utf-8?B?bU9EU0h1OTVSVGRhVGczS0FjZjJiSmZGRnlGcnN0Z2plMDZnRFIvME9lTkFs?=
 =?utf-8?B?VVgzRjFINU16M3BiVTY3WDMxQyt6NFRwa2NibWxNd0RZdC9ZNGcyWU44dzdO?=
 =?utf-8?B?NTduWmZrL3dVYkxELzhRRWhzOW5GYm82d2REOFNxSnlzb2pFL08rMkNrL2RH?=
 =?utf-8?B?Wkd6RmVQTDZWa21OM3hBL3VhYWIyOVZWeVRvYm8vM1duSWJVYjRaTlFrMVdx?=
 =?utf-8?B?ckhaOTRwb1FUVmkxcHZpTE5vY0VjWmxBa3h2WURIVEovNlJYTjNFeGI2cWVa?=
 =?utf-8?B?TzN5SWFURnZPWVU2RVFZWlUrRE9YNllJVkdqNzlIQU5VQzBSci9jbWY5Yk1V?=
 =?utf-8?B?MWxkZGpJb3JDTFl4OFZDczZJc2V4Z1dSTy95QzRGWXhBMk9LVmtXak56TGZt?=
 =?utf-8?B?VllNdmc5VDFtdlI5aUUyZnRkQ0tlSHVjZE1vMS9keTNHV0VVVlBiY09KMU9Q?=
 =?utf-8?B?OXdpYlJxTHVqUFcya0QzNGtNUUhGb2RsSUlPQVZUMHZqZHprTEsvZTdlYld4?=
 =?utf-8?B?WWQ5cmF0bFI1NVhEMlI4ejVCdzhzZTlIbjlKcEV5WDg2cDlWNGsyQk9FdGVm?=
 =?utf-8?B?ZXRMTENtd0E5NURrUEJWUzk4TTVxVVZwa0F1Qk5NRDZoaTdpWFMwVU5RZjBp?=
 =?utf-8?B?L3pjc0IzZE4vRGE1UFY5WlIwcThISW41OWwwaHFXdWRpb0NRdUhWdDhNbmlq?=
 =?utf-8?B?YkhPYnpYNFVlUHEwcEpWbmt0OGFTaGJ4OWh5bFgzazlwWjQ5YzVTZER1R0c1?=
 =?utf-8?B?WWxKY3pGS0RVMVZFdXJMYzh4c0pEbGxhbUdXV04ramdpUlo2S0gvNXlZVEJ1?=
 =?utf-8?B?MlNoRFhwcUk0OXBDRVVtaDhPTUZJOFo4V24zL2RDR3U5NjRoUmxNTUZYR1ZX?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1511a3c-115f-41bd-7a1f-08da9ffafe96
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 20:09:19.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQbpNOpWCmxEqm2iYTIV6E5IbfQ6SR816+Fmax/tSThRv6TMC+3PhcSvb+4fQlU/LpULXgsoiaQ45/ne+YNErDxhnPJGqMCHNYFmyTEUeOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260125
X-Proofpoint-ORIG-GUID: J-4FRXr1-B5beVWRpZTOUl-Z3TKOjLtg
X-Proofpoint-GUID: J-4FRXr1-B5beVWRpZTOUl-Z3TKOjLtg
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/26/22 10:18 AM, Juergen Gross wrote:
>   bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
>   {
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
> -		if (is_amd_pmu_msr(msr)) {
> -			if (!xen_amd_pmu_emulate(msr, val, 1))
> -				*val = native_read_msr_safe(msr, err);
> -			return true;
> +		if (!is_amd_pmu_msr(msr))


You should be able to move vendor check inside is_<vendor>_pmu_msr().


-boris


> +			return false;
> +		if (!xen_amd_pmu_emulate(msr, val, 1)) {
> +			*val = err ? native_read_msr_safe(msr, err)
> +				   : native_read_msr(msr);
>   		}
> +		return true;
>   	} else {
