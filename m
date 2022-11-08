Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41066207C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiKHDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiKHDvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:51:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0C52D76F;
        Mon,  7 Nov 2022 19:51:04 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OVNo027238;
        Tue, 8 Nov 2022 03:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OLaH+vaTcDu8UL0+yKRBTe1dGwSDqkWLDyQNDHRkqLM=;
 b=P5X/PK5gY55vWxJqaO34qin+BYGm0aP3cEfdzgOXTpKy7E60a0HvWH8vB6pb6Q/5Ag2y
 YFJ0TEHfo/nCvsHx01L+mRZap/+ekw1zyfkcwsBblpO9JgBYJqQUsX6JR4drt6TMXGzp
 azGvoHWLRfUbcNUJeXS785XU7L7Yq5tZ+aNaSB1ULw4S6t4Kasoo9fBp+8BGrxeEjwFt
 MxFKqvgkKlNq25gbYJ73rP5bud6fzI2W9tdKvRdzvspNDIL0LThxm3XPDFBznWVkYGKe
 dD9iqZvBGHN/TSfwHQmCoQ10ut91O09idYcIjKLPl3SArjmof3A3bgaxK/lraiduCF2k kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrenw3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:51:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A82CJOL025617;
        Tue, 8 Nov 2022 03:50:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfgwch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDMHdkvrQhsSNmwBi1/3nXOOZxT/+IL1Ey8u/aPjF8FY9GcVmPjNB3X1og6ND8laLg/j99ADMuu/Q3Ip9cpFtYU5szhYJemjNYYs+UXJ0cQ1raObPPtE1Xnef2M+f0k7YnGfTR4E0RRuBItS5sECZJ4T7egfXMhTOqF3mcfUQ4LhYQvYVXG8eC3xytkyaOJjuMn2Z42Vg16XBmctAZY4UkwFN3LsZSbcY21Hg3HLL6a36oFiQGuZULfpRoxS0YmO7FW6VqQC9gan3Li1EpPlhx7+MxNiE0hPYkNwx5KuFOdxmC4FOkpbdGEgi6Eeq+DpfsSxbMXokOq6j0F8ljc5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLaH+vaTcDu8UL0+yKRBTe1dGwSDqkWLDyQNDHRkqLM=;
 b=KUmEc4kHl9R/JrPTm4iuqPeiE2iFgXr2N72iBwlqCx6AeRp0oIeu76RXhnx55kMRZFISnKVngTdWBwSrwOp7ZYj+a/+rxtfbCQIE6jpW3zki/SQ0dSGtTcFUT+QCnf1IE/uLXZR8zrXURPeQshKU3KHbw+a5yNE66tlEb7UimiFowOtzMms1fxmRi82belM+8GKlttXZ+4hA0/FrPZzpX7HedbEPhphbeE00XnoU9Esb2QKjY5Iv8wDdz8bcSUiwbLHZKahmAJBzTGDD3AEGnhRJxD97voRvgOFD31558i/BgZU9I52+/aiza9/b6zKDESdbZ4t+ymeNeHKroi2LMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLaH+vaTcDu8UL0+yKRBTe1dGwSDqkWLDyQNDHRkqLM=;
 b=gjbEwmkEeLK4QWIY5duSE7ypaFjtUp5TCJl1VBEUU2tpBcvSBM1+YZ4OM1DkqIc3DdbwI5thx3RakEjEe6ImCfr6VbwuakXKP89iR87lIn54ljTjtu/4QE+yLzXgx0wWmMIs9IvxasP2J/PSRwhXFpUpM7hjy7B0HI1t+lcXQIE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:50:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:50:56 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: Remove unused variable unit_serial_len
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfiuhzoq.fsf@ca-mkp.ca.oracle.com>
References: <20221101105326.31037-1-colin.i.king@gmail.com>
Date:   Mon, 07 Nov 2022 22:50:54 -0500
In-Reply-To: <20221101105326.31037-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Tue, 1 Nov 2022 10:53:26 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa00e12-39d1-45cb-6746-08dac13c7101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sno6Sc/Ga7b6ZYifgTuERRWsdoN87vwT20GkowRZ6VfGQ17BO6oAs40yRjkeLx/MiiS04pz+MQY1YMtJOElbTxjb/pqw/l8Sv/ci0V9LIb88JbdJklEN4Lq9PRfNhAiyJNFa/OnJ1oZ8WpjcZNNOO0Uj5ICQAscJEOT9AKAnuDUuLAqA7MDJAgpIhjVUVaL1173400m4MIpDNq+K/uoJ/WPoMguA0AQYXI5oeV/0V5emhOh9rRpYE/+irdGhvSdIFuTCiHAfQKqS+cLkpVnsqbjTosWW7FHKVGNurXa6DT4Liqz/dK6XEE998Fm2d+T0mYBUH86Fu8hPcycUEdEzsoLgayGqjyCpTyz54VY19cQA5konXrOsDTLG1t3N3GFup9HiFe/y5Xoz/2XqcQKPMlrEN24ZGxnqSlwI0XLnPb3a5o2XcheC+YW3swYtpwA0Cuq4FhgsgPb0CDy52s6YMx/VduH0dEUJp4MH42KfNeUIiPZHuGa1NV1bYhLBS44KpMVPXfVescnDeFsGACBtO/wOUWFfTv5i33vR2sjGVtibBKi7csAARz+G4CgTYOc3XP+H37NW+VjI9NPN+mQom4PZPHXMn7m+ZN2pRZiwmFDfZIVCCPxxIbJxgeCNOnG12ydpgHNCoj5Ry53Lq9QdfFATdQESTikwaQTipEFsrmpD498ijdTLYhXs4lnN/Y8Zu036C+IeKhVHoKIPPuudYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(8676002)(186003)(41300700001)(6506007)(66476007)(6916009)(316002)(5660300002)(26005)(36916002)(558084003)(4326008)(2906002)(8936002)(66556008)(6512007)(66946007)(6486002)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYYKgreJvHiYTrChjINjSgKs05ZT6gPjbvQzVIQZxafaYk5LcXE5Ll1tGP6R?=
 =?us-ascii?Q?0Z7On6oWGHCNy0k57PpQ2lzZ4/0r2nyNdILx7+zfDxqe1WGebAhKU24fEY5s?=
 =?us-ascii?Q?vFJolI3Yi1O/i/BOf6sEK+79iIy9J+T8u3mnUW7x/BhStIg4pW2+fOgoHJ/E?=
 =?us-ascii?Q?QqAlBNCvx813rJaP9G3Vwd1nbwe1C+PmHEu68h5CGkvryBLjlcaz5S5mBNZk?=
 =?us-ascii?Q?3Cbi6QgJg2mWaQ35z3+vKbw6JKo4EMInU6uquT23lvy8LzY2eECf0XhZ3ILz?=
 =?us-ascii?Q?aFz7Haj48lfw0ubENrwE9o7NTAFYZrKMsZTd//cbbcOjdziE7RL/QV4fWwQo?=
 =?us-ascii?Q?MEu08m0ICK0+XNfPWr0YKBYeiOWOchpDAmgZl+LSVL5Pej8+mLlsx2Z+Gcpj?=
 =?us-ascii?Q?MWSRlSCd+cJg+nlFhSyElNO8zrqDCe6QmiZo39DTLheiGtxIeGrE9keyg0Jf?=
 =?us-ascii?Q?BbvMMB5p/i0X0INeemGoZXDkEnPug3GJ7wsGCYEB3ChzgiiVugmsmtLT1nRt?=
 =?us-ascii?Q?kfdOHMaycwFqcpNoc9aV6qaNHsyEtExWV/dXfQuCtY9kHcncHZ6cOgMGzUTJ?=
 =?us-ascii?Q?cIcoDvOgp8h54JWQL987pbAsC+w+jDTJ8sOS+BbVzFofWTBkLhj7Y9DIe4Qm?=
 =?us-ascii?Q?XMXr89rMfr6obQR0+IFlZoEprRl0pbNtcT++Vc/kDWVfN76VBY4Wk1puUUNG?=
 =?us-ascii?Q?FM/L/JBiRd7GHiJQMA2b9Ih5ZMCYNEuZ6wvZImEkglBc0rIqN/nrkXRU2+ik?=
 =?us-ascii?Q?9l525TjEolnNz8cwKSctWsQAUyVPdNgWBaBDoyNQyE5QcKmuq6lEnE4MjayL?=
 =?us-ascii?Q?Xm9OWKxM2xjxLj2+7Egu5pC5k8F2EKXZopcViodG9TjZ4yEdQMHCrOJrI74F?=
 =?us-ascii?Q?EUU1GqVB9F83MZOjUFnLtKbZQjHnCDcj4XdRES/kmbd3QUYhQEiSWBG6N/kX?=
 =?us-ascii?Q?As+B1ebgw5LiSQtYX+u5LoH8Loq0PrCGVjkdo2G/oXALfzVUwSAQrCtPuww5?=
 =?us-ascii?Q?+UM2NfwYWcZ2pG6ckHTQjScmm+3mhKNEvlFYiWwF0sYZn9C0oYGGxs9tnSmz?=
 =?us-ascii?Q?AlFCJ2m5+DZ4Rt5Vn+1mBJ7pPkijmfCKFvgNfQqXkYkl/YN3IW0HYEUse8tg?=
 =?us-ascii?Q?z0zTtTOosod/aeBFSuTBQJq632/yqt6gTswf5yO9z4Vrq6xr6sJ1K0A964mA?=
 =?us-ascii?Q?wRuGrln2+YMLrL4jXhfHZZo74YCWcTKUROtaZBVfAs2049FUuRgeYMXyzrDr?=
 =?us-ascii?Q?TnQMmKUdXMFtTLBdIfbMn7lIVfw3JpGZ5wjzqxQeg0kZrc0Yvp00a8udREfs?=
 =?us-ascii?Q?cKYyq6hJSkXb+4yxx00akLmDRhEH20ew3n965XTByAkhIQNCPG1m1XsqyGaJ?=
 =?us-ascii?Q?e8fHvPMOkzsLiAMzw0vi/UxrmiYcuPIIBfpvNY821f9sAmbwU+7oaCUfBQsY?=
 =?us-ascii?Q?kwfBc4QfGDhZpS822BEjAJ2On9GI/ee2kDa/vosLtEOZy7wwQ7H9qdH9AH6F?=
 =?us-ascii?Q?RZBI6WTm4JAVXfErSK2lUmQ6C/6XgvXLJ7Gd6Hm9gH4bER4gt6ssDsAICOJ5?=
 =?us-ascii?Q?iRJsiADv626WyWjaGP7kxpljZ2XBcNySskPlMxir/SwyYk+0VMTjjymnpG4z?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa00e12-39d1-45cb-6746-08dac13c7101
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:50:56.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju2mE9BLqp+KE6tsDl1ePhtme8yrz/972+fb9lJ9EOWblUTuB+5+E0z26fPRoB5T8mGVJJFALxtpArsUFtSMxZxTy6QEqsUlng1vNCvMgKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080019
X-Proofpoint-ORIG-GUID: -k7ip_seUuyH0X4auRUY0Opt2CbSHvNn
X-Proofpoint-GUID: -k7ip_seUuyH0X4auRUY0Opt2CbSHvNn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable unit_serial_len is just being assigned and it's never used
> anywhere else. The variable is redundant so remove it.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
