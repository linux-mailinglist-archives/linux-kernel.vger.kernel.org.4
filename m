Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7A613EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJaUMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJaUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:12:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E0100A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:12:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJev3X026899;
        Mon, 31 Oct 2022 20:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JEV/0tVu2JduN9jMAeiHSmjy+CLXQn0264sxelnUB8w=;
 b=LqCNtdtEWr7FoFWpwES1zSuhITiEBNz0+Vjgqym7CLde19O/Qj73uAgaz7EBuDQDSvjw
 0cLjuI0o5gjV9caZrdmK2x8xIPo/1ePHp7gZO+XdVXYump1uBVG6TuyaNdtBvgNbU9l5
 gr1gYociPfrX0lduUVmQo+smBBRgTYqEBFLyUmGofVOzj/ofRFR8MFKhGV5B2MEqmPaP
 hwkD9Lt2QVjBWdJCqyL0SeQdOfBDHkv+KJM/iFa0Lp+VREQ6V4r+KnCvxVd42eZe3uLh
 KM26GIZlPJepq3NllsL+FHOUIsIhiM/E2aAYJk65wdaoAMzU/zOG1bxyYEyp/sBWQ2Jr vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts14w1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:12:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJP5mr025881;
        Mon, 31 Oct 2022 20:11:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9y5s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 20:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE+Svz9OKfiRGCLEI8mCNkwAhIrUCEJUG+vI5vs15LfpzmSyksWXkXmv0cnK3A/XH6w9mKJz5ttHU/3+SdsDqRxAk2AQtlXJT6RcekveLJXEVqQZVyyzU8ePfdRDII1fVuXYM4N6ScIIpIXel5nSNufw+KhSYNXjw/Ttmy0+UmB4Gl9iDDf7mVgL9jicoZUzmz8Xn0DtohirxzwqX9SLsPNXw/xibCGKe7IjyPKfiwvW/QGZ+8FxjPb2/cvJaSE8wa3sO6YfFWxAeFD2u+udhVis8/pzV5oT11i3pbcdLsugFLopBUIN5eoyukfF4xGy0YRtDkiN+Z6AGQgSOo9RaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEV/0tVu2JduN9jMAeiHSmjy+CLXQn0264sxelnUB8w=;
 b=Rt+UZXmI7Pjc01fumAUNOklkvbCy0oGCNOWRjzKiQ1Sm7ywTmNmNgDZAnmlTb38RTFBZWNpNGZn/Uo5AGWxnlwzjBpkoCnohS2PJqZNkj5dnjBuKvSNf5JJCsuFDkmdPPyAEuolfp9E2Fjoh1Mmp44dApFJhj3nVNz90cvCTM8/t5B4Zl0kT3RRZaNkxnkpCHOLmPb2HErE7Ywurb3+KZsqOYgVCyf78qfxIR0NMqmz2dDuORXdQylZKLO6w8rdmJGSsYiQw9ibEBc7hhpf3DM+v6QfTXmsvxsoLJivlORhkUOJiHE5zL6k5jxfqtSD/8lrsYRVxzzqlJWX9aPD4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEV/0tVu2JduN9jMAeiHSmjy+CLXQn0264sxelnUB8w=;
 b=NyMQktV+nRoTjnR6fIHSgZGE3a2Qq6+KV+JlwQT06vWf0OcOxiW6A1GLaUJJKw2Km1BwvItAmlzNnovjU/Yu6ePJBqIKPX55qlbL4SVgSI+T/jqvsnc6LMC1bpNqIvKIrxa93CNYlSxjdgrZsB49v7pIWu8/IHCsndeLrzX3MNU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6388.namprd10.prod.outlook.com (2603:10b6:510:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 31 Oct
 2022 20:11:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 20:11:58 +0000
Date:   Mon, 31 Oct 2022 13:11:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 7/9] mm/hugetlb_cgroup: convert
 hugetlb_cgroup_uncharge_page() to folios
