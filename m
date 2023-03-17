Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842B6BDF83
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCQDUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCQDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:19:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08801B329E;
        Thu, 16 Mar 2023 20:18:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H33b4K008953;
        Fri, 17 Mar 2023 03:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OBPAvg1S4AAzeYalNBJ/uuFKfKWgHYFvNRD9gp4PLtQ=;
 b=gHxgOw/n55IFu04520UCY0C22FBWkA+guBpH1eLQR2iFHYwtgYfEo6GQ1BYFUtkAwF9U
 jLrVHwiJQ3n3FEb+loMNVUtDW0FhQWKiDfy/ao1ShW37nZbTH8zhjkZ59ezlEZpXoyO6
 RZSacTaq9i9OUK0E/zgDpq2c9ZxrMRtx0Fh2DogUy9OrAipZtq876FUyliu5KLBcCltR
 cdbOkI+OaJISow1qyhNCWMP+AGlk0MvyaZAEA2xAUEdMsFKrigZ+NFAO6pAI4wnH84XN
 vBAkC+F0Cz1xahzPY8DVV0xroYbZyLN9FDt3UC6WTwmynhxb65XOPCKVL6JbPMsYYwOH 2w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29tt7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:16:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H3BaN0004114;
        Fri, 17 Mar 2023 03:16:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq45q1vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9Vg8ahRE43RSjVqQGHVzlY3sC+JF5N9PalugvKXwyH8C9/D5uxKj+5XTilVdOweGSLi3kquBCc94DbB77rAXqLZzDQOVQFKSHKcDll9/zud8spB9CVBFY3PxoS/1UkRMwwJWfT07teMXW8NRg3L29wXsLPvwHJEbjsWSEnUW+RPsVUtkiLI8l3vEabFtdYTouqPZth5JvmMfA5Lu3g4cyWUl/kGswW4CsJc56KK3zwKqjlyBfmFSJhWC3C3fY+phwLbCwHYhD/jZPOU51a3SirxgffTp8ybPYT84mGrSyNbM+MDLy/20U/o4lFREoOkK5LoWmyF/IvnucjMsBzCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBPAvg1S4AAzeYalNBJ/uuFKfKWgHYFvNRD9gp4PLtQ=;
 b=obcPQ84cMZSOk9ispvgdRyVvNlOeu4Yrm6t3lsntrXVQeuv3vzfy6/SzZM5lv72YazlGwd+Ezkd9JOn/vL/h2tQ/vk7KgvXYpZHfZ+k6pgxzVPnVCtBgTdApdHDLUCviA0RZbdjT5LxRgk41amsI3/f/vULF4wXcLm9ktum+WibM5HaW6cDBBmDi9vMLit+MtbL1/Y3jsJ/8+N76PqeTxawD7Rp278vpNg5PsA5hEJGKy3HGMyXEWPCAQW/GLweL1nzj1b7ebw6vRCgX6GuqCnT+LxOBuIJC8SP4241dLqX8nl+1jhUNa7qARohY0P+MDoK3oJ6TfL2tBBwVx2jJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBPAvg1S4AAzeYalNBJ/uuFKfKWgHYFvNRD9gp4PLtQ=;
 b=Nd8vcX9tP+vnXp7fMJXKiyf2JwCR9EAszWb79joAlmXZDXd9MG9ikMScnjYnf3OC7Eb4+hnAyBATdYi1yJxloSnT9nrRq/HlSKWhKYwEn2BLSyIX2XimhFF9MBV0qLSw6AdY2P4iOtsPiOUmUE0L3ZaotluKCYb/IOYZluMTQ/I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 03:16:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:16:45 +0000
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3] scsi: ufs: core: print trs for pending requests in
 MCQ mode
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfe4xe2b.fsf@ca-mkp.ca.oracle.com>
References: <1678865517-43139-1-git-send-email-quic_ziqichen@quicinc.com>
Date:   Thu, 16 Mar 2023 23:16:39 -0400
In-Reply-To: <1678865517-43139-1-git-send-email-quic_ziqichen@quicinc.com>
        (Ziqi Chen's message of "Wed, 15 Mar 2023 15:31:52 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbdab76-199f-47b4-4a54-08db269609a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvDVcXAOF/erwVcwb922We7jLqhTnpdETR7Cs4aHFKpXbtpOYmJlUo255WzvQC5BoSS86zudlSTuXOz7I0wtRem5GAlvMgTU1zNbeapxArlDt2geOTEJplIx7FNghrsYRmyKG4Z2LFyCUI2GfawoGo5kVSMNeO5uslZ63Cu6nv7sxPEB1lc8jzI3Jz+xL5N/AAgoaFwqR7Sv+K+GmcLBjZJyjb6vmLda0xwFq/89urLDM5AxqCbIbvBpXh7tcW8xcmVpVCY71hhZ/UQsl5YpqmJW1xhq9KshX1JaaRzda8T8IPOV4PGq6Bh2ChyNzZXle0Ji1nNf7QLAcM7hDume9vUslojYjZfYzLP/dPOnsHA+OYIL+QG/IvbeT2wa0GTYyl3i+UeZ4STV1mf+CzlF2o0cCyizF/sQRNSWOxIGXX/ERpKR8j2cFni6Jg0+2EY/jLTZyqlEtidfw57VHYqN/k0k9wihpSRkHkCabWBll6w1+dr3m7ULsch/m/NKB2LnmlUK+33cYxU1q01M8pvfYlfDkRzq88Fn5rCKasrIMzU25HBubr872p2r32up4OascApUkFP6+aUq+v3DTpwoi6ZRjATGJgiGjafkwdPrcgruxw0220PY0ogIoC5PrId5BC9csorswUig2S92M+b50A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(86362001)(38100700002)(7416002)(2906002)(41300700001)(4744005)(8936002)(5660300002)(6506007)(66556008)(6512007)(26005)(4326008)(6666004)(186003)(54906003)(83380400001)(316002)(6486002)(66946007)(478600001)(36916002)(66476007)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79jdAdfaaflpG/tpHajqKCGeoacYu4EfG+8u4BqRpgVor76CNEjLdlhMpcEr?=
 =?us-ascii?Q?1SkLupeVnd/WG2ALzv+xvy0MB2mBPh/2asti60lfykAX36XG02vydy2oXzs6?=
 =?us-ascii?Q?2MvRka6d2HxkdHAun2ApHAVH/WNO2dbVhESnTvE4UyhF2NdKY7TwA97t2o2a?=
 =?us-ascii?Q?u3dN4OnjWSI+M6ZDaw9MB547hPoVqUYczssCdaOwH6/C12ORE4AhYnn89pir?=
 =?us-ascii?Q?AGFPQbP5pJuq4Y+iO+Liz79kReCmjb8229jCIQSrNL3mjKewNEssJpkKbF2W?=
 =?us-ascii?Q?y4A6MMVBO84DGzHQtV/9i1lusYBjGi0wCXtg/ps23+BpqKTQ4FbZEAoHnELe?=
 =?us-ascii?Q?iAf6QiqP3DyM8a4hCiaHtT7D0uY3GKUS8WplQ15s70viua8KwweY6Gg85bQq?=
 =?us-ascii?Q?PKAwP++7KCk2ig25vnUuGtQ+OQTfC77WC7RLrxjeBARaR/asq8bJXyGzCPgx?=
 =?us-ascii?Q?DLn99Hmsj6LPeAe8Uaa4WeHxlM+goQ+t2MHT5kiVPq53K5tiY9+vbItoclgF?=
 =?us-ascii?Q?UZoVT0TlDBFlBkd7VTzRLCMORsyNYvOWg0TaWbYoi/jNesahCtxC+VDiuR3v?=
 =?us-ascii?Q?ls+YC/Pb7p5J+R7y9OKpk1qbm+cQ8V8rZCg4n8OdINPPZeQUzUsTRhYPI2XT?=
 =?us-ascii?Q?PMjUKgbL3Ey7maU0IiLZk9Ztm3Axysb4dZUUL8s+yT/c/rXUEMostHfgQdap?=
 =?us-ascii?Q?JYZTBjipqdsOUNVvCRFu0RfxZ51ZPB/jUlEgLnhpGO1LOyLOaLgbLqQoTUSH?=
 =?us-ascii?Q?vRTb+A0A3kH1fT9SJPK0hmELGK+lM8n5IVRerPTrbuDXYpQ//FU+NoJPbTEg?=
 =?us-ascii?Q?OsaM9vUwYT2BRU3bm0X1sgg0u+QjZrCCOuow9ktwtsPRPGPmG5MvEudIgiue?=
 =?us-ascii?Q?nOtwPptaR80f2Wf+B60GYqhylEF13sxJWhqPoyj6zQJbl7RcIFlmOgC8jjKv?=
 =?us-ascii?Q?kbLMhlJ9HfpM2+e0uWsZjy7+ijRdJqj9bAlKuhaTlU6uFIcZWsymkf8e+mDd?=
 =?us-ascii?Q?ip0IUXoPMyFdTdUKO+5h1dMSOlf5cdHhcO4WNaIYgZt8d0LHQEjb2gAPiZ/S?=
 =?us-ascii?Q?ZHpkNd5vTnDjc9hvos/xo7D+1VEY3c/ADKjnjiudlp6RnLMESnS3OIOkIBkG?=
 =?us-ascii?Q?jH9nvSzD2OBVF/Xuli9RPcYKNVsicnku2l2le8JeJdGXq7ZbicIHQnBLlgsv?=
 =?us-ascii?Q?oPGgqWz+MThTg5pLEkhxL3u75Btcrz3qJ235nsqaXAZtJzgwo3KJTzWInWA7?=
 =?us-ascii?Q?hM3TnpX53morzmDe/FWvyESd9R3UO6ENafEL46txr2tlse6zvFmAwUyi+udE?=
 =?us-ascii?Q?VnX8qcerIVxjIXEDJmTgvg8kmQT8BmlqgRhl898YWDKlhsGgsq97OOuYXVxA?=
 =?us-ascii?Q?tF+DvdyMd0BMe7Rdpeg8oSAb0UM3z6F+5Bhu8vACCHWxlJK6ZDJyJtiCvzmC?=
 =?us-ascii?Q?pXiGdnChZt+pzqqOveE6eAbPkujzg+zKWss0OxqDMfkWWvrxYqHOFOchB1y1?=
 =?us-ascii?Q?2duhtMG1TDCQpFQW9Wly1d62EjMKwGsrrkWgiY0p//fBPtbR654IjtlASYQw?=
 =?us-ascii?Q?iBaph6KhRrMdFT4emv95KVFmUXKnuextHLy++nEwJczsO+0ikB3xQcD/S8FW?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?B2o6tpzlZEvMgHy3aWH7ujcFE7XIBTdp4dQXeAYUhYRpVEt6ji3YUT0eNSFv?=
 =?us-ascii?Q?cQH3lGPqZVTpzscGnuYS+izcIPTNwRgTzmhy5G3sn1DTX4dseDN+CvHolsKs?=
 =?us-ascii?Q?VAuY7acStOyziCN5iTn7mHMEG+RzkpNVO81ym+QxCrz5H7q81bj2ORsCBlXM?=
 =?us-ascii?Q?YY0+VOKUU2sDE1f2QXr0Tjs6LcRPSrBBki31xZL/44/JaIIsV9r7LI4rxGaB?=
 =?us-ascii?Q?qFydyXub3nNyQ2K9NItRk7/Qs8PyAYIPs9LSSVF//dH6EdUuKKQt/096vIac?=
 =?us-ascii?Q?7SdhoHOLFGL+XcBl86rJiQ7qjrCN03btp/MGIn9wHuxJ3fOMZAvOY5ekrW9f?=
 =?us-ascii?Q?3OBwMTt6J1yuor9ICvim6s4Y+qnX27rr95eRM3htmeDb6Qs30mA/D7FN80px?=
 =?us-ascii?Q?LJBX2WxxbLeliHKMnrd6coMnLUg7Rf0KMGbgblH0RWHLr3XRjf0/OyT842AM?=
 =?us-ascii?Q?uaj9gnaYdv6ZunT/B3/6PqS4IeyRk9QLNA6/qTO14p0KXauGwPBuP3sY3+gf?=
 =?us-ascii?Q?2XDauNjCHbjTd1lSOsM2LF21l8nbsXe6eVOQcMd1sqZQZ5K3ealeFk7xBqm8?=
 =?us-ascii?Q?BUyCPqg8c+VotxxSoIJHplE4gyys5IzuvNJQOLBSs3pQfFJoZO/UioypWk+J?=
 =?us-ascii?Q?/YT2r8cPOZ2BSD/NU0LsHqsKI5wJ74N3uE2ib0VNMvapmm6zOVGAc7Gn351M?=
 =?us-ascii?Q?ZupkuFVWy7y03OIxJLdI9tnf05751VIQReuhmC+UIZB4CiMl1sAkwnGZb79f?=
 =?us-ascii?Q?TN50OZ2uVWamWYC25oDFDUumR++VJf4+Ehc82SxAC94UUw59udamW3wUUdwI?=
 =?us-ascii?Q?Cm0AIPr3HE3NnIO18N20NqswVH9eXS4yb3NHDHmwHGzgtcunFBK3zUqfx07P?=
 =?us-ascii?Q?iNwnav9xd7BXSsKMXwrI9E+L5mHOp6dWDa5Q8cgs5gDPlmInAZa/y1uqnrHh?=
 =?us-ascii?Q?HC2qNAau2+5jK+zQRRKe0I96WbaOfQ42OEsJt2RWvrDljKSNSxweTEHXgOfo?=
 =?us-ascii?Q?BzbUUN7H4pbYirjVf/Qz3hzaPQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbdab76-199f-47b4-4a54-08db269609a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:16:45.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq5U+sqH38wRxOJIMPi5ePQX5CKGii5Me0JpOwZol+MkDZBFQvXJEWNkCDWLW/ivgPFAUJwNOsXxcj7WGOnbht3Bml7ljw6X86NGZoc5W9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170018
X-Proofpoint-GUID: wFoomDikUjiy6e0cnyyhOe_Cr4FO3N04
X-Proofpoint-ORIG-GUID: wFoomDikUjiy6e0cnyyhOe_Cr4FO3N04
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ziqi,

> We don't have outstanding_reqs bitmap in MCQ mode. And in
> consideration of the queue depth may increase beyond 64 in the future,
> we reworked ufshcd_print_trs() to get rid of usage of bitmap so that
> we can print trs for pending requests in both SDB and MCQ mode.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
