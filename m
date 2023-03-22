Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A56C4F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCVPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCVPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:36:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9B532A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:36:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCXrbt010873;
        Wed, 22 Mar 2023 15:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ANBAZhoqXHJagtWWmTY/sr9t9rdydVwMOzpnKHJe6mA=;
 b=lX0TNO9x+IjyftblCvoU4BGdLwT14OGgFypjuqPdfusmqhuFTG+1y3KhGGTSaIrvDEfD
 S36Fs3fp840C+B0m7Lc9G8ErIRRLc0uSj8Gld0oJ9uRJKPNaYTnGfU4FR2+hKsda9pw6
 pn8Fl81mg9mbzN8qSWcZxXVdsYrYkBzDAM51aYdgwmrYZIhNxfJJq5Szboe8A+4VfsoN
 OOM68K57ikibDMkXKF9Bs2ot+Y/3lfsKAtnx8LnnlMlv2J9ktW2gt2pxu3rgnsFa+yjc
 VCk2dFrX6ptNmNIH3SV6y2vtQ4ah+qKJz+QK493KjbdrdE0P7fRzUubVWO90uilBugTx LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uuh96f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:36:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MFNquJ030381;
        Wed, 22 Mar 2023 15:36:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg49egfua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 15:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSkypCNZFp7z3PopYnrAleAsZtIdI/lUjEkj/CD0xTar0haqsFKG3aoOqyOsfUHTf0je5tyRsoYGIjiI8PC5R1zLtH9D7w/MXoMLc7ZTMx+OwTOrIY7NUcRxs/Y4I9GkWjq+LtlZhh2hUy8PkVNdpm0ZimI113NZ4cxwOpHD9QnyachAYUjZfo6Udt0y4NSM147Si84oBowQx+qBQ5hL39kYUWlLXijnUSqcu3Lwku8pC0ghC6z7LUXSAGodZ7yppZ8y5PeX25aqbhH4+okGK4Z2zXr9W3Gav7Kjh+xVj2fEJ4LX9A4s65JsMKeAQfpF/tiFFdVHAmxfYppcxfumAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANBAZhoqXHJagtWWmTY/sr9t9rdydVwMOzpnKHJe6mA=;
 b=DhcBkpDXji1/jvXZ3vYaP5ae8hLE0OwxpnOmwTxdH4jGpX0w/pZcELS/1zxPGF36YVlpEr76jieK1h7EymLpVlEx1+XMQFP+nX3ajkVxqvwL/20sijimw7SdPgQyzeBmOAFPqiamE1JVJJZnlZkxj0H85zx+7xTuS2+IK8nibEvOUhzMEaFrhVNmwX3Z9zkcgStVKZXNjeHnF/QLk64RXCIg2gSFCguoUZz0wpjwgWUwwCwxlW8ciwFNIkWwuaAGTDQXIioxfBj2qTUrXRxeWWZp3PF2Ph2ekx9RXbP+bYAyKGHd1XoxIVo8QDLBG1uc0QWi05Frdox/tgKYmzL4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANBAZhoqXHJagtWWmTY/sr9t9rdydVwMOzpnKHJe6mA=;
 b=bLOY5SwkbdWeBvK7MKzA8YGNoF4aqLhmlNBBxX6tCcmIwaJhPLnFaZTUyvGaBMeL9DGstDDpsWpbDMDeYHjOm7AOgc1UdRS0pDjTv7q2kq/D4M72uUn+BGJVSwaoTDyNF2xXwoZVSq2G4RPsXtijd97tiZZcMdOGQRCCI290jpM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:36:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:36:08 +0000
Date:   Wed, 22 Mar 2023 11:36:05 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v3 2/4] mm/mmap/vma_merge: fold curr, next assignment
 logic
