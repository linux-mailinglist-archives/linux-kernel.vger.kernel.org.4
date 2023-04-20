Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5BF6E9E26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjDTVyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjDTVx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:53:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA901730;
        Thu, 20 Apr 2023 14:53:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KK1lhd002114;
        Thu, 20 Apr 2023 21:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wX9gDl7MwAkkjyL5VOUvTctIf8owQ51L8PKd1cTmMaA=;
 b=l2nyumOkMnvAgH14dmDkBgdwYq/UpsszYGZV8qle9LjwTsvyaogxDsNU3vkjSYTAypZl
 uPy2iH/crATRzuWVRBN9yK/RG42B1yb4TIkzIkTNnhzxM/Or+PUpjJ2XoqRa7QJGMfV3
 u10VGVDdGK6Xucn89GElK8mf4feiIuafEFMkZktcGGKhm/o3Vy06F2uEJDoumhNpO4Cx
 LEl2vqUye4pfLzdTjhJtcXDBDY9arwNT7AvWk43iGE+G/NcYMhrupS5II6Gnbi8TNa3l
 uIktl6xaOp0E/jsqRO3a0qMTqbkEf79ZQSaCGS522gF9LtvNzky7ENdhubdmAjuuTdIU Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu40wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 21:53:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KK666E037795;
        Thu, 20 Apr 2023 21:53:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8ug3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 21:53:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/xqLcQpfWFY054qOEX87zzOABp2ZyD1YHvoPCvL9ZlXyFqf9zEyWBuhMESrJpRt2nFL2qAqctay3aNKTTbQeJ+HoWLr4cpXr+HxgMc/j6RR8u+7L84J0P9Nl+TkcpV0KBzRlzZVWp23dZVVHltOhwgKJHUGNoQEz2uWpUOz/2XsbNIZy5lpyl9vFm/JvpF2jzf07fzTh/tGNUiUSXZR5tA9MoXSRIV1i31IRgNpbR78qTiKt9UDsmIYc1qfWmbjhWEpLQ41cwk6Tg7Nw/bxWphlXtkr2LnFtXcOxuXlrjUnTllAsDCnTNVhttuILUqFiXMINg0wHIS+UU4OwWyuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX9gDl7MwAkkjyL5VOUvTctIf8owQ51L8PKd1cTmMaA=;
 b=N7VQcNDFH+uVrYYBdzOfNaGHbO0/AM/rDyAL9gmOPG2uMpbycb+v80OGvA9adAOfm5i+neK+CVj0TKJPT+ksZUyn4kuqQQT0OfAmzuemyAW7vi8PBPegCSRn8RJYWYqX8CJrH7qhaOZyLycF7/Y7qdCPhC2mee60fAjFnRJ1YfDMRgNpMvnUkcpv8/edDuGvvZjCgW9wo+Xm9iupnSVxLDxRFdZwj5mSwFH63D3LQMOhtcPOQ+HgMBjvd6St/n6ZMHo/CSt3pBmDFFUPQJ1dsebIJ31ulmd/X1bBYD1GTA5N+w68f7qi+s+S2Z+ejHPKv/0VvWXJQZfZCI3BcQkOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX9gDl7MwAkkjyL5VOUvTctIf8owQ51L8PKd1cTmMaA=;
 b=xJlAqp9x7LeUvnP24iUPz/ITFukDbck/IXpKknDCKHDe2SSzl05D+dUlmSHvOE1XJyPOufhgv2eZVn/MGrR0ko/FBt38E03OXU061GsYizWaldsA4udL4ixjemV2j0x8H2ySOc6gYi9i8MxNIS5vcQ9yg9SetZzwv1Nrw9oxFbo=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH7PR10MB7036.namprd10.prod.outlook.com (2603:10b6:510:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 21:53:47 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 21:53:47 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, axboe@kernel.dk,
        jmorris@namei.org, serge@hallyn.com, konrad.wilk@oracle.com,
        joe.jin@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Date:   Thu, 20 Apr 2023 14:53:31 -0700
Message-Id: <20230420215331.88326-2-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230420215331.88326-1-junxiao.bi@oracle.com>
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0046.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::34)
 To SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH7PR10MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 8475b27d-7caa-44cd-898b-08db41e9b7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cStGXCJumBZmjK7y7/xY93wbDZzDeNw66HwieSMtfsPT9TelKch8wrVrJxAXpnFX/51yEgsROPoKt6MLq1pUsP/8tDfPFRf4MuJ37Ck/VvBKdWe3f8BjuYl5vdhhHHUWzNshFmPZ+S77PzHZpI8eKA5BlGklYenKUHWqeP9nEcNJ3phwFDNHmOclk72GEPhK9qTgQnCpSZVPB2uOm0rw9suwJPmzdHF75cWamadbP/sj9NqUXBGsYhRpbuQnK9m8+EV5s8LtlpC0RCOku0Xm3VcH6tDFw152tgkUt/DBzg/KFqQ/JsVdrjjuSXV91x/Ny2bvs864G4sdGmwywCQdRfjd2brBgNx/uTq59oWzd1WrfwoPoqsQbAbBpaKFWDBnLi5GC04L9OoQ28yvniHzELAUGYeuE7peJ0znLklEpj0LN8a1xpFdXT1kBDaJZ7CRwWYDNT4aYP6raPVHEjx+LM319z8BsGhVZ5uzsIkjfnFRQwXe0LjoTpRTs/zgQdlgzMl9QyrgLLKw0MdnhVu0qKYyIHJ+8+v+ksFOS3R8dWErW92zJQCWuoS2Jdj2ML1v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(5660300002)(44832011)(2616005)(41300700001)(83380400001)(86362001)(107886003)(1076003)(6512007)(6506007)(186003)(38100700002)(8936002)(8676002)(478600001)(6666004)(6486002)(316002)(36756003)(66946007)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0w6YP0qNKeh5/qcqdLsJOa9BIDgbrk1IqhSHvQJtwSPTRMIHSlWF3lzC4UPh?=
 =?us-ascii?Q?gMgAlsIfMFQGdI7MCybyMzIeT+GYLoyxLMtguoLsDtOQldj52F8qF5vH6PJe?=
 =?us-ascii?Q?vr4dY2bP8cubL7CdOEcy9HSssBKroenlgCDlrgcOlJiE3s4CtTtBrPEbPqzO?=
 =?us-ascii?Q?M7c7aEKkeRMpavF8Fxy6nqq9R/Fnnj8PdnrH8DVcd5+qtm8xxMhx3agV5qA7?=
 =?us-ascii?Q?VaNkIlarBeM9AYizNiAC/TY12SmtSGmdEh82mPHAvmHUCk5UgbDs/FMZ4OD0?=
 =?us-ascii?Q?W9bNsxTEi2AG4wFAjBeUyXQuds5Yv/yqEmUssF9/KRfCjSkRsQDidmy3RRNo?=
 =?us-ascii?Q?DntpUDp2X7ql9FDChxqDd5Wt4g57O6Kf+62IJ3U4Gj5MK7lycMU20XWUeA+q?=
 =?us-ascii?Q?XNeevhgwwrSjZtZ7CfT5rN4FxqyBQjaJC89nFO3zfTJYGYIqOFB6r0gs7QCM?=
 =?us-ascii?Q?kzlmAyoZoWnshjc3l9VWWUcEPKALTN31ANaUFRkUrsLD8rvbhzD/fLhj7SBT?=
 =?us-ascii?Q?YM9sKqI4FcDCi1XeRNzkKv3kziLpofxRBAiOKYrAznUXo3fAPibnVhzhlQzO?=
 =?us-ascii?Q?zVnfXCguSCINu3RTaOiexIxHbwb/fH1DchuYApn/CnYV71Anx2IZvsMCt9aH?=
 =?us-ascii?Q?B9w0ebbJbt+uFDgaZ7En/VUkjVUGgqBWaYnS/FARYdoYBY0zl1euITJwMhfx?=
 =?us-ascii?Q?1Nv3dBqZve930w9wZeopx3/t+oaO3RVGVlCIGeZXuHAoY3nYVyH0Mjp4ZGYQ?=
 =?us-ascii?Q?wWsJy4AcPj3KMqExXr88SGjyTtmjhPFTqtN/JX+4fK5EKL05rsJa6uu911vw?=
 =?us-ascii?Q?d5sqYXtqFFAK27bqopfflsEtOrJsjhrjML9P8miXsUyCuNnM87GBqN4Cm7cy?=
 =?us-ascii?Q?0Pl0S+MrRgQ3cLsNoG1T61sWN4o90woFu9Scr7Iq3XPg7yjkkM5gG8crw7+c?=
 =?us-ascii?Q?XV2EX/uMW6K/DjinrtYT5qK2jwkI0QYlxumwd9A8da3MyB0oze49jlVmEbPR?=
 =?us-ascii?Q?aq4q+pR+M3SbJTCWWnKt1zOTaMBoJOSKk/q6c1+HQKSpGukUVsaXKlUn9rYT?=
 =?us-ascii?Q?BsvrZ6jMWO3xyzFaWmJCapwPxOIqifJlce33w7H/5HgWVkSI5+F9N0YxP+/v?=
 =?us-ascii?Q?PR/z/vABSYkP2Csg8KDc+TCZKNSOysQO9QXzrDgS454jzsWaax7mbxhM3oBh?=
 =?us-ascii?Q?p8Ca8SvvECgKS72pAY21DaXOa05LApJe/xhM0Arv36mB2gJJywKm3RYGP3aI?=
 =?us-ascii?Q?ljNo5mONEddWY7/XIBVfmwSdlEgpzvGGiIEkZOIVOdUFffGqDl1/yRuhVvrb?=
 =?us-ascii?Q?jwxefkeiHy2uH0M7exmjjOQwxL4fzr7vegnnj0LkyOnIwn1oE5XEU9yLvuin?=
 =?us-ascii?Q?BfdDH/MEaKJAVjMgIMK7c6BGMvHflpjJwZmnY+rrARwo/7A2DY6+sfbA9NaJ?=
 =?us-ascii?Q?BY04kc+TK5Y2AiwFUqT5NOhefOvw+SSDD68h91ryMyAHek/1B1puLNyuTbxg?=
 =?us-ascii?Q?bMAFVreWXsl2iXR8TFZn+yQw6EunCzBtBsqt91U6FpaoZDW/n9EJugzVYtMf?=
 =?us-ascii?Q?QLAzbCXNwejbE4B4/ogtitRCCEI7wls3tfnw1nAjF96WN3REQj/gEgOMhK0O?=
 =?us-ascii?Q?fWOy8vOsMubyZWn7IOxjJjM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8/teiFWywI+2Mj+wtW7IKGiQ4nz1HKAcQT5L0SifLzS6LjT6Jhethhai497x56Ta9ZOPchGV9lAENoD9gEmUmFJkrDFEpwRHlZ27gt71iVRDDFhRnPh8qq6v0G38FNSsnKa/rm3VGnwuShv9zpsZCX+7teTYYJuJyIasvrzZw9wAt++Ce4iw0aZkQPjz0cT2TuQcFC4A5pZX6KB6GgS9waKMRh9c1UsHSEU/+fGgBnIXgNJsomTQqgz6hUajemkvidjL1Yr8WYd7NXy5Vfo6zu+XEDC0pd7XpMdQZF4NgVGjMg9DU9UI92QfqjWAa8CHaB7u5Ski4M0PABbQqR640sdCe/S4gFjQsVyqCOTkJptSPDc2uCIblGN4uzLYYoUu2Yleg55jidvDeH7k9vJVcs3eGozEkByGKaCdcRSDUyWEmCeUgnpkbSlg2RHYWLwyVqI680TNe3U7kO3j77pdPR4YulkHSyI2jnfTY+1viJt96t7ns4cDKhyAWhLTBYxxHCk8Bqu0pzxgEFBqV/H+2J+FaY1Wx5XH9ULwPEc5dB6KC7elQkg5N70NfJyKgcWBsWtO/BdBvwH1sOraA09v90fHYgEx9cgEH9lUXKpVbkkWBiNgYUhVvRmPs2Bk51ao0yHH+rejBHl+RvDQgkxKT0WVdUpLeYLqwG2LT+uHfRrZPTIIID5Fk6GEuE/uJuYUwCQhcT1BR513jXVNiWbT2+hmEY51JBU4ZJiRDv6QqZNeq8s58kMgJHc0oZFRMaKsyLWqRpnFDCUJxalKX6s8TcFwsYb5I48gMDN0aw4KC7bsKHEzaRzOxKL6X+VaNU3VtJVGdE+UIVn6cSdVGKbkJSssMxutkKLBuf7JraZXGZBkcgbAtecC7T4or3JhqNq0RFw7JWkuiTBsT0UUdznYW6CaimeEC9M3tO2mdAA9njg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8475b27d-7caa-44cd-898b-08db41e9b7b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 21:53:47.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES19ecZs3TZgThBm68jH9aTMota3q3yEpiqmNVpgTUb5FrsDbGKgWVNd+RIc8vRpiuGYDpZUc20OhyLhoqTHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200185
X-Proofpoint-GUID: _nEKtGSYN58_925wjIfNpUeL4LuoX7mu
X-Proofpoint-ORIG-GUID: _nEKtGSYN58_925wjIfNpUeL4LuoX7mu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blktrace trace files are per-cpu relay files that are used by kernel to
export IO metadata(IO events, type, target disk, offset and len etc.) to
userspace, no data from IO itself will be exported. Bypass lockdown for
these files will make blktrace work in lockdown mode.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..e1a9f8b7d710 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -490,10 +490,16 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 					&relay_file_operations);
 }
 
+static bool blk_bypass_lockdown(struct inode *inode)
+{
+	return true;
+}
+
 static const struct rchan_callbacks blk_relay_callbacks = {
 	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
+	.bypass_lockdown	= blk_bypass_lockdown,
 };
 
 static void blk_trace_setup_lba(struct blk_trace *bt,
-- 
2.24.3 (Apple Git-128)

