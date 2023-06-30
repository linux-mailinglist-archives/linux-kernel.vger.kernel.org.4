Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58A744299
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3THe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3THc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:07:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2B3C07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:07:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIwpDo019418;
        Fri, 30 Jun 2023 19:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=GL8pzXNZZ4SW0Thgzutv6GBhBtnvQgKnYCpaWCKxOxQ=;
 b=okLdNZYiR+3SY4F5id7+LTFFBdcMaw0T0QIfvZQmvyccek7pTp/l+RhkOihg3LRkYSPO
 z0IwXkXMfaIMvdE2Zvus5bkzap94IQxcYIyzRvKmvSNiXaHs6WjrFNFhZz1yFtO0WH5Z
 cOvYwX3HHNg0vtICnOI7jLowOzRRexa9NJr0GjTt0O3+eVHQrRkJ6KOFxwaR6Kd2Ubum
 pVLDdhhwviKKZ0jUJnGbcZEqAZQPcEo4U40oqfsbu2IhSMidLGYsqDFb6Y2tcb8DxDgo
 v6223daPlCE0VV0eAOhYhIRcN9Q6coV14GSSyWPIsjZXn4x3fz926iIGMeM1Fv9QsGko NA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40efwk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 19:07:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UHicIB038174;
        Fri, 30 Jun 2023 19:07:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxft3es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 19:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+DKeJk/TM+pzUJw13NxXbdQpGn7qlqjdy2a1Ygrq8/s/cegjNddCO9VMlCqiXjp3y13n3uBGyWGyHpmQKkrto+ePN5smzlaIkFlKixyFpsY6gp+gDDA6gWTh3elgRyz9gML+ryKd8Qw3WSaWIVruPtrxYjR2+ine3A9kyKU65FwEvqcj7DTR//W5KgpXxm/1qeQARKZNV67hAYyULg9TEMgJujQ0Df1+ciHWAIFPON69GaUPk7ez/0kiYquDt2CeJcYziJoehSUuqz/3sZGn8Qqblgp9xEPOr++lEoyqpZat8cnMf97JjwvuM69nOow5uWjDjEP01UCLDbS3aDCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL8pzXNZZ4SW0Thgzutv6GBhBtnvQgKnYCpaWCKxOxQ=;
 b=Zk+aoc0fOa2f0Td5dZ5s53g/YqJPvYuPva8/xaQzBI26WBl8eOMF9Y7gb8rhfbRCqzWg9GrUgEq50RPgePIhN1/1nGp4ydChHwDlGcKo70OfWxLjE2aAXalxVC9GSYOP4/ftyWYXW0fVoFGtrpdXvHD8Ce63a/PKoWh9AijxT4luXR4BBlUNyHs3RmT9FeQb3+otNMtL/XJ9pnVzGwDyqKaFY4OExxyL/RZvpQsFiAKe9nll0zbDZ7ll/O1M/uawe4sPPUI612QlNwWw0mesi9BPXOmM2t+ZaAiTC9vA+6fchEcSCC6Lk1dPgEHdKaZE4OPWOz7kO8T52oB6FqAbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL8pzXNZZ4SW0Thgzutv6GBhBtnvQgKnYCpaWCKxOxQ=;
 b=fkwByCeorw8VK3vs4zt6Db7EsO2sOUdVwzXGMKyEnCpxQf8daPv3QS63kSqM6+V28RnVgJecup7RQlsoboFsqUVHjzLmkPN/LCh7t11OlNT2l9+feZhA+y9aWUgzQA39C7rVLqp9Nlr0EupSQGKYb3GrDlj0z4nNjC9G2jmMBOM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:07:10 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 19:07:10 +0000
