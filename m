Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380A26759FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjATQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjATQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE01891F4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:30:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGDi0K014958;
        Fri, 20 Jan 2023 16:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MBEDGhtN7BkuDoCi6obfXZugRKwkp4Gt/hiaxbRJ8iQ=;
 b=iMScHM7fG0Iu5Eszf2dEYa0rzJe2bIUDkvNxp9qYIcept4Ngnkp96wBQssJ321M7Z877
 vBfrhGqIcbf1dcKdXOnBY2vObJjzDQTkhMDiOrpUGGmgeKmokAzSUdYoXClyeovODgLW
 fg76pLiu7r0hfCaWlFfYwsvHnC7jnG64CDngKWnu1RzqkU1Zi2HsTB/PbD5XKJ//ftCW
 oQVxqdEAlnaoXmo7FGxlySzgyoAAEaR5SlpIC9ee4ug6WXz9X7Pp1lqx0VN0HZFOOdz1
 zQ49I+T2pxzDAG+48ShRbA5AUhoF1Jp+ElMxGmJ0HYFxiYXl0/hLQn6bn11wJCba+sPj Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxtd24e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFMi44000775;
        Fri, 20 Jan 2023 16:28:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2swdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhWkjh09+233Ab6myFMTpYFArO8ke7wn8AL/QhKfeguSobzSRnwtNSM5MLxRLZ8OaEftIK9sg/SqvJdnNpFM6YjNeQuukzhqrtGhib1OEYfYRLB0uZzBw7Ph/CpMGz4+670QO6kagA0bhj1EA2F5HdI64Q37ZnuEUqw5RtcFFRzUCA5NPwkD2373V4tYPhoGsj/+53wpYoeN4yimzZ3bXWw+Mn0EYZ1L634YSLhYhkTTeJwSI6HhjXjR3bygmsxti+ZEkR0wWRz0dpn0d4bWtvo81tlMDlDFZDclkXia2CT07+ZBAAsRdq5NhoII9AiiDaAxBybVUM/nPbSLNBMtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBEDGhtN7BkuDoCi6obfXZugRKwkp4Gt/hiaxbRJ8iQ=;
 b=fiSrj41YiXp+1CjAGFIlAxV5tgVK2ByNhWAqtzOX2L4piIWpHvdRebGaf+ErUZAgJdpmIsjF0/TZNZIpjUHQeLjT/K6VMiQ58rSXNu2kkQX9NzsGT+WWl0LVfeQPImI9tdUwMMwPnnBuif6634e1B5EyGpv2a2lGAMmPKBAgnd9Uuj75LCnia2dJvSIBLgPYmhB8UUbS5tzx2tRfzxr8G6ti5VlmkLbYDYdZ0WyLobN+qM23Mg8+XHM1gsPz7SsejShQKb5Warg7iHD0AEp9dK1t5amwu2IvqvyaFK+bPz2yKpr+xsjzrpmkUCTmW8uqo/X9h7XTtFuE3gGp72WS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBEDGhtN7BkuDoCi6obfXZugRKwkp4Gt/hiaxbRJ8iQ=;
 b=zOC4mqlBguURIXBR3hSZyQ49gKVsc0kywBfOHDU1T8CvoUA7C9eRfTNvcegAyZLNXJCa5hmfIM64ZY/yd2yHVnm7auBt8njaO+DtQZh/svkI3EJDTV0kF8V851pFQqR7QcO7MOkgPXSZXY0pjA25KGG7pDApGMQCVqBmyjGjVTg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:36 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 33/49] madvise: Use split_vma() instead of __split_vma()
