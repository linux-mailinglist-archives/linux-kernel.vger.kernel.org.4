Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679705B5CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiILOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiILOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:53:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E932F36DCC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:53:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CEYS9m003661;
        Mon, 12 Sep 2022 14:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=5I7eGmrlTXLWGPetO/7Qr3d5fSMDxtxuyfws7qyfZkw=;
 b=dQGTKHGPhHvwM6GzrsT0MS9uX8Q2PGtTWHYeBEZOERH9U3QNEQs8TGrwRpdVr6kQaq28
 WrtydpQjbHR7hvWQN8soAjGf+F/wTcl2bv50D/8sHyp5DmKx85zJZdL789mgdfNbD6zy
 wqKNj7u/mg/N1pDikwGBcitcXAZO2EHEf9hbyqlfJVxUNA6MCcr09KQ6kaQIy77u2GtE
 0WSRsqpmNrrefxty72WYcOd4TpCbA8+8rcKS/UgNRz4WjXlSTUdjswIc8EQp7FTag0qE
 P2RTsnjZt17eQWY78kzKOFLW/OYEsAd62j26oxot0uif0ybtGVLwgyCl5LoBTJ+SmmLE AA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4tbqe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 14:53:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CECX7r017459;
        Mon, 12 Sep 2022 14:53:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jj6b1hnab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 14:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiz5DWcThRisCRrO9l/+CPU9jJK0h53+/p3UO+mqJmcExdw0S3Yn8mzTbZ7v2wMYy8OwXsZ101epsLBZcC9vdN3chngzyskAmsoJ4gXa9pbLavGleQWBqy5z0aXO++DsFPI9Q2mIUhd6WEpqGPtG4dQd/bXHpatZaq7L06mQ4CLX/081oJhhKX1PKQQlVTS10I4G/5PKWWdllGrn+bcnMQLsPGbr3JCt3xW8ef63vD6GtnVbVg67y78+vTL8FDE+re0XAhsRQs01FiiPDgq3+YqtSOOs3zW/0dPyQEekNE9vJlipjiJN2hMQozsjiMfzBRA4P1sCOp+DQm5em784hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I7eGmrlTXLWGPetO/7Qr3d5fSMDxtxuyfws7qyfZkw=;
 b=fZLaGrrG0bbtF6yuJRczCgefdnLGesv/bM/bZzpD/eFT67aWpVtHsbDCu5s0iJA57ONE29XDbxty1DfeMDIBsHzkdcCd1szcZxL8Zs+xfuaa7lwRFXfyiK1wQC0T+casUH1ThNh2OqMRa2QaV2yKhPpbfNsHZBaGcOGgWpuvZsZf5GUhplo/8Y4XGaN0IZ8KravZhOr/C0JV+vfJ04TK4mrzI6N+wzS3Wft9KZh0C7B3xTiboFKTCgIX5FT0xwIhaFZ4jmT1DyWkIJ3Ftc/niqJmcoFxmHwhKhAkopKOUayB6DGs2TwAjf9u9iTF0BW4H1DITd0SQI9AV6+Dz8cPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I7eGmrlTXLWGPetO/7Qr3d5fSMDxtxuyfws7qyfZkw=;
 b=VoLD2m9Q8wRKG7RqQ3zW4TfCBiI/f2+fz9ljSLZyJRzGNyYDcsbFSB1NXHc9hpL+Cd0w3Lp+Mx1AU2hezFsR8JH6yKxG4DAyo+vUl9ccnTH/SJFOL8fTAXRW2cpRCcoiEB+7ZAFVh+O1UB2Dyl2KSDRA4YNArTJBv3lwkQAaHV8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5203.namprd10.prod.outlook.com
 (2603:10b6:208:30d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 14:53:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:53:27 +0000
Date:   Mon, 12 Sep 2022 17:53:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix potential memory leak
Message-ID: <Yx9H1zSpxmNqx6Xc@kadam>
References: <20220909141338.19343-1-namcaov@gmail.com>
 <CA+sZ8B-z7nRdJLhxeJ_tWSj_LBSwoFgtQja1-vDnBVdR=b0=DA@mail.gmail.com>
 <Yx8/eKbkOs8AwGpK@kadam>
Content-Type: multipart/mixed; boundary="9SzGQlHmom9E0W3j"
Content-Disposition: inline
In-Reply-To: <Yx8/eKbkOs8AwGpK@kadam>
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc3813f-b45a-422b-a2de-08da94ce8cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0XC6N/I2N5X4vg4vQkOyMxdKlrhy9Xv5IvKQtCYj0bR3ItkBeOzh42dJteaqkIIBtciz3t+5Xp1l7EdjHtwHWP2bF1OqF71PhT5us68gNHtjNb4gAaFRUwCJvwXpaSBu+Zhkzz0wjNMCg7ZxkqFTtiXtg8bptsNwiSm6rg0LI0I1Zxw8NmudZszMU/Wmf+tz8Xd5vK8RSDbo+24ZDcGwEvaL0a/i8dVYQI28tDZMBzVit5Lmm6rGRK9i07AQfa/OEzvnK3t7StQbV382TuhjHa5ZAVdDwoqKhJgZCH3jIsGQBQWk7J5K2U2AsO2ViAyBh0xr9vM0452bTSL580IVCSx3mpersoj3L+jNc4Qo5qQ95syOGVumeEziqGCp+jMhimbFr9AMigRhidAlG2YIYtFT50IDk7QCQ27VZEEJKaUM1Y154jp8gFpXL44z+JdeJDBRR6FdaFPgW9AT4TNyHTbU/VPilfgdY+3DUFqWKSeWQPzNWcTcS+JSqMBQb3Glhe9ndpNg8KtpA4ZHoq6ywyzaIZ5TWfN0jOvDc5in43JAPMdRap4mlsi1gKFQIwU/WoUbe8owZb7SBsVHy/3yTpn97Tz6cVFtOMOPayFkb6+y2/s2Rad1xSIdzBuzgrj08NRDWEnOjG932CHueuor2guQYC3uoHgpSXcm6o7+j+a5bIrenJiL0lVAQ/Lx42fKSzv7dZQZUia7lqmpkKge8q6xTnR/SKZvC0+N7p+ga6cNbBkCAEesynZSc1qB7TQriKJ5dLtm/k3GKap7gNOSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(6486002)(4326008)(66476007)(66946007)(44832011)(478600001)(41300700001)(8676002)(5660300002)(86362001)(235185007)(66556008)(8936002)(6916009)(26005)(9686003)(6512007)(186003)(38100700002)(33716001)(316002)(44144004)(6506007)(2906002)(83380400001)(6666004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLzzc/i8GrJyozkz+xqo2riDM5mqlFdlb97o5B1raL9119oqwsrO6e7S+hUE?=
 =?us-ascii?Q?PHA2kp4TEGrq8eNxsIpyV/IBwxjgd1+tyhTyRKbpOq5t7yf4x6FUoWhGXuM/?=
 =?us-ascii?Q?lHULQwQ/XVILtB2EHWXye/PrzGmSHqbl95ETwJWnqm/ht8Gnw03s6hsCtrxF?=
 =?us-ascii?Q?YrXdp8qMmwd6VuADMIBIn1UXpnXQjWcuZrhdrUZJEPGMQ/M1bo512cekC0Uz?=
 =?us-ascii?Q?OrJmMj/M8u6SXBkTYutLFYL7dXb5zfT54u4npuwN0IizS1htnYt0Wk30niZB?=
 =?us-ascii?Q?9gVv39Gcv1fVzWwDKUeLL/QnUj2Hp9ERV2GMOWLSIubGAhvos0acm10xkzED?=
 =?us-ascii?Q?LG4EmIDctyGYk1Uiqx5Hg/UYkll9n9+w4SlfjrqaR6yRMAIuDW/rCuHeFNtT?=
 =?us-ascii?Q?6Zf6fX+o39jBVYy79/83pZ0z7lUMBOywdf6KC/i7/sWc9Deh3RPcYBF4xq+4?=
 =?us-ascii?Q?Atg/Dgl8Sn1e9265xSNRTxnRfZwFvpxIimjpdD5fhdddJV9H5KnLJcjQMxN2?=
 =?us-ascii?Q?AX9YgeQjWFcOfqBRo+3yHx4K7dvMcrke5JdjAEcnZGO5gPCsK4J3lqi3AFAO?=
 =?us-ascii?Q?OBRgQU9ixWsqkMeUmDg4v22pLPzdecyMppTBBShvXqSj6B+6W2SI9kXmTEZI?=
 =?us-ascii?Q?ae7heM/+ZhfTh1nBcK48+Z/EW9Eq/5zcFUATKfZn0alVM1IMWpEXZ6rEJ5++?=
 =?us-ascii?Q?m8Q/eLlDhTHdth3DNWYVb1fZ0sDzFFGd5d2MT72g5/aDxYsutwndIljRvV0q?=
 =?us-ascii?Q?hdQNVLpw2XjMyt1j9uTrhDCLTzeWcpq3mSVnOlON7kTWh3tu2M779xJ5cmIk?=
 =?us-ascii?Q?mgqhI99aVm4TS4kId1+nS1T9qyqnCgEeSQagL9Xa4+4ARSS+krW3CiYAf8l3?=
 =?us-ascii?Q?/fWPBbs8qtBPkmVucEkkPu4ukHZTl2R18hFsNhQzEysIvXD9j172YSx+lBg+?=
 =?us-ascii?Q?rdydRnWDTnSsY5pILNFkO2aucIGrUoBDMqi6/sOxN1AN4lXpZj9TA24M7xDu?=
 =?us-ascii?Q?YgJtMC0Jrr3MV4ujLTBnP5vl5lmRdZCLmXmriQQhTbFBrXUhfSTJkMQq+VTm?=
 =?us-ascii?Q?tp1Xdw36QSpy+BrTMrcYbwYodLh/hm2ojjA8GXt8CzuCYzS4FQmf2pUgujAz?=
 =?us-ascii?Q?9GkOTj9X4fepDrAkXLMdT7cxZsWpwevo047XtcgfsQLTgvIYTHbG38NiuUQ8?=
 =?us-ascii?Q?dFr8iZSMIUrM9M5Zn1GBvWJsB8BzbIKDgQUKafUcR9z9bvXJoBmyXOLA+tkP?=
 =?us-ascii?Q?w7Jy4XG3H+iCXejzWxO/VSIv3fK10OIQd0Oq2/9W1pROMr2K/eD3+U+Faa0T?=
 =?us-ascii?Q?jawQHcl2UTqCnZ/E++nKzw9aiYI+c95TCsdyy1+gYNgqBqqDAJNhxiWVxYKV?=
 =?us-ascii?Q?13fMgeZIBPg7OJWnnSx3MkMKGH6fZHTBoWehZPk3Ix4MEW0k+lLNKJQF9ujW?=
 =?us-ascii?Q?PYGmq7DxggJhyERPC1q/lfmM4LWpUqiC2pmdC6Pxzx82xPKHcYCW6kcdDdjN?=
 =?us-ascii?Q?3ZY0ceHWsC/ANhtC9lZEo6Xo95JOKyCyQ+hZ/SwjWn+G3cM3W1AecyZyqzc9?=
 =?us-ascii?Q?qxc+asKzOQw6bEjzAc8a3SHhSiEiUjj6O4ygHYde?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc3813f-b45a-422b-a2de-08da94ce8cd5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:53:27.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xetrmYa/hwAHwXibc46TYMu0IAKgFyEA5yEbkmy/vtp4EL++7Sf2QuBnREDVSdVSPBKncrn2be12+xwAV8z1ucAOlY5aL6Q/fqgsAVSTKBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120050
X-Proofpoint-ORIG-GUID: Wz30tI8IBNdR01rVwxonhuP0_fXDgyZW
X-Proofpoint-GUID: Wz30tI8IBNdR01rVwxonhuP0_fXDgyZW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9SzGQlHmom9E0W3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 12, 2022 at 05:17:28PM +0300, Dan Carpenter wrote:
> On Fri, Sep 09, 2022 at 04:42:05PM +0200, Nam Cao wrote:
> > I did not realize this initially, but this bug can cause more serious problem
> > than just a memory leak. In the case that kzalloc fails right from the
> > beginning with i=0; then in the while loop, "i" will wrap around and the code
> > will access priv->apTD0Rings[4294967295] which is obviously not good.
> > 
> 
> True.  You probably want to resend with that added to the commit
> message.  I will create a Smatch check to prevent these in the future.
> 

I created a static checker warning for these and it found a bunch more
bugs in the same file.

drivers/staging/vt6655/device_main.c:635 device_init_rd0_ring() warn: potential decrement underflow 'i' rl='s32min-(-1)' (iterator)
drivers/staging/vt6655/device_main.c:636 device_init_rd0_ring() warn: using underflowed offset 'i'
drivers/staging/vt6655/device_main.c:681 device_init_rd1_ring() warn: potential decrement underflow 'i' rl='s32min-(-1)' (iterator)
drivers/staging/vt6655/device_main.c:682 device_init_rd1_ring() warn: using underflowed offset 'i'
drivers/staging/vt6655/device_main.c:746 device_init_td0_ring() warn: potential decrement underflow 'i' rl='s32min-(-1)' (iterator)
drivers/staging/vt6655/device_main.c:747 device_init_td0_ring() warn: using underflowed offset 'i'
drivers/staging/vt6655/device_main.c:786 device_init_td1_ring() warn: potential decrement underflow 'i' rl='s32min-(-1)' (iterator)
drivers/staging/vt6655/device_main.c:787 device_init_td1_ring() warn: using underflowed offset 'i'

Could you fix those as well?  They're all the same bug and the same file
so I would do it all at once.  They were introduced in the same patch
as well so only one Fixes tag required.

regards,
dan carpenter

--9SzGQlHmom9E0W3j
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_decrement_underflow.c"

/*
 * Copyright (C) 2022 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_extra.h"
#include "smatch_slist.h"

static int my_id;

STATE(decremented);

static struct expression *prev;
static void match_condition(struct expression *expr)
{
	struct expression *orig = expr;
	struct statement *stmt;
	struct range_list *rl;
	const char *iterator = "";
	char *name;

	if (expr == prev)
		return;

	if (expr->type != EXPR_PREOP || expr->op != SPECIAL_DECREMENT)
		return;

	expr = strip_expr(expr->unop);
	get_absolute_rl(expr, &rl);
	if (rl_min(rl).value > 0)
		return;

	set_state_expr(my_id, expr, &decremented);

	stmt = get_parent_stmt(orig);
	if (stmt && stmt->type == STMT_ITERATOR)
		iterator = " (iterator)";

	prev = orig;

	name = expr_to_str(expr);
	sm_warning("potential decrement underflow '%s' rl='%s'%s", name,
		   show_rl(rl), iterator);
	free_string(name);
}

static void array_check(struct expression *expr)
{
	struct expression *array, *offset;
	struct range_list *rl;
	char *name;

	expr = strip_expr(expr);
	array = get_array_base(expr);
	offset = get_array_offset(expr);

	if (!array || !offset)
		return;

	if (!get_state_expr(my_id, offset))
		return;

	get_absolute_rl(offset, &rl);
	if (rl_min(rl).value >= 0)
		return;

	name = expr_to_str(offset);
	sm_warning("using underflowed offset '%s'", name);
	free_string(name);
}


void check_decrement_underflow(int id)
{
	my_id = id;

	add_hook(&match_condition, CONDITION_HOOK);

	add_hook(&array_check, OP_HOOK);
}

--9SzGQlHmom9E0W3j--