Date:   Fri, 30 Jun 2023 15:07:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Update do_vmi_align_munmap() return semantics
Message-ID: <20230630190708.nkn2dls5x6tc7g4l@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
 <20230630160519.3869505-1-Liam.Howlett@oracle.com>
 <CAHk-=wg=DGSsA+=rr3bMDKrGNgy4C+PGM_w2PtpK4+Sx9qFF8w@mail.gmail.com>
 <20230630164135.725ewvttype5tt6x@revolver>
 <CAHk-=wjpsY9MC-VyjO3j0OLWYRBZrctZZm-v=szTBh9JwfWEiw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="6yiabyfxthbyq3ua"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjpsY9MC-VyjO3j0OLWYRBZrctZZm-v=szTBh9JwfWEiw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::18) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|SJ0PR10MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fbc633-3f31-4dd6-0ff7-08db799d3474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cqpwr70h26fBdd1liwz4bpCnUhhCzoZSr/BJlw3QYLzXBmMK8KOzZWrINPmXDCjWs09g+VnwXXmUHc/3Z1VbAKQ7hLrdAWQNYiVLUoOu/xFNVKuKge/77irUDXMwGVRFaH3TIRCrThRmpx+PdLxuCqQFSjzXHgRkjOH7cEz0Rvr6yMHogRTjmi1qjvLFUXeuVnv2zixiObJXPbIt86w0LU23BGgYkH11MP/dIGzbgDcIcycdcEEmvpCEUSe0pU/vUP024/Fz/OB9wuMU9y0vx33DPNaISra+uD7i1i0xhtc90YulNE2rLdyyPLimx899AQNTcv7kMvQWTUtPhnqhOhkof+5c8+oqhhe9q5GgdK7AGxCPwsoPDpMlWT4JiYiWBprkaWCL3rwI+QEG0XWtU49689/uY4A21nsoMca0Yla0fsx+hwE7TCxC3hdwLQZVe8SB8KEICRhl8orgVtodj2dZvh32FT7YkjxpHAIVna71ITMs0kmUviYEwxtbKLDiLoRTSSnKx1+T+NMAfYImPO7pvx1OWgAAnqcorM5HXlRi02eCbNBYX3bQU3PxYSKg2HroUL5RLjEV56/ron98mrbs1QG0Dxfwjvt2ej3d0wrMaOGRF/TSNML0uczFxaNF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(44144004)(6486002)(478600001)(6512007)(26005)(9686003)(186003)(6506007)(1076003)(83380400001)(38100700002)(86362001)(33716001)(6916009)(4326008)(66946007)(66556008)(66476007)(2906002)(316002)(5660300002)(235185007)(15650500001)(8936002)(8676002)(41300700001)(54906003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvm+17fQQo2UB5NVtsnuoeGle7ix7hknr7pRbfSYYSp/b1LEhuChnm6nzJkt?=
 =?us-ascii?Q?vBikADK1h5dgIGbGLPrjQOdIl277oArKcWi7LdC4t7Rqfw/Au6QrZ2KX1WP5?=
 =?us-ascii?Q?EHlSEu1XSMrmNfWTMxc2CtTGb5oj8DOFSqaPPwqKiFNqt1UcK3Vh3fPJ4jCq?=
 =?us-ascii?Q?N2LDWNNDC8g0h33f/ee3QyXkwDGHIzl/EX6AtOBH3DLACXpzv5NShoyvrnIo?=
 =?us-ascii?Q?zT30gigKDfuzS7bGgYGf/kB9611kLJkJc8wucYZUrfGpYxoEOkFphQ8lXoDI?=
 =?us-ascii?Q?FWS7VjSaomwGZk/5PvEk3gCBPjXUXyEJxbjcAk9PkxNiSGUNTAMOAf+vCKg4?=
 =?us-ascii?Q?ttiD+aIa74eYG4JYJuTdtIbc0MtWxI+x+m2ZfF4DyqDyZq6LQGciHStf+Xrh?=
 =?us-ascii?Q?v663pN39PVU8q6TgzVYmM+Udk6SgJa2/aLnNF8Rnv1+R8MoM+NYTk8S3ucbc?=
 =?us-ascii?Q?7eyVRutzLdxT8y4l2tawVCcig8ZU5YnkDdYwhTl5UMDM0LQOF+4lAWVvwpkN?=
 =?us-ascii?Q?eQWgTL+fKRizKMPOJqAzTwMtOMCmO9XBn4Sd/uWWDWTu8T9VAgzA7qNvTNCW?=
 =?us-ascii?Q?hjJSqnslEXTw2L+i8Xknzn0yiZ9qxgyEW63JSBSueXFEhUi5vueCLJoS/673?=
 =?us-ascii?Q?MuSRJ+0VVZY2Ef+Ma4/W/c+A11LiChxxAiHe4nURcj+38gHhJoYIkSkMGy7t?=
 =?us-ascii?Q?Y3SRyI7l23vwGhuObCRKDJXs1DaKMRCfAS7hiMpVO+nJmyr8B7fcy9E/mn/O?=
 =?us-ascii?Q?NLzK8TGhiNdVP0f+DEY80xM3QZ6y8eyHXnguBFTaRgnZxVVCXCTlq9PeUjko?=
 =?us-ascii?Q?BLtn62ler1A6UDXSb9a847fnjOrfd2R14V3APEucl120I85a01aZUErZx7qj?=
 =?us-ascii?Q?9wvZCxM1Xf/RzDLuHbgDeCxrgtpZzvm4dht+s8IAmmeotOp4u39j6Rlvkgju?=
 =?us-ascii?Q?L1l+dkk8swAYsSRpDRsW/SAGdmpBxZb3pt2PPJfM6OxxvMAa5vj0B5gucf/u?=
 =?us-ascii?Q?19iYuYNKvZyIHfAkceYZsv0vd69eW+u2bFcHv6qKf0LUiVeRGaMIrVpvDpvG?=
 =?us-ascii?Q?rwIN6CRZYkKhYpQcaGxzl/r/8Lhx8r6P96wF0QWQo2TRIJVVlmaGD/KSrG/h?=
 =?us-ascii?Q?hqB2chkdb0ufQACSnImXCwVpGa7FrF8PLUdKE+I0eMBifD+LWO/evS9BZc5g?=
 =?us-ascii?Q?cbil//Bl973g84rkRAW8umAIOQHjU0eLIJDhZSdxuAT4pYgTiPdqtAlodWrg?=
 =?us-ascii?Q?fjQzy9H+ZVkw0KW9TX2Mvc+vw2SS1sA4B+a9NB7Ao/Ysak7FO0kG9Civ38M4?=
 =?us-ascii?Q?lBL/g1lKzOzW/RNKjZq2e51qBy96nxkVwp7Vpjg/q1uUMqSkEDMv12RWleKb?=
 =?us-ascii?Q?wc/NJZhaHnODONRZOlqBwFGGlntKXacs+ZVR7z69ku7v8mVCBSNL1MmV4DP0?=
 =?us-ascii?Q?bJCfxrD5LRE4ZE8615HVschIifxioQizM7YnM7OZANl4ZGPf83PxWDjJA2n/?=
 =?us-ascii?Q?+r4rBVOaq9VyOil01JKLHqAt+FTjV9jFfM3ZSMIVGhqyigaVFz4/uTLgRD1j?=
 =?us-ascii?Q?9Eo8OnBUvkbikJnoc6z27hzUBN4AV/G1hIpwWxfjXC2FrVNGjaSSgDKSuK3f?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rGkhCIJQOCRsOZHV453O3ZfOyUdCi1ZBlyefdf844shnYBYh9UYwOEHjlJk/rrKP9oJg104kDfflMG287+b0ox0NGx+kmXwqQpBN8bXsNLYgml2I53u1Cdaj4Wtfz26f9+r8j6U1sw21/Isz4E4/qKYIiv+0sJFFzJJwqa1VYGW6Sl5Dxz/bhD/tWxiP0E9JLHGGnwtOxt1Ncwq2jf5PQRL7QoW3MWv9WAQwIh+WQPgmDceBAc+nea326jxm+C2DInizRU2ouQ1CPa8hpcZ4BR9mMhyKL9fh3lWYGQjHFoael/zZkbzp5PI5sh6k3nZDQwo8LMjbtfHMiiJ3qLTgGSfSuLt9YdE5YsjwszMuzM5ZnS2IZ5wuBZHi/GwNlh/xrpAA4yykjavf8uKAdd1a6ZAWQt722gdvI8Q1hRI7wMPtahnR5cAoMeaj/974j5c8Y1P11YTkmeFqcWAQIosfjHaeqO2tHEiitmlPMJVNqc+osrHusg+tE7je2s7QRU6URd8/LWeCKz42sWi3hvH/o5A62HHzilru5Og62ooN4Rv2OSXde3WLDe6oRKAiLMZetiI9M7rJcc34pq69Xx5btqRmr0jh9YAhpApp8194rc0dZBJfU3U8aej05F5Y6TZfN0+gZqcs8Iby42epZBBU3OEeC5uCyZc1xvVXao0KmFkvRogOfbt9z4BFQKr+N1iKdmjG+pALOxHo4XRC6glFHMq91+JeIrVd1QBQj2b3Y/8WruNBoOSbzPF4kMMOCx/hi3Wwn0XGmNRhTCPWxM/lpLHB8SxvCjuJfhuHDD/RiOKFBPYHnzUbe/Z0hwQEWwR9S3G2wZfR/KLF7vyjD/2yH8adTfMG8d+rX2mhmwWqf5WDeuKKtnTX8J8O3Tiq1LMQ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fbc633-3f31-4dd6-0ff7-08db799d3474
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:07:10.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqbGSWt/nQsUstjwUTQwwBJrdRAS7FSDD62ociSJ/9QLj6TbaIbk5LM1MwcH0yNaAS9HV+nhOR/BAGzJavaY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300166
X-Proofpoint-GUID: 1rUILpnpckMFYmU2MCVaH--c1M8hJ-pJ
X-Proofpoint-ORIG-GUID: 1rUILpnpckMFYmU2MCVaH--c1M8hJ-pJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6yiabyfxthbyq3ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Linus Torvalds <torvalds@linux-foundation.org> [230630 13:21]:
> On Fri, 30 Jun 2023 at 09:41, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > I hesitate to ask considering how much trouble I've caused with the
> > 32bit map flag, but I also wonder about the stack guard now that the
> > write lock is taken for stack expansion?
> 
> Which part of it? We have a lot of special code wrt the whole thing
> that came from how we did the expansion that probably can - and should
> - be cleaned up.
> 
> For example I didn't want to go remove our ad-hoc locking, so we still
> do that "mm->page_table_lock" thing.
> 
> And I think the stack expansion does several things differently from
> the "normal" vma games in general, because it explicitly didn't want
> to use the normal "merge vma" code because it didn't do real locking.

I think this is probably rare enough to not be worth the added
complexity?

> 
> But you're talking about the general issue of having a stack guard
> area at all, _that_ isn't affected by the locking.

I was thinking about the searching for free area, which falls into this
category so the locking change doesn't help much to clean this up.

> 
> That was always a real semantic issue of "we don't want user space
> stack growth to possibly grow into another vma, and because the stack
> growing isn't strictly predictable, we need to have that guard area in
> between to catch things when they get too close".
> 
> So the stack guard isn't there to protect stack vma's from merging.
> It's there to protect users from mistakes.
> 
> And then we have all those very rare situations where we *do* want
> stacks to merge, and the guard goes away, but we currently do *not*
> call vma_merge(), and just leave it as two adjacent vma's because we
> used to only have a read-lock.
> 
> End result: I do think that doing the locking right means that we may
> be able to clean up some other code. The odd do_vmi_align_munmap()
> case is just one of the more egregious special cases.

Thanks for the insight.

Anywhere that asks for a downgrade can be changed to an unlock so here's
v2 that makes that change as well.

Thanks,
Liam

--6yiabyfxthbyq3ua
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="v2-0001-mm-Update-do_vmi_align_munmap-return-semantics.patch"
Content-Transfer-Encoding: quoted-printable

From 63fdf37f09cadc126b93a338b92c78b44ac6641e Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Thu, 29 Jun 2023 22:28:16 -0400
Subject: [PATCH v2] mm: Update do_vmi_align_munmap() return semantics

Since do_vmi_align_munmap() will always honor the downgrade request on
the success, the callers no longer have to deal with confusing return
codes.  Since all callers that request downgrade actually want the lock
to be dropped, change the downgrade to an unlock request.

Note that the lock still needs to be held in read mode during the page
table clean up to avoid races with a map request.

Update do_vmi_align_munmap() to return 0 for success.  Clean up the
callers and comments to always expect the unlock to be honored on the
success path.  The error path will always leave the lock untouched.

As part of the cleanup, the wrapper function do_vmi_munmap() and callers
to the wrapper are also updated.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-mm/20230629191414.1215929-1-willy@infra=
dead.org/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  4 +-
 mm/mmap.c          | 94 +++++++++++++++++++++-------------------------
 mm/mremap.c        | 28 ++++++--------
 3 files changed, 57 insertions(+), 69 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 39aa409e84d5..95dbc073b4d0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3176,7 +3176,7 @@ extern unsigned long do_mmap(struct file *file, unsig=
ned long addr,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
 extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
-			 bool downgrade);
+			 bool unlock);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
@@ -3184,7 +3184,7 @@ extern int do_madvise(struct mm_struct *mm, unsigned =
long start, size_t len_in,
 #ifdef CONFIG_MMU
 extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
 			 unsigned long start, unsigned long end,
-			 struct list_head *uf, bool downgrade);
+			 struct list_head *uf, bool unlock);
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
 static inline void mm_populate(unsigned long addr, unsigned long len)