Date:   Fri, 20 Jan 2023 11:26:34 -0500
Message-Id: <20230120162650.984577-34-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d724aee-fa6a-4573-8e9c-08dafb036192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdfonDVj1uzqsynoFaFNVbfIicBbOuRWwXUaQztXqmi/sNpo/pJRZQm5KXAcjx6+S0tGB//oPhSTg71aPAe6J8TieHW6abaZwnmc3EDTlFTOCsHQN6zavb2uLW+NVY+SNjHEbhLqV9RCyHEAQq82cOcsbj87XzFYnMiN91B2sUdL+8Tc7QkuEr0YJ5VbNe5FfE0B2MgtPTkL0EPXUkrAwLKVpXaivk2QzeL9hXQj/uo9jF+VkSnNF6LXCog2Km7Thqo7XYk/ewdthWHqJIdbDBOBI1nM6eTKl1IC9yHBaeP0LcoamtyRzqv3ZT5Af00J0yu7CYGWWeXlBVTSrgEhMk4LsIsePxC5zRh6nluHrJqpbVf2Z3U9+xhUZ5Z/vPB5sIo442k36twtvrSkC6uEYj11EpifMc7rSsBCcdM6dNQveb6zsqpxZnHdDHuWcfyWesa5d+jzwORrsTsgwl+NEMfotUkXGAv4Gvxlb2oe3qVnKWDnLeJ06Ivx1SImfCRMVE6oASuAU9F9PDm8XDMjJxFfFJghA1BnWNqrFiME3HuQR21KTzwqFpaSUo8cUBuKA1ANQEUkbBhk6APuo7Iy/FF21Zp4ghY1J3K2LZmbo4Qdb+ygbBbRb0we1mPpUMmTHy34pi5DrECizkfL7d19sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(4744005)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BzMnoEwJaRj0Vc7WZln40jSyx9nHZ+eUZggZxOADBG3+VWUvbCtsDpG46YJg?=
 =?us-ascii?Q?IoC/xLgE7pdEwCSR5eiQ8JsDfba/xuLRLl2ikBG/1xQQwSkRZiAlw2WS4l+n?=
 =?us-ascii?Q?tayL/awVE2wZw7EcU/EImrktFl65M9UHSqqMeqUDgLpWOEKFP/vKv5/Hde5o?=
 =?us-ascii?Q?cNsSeYyc5ytHby/hfFxj7hFEcZh45J3vUhd/GJMW3V12icT1Y6RpSrAGZFsO?=
 =?us-ascii?Q?imjFcGaiocQ8zqX1sgOzVPQmP8PrHyhBfqyTb/2lNGX21tatoQW+r3rNn0Xg?=
 =?us-ascii?Q?NdUmJF2+5rvlPJtzslV71ua8pX2YK4pAWaVTEP3BRg9C9KDGlbSkqWWWvJ3J?=
 =?us-ascii?Q?VpPhGLjpyEL4Wex1bQk6rJPfHhiCmG0KRofUvb2FunwJGXpCW2hbXOiEqTCp?=
 =?us-ascii?Q?c3N2e7kDzpOPjUae+bZUfDlwDheqEDcHSR6Kr2xgKN2DDsxcNcgubpki1XS9?=
 =?us-ascii?Q?WsNc8OC0vOCAdNuyNZKVj2s7dhdO6V3ehBNHbhdQxelFlgCxZWA8wF2rvp0t?=
 =?us-ascii?Q?9Ecc6GjvD1RvFImFFcGYafXq6sZal8YYD1mZfvHH2waQmuV8StHeV2wmmNfQ?=
 =?us-ascii?Q?1Xem/1/J9OaWH1UDO3kVSBMY1L8AQa00h8Ys6vfnKJxzk8JyCBMQgTLDizlG?=
 =?us-ascii?Q?VhHF+BY5cbxb3dfLwkutmOaYziKkbsPvbM/PA0ScauOikM0BGCee2DYIzrkK?=
 =?us-ascii?Q?aXCOuQM2CNpu/OGQDkCr5Vd/Nf1hJO7ioYVOMUfKdz5n9P4H3Vvg0GIIEBP3?=
 =?us-ascii?Q?opoWKz1CEhcDAqmHV9H6YaGlmupjsvujG6cedjAykgGyaSD+CWkaL3j5e7Mz?=
 =?us-ascii?Q?F2AvRcTUc6o+tuz0UUMOFqx8qUC5Q5E2mVpw70HCNainnI1r7FtD8OLjLq+Q?=
 =?us-ascii?Q?0LibzG/x1eqGKW0PUg9KMI49GJtXKs1dmXDpihXrh2smPc1ef0hR3JUHODbU?=
 =?us-ascii?Q?p/RBjTS5V0yE6g9Rnm2GFM9UtMBDDulANPAXrGVrwQOvcbLNjn5PC4oeyb/r?=
 =?us-ascii?Q?USPDob5iFXi2hl4XcUnW07DQFcyr0a+ZAPTVwYnZsSz21Xi0M17oBgTqkNaD?=
 =?us-ascii?Q?rJn+ZY+g/NJOCgyYA3RwR1KsI70C3QwaPvg6p8g/My04sDdFFR5RVDiqqmpO?=
 =?us-ascii?Q?KHUPrUnMVQrhkDqYIWncM870c/t4MsH+3YrBcJlWAkAJS7Ko+ynuFhOnOml5?=
 =?us-ascii?Q?2SIbau0I4LkiKsGFY5oxqfKRcJRWBtaEj9rc7T9A2lAPzwb4UoTsAtQE1eYU?=
 =?us-ascii?Q?Xe+khA+NrcfQ+s2vSLvsgiV/BiNO2jqO9DcS9MfJcUa1hr4QGNjYkXxmpmG3?=
 =?us-ascii?Q?OSiT3HqqhWdXOXFS0GLRs9EfsZu9QV6DHy5hVR0I15YKQIDrvjvqENQWBFXR?=
 =?us-ascii?Q?Ylzt7Ru+4PgqWwdcl+mzvfG6EI6Oyn4Hv8zpMwBNbU70pFZHSM6+0SFJNWiG?=
 =?us-ascii?Q?fV9qWJZ5j+1Ya38QMulyF17NOMbqLLQpow6DJu6Wqcpii0Z0eMTG6/n0xwkb?=
 =?us-ascii?Q?JvCqqfSHwus0xviiQC4STXoHfeM/CKxrcE/zGdQNi/iquz5Cv8wqSyVLXCIE?=
 =?us-ascii?Q?Z25EPAmOq0x7fjKgXBTzLTiSilWAFM7zutztNxFS7X6YPgby4VAt8y8djvZX?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ixy+ZEV+PONmp2NtR/SjcFpiliMZ3Hmqsr8g2PEoiGHhXnN5JHQmuF/y8z/2GelFJ1/n4kGwBANmaCuUINyRS1v+s7k0PcXTL2XpwtVnent1P2tLbEWyWPB0NkibFFRyirPSFfFjNCMu4YC5Q4Pa6zOu99rfgEbyAUNDc/obU1cHuWskT6qfv6FowGBGr0BIfn+4Xs36u+iJvg3jqRa+2XdyCu9ggf+wHtGNaQ3gvz6ZXdDqJ8FQVMHrRN2TpnAObzSNemdy5rIGTpJDS1H1THVhcv01x0xXlHMKcsSLipAadg0P7E9sZhflu/pwoYbLuZmgmOejhGxQJdiBpkZl6l+mQNB9kh4qHe21er2C1LYJ/h07myp9q5aMHXV0vC6mbaFr3Aa53kvL3sLph97FX/q0SCFgETdQHkJNMwxP6P6Kkhh0jrCtvz4qqIauZEhnMwOY3dRiSnI7jJIZCVTJ+vMnskU3kFSGAvRsk42+13a2I1fDn97eipnRPk3WSI8XdnKc9IC/r+UmNU2pCh9vOeK51kgBQEDrGeNubZKEFR5Bc2EeuyF8Agbcqw9JmeVvYBQWbQszra1QsdxI9cx2reDmPrHYx4VYZzq1oC9dmPfT0A16zzh5TBTsVor5hN1gzM7AwbI8kwInA0PbbvPfCMIXfaQQlAdYmKeK/vl2ZPJ/0J57vIXYRhOBjUFQdphbLquED2SkZ6X8215XP+yOMrHJbnJBljKVTtopjQT7n0TJmgf5cNPb91mrLIR/14NqVDQhwMKzOybDH5HOvOm5z0z/ho1PpTsUau/232p8V3NYMsMmoY7fMjd3LsVAvx2Qo4WitqZjI1I1Ql3CQEo3NRUUC1VubvTWN87SXUhKl/VLcnsGOnmfU96j2ZTcYrSSq0qykKhBHnazgitRR8W1/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d724aee-fa6a-4573-8e9c-08dafb036192
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:36.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu16Ta5VBPDcR0dsb4+1hLSQnrZbr3XwWe7C/wJb4PlaeTtN086WAPVhemIkyrvNDdQKFmAkjlWiWjEuZ4G+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: Rs8qyejwSrEQWaQBGCKSae-xIckzTPEA
X-Proofpoint-ORIG-GUID: Rs8qyejwSrEQWaQBGCKSae-xIckzTPEA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The split_vma() wrapper is specifically for this use case, so use it.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/madvise.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 02b317726c9a..7db6622f8293 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -161,17 +161,13 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	*prev = vma;
 
 	if (start != vma->vm_start) {
-		if (unlikely(mm->map_count >= sysctl_max_map_count))
-			return -ENOMEM;
-		error = __split_vma(&vmi, vma, start, 1);
+		error = split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
 
 	if (end != vma->vm_end) {
-		if (unlikely(mm->map_count >= sysctl_max_map_count))
-			return -ENOMEM;
-		error = __split_vma(&vmi, vma, end, 0);
+		error = split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
-- 
2.35.1

