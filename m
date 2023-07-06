Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8374A257
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGFQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGFQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:40:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515871BF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:39:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Fx3m3012997;
        Thu, 6 Jul 2023 16:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=csBh4HSSzCMWoZjVgLKpsMLNsrSVfG4zddz20S1OWx8=;
 b=JYX4imV/LuV4pBfvWryXHZJjX9WN8QQ38DXmrfeKifaYk8kt3Nb0VwmXbwl/Ojth6TZr
 0VQMKqWkQXzLzfsxODl4vk9r7gxSMsp7GewIexvhVWpWP4F3wwH0Jj4WibloGOzOCxWr
 7KYx2YQopJUeqeRtj0HjgXQDtTmE/nSk53CWgx76ljYDBroCeGROb7CqxU8f47ksEgfr
 gQUFDLYFzd9X8Wkcw29Pzr2LRp3YwJnMm+Dtx1S4kv8QfPd0bcUIDDDvC9bC8fO2eVRz
 8o1P3PGqssVmtQnVUxWSX3K7a9p9QyNcqYNtkrM2ZOT5mkDV5O0YwEcRvOtpNjnVdGCT wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnx8jrjmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:39:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366GXnsH013569;
        Thu, 6 Jul 2023 16:39:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7av8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAEyde2tffHN201Ivx4XH0LNHCYOjE0DG/H37g0bPa7bx3IohT03fS2uLr1eMRNITbeed+fENGBwYzyEatDcJjlHXqObi9lfkfRA2d93JxAGvupgspyO1GBg2TNXtVfKxS3CVt+3gqLECARk2mL0yUaexOlVs90luuPb3r99ktQivTKz2L7d5ltFFCAGWhhKvmW3Qp0IY/Lt0fyj3XZAKWs8QQfSJKO0i/QWUEcQseoCSfxscmHXlVD5CgbGmj7ZGEFWFntNn+6wNWwP930MktXJrxzojI5sspR1dpQJS0FDn7BerOypoKXWReOJpe/DUxIcKV0/5HV3RIy28OGeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csBh4HSSzCMWoZjVgLKpsMLNsrSVfG4zddz20S1OWx8=;
 b=Z/Wy4wcvlZVraNbFsFtVbb59OQtpUxcbinnga5X9IOSYOkktwMeyaDJ/7Avkel7oeSc53CtFEW700hwDqnctBFHxete8RTjmbeFYBlf6iVJIfPi18L9mG993MLNbwf8GamyCTYzaFQvMExRy8wtH3XTdEi2Ews0a5ipllIju9CH3GAfjTpy8MjxvIkOLULM1kK4xYuOJKjFcycdCTksFtK0Rb93tSK9Wso/DgOSBrVIMAO43VkIB0WlkYGQJN0Dt5SoaA5VFcVaCdkqG7mQBWuvAPQ+RaoAYxP6uKWHCkLFD39xFW9MOqfFrZ4avGdwUIWoj8ALtUUuA5K5V122vVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csBh4HSSzCMWoZjVgLKpsMLNsrSVfG4zddz20S1OWx8=;
 b=q3GIDNRbAKczIukMNcI549KCZ7/7erJRep0yMSk24s0uups/ctkhF0lT+RLxnDIrnEv18qaHUNA8m2QGWlfE4nXifhDY7++/vk/4Dg2w5GcN3+PTEj6vE2g1+4r8Kn44pRyGe6VjU2mBrGl20TJVXqxh1G57z+ZHcMTWqFP8tZ8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 16:38:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 16:38:59 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        zhangpeng362@huawei.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 3/4] mm/memory: convert do_shared_fault() to folios
