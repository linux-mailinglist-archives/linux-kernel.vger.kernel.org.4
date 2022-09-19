Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDC5BC35F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiISHKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiISHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:10:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B51DA6B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:10:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J6kU4u014687;
        Mon, 19 Sep 2022 07:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=j2yUVh25HGYepONSrJFL0OTs9R5quu8K5N5vB2G1RNI=;
 b=iPvFXy/Nhym52Fd03WRTyNfk0YxScFyMSrUDOjUu3Ok5dM5TNkWziFqQt+bL8IGmByX/
 NrbYe0H5AMU2iUYqHTgulSI/ZB18ql8yAdk2vCsqNl8J66JVCtigHmdPiCH71562WSVF
 WYqc7YzlYfeW45GN8cQ5ve3HtNebZtI8TznRk7zKvBqMEzPGUEyOmBEy/j9D9dkI9BXl
 wa6Fc8PSnRLg2bacbMc9Qh91jVPwHU3vC7tgTTkyCJ1XLInrqO2UPD9wevhWIsunZy/T
 Xhol1o9aTpvAUh6eeuOg9KDv2r0dvkfe+iP3tg732azhvgMBOiWe2KOMm96us5dAEpcJ Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m2vkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 07:10:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J4gDPF019189;
        Mon, 19 Sep 2022 07:10:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d0fyud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 07:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuMGLzw0fmx6q7g7lzA5AZforzJRfje6MeGtfYo/cC78BbuIcrDt2NVDIcU9+n4xVjqq14bapeQ1JlwnFtJQmSi8QKqiJEpFwuZWhY2wcANeqPD73C4JWwuz3D2ykRte6Atz0QDZBuZrT982wxTsF2bYhyJzOHn6nzrHpShvHiGwoGR6sap0fQnWg4h49mZG9rkXKC50AfX+iOp23bY8bEF6UvCvmFF/Da1eBvKcF0eeEfTQhVP9GT131fKZLySfGzyTUwcPMAvKLKdXv5b+tUNY1b27HusSGgin/Yj/3innwDR5IYD5/ci4mPo3NzDD7N4SY7O5AC8b33OdGzTfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2yUVh25HGYepONSrJFL0OTs9R5quu8K5N5vB2G1RNI=;
 b=l2zdq3dSSA53+go156a84ePq6baGynyhPfC1K59cHYqV58814zKaVJ2m7qHPMIcTY8hcl5ac1tXBPdxMgF0QeKLM4ymMgv+53HXyv3vehTrDYJCvalk4gSgdF38nlSYLjsgDI+WZm0L6xEt+22YoKUF3KNAWJuXJb+hDKiOc9ol/yGCFR5J928m3oh10CKw+AVyoshdAumVapoKJ++cwqjN2SfD4naEBN9yn+k8JUUvXxv0SBKaTj8G9E2JHrau7YE4zPv5UgWchhX+1L0y740ODKhR4oN+0saX4HKADfzy7Pky9sxRULMOLFg9VLD5lfWdKIaIJOwjcV8nn3/wdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2yUVh25HGYepONSrJFL0OTs9R5quu8K5N5vB2G1RNI=;
 b=hjQVR3JjzQOl5A+qOHA1qMn/r1CARxU1fS0UJol+rxWgO6LBAXPhudHKgfUd7nhLP6tHvIPgai/eSr//Fy3zxG/XlC8ToZQ+T+3ZHsWBLY1NIoaDSm0pvFiXWV6agnnQ6JMb/s6GLf701nTNim1zJZ71g448gEubKCYzy0s9Zt8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4790.namprd10.prod.outlook.com
 (2603:10b6:510:3f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 07:10:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 07:10:20 +0000
Date:   Mon, 19 Sep 2022 10:09:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: rtl8192e: Remove ftrace-like logging
 RT_TRACE
Message-ID: <YygVsmIFlt4IQ/E4@kadam>
References: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4790:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edbcf4d-23ef-4fde-10eb-08da9a0e0313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqktwEKPpYtFyRvRvo55swcyMJl2Li3ruXIMUYnnYBKqJx3ctaGdKznSbUD0bnJV2LCM9ImrigDedDs8s7qg16nVC3X0tIs7WolFy+RP6ZJq9k9SY+zY1XOUV/W9wkifFcxNM7bQ4EVGaz+IQi10egyhkAN7h9Udfben5e+Tv40qeUXf8uiEguoNKZmFKIa5UOigeNa3K0QZtoHeNIPXo20qrk37cobh5lRuYSEe4wfHB5BGjT6tLgapmzd5aHPNUSWP28s9lvHS9nRvmT3Zcoa5QuiwLJlXyWv01iNYCtuztgrDOSlE/smPR59iSTSp27fTYe83cTOluEv2VL0b3IDiD0u+1/KqRFAmhvwBSuKylVEBcuYVV9O9mp+fQQPUQfDi40YTuaUSHf2uRIi4AawwZ/yyuRn+quZ81m4cTcHLEcwavMOtRqpXMALP28duPRuAuDpHjztR3Tw6c3vUV3pl4rKKz7LwC4ADF93gNwMLjRb9gFrpoOcbVM5OumvjCoCjWE1G9TMtw98wdU3AfzbIv/CZf2XTbhqqmhZYfh7HhcxpAl6dPgG9K3TuBR/3u56t5HLHiWqip9zHPJUm+3C9IOgFe2H2mtoA3RPNx6/hEvgYkbLOki3T55BzHqXEXPnmUszItCdtas6Z+TbTqyEzTN5gE57Pvtcacugxf0z5++U/Cuciq9udK4DfQCIqXbIbVF31NRDKCdgBPBoj+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(44832011)(4744005)(83380400001)(5660300002)(6512007)(33716001)(2906002)(26005)(316002)(6916009)(478600001)(6486002)(38100700002)(41300700001)(9686003)(186003)(8936002)(86362001)(6666004)(66946007)(66476007)(66556008)(8676002)(6506007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fKBjH+pQspwYSQkldkprghdLLk2IPZtzu8RU4y8BcCaB32VwZMdpfauwQi2S?=
 =?us-ascii?Q?xN0bxJE7I2AyZufh04SgHI7gTUlsSstUCJe/CQNbhiM8Vkv6NJzpmlgvrt0Q?=
 =?us-ascii?Q?P6BqWnRLS0zGNkQNP+hfGMKvs2vJfo7cT5Py5fibNYLL+y2NrO48oFs+kj6F?=
 =?us-ascii?Q?LxHwOXoDEeUe8Fd5DGF8uDlDSTZtdww1HxfDbSnqN2UlZw4k3IXyqnWf9QIQ?=
 =?us-ascii?Q?sA9byB66FCAW1rwNQrLmiDRaf9SDVtqn4DgXYrXRPinlXqWa5Z9EmphnWNK0?=
 =?us-ascii?Q?Z5rRJDtkSykqr81EsqC8gi7vjFhfKPQtA2diXCGvSbGzjtFmXg9StDE313MX?=
 =?us-ascii?Q?kfIdkcP1RoW8oTwiTQWvKGBNSrBxNCpMZTWg6DsyvZQHOjNC363UrkIcgHpk?=
 =?us-ascii?Q?PpVYwkal8HtmnLRGhi6hjZK2+Flui27ZB9p05a+xA/mdJH1xPWYup8bUnU1B?=
 =?us-ascii?Q?F7N708OSnH99oK8puwLkEk3RHIPRwU6HwoI9T71nT5/XNOoITNziwFeS/VmL?=
 =?us-ascii?Q?SpGMPhGVQ+/lMm01UgDA/PeBQJUolJWjsql7i7ZwGWMoqNomsdf//oECtW08?=
 =?us-ascii?Q?mYEsFXF1F1czD4sATwT2YenL36PTPsjFsvEEko/ADykHC35haukYUQZFAgja?=
 =?us-ascii?Q?qIq3/K+4w7gBpybB0NmQ4TogXYQRFYRuEPOhlzkysF73S/ENsze+00Ar8r+y?=
 =?us-ascii?Q?UjLcQfEzka7Ex0HnYG/I1UATPRyapEWbb/BWrFixm/om6jiS+EN4WsjolBcO?=
 =?us-ascii?Q?++vskkJHSYH9mYQeZ8bZwHOxUJisLfSGWDgBTSFN12hcsoitKmZvCS+1q34l?=
 =?us-ascii?Q?vArXWoTJdTg52SOCiyZgUGUlQWOnkJvpx0b2uHPxD2sw6hVxQaEH7YHOnzhk?=
 =?us-ascii?Q?Dwi1cxUw7kM7FlezuNvlQaq1C5Ny9ttZwGNJXuN5JBLp4BKW1KOuOz+L9Bhd?=
 =?us-ascii?Q?8CyHEcdA5K28g2aN8N4r5hmNa5qH2f2C5FDgiI1AharqAb5f5RasgZ0gTdGv?=
 =?us-ascii?Q?3GZ1oVQHr07SIDumigZdiMwd4WuPgxV7wEVFmfIYaiQ/Vzq//nyn6WO7MkLc?=
 =?us-ascii?Q?Y0dDcUwRhDjo+5T0puBul6C55bzf46VS2PXOD0C9lkfEb+x8B8algN2NX3Of?=
 =?us-ascii?Q?HGR6hMMJxQDoac1UUiJBc2I3nhNdeO7oThdR+6TMH+FpzpXT26bGaubjeF+p?=
 =?us-ascii?Q?ggAXUpIYpq7tGALYeYBHtWxfPsxyakyJMu6G7jTS1EFPPTagnnkiFMNh0YkI?=
 =?us-ascii?Q?OlMBoadnUBZoGPBsPxNyMKyQU/oMxJMXCkfD6cE/BoDfaKZLQUnc/fFXpbjX?=
 =?us-ascii?Q?krFhLGr+bcjU3flU8hfA5Lb0SQxjB3SOBYU3fKJg1avQIAIZKrRz1zVgPGDB?=
 =?us-ascii?Q?R0EpepxqPxZ5wGJnUkzfqsRoAib5zWZe/l2kqDMlPUy3g6PBc82Ia3pIGh7J?=
 =?us-ascii?Q?WDy8gJdRB3cVOTET5t9/JKna/FHM178+/pckyVA93MaxbegqYgJay0UVtRjZ?=
 =?us-ascii?Q?kD5dkcjD9mhjjReugFvN9TMgIuM34/XfxDpNmO1Kz3RSREs1OZ7Mq5wB9qAK?=
 =?us-ascii?Q?ygrGAlxjwVxEQkMUKJqgJrc+JuNf2vNNlDGr1sjT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edbcf4d-23ef-4fde-10eb-08da9a0e0313
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 07:10:20.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nE/BYU53FR9fH5Zfv25d6KF8YzR5+G+p3v2UYsWzXxCNlwP2EJQfWaLHpBQ7S+Y0jY23lmKVe4ek3H+UdvZWE9huouhENPcbxd71LmJygEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190047
X-Proofpoint-ORIG-GUID: hR9FgviNX4WpbeHBwPR5TOyZ-aIdZN6o
X-Proofpoint-GUID: hR9FgviNX4WpbeHBwPR5TOyZ-aIdZN6o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 06:24:53AM +0200, Philipp Hortmann wrote:
> Remove "Unnecessary ftrace-like logging" as requested by checkpatch. To
> keep the logging would make future patches for fixing CamelCase larger.
> 
> Tested with rtl8192e
> Transferred this patch over wlan connection of rtl8192e
> 

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

When I'm reviewing a mass delete change like this, the typical bug that
I'm looking for is deleting extra lines by mistake.  So I go through it
line by line and make sure nothing extra was deleted.  It's not
complicated but it just takes a while to check.

This patchset will introduce some checkpatch warnings about extra
curly braces but I actually prefer if those are fixed in a separate
patch.  It makes these easier to review.  If you were just deleting
one RT_TRACE() call then doing it together is the correct thing but when
it's a mass delete I prefer the curly braces changes done as a separate
thing.

regards,
dan carpenter

