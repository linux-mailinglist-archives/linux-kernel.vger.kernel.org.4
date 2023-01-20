Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB14675E44
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjATTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjATTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:45:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BFAA7EB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:45:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBaV5029981;
        Fri, 20 Jan 2023 16:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qhY7vp45X2rYBbuUWykYt08J08ENdLihX8OXTFkfGxY=;
 b=gxvHCPwdMi6/EvviV+XvuTOPmFh6HF/Tt5fhO0NuXlrKYikTqLRIJv4qOSec9z7wUPjB
 sEcjowFetcGoO4C5PoM74z1ChFTYavxLl8oBdcBJQX9jykUHv3TrY0vauMvlm7KCJxq0
 WNss5im4FHZU+oc+cECt+ofAhW9BPZuyM8trCCW9XlpXGvXfZrTSMRAwR3dqeRzUSzn3
 nILkX2/ILEON49Dt4XATTzwOe0rn+avGSZ7XWkDTroiMuoX+QiUeXOdJPf6TzeXkEWt5
 h4d6UUNyZAUrTl8z90UR7hok0zN0c8/sKotHsMH417ZiAbqabrld8VpRZxuJy6iSbFtz sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6cd3g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFNHTJ027854;
        Fri, 20 Jan 2023 16:29:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud93ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsZvrBDTT7STooqJCQTDiihMaaSUB8g12tLl3O5fOlh59Z1Wmwk7FSSvqyMa9zCcLmlu1Bn3yGRTqEeT/eyNYkHTX7a3xceGrPpdpHxdtMWxLJAx1U+QxGedOj2uRBD4uvNQM3uG5JwgUbE3UMX1FpCDK6sRLBrHQQUhsw1H35bSr2+XX2jJjxM16IuwbeM191t2X21TSsjvTB15R8Zhp6zUUOOvQQ3ploodPtbgiSi5MtPEoXLmEecUDsnfVX6tfXFVmIXbkWtWaOG4v0cPJfTxIpuz9EduwIIyfB/E52rjUqNLyIYMN0qvNRP1ibj1kEu9xIKNgtprUZOp+G0KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhY7vp45X2rYBbuUWykYt08J08ENdLihX8OXTFkfGxY=;
 b=j18jVgvsk/fX6SKIOMitXRp1RiLK3B08yyTyozNBR81PLR1uY2NCZbjY8nSVnBzt8/xePWpDu10QRobU8hN84WiRsrn7LVqIzl3TJqbFWW8fclacVruDxLuQOkF138nmC8Im2GkKSa50PDv7VlyLgE7gH4MQ8rhg4yKsPIUIQRxN17i4j9bGmgFAxNlYIk/0EnvmVRv6eiD7DYB5w0G+zsXQnHaNcboQsE5Hmg2XpwV5VB60/Aeivz01K1XPdwABFDoChZvnB7cxiGMYMqqrgMRnUNSnIABw09pM3DuO5rSqpIzm+fSkiMHjUKKeYk3koP+tAEE9qmNq6ARQA47byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhY7vp45X2rYBbuUWykYt08J08ENdLihX8OXTFkfGxY=;
 b=JI4IZSWJ5jHp+DR35Z/rUW4W8wk/i/aGRoNfHWHYrF2hJH4O2NMIFq0vDaONiLXUZIssQe+HztSxOxwsftXm14ULkOtyMBS/rAtafsJeWladflC3PckOkUNw0o97Cvzu5xKEb8oNWgLbza4knOG3jRB86WkT9AsLZu6vqWhwQ6M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB6400.namprd10.prod.outlook.com (2603:10b6:a03:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 20 Jan
 2023 16:29:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:29:06 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 44/49] mm/mremap: Convert vma_adjust() to vma_expand()
