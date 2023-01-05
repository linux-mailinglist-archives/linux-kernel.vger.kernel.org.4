Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59F65EFD0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAEPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjAEPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:17:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342959329
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:17:55 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E4HO4025078;
        Thu, 5 Jan 2023 15:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AIc75cdGTfGHDcpOA+nAXVIZJLskQhQr5iCkcEIv3kc=;
 b=nUF8H5OWxFG7xPZ5G8NfJxPO0fnGyOA1ePg+MKgTrNbaJPv3yns3bU3Bu5iRR72zovL7
 wk2kOEgjNSLQhyr8yuSA05hCwpTPhY369F4kdH6CzjJu5oF8unbYZebi2eBq0AIpt6k8
 Ill92iOkNOUX/H+G6YYbyneaxf8WotnttcpPEdVpO85KlNCn0/S2ckhIccThF0Bvq0Hq
 9f6iQYeMQyDovA/4kRpPVV2z6JNcC0Y2CY3fwIJ1towQD+jmaPQxRgF+QixD2m3wqr4l
 2jlxszyD7YMG1bayH5WOX+cU2sLd1nv62iFJE1mwGOdqhSVeDFKbCgm8w9J10/O5TSNv Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmts0bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPJqv033701;
        Thu, 5 Jan 2023 15:17:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkexkbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsFBgtrkv91j+nTPXFjKErsHigOTI54pUDkaY7RnvReE1lRDZE4fGrPSSgCNTeoVcYMghbXTvE26oF6oM+/QoBIsEfk5XeDdeHZJV6S2Nk9OjLCEOo2WHqg/BAyp/TyoKWb8se38rxCfI9mZkSBsIGUMgsrGO5uw5GNyJR1DHWCJvpIeJMApJ2WhyQC7CJUN8ke6LeWFF64baB2RZDmgdNAUIJXNR/Lyd2l5B+NhQk6MShqcs+PkijjKw3SV7uCEZ1oAgMNIkzJdivQq+NjZbvaGqoDam5Ht9HNgXzYL9CQW2XAdsg6+teimT2NXE06mas1hueiNbp8aaUXGXk6D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIc75cdGTfGHDcpOA+nAXVIZJLskQhQr5iCkcEIv3kc=;
 b=VMcAiX1mxKA+Ag49CcptQB6K4sN0iYeUcPM6FvOA/KdvyyS1eKvLkqXkwKLyW5u7z6eXZeBElywUzeTRTAYsNP1DadnFrxo74vgiRwiZeVXHPnh0wE235ghJXarDXwL2oEFgH95zd0ruMv7xii+8VqCJa7pDEo+h1SRcd7LkFcFiDFEdA1EnuhY4JVzy+p3mm78VpPtienBhDErZKhxUf+bwC03TTY2neusfukLMV8rP/063rZiHxHi4tOt2qFWwfmptaFHjuEOMl60790fyjkbVPmuAuq8fIE59k0wqk+ulkGoAH3GDQa52NSYJTDReXuyVPMJtpdtcrqcZ4qyGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIc75cdGTfGHDcpOA+nAXVIZJLskQhQr5iCkcEIv3kc=;
 b=tDAk+BnSm6+rTdCpC1rV42XHPFofex4iQHtmoEpbqomcLZuirFKVX22SUDKsOfc/8L7qUuMCPxN4Bq5FQuqo+v6kyoH232JAvoVSZNKTZJ0hx7Yq8g73jZA1Yf7IxpvuvpabTyk+Wt1uqcWK5UWwed686OYTCqSlOVNKedWikvA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:32 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:32 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v16 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Thu,  5 Jan 2023 10:17:07 -0500
