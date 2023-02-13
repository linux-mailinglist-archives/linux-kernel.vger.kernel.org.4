Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A31693B84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBMBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBMBAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:00:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01693903E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:00:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CLhQdH023200;
        Mon, 13 Feb 2023 01:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=F7AEpbKzmLmpANkYpJvulCTuPlPbuov373+ijmAq/U4=;
 b=ons2PzDmX/EUwNO+ryXmnhBZHNYzNC/9YJIEsw2TFWpmbpCQQol2PqSk3XofdH0Wk8mg
 jBXtkNf07tth5RC8EojtrUF0a2W68f3z5y2SvwPylSnvgdtXQ6p+LcfOJsZFljwFyn2B
 Cued76pHeKwTa9yibJfUdnzeMIwgG6XokL1r2fGnm2f8hAOPKW0CGu41Ykwefq2SdaPY
 fKrTyTfga3I04c/JDChbf4/j6kQJzvJdcRUpIUFHghiAiBOshk+KUIBmUgEOhlA+x0E1
 uxV8s4Ju2YeiORgDykNzPmENXR4LLjrysa5KM9C0b3HOvKAW3lW5WE4hcwzeQPwO59gk Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32c9nu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CKLOal013516;
        Mon, 13 Feb 2023 01:00:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3gb4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdf3/YUPiZvOR9unwJ69+1thyW7pJxVbWu0OX8DqFhLuCUpJlSPLhEfQlt72WPsVX7imiEiqMOwtjtjuZ+Rm8hhLIZliRKTOIX25wXl9uGdgerZIbnlTWSugaBlZ6MLj7hnt/ck+X77tcVygf5nXRVBfPzrlkO9ChRer/CRSa4YhCXVsGD/PkZnXJUDDOa5/RhezbODyJhCxzEsdjpuySd2sDrFPDbKccSZmqfAbLr69yIB+tds3LzFW3LnpA4NxTkz3x6QKNWF2i97GZlCeYgSo8rTGH35Glbf56FWav7/yMLPIJZmSwoqRRbz0N8/cXJ5h1qGiDgGwOs+E4iJ8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7AEpbKzmLmpANkYpJvulCTuPlPbuov373+ijmAq/U4=;
 b=YElEneIDZnkSfrQ2tHLE5v3gboHSMr9FycY3NyuGTRNP5J49n7FutElJp4qsCf1hhCI+WCwSBbJmHIpCPFeZyfeJ4e7cfb5IMBNNw5bOVNyCc/3PQLIzJSsaiA93BzVPDCj7msScfhKRowew+1tGMEXP0R5JYE97WOh4Rv1y+AW5U4A23j6MVayNIg3yUMIjWc0Dmk8nWlk8Ov944j5koKpYlQhHpW3KNNFMGVRg6Js3RhCNyDrg39OyUmmSV9aHj1PKNAqUCRSUlF3eljwBBsR4gc39vwtQIkCTDJJkF/MP6DZImTqfhPn64QcmXIMtnO27PGTkK21MWjwF/tdfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7AEpbKzmLmpANkYpJvulCTuPlPbuov373+ijmAq/U4=;
 b=Q+Jy1S3Q/wFjINW7hdfwxACTBFFkB37O2ovFfR4FBRpopvXs4gKBltJYXcc2fAsXr6jGWNAFZRq1aOTa0/l99+drjmJoGm1u8hdKIdnOYJlKzAMa4+1jMFAouyWpalRpfH0rj/1F6MkGHwZrsu8QgIq5lkE8Y/+VUmGQGpSn7bY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Mon, 13 Feb 2023 01:00:24 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:00:24 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] kernel: Standardize task comm setup for kthreads
