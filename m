Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B66DA4A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDFV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:29:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527761B0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:29:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Eo03I009307;
        Thu, 6 Apr 2023 21:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3Ttdu0nAmfvHHlSJalLAXHkhtSIWpqws+sZYU62ExNc=;
 b=UtI0hpGCvnR9eyCxja3BwAzyvuSOuulVYiqau39Jwae7sNLnPYflshZYyuvs9ySOtPO6
 Sd1MN0FrckKIMf/7VlEqqwFCiK+WD64Df0em1VpXLec1kB0nVmz/XWatBtxID4IH9Yj9
 Hp+rpFqF95lG37QrWKB2EbxniIqgsddwg52umdXkANcoVM1qW414NfcXufrEXVzq0cUB
 /M709etR3V1uX8FB3RCSeAmRD/Gxt2MqWXZ/urbaECBK6+dwNYWZ9gAx2SWiREvZX+P9
 DIebGtHM8bCFOY7uz3g9u0e0/sq5yjJgKrDfeBCnay0Ltgn19M0/TWdHDuX75DfP9PzC Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1duv0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 21:28:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Ko6S3027442;
        Thu, 6 Apr 2023 21:28:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptutmwu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 21:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7pU/eN0q8fGo88NjqZdUZaAxFEAD4GrAwpzjXhltdJDkBr5vYfBW3TYyEsg2MvZbD0oPGzjPzuQAQlQFW5Qs/aD3bmuNjfQD/CAiOCsmw272LBn5h3yuqRWM9udI8GblEIoDM8MWU4jWTMs3b8GYh4FEtAfrvvgVNPPAMoJO+fV+a6a1aaOlsrjybkVVnxcBj1EOjDSgViMok/fNy9d+nJ4iDX0AWyuQd0OiEDqRUEGUjpxvkLzytnHDpKAtZXlTAR/4LyxgxySms4f1icIUMMbno15SvSbLcuAh/cEwg4ECO3lNUz21RvA0UVbaHhF/cZaVDhHJREAu/FabMZ3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ttdu0nAmfvHHlSJalLAXHkhtSIWpqws+sZYU62ExNc=;
 b=PDisEOHnb+fLPwdA7Adx5yOGj30PlICoOKQxf0ZnIUBiGOanphgMxk3QlNuVERvFNRBZHq0bCdWAnucKZRs4MplMZ1HobQjnUv998VY2vaObon2tjTQxBSDC115b/8WLZ5L1aJPl1nyTz5k7Fd3+l6kgO6kJHR+9twmupWptpjiAgNBDec8ajFKzEhq22z9TnN/toe0MupOzht1o6dk4ZGdI5x1qwPXQIgJb9PkoEDVp1xP+louvNxSiIDAQuvrx0swXe4ScY4QgN4nNk35LQDWmSwNNE4MmSe73KjWOhAdV+r572F4rhQOJTeuqQo5aIztqB4VPMKi248cymbr5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ttdu0nAmfvHHlSJalLAXHkhtSIWpqws+sZYU62ExNc=;
 b=lBr3RNPtlRe8yiZoeiI8Yn9HBoRByJF8HXqo/EjXcfqcig3h1gnTuj1RWPIrB/szZTPZnR3JVegDx6CAdAgY1ryrVsNx5B8LGMmu7V6vP18Cd73f3qHbaqtN5zvFXB67nbULErD6a/kqpS38bI3+IaVRIYoRXrM+9jMNFENjNWM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5869.namprd10.prod.outlook.com (2603:10b6:510:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 21:28:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 21:28:51 +0000
Date:   Thu, 6 Apr 2023 14:28:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        vishal.moola@gmail.com, muchun.song@linux.dev,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v4 1/6] userfaultfd: convert mfill_atomic_pte_copy() to
 use a folio
