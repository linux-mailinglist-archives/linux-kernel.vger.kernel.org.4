Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5964D6F8D6B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEFBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEFBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:15:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB42688
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:15:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhJV4028056;
        Sat, 6 May 2023 01:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=JDuz/VeuZiQAuHVcAApGDXGQHVaYjWzEaW9gtLdp2u0=;
 b=gkYQrVsiUOkoGqyUq3Y0cdpnc/rgMNx2Oafeya2ixWw9+RqPHj4eZEJG+W9KSFfH35va
 DHnD8U5zRNPRurMv2cVo6QzQXI9TlmI8hsgZO3uQHCSeuJ8w9xQpL0ijx7t55D6Oy+6W
 Ua1Tgxh7Hi9KFVQBRK76m42Bq2Vfb1wBWHhdc5qWIeq2f56Lp4/olRzSa1643UI52MvK
 kXcRxrpGK9CfWHMFnXAWJUzyxatKskBUX0hQmGAy/wEy9MSsJRhZihlPnS2GNwY1NbP8
 pxcX1QaD+v9m5c07hLknvMQSIaPZXwpvKY3NCLjnKNjbtMGB+JN/OwOm6oEAnjo8MrjZ 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t1464e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 01:14:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345MTBfr027240;
        Sat, 6 May 2023 01:14:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgtjfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 01:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FocXXLn6uYAhvvb21HJ39/EhyADu5Q8qnFC+Bt1BqobwL2uShtZcsgq7yHZuKxIKvCWlFCBKpvXBs7y92f/kRsuA/1NhgUYOszZ6Xy086fU9esEuZATmbbWHfKbRVVWrbZEuXvCDIacNUaqALg/g6pMvFeCqtfxADzcGGufNOvjrvIXeGDXVOEYisWeQYptqfmAxGkyu01SAhblXgLp2t30gH5qF1IeNPv/nrAs0szxHDoRInK0M0ATA3CgTFCOP2MksNAP+IBzItJL1mpvawgL4CKLuK167zg1DI3X30P0Xzhnlhh0kHxrld+hHxeiVgi+lavkw/GSxdrNB51ocLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDuz/VeuZiQAuHVcAApGDXGQHVaYjWzEaW9gtLdp2u0=;
 b=eHS6thvYFgq2JBiogEYYGbZC3NUc6t5fiM/doycjPRvq8V5+H9wGBxtgKzO/dv0h3odLusUkYdhOFTnFiJyou5ePB+yKjeD8TUEJyRlhW0DFoi+SxIE965qzKmNM403UIwtGHMavtH9TFdrWK4g3C0lkf/4IVpikmXOn2Eea3BU3sKewBC5M3lXi9ht/9ztjztfAHvpP+cDa83SZpIcDRbvKx9u2PRGftdIlPdf0gokWdFLV0edPuU4ecDDT46sVCJIUGtNSBuTPi/2Q84GB4zwGfP+ogWAsUs2ogL9XhkrA0RpNmF0pVBqnNl2SxJivinQGXDDqaW8X/QPbQmswrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDuz/VeuZiQAuHVcAApGDXGQHVaYjWzEaW9gtLdp2u0=;
 b=R+CF8z6UJdN2/RqB9KpKvvG23gPvY6ZVDmxCPktB7R4YJq8r5J89KsHkgQmIoMyLZLwRxtsbmepgaiN7iR6rvBsPJKoHv2Vu0ODhpvFS6W63tjhhhqevpSY8y/Cb2T8gbOOrEVSFq2XHl6t/nQvhHq1D9tWaP7uFXuEuyVYvHrw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Sat, 6 May
 2023 01:14:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Sat, 6 May 2023
 01:14:50 +0000
Date:   Fri, 5 May 2023 21:14:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Fix potential out-of-bounds access in
 mas_wr_end_piv()
