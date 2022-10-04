Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB52B5F3B73
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJDCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:37:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842A1D0D9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:37:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2941E5Ze011887;
        Tue, 4 Oct 2022 02:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=rCidvFUTygHcuGjuR4RTfoWXKil+7Ef9s7pd9+OXcvo=;
 b=krARLVG39sgjXUqALnGmX/ekbp6Sbg43WHMOADu88E+mneNrnCEvehOS4gRf1YPa9Ypt
 YFZWwlRke/K4pIQBwuSiZrXud6MNUiA2cfcjPjPS9w2bn+Q9mZTG6MCYE3aiUXM+M7PC
 51M4g3gGeVYJhJtaMEsIzB7KUetjvzZug+wbuo+qI1HPmPpqipRtoTusSR+ylV4aKUgd
 QgRTnCypDMiVC6Xy5S/vKzEuqkaqMo8luOQmSA7y2PtZNLKdY8DU/UMlaYKbLcID4ntg
 H16XEX22yCCiSQcprFE8pJ8T7UYB7Ni33vUH9v5sYWYvTDGH2e5GWSzdMTg7Uu1Y3PPT gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxd5td5vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 02:37:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29420loB030205;
        Tue, 4 Oct 2022 02:37:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0a2dvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 02:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS5mGMCZI5a0ciYmXvaqDKP0I0Ck2+fxVmtlxDLxGDRnLqrKm42Xmo9Usgei6VNfumEec6y+mLW5Q8LMLnb/iNA0xtAq/lp1Mwlv0q3CScuGZIDgXvviKPperbSh4rnqD/4cLwjHEo7EnK7xJQ8LuzeY/WTycvO9CdYKYZpEOziuTOXHi8Ir11BwjCDFwGh3wCnvv98zsa2ByZmIJsRYrAdBNtGNNgelnKnguwndk02avo6MD0jBKj/NBVeFxPdC2NWcJYN7cSapizli7TsBZPPBLUxFq5IyPdcTaJvLKFjPfjVuORCFnvkdMvYa9U6J8lgOhZkFvncbXsfkPWiefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCidvFUTygHcuGjuR4RTfoWXKil+7Ef9s7pd9+OXcvo=;
 b=GgmzFby31ZvPKXMpKqiAjl5XnJizMAFrIUbVFV3cWrGbYr0JOdhP+3fhtm+8lxC5/a37atas48Yq8IwvBL+giXPKQNEEJDhCS3ckzaTMQnzPMJAwb4bYHKq4NfFvjSc6sCydtbI1RJXfp5JJlcfyPqxr10ACWvbPzILI2hUYAj1Korttee+WwDyqlEAcl6gvO09DuO4NAULKi+p56UF/ErbXhc8vSlCAlFQzx9RpvVGvITzU8062urBm5zt0KLjVAdmvCOErA/x8cagg8xGOxOC1szEybCZS3xJfB/UNAxtBklbEMVbGOJDI970Xri/A7yWXzC5Qvy1WC299gjYJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCidvFUTygHcuGjuR4RTfoWXKil+7Ef9s7pd9+OXcvo=;
 b=mbc0zVSSFMuuAixL2Ijg3cnWUV8QYTVb+pe31OzLm1EYOcF5f24fUO9Xv+1aiOmNYuMMLva7gqKti5oCb3ZXKdDiI+wYNTfYFq7aWgJKYYECKHaTCDFSBaOEpp/DxhvwBRGU1RDBb9S37Ta6PMyhT2Bnqcu5mH7EZGKNDEGtMBU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 02:37:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 02:37:45 +0000
Date:   Mon, 3 Oct 2022 19:37:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] mm/selftest: uffd: Explain the write missing
 fault check
