Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48270CD79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjEVWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEVWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:05:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260EAF;
        Mon, 22 May 2023 15:05:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNugY019629;
        Mon, 22 May 2023 22:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=x6retJJrwviP/3nATEnfHwXNCZcAIvTnMxNfD1Unfi0=;
 b=1P2WT8Kl2dqu2Y/4U/Do5YIxIiDI3xqdN1QwWKsTgBr8LShVqSnwkSkkZmQzVMPQLkYb
 fhaw1pEMT7gbCOEGG4nz04tpoahP9BWZ/d/67KdJ2lERixZEmqpWWWpzHd5VCUdOh2a9
 YuCPxaSnA14nXX4t00Vh0MUh7dGhTpjkBa46ESberdtkTple3pszXcLAw8IbQV8OW+Nn
 ux+p62/nsisfiP11EMrxGlLzxOrOG6UDetXnJcBT9XJ4nk3fQus4ccoanJzUEd7dKLmt
 0jy1X+lzVYW44mmg2eszKLIhmn7tppWEKbv70PUFgo/v57lg1+NTFUzWxE8bpINkO8o7 Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cbtyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:02:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLqOX6016006;
        Mon, 22 May 2023 22:02:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6hhj5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVzcxAjxumAgHTCty1BtH42gluFbLGQSWngXRfR1a0r8wyS/WFrLU1i8gwnC7nFT6Gz/J+F1vihZgn+UylhlqoLWxfg+7/9ZunjjuLK7VZF8Mkmww9HtaeiFlQd35W5ohufD0RpgL+ZOH90/xRvDdgFjHpn7yG+RJK3CBqiHMxLP8WmvjnYNL8G+jipoY2d6NJzsu7Xt0bRykxWMUDSzFOr/RW57cqaTvDGfj9bSr5lOF4elrmv4vht8M1QXStSToc0U5cZVLiAMJJbPvAPuMHdMx2a4hu47lSXH/8eZpsRecqx+ofx7mhGGv1CHLhzD1xXb208rez/kFb3owR8VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6retJJrwviP/3nATEnfHwXNCZcAIvTnMxNfD1Unfi0=;
 b=gHPxCabSzcutkU2DEAzfnHX1QwrYgsE8FX21rpAOaC4up9f6YsDwDHu1ho+juBtAzorRue40Snkez+LYd89TYpmnHJijMq3NLqGVb0I21pm43UAiudJiTWcVGe1QMe3rWMCEMhHodRUySMKjAFyKNbnkJ1TbwE4Uk/hPiAzhxu+tW/3f5CqazM/EVrhI7bsgTWkB6wvtdZQQiFi2DV0Bh1iBxTIg/JFnW3kLV+RsBqZtVAPu3+x+tt+fMA2bpDkfkWJraHbTDkf3MYs0tfPMFSkbT9MieZLO40HBIQaVhPn590B9vPO1X9Owx8aZbQICjahCJOp0HVCGieZgqkxtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6retJJrwviP/3nATEnfHwXNCZcAIvTnMxNfD1Unfi0=;
 b=klwL1vG21wHNJtcXcUHAYFkM4ZBycIHTE15rrAmod0W+xXBDfApaROatudbGBo4s/w7NRDe63ptwjQE5+jK0XzKKbDmKr2dfKowp32wqUhjSQBx9XHiDbhIf3itzY8kuM+MmosZq/OfC/wshuFtPPHMwOR1NODkrhtPbU8LpxwE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:02:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:02:23 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qj8nhy7.fsf@ca-mkp.ca.oracle.com>
References: <cover.1684358315.git.gustavoars@kernel.org>
        <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