Message-ID: <20230406212848.GA28429@monkey>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-2-zhangpeng362@huawei.com>
 <765d450c-2ff6-1420-b94f-528d56bffee4@oracle.com>
 <ZCXOv9rz8GCrpbMk@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCXOv9rz8GCrpbMk@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: b8277218-126c-45a3-9371-08db36e5ea99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8DrPV7ZtipKBKxFx1RBfq8+6ztwyiKsdfLFRdBEhs0+pRFzI2EvrkonsUsW/LaPiiTk2GoHFbF6TYMZ0Ik7LryH8Z4PukEkMYiaR7kCiW/XMcOhTP9qPnADx7ztlTNucuMiUrO0JL4jcnA0v/KTuKLPnrVghSsox4ecS89wDWINfqxPAeSCzvMi+yowRxZAfWHNaXW71z8+OUlFR/mmPXentzXTUN87s2UcgrPX5a5X5KhYrVfmDSCLz4ax3pPOd4wRosLJrTAEpYIRc6yPbJ0OqLcgMBmynmjAWZAYpIWs8F3PNJ19d/jdCkLdpUx0sutBTaeqx4vRRxI6uwuN7UjsIBGcKkXQJu6lscCaY4WyeGbjx3bfs1eOTYJIZjrMsBCCNUk5uPbuAH1XjVPIqOIFk2uGj54T4swtWFoUO1yybfpk5GC7+Qs9DoUCL6nQBI/beesG12D8xaqYYVYmlMw8y3QeUEaWttpsnvqICqKZxXFTkCkiJEbfc+O/RZ8d4N3JmE9MrGvarE4jEVCgygbm2V5scujgKLQKXi08yEZWeFvrn8ZEWSLd2huZLZGe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(44832011)(8936002)(41300700001)(4744005)(38100700002)(66946007)(66556008)(66476007)(6916009)(4326008)(8676002)(2906002)(54906003)(5660300002)(478600001)(33656002)(6486002)(9686003)(6512007)(6506007)(316002)(26005)(6666004)(1076003)(186003)(86362001)(53546011)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2+K7sD0g9dFIzo4huHDVdeoCZGBy13o6pSkAU6txgiPXfBMK4VY8p1N7rq1?=
 =?us-ascii?Q?6dr4OwGq3HCMrGAbpILOqqJXar1GK0O6TJLuHJCE2sj4+0t+M/4xY5oIYwDU?=
 =?us-ascii?Q?sDHKSY+NVNNjup76oGdIjzCo+ux19YKcNvN644KUywXU5CZ1mZ7YG5y4YRIs?=
 =?us-ascii?Q?QBH4LU47eS+vlK7qoILrV7tjB2wKQtbD/qMUf72erCF1HFLiMEqlNlng6dU7?=
 =?us-ascii?Q?GlkbVNfg1Jzw8N4j60+2+zSAeWBNnF6tB2HqEAjTkua79Dp+gkICY1asY3Gq?=
 =?us-ascii?Q?PEB+p1fPB6cF3UWO3OGv9H/Nfl9VVqnusDn4NeCnwC1CEz/fPeRHnEFoMurI?=
 =?us-ascii?Q?k9wQLE7NqB86TeCFaMJxioRAPKQhzM1rusvbQTK2t33+jVrmo6WMwG3tyvc/?=
 =?us-ascii?Q?hZLWP23c+ehoctfpQGH/sAyN0M2MNuRt+ca+t4BpyLktc0v7fnf6A1M5r6vF?=
 =?us-ascii?Q?zXI7JwSQ/FKJW+KON5zg5eGh7pBzExdC6V7NiyNrkuo/h5eARL7zLO40Evbn?=
 =?us-ascii?Q?r6yXruyESReXLi3G2VyUeuGwyVrl1UI5za8uIMzTvSTGT/rh3Iv/3lJ92LhC?=
 =?us-ascii?Q?7YNW1k6u4/rBBl7e2KlR8SGFTpycBAT+fIib21HOwrRUEQKbdFVSAMt1BWZ2?=
 =?us-ascii?Q?tUOK6zsMEfq4BwK6k9lSIcOp7+sDMZYu8QDsUtdBF3zhJEYQ8nbObhQbzzWS?=
 =?us-ascii?Q?kAWD8wa0P564WcM6VQyJjjiWO5VyFMvbZ0fK3bm6gz6f1EjZNQvmdTpQ4fT9?=
 =?us-ascii?Q?AlSMuQi6S6AZ0rSQAuWtfxLDgt9Ymo8JMPRAK7Wb9vLcJDxXQbQ1x6dDA3ue?=
 =?us-ascii?Q?wwSAiRMv21mkPE+TVEZXVIQMEpFnOd6UU7ohBow7Fz/qxsHMAs2cMOyCbV6q?=
 =?us-ascii?Q?MdEZtBm/mIgzSEivoZm0koFIja34IZvtMnkaVpc0dmh1tBWktfxgxJ44kn/2?=
 =?us-ascii?Q?eAouKqrtS+GEk5lqNgLa07sbb65Kg2mK7TBGvDJUbnJO+fcNh6fWTJMSWLSq?=
 =?us-ascii?Q?SZaZR1X+2QX3w2+mVyTCfo28mUk1yS4ZAAwm4VAprI149/PV8MivU24IMivx?=
 =?us-ascii?Q?ittRHFdWLSJ6F9/D250PtMXtv0Zl/9X3NYG42Es0C3ZCrYlajnjMn/zahVs4?=
 =?us-ascii?Q?hRkv6KEntdVYjkXlKKmUahNuJN4iWZWy3BS12RPfVsRNUwiJteSPWEkhGobg?=
 =?us-ascii?Q?kL9R1aJ8i+45cgUigRSqVBecIaB2y0mTD5nDa5CIzjz4E2fH5Q2hN6MoMoy4?=
 =?us-ascii?Q?UCNvxRrB9OuI22q0sQbWIKdVsCuyLyWRT5EFs79qWU7EAQoEIGZVqsNWSzuF?=
 =?us-ascii?Q?2cvQgd9sb41c/4nJ1vADjWR6IRBt/kP2kS5MnmYF1oVmJTjST8OLhMHwIlOZ?=
 =?us-ascii?Q?YWBRgMJiV0XhZYwfkhKcPVbwfJPNjU+5Rr/FuSIZq9JpobShENtuYCUcNNCl?=
 =?us-ascii?Q?zb8Psb/u1zPhd7Y/VCQNDVqE0Rv49Wb6m5c8UwFaTzLMFEhr8Fq8woLTanww?=
 =?us-ascii?Q?UW0I52/pel8++OC3N+ZDcOiAq868HlRekOfbQIcKIOVzjS1BbdehKBpS0kCp?=
 =?us-ascii?Q?WlHji2TTrIlibEGAgD9MGY5WXyjWxYDGtQ07rWczqnR8kqdrK2isqC8quHAi?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+WUan0Kis7wpn1ImafIy29DsjXthf+QtTH+4FIlBrIsSo1sDJdSkSKM70tWX?=
 =?us-ascii?Q?ramsvpBuifVhFuyzBbJC1KLyr36J9p7ZA5HQjHXOzBBDuC9M4gU8stweaT1l?=
 =?us-ascii?Q?KwPtAcAIfyhDpWMM1VVx9xFfBhW9Z4Aq4RmyYlbgoheCynox9cuAhKu7Kisy?=
 =?us-ascii?Q?vFxaqceut6wldG8umXZrGC4h3xOUQ+KjCneHYUcxynnXEuqc0F0HFTNcDF16?=
 =?us-ascii?Q?ok9UV6N0I081bC+CbJu/GufRL1SEI6P1dQtj9EMfNKr3YEChA4skx2dXCI3f?=
 =?us-ascii?Q?j7QoixbLDoIBdsePX658DnrC1+oI9A1H8B5TEkr8Y6i5mslF7Dev2Hmocovs?=
 =?us-ascii?Q?4zWOX0RcF+wGcBD3pYTvFYDQ2/dPyHPrHTZf43+0pFFwkGRFXVPqDpByxNS1?=
 =?us-ascii?Q?s9EWGLdM1iSJAkzEKTOcYWo8ct575H7ZLrtUH5yplGhrA8RjN8Bd1KJCa4OZ?=
 =?us-ascii?Q?PQWBIRA3ZKEPAEqXUvJHh/udD0bVgNzP5y2UM2AIXLYnRRsB1Z6brywPIpYS?=
 =?us-ascii?Q?neeNdv+uC3qKfcP22vUzGwPusegf1lMA+3w6dnzfOj/bFNUQzNz4vdmqSpzr?=
 =?us-ascii?Q?5oLdun90dt+CgDGVVw+JzUXVDo/KMxyQK44av8+KFFyU8hrYz+Q4ZbSyFa5x?=
 =?us-ascii?Q?ujEWV0QuMR0e4rBOtqqmoxZ1/7Z8U9HVPDo9/MJe3EmAHgys+WHdOJje7Ji/?=
 =?us-ascii?Q?4NyNgtVegzFWINbE+ERPt4xIjuW4QzV1PiSwwTaLwszbCAdZ2s55Yp/MZcVC?=
 =?us-ascii?Q?jXfDFYmRJAUvcgqCZ/eQGxn2rEsTqjjG4U4Ak3T8GJ57nUhzZ3FgIZ714OLz?=
 =?us-ascii?Q?fHHdiAdrgYyKxVeyJzBnk1eee51vuw8DYYQdW33Aqh26U6vf0Vs3oLK1QNyf?=
 =?us-ascii?Q?BniWhhoBAPnD+Nr+KOQedCu/DVJuCpoDWlSovxNdrsGUAcCNb+QucUpVP45B?=
 =?us-ascii?Q?FiLGy8UIXPZNuLyLvWgiFw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8277218-126c-45a3-9371-08db36e5ea99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 21:28:51.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCE91YYN/SZs/xyijI8mJdcVbeJmdhf9A9p0lpH7oh8lCoHe5L9epiEW3MevKO9AT/RjXq0JiktYd+fU7ZSwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=756 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060190
X-Proofpoint-GUID: l2Dx_avAv6mmZwPbT-i0gdqw5i9ROI9p
X-Proofpoint-ORIG-GUID: l2Dx_avAv6mmZwPbT-i0gdqw5i9ROI9p
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 19:02, Matthew Wilcox wrote:
> On Thu, Mar 30, 2023 at 10:02:52AM -0700, Sidhartha Kumar wrote:
> > On 3/30/23 6:40 AM, Peng Zhang wrote:
> > > From: ZhangPeng <zhangpeng362@huawei.com>
> > > 
> > > Call vma_alloc_folio() directly instead of alloc_page_vma(). Add an
> > > assertion that this is a single-page folio and removes several calls to
> > > compound_head().
> 
> There's no added assertion in this patch any more, so I'd drop that
> part of the description.
> 

I thought it was this.

>  
> -		flush_dcache_page(page);
> +		flush_dcache_folio(folio);
>  	} else {
> -		page = *pagep;
> +		folio = page_folio(*pagep);
> +		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>  		*pagep = NULL;
>  	}

I was wondering what that VM_BUG_ON_FOLIO was added?
-- 
Mike Kravetz
