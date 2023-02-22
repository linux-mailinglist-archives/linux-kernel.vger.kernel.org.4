Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4816F69F49F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjBVMee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBVMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:34:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0BB2823F;
        Wed, 22 Feb 2023 04:34:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xHfv006785;
        Wed, 22 Feb 2023 12:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YbGJfL9cdZUTxiLThH8ld5K0YfKsE8MVqeQJAZTeDzg=;
 b=jqKFhkmVuYVLV//B/8IpKpwENyV19pnY4y80zqGKclXNRvBbWT0J4sBA9kfvAPbb3VSq
 5jjTYw24QK4lfoQfXcLtWKcCBFhyzP4IGqm6eMRLrP/G7ouvCI7+7tCPxinvnsbgnnO4
 cQZUfZgsKwRJje5zY6R5yW7UrwM188hIIXC2yDx846BIXbZRhPM9Smx9sPjA0a1znQ7F
 rHViXxJPebXEfxlA4XAvukuhQDcTYA3FjHBnlo5hDqrz1f5qAmteDybMtB8Fz/t69waW
 4wlYMU84A5DFTqZ59ZbBlqAwG40zU8cY30Fwn98m+nh2oupb+j9s+kubv3eQuHN6QV2j ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7ufky7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBOOLX027244;
        Wed, 22 Feb 2023 12:16:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46r09q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBOWU7uKgKEboK/bUDfMolJPvAASJiOL9JrMIDCBjhhOeoiHuFI3LJ74GhKUYlx/u6d6lo/CcvcAezm+WTOdVAoTBQZhaTlTwE+I5qeGUCf88S8p9jqmQqfFfstk36qrxLmMQsBWe+DekL4EVuk4Bkz2DDfdZ9otVWyfoz4imNNMe7kTEzuY9rIiRzhJLXhWwsFaocJoZ0hWNqLhOAhbizhEmz6ewrGMVuE5fpLgP7Dmc6gqXOij06H/4V1Tn3GphQirFV2sLgFpafiMt/ZsA70/+ScRg5dpPqWKqwotcPDQDuXRwJ27H2F08phHIVu3v7mcd6ihRuavmH7LtqQnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbGJfL9cdZUTxiLThH8ld5K0YfKsE8MVqeQJAZTeDzg=;
 b=ngE65jNmFT9inFQFCdOZldkA50mw+2v0ooHFbBbSRn17GLjPp8nCOUYytX4CpLSUahDIQiQ6GXWIYhUscFzLRlx5zspOGwFLLpA2sULnnITx/8m/mDocrZKqiVcbTaExwmsvjUKKJ9j/V1BcpHiLxUwbyxiLjOoL9nMPUg0qzCO6Zjop+zUJj1f4UXfkylvlrW/wVnU2D5JNQ/sK2QCxX5T5dNOF/N63HjMtmhpr+2OEymPTU6F00fFOQNXnBE5iKgp19Hw25GJmCPRR6eeLtR2oZHu7JO/ESSeJOm1xyPEjN8yUqG3Bv+Uqa+zx2RwhYs6kteFaiv+YWiUcyear4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbGJfL9cdZUTxiLThH8ld5K0YfKsE8MVqeQJAZTeDzg=;
 b=zkViu2ULD3r4HKaFxch4tAWc0C33wwmmBc23NcvMW5/eCT8tW6tCfNXf9h7uWJjXsx14vxuVskeyz4v7Wl125DJvkZLtDI4Aegejylifv+1Zd9aNR/FyMLpk4z+jwDyyn3jXhH39CEIfnfs1ifZZUL/1roGzl6rTEdsFD03Mpic=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:25 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:25 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:44 +0000
