Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100571180A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbjEYUWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbjEYUWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:22:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E605DF
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:22:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PJ4nce016658;
        Thu, 25 May 2023 19:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Q2ZBtKRlz3E6hQCuVecwKh27yDcrRZrW/7fOEpFyq/g=;
 b=jnKE2WPZowKdwJ8vo6EdmXQUiCk1qYKCT9DIiP7lzZTUCdC/q9dTCCPoWpHgIniyvpUC
 vrTiqwiOs/H4b/hWbxCtr7O9nooe78pZ66XI4QKR2TkNAfsFnIjyQKGqQH3pcEqwuL0t
 WpMhQe5vNW2t4MxjUPflsSRpxJkWcbjlqi+lw5Jyv51hPAE8ruvAE0+w/fUqMsyBdLM9
 slB7/nFUbRCq4ZV+7TD0GZsy9oKen26SgTfkt4+/rB2NBRy0RfTjOTJxkHMQNCa1Y7N7
 8kZCjopD9wuBRDjBEEt+x24p0DntSLjMY0nKdpSQF53LTL8CsQqh/scBNEi6FbmMGPmw 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qtdgy80tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 19:15:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34PJAfA7028664;
        Thu, 25 May 2023 19:15:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2u9dy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 19:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyavO2obI3Hqh9+9g3z3+/+Po+o30goTQYgWsXOy6dVZw+lIIlNWoW0B0rsRpZxFqwMms7xVgaGxHiCypu2kZxc+PUCIpYTYOcF1bWFJPtKT5/+oLJR/UtuAEjX2lFpbkQgKyGyuncKORy2v4mckq2M7F6r1Qqe3AhXSjU2rVcZQU0ABkcYGv2/AzpnZ/Lkx6f9PK9XVr9QDOaJZWg+Rh4gV44cCWLLqfOHkwBiuSexHD+AcgrnHGlpy4rjRzSuAljIL54cWlW/6nbXwczyrY2aNvPq0ICLn+eC6rbg0bHslQKUO+7eLuuFQW4eCeHyN83G8rGCRq7Ucra9fWoKGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2ZBtKRlz3E6hQCuVecwKh27yDcrRZrW/7fOEpFyq/g=;
 b=PtMTHzfrzR2n3uKBhH21aPyaUei+jYlt9Z46T3Jvm7xD9TGqKDWZLZKBkqQvUal/W89MQFFscFNO8cOvs1rpfWmgozzCDKb6AOm2hVFUvfI+n3RQE4uUiQDhY/DbFb4t2ZvWSOZslIa4QN+o7MeFIB2m6744LmVoNrp24jvL3BuGMqBmh7KeNpaWdUp1DBIIXCjXyYEV6ClK9xZUNpiAAxwvlN/n8w+TIOHv+cH64eR6Fl2WG7Hwu8SowJU5ClmgLZzOUPMoZEgk2DkaJIg8BxaV3qx4b2efXcpgBcXNC+VZQQDIo30gyii8UbHWO20Mu4/1WIDaadWXEKVnRyqjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2ZBtKRlz3E6hQCuVecwKh27yDcrRZrW/7fOEpFyq/g=;
 b=lF5MjtumF3UGDUrtcJ31qqUnqcu7taGLPDq8XEx4LVHcgcEUtyThCsjtlt+I0BKTMDCsksyl7hq9a3jN4Xs/gUgFzl6xzWihSm+ZQ7QWsDb3PsOdykCtEm2iOR/cppTZmEmAigOrDxv6R2hoxblz9dOjNFhT7s/arq/6WpiwDtY=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 19:15:18 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 19:15:18 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, willy@infradead.org,
        steven.sistare@oracle.com, david@redhat.com, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: [PATCH v4] mm, compaction: Skip all non-migratable pages during scan