Message-ID: <20230322153605.zfljuuivrgvdpuja@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <36399b6cdc843eb7fe243488ea9b29464f699170.1679468982.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36399b6cdc843eb7fe243488ea9b29464f699170.1679468982.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e85cea-d3e6-4927-6f20-08db2aeb2874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0Pnbb0NGxo/3zAgvmj5iGZWQDBy68OlxEyOgqpwaJ/GIFVWxaOW71wzaI3Qbvd2FzLSGrFWyqJ4C/zThsWKyn791WD2EFxd4divjW1B8hRqyj3Wqxdvr78qegUkC0OZ2ncHl7PsEhEpK3l0NdDkuKxLZmmdCsj9sa/SKIRmIPYZhxT+Q2MR451v+4dB0XluqVj3Dv3IYgor/3tL0qVRVemdvvUvluIRys0h4jhPHbBtncMuu9ss6V4Nwv90vysQixeP4QVo3LJUr9qGlEs40DyuaIjGg4AbaKGu8QVS1P1NboEGt5Ne+QOF0tiavjkR684Kbs1fnXYW1pDTf6ZFG4g0uHSRDrnC/xhmpaC5lCIRd3kkkVT5YvRNg8FdAaKtaPvA+IT9NnHFskONw8yuUgGxM0M10ay1+J9n+L6QWans9ZenRiY2l4SIRsB95poC6pqx/QMrded5fbn8rl7OikTS2RJEmChNAF8NqlPgvt/CnYDuda2JWTR/xPuT/rimAr8UJ1OkgGymt9U0vvIOd7TI7LeykgVcc405ibA2gWvjUrHEcjUjLN8WRd1Y6T11U2wiPs4m36Oi30OJ7DVdaOQVUA6Uav+M6tEWrgHBEr5ZcF8kysyghog6FliFTagdHMomXoADF+fBq2J7Yh0YMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(316002)(186003)(54906003)(6666004)(38100700002)(66946007)(6916009)(8676002)(4326008)(3716004)(478600001)(66556008)(66476007)(6486002)(2906002)(83380400001)(41300700001)(86362001)(26005)(8936002)(9686003)(6512007)(6506007)(33716001)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWuvm8ZGYDXySOBd4yF5buquBE+P5cpyxIEmOYq+sgRXLy7pyCILVib9QGw/?=
 =?us-ascii?Q?w31PF44cQtlomzhfVH7h2pTfGpbTpRvgjQrsB/0U3sXoEyxkQly7ZUVjtl5K?=
 =?us-ascii?Q?okywAwFQo+YR8Eb+cLYyICyZpq9wi3P/eEAem5NOoPHfpYzg7t5zyoMwFLm5?=
 =?us-ascii?Q?X1hYKVx8ipI/AO7lKf+I/zzNOnsaBZ+2cf/epDnd2cXhFCYgbJQVbFK90EEg?=
 =?us-ascii?Q?4n136NdH/yZeBe6uLqrVRSV7VP93j46tuEuA9ajXVCGo/ChjYcKrPjkrqikx?=
 =?us-ascii?Q?d7EA2WrlgMyWQfuhRyBhvEgutF+bNAsR/4g/PsNVQ/SNu2NXwpKfXFAF6jOx?=
 =?us-ascii?Q?S4VCpz8y3BtY8bSJHatwl62Y0p7z6tTSUObZFCGQ4OXXmQMBY5/jJxYn6aBC?=
 =?us-ascii?Q?v5G0HoFY8aBXoDcJkP/Gl80K8KlICBOZXeMlWsQPxl9mbbivrFjD1r0yO2P3?=
 =?us-ascii?Q?Ti0HaRDar7FNT3qHQMXkq4usfUDTq7a5F2kfel6k6hMXGa7TZLbQrzMv4O3y?=
 =?us-ascii?Q?kc9BJNedqWOPxF7Q3PBZQmN7jd9T7evyvCq07xUQBA2w9LMxxf3Drp783Zp6?=
 =?us-ascii?Q?PzzOO9/gw2gqwaXd7l690RvqImSfwG+epooS1zl6JhcICDVBfbhJeMLbLCSe?=
 =?us-ascii?Q?K1LkSSzFu/YmxoUJJCmJEkGFWZHE8Hs9MyJaMtt4+1CRk/FNwDpUbFjQq9yE?=
 =?us-ascii?Q?CwWcS59ozyKw06Zzp7HKB947Mf0xMSJtpu3u3M+ntX+Ma3/9nDkIU/iCBy0N?=
 =?us-ascii?Q?ZkjuK/llc0HTRHfE+GHgLC0eFNfZqpW6HcOi2tmfkbho5K2kjKiqdffeg4PY?=
 =?us-ascii?Q?bfVsnd7n4soLWS2q0qPe2VnGVStjE2/o4I6B8BiaXk/oK94gKcIUBhcdYGs2?=
 =?us-ascii?Q?wQ6GEBE2Ld8ByH7W40uHcI0Q0V4GUNn6IoL8v4zD3lXIIaAEMpOnCu50KC9U?=
 =?us-ascii?Q?5WLZ63AqyGR9A5T6yDyS1/4cZFADXwDCY2HDZeCsbZl/vIDyWPr2JPjO3BHh?=
 =?us-ascii?Q?KRBhN/Hr3oJV6e03P6FTfNPsmAL2X1qB3B6SsnRBlu/+NrvnC0XLUDnn+qrY?=
 =?us-ascii?Q?I/TfxL6AIfQ6o82TWZza1qM8y2wUapUDjXN+jFG+0q5rcR6NHFVtv0UbZS06?=
 =?us-ascii?Q?drJtLGiW1Evr+ll4cQZXstNZhnxUqVaQnzP95m8DCoXOdsetsup3ZzoityPC?=
 =?us-ascii?Q?zzn+YCM8mvN0FZamNe+6RoeGgS8Pum5bX6aptpOvxnardYUtLIr4g1i332Y2?=
 =?us-ascii?Q?dyHp1zYsNUnjB0PLnCV5wUn+1uyLaP27JfwbQ2pvPtx1YPLm1/u8b4euB9L4?=
 =?us-ascii?Q?PNhLAU6mpiVGp0IyIKx1b67lCEjg6x5EovOt7MRcMK6fcxSvxZmx6GnFR/+F?=
 =?us-ascii?Q?OfvtmkCB9wqcmAYZDiEAllupPfpe5vCmQiQOcfBhnNJXKAex2xFWtpy5tYDL?=
 =?us-ascii?Q?8OxSTrSTeh7HFqqkMT/2vK/Qpp4fArjx+x+/7K2yz35bL4rd9BATDrpbSosG?=
 =?us-ascii?Q?xVXEGdrrO8ie2ppWtSp3mW3waJ14ImUkT3VQYAkhrJheZgLcS1eIrRG05Oj6?=
 =?us-ascii?Q?NHe4CbuQ6OUWdj+qqx0nl5zF1Ski545uBuL3gipQzBSPQUwq67Mi76qTC+i4?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9d4WLFh4tdVWSOqTb7b1A8GRVxxzsok8uuwQaRMcXATHoH6aofLI2w5TetYk?=
 =?us-ascii?Q?uOipnaRPWIuxM2jgLJZnj3PE3EYIh3Iiipt8vnMtna9U8zONvMbrjSbzHwCG?=
 =?us-ascii?Q?u+6sZtGgOdTVXJio97Ny1XWte3+aY5beKgzYtafei5YAzq3CY+m0qt0vW0dd?=
 =?us-ascii?Q?csWMUNheBeSRKvLgrD85vp3pwJ8b1ERQzbmklXiiB/ZErfL3zS8pZIskWNE0?=
 =?us-ascii?Q?70oEomRESDViHIOHIkRf/tEx6oHKji9qjZG/6plTVtwfUTGHo37nbQR7dvvY?=
 =?us-ascii?Q?cAUQicSszcdnk844700o+U7gogIkYTNdfbZAUWxnc1ISU7rdNJiIlsufxOw3?=
 =?us-ascii?Q?R3whT3vdWdeSRiSlgijYAetdFE2M5Ez1JhVPLjiBQ303KDd2qSWT2DcbCQdd?=
 =?us-ascii?Q?7sU7nGsFDd6OlIPR+H0p9SAW8Ciwf79IGbG901sLWfTCfu8D2Besc25N2E/a?=
 =?us-ascii?Q?ON8UmgggylatvNMzH4EWGAyTI6MkWnE149Uy5iESn91xHT1IdsvuPWFzzMu4?=
 =?us-ascii?Q?HnrOi4QWSgES1twn6ZpWTYUFCbAq0cdJH4eWAQhD83a13oAoagH9AKYuiZY1?=
 =?us-ascii?Q?s6tFM/0ow5INACbViVusEy2BRYMijKM1yGk1Fl/EUcXuAJUqbyy0YRtG3EFF?=
 =?us-ascii?Q?ikmQ7wZm6p1Wlzvlpt3K1J05lFaIeCqfWp2Uw7BnNIZr7y1DPnV/c+C/9iTA?=
 =?us-ascii?Q?UZHn+TrwKhciYXXbnRJbjiBtK6m8y/TRbNKTZ34/nnnSLI7m351iCKshh119?=
 =?us-ascii?Q?UCevKbnATCOkBDMX6Yppg+rtisff28cit90cCefelz8hHJrpoE0YBe03q82C?=
 =?us-ascii?Q?uyx+5gxWUSdJSFWHQalc/UlSPoQYYCTpxluAgxDGydcoU1b/lrjS1oM2ffJO?=
 =?us-ascii?Q?W/VEBg59BkCshZgjddlvBlKMruN3ZXBVnQjeewjmqn8XSu2duKdYgsduL3BU?=
 =?us-ascii?Q?QLwhMLK4vJUUN2fbSsq3TAjSYk39yWGZ5bxV4IDP2MtRPgZ2y77nEs3shOwv?=
 =?us-ascii?Q?TKRF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e85cea-d3e6-4927-6f20-08db2aeb2874
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:36:08.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+uCiKdf74h+C9qLwJkZtDSqjUk+8Pdefy/090My11v5e+hG3nyYlY5aI0cZCp8sllwDbJGzkxgaWj3Lg5Yr5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=949
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220111
X-Proofpoint-GUID: ZIEI-pM0nvQf18UzZrNHPB-4URuRQJD8
X-Proofpoint-ORIG-GUID: ZIEI-pM0nvQf18UzZrNHPB-4URuRQJD8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230322 03:13]:
> Use find_vma_intersection() and vma_lookup() to both simplify the logic and
> to fold the end == next->vm_start condition into one block.
> 
> This groups all of the simple range checks together and establishes the
> invariant that, if prev, curr or next are non-NULL then their positions are
> as expected.
> 
> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Nit below.

