Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF43724CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbjFFTVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjFFTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:21:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199A92
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:21:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IYm5p001857;
        Tue, 6 Jun 2023 19:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ujgmLjWPuSqoOJNnhp0WjmfFTI3D6YKwTJg4U2kd+a4=;
 b=p0kw1q/fwkmgSpQGkqCGfmSHweGyzAPf0e5sB7xYtqCCQxCu7lMS/9oPaZ7bxv2N99M9
 07h09Tx2+b51Gh2ilEnMMVY/9NNDs07eNWHguZcT+wtYN4m4IaOfHg15WfyB7ZtR+/8C
 BUeANM+Np/Z8hOjuRrcEmNDxsGPIRYLTJTIHYYVCoGyAaw/oYeYNIzZgJEXyd7U/K8+T
 esHzGOhidF8dn6eLmPhhljsozXP3uP2aPPZwPHfSEJeVcpuFFzmhK7WMvDmauM0JbB8j
 KyblK5IsLcnfI489/3pt1DE2u28F8kzOrA4Qv6rBM+yzw8+jw674rOMnU5eAX40UmlPP Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u82pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 19:21:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356IY9tf010488;
        Tue, 6 Jun 2023 19:21:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6phpf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 19:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGisY5u28g2jXK26ly9SdF/7Uw1RoGuNngPADUfxqx03k1y+s0BQN/EfY6An5kIkT76AaTAYyH5uT1GyO9Mg2eR2kGFtLSZkarAgrr6k9E0s+39H28blqo17YOR4dG1fpGWz3UAsx0ZK1GGQkIpP1ftRtmTCLWPjlwOfHRh3iAB1XfIbYCKE0GwdGQolIZPNDUvvJYpd5WiWeDAlMa2K7pNqsJqVenh43djUznUVRNo+DoBhdbKPAbGf0HoqlD/U19WD2IMT7Ln2Sx7QkrRC3T4EF4hK0b+PrmN+g3HZ3KDKMmDgduNnOF0Gs7obEs1O3fB8ytnTA0/j5EUlmELBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujgmLjWPuSqoOJNnhp0WjmfFTI3D6YKwTJg4U2kd+a4=;
 b=R4dbQW879IeRjPlBaSRgUD2LVucZTDvApK7RJOwFpjN1NKfVzxGnapy16a7Yl1GTDlwZElOCLuohhcGKE9NIMp6nbLi6uy97r1GuhWvWvB/QqSAvgk49dDRRKm1RjojEZiobIKkaFzMlUoFZZrGfUe1mBHO4/ymozX9jbV1oZlckwL3jz+exuWiv62o0IE0IFAvIGduh3EV9Cr9sS46F5VyikQSqdtWAJ4iXQIPMu+STpXdmeGqfZz/fxJWeGqdNFSVmaqKz+GF7LQBg1rXRX4ovoIJBIyu74FTVWvMSFeNO5zhf5xC8Ss6IPEtCPCO12jKQwyx3/R3O7hQUnlObXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujgmLjWPuSqoOJNnhp0WjmfFTI3D6YKwTJg4U2kd+a4=;
 b=igejXrORyH7rnXXdub52/iu2gyIqUGo5nsJ2e+T62qfgspLhqALz8XZRB45QgWZKrxRzDG9lMko5Ld5TWL7IJwRnvlqtfJH19MnRNSADX9eyYWhzoXNGhHIHrPCrmH9ftMaWaYh0Vpmm0Lil2b/ixdE7wOnpySDLWFm0y/oMLvg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7363.namprd10.prod.outlook.com (2603:10b6:8:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:21:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:21:30 +0000
Date:   Tue, 6 Jun 2023 15:21:27 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Yu Ma <yu.ma@intel.com>
Cc:     akpm@linux-foundation.org, tim.c.chen@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        shakeelb@google.com, pan.deng@intel.com, tianyou.li@intel.com,
        lipeng.zhu@intel.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Message-ID: <20230606192127.w66indpq74ec6eyt@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
References: <20230606125404.95256-1-yu.ma@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230606125404.95256-1-yu.ma@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c0ad72-edff-40b0-8e5e-08db66c33b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7S7B2WbGNc63l7KMO6te8DhF6qnpfs6SPloPtynCT/k5ltopT6cvYHgtGSvZUoGYnfjf5Q6HqYZFnINN52YS4oFevwKgjxJa5qNmtLEJ94exlo2/nJAKGDz5tkt2UOWuVlxrmKF434EWUzqGn4679iGjuUoY4m2wafUtFluwRtmexWB34lDvHovrSv87zjLLLpZD/Rodw+ikN9wZnHq7nBkoDvJAFlkuGSAFlUb1yq1bqHet8mX8Pju5eErh1aC5PPcRstcK5sZFIATSit1rBQgS6FAOti66qILMfmL8TVwtWmYOB+Z9y50Llv0EzNupwAwzVc50qzJvlh6+MfI80anY2vkFbvAQF6ylNv0O04+uhbxfEp5Y2u6toAnBWVcEBP5iG8krbdlqcEu4gVxzjyaNogNb+/FSM8lUwM3ZxQj1YKo95rV7SeCd2GFlEr9RBMFamTfJ2mOfczmOEMvfa1lByk5T9TRz/j4k9kgEbwyRdH4vQYNgCmbK6EGV4yujnSEbZh/qXHi9unxJN6KRIuNrzjBGwIY4X37qVNEUFsPfH3XGJPLZFmqEJQpZrJv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(8676002)(7416002)(8936002)(66556008)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(41300700001)(2906002)(478600001)(38100700002)(6512007)(1076003)(26005)(6506007)(86362001)(9686003)(186003)(6486002)(33716001)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZRdW5nZjlodjF6ZDdiWVllcjFQclM4YVlHdG92VEYzY3VuRTNjUXl2OWFH?=
 =?utf-8?B?YXRlTkRhVlN0aFVBVDFKZTYwT09OSDloUThCcWUrY0toTEs4Ui9rY21JMU9S?=
 =?utf-8?B?UnVJVWlzOUdGRDMzdmtKVzk5MDRZTU4xQmQ2Ym5mZG1wU2liUGpEeU9aZmJU?=
 =?utf-8?B?V3ZlMXM3ZFlMQTcyZkY1YWx2emtKZndUUGpYL1hLOXJweEpOOUlXbFJObE5W?=
 =?utf-8?B?aTMwQXk2ZDE0Nms0OHd5b2FBY1dhcDlNd1lnMHdvd0VQQkwzQ21IblhWWWZF?=
 =?utf-8?B?U0lacHpjVnlBSFVoeUlob1ZmTFE0dENlcGhlTmxRZTJBbkhuT2NZRGdHajd1?=
 =?utf-8?B?dWcwREphVjZFNlczM2RZcGNnZjcxRFBpbkJYK0NqZGljRXFSenhManZuanNv?=
 =?utf-8?B?ZU5xV3dFazQ2cWlmWEJ4ZFc2SkdtaXk3TzZTelMxTjJjZXpPQkpWWTZROHNM?=
 =?utf-8?B?TlpZS09vNDR0YVRnV29CWGwyZWtzM09rM2x6U3NrMU1jekh2VXFBRzBjdGg5?=
 =?utf-8?B?L212U2E4MmExd09ua0hydllFRmlmNUhlQXFPbTM1RjIrTGEyT2gvdHVqL3E1?=
 =?utf-8?B?c3E3czJRaWdpeWY3RmJ1Z0czbjJoWWdnMkt3QUFGNlpTQmJsYmZ4SUx5cjBC?=
 =?utf-8?B?TkZFRFBPdTdBSmVZcnB2dmR5L21LRWUwYzdmQmF2c0xtWldaS3JTQmwvdGxX?=
 =?utf-8?B?N2srelE0UzdSU1lmSGhFbXV3RmRJbGZZZGkvVVArcUtuQW0vM0p1OWtXYkJ4?=
 =?utf-8?B?N0lleUFISEhsOFdjK2ZlOGpRemZoRFJ6R0VqbXFJVk9Ka1NEN2svNVZIRkZv?=
 =?utf-8?B?Y0RDMGdWYlM0RWNCK3hCNkJKS2Ird3Y5VmFIRWxYV3hXbSt4bmNZai9QNlkr?=
 =?utf-8?B?dlVtdDh5eENIVUdXdW5LeTJiN0NVS2twR21tOFR1ekl3WVVhM1IrY1ViS1Bn?=
 =?utf-8?B?VlZlK2Z2L0tqVjRYWGZjOURmOVJOZ0dsYkxQbDB4ZlpvTTZ0eUtPaktsYnpE?=
 =?utf-8?B?ZUZGYnhpa0xUMlZHcG1ndE9DTXpnWTkxdE5HcUlkZ1hib2dLcTB6M09Ob2pF?=
 =?utf-8?B?Y2pvWG8rU09wMnRJRW1PWi9zc3JJcG9VdmxBVGc4QVpsT1BTdjhpVmtvdHM2?=
 =?utf-8?B?RHN3WXd0cmpMc0w1VkRQdk1LYmdYOVU0alErWnZFY0lLNjJEV1FSZjVRS3pB?=
 =?utf-8?B?NWZDMmMzaFNYcmlIVDRuNENlMHVYVzcyOStXSklFZS9qb1haUXVmUk51aWpO?=
 =?utf-8?B?akJsTjVxdlF6NEhIOFlTY0V2Z1UreHRJZUlqZ2ZwVzdPTTVyY2FBR1ZISDI3?=
 =?utf-8?B?Z2JOMlh4UFBmTzFlcmtOdThQK1FCV1ZhRUkrQnhEOHQrUmhxN2pEdkRqVGNX?=
 =?utf-8?B?UFgvd0VrQzVsZ2ppTnJGdFc1YURjQ0lNbitZS1pBOURqSGJrMjhCNllhUjQr?=
 =?utf-8?B?bm1VWFIxbTBhSkthVUl4SXFHMUsrVllNVWY1UGFXdFl2cFBuQ1ZPSittdkph?=
 =?utf-8?B?QytWdGRRakc3WjRQdVFOdDQ0dVlNaTlvdHNUNTIraHFXVGg2RzdscVc1VkNQ?=
 =?utf-8?B?cVVtdE1mbTdUZzhSczNrS2lVNWdrZ2pQeEZldFo2cEZxcXVBRnA3WWV6MmZn?=
 =?utf-8?B?ZS9ZcE03OVdPb0ZjZzgxVzBMMWh3N3BjRVh5SFBSbU5lRVNGZ0YrN2RJTTc2?=
 =?utf-8?B?aHNWVW5QQW1Yd2dXRFJ0TUhKZHYrNHgrVTZoOFFBaml5NENLelRrNDFJd21D?=
 =?utf-8?B?eTVyZDk5Qk40MW43U1NvVldZRk5aT3JmUVBXRkFPVU9kVzhmdUorZzgzcmx6?=
 =?utf-8?B?RmR2eXlGWnVYQzVzZjdsV0JCV0s4dmVWZXRxWnhtRTRQRWJUa1B1Vy9mNks3?=
 =?utf-8?B?R2p4UlhyY3ZidHFxVFZzZndnbHMwY3BTcGtsK1hna2c2TlZ3UWtYbFRucTNZ?=
 =?utf-8?B?RTByTS8wSXlqWGtIdUtjQWJaTkREa1NhZkJMZTdzNGJMVkJvV3Zoc3d6ckk2?=
 =?utf-8?B?N3Z3SjM2eEFReTQvMUJlemRoemNkdUNxTWJ6bWdEdE5tclZWaGEyaEJaZDdC?=
 =?utf-8?B?Q21PV0JUQ2YwZkVGVVdWbUE5eHNKSWVEUStmOHVacFF5SnlkcGhCQnR3aHlz?=
 =?utf-8?B?aE5UM1ZRMzhPbmhvZHhSZ1NSdGZ0UHQ3MlQ2L1l3bnVhSmlVSlpFd3hFWGk1?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QjZqS3RjTC9kYlZOSHF2amhPT3VaV0dXKy9pRkVVUnBhbXdETC8za0RsQ2Va?=
 =?utf-8?B?UG5kaDFDWUtKQ1JrQzVSc2NhaUhqZDJ2aHQ5OFBId2VUU0hucmpFRHh1Z3Ry?=
 =?utf-8?B?OXFoVjR6NktYNmhMVkVqb3NMbXI0eGZvMmRONGRVVURvS1pmbWpXSjhQdEJJ?=
 =?utf-8?B?dmFrQzlyckQvRzU4YnNycFJNUGx6VnU3c3hSdG1BK21qV3J6MGlEaHBjSUgv?=
 =?utf-8?B?Uy9vbk92MHAyb3MvTzVSY1haUHgwVnlmdHV3UXQvQVNkYUd4OUZSZnBnd3pm?=
 =?utf-8?B?cWNtKzBMRnA0dGpBMlRKWU90alRQMkJ4bDRFRjBhQ0lZeGtjQVRyVm1ZK3hP?=
 =?utf-8?B?MDhVSElCRGFwMk11TEtHZFRaOVRpQ3NqSkJnckVjOHNaaTBGaHRLYzlFa21h?=
 =?utf-8?B?ZUh0bDE2RC9TYzlucEVnSmhBdEpGWlk2RW1pMis3aDJFMGwwdVBwRjBYL2l0?=
 =?utf-8?B?U0xSSlhaT1lYd2NCZjU4Yk40SEVZS3BON2VjVjBDK1lHMm1HRFVITjNsUy8r?=
 =?utf-8?B?ZzZiOXRZYW51MFFWaFo0am5HQTk5WDRIRTZSZ2txK3V6UUp5UUp0VysvQk9p?=
 =?utf-8?B?QitQandJOGlXS3dGR2FlNnVlVUFnaW1RdS9iZElDQmJCK0V0ZFEzUzZSbjhn?=
 =?utf-8?B?Zy9hb0xmZFlXZFdiREN0aGlGak9nRzNtVGFZV3lhQlhteWJQQVJsdzNsdFpp?=
 =?utf-8?B?T1U4TmYrNmozTTdad0oxTng3clVKUWRtSkNaM2pGQm4xVG1CS1lscWh2eGJv?=
 =?utf-8?B?YVBLTEFzYU43UFpSOVp4M2t6Snk3N3RtQkJtdSt6MkdMM21QWGRUczJyblRj?=
 =?utf-8?B?SXl0cmZENlYyOEp5NXBuOUROUTcwcHVyeUpybWx1Y05sYVBJOVJ3UEJveEJ5?=
 =?utf-8?B?NVlrRlRudDdqVkRDeEJVZ1BqMG1lRmJoMXJod0tIQkQvUG8yOVllQkVIZjFo?=
 =?utf-8?B?aGNodWZXVUZWMWFyRjFxbGlkNEFEclVBWkxPWFFyN2M4SVFDTS9mZjRIMG9Y?=
 =?utf-8?B?Nys5eWdkbWQyYzd0TGZQOEtEZWxESmd6dlRrN2E5L21wUnN2cVpLKzJITXQw?=
 =?utf-8?B?TmJpMGkzUWRuM0pqeWlVR0xKWndGU0ZsNDMxVVB3TVJMQ1Y1Uk9XZTVnWjMw?=
 =?utf-8?B?R1lFL3RORm55bzdLREw3bCtUeHFGZXcxRGpZNFVZTDRHbWtPUXcrWGNZK2RH?=
 =?utf-8?B?ckwvWnR1dHltWXBXbkRtck1VUFVwTVpxeVBZeGR0WG1nZytKNmxGVVU3WWh0?=
 =?utf-8?Q?8r4+eAuzZ8x5Tjv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c0ad72-edff-40b0-8e5e-08db66c33b73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:21:30.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHHyyTGa9971Wa5A88SCr6gIgRZ3YDJ4PC+Zd249usNZbypl0OD8R7GNce/wAH2eG+PBEVvGGrhLBJQFKHZJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306060165
X-Proofpoint-GUID: PQUDaUj4y2x5F92g4wN56aJgPJYcIVA4
X-Proofpoint-ORIG-GUID: PQUDaUj4y2x5F92g4wN56aJgPJYcIVA4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Ma <yu.ma@intel.com> [230606 08:27]:
> When running UnixBench/Execl throughput case, false sharing is observed
> due to frequent read on base_addr and write on free_bytes, chunk_md.
>=20
> UnixBench/Execl represents a class of workload where bash scripts
> are spawned frequently to do some short jobs. It will do system call on
> execl frequently, and execl will call mm_init to initialize mm_struct
> of the process. mm_init will call __percpu_counter_init for
> percpu_counters initialization. Then pcpu_alloc is called to read
> the base_addr of pcpu_chunk for memory allocation. Inside pcpu_alloc,
> it will call pcpu_alloc_area  to allocate memory from a specified chunk.
> This function will update "free_bytes" and "chunk_md" to record the
> rest free bytes and other meta data for this chunk. Correspondingly,
> pcpu_free_area will also update these 2 members when free memory.
> Call trace from perf is as below:
> +   57.15%  0.01%  execl   [kernel.kallsyms] [k] __percpu_counter_init
> +   57.13%  0.91%  execl   [kernel.kallsyms] [k] pcpu_alloc
> -   55.27% 54.51%  execl   [kernel.kallsyms] [k] osq_lock
>    - 53.54% 0x654278696e552f34
>         main
>         __execve
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_execve
>         do_execveat_common.isra.47
>         alloc_bprm
>         mm_init
>         __percpu_counter_init
>         pcpu_alloc
>       - __mutex_lock.isra.17
>=20
> In current pcpu_chunk layout, =E2=80=98base_addr=E2=80=99 is in the same =
cache line
> with =E2=80=98free_bytes=E2=80=99 and =E2=80=98chunk_md=E2=80=99, and =E2=
=80=98base_addr=E2=80=99 is at the=20
> last 8 bytes. This patch moves =E2=80=98bound_map=E2=80=99 up to =E2=80=
=98base_addr=E2=80=99,
> to let =E2=80=98base_addr=E2=80=99 locate in a new cacheline.
>=20
> With this change, on Intel Sapphire Rapids 112C/224T platform,
> based on v6.4-rc4, the 160 parallel score improves by 24%.

Can we have a comment somewhere around this structure to avoid someone
reverting this change by accident?

>=20
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  mm/percpu-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index f9847c131998..981eeb2ad0a9 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -41,10 +41,10 @@ struct pcpu_chunk {
>  	struct list_head	list;		/* linked to pcpu_slot lists */
>  	int			free_bytes;	/* free bytes in the chunk */
>  	struct pcpu_block_md	chunk_md;
> +	unsigned long		*bound_map;	/* boundary map */
>  	void			*base_addr;	/* base address of this chunk */
> =20
>  	unsigned long		*alloc_map;	/* allocation map */
> -	unsigned long		*bound_map;	/* boundary map */
>  	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
> =20
>  	void			*data;		/* chunk data */
> --=20
> 2.39.3
>=20
