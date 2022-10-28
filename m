Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A461174F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJ1QQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiJ1QPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:15:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCC5073D;
        Fri, 28 Oct 2022 09:14:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEiEkK030134;
        Fri, 28 Oct 2022 16:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vc6iaFN+/ril4Gi8tLqCKU1iEVAcxVCYY+gh7l8Z/ZY=;
 b=OJwqMRnBicjFHZBvHwoGldsoZb1T8XuUhT4rIWUXOWOSkvvyhH+Aap+eIf8nl9cZm6Tk
 VVpckIgfSP+Xd8rhUe2EYj7EO+MZvgbhiiXLZ1VLClCs9urUtSrCnMpWyNdFFuNJht67
 RLQXYOkmNAHC+8eCPlbhTRL0zsPtGWQriP2BjIDLmE67nP/8xGhd69ydXKUQJnnKBstj
 IhvCGyk951F13zrvrxniCiWl3HYlfaR5HzUfUdJJrlJKeIuwyAkl0AfFaa4KuqXNDG7r
 FfPDbCkomGv8OZR0i727+pKdtEopzPHRA9eIi/rZRvQ1/fSEkibl1tySUa9j46K6Gg+h 7w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrwgtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:14:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SE7NvP017461;
        Fri, 28 Oct 2022 16:14:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghqf26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma03i/AezyH3musHz4aGSckvahdW4vz3I4GPAkrFgCV2xM/SIqtOFu0Sf8kRGPGXIfQy3nNJhWRU3Pv8xo2HqIvAufeo299AmojG5CwWaszVpqSj87TpnIiGZ7AajipzyrejgW2BS60DBFoXKXwQD4cziIM8HxJf2c0ol3d2+xjEpdg6mzivBsd/48YNrXPZ91IOOkpLdVPSudBeKH46ens/mRoCe8zy0+LJAGGD7K519N47MTYy0JOdG63zM2evIt2N0Rw2tldVtCZkiRjFBzBz3yRCseEwjYyITR1S5XRx9VNHFKPTc6gVHXsyHt2cTsYoF4NVV8RNfaKbzj+Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc6iaFN+/ril4Gi8tLqCKU1iEVAcxVCYY+gh7l8Z/ZY=;
 b=ZvpST5T9TV7rTMDNwrRF1wLQsLQ9LS1BZLaGrAvmAaa487iagVpiVVibLHkQmZ2i14RajypXTMODyTXyAmpMHAMcpPUS1d+oShcqSw3OZy8HpofnI+IW5NK5uI2PtgjY1jWBvOnA2H7LRFRkQWPEZT9ydTr1Ps8+K1LcpdjJzMeLN6S2yu1LPw+SuzXWWL5mGgTZOMmlrtuPWKGLihlSG8cf3LyOhce5F2tpIQtAH1+UtBAJfNEHtgPL271Tn+4b4tWD9tg9BCdt8BOfA3ELRPwNStpOSfd09hkrCXlbYclKFOlEvsyOEjm9z2wt1CybPZZ8miZIx+tLktu0Vv3YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc6iaFN+/ril4Gi8tLqCKU1iEVAcxVCYY+gh7l8Z/ZY=;
 b=u4CF1h2mtVIJsE4edcxBB24n+nkNPRgyi8wL9MmL5sE9gP1JRoJWD52XMTD8lkN8Z88gOPm7gcqwQ4zu0C/GRUR1lfdmazcsxEGRDKXa1I3JQ7urTICZU/wg7+8ebWoptAIzsfYrVHQYQ+OFE2BmvqXS462D7hN5sUApXXt6tKo=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ0PR10MB4813.namprd10.prod.outlook.com (2603:10b6:a03:2d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Fri, 28 Oct
 2022 16:14:05 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 16:14:05 +0000
Date:   Fri, 28 Oct 2022 12:14:02 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] padata: avoid potential UAFs to the padata_shell
 from padata_reorder()
