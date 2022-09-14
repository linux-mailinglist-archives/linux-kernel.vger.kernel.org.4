Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBC5B8A89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiINObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiINObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:31:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B63ED5C;
        Wed, 14 Sep 2022 07:30:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDYUjD030201;
        Wed, 14 Sep 2022 14:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=dc/NiuMrYfRr4DE4y2bA+FF+i6UEsb81lhEWDFAwCIE=;
 b=sjg475HqZw3dW9p49+gnxhSsqOt9xmVCmRHZa/SyWJTIes0lpZDfJMhrqA9aTAm1Fva+
 Q2Gvy5qbXPCDcy76WZgf469mI54S+M0MQj0rwCACUH7VkM8yw5CdRuPvRzYnEaVAikA4
 Goy1UMKLjmID7QDrBcuRmh3XEKGUsK5lCzwFfwPEAiv2z4UqC+lDe+IvTlp1MjMPkL0V
 ezOuUCoWar+tuamgeG3hCuJe4SItshMB6zNNY6CqT9ETEg27hjr+RVAgLz3IAjgjHbpu
 l6Vk3Iq2Kn5rPpWNy/GFGUUxA5vcueNkuPqP8YDgykBaLq2jLUX6n/LrazDFocmjmCgT fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydth0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:30:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDZbBQ009644;
        Wed, 14 Sep 2022 14:30:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyecrqyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoEtCTyoa46nexrR4GhPS3zglqX7oMrjt2yrKkDcvLd5ygXT8mcxuabmK9HVD9cD4VumDL5c1uyOvuMqCM60BAy4c7XSkZfeDFexuuCUDAnl4bSweszAJ1AST3RT4XZxdB6a0+5+YaTRNK0dsyexR6Kiv8hSXsVKYe1pAUkxzYhIqd0xSjfWETm2V84miudkl1pl3cPBb4Aweojxs8PPe662Jz3dSLzdy6/oAZ+vtE82qUp6MuuP8QJmXVuSoEO2FTsNKj8vlpuuDcUuc7DDhLixh9wKKkcMEIDDhAvdpKwslCAHbsI+AHHQDtVRQ2rNU2j0Sap229ktz74lHl+Vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc/NiuMrYfRr4DE4y2bA+FF+i6UEsb81lhEWDFAwCIE=;
 b=ddLy4zUMa/Rk+zRidwaieGNHy8vTBWlITQkig8a2fSwnQVZS6NSdsj+ASq5ImPHA/dLCPJgKY3OYqYompBILtWLDN1wkwEJJohT7VHmV2gLYKOtz+4DKDz220onSPSnmSeYYgkBIF+L3vU2Q6pq5MFlgOaYMRT5kceqCG+s0BdmvyQdNybBfV/fK+Y/AO/ffu3uJJNjPcncv1aVylePfYw0C+1AYar0JroR8TxGbdKgliEzUNH1EFQT/bx/SpOEdlH5D4y8SX1pC3I0gTb8cNG6qASrwX5fjOKcez26jlkSXQx0q4fWY8l9mCPB4xTPbKv1x5IHrvqxG7T+Lzqca5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc/NiuMrYfRr4DE4y2bA+FF+i6UEsb81lhEWDFAwCIE=;
 b=aMU20XS9CMOgdfaKGSKHKd6uMWMbOz9l3icSo4YcNuKtn9l1VFr90B4mN2Lhu5r0ixHbyvGRjDV2IOOn9g+8aEXd6Gp0QwqStOgAnNywRbFr1sDtHVJ0BSUJjR++HV52PKYHbZuM3yxmGgQmZwI6iA6bpkScJEu2pNwA1T0UjM8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5633.namprd10.prod.outlook.com
 (2603:10b6:303:148::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 14:30:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 14:30:03 +0000
Date:   Wed, 14 Sep 2022 17:29:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: imx: Round line size to 4 bytes
Message-ID: <YyHlXMHuUHBqipd0@kadam>
References: <20220914113436.1503790-1-dorota.czaplejewicz@puri.sm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914113436.1503790-1-dorota.czaplejewicz@puri.sm>
X-ClientProxiedBy: MR2P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO6PR10MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: c38d4911-00bc-4ee4-465c-08da965d9cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gyev/11tcF62mjvWbDEvioCSzRW/OfsV6xTig+she21yUe6u6abu9yQzTd6ZZwhkVSYfnzJibtLLskljdew5YfYJ53dMKdzpp5AWzPsGKFxIXvnH4HU9giCMUOD5CASH/5WYnDwDEo9/jS5wF44ByZEyqkT/JxtXl9SkwfxTiDsIJLqi/ePExLRwX/MynEZOPizfbTWDoTcCtCHc8bacdtxrCkH3ZZptbkBrATg69V97NkXLFYew07PZmJVv5qXlBp60yVmISqF4+h4m9/ifz1cWBYhBF7puDcUZnAe1TwZfUwc9uH3Jh7M2ACi9+WXuKHqJW2QY/UkN33YzgGXYc4LyunsECBTt162Y292nKdWp/xhIdxK/29eFLhXikILVQsrW5uc5kCrnxsUu3Yo2zuqDvd4Ug+kXXShETlhXx0ItLyZQ7cWVKNTOPJ97JR0EYmPgLap960BdCcJfCNQ+lo1cqgZtMghhdEUGyn3s++DDTVUMQIyjahqMwgpk4CLj2VM/CGTWrkcnFDhxTqiv7F4iKMMQGroeZxIrQ+brypdubPDefyNv0bC0+7ZlaKowIfIbHcXGeeXiFxd5M0QSNOnZOcTMwC9AJa21dw+PsB36bQfPzKQxVZYDgIM+sFVM/5DrxAXu9xMhDzRGwuSBi2QY8YXGHfFMKgt/W/lERLccbwjEKlvipbjTHxqDvSdLDLNppmMSxxaYFpCRPfUmKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(66476007)(6506007)(8676002)(7416002)(6486002)(2906002)(33716001)(6512007)(54906003)(186003)(86362001)(8936002)(110136005)(83380400001)(38100700002)(5660300002)(6666004)(44832011)(66556008)(316002)(66946007)(41300700001)(26005)(9686003)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KabTw7TeO/WKaCp0GZLPr7Ib8NB8ieoWCYwoKLbJauErgfzFjhaIBzb+S57r?=
 =?us-ascii?Q?L20lEqvxpT62KVOnlgyRwwKVI14A0fpVRxcc6pj6gBPNlGxZ/5STpk9K2zrY?=
 =?us-ascii?Q?vlpjV6qz58y7JrPBXSMpFnF1EB9XzdIun193QLCWhwF5QZJYXnhklTWqk6HF?=
 =?us-ascii?Q?GDeBlnprRe87UKLB2tiGHl+zuzrzXvRPWmF+NIVkk63oN+OWLLR0MITUsWvG?=
 =?us-ascii?Q?1vJIWBYfiMeV5eCrlzrGBaf5NBmvr7RjdovHnUpIwpPnxCZE1USayZY0czIM?=
 =?us-ascii?Q?pRX1k0GRG39NpIth757ax7ziqJX3OyQD09g2RnQE8P8odbjdHxWboHJapbxf?=
 =?us-ascii?Q?r1YwhAtZaaenowNU96tRRVZxpdai3edBv3uA4azZwCUTHV1wVIby5SoWx2Zh?=
 =?us-ascii?Q?tfMSgqYOy8P713sTPb9e2/u1UUxOSj2itxtv3H7qJ3IpwNRg847XdzbO6FpQ?=
 =?us-ascii?Q?FDdtZMZCTXEQDHvi98ZC3HAX80oJLLInwNA5gPptZ88QON7yrt9In7HJfXfg?=
 =?us-ascii?Q?q6Bd5CQgzVA492vSl4VR4bz5qjgZeXx6A5KPq3sc4O4SrWlHdlsyLJlrK02G?=
 =?us-ascii?Q?iSR0xPbsilHva6rTTrXlh2g3ulKGTq4aQcsF0n8OjTe1AlqoT/l5u95a6ofT?=
 =?us-ascii?Q?Ay7QP4d+vBAIfWfpT7QIDsFZcxPlEVo6adhsDTHHN3jvFVCZZ8OcYu1ETvDb?=
 =?us-ascii?Q?p4qHnPi7GkeKnNU3djPnKk0n743kaVLyO5pUoiCJ0rBRz5vT2aQPVDvetZTR?=
 =?us-ascii?Q?cteS2r2B5hDQWDxQf2zbEgZJluVWsZtrOtFdo4ngQq3gr3ziT0XQzqSoxG8o?=
 =?us-ascii?Q?tXiuTioAoCdv5NB8ir2u3mistC+OSOgIc8rTo7xGA3flfQAnvVC4OoceFYVV?=
 =?us-ascii?Q?FWdGZK7nPEdEiWuRbAm+VpXUCJv2/1w2z1WC8q8HiVBGV99USV7WRukQq7kk?=
 =?us-ascii?Q?UnQzIWSiznoXiALrIYlYoVOKbdgriwExk8NfEdehi4kYwAWgL6b9wmvO+HE0?=
 =?us-ascii?Q?X7hqmtjdbpMUsxfUEB/t+VDdO16RtsCTiARDqUCp/Xm3KvvGay2sEt1IxWgH?=
 =?us-ascii?Q?7qc3D8sKi4LO/tF7dtG3PNck4FeYIL/5DD2mQ/98jxk6+uLSDaLegekAvt4x?=
 =?us-ascii?Q?7REXPMykyH6mEDGzO+F+Cn3SkNEJ01usvnhBLyfpjF+UCsfY1fZSVqNDBcR9?=
 =?us-ascii?Q?vxDrznn2VuRVMl76FIrrUnhDyQhjRpkSA5iUoASXp5eTGTAUsuf+63WN6sqo?=
 =?us-ascii?Q?Pa781Dz5B79+CCnrdI7wO0xXCVt0l16uI8gjLjZYu6cGFMK7WkTI/+eMsScD?=
 =?us-ascii?Q?/3BcuDzkQwKipCJhGjxWEqhsQjl+IqUPzdqapq5GAA8g4rCLlV8WFKS4tWZv?=
 =?us-ascii?Q?qyywJKe1ZA5MDgF3wtQFF8K45ba/cJ9C7De8unVxhhSsH5c7eP7H+FbCKOjW?=
 =?us-ascii?Q?sadZlXbGDmBP3hUGRLG4SgrDi18NG27d7p0P0hfS6CbnHqWBFG3F0g78oS33?=
 =?us-ascii?Q?riCFDt4rNjX5ozDnrgRUX4KlokPdWqy9KMY0W0aK3NbJi4NnvtjoCFBzljDk?=
 =?us-ascii?Q?blzdNGNtIgjNDgbC64n0vOAOy2SVmFYBY6fcKMTe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38d4911-00bc-4ee4-465c-08da965d9cf3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 14:30:03.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wh8XKI2IqmGkSgvszlbGiJkNZN9p0QK1nSZghQhS5oQ5UQ7lGovByc4HgtyqvZXK8kIgJqsSD335fsoDpYePHdD9CNwCGZ7VDoeheLJWFAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140070
X-Proofpoint-ORIG-GUID: o85LNAwnNDPj_Wi2KA8YVr_IrHuLD_HF
X-Proofpoint-GUID: o85LNAwnNDPj_Wi2KA8YVr_IrHuLD_HF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 01:58:08PM +0200, Dorota Czaplejewicz wrote:
> This has been broken in e352833d, which does not actually copy the logic
> from 056f9af9.
> 

There is no commit 056f9af9.  Always the human readable subject for the
patch.  Also use 12 characters and not 8 so we don't get two commits
with the same hash.

Please add a Fixes tag.
Fixes: e352833d32e6 ("media: staging: media: imx: imx7-media-csi: Import format helpers")

A Fixes tag can be used to automatically determine if a patch needs a
backport or not.  It's just useful information as well.

> Section 13.7.6.13 "CSI Image Parameter Register" of the
> i.MX 8M Quad Applications Processors Reference Manual
> states that the line size should be divisible by 8 bytes.
> However, the hardware also accepts sizes divisible by 4 bytes.
> 
> This patch accepts line sizes divisible 4-bytes in non-planar mode.
> 
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
> Hi,
> 
> in recent kernels, I've noticed that the Librem 5 camera driver no longer works. The s5k3l6xx out of tree sensor driver uses sizes divisible by 4 and not by 8, for which I submitted the patch 056f9af9 . The new kernels no longer accept sizes divisible by 4.
> 

This information needs to be in the commit message.  Otherwise the
commit message just sounds like theory and abstraction which we do not
care about.  We do care about real hardware which is not working and
especially if it used to work.

I'm not really qualified to review the details of this patch.
Laurent is best qualified to review this.  He'll get this message
because he's subscribed to the lists but it's also good to CC him as
well because he's probably drowning in email like the rest of us.  I've
added him.

regards,
dan carpenter

