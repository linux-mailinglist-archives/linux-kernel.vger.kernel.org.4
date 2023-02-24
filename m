Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6576A1E11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBXPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA14BEB8;
        Fri, 24 Feb 2023 07:08:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEo1QI012042;
        Fri, 24 Feb 2023 15:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=snkQHU6w8ZyOkvPlO1t+4rMVLBhNOb1nlb5fJHYrBl4=;
 b=P+X4rYTkJt4VWJHn5gwimTKu2ASLGaNtJbyc9/0rSgrEDirC7apSl3r6isvWdysPR0WN
 fh6Op+0+OmT/GKhKW7XoW+3s8qGm31cAtUsB0Fk4FahapAjyJo28MPQpGQo/t2stO+Pd
 5RF3T680ia2L02ScuH5lQwBj++c8uO2DtJuAMmi866wYUnq4CNkshtywS9ipgnUkeb/T
 dmZmEZJ0SvsWCHvy11xye65vjE10rhKDRdlfI6tEkcEjk8tI45rxs6FMLtUSQ9uwiphL
 DnoWl4OK+jFcfbjLBL2M7T7pTUTMahlm7AVh7hHYYnZaBf1c3HnJKs5lZ5vAsh744G0F +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpjad7x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODRtpm030422;
        Fri, 24 Feb 2023 15:08:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kw2c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8/uoBH+Eq2LPem1Swg2VBBFEVgTDZb+zod17Uw3x3B+2+9EpoXqjx/SOiTwKkEL2J5Hs/CsLc0c4PnaILN+ONGrLN8AqCLx0bCkaXS6DsBfFMBo93V2i0kK/e659zzhlufYr5HgeHU76+hrGiXX5dpQAsp1MNCorj+118Hyn3/xi7VnI8ebs5nRBalM3PKfMVNCOvZKlviZNUA3lFHCne28Oa5tukc7VV0iybqj+nVgBdN4TqrgjCaa68WJdZTcnW9vu5aFpimocGYLCpkeHzHsnP/Q2TR1WDETB94QCw8ofArlILsZajMWnaKptipwOOEXpBUCat9AILnCjGYcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snkQHU6w8ZyOkvPlO1t+4rMVLBhNOb1nlb5fJHYrBl4=;
 b=iipof0K+PLIOihDts5PWvK39kLpf9mUBwbSq+IOsFHKiJMB7QbE8tOhklA8YXro1lKyWNIVFlghT0nAeAjg4+C0vX5quJt6+gtZvRgId8orNiqoAP2lgA9DwBEsHhKZK0hgMP/4Vv4wpuE6MtmAswgV9ZEd9BcjpKWXx1sxNjWWVpTqmjC47GQ35ZHaiFEY1NEMkokIPH46rhYUq5RTDtOo7R6OK9fiOrjfuq/9CsS36C4Aa31w/8DbOZVBk3KZ/grHZo50WN0LSwJ1MrrRVG9wVj+HBdyB6YSg5GFiug0PdPQwUGh1RXT7SenpE0TXbmnurq/W5+PZlh19hD0jd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snkQHU6w8ZyOkvPlO1t+4rMVLBhNOb1nlb5fJHYrBl4=;
 b=CH65YeG7cyWSzOXpzXEOWzxxQurBK6oEzLQhAJfwDT/HG0tSggWGPYptER7qHL3oh8q/bOuNa7dnp1lFSDP/G4Te9O6QdqzM7B+xJsnWTfXXmO3UwBnbBT3XYfZt8vSeS9BqUmIXYHafyGKPBg04Xbc60zwlCOI6TsXnvbQrB3E=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:08:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:08:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>