Date:   Sun, 12 Feb 2023 19:00:15 -0600
Message-Id: <20230213010020.1813-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 962b47ac-cc91-47cc-f195-08db0d5daff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfXjWeSoROOZdNFqGu8cPDzeb61skCRXfa83uosTERmTmzU1SaR12ZkAFukK0dWONTlNwphDnhpqSLbRWFGnrayxGwfvn2mT/tOZ+4joVd1fSvtjbGuQyrjjyNa0vc/27bdm//rrlt/Huhpx99vs/J/gcpxT8qdIuFZjeYUdOeSD4nf0DRLW3YDYnUTE6B/MFGBgqdjS9ULXjfSGZSk0BCpzUt5jsC43zxD57kIeX9gQwH8vSjaUzGhBYRsEvJF8RbuoNZkYbc78B04z0Yl9e4LZBtBKIdWnDgAAn8ZCTy4+vywZfBIMfq6At88lrx1r4zzxjIqFOwuxTqCMQGRmgvSCoKnWoGvILTLPxNRiTfYS2q46HmSBgPu8vN/2aLubCSRBMbLvEsa8JO93aG1CIplnk0qVpCk8VLPeCbUAkimfRKVQSJWJX4KcDCVaJx2UScSZ0EgcrBlwKzeK3EHnWeL0SFnWMrQbReO2nvu7hIIM9k8yww2XQsM8daLZ3tmgRc7ODaw0eoZ+ARvrE/ngNYtFq+lk40JHb0heXB/FetvyJkIQgz7rvaXQ966rtHVKmgoR+39Hjt9W2xSEYge9LXrgOjNnDQNMWadfUPxTnf7cxvzR/Xs3MVNBSgrdcHJfs+ZHscC1i/qtUk0MdMuCeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(8936002)(36756003)(2906002)(4744005)(5660300002)(86362001)(2616005)(316002)(38100700002)(66556008)(66946007)(66476007)(8676002)(41300700001)(6486002)(478600001)(6666004)(1076003)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFECl1lvAkIkVya8rItSf1KLU/jq4IqIUC7Kklq1KA8cT7PMS1q+670qaTyb?=
 =?us-ascii?Q?swyjZSwadNpzSfHp/e9D4Rb0hnxg569fkfr8i3mPH7UJJ4p9Ib5u3VP2ciyU?=
 =?us-ascii?Q?I+BhVvQulssY9UIh4w8zK74c3QvZ8VpRmKXmwbHr6bgBSefMpHxjCVoDDgPc?=
 =?us-ascii?Q?JasVbrJL9vDxpG4+SxTUGmc/wKkYOEqm5Im6Ejg8trz9AWUJVITQlTJzTFzo?=
 =?us-ascii?Q?z7qTr1B4xHuztyoEevWN1ukeiewE2fUp2VMEYTqhs3MU6BIJN2kgVJ+qxKFO?=
 =?us-ascii?Q?mDDYQSbGBk9kSQxVPvKmidbe0hFD0vkZ0h3ANwMjHCUPfUgKBCkmZ1pOdQkL?=
 =?us-ascii?Q?w3JuTjJmAZAGDoLSQ5kHsH73kba1KkCa4ZSGqj2SiH68540qI1W+tsBtJP+l?=
 =?us-ascii?Q?bzjtgae8syRvN8s8o3iSpRQThO8E+F7x7L7xAoEV6MY60cg8P/lDHwZNSDtl?=
 =?us-ascii?Q?0kGP24IO4X/Zc+uQWRrV7Tmh7ze8hAWQQRR9li3aETFXbv9Ih33DDDfu1tqu?=
 =?us-ascii?Q?ZjTSdpojE4+AuLR/pSpcAu2SaBwMqnLMaRrgF0FUlMM9/ZnXizHZwMgT/wFN?=
 =?us-ascii?Q?R411T8KDwvFOBQ2L+2aO6/8hJ2+ZRJWrwHSmo3nEvlLk1oz0HeDW4eq1qe8o?=
 =?us-ascii?Q?s76/5JwembHKui8vurWnoPL7oG8hCgZPePLCBcLMDOdppvlYEbrNZptM9QLY?=
 =?us-ascii?Q?7k1/T5BCbaZaihgUsFyNb9lZWGTsvkW2ZK0eolRhCD+FZfaKumYg5GoV3C11?=
 =?us-ascii?Q?yPnKFPmE5URkQVbhHyfxUt+2uxVAb5UWoa3G1LPldPFDqzqUadEaRmIpNZp9?=
 =?us-ascii?Q?SaB7jJ7tdAgeJEr1Ek5pt/J3mfG8X4FrfgtULc/oMnm/x5qa96zxR3VuFXvw?=
 =?us-ascii?Q?8L8cYUN5T9C1XmFOoFXc/lrpETAknnXxkS8sHSPiL45HRJWLHcaWuxbTo9q+?=
 =?us-ascii?Q?5gLyB8QscTqNX+4FdrbA4Tg+4oWSsfmBuUGPb0h9iv1FI263PfQsRsnphxBk?=
 =?us-ascii?Q?73Ddcv3+WBnhuVb7eZu0jT3Z3S3gvK0qejQtknaIk8E5bWzwnlypfOiLC3Ay?=
 =?us-ascii?Q?ZURILoxiasugDApV/oL3kEUDSwZftW8jl/blhLOirAH8nqjmLtaPBIGOIaLz?=
 =?us-ascii?Q?egNMMJfsfuEJqu/Ou+y02TdUxd0Z7giywugr9K6DCoaSiBOqpvCKrvmVqKol?=
 =?us-ascii?Q?Uf8B9PXSsgq4ZBH6bE0RrW2n8dI3uY62BtTTCSlEVZY4xkOnN3j9HRavDdwN?=
 =?us-ascii?Q?roEjj9eU0X9Ez9oOs5IA340/iMfn0ujHgJWG3oLnclnoVYimjjiXbyLKNXo+?=
 =?us-ascii?Q?rfxELHGSAzezaUF2jhdO4Ay4CDieaTASvYt7P2sYeB27y/GmuOyq2wt6eIfY?=
 =?us-ascii?Q?NyaK8jiG1FU4XaxAuNyqn3e4R8jc9vq9ntf4hQGJywORuRIyCPfBhzYkznKv?=
 =?us-ascii?Q?l+AJtfwt376jgwFbLusasb0Dz23aWdIfeEHxPf/C/EarN/Ao5ZwieKwwKdDO?=
 =?us-ascii?Q?nsF5hwnaVaN94cVBB3CD9okt0LS/nsKB1yTIqDAN1DAc9/EPcJ5lQQpbfp99?=
 =?us-ascii?Q?H9lbacnG3DlpMlD5/ZHXSS+ungzOn/AKu5/cxWxwomNSTz5JsLv3NgA5yjlu?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ebvhi2tUcqQ9c5lj7KnYCrn0RJeNa8Z1uD/ZJhvCr5tmGFUZVZvBqSgv1urNzk3kWkVBv6g5CjLag8fhOfyxrumcPbWOMviY925auvuKlhHrtGZUGgBKMv0qKJYkx3432crfJaCPQ9z8mTO8VMIL0HaBEQp7GuOD2SakSYbdncZgQC0AvO3esW+Hd9nxuZEKkypjXaYdCY2/j8fiMHw4N5QlaH6zHbn2vFVii+w8IP/BPTOPXHOViIoH2gmmAAh6SieU0ClHCpNQGdxNYtYt6oNIK4xjzfUXstlxcjWqppJK8sRwDOMbevTbQYkUNsYkeK1nPtq9BdprCCkdDP/dKIoLVj1peREnooZMjg7nyxXLJYUCqpqUvldo1YH5uL1um1t+v6wp1Wq1sVGwMyLlb0ZSuVP4LtsUCO5Sf2ubmQaDxZEu/Q2/sE6tkoOaUqz8IR00YzoZahEneOeZYuaPF9QfRBUhomFiRddrTZvff3tmsjujhc6On924qdR5R/JQ7JBNscm+ETSwhTlY3oc1sZ9H9dsjvMlz2FB8nWl14z5caVSW/8kUW8WoEB1TTcYzuZM2mc1vO80aN2GaaUSnLIAZqSIwSjwtIJAZHs9J9UHBa6pUQkZ+21PoXTpRLQPHZCiuH9VcKe55bDMEDnwFSyexX3bSgpkvxKNk2ePU/KVFeXcC2lRZaMtABknvCSDYaWNiyqmVBvmHkFSKyPzxxW1zM56VX1PEq5J3WmPgQS3lET3/ZEvfF88KbYVX+9sADAZUsPLaa8FVfv/1o+QVx8QLPjm/SX0lvuewa0bQOWckbsy7m8fzdefJ+0NqQtM651Sw/j1+nmY2PTLhSJkivXn+lfTPIy2VPD9gNJDUtgmolh2PtRF0TuiZeqig0LnS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962b47ac-cc91-47cc-f195-08db0d5daff0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 01:00:23.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYbZQaoH5PpzZAS0W/fMLj1lCpvrnd6yLO7zgd0WlyrnmeKL6DxeaYBXqahYQGTRPECGtS/RCtsbxSmLqD2Y28itzpHh+avT7iPzDbT6JfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=928 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130007
X-Proofpoint-GUID: tZdwGx1W3iBFhhD9e0QhlLocNbBKAarL
X-Proofpoint-ORIG-GUID: tZdwGx1W3iBFhhD9e0QhlLocNbBKAarL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches were made over Linus's tree. They standardize the
task->comm initialization. Currently, kthreads will set it up after a
successful kthread_thread call in the calling function. io_uring will
set it from the thread fn. And the vhost task patches added it's own
helper.

This patchset adds a new kernel clone args callout, setup_thread_fn,
which can be used to setup an internal struct, like is needed by
kthreads, and can also be used to set the task->comm like is needed
by kthread, io_uring and vhost.

Note that I have not yet compile tested all the archs in the first
patch. I was not sure if Linus was going to prefer this patchset's
approach to setting the comm or would like to leave it as it is now.
So this more of a RFC.