Message-Id: <20230222121453.91915-19-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: f26ee753-0741-4578-d36c-08db14ce9e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2S0WBZJz706o3w7gxuuU5n5wVsDC+ddL/qmg9iYydBKn5ENI9j262OOrNymhwHupzlnVGsa78pb/YdPjBJk3RB9j8XZF0ZFapsBew3oRUgkUW7XtsFgbRiWIiUgXG8XxDu9npxvzIOSVZKJPTU+1smAbL2YwyP2qDn8ltr/Da54HSM8EIRUt3UoWw3LMK+7jJWOvSHdEIiRvtb3ZbC6rVdMhCU4ZTM+m6bEpvMsFMyb/r9I0jvItgxuJehcmvCGH8mcjwjT1hgU8s95P9WPZEcwWTruGVm9IsnN5n5+2EHBPnwdf496u8Tad4l39uIs8TC/MOHtrFvaKCyfiZNGbkt3aVWhJy2CZokfkoFRxszICpkQRqMbwdBk6xRLcSw+xOxvm+mjWCcYAyQrc8PIwKvvTB4X3P9bxhLAe6YXknT2kWBUoqAJiPaOpTLVaNWH1K+BsrfINTisx5f6JM0FUzSflfqMP1oooBUQH02r08hMrvS7PIR4JWK6cyLQJAPqwjWFVw/QnmDfwbSdnhhttaLeLlbGOqNZkcu7da8RbJDsWy0bjSKh3kL8e3WVWfzibHTPy+a/15gAeZm0WppIM//ViC+06ECa1ombOfzQoyuloeCCWniNjfbetVmhqfZCa7u2VqzhqcvtsPnC2MheFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWDDUtsjy7wvwBQ10RbeqskqhNIwRXwhDR0GNWd9SIMUuJiMy4M1AytkHlch?=
 =?us-ascii?Q?L0whY75ZEszr1lsukOD2rZ8Z6ILcBK7x837RFu1z0MWArxkYSn1R9TMlHD5Z?=
 =?us-ascii?Q?oZ+5mVaWIt+hpB9cNlm8ufPrQXMQuUwpicwhOOafCcU/N3o82OLgzMQHELgw?=
 =?us-ascii?Q?kN/ilCw3akxgR61AN9fQ9u6X8uojJmg3AEKUa8L3hr50Lhws43CmI0NzIyx2?=
 =?us-ascii?Q?8n3mwlm6VVICxjm1d7K3jBEnNnMcpIESiGAUvzXoXbdUpTcaIVOIcZOEm5zU?=
 =?us-ascii?Q?tIGUDYfn+ryR18wsxoOaV7DtlMqoCDm/8Gz2jQtcjO0olbQnFJSp5IhXd/LO?=
 =?us-ascii?Q?VyKnGe9T6NZaXK+RtRKwyU7vRLgt0+2kH3j4pEmmdYDA92H6wO46+vg2Zk9V?=
 =?us-ascii?Q?SozN7NPKRATuUbQy3cccQR+BdkBaLzO7VjdzBzJryuOBobMxE7OEvabUDeea?=
 =?us-ascii?Q?cO1Ayuj4e3F+/bu7XVQ/s1DbWj3+rALkqJSVNRZIvD323iVKK4EaxWXg0qe1?=
 =?us-ascii?Q?OCzjAS3lkHZp+fb/oFJWMuLhya/7xsbGJ+EPl/dbZz/Gxkxvbu9VeENLgdvZ?=
 =?us-ascii?Q?FcheRKE1KX54vwhvgIKF5TxeLw+MO2HN9Gtm9HSiOspdAM8mJgeJr49XAUWW?=
 =?us-ascii?Q?qlDFVOrjHQt+JJbH0DZPCX+5eX0x/9tW2kFcgWfZeJ0SkO8s1/bjgR2pZybn?=
 =?us-ascii?Q?FafWhBQkHm1DozVpYDHPZcvN63Rg0/f64tbrW4imq4Mpmy+ICzcLeTFz3ZDu?=
 =?us-ascii?Q?YYYKq3gwDyhxZzlX5dBgEHieBrb2M2W+hiIuYhAKzlMlV0esYVLOc7LvH+sU?=
 =?us-ascii?Q?zwtC+qrZkCsI5yc6gsDJXOFHH4MzQPLoz+XRY7IWs7A0P54jUsMlhfx7T6CT?=
 =?us-ascii?Q?fPWenA5CL+vcxi98XZuUx11qUwKc185hpzfb+xc5MsTI34EPiihpI61GCm/j?=
 =?us-ascii?Q?UG7x/GWN8UWATOOAM0flsZ3N+O7+vfn7OaCMyYV9+C2NDc2wiOhri+o/us6b?=
 =?us-ascii?Q?qfgM9o8PFYDUdZKpzcv6P33XelzN15m04h1ZEvTDzmFgYPe1GgXZRjzfmFbC?=
 =?us-ascii?Q?Kg7GVE+hGcrvRItKTJYv4FWWnHTLxsYtgUxjqd+otL8lOIzLPIuIYMmA2L/H?=
 =?us-ascii?Q?GyPmJDZOCODjpMovAfn9JHO4ytlIQ04Z0QJaNzmtnDOByga3ebLazsefilea?=
 =?us-ascii?Q?VdzPRrZjT8ph9GmlBCrb1DFU7GjftpJDKb9cFalrioRewqvwgfmSQ2GnW+pr?=
 =?us-ascii?Q?wfQ1xjnFpFCO8ExWJNdO6XO4ASqON+Ze7HKRGA0IxroLUKJpKoQ/c3RBgTx6?=
 =?us-ascii?Q?dUoonSUKn4lnG+d8drTJoym0LJQqiobeJvZ7T2gXo1ul5g9vIpKBTFJjDYtW?=
 =?us-ascii?Q?X6uONmUwR9S/qd+kiPACkalZ/JiTDSotzFTzb3TQpv3vMMUa+ZH0C7DNpM5c?=
 =?us-ascii?Q?4O83ztQ7zK34duACTnx3Mn0D9MUc9cCZaf0Hp3Ys1bmbfe2ufD8mkdi84NVS?=
 =?us-ascii?Q?3bTPln3TG3os+Eu9DhqAh5FV5FKaEXoA5PS73qI3Jj1pbUjduMR92jfrqVC4?=
 =?us-ascii?Q?bmaekNJgrkRW5wxNNQEyFYgzPyrG0C/aq5kDse0ZEwyui+iLeKq5rQqY2Fyl?=
 =?us-ascii?Q?Jc94AFEW+38v0LwcH/MG7Uw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MEnV2R+2epkhEL8O2w5k3YpeuYKs5G1xTt8EeW3okxCq4cUUWx4mnrCS/6hspsVo/OIcz1X+KMIlPiuh7Elbg+veHUMxJOqW4puVRmJaFJC/RfJ5Xc6GCUWf1sOyvVD2clOYteY8dX2miMbkbh/uwPk7rGioREsu3VOG2TfMPsU3rAj1zsBssWFZEr3lEMq7/PH8OslkZfW0keu308BUFh4+u8q6mch4KB9FLMk+/mf0bkKgmmIiKN8JGbJuVygAgNErS4qQh2xvQwtkZfHxqKcdliyvKRsnFWJKxuhYdpSY3/lJ2X6uoVqr565Tca7cqFtGSGU6keVgy4+/WqKxg+Yexl1mdj1ePnEWIG6Ih0NtIaJsethNtu3lLOf3BTIRnaCbr6zQsQVHTu0rz1w1hiekemno+qbW2ah2J4MusJxf4Q7/6oRsdapVZDf/EVXy22WwkpbFFiWQaRiHOuM3moE9a+1NhIsk9ET+ZAsDEN4svcCWetekmevK7tLWF4NWHiBIgJqClm6X7jI/pdrNSJps2mOpkfshNbhrBbZBqofx8KAuHk+zzkB91LozOqy+uKHoQ8UscjJf+6oiR0FbD2rEn2AUykydgiDRUA3CysFIEXMf7eSSLwIonBSkERbIpQ++KKvf1Fe+YTmTCxqPUIZ07h+gEWvKXQ8SiKgXsQ9XV/wx1Tcfg7d2iPCD+qt3jZ5wmC5IsTVbr8uLDXLD/ui9sSHupsn6z/TI+fqihrF9UxHDQ7V6XWAnsB8kDzwgctg/Hus7SqS0iRokPS/H0tPGahi6UcDnbPpi/iO8cMdLoD2oKorAhcu5CC9sV7+RJoI73UGYVxrIpGug9HIGhb5vGgeyRGJbEy157+gzetQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26ee753-0741-4578-d36c-08db14ce9e24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:25.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa17/nE8xNLx4XFQFYCivvDg54P9ckrkzwHxq+aKkAielPWJlQzc0mI/ZAJ2l4VDfEd7Hq8c/HpD11lcS8FJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: tFFTafeHthh3Z6rdpuuwKtOt8AYjAnvl