Message-ID: <Y2Ar6Xl9V1jonaWJ@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-8-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-8-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ca33db-ae68-4ad1-4cc7-08dabb7c29d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWb9JnCZyxkcFUDzCQ7i6agwWhMu1rssPSxEf4x4G4kK/ljUVquEUPJTavTogZSlyQhVqxtRtx6hb9g7on9d9HzP+GHMPqbAcndbFvmOJKuRZ/mtyHhkmZa5BVs5ymuMPsFrG+yqGep7UDFkQ2xJZYJd294tBUlbp+ftutldDBCHeyiqm5YUink2CzYpJsd2lEChtA4yr5O2RCPE89BlArOUcQ3Dyoi074IK00V6jXy2qK2WH+NsL1jjfP8KyolP3L2oLdfqU0pkD7WFejQ9rw1gQat/WgiK7L9I4I0Z5K5n+N2sQBKrTk+/pPb/Je+1HIJyjmEq4TxFX6NeQXZGX/2rZOk1od6iZimivvoZjFg0u1aFDdIKUIYRs1V+nKjgdYOVtjAKEJ02D1838TlUiDG/kyr1JNk32i8UJKkn+s4sZQ9N+/1YaIdPvCYJ0RMKuu89uTbZ5Cv0XF/41KS7LCE6cWW1GKQUKzTK1J0FWudAyQvrvZcGYP3TpHUT5hQJ3KwGPieR6rmKVkhRtQ+irJdsHsyNPojaBgH4No+Mfu0scdYv9opDMnD8bd1NoPqpBXOJlgBonhM9e/YMrm6q1Ect6lr0YPuBTyfCPD6oGLOEKlYrAbIcTrqviYZ7pkCOvtPLuAQWDbFnnXqhwCzO6e/S1noq8P91ZQ9z0vrdM0WJOL0mb39hc5XiNrcHg1h9a4Fh//DOgFUVjGNgy2x3Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(6666004)(186003)(66556008)(38100700002)(4326008)(44832011)(2906002)(83380400001)(5660300002)(33716001)(6486002)(41300700001)(8936002)(8676002)(6862004)(4744005)(66476007)(86362001)(478600001)(53546011)(6506007)(9686003)(26005)(316002)(66946007)(6512007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buUM3CjMvbv/DvEGFWK1bEazEY4tpHoXu/hZLVmZQHuUiTaVvmJ9dxbZbHFk?=
 =?us-ascii?Q?sbJtzm3l/d3kUV1AGZs4b/qR7+8gB+Y9U66CscTdo1U6MwOqylV6SqzRs/qj?=
 =?us-ascii?Q?1Y+KJOyf+rX/iRjGj4opOlHs0JpimVhBwvBOoVuaRClJLyVlFtjxgMCJXHvu?=
 =?us-ascii?Q?4qy89lY39Ob6v/H6Vm8yS+cMj3b8zRMbnIvbo3fOHKvMzPqxouVMx7o5oVL5?=
 =?us-ascii?Q?HnngOQyUnN4dcMdRE2c5XNe5ev7FZ1K8Vr0lWBTUPrnmx51sQ7ObuxNJ9aKa?=
 =?us-ascii?Q?K+T/VtAUApSBiLYJCxeqwboQLkpCsJ5bxOImlyJ4dGiUedOrSq6AUHXD33EA?=
 =?us-ascii?Q?bUIN9zAFYXFuWXHwDlS4mS5Wl5Oii/omTvgoZaCZ0l2Lk/YpwSKR+R8GhUuv?=
 =?us-ascii?Q?avRFOoVt8u5rGtodGCojXl3ozbGC/K9D7YrxiH/KaYP7DLD0RBXXNT06BJ4S?=
 =?us-ascii?Q?QsQZsviBdWegRhtL7eAqGIvrCwHXW4sasOTuX5hikjI1BRLyY3//Zi6puzWZ?=
 =?us-ascii?Q?K99h73n1MC6hFaxl8Pkr8JPrJmw+641ZHap0FFBo/Pw0sasIFEAtayOVa3uC?=
 =?us-ascii?Q?qd3W6CnlviBkZcM3HdFvpK69NJzVwPdWEVzGUkIfTSvEIp3ooUL1ZaGzj362?=
 =?us-ascii?Q?ZKUibN1K5t57m0rltSxmhOm249wNWZidfCZTG/VVhUmE1kpO8cJ54JqYnAiM?=
 =?us-ascii?Q?Et6DxS4J/ZCO+RT2TxNBJv05TFnjeNfPOZ9moJ3SR1GeDNqk2uXVIyvXTPXy?=
 =?us-ascii?Q?kEHr0VCb4paTnD0AderRNPtJIvxKxLlljU+bDBCgWRhtXv87vEtp+yzm9+0w?=
 =?us-ascii?Q?dWb7Z2bV6Ji4kgDlA0Z/ZST1SCJfW/AIFwzQI9hEQf5eW3BF3yAZThMcUbhJ?=
 =?us-ascii?Q?RQlyTeslY3IE4ndr7kGJTfSDeOyDuP3YR1vcELUh3YU490b+LtoPXky+tt1D?=
 =?us-ascii?Q?9LVKm5U0kWXqBGrh0xwwPYysZqDeC6VS77/6zb1+tG97dxc9UEN5U6s0VZOc?=
 =?us-ascii?Q?w66oaEEYcBFSAF2jBDxfxZirh6RwQ07FgXx/4VXQxkGeVuTmJRT+ViqRJ/wf?=
 =?us-ascii?Q?5xNEgZT2OBPFAglvc7w4Ojv0GV89MIRa6X+jjCxvHLore9EKNhdVfHCYZFHE?=
 =?us-ascii?Q?/O3uRyipk9fquDMDnnI6RSx4n+oe+scRtAcYRgbBoSmx6GA7BPABtpHecqG5?=
 =?us-ascii?Q?fkulU5RyFCwVrWwpHZrt6Ard42p/qomFyDrTmvSV+qLE4+UsoasueEzi34eM?=
 =?us-ascii?Q?KiPlscl9Dg6a/RoHnSNgyHeIMoOsEC4B12tEFY+CwjryaO7KV43t7ubW8qrT?=
 =?us-ascii?Q?y8P+dMj0Xv84EQ8Zql2NfGLU/BpcDNni8gBfOmslKHnSUR30huDpPlrfuv+C?=
 =?us-ascii?Q?YW23ax9IAg5OvSPi4EfUAheivXcQqMJuFvH+GTNR5ur8CHRhdFHCER3iKmMV?=
 =?us-ascii?Q?TrxnHk7BFl5qWsIWU2BPl7is87OOX6jMwyMbVRWxkwl8eQuxuPC+yrbEoZkC?=
 =?us-ascii?Q?/vK6h9yUOHXuN8tZHxtzyVVQ8io1UJSn+sJKbuy2JrXH1l7Jo8Yi5zc6RTBP?=
 =?us-ascii?Q?9Oy/TUrGQmS/zSQUJyq1BQyu2FKu8FIafCbqIfRVl7HtI4x112RFoqE5JFI3?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca33db-ae68-4ad1-4cc7-08dabb7c29d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:11:58.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMiRv1QwsiaVi45zFA0aT/vkCgRFdnEpIWaZr76KCCUhuPteiLV0Ca2tRUuBWWlHxvMumXfHCRE3YScIuX9Lxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310125
X-Proofpoint-GUID: mV1dWtaBU1bXywvJWw84APkDMt2J9-HM
X-Proofpoint-ORIG-GUID: mV1dWtaBU1bXywvJWw84APkDMt2J9-HM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:13, Sidhartha Kumar wrote:
> Continue to use a folio inside free_huge_page() by converting
> hugetlb_cgroup_uncharge_page*() to folios.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb_cgroup.h | 16 ++++++++--------
>  mm/hugetlb.c                   | 15 +++++++++------
>  mm/hugetlb_cgroup.c            | 21 ++++++++++-----------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
