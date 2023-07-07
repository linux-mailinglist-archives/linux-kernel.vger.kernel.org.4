Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871E774B532
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGGQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGGQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:46:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1711FEF;
        Fri,  7 Jul 2023 09:46:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Ggfue023248;
        Fri, 7 Jul 2023 16:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=dBfqxCYBFX9l77/eiJ57E7wSc3ZqB1tnD28sBcZgWtQ=;
 b=eFmh3NiojUNvacQWS1mR4d/UUjiz4O1C0yMteIHR+eZMqSXCXyTLusqmWo9OMPsl1gCQ
 Nlhq4yOdXBcZ4OCVtnby0t4DawL1BK89CmBbzDyHKj/KxDDqoFWnjdHmuWv0xo18mRHB
 j1f6tkRg1bqYlRWdCKsX0t99vcl97tZxaKZSTfOicGq7/X6lx+QpHI7pIo2dolfOoDK0
 DrMqzuemdE3cZb24Ps3td6pupPC1zJcJ9ZpZSJgPPRiHerCyRugU+Aimy1iuBfYy1vhR
 hH4bS08yRB8jsXN4D1duHAf0KXElXNGYhj6y6sj6UgQfPDtLd1dYyTQSNrDA+ImNMBh1 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpfhprun6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 16:45:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FgnpI013587;
        Fri, 7 Jul 2023 16:45:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8ppng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 16:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA2tvxxVOVGmZn64sR/rmvrBFRY2iGfQ2Jt7PHDTLrs2lbLZFZC3y+4+bqevgGZ1WuV65vGmyEIPr4TF1RVzWqLGJ74Y2vZ140gN2n382p6VPIyyGLZcGV6/D4i2l/OcsQ0kBvCIfeiP8GHzkQNXqb4Zb7G+O1K8LQRnWnsp34iYdhimB6o5+5C/dvYCYvnYWi4Qwtglx4hdDvmZHvH1jeeEHVoFuIxt5aDm3mO07TUroBODYr9sVNixfqdmMdvh2KiawioTCnLFLmsmthNiiPr9j0Jwtn/fKWLI3N5z3IY+ABe+mI1FRGmKcNUZH8lqlvazMMw9+XqQnlXo/VcEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBfqxCYBFX9l77/eiJ57E7wSc3ZqB1tnD28sBcZgWtQ=;
 b=d04835EeQ7MsZnrI4Kbv/oWIzT9fWtI1hc42yE/hrwwKEnkcZsXZCBfCVUHvS/wPnGriPtysEJfmB/e0MLJ8XoI8i8QxR81VB/zYkprOVGCKL5fdTLbd/mPWe01HjsU2j68kK3SjteswasjiEXHK+tY+X7ClQruYLfFNw+QC9aRt4xdmFE8+Vlsu04uKghjLgcofDuORpfXy+f81saiP/+1cdSR0A9M+/cJguy271CadYOSG920pugBpUiS/3UuLfB4Ry2y1QIAdZkYmcdRGKdY6JQgRnum1VsKFw+HxWf8ieY+N7t7HRFcxZJxXZETpeAI5JcuDwdvZPuG0oytgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBfqxCYBFX9l77/eiJ57E7wSc3ZqB1tnD28sBcZgWtQ=;
 b=XS5ENRw/WkJ5CGBX4VB0rcnP7vXuRVFd69Cq1CTonKpnYRv1UMzFI6iAJmxHd9+1GCd+M6qP3QK1hrIE18iCXybkCWXQrzg97bLS+nnbhmdfu98rFZBTvc2RspCoZ45LxPo5n+u2NaDBruvPJqntWn3KKiq7sACrhzqzOgJAa3U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 16:45:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 16:45:09 +0000
Date:   Fri, 7 Jul 2023 12:45:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH stable v6.1] mm/mmap: Fix extra maple tree write
Message-ID: <20230707164507.mfekysya2jyupghp@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hsu <John.Hsu@mediatek.com>, stable@vger.kernel.org,
        linux-mm@kvack.org
