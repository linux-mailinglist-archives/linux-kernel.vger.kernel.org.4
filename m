Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5566502F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjAKABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjAKABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:01:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189BF55664
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:01:18 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AN5Y0s010235;
        Wed, 11 Jan 2023 00:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=022QPMl+731cLe7Ef+UIegoQgaaIAzjgDZ55jddhEYQ=;
 b=2HIf4i4LaSj7MEAdriY9xvYp6QqALzHaoX3MO8qNl/pVISnulVaxP5LlWUR94vbDgWcM
 GG+UD8vBJCjZQVfmSPPO/mFZsFrBZYlF+iw9mLh+eWoxNYQ9VnSXhLjua2pzMeA64RiI
 kuMuJV93+at3rN4EcLUAIAT7awq6Aa6r1AGyjY88+BWpa1M0EiVJteIdD1rJy65RWFru
 c+cV+4d2G5qA6nEDFK5swFyerYOZXZmm1vZ+bP3e+5cKxaxU38yocYAnVaZuaj/Lo/rq
 Pw6L3y4WBVqjanxQljmLjJ/gojKeTHxVpm5aK55Yv/X/jw+lopRqlpzCh9Oe6SbjB8FX VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t9es7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 00:00:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AM3t8a031785;
        Wed, 11 Jan 2023 00:00:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1gfyujwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 00:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4iOepe95cF2xv7n167xvnT6l6j7hAnPSx07VhHWjQvsERlAMfAwoD0/x+Fp1NiUiYMg2efNpv4I2HGfk/fGH0nGrKzgQxuUx21taLr2DqpzWi/71QOXgbtHh2bANirgCcNKii+QOBbwLfSeaDaHK7tDLilTeWq/+eT8P60drzoMaVL+afQpBzfNN3sJl+U8UhhGQACNioBBvkjYRg+P8sAjBYuK3+fUjrWNiPwjWxAq88//u3P0bgXtQEhub6dKKz9TaJGkXHCsMlUPRX3VCu/eeN7XEDoR99A4+Npi5yf/00cOSdDL+PVrxaf4Lyyf6fRfDi9LBFLmK7ux/lcTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=022QPMl+731cLe7Ef+UIegoQgaaIAzjgDZ55jddhEYQ=;
 b=N7zT5odv3svMopOBWCVfhm1TXviN0U4sMRc6WELPuzny3/Z1yfm/NcamTz7i0fu1DYg7QA5E1m2gDvB5UGikxYGA2uxMR5a8UIHdLo6C7PkiPO/Sj+gvea9W+zWjuvjasqBhE7W0h2GGX+i+wjZbDrgHSG/63mCW+rEs2FFtG+91h2TwPG8/rUx6orJ+nqBr90NF0xjx4N6Tvlm1m8zujfOPf8rwL6/2rlscBvJ2eFYRw/69VQuaEqwqx9fvFf0fZgzaVtck/rBOyX8SZ4aamIMGqPPGcdR5n2PQV7X4vzkNT+9U53qhvtZTacTA0UP+vwnvAeIC/yUT0o9et3dyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=022QPMl+731cLe7Ef+UIegoQgaaIAzjgDZ55jddhEYQ=;
 b=Hskd4RZ8NAQFq6bpiNQdZrFrOKycUT+9J7MyISV8p3pIU7UoAHVppgFF6OBkehihPaOAeRGe4BMJgX9KKEa3JnfZud967CHXl62FIQbCBfAzSTi7thHhMNCzIxgYYsGrmk7NgniHFnaYht/uttv6XWiT7TRpauu+P04ANxvnKwo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6815.namprd10.prod.outlook.com (2603:10b6:8:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 00:00:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 00:00:20 +0000
Date:   Tue, 10 Jan 2023 16:00:17 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable v2 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <Y738EQkRcgv1eO66@monkey>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
 <20230110212821.984047-9-sidhartha.kumar@oracle.com>
 <Y73bP5CFT/8T/DvO@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73bP5CFT/8T/DvO@casper.infradead.org>
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 3539b4b9-b10d-4dba-6201-08daf366d401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lL/y8fqmcwSR59Tum+Naz+vJyrUSluGsZDWl1iwR+QJwptVljAh45uXmRUt9yhH/aESs814glrH5sX0MSprh1UqvGHSK7nyAJRCOmKeSV7c+/kBf4nnG6sN7q0mxfYRUwOx7QRfYs54yU8DeEXWoUgfRgVKpmfcQ+AFKiikj14foCSRCuMYf0fVBIrwQILANfbGKvA8vLjGa5ZZPH9QgD6gHjlKbTpx07padHQ/4v99G958T9yW2h8IifSuXQifPMCCAGr+3V8ckOSyDgmqVohRYzSp4YdfquCgtW40QhnED0aEuTolEDy7pHkc6LWk/HmDuOVd0xVLI0Oxg2FgjTevfsl4FjvQtz8wLb07NshcQy2oOmSHO+ba0i9CxGeGEmkzquActEuJphgKKhLH9xpqzyotJ5ViTiAGGWE8YkHvlim/RiS76XS5usIx4FE/BfX+t2HHNXeC4Jzk5+v3yrMy3mOvv/O1jhbSa+gz7PD7nVdY2eIHIeyDbIqEjq+Ysvyz2U396r69jxR3nWk5B2q4Qs8ecjiFPCIsR8RhWg7xgfLSsvtPxyG6JCoFPoQy9tQM5yyld9oCkNJ4JLDVaJh1/Z8St3iA5lpbcetgCVG8fe2Z+4bBnnPQcdVARXJj9fDYss9jKv5poGL8T9kEi3CHiIg3BIon5vk5eim5G7EWIJjiVBTOXaMJg9pOtTFif
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(44832011)(86362001)(8936002)(5660300002)(83380400001)(6506007)(6486002)(53546011)(33716001)(478600001)(186003)(26005)(9686003)(6666004)(6512007)(38100700002)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(316002)(110136005)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUFuSt4fD6MKu/X1gLlyZuIyMV2GRttgL+ifCf2BbY6EpjBVz21K8yqTDHJ6?=
 =?us-ascii?Q?19xFqV12bwunQC4akiuKDkbCAWp6FvCHeCorCBCG41AKlgZXByWvBMHLIJTW?=
 =?us-ascii?Q?m8U+uQs1VvTKmPxqGA3aRcAh8cnAAPS518ZuNSpBx3c8gEdegXNcEJBhwlQN?=
 =?us-ascii?Q?6fx1VZhopxs4zgPIZQVxXwrju1DxUaSDV4azV8LtwjgtrgXIc+zVRsMsSX14?=
 =?us-ascii?Q?OxpAUgOGFPhIN5zQN2ayinidEikYrt9NY2gH5bp4+nWGl8cdurMj2hfcojSO?=
 =?us-ascii?Q?LFRhj8kU3Vl5TCIHyKkz45NWxuWzDt86gMnkRaWkXDQfDnf8qD6WkAXfD71L?=
 =?us-ascii?Q?AGpbm++qNgb4aAgOG4iDkXtDH3J6tNo6nlO8zbFQuoNClrwu4A/c5gkjWS1f?=
 =?us-ascii?Q?szAGgr0eL3kpYh3SUVnJBjGvfu2eAt+9F56jUa38QXOaJ8byhnRwLEyDQ590?=
 =?us-ascii?Q?7gEC+adAH4iNkqwmB7PiGb2RiAGjl53pK4zLKfHYqNvjKww7bOUQnEtGJ/zW?=
 =?us-ascii?Q?Qdurb8syYW9Y3GYmYIcHArWa0eBWtNw5E8Bu3TDpwkUmrCgibg958qLGuB9T?=
 =?us-ascii?Q?cIlj0zxb1rYXWWiAYEob79E+fZzAIaD61eGsmSvrjWcdonKdPQ6IShjh65DG?=
 =?us-ascii?Q?iUH911xqDuoG7Ijpio53FXRF09Cn5A+W+9uNqllYacFQ5Ed64ORyemUt5oq7?=
 =?us-ascii?Q?nZYXay0l8IpgBwSinXut4KF5behLo00OCRmQZFity8wXWnKU7GKP7Iu6SD3Q?=
 =?us-ascii?Q?9Q5Dx8EClu25whGp12e3YbtU3CkjfbO5KR2/TbUpID9I3TGY4LvgS9hRGt+8?=
 =?us-ascii?Q?oQgY31hxUOTG1m0B5oYSN0Ieic7/kF4GzjgADPht00++TfZVLJ2sHYodNPQP?=
 =?us-ascii?Q?EAr+2hDb17vPQlINmLpZZ4aq21If5ZcovIYT9BnaAOVcaWFD9pPp2QPtpGwz?=
 =?us-ascii?Q?0+KPCPF1PjYHhFyU7D0dSfpXNzt/ivNoDjx+eaLrjGtPpMv5FmWRMr84/mSK?=
 =?us-ascii?Q?B/EUs3+L5rF2snG8rEe6rntCNlFmq3zd40p1sFCuLy3JTSW0xNyag7zsZLzw?=
 =?us-ascii?Q?1of4wajLxW4zNvF9E1IC0nBD5nl/jXyhPBPerA9BwX39z6iHXTIb3k1PeGpV?=
 =?us-ascii?Q?mysPxfqHxbR8PK12In7NCOefBCEkkShzM5Ch//LJVo/tR3vJnYJx4qlm187D?=
 =?us-ascii?Q?cAzSUDG9cGuRWiWSwlxAkzGWgLOYkgQOOVpYWAsuoxxEEMIutyq1ry+kIZCP?=
 =?us-ascii?Q?w5+boGtGL2T8JO6qOf1JswjoSXof4ao0gyCfQRENvD5BlKEsuvUTxGviQtlE?=
 =?us-ascii?Q?opYeRN9qrQhn3l5dAa4sek8W67n9E1aWTu4tKQLnHqmDjwYBtf6mdnSg4uWu?=
 =?us-ascii?Q?TeD6OsKU+nEy8+mNuujr2PkSzbGnDoJOcEhlQmJw7rtjC6J00gB7y4Hs2Dfz?=
 =?us-ascii?Q?Atr+F3EcWFQ1uFZb2RjIT6kds6A/oDeU5h9foaS6nR/nb+lKSVU82s5fjoC7?=
 =?us-ascii?Q?ZqxJq0UlfIzdoobYuIAoPhWIqopKNt/0JMxTZ3yIP2byJtmTArS7UrsP5O4m?=
 =?us-ascii?Q?ueI9NGFYqEVGVs2uvREACe8ZgUCYoSsmEc8K6X7VjcwSPvUK+lMzoDF1SSjC?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JXZhrNQxjUlLOeT+ceCTNKHQ3DznDhK7eudlEyuuMZ7GsaRBUzAaEXJdwekC?=
 =?us-ascii?Q?ZTaWUbfhiG3DTHCKG5Fg45BuBZeQFPbKjhnMsPQ/BRltDldS0DtG5LTEzLgq?=
 =?us-ascii?Q?ju1BW0Z4sv8FwKWoc7v0aLdbA+Y2c+LUbY47CCl5YFvVSkuz/yL9/aY14eDU?=
 =?us-ascii?Q?1mOjJgm6/wRTgDqYVNNF5dhaqmQ4ZWm6y55gkwSekBWgSmQWG63/gsUFItRg?=
 =?us-ascii?Q?ybTe6Nx55xwFS5GN2UlASYT/RXrGoJHHqLVV53gaMNevGkoJUbu3OoOBDvjl?=
 =?us-ascii?Q?8c/k7eUMYOrfizE/whJg85869rzoH/Hvc2LoAMBERvOIZNEpY1GKZOaI6NFK?=
 =?us-ascii?Q?fCyuBQLbxLI/Nuwn+K8gjceurM03w0pB0dxquC3KcqMNYV3y9M26AqXEpLzY?=
 =?us-ascii?Q?vx4OdiDjwl0J9zb2Tc3JvuY8C/Yf6Ti+4/6wxJcDUYpUbnvvPg6xr7o7a2+N?=
 =?us-ascii?Q?ObSzH6N/t2TAEJT77Cr9nj49udHaLD3xFnUreIXXRzi7IFbQGSAYHr/o8Oax?=
 =?us-ascii?Q?FXKJBGLHaD8yRcbWMdd1dJd5/NM0MksuFzbTSyQAzk9cdISFoPC5oGHCgXPr?=
 =?us-ascii?Q?vfk0M4nkUkqZ4RdVmnlAYlQA+PYKWzk1QkOWMc/+lqChKh+301f/YrNfhmg8?=
 =?us-ascii?Q?VK+geZ72txSCCPaLXcU1OYNfEyHJzHJXPuL0eGnfhrskYrxLghUByIKj2qTo?=
 =?us-ascii?Q?GkcMPEL5J8nlw5O9IymdfmR+gcIl1uBp/KDUs+27tUA9HECg8fB2DSEgse8D?=
 =?us-ascii?Q?TZOFRgDMxlyakSJkymimrDdl5bDRszVy6wAqXsEDsY05SLdr11booBaPO6is?=
 =?us-ascii?Q?1H+VZvNy75W88Jq2UEZ0LEHnnoUVCUz2lgDNxC/w5VeBNj0gOyrvRYPZFkxi?=
 =?us-ascii?Q?RTETG2IIDSdPAHHgXgsMGOGTZul7HAMdHJRCmn9f6nwpVXcP92o8Pyq2QSG6?=
 =?us-ascii?Q?fFjV+n3WVhf5UTcaC8LkA47squmH6QiSK6akGlmBN2Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3539b4b9-b10d-4dba-6201-08daf366d401
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 00:00:20.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfGCRqul9OCu2EWNS5aC4i2NW3aGa03xTbpnta+NeEQHV4qcJIOuGd5IprCz0vVo2PhqNOaGAuVJwED+BPGfCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=870 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100162
X-Proofpoint-ORIG-GUID: 2YA_tpcipDMzynWnudYxa0OcN22EtBqf
X-Proofpoint-GUID: 2YA_tpcipDMzynWnudYxa0OcN22EtBqf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/23 21:40, Matthew Wilcox wrote:
> On Tue, Jan 10, 2023 at 03:28:21PM -0600, Sidhartha Kumar wrote:
> > @@ -3505,6 +3505,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
> >  {
> >  	int nr_nodes, node;
> >  	struct page *page;
> > +	struct folio *folio;
> >  
> >  	lockdep_assert_held(&hugetlb_lock);
> >  
> > @@ -3518,8 +3519,8 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
> >  		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
> >  			if (PageHWPoison(page))
> >  				continue;
> > -
> > -			return demote_free_huge_page(h, page);
> > +			folio = page_folio(page);
> > +			return demote_free_hugetlb_folio(h, folio);
> >  		}
> >  	}
> 
> Can't this be
> 		list_for_each_entry(folio, &h->hugepage_freelists[node], lru)
> 
> which avoids the call to page_folio() here.
> 
> I think the call to PageHWPoison is actually wrong here.  That would
> only check the hwpoison bit on the first page, whereas we want to know
> about the hwpoison bit on any page (don't we?)  So this should be
> folio_test_has_hwpoisoned()?
> 
> Or is that a THP-thing that is different for hugetlb pages?

I believe it is different for hugetlb pages.  See hugetlb_set_page_hwpoison()
where it sets PageHWPoison on head page as well as allocating a raw_hwp_page
to track the actual page with poison.  Note that we can not directly flag
hugetlb 'subpages' because we may not have the struct pages due to vmemmap
optimization.  Adding Naoya just to be sure.

Do agree that this could be list_for_each_entry(folio ...
-- 
Mike Kravetz