Date:   Fri, 20 Jan 2023 11:26:45 -0500
Message-Id: <20230120162650.984577-45-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 9770648f-bd46-40a4-1288-08dafb0372ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTRAJYTZ+Nk63zJLrmmkV7Ow3T/qCnKErqGgJo/Re7/rta08QsvabM1b1+p+tpmicA6ftQbCmJ12g/QgwmVqLhZNfyEvOm0F8k4fJ/CyhmDlD5vCdrAgVdBWhfoAPd7v57iq9Opjb/Lev+WVCxh/0pdBiDvmBJU6oqtsSTQJJntVldKpRXC0yLJKQ/K1XNeUh/tOWisXbU7bdI8FlUhs08v0+dCFfT8rdpVo4Qt69QDlFArXgGUpcgM7fz/UtjNw1Gcd7XrOAuRJAQqAqfCAysrTe02MBEv2e8RMDYcyv86pcKHfawaZNPvjYu8IxG+C5VEbgwtYU6qHSBM7e9e6FYuVAkA/pxGiKnURacLTYKXQMmSQWI/IhOcpT2CcsnvHgP4CihBhf8sos1Ho2pcOyk1MtEzTAtjrVikD2P/g/P1qQZrbLgGMVfXEDE66i1gdKjwxVsfBMC25E5mBVTR+wqUE9KjUPTvzXpsLYScKrrJZ7Ki8oUok46Lhp1cqXaE+EWoqD7ydExFDh0IaOBd5rS65G4llrpLPs+2uskNj0J/K7Jc/bVtpOsKSY/vJnrM61IbtVsl5SVhH3uoDoz3FtxBC7irebPykr3sL6L4ctosMQyqUeFaQOSivrbonHxkFOLKb/36ZGO1chi2oibCvqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(316002)(83380400001)(2616005)(1076003)(2906002)(66476007)(26005)(6512007)(186003)(6666004)(107886003)(4326008)(8676002)(66556008)(86362001)(6506007)(36756003)(66946007)(8936002)(6486002)(38100700002)(478600001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeLrTU5AMyCgJfbetRFQlmCeEaOA8/FNftUuh/2fip4LTPqkf0qOEfgWAcSU?=
 =?us-ascii?Q?bd6vFUyFQGRyYbHJzdPo4tsvwpCUZnI34SqkxL5epLLAP+15fUa62YI39DIe?=
 =?us-ascii?Q?HT11+R3Ip3LqZe3sJU+7HD4GjaiBbzvW8+nc2a+DaG54QzkjnUYyI7sU9uLV?=
 =?us-ascii?Q?AMg//8eHZR223r8BhqNB35nqsJC0X4aQySwZXWJS/Uh6k+FQh3uHF38F6oCt?=
 =?us-ascii?Q?lx5B0MZoQldfgBTqZnntE7ilpMsYD5J8Vi3d8En4PYuOMEytGdgDh0DJpneF?=
 =?us-ascii?Q?X17dSCFxlC3O7nyvZ2CxhFWCRyB1+IMGWNBHCrEe+6DM5Gy/OizYfuZDhcK8?=
 =?us-ascii?Q?i6jRpa0PZna4+l1Wfk3thuiVtZR0FO7Y/b+rgz6DNZkXVonLbbq7+pF+1EB9?=
 =?us-ascii?Q?hEgmETafKA/VNeaVArMpZTFDCBxtBJOAtwLQNFqej/PQyOd9q03d+xvAUytO?=
 =?us-ascii?Q?GiRC1r2Is0O9S909soGn1sD2PlqR95GqCmOlUnGSuzdROOKMubXTb9lrzZrm?=
 =?us-ascii?Q?aIbaaWbk3ZbAwRC/EXH1yHA0/Q57VZSNTwMQyTLnAP8smQyIBBAMVQQBYPrF?=
 =?us-ascii?Q?a9JksEunDunW6/4dcNYZY94DDr4tCwi3ENr8pRNS9G1Rq+9nOETSLZzN5cTl?=
 =?us-ascii?Q?UVQ50UadVvqU4DEOiSwq4M1SI1MX4WclrLOVDwrMfepQJpXhStVRy4i+9uoI?=
 =?us-ascii?Q?F8UEHSAqJd5xneh2Q7ZccUkjphpfLRcTLy4h3id7fiiFcYswzuS9SbOhEtMV?=
 =?us-ascii?Q?0LgiV7ZHKQ3Zkkt29QhrKCfmE1LVjZESXS+HQMyLKGHCJ1kfBa1HJDyDEmIZ?=
 =?us-ascii?Q?PhtzbWszDo3phttPzi2dJztstfmB/ae8tSMotN1khoPl36hFC69ETbp1o4Vb?=
 =?us-ascii?Q?dIFoSf3Ak4GNUg1QKMMtvkWHehH5/xs0eSdAagfxbXV3GdoifY4Y4yNQCZQQ?=
 =?us-ascii?Q?PjRn8FrG5g8hKqs4WIexuFp00NDDmwJiLaF1ZCzPFuXVzWlwzf08bPMBeEY6?=
 =?us-ascii?Q?FU7MMszurlR3NkZjXuYIcKKyMhzWt/qbFb1X/fMR/ar4yzlwUBFjDisutufZ?=
 =?us-ascii?Q?6qMg5QivaFoQR3maY7BmI6cHJGBGLs/XyRhfQyQgjspmpjU8rKdOtgEMg6BL?=
 =?us-ascii?Q?agco9chcYYBg4zpNp7bq8JeaUzD9xYEM/s712mvgZu3oNeJLM48yZnSR9dzF?=
 =?us-ascii?Q?xy4HpWLmp9YR940+R4d4m0oTQs4V9hw+3HdcAdEWwOIx9vC+RUBBTeX7knRb?=
 =?us-ascii?Q?PLPIvbH5X84d03/Mi41r/UXhQgK7GewiWiTB4CerW5ZRUaC/DeStd7+FLpWM?=
 =?us-ascii?Q?BhT1i1L//FoIcwvz6ECEMp8Xm/u+x9afbtQe9DJbX3N61eMGGGFPYguXyruN?=
 =?us-ascii?Q?uJkz0zs+SFPveapwlC2IOCggH8u4kmurs+Swt2j4hZbEwL9P16adGaIH/PbE?=
 =?us-ascii?Q?huXO7Z95B0gbGeubZMApV8rxXhUnCXWPRVgUGvbEStLAlECIJTxpZqAcmgLu?=
 =?us-ascii?Q?t3gKz3ENoZa1WFlvvfcMKanQ1JupTClDD+JtiF9WosncA6TSKLAaziWX5XmP?=
 =?us-ascii?Q?P2o6JUP9Tzp9JDy6Ebo1XvN2pxeI1IrXkxEGNVrAbcdnj4VxnfjDT5rlGG2t?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CMJjR7hxraPhaRJezY3tpcee7IWJIpbe0J28tBlC78aL5FoKCUb51yFtVDMwM1fiVg2RXKLnf1XMzO9ALdaK3agacGcew8G/c7i7fq96TdkVrdn1jtz4+ewgR1GbrmrO+zvLy5Olj9tigKj7sPJ2DbE5O92qKEYKHk3M5WzHPdlfUxW4neEXkJUV5Tpozy7jR0todI09cxuYb5nuwQMxLQHHFFAO5BFlXf04ivFuHUlduECYzo2loUShnKMFU6EyXKnH/fovh+5/dJmBblsRpeieQISHazfM5Rji9uKL/zNi5wjyfPO/vw+zgK2lmXr0HAZpI6tLmDagxWZdIrt02AYiyssn7afx7onXOQLAUbzl3N0leXddXvVWGGzzteD3B423RvDG2NkKcJicN0D864ssaqluttrSo+sqA2K9dgOAl+fZNM9JDIUtCDmE/fPSywMU3ZifSxfiDQvBDD3hb2FM/eNzF9qb3mWjY2C/6Hw112tWSNCLOoq5l0mFTMIfdL9SAacNz4QHvf/Z02PKMGAtifHFkEobc1GT8w+0d1+NlIFx4r4yIoYng3lsTmqPmVgEeIdoyLl316gNTFa+0bewcBgqclWifmXQvGEHe1Mk+t/njMHVRbH5e03jMFipNX1+8RvwW2jvFabLYi3O0yLFEoRuo2NpEgEGGIm358sRa02V1YH3QvOKxutP9N1UalOo5hRQSndvpOB4Je/F3BNi6n04MW3km6LY8EQ6uqBZrnCRao6DeIjPy8y9ew8vx9G7ckUCk6b8oJ1eUGTqXEnSd5XXnGLhFoqEeP/G9pxuldS3XR1hfYj4FJ0ioOmDYagHzV8IDJO81714v1QWT4jD6yc29KiyRDizGtWaYwzaUA9KQtDISIdkx6/N5Gix/Mqq6jCS4NpNjiqsOlNpTg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9770648f-bd46-40a4-1288-08dafb0372ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:06.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44eVWiRDmSCa8bz/+WHWSjQ5C/EnYHIU8R1RFQJ71YEZpI8hOGzl86J26AHLPRErjQ0yaOZpjCUXFCdonNNNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: a_ufg1atntQOxTMBf2uWRkBdaHM68IK6
X-Proofpoint-ORIG-GUID: a_ufg1atntQOxTMBf2uWRkBdaHM68IK6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using vma_adjust() in preparation for removing the function.
Export vma_expand() to use instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 3 +++
 mm/mmap.c          | 6 +++---
 mm/mremap.c        | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c372c09e11b5..287e340ced01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2839,6 +2839,9 @@ static inline int vma_adjust(struct vma_iterator *vmi,
 {
 	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
 }
+extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next);
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
diff --git a/mm/mmap.c b/mm/mmap.c
index c1eb353c16f8..4bb8d219b53f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -637,9 +637,9 @@ static inline void vma_complete(struct vma_prepare *vp,
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *next)
 {
 	bool remove_next = false;
 	struct vma_prepare vp;
diff --git a/mm/mremap.c b/mm/mremap.c
index 30eea37f9fc4..1b3ee02bead7 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1052,8 +1052,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 					extension_end, vma->vm_flags, vma->anon_vma,
 					vma->vm_file, extension_pgoff, vma_policy(vma),
 					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-			} else if (vma_adjust(&vmi, vma, vma->vm_start,
-					addr + new_len, vma->vm_pgoff)) {
+			} else if (vma_expand(&vmi, vma, vma->vm_start,
+					addr + new_len, vma->vm_pgoff, NULL)) {
 				vma = NULL;
 			}
 			if (!vma) {
-- 
2.35.1

