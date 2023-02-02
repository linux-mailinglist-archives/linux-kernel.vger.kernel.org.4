Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EFC688ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBBX2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjBBX2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:28:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3236993D1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:28:07 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDtgK023725;
        Thu, 2 Feb 2023 23:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=x6Zga3XJK4aTT+6LH8YBY2aVowOElE3o41viDVSZh1k=;
 b=n59mDM79amZFoZIOfwEvm4+Ow817nd2Q0XNKt8Lkf5Iv/Swzm0Vy8icmIsbs43D8kXJk
 1XOOQIdEckfWc9qzXiVdtE7gj37czMuTdzQq9kA8ua09Ns8q0iDlEgbB8BxruqHOWhu1
 Hl09yVwbmwaHGeX6LsKsP4ET3olw5E6hRlnqRn9IHVS5bJM8lLCoByvhsYKcrG04osa9
 3e+iBu7WxTAYG7e9x27YzQTWaCaMN7safMLe3jJ1c0dMhk+BjVDeah6fY8hXT+8Mfzie
 DiXCABE/Au4b/r+4sLRdGjm+LvDGX/yqv+BfqR8ypMf1uq5fI7IaKImErTkKX3ikXQvx Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq28v5w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312NEWcr040631;
        Thu, 2 Feb 2023 23:25:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59rd81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNvdA/Aj6Iat0VBkLdm2zDLfKDU2S/Ei+14ig6ZS0A6xb05At66b3ICB51SESKDMZJELonLsPF55t2Zeg2uVhUQabJ1Qa4CZDZsuipFDff1NPa61/rl2EbCcvmpxtag+4ZPvoWovolvsQAhexhuIEW8ycBL8n2z5mX/BM7IBaiNFon2gSTLBqbGWmEAKZHeGqD87c7StACSvpRlWD7WO1oTeFiih7eN77KPMWJrC0biBGKAEiEukCj49KSQMBBujTHuzpiTjh/z5iFXGRXihEOhaicHSJACIDRMtTFLFEHxTCs8Sli2FzVCBvT+T9ATbcG+maGJdujGBHgCXukMZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6Zga3XJK4aTT+6LH8YBY2aVowOElE3o41viDVSZh1k=;
 b=DxKZIxBM4fs7e3J+V3y1THBbd/lTPALrrM7xSVLMXsPOOChFPCjhtiHlWCfSjjMKf7u1tH9/vhcuFHd7wKNV8NVHN6mXQdzuWhZS7fPh+0hZevsdkidZCg0sA1l16WFIKcG8oL/tlmWLhtWzKWmVWxe5TaA/XYXAoVVVqSNGMR0g1B1DyEfIK7KLgFj9uasbB+znXI8PsTpRUUhlJT+I0Mun5AEtJQdqfhUh2uICn2kOMqkKak3QGBvJLs5EETKBS2lBIGk6Mcu/zLfwaLYirGE5O/aUssZjea3dyyYDgsrIXxdjrRi4kuapmASeGXy7R7sfIf/w9vtt0YtE7+Rg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6Zga3XJK4aTT+6LH8YBY2aVowOElE3o41viDVSZh1k=;
 b=Q7MBY64OsNIsYDUQDM1qFyHpHjSb7aQxrCxRAvrM0Bzy93V5cTjqVgcI0M5Jkt5dWhR5ZTGne50BWn9/ODC7UN09JCvtYIwJx/kcf9dcX274Vdot4JELEKC2gpvr2cIGirQTy8S/hIzq2sdNbYZjicTKlcUScW2pcUrFAOrLnhs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 23:25:35 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:34 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 7/8] vhost: move worker thread fields to new struct
