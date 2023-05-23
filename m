Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106270E456
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjEWR70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjEWR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:59:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF697
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:59:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHx2rt009970;
        Tue, 23 May 2023 17:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=R9FEmP4fKgoadbHW/leKzk9t2y4zrAYO5aMqbM8Oak4=;
 b=mVaoY6jUXoSS8cqjug+mDge7DpmsVv2qozqhth8qAZokK2VLp6G9TOUUDFlAq332uwMl
 nkqUtwmeOfvNCPIfdYTIipJx9isZsOU6RnL6dMPLMbZu5nPe7x6JNxbsE6QxIobAO6Ox
 9OwKApJsvNPu2nPfaE+9PYWavroQQUkGBrkMyVrpH1IOmnWVpDWeFiMg7z3uWH2oq4Qx
 /MwybjnbrUXFmpyp5hBpJsmMC50UDc+O/igbjxUNqBreohiByzpNcMPPhc5zMFMp6wUn
 /JVTf37vdyorxksaDsa+foDZ6+xHz9e8TYOCQasXs1wDM2cMNSHZtq1fahM2Qs96za12 Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cdvvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:59:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHPhFD023670;
        Tue, 23 May 2023 17:59:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8upm59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdfxzEgFdfwT8sTY4YZPWtZgz0lpIijYxrxHaKNLlmbNDlFQCFV0gveZl87reoTuR85DB/6OTa0VWxW4d7te3Yp4PbskzqRdTOfVnxtGgoen+LVFAUHyBayGLCIjGmx8iYMS365nGeD4IN8OqRd/P6wqGrfzn+aqrwzRzx4u3XPSv5MKi/ZjmyuY3b5NxK1gFKYZSmpElB6YWmTtr79Ui3rxG8ExF/ShxqKHKi3VsXfM797jwSQymxrbw3GLKqowS1HwtXa+9TPtj/CrdnooqhqRHnlD1koUH8FSmwjE/vtCF4VyO8l2nztEHy8DBt8S2mk8/XETorPDM8sh0k8fGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9FEmP4fKgoadbHW/leKzk9t2y4zrAYO5aMqbM8Oak4=;
 b=P5nTFjq4ygVDOeUluaxddLkjoGU3rZSJ9sKHoyD5fagDfwsIvFDwAj1OtMpU5q5e8hrKx9wmFFf+KVwll0tWbugxgiza0f7VYDR3b7nrYbJ5BDS1nXQroDTsNdwcGwSBkHTN1mxDie9WKSqvV/ggFt6svdb4tDlltDdQuKz+2UMaGbGMYlumGODnuiIzYM08Y0sFZP50qsd3U/blLaZ/TfmFBHHD/5IsH8Ryj50Sh+kVNF8uSCGcQg05Qs+MCfsVLlikH1YvB6sQfQRlwPD2eOd/bloWHbwF577OBFrAZq44U/dv3SvX1rrTwuJYhNCntIw8w5wAms0+THsZ8ZDHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9FEmP4fKgoadbHW/leKzk9t2y4zrAYO5aMqbM8Oak4=;
 b=x1rM2tVL2LARG4MWLhi0JlfsFk1bf3flBtQjMBgu4BaviSzQw/tpHNgRujbRkLMtI4TSsVAAye7iRTL/r+PhsQge9b9P78Bv6B5lf04tCjEtPWZnEKlIlVMrqyNRnYcKg0cdtcjOAfxZ2wPqciHcFNVPthDcHe7Q4R+U1/9+Oa4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7787.namprd10.prod.outlook.com (2603:10b6:a03:56c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:59:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:59:04 +0000
Date:   Tue, 23 May 2023 13:59:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 08/10] maple_tree: Rework mas_wr_slot_store() to be
 cleaner and more efficient.
