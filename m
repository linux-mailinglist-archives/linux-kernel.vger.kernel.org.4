Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A76A0119
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjBWCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBWCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:12:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29395BB0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:12:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N1mwi5021948;
        Thu, 23 Feb 2023 02:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=j+cpta4PU46F9vow7nOL+Zjnx/WnjjxyS+9ffrm3Jwc=;
 b=ZCKeX1mLaRjzcBt2WXfL5fYoh9DIc3f/96b/BV6XzjsCB5MYOjalodXBueyjR5hupSFf
 xTaiit950U3iDbctXriuNZlp8tXlGYlKXJB+jMyX0+/f8OBOP6qrXQRp8rgLVl2ctNv8
 lP7hQT27XiVvYicgGJTvA/nxptaZU0u1J/VkRWh7IDdwIu83ZjvT0Yrvba9s9ff078oY
 iqAxj19zDXZNaWfQPdZXhh/iqgIyYUysCXMwpqW7zd8Tq1Z2jBwHOyC/lT/IEF9zf/8o
 5/vUicVDDFIh1M2dxardKSwQ841Jths3sq7/yzehAD691uvCYL3clpVMbwMfatFwoKyH rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqchh3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 02:12:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31N1Q2KA006871;
        Thu, 23 Feb 2023 02:12:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4dxxq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 02:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW9+9V0/hRo/aaQ42Pt9frg1fOZstHOIW/oYkDbuxyF8ME45SOBqLDp6uoe4sYXzaFMEzRCDLI2vlsNfHiEQteyc9DS8lMo9xKJMu/CkE/hqc66SJwoA0Sb/C2xV8OsUnHMzp6YPoAb5JgK4RifabN5N2v8auihsFZAmvCd2gyH/hGoWt9gSjuunIbm4S7vuaG/v7Qf6e0qfe1F92jailkZcQTfNSHfECEix4pxR95Ytd7cv53QxSzk8+5QGAueF6CzTBhDSjPLEXejVd7dmKUP2TEPzr4jI2NsM71T/fcGU7tiNlifTg+jupXYQ2KxEHCFTvZjtaLWUKP+22qeI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+cpta4PU46F9vow7nOL+Zjnx/WnjjxyS+9ffrm3Jwc=;
 b=WbC64V6KviHrdeIOreGf5XL5AP2Wmqj8FI+BxvSqmw+x0BWbcU5JEVV8/qCqGDrRrCF5e4VJFv36ci7IItk5rygcrrYofRJJS3M4GPaO+/0aTVNgIU1RCbbfCNOMy5vcxA1w8SVjaSu56N6AZZ0ZUNio1RWxLFo/E70WESgGAGeoeIoddi5lz95dZnVNTMA3VoA03tqFxOaRkltL/RJTgNDIDsvPbUFYkVp3y6jPeWlFsugoEvnac6eQffIIcIuAb6KqfiueGS6Qxrxh0QsEe8NoYqnqh32kl9lzY5/raq2ULgq5bLYXjUVFJRj+LqqySv+q6BfQ51CyO3Jt67kL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+cpta4PU46F9vow7nOL+Zjnx/WnjjxyS+9ffrm3Jwc=;
 b=X4xDid4KoAmLtQrkoE1kGvt7xWHZ2zSnGG3TO5CDBX5XPwsmUhUedRpcHILfpXyj096rkvq/bjmDUVTXe54CoMUFibI32SviBED+oY9zAK3nVxzZ+Yt3P/h6NaBmlww0nCYsE6JdkWccW4BzfydadSJfqLrHkhBGU2iEzjeVM4E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Thu, 23 Feb
 2023 02:12:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6134.017; Thu, 23 Feb 2023
 02:12:37 +0000