Message-Id: <20230105151709.1845-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: eb176ac2-4956-4d31-160e-08daef2ff7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRUjqe9WZvoIoeR8ZsP4Iwhx79xZT8AhRvlRRbXJlsQ7oCNR5a/J4Jw6H0rqQyKXWSi9Zz8EXoUC+d9XnToOlglqL0EfzJ3k+UdNDbs+miBTANy0332Q8RL8Dj2dGmianZfz8KcYMw8B4E7lf7LFtXKjf8I6fVKbwLvw4ZQuir99xRIot0KmXeklSfF+qfNE+AnYkzotdKUNTTP1eAqmftYwE7Mk7JRRzqGDvE9BBZGj9Bbv4H7gV2A9/q6fmhVcPDbGsT7SeZ8ILVQRgflwOtW8M2nfOSaTgOlNHhTeHVxQ4Q1usypUNCBq04RrIEYJ/J4rM1PBTRLYwglNjH/pwo2sE0rgfA1hcPEjWTYeKtrgjpJ4s9mJ+Knj7X85a7sYyv/qU7rEsc0jRnB2++Fvz6JmpHksxnNG4EyDBWPUS9fWd+zxPcZ6Sh5jN/4DXmZdyXpeTiAy/T6vAiO3+sMvvb2gnPUXhbqzo91OdFF1vCm0LwlJU1Wfe02PONh6xTdkFu78PEmD8OH7RHxyI9QI2FAzWX6EXdtCa3hT7WB9ErKuh9rTdBmWUAWe9EGBBqvD0ZQMIHPEtefrz9ez9vkV+h9s2XCrm+t7kF2XzIbLmtQf4SluoHEhg6m3jUGOQJUwyMvVeNOPLkqfzdJ+euGxUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(4326008)(8676002)(107886003)(5660300002)(66476007)(66556008)(6666004)(66946007)(8936002)(41300700001)(316002)(7416002)(6486002)(2906002)(478600001)(6506007)(38100700002)(26005)(186003)(2616005)(1076003)(6512007)(36756003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dd/7lo93WH/ggeR2G6vVxeeVCFG0yir2h2sEHv3D/61ivKdVkCpaMArjYhH?=
 =?us-ascii?Q?qIVejiMfRnvYVwOt7XG64bFw/E9BC8objZWUPYMenxQouP6FgMjAYb1P9FEd?=
 =?us-ascii?Q?SBPGv4AO2SWItKiNraczNiLFJUw+fSQHefFRcqlkH5L2oxa4dYCBmpVNGYWO?=
 =?us-ascii?Q?hrhnKt4YnKptKe3vuhX5RzepXRby73SJyL2yw0EBeybkI8BXI7sik7nJuK/i?=
 =?us-ascii?Q?KhjkD/mEdMK53BKLsimKRK1OemvFD1W2dotxrbrIa70tXGy5iqydQTwMzScB?=
 =?us-ascii?Q?dLB9wxcoOrdN7fnCtYLjiClvzBWhlxOvzw1qdBFezkHHHa0Aaf26ntYuuHyQ?=
 =?us-ascii?Q?txU87FNfze5dYYy9ul7fnAFsWiXPc/ImeM/2dAe1km3EXYu9lUsnKXX6r4ET?=
 =?us-ascii?Q?pKglWIPZOf2MiCl8hyXdXRH520ka5kaB8hWjd4GCg6wAzxWMZZ5J83mrK6eg?=
 =?us-ascii?Q?3oJpROIhCn5RlFL7xA+RVZxbaH1v0iROMbz1IlYOvARcSv7E9oM1VbId+bgf?=
 =?us-ascii?Q?RRphvKBSiAk3gI8YvgFaKvMa8om1LDmw8cfJmBBLTYKjoJPur0jAbLBl25a0?=
 =?us-ascii?Q?oZoIrbclFxksjKMBNr/OAtBlHQiEqQPedmAFDZPfJPS6Gy8FT8+XbiwsKL10?=
 =?us-ascii?Q?wE0okbr7NWRhWGWZKHwYX6pLA56ie4c+/G+qshdm4al0z/4Ch7KE+4sIlNPY?=
 =?us-ascii?Q?uhg4We9ouN5psz98K8yFc/u7vlTYVLQjdthWCVL91d9pKvRYbymZzd79xnHz?=
 =?us-ascii?Q?AADS4mN2wwJ58yKpDatQrhqY9SRtIs0xb8137sNmbUAbMFU4RcMDku3SChfZ?=
 =?us-ascii?Q?+QSqroNdnTIbBppUTwYYMX5+m1f2rF007Q/FzZ6JTylXOc94xHVhsjQQHhXn?=
 =?us-ascii?Q?PZw6DxYmVTAPNYa4SFW/vWm3lVsX0z4x+CvM7jpqIblZjqzfhR+zv9Ynor0X?=
 =?us-ascii?Q?O3iYiohivIrCBQ3mHwBIL170o2nZ/T2UsfXR2cy++lsngIcVMUjPjsQXskqf?=
 =?us-ascii?Q?pmxLMNgvCJDkezL4j0Q9Hbf651m+OXRATbBeTHjSB0VjIBg8Iq/x2/lMVXJc?=
 =?us-ascii?Q?dkDv06iN8Dvsv5BX13wyakQbZLyttzVRRecdYb04aNzKzfYcaqE9cWYDRUCn?=
 =?us-ascii?Q?NxKolx0skbewJTULp5seeKsCNkRjojXC7EFFVLJ6J2u15uqYU5lT7uMxk+cB?=
 =?us-ascii?Q?8qPsY9remh/ZiISHH3R/v1XsCzUJScEhSQFsmp7iDmfM9dlVDle4mFe69290?=
 =?us-ascii?Q?vLgZNDPWGJcHiZ+Jc+/1gcuIKBuN521AxuUk0azxSPv6rGmQI52KN0iH8SUw?=
 =?us-ascii?Q?kBWHHG+sCBAOfkoYP7qZjgYiiiM6TMV8je0yif4+Bcf/9pml0RTiYp8erWRc?=
 =?us-ascii?Q?DIJeRXD+8m+hYVplfr6GNy5X6Yc6+BWclNgnpzNBm8Xud4xtlQ7vKZR81Vno?=
 =?us-ascii?Q?5rgI30+hkUM1bTxz2/6z/Mujqbh5KYdfw0Yzp4ZCSHlhGJy2QkCNePiH7iBq?=
 =?us-ascii?Q?idvqsCJSoEzS+AWJRM77EuwjO3eHlekHl4GeltXyfpI9iseXrX54dnMGua3y?=
 =?us-ascii?Q?kRzDQa+2LaTt6AoCkONXronbs46Oxi2g0yJ9P5pw5ibrDoPm26tchh+dAfHq?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pqu0D9Zfzrvwcq8TiOBlGJPpH03taaVEJTK2sK3425Uz2h1L2IDWbzhZGaCY?=
 =?us-ascii?Q?2kNunSE6lIeQby56peoPzgyD9OwUL8CN7ODTI7KtCIkRtOXcIkSIB7GGHYL3?=
 =?us-ascii?Q?vraZZNHxts9tAvh64Omc+u0vJes/Lbo8QimxP8kfP+yRNNk4CUhjLZujpuCQ?=
 =?us-ascii?Q?5c2Rj/I6mT/gDUV7dnLJAAS38nxwP3+MV7hyPskE+j5ajZ6Gq4NdlWE77QvQ?=
 =?us-ascii?Q?Z/qLSf4vwJPSFRDUwnqU4CGH7WUkQf9QAfdexrsuRatyOzSP7HakzcFJT+GJ?=
 =?us-ascii?Q?VVTO1LGf9NLXN4ScEB6Cqlacl8eS2/hfQ+GCC1ELklHkfjLZqqbqArP3Qdb6?=
 =?us-ascii?Q?sKBvaej74hylYxysJVYghtHd6wIJml1jzBAe3AiLPyIQeg+ZbudUGA5iG14T?=
 =?us-ascii?Q?PmIAUpMH4vY0JPeaILeHs/ZKbKkeHd83aaK7fkE57bC0E+uN5oSxyM8b8Gdt?=
 =?us-ascii?Q?Xr05qOpNPx3gbskA7+ft72vN2qcsVqEYB5wu3uiZhpMeLKUFI+nmpxpBkc2f?=
 =?us-ascii?Q?NL4ENXGi4M0Jgc2aJtHUKyeWQuzIGIro9JE3x1bMqif2qUXlEP5Qy4u2SXxv?=
 =?us-ascii?Q?+f+PHYduZZtYGYMQIFC21ANO3OcJwsmh/df7KR513JABXsuVunLmhNdg4bJX?=
 =?us-ascii?Q?9p1AApxtSHDztuKq7mgULz4JAWshJc3JVPr+ib85jLGUYxo3o7EbkOfYplmt?=
 =?us-ascii?Q?yWZaz5TSLi50ZbGonqeee8efJcx/+7Xr6Rv8Fv3o/edap2W896621O4KwSqP?=
 =?us-ascii?Q?rPjbSVPbvupNpGeNQ4KuSXJ9krY/gEOFL9JL1pVkhAZ3oN4PMxzJWkNegoAH?=
 =?us-ascii?Q?lTvEIBrq0kzdB/7oKzmIMaK9N21Pbu+7yw7NN5ajoVwIa+mOoAnUIZrL+3MA?=
 =?us-ascii?Q?mcOk/03uc57t/BD2noGcB55Kv7cXJ4lP9E/3RMaZ1E73PZi7oVMryrRXesLa?=
 =?us-ascii?Q?GMn7b0vHwZA40cqjZ5Izjw2XL8663Qp8J8PWIFNJ/KHwF4gpOPCCBCLMPRsA?=
 =?us-ascii?Q?CIgSOLJVSmCiPbCkVVoiF6nM371sd2L7kErxOU5OeQZQ1w9lJf0ZLc6h20Jb?=
 =?us-ascii?Q?+Djd3umHmPSTx92539oVOSjNkDjUpL3SkzJ1OxMc5x31n7Yqc/ZBKVNuKRc9?=
 =?us-ascii?Q?FnZh3wz6IdZ8ftuLlmhpVOYB3TJZ897+czlDVRjqfe2VnrC7fhkX9xSMRvC7?=
 =?us-ascii?Q?xrrMPG47buLwvtx9OPoi9Kwma3F2AA0UuwAzteGl9tbkK2Dz3qdx6aV/VUlD?=
 =?us-ascii?Q?vBQhRXnNRlQhXFf0JRgcUcIsdwqUQNaY1RC1A+kqHdbT0ljihr4x+Lqj2/JI?=
 =?us-ascii?Q?Y+vucw2W/maV51Djpv2kRM6qRkadirOQ3hqHgBlaUOu5rA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb176ac2-4956-4d31-160e-08daef2ff7a5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:32.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zGzcIIeQkvqE1h4S7YOd0EE3EKoPbigKRsVQzMa+EGgOs4b897lOqqmcDz4g9G58kfNT5oSYYdt6ad25IKsqrMejegRpJSGTGTHYLYh5RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050119
X-Proofpoint-GUID: yYp3wk1BMn9ch-yXEabeK0XNpOOtzc0s
X-Proofpoint-ORIG-GUID: yYp3wk1BMn9ch-yXEabeK0XNpOOtzc0s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 973d7ddff1cf..910d377ea317 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,13 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			/* Skip the soon-to-be offlined cpu */
+			if (image->hotplug_event && (cpu == image->offlinecpu))
+				continue;
+		}
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -686,6 +693,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 			/* Flag to differentiate between normal load and hotplug */
 			image->hotplug_event = true;
 
+			/*
+			 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+			 * this callback, the CPU is still in the for_each_present_cpu()
+			 * list. Must explicitly look to exclude this CPU when building
+			 * new list.
+			 */
+			image->offlinecpu =
+				(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+					cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 			/* Now invoke arch-specific update handler */
 			arch_crash_handle_hotplug_event(image);
 
-- 
2.31.1