X-Proofpoint-ORIG-GUID: tFFTafeHthh3Z6rdpuuwKtOt8AYjAnvl
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
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da903x.c      | 1 -
 drivers/mfd/da9052-core.c | 1 -
 drivers/mfd/da9052-i2c.c  | 1 -
 drivers/mfd/da9052-spi.c  | 1 -
 drivers/mfd/da9055-core.c | 1 -
 drivers/mfd/da9055-i2c.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 44a25d642ce9..6570b33a5a77 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -563,4 +563,3 @@ module_exit(da903x_exit);
 MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
 MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index 8b42d2f7024f..150448cd2eb0 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -653,4 +653,3 @@ void da9052_device_exit(struct da9052 *da9052)
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("DA9052 MFD Core");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index ecb8077cdaaf..03db7a2ccf7a 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -209,4 +209,3 @@ module_exit(da9052_i2c_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("I2C driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index b79a57b45c1e..be5f2b34e18a 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -102,4 +102,3 @@ module_exit(da9052_spi_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("SPI driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index c3bcbd8905c6..768302e05baa 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -398,5 +398,4 @@ void da9055_device_exit(struct da9055 *da9055)
 }
 
 MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 702abff506a1..537fd5de3e6d 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -97,4 +97,3 @@ module_exit(da9055_i2c_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("I2C driver for Dialog DA9055 PMIC");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