Date:   Wed, 22 Feb 2023 21:12:33 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 48/49] mm/mmap: Remove __vma_adjust()
Message-ID: <20230223021233.f2b23zhfpoqzxryy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-49-Liam.Howlett@oracle.com>
 <ad91d62b-37eb-4b73-707a-3c45c9e16256@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad91d62b-37eb-4b73-707a-3c45c9e16256@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0035.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: 582d10f4-69aa-4a95-be4c-08db15436eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOI73QONJFJWJBmu17ICR9VmOsxqbRaVZU6xmO0vETPHT23ifHqkpCsOUmJ56qObS4jMJttLGq7exr+2PlSuWOjNAWdL+gZu69wHCWcs4WpqIlsAL1MDzI4FtCtilGU6dJPz4nR5RiTt0YyAVCJgyrQnDQncNC2hEK2GqDDu3giE/gBzpmUWdi5B73EUJINPp+JCWF3tRwBa8EcqPrg0rRPRgdmP/DqIBm6E9NwHqstZxsGTMRYXUnh1gSjsOv4cG3GXqrGDdhDbhD9NPelDcVC3LSCVZaQou6JyKDSmlIPYrxbA+P8zw1wHCE/m3S5GHEjoSSpuHhZn2UBhXEKeSGCsZ+1cVbI0BDnWGaO5xPR1Ovw+hTNdozjc2UcDcTu9cG9ylfxHB0Zful/0hJ4lVKZKIg07+UUpvO+iHIliHthuzkVcwRhlXmBXIgH1SvaC2kNIShefOlaXcFoi2zq8XUz1xXsyc4k1apQLj6DPBl94RpzlOeExjPsb1iOth9vcd97ll78nBj90ve/vKLgQV5nGjSkwfu7Bm9XWyiS6xgd1vptzKEZesX78HL4L3UuyA5EddT0fz+vrTP5efC9hRUSRCgsgtygOainVQqC/RIaiX1Jq0tde7/BWavav4oFyOdQVvQ2jA4KISBguBU/TEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199018)(86362001)(33716001)(2906002)(38100700002)(478600001)(6486002)(9686003)(53546011)(26005)(186003)(6512007)(66946007)(66556008)(66476007)(83380400001)(41300700001)(4326008)(6916009)(6666004)(1076003)(6506007)(8936002)(316002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgxrL7VxBB+mL6OY34Dn0/D6TOYJh9VM+5q+17oIOw5DZm5Ka+U4O2K6J763?=
 =?us-ascii?Q?ClGNuNPkjaCYVLt0PeqLJKVSYQ3dcNXfdTVCH+95qfK7JGH4oY6qV8FQGLt0?=
 =?us-ascii?Q?7KxkK+11HhthVnW3t56UklGOB7nRsqGdttC2fGey7C+SVDATNIMMm/lVFLw/?=
 =?us-ascii?Q?6urWBlyU2uan2ujwmk3hAmsuaR/46QHTkHlHs1sOw2SN1L70N1gSIuF41+rb?=
 =?us-ascii?Q?azp4/jtEs10dG3EJIJIK0TsUt1GUtlX/7UoKLIfJYEaLhWD7IW5z7pBVxBgV?=
 =?us-ascii?Q?1R5Ml2aSJQqFZlsD+j6z35cnwEqtFajEwxnkeZZWNmpxkkGTvQU39WW0sJAS?=
 =?us-ascii?Q?y4tXrb9UORHjHcFGM9o2AgUeoiMo8ajOT/PrEaGXRY/ICu0z36/cGQ8H14+r?=
 =?us-ascii?Q?LubMWiAHFgScg0y5kAfDCU2FdpASXhOHzlhBo275KpAu2h9tUhB/1Qs5eTVW?=
 =?us-ascii?Q?30XwWc46mluQq1AWT68aQ6yury3NbylxuOU+cUeWhqZdiaVH0q3p0EeBQPaG?=
 =?us-ascii?Q?dFKRm8f9iKuU0JJcinub688H0pf1+J8qTMN3JmBT6PP6aBRPH6ihc2JeFSNr?=
 =?us-ascii?Q?frZIZ8z69FcUkoH29pXPlgRhwGDK2XsMRxwin+uJ75o7G7orrXBXP2KBD3Ql?=
 =?us-ascii?Q?ppgx7qAOU/XL1l+9mTrfxdI9XbPJinTdJz3hPhu92YlWr/uHe180FdOke1+l?=
 =?us-ascii?Q?8bcWRgDjVDjXlUs1IP+qd670rU3U7pQShTITZTNYZ1yWV9kxfjybrjPauhEh?=
 =?us-ascii?Q?hTTnEYselcBAlazW5F++zKPKawYyTgyTADbQsT93c+2SdXLE8dFy5Zw3MaP1?=
 =?us-ascii?Q?TYS+9pMKYtd+SElZmPKTnAApOs8j1wpxAzDeTdiCdyLXfRvubqXELF+VJA9B?=
 =?us-ascii?Q?Zt5w6IQoNkZFlvNLGveOX2ufXuQbrTc9su1V3fRJLDUci8I2q5mg88MLVh+n?=
 =?us-ascii?Q?GCqOLVHFgVPJCFKVCSS/npLLWacqVGwljmJl5Zo/vbaLrII6VEvpdeUKM5Gg?=
 =?us-ascii?Q?vQugfeTkhyRtxxLeky7qW1y7FJEKrcgxdY/i2oVxMpe1TxXYLd6yUke5nK+R?=
 =?us-ascii?Q?MuB1NGHqpSwuIjp4067R6Hexjedqr0UXO6rN/SIPnP+OqGG6ue49RW1x+NTl?=
 =?us-ascii?Q?1QWb18dj0HjyDu1ZknIUB4rMATsL+84kFEjPIYnWAcgcnMDoUKqaQKM2YTGE?=
 =?us-ascii?Q?lW1203tLf2fmY9XvSJ7rN8ClKgQt2w2chC/RujrK2GUcmrZ+Ya8zOhwzzjp+?=
 =?us-ascii?Q?QpQIDSGkOVwevCBCngLwre3ZD8u5h687ODKqDKx1FvKSF0yfOMTyXhRWtvEq?=
 =?us-ascii?Q?dj4ZyTA+/cVkbb3+qqBuz+kd3Vs0sLddc4qT9YgiFtK8eX1VcocnzGHWVkzg?=
 =?us-ascii?Q?Gu5dVI54akKwRYz5SjY/qZyD61nbMeo3XnqOyBUwizRHuDt5fBppO1Lt2dYv?=
 =?us-ascii?Q?5sD0trG4qxHKTWmGC59wbHdZP2BuL2THPyIXMwl4EpZTxM4gb4Cxz+DzoDqD?=
 =?us-ascii?Q?pBeVGGG4gZ16X30ojICKtkGSwrMI+Gp0J12YtO3hd8TOnnIcebXJq521LWwY?=
 =?us-ascii?Q?AaB/yZDRHgCxAWWSC+ZThQc9EidlJrFyjD755eSEjaybesLHzCIB/UoNh7eH?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ig3AgFDdO0q2ZW8jReFrO5I5oVX1n2tYLO3M/WBnqI4W8qO5oafaY1DBDOExQMJJFykT1VZHO1v7EZwKop4YzngRaK+8qJfIvRLdAjHjvML69KQ1ahWDJQ56TX2qRvJPWnwap+QIlNjiQJc0Q7nz4sY/VDr7mBey7D4cjS1U63/r8GoSPjOs8iPTNmY5lcAD6PobatQhbeawevPnejGeqaYIkaVaeZfjrb8CPx83eknO30rz6mF4kQpUaoKnPLIFh3vC1JukJ855Hvb1caLW/rzJhH+zEy/qN3GmVnRFsyExGEtzX3oyjYzQ79ltXGTArfUsgzFqlF/Zi/uolYBI86EZNean4tftgpGK+PSS/Uf9VXJOli14JTDjUSCxx7rJ9QinVOkw/FYIVsq9G6ehA5C5EDnk7/AphZjvOTco6xb4TvAEaxH+Y6+UUxoYy2dweadL7VPC5VnKL4795w0UWiTxtmzjCc+WxID+R3gg3DJOy5WpZxYDRpddnnEkFBrU7X1t0tNiQjqeMC9qAiTxnp2yi96l/X4SMdCiu1HL318vKKfpIPycT0j1Sikcc/l3wShzsoUYpZcpaorSGyliuCj6EwqYNmpFEO3w6SbwJ6AK6ouofe0SgQ+C2IhzRHk43emr+IeVxUvnU4vp+dTrt8bqyMqqnix7smhgzGvTjCSZ+HfmxVI881xxihoaJIxt6jsueGu+5GnBBgPkM6uJMXbs0H17MVAKOJbXri3lSHJmEe2faFSj6A/v/TsYK5HWn/g1lW67IEk8nx7oz3Al3RpqPax6bt3fHq6m6fFibPsMpX01Eu0rL13yYEaHmXMEw595z5VB15NblDlhuN+Kv+jrnJ0CxJJxCnDPbYpJVmUgz7QqdazcO63oisu0iNdvyh281GasqTj5ZiKskFLSHkQdjQqVnc6s9ojvFryYYbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582d10f4-69aa-4a95-be4c-08db15436eb5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 02:12:37.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XPZzO+wGeTfsl5yAYSkXZ4a6VCNm29rHKS44/qMjlhRRWUVUgVXPPeamtBDMfP+NfJeUQNq+/1fKweOM8YBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=758 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230017
X-Proofpoint-GUID: 5_v_HuNxfGrN4xBCA8TqUIWTLS5bmG8l
X-Proofpoint-ORIG-GUID: 5_v_HuNxfGrN4xBCA8TqUIWTLS5bmG8l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230222 11:17]:
> On 1/20/23 17:26, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > Inline the work of __vma_adjust() into vma_merge().  This reduces code
> > size and has the added benefits of the comments for the cases being
> > located with the code.
> > 
> > Change the comments referencing vma_adjust() accordingly.
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> ...
> 
> > @@ -1054,32 +945,85 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  					     vm_userfaultfd_ctx, anon_name)) {
> >  		merge_next = true;
> >  	}
> > +
> > +	remove = remove2 = adjust = NULL;
> >  	/* Can we merge both the predecessor and the successor? */
> >  	if (merge_prev && merge_next &&
> > -			is_mergeable_anon_vma(prev->anon_vma,
> > -				next->anon_vma, NULL)) {	 /* cases 1, 6 */
> > -		err = __vma_adjust(vmi, prev, prev->vm_start,
> > -					next->vm_end, prev->vm_pgoff, prev);
> > -		res = prev;
> > -	} else if (merge_prev) {			/* cases 2, 5, 7 */
> > -		err = __vma_adjust(vmi, prev, prev->vm_start,
> > -					end, prev->vm_pgoff, prev);
> > -		res = prev;
> > +	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> > +		remove = mid;				/* case 1 */
> > +		vma_end = next->vm_end;
> > +		err = dup_anon_vma(res, remove);
> > +		if (mid != next) {			/* case 6 */
> > +			remove2 = next;
> > +			if (!remove->anon_vma)
> > +				err = dup_anon_vma(res, remove2);
> > +		}
> > +	} else if (merge_prev) {
> > +		err = 0;				/* case 2 */
> > +		if (mid && end > mid->vm_start) {
> > +			err = dup_anon_vma(res, mid);
> > +			if (end == mid->vm_end) {	/* case 7 */
> > +				remove = mid;
> > +			} else {			/* case 5 */
> > +				adjust = mid;
> > +				adj_next = (end - mid->vm_start);
> > +			}
> > +		}
> >  	} else if (merge_next) {
> > -		if (prev && addr < prev->vm_end)	/* case 4 */
> > -			err = __vma_adjust(vmi, prev, prev->vm_start,
> > -					addr, prev->vm_pgoff, next);
> > -		else					/* cases 3, 8 */
> > -			err = __vma_adjust(vmi, mid, addr, next->vm_end,
> > -					next->vm_pgoff - pglen, next);
> >  		res = next;
> > +		if (prev && addr < prev->vm_end) {	/* case 4 */
> > +			vma_end = addr;
> > +			adjust = mid;
> > +			adj_next = -(vma->vm_end - addr);
> > +			err = dup_anon_vma(res, adjust);
> 
> I think this one is wrong, and should be fixed as below. I'm not
> exactly sure about user visible effects, but shouldn't matter if
> we fix before rc1? I guess what can happen is we end up with pages
> becoming part of 'prev' that have anon_vma originally from 'mid'
> which is not connected to 'prev', so eventually some rmap operation
> will fail to do the right thing etc. Or 'mid' is unmapped, its
> anon_vma freed and we have a use-after free. Probably rare to happen,
> but nasty enough.

Yes, you are correct.  Thanks for the closer look here.


> 
> ----8<----
> From 854f4cef0fecde9a0a89ff1a5beb0a1e2115363f Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 22 Feb 2023 16:51:46 +0100
> Subject: [PATCH urgent for 6.3-rc1] mm/mremap: fix dup_anon_vma() in vma_merge() case 4
> 
> In case 4, we are shrinking 'prev' (PPPP in the comment) and expanding
> 'mid' (NNNN). So we need to make sure 'mid' clones the anon_vma from
> 'prev', if it doesn't have any. After commit 0503ea8f5ba7 ("mm/mmap:
> remove __vma_adjust()") we can fail to do that due to wrong parameters
> for dup_anon_vma(). The call is a no-op because res == next, adjust ==
> mid and mid == next. Fix it.
> 
> Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 20f21f0949dd..740b54be3ed4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -973,7 +973,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_end = addr;
>  			adjust = mid;
>  			adj_next = -(vma->vm_end - addr);
> -			err = dup_anon_vma(res, adjust);
> +			err = dup_anon_vma(adjust, prev);

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>  		} else {
>  			vma = next;			/* case 3 */
>  			vma_start = addr;
> -- 
> 2.39.2
> 
> 
> 
