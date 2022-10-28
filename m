Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D15611528
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJ1Ott (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiJ1Ot2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:49:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951A1F810D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:48:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNnAI018947;
        Fri, 28 Oct 2022 14:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=X46OMOGXselDN60SbnjrDj1N9NMEQOlnMOTnS7VnojI=;
 b=MPw+KrmGDZ9pyYXFxeC/AAdWz33fMfClfjZSO/ku5S7sDF0ZpAkucpU8klQQ4T/FoINY
 wx9uJg8X8Dc/nVfuG0j+G8L0Nuknl2h16x2NupAn0M8eFJkSrs6HO4LkyudmBJDZOLe8
 gHKmHRsqxEr2iYlza2wA1q775qEOU+GPnBMisu9RviSTxwnB2IY8WnV0+UpEqKCBnw2p
 kcKl4CsgKJviCVyfdXvFDl1o9R9pujVmgzk6QVm2VQ6563Si9a7B2ZKIJ13F04VP+gEs
 URoM/O5+FAf/U8H/NxdiQZC5Zs/33yGg3eDUYCZDOHzrJSoTNSjD+sFFHge6eqVYrl0o +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7w0cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:48:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEAtkb011664;
        Fri, 28 Oct 2022 14:48:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags5j1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMQejlTcldZZ6E7WYUZQjTQblhzm2Q9iDS8Dr4GURS9EGEohszW4plt1vO7y5h0mM4Fp1ta3YUFbg++BPWJbgQwPOi7UVEvA1Nmxl7leBYpwAE7bKQmbtMR54+2W3zJz4BQwav/nX6FRkT6SWz95tgrQcDNnN4FmrX4EL6d3M6YpyA4W13vwNTMcsgQVIWkBlC00Re2iIHXGCw0JrLjAVixg8spEjwsqXWtPzPv+LjA+D6XU4j4HQlhB3ugtBhWCrdEtUW4ye+pznWtO555TiAP56K+Xh4BcMw9tnB4Y9G/HOX1eDJ9WnCgHdk4ULEP+o+4aY6fPJVxlVJw8vkCpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X46OMOGXselDN60SbnjrDj1N9NMEQOlnMOTnS7VnojI=;
 b=dfg/xt0PmGF3weVg0S7/5DQBgd4A05jAA26REEAFU9b18yw3BAuEzMF+YXDw9exbny9DesW4GhmzqCDj6KdjMmsTbMwvWONsL54O0l30Fk0hwevJTJo3Q43aRYgBlfWNkystk4n02yoYpIxo4DfIQ/UD3HUH/twr7EtsFCNz/STmgmOw6eVgvE6V8/7J+mYutyEZIjue0nbNx2Bmi72pIatYrprsLGImBy1coy5b6QdD1/QtjF7o9MSPqNidssAw9JX2kybrqOYLUIk5E0q0AQEJaD8vwDLPYJCSakfm/ff36OIDAvZauh+Y7LJ6RAEKqMMw/1zNmn3AnPOKMWnrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X46OMOGXselDN60SbnjrDj1N9NMEQOlnMOTnS7VnojI=;
 b=vHNP+vtgzPbSq1MvacKxvZse+C5V2Ih7Dp9lHPc7ZSH4DYc+Hl8kTCUehi54wtu2Ymiwr33xGXnmOqD6QvmgYt9zkn+IA/yoUVarFHlnRJX061MDgSi7k4LEX7UKmJ8E0P7gQ924blxPOiS7Q24a48ssvcQo2Jc8p876dXKSxkY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA0PR10MB6426.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:48:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:48:23 +0000
Date:   Fri, 28 Oct 2022 17:48:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Use flexible-array for one /
 zero-length arrays
Message-ID: <Y1vrq5tP3XslI5Go@kadam>
References: <Y1vNNSSWK1EkcohT@ubunlion>
 <Y1vo+TjS/mWyT7Zc@kadam>
 <Y1vq5QdBn1oQUqij@ubunlion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vq5QdBn1oQUqij@ubunlion>
X-ClientProxiedBy: JNAP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: e65c496e-2f3e-4f9c-dd70-08dab8f376c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfRm1CmLHoqUC7z/8AnZXQjtVR93VWHLcAXt9XpKv0SFpAiNl9/UBaMpPbtBAyqNeiHED0Z7aayC2MDsrPKCsb/l6l0RuM84gDGA6yUAG5YL7QSMEaFVg7wYYopScqdDaoXegG+OfURWjgxskXIj5rAPwAjh44S2bl3T3i4v1G3++LpawoecBIgzGbSJZtZiLPaubSfknPuCJemy/bm3m2ejURjxf+Ug5ucs0oZw3kkpOVCekbimAZ+vp1da9xEULEEBUsLXgHdKeSlYEVMwlKv8Fib20789whLAFRBhKIl23ZeaKo6IRv4M/IB4mMaxgf840E46hRuuRkcnLkANKUkG4/KAM1Jst/NdVnGzSFPTIbRZ7xFEPpf8DGo0s2lQKIGBk0LAfP4zj6pHxzM2qP27+fyeqcoe0osNLzQgBAUaKkjWLcQAKei91T81TKU60w0XczTWDnycMUsHiyM3gM0ehN8QIQgU+6UsjuOTGClo1D1l+qoKiRo/Yn+RfQe26wsoVStFl14YF/BW7HnvSheiHBqoUzujsc0/kMd7SLZsfuqw85wzwNk4AVFM7TXMrVLblQx7/fo7tGB7JenpelXv0isp/L2Z5cc12RoqzWtaCqMwOQs9LQratyPUBi0bIA4DgiXMIRT9UCiiCE2Em3XAeHMWRLJaUFieXIVeuVr3CgyQOREdLlAUaLV89oIq6l6Fmntjaerb4aGu7kyjog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(6512007)(4326008)(8936002)(186003)(2906002)(44832011)(26005)(86362001)(38100700002)(83380400001)(6666004)(66946007)(66476007)(8676002)(66556008)(6486002)(9686003)(5660300002)(6916009)(316002)(41300700001)(6506007)(33716001)(4744005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlpB+mcBqVt/hT4yWvhAhfanNbG7px2iJrN6lqm3aHudhL3BZrB9mzXKa6m2?=
 =?us-ascii?Q?VDm387kYNKtIS4XNqgFoLsCRX9AYKs4hnb3xev03l49zrK6DXjQf46AXlb/0?=
 =?us-ascii?Q?WpqcjNZMQvkXcBxFnEebRvDARf00Pxuh3tmTq1Zf4ldv1yC+uXktVSgD2HCU?=
 =?us-ascii?Q?UvloOmYpYJq/8jfvBNY7v0RaqJ7Dz+kTsRynIPMSweg7eg7nfJ7UpmZds5v7?=
 =?us-ascii?Q?wdZXMkPxs7esiKn6fGHWXNNPiRU4uuUC2RVTNcMCIaRNfxAyBU8gkCeFL+tO?=
 =?us-ascii?Q?zF4KrSvMHRFUO/LLTTfP2HUZTZzgcz2/ZtPZP0mSmk4LtsZZVOKB/2y2eeRe?=
 =?us-ascii?Q?7gHgmI1Lza/6dHo0WddUGMLr+UlPR09Ac8O3joCEjN2+zhdqZuQ/QBThaJsV?=
 =?us-ascii?Q?+7YanB24oyyAgzBv2I8EWqTQ1Ed3sp9NGz64hEgq/18zeVcNneZB5JgcLeYB?=
 =?us-ascii?Q?RRJ0hNMDEgAEye7vsst1HjUIcdQcWYcfUInNMlaxFtDIucUuIr/K9DVEwshs?=
 =?us-ascii?Q?IAOQoh+3MugSzBWptR+nEAWsQg0XrP0wnqYYJcqGyX4xH9eexwa/bVM3rX6t?=
 =?us-ascii?Q?/MZ714f9/B9tCMw2qXUIe5qDzBdQnD4LA2mAN64SFL0VJFj2UD2RaKyzb3wA?=
 =?us-ascii?Q?Mo24Lmns5/rIbOorXmW6rfyd/ogB1n3UvZoeNFJ909KCCho91mG/pxdIKyc2?=
 =?us-ascii?Q?EmjhyBj/XnO2eRNQReKymQ+xaq8h+GO3XYS2EG/ADt2/oN0DbnqYZ1e+3Xqg?=
 =?us-ascii?Q?B+VYOlbw1xkWq3B1EFjzHy7sABzTPini/cAv/4ouNJJv/w5J222Vr41OUZk3?=
 =?us-ascii?Q?EacR/vpTyWW6tbwfxsCnieBwEPNr1AGEjO5viFKDCXcQHCoiQNOX6CTu+RLh?=
 =?us-ascii?Q?JSCMtJW9QxtQhr+yo+0g5lQ1tDRG/eCaxBdzK/dg4Qse7WrPO3f0/MzR6hwN?=
 =?us-ascii?Q?MIQuxbXf8ukXPTzyWmKP46UhJW+44/PLEA/zpFqaN1XoVwgP/Y/eDnhxUZdv?=
 =?us-ascii?Q?zCCVoX3CTXkSVXxR42nQZtPQoPeXa3/Tcw6UwdWVfLZIxKzQCOnkeXDpRGHc?=
 =?us-ascii?Q?j6mv+0tx+/112fCCD83CoWfKH9hIpoO2mYuj+DVKwoqG4bJ+4bq8eL3GR8i3?=
 =?us-ascii?Q?ZYtGB+RlGNvbKhQ/7p+b5UTpQ2Mrenv5sBEWm26c3ZyP30FMESl3zbWNM42t?=
 =?us-ascii?Q?Ct78oM+UzM/nL5AS4rSsnFEXo/njEl1Wp8JTwhJfbd03t5s2njvOB9Xg5gB3?=
 =?us-ascii?Q?ntaqkpEJyuvWj12HQutXM+w+HgM1vUSiBwIJyvTx/PumJwNGljya2P7XY2Kr?=
 =?us-ascii?Q?xMPZkVOVHrGc8WPgizM5iwulwWqGtbX+iO1rkzKPioE4ddtY61D+x09oCmEv?=
 =?us-ascii?Q?lRKpDt43Q0lrv7dfjsHPmWlqGd5AMBCDwptu/NDPUVZv9Q+/T2hRUI9mV9gM?=
 =?us-ascii?Q?Qs0/4zksxNEzszSGhlBHegchTr98xIv3KwGfhFbtOIeB8jXdAViquvCz0EV2?=
 =?us-ascii?Q?NwFCCnqU/JNBCWZfZzoIOlDUy1mA8rmbMbI5nOye5u4yaaELTXa6RpvINqMn?=
 =?us-ascii?Q?xhIIYm24YXr6wfGu1SNrzMx0Wp2Z0c/GED6vsneFrJdy0Jpq6nEUTeSWUhkg?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c496e-2f3e-4f9c-dd70-08dab8f376c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:48:23.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Iydol7TlHMFKhE/22TVW8LhZ7Yt6M/j0fsaAHnB3R8KrzQmGLkm9ZI0kntFDTCN57/OwlxLIMDlRYI/DI3XdiMj0mw+1l7CYZcePwhDTlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280092
X-Proofpoint-GUID: VuUVfJDO9gbvzqIvQQDqEOxuK1_80Pxv
X-Proofpoint-ORIG-GUID: VuUVfJDO9gbvzqIvQQDqEOxuK1_80Pxv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:14:53PM +0530, Deepak R Varma wrote:
> Also, there are a few function declarations that I do not think are used in the
> code anywhere.
>    File: drivers/staging/wlan-ng/p80211mgmt.h
>    Line number : 500 through 519
> 
> Can you please comment if it is safe to remove these functions and include this
> clean-up as well in the proposed patch?

Always feel free to delete code that is not used.

(But send the patch tomorrow and as part of a patchset).

regards,
dan carpenter


