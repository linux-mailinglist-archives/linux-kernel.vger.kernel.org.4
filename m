Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042286EDACF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjDYDq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYDq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:46:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6324C10;
        Mon, 24 Apr 2023 20:46:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0hwBm031638;
        Tue, 25 Apr 2023 03:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=b2rWFrsAO/gvtm2/1RxNd1uVhSOjPsUloUYIGaDeh5I=;
 b=Gsp79k6I+ATxI2iKWqRmxGcVGCZxt13rmKweXkVM0s5a+PJ6Ja/k0UvN8aMeb91e18hG
 1nidd2JjuAE3qlEjQLRy79N8f1n9TB7YgUHPXfCKKDeUzsU4qagM60wpg1ikYe8FhjDj
 EKTQKmPqW+vYFYD39KpqYEJdT2Tfl54n2rYKb4fxfElXubCOebHHzeObv71Biwpt1Oen
 7fSAY7Sl72sSrklAd6dHUD5wb2xAWnkl0F6L7B6KEf6zKqmuEpCzx+G2H5kOvIQVBBW4
 IrkRvFEBTYYYErYEmSHi8XK9g1PKMdvH/KVcI1FtHtAs6fOQVf5QydDaSs4lq/19TVCj 1Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c44cg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:41:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P2136Y007445;
        Tue, 25 Apr 2023 03:41:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4615v5a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDSdvf+nfqnp2mTwDwc4bzxAgCKVG4mYww7oSDtZ3KnilnjHKoUgqoS5zQ8EwkBFeEc6XDIKkmW1Vmc6A+XpscuoR6dNX/n+yZSzbYmBSm/eV2FuU2BcQCRLvhIqYhIiEKCcG1psQ9rBfJAayqGLqgwv/fRfawiPJSHtTRZbD7kSXaAeUhf+TQLL56qa1QBUI1iNNIdIqq6XtdAR+N+jRJ/TvTgwN6XNDo16KoWhJ6PxVWjy+ng2KIbRJ4vdrnZk6FtPYpj+i2PM2DSCyEamCcGAb2WuYBW/0txN/NrxZy5IOSR1RtntfDE6wwxiHl6YsxFXtoMvWtGJEKRAKrUTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2rWFrsAO/gvtm2/1RxNd1uVhSOjPsUloUYIGaDeh5I=;
 b=DmzrVd/S+X1BxIlro3KOiFC/l4WW+Cmv/8Oon33D3C04gSZN0ugPRA3InIkbUVfSlU0iToawB3gzK0YmMUQtgQt/BvAs5UJjD5Ou5Y9ZWl4vpw5LbBgja+VBQQkfrOPRWJFFKjPFS0tX0ow76iBmEbVt+M5IvFd0vxeH7l822FE8cxup/sKfY580Hwt+In11otLBS1GmRUnty5BDwT4vI3yyHWs+/Uuoc/NaDEzx85vKQqHH7U7/BKIoaBMzB+q8GjESCcU9DJ6+RSsFjLbAzzx4RimeG6qGRnbodSeKY3nUTXZ6c2rJzBGpWA/xJ6XEpDzKa4eqannV60iBvz07LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2rWFrsAO/gvtm2/1RxNd1uVhSOjPsUloUYIGaDeh5I=;
 b=CTIRmPdoOydq0jJy97VE7E4HS7/aMZr25mxUBPYc5E8FhAvd0p38gtFYFe2inyrpncQb2xDBW1OmFVyiTo2TXdAiQZoFasUrsW2OUBCb9Pew6KR/BNIv/vAWg4BczGSORLxtpK4AtW3Z4M44wIDt0ZjuEE7t6QPXkR1bhpTR7AI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6068.namprd10.prod.outlook.com (2603:10b6:208:3b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 03:41:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 03:41:46 +0000
To:     Jinhong Zhu <jinhongzhu@hust.edu.cn>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter <error27@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qedf: Fix NULL dereference in error handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs8ok4v9.fsf@ca-mkp.ca.oracle.com>
References: <20230417135518.184595-1-jinhongzhu@hust.edu.cn>
Date:   Mon, 24 Apr 2023 23:41:40 -0400
In-Reply-To: <20230417135518.184595-1-jinhongzhu@hust.edu.cn> (Jinhong Zhu's
        message of "Mon, 17 Apr 2023 21:55:18 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0691.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f517992-d5eb-4433-1b16-08db453efe90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4G9O2WerRIHWshLa7GsO01DnroKFDF6qLFla9dP+acdYHWY19HsbCwUuv3hV/zzE4NIQiBsqAHzDs9Uc40zWmWxoZiLotL73xFkqVJcrYbt47AWFSRB1+JBzVo0+L1bwFnl8dwCKGIorbKoht7otdyrMGdH8O7obhhwkHPxq4Ego3c2QWkFc7t0RhGoRlSw0Wu/7SfM0tufcxjq+7fKvqwl2I25zRhQ9vp4QYQlsYz8hrZwRUUc+4Ef+97MqQ7i8PGn5wIfHdwcg5DVTA8X5OlIlaO6zQOWHqNNe9Ei+lE2w4emV4jAA0AELKIbxw3Wf/PirnPsyVS7tjVx7XeV5nA7qaqy1MXKiWROmDEZH+zoLqhwcFeAi+M/78T7hpPHrTzI70snjOXsXPpwZUNwJ/jwOzgtbVkO3DMdGvCbCWgMae9mjgCq7y2HtnfLrA/0BQvKrBqC+ZimSUDe/8WROMYyl2es/B6Fr6NlTEIoFvTofvEa5gam+RfU4pk7WzmCZe9/ycippv8QZg6FNZyfSBYR7q2j/TKd/2SUib1V/PT4nR3wi5P9go48V5BBFwP3y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(54906003)(558084003)(86362001)(478600001)(38100700002)(41300700001)(8936002)(8676002)(2906002)(6916009)(4326008)(66476007)(66556008)(316002)(66946007)(5660300002)(186003)(6512007)(6506007)(26005)(6486002)(36916002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?za0NZm1fIIpQzXe4jF1Udud1iQNwQ3H5BXE2+Izf0flk4Dm1xbiF6P/nT+i9?=
 =?us-ascii?Q?ZebrT41SrVWvZZytRmzkQuWrb8Megn5ADjkmJFs0cM+tU6ljceNacm/KK5uM?=
 =?us-ascii?Q?cKM5kQ2gbG+Hfb1pzYZuEiB8d8tL7Yd8+hR50pBWJsvoH+DBnsIYopcKBlGY?=
 =?us-ascii?Q?31j53jWbSa21ebXGqF1scJrs5a8o4JhCsuHFOWtweogbA9jMgGAKpbZTChet?=
 =?us-ascii?Q?Xt8isKOCzgCTDwf6783CvpsjBemuYFmAt0/5KbxKBi/roJpFZVuMjmO0inzA?=
 =?us-ascii?Q?+9JHKpfV4Y6U/Hv89UB5Ao7/CJPzpPLGoacIGrrSZBavhApR+Y3gnVQ5RdII?=
 =?us-ascii?Q?LyKmwKsUuYyd4eyDEnxoR4QEp84h2ZATlNbUuSmsQSHV4G5BScp1uBkkjlTM?=
 =?us-ascii?Q?H0LZsxILZhm6KYg56/U5yi+3vb5KvLMkL0lVO2APElakuWjBpJ/TD6ssDWz+?=
 =?us-ascii?Q?ZGBLAkKw2ZmcT7xm3WZOt3NcjAuaMx5snQEL72jcXe7f8VGThHZbmB5z0Bv/?=
 =?us-ascii?Q?03TyUJWijMrkxiXgmKKIXx/KB2G8dbRy0BUCjsox/dL77wi9cLH6/0QTfB/W?=
 =?us-ascii?Q?QgqAs7cuV1ATSmW3qRrvhDCo3lpAKrauu1+oE64pst31LttFbrWg2LE/TcTz?=
 =?us-ascii?Q?RTzmIA5RDZ2ZEeU0aKIaTULinsmXP1qOZFhMudVhfe2ZNbAPU3Wmw+e+rxQU?=
 =?us-ascii?Q?ie/YjVyIKyLbohexUI/94YmJt24Qa45VRgwpzUv8/58SEgnpOEOcSbFxWkg5?=
 =?us-ascii?Q?SiNkwPcZJEnhw+qVwmKw6lXfgmmwzZiGwIdVQTr64oSLduP7veq3RfJ2G+TL?=
 =?us-ascii?Q?yeIIffDpQrvMh0JDgddUx1XpXMSFbVQBNTy685H+Db6PHKb2Gqld9O8nznAI?=
 =?us-ascii?Q?z0BBTD/p4PgeUm7ARPcyz+NutT9vhz8DrG79wKzfo6a+5GeI6/w7wuQGuNMW?=
 =?us-ascii?Q?T+KFER29eapUTCWjF+Y3ZSw9a00bYRR53qw4yDJlbmeqNeNtE7GaUpINCUGu?=
 =?us-ascii?Q?tk7X72IJgQS/So+LEIVIi769ylXUPNFrrxgBs7kcr1lzLl5hAQin4nuEkHaM?=
 =?us-ascii?Q?RWYoh9TbLmEZAj0RrqBVFgWvVkyPy00YQkhUlgU5EMcKEipibpylrCqUPVfV?=
 =?us-ascii?Q?GIIYYj/lX59bFbG/YC5V+Podj4QRuHOFbq4eTAvvHU11kHQA7ope+R9wAMsI?=
 =?us-ascii?Q?trie+x5ETGBdKOnnAPSxr51bjmLW1PLFPSWUaYN+I5LGpZbfEHWhlntCBLWd?=
 =?us-ascii?Q?ieb8C8aHrHXGm9jSjOcxY3WZPEDHzBxotyCnVWJHSGk/QQLLCWXyy3X5QiZn?=
 =?us-ascii?Q?7fRr0pFHyAnFFGzWRT0rO9RwBLtOsB++vLCYXwWTvlxwRocci4fTm3E3Dudh?=
 =?us-ascii?Q?l6aYtFPCNJcrR82TosGh4oA6eRLZLaouyc6sDwQvcDY+US7d2nWXW13cfG+b?=
 =?us-ascii?Q?BDbTX0S7wJTb5a0mOjHHskeT25CMEAlknU7pAVMcQKIrRMlzSVDNeUz4ejEO?=
 =?us-ascii?Q?n33yb+mw0s//V49BFnjQ77bweHvoiWt4ymJj057MHBAhjcvTBi0aMwXx9HwA?=
 =?us-ascii?Q?3nB+nk1olxGcz8iq8/p/sbwrRpb66zj47RyRfWSgnXLzJV+Abb72NS9otrUc?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HFWBsMfTk9Tqz/IYhNejdBbz3QyCkMjZzGly2XXxIJ6EXE8q2XQt+xsxGtGpHhodpe3rLWfh7zcWklRUitvPqhu8ARfjkm8xSN1CN2XztC5/U2qFLnJn8Cff45I1RED9Z1ibFBKMceEPIwU/l0OeaqihK/cGZFBZTWcLJ6Kw2vUdyrb+E7LpNOKcIPSL+Ckr/foZtnsnuvi7AmLwt5OMpslSjQcF3Xwiy3dB3Om1DrpR87otOEhM4leVQW7mnPQLMv3emIgqF7Pn7HzD8QlotazV1P85FCGfLKripHhIMJ4KLJZz8AZu0o9NPERM9XEHmHFq+y3MNepv9SbOoEFNm2VO9OW73eEiZE3hj8vqUdNcUqFnNVyGPBW9gJzxW272HcWh4pWQURWTOTXv7AOIZPmfsyapZAh+ffcAyRfmIS5OVTqiBPtFe9UNs2Cj4TclXTJfgaMtA0+eDPT1Y8OIijxVuDkRytXLMX2PnaD2JuV/s9DLP0aj0sfZfNfSBKzdUPA4SarLO2p1whD5nlJBVqcZ0sjNfo/wxSNVqadtil5mBqKo7KsNofH4dQnOg9DkmvUMRL+p+BZ9t/RoQr+AdkK07nNvllFHefr7r5Sc8+anrqBAr100SH9q1uRLlvbxJsisQ/jJtDe+I96x11+OM5rMh1ukqCDXOEbqoPk+KaqGpH2NBw7tZBeLapfVdHIrNl8SbbGCPlZEsSyEWAgZVKgr5Tv3MoTuTKfaqbMKv/o6mE+MuvSFBN4o+PAirdAiWm+KBmtXRqNQmHSLQOJEpBJypvj+JlN2e1WdBGA2GXHD4opOko7dIp3eComlP5QEG84Pg8pJEIgpa6rx8bKrImz0eaPcuFRE1r5xD8qwFxbgFj0VGHp/0Pf35zZSAYs2bApYWnToAqjP7VExqfyRnw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f517992-d5eb-4433-1b16-08db453efe90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 03:41:46.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 860agKuhVSlLMLyhHthRmTVFGqbpv7q/XpxJpPc4FteM9DQrlQMrxsS8Ei0svX3+mIE7wlvuT2KsucJA8qi6+oq9W3wxCsBzOSdnK5itzC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=863 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250032
X-Proofpoint-GUID: Wfkz0EX1Ismkyeh6xJf6vsc8v35nPWNf
X-Proofpoint-ORIG-GUID: Wfkz0EX1Ismkyeh6xJf6vsc8v35nPWNf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinhong,

> Fixes: 09e062ce83cb ("qedf: Fix NULL dereference in error handling")

This commit does not appear to exist in Linus' tree.

-- 
Martin K. Petersen	Oracle Linux Engineering