Date:   Mon, 22 May 2023 18:02:21 -0400
In-Reply-To: <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
        (Gustavo A. R. Silva's message of "Wed, 17 May 2023 15:22:45 -0600")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:806:21::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf20e0c-8cac-43f9-64bf-08db5b1038dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96+G21m3+2X10URDz1ic3bvDorJTCImajFM73ZeD75iOGoaEtpr42y1hIyfGC71+eViRG4HOrJrnjQ6F1wmBYFGXUgfvxKj++bxnQbrU1pl7LJ/7YQU5wO3l3M99ZVo6D5jln2x4Ml5Kz+w8a8w4NOkfj3oQuZQd1vzgb/ev8/lWHFxTroibM+j0OWiLYpz+2VKzW3pUD1iLQmaOG1vExwGNhnIra8AVk3X884IE1r4ZzvfrLJDdr439XJE8NIqSxU7tsTwQ7CubfqmkhP9nrVRbhsDVW12ZsXxCw66vjpeSvN0fvO48GQmEBw6XRPKT8wHRYMQIdaHAstD8TB9r6MfAzw13TlfxYOF2vVXSGMGD2GczCOmJKLKDnxkuMBeJQ/uMcAad5vYw2DSwuQiTs2ovwRXDEN7B4/zGhhPBIakjmTFq65Lg5NqpiHT+cqq2DfMIr0jb8HZAIuZGTKajJQFsRRy0zxdNP7NJXPL+lbVK0HuPpBD92XopZhY5cqW02Hk8g6LjaTI2+fHvqfFTeWs2/Pc7nRfDp968n1he/48oN9iIChaK0dUhVXy7ccji
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(186003)(83380400001)(2906002)(4744005)(4326008)(6916009)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(54906003)(478600001)(36916002)(26005)(5660300002)(6512007)(6506007)(8676002)(8936002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UK7H7j1oQ6xYh8nkaHEp869hUyro0jxA1isT3W8dVcXjWTtcNoTmWfGGiJKA?=
 =?us-ascii?Q?n55RhV4djU2OoykduISPYL8vOO5cxHvzftxveIVQBUDrgYiLJoxJCyhOCwRG?=
 =?us-ascii?Q?9jXOOrmzHyoF6QCx5rOb8MsAURdiiVML9ENeeXInihE104GiMmjRwdWWJotG?=
 =?us-ascii?Q?dMrwlNMfFa5V83lBLz0ehIi+dNm/b5Khqn0xNIVR9SDBvC0XQCb7FEZ/yl2o?=
 =?us-ascii?Q?fT8S+k00ytuBz20zTrW5MSF8v9xNlhG1HrDddQVo5yYJNIoc93mUzyVrABp4?=
 =?us-ascii?Q?2vMtvTKO5nMC94oD5i0hHvbw+l+CqFlodpONz0Akq9Zr7wDyZ/kTt5qQpSWU?=
 =?us-ascii?Q?Ibw4NLT1kJuhSTNKE0U1+B1QEQTPmr3kztuVpqcAMes64vrhfbNCVLo6S7hh?=
 =?us-ascii?Q?/t53nrllsrmjoYDSjHXj1p3u9jW+FA4vI5ofNq0Bwoqp5HfXM+ng71S0Pv3k?=
 =?us-ascii?Q?XKpfmDt/C5e5/0blKMS+L5gb5Hsh5oyitVgYy+ULjJtL8sJ5zJBSuLEefvRG?=
 =?us-ascii?Q?+fZxx6hna1EnhOWMBRKPDPjRkcmjrrn1NtGkDGGzVCUDtQ1QD2UsSAVQZlJs?=
 =?us-ascii?Q?J4Wv2y5W17WnwARCbHzIcI9AhbJgT10zWo1+tkHit7sO8bvAceFFIihETXL7?=
 =?us-ascii?Q?jGFe+MKm4zjEPCHzd73K/RNZkvbmTweollyyYOuwjnY3Wm354mq5UeHALngn?=
 =?us-ascii?Q?MRk43arAG/AzfdGCi6UJmPn8RJ6dFAE7aojmuvOByIyp492LgdlR4KJRcqYi?=
 =?us-ascii?Q?2ZUlbMuvUXTzcGX6IZ+2Ut0G+NgPjL/NtWzbW7LBaRmump5XJz70MscHv/or?=
 =?us-ascii?Q?+ju6O+Lyg000YBU/tNECSSNxxdx7ycHT9OtpqGvCaE/ocKVKpIyB+nK8Olan?=
 =?us-ascii?Q?/geP3+6hmdJvPeNRumQLJeIAx9fCfkpPcFd4Ggh9qQmfBaclAve0R01YQXqH?=
 =?us-ascii?Q?3rztUT9Ya4kZT/nz2nF6T2rx4M9Ax2HdOO6ActD3j61gtS7f0QxUZQwlSSZs?=
 =?us-ascii?Q?UIN6iBZAT/KpxWCOuNEVCYZw9NYPHRD10PC3SRV3lIL5jEag7qdPXqvP1SVQ?=
 =?us-ascii?Q?G8PJfVZLTJayWDCrspdt1lOugA5QmBwiL5834YXgjhcow6hIYDNd3Fyf7zrn?=
 =?us-ascii?Q?M1g803bx1lpTYdgpuUPFPkOuQyypXy0fyMHTWiK1fpQdzwUk0csXwvcgyxkN?=
 =?us-ascii?Q?xVIGH9gaujcggOHRCw97LgKGW04S8gYgMxE8SKh7DNriXbjoKE9m7RmkfKvy?=
 =?us-ascii?Q?qObFzId5M+Rr+o70piWR5NdKaxzkVLLcik5rhrkt6V5x45rNFLCmb0uYGbrZ?=
 =?us-ascii?Q?ua3cuzmUD25XjnCLMSWWBzow6D50aOSiQWK8bLNDoEH0sYimFwFYsmk19cqO?=
 =?us-ascii?Q?054+hEBhiayf2h7We7cIlhz6LyhEvjchKEjYacA1QORYmb9TKKCUJX02m5E9?=
 =?us-ascii?Q?zipUimU6k2ZwNRVLGa1oNf+BXNk+9JqTEOfwlYbaVjJD/qwQkVt1nF/dRX6y?=
 =?us-ascii?Q?wL8rPeSUMMxoNmWGlImUl9ovdZcutGiBY2Yac2JSMHjh8r4xUHIcZI0Db4yC?=
 =?us-ascii?Q?ZW5WKxa3DwUAReucsqOSIRVKoCE2cE+mG5KZlC+ey2Tw7krbCRx62qzw9CAp?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KVowH0BnAORS6xz8oeKSfM/WsC0HF9FOc86+j0TeaJY/F1LsQDV6O+fjRp2zb7jNr9KcydIXJdjCK6R7wOqpZrcr5q3PflUvP1+cgc0gP5BmkuBXGUKjdZplSmqPMKz8Q/inwfB4S3gk9en482OedzR4hMIc/0x9Uus2P3o0kuuLIrO1tLp/p7iJqp5/uwjGGpwqagKkYwU071DXg2h1HuPi/kKh+/R3Fa8mi0cC3q8lfpiW6Zij1+rMoGFmeyNHFSbthMDwE1dQiA383N/MvP744D9nJJywk47BjFevcZOUpQEONRZjWEM69lPRuR3PgN38K6hhXZQp8DNiBWGT0WdL6k+if5OZbzvd5lrLAM8G+jEpkQ/sLl58EpetS5Gov1U0Qzlx+kOMSVSLDOjJbJfitQVumy2nJTmtIiJExYdn9hKvH05TeUMZFOveWaXlM31JKS+HfMAbG6pHS5oRiJlEbFhQ1it/EQf9dPwoBCXM8EBai5FK1liRTtxLWWpGjrq1tOpaTCMdUISd+TATOzyQr3Ka7BV9Kdi2jiBEH86jmyOYkm5+LBv1CEs2rZoj0g0vi+D0KOHhIzDxY6HeKdAOr9RC9E/YioxhoQOMLajqV02Z4QuBPGiKZmQO2YBxNrvSoZojQCmAxRLbTLGB6jD7S/Jotj1ucDz0Rw2R19deFA2iyXi0x12c6d+1RH7vDu+CueOc6ah7MSE7xQajKg/8Irby2HG88q2aNNcaQduS1fLJmN18BgxA4Y/P9nqJ8+p21J9LYAzhHWRtbh/tawdETNryvSuNHTIa/Age/LemiqO5xZ3jjlxCEEpicqU9CHxEWaZb9EJltYRpsihKpqs5BjwsrvYl4nvCiapwwpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf20e0c-8cac-43f9-64bf-08db5b1038dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:02:23.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYBEsLB+K3B/BJqYJ++n0raUQeUINz0cW+AZS6Fh1djiZ/0C0dt/1KjQTSPug5bzogGZAAagBE6WT6ti72n22MLMmMngvTZvHhyNDyfNdTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=826 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220186
X-Proofpoint-ORIG-GUID: 4evQxDxX1RjGqAscT-0uY4PoEaXTOZhG
X-Proofpoint-GUID: 4evQxDxX1RjGqAscT-0uY4PoEaXTOZhG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in a couple of structures, and refactor the rest of the code,
> accordingly.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> This results in no differences in binary output.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