References: <20230706185135.2235532-1-Liam.Howlett@oracle.com>
 <2023070748-confiding-abnormal-b7e3@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070748-confiding-abnormal-b7e3@gregkh>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BLAPR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:208:32f::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2385979f-a808-4252-6bd6-08db7f0986c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xPWhAcLwJRj/wTRGJ+TxPVltZVENbiBaWbe2hxD1G8162M8XFnkurKmegUk5UPsJzv+kEwL9vP/3IqUPIRQ8CKRKai4CiUKohECdUyKqJpUdFh4Nj3Wt+DMbQvwMt2tDBT3/3W1/YuwnW1OcCUw4HGBbnUZJQtow9p8c8T4a+O6HSFS/TppGaWENyfGNGO1MdNTojRbl7sue/ENLOfY90G77HfV0McIQ7IbfZ3YoRxBy71zLP/7bbX3YeL2MB0PMEny7eFcxZN45Q8eWTrbhmuo7Fq3W5O5pZRTbIziBUfQCJlIvwuzXuVvbHp+lyIZji/MNCCJ7ZbmejR5k0MKOq/JvPUeVaFx8uOILdzO8Jw/des2hJUOtRfi5QW/T1j2aj7U0j6eB3TF4A1AOLJXRKlDsSnpGOOExqFM8d/6vp+XuHd2EY7Am4rJh7SvweKP/Yc2wIf7j+nTpaAIUx1PnK6hiUtNlIN3sRvfLmRcYfNH3WFIf7mr61UF7d+1aFQSUuSIGF1WlLkxeQ7E4EpbuKFTHO4AUVBWQN41nbIZHkBYhuxZP15YQyosRV8UD/Km
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(6486002)(6512007)(9686003)(54906003)(478600001)(86362001)(316002)(26005)(1076003)(2906002)(6506007)(186003)(38100700002)(33716001)(8936002)(66476007)(66556008)(41300700001)(5660300002)(4326008)(66946007)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+OSdvk6u0jGiohzi0zgzEVbTH6ThOyrpk9jjRkXSJKKG28pO2fqEcPpqBTm?=
 =?us-ascii?Q?sPeNjExTWX20obo+jFDlVCA+7bMr6blWAKPI8TkQ+Mas7/qcDdaFqHvO5HVh?=
 =?us-ascii?Q?YR8ZxDXl3w6+3O/8mDqa/Lb0WmT9+jcwjIpR4r1fxQUzj7aCi7hnv7yKDJo6?=
 =?us-ascii?Q?zgVgeTAI8k4eVFOmVfnmGEv4j/QckkN30BIbInqTH80Zlmnx3x2ZqGBxBOXj?=
 =?us-ascii?Q?TaHE/zhMy+cVDtnFjlJNFKctaLn6IHgynhpxkR+TLEe4EMKfPTgkT8GjyWOo?=
 =?us-ascii?Q?3cvblA6QUFiknbRq+WjEin4q/VGBnYyYioAMA9Nspc6sf7lH30RRDWC0BIuh?=
 =?us-ascii?Q?z9I7u5/9OeLpwdCXDG0NADwPERRnB0AkgYglQUiWpAhS+/pmRIPXaWXQm6oy?=
 =?us-ascii?Q?mkBSNdSG1kzwPCPIU4/HaaCkx+zDwfzL9YtoAbmosByGFZDGcoKhjO+n4EUp?=
 =?us-ascii?Q?xpCdJep1z+9WFxelv9bptc8lbgvU+blHyvrVH5JfBEGkL3xIjIaf6iYkUD5t?=
 =?us-ascii?Q?4/n+vU2NQ3C9TPrzFxZM7eaSc9/ZCcw0kF8VpgZnD+p5shj1QiRS6UgkEg5P?=
 =?us-ascii?Q?SyzzJK4pWY87yRwB8xlQEQVWJabVRcSTsfACo9vSjPS+DJZE/0w9FjatdVVL?=
 =?us-ascii?Q?TgggIzOnyGivOgvQpX89YeLsjVF7gwALxkVVnrboRoeqzsQgUdBo1623xpWs?=
 =?us-ascii?Q?JncisLaJ5Vi4uaTWtj6SRCc9PpsrBciueEwqwGMA64sRKeo9MwjvUKs90HKj?=
 =?us-ascii?Q?VisJzrcon1xA5f/GFMHdCZ7J5X6kLMk098I6GyalKqhx9IEdrNnpynE/ZmE2?=
 =?us-ascii?Q?3T28FPkQo3tR/KJUJKyc4/VinpyBZq5vRuNsuwhEL/V/D2wr70VNTdCi9lOu?=
 =?us-ascii?Q?bgorXKgeUCc4s/FmPwECLIDWa2FCLUtlU/2JuP7NP/kDx1beHIC9lNM7YlMw?=
 =?us-ascii?Q?qyweFSID6rmwmGH/7gL95kWDgx7Ivd6GWPzPyWMCJQmhxsOCQyklWgJJ8EGw?=
 =?us-ascii?Q?7KVAqHD3g0KWKcrBV8Zw2Z6BbBREPTE+L4vAMWR8TmX7uZxuLO+PAvhApMcC?=
 =?us-ascii?Q?+OnS9+OzrlBLljfuTTye8hylEkmuzhHJoBFXIts0m5xfI1jrGSdunD1OTHRe?=
 =?us-ascii?Q?jDDSf9v6LWYauyyA0eL/5ZTCHQtWv3gD+j+d4r8F8P0wd7DPA/xKJealF4kO?=
 =?us-ascii?Q?GLGyJX6CAAFmZ0q5mHPoiHN3NUQ6A5D4+LC1g+a9Yk7UGW2eloel5inyuAsZ?=
 =?us-ascii?Q?GVc6HA2jkMHK/wjapOCg7ljtSQWjfHRkuD4831ZwYS3QDBNC0jCvH7Obmh7R?=
 =?us-ascii?Q?u9RZyscgfOHzsze+eW0fmhER4Pe+1wbC1EKujRsCPvISWuP18fXGI+QIk+9Y?=
 =?us-ascii?Q?f+vE40ioJoSv8dYNdOEjcnyBjZVGSg7MijHkawh1A37HW5bgVK2i88AqpwTg?=
 =?us-ascii?Q?diReQPonoJbtm/G2uen6rFwXyVWrVyIn66A/hTpikzoFiDyyeinmsWscdzLD?=
 =?us-ascii?Q?E+UGivOJSAbkRrZQAEzDkpsW875tyRmJ1dLnX2v25MYUw/emzeQGMWw8867J?=
 =?us-ascii?Q?eP1dhPmv2EI9/7Wo6chz15JSAESh3LWc1gZgO47W/HL64OS7yd7jrQIYpzll?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: htiuAz1/AbkPm9hgnwFnITEw+myMs4u8EWp9rc3d+XbSc2rhGhUTczqs1fxKChFxa+XqEB+mvuWsxR1e6XLuSqygmQsnA4y0Li4xLRLo+JhsBF+B/NEk4Rssj97zGsK5oZUncSe2Qo1oxvv6v1F2Af4Tq9tnf7NkBB6eJ3XpnMygGVppml6vGzX56XBjlhJf/Vvo42p+NXajSm9kXpK0iLkQdbOG5i6mqxYY851fMdkVU6cnU4qK6EHyJFvyC110gJKoMnvn47/A7EGT4zdkofW11sg6iUviaKadlGE40MIm8CeLYVL+TUib+JZ5sa7gAfOsJ8d5dRRsiyMqPd2jnzUV+aEvl4TF/RIOMteZqk8bHUhDgjt7gP7EcEqdvMLh9o/Qsf0IVS+OxYbM1t/YXYxtO0kQoIdtDbNEfX1F3sG0eMPSicsfsfP0vAzor2hOlWz4airM/AuRuyl1lPYIXgTlw0mzDCuVTNx+WAe6nfCp0hZYBit0F0moJIl0NwfMZwtZRsvXxoWocIt3ar7rdER2n9QZ0Q83rNgiRY4carbHKMDFgQ564UUsfznVDw/38QjhgkqL5Xjcz7HXWxNabc9Z+196kbjxptYx78wo9avw5d4YqDsDOtyMw8FisVqYEs6FD3fQEusvmIZWV2TGvl8SMDVGYm1wX4W11Y05C1rK5AGWXNLr3w00m5JNXXrgkBEkJslTdUjG5DXt6nY+/+qsHSqROLphFTpvRP7S1ayfcxfbz7twMbCL4ZEa/dB5o18IZ4NWLax50cSKjrZM8/RUEk6STEaN/7izR1+IVA+6vVveRRIXXjt/bkB6nz+G9aA6j4nlsXJrlmYEXuhg9Bez+zruUZj2+l/KnHyYOpwYYqllrmhh+Po7AP3MQx7CzqTuNkhO3XLZkQvK027N7W/ZgtgVNobYdkChmMOf9yY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2385979f-a808-4252-6bd6-08db7f0986c7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:45:09.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJOoXRzJCbcvwMdVO41D1eVkRhYHMsQV4/UeO9D6CLHL3lXdg8JhT6PrOAjB7je2SFChYObc3F9MAy8kAdMApA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=631 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070155