Date:   Thu,  2 Feb 2023 17:25:16 -0600
Message-Id: <20230202232517.8695-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:610:4d::34) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d1a98d-a9b2-4f2f-ad7d-08db0574c8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WTaMsHl3fcE6iM9C+exKrM3s2SXRC5kRmNlWvnIpMJCqoOYSG60O7LXu932/7e1keA7uBPZgIjirvkBizyIIpeP/5yEhG3gUQVL12zcpMENt82B9z7GucAWuqPlXcpIq1BKE5ync1bSD6Zh8bkkjRbojsLqv6iZaTuLaB0/NPrStjfB6iX1Du93Mfz0rZrl/sSCSFNhPWETddNsXIqtr8HJJpVhN/A5UAJpdVf9oj4ZF+DfkrXNR+W00RhTJ33C4hxMeDUkcj5vQa2TGO7GHIJ3djYMhZt1TvBYGTjID/ePcGIBU1EBqwFO9bhNaHyVAPZ3dRmYv101/DCTz0Vw3gA0ymjcAn1qegTLi81eFIbJLVMy73EjIlcDNNIMmAg9LrOltyAqa8jxG/lRDe0I4Z4M+eGDrDNdFtr3ogq+LZ3x216cmYxoMgI4Bzl6r3jzdOD8jxwbT8JBogpIVObxCpIPkoTlKKHb+A1uaTZ1clhaPG2ZrS1n2As74kCTRDFNNAQtYIeAAgUp8QC/LVGIpirmWJ8Y5kwV2GNA0VfaoUXWL4dUgkgbie/Vf+VTSqwLsK14CBqBr/kYbydNiUAsAT/1fmTTKGNtGs1HdDBqX8VutoBftXsUixZgELgVdapCLBcFA/NFTWdMvA8vOcVcHzw5n7dro20v+IM6BeCXHbkGD/sqfRmS1q3M3r/LQLrx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(38100700002)(36756003)(83380400001)(54906003)(316002)(6666004)(186003)(6506007)(26005)(6486002)(8676002)(478600001)(6512007)(66556008)(4326008)(921005)(8936002)(41300700001)(7416002)(5660300002)(86362001)(1076003)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yR0oc5pQk+AamK+N3bYol/BPKdCwHGJcbqTo2n95j7QRblL0pLsPJxFGAS75?=
 =?us-ascii?Q?u/Uo9oeE3SEM3J/zavyKGge0V/9UH69MnrVv/BPd744Qh/B44VG7cOKu0V6t?=
 =?us-ascii?Q?dASQeA+vLjW8f8xyr/mUzW1ENX78aJLJL6Z4wWwxWRHr6kiFE6j88DaXd8la?=
 =?us-ascii?Q?iP07wxcDZoy5a/2D/N8qDrqciT7x4A6UK0Rr+mwa9zIjhA9tdIaIF7U/HZlq?=
 =?us-ascii?Q?Dw9SW12TpHK0kFRmDh32VCZkBdbBdEHNeStOCl/W98rRe5BDSuDP/v0QwjLe?=
 =?us-ascii?Q?ZIT4+Tw1atIG0FpWg5HKq1+GSb+BbCFP2TlGzsiZK4H+55agskA8SotDdTC+?=
 =?us-ascii?Q?CpMWMl6TIj1c2DoG2dU4XJTz9GZ7FTgakVVPRanQV+A4fWvF4Td9bA2QPK7s?=
 =?us-ascii?Q?DUjRTR2JzaPBWCQGJN3gbLnyHzcCPPm+E2N3+hurSFxSkW6vN7GIyk04z0VE?=
 =?us-ascii?Q?ZydoRNCyoH0uQNFcW75nKW1qzUYz3HfLH0X6EBNwyrrlc1zKmPmrMyMs1Xxx?=
 =?us-ascii?Q?a2gGLLZaQuyUb19Os/37aNfSujDYABgiNb7oefftBdRdPQyfU5wgjHJJYgBK?=
 =?us-ascii?Q?N0w8IZGjn20CnnYScb+c8KJM/U6P2MENAvVxGSGrQz3yKItOdBFIWbHMZsOC?=
 =?us-ascii?Q?HAXaf7baNbsNzWdWKTdiFT0p+T8TRaR9DcGtOlMnzsDUZlbDBIUtcG4QGcIy?=
 =?us-ascii?Q?ONjs0HRVwT4WHliut0bY/Cgq+dtZUjLj/mSrldScoh1nHEBR7Anjgy+C75Y8?=
 =?us-ascii?Q?5D9BJY15vfdwZmpP8crLSShQGcgbOZvnH4ewaIAGBJkuw7HOdphei2IA6T9+?=
 =?us-ascii?Q?93gT670vzM8+t+ebHr9a8TcKTlICpST6JIbupW6c4CcWFM4U2Hxbul8smSa6?=
 =?us-ascii?Q?ITfGgGKtPppr7d31iBDcUWpBQvx3sE59E2ALRiHm0mg2jMAe/8xPqSL8kamg?=
 =?us-ascii?Q?czERs0SmAK9cumXakuZq29DuWcdO0EjhHY5S5o6rosYVpsIkhkKM28nqQEO8?=
 =?us-ascii?Q?pScLR0tZYvgg4aozXNRTtIAqbUfuwWo9x9ZRgB61y/czXl00KEXsMrvCz0vS?=
 =?us-ascii?Q?kKcNuvurSc0xj1IDmRSGC+DBiRL/UfCpRRWrCkaMDeQKUqqE60KrlpP6ZWTj?=
 =?us-ascii?Q?FrfTqGpu/Bhg80apiO6Cri0Ga6/BBbjpk/O3Zot4SxaOBQygcxSyL5qdqVts?=
 =?us-ascii?Q?/2DZBX/1GkNWxjn9uzYzWwNiAm+kBq1PNgN7oCi6NmF3F371EihFlqxvI6l4?=
 =?us-ascii?Q?WHUo/AXpYjWGE61fjYNKdM/hGUE3C2lmB7MDJuy1B37bEzNuKj+VgHAcuCZs?=
 =?us-ascii?Q?6PNRXFYOjL9qiP5bKKDXCTmEGMqAr8RnF96AY9R+aTQXF9ktwKPtEDK30ewP?=
 =?us-ascii?Q?7qnAlp4GiP+yGfFWIZDtMTYr8K4UL36F2Y63q0NkTTNz9rTwAAroEUiQqQ2j?=
 =?us-ascii?Q?vvLUdWWLyjNsztvsPqk91jpYp74MrDwxMvlTPvZInrS/jyVFUwiTAwoxR5m3?=
 =?us-ascii?Q?CWInv5aB7/YG1uQTliuh3x0++SWeioOQMAxL5z4ewwfhqmBHxygCGP2oXeu5?=
 =?us-ascii?Q?l1vhsrtNh/9CDO0Jtj9InBG4/2kvRJ6XwqozsvqC1dymw2DvNfF/VBtQqiUK?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Kn/ZXC1y1VHwyjodRsmWPHY6Nd9jx9rEqNgaeM6eyprCHcVrhzlp+v4+x4zI?=
 =?us-ascii?Q?JsaOcz8OFEAQAuBW+mb11FPCtvqW+6rCzHLmyV7wdAfECSS71bRsm6DmE1U9?=
 =?us-ascii?Q?itKB61xREuom1sD+kgJIywEAnQDL27sjaDTlTbw12A1Gh/H5D/rZrwRusRo0?=
 =?us-ascii?Q?O0JXzPxhtBvguHlMOsVYuN2XYUqXXP0dJI6/I/wBOoBss2ikRqxyOlRooxIR?=
 =?us-ascii?Q?8Tj61hsszyyZr6OC2Pub9j4Wq4prSip2advWCZPoVlq1oh3Ox0zWXzcKn0bO?=
 =?us-ascii?Q?Hheq8IoM1+Em2GcHWpDaFAUK2Ru0O+7f9XIEUZ9OYvs4YzxwwBdbh8DqDjuL?=
 =?us-ascii?Q?Q7nsuROB1WFN6rt7m4RPjkt9xS7NnklVL7D/G1JHwyjZs+h6Amyvyzvhz0Th?=
 =?us-ascii?Q?e824+mjSiKFYxUbb3SeU8eqTxZ96FpTDhxL2KrQkQxwpNUrBHretshoGkrR2?=
 =?us-ascii?Q?+4EjWyxAUS7iFSS3OIokzk9V8+OQIZNlRQKNyxNVv1e0/gxBRZ6muJb9qBRq?=
 =?us-ascii?Q?txA9vQ9gXzJAaGf0H6JZIAszLRkmsvft7UebX74kMs5EDY6Kt7ngW9PwFqAF?=
 =?us-ascii?Q?jPP0CnttpM8LxHhBxFr6vNtap+cNNRJiuyg6wjtogt3Oq8VRZ/+5jlulPBYU?=
 =?us-ascii?Q?kjcEl5qjPuBJXnduSa8rSL15N9oJSSdu511B8NFucVvfZ3VwwtN+BA3nfrSm?=
 =?us-ascii?Q?fAjWsK2gBlN6PymmrNavbMcvAKclHjDe6hXjeYlAGY/qo8WGWCh3IUQoo+L4?=
 =?us-ascii?Q?TsGxcqaqFjmMxj/WwEWKS+m+YHqWQlhb0YzmESb9ulseooMzWg0VUZ/VZdld?=
 =?us-ascii?Q?O97bc7ojxBYWZVRPoWEKKzEcrzaW4VnyntD3qCA+2gq7PchrBNzwWaySDgQR?=
 =?us-ascii?Q?ZnajbyuhiZ0XHm31Q4gdx9IUQTlYdrrjuRU+3wtH28mdpUT5goYCZY1UfW9k?=
 =?us-ascii?Q?o8A3J+O9fAMy03b+MA6p3GZxdL+dD8eCr6bTmnhUj3d7IiAOW8CwidzdFkzg?=
 =?us-ascii?Q?4Z2c7mm9aGb3mK+qrvBx5E1997EIv3xGEXRicnk4s/NWtW0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d1a98d-a9b2-4f2f-ad7d-08db0574c8c7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:34.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VmNUQKDgNvU8lVVguP8QLv8Od5LgSK88fuvjt3Gt3yNbahTGG4oORrvX+IytL/T6gYLZYLS1+bPNzJlfMYe2Zf97+yE6/LniT4+tAQFFYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020207
X-Proofpoint-GUID: CHLyObpReeO-uilBwHwGhfLw7q5je96l
X-Proofpoint-ORIG-GUID: CHLyObpReeO-uilBwHwGhfLw7q5je96l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cbe72bfd2f1f..74378d241f8d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -335,7 +335,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -350,7 +351,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -360,7 +361,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -479,7 +480,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -571,10 +571,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -585,36 +635,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -704,12 +739,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index d9109107af08..2f6beab93784 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -147,8 +154,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -158,7 +164,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