Date:   Thu,  6 Jul 2023 09:38:46 -0700
Message-ID: <20230706163847.403202-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
References: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd6d229-86d3-4c9c-120b-08db7e3f7f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PenC84z6mWtPU2HnXAeH34qf618yBoAGGHrLc4gHIV2jy2yJGrAa9TtiRFCjqLsrmXA4gzDCg04vSqoajLSnH0V6+ysklKvs/5GQ+wrCfCBfgpdIAqDhFNL2ZqJKirGfYYpeliXJCRfN2oG6dNV7NsIXoot5Ju+ADN6WqFwyFT1R5neogrwT2Hl7BR6wmkKa2iR0b1T3O9zonxmiCWdoFv8aTGu1ePj34D8/qrN9oWO4Z+FXoJ+2j7ZJzIW8g774WHTNMMzlPiTGuTUsOxIXqpox7QnZTvKKEHu0l0l4REiGi4RM3HK5kIQFVwn9ieVHouddXBXhMAZ0Yw9stZ+nVSri10rGnXoF8g+tD6Mv+F7SxXAcsPsxAGgblZHQNuCbUtOjeMzRID3ci1bXBaFpuzka9hIuNe517uERRI4oW9g13ae/sj9Kb2p02ClwqsIGMvEUXkZfxSIcitIZetusSWZgSDH6aHlxv5/kraqvwHOzRjhnpsFcS7dzCGqyyRmprbaNC+RXU7zhlTaufnmL0z4J2nAjxPsca2pgzcnCijz8rv5b1eUSXNdSjhoV4rbh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(44832011)(66476007)(66556008)(66946007)(38100700002)(4326008)(41300700001)(8936002)(316002)(8676002)(86362001)(36756003)(2906002)(6666004)(6486002)(83380400001)(107886003)(6506007)(1076003)(186003)(6512007)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ny8ToL4aF75yWMItrY9i1ck3w2kME/sjvtEWx0+Ns+lp1OY84aTTUczauth?=
 =?us-ascii?Q?yhdybUngmWvQ7lSoRNBo51Kt9rvMnikwWslzChD6gYd02RXuTk/rUFZnD7nP?=
 =?us-ascii?Q?KYVeu3l2+MjmqUwtYsN/Gnb3Py5BAOw4CwUnm4sL+NSz1ddU82derSKZy10w?=
 =?us-ascii?Q?43pbjPbi0GttnKBblJwLt1/UBeZHPuThqp61lB15a/o6AQeCeZWr/s1pRmDc?=
 =?us-ascii?Q?wUY5qp7+LPGCu5pg8dXTSz8yqYYFJ88Swz1kQ884ia9Ad85mpJauveOf3uIm?=
 =?us-ascii?Q?aZ/6FbgFv1fPNMqnVDqNrYkQAgQek/lqDMt5I67USoEr8sVjCUemHJ+yTwTK?=
 =?us-ascii?Q?igcImvpdJQhVBSxhDJdkAJG8auzeGd25aBwsuvnt20poLiDrEOh64/4lMPEh?=
 =?us-ascii?Q?LHNWePnKk6e27ZdW4/mZZaI0z2o0Sy4cuQp0X9prgdW8aD08P5IHrKcYPsGt?=
 =?us-ascii?Q?m/aLkEGQLj2zLC7LmCd/T0vC7ZYg6efiyFdu4e6GKNa+TzQjOtcoWX9snsDj?=
 =?us-ascii?Q?4n0s1ZalE3ia82fmSvLZvpMkCJB/aerxcWtMyO4fuDGNxuE8M6aUrLP0Qboo?=
 =?us-ascii?Q?JqvLX3KqTEyku9uXYKgxIrie2vtAXaDTXK9cz+0cScgYa5fwlL7GM/7obGcq?=
 =?us-ascii?Q?FDx4+Td1c/WqSk66b38GJg2XYvH4FpoImCMOrckz8fvlyVeyn3ey+s+CdsAu?=
 =?us-ascii?Q?E4neIi09FjcqHVG1xj2NdMdWp9CCRlv17BW1Ed+fdF2tzeNyINIC1A5hIpRg?=
 =?us-ascii?Q?FazaJRgBrbxreiVz/umUTINEaLudWdn/BeV3v5XAYpMY02p875AqRAhOeYiL?=
 =?us-ascii?Q?jiVNW9TiWvEfS2wM3CBNlkk8cEWhpBdeRlSJtr4NhMiIZrLZ0UwFokb4Ly9m?=
 =?us-ascii?Q?8E/KhA9W1/YGF8sLjzWelTj/vrOVxtVJREoKzk3jQxSasz/tSZ3kzZM0p1nN?=
 =?us-ascii?Q?d16jrwJEke9kYarED9Gq6Ti8YKtw7sH0MoNYPfzVpaDFQcndzZwVQtMUx42f?=
 =?us-ascii?Q?NpbJGsDc5fnqLuXTL8qNiGAUl+++329GClB5cM4U4w7omHuoBKl56eo+PNVa?=
 =?us-ascii?Q?HHocmHi3tXP/QKHJYcClc50MSmhtNDpFk55GtGaIri0Yj/eT9mQ+KLzuMVz3?=
 =?us-ascii?Q?msb3FILZJNJGfr83roIiYA4DazhP1MjluuhfoqriE86je7FFr/aqyi1xcSlA?=
 =?us-ascii?Q?pKTEPj5wKd/NqbBrUD7Tlb5O21tDZT/+DQgHolHrBE/j3fYrZRHtX9X4vgl5?=
 =?us-ascii?Q?bktHHb+wTmsTiGkX457iXToAP8tUny487EGwvhh41E4w9nSo0kZFYiP3nGXN?=
 =?us-ascii?Q?L5kadDVTkS6sw7wgmX3dCVqXYB/k8EK9HBH4oedbJRxgjUaR6ijvAulccopL?=
 =?us-ascii?Q?Yqk2lXjrDKJSpCrdXF2SrOjrhl3REk3rOk8hYjpcrYdLL4zDtG5uFsBKw2d5?=
 =?us-ascii?Q?f1P4xqUNGN0I8fadcmzb1yxKZ0CrVMcGtQAfINPgoubIYMg8vM9FpisTdPPh?=
 =?us-ascii?Q?5+krrIOWYanMNxK3EpRXCpqapbmH/txgwgDuSSJI2rgi2pga5xSzs4i2MRoO?=
 =?us-ascii?Q?IKmOf9aExU2qgN1SX5LsIAdZHUJinfC8GrIehgHUmlvHHNA48y4snXSQH29M?=
 =?us-ascii?Q?X1hFnU0oo+DA4xNFhhMAyUk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aMJu3aEkZf8PZc78zdF3DWztXX8LtnoV7xyv1Bhop57ZTUQ3/s9xC9Uai8DOyuaZLlM3EEDZ/WcCznbOa3L7Bvt8UKnpVFiCRwFfZBi/H8xvLdRiAIbrgjfouR/PWItNIZhjx3RiEnVPIkLuz+icECaJ8r2Ub2m5jIkc6TkA1bc8yhzTdQGL+FKbr2Bn+ZJ2dh0WMsAraAwUInbwKQSR3rI3pX99aUFE7TKHrRS+gekJhAy126EHx2QoGeX1gXWmYAkNQD9OkBPYjaQUEy+C6gSlTKy+zu2zjQ4u3BmkkO1BO/dHLT8+/uAluUMItX7B/jOunooxzuSgRwG+hM07TR5XI7Ot6eBzaJ+jUMfZbj1xy7j5+YhWLmCz8xlu7Kzb6RMbEn7b6/gUj2pgrXVTA4+8leeoqWpE2K1aly5aeHYkVWX38PCf67xMCwQLb5f76u1nMQIJvKFIth1sqGbxqw7taWDMhzN+HdNyigxBhCMry9V29D77QNcu9oKAs7KbbA6C1tyLHLn8I4WlNK/JFWC5aeJaYHpw5NmUj6VopeNWprJWxA4zyj1e7y/6wOTQE9M+Nwr/gRpIecZbolWCj2B+zeA5PI+dQzw/ppFd9hV4pve3JvRAhQ/8jC+0Ur/SNFOAp+wP5zOT3uoEpkJW2X4+jtecYf+Zmca2jNf69eTkCSleVxctU+5i3Bk1sNbPUqbCCMjulTrtSBHDJGEnXuVWUdoxpMp//SNrMV938U05uzZS9jqaoiRy6hSlFhIMeEcMf+3RiwBrHG15s+SCrgLPAnXui1XjjRXEbmtcX7otsgtT97+LdvTSgTud3HBNOegxF48QvkOxDh/5z9ICcoy4qz19u1DMf4ucGZZpnNvoU1k9Ah/dQKZZb0xf1ZG5MXFXiHgo7hDe16RGAKo86g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd6d229-86d3-4c9c-120b-08db7e3f7f6d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:38:59.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucPH6ljJbjlCR23BEVnGJG9x6QF0JfFhbfaCeYH9NDCBozPJ7tzIDBgMRZEkr15jJlBsQunNfo8ux4hDrKzYVVX/nQcNeLCyWpW5cfBQsV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060150
X-Proofpoint-GUID: fveeOjDtPfXO6w6BQCfAmz9DZ1e8gBHW
X-Proofpoint-ORIG-GUID: fveeOjDtPfXO6w6BQCfAmz9DZ1e8gBHW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves three implicit calls to compound_head().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2:
	 - move folio initialization after __do_fault()
 mm/memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 673b9fa67d0d7..a59b10e534c07 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4607,21 +4607,24 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret, tmp;
+	struct folio *folio;
 
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
 
+	folio = page_folio(vmf->page);
+
 	/*
 	 * Check if the backing address space wants to know that the page is
 	 * about to become writable
 	 */
 	if (vma->vm_ops->page_mkwrite) {
-		unlock_page(vmf->page);
+		folio_unlock(folio);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp ||
 				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
-			put_page(vmf->page);
+			folio_put(folio);
 			return tmp;
 		}
 	}
@@ -4629,8 +4632,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 	ret |= finish_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
 					VM_FAULT_RETRY))) {
-		unlock_page(vmf->page);
-		put_page(vmf->page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return ret;
 	}
 
-- 
2.41.0