X-Proofpoint-GUID: zigoSW3csaPActc5pj_h9v4zRBh4KrV9
X-Proofpoint-ORIG-GUID: zigoSW3csaPActc5pj_h9v4zRBh4KrV9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <gregkh@linuxfoundation.org> [230707 11:55]:
> On Thu, Jul 06, 2023 at 02:51:35PM -0400, Liam R. Howlett wrote:
> > commit 0503ea8f5ba73eb3ab13a81c1eefbaf51405385a upstream.
> > 
> > This was inadvertently fixed during the removal of __vma_adjust().
> > 
> > When __vma_adjust() is adjusting next with a negative value (pushing
> > vma->vm_end lower), there would be two writes to the maple tree.  The
> > first write is unnecessary and uses all allocated nodes in the maple
> > state.  The second write is necessary but will need to allocate nodes
> > since the first write has used the allocated nodes.  This may be a
> > problem as it may not be safe to allocate at this time, such as a low
> > memory situation.  Fix the issue by avoiding the first write and only
> > write the adjusted "next" VMA.
> 
> Are you sure this is the same git id?  The one you reference above is
> _VERY_ different from your 2 line change below.
> 
> And the changelog text is not the same.

Yes, but I am not sure I've indicated what happened correctly.

The bug exists in the older __vma_adjust() function, but I removed
__vma_adjust() and inadvertently fixed the bug.  So the bug doesn't
exist upstream *because* of that commit:

0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")

My comment after the commit id indicates what happened, but the
documentation wasn't clear to me on how to specify what happened.

Does this answer your question?

Thanks,
Liam