Message-ID: <YzucdvxRdLEvfj7b@monkey>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-4-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004003705.497782-4-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN2PR10MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: fa014066-6761-4908-eee5-08daa5b16b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cv8mzufN42J/rzP3s3BV8PjtQvnp+SyrMcNDP/+y6rhX0d/nGWWHx6TBULNa6yN1oMcW0hy78dqFGzAOyUsnV0nnT5I6qcYQODm6ZFjuGrcSjcN2skLYRsnJZMlwkA0f1ESG9aJQSymQ+K0djZzFeJv78JmM+GfxN2TJEkqMOX/10vsE8wEgy1Aj1xXWJeENyKHNswP6dCXcGHgFkOvroHmREVkn4HcnFneGbzwxn3pLrowShONr3+Fi9ANGvkSkG9H95l9PaJg+shF5EF0c5mCF1P+3IhJVeUBRl517PNwTuwdce9RCFjpEHwj8V7s5iTRaFykCTlai/dLeTXexpgiu+T0ge9881dmicT2rtSUY/esx5CTJlO743ciMf/nCmD6QUcKVsutrAv46u6Ua8McjLiG6HMyA03dBPiX3iCWjsxn8QMRWg6bIXG4WROvKc0QRz+BCZ5i3IVyCRVVQSaWWj+vED7bJrRdlM+nGFjjiAakmSR70JxKp5NYylEKFKfff+80Jc9nmu3mOJTqRNp09l2uNh0OUFDktWhsGkFpmZ69aj5TFCfqyFl7NX5WQa2w4sgP24YjRO5ObXy25j1AoH3D7nnB3B20/tZqGeA7Fvqpf6DPx2aw/yY0ckEn+C2TYfSzCCqQ8PS2Zrh+PqbAT4fmVmEFcVVT5E3q3vrCNGi5Pl2xuDLHxGnQtRBquDn0jQ23RAZtg8e6fkGYblQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(66556008)(38100700002)(86362001)(4326008)(8676002)(54906003)(66476007)(5660300002)(8936002)(2906002)(44832011)(41300700001)(66946007)(6666004)(478600001)(6916009)(83380400001)(186003)(53546011)(6506007)(6512007)(6486002)(9686003)(26005)(33716001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBa2TROkd1/XyouUhmbEwB7BxVMsxh6vlbWf6eVrTlLRUjXXQL0UdYjUvZd7?=
 =?us-ascii?Q?3ImM10yI2QXdssG6F5oUBMGcEL39k2O4KVtlw/Wgfxmu5KFciPG30ZwbTDFG?=
 =?us-ascii?Q?xGm2bOWdwNMwd40wbZVqJN8CaAfIbbb3NkWrYnxjWtZs9mCa4uuEndOj2oIg?=
 =?us-ascii?Q?KqtO7AOL+ZeWpRPgLGez/g8IZKCfdOoKvjmp7sVfgGRGzOj1oVdgKteUFJ39?=
 =?us-ascii?Q?JTO28a6J9T1QhIsVjwOwbMCSrfyks//+/2ILmqFjbctsauMNOXAmkBD81lqo?=
 =?us-ascii?Q?OiE5ZxyeoiWtKiSTyvvWGcgpt8hJ4igKxhI5KmhcU4kbqCeSaZI8KgdTbj0f?=
 =?us-ascii?Q?yDN7YAhIH4ofQkg7xR1KA5bqtjcNKvv7GvSaIsrazARGO9x7+dTFY2tkmFmk?=
 =?us-ascii?Q?ajQFOvINPGGuNkY5Ml3Bgc26qaZaa1VA6jdM36mTZ3rcNPpMQGEcDjqnZ3q1?=
 =?us-ascii?Q?v6WmwH1ZK2oBGHmJLrXcXcV0pHnNU3HYzdNuonl6y/SWi9JWiCz8t/XyXxJv?=
 =?us-ascii?Q?WclwNmgxEDkBmDuHS3g8s8Q4ojTPVeHHf2v39yxOGYJpK+Wp8LfvsQn4XUie?=
 =?us-ascii?Q?v2nquNot/VCjbYrcH4FKjbePnayGyRYFbMKw2yAyiGR3xEm01b7QpqJUB5Yj?=
 =?us-ascii?Q?vA0YYyGgGq01kQeEhy6ayYTWPGg+d3tEnHB1sXfrFJ0EJEJrZ94xjFGB37YH?=
 =?us-ascii?Q?Gf+MElwmDODg3AoiaxTRchadDV0h/iwHr7evnQBQxAHvtcDA9lw+MS205CRQ?=
 =?us-ascii?Q?n1yBFWTMzjtJtlKhfcn6BJRxWXhwObIb8GplZ5cAE+TXJcTMRPX9S8UP1dWt?=
 =?us-ascii?Q?62WBfZS2x2l5DXTe7ekzg00Hf0e5XP628P0emhJklaQZC8tRuSkHJAkV5E9p?=
 =?us-ascii?Q?cNukSosKGyz1uOoD6jSYFX6kPFiNMx83GJtXu3g8fxhLJZhmUz9UD66yhHp0?=
 =?us-ascii?Q?WeNHUllCQilR8eSlFtGZgn3R9IAuU3BX1wRVCQOsBZeiAiG9lPO5btQN03R7?=
 =?us-ascii?Q?ITmhltl6F81s+JTi+QQj/oOhx+0Ug/4HISx6gGs081pWsFwTrBZKWV6Wm/mR?=
 =?us-ascii?Q?os61BAv9xi/UuqtyNDsQdg91nYgrEhQbJS6E0GguGUjLIs7t5PrTzruZo08k?=
 =?us-ascii?Q?MgKVVv1OmtexOiD0yMd39KB/IO6yAcXmalkN/BFI760mgahhMQFIFIf1Q/ly?=
 =?us-ascii?Q?kJ9vbWz2gpdYPFQGdfrJUThX/E422gFsdeoVOYIqxBVTX7qX4w2Jc9tLAWJm?=
 =?us-ascii?Q?4alDXyMZ00CsyWeonQTcQyPPnA/bF1O7QoLBlWhamC4+qig1r1w17cd3IpHJ?=
 =?us-ascii?Q?54T7dAXDI134s4dcGKiPIiU+0tQyPDJnaz7NfDFBx7BRG0qSTtvmQeNDSkD5?=
 =?us-ascii?Q?bCEDlbDxXrqNqlGDdGZgbm5/7OvNQGtxKC8xVCESAwDmO92m2fGo+rwdYgJE?=
 =?us-ascii?Q?rc7stTFCgMbv1UY17wyveVPM88sPI+GoL/johiE2GZMeZ7F+6STDVQSGOJyQ?=
 =?us-ascii?Q?LmD3ElBG7xmOX7YTqg/nr06dCwzxXkYmrKGKQmfzOWjS2JdOGygw+mleXFTc?=
 =?us-ascii?Q?R2DddDTxs5W/3QuagamFYwRvSqJ0fbeICb2dTeSYZMPvW5ouHjPHhjR4lzUs?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa014066-6761-4908-eee5-08daa5b16b12
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 02:37:45.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpXwXoyw++J+XD72KE7OUz2YcazlnY69jr7RHFCCWF+A38b2Ku3rCToq+Pdx5J/r95oc7j270tH5grZOQfSCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040015
X-Proofpoint-ORIG-GUID: tlFFevHvtEREdTNBmcdXBZMxg6dE65iM
X-Proofpoint-GUID: tlFFevHvtEREdTNBmcdXBZMxg6dE65iM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 20:37, Peter Xu wrote:
> It's not obvious why we had a write check for each of the missing messages,
> especially when it should be a locking op.  Add a rich comment for that,
> and also try to explain its good side and limitations, so that if someone
> hit it again for either a bug or a different glibc impl there'll be some
> clue to start with.

Thanks!  It did take a while to understand all this, so the comment is
appropriate.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 74babdbc02e5..297f250c1d95 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -774,7 +774,27 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
>  		continue_range(uffd, msg->arg.pagefault.address, page_size);
>  		stats->minor_faults++;
>  	} else {
> -		/* Missing page faults */
> +		/*
> +		 * Missing page faults.
> +		 *
> +		 * Here we force a write check for each of the missing mode
> +		 * faults.  It's guaranteed because the only threads that
> +		 * will trigger uffd faults are the locking threads, and
> +		 * their first instruction to touch the missing page will
> +		 * always be pthread_mutex_lock().
> +		 *
> +		 * Note that here we relied on an NPTL glibc impl detail to
> +		 * always read the lock type at the entry of the lock op
> +		 * (pthread_mutex_t.__data.__type, offset 0x10) before
> +		 * doing any locking operations to guarantee that.  It's
> +		 * actually not good to rely on this impl detail because
> +		 * logically a pthread-compatible lib can implement the
> +		 * locks without types and we can fail when linking with
> +		 * them.  However since we used to find bugs with this
> +		 * strict check we still keep it around.  Hopefully this
> +		 * could be a good hint when it fails again.  If one day
> +		 * it'll break on some other impl of glibc we'll revisit.
> +		 */
>  		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
>  			err("unexpected write fault");
>  
> -- 
> 2.37.3
> 