Date:   Thu, 25 May 2023 13:15:07 -0600
Message-Id: <20230525191507.160076-1-khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0167.namprd02.prod.outlook.com
 (2603:10b6:5:332::34) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|CH0PR10MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a73839b-afe3-4f04-ce8f-08db5d54605e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dddgw++26rRwt9jcy2YQvRnsy60P6Z4hPIGL7cxumXRSdlEJnlge4oYLm7UyrhPGSMV3g1AAurVl2aa+rCCPr3djeX9+ObAeKlbdArZN0BNLD/e+JTJ1Amd0vsOvQy9vqpqtRXQVo2RB80GfCOUxUYyCRNrVKsLbnQcUcxFB+3/pxOdZpxjMkzrHgYin+deWii9ROe5CDCgHRyHst1tBaaVgnV4UPC5UzDu1qH5mk2tV0+wXgt8y86Eb+fecZq4ED3ggV1Q2XYLUZXTWWP7VmCyXJk2QkBeHDTJbGWl61dcyHea7S3/x5wd3sdmsnOVw9xNZMpkpXArgM2t1x/hXbADb39fj5AVeHZiOlFoLN/VuPDYbinnFci/0mW4KRyYWJ1rkkPsxqU6y9XkW42RMjX8CMXsu4VLywTurgvrQ1uHyWpzU7xOL00nBZ6xGsrtkd102vTXXcxcwc452kNRLFNuHFL1J2pJHwkoGkq/nu54fumQHvFF63CIVgEBkaCVL31C8bqmLEO2qcLKBRSOSmfQQsaTAFJkcY5RNHXYP2g7MO6h/0GkHEP3EIeSXLLnm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(2906002)(54906003)(5660300002)(44832011)(8676002)(8936002)(41300700001)(6666004)(6486002)(316002)(66476007)(66946007)(478600001)(36756003)(6916009)(66556008)(1076003)(6512007)(38100700002)(86362001)(2616005)(6506007)(26005)(4326008)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C44iWc5HtxTMcM6USTJanJCLfb6YU4GT9e52yRn+CNo7OTp9zV5mISnWAwlQ?=
 =?us-ascii?Q?EIHB7SQqULZlvGU472jtOGp+ZsEjNjPKIL0Co5EmGcjcXkVg0o+08UR1D2pA?=
 =?us-ascii?Q?pW9b2qmnEszXPqGg2J8SU/00JTAheNMQ9fg/iKujTtNCjGHvs6q8x582ixmt?=
 =?us-ascii?Q?mDp8fZn0pM69/9/ckdtbTePDkpo/rxTMh4nOMMMfS1zAvub1CWp1b9izR9Jj?=
 =?us-ascii?Q?B/vggDp01PiUOkSD5t2ppXg4dssSFWwJdQY53zg2ds+p2KCnq5RV1ge6e3jy?=
 =?us-ascii?Q?WSb+KRM2saSKpSgmI5/CRAoADfgKqx9Q77C6zXPfjotCOvFXivgwNZA97zDR?=
 =?us-ascii?Q?Le59VYpFl0q83vdDzAhSYb+0fz73f4tjRNNrjo9uuHAOfGo+yNUtMUOc29ew?=
 =?us-ascii?Q?4vRMlm6YDJvaMM2UfoIaSAMA+mttCnaCU+mHFDGHTdFmm+j7j/2QS5U2c2Fr?=
 =?us-ascii?Q?aLTp84GairCXFkm/aHEraFE9wdLMXKE73azTyPOZXo61O9dFoxh2DUy22ktK?=
 =?us-ascii?Q?c50tTZdQ4idNhYTmpK+3dWJcvtq//wq+LLQ3nB8k/NzioR5W3PAUeyfXMjPF?=
 =?us-ascii?Q?dbLQwBykwMoWzF36s89hdVZYsnRHt/xkT2xnh6AJEdJNJcDv7AiYnqNVy6zq?=
 =?us-ascii?Q?qJk+/e7g9bNuwENmFf723bWhAcNfhSzjUjgOhuY/mCZ3GBcJpySP1H0dzCE3?=
 =?us-ascii?Q?zP5takVm1Y6O6ghsSDAyjTZ00FvpDtkTnpeLn8tU8K9u8+OZjK3reWDNOhYJ?=
 =?us-ascii?Q?mbv9hoA3Dbnul7MioSm09PwVLLoUBllrBd2ay6lmk1bkb6EmPm1Nb0XRLHuF?=
 =?us-ascii?Q?WZ12MzlvRk0Mkap/jtyI6MMI/x/Wg9pk079CZwRD6zUzhZgkMhyvxGyg7EUi?=
 =?us-ascii?Q?8WjYwPPDluSqXFL2+eoOz9UAmM06oJBN3DEz88X6aWWofXTi4jTWBEJrcFWQ?=
 =?us-ascii?Q?33Gi1sMmJ4Y1YQWyRcokjIvi8TC1sz1NK7vkoZ85ZHY/n3ioOct9HE2MDQVm?=
 =?us-ascii?Q?GbByxLuCWzrHGr3Dh9hU+PRMUXu9cIMYwQNLK51LYZa0pzR3+pg3wjtQ2lyF?=
 =?us-ascii?Q?MihyKy9jY0BBE80TGb4GjyI3OW10jmV1Lt5+XftCWbCNrVgBcH0g5l44ZqS4?=
 =?us-ascii?Q?dEgqIzX1WixOaImwjqMYZb0ASuaOKp9or3Ilsx48L1X6M1eRbw0UMMqShV2I?=
 =?us-ascii?Q?cJLwK8J2NUiD1sefFwWEakc6hrrFyCyklxmTre/5O+1Q/SZFzFUViY8NF9a1?=
 =?us-ascii?Q?yrMqM3JxukJxHyW1pgT5VSRueEsJZaWyGBDcrrhKHgDLGhqz+oDS/QWYiGtH?=
 =?us-ascii?Q?/KSEDdwJpUfwtZxj16bJo1qv8+s+4rUXXk7h51mCRlvLA0HiVK5otOCgLgwx?=
 =?us-ascii?Q?6IpbI2gc05JeKOL3mU+bMjfaRcBLhu2wQ/RDOLAoxogUBrJKyOUO1qpuzi01?=
 =?us-ascii?Q?FdapC+pmcNd6elyvDsSmRo3XNSlkAYiivg5XYQl54mzsOIEeE3Mknzf0Pfmi?=
 =?us-ascii?Q?N4/WiFXlXf7WnfOEvj8zt06m+y97HPc52L6xxiYc+IjFZwgj/CpJ9q2FqAxH?=
 =?us-ascii?Q?vFXyw994xGtVCnoRztG2k28iL6FePOBx/+lYCgb4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QxANPjB/Jo9lY1Ik8RSHl1U7u9415ygAC+2pV1PAN8yldLTNzYGpIGFTgLfk?=
 =?us-ascii?Q?1bmbSnavsaWbDw5/v2D1c6e5X8ADsVw1UjZKwdR0mWJSwGQP8n8MhtuiQn+D?=
 =?us-ascii?Q?rqsI9NDP4ApcT5AdDgeVxDLQnRes1vfUOP8b/901xS/JqqIEfbzlIWAI3h2o?=
 =?us-ascii?Q?SSIxITFhjFcwnnZwixTZp4T3ipoCHor5jxxP94NY4jwHd02RgXtyfmC0/DuD?=
 =?us-ascii?Q?XEO4qSIlspX5ReZR+VAiulXRdRnot2GkqATKwwKWI3RgvGn1rWb7hblckAPg?=
 =?us-ascii?Q?coWywkDibrZx/AcG65cofOXGLStVxGu34FjP2+u44636QGPCtlPEwRkbYiC1?=
 =?us-ascii?Q?vcwRyo0+BT1nsD+xlHJ40ohrNOOcsIwBGF9NHp9UcCOzIPcPPRki9gITqcsV?=
 =?us-ascii?Q?Wn4GSgtbO/lFSx+AVL6fcHQh4+ZXXeuSOz3bcjcT9pRq4D8AkmtNEN/jrUuQ?=
 =?us-ascii?Q?vuS5maJW+13q8ofIzMFV8Z0vAFmqPI77sOl1Io1ngX7yC1N0CQiHR2twmEeb?=
 =?us-ascii?Q?NOqy89tGDVaVao83YzYlHs/9tlsaab+bm4KFPGUDhRg0gNKyEZiIU3Fej0yz?=
 =?us-ascii?Q?Tfm7FxTr9AI3SZwnwluv66c9hc6z8aBM3eqmU9JS36T5qF88B+U4tGuEkZUI?=
 =?us-ascii?Q?r4k51/syHyAvuJlfUDHtnbb3LBMCE2y4nDMILtvmdTw7s016NLcb0mDs56wx?=
 =?us-ascii?Q?mzLaoaw7jgt2p3yhlpn5dgoshvp8ozbxcqhK0N+SYdTYQPi+2GLGMQjm9JaW?=
 =?us-ascii?Q?OY0OMhm9av8eXCJJuXX6N/SOSVNoIliFTYVbkAC2GWjCUjKP/eiK31tXTjNM?=
 =?us-ascii?Q?Ine2gL2OT0wMpM/pQcVOobK4zYeiLot6RtwxUay9qLtwhQ5OGbnqxftr9A15?=
 =?us-ascii?Q?rnkixJ6bOhwAOI4vBp9JKXDevIfk6hZJbfGhPtPxUO+I30D2FkuqgJo730j2?=
 =?us-ascii?Q?82dKRuylPJrz+Tz+okr9IGolPi7/0GsSQxrIE530A3CqlWnroxHQ8YmBLKyX?=
 =?us-ascii?Q?EI/Sk2wtF//qIHDbtB76hpW1P5nCFWOV9vUdRkEVWM8BO56TSz+NdNH0hslc?=
 =?us-ascii?Q?mHJxqJW+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a73839b-afe3-4f04-ce8f-08db5d54605e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 19:15:18.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av++eSmjRh8IJMO51LUau7jl59w60HYLUGIYBKno6HfZ3F5kwa6u/xvDJVAEgsJbtPlmna1o715h6cysjc3JGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_11,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250162
