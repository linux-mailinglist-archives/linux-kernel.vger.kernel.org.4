Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B236DCCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDJVv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:51:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3F198B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:51:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AKBCUf002759;
        Mon, 10 Apr 2023 21:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CjtgKgQQ3huh7iyEo9U9iX9zy76w5MlaWNSGi1SKyt4=;
 b=S1QU40ti9yVg+Dhv//M+cdsEfbfqA/eQPTMaR4IhSsadinkwXDWQmtJDf+bFDSgsxs2H
 7xxWblvfNnGtTR+4PEoKmpAMKf487xk0dBpoBlcLMfXoAeZV/I1GuHz6p5LNyB21wztS
 vfh7adUYB4dVi8QiuRTV1PKmQ6n11flBBLP3cqj4zjD42L0YS+8brWepWTfZf2m7ncCj
 vfnY5siUftcgWqUqjHZ47ZnBdB+tGjOMWWAyRupXtKaQE6jW+LXYddCGSFlGLaujGtIH
 jKJWSF1E7WjVEjOLU8cut720NcZsH3xmYzgvqrV6SRlrO+I50YbxVwt5oMRfHKqG3Q9S wA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eq3wpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:51:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ALou6p019926;
        Mon, 10 Apr 2023 21:51:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdmnfmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bImYbd8gj9RKJ4evDzo/2klEbBjuFjE0mgoaIWkzYNVU0tXVh2KWZ5YSBVVmW/eNn35XjDbDhG8qX1BWvdpSPQS7x3Hqx8egkI/qtgy1KNQPbrvdRs76n2Opdrv6345Yl6DMczku6Kg23B/IqJSzFzlhr11Uogbf1v/TBG0YbftNutKhQiXeWEgxrwiYQMhdev42pXqqME7bZM6ybW4dMXjJjc0WsxdnfqaEcMpPQmV+tKm7C5StVCRrW1Otq0dj5K/vt0eTIqkpv7f+/KNfvZedNATruLbnHCZCyJQlkVeLxlszwzGVcWYF1KaUOYGZUCLnJ14MtBDfsyXHbo8iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjtgKgQQ3huh7iyEo9U9iX9zy76w5MlaWNSGi1SKyt4=;
 b=Pud8VntJQGoslEXL0a/gekWn7w1LUy2U/dyS4Wf/+ZT8qaCOxy6oAIRT+pDbR23SrnEph9sV+2gcQPWTmZ2kZblhPRU4/5YQZ/jHomoE12YX6BBXebdiXX6pOKrF0zuJwQBTczm2kLqZUNxZaS0kAfA9MMwCFB8SvcFDqnjNdH7+J6nWOS/xfqfD7/8A3rdPvh9qgeiPXANXMQFvXIXODGzam5tl9zJb2wW6y/OUNxZPFdCIe51SbFsEujKVF3S3byfX+c2gIN70cAIlAJlUyu++6NM0lSQ3//LWLGngZ3F8S4x9IoE/LOIQClv+C/cWgf9J8Nsvln9py4wqX/WYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjtgKgQQ3huh7iyEo9U9iX9zy76w5MlaWNSGi1SKyt4=;
 b=vln0PfsSmARXBKBC6Heo19QDrJwD4hq7iusDR0+uC+nEsycx63bKKsr7WlHFZ3bBlx1Yt+XKOSa7WsMVewrlCTbm0nIbPIvMCr1RJTKqUSJZsZpkiWqQ6N10ebW+x3d1G/oxk46+GD3zE5P6RRNTCbT9qNxyyYrIWEhr4fpLpic=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.36; Mon, 10 Apr 2023 21:51:41 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6277.036; Mon, 10 Apr
 2023 21:51:40 +0000
