Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2A5E94EA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiIYRbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiIYRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:31:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD2FAC8;
        Sun, 25 Sep 2022 10:30:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9RRbQ012930;
        Sun, 25 Sep 2022 17:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0hXt6TYf3I6dUDg6ng5/DjVbtxAAqtW3Nk0f4XIE4ZQ=;
 b=vB8fwz1QNSI9DbAGqVP3cSU0uDtAXWtGCfQ5sNcCcYfckSdL+2ShziYuBCLHqnGSnAOy
 B1EWehTifboUfCTom5DEttp2QabPbGZ6CBnblbcOu3Fz33VefAoBrfSaNG+V1FrvVzAi
 nc9OdsfWjB3n3SosJWeBglSJ2LX9VljVW5yJ2E2pr7nW5sbVD9yRtF7Xm1xTyLpx8JYj
 MFRYbfsA6OdI1q7m0KwaZx+jGHTjZ1b8hjX8R7p6CSY2lx1MUlmdSCVDfkL6DjFGvO+M
 g+N5qdR89JLBt97RIDq5AUFgdyNwKhROz9AYX8glq7wgTrCVnIugj1RrGsNvRblQkh2X Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstphyga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:30:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCFvO5019704;
        Sun, 25 Sep 2022 17:30:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpu83pss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmPB8AgC/6qIv4fCPSM9JbbaHwVGvwEGbStwDjQfOtEUMTEKXcfMdnFZrzrQ48vY6YMlZ6/hsdVrBADXOnrxmSWuBP2d0NlrPcNVb2FFsfzTZhwQ41zfSa0s6OlUqY+476IM4ImggD71wRs9HOkLKFSfdMLQ8Cdfr5PUkT/VPxkJculX1L9Wu/U7CEyPYfLca/JQZbr80UTC77RCzYlFlpZDssNNoToUDERCsQRKpiH6NSR6A2cuADt6E7mu3M/L05cz8U4AOGkdElSj+IW0wFmsYnX+x5mflnZuN00QGI1hsGCSvje87ZujK5GuQMLwj4FgWss1o1NgOEfxz6ba4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hXt6TYf3I6dUDg6ng5/DjVbtxAAqtW3Nk0f4XIE4ZQ=;
 b=XcciLjwuPjW2eFlO8CGaUh+NCNWcroOgeIkZ81AvIfI66NYcDZmZtcys+s78WXfT7sZrPvZ7WAU5wTCdamU2LewbHz6/04OcJZbFsGpRDDEmYSiPYhdlXc2zoNOgefPrtup0YEn1ikLu1z3u/hyRPtZTHGR+fUKojUS3p6yuyiY6LvKAHc/b+yVse1QNaOTsDpzeqVQqSlgqV7Z35eE+GkgkPoH0xpjrb9dPjNvLWhqtM7P18WjA24CMvXNbsLdM1z+XC8uo5xvJCyDEyErne53j978cbhZpeb6Ike55gjRRX/PrnZmHNXPdkDD2Gfvu0ZjQhGQTA44SOpTRpCCT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hXt6TYf3I6dUDg6ng5/DjVbtxAAqtW3Nk0f4XIE4ZQ=;
 b=Cws1HXIkMVpPE76lfVfZklK6pVjjSNt3+b3Pw++f+z2ClH53LnjUR2J52ydpYTrSWy8CyH6XBKsODT5Zjuy4HPKSIc5SulfwJfZWE0rEsg4RnK7iFju4m/Cre2Y+qmRm/HViCIEHEoDlaV6IlNH7baggyjbnJZ3ppYipeFfteOc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Sun, 25 Sep
 2022 17:30:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 17:30:54 +0000
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: wd33c93: remove dead code related to the
 long-gone config WD33C93_PIO
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8pbpdj7.fsf@ca-mkp.ca.oracle.com>
References: <20220920112921.25275-1-lukas.bulwahn@gmail.com>
Date:   Sun, 25 Sep 2022 13:30:52 -0400
In-Reply-To: <20220920112921.25275-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Tue, 20 Sep 2022 13:29:21 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:806:f2::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 52341f03-7bed-4a5e-3bfe-08da9f1bb310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avtcCSXMNLaN9X5jPgAqQqeTDO1YDrSHZqFQd0IKh8nybxBxL9J3k2nzSyF5MhDnWwejYLchx+ZVYAnLJtddGF/tWtxoFrNEhWa6YF12gW6e+CEqSwvf8ELLriC9wnvl33tBeKn9a0RobH94gW5b0GbvCVG6YQslUhqjS5QTg8dzhSKfSLbcdfS7Wv63bbKELN4l+mpLYqjB7Z5MaaffC0LLO7RKklBQKl3dSFg3PS8N/7mHETukSq7suBsrO1JrWe369u4U98xNjPPDVhwDvVd+x3YYaO643gCrfeqr99/yD6nKYxB9oBkKysdjhFCkXi2haaSzSlj1uPs8G9vooGUw/QqMDKehfqv1Cn9VdYduzZsj2Nap65GOSUlk+tF05XYE1iOAQtpYsHhGA0E+u4+Cj5/FVHDT9ZJzsiBocmdHux6A+Tpk8RAsPFIyW3IYR7R70wFKlwdqAtsxp3yukNfoe9lSVQftKgd1zsu8e31y1lCuDhSDeljLpn5TL/bPEIYoW/X1+de8aVNvWmC1MAuvs3csOB922I+r5GhJAtisgqjblRaLkQfnCBnF0I4e3cZ9kvGLsBGDCXDHA4aX1IxwqC7m04gyAtaMnu10K6dsnntD+cSz5XCRdDof+J4+za0dy7DAHaLXkehZFUp0f6x1Y9qkYcxc+FsB3HqJkVpYuS8zzWBUaipkZXfW+shX2n4o9ny6FmpSfou5+nrGCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(38100700002)(86362001)(5660300002)(41300700001)(36916002)(4326008)(558084003)(8936002)(8676002)(6916009)(54906003)(316002)(66946007)(6486002)(66476007)(66556008)(478600001)(26005)(6506007)(6512007)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CV37ggsbGlw4BkiE9QW8xDiUvQ7yUo3JlprCLOIqC9SCLCUFVOFIKie/pNPG?=
 =?us-ascii?Q?bGRMYCA2CaHX7ddxFv+QLuF+/V536H7HXiGDbGTCwoBDjEgsqnnWeev+G33z?=
 =?us-ascii?Q?Wx6c8/gnmSLLyL73JaFrLxI3iC53g62UP9dHCE7mdDft5zSPCvDnhSe9Y8J3?=
 =?us-ascii?Q?lkIAAhA2tEM9t18u/mYMNFUjpve8P2azvwNxJEI6MfYBY2PglwDBVOe/uh66?=
 =?us-ascii?Q?QTyznq0cpPliYbk0VNhdzb46odfadqv5yjxKc+19Cw3NWqb4dmxmw9pAqK33?=
 =?us-ascii?Q?5Kd0DXbWavxW8Az3hqI3Tx+TvnSaBEj+6XHtgqkT31ewDw7RFKHW51Xli+kg?=
 =?us-ascii?Q?8P7BTHQAvuvxzQnwUJr0JFnwBjCzaXgxygUdj/DCMAMovV2n1PEdQXpIKZnA?=
 =?us-ascii?Q?s1ff7JM7WNazzUS9ZOCAVc0GATHzyqQCBv0FppvtrWxE76THbLNCvWDeouO7?=
 =?us-ascii?Q?NPm3pQlg21faiwEyG/fiUvKKADi35FWxPnK/bde6VXutvrfVGbEZKc/hxdZw?=
 =?us-ascii?Q?qnqNvKtpk3A/+Uly92PkpHr3n2xZ1+6P1WrBTk0Mpn/68cRDt+U/PUXHYEe3?=
 =?us-ascii?Q?Zj07Cbr/qnYC/Dqts5HIVnv4N56lEjzR1HO0kR5me9IP1rISpcmwJWQ8T2mx?=
 =?us-ascii?Q?MJA+S6rgC1Gt4gk6mF5rYt8pA2mi/o9PvFQ/lqYDfOfnTiqyI32el13vDcry?=
 =?us-ascii?Q?yKnns7FuOx6qC/OxPdPCoPQEoZ2Z/HCI5uUHK6HJZjGIt44tUS197Ri3OTlY?=
 =?us-ascii?Q?Tgcb7JiM1TYhzucgSnriECuB1HwWA7JLreZjYUbkUh+vStGXwbyzyib3iE7V?=
 =?us-ascii?Q?93TZQO2PiQN+7NYCR3IlVh9xSCK7OfBuhpvkVMmMv1dxyCJmiLXnoGQcNhf6?=
 =?us-ascii?Q?30waL2JqHTEVh6dhRLjzsM5plAuB2PEuVPjA8nomkH21kL3f4HxbLM6Y5FU4?=
 =?us-ascii?Q?g1OVvnjvNhR6/K0706if5o1yVcFizan/JxXeHCoOItFW7a08woG9fQbErqyg?=
 =?us-ascii?Q?70qpf9sszprfpduTQ0Bkh12QjGjHfev0QO2HbxMEPMuQL7uxjM+Wq7eTxPkn?=
 =?us-ascii?Q?IeNlkGpLJEGs0euhmcT7aK2b24Aujn7wKX8SJoxEH8LEwQUlgItoLzXnRn85?=
 =?us-ascii?Q?iNwdJgeCIHDfiIrjjwfoQM/m3CG9+J5pAUxutYEqPCc4jzoeSPTbesY6Bfr/?=
 =?us-ascii?Q?Bkz1WUkXRAFGOdsuVyi32s8s6Yr3rfUj9wkbgCQotvcmRyVNHmcloRa107Pf?=
 =?us-ascii?Q?NkSFUpe1hC0E5D7gBSiwKzIC41ZYQfJ2rZ2Tk5Co64kXfSo3P+EUoQ6N2U35?=
 =?us-ascii?Q?nYU+U7ySrJt+1Phk0Q+7heDNe3C3kDmDYQCG0WNu6UKPtgMlYRuNeTebR2G0?=
 =?us-ascii?Q?HEBjpqcQZZPn1IDPdwuHSMheu3JLrrDiup8VCt1+br2rzZLqZ9A22YW4H9Ny?=
 =?us-ascii?Q?fPHTBmjXLRtdVe/I1mpMowaHHL/NrrJdTW6yyZMIQhVu7UvGIpV1vdUitR4m?=
 =?us-ascii?Q?Bcyk6d3oVANy1HdHD6UuB0CZ+homqMV/iTUsTCehP0qc8ReFQ57w0qkMw+rO?=
 =?us-ascii?Q?FoyB9FWzKB0kDV9Ii2vZsu7HHd4lvzLm8mtbgRX4C1NQu/JXgrx4hSNvoTlZ?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52341f03-7bed-4a5e-3bfe-08da9f1bb310
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 17:30:54.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AePSeZ5ZD43NoSvVTLN/vx6OOEyKLd1/wwbobdoXGsNHNtfsgOQkk+m3TZji8+V7R1V63wRbeNvr+Ox+ox2M43eJ5RoLeam/jVERDgii/kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250127
X-Proofpoint-ORIG-GUID: B8dH6A8h1i2ImwdM_gxXoGpqTWLK5DeQ
X-Proofpoint-GUID: B8dH6A8h1i2ImwdM_gxXoGpqTWLK5DeQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lukas,

> The historical commit 5e018f7e60c9 ("Remove PC9800 support") from 2004
> in linux's history.git removed the config WD33C93_PIO to tweak the
> scsi wd33c93 driver for the PC9800.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