X-Proofpoint-ORIG-GUID: xHYTVsQ88q0HsTzoW6Yfz23KTJ5OA-Ke
X-Proofpoint-GUID: xHYTVsQ88q0HsTzoW6Yfz23KTJ5OA-Ke
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages pinned in memory through extra refcounts can not be migrated.
Currently as isolate_migratepages_block() scans pages for
compaction, it skips any pinned anonymous pages. All non-migratable
pages should be skipped and not just the anonymous pinned pages.
This patch adds a check for extra refcounts on a page to determine
if the page can be migrated.  This was seen as a real issue on a
customer workload where a large number of pages were pinned by vfio
on the host and any attempts to allocate hugepages resulted in
significant amount of cpu time spent in either direct compaction or
in kcompactd scanning vfio pinned pages over and over again that can
not be migrated. These are the changes in relevant stats with this
patch for a test run of this scenario:

				Before			After
compact_migrate_scanned		329,798,858		370,984,387
compact_free_scanned		40,478,406		25,843,262
compact_isolated		135,470,452		777,235
pgmigrate_success		544,255			507,325
pgmigrate_fail			134,616,282		47
kcompactd CPU time		5:12.81			0:12.28

Before the patch, large number of pages were isolated but most of
them failed to migrate.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Suggested-by: Steve Sistare <steven.sistare@oracle.com>
Cc: Khalid Aziz <khalid@kernel.org>
---
v4:
	- Use existing folio_expected_refs() function (Suggested
	  by Huang, Ying)
	- Use folio functions
	- Take into account contig allocations when checking for
	  long temr pinning and skip pages in ZONE_MOVABLE and
	  MIGRATE_CMA type pages (Suggested by David Hildenbrand)
	- Use folio version of total_mapcount() instead of
	  page_mapcount() (Suggested by Baolin Wang)

