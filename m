Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341A6114EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJ1Onr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ1Ond (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:43:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7451D3C68
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:43:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNoRa018953;
        Fri, 28 Oct 2022 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=s+X/+6sVKTpHJ0ws2XTxbShkdeqHTkvIsTPX81u8LRE=;
 b=kKP3ACegVX+i4QdhHaWzULNPeU1myakH2gJkH/JAoJ5TUFYE9nWHAromdIffmccaGEKT
 8197MrqItphSPO7jWPOZC/a5c93FYbICQ7mnTgh4qJQjLByBfLgGo33u9TyxpUU0nflZ
 9gf0002q0B5mvP4IF0N5xcjDdINUJBBWUya/V0AteU/idFEb3bAQ/oH6I58RkiCA8DmJ
 SppoFMxN9RGUcv7HPaDd+f2GFyCzE7pBJqCbPhI3DTPziu2X+bUk6HWC1CjJFPWB3DcT
 DDWTHxVQdPZoaI+2latNt533sumGZqzVq3EMHrns9TZ0/eTK6yRt1BafLaH3o8j5i/4g Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7vyyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:43:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SE28o3011896;
        Fri, 28 Oct 2022 14:43:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags5d5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfkEkaxgflN1vif9vqE5hlDXxOZ2oJaOaOmjH6FD1b4CxQKc751MykvJVdCB0MJVD8oRWtHI4ybKz2wUxyjJRXKdqgAVYf07GOsOmcS69cBULvUpqoKMG6qvOGcoOcmxsVZ2RAQyigZRQmwYUiVbdslksChraUziYTpROCeInfGRPkHu+HEL2+eRhcPmkmOt/7mq3wbrJTLo2AbtH6Eud/k0lw7jYdosSCvKt9FyT4TksGW1IP3bRcdgjurIjHJUUsY1sSC4mh/GiHzgKcYl1AjdwGjyGsZqgwrG7gZU1MGHtMetrceJICDvPTdKwYNzWvZDP2wEUXNx6x3H0z7xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+X/+6sVKTpHJ0ws2XTxbShkdeqHTkvIsTPX81u8LRE=;
 b=Vohn9mN2oKYNG02bkPLG0tZN8CgZY92pdoG9s29IJB8T3Ysvndnq0MgU9MANbk/al4vVwMcnpgWpFxNehxkeV8YBQIriecKmbQb0IIS+LDYkSBgxwuC/a4TOhKkDxJ5uo0wWR+Id71mAsWk1SzIRtOH0QnnFy0Gm2YIBWA4D8PnsZFBRDtzyRreHugiCKLbrsq0tFlwd+Rb7GMvX595hSbEYD6c+i/8mpJASOyjDzIlikE8azGGFN+qAygR63sAZaKKa20w1EGMMR34GcPWD6vZnjtqVOGF6S37J70vkmv8orBNJU6heAhKFXlFWPqolAviiSrz7hfFFkCGbpQzLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+X/+6sVKTpHJ0ws2XTxbShkdeqHTkvIsTPX81u8LRE=;
 b=BZOn+2dMYj4YR7JpI3kG/0KZvMOobCWs36cug5a3x0y/QgBv/9hKh4B94LwLH89aFJPYioX10QZDvllWbcuTOaXyf5HyILtshy/0tCENALxuY95EuTVQ6Uxl/rMvIPL0JCJcihie2F0KWO7o5VoXDALsEGUy2GRDw7+SRY8mMW8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4335.namprd10.prod.outlook.com
 (2603:10b6:208:19a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 14:43:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:43:14 +0000
Date:   Fri, 28 Oct 2022 17:43:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Use flexible-array for one length
 array member
Message-ID: <Y1vqd/ij5WqcL3Qe@kadam>
References: <Y1vRivFfRD6VoBt/@ubunlion>
 <642519a2-664d-d837-983a-1d5bbc72a25e@gmail.com>
 <Y1vjKtM9druO2bSN@ubunlion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vjKtM9druO2bSN@ubunlion>
X-ClientProxiedBy: JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN2PR10MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 5118d839-a440-4a78-bdfc-08dab8f2be08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqwm2/RRWnJc1tlGhZaIRtqwJnRhaUbsKr7kobghcOoZJrMMkGq1966lcO6+9bqXfojd0xcxblT1D78qOgBMK/rCtvACFp/tJyzuruGBj1NISTxlEyNF76ksB4TtnK0zkv43APOvW3yc9DRmbfKsEKWKVyxgdZADNimPMkejGmp2/eVEmK96m8SWV4oeDncL9w0mAhm9+U2ot9DjnbvxaICHrHG/D0pJjjVIkQ9WNkSZPYB77N0G1f/o/ZR+xSxtwantpLvqGtPeIEY7rDQwvVlTiE9jWCjyJ956fz7ivI9FgpQrlfE0HKEkpm8/YjuOzIKa2aw365tY1pwVWx3Ds4F2a2HrL5QQe+7ck5hFGMlM6uLh/GRrmwfQTCUKUJ8Yhq0xqnlsZWx8GooIpttdDTFuryLGsbQzeNBGQuxKqB70XiwGpXGtZV5QIiD3KVE5p+n6Cx5vhhZuzeu9AM7xleU3GrkN/cj+ipPSHLmBPsp1lzolVexDrhFHnMI22qaSqRbTRLR+smK0vOjQOVUEi/kdo3qqEdLDdqdxRcI3S4dQZhNriaVaZFAPxcyf8Xn7I8JNlDqJ19FuLn6yVudnL/QebhIgS8OsG8YQKGJuOcaH1QJ2gTQBXn2LL7ujK9Ep/QWRTTulRYyX+qmwsB9E5c3qJq+PgzHXgqRq8NcDC478b6hNh9v8ACvLRqf7Xa2x1tAqIV2FBCOlTVut/13YQYSaju8iIzU+KUMpZT+BWMlOE+luERdndcNYlcLQpYSMhglfSpuAYbD69RCuxr/2zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(38100700002)(8936002)(6916009)(54906003)(2906002)(966005)(6486002)(478600001)(6666004)(33716001)(5660300002)(86362001)(6506007)(26005)(6512007)(44832011)(9686003)(83380400001)(41300700001)(316002)(66946007)(66556008)(66476007)(186003)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2I84pVzO7MhNNQHrHbZyZnP4zV1VluJ8RL9VC/fmeUW4ygRZcFITTHll5EQ?=
 =?us-ascii?Q?vvbZMaW3cMuB/fR/e/Y6QUyjFei4mF0fR1Kv3LOhzKUPD8VwhlkKgPmK+a9p?=
 =?us-ascii?Q?p/0os3LqgQVLNmu8XpaqOlllQayyOAuXUsJmgeEocoVdGwRAWMivgGiF9ND6?=
 =?us-ascii?Q?/eAUrdU/rMp4otUlg5rPfBgoi4Ofs8PVbnZ8RlO8JRWMZLME0WuIkgDM4hXt?=
 =?us-ascii?Q?RjOLrq4mBkraYnYM4M6G0qckeXRwqUj6SW3CKBrCsVnVx3sKuzoX1yWKL1iX?=
 =?us-ascii?Q?kI/VF52Yuiaj64/Z1nghy4LUFN/L0gATFtQegAPAf7LBWPxHc0EIsnqPpbzZ?=
 =?us-ascii?Q?T//xUIFEeR5uHHOIn9nJkRdY1/l5fuxks0H6T+rV0jy9n1vtPKFW4Gxf8npm?=
 =?us-ascii?Q?WR7gMHF8ZpG2+kR7+wC1vw7JpsuVcrwD1G6TiDHKZqwJvtDnaCxjFlyRuazA?=
 =?us-ascii?Q?PPOgP20PpDrteoKKHuQ+oM1INOpDpcs3qxilCJ/v1qhpGLbP+sV5OXchrFGI?=
 =?us-ascii?Q?7UcUDL30upxtSVJmItK5vVB94Sw/gZmY8JfBU6G1gnEzDbqd3SxpJ+mxAXLN?=
 =?us-ascii?Q?3cBM5c+Zbxo6NtPsw4cyeQ1tQk8AJZKC5rKtvlvCIsQDSVGu/FmQ7i9FKb16?=
 =?us-ascii?Q?i/dbxRKZtLYYdACv+caMDzQoGWUANK6m95xbDrtmMCa4g05vicymqlWDgXha?=
 =?us-ascii?Q?ecninxr27rSbSsC/dicJg5C3x+/A8dlIfa6SGO3+YqpomJ7J3S0Hjbd8Qk2O?=
 =?us-ascii?Q?6PwUYGQ7raJtzEoQ3Ybv/YRiVQa2/nnOrvDQfCnkn8zs90coF7ueoYG5nk0/?=
 =?us-ascii?Q?7sRygZA6xjIKpHQyFrKvW/zlO7g6dx6xzotQMfE488FlNm72HUK6yzn0dxAL?=
 =?us-ascii?Q?wBXuxdVQ/ywIFGLIeErJdwqZLm/V9eQ1jdmL3KSbOSh45YmmmsbSkReTGior?=
 =?us-ascii?Q?oD/o4UVgJ3h8mPa9nZEDQ1ReXVRxIwMryViFSF3GG05RGKYhZpat/FJD/TeZ?=
 =?us-ascii?Q?3ZUNZnqGoZOD6qJAAv24tNYSVjrNajK6Ht+uY8ZcZp5f3Ki3rTF1oPFkq9V/?=
 =?us-ascii?Q?zjA3TXLhq1F5KL2X9Qoj/adEiZbBBxoE4en3gkPA/x2vXYZznhO0EuOs6/x3?=
 =?us-ascii?Q?zGKoJB/Ck+e5a1maxtiIYapc8CA5dpTgOovWIMD+25vk4CUcIl5/OqWjk78k?=
 =?us-ascii?Q?+jZNP8bjL51nyUj7BC74I660DE+Gndum8pLfurZ2N4GdJpv8uLg3Ln8p5/nX?=
 =?us-ascii?Q?6FoT7TFMIlaXr+u6c4LgM4aFjDMzRJlF7zqCvY+OuizlKMD+nBVXXGXEBXDn?=
 =?us-ascii?Q?onPe1xgGo/kStCHAbkhkdRKgACMR6W9qTbghU0wSbucywXeIfkZBQHgvrkyI?=
 =?us-ascii?Q?WlsZycHE/+/CiJqQYHVQ4EJnxgrimxhrD+fVeWmASSNrByd4lCqH8BdgXaCr?=
 =?us-ascii?Q?BfNlSIVJ6OpKgemN4N1N8pXmbKoMfToZ7hy0reiDUypE5DypzFYehOadldYR?=
 =?us-ascii?Q?0G6+tfjn1dix7iodx4z5pIfGfbcgayBKMrJEE/jTkjOzshJyWkGrHPVp4ryB?=
 =?us-ascii?Q?vXF1o0TUUznyf9qCIpM1H/RTcEZyVkQmHISGzM7H76rWSMny/m7dDp9ysnmx?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5118d839-a440-4a78-bdfc-08dab8f2be08
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:43:14.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkGeEQmOWJH8oZvi4fWbe80qGOq1XKvdpT4J1MGJ5Z+scy0Hhijc5uCdJRFKFWerZSkArvDK1w/hQp2G7M6t0AHjwaL1AO2ZUI/bBAaKYo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280092
X-Proofpoint-GUID: Z51I-f8LoefG6kklFidNPh_qsoUyPEkM
X-Proofpoint-ORIG-GUID: Z51I-f8LoefG6kklFidNPh_qsoUyPEkM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:41:54PM +0530, Deepak R Varma wrote:
> On Fri, Oct 28, 2022 at 05:03:25PM +0300, Pavel Skripkin wrote:
> > Hi Deepak R,
> >
> > Deepak R Varma <drv@mailo.com> says:
> > > Flexible-array member should be used instead of one or zero member to
> > > meet the need for having a dynamically sized trailing elements in a
> > > structure. Refer to links [1] and [2] for detailed guidance on this
> > > suggestion.
> > >
> > > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> > >
> > > Issue identified using coccicheck.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >   drivers/staging/r8188eu/include/odm.h         | 2 +-
> > >   drivers/staging/r8188eu/include/wlan_bssdef.h | 6 +++---
> > >   2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> > > index 89b01dd614ba..e2a9de5b9323 100644
> > > --- a/drivers/staging/r8188eu/include/odm.h
> > > +++ b/drivers/staging/r8188eu/include/odm.h
> > > @@ -166,7 +166,7 @@ struct odm_ra_info {
> > >
> > >   struct ijk_matrix_regs_set {
> > >   	bool	bIQKDone;
> > > -	s32	Value[1][IQK_Matrix_REG_NUM];
> > > +	s32	Value[][IQK_Matrix_REG_NUM];
> > >   };
> > >
> >
> > you are changing the actual size of the struct. Wondering if you have tested
> > this patch somehow
> 
> Hello Pavel,
> Thank you for reviewing the patch. I build the module post making the changes an
> ensured that the build is successful. However, I am not sure how to check the
> changes I am proposing. Could you please direct me to some information on how to
> test patches? Is there some documentation generic/driver-specific that I can
> refer to?

You just have to look at every place where it is used and especially
look at where it is allocated.  It is only used in one place:

	struct ijk_matrix_regs_set IQKMatrixRegSetting;

But that is in the middle of a struct and generally it doesn't make
sense to have a flex array in the middle of a struct.  So investigating
further, we see that it really is a one element array:

Do a grep:

	pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);

The first element is always zero.  So this patch introduces memory
corruption.

The code is messy and should be cleaned up, of course.

regards,
dan carpenter

