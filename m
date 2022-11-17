Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534FE62E3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiKQSUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiKQSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:20:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716AC5130B;
        Thu, 17 Nov 2022 10:20:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGmTqc015890;
        Thu, 17 Nov 2022 18:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0Ep+rL2k7m6XicO54+RDAPEX3yfO4GSVKR8z3DeEoy8=;
 b=biYI+vVh3kRrsvpyMHV+a2KYEy2MDj5FMYI6qByTrBds9/7n07RlQMMCaIbYx5gw11Ap
 VCwR4GIQTpue8bL+SFXYFAGLY9me6XQ6XgeDrHmRR6GEilFhi1j1fOqbKIZZXWSXUiW3
 SN9qQXcJtFNghGC998cgtSR7BgpWz0D3ohepYan5LH+E3O/weDyopwTJgEXShj8nlu3a
 kvCYgGPkHTo31kQ+YlBePfv3WziD8qEByCe4bcqpfHYQnjskeoEh4QPvEdoKm9WLMzX8
 8Xuh3bPVtNSiyxkojrVhHmuvlpG1uOeGs7S+JN6WrhjIII9MERHB0QEdxIVEhhtdg2Pz hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwrt6ra04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:20:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHG57m004270;
        Thu, 17 Nov 2022 18:20:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9ehay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0QMMV3cZ+JIwd89geJQ6bfvpW5kycRvkdAR76W35Eyk8G2UsdajZf9c4MMlWRhzRKsFwDNG/RWJlc0zL7BR3XAQEIaEgq8TVyAAEE0fcpmkKYRAk8Aw3hpD2H/6Hbs1bGsfCvxMUhd/2l6zFgHEOP94NcDrao4akIH5IUKhNga4CCFxVLRMl1Tc7C69Ix39SDNbS+OXOp0D4tN7JFq+U4SKXqC1RkiW/iIjknUHWx9R6in6e6JfykUp6V+naE+/97ttqxYEYZm1eKOWAMvDz5+hbF4nfGYRg0w+L+OSpvlwmMQ1YYsp67PcIwDtUfsunrxOKsEl05nUDyab1TFpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ep+rL2k7m6XicO54+RDAPEX3yfO4GSVKR8z3DeEoy8=;
 b=irmQwcm5Y0LgIwPuDtXai2slwDILN4vYPa/U+FzzSyDjuAlGBrughW+P2c5ox0i1aT0fFJzWMc4+c+ATCnYofLRPMuSTSEl8WSWESSEXWH6VAirhjezrxfhKpAGVFSfgqu21JfWgWpVy7X0NKvtRs8/mSD+OyLsopnfRsrm54vewNa/pb4DRT/KEY4nCVMs1YFRRZzkSIggTDKFWq8vXmQ1EBBD+Xe2SsvUgfZ3pCfAywDIO4qIkI6hrJjsz0KDV5NxWnmQ0PYCw+FkdAnWE8oXXByVPUBG/FVBEgnLuJznFJjfnPvXmQInAzpnhMIXnCE2CcF0DhRe/Rw5Pvl/BXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ep+rL2k7m6XicO54+RDAPEX3yfO4GSVKR8z3DeEoy8=;
 b=jTwDuFPhFLlgz6HBCxAWeKLcOgXeU6bIVYib/gwxhYi8WpB4pGXDDTEEKqIY2Zr53fICcS5tnE/ctxZbO2pQyxj/xg/5hiLT8kwIKfdMEtG89LKjoXZWjJFxWUU65DlD3mCetwM53i6bH6pBa++Bs0XSKfMPIt+EOCBLhXxN1bg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:20:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:20:31 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [patch 03/10] scsi: lpfc: Remove linux/msi.h include
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cztwihm.fsf@ca-mkp.ca.oracle.com>
References: <20221113201935.776707081@linutronix.de>
        <20221113202428.436270297@linutronix.de>
