Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5270BBCA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEVL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjEVL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:28:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F20185;
        Mon, 22 May 2023 04:28:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8EMCO006996;
        Mon, 22 May 2023 11:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cDMY2QOKbq9NNmjg4rNkHRxR0p8khGNRqIimm2JMICQ=;
 b=23J5ctdep32Dhs52qlXxYKOcML5q2nelkyYhjMXrOBoyQ5T9x+cZHV09Dnw3+85qNvLt
 OsUUYVm19IFtPIa53Wc8BKKDRZ1mxJk5dYb5qOE8FomnMQpGX5xgnssBGbT02/DEL6nj
 bQFLl8IRxc9iSiijrLFXhlELayKfvmLFUoQ8d/741nGOW8wwZxSdGa+zIJqtfAR3Gouo
 aiaDhQicUVB4Kt3PgHqd/vqKt458ROZBTxGGtPCh6Z5b2TkwGUcbfNzVT5splgJxTnce
 5CuSDbzaWKTBAhFbwkJJl+6rI93wGrJN/++NCJXH2HFUvKhnjICxOw14DlQyDYlD6aah Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44jfpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 11:28:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MAl5lH023588;
        Mon, 22 May 2023 11:28:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8stspe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 11:28:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOBrIV749iX05M1XIaw/3C7R2i+ovcXNOvrAxQTKPUIMnfdlrMKrbaQ8lCasbA+OAv8AeDJxGBugCANPamaEPNlk14dmYvuiviMIm0gXsG2w9oRd4xqEsQV3LHNaBUUvF+OWKkLDqSjW4fiCwKJLp0pMz2pnn/P6J/NJjeD8PjsLssALfm9eNkgXeYqmAEow3yk/I7btKGvZY9uI0gZ8Zhx3CnxuL0gyi4zlTOlfRqjSqvrg+NdEbALGx1ezR6gwFnuc0EgK0y3ROgvnRlbQXJOIx4SI9usEhvI0Hm7l7P1VZuGHmTIpTGqyiuCaYQ3Zo+5Wf14g9dWb6hH21fBMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDMY2QOKbq9NNmjg4rNkHRxR0p8khGNRqIimm2JMICQ=;
 b=nc7AkX7ACGt01H5Fjlz2I2/6GQe6B2I/l3fWoJ80429eZDtztsE8ZLO8qDb86uIQAcODBhedMz07/lZHwixYqyc2RX9T6EtESK6udsgqbTfu67JWSxbZqtZ/19DtBAR/yR/YXeXfRmtGzmKuvALsiiGYBk+mbxLG8N+yFtMUmQMcL7lgEKsvxsa1yTubKTrmblU2gtK1CNFSoiat0giKTaOCPQaTZ0Ksh5OC51s1BvIFGV6MmHaqeG8hMw8jbfs9rjnKsxfkYOuxlCEu6oslgg1JgLP23dUIvXe83Dr7+VALjo11RZNUCyaop5+OS1khVkFDWtZyB8UKxGiE0s0iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDMY2QOKbq9NNmjg4rNkHRxR0p8khGNRqIimm2JMICQ=;
 b=QTBus8MQQlEEJyt3woXJjLg9vglwg9XptzbYkDX+SyaplIvpa/V16NnPPvk41qeNvF1pSk5yF8jrzewTv4BJuLeY0Wbtg115YAjueRRHBJGxAWtveHorEBAefbIdXwHoK51XJf186xvcccNBfVq9hYnkUyW4XHa7WBk8Bwyh0nw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 11:28:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 11:28:14 +0000
