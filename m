Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908A86FB4DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjEHQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEHQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:11:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43035A3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:11:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348BIsJJ012755;
        Mon, 8 May 2023 16:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=79RB3i+/al4kGcJntw0Oz5i+hFS9kVdWh+TZp2vAuzo=;
 b=I5T3Qp8/7j/U/wZW1kSX0jGYfw+wRAep58Y5k3Juqt6asWJQ5nGc3/jnxpl/qk/1Ilgz
 i0JFU3Yom4IQbymxxsHR9rLiECA7Bj2cRSGwpi7UXeW7ahcfYYHjwyCSAITmzoMUoYTM
 MDyseexxgyIDVujitP0vB3qdFsTAyMCUtSjIgZp3rPtYr8t/cFXWvAVU7CsXJaYRwMHg
 yw1f4bD6KK/KzfA/7awolkg1D6m7GqKhvobcE7p4ELbAEedK+0WRKOT+gUHTGjV4dft1
 98rIfCJrqvFJnuijTDtKjNL/7+3Ys/s4jiOWfoE0X9N0u6HVZTo+zQJUUw9pX3SMUNHP Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddp4ktxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 16:11:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348Ffr3E038281;
        Mon, 8 May 2023 16:11:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb5epnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 16:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+BQFupWHD+bmMGZZFIKDR9cQqzJRYV7Xz5qjZPB29bAzdqmSlKtjpXsi8CJA57gli3YzAwWJ64LI+RUAKNIrPqPEBr2VG6w553Z2hoNoszdhY0AQSBzLaDAeJOQrGnsvos0t8bI9pVhugmwAYKW9SZnT7cnHZF/epkqdQV3WUHgXV14+UgSfQv+2da8/R950w8SIFyTa09BNKDUmrtnrGupzT9UiLp4HAHNZBB9yQU9z4ChygWwZu7trhvWkm1hWPL8MTgLTswB5a54CkUz5J9cUeX7x3vXL66agqkEw0F00WKBcPzAn5ffzH577+fayJX1KVxGJpicuXipY/O5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79RB3i+/al4kGcJntw0Oz5i+hFS9kVdWh+TZp2vAuzo=;
 b=JxkK/W0q09XIgwHAedS4Af95iSKh8O3qyw2Lk7z3tFAEgcA4lFo7kcBY94Lh2QLmewEHc2RVrFp/6kM7s3iJ8d+zTHJeS4/2n/Dea3GbQIt/kTLLfBRwNjAGs5JdSgJC2dLiwp3zn9V6k+8JNGX6qup468SBtHd2ZmHwIppXqrX8opMrgjTOJx/RO9NCDV/w8PT7nfDqTeBJsJk70qJEyTXD+75XMBBTBHpkrCr9EKKaDirMHKn1ODbFB6oLLfUd2rfjhpAnaU32L9pPdYLOMaJ2PY+dI5QkMMtMvw6NgwS0M6ozhY1jCuws+SRZdqq1vaxmtzHGT2bcwYIDbtYvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79RB3i+/al4kGcJntw0Oz5i+hFS9kVdWh+TZp2vAuzo=;
 b=ZJiTM/yCfgkQmr8Lya3RNql5LNn0N2eR8o/ALCz4SI8akwIHh0Q/4fcbI5cduBxogPAzdv5zCEV560+V+0oeQKG7kqVrlsejN8vkIDtYnjZ4RbeZ/BeDjnqGw7K/txJ3c2Ra/btFRq1vuzTOqcwz8W4+9iGnsmJfj46Y4H4FHew=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 16:11:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 16:11:38 +0000
Date:   Mon, 8 May 2023 12:11:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/36] maple_tree: Add mas_prev_range() and
 mas_find_range_rev interface
