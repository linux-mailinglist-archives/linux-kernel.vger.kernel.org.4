Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5379368FBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjBHX77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjBHX75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:59:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D314E8C;
        Wed,  8 Feb 2023 15:59:56 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KwwZC023288;
        Wed, 8 Feb 2023 23:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xrGMQkM8S3eUMuhJ4ekNU9RE3zOmHUhgj+y2YiNrpo0=;
 b=vF5iW8EKeXi4rcRmZmc5O/hrr1tNrstiYcSpTRdUfGFIViC+jJn06jfZhoO+z8YXoaxv
 BAFFjEmP7WUADwzO56hVigCHICCEqGnbe9vA0SOyos/inknggrpNh5PRWE3Lo3sDR63r
 s0EfUqW+/dt/vTTec+OMCnvtQGI4k5rQgTG9JuairaoeiTa0LSrMOpYca9h0nZLd2gQF
 k6MQx43f/VuZUO9Di9snGh/jxWhC9++GTsiQNxQELoqXKcBh5knRoEnmRtmrI0wToRd8
 XrZUlKp7TP5jR0B4TFR/UMoYL0aQuBudwjL/oFBAlm1oej4V6i2Ev5Q8xuIQuhMpl6dN /A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nhk9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:59:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318NN0Sd031332;
        Wed, 8 Feb 2023 23:59:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbcg4hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0bTgb3mUG4HgCxqC3ub3O+6alN4JhAUiyjsfx0wzACQEi0uV0G2AJwnrFpYb+1c/EwJt/i3xlhqH6O0esyEaGeluOT8pwO1JFtu3vM2FQ7iiCKpBPorsqdJj6anqI7HiGmXpAEgYYPk1xKJRgyDpsK1K7/drVVQXHhYtetuJYuQPCfibQHpWlILyw0rAeoJOquumovZh+fBkk0wa9bJxs59/ROhweiCO439Fi7Kx1++g7EUTyCNw6tpOMFwkHZ8Wu02V12AdJRF7DVJTFuZd3sdCL0GgV0QX/+VCEt3h2J5oaPR2yGhKFQ3LR0+vciqN8Z/VHEazKknMFLDOo/9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrGMQkM8S3eUMuhJ4ekNU9RE3zOmHUhgj+y2YiNrpo0=;
 b=HYAREfI0jLDkScmqQGC8j9hPxrFR7HBfutvJVPVKEpVm5f/AlO4pux2NYIN3ZaRlpNITzzrjKWrljhQkdxhSkpvgfqpt0FWyNRexdqUy0912mnOLJExR/hborQD5eLbIxBJolegfdbBnCUMcwAf9QhpigL2oRjanSkgPjfsX08hjF0pPFbyaas/n9cJSE3FnSpqgdjsvDDVgcombC8+wQ8/sUcKR5hvvQ0fen4xrS3GB9urV/9l5XAtEbHPv4WlhsFrHCzsPyXsiJBZtGA1/cn4Si+IA5N0pDYjPz95StQtD94CPnFSMA3tmRfh85sccUm3Kjh57gmpdHra8yD58jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrGMQkM8S3eUMuhJ4ekNU9RE3zOmHUhgj+y2YiNrpo0=;
 b=gzeOiURHkRlOOZuQQ3xt5lv0xB2nJi3t0dZ2cn7qtInLEG9pQu9PmEMPzFJ4wAtQ5EumxS6nJoHdtG6Tr5awjTHBiX0/d2lizAuWX6X1pRipf8qcYz2h/qi/A3bXSbzn1XyqlP1GtFIVIWabPhe0dlzKHpw9VC+ctAx4WYQRH4s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW5PR10MB5739.namprd10.prod.outlook.com (2603:10b6:303:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 23:59:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Wed, 8 Feb 2023
 23:59:48 +0000
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: qla2xxx: Remove the unused variable wwn
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilgbyahh.fsf@ca-mkp.ca.oracle.com>
References: <20230207052234.24535-1-jiapeng.chong@linux.alibaba.com>
Date:   Wed, 08 Feb 2023 18:59:45 -0500
In-Reply-To: <20230207052234.24535-1-jiapeng.chong@linux.alibaba.com> (Jiapeng
        Chong's message of "Tue, 7 Feb 2023 13:22:34 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW5PR10MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c1f6c1-fb24-4715-a721-08db0a308f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0j2coWo/UtSWjFE04O0xsAEbCwVme1hH0O4nLL0piiPkFmwE2bqbZl5601jSZwKRl0pkv8cXS6ua7DG5Q2s2sKXA9XLrXG95C/86O4ZJwWKYTlt2t27fWRIbmV4/R36985UUiyyzfCs1QvcXbM6xG6o7//8C7Zy1ee/BU1dhyN9fsdX/s3htTJJJbuf6c0+D/PUrq+107Fpyik82hHAetRmyIUAVROz2B9cOY/c/5KDuv+79Y1yf16vuleerA4ztHCeLD1j8ltrj9Th4JdlC1Uf5aqkqeJa4v9oB+364hlTgtsI70G4mA6qyZPj8U4eD1eGm4KrH+L66QsK39VQ/A73IR1VDRS22/lm8TivMBZIUYt1Mqxoq8HQO6Rl1Uzg0rvr5cjeIlX1dgJ45YreDH5WSsP7EUORFUo2qkPhDYhQ3GVDGGfIreiPSHoxY3dLpm8jf06cPHnKMqx8YJNpvXUaHwMAMLFT4WrW+QABKWiYW4OFedMWwUg2fnrzlLdwykdaDJis2XEGS0tMKR/5FFN9TcjTfaUM48Z3dT0/v12OuyGYHBIu1bCA8G4cfBYr9vyGTKYUkSIn+atlzbKkYwyZhlBHZ4lCNCp5e/IhAFNmr+v0nHyf5HGnOM6Ck1tCYLeoau5f0Tznx0QwbnDJHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(6506007)(6666004)(6512007)(26005)(186003)(316002)(2906002)(8936002)(558084003)(83380400001)(36916002)(5660300002)(478600001)(86362001)(6486002)(66476007)(66556008)(66946007)(41300700001)(6916009)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2eGSblvNXmEog65cB67zX1l5SXEAqGh9NNt9z+m9pdzSweO6LniHOJlvxMd+?=
 =?us-ascii?Q?EV7LXnY7oXw6clVMG/9hGMcbqLfbKqeEdjB61536XXg8BbXkiNoKxV9gSFfH?=
 =?us-ascii?Q?iAr2/R7H6aHFY5B5UafytviMqc1RlJ9hzUsJjIcVHr49hln5YPc0KrnPpQJX?=
 =?us-ascii?Q?GZ5r0cVuM6QGVFvRs8Zix/1WcvFEh3jT5CXIIFaH7ebQ74azouDt+Y32tcrx?=
 =?us-ascii?Q?wCws7LQ7DJmzcM6/4ESPU6qn9X/XsVQ9j3XWoTrchzekPcVkDRfx43OQqbSw?=
 =?us-ascii?Q?7utCePtfcjk+T0DqOOaeq51l+HFlFVvlm62gaapft7Cmde49ZmHiXfiQb24V?=
 =?us-ascii?Q?lPMoojVMw7EUpeG51f0CYUSMmDrXbt5WTrgthYPPziOdqpNkfi4PDxd9+LcB?=
 =?us-ascii?Q?TfWtfyLXol6CIiDkOLUbK87zi7Y5ya57D5KQHb/d3vyOQMaL8XJoQ0pbW704?=
 =?us-ascii?Q?Nx3HATpFC455NZ+qbdK6q4zG598b15uHbWOePv3eQTvC7FDlR/F5O+BibF1c?=
 =?us-ascii?Q?fEtEz2RV1OP+5pyNHWuPpY1r+NyWwhvqxIf01/n7h6MC3NveqhEP0oNDvFO0?=
 =?us-ascii?Q?zAZCZY1GYaYiH3A7meCsItr3PN+VjvwkTzqTUeEMtqd+AotNO4sQ1y/YGltp?=
 =?us-ascii?Q?9idFcBrfOCW/wmXBNn2qJBOzsGE4FLicxg59DnNWio4RZreYRf7yngEVQeZ1?=
 =?us-ascii?Q?vbc8Qy9m9h7jKwG3bMP/4z8qOdSSpQMOJLxSw1tVm6VDYwUYJBsa4QSCpY+m?=
 =?us-ascii?Q?EAEfBBqI+7vl6ACGXpKhYgFhCfK/AmwH7v2h79QhNj+sAlRyctrHeS09d/Kg?=
 =?us-ascii?Q?N8j6kw/wk1Pey3PXKvuZXgaBxofnMAdU9TWFftHoFob6b2J6d+T+nbGm1Ypr?=
 =?us-ascii?Q?LgRFT12rRyoWNXswEq7HtJK4WR2Wr5kdOrxteyvwZ402e3SdWSZcv6dBBuxd?=
 =?us-ascii?Q?epWV3GBKGR1tfYWJQVvjEb/i1YKZInPF0uZpoy67wbFSikLqD0fJtQ/wTJF8?=
 =?us-ascii?Q?O0TJknGZevVv+abxyhina7JJaZfYQO3dAhiujlKnoSYJNZcwrV8elQZ1j8Af?=
 =?us-ascii?Q?rRfULexkMxUIK9D7e6pxnaXqNXBqxCeG/IGvha5YyvI30eN5VTqAv4DhCc2G?=
 =?us-ascii?Q?fIw1M0sW60IK/YMBb4nL7oyPIbPEiZynck0efTSvBXdtz7dlwCXSEbIGijqL?=
 =?us-ascii?Q?MhwDAHSEpTGzbUFxi5UPK7gCUeZ4ffw33wvQiq6xqXTAY+o8cOnkGkKyArFv?=
 =?us-ascii?Q?i8MNU04In1ccb6Xrv+F6zSKqEh9sHyhdSIme9jo1rxEcAX6fN3iuPfGyoNYk?=
 =?us-ascii?Q?6gcV1R5xZJpekSMsL5i98GhDKKvYyfnBjNIMfiWANF76YZgikju4ipxYB0W9?=
 =?us-ascii?Q?+UeHuJG7PD/P0v1rMuljEzx745xXHm3/wAPWgGfoRfQ8xAhMRAfNuXA0sT5Y?=
 =?us-ascii?Q?oy1OVrdrygQRMQadgIfx+vVeMepFlT281kqqDLV1GJsphM4i7AQQi+qbpoSP?=
 =?us-ascii?Q?9cIwdJUuHMe9VMpoObV8gjYigsLfdTawivjj3KDjfgngXDwP0UVfHO49zQ9M?=
 =?us-ascii?Q?kF4RkAXkvHCQoxZHTYRTmoLM7Mlt58z9PuQLoX4iDxu1luImHaHrKlRU9x4A?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: snPrSj0/wZOBqFeFrXOWUz9SyrEmmmlr/LB4VsA3aOIsXTJU/CxK+jZlNDLNGyP0IvXGxS6MoqsFoxKwwlV1dyJIVKFGbCRhnvhDw+yKft659Q0MTo2F5hxJWMRzq65lQ12JLma+dRunfnAiq6ZdBDj2gqZ/z24tVX7CO+/n//tTQ505mRHGDR5Duf5cQkbMeG8p4bsNSYEOPVPGYMVnhqSz2eqRz/57yGuMKzaS3k4oUHEDomb15FgO7ktB41y84e5KR7uGiz/jgt9qeBNU02YZywhIN6Oq2ODSushGap+HVf99EqJlYiep3sQviiEKjiD66oPg/t7rwKRHvN0rmJMM7E1mOrwbTKbkiaLVNX0LkOTXXpNFovk3IL2UQXOxZI2Bp7nR6q0WrIWVfsYu5R9zDTn2iRuPEhDUKCgefVm3voYtcQFT+CXdt5IDtMyzkGREZrdL+34o+q3MhtQ9pXqXhHeTndGTeXhwS/TKf6U3yURRWi3sIBgxMyNhi2rM+97a1iJcJ5Konwk+E3E3YjO+QI330ziMuer9ci2QEyOfOJ2R2F2t7j8xmH0+zR4/r9pARhOIz5kvsOLvG1hAotTN+wHDjOF9/KZ9wU3Y1+nDlGznwp8Bz+oUKgEqG/sKi5LSdO61hHjXrqAhAZp1QlglQ8pA1gPC5dJ1JHTYtoenZfsGJk2gU4IYIRhcowxVSMxFxcL6iffUEwlB85M5xOxGHDXOPpUF1KO7s8DhBw1s6BXdMp2lOR2vqJ5CMcE8GR/M7Y9UFXR5a78cqIibgCguVB++zEMQN7PCh3+vjCEXIegTU+fbuwV+/jH2On06R1ZEXPFJ7/jCG65+9RIryZtHgdD8xvWEsdMxV4AShYwtaq1mJ7X0R+jkamujO8Bm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c1f6c1-fb24-4715-a721-08db0a308f28
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:59:48.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuMq80CeXIAM2RvTp8HoXdK3aAQm+Pvz7vF+ffk5STrsWHgbHWhVlQyzo89Ww/90xmE4ufA4HKWo1GBnxhffwfj5MuMswblY3SsbGGypbv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_10,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=718 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080203
X-Proofpoint-ORIG-GUID: SGMJK6Qbzv8aMTLPcwB4vYa28f_vdsfF
X-Proofpoint-GUID: SGMJK6Qbzv8aMTLPcwB4vYa28f_vdsfF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiapeng,

> Variable wwn is not effectively used, so delete it.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