Message-ID: <43d5ba4a-efc7-09ae-74dc-81b19f635a19@oracle.com>
Date:   Mon, 22 May 2023 12:28:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
To:     Jason Yan <yanaijie@huawei.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        yangxingui <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <02d36ee9-cdad-454d-d822-95442d7bd67b@huawei.com>
 <f4ba7a92-1f00-c254-d196-7d21fe14dee2@kernel.org>
 <938d6b5b-0271-977d-f046-5fd70d29b3ca@huawei.com>
 <a5c2e157-aaf7-1300-3fbb-1300ac216cee@kernel.org>
 <68953040-1622-254b-f6f8-b279eccacfb1@kernel.org>
 <c88dcbc3-d530-3e9e-f674-a2fe64ad5fdc@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c88dcbc3-d530-3e9e-f674-a2fe64ad5fdc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8520a3-aaef-42a0-3b91-08db5ab7a200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB9pnpDMZCc5MN95ozz53fuQJIzy+pTjcd2P7h37pIQ31P4mnKW/DK1Vg4jZPjBkkpEVnkeNGVvmD7DEOaR0uAv3f8zLnXLKtkg9s8Eb87lSSHdUPPP0Jb+HkPjZdOr3h2n77JOCiLdJA/vlFGXm/APhW09FDr4L36hh4QkZEoUTYr8l9f1fALxSYJbeRKO0wwoDkskbOOgm1WyzwCi508QTuNUW5MToLxEEhsS+hRTJbzJttagtwiGI8tH/75e3HPQT3MnfTq5xeGjhrHrj7g+OOdvbuVj9GQfjjWoFbzoWb+mFmCahr1UsfeMJ3xlPlq0RF404YeIMIZMl5GT8l9URby2/3L3AOmRZVd+XmMfLlYSL0rmAVBBi/NtUFP/B3ehzbKk6njc8R/sRLPBD6ASvECRLMgqbnHcb1a+DYcMJBJHf1sciyHaxUp5c5YcKQuCEKvmItyp+zgd3N/fpLb78R25Fg5Kcbp2bmhM+uOGZ13pGhEeFxK0WF7Bc2pjQjmXY5CLoGLXNF0ZYcXPApjZmf3eeb6o4Uu/megB4inTThZyP2x4kVLcvaHVMjmUT7xlv9Hpbe5U4Hm6v641iqTlUXDlf6S76u7REyQHWClq3ULE7b5GxqMSCfHeP+M5CJ/awNFsPfpdEokJ7Zus+QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(110136005)(31686004)(38100700002)(478600001)(6636002)(4326008)(66556008)(66476007)(66946007)(66899021)(2616005)(2906002)(6666004)(316002)(53546011)(186003)(26005)(86362001)(6512007)(6506007)(31696002)(36916002)(41300700001)(6486002)(5660300002)(8676002)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjhoVHFIQ2ltakV6a1Q4VkJURkJSTS9LRTBFcEdOampOWGlVR3lWazRBc3g2?=
 =?utf-8?B?c1JRdlRFOEpUNGR4aHV2cjkvSXhKemh6MDd4ZjF5VVIyZElqSDExVHNOZzhF?=
 =?utf-8?B?enJkaUNGbTFKbG51Vk1COUZ2RmJybGg0ZmhVeGtic2tlWFhETjJhaHJ6emY0?=
 =?utf-8?B?eERmazhHandEV0huNjZIZEgyT3dGWVJNeWV5VThObi9SVXE4WEc1VyswRExo?=
 =?utf-8?B?NFR6ZGlncUphdVp1L3ZLSVlXU1ZuZHAveVFrL21VRGYvb1RFZ1Y3aEk5UjJH?=
 =?utf-8?B?SnRhVDVwYkJyaU5aNzcvK3VUb25rVFI3TU5Ma0NmY050dFM2NnMvQjd6a3FI?=
 =?utf-8?B?ZXRsamo3U3Rqd1BBNGJmQW9hWVlJMTFlamJ0R3lOWjJaL0RydjZXcXo4ZlJ5?=
 =?utf-8?B?UDFqZERORVJ1RE1YcG5nZ3hEY3czRFFOUU9KbHZITlA0UWtjQ1d6TmRXdmFm?=
 =?utf-8?B?dm85c1lZQVQ3NE1tLzB5Z0V1UmNNKzU2L05YWHJoQnFIRFhTQUUrQlk0Rm5r?=
 =?utf-8?B?K3RxSkZIZnFlRDVRZkY2V1FROXRISnRWVnpUMVNYRE02eTRHc0JHNEc2aUVL?=
 =?utf-8?B?cUw3NHp6VnUxdE54L0tuMWJIbCtidVBka3dsN0JUclRGNzdBdTF3RDB4a1ZE?=
 =?utf-8?B?Q0RSV0YvaHRkd1ZNb1RmWkxQbHkxYTVGZW1NVUpkaE1WOThLbGlVSEQrVHFl?=
 =?utf-8?B?MEJJSnhQVU1FTmR3OW45WmVlTUZxcjdNcTgvWjhQeWoxZDJWZWwzd3k1WUZv?=
 =?utf-8?B?RVJKdjduWEFQQTlSWWFmSExacm1vWnlQNmg1SVlGMUlaeHFsWnJTWkh4VUR5?=
 =?utf-8?B?ZFRZTzlUbGdDd2dXbmdaV2RCOHozL1hKbjFkYnZrU1dxeWo3SFhVSHJ3b1BO?=
 =?utf-8?B?aGtqTzdXVUVHc2JEdWQ5eGV5RnBnSWlvOVhwTDVhQkx6V21Na08xRmUxY05J?=
 =?utf-8?B?Vkdrd3RxaDhQK2RHN0FQcWI0ZzlGWnhrLzZ4OVd4R0RaZzNNZFRPd0k5aU10?=
 =?utf-8?B?bCs2QlBybXkyR0dObGxBcVBLTnd2bk1iRHQrNHFzNUFNVFdwQXVheU1tZlU4?=
 =?utf-8?B?UXFtbGovMzdWWWJVcThuaGZwUzd4VzZ5QWNGZkdIcUo1eTZ1MnVoUjNEd2M4?=
 =?utf-8?B?S1AzdjlyUXhudm1YYmVBUS8rMHlTUXJBNzNDd2s4dGUyK3lhVEQwcGFJZHRm?=
 =?utf-8?B?M0ZFVEF2dU53SW9hMmtxYTB0am83WUVvYnl4VktTcGJxYWpaNzQ1WkJaQ01U?=
 =?utf-8?B?VWNDQ1dPcjNOZ2lVL3NSU1I3ZzJUN0RrNmlGMkRFMHZEaGdMMGVLR0Y3Y3Jm?=
 =?utf-8?B?NlFzWFFxU3c0dE9qdDI5TXRRUkRhcXkvRERWM0FCVElUTExleHZnSk90RHc3?=
 =?utf-8?B?SHErYzVMeFA1K05yWVJyUXJ3YVFjdWJ6Qm5pTVpJKzV1OCtmekRDL0R5UGky?=
 =?utf-8?B?ZlNIYXVFdllaWkN0dWptM1dyblR2R2NjaFZhVTlobWV3QnBMb3VpTzlWdXZK?=
 =?utf-8?B?VzdHNGg0QjhIVGxnOUdLbXp5MGxFYlNPZVdXbTZHWnd4WHpWRXZCTkc4UUI5?=
 =?utf-8?B?dWpTNnkvRExhREYwVTdHRU5HUnpvZ3IvZ01TRW40M1p3Qi9qOEZjTVQ1VUQz?=
 =?utf-8?B?ckdGcnhEKzhLRVlocFA0eXBjREdYQmQ5UnA2U1RQSlQwcjdGT2RHdkU4MUFC?=
 =?utf-8?B?ZmdzSEQ4YndLSzY3MFJ3N2VQT0VsbDFyNEdHaTVyTDByNGpYd294NTI0OXo5?=
 =?utf-8?B?VXhxMG5jOUZLaHZMVlQ5bURPRjFTWlAwZ3VXcnp5dnZSR29SeHY3eGRyMmx1?=
 =?utf-8?B?N3RxdVluYk5ienRzQk9XNy9zOHM1MkJxTzdpNVJYeWFoL1ltaC9YMXEyN2hJ?=
 =?utf-8?B?ekp3UmtPT3pveUlqTGRXd3dTblpLaUlZcTRzSE5xT0ZsQlZneWFKbjVaSEYv?=
 =?utf-8?B?bnJLemZ1NU5mcGhSYUNtMFV0QnlBVEZPdHdIZm9CS2Z1NlduTHMzTVV5dnR6?=
 =?utf-8?B?YWZOR3JjbmgyWFN2YUkrWGI2anhDQVBML2xaRUdGSXZTUG9raFNrTmtiUHRL?=
 =?utf-8?B?Nk5Ud04vQmNZUkI2NElrbzlHa2VTYm4rMzlOL01nQlgvaEhONDJ4Vm5BSGZL?=
 =?utf-8?Q?h1vm1WjJF3scOyAqrBSVf4j2z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2GNq86UVEcWunqLJKiV7zS9nvAsqCsZnXx+9hCVP4brNfo/aapYNWLtVjraTK0yHGb722NDvxB4MLQuBWvN4Z1kRTjzA/3Ck01oFqgnZ2yCyl6Gabq7dfWtkNp/MavhAYOAx9FyHkX5k0kTmzCc7a2tyr3lqZ53S9M4JMcg5+GH+F8KirU/iqeZ1F4BUUhqQT6d9gDYUXrGmGGKqQCdaCarFZEjbeMez8PckIGVLQttNcNqB31C4NuFOrpPIG4XTkCjaoI39EwhfpsUJNZgI2/uaSSrDffsDYBcZZQqb/ISM3h/PyXgtgtb++9zXWiRxvRg2eejzn2F05CvWJtAttR7AWeRrBNU0MmbXO7+Mo8OAg6WU0UrPvjbJngk5VgMtOGJg+8l8zPhTDndZO++8veKtTBfwrrWKsL/yz+h65GPTpunY+piooL8Ta9zuitFm6s57VJy1y2vJOW4535NaBHsEIvFHXj/uMgVOt4W0KXXT7nrmUxrMAecFf8V20PQLxRqnQXpK0I+5mKFcnc67s60aVz9Ff5AiNnG7t062HV20ToCAN55lGI6b5RycYteUVOAq3uSC/9UT3sOxQFjz89atq27yJPpZ5e/pPIt/hVwPiQ5+vEQ4ke1h3F4IgNpMI5fJkm2v8NW4+RNoJNdGBS+ykG1jSL0MnalEu5l55tZetLtYIKdPPx07H2tqXJI/4J90NGVh7ZI9Z7YrPJG5cbJw/MOYnqVzqUY+NL4/7gS99MecFVZD/NpSapKM1ktCzdhIaZQdoFBf4gKHn7sBn/cEFfe4WtwyjGRlFEgcqwbbA89i41msK8WIxWX2UBhpIAog/If8PsO5LuUAdENgFikA4Y50sq94kSPqxO4163o6DYHCNIbWE224ML2Khfgpo5LrAO5g8V7sviPGyt/vnw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8520a3-aaef-42a0-3b91-08db5ab7a200
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 11:28:14.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cauGcG1Zv7P6uOtKRgwRH/72L1dWhmozybF3TAquCaWw4qooZL3zSiJgeULly3vqdmVtXnocPO76sh5w7WXl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_07,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220097
X-Proofpoint-GUID: vjyzvGlB4Lj3o86hWu3l0keafvGM9dx0
X-Proofpoint-ORIG-GUID: vjyzvGlB4Lj3o86hWu3l0keafvGM9dx0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 09:00, Jason Yan wrote:
> 
> OK, so the issue is that __ata_scsi_find_dev() calls ata_find_dev() with 
> devno
> == scsidev->id. This leads to devno being 0, 1, 2 and 3 for connected 
> drives