Subject: [PATCH 04/27] mfd: intel_soc_pmic_crc: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:48 +0000
Message-Id: <20230224150811.80316-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::32) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec0e723-16cd-428c-4a9e-08db167904fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RL7QAlrsJWh5S8WwFjfLVAs8pHX517g0vG1BskBoYE+Hy4vBk6sf+Xis1yu3MJZdWwgHlVByhLj0c6RJaozppmRFOaKN7OWW8oDJALBSKhncbsI6ESkfkkBP7//UAtmd69WZ9UpKdwevfh1eQQRK2fjyKHuKZmj9FxR3pXlgqAIvpeGhZRgtDdsb8D4pKSA+MI9Tp5WacYQc4ajWRQcgT3gX2rMmwUZrRZk3WukHt/Fd1+98EYXwcWfhcxaRuosu1W8coon/toJNcQ6Y7OLWafkSRX8dleZsAZTgwtbUtZA8Zq4q9ECMWSl3DVyg2sFsxWTxsi/imjYxw/1vyZ3+nR+1ryPFX255L2mk6bgcZQmncA/343cbtduxoWNQwO3Lg3q+Kf00u8TAChBY9WcGwt0HhH5A5M2mU/mTa6oPK2FCsZmVD00J3fFd+qylzy3qQCxK5G8G5NmuTZXthMkF9a7kPGlN/tXIYEqCrez9KXFUWQ53oBpfjZ33bXEoYlzM5Qr+AOk9tYbpOWZMK5PC4Y0DOYSjNBAVtKFtru3FV0rSJBUMkEoNyzbWmDWL85QsdUAMlXJq/y6W22xOTx/cNvAz8yM6pA+6egepoos0o5fuAIcg3j2ib5QRHXNSTKZ8FLeTz3vAaTnhF6aH6Fy6hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZx5c01KdLUCYNUmOSpGnkErXtJ3czSRIn1iGmd4Oli0tg67AUbuN9fIYDEX?=
 =?us-ascii?Q?e5tYg3RZHq/BUlXDV4Jsa8HhsKrtXjtkQdxuAQtf3Rr33ajO5jrOJlj89o6e?=
 =?us-ascii?Q?AVTitG69J/xXtOLm2ScJWy9As9fgv8UCm74NfCqEQEtsor5toFA1vpPGudDO?=
 =?us-ascii?Q?ndg4ZokpKoj5fiLK+7qQoH053fPLpbbmqQ32ZuWCz5GE1u+zudsT4eSFo/7P?=
 =?us-ascii?Q?NGaDhXZpnw8XoJc0d3JgWlEjcO2FowSzIL7k/3YDMN4sZ70+e5aeR0sgXwzZ?=
 =?us-ascii?Q?j2xs5uMBjiPWZwOmwvwx4IigG/joTkt667ORHumMHZsIrdj2Q/duJCZdjQw2?=
 =?us-ascii?Q?9BHhJJ6zkc5uGC3OAiUxz4NFZCyj2cQ6OEhnkxKohs7zlHjDTAHWM9MumLL2?=
 =?us-ascii?Q?g3/70Kja2JqxxR2EzQHrahOEy4hT0KijsbrmCDgSQPXMmmwNrMSEMigL32h+?=
 =?us-ascii?Q?q9kJdA7RQDZMpRnEVOKU0UdxnmjOZaWMqeUKlZiDm02kWAgutat857gcQj54?=
 =?us-ascii?Q?RbGUBxLIF+5qOY2bJ+SqqtMJi9vOFbQ8eykiXa1txzjYwwJvCMSNTZFW8nwg?=
 =?us-ascii?Q?8gCLoe0gkcamSVdJxmSsjPIsoNN56dVh6dyYA+hnjjr/ECjTKntyVAcnjJKX?=
 =?us-ascii?Q?ESJRoRW4UYFTPWU8TnDAOP0Uxbweju7lk2kpy4c3/hV4X9f+jua5v3hcJ9eZ?=
 =?us-ascii?Q?IMoAIDDtrhMy3LjDAkLbkuQ/jW1YSAWxhyFyB83H2DeTUihN8ypijQZ1EBTS?=
 =?us-ascii?Q?PKB0jLPTrfca/L2ESy20C5mCO6YvAVnnTmpCrS/6nhWIx+htfmnW0kMYAwhO?=
 =?us-ascii?Q?cognHHl2ZRvtCopqJqgF24q4Et11pKPCfA1oKD3KT0AC82XSA5vXY3tWu4c7?=
 =?us-ascii?Q?sS+dXuZVa8pYtuUDaVhM+yLrXZhy/lb19ufhqWVPWO2GX7Jkxcm5OR2uWIP8?=
 =?us-ascii?Q?GVrJhucVkFnt9R2Ly5DoIu3hdRgknO/vXkWgLGqQrNAZoYjpxI9TAVeKWCrL?=
 =?us-ascii?Q?JfHnRexKZ9lESYRkvWVvETuIypcjbUVmXTupCzP8+jzwj9fC54DQqXh45VKr?=
 =?us-ascii?Q?uMlqrVWbqv6E1IoBYELa1pknjXHkXP8ISz3cb/lRef/lGILXoxmASITTRPWM?=
 =?us-ascii?Q?NIpIodxQsKBrnqXrNhxAYAhozj5qOoq24gWmY2f3w7mRTW9U8H1rlZRW3t0W?=
 =?us-ascii?Q?FR2htFaljY+AWYEtodq5dexXQ+kD4byCWX4QYiejYLsEqpuYX4wmj1tmE9In?=
 =?us-ascii?Q?T1gplhdIX2T1tltDlLVEqy0q3LC7WZAtV2+ZPuqJsdQKctohUW6aeF5CzguO?=
 =?us-ascii?Q?MxfmoWF7IWCrEFYFqWsiHU+YkQ6Baf+1sKxGn1yraWDE48LDiu7cQYgCpqry?=
 =?us-ascii?Q?Jq4YS9zCpRIFr4yswwJqhskzvzVIU2+zOdOt/g8zSAoelOb3Tpn4OAV4eoQY?=
 =?us-ascii?Q?X3C97IEyjpTLf8XIDJsZ4Q19nGB3HGlMyEwCgLGAL+URBu7/k8bjrpfoD3tF?=
 =?us-ascii?Q?/YkZyg83sbobgbHw70KmghRd+8A8ozzyC/Hp+WQAwzJeSm36N/arlNtOWEai?=
 =?us-ascii?Q?K5iDhqN5yEB1y4q7fwbxdtIg9Sh+WWftIgOluCXmmDmB6uQc10KWy2X5/DI7?=
 =?us-ascii?Q?HDHa+Rr1dbdW1cMmQ/VRcAw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SxqLVSjfX58H4hQOMOKyvyJEAOxuJs85ZtYwzEiQlWAlGRBsKehrjbKwyiyr07+jFbU9G8JzcKB12+zbBkwqZE040WTP2j5b3KnD8DUEkoq3Ek3gZBtV3QIZ+Pq0BQG8sWPJzEx0jFNEp4hQQaBmxJdLIZT/g98cY07Pcmla2cwn6pzvpXOs5NOY0PwemMsKkqJv0pqfoY4o4BPhGdBBf36PbYGeAcsHCMd6mVUUafLDiZl6EN+w8ukhaXKhMRP2bcLqCSBSGBJwPsiaz0tz/xFmMzLuThcplD01NCbhQ7Jd8EBaO2MvML1Fn07IapkWiYuJTfm/0NFn1H6OllTJzZ4xQNS0xYM8eP3cCk8rV0TSbKLZAms+BLeUAdr7+/2jPZocX21s5879EmWR+OS2/E6V/H22nuAAsO51rENfnDkXq7g8y9LdkLeXLmCIyoDkA6z6nKpf0D12ZolPflOGB7zhsLlFUE4ntT4t7Hv4DrPf8u/wkzInCc7afopFaalhrE/GlOpMve3CNBK47zjsWFLGYfwC5sXDGCJWfiY5FsX8xhDVmttkMVoAf/EgoER3cCf1ltYOIHCD44NHo54kgLsowOqp5ISW+s1DBVVq50fbQwSgfzdJAUvxqY0wDEKWKuZc13bI1Q+CZxokQkO0qjgC3kiD2gng8IZLJUXk53eD3YiyNic2AJdnreaCpxHW+bz+pgUl/3yx0yTEsZa+taouGiSZBlMFexsBvxKGxvMVEr6QPEed3G9M1SShlrM92QlrWOc3AaHHw1KU0jOvvBO8yZibeYW6la/3fyltXdRqmPQIS/unqf3BtXprEjPO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec0e723-16cd-428c-4a9e-08db167904fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:08:43.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbeH5nMEj3eMrWtkWWIC4cNHIUNiW1W4PgZJ18rBUWJGHZbp4p6Hts4BmtfdiPxS9F+jQ02KhD5L3D8WAjxc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: 2uuB5XWuh6pwFV3ALFpT05NPwFYyVbS9
X-Proofpoint-GUID: 2uuB5XWuh6pwFV3ALFpT05NPwFYyVbS9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/intel_soc_pmic_crc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index b1548a933dc3..b745ace46e5b 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -271,6 +271,5 @@ static struct i2c_driver crystal_cove_i2c_driver = {
 module_i2c_driver(crystal_cove_i2c_driver);
 
 MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
 MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
-- 
2.39.1.268.g9de2f9a303