Message-ID: <20230506011447.2e47mf5kwwo4yz4r@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230504031422.47506-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504031422.47506-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 27db184a-062e-4994-88dd-08db4dcf4a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXyUoCXJwgik3p/xjurgGYBCaBUGrjfbkZCTTe6SUZAPVl7sJSbSLKE+YGrteMskfoYFKU8JPAITjdc+gSohJop7J5dJDhd+9ON4s0lEZKRXpmJV3qicEGQAP8G6hvqnVVxAo1MQFDw89vFfTxTfnWqMjBTtBEtc4dJqWLFIu6b+Po2ivc5vR1ImPtAILcmxIy9tLh7Ae2t+mxGGCM0pEYjC01P+eejQTtMG4IzOBmr4/k0qh6xQI53H4hkGbGwt8XGfqpGOqQ9mF57wxA7Qee1g8VKPGXPMt63FU1iVFktx+wZZNygmGLRobMKXomtn4vG0yeK3k5LROzLnOX2bhqNH6KMJ0IHGzUW+bw/Oy3BfhakoFMQn3s5us5jIBaTirBp41k3pNvAfk8wfl/Jzse14ODcFVTsWIAjNUrWHQYyaNvFAL0VhfxpwtNt87uT2w7W3maF7I2UtDYhmzm4hF/9G+BZFmPthjVNmsvZa+66UBMMIMWITm/B6wZn0FbZNZtWBY0vUgM0AmGkqmlsjRvLdfK/6rOrlRtQYpqyVKs7Yg3NPOFfSwiXQk74SXxJ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(2906002)(8936002)(41300700001)(5660300002)(8676002)(4326008)(66946007)(6916009)(66476007)(66556008)(316002)(478600001)(86362001)(38100700002)(6666004)(83380400001)(33716001)(6486002)(26005)(9686003)(6506007)(6512007)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnKtgghOuPHuBIX4O9IAgfsuSB2bqI5n+cK8wm9It+AH8t85ghE80tQ3wP3t?=
 =?us-ascii?Q?C+2r07DU5DOGZJX+4dhhizh4YZyuWkq7lF8/ZldwJGUGP4qI/ry5XVMz104S?=
 =?us-ascii?Q?n+XaACll5IWRi2JaiyCaOyDwY2JVnbWn3FgCAHhBRShyTVJlRBqp1UIVmfZp?=
 =?us-ascii?Q?k+BMWl58W4DNkn9iXqbOd+YbMEYOGhDTJwFp4cT+dr7sQ8N20NzRwAoEYU6M?=
 =?us-ascii?Q?Qgx7jRhU+t3ml9utuF182iofQD1YTFsUADfK8Bmsp+wlJkxT1Mwy1h7DMFo4?=
 =?us-ascii?Q?927Ayx+FjBpYNd/CGfPqvPWykXynwMktvtfgp7HtHmtTUe9eMkIEksLWq2MG?=
 =?us-ascii?Q?XXh5yRm9hRnSOt7XXxTGbyeqS13M6czocuZO3duuX1/Vdl+SEuh25dwKTtyQ?=
 =?us-ascii?Q?Smzn0T4mGN6JYRVT7PsYZxSs/erEXm8QRgj5Jz0gdkz43sc+5KDRHsHY38IY?=
 =?us-ascii?Q?RkE8qDUfNDZ33cdPSuv7l/OBgaktQKHCtJ17Wjf68UfxQzmbablDXMp4PSyJ?=
 =?us-ascii?Q?xlp59YzYPtO+dxv8kHcdbnqSfK6NvU0VMelTtZ/ZbP4iBJXu4uC8vFA5AAnD?=
 =?us-ascii?Q?ropgdrHjPCLQMxxvPnBtA9TnUpEJVBpZVE+ZXtIKpuvqwfHlXrGqpcePNjyc?=
 =?us-ascii?Q?Ddu6+cWc3dv3ge8DI0Q79TeDnDMIRfrg19gDs46pmLEMlfcTddeZWxgWgpPb?=
 =?us-ascii?Q?c2gZ8FtI3Rdjr6lVcsF1Mcr5aB/5VTCCzu79DJtRF9/FHuWlafwA64ow/KGa?=
 =?us-ascii?Q?AgVCGBlCpBzIisGQEEs5CT+OI4gt0ngVIwV13RLR+aCtiPqm1pTt5A+fFysL?=
 =?us-ascii?Q?ZM6ZalZk6GeyuKHFlV/9z+VFemITbYp86ypBsb7PIu8cin9qFHrOKrOPRPC5?=
 =?us-ascii?Q?fqeavOpcONNpoOty5JzRoA5kQcrWXeoANIXuVH1ByYDpM9niBxsida+06ILL?=
 =?us-ascii?Q?9J43fIt3MmPFZJrlVAEfc9hqsuDUqJbueMRDBkxaBgJSJ1LlXcxy5505rj+Y?=
 =?us-ascii?Q?x4gedKRTRYO/820iqrcM4ir6YsbOCbbkfNZShHsuP5dbQ5AjBT4mambFDdUb?=
 =?us-ascii?Q?rqbZZZz0dlJevwNtaivQQHgnRadck06qeRz00EqYr/qJiJAxnLuFq+OTMbKo?=
 =?us-ascii?Q?fRZtK+43k8SDjX4I+LVXEgyY/jkYY6U0wj2XPHsuFqEr4EIoOPLUaWH/0g+x?=
 =?us-ascii?Q?yj8p8ZVIvvLKDirx6zqicPlzSGvvzIhBUn6UDR+jlchOmqxyFGDuJMS2ANaK?=
 =?us-ascii?Q?+miOpGLVRfhbpPHe+wNfQS2JR/I+XkgWhYlCid96JGYaVfApVmZBqQWQEbj+?=
 =?us-ascii?Q?ViNglhS0/B/K+5PmG5F5z1yhN8VKzP4Gfqx+30QfDyvXDGTR5xyq1CkvxhQJ?=
 =?us-ascii?Q?9yOOr1OD6eF3m7Ag2LLcUQQGrB4d+zl7UkU23eohehkapFPLq7PPWost9lh6?=
 =?us-ascii?Q?jeAofntR/k4bQS7FrCCHrRW2fnn7/F9V1jrwO533wW4RDdHmM7j8Ie5nxLtX?=
 =?us-ascii?Q?mCrFLXnlMQ5AiU2gsB+Ar/TVS2n7OPC2fUAUKwgmlIhOqs/jf8tqg2fVk64q?=
 =?us-ascii?Q?WhvTZS7a7GvTx/fRpT9tTOUG+FcoK93KFRZyOhbnXsVJV6AGd+8U3vFbsq8W?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rsXnTGTdhYyw8XVCmRJJnm5Uj5v9BS1UTvtoJdiIwM8Pb1gfFpQigoi0gF6k?=
 =?us-ascii?Q?Xsx7Kj2v6HDyh2IweJxOBLy5PxrldG+fExJZvGD7YZU+KfGzQKrp6bfiiQJ0?=
 =?us-ascii?Q?+9q6ggKnANn8IgFyYY9PNm6I9jAfvq/5U/YlxZdAB4gafv7ZQwnfn+EPpttO?=
 =?us-ascii?Q?6Izd5txKyVHR4PPERY9xcW89Q9XeHVll9DRUPgKRYSHyBDMhvpbWFEPkFh4R?=
 =?us-ascii?Q?yoBK+/z4CoQgN9376wLQ/a7/s5UYuSIR3Rl4A3QFo90avi9c6zB2XPtXD0WW?=
 =?us-ascii?Q?+e5h/P4j8Z1rLAaZAH1MXw83t3cXN6tcpnUTZ1coYnd0zMQ+dGSwxqEhxiGf?=
 =?us-ascii?Q?mRlPed7qr+NbvfQQxtOSp8c6SUJyBChjqsCyV9fQ1oBqfOeSogR0lpOAfIzF?=
 =?us-ascii?Q?IZrqdkrL3MsgWr7WhtcqHIYSgrVC4z8n+j6LncQD7hviHPVaER4AaDI47129?=
 =?us-ascii?Q?zbKGqAeNdju03ccAG9k1IYz82BwTB//DY1dWCebWCdkJjocuQLKjsrDWhIMH?=
 =?us-ascii?Q?r69N7Th+09qZ0YfwAaA8kS/PKl3ar+hac404BmJyghsJOInJkSg2RDrKbBpW?=
 =?us-ascii?Q?7VV8RE0cvGmuu8cn5hOo2VH0swGDtH9I+UX/xxHJR3nAvcKICFVbzLF4MNdd?=
 =?us-ascii?Q?lTip+JkfXxHXQ3dotPg5QCrdCsrWt5MZ4VCG1fnJ+LeIVxyfcA9hMv6xj1Zk?=
 =?us-ascii?Q?V3xtZdNZQcSZDhXhaoVpdqIwk1aP9o0YinwJe1gckUq5ZsxVvpcw7gmhBnTo?=
 =?us-ascii?Q?q1ua/q5dSw8q9p7tUup/2hMy5/x8hCLPBbEB+qTX5tgeHf35JbMATXPbxnIW?=
 =?us-ascii?Q?LD8PAsZf4+sXK/hA8UuS/hKePazK8+kJcbl4aUjN14yrq4CbqLztjT9/Mp0e?=
 =?us-ascii?Q?6e5aitH2gjsq8YC8bcOCmQenHZSWCBMh4kjwU/3ufggA4joTNCNtn3SgAArI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27db184a-062e-4994-88dd-08db4dcf4a12
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 01:14:50.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moWGo6e2TNayCnPc5LW8l61cJwFhQvvpMtORmSsULLIU0xyycXDBSmOfvOJyvNyGTqv/vbZPK5lsxu0yWX4f6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_29,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305060007
X-Proofpoint-GUID: Wlll3ncvefuu9Hh25UTVm9dUwNRILEEB
X-Proofpoint-ORIG-GUID: Wlll3ncvefuu9Hh25UTVm9dUwNRILEEB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230503 23:14]:
> Access to the pivots array may be out of bounds. Fix it by changing the
> code to ensure that the index of the pivots does not go out of bounds.
> It is difficult to assess user-visible impact.