Message-ID: <20230523175901.w6xb7kciqxefrszv@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-9-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-9-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0072.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dc1611-8bf7-49c5-736d-08db5bb7654a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTpZTZIj1H215nWlRebXtIzZZRVXqagUgRrqNlwDRxngZWRRAV0zdsRdMRGEz8kcZ/xWweJ1fkYzUH1f4Y4yrkCAEuh80gUeEfH2wgXMSBiisR3mN1lBNpUw517dAGUM5wvp8XBuH+BeN90AzBKOjjDvH0xseHjM+upo6U64Nn/e7xsdSDFtXQXhkDif5aWFbZT5faK+pPsoWCDmtcb8LXYZXaC+Z2LRMLdpmpS+50MtW+rd0xJzcccEhZ68VhMJCpan5gIhwD3vK41pTnj0UhAhqIKS+RtVhdYJvEGv9jGd1J/ZrFm67iEhy8U/3VeDoihUV3iKHR1HvMCOM/9h8oeFyOVXqMAicdYD4dgL63ZUXkPqYdAGv45Df4QOlTJmIh5OmPRg9oi/kAEO3RipwmQwR2AktldJA4Z4/ThR5STFOjVm237QI3Q6HOyRuhEaiZIEPjQpBuiQRRjk2gKZA07UgqbU7y6am7f670L35mAt1m4QY716VxNnShEXmBDIcJhLJAVMHIneRTTbS5SzNNlDy211VKJLZvnIF7kqq7d3bjNLHY6U27WPvUajE/0M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(186003)(2906002)(83380400001)(6486002)(478600001)(4326008)(6916009)(66556008)(66946007)(41300700001)(6666004)(316002)(66476007)(26005)(6506007)(5660300002)(6512007)(1076003)(9686003)(8676002)(8936002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2cgNw2bxcrMehf29cgDpK3Lce/7ihbQ9AIVa0f7uw3hXYJJeEG+kVt182DJ?=
 =?us-ascii?Q?Wi5zW/wv1fPvqdg7uHNwEX8bQluXOOBbwOkAtbDCwMSgvR89S5y/guSrMShH?=
 =?us-ascii?Q?qBBmhjBwgHuIXXnC/jZwi/sqL7Ib2mY4snHU1nqGflwV92QEuexajx6gNXz3?=
 =?us-ascii?Q?d31icRvWfjgPbAOOaHGuGxfE4EMdNg44+DVb02Q1NyiXrHFt07EXjQ+pgBQf?=
 =?us-ascii?Q?tx4VXN36AQ+YN/XoVqSNRZQJNQ6z+dXOWhyEzt6jNqWsa3BoF4wW/TWWMqQe?=
 =?us-ascii?Q?6uMN5SnYcKkfFWP6ljQbv2lVvaVgEshiwa2vyAlUoQCbJ+pNdiR0bjyncF7F?=
 =?us-ascii?Q?5tw5i5FxfnojdvtfgQppkbRWwjpi6ISi4510qASdvQ6nUqA7VH+swJnUJnxV?=
 =?us-ascii?Q?tncENb5MiPUYd79MeGmTLqMBUQ9gZJ/lRMqygDxElmALH1TxeafoMBZuMLq3?=
 =?us-ascii?Q?LfyUgTc18XRgG+rLVumH0s7WR90FuEdod8KL89JGufe+Aqg7pQapDN4CAOxr?=
 =?us-ascii?Q?QyHnR1DlPVM9bwW0LX2F5LC4GrQBN1eiR/1Bxvb0DLg6NrzEC6t0pRfmOXdK?=
 =?us-ascii?Q?Z8arJO7HIW04K+zmp0DmxQbZPtY1jzsA96J7Plf5jdpMwmVErAeDtDZQoWJb?=
 =?us-ascii?Q?X6/5tG97crFUPHpTiI2egOP9rVg33NYPoIHeoBQokvgBSZqaqdG8+fksmG8s?=
 =?us-ascii?Q?0LEL89Kxdaq42s01Pfy0SpQiSDs+cVOg4iODu/pOcuilRNxopI5IF/i1Wt9c?=
 =?us-ascii?Q?/WbGxSc27EIjXQggj5OcMuRKd/GPEL1YnxmjojSY2qEPJcIas6QTSiLde3K+?=
 =?us-ascii?Q?9SRghsdP0OrR4MoDuQz8Y/yBr1jgttfOppIanwQmS305LiCHlXjXvhyJBswH?=
 =?us-ascii?Q?0/CxxrrdanuRsVv7v1B5ctvBINYf6SGTCGV4zuGKRLCGFWlVbDd6/6vPP2OK?=
 =?us-ascii?Q?YS5/+2U0QYkP6vIz3BgV3uOEAGJEP4BJ+0oAE/tGUp+t/CBrgFmsgaWRzdLq?=
 =?us-ascii?Q?cuHu91QvsVqM72syPWHBIwfIR1AVPw1DfSxUa8X6Dh4ily4oZNxj/UvGCLC7?=
 =?us-ascii?Q?Ja+ETNfD3IlhYzsnwrYxU6x6Brx0wPrA1u8DwcNY2CElNKwLctIVCdtqhSNN?=
 =?us-ascii?Q?z4kbUFczgQ5jn5/685vO1c3BFZvjC4yyZI/HdML7iisp9cMwJ0TO6pHFm0qi?=
 =?us-ascii?Q?GZQShZSpimLf3CCwLoDRcribIuAvGeCiEGGq2hfW5MQ6xt/QnOAohavvhR0G?=
 =?us-ascii?Q?91eeQoGpKsjEt5N1D2w3ud3JdXAAv7AH+I/ux8YiU07Rd2ER9XJb/eZ+P4QS?=
 =?us-ascii?Q?pRww5U/tGHkk7tp4mctwpfT21m7U4Y8hIoFDqpGjY93qOr6AnNCHdPNKJhYM?=
 =?us-ascii?Q?QLclRUuOCJZLS1w9jdKXC62SmnOc0NDKjbe8rEqRQOcQrfJsjFcftVE0QXUw?=
 =?us-ascii?Q?hYJAvsxkpd+LLLf31TRaKWwshsXh1D83Vf1jKYeVfGUScQ/Hjn1gmbdEXSmv?=
 =?us-ascii?Q?qX4V9C8N8FvHghjzX2J1x68rSOzrVO+E2lD4CEChiP/eMxdIzCPG3pPAfwo5?=
 =?us-ascii?Q?qAcDUut1EVm8xTPx+5gHMVzS8NS6ZNgZ6q/h31tdWzwA0gZ4uF7qdWsae3Xp?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?X8shZ+Dr+OQW161FUjOBs5rZfALZS+0RvvvA9jcdNlIgt2xIvga0UexM2rWr?=
 =?us-ascii?Q?6DN8cDZ9oqR6gMKOqi54K7NU9OkJi8/oc++xrUiA4T2cm8fDXf5pEKghLQUn?=
 =?us-ascii?Q?KegItfUXZB7r/Y2YbrfAtNJv4kPncvTj7ImdyJ24ecSe4RGOyIrj10ryN4hZ?=
 =?us-ascii?Q?MNoLbviGrSKgU+AlaD+tbfUP9Q8gWMDT89AZqvURmEK2Cmz2iO8WfIkfs/n7?=
 =?us-ascii?Q?yr9nwSO+tsl9sdAVI2HL2CmN/XQ6u/kf5gK6dAvhY9XB/nHPuybWTZEMx0Jp?=
 =?us-ascii?Q?tsRk9Ejt0pAitFokPqc3wnXbyvYQ5hCv5C20SdWjcdwTVqYhq6pehBPO1hT0?=
 =?us-ascii?Q?2ENh/FRM6RIOClR1fhQ55mj3pSOHj8urtUDHbZ5MjDukGyqTIxll+yM201tx?=
 =?us-ascii?Q?cu54KHTIflm4hZC6NPSGxf66SiBzfLZbXyjoj2ARSpO1ZvZCeXeDeOGyzxbT?=
 =?us-ascii?Q?lyrp/mWNMrjX5qnidrsI6L2cAFwMGzMKxDa84bOzhxRQvte+txb5K7CFOKGW?=
 =?us-ascii?Q?IOpMyGnf38BmFPBB29F9twKV9QnDnyCuGLJaoQFzQUv4QJrgLvxPTgktdmNS?=
 =?us-ascii?Q?r3v/GdebF9NPY7abP/oku2byg/0uPszPQDCkg0rsqOkcXxfjkYjAqVW50EWb?=
 =?us-ascii?Q?zQCOBXvcSBNWsxaO4Fd+HFffVWxEHkiXZpoY23qaXD2h92QajLprUdwS5nbi?=
 =?us-ascii?Q?zgdWL/qAiAcfk714B8fQRE1Lab2Q3qgOzS6cKfLEjGGdwKG+QxseapmT32hL?=
 =?us-ascii?Q?19CXdf8dqqTolHP7R20al9us0FkeMPayfH7DBJxIMFE6zY5xV/krAx4jw9Wc?=
 =?us-ascii?Q?MhNcCb04lk/14/PbeofttzfdozDjcM7hibusuxXKQk9E8s8oofBWxXE1mnZg?=
 =?us-ascii?Q?dbkUZ2VTMu6pwjPe+bfjx++TowuJhOgUQddtOGVH66b4kopLRkETlGcPUx4V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dc1611-8bf7-49c5-736d-08db5bb7654a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:59:04.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kKRY0HwnoAJXuOTUr6HLVwczxdgOYXwB7fjyL1+FovTfRLr30Rlcb019TNksoz/41HrynjlBSNoxPo2EDszRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230145
X-Proofpoint-ORIG-GUID: 2QcK0h4Kj0go3_mUYRYFpjw3t2BrgcyV
X-Proofpoint-GUID: 2QcK0h4Kj0go3_mUYRYFpjw3t2BrgcyV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> The code of mas_wr_slot_store() is messy, make it clearer and concise,
> and add comments. In addition, get whether the two gaps are empty to
> avoid calling mas_update_gap() all the time.

Try to concentrate on what you did in the log:  Clean up the code and
add comments, but the best part of this patch is the last "in addition"
part, you should start your log with that.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 53 +++++++++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 34 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index afbfdcdde5db..1fc872f7683c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4203,49 +4203,34 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>  static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> -	unsigned long lmax; /* Logical max. */
>  	unsigned char offset = mas->offset;
> +	bool gap = false;
>  
> -	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
> -				  (offset != wr_mas->node_end)))
> +	if (wr_mas->offset_end - offset != 1)
>  		return false;
>  
> -	if (offset == wr_mas->node_end - 1)
> -		lmax = mas->max;
> -	else
> -		lmax = wr_mas->pivots[offset + 1];
> -
> -	/* going to overwrite too many slots. */
> -	if (lmax < mas->last)
> -		return false;
> -
> -	if (wr_mas->r_min == mas->index) {
> -		/* overwriting two or more ranges with one. */
> -		if (lmax == mas->last)
> -			return false;
> +	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> +	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
>  
> -		/* Overwriting all of offset and a portion of offset + 1. */
> +	if (mas->index == wr_mas->r_min) {
> +		/* Overwriting the range and over a part of the next range. */
>  		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
>  		wr_mas->pivots[offset] = mas->last;
> -		goto done;
> +	} else {
> +		/* Overwriting a part of the range and over the next range */
> +		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> +		wr_mas->pivots[offset] = mas->index - 1;
> +		mas->offset++; /* Keep mas accurate. */
>  	}
>  
> -	/* Doesn't end on the next range end. */
> -	if (lmax != mas->last)
> -		return false;
> -
> -	/* Overwriting a portion of offset and all of offset + 1 */
> -	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
> -	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
> -		wr_mas->pivots[offset + 1] = mas->last;
> -
> -	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> -	wr_mas->pivots[offset] = mas->index - 1;
> -	mas->offset++; /* Keep mas accurate. */
> -
> -done:
>  	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> -	mas_update_gap(mas);
> +	/*
> +	 * Only update gap when the new entry is empty or there is an empty
> +	 * entry in the original two ranges.
> +	 */
> +	if (!wr_mas->entry || gap)
> +		mas_update_gap(mas);
> +
>  	return true;
>  }
>  
> @@ -4392,7 +4377,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
>  		return;
>  
> -	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
> +	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>  		return;
>  	else if (mas_wr_node_store(wr_mas))
>  		return;
> -- 
> 2.20.1
> 