Message-ID: <20230508161135.oupj37rnthf6wgdq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vernon Yang <vernon2gm@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
 <20230505174204.2665599-32-Liam.Howlett@oracle.com>
 <ZFj4dNW953l/qCb4@vernon-pc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFj4dNW953l/qCb4@vernon-pc>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adfd35f-1cd0-4734-a5a6-08db4fdee777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClrNAdqqRQyihDA2REXCDRl3RQoD3e8W62RQPg5HPXQ4bzKwfafgIauwu0o2Ws0F0lsR1pJRUJy/9VRYCrbnxxywe4dXe+W6lknffpnaEBAfLkhNM4/BFFruFSyzczzFuH5gP9py77t9O1jlNaEhuc+ABeQsq6wk7KV8arpURtg51lS98Oitn86t4BcUU84Xcyo5ODZP5/qLjnDvBNgrcq99viXNxEVL9c18j8fMvox8OkVntgMHocEG6CkzNQg62NPkjooEtS1mu2BO1SM/t4+CwSxU1oVEnFYU42x1eWMMOL04medmjGAJiCXoODDOGYYO9I+XYF0Af7v5jDvTQtbGXXiNe2V49QLmQDVB5fAW5hbwtv4gqlwZB+3wzg8wNcvDoX2wcc3x64ejuQ/xfEu2+8ToWI+00uy5ECgYbLT0iBj6BBO6fiS8ucdxqtYaPo7YiRu9cP/fLGv9sf2dvO7/QU8k7SboL7Oyaq1arBU6zC0A2iVCawdPpopFQ4oXVcamSkCHq+h0jKIJSAsqq7Bh1iNjmVguRvi3lCSBEZVfhGhq/nGwG33+3FHHBsLU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(478600001)(316002)(86362001)(6666004)(83380400001)(9686003)(6512007)(6506007)(1076003)(26005)(8936002)(5660300002)(8676002)(2906002)(41300700001)(33716001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxUpXDsjtMHaTOJMId8NuWOKgvg+oL6oL0FQ26+TDaAdATEX4NfRo1+y6L6G?=
 =?us-ascii?Q?uKEaaQsVQpuwbpMWvynZKJ/xERIycPupZjx/965og5oCu7Wq4u1P0thEsXSf?=
 =?us-ascii?Q?zrIe8iK5/2i1U51xCWapk9E/ogYD8paC/KuMabsxwgGPqvO3Ds6KjAE1aU5K?=
 =?us-ascii?Q?D3AQVUCXNhQwl5vP0iEO1kLZonZ3GmUVnTJcTBwRkrv+kRvgSZOHsoafVrYV?=
 =?us-ascii?Q?x1AB1NHFNV7tLhB21cVLR2T6CSbXocmICMpv+4CGQd32Kh2qYqRYXBrnQLPD?=
 =?us-ascii?Q?FO6S8N8D/98dn0HVNvMHduM2KTQuQ7Jwk8DgNebCRgG8S3sJPbITnt3rWNte?=
 =?us-ascii?Q?ufd+IdoQPca6POOlWvrX68H29QGalfMfpYZk9FzopW7Fw8FgPIky+fkChtD2?=
 =?us-ascii?Q?1e6ylS191DRQ2sfr1tTKcVDrTanbwyrPlrPkXo4ILH61S0cInx0VlmKrLncA?=
 =?us-ascii?Q?qcDimB9Y/QgE0rEhAR4xyMtQp2JZgscqloLtprQQ4M+/cBlLtj12efNIhTDA?=
 =?us-ascii?Q?0V/zQgSMG+eLDyaANNA9dF+vWD+pREf+tb4G3oPvxjMw3lV0e4gPmUic2KbQ?=
 =?us-ascii?Q?xgnDrr5aeGP6Q7AIwHHDOPyh858ZFZoPaN7Fl8YFdcW8JMQ2ynI8VxYVYl8N?=
 =?us-ascii?Q?Xbx/U7oeTUuqbc7McYAI3khv8ScqiWcQPLs6YxRjokQsuibNRGbvZbgXrtac?=
 =?us-ascii?Q?WLCFi2ysqZTBz98uGmUFmARpG3KgGcGgjiQNROPkUNm02U7U7qTzLjHvO7NR?=
 =?us-ascii?Q?7NWl7FQrPeXgVFRm2x254rqBCJWMjjj7bcDc/JcovoPGuc5iZjIOyBhZp9ZT?=
 =?us-ascii?Q?OvgUnU6nZi6B+Dgj3DY3KQmFrPIjIin1u7yo16W5ckF1pi6K5SKup2caT/Ju?=
 =?us-ascii?Q?q3Vjhc0Ax0/w1a1zuV7F8H7Ru0+3dQHFBmZ78jK8CqZYKgPLJ5Soa+4b5jVU?=
 =?us-ascii?Q?nkUHrhP1plFwzaXp4v1YSJfwKwdtWllUReonRd680nJ/W8I//UsU0XcA5KvK?=
 =?us-ascii?Q?w5NMUzDLKSzPMFssIINn1PiLxaCrHemBGM7kTnV0oQAa5wNg1UOQV0iKTJVC?=
 =?us-ascii?Q?O7VPD56rCFIoJREEXLnat5NHD7l3g20qs5csxFfQwPJsNuoiZ7EDuxUDaEPD?=
 =?us-ascii?Q?unXtnXVTbjnAk0WVmyrOSvAVMr8vF22qKd5FFSOPZuSrf1DOSQkpLJB83W7m?=
 =?us-ascii?Q?Q43GV6QYE5+7GGUM2ldMBz2DBAJh+ojxDGQsAjCqCUuA6lu4rmha4XyBTypX?=
 =?us-ascii?Q?abYwdAQyQZPeWcxq9rrJiOQfUFE5uFz7KNsJ9tFYpgJr/36wO5utg2+Y0Ibs?=
 =?us-ascii?Q?tR+giHt88e+ukxDLa2W+tJ5sfFEj8wop6E9tmeal3s3AjG/x2L90P7IQhFKQ?=
 =?us-ascii?Q?a1t0AiORXcuJQ3lfbgesc+W5m7GADHtzOAC+O3FGRhHBkpoh2iymy9xL4cPw?=
 =?us-ascii?Q?E7TwKaWBM9pU6inoKy2v1QUPgVjUEtoVOglKA7bMV0U7YYOGIC6hERe+sn1k?=
 =?us-ascii?Q?VeTsEk0Rpfdtb9extpmTJPkVfxpOIisvWNzzu0VwxAYO5fcGmr0R2aBJj9cz?=
 =?us-ascii?Q?esBf8GR7F6DPvyRA/yVqDJ2nSLDpr9KemVjsbN/z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wsHXU3mFCfu2ugAArPK+BYYYtRxhvE7EezijlBmKlzqkjgoziaTvMPLAdvL3F7N4cY6IkvfLlqcXV82a3zzaxn4cejDcmEsYtadkm/3AHFe7YHwEXJuywbsQtXSmTA4LrzqILHI7oJYkOgf97Fz4jJThYO/JvjRWTVDI6QmOmnD1hvaCsmn+wPG/V1ZBOlgTITjdXUCckVvIc/kk/+U6JKv1mp5pGf4ThDxMZuMhRw/FkyBpab6G/UrjW/FAaiOLia9cqfxHCkdBtNSbLpBft62FuqrFpPmKhGJO1OWKEgAx4A5oLUPajYjNVGEoMx2B5RkNnMUe6x52E5GXd82hyCtcwG7FCIlammWUfx/U/05UiopAgbKjKZZRap5SaOZYmHX/l7lBFRfJhSYmwk3OiuWfmb5omqLz5K2RnNCu3VBANPDWm2zCGqLDrleYlL/buuYedrHr1SQ9MyuZ5RxKo7qBSAmyXl8EIwnkK5o//87EveXUsPBaZiOnUdAsz/IS3lxEoqfkQxwogthOp6QhOeaZ1y6EHbV4vZvBmDMQQg+cZWV1yjwdW1nL8qVSBwkJ4HZQ0ttlS9MchZ0HSsSk+2zrlOBZt8paa/OojTx4TAo4R3kFT9s8RztWimb0fQICQKx1mUBnvEkTadVc4Ee5EQRD3Pf0QZUFJzPPS0bvgiXPsj/WbXB6tNhit8eYRIlUvslExMRalHGcSxi8PAGh7VbRYqBJeKXhXOo81W/LZSEa0PI11WUZGY5eZ0KxHzSzEuFwyQY8HEhcOp520foFsGpKR7KkTvkmr/z2Hh8KYggSMwww1MBYTRAPKJEDmlwpNElIMRXEiHZtzTRnDGUFwa7MjvElFXsnodBcnGOUIOILjzQJLQ6Hyix87igilRYzxIP4hsW/1Moa3qQLTw3u9gr3InuV80efePXhuVhZIX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adfd35f-1cd0-4734-a5a6-08db4fdee777
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 16:11:38.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ+jjBjjQ8wugcfH8CqcCMBLhlmK1AtgqDW04n0D+reBf1AdhK7shHXKAlpGVxUqy/6eFdqvxwrPoXK+f79Agg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=987
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080107
X-Proofpoint-GUID: fvapc26456mS4k7_FjrKnDTylrCOzJ7H
X-Proofpoint-ORIG-GUID: fvapc26456mS4k7_FjrKnDTylrCOzJ7H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vernon Yang <vernon2gm@gmail.com> [230508 09:27]:
> On Fri, May 05, 2023 at 01:41:59PM -0400, Liam R. Howlett wrote:
> > Some users of the maple tree may want to move to the previous range
> > regardless of the value stored there.  Add this interface as well as the
> > 'find' variant to support walking to the first value, then iterating
> > over the previous ranges.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  include/linux/maple_tree.h |   1 +
> >  lib/maple_tree.c           | 160 +++++++++++++++++++++++++++----------
> >  2 files changed, 121 insertions(+), 40 deletions(-)
> >
> > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > index a4cd8f891a090..542b09118a09f 100644
> > --- a/include/linux/maple_tree.h
> > +++ b/include/linux/maple_tree.h
> > @@ -467,6 +467,7 @@ void mas_destroy(struct ma_state *mas);
> >  int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
> >
> >  void *mas_prev(struct ma_state *mas, unsigned long min);
> > +void *mas_prev_range(struct ma_state *mas, unsigned long max);
> >  void *mas_next(struct ma_state *mas, unsigned long max);
> >  void *mas_next_range(struct ma_state *mas, unsigned long max);
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index e050fd1f7cce8..f060c71965c0d 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5924,18 +5924,8 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
> >  }
> >  EXPORT_SYMBOL_GPL(mt_next);
> >
> > -/**
> > - * mas_prev() - Get the previous entry
> > - * @mas: The maple state
> > - * @min: The minimum value to check.
> > - *
> > - * Must hold rcu_read_lock or the write lock.
> > - * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
> > - * searchable nodes.
> > - *
> > - * Return: the previous value or %NULL.
> > - */
> > -void *mas_prev(struct ma_state *mas, unsigned long min)
> > +static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
> > +		void **entry)
> >  {
> >  	if (mas->index <= min)
> >  		goto none;
> > @@ -5953,7 +5943,8 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
> >  		if (!mas->index)
> >  			goto none;
> >  		mas->index = mas->last = 0;
> > -		return mas_root(mas);
> > +		*entry = mas_root(mas);
> > +		return true;
> >  	}
> >
> >  	if (mas_is_none(mas)) {
> > @@ -5961,18 +5952,64 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
> >  			/* Walked to out-of-range pointer? */
> >  			mas->index = mas->last = 0;
> >  			mas->node = MAS_ROOT;
> > -			return mas_root(mas);
> > +			*entry = mas_root(mas);
> > +			return true;
> >  		}
> > -		return NULL;
> > +		return true;
> >  	}
> > -	return mas_prev_slot(mas, min, false);
> > +
> > +	return false;
> >
> >  none:
> >  	mas->node = MAS_NONE;
> > -	return NULL;
> > +	return true;
> > +}
> > +
> > +/**
> > + * mas_prev() - Get the previous entry
> > + * @mas: The maple state
> > + * @min: The minimum value to check.
> > + *
> > + * Must hold rcu_read_lock or the write lock.
> > + * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
> > + * searchable nodes.
> > + *
> > + * Return: the previous value or %NULL.
> > + */
> > +void *mas_prev(struct ma_state *mas, unsigned long min)
> > +{
> > +	void *entry = NULL;
> > +
> > +	if (mas_prev_setup(mas, min, &entry))
> > +		return entry;
> > +
> > +	return mas_prev_slot(mas, min, false);
> >  }
> >  EXPORT_SYMBOL_GPL(mas_prev);
> >
> > +/**
> > + * mas_prev_range() - Advance to the previous range
> > + * @mas: The maple state
> > + * @min: The minimum value to check.
> > + *
> > + * Sets @mas->index and @mas->last to the range.
> > + * Must hold rcu_read_lock or the write lock.
> > + * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
> > + * searchable nodes.
> > + *
> > + * Return: the previous value or %NULL.
> > + */
> > +void *mas_prev_range(struct ma_state *mas, unsigned long min)
> > +{
> > +	void *entry = NULL;
> > +
> > +	if (mas_prev_setup(mas, min, &entry))
> > +		return entry;
> > +
> > +	return mas_prev_slot(mas, min, true);
> > +}
> > +EXPORT_SYMBOL_GPL(mas_prev_slot);
> 
> Hi Liam,
> 
> I guess you want to export mas_prev_range symbol instead of mas_prev_slot.

Yes.. and it mas_prev_slot should be static.

Thanks for catching this.  I noticed this only after the bot complained
about non-static functions in this series.


Regards,
Liam