This is indeed an issue.  There isn't any user-visible impact for
current node types, since the overflow will access the slots and be
corrected in the next if clause, but it's certainly better to fix this.

The commit message is also not as descriptive as necessary, perhaps
something like:

Check the write offset end bounds before using it as the offset into the
pivot array.  This avoids a possible out-of-bounds access on the pivot
array if the write extends to the last slot in the node, in which case
the node maximum should be used as the end pivot.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")

Cc stable ?

> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 110a36479dced..5a49327444d76 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4263,11 +4263,13 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>  
>  static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>  {
> -	while ((wr_mas->mas->last > wr_mas->end_piv) &&
> -	       (wr_mas->offset_end < wr_mas->node_end))
> -		wr_mas->end_piv = wr_mas->pivots[++wr_mas->offset_end];
> +	while ((wr_mas->offset_end < wr_mas->node_end) &&
> +	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
> +		wr_mas->offset_end++;
>  
> -	if (wr_mas->mas->last > wr_mas->end_piv)
> +	if (wr_mas->offset_end < wr_mas->node_end)
> +		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
> +	else
>  		wr_mas->end_piv = wr_mas->mas->max;
>  }
>  
> @@ -4424,7 +4426,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
>  	}
>  
>  	/* At this point, we are at the leaf node that needs to be altered. */
> -	wr_mas->end_piv = wr_mas->r_max;
>  	mas_wr_end_piv(wr_mas);
>  
>  	if (!wr_mas->entry)
> -- 
> 2.20.1
> 