> ---
>  mm/mmap.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c9834364ac98..dbdbb92493b2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -930,15 +930,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
> 
> -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> -		next = find_vma(mm, curr->vm_end);
> -	else
> -		next = curr;
> +	/* Does the input range span an existing VMA? (cases 5 - 8) */
> +	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> 
> -	/* In cases 1 - 4 there's no CCCC vma */
> -	if (curr && end <= curr->vm_start)
> -		curr = NULL;
> +	if (!curr ||			/* cases 1 - 4 */
> +	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> +		next = vma_lookup(mm, end);
> +	else
> +		next = NULL;		/* case 5 */
> 
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> @@ -959,11 +958,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  	/* Can we merge the successor? */
> -	if (next && end == next->vm_start &&
> -			mpol_equal(policy, vma_policy(next)) &&
> -			can_vma_merge_before(next, vm_flags,
> -					     anon_vma, file, pgoff+pglen,
> -					     vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(policy, vma_policy(next)) &&
> +	    can_vma_merge_before(next, vm_flags,
> +				 anon_vma, file, pgoff+pglen,
> +				 vm_userfaultfd_ctx, anon_name)) {

Can this be compacted to less lines?  Pretty much the same thing
Vlastimil said in patch 4.

>  		merge_next = true;
>  	}
> 
> --
> 2.39.2
