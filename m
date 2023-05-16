Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40A705AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjEPWxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjEPWxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:53:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201536E9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:53:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJwuaa009506;
        Tue, 16 May 2023 22:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=VDQXP6poTnXTlKtRX4xX1euzq3EzCuD3ZuuMWt9nAVM=;
 b=moT9fV0LBrdC2maQv6ILs9qZLudtp8Dt/GDDbm4cAHuNFYAKEtMZNUBGj04xipU+r5Vr
 6457MZnafQQLPCMPDvWGYgkj6pIZAukvVYWzhFljhz5pIFbROi5OV5Q9+QdeRrbIWZ+x
 fgO9JU0sWNVNGraUb7J67shrjbemwNcTuiF41rpCpepwWbT4kNyUm4+77Z+XOYEITz0b
 JUyWOByHxbGwS89p0U67eHMdUgqGGkL1VUID4s9rVh2s9peiNYoNCL+rT5FrshkcteIz
 WAAeuuD1B80sMYMedLEFCXS9JOnj8cO1DCt4yVtFtTo12ry8bqhGwZdCTLVhJRfEQzf6 XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25u4a93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:52:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKjEf5034011;
        Tue, 16 May 2023 22:52:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1056715-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 22:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr45jJVnW6oLrCXypLdlfWhhLYzttVxhPaDhcaL0yzc2wThZoNdl8QrNOpdCjBAjHQRsSpAt3RjWlkvjIIC3FXGPmlYJoqCk+tt9rKN92JXEmR+5ziOp9s1+FRUqSdRbM5gDooaeKL18+8Hy2UQqaSLjP8opRUrDOUUhh9uR0RVV4r6Bk8Kb7hS33/mzq5tOkXNO7cN/yVM140R1Jh8xA0HlaDXt1O1P0qbWdre2ltJhsyGybJZcgNur5E/C0++BiC+n7VpmM+kbtu/ZvEU9kbd6vPliGMOs0Qmz9Y38PfQydo0YLchRykQZk2bZn8nnhRCMUxXgn+FgPRvFSbxRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDQXP6poTnXTlKtRX4xX1euzq3EzCuD3ZuuMWt9nAVM=;
 b=NCK16qPmDlg4unE404C09ht+/cpCqBcsdi0ZCCczIcmXB3aT0TWI0TuoBVkrowk7n9AvyTWfrXbqbSSPj9jGY7ldlBaoC+AgeZRqMIWrd87RLWxSmKAsy622qkER7CrL6D4Ixo2E0WeH+atzglh+xccIZOGnW3zJ0Iu2Zf2fRmMEYt/3rEdxiD4oALxqHeH+9+IWPouGqXLbL0+P4AOAvqP3vGjpQQz3m1Hr8eEhrWhpHLvnZJLh4w8xNkAXIKGNdwGLIeMfZbQY6ufdrSP/LpjDcr5g8UtIG8O10onU5fL02cJhdjIuF2L65w+WLLOKskeYt8Fty37mv5w0Ote77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDQXP6poTnXTlKtRX4xX1euzq3EzCuD3ZuuMWt9nAVM=;
 b=pp9/mZxesTCT886rZWcosfzg8CdM8AZBiyak0LuJICecrThu7xWd0/W/KiwJKo68hEvVz/sv+u7b8dxVaGsqbHHzDzKidWm+lR68+hOKT5q1U1pzc3mOUJG09SmKNP6HW8pSo5v3qeRXx55qa5g6CgKGk4kLZI8XL7favJBsYuU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 22:52:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 22:52:53 +0000
