Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD54E6BDF81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCQDUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjCQDTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:19:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BBB6EA5;
        Thu, 16 Mar 2023 20:18:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GLIicC030638;
        Fri, 17 Mar 2023 03:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=MUtbC+9uoKHv/Ivco9H2nC6xRxK9M6G1hcAQDlg95ms=;
 b=FayczMdSR6iitBXNTAU+2sUmLI5OfNbYQ/N3WaADhoZiZMKyFu1unQYzkvoLOmTYPTLI
 eGJbonXR8mkpVoQ+pFcjoqskc0Hb3XQwS8/LMlHhz0LBBSeChqXkBUvKuI9lH4Jil9Cm
 ee/b2F5aFC/PsLuvls+bGJMsi9TpvIj7dZcAsXb2A+ewDswHf2ZuKfkLFalFB61Q4Qrp
 kXzRjUSjZLKReQ9h1Urasot0ecY1td2Tv7XwKTjZZA8DUDp8PlNhOWUfARJyLxSPITtz
 rS1Wz1awKzxZTTp3T7NfmW73KjKKR0OGrSYDkoOmX+YAfCVBBigtQfl4lyYMWzA/BEMg YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs28jxg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:17:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H2qxdx003231;
        Fri, 17 Mar 2023 03:17:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq45q211-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JamtGWFY/6NfrmVeDPf5L3iGIgPIJxUgBzgoUtNSMFBFDk5QYv0vHWXZxB6VVNEULfzAjKKBsv3sjO+XiD7X88MaO/BJIG8xa/gelZ6jXc6w28Ku9oHZVYyax4VNMUEIVeek+5Pti0hFLzCXGRTThF0n9x7JyyoHUMfOR8FXzHdZftN/jXHo9TGrTRVLOU8IzNok4ASAEPulcZnor8M9999w4+8lREwFXTA9movebexa6PAiZ0OP/ZP8MVibuZWKqbDUMbFtvFwniukjnNgtwLlEKjEt5mQLEKeYiFDAW0Ysp/x02V21oD6exJDtDLWKlcNy77sT8x3uJ/g2TcOpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUtbC+9uoKHv/Ivco9H2nC6xRxK9M6G1hcAQDlg95ms=;
 b=ZrSULcqH7iPcXOPoVaxysM+61Zq6ijj6t/o3f+uYRBWkzvqu5grSgJbT5gW1KI0V0cKzB+TWyQH9JRHHXiDjuTQMZ/oZLleq+DFSGYsTz/QMTjkd+W83KAMNebN5iwl9S4z5dvHRhTHZRP3jvO8WUEnqM06aBoS7JrCb8RFGT5NyKAPgNRVjWbzk7BOK4QzoN0nlwzPlVAOfFEnZjbfPDmZCxFyIZjQAE8NzZ/Wsn+d3+wHj180djfIHSxYJR1FeJ0Y0WFPxgZwvYY1rMbxqQytnPaTJXTHikkS0BR2w4g1cb0z6KD9seUyHgLaBMcRFFcBxsc20gBMENYBsstx3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUtbC+9uoKHv/Ivco9H2nC6xRxK9M6G1hcAQDlg95ms=;
 b=viiyg4aTBYWa6uXeh3wv1KM5B/0eJq6/Z6YWGwOfuOrBu0y8HTEzHoYVXH4AsTbmTh9dx3Jo2JpTXUq3XETZeQLgzgM9LLRiI4C1y9Estc57kNelLMq1Y7fmTgn5ApEAjpclmp5gNWI7c3dr7n/pBjhxd8fOHbXeWEs8kejHLqg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6100.namprd10.prod.outlook.com (2603:10b6:208:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 03:17:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:17:04 +0000
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v7] scsi: ufs: core: Add trace event for MCQ
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt4cxe1q.fsf@ca-mkp.ca.oracle.com>
References: <1678866271-49601-1-git-send-email-quic_ziqichen@quicinc.com>
Date:   Thu, 16 Mar 2023 23:16:58 -0400
In-Reply-To: <1678866271-49601-1-git-send-email-quic_ziqichen@quicinc.com>
        (Ziqi Chen's message of "Wed, 15 Mar 2023 15:44:25 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 179435ba-cb27-4bbe-bd9f-08db2696152d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYMAPKEv+A8b1B9tPhI0u/6BZLTHYlt6ph86aiXMghFjDbc8YZKjJLjAq4/7x7ZciKHBZCAELR1EBgYz9c+6Cip+KBuBRxWfZN951baMrSM43GUUwOF4xwTFNX+MtCMBad5FhaYoYQ4uJj9UhhWvYwYR8wJeEaemy0DSf3QBzftxgRaZVNfHPOcHDsaRNmZw2M7j9vasbq8S8gY2m4cSpMav3n+zJFw3RH2wqiRl+v1jTG2hkmSJ0AAekCx5tMfeyfv7p2UrFNtDLS8VQaPfkzZuQH3Nz6BExfCTGnI5dVvKQWMiEE5ISobrWoynvPz1EOiMD8KEWZ5dbjQ6hl82VFn3dPHnMPbHTq5zEevuyJgLISYXqwE9Kab/vRJxYxBv4lusSWxz4Ji73Ipd7pYm6gugV98kEpiggX0RU9Nsa0Rtxxr0m8LP3+4SMf6ZPOIWEzGgs3qqz3lQMu9hRr9heB3hPbkUt2cT8c5jK74FYA/z70jGLt4C1yJC/Jh/RTpR67OYTCvBXzIaNB1oQZ5ecSJCojIrubA4ariKByElt7ex0erDAk7hpoU0nni2ceiRCpkmylrdgP1IP3zGqItNP3Gtmt/SZJev8rRTXlhD19Iy91Yc3YsqzEBGMwhkFLZiYPrFFIHUb9KbPECR/yjkDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(558084003)(38100700002)(6512007)(316002)(54906003)(36916002)(66556008)(8936002)(6486002)(5660300002)(86362001)(7416002)(6916009)(4326008)(66476007)(66946007)(41300700001)(8676002)(6666004)(2906002)(6506007)(478600001)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D89JDkKK9WSxEx87F18ewoRLBmAFV8PsNErJ3ZKULJo4qEg9VovLTdzVtpKd?=
 =?us-ascii?Q?Rj0CtGBQVnV53RNFAVGOPoTHHrM91qmlCgy1kDSOv4QL0TjLFMtGZmqR9UQu?=
 =?us-ascii?Q?WfX/snD0EtuxXvbzP9ftKH52rsK55B1Xabjmf9q2djBB00lfRlaGmdi5Af0G?=
 =?us-ascii?Q?e/T59DrZwAFj95fjbvjCbueA8tSU8w+RxJg/ISgo1svoZWa8PF5Iku6uDmHN?=
 =?us-ascii?Q?ji4aRMwLdrhfPkZcW2oQa8OV5+J8TDXTFq8+dcNOMzcOZv+n66+CAvJTaw6E?=
 =?us-ascii?Q?aYsaufPaBdu+hdmJsOXa6Gk7Z0QyPEQQOUdMHL/NHvu4XuYeCCMNUrhEiClr?=
 =?us-ascii?Q?b/stmmjibeCo/9GtqHI/vpsqwOaWuGYZt8Ll6tOisqtUKlwAtUususS5Lzik?=
 =?us-ascii?Q?9koKwA6PRrCOOubVfbaImIkc447KFFLM2wwCTH4pLGQyduh0+Jp2y+XhpBM1?=
 =?us-ascii?Q?NJCnVn/3HEeq1SfuWu+mos44v9mJOUZxi3/UqWHTv25WyAidBT3MxIXLOOBZ?=
 =?us-ascii?Q?qjbXJfTwX+BmgUzJxqasimiB3JSw1+I/mVUJf8AxhUtfcU65wqZz2sN8Was2?=
 =?us-ascii?Q?/z58EqUqZslxjOkfQk7sNuqia2rjUAtZB6E8MjUawK23eUKkAhluprge+27U?=
 =?us-ascii?Q?Jw6WdDGojsCZg67BylgfEpLO43mCh0yNd/tKqx1WdzCtou0ENjByRQFWsLAY?=
 =?us-ascii?Q?wXnfd3PCwEjNsLFjBNCojkQDOHxxpyFdJWIGuflVZL0Ysmas5IoKcfcdGlYK?=
 =?us-ascii?Q?qbYpSaNFs9lL2Q+7IsD6uvx9y8pZ0yjR5gzNk6CDwQIIP2yyQesJbl0tDvk1?=
 =?us-ascii?Q?9TpgwlPMENO+vY6F2WffwW9cLn/DFAZrdh9B688zN5Aj3sCiuOQnNM2rXij2?=
 =?us-ascii?Q?rTvmR7sxNshV/sX0mNXvnCzRKYH5f70osrdUGhlKdeta2XgOXNdXsMuIq+E0?=
 =?us-ascii?Q?0auBDlHEVinaUmYSM3AiuQQTemNj8k8D/Tq7gybiDx3F8h7e+TFqA/ObRiHE?=
 =?us-ascii?Q?oFhulhgOqLkc28JsNdcK9+ZTOA91RIe6QDLn0ikBg+sPnv8QJL1hYm8BCuOt?=
 =?us-ascii?Q?GJ01khUR81FtaLJtIDShi6EOi3vDJjPn2S8IOmmUzVNqrW+sLurfrFrzReEt?=
 =?us-ascii?Q?0y13IyZn2B+JZzcDAXMb83yhrt7EmmkAieN7w6XCN2bmAja9FZ7+3BiMHMMC?=
 =?us-ascii?Q?lT4xMZorZzK5oZ0c3Qo50GDvVJ934wepTgApY54r1aFoVk8injpA6o+I8GZh?=
 =?us-ascii?Q?xo+hvXVfZ0no0ouPSZ0CV0+pbgP5k7JtQ8qxNhb9szGzRm86tGcOX2geAJaK?=
 =?us-ascii?Q?Q9hh1DMqL9THvwWSKexsJ2c5hIeGtSiEqZBcCmixtj6w29Yc8cp1yNoF/e37?=
 =?us-ascii?Q?HuLDxD32Ed4hBQs6p/st2wjozJtjtdcCGK3YWfYBS5VwP0YNXNagUu65b7JU?=
 =?us-ascii?Q?pMf/kHH7uUvRiTJpl1tgUiKfjqfbHHx2cJbwjjAJSncQJIxpxAT+xgctyxTM?=
 =?us-ascii?Q?icjJLwglZ3k0d+D0iOSnhO3pEHGm3msDAYBqNNwjVWaHaiTQDTJwQYjuwapb?=
 =?us-ascii?Q?iOWrUfBGbWmTWfERnZbPue5rvJLmAniBKeD8LJQv4mSeasMlkxy/zQAIFKai?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KsCv9I6SF7MzNLY9RA85LQKw778cLl4oC3o/QuliGokrlTkcxN07e5BgZCAF?=
 =?us-ascii?Q?WbEJTB6T/V8JEZlwEhKyRq55HIbpD+FHIUN2zguzfwzEGvRcgALP4+sjDVZJ?=
 =?us-ascii?Q?lhE5yeVlmzJi+eGk3WHS21WVh4k8cUFjdX58UbKvnmpWLF2/mW47EzwXoyJk?=
 =?us-ascii?Q?gYEcK+34jHdfLa3yQvxo6GZujl3f1reDB1qRCBnAZ0/4hPwArWwysl7ncjSw?=
 =?us-ascii?Q?dCkodN9yes25/yYFJb4LyYfNOjxSN9VJ6G8QYq3YcCFVqAwnhGvW1no0mquU?=
 =?us-ascii?Q?z/VKDGY82ZaGQPgX/khdsHPvdJuZUaWfdNj3iROr6CRRtCQKT0qKI8ZPiIRU?=
 =?us-ascii?Q?ymOtcyMEeKYQa+umffJ+N7bVqxxix4p00/yq0a7Yt5MP0skiTpn+nl65whN3?=
 =?us-ascii?Q?16GHZjxoFNMR7OfGbJxuPnGsXrCUEHQrWOQJZbHaU7EnejDjd7yKdQoeRVi/?=
 =?us-ascii?Q?DdFewAmL78YODI4j761zpHC5tW5SdSgSgKYQrWd4Yy9ah6/3OxD4uS1qMxWj?=
 =?us-ascii?Q?4nhEsheNNA8uXzhqjgbNxQqOKa4SLde+xGvnqAzHudYsC/JkrXQT5h7wYPk6?=
 =?us-ascii?Q?ba00I1BSts1tVrwtruU8hcUxBTYWWjgLodE/3E6QAGEButXYMNdNPANiNdJo?=
 =?us-ascii?Q?5XvTckea6g6rDdICz2LiN2XvmECJTEwdudT2lVKf5/FuQp/lIcvR4Wz8DV+n?=
 =?us-ascii?Q?JFacWqmW+iR6Kieg8FIzAdsZMZ4BlPWkdEo1GSqXZP8AuiUJh26kGwDzG0ks?=
 =?us-ascii?Q?bXt/j2ao1FgDrvPR4RnlE4UYrq7f/THv4176VE8ynr2zt7983THdg2VQiHct?=
 =?us-ascii?Q?egeR1c+EPoFtCRe/FJYfXB0bK8iR1U5uItLfuGiwgEVRsWctOm44ebczmuol?=
 =?us-ascii?Q?XHUGwo/EyhbhY5A1DpmjRvAPK5hpccwiwKyW1qpYDNNagm0jBKOLioQl3x8n?=
 =?us-ascii?Q?cOdTt5SmHyiMg1uerAIRJAg2aF8tPGWk2nqm2Wf9aTzaFjSTr3XI101j+zcW?=
 =?us-ascii?Q?Mjb4dvDwzxneTJyte1CAM7SO2h0pSaRjIkLHV6D4IY4AddPAtGaImguM4vRA?=
 =?us-ascii?Q?EGDOOXGR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179435ba-cb27-4bbe-bd9f-08db2696152d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:17:04.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o7sF5c5FI4sJx/DezLrHxfHvWxUSdH1G6em5AcLy8NwCph0m4IEspV9X3c85G2bW1jLD28BqWEYIN7rxZbgpnqvq3mqAfK8hhFNu08rRHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=913 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170018
X-Proofpoint-GUID: _Eat4R605Cy2QcgF3X2TNxDmOmxPULIP
X-Proofpoint-ORIG-GUID: _Eat4R605Cy2QcgF3X2TNxDmOmxPULIP
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

> Add MCQ hardware queue ID in the existing trace event
> ufshcd_command().

-- 
Martin K. Petersen	Oracle Linux Engineering
