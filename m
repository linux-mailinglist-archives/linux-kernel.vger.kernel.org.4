Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30574933B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjGFBl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFBl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:41:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C10122;
        Wed,  5 Jul 2023 18:41:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365N3qjE009596;
        Thu, 6 Jul 2023 01:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=A/UiHb+XJRCCar59xa74ryynnTovMNMASZLNtObYJuk=;
 b=efF/qSl450rzIOdiSJh70PbLT1nvednixZJHl+QtOJF2wPzz9fCA1+WrT8GbKSf5Fc2o
 AGvao7aHHaZPzOQcVwzKGKtiACjg8Umb0mnTZguA6k/Q0SEo8fSBkgJ4ges+X8/urs8f
 y0HS8uWU15is7LjXJkwyI9qBXNuKSQoRljeivekTv2qDYMgu4kpg5xD/LCGq28Kw1bNq
 Ntrxs1OvN8TO5uWidhRR3u+M/gOSd1goP4v5umpo6S2JQJg4puSvmjsziUCKVTJL6tUG
 4cbMzLR3ifZ0QB4xLycg7seuFQkx8LLFYE3EjiXEx7pnrY/yjZ3hMVnOOpRvdXLke1fX Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnd8q8n3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 01:41:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365NSaEg001805;
        Thu, 6 Jul 2023 01:41:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakcbqaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 01:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHwPd9cVEZLP1ZUOhezXQKYtFRwze9uJkz6qqW8zxoJE/AdjzKEW1Dbzjp6JD/Eyc++BFInisda5+g3b3QhqfZIMNN/1q5JmEQH+V4mjq6SH3j491fei5MGDSAYahTRZNZhuoEJK6vtEF+/iEgDC/Q6EnSb1WedFiZ2p06urHg98ucSe4BwESYftsWtykaDp8uPCdzMJ+6I8EWKCThEXSHmSx219Bg7QnT1RMwh1FLhvN+gRhq8YYkbtjX+3+1IOXKOTkDOI9qqCl/ktYcgeDGI37TYZS1FBp5daOPOZ+3ByO6p9g22ZhMTNY8+blwPTs2foBnXU8CgNOfrnWZf7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/UiHb+XJRCCar59xa74ryynnTovMNMASZLNtObYJuk=;
 b=iWoTtxUTdO0Pn6a+f0fNpsJaL3hxPp0ooJpqdZ+oBwXHnPtch1xby44VbiT/jJOw0z2llBzSGC8IAx6zr1Lyv2MQVgOpI0n7CWhmMxX+6siZEtnbZJC3a0H/KI1FDLuU8qh0gAQ8Obpj/bKOSI5A1pvdnAUdOQ/Th1CIYmCilTlrP/Ald3rAarHkcKSt/GIro9E4uBL2oZwsNwQJkb1dK2qAb6iFP0KHiY/Yrj4BorD2xdbT9yYGMD8FgEJamjRjwGOd5iLhRjQhsAos7ZUj/jxvG+F7RSObf5Rn9yBYMRT8EavxRqW0ANlbA6SHjwuFK7RtLvKWE8O/AZ5Upy2ZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/UiHb+XJRCCar59xa74ryynnTovMNMASZLNtObYJuk=;
 b=sRtl3R0s8EOSWCsxpbM5cVM9okpb93abRi6ryP4C7MEgRuS4tzq5TDPON2sQzisz5ufMs3/LFudQY7HIE/NnatSn5vlhipTERJacH7wBRqsddysZF6K0oH3/s+6o03lJ/skb8HObVv/tMaowj5KoCKYlpXLjP3VztOs1fi7qp1g=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 01:41:08 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::9f29:328c:1592:d5bb]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::9f29:328c:1592:d5bb%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 01:41:08 +0000
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH RESEND] scsi: ufs-mediatek: add dependency for
 RESET_CONTROLLER
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edlllsus.fsf@ca-mkp.ca.oracle.com>
References: <20230701052348.28046-1-rdunlap@infradead.org>
Date:   Wed, 05 Jul 2023 21:41:05 -0400
In-Reply-To: <20230701052348.28046-1-rdunlap@infradead.org> (Randy Dunlap's
        message of "Fri, 30 Jun 2023 22:23:48 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: c06fe6a3-7bbf-4042-d4c3-08db7dc21211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0qvZE9kv5loiqxyok2K0V4NBcOtI72eQmUYyEuRYP/HCFmQX91D1lKZrAr4KKZUOLeIwAUuDGELhF9b/OHAhUqcGqNs/lB1hOZpEk73JBkmJ2JxyoWoB3wRhlrKQtMezU09vs6t4aseakIHByPoAio7NcQW4HcUOgB/dlpB5ONYZmK1SpjxSwD4HVt1k/nSNGZBemRz/EXHBvX1kbRqo/1YnHDwPTd5Hyx7Z+xx5iqQbLIO1PsoG9VYHmkhcDW+ojvt1UdFLNHmZDaWNTpItYw5H7o6JalV23jBJlbWaf5N7pO3VHhnRH7Vg0qUo4ObELe78C8QuCw+DPfrJ8CcMb2fsx8X7TAUG8l3TJzGAGYtJDvtNP/GJH+QeX7jONfVbW0MJDtcOxF3cYMJ+8HFb2yEbDVLyRzl9geFk/Eivs8jPT9DIJrQnNw6jJkiB0ols09Z4fVEGCzl4AWr8VpYIJS71FlhhXedqxgvk4MwBuy8UCz0hMumYx35Qw4QWLr8N7CTTNCdBvXEtKUOoBaFVwMyOJEvt93LslW1sJFGIPRv8lZVN61A4DxqlODg8faF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(66946007)(26005)(36916002)(478600001)(6666004)(6486002)(54906003)(6506007)(107886003)(6512007)(66556008)(186003)(2906002)(6916009)(41300700001)(66476007)(8936002)(8676002)(5660300002)(7416002)(4326008)(38100700002)(316002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVQG9AncjSTK9C7lvn5YKkWPwhJEGvPRno0MA7ollXy1bG5R9s2sw2CuUwHm?=
 =?us-ascii?Q?DqMKDHxNcF2lyJt45FSdi74I3vKaSbhIMZisMvA8skrhJHFJxPBX+YZPZukL?=
 =?us-ascii?Q?T43YQ1TEPZ6z8dXfWxJe8BCEKwsotKfcKMxx3u0kZfx+0xDpNwvo5PTsXUs8?=
 =?us-ascii?Q?4RaXzV83jLuzplK4K+vpxwPS0Q+olU9KQE8syhJ/uj1Vw0kgK4i/6UBGD/hC?=
 =?us-ascii?Q?VLyj94F8ESR1qcUlK/gbEH15vLc6Nt24Jib21BavN2PFbZvQqXNQzN8xFo41?=
 =?us-ascii?Q?xKrySnTKujdX0jmTbjSgiZ3rBKuZW1MveootfHxnLJL25WJ1TC5m8ZCjj/dU?=
 =?us-ascii?Q?A/A6XwdQR/ComeJFjc+ZR7fx0oTQ2MwErV9YwmdAhbFXejfbX84hMF9e76Fn?=
 =?us-ascii?Q?V7j6/VfHwhlby1wglzZIqmrAg4yifCuR129J5+HhePXoVTyQkqUHJJRif2B3?=
 =?us-ascii?Q?h5WD+Jj6AaFwa9jz1F2nkHZXVGzk2zgNCZShp8GeU23LGCMtstlqpc9Cna24?=
 =?us-ascii?Q?0/cxNa2B99vSbzmjPNewFuFnFRqs2nv+Fwn22PeqUcytN9yP39/hvNYbXbCM?=
 =?us-ascii?Q?E6dRcrnOGdL18C/crSYoqIRpQ6TLaHLWry5EXKbDIb1TMPTCPk7+UBVW7j5N?=
 =?us-ascii?Q?bft7NpFpAD1vvDUFPasl8CSRzhvG6tFjiLGPzORIf4TlIgH5kfgUJpUc/5J7?=
 =?us-ascii?Q?/TE1NyG7asZAB/jd/Sd3WnvIjf6b9jZ8lgEXect7s+wdieAuNR4Pu+I6cqNZ?=
 =?us-ascii?Q?UuLLahESRhEcEU7HQYFlOHIwSsv3UW1yqTVy+bQ0QN8T8Xo5GCQHfnz5JpzG?=
 =?us-ascii?Q?IYSelTrogDdXiGeEPcef4AOciG0TfR9XPCYshCyCJN3pOTs69HAeOFZSkeRs?=
 =?us-ascii?Q?dWojKIVZc8Jy8JXvuHeagm6abC0FnpNKwGN7eZHR1z3ViHQJw/bpRxNm9ALJ?=
 =?us-ascii?Q?YU5ifEFH+qM6elWaVD3zN/XHAMsQ9HolaZ8ETTShl7y+rgI7eAD3XqQ7IhpW?=
 =?us-ascii?Q?fADK1D25jUw61rpNtUotxWkXmGIWLExnJVPJgnvbG9frk7t3WcohzLlPC4lX?=
 =?us-ascii?Q?6bPbeRifvPgPE/X4zpBPyZ9VE08yKmO70LDsg+Kwa9sW9IZ5j/GQWm5cErof?=
 =?us-ascii?Q?ZOutJqO7fgTi8OkJyDS1DvcUiCgwyd2lAPyuObZKBniD0Bmeq/8tfLkLxf+3?=
 =?us-ascii?Q?yCr8L1aN+UH0b1C87h7P+OuTihsnbKI5TP/syc2A6QViXnH3d94ZlRign+ds?=
 =?us-ascii?Q?pdpJ/75CQ+dPDtYpTc+VPUX+5oLQ/f7SUUSLTw6nHRzuITNRdDbjMiVebfTB?=
 =?us-ascii?Q?5vsOQznB9a/m8oOKfT1Hqq2Uw+YTv/BKvPSQ9VdGMo5ix7kN7mwkO0pWVed7?=
 =?us-ascii?Q?fNKs61Uemr5UNvtGEnJXSNgLo3e8yay1jc2siCYkgM3Sqg1cOGZSO44xbhl+?=
 =?us-ascii?Q?NyM1K80qo0OrVTHtsf9z7e96/9M/gxN4QpQTO+CMaYMlx+7Lhbc/V0TBgwoK?=
 =?us-ascii?Q?C2UuhovQ6/rxjYaMtt368RwPZLUTbFF2dmJkBhy1gAydahCLy37kq8SBd85C?=
 =?us-ascii?Q?uC75zYuwPhy2IQHmuX1736dJjUwATemwKQYoYJ9OyZd9tZ6mzNzrh6oBD4nu?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MHXaqyY/E4Wvzeg7R6BNjhhH10kkautb2k/AtUl/29wkLWrKzGvmVCqOebU+?=
 =?us-ascii?Q?yK/jKI0TX1R7E9DPU8F2CqOfQgDrTUL1JXRPAi5eiPup9sXnJ7zQE1dTwlZI?=
 =?us-ascii?Q?lZwDD4lihyS0wZ5SsRZ1jWGjSnpLSfO130hHIgioahxYTXQsxY/qu+fr+P+f?=
 =?us-ascii?Q?R8uXkp2AmsWpzu7RgkE2FQGV1nMawLNufg/a7OoLBKqz/5QmpBBctPrgug82?=
 =?us-ascii?Q?bMJ4b3d1LF3Z+rSzWVYrOTkyQ1xrEkj77vjdUw9dyU4MEPb7aVk67/avJjjZ?=
 =?us-ascii?Q?RUHVGwwR75N5YgKmK6n7PWaix9O5uah/eaf1w/jffE3sz6Mryo1a0KF7KJA2?=
 =?us-ascii?Q?yPUQmYHpo4dpbacPvbHCoConmNxjJE2TMj3F429ZsDS8Pu1oxT7/cfPc+Ay6?=
 =?us-ascii?Q?bGODGRA2RZYWhbTGH0P5i9azmbPTAxaZt7AOnT3W0yg2w9QgA1xHJSf48lu6?=
 =?us-ascii?Q?uIrSIvjzwZz4N0Uokcf2aAOek2RWpbp2WSgL8/9yyLgdxabqrgPpfk5nB2t7?=
 =?us-ascii?Q?ulYWvXx4WO8B+fqXOVlA868uDFTdQvxvE+hETq9HgzPIm81p1kIZlWaPZ7b4?=
 =?us-ascii?Q?SaG1Rra89pkyKsxTpJ4GzEpSwLL7ftsIzM+xz5Y8A4EaTr1PrJjymZeaNOol?=
 =?us-ascii?Q?R4Z+GUxmR17ubjXCf5dATkoUwLHSsQtTO5Se64mq25FwGZ/H5BUvVRha7Q1i?=
 =?us-ascii?Q?KscirYJx0CJYQvuHCmzZTv91T8MPmUKwu1Vth8FKcNgTGmDO6XccjToybxCy?=
 =?us-ascii?Q?YLWcQ2wRb/hjlyCsoc3bkS0MtqO+7kI5K6wZw2whtUXjU1sNfD63IcuiXWKn?=
 =?us-ascii?Q?Z/yB7HPPIIFxHw8C6lRWog6gnLkS2wsA2pN/F290XwYpBA70/YMOa8dQqDyh?=
 =?us-ascii?Q?lZ1JhNL+7VoJLnplEKrtvPsdA+6s0qnuuI43pkAwwgIGChu/PeFZ2alYQ6y/?=
 =?us-ascii?Q?DgGKeeS9t0S6b/xMWOjS3a7ud9f9ykAyw+SWOMfOD0KX9fozZcVwatKTvWuT?=
 =?us-ascii?Q?2xX8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06fe6a3-7bbf-4042-d4c3-08db7dc21211
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 01:41:08.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bfgghAkfu1jg0xoVMW85DoY2erL2Uj/f4aRNeBZIhzcx0r0Lr2rTODCnjWTZOFaHRNXjIiWjsRJek8q8eoz5yga1UFEOvtH51AgHlEJmAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=787 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060013
X-Proofpoint-ORIG-GUID: cx14pfcTugJA6qE4oSeYbrDsIq08JRpV
X-Proofpoint-GUID: cx14pfcTugJA6qE4oSeYbrDsIq08JRpV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

> When RESET_CONTROLLER is not set, kconfig complains about missing
> dependencies for RESET_TI_SYSCON, so add the missing dependency just
> as is done above for SCSI_UFS_QCOM.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