Date:   Tue, 16 May 2023 18:52:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20230516225251.xwmz2oyebo7k56ys@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <20230516164907.5bf2qe7nn5bo7iaa@revolver>
 <ZGPjlVOV5R7x4CV7@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGPjlVOV5R7x4CV7@x1n>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: d7465a8a-e8c6-4cbc-ed00-08db5660487e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMIXwSx0376c9ztkkaQ6kwErVjRyXFy1sTxWlsfWHK93Bt9s3STeeoSqeqaT/g1GXtVkl5oFqUKcVadR0Zwz1iMScGE3cs5o03FsAHsfUdgU3AEwG4cfftZa3iKHitcBzJMYckJ+fTYvflvrtNRWHQcX+uY1UbG/i+k56LBH6OD+s+/9LnGjgk2+ogZKgFSE6vQEPiP6XQMkfE5wukF8ZikbPQCeiPZb3pj0jFVdS8cFIK0J4L9OcF1GweOj8OkALt4X4Pe9m8wNSZ6jNiS6uZTMbibZixOcIMNxO2EN31hEEuB5hQiqqy79B86XEyUD3VDsVYN7SfscyNLK9iqd3i/hRZjDxfYEGuQWLmanDwOsDD4bptkwJSU+h+7i603LCdY4cQLLNVYMmf+2cHo5Xig4QutaJegnpGUUPnZjHGtARj7MlIHRuEXcsJU67UVdN0japiC6EPLPGt/eGECmX827jCh8X+ZkxGEuuQaArJmvHP6hnOq2MTm/89KD5ixpvrFB3OznkV5KXxLLlZd+c+S7ciCgqR1UxsMXi9zKltSh9S6USG9xwl5sIPbOiqmF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(66476007)(66556008)(4326008)(6916009)(66946007)(478600001)(54906003)(6506007)(6512007)(53546011)(38100700002)(186003)(83380400001)(9686003)(41300700001)(8936002)(2906002)(8676002)(6486002)(316002)(86362001)(33716001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UK6VY2g2V7l4XPAryC64kI4yAd/i47lCA9Mo3C4bnOCByDaVkM38+DHQCOGB?=
 =?us-ascii?Q?yPmyTvEDMQCajBW+F1Gwm51Y3dHZ9b5pyRCynnm4spPZ/qlqtmliCWwXC+28?=
 =?us-ascii?Q?maXyhtV4b6T9dvSP71CQbE/5lfn4qBYPcrW8UcP/y2nEvoRXWNeil7LvMwS4?=
 =?us-ascii?Q?KnY5TlkHaQm+asq10AVy1sruUcZO5IBI4+bAmgrqLrSth7YhOlv+ycUvwt8w?=
 =?us-ascii?Q?xUBrw1Pt4+TrXqB/pfTs/xVY61SSmKYgYn/l3wnSzxJMYfnQ6VdLSlGGURpG?=
 =?us-ascii?Q?MsNe5zyt85wXgtxF9zD8KcI5QvuyJ5vAMV7EdZvb96H6XMPRZ5bWOvhKvEoN?=
 =?us-ascii?Q?rJJ/IDjLtPEOb9NxrjdrHx+JhFHBDlpW127pJ6kdOuGoLYygAeKvkNDPEi3J?=
 =?us-ascii?Q?MYeA8ngLasikqJVDGBfp1bfj6xAtzXhbx3pjo9b+Lg2ymOUKGbe3p0+zS01/?=
 =?us-ascii?Q?fmgq6SkHoG1fBSi9ryJqonqVgoQ+GdLXjRQvgaT12QZ6YpcTvdao0322QB1G?=
 =?us-ascii?Q?y7tmigXkECorKUDEo2rKQ8WDBOb7WbCg1s9fuIouTFbKc/JXESoAY3z6hpUG?=
 =?us-ascii?Q?XYJcz8Cmdwa/WI3j4Nzftijpjxc1NpNRbI2tlxE/2QAqcmxf9p/V+gUARbn4?=
 =?us-ascii?Q?HmWAz1Xk/S602TibrA/+YbOOyKPzDkQUIihpTajEZUJNVMqqZzJjWWEGvvEo?=
 =?us-ascii?Q?zgozyaVJ2hngxMlncYzg1Y+berzoqSy0KXNIni3fUb7gQVYSZ1A0TN0ipHR9?=
 =?us-ascii?Q?zoatFWec4Ujxqbuo7pB3XhCeHIB3ns2d6ba612u28Td7Lkz6Fc+MEZTemlqj?=
 =?us-ascii?Q?52r2lghN6VaBE/NIIxXqy6kYjnC/a/PyU1wLHgJwG/xO13XWgVWZTOu8sQSA?=
 =?us-ascii?Q?iP/CjjEmqdDwqaniWZFcFEFasUp7AjU0u4Ed4y0622O+5gzp1KqRDIKdgrK/?=
 =?us-ascii?Q?16eXIzasSeURVLiJRg2ddybne1Soctxa4243SU92AniLYAAKSHrOQBDxPcYB?=
 =?us-ascii?Q?qjNd+YPr009cfXbKFvLIYaJ7wU24pgXzUuMqSIY2keSrZ6Q80rkb4gxgiJYp?=
 =?us-ascii?Q?O/FWCDwhr153XMpoySnNI3id1bYBfXKBqBQ4oT0GOlwEfAw39WBhuOd8n0Uv?=
 =?us-ascii?Q?67eVnHZo4FgAZA9LwWor1UtFQtlcnOhPxH6Wa9ZlVYmGv+i7alAE5GQ+aJwX?=
 =?us-ascii?Q?ox9UKSABwTynSZKY3yyEKFOahXJw1EcajRH2is24q2CcuNXYVYLEUz7PE4eK?=
 =?us-ascii?Q?AyKqMeOJgU5t8RChX4XKeDgGHFFIvUJqirU3d3umJ9xFIRCE9C+55g6WSfOS?=
 =?us-ascii?Q?f1FFBhyusCeSvGSwjgoMq6xd6EN0AvEDwa8W2avnmcMfRdQ5ZDMzMVg7iJSq?=
 =?us-ascii?Q?hNsIsHUMKpsMFkd4pPTU3LCs6OsZIEG0DA+d90pURcP5ANypzx/7kJPUyVe4?=
 =?us-ascii?Q?YLmgKAZ1SrS+c9N1BVgqcGH4f5CFrMGHaP2kx4XTEV7qsI4y/3S+1Yv2enuZ?=
 =?us-ascii?Q?/ZGK5OZ73X77kVDvW2uN59d1Ibp7EQt/wS/swwT3D6h5Vha25lXbcJdGH8Aa?=
 =?us-ascii?Q?Pvo/q4GuYhWM+SJq+kRT60ATxQLWJlOixWD1EOeHkAxHBt1Bh9zufxQB68lG?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SetA89sN9rcI/oJFbf39W+0wIEtDn7wgh8DWBnNA4JU0KRmF9R1dz/PwvFD9?=
 =?us-ascii?Q?Ztcx8M4RNrnoN9zYNP2oEA7fvAtP18naVd1PRssb7JZ/EzUNYbpb+2tD91zw?=
 =?us-ascii?Q?UeCoOKLBubYGEudjPwBK5ZMXNxNc6AL4oirPltfLGoHtLTaB3kI/66+j8UHZ?=
 =?us-ascii?Q?SJph6yG2b9peHkllRw+VIqA+a62L8t6a9FHTrl3h+V0h2KZ1tuoUPewkjXFJ?=
 =?us-ascii?Q?u5lruYdrZYgcUlDcDAH61jgAkB5+VTIPRxtSKOiRH4k9rgmjdwudn+7sH56Q?=
 =?us-ascii?Q?QUYHWxRE2Mko+tX19P2DJ5JkY9DIpfYTzDetmRtnPWF/49OS8pnf2USan3tC?=
 =?us-ascii?Q?yHskXuxHWFSPihX9LPFaB8sSqAVOJrAILerTD0Bj6o5Ij2PpP9lkdzuWlNl5?=
 =?us-ascii?Q?ho/zKEY5bn6Valoz74ssHAWhVqvc4jm6MJ9HM7VkpsXJewS2lEgUkA7/lws4?=
 =?us-ascii?Q?Er/wkYXB5lDpiKPBS4f5rkwWO8uATaiwcSlHUzrjYOtXjujpar1Rys7GxgBV?=
 =?us-ascii?Q?fyPArn8FxghskPj2o890f2e8UH8bgH29CHhYEyZOv3IZksOj0cUTl76MD/tG?=
 =?us-ascii?Q?IpRBGhIoFNkVl/f7WZUii5NW17kpS6z1qlIVG5X4TBhYgl02iWL3JxdONDOu?=
 =?us-ascii?Q?hS2WVDsnh0NaLWa1SRFyWnvcvOevHuli4Cc5ANvvew2eHqbB+CBrp1czpviI?=
 =?us-ascii?Q?RiO0zm3vqZ7DeRkdLfV5fmNHiBLS62Z/q3CSoH/R8mgxtArXASngUx3hc6XA?=
 =?us-ascii?Q?mTqlzSi19d+ZAM4oPBm1c/GQYYu14nxgjRPjadqDEVqey0QqWhC3/rd32Bbv?=
 =?us-ascii?Q?dtwR9yAGkWJAMuvQ0YbwnQjFX2FBrEaIbJDuVMTwjRNoDI7m3/aITJW3rhw6?=
 =?us-ascii?Q?zJ9TJyWycJEHAoJvDUEnPoH77BBRxPGPu9WfbDa1S4R6ZqQFwaN5+NdNYF0Q?=
 =?us-ascii?Q?mkFfuJLoBn254rsvrYzlNDa0GJfwjB4/CFHtDj6ERD8TYVZhVrhsMGOWlVjQ?=
 =?us-ascii?Q?Y94K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7465a8a-e8c6-4cbc-ed00-08db5660487e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 22:52:53.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcLohFlH/5eazOvsf4z6myMjROYwVVpbNf1pGnuTK64vX0OkKhGIU0Hjs4xmyAf3u6+Gfg3Ke9m4ezLJScZcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160193
X-Proofpoint-ORIG-GUID: wcpcariSfslwoQhwWF8M0Ko1D3PhiQZP
X-Proofpoint-GUID: wcpcariSfslwoQhwWF8M0Ko1D3PhiQZP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230516 16:12]:
...

> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/userfaultfd.c | 27 +++++++++++++++++++++------
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 0fd96d6e39ce..7eb88bc74d00 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  	BUG_ON(!found);
> > >  
> > >  	vma_iter_set(&vmi, start);
> > > -	prev = vma_prev(&vmi);
> > > +	vma = vma_find(&vmi, end);
> > > +	if (!vma)
> > > +		goto out_unlock;
> > > +
> > > +	if (vma->vm_start < start)
> > > +		prev = vma;
> > > +	else
> > > +		prev = vma_prev(&vmi);
> > >  
> > >  	ret = 0;
> > > -	for_each_vma_range(vmi, vma, end) {
> > > +	do {
> > 
> > The iterator may be off by one, depending on if vma_prev() is called or
> > not.
> > 
> > Perhaps:
> > 	prev = vma_prev(&vmi); /* could be wrong, or null */
> > 	vma = vma_find(&vmi, end);
> > 	if (!vma)
> > 		goto out_unlock;
> > 
> > 	if (vma->vm_start < start)
> > 		prev = vma;
> > 
> > now we know we are at vma with the iterator..
> > 	ret = 0
> > 	do{
> > 	...
> 
> Will do, thanks.
> 
> I think I got trapped similarly when I was looking at xarray months ago
> where xarray also had similar side effects to have off-by-one the iterator
> behavior.
> 
> Do you think it'll make sense to have something describing such side
> effects for maple tree (or the current vma api), or.. maybe there's already
> some but I just didn't really know?

Well, it's an iterator so I though a position was implied.  But I think
the documentation is lacking on the vma_iterator interface and I should
fix that.

...

> > > From: Peter Xu <peterx@redhat.com>
> > > Date: Tue, 16 May 2023 09:39:38 -0400
> > > Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
> > > 
> > > We used to not pass in the pgoff correctly when register/unregister uffd
> > > regions, it caused incorrect behavior on vma merging.
> > > 
> > > For example, when we have:
> > > 
> > >   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> > > 
> > > Then someone unregisters uffd on range (5-9), it should become:
> > > 
> > >   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> > > 
> > > But with current code it's:
> > > 
> > >   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> > > 
> > > This patch allows such merge to happen correctly.
> > > 
> > > This behavior seems to have existed since the 1st day of uffd, keep it just
> > > as a performance optmization and not copy stable.
> > > 
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/userfaultfd.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 7eb88bc74d00..891048b4799f 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  	bool basic_ioctls;
> > >  	unsigned long start, end, vma_end;
> > >  	struct vma_iterator vmi;
> > > +	pgoff_t pgoff;
> > >  
> > >  	user_uffdio_register = (struct uffdio_register __user *) arg;
> > >  
> > > @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >  		vma_end = min(end, vma->vm_end);
> > >  
> > >  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > 
> > I don't think this is safe.  You are telling vma_merge() something that
> > is not true and will result in can_vma_merge_before() passing.  I mean,
> > sure it will become true after you split (unless you can't?), but I
> > don't know if you can just merge a VMA that doesn't pass
> > can_vma_merge_before(), even for a short period?
> 
> I must admit I'm not really that handy yet to vma codes, so I could miss
> something obvious.
> 
> My reasoning comes from two parts that this pgoff looks all fine:
> 
> 1) It's documented in vma_merge() in that:
> 
>  * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
>  * figure out ...
> 
>   So fundamentally this pgoff is part of the mapping request paired with
>   all the rest of the information.  AFAICT it means it must match with what
>   "addr" is describing in VA address space.  That's why I think offseting
>   it makes sense here.
> 
>   It also matches my understanding in vma_merge() code on how the pgoff is
>   used.
> 
> 2) Uffd is nothing special in this regard, namely:
> 
>    mbind_range():
> 
> 	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
> 	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
> 			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
> 			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> 
>    mlock_fixup():
>    
> 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> 	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
> 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> 
>    mprotect_fixup():
> 
> 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> 	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
> 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> 
> I had a feeling that it's just something overlooked in the initial proposal
> of uffd, but maybe I missed something important?

I think you are correct.  It's worth noting that all of these skip
splitting if merging succeeds.

We know it won't match case 1-4 (we have a current vma).  We then pass
in vma_end = min(end, vma->vm_end);

vma_lookup() will only be called if end == vma->vm_end, so next will not
be set (and found) unless it is adjacent to the current vma and the vma
in question does not need to be split anyways.

I also see that we use pgoff+pglen in the check, which avoids my concern
above.

> 
> > 
> > >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > > +				 vma->anon_vma, vma->vm_file, pgoff,
> > >  				 vma_policy(vma),
> > >  				 ((struct vm_userfaultfd_ctx){ ctx }),
> > >  				 anon_vma_name(vma));
> > > @@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  	unsigned long start, end, vma_end;
> > >  	const void __user *buf = (void __user *)arg;
> > >  	struct vma_iterator vmi;
> > > +	pgoff_t pgoff;
> > >  
> > >  	ret = -EFAULT;
> > >  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> > > @@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >  			uffd_wp_range(vma, start, vma_end - start, false);
> > >  
> > >  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > > +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > >  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> > > -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > > +				 vma->anon_vma, vma->vm_file, pgoff,
> > >  				 vma_policy(vma),
> > >  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> > >  		if (prev) {
> > > -- 
> > > 2.39.1
> > > ---8<---
> > > 
> > > -- 
> > > Peter Xu
> > > 
> > 
> 
> -- 
> Peter Xu
> 
