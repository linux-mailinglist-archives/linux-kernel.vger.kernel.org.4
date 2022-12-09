Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE526488FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLITcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLITcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:32:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332A2228B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:32:51 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9IxCqU013382;
        Fri, 9 Dec 2022 19:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PNzzHDIsSR6h5f631wSYuH8ciJzhQz+XG+bm67WnCgU=;
 b=v30WtkNFYHireXut8ToTJQVNR7FZwlJJDpBSNSfwA5hr2wDwplHjpmEjBRsxMqt+Gj39
 /O31oO0B8UdIQPT12se3eiyKhhy3yQMevB1f/bPZmvYdXnVJDBbWDH2dM4WnLOnBR2wG
 xgNVimeG8akblHtDCeJnqaLADuRbdPJr7UaRD62TamExo6R6O47Dnu1ZbHURNegivlO9
 cT8EY0DEOaJJwJ7RCu6kYMg86bgYglN3gFEw+ZOPCOViOYpWIey1FZ28muQY/5cUgoKp
 +WYxPb9gtebF6DxYeRv2x6TN/FBxCh+cB8d6yAhYcNJ3cbbALNe769gInxphBHI0apeT +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud760ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 19:32:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9ILgXG032133;
        Fri, 9 Dec 2022 19:32:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7ggev4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 19:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnRqRMVkWUkyrb/8L/F0gGr+vlyNssM3pSzeLCXl1yo3NWiHxySTrCYP1fEeqvORQrfFjdtIxGm3mpPHLFmkQ7/5yQeXZ5EoNlhUxXrXeg+aZb+PbKkhpXuakqoz/6AXAXU92b5DsAfWz/npvCw0265f6BqMWTogOOAXeVkHIiVpb/S5vg8lEuLBiR/HAyNRmdNrRXlxgh5levDICylb/y2IAngtJZf0rEHcxPgTLxmO77RYUM371fxFrzjuncR+T+6CDrpUH0xdj0erKBG1dVDx4Rdnru1eYPVZYXqumY4t/tLpHC9wQCvm/YckRnNAYjBORmSKGzcQvxzRpFazdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNzzHDIsSR6h5f631wSYuH8ciJzhQz+XG+bm67WnCgU=;
 b=EVsj7Zscvd+qUJfkqduCVJ91lIV9w5cok47NVdi5KQj/7eqLqFEUXasRk2M71Dl+G5N8ZIal0tmwNJRqARmFkRjvClPmaK/BJj9bz9wusIaw/6IEtg+/XTGM+ETlOeIV2Qr8ra7cEvGA0FpiJ7Ug4e1xNfJhjEmR+BAKcaKtkcT8rx79s6dTceD0moQT4S2AWK1wOTNzXbRiyzNBuwteFS2p04FS8D+e3+zJl0TGtLSX3viCahaBmoc4VJp3eAKsb6JFDg4cvP08NDz+5g6OB4e6LxtsfWY4L6QamzBgVpD3M5KqryzSF8lP+ZRtWpn1zCbcphZWtUO9O4qQak9bZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNzzHDIsSR6h5f631wSYuH8ciJzhQz+XG+bm67WnCgU=;
 b=jd+wfwozpxGKQF6GgI0CF3S3pfG7hKMw5sVsVMv1kME1hrOGLE+uICnouxm6vHnyxLImpwIzp+L81KSymB7RlBlfcG1eXIluikj2CV8yqbKGqYJgp520TZ1UX4GOAcjiH6ln2J9cDmss/AHdevWYOAZ+pfBLhetHW0Aej8V44Pg=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 19:32:17 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5%8]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 19:32:17 +0000
Message-ID: <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
Date:   Fri, 9 Dec 2022 14:32:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
References: <20221208163650.GA3225@templeofstupid.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH linux-next] x86/xen/time: prefer tsc as clocksource when
 it is invariant