Message-ID: <b9f72ee9-328c-9de3-05e7-ea7d1339984b@oracle.com>
Date:   Mon, 10 Apr 2023 16:51:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
From:   michael.christie@oracle.com
In-Reply-To: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:5:190::41) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH0PR10MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: a84bb386-dfc5-48c8-2744-08db3a0dc3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9ACQtdwdPxI05yu/h0Ew9C/wnwzyWzy8ppWN1ADXdoRGV0Hnza6Tp66Wrx969LyyMO/QHr9mZW+lYpu4USZcegtqf4sm+UdLORZzr/4/HlKCF9TchxBsbJp/TsAy7OvQ8vgr2WZVRHrJQI8ZGyyDDYvfqAu4WG1gLY1CmtEAEQ03vNm0y/m7y7cGgIHm+TbN8Y9ahgcINcp5huWI58qGj9Zf90UIDQDxD2lucspv1L0YEBMeVnV9YH/c6jQFT9iqs0rsopEuTeq4f8y48uYgkU6H86FLOJX5hkkyHqgXNTOyz9rJCbrY2hn+D4G+WyIxvMQj+lRKOuzV5HqeqbaeVr7BVnVFcfCzd+m4vf9vL9aBRvdhoMJ1sMOGWcIVwFWseYY9VUQ/NaMgd/vE8C6JF/zrUk4+/T/aUlgxlHSiG3f6oHj6rzTq9W2kDBPqFXt4DwvgVE6NUU3buUNXqMDO0BfciP6YaWuNtp45KM0QmlxATZsmhJRrAbvXOr9yASj91ChudDRWsOKJ5Fvg4sQI8ZU/qKNEebMVG0Q28oFRObwW2OCb/qYCVCHK/9763nRqjuQ7IOEXCHT6JS5SZLdeC6kYn+erFr75y3yTlpxsnpSDFjyPHuIrblISQd/jUBA/PTUedv67zaJmJTg/1lULQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(31686004)(478600001)(31696002)(86362001)(36756003)(83380400001)(38100700002)(2616005)(6486002)(966005)(2906002)(316002)(110136005)(9686003)(6506007)(186003)(54906003)(53546011)(6512007)(26005)(66476007)(8676002)(66556008)(8936002)(5660300002)(41300700001)(4326008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRxUHBpbXVMZW55cExZUUVKOHowYUVnTjczelJqQ2tUUzVsVWhHVk5icnMw?=
 =?utf-8?B?b1RyY3dTcjdXYTVFbksyT1VuUS9jTFF1V2lpNS9rR1dkSWZCSWRmSHJJbGhG?=
 =?utf-8?B?K1l2Zk9lcFdibURodGZUdkpyN2xkbUtIZVUwUHpHalA4ZHcwWWZKSDlKRzQ3?=
 =?utf-8?B?MnAyb1owRmdWRFJrcEZPYjhEdjR3V3NlWFBMbmRkWVBaM0RSYy93T1o2TU5I?=
 =?utf-8?B?YzBDMHNvMFFuUHBTUG92MUJ5TGorY0Y2U0g1RUZpYUhkSm80VmpxbmZHQlhT?=
 =?utf-8?B?YTlGNVRtZTl5Yi8yNlJWVFkxcGp3d3hwdU5WUkpBQ1d3elFDMExtVGFrYWVj?=
 =?utf-8?B?cVh3bUhtSk1NWXplbW5TTXp2clowV245TGU0WHV1RzRsYUNidFJBR0pFcVNh?=
 =?utf-8?B?b2taVzVtTDQreU9lWU9uTCs5VmNaV2ROMFBhZ09mclhTSHlmOEJXVElQVzdM?=
 =?utf-8?B?aG9ZTXVZNks2YXVxTmpPVndNYTZvdVA1SHd0L1o2blBsb3dOOStoUnU1czVy?=
 =?utf-8?B?Y1pyWE1zWjdjV002RUQzL3kxVnNURUd6czdZUGEveXBmY2ZqUjREMktyZnpi?=
 =?utf-8?B?cXZPTWRXZS9zNElTZkp6ZUNUQ1k2N0dMYjB3WVQwZTRzUHlENlE3a3NveWlJ?=
 =?utf-8?B?bFNQcndrOXluWFFTU2UzVnFlRFRZQi8yQ2J4dnp2OXBaSzYwR0FwUStPdDJF?=
 =?utf-8?B?blFNUVVGSjBsL25XNUUyMkdYRHo3TXJ4WU1lSDZqUlhCY0pGc1NHSEE2VXZH?=
 =?utf-8?B?eUpoa3pNQkNjRXZKeDNPd0tQUXNZelpXTHc1ak5TQUtaTzFuNUNBRUNnaUo3?=
 =?utf-8?B?ZEphMXlVVS83TXYwMUVpdXJxOG1jYnZoSjRyNERDWi9YcCt4TUs4ZlBJZEtX?=
 =?utf-8?B?Wmh3cmVDd3dGMDB0UEhCQ3VUSGQzZE1YNkZ3YzVrTS92a3VhMWZSbWM2QVMv?=
 =?utf-8?B?R0RQRU1JK3N0SWVKVVNydlBXbVA5VkdXYTRTSVMyUGl0ZXlNMkljYkw3bHNP?=
 =?utf-8?B?bnRzaDdMa0d1UG5oSFFRL0xPUjhZTlRPck1lTlhyREJ3QnFGbGU2b09QTUlD?=
 =?utf-8?B?VG9DeS9vS3pESEVFdmtpZFNSOGtYanhoNGorblZWUHFrbXY2enJ3ZWxnMWpj?=
 =?utf-8?B?UjZFV1Jidmcwc2Nld3ZveWhvM1JITUdxcGhOa3ljbjhJdmdXSHNma1NvaS8x?=
 =?utf-8?B?TEZPaHVkcHpjNHA4M3RCVXJOYTdFbjl3NEp6N2VYbHlvYzBBdkdHbTM3aFYz?=
 =?utf-8?B?cUFFSmpnUmpYdEExMFFOYko0L054RDZkZkgxdG92cHo4NlA0UWZ6aGlDMDFu?=
 =?utf-8?B?MjNwbGhBQjgyaWVEUnBlVlFnWFBKcmo4c0tGUXFvQmUxeld6WTFiTjJtd3Zm?=
 =?utf-8?B?UG1nRFhBM3Rxd1FSNHVVazdTeXh1VFYzTGV0U3dxSnV4RjBSTTB2d2M4d2lN?=
 =?utf-8?B?cEFDM1JwTHZXRDd6aHhqRlV1NmY3QUhmb1ZyMzlGMDNGYzY1REU3RTQrNk5q?=
 =?utf-8?B?ckd1WFd5cXlidVhRTFk0WE1yMnRKSERiVnU2ZjE0YVlrV2V3bnNtdUZncFFi?=
 =?utf-8?B?OVpNZFp3SlpyVzZDekZ0VTBBYTJDcVAyc1ZwVUZUMmdXZVFXWVZ6UnE1azYx?=
 =?utf-8?B?Znl2YjY2MUVveEYxMnJrbWhyTEx0N3JTQTBOdUlLVTFnZ05iTDVMRDNRWklu?=
 =?utf-8?B?RWxVOFh6T1gzanFKZmRCd1dzcGQycTVRNWx2VDhRSVBINFBPTEFMOG10OURk?=
 =?utf-8?B?RFgvMnNsSitxZk05YzhnRXhQbHczT1V0ZXh0cnJrdGV1b0xvbCtIM2txbHdV?=
 =?utf-8?B?TndtMGNtSW1TMEltUWpiR1Y1WW1odjBFcEtWak9aaW1MOUlDK3ZhTVVIMUJ6?=
 =?utf-8?B?Y2k0eVJkZDdXSXhqamdneFNZOUFHTHVQYk5OSGpraElxMFpyeEFRclUwOGUw?=
 =?utf-8?B?SU9nMTVpTjVNaXNBdU9LV2JzYTZWby9MTk5HK2dBME02a0RJWUhXNjh1T0ZC?=
 =?utf-8?B?OFhaK1pZbXJjZFA3cWdMME5hUUxYTmU1Tm5KdVd5blUzZjhTNjhLTktNTVNz?=
 =?utf-8?B?UHh6SThNRTMxLy9TWWVYbzJteDl4bFZBWHZTaWZXS2tiVFBzWSsyeEgvOWZG?=
 =?utf-8?B?V1NZM3BZZ05kMFNVdGZwdGwyQWhkY3JZcW53Smc2R3YrcFFPL0VSdGFyeG1u?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: as75urqHHebg2L4hZuwQA5jqeC0JyYsel7z/AUa3NS//+ZjeeVjAp0ZUSy06WDR0OLzKH4fVIKqKUlZWbR+sQY7ySkGLaC4anUbPLUS3gy6ZcL9/PbSHTpQx1wa7ihY8QUe9kPTAnynYw5602AElO6b6y6bikJZ+xZMEJUhYQldqj3l9GGBpaOyqX/7d21WZNPF7DClXQJW4dNAgYJLeKuYz7KxMSptD+jVceptjTDPSQvJcgsta6zdZzEzrHI+sBVQIgqI8d3pZ26Py5YE0d7oS0YBgLtd+ml4vrDmrH//MIqPrHJHu5+1Pz8LIeHlMD7xz9c6+WXLE4GOg6en+sinY0Is7zwB6/mC9Uw1SHveEJTYIBb75/HGMfOYrLZhMEDVgOoeecJIMbq8C1lW2pgAQaQOjdtgj9xT2IZkgt/S1JhL8Ez6PILIOfD4pmBPOzHFPK6pXKTIVdp+FI3GGZgyTLeikavOzlX6b/k7CYqVZLFhsHrBKRaj8vQmEBpAVc/NfmoIBskcDTlpHmbcePEQS+3aZin2lCRBZoshWPaJ78qStvu+us3dB2Vzr39iAo2z2jHCqWUmYjM6o5KHRH/2sBN4CZDaLAUBEwQgmcSjtvI1dG5xZaj1D+RZRFIsLyTaUoSJlbHYxar6nQeazpgs98/u/lL8too2V+/xNPb4DCWrC+GSRvFKJpf5v7nUzYfTYTyyFEignma/Tp2nl3bujQjtDkUvt28Z84wSZbfXvikR4mUVfypLTH78qrrfymINwWp6HntjEnzJMQEdlJgF/S8kBVrmSEDOqFcmKs7zMwQwwzGlLZhW+24UcJqM0rF+A5kd0RJTm1pMxllHRjO9m2BAGT7cSgWLnxUQbMGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84bb386-dfc5-48c8-2744-08db3a0dc3fb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:51:40.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A3F4PpbJqjVnrNfw8idZIDeEw4PkQyLyVOB4m+7y6E7HNlh42J/AO5YEdCOwy6poslN0QGo/w0J2qIeGVWl6NRP/KpXamxi+iIeLoGaFv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100190
X-Proofpoint-GUID: De4bU0xC4ugJcztNyh2XDxNmWLF4s2aO
X-Proofpoint-ORIG-GUID: De4bU0xC4ugJcztNyh2XDxNmWLF4s2aO
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 10:01 AM, Mathieu Desnoyers wrote:
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.
> 
> Keep track of the currently allocated mm_cid for each mm/cpu rather than
> freeing them immediately on context switch. This eliminates most atomic
> operations when context switching back and forth between threads
> belonging to different memory spaces in multi-threaded scenarios (many
> processes, each with many threads). The per-mm/per-cpu mm_cid values are
> serialized by their respective runqueue locks.
> 
> Thread migration is handled by introducing invocation to
> sched_mm_cid_migrate_from() in set_task_cpu() and to
> sched_mm_cid_migrate_to() (with destination runqueue lock held) in
> activate_task() for migrating tasks. set_task_cpu() is invoked with and
> without source rq lock held: the wakeup path does not hold the source rq
> lock.
> 
> sched_mm_cid_migrate_from() clears the mm_cid from the task's mm per-cpu
> index corresponding to the source runqueue if it matches the last mm_cid
> observed by the migrated task. This last mm_cid value is returned as a
> hint to conditionally clear the mm's per-cpu mm_cid on the destination
> cpu.
> 
> Then, in sched_mm_cid_migrate_to(), if the last mm_cid is smaller than
> the mm's destination cpu current mm_cid, clear the mm's destination cpu
> current mm_cid. If the migrated task's mm is in use on the destination
> cpu, the reclaim of the mm_cid will be done lazily on the next
> destination cpu context switch, else it is performed immediately.
> 
> The source cpu's mm_cid is _not_ simply moved to the destination cpu on
> migration, because passing ownership of the mm_cid value to the
> destination cpu while an actively running tasks also has its own
> mm_cid value (in case of lazy reclaim on next context switch) would
> over-allocate mm_cid values beyond the number of possible cpus.
> 
> Because we want to ensure the mm_cid converges towards the smaller
> values as migrations happen, the prior optimization that was done when
> context switching between threads belonging to the same mm is removed,
> because it could delay the lazy release of the destination runqueue
> mm_cid after it has been replaced by a migration. Removing this prior
> optimization is not an issue performance-wise because the introduced
> per-mm/per-cpu mm_cid tracking also covers this more specific case.
> 
> This patch is based on v6.3-rc6 with this patch applied:
> 
> ("mm: Fix memory leak on mm_init error handling")
> 
> https://lore.kernel.org/lkml/20230330133822.66271-1-mathieu.desnoyers@efficios.com/
> 
> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Olivier Dion <odion@efficios.com>
> Cc: michael.christie@oracle.com

Hey thanks for fixing this.

When testing linux-next with vhost devices, without this patch IOPs get stuck at around
1.3 million IOPs total when using 8 or more devices (you get a worker thread per device)
per VM. With this patch applied IOPs scale again, and we get up to 2.4M iops when using
up to 16 devices per VM.

Tested-by: Mike Christie <michael.christie@oracle.com>



