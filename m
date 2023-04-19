Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205346E717D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjDSDQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:16:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6361AF;
        Tue, 18 Apr 2023 20:16:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ILt6DY006857;
        Wed, 19 Apr 2023 03:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=R8ShaecSlKX5G4wIiUPTyzGGHbfiOGmoKXkU+AVAyl4=;
 b=NxP7p97B/DxIxVgTNuwIB1TZ9vvP5mrTup3a65PQn/X2M+W2E2Qh9rWNoxj/A2cIroQO
 raCyzAQMQCuqpLi5hluzbVm0oMvK1vkJ8bsaqi8/feX1ooZHrzzIlxSpQByKzRKJooXg
 gCAfGztLbqq4r48cTaEo4xBeV2Gk73J8SKFVv+pEdX7SKzl0VNs/j4Mtp3UR22Qx9twC
 H0fT092pEi1Nw2fyXdWLPtzXPGBG3u/p2hJOzh3c6uI0WoFx4nRLYwUJp4Ik0zocPTUR
 29M3nn81s0NIh8Zz+dKB4K5uErOqakItULtCSOIJ5CXLxwBfvqKnVC9LsOUcVNNobtP5 uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q0768x85h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:16:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33J2jWCE011361;
        Wed, 19 Apr 2023 03:16:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc631n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 03:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH8zhS1AGRIumUcFiDoapw8UxS+E2CdjLNhrAEpi26OG2NPn31gBHl1af8gZ1fMfEgmGdRjRpXj3zhDVf9H/5Q3lpTkmJbCbE1/eRcLWxRQKHvSvqx/b/DMghAxmOzpzsf81qIbXYz83GjOdyhH80tBunJXHfTIVR4wj9D1vyBk415fEXVqUfjRgBqobEoeKllC9VDBdeB4LteY4JyrhbUdv+WKdpURaWSOVkjEJc4rBlanPBBRcjQsbmdvhcGKDPNi7s/wDXP8U4V9pZxgJ2B2YtFymhqt18JQc57IXtOIF5Qj5EM+XUBUtoawEh8iUYDJQgcxW8am8OY5jtPRNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8ShaecSlKX5G4wIiUPTyzGGHbfiOGmoKXkU+AVAyl4=;
 b=hbd9DO2dT7sSIuMKViljH73GjkzrTE5bIhxLKBFZhgZVy7wn0/1JtrJtsId+ZY85df2ajaM5jOEot6bXRBs1mvWa5zPq4iqJKQfEvzizqat1BVPrLI8deEj4Nm1BNLQJB/6CFGgmnJlKDu/3qTpdN/bIJLaW88KiwTDwP7mhXkkCick4Bs66OCBeynmxz8knU9IS8xLweqEHS43HPULvKj9UCaDG7N+TUwAFpjBr3yGLtodmmxEBWMdZbSHJtXKqZIccsl3rK4S9He+2OcG4Kq/ESODmIQOHTfoAO2xbzBhtogj5DtA+P4XBDe60DaP76yYrznzvAqtATFN8wux42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ShaecSlKX5G4wIiUPTyzGGHbfiOGmoKXkU+AVAyl4=;
 b=uUxkzsQaCWGXlwvd8E+GkMTT49siGwZ8/FudPqr1a4cZDRNjFiUxwSStrVpJXM14oBY1oD6xARCuvJivR3hi15/EHTd21csPZivcDVpMRoevHRRjvzf2MMN2bfJ7vVAh+qAKaPQU3S9JDZrDyMZprBFd6CLzoENLP70rfYyJxKw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 03:16:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 03:16:27 +0000
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akshat Jain <akshatzen@google.com>
Subject: Re: [PATCH] scsi: pm80xx: Log device registration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzy8pnns.fsf@ca-mkp.ca.oracle.com>
References: <20230411230650.1760757-1-pranavpp@google.com>
Date:   Tue, 18 Apr 2023 23:16:23 -0400
In-Reply-To: <20230411230650.1760757-1-pranavpp@google.com> (Pranav Prasad's
        message of "Tue, 11 Apr 2023 23:06:50 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f7ea6d-34e1-4d06-f050-08db4084765e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4La6BUiAT/fXRILS4MzkPEtHiUC7H0Fm43uxj/2VVePjQViEXJYE2fOXO8rUVaZaXFK+7v23sRXs+tBH2gYGQdLdctrf6K3zaOb1ve2+hDd5U6Zhp1yMmMEDzdpQU/x0fMrsB5gxihOQt71K+L8o6FkiYEuZ+NV6oCbBxxJX0AG7lduqnqkNYREpkKi8CnhfyICQ6OyzPr/z2YNvZAVSqZ0Dtd4BeSmBNac56LWtm3p/UMdTUaRiKZfU+SVOyMsYXsyaX+aSOt/JX3RTnWOzdfINsYBZqvlvDui+HVWApLWRW1A4uD0qz4y8ubkvCm5FxuOgqolWtr0B5m9wUyX2jfbRp12n8ZLq7midt+Au0UDBGypHiWLmeYrsCITtRoe9YORNI8olQ5jhWD457gP0XzK7YYMH/kcSD9Rl58fZ3ZmnaYTsRA4qBhezATYQiw2NuO1pTVDyCpOzTfbx3YruPVUoSvO1v5NRc21cXEXbVSSV8jZYklkmIxrLR4FQYLVhgrw98dqAzfEY0byXcn2M3xFAcT5wwdIMijGkvG0cRRaPw502PKm5dKOOjWbGC6J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(6486002)(6666004)(86362001)(478600001)(558084003)(26005)(6506007)(6512007)(186003)(36916002)(38100700002)(316002)(66556008)(4326008)(66946007)(66476007)(2906002)(6916009)(5660300002)(8936002)(8676002)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nli9ylxr/OpoDzsIN8vvK1TZf3l9jXvlkG4oiT4wAeUVhLOn0PMur5+hNydw?=
 =?us-ascii?Q?qsLGFm9QvN3jA5B0VolhobqweCbtDLkLObfif1CoTCtDn8qOcpBJbV96XoA4?=
 =?us-ascii?Q?R6tgG1/cNaLseBTm1Zt/KcAdAu11ocLhA6HZWtjtdt8GIhPIhVygFooq9gbD?=
 =?us-ascii?Q?sERLM5odSWB3gejVaYjXBsb+WZ4GAO432OPjBOjANEZylmzpqQ9/S7gBXJJ/?=
 =?us-ascii?Q?tOTguzDAeY8WPtqVNPjGZcoXJu9owvCMDDxFcyi7Pc+RrCRGp1/5UOdkG6lv?=
 =?us-ascii?Q?rssZZewzLE+A0UMdPhDo6KDVSwewgVBQ9bz06qEj/PDv+kESOi5nz0TUGoAN?=
 =?us-ascii?Q?149MvtGww5X5sx/pvDKc7h0O5rUn8zwgmaK8Y4nV2bncdUWgFSQ9HI8BcdLZ?=
 =?us-ascii?Q?WlUVs/UgHWoFkCQwe4Ju0jIsZBqvUK7q6VkgsuPFcPhjcPEzh8WOWfAkXyre?=
 =?us-ascii?Q?csHIDhyy+O3FjJRoXC1KL+EcvrqYWZthzyVe0axSBQEAboJOLp/jBLvvfGq0?=
 =?us-ascii?Q?bAgVJyUXZb49PO9B5/cMc1zJckZPWiOpoKG6c7zFUgPJEzuvTpGRHa71dyYi?=
 =?us-ascii?Q?79kTTvuzwt2rRU1ZiDN9QtUgwnGudoSTx5hKLx65dx69Qgngc9cSregMm7ef?=
 =?us-ascii?Q?1ow6SMZ7bZkhJvQwKBwGzUVEvkv2ELNQEzDwh21LxCuGij3f+rLXFUAVi5p3?=
 =?us-ascii?Q?kIiQ6znG2rb2tQb3NgGHDslWRgO7XPm2YqLdpmecPkCEyA1bCPGckxxWcorc?=
 =?us-ascii?Q?Kyg2V2x5mZd3MgbT1U036+tMXggzWY0CBUEXOidF/r8BS2uKP4h0Lf3a3ezM?=
 =?us-ascii?Q?JzT0B3rayIt77alliq/xlPlyTRXO3hpapF0AhT1P4DubZVNAXFluVuksJqHC?=
 =?us-ascii?Q?9iuCs8NQtSLZ7/FOYjgmEb3MtmyM3MtLyp7JGnXvYlxqhABzz5lxLCelfdtc?=
 =?us-ascii?Q?B8lDFv/9C7wwIxZhoD6uXx3ic6nSlT+pDEWtf3v6ZiyIlXibf4Xg4o/1iiqK?=
 =?us-ascii?Q?JwoPZ56tyCmdLM/N2o5xOnWUON6nJkGPWihwx23iw66G/IzgLi6jOo45qh1Y?=
 =?us-ascii?Q?baoHgjc9PmRbc/VZimDDHt9nEjmi5WJU9U6ZtaGGQ0dJyHHvBrFjatsapa7T?=
 =?us-ascii?Q?BwLB5mKxggWjOvi0Nh8NhbOt0QPaHlDOjM6bGLp15l5GS3juhkmLL0yWcMFx?=
 =?us-ascii?Q?E7pwtmqXyV/VYTXY0hT13ktG35VEETvFuc/9VGUBrIfccLaqMEzsySlGDadJ?=
 =?us-ascii?Q?Sag8yv8LH+udRomVwsxJEC36q8YxrmBbPremOJekFZh2ydcygtsHnZbLOwnz?=
 =?us-ascii?Q?korgG+h/lO7tNBpFwBiMwqTvaFDAiUro1lnXx6Il0iEFoi/upb4MRY1ejWn7?=
 =?us-ascii?Q?huvzAkS3itRoeWnn6hU3gNv9anLQxXuScCgCIysEDuJcKzNqbSMCHint113K?=
 =?us-ascii?Q?rmJFOWbjxrycOcPYnQADZrzgM2cOEHBJvNYHQiCWFgEy91XOx+Yxuor4oNWJ?=
 =?us-ascii?Q?AMsOzXt/fC8kZTzBdp2NENyvLJTRnhxG7caAE108mKvhHLIFpvHELgth2ro3?=
 =?us-ascii?Q?+v9ZOU8Zi3aHtlINk9LODG+QapUUtq9z1TzW3nHzLicJzXON7HxtpZP5Anqt?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: isrKddmds5ovaQzCl9d2pO8RlcAUKEnwIF7IFQg3eWuveJTP1eB1ICUCTk4m83CErJxZemGBLxoJvSfqCWfh62fAob3Kfpqs2no5jwTMSPzlA919CjCE/r1HU0CWhx5sioIN5v1rsK/Kh8mSMypxKBJZsJhHInNf13GKeORisnJHiHaLvtknONQz0XbOjHKtADZhviXj4PS+VHMmbawuiTOCXf9isJOWq8FNX692u6s3Q+mcru1I4I2sF1HYIu/t/zUYkiW4MrcLcukBGWRk8n1gY5Vy1yp3agLRGOnOQydQrrBpeaRL5tt6/7lF0EF/SRNSeJYqzFfV8cUPJPsnIVeGiAe4ArlOOGZ37zpHfKg1Wmvooe6Wwqs+qjdjYctOx8Hb6D1ZDOXWicFQNTbV9YmYHuqWl+GkLWWbCXJCPCoiqiP3ofqC9i4/DEzur2lsmZ5NaKwH7Z4oSVLGEMCbg0QKHSHFvESJelZ6KPkxbcrAXyxxT/U5Tm+Ry+Uq7TZAow24lEfVZluvwOAhglVoTBkqK054IpimBbGmMCPn/PLvdy72blEdya688XBpUefRCumIJ0/fXLH1F0GRruePblZmQyORYy/cFXtydlwpLYdWKBVmoCSMm709jZvXcswz2Wl1s6fYJc4KPC6bkrEmexEtS/bJ2vg+l7kjq7Gs6oV22uMQvFkYxJoMFzRHm0hXYY3dD2lYMpGzwOJ1MbeLf1PzW+Pe+a+vU5Ptq8ZgY+P2x4AHEcLLEhzOVon9+t6TDVHR5yDXQWLeCDRGjGKMW5ih2icg63uID2IooWUHVxBvzQ+QFD4BK3pyiaew/Ax1Jq6bE6an9+tQRDeH6znrUwbt4qkan/7VtOQRTofy15vU9k7d6DtG6/+m7hxaq14y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f7ea6d-34e1-4d06-f050-08db4084765e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 03:16:27.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7E6SjFzjVzuyEoYxUWAMPCKqMoX81uCucYwVa1oX0Vuy1eXs/QbwPMxRHzBN+xwcWvfFNy6EtikuF+ikJz/6CDoBVqek7xZvbpCkJDN1swk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=857 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190028
X-Proofpoint-ORIG-GUID: KQ9X1hkeeZjxxMDnbfB1ZhzulIUONOop
X-Proofpoint-GUID: KQ9X1hkeeZjxxMDnbfB1ZhzulIUONOop
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pranav,

> Log combination of phy_id and device_id in device registration
> response.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