diff --git a/mm/mmap.c b/mm/mmap.c
index 141c618847ac..51e70fa98450 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -193,8 +193,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
-	bool populate;
-	bool downgraded =3D false;
+	bool populate =3D false;
 	LIST_HEAD(uf);
 	struct vma_iterator vmi;
=20
@@ -236,13 +235,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
-	/*
-	 * Always allow shrinking brk.
-	 * do_vma_munmap() may downgrade mmap_lock to read.
-	 */
+	/* Always allow shrinking brk. */
 	if (brk <=3D mm->brk) {
-		int ret;
-
 		/* Search one past newbrk */
 		vma_iter_init(&vmi, mm, newbrk);
 		brkvma =3D vma_find(&vmi, oldbrk);
@@ -250,19 +244,14 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-		 * do_vma_munmap() may downgrade the lock,  so update it
+		 * do_vma_munmap() will drop the lock on success,  so update it
 		 * before calling do_vma_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true);
-		if (ret =3D=3D 1)  {
-			downgraded =3D true;
-			goto success;
-		} else if (!ret)
-			goto success;
-
-		mm->brk =3D origbrk;
-		goto out;
+		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
+			goto out;
+
+		goto success_unlocked;
 	}
=20
 	if (check_brk_limits(oldbrk, newbrk - oldbrk))