In-Reply-To: <20221208163650.GA3225@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0090.namprd02.prod.outlook.com
 (2603:10b6:208:51::31) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|DM4PR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a077cf2-ffb3-4107-7257-08dada1c1543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXndInz/C86evfUAbeL2Eprq0Nrfg7kRu/bcBWm+2rzv4sIkkeYVgvUXfE6Yt/KaynuDnwJkj9L/C7TrWsFc3+0nbGD6WV6xyL/1HldoICAp1yBqAUgqB16fjTZnNy3KQr0LokjRIi2r0uRiFvJGjqWkfidz5I4eTYMmVLwUs9h2kScncO3AD52aFTK6Qp6uzAUL831Dqepsjz2TzcrVvdfIM7e16iCilGGnYysY0tQIX0X2tCEv22DY/jcrUnAXqBmaHGFv1uBycRjSg8yMV7Teydsbs4X8T7cPq8ZF6+aAjfks73HzCV9SLln+DuF2tuTaaLB6vsKKT3mLMo1i/6ipAK9Cl03PCU1Jhu+x8KZCRU+kkbtvDcO2rO7hsrdIrAX+lev46MhqZsKazLo41Ha3jrh6Q7yROxMCVWiWe43zsi52C+mNFterg6EyCamavgEUGzzkg5UN2jzPjJ+k9hZw7FVns0FQt5MCkPAKxvFSVtQTwObOhrMHm1X/nqEVsLI0cEpjgkA9LoUBqF6fV15GNgiY/9hVhZbfsss2E8IJm+h2UKKidb3W9VvUQIE8Kh4NIpdgla9ELGw6+e2VNtXs2voDzXdHBiHsEuwr3dn9hc40Ea3ZvlKSL5L3uILLP1u6fDhtG25h0FK6qIFvgNVGaaTEVZyW5zBqMZ41lymGmPrY4Q4psv0WijATlFUSWl7wdC8MUOlQ5sqPc3lV9/+pG3qiIih7Cd8sFV385K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(5660300002)(4744005)(7416002)(2906002)(44832011)(478600001)(86362001)(31696002)(316002)(8676002)(4326008)(53546011)(6506007)(36756003)(41300700001)(6486002)(110136005)(54906003)(66946007)(8936002)(66556008)(66476007)(31686004)(83380400001)(38100700002)(186003)(2616005)(26005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlQrU0hEdDhmaW5RNmdubndUTFpFSHBFRTZYSHljMytncGVkVkhxZXgrZFRi?=
 =?utf-8?B?c3Y0WUVBQlZ4V0QyS05SV2JxUlNkUWFhNUU0OWRkTW1vSHlDSDY5KzhER05P?=
 =?utf-8?B?WWtRdzBnOW43SSswL3ZTSDlVbnJtTzNKVUZINXVaaW95b0t6aU85Z1BrVkFY?=
 =?utf-8?B?dHIwdEdSbklyWHlmRkNsZkVSeWdKc2RNM2IxZmdMVk91eWx2YmJpTXBaTzhO?=
 =?utf-8?B?dVhZcmlBR1lnbnRWbTZ1RDJXb3dvR2hWeURSdW0yanMzclJaWkprRFMzS241?=
 =?utf-8?B?ZHRuOFFmV1pJeVhNTXN3VVJWRnpjRXdYVTBaaGhqbFJHeDdTamRGcWpxdmdt?=
 =?utf-8?B?OHd4MzZHSEJVTWxnUWVZdDFNdHdKYjJBMURQUDVLVTE2L2ticC9oZ0NzMWZQ?=
 =?utf-8?B?eE9IRFQ3czlkaXdRaVNJd1c1UnZUajBjdGtrMkYvNEdGa3VDVGdobFdiWW9a?=
 =?utf-8?B?VXl1UnVaMnRISXNGM01WMHBPT2NzdktzV1NhaHIzcmlabTRvb1VDbHdTdFBV?=
 =?utf-8?B?T2tGeTd6ekRtMGVmbFpRYzdQbVk1VndvbHEvbERJaU1taW1RU3o2bDZCT1Bz?=
 =?utf-8?B?ODZRZElDdk5pS2N1a3QybnF2NDJFa25sR3kwQm5nMWQyeWs2NkJiVFpFRE1G?=
 =?utf-8?B?NDYwS2RsNkZQMllOMHcyYUYyYUJZYTU2NjRVMm83QXV4cVI0WFZMalF6RXd4?=
 =?utf-8?B?WEFSOFo3UEtNSXdabVJFZnpCSytrbnNEdDJtNzVtSHJ2Y0piZUVORUJZMU1q?=
 =?utf-8?B?NjV1dTRtL3RTRnlnSHgvRUJxeGlGcGNoNGV4dFlEeFhzYXJBTHdIS2x5dVIy?=
 =?utf-8?B?RncxVkM0dUY1UUlNOTdVcjljQWxZYXRkQUU4RnVyVWI1K3Q1TE9KejFKaDYv?=
 =?utf-8?B?SmpHSWdFZ3QxNWNFV2UzM1FWTWFhT1dZZTlzYXNoQy9PWjVQMERnU1pGNUJO?=
 =?utf-8?B?c2xzcktKc2JDUi9NdmxWbkpxUUx4MjF2dmw5b3pndkF0dW8wL1VZODY4KzVX?=
 =?utf-8?B?L0h1YVRoVWRqUGpwSGxaMndhWGtiV2habTlvSHhaR3JXclVEdEcxblZKSHJU?=
 =?utf-8?B?NkJQeWZuUlMzeUNjK3VMekV3dkFXYlRQK2xpQ3ZiaDVlVTF4QlI0MkJQanpH?=
 =?utf-8?B?SmdBQmxxMmxzRUk4ZGtWWmVhSmdRZmpOQmFZS2pXeFNOR2wrWDZPb2o0SkFE?=
 =?utf-8?B?SGdwWkhhNmlXL3hNaFB3WnFQU0Raamh6cE5ndlFpbTJDbXg5aUR5YUhsbEoz?=
 =?utf-8?B?cXBReWk3YWRHU0ZhTXpmQzRsNS9rSXY3bnJxbG1MUEFYK2pHMXVMeDJBUGdI?=
 =?utf-8?B?cFZMdnBUNlZ5ZlBRRXNTdG9NVE1kenVCcmhiN2F4TjhsQlk0VXRuYzVwcVRS?=
 =?utf-8?B?SlEwVnpRWit6VHJoeVEwa3l4Z3FiVkdkZ1o1TEt3VmRyejZqUFp5amtmMFkw?=
 =?utf-8?B?Z1Q2dVdBTlBDVDVpYTFVWGs2Z016bUltRjlkUDRlK2VYZk93bm1kZ0Ztb0RF?=
 =?utf-8?B?bGhNL24xWE5JY2hNUzNjVkh6aWUyT2NXV2YxR2pZYmxYQy9Jd0xJSC8vMDZt?=
 =?utf-8?B?eklaK1lOVlRHcy9SZkVsZVMzMXA5UHZMT05maXhncnd5VTZxbUtYcVc4WFBY?=
 =?utf-8?B?MWlIdzcycVBycXRpT2dxY0hzNWhUZHUzMVBVcXZlV0VzSUkyWXJPUnQyNXVI?=
 =?utf-8?B?VzlBbnJSR294TTRneHF3OEYyNm5wZEZwcDlGcU9qRFcxV0ZjVlVOdzV6QTRS?=
 =?utf-8?B?U1d0dmEreWJQNjFUQklray9OZ0NOWTFnOVBudGQ1WWVlTzhiSVhkZFM1Vk9C?=
 =?utf-8?B?R2NvaHhNZ2lFRUphOWI2UHBQYlA4MU9iMTJqOXhQdVQ5RmhzekFFMzAxQWNT?=
 =?utf-8?B?ZjVOamRUU3pudC9HakE0ajRGUG5qZXNGc3p5RmtZUy9IZ3hmYWV0Vno1eEp5?=
 =?utf-8?B?OFdWKzQrQ3R2aTlFT3U1b0U2TGh1WXkwaHhYU1RXOGYyZHdvc0lQNmRGK1VI?=
 =?utf-8?B?WmlMa3Z6VTliZUVnUlAraUhEckNUaCs2QzV4QUhGaHVJa3l0NkhmVXNvWTB4?=
 =?utf-8?B?TFBhUXlxYVd3cmwyTUxodFdmSlFzZm54WitLd0FFZDAwYmFuT09jSVFYdjMz?=
 =?utf-8?B?T09zNytQaE15WDNsdSt0T0RmRVhncWc3NWNEaFRvRlJrUkF3UXVPcEVjZ1l0?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a077cf2-ffb3-4107-7257-08dada1c1543
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:32:17.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylHzhhGLQOHmonejiFmfZxbxFdyrys2oqvB13FuKPXu6iERaq/QPQftxKzGVPcsAApwMaR6/yRF0LLfxtz/EISUrI0EECyXDfiYrNqdyjc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090159
X-Proofpoint-GUID: Eo5tef11Xf8C4zmn2Kel3JNOB6d805WQ
X-Proofpoint-ORIG-GUID: Eo5tef11Xf8C4zmn2Kel3JNOB6d805WQ
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/22 11:36 AM, Krister Johansen wrote:
> +	/*
> +	 * As Dom0 is never moved, no penalty on using TSC there.
> +	 *
> +	 * If the guest has invariant tsc, then set xen_clocksource rating
> +	 * below that of the tsc so that the system prefers tsc instead.  This
> +	 * check excludes PV domains, because PV is unable to guarantee that the
> +	 * guest's cpuid call has been intercepted by the hypervisor.
> +	 */
> +	if (xen_initial_domain()) {
>   		xen_clocksource.rating = 275;
> +	} else if ((xen_hvm_domain() || xen_pvh_domain()) &&
> +	    boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> +	    !check_tsc_unstable()) {
> +		xen_clocksource.rating = 299;
> +	}


What if RDTSC is intercepted?


-boris