Message-ID: <20221028161402.rh2p6feok2kjbjuq@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-6-nstange@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083708.27138-6-nstange@suse.de>
X-ClientProxiedBy: BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::24) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ0PR10MB4813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5250c7-ef25-4cc2-0781-08dab8ff6f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XV4b+MBa7HozxEz8hcsBGNpMklQtv+GCoWdquonVkYhB/M3fN3T2zc5U8I1Mm82+KdWEhyDrDHZOK+BHZjaGlaXuQUvo+TvsaP+Te+A3SeHgmYXk+6Q4YggwO5QHgI3sEotIJNbk5RY100noAS9nuAA1LyV/haOFAluTcdEjNG6JBIWLP11Nl7dhctmydXXWpWim9M5nLjVYkwhy+UU1DvLjQIlAZAKohoaSUw1rrf/6fxBW1ipTB92k2EOVyADXFR9CVgqQ9OVKdp0K/vhcC/hrlDstms1cDZQZCoUpMX9nDN++D536Ccvc9syTQgez1D5pqfEfl9iNK/eJ1/A+h/38XLA+yM5ws/1iKxR8KZD+FIfmNnYctA6pdJzQCkzvBgjFLnSkM3hPHSa4on3YnHcNjlaUuuI+DndogGUzvzxepeGsugVyLTaq2PxlF5FrjZ8CHWh0fyDiUQHLlKpgszsaODK/ko0Z5pJzAlFpkSolXHF0iDv+rEDxI8/emQsgAs/mae55AoVEcZps54ONEMbqMx8VX1WLuvynxIVuu3vql+5zy4fOJzghPda22lnUCy4LgQr91mFmj1LU6BI5ou0kxtsMlpQxxaRJjSQG8HAwufPbCivLKaanQiZC++IhULDvKVomkLTb+WRUmch22VprlcNz+k8Otscdnz853hW1in811QFEl3g2TpiGJldWsK4dvwVWuLCjyWfZz8ttQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(26005)(2906002)(9686003)(1076003)(5660300002)(186003)(41300700001)(8936002)(38100700002)(6512007)(86362001)(83380400001)(54906003)(6916009)(316002)(478600001)(6486002)(6666004)(8676002)(6506007)(66476007)(66556008)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzJx5fWJVDTboQXWTKE1xef5hd6XYo/uxfOBEeSzqkjQ4kKO9g5qHA5DKoqG?=
 =?us-ascii?Q?Wue6Qbqg+VTMBbHlzv6FqkD0DRqjqBfFbv46yNRA+TskmZzW1PRLqrjDKXYo?=
 =?us-ascii?Q?6g5aQFFEQ9eLyyrVxNfULSqzBt7/xp23FUYo2TtDmYzkS3WCU8t8aEHIE5SD?=
 =?us-ascii?Q?L0ZodkZ+0zb4ehIUnxZB8odeV4+1fcfZlkQyi4yrhfDXxU9i8PFQJM9QFhWH?=
 =?us-ascii?Q?/B/Z9bFKcY9JDEwxUGxukQXmJuGRaIDKZkTisw5yygaXPZ3SzPD5a0iyBrhN?=
 =?us-ascii?Q?BR8NGpWq8G5fu1xbkV0/3F2KK/FYez5SDePpJg4l4Ewadcbh6E/3bsI4LCfd?=
 =?us-ascii?Q?elmkIF4lGL/jRwhJnU0ThUWpNAg+qcLA0Fe7+26Otr838N4DleIq1llnagbC?=
 =?us-ascii?Q?VEzifiKcLMT68h6ulU811aK1W5iLQPzIVcaNT2ElnJiuLVUMTQJ+p989SOHl?=
 =?us-ascii?Q?LNmIsf+NMLlMgfZn+xDcgdliFw8b56y2wQKLx17tZdFqo0nMTgcIQdfoqlyC?=
 =?us-ascii?Q?XFNKRR3H2uORDeNH8IiBYNSo3BGMji5kZxBdII/fnpRCw2PggJg6NMryzMzk?=
 =?us-ascii?Q?1c7gyggt8tPSsW9KGTzXZb7MDoi9DTRlXEwPAOW+L5dlVluGwM/P0ap62giY?=
 =?us-ascii?Q?9/xMPCHM05NHWOrZ8CbTo2sPu0e2aDY1GWhuM/pBb3weGFPJFmjjUH0Gfi8H?=
 =?us-ascii?Q?mKLvqqQeY2PE3PSN4yxTKZNmlcl3bXea6h3qLzXm3bThEhlrRtA6XmRDFgMz?=
 =?us-ascii?Q?EYV86OSe7opfUmjxhHOyoz4RlKdGx9LVbDxuaXicoBw0AsatvdiPJwvN8lpH?=
 =?us-ascii?Q?dTJcJcZcGRMuSzc8V4iwFOVaCxngpnEksVMl1OCRgLj5zhCfmWnxqYgARkJn?=
 =?us-ascii?Q?zKZSws+Cvc/dO4J3VDX29lNFRjZwvF3kQAzK9tE9ohWReBPMmXpgFYYx8EWY?=
 =?us-ascii?Q?36NWQoauOMP5TZtvsivhP0GU67piij/eayAKkCpeC3KTGhMcZOcEi9b8ngmO?=
 =?us-ascii?Q?OQdsVTquFJpQqc/7mC/wytjUPfv53NyoHVweBlFuAaQJQh4IKhHaFdKRsBiM?=
 =?us-ascii?Q?t50nZhiOPGUK+A0owAZJFt2GAJqn6KY5ySD7i5L7shCY9xEqeBzMVuivgM/S?=
 =?us-ascii?Q?GiPip6nX+zzfQiBI+PKT7D2ITQ6hCuYK2pjaykntLJ4guEUsMTUWFc2C4gCr?=
 =?us-ascii?Q?S9xzjfosx4PVuchGlUDbVPQPMjOKeeBApiaEv4zIopcOoV1xoYb3xp+2yYlM?=
 =?us-ascii?Q?6yNIXIjnlFmGcjnGgMKSYE8IDNcO13F5Oy3v6CviCwdU2d3YAEdOPY7B6NSx?=
 =?us-ascii?Q?ZKNbQZ5+Sz3er7lKf7D0OLdn68t2tksOIHA9HvnctzVWjvQM6fUpKUL4o9D4?=
 =?us-ascii?Q?lIcAYHUZG7yZcNYHFQMeBMQgbGKdXzKByXVrSWAl6wgC+1CWB8aLITua/Pnw?=
 =?us-ascii?Q?rlAj4g8B/LAD2hGoYYKlAE+zCAXWIuj1ZdG20/8f+EMjJZ/+t4LrdkB7c5g0?=
 =?us-ascii?Q?L6cKKrQVYjHsVQ5/44EHjRyvYt7Si7kHiJOQiIy8s76XH9XNqsbuYKM6s5OR?=
 =?us-ascii?Q?u+wfsHfrolR+F5a3ey7qjINUQJo+E2lfl/od59B+C4yFbRfDzSMmiSaK8eI+?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5250c7-ef25-4cc2-0781-08dab8ff6f75
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:14:05.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5b6CMp7P9eFxOsUgq7t/jlL7OQm/II9oomlWHc0LxsdtKVhlJ0jtWJz3rI3DxRVp2hhgguD1C2f+UB4FDcu5mJdGZ1OD3Xx0HDeYEIrnUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=916 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280102
X-Proofpoint-ORIG-GUID: kDuGoqMioKb_t5G9FUyUEWTVQbnBo-b8
X-Proofpoint-GUID: kDuGoqMioKb_t5G9FUyUEWTVQbnBo-b8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:37:08AM +0200, Nicolai Stange wrote:
> Even though the parallel_data "pd" instance passed to padata_reorder() is
> guaranteed to exist as per the reference held by its callers, the same is
> not true for the associated padata_shell, pd->ps. More specifically, once
> the last padata_priv request has been completed, either at entry from
> padata_reorder() or concurrently to it, the padata API users are well
> within their right to free the padata_shell instance.