@@ -283,19 +272,19 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto out;
=20
 	mm->brk =3D brk;
+	if (mm->def_flags & VM_LOCKED)
+		populate =3D true;
=20
 success:
-	populate =3D newbrk > oldbrk && (mm->def_flags & VM_LOCKED) !=3D 0;
-	if (downgraded)
-		mmap_read_unlock(mm);
-	else
-		mmap_write_unlock(mm);
+	mmap_write_unlock(mm);
+success_unlocked:
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
=20
 out:
+	mm->brk =3D origbrk;
 	mmap_write_unlock(mm);
 	return origbrk;
 }
@@ -2428,14 +2417,16 @@ int split_vma(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @downgrade: Set to true to attempt a write downgrade of the mmap_lock
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
  *
- * If @downgrade is true, check return code for potential release of the l=
ock.
+ * Return: 0 on success and drops the lock if so directed, error and leave=
s the
+ * lock held otherwise.
  */
 static int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool downgrade)
+		    unsigned long end, struct list_head *uf, bool unlock)
 {
 	struct vm_area_struct *prev, *next =3D NULL;
 	struct maple_tree mt_detach;
@@ -2551,22 +2542,24 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 	/* Point of no return */
 	mm->locked_vm -=3D locked_vm;
 	mm->map_count -=3D count;
-	if (downgrade)
+	if (unlock)
 		mmap_write_downgrade(mm);
=20
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
-	unmap_region(mm, &mt_detach, vma, prev, next, start, end, !downgrade);
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end, !unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(&mas_detach, start);
 	remove_mt(mm, &mas_detach);
 	__mt_destroy(&mt_detach);
+	if (unlock)
+		mmap_read_unlock(mm);
=20
=20
 	validate_mm(mm);
-	return downgrade ? 1 : 0;
+	return 0;
=20
 clear_tree_failed:
 userfaultfd_error:
@@ -2589,18 +2582,18 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
  * @start: The start address to munmap
  * @len: The length of the range to munmap
  * @uf: The userfaultfd list_head
- * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
- * mmap_lock
+ * @unlock: set to true if the user wants to drop the mmap_lock on success
  *
  * This function takes a @mas that is either pointing to the previous VMA =
or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
  * aligned and any arch_unmap work will be preformed.
  *
- * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ * Return: 0 on success and drops the lock if so directed, error and leave=
s the
+ * lock held otherwise.
  */
 int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
-		  bool downgrade)
+		  bool unlock)
 {
 	unsigned long end;
 	struct vm_area_struct *vma;
@@ -2617,10 +2610,13 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct =
mm_struct *mm,
=20
 	/* Find the first overlapping VMA */
 	vma =3D vma_find(vmi, end);
-	if (!vma)
+	if (!vma) {
+		if (unlock)
+			mmap_write_unlock(mm);
 		return 0;
+	}
=20
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
+	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
=20
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
@@ -2628,6 +2624,8 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm=
_struct *mm,
  * @start: The start address to munmap
  * @len: The length to be munmapped.
  * @uf: The userfaultfd list_head
+ *
+ * Return: 0 on success, error otherwise.
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
@@ -2888,7 +2886,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	return error;
 }