v3:
	- Account for extra ref added by get_page_unless_zero() earlier
	  in isolate_migratepages_block() (Suggested by Huang, Ying)
	- Clean up computation of extra refs to be consistent 
	  (Suggested by Huang, Ying)

v2:
	- Update comments in the code (Suggested by Andrew)
	- Use PagePrivate() instead of page_has_private() (Suggested
	  by Matthew)
	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
	- Use page_ref_count() (Suggested by Matthew)
	- Rename is_pinned_page() to reflect its function more
	  accurately (Suggested by Matthew)

 include/linux/migrate.h | 16 +++++++++++++++
 mm/compaction.c         | 44 +++++++++++++++++++++++++++++++++++++----
 mm/migrate.c            | 14 -------------
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6241a1596a75..4f59e15eae99 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -141,6 +141,22 @@ const struct movable_operations *page_movable_ops(struct page *page)
 		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
 }
 
+static inline
+int folio_expected_refs(struct address_space *mapping,
+		struct folio *folio)
+{
+	int refs = 1;
+
+	if (!mapping)
+		return refs;
+
+	refs += folio_nr_pages(folio);
+	if (folio_test_private(folio))
+		refs++;
+
+	return refs;
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			   int node);
diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..b548e05f0349 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -764,6 +764,42 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	return too_many;
 }
 