The synchronize_rcu change seems to make padata_reorder safe from freed
ps's with the exception of a straggler reorder_work.  For that, I think
something like this hybrid of your code and mine is enough to plug the
hole.  It's on top of 1-2 and my hunk from 3.  It has to take an extra
ref on pd, but only in the rare case where the reorder work is used.
Thoughts?

diff --git a/kernel/padata.c b/kernel/padata.c
index cd6740ae6629..f14c256a0ee3 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -277,7 +277,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 
 static void padata_reorder(struct parallel_data *pd)
 {
-	struct padata_instance *pinst = pd->ps->pinst;
+	struct padata_instance *pinst;
 	int cb_cpu;
 	struct padata_priv *padata;
 	struct padata_serial_queue *squeue;
@@ -314,7 +314,7 @@ static void padata_reorder(struct parallel_data *pd)
 		list_add_tail(&padata->list, &squeue->serial.list);
 		spin_unlock(&squeue->serial.lock);
 
-		queue_work_on(cb_cpu, pinst->serial_wq, &squeue->work);
+		queue_work_on(cb_cpu, pd->ps->pinst->serial_wq, &squeue->work);
 	}
 
 	spin_unlock_bh(&pd->lock);
@@ -330,8 +330,10 @@ static void padata_reorder(struct parallel_data *pd)
 	smp_mb();
 
 	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
-	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
-		queue_work(pinst->serial_wq, &pd->reorder_work);
+	if (!list_empty(&reorder->list) && padata_find_next(pd, false)) {
+		if (queue_work(pd->ps->pinst->serial_wq, &pd->reorder_work))
+			padata_get_pd(pd);
+	}
 }
 
 static void invoke_padata_reorder(struct work_struct *work)
@@ -342,6 +344,7 @@ static void invoke_padata_reorder(struct work_struct *work)
 	pd = container_of(work, struct parallel_data, reorder_work);
 	padata_reorder(pd);
 	local_bh_enable();
+	padata_put_pd(pd);
 }
 
 static void padata_serial_worker(struct work_struct *serial_work)