=20
-static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
+static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
 	struct mm_struct *mm =3D current->mm;
@@ -2898,16 +2896,8 @@ static int __vm_munmap(unsigned long start, size_t l=
en, bool downgrade)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
-	/*
-	 * Returning 1 indicates mmap_lock is downgraded.
-	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
-	 * it to 0 before return.
-	 */
-	if (ret =3D=3D 1) {
-		mmap_read_unlock(mm);
-		ret =3D 0;
-	} else
+	ret =3D do_vmi_munmap(&vmi, mm, start, len, &uf, unlock);
+	if (ret || !unlock)
 		mmap_write_unlock(mm);
=20
 	userfaultfd_unmap_complete(mm, &uf);
@@ -3017,21 +3007,23 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
  * @start: the start of the address to unmap
  * @end: The end of the address to unmap
  * @uf: The userfaultfd list_head
- * @downgrade: Attempt to downgrade or not
+ * @unlock: Drop the lock on success
  *
- * Returns: 0 on success and not downgraded, 1 on success and downgraded.
  * unmaps a VMA mapping when the vma iterator is already in position.
  * Does not handle alignment.
+ *
+ * Return: 0 on success drops the lock of so directed, error on failure an=
d will
+ * still hold the lock.
  */
 int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  struct list_head *uf, bool downgrade)
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	int ret;
=20
 	arch_unmap(mm, start, end);