+/*
+ * Check if this base page should be skipped from isolation because
+ * it has extra refcounts that will prevent it from being migrated.
+ * This code is inspired by similar code in migrate_vma_check_page(),
+ * can_split_folio() and folio_migrate_mapping()
+ */
+static inline bool page_has_extra_refs(struct page *page,
+					struct address_space *mapping)
+{
+	unsigned long extra_refs;
+	struct folio *folio;
+
+	/*
+	 * Skip this check for pages in ZONE_MOVABLE or MIGRATE_CMA
+	 * pages that can not be long term pinned
+	 */
+	if (is_zone_movable_page(page) || is_migrate_cma_page(page))
+		return false;
+
+	folio = page_folio(page);
+
+	/*
+	 * caller holds a ref already from get_page_unless_zero()
+	 * which is accounted for in folio_expected_refs()
+	 */
+	extra_refs = folio_expected_refs(mapping, folio);
+
+	/*
+	 * This is an admittedly racy check but good enough to determine
+	 * if a page is pinned and can not be migrated
+	 */
+	if ((folio_ref_count(folio) - extra_refs) > folio_mapcount(folio))
+		return true;
+	return false;
+}
+
 /**
  * isolate_migratepages_block() - isolate all migrate-able pages within
  *				  a single pageblock
@@ -992,12 +1028,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			goto isolate_fail;
 
 		/*
-		 * Migration will fail if an anonymous page is pinned in memory,
-		 * so avoid taking lru_lock and isolating it unnecessarily in an
-		 * admittedly racy check.
+		 * Migration will fail if a page has extra refcounts
+		 * from long term pinning preventing it from migrating,
+		 * so avoid taking lru_lock and isolating it unnecessarily.
 		 */
 		mapping = page_mapping(page);
-		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
+		if (!cc->alloc_contig && page_has_extra_refs(page, mapping))
 			goto isolate_fail_put;
 
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..a2f3e5834996 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -385,20 +385,6 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int folio_expected_refs(struct address_space *mapping,
-		struct folio *folio)
-{
-	int refs = 1;
-	if (!mapping)
-		return refs;
-
-	refs += folio_nr_pages(folio);
-	if (folio_test_private(folio))
-		refs++;
-
-	return refs;
-}
-
 /*
  * Replace the page in the mapping.
  *
-- 
2.37.2