This numbering comes from sas_rphy_add():
...
if (identify->device_type == SAS_END_DEVICE &&
     (identify->target_port_protocols &
      (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA)))
	rphy->scsi_target_id = sas_host->next_target_id++;

..

	scsi_scan_target(&rphy->dev, 0, rphy->scsi_target_id, lun,
SCSI_SCAN_INITIAL);
}

So libata and scsi_transport_sas just use different sdev id numbering 
schemes for host scan.

> sdd, sd1, sdf and sdg, as shown by lsscsi. However, each drive has its own
> port+link, with the link for each one having  ata_link_max_devices() == 
> 1, so
> ata_find_dev() works only for the first drive with scsidev->id == 0 and 
> fails
> for the others. A naive fix would be this:
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..e4d6f17d7ccc 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2718,7 +2718,7 @@ static struct ata_device *__ata_scsi_find_dev(struct
> ata_port *ap,
>           if (!sata_pmp_attached(ap)) {
>                   if (unlikely(scsidev->channel || scsidev->lun))
>                           return NULL;
> -               devno = scsidev->id;
> +               devno = 0;
Would this pattern work:

ata_for_each_dev(ata_dev, link, ALL) {
	if (ata_dev->sdev == sdev)
		return ata_dev;
}

If not, I think it's ok to have devno = 0 assignment under SAS_HOST 
flag, even though it's far from ideal. Not both of these are not 
preferred, then, as I mentioned before, some per-port callback to do the 
conversion.

Thanks,
John