-	ret =3D do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
+	ret =3D do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 	validate_mm(mm);
 	return ret;
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index fe6b722ae633..11e06e4ab33b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -715,7 +715,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	}
=20
 	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
+	if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false)) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
@@ -913,7 +913,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned l=
ong, old_len,
 	struct vm_area_struct *vma;
 	unsigned long ret =3D -EINVAL;
 	bool locked =3D false;
-	bool downgraded =3D false;
 	struct vm_userfaultfd_ctx uf =3D NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
@@ -999,24 +998,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
 	 * do_vmi_munmap does all the needed commit accounting, and
-	 * downgrades mmap_lock to read if so directed.
+	 * unlocks the mmap_lock if so directed.
 	 */
 	if (old_len >=3D new_len) {
-		int retval;
 		VMA_ITERATOR(vmi, mm, addr + new_len);
=20
-		retval =3D do_vmi_munmap(&vmi, mm, addr + new_len,
-				       old_len - new_len, &uf_unmap, true);
-		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		if (retval =3D=3D 1) {
-			downgraded =3D true;
-		} else if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
+		if (old_len =3D=3D new_len) {
+			ret =3D addr;
 			goto out;
 		}
=20
+		ret =3D do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
+				    &uf_unmap, true);
+		if (ret)
+			goto out;
+
 		ret =3D addr;
-		goto out;
+		goto out_unlocked;
 	}
=20
 	/*
@@ -1101,12 +1099,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsign=
ed long, old_len,
 out:
 	if (offset_in_page(ret))
 		locked =3D false;
-	if (downgraded)
-		mmap_read_unlock(current->mm);
-	else
-		mmap_write_unlock(current->mm);
+	mmap_write_unlock(current->mm);
 	if (locked && new_len > old_len)
 		mm_populate(new_addr + old_len, new_len - old_len);
+out_unlocked:
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
 	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
 	userfaultfd_unmap_complete(mm, &uf_unmap);
--=20
2.39.2


--6yiabyfxthbyq3ua--