Date:   Thu, 17 Nov 2022 13:20:29 -0500
In-Reply-To: <20221113202428.436270297@linutronix.de> (Thomas Gleixner's
        message of "Sun, 13 Nov 2022 21:33:59 +0100 (CET)")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed45471-4235-40ed-d3ee-08dac8c8698b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lso0qbEJJ9CwyJaeQ5HDlSGt+F03VLRq4YVndQADqbO3yPAgqpDep/8ggEwHOJX8dtYOOHyAHBGnznkgRI2OPF7ud1gdgJLwwUuWbyfiwahxdoBEQxfrROoraeWRm1THR2gVNfLP4hNwLzItIiRvmzA+udkr1+c6ZVNfh7A61KIzIpLUBU7Prc2OPKQrtzPtBnmFY3LIwuEo4yET0fkKjBNljLKGfUlf7+LjC+PMBrGvLa16VduxrtHxD1zCKBsiRkwWPhBSHs/wUc0vCZi77nfqlJ7OzB6jBviE+tGEy+bT2Vg91bOfDTyOLjUuGap+WMFGGkmw5nXz/bYbXAH5EoqBxKNo3sctXU2NMxZet0EwMV00ekfV99f/Zoeqoxr/bW4wQf7+OoopUwGKWHeL4wFxxLhBX10DwFshamOfbyiS0+QKRQE4oyFL401ifuL6R6ZLmkfP5oAD0/uRnH4M2DfAiDw9iGHBR9gdiNMcZgHExGFkbmEa4Vk6PzeK+tCdUU9D0ayOfl/Tttm2SVi1Kt3Zrinc0kdQil7UQFnocZYY+RAEuRS5L/WETORs84m3hARbVk/aiY3BGcppA5ORxoaxaua1AoQXJ28QCwhJzBM3fHssfTjmtAZKPOLuUTN/gn38wwQfSGd5f4vP2hl7BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(8936002)(41300700001)(2906002)(5660300002)(316002)(478600001)(66476007)(6486002)(66946007)(8676002)(4326008)(66556008)(6512007)(26005)(36916002)(558084003)(86362001)(6506007)(54906003)(6916009)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3cVc7DMU/+7IqxCNfhldoP2j/JKrp7OfHDD7sKLUyascNOB4fP6byoW4gmfX?=
 =?us-ascii?Q?62QkC2J39jDWkEeaDruwcan4yGBxzk8h7baoPMxTBZuIK8hEF7Aun1j2l/49?=
 =?us-ascii?Q?aIFsoG7Hf/dBOx6BKDYk3CXDfxF+D+Ja4Az9fYOLLcL3nGqC+5jy0TRWG6cX?=
 =?us-ascii?Q?16dTIDgtE7O/kUlDlEdT5lRvhoq1F05qh0EdVpnX4O3SwqeTBTudUxs6Xyph?=
 =?us-ascii?Q?wIFnU1LVHdBgRYg2E+PKNNfMissTask3UKpwhiF6wlBUofJWTI/3aoo4cL+W?=
 =?us-ascii?Q?+xAgb/hGn2bRQd/k8grpfj9BhhhitNQQHOi11We2gzxK+FIkTYyHWI2NPoSi?=
 =?us-ascii?Q?quWeIPWiPrToWqlSbKvNE+V3bEjD0GjiCSUW5Y/86mwtOG5GZV4HXLllZ8xv?=
 =?us-ascii?Q?tPT7HGWvlv9TTHjtLZ4J73Ql+QbuaRJutXFq/07UnVwwK434uOgudDiee9Qn?=
 =?us-ascii?Q?UxApftfSDrcvf5xmtNeLimizv0WcWqTLgPJkBSBnh3Z0o0Tac5EJdseq3CB5?=
 =?us-ascii?Q?Q5/mffPxNCOL2gO3oQJNtnQFAX0AONC/xxHqar5EIlvlj+c+SbNkmrq5KWGu?=
 =?us-ascii?Q?FhGpq9V6f2WZvgnwBlmZF8gj8LRoKPLZfQnovhwm6P9opvF9AaEDog30Dh9X?=
 =?us-ascii?Q?7eN1SckPlcjWXyelRtPdKeaRj60qTK3zhkyWrPb8+Il0LWKr4E+QG93osEsz?=
 =?us-ascii?Q?ButvjCVrUmrKeoy/GIPcdBeHBv/QwFSGevbjV7T4M3ZmXX8D4BNFGZrMQVdi?=
 =?us-ascii?Q?mtf1f+tm6/4ScKsy4J2XxI/N/QobydOOPzF1HlSie624Y+eBi2/fvSn8yT3d?=
 =?us-ascii?Q?k/2/mPQW1LX4A2WOv9XJNPS6ry5kYO45UJmex/jYxCvAEdockWjFwLvY1YDV?=
 =?us-ascii?Q?uurA0cEfQlKt+d1Qe6M6roPRqobadvGdDv774MPeVADKN3MPRbAxx02wDGAV?=
 =?us-ascii?Q?b4VdIPxqhdOq+/RX40VX45nudHrbQRwUmPtXk83MbmRImU29CSDqy+oXR7AT?=
 =?us-ascii?Q?74XPQc63uOfwES/eeQF+1Vj4kKyERaj560ydWXuC0/SuPL0bhyX6AwTgBZBs?=
 =?us-ascii?Q?4Fm0xu8+8Saej8tdrzjR+9t0q1epMCHvP5193BhnmJPhIPH6pGNi/zZpq73+?=
 =?us-ascii?Q?og82Lw7vNaeI09/+OxhyK1EX5HrKNKgzMTePtkvR4E60jYHIenpX7niG7frC?=
 =?us-ascii?Q?AKFP07Uz5sG+eIY7M2WSX/uAogqkvyOL59LSvWYeW3xM3gIcoPrH40tsYapZ?=
 =?us-ascii?Q?V9zos5wF5MLiYvkL8JQKOFvbd/Wx1L7qFT3vK++dm4Pod7uXEq/nu7QaTcgr?=
 =?us-ascii?Q?Z896JkIAftW7YAoRhDNcXBCuI2CwZ4Ys8RUxrYn02pIkjaNXLHF1qZePqwuC?=
 =?us-ascii?Q?SObYDST9ZmT5P9MJIGxw3Dp20DOdNaw1SNWJWUbhDL7WsQaNwyx/Ay6wTnsE?=
 =?us-ascii?Q?MaSySoyum4kmcY1LwJR4B/U5W8Q3bJJron94k4Br5l3xMs10kuLxc1r7vLns?=
 =?us-ascii?Q?cj1ThlsgFp4UuXRmWwfGPzM17ihuMFsg6FDF+33+fOmlDXChEgW0+qV8l201?=
 =?us-ascii?Q?VLmt+A6vI02dLzzC1SYLyKWPARy24pvfV9t3es4LRuYn9OBKIkEKz48Ac8iR?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GOf60R+qSBd2ipm7bKlYV01TYL5e7GkBIRZfgTpFftHBfkY9dB/nyfNIwixR?=
 =?us-ascii?Q?nxFQx3HzTN5vyjHF5UQZ/45Dten8eqnZyB1fTZrCnNlR+aTtF+C5DKFaVXWf?=
 =?us-ascii?Q?cnnJyllTVsOa+91VBF4q4wnek+HeAi03Z4vLOAYq5RKDV+x1cN7LBQFCBSKL?=
 =?us-ascii?Q?Fw8/2yIgFGuY6jSFH2d75aE035ElxzSPJhgD4on6bbXkTNjRthi+wNGVCMTV?=
 =?us-ascii?Q?VA0eLwP1Bo9cYi3eFPxeBcmlCSr2oItiFD0EG1dLEQ9y3zZbIjsfq39vMfVd?=
 =?us-ascii?Q?YgwsWHm9rpdT/2HMzlTYYfFWCmg1aq2/qtRwZmDT7tx5ssVVeisrbHpO9mfq?=
 =?us-ascii?Q?Kvwx+b5/ESWDasFUL/HLd4+xbzErw3jP8jVoRHz1nixxW/OqHqi0ldXuoQ/Z?=
 =?us-ascii?Q?yjWexzGos5eN1QEoh8Zg5Xqd9UHSbv/amKIsfQArE1kZw9Es1czjBu2B96ZX?=
 =?us-ascii?Q?JYFdzP4H9q0i77BjHcrsz/WFy98RUAcMw0mrzzSrVz35frtZ/MGlnBv6GnZ3?=
 =?us-ascii?Q?zzk5Us1pfGye8NHD+WqRMLZ+UuP2Xppf41xvpTFGca5q5wEHfvouG047NLDi?=
 =?us-ascii?Q?ALxvlui/BSeBC2Ha276EL8N/tM10E73cUgCNTeo5+M9IR/r4ACKR14U7uWkK?=
 =?us-ascii?Q?wrjxZV7bQDvCLC9ust6ndpPZKRZ6iWrh0pVjhM9NwvPqCcIVSUomVkVHmaVL?=
 =?us-ascii?Q?xa/ZcF5tTCIxzajsvV7+wicjTlmH/gsUELEaDmcYfnSRZtvuR31zirOWS2TK?=
 =?us-ascii?Q?Pasdc8aWLIHQbndPAWvM4WeOUMrfQqVpcF9MpUp41IZctDFASVvDvi3tI91t?=
 =?us-ascii?Q?GghCbMSLEbeU/Wg2gWIPhQztIkaVZuXfuJpoPD9mtsv7NI+YePYO+UyhU1N6?=
 =?us-ascii?Q?XGX9EA5FvkR4I7EH6G5dctpSwZe2Jlbvn1oNgC1eQk3GcrW7tljmzMxv1Hcs?=
 =?us-ascii?Q?3qK0fRYzW9IGkiUqiVKCnzfJzp0K1/TilhViCcxP7z0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed45471-4235-40ed-d3ee-08dac8c8698b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:20:31.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDRFl+sa8PJ1JqmJ1fIH6KhTJGgz+tgQday4URIgLA0+6IHrIk88H4+3S5UY1kY0LDyzbTTT+ohD8TLPnGxRWWLGJU6xXJ7l8wBL22dN7zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=964 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170132
X-Proofpoint-ORIG-GUID: YA6pFpHPCZNaFgT6Yh3_MclSNdsTtS6o
X-Proofpoint-GUID: YA6pFpHPCZNaFgT6Yh3_MclSNdsTtS6o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas,

> Nothing in this file needs anything from linux/msi.h

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
