Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA71678DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjAXByi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAXByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:54:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0B39BA4;
        Mon, 23 Jan 2023 17:54:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O04nU9028979;
        Tue, 24 Jan 2023 01:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=dfizsfM8jJJKR9949j/l1gTJGtzuhanNSFzhEF7EEsg=;
 b=Z33RI++HApJxa5pG6vbbRIEyZnroeBYBVa0Kzyr97A2A/NDW5aacDdA22Cp1jt/ppFLp
 a8Q/9pg2nPJ8OAJW3DE4tVb07o1L7mcyD35itc+aEe+1hjg8AdXe1XtOFENdiLuzm2N6
 KQ50r8M3wxVkUHH9bWSiuGpFE7FVgQUOd5jT7YWR0lUefv7daTy0BTafamdBbw6qur1g
 dF4boBXvemN9Knc8Z+crCA1S3re+q9wlphaSKyKgpk33ZPiWmCsFb/0fQBW8Xb6NXZF1
 ce7+hvGvR2PplYusaLkSaRGjsxlf8ygcBCt0XOtF9MnVai+2QOUXsJY5XIoSQfwjg/EE /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0vd00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 01:54:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30O1q2Ae023294;
        Tue, 24 Jan 2023 01:54:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4mgrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 01:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKv+2EfgSMpMJgreX3BBZuSx+tHdCHlS8ZnKC4doeOGhdh86YJ3WmsY4Hf6FfyJnY/Yx04DwMPreSq1IV/WlOr9tMm/Y4y3jlBOMdp9IVrTFLaivz3gpFToik13rv6tFVDjy4dBPaX3nYJtnezpdlkSShHyUVJazf7wrPiP058uTiFZ08Dz3TxazVLiORWvSqRusA1dTCii3DvYUkt0CIjd6SnwJrkaaJOgzdqqBv9oivKAaiFrgGxCWH+v7YtH1Thmq3brwSAO7W3zOX1T0GDUSkRWJScXR+jW3xsYtpjgIhlae4hTmG62AOeOsMHRFb9PTVPr1Bazz79A/8ocgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfizsfM8jJJKR9949j/l1gTJGtzuhanNSFzhEF7EEsg=;
 b=mIphtOtuVlalweJ92/8G4a6vrDsfdTrp8ZO8kTvmAft/W22Z2e6WNkHZzKxRmUQlIMTW+FaTgXnHBA2x6NZsM7mMbwa8YZZE6x4PPsPBNVHDyKUYy2ev7L+SqnWqJ12qCsGFrUEzQf3g5koCDgQx4UupKC6fq7SHO3qNL8BUfkGhVSY5CddB/s/wA2vfgJOU7ywhkESYVFfC5zg/AeJhrQC1YJDy89AlX0KOdBb4k9zMRdmy/tnu1NOhQUQN5F60ukzLAmpsMXq14jSv7vFP2twSB4ppiWRxAj5n23Y02L6HAtyunGfVuI8li9Rv2KKqqvnrcGdsWIhlAzLFN4SDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfizsfM8jJJKR9949j/l1gTJGtzuhanNSFzhEF7EEsg=;
 b=VISnjLuxxGGYi+GFMDgNOGlyaCqZH1jgqlDxrGeWKCNnoKgDB+dtVaO4o2DnHNHBPSJKO8+yxkdBTvHeNGdImDRdOQly2PMo7pPPUmDvVy5RSJ/NrI2jOD3feVUUVH4Zo9j39nKNKpIG9dw/QgOO6uj2M8+haK4Goy1bnVfoanY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4280.namprd10.prod.outlook.com (2603:10b6:610:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Tue, 24 Jan
 2023 01:54:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6043.016; Tue, 24 Jan 2023
 01:54:16 +0000
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        target-devel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: elx: libefc_sli: use "/*" for non-kernel-doc comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkmon1e0.fsf@ca-mkp.ca.oracle.com>
References: <20230117070151.29339-1-rdunlap@infradead.org>
Date:   Mon, 23 Jan 2023 20:54:10 -0500
In-Reply-To: <20230117070151.29339-1-rdunlap@infradead.org> (Randy Dunlap's
        message of "Mon, 16 Jan 2023 23:01:51 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:5:120::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 969df111-1ea8-4345-0adb-08dafdade622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN5h+3rukyRNokClyNAv49i4frOJPLZEQjytNnapPtsJKyTXTgtKaUQcEfoO7OLcdYmxJEi71tuFAiM+aGzB9/0zqF/2RVPYUIHORY/93cwPvmN5iuPIT6uLPU9NntRfJfKfZhRInrcXwk75y2YisrGR42fsGpPoI+G/vot9C9mdsafO5jfSAKS6qbAECFkdxM1KUq3HnJrgyDGx9OlkTKrl3qZ7lq3C2KDAe5ms4GQPqHqpAs4cycJZ6I3S+vN+m/ikUZO2V9gjYnL3Ny48RsIy8ObajRVG+IYXCkIERM/qzG0A0VeeJ2okzRqH2n0eHn6fmA0m9r/BpshEjuAZZhVTOea6liuyHj/I2vap/ADck3ItG+hEG+4v5lWPBnTXUhwxsDbNrrqn2dGZqsJcUXs88GYZJAgWeoJTgcYME2aVkZfWCdg7Jht9EEyhUinqgnDTfiNgRJogYWX/vxkq3MhU2ICOx4ZjcEmCF0K8WpghBIqfA3I6T8HKuO+ZH+SIWOspT2Av++fK2eauPB7W9kbNObfjHe2FM5F077IshXuKF+8MMPwIdl+qTLVQiU3duXxRL4WGkWv5JiyjnEmtdvZUTheQ5uiH57XQ/CnvAjQoHdievqwszXIUPc4SlyoFpZv8FRzLAP736ys6P2mMwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(83380400001)(38100700002)(36916002)(41300700001)(86362001)(4744005)(2906002)(8936002)(5660300002)(4326008)(26005)(6512007)(6916009)(6506007)(8676002)(186003)(6666004)(107886003)(66556008)(66476007)(316002)(54906003)(66946007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvFGK2jXojEmQ9R4EK5TgEqNULPeV2QFKqa19fmsC7NdisPuiSaCTxEPaksk?=
 =?us-ascii?Q?+a2APtGIYMLaYWwyWTbG88QPd8V5fxOxGpOvzMo0MYjkHpmTG+jFMLeYu4cf?=
 =?us-ascii?Q?3OHTewDTyVyitbZkNOHrI9LPXNZxUcOrmvQbQJ6kUmjxT3gh2jgWx4TY08WL?=
 =?us-ascii?Q?sV7d/aIDyJG9WbisqHa97pIM19U8AriCmOU7uL5QWi4/NadHiRp6XnSIYLRd?=
 =?us-ascii?Q?Ff19owJLm++aXvRSZodKLhDGStefotFqmGIuvBbO8QOGZzJTdH2lIl8fu2N6?=
 =?us-ascii?Q?a3+yk/XBvQECkqNrNmS5IquRV6Iut63pPXAuRrTY6tD/FWZCup/+WCJKkA8X?=
 =?us-ascii?Q?sJQJv8OlHSG5hzEpDOenincww2x40sopGaNcPdYEEdMrUfeAP4z80QEkf71l?=
 =?us-ascii?Q?VZYZR3uvZ9KnQoQQ8kpZDSd22fGZGJKGOf09w3MAWLfs7VPLkeUQJAVCIULV?=
 =?us-ascii?Q?zcS3oiE7XwCQ6eceWHGAJWzKphaqLZopYHQXCan9ElFv4jK8V6u4N8+I/XlW?=
 =?us-ascii?Q?T1bIw48e/WCLeJvNNK44KcfwHvsbHvITYgz6klH5+/9q2iIxr+e3uPRlXYDb?=
 =?us-ascii?Q?hfbb0q2Zp7SPUfY3VcId2uzPIZa/nnSqFCF4nwVdCoSoN5TwAONrSuoroiVO?=
 =?us-ascii?Q?NehqFh3nzWOojuJu5AnTy+r23BS9eV2eDY32SN4YZyVzxaaxoOrZxuWtRov1?=
 =?us-ascii?Q?Z0/cFhkxYyp+ScpBHgwrJy8slrq83S39mBUnvOBtxPQAQNp0SaLE3SwNRnoP?=
 =?us-ascii?Q?4oIFzFjDUd3PSUyJ0//ikDZQbhLBsOzER8gA7R5/W777t2bFPtKsnsN76MVD?=
 =?us-ascii?Q?N0jrbQSANWDIZW8XUa9RktU+zLlF8ZxDPRACZB8Y/bm7v5LGReARjhiVBEyO?=
 =?us-ascii?Q?x9eOtI75TVvEAWYbg61s3Jz6Qmsos+vC81Z+Lhq81B3jvtEzw7Jl0UrHH2GA?=
 =?us-ascii?Q?9wuKR1Yg6EdIwYtIqftFff+6ymUA4KbxEVsHz/7QxBsl7URgdgoGbY1ca6VQ?=
 =?us-ascii?Q?hnoxPOvl2I96vMjYgNkH+fUWrqOIsCjY/QzQk303krjgXOJs2/4dOZ7zEbVd?=
 =?us-ascii?Q?eJf5Bk/gvxD3OLRX++sYO+VMOpH4aZb7rI01mLbRrQngBRj6StCQ5AX0ZcbS?=
 =?us-ascii?Q?rqEs/7BqEWApLsmfe3XvKEDZEzRl1VEmGoC8aNTdDtt8HE512kLauOjQsscD?=
 =?us-ascii?Q?URfFU2YYG/9P4y6wCeaHqBnTpvHq7cwa1/ZZgC31LHJKt2jrjAgyScWljdFq?=
 =?us-ascii?Q?1ZCxJViowsW/R1KmMS6rZskea77BCMklw4x9q3MMU1SXRMuTjekxMMuX9b6C?=
 =?us-ascii?Q?YJyZ31q8UB0ajFAo7BqM3cgOT2FTYCkdltmtevm0R4H/qtMtcWKqTDJSvkVH?=
 =?us-ascii?Q?r5D0LX57HS5uoCixXxGVS5ZsFbomwoctUIfLk+ucjOCxifTEpTSSaHQ+TasB?=
 =?us-ascii?Q?RId6dp4aUskQLus4281wAM7WTf+VOvGUpXYRHsd1KV89MN3UimRnstZUJ9bp?=
 =?us-ascii?Q?LBlE32s4vrnKp+nYtWfP7oMFDRj3fMGlBwIyTzrkI2OZJTucDgAJVHVUaLky?=
 =?us-ascii?Q?TGuIgDZPMI1aLRbY2u65YueIPql4h/QwHw9rck1Rovh2gJdi1ryhdyWrY9S7?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xSrBDq3r5skJ/WzteDDRyE87pXyMP6puNpF04HI/w69VqXolEM/3Xgn/G6dBYg+mOoWOmJio3KlTlstTpA6fbxD+mIoDfTahAq97y7rO2Exie2YUrI+StZooWXD4YYmDUUezIO++TjEUJPJovHoqmeYy/XQhZscUs3CdMFL4MGMuLFEoXF1Dnz7kw0+Rq+bFvlTWJx5gsL6rRp+bpW3/0BGW3BWdfXxtJwOdXfG+dIIqoMGP8o2LT8h0rufrxyxOuW/nXMM2P45xUdKeqU3y0ZuzL2FUa4JNkeia6l70M2jZGXl5+7Xgp0J23W7g0tLFSyzAMMutaZtawpYwfrX5qt6k0g8CCP088P7CPOP7XnVLYTmDgryUDU7loxddrB/Yaw8iuoJ5KAF/AbAcRFGjLrgUQbdBgWc5Lt8W790CfR5Hg5A0AzNBmV4dtZ2nQWRtq6Sq3phoMQD0R+hZDh/rWJqCkT0OoMgLL7LPJBQiOfv1PWBfpIYGJ2A9696ZNttHze2wLpFJHVbR9ZBD7lfnvNTrEUvQVBkGjEtt0YQkWhbJFIiBDaUN1r0BkGaxx74TvXTASc5B2o6tIOKqiHfP5ZMcpvj7BudHx5TTBUgzNt+smfpzhBZVUgDdWU+Z4CRZaWf9UYk7jfDd8y10Ii2fV9EVzA3UewAS6MPc+r2YoBMnnSQXJ2HyaQsWZANWpuje+SLmZ9JdiVz1SETMCvNiDwdiozRk3t504DiYQmh1nY+VIAoQphz8uXrmTeXtV/iBdr8ftBxmZCoBZVu7SJ2dSvPmYeIkl5grNjz5ZJKU+PKj9+L7ccD3Tk6ZeXzqrCMezjiSAOLXZ4LQ94sF5m37Rp61P3GlqeZeXEZFmuiGobiPAWFLS2mofso6JrXOkJAW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969df111-1ea8-4345-0adb-08dafdade622
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:54:16.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um2EokwMy8Z6SLr1pi73kAIA0rmb7fMGHzhC+oGYf61JksuiVHfJ2dJ6eMnWmkgBF1MHpfmz9So3ggXS7PXlXbQ/h76+1591Qsd1OE+2954=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=840 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240013
X-Proofpoint-GUID: BVdmKufaxrwm4k7YdcIN4IWyAz70BjAU
X-Proofpoint-ORIG-GUID: BVdmKufaxrwm4k7YdcIN4IWyAz70BjAU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

> Don't use "/**" to begin non-kernel-doc comments.
> Prevent a kernel-doc warning:
>
> drivers/scsi/elx/libefc_sli/sli4.c:13: warning: cannot understand function prototype: 'struct sli4_asic_entry_t sli4_asic_table[] = '

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
