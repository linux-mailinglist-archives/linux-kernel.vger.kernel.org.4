Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888C69F438
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjBVMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjBVMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:15:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C633A0B4;
        Wed, 22 Feb 2023 04:15:36 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xCCM001469;
        Wed, 22 Feb 2023 12:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Eca+CXM2azDcvPzmOXyHZRiFRm3I5MEXuYxQMgqtQsI=;
 b=fq3ilILD7R8ezg1e+3YO3iQqET5DvmIMbMhFXxT3wtJZiB4RrbK+4t6fhHUxx0QptcO7
 +fFkJtWeidPwqf6muAnldP+nZAO0ZJp/FTTRRBcMvqVmr4GwMGXLdN/MBlEzSiW43RxT
 99UFpg6hDG8kJP2pTj3dhUwTXsIQirjPDDFvuTMBkSUP6EJhj/adO8c/uBayWcNGQqXX
 HZWs46Ntz28os8SK7AX8EvF6aFZfkcWbKf+c2wJz9+0V/1Acr2Zh6AZ1RbZKZIWAUgiy
 7M3jkIxX59dBUgwAH3mO6+cmwALpc9dA+UXfTFS0yurSVD1lGdxD6ze8llVO/F4XpBgl hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcfra4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MB7Fj0006809;
        Wed, 22 Feb 2023 12:15:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4d206j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt3tu5TuSI67O6lOENqr6/63NcAr2VroE4n5cuZPZuwidJqP00+EJ+yN6C/bbwNGT1p94vv/FscZcj+YPS6jX8F7X/F89WoyfSZLLfBCovvDoZOSL/dYp0L1o4iEG7Naym9sIhb0C6vchw3Lb1d9pqJZ3HUe/Z4tFSoOBxKdZRQaJVMaz5SboLKMDXimmOhdSRkJ86K2cTfiZvviDFjtXbqKm8vHNq5LlqdrWB9EUM70bDhpEyrMnlGp0tDfg+rSYd2Q8qb8shysZdJ93brMsM25Gj5jaFuvsbh/AZC8Xdo1bcrVhuFD80wCUspubf2NICNCDbjqwECkzSHis1tYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eca+CXM2azDcvPzmOXyHZRiFRm3I5MEXuYxQMgqtQsI=;
 b=H5FLAgqzuargA9rNp8M8CDu2gsSqloVSJrlzFj6bqaWb1W93pd1ikqZNfmtbj5VnsF6v1yjh8LLmfXMYwJJrgPJs51YeicFmtHUZ5n2OFCd2IxACWQQYCDUPRaGTzqSz6JdVrLK526BP901J36iw1D80V6ZLBoZKjmreea4OjxUvrn4AMbHRX2BEEfHGP1Y83AXHj0m87hoiY2KnNuUz/nBnJ7vhQD76CH4Kv1y9gu1SGT+cQS/Kdl4/LfrO0+boLxlxZAzGx/JeiylaQhitNbAeyX0TQFeCvoZOTXD583y9/7ilESK83iz3lEXXc60W9W4mR1SJJmQgX4wS4fhTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eca+CXM2azDcvPzmOXyHZRiFRm3I5MEXuYxQMgqtQsI=;
 b=yx37bDVWskD/fmBnUvhnXT2Muz2jZloOlCSmirEbPugtmfd+Fh9S36TAfJUkYG1qlbg9BEM4kt95o1cDtV5HQYfwaSPjS1+HYuF1Za1tJHHzI4SztZfkXq01Gnz/vYhR7v5N9yAxLTiOolfxt4Y9WmszP9z0tQmECbuYX13pghI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:15:24 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/27] kbuild, soc: bcm: raspberrypi-power: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:30 +0000
Message-Id: <20230222121453.91915-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ec7d31-76aa-4eb2-b80a-08db14ce7992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZTtBikSXKZSJpZrH6ze22YWyAUXNm2lpxon3yS5JOdc5T9DaAnQWpVfjF12qiUeK4dniGvZacKkkRGDkxj1r9ECZh+g9xZ1A9JkpIrlLyDsh4gGe0bKsabcFSakKy4fd1i+a42+yIw+F7DNxqOlYYZGQWIn6LAgjIzA7Zl/iVAWb6blGNBoOhEHZDUEUOJrEkm9ASo2VeOyjxYa9Ft26lSOI9emgJFlBRRMZn0w2avLo6aT7zqLlCakDkbLHKFtniCOmzv8pYS0uRtTmerGFoCh0dQbqkH7pWlUq4erltOF4G8kBm+XHONSoJ3mbroAtzZiu6J6ytQ3Z2HbJxb0RY+pauo4zryYj6b4STHkse4yZkveQPDtydbQng0RuiK4HkHBChnIKVS7mCFKovPploi4AvkLQmNjczRo3EBVam5kGJfigW2WIIZIyrTEGWoV5nUJjmRediQPUwfI0he7HJjJ1LEVgi4tp1ggQECHmjJvZYgqToBMHEUE1H7Dbp1qlhnA1pOrDg/8aNqWgIJp1y+CiiW5bzCNQM4MMqb1fPgdJtGn37NBwS21RCXiYI7b2UK/CsiRg3ADQqqqzLz4Oh3Fy3GwdSW71wYb+nICbODIWMjzruSNkENIV2+rE+oYtmyLs4PP/DzGigEfY9jVrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKhzw0RIjtw8l8ODEK5Qn+Jk6/ed9cst2nGJrQZoKivQdixBYpdc3n+yHMSC?=
 =?us-ascii?Q?XRqtin2rKIri9LtO45q5xspmC5ihQdHu3EhxD8ofPu2HsCwNoFrf5iln9XVb?=
 =?us-ascii?Q?I3oAPYPGJCY/lP7sqIXKytplUWsgWbHhX2p6e7mS+QRjR/ruV0Jj8qE+YJB0?=
 =?us-ascii?Q?GdmX+UoxMS7u7AXg1LL2Vo/iJYmuMow/k6IG6RGzUJYR+21oBY/PvjYXIrPY?=
 =?us-ascii?Q?0EcvuVDpZ7Y08ujEWf8hA7v+zU1GuE2P8W3lEzmYWkcF/UZfSH7mA4tQfkbd?=
 =?us-ascii?Q?ki4hTNQeLgCcl+f3K87NCkzPnayyksG7VqiG97/3zrPosRIna6kre02GvFv/?=
 =?us-ascii?Q?YpGSQjkrg+sJHsrWtGoddovmtdFElg5hZ0G+URjwOz/TJlrC1JVDmetTTpAY?=
 =?us-ascii?Q?xVjcwpGBjoxRNDAsZO0hp0E7KdiZJnfbifvuIwBOVr+/Ie47c1K9uwgb3PGm?=
 =?us-ascii?Q?C1PvtOxf5Pzjdomx70ENSeyqL0dS/a7RxxB3AwbYJuTxgldD6bxy9pu5cH9i?=
 =?us-ascii?Q?lGbA1GljaBzdWq6zmbEMPytqEY1rZyFhQQoRoWXyV7pqWf81zxqOCTjUsLOw?=
 =?us-ascii?Q?7qO3EDsaqo3WaITs2ofqKBrPzNsgDpp1ZClXwWLOx0X9fKa6lCuAUz0X8sLP?=
 =?us-ascii?Q?qgrrFVXkqWGKHHAD7s6o+qOY5rSDZfZ/aWttyISYSGm+evj/+mSF7y2JrO7O?=
 =?us-ascii?Q?rQgHsGhlUuFfp6+UWKdbnDf40fZbp0KqgULxgT7+GqJ3pBG4MxVpmHpMQrr9?=
 =?us-ascii?Q?fxAcXaMcaAo5/WULtRsOtBZug5j2cUwrVKpwYIbxWPKPU9zPA7OW1+g5NPHG?=
 =?us-ascii?Q?LWttlpTwrvEmY5uxWHNfjV81AZg0T+h5lt9aRxMZF93UGbe7zh7cABZPLBxt?=
 =?us-ascii?Q?lLQT4sSpyeuI7Am7ricfHkkrrfTtfUeGNe09H29gDGUFyWCb19rGFQIwXm3x?=
 =?us-ascii?Q?vy23tyv+u4ekHWS3wJu0RNPwMzZg+pW4fvOmKD1L4QmPEU8eyAUeE/a8YaK8?=
 =?us-ascii?Q?uPR05sKe+fsjyUwKJqzN0EIP074uQrynW2OZq9Rt6J/y/2pm5hReIZ9Ex+bn?=
 =?us-ascii?Q?jX3JB+vxryC1e9sD9uHAYYfHyF9xMCfYdhkro+hGWCJtuOy8ZKhZR3eSQy7G?=
 =?us-ascii?Q?UMOqOpB0msfyyB9zfWbEMx/21/3xTxxuBJf5vFR5gVU2XT/ZvaNhF0XcK3R7?=
 =?us-ascii?Q?Cd+kMlmA9ouTAcNWefo9C5LlesGu9WVmR6m9rkWohaUnbgRSesD61hy4JTRO?=
 =?us-ascii?Q?1z2R4xMe2Hiewnm+4TOybn83T5h5QioOshODMBCIizbvwzpHZMCoxvLr2RBJ?=
 =?us-ascii?Q?Dd0nnOqTqHZD6e2nnRNnZ69oYlY2IDDzG+7m4DalIN2tgIAqYHeyot5w1VSg?=
 =?us-ascii?Q?warqhfahG93Mk6cDXFSamg7IdzEQT1FREiyTC2rIAqWvYGTFC9SIhVGyJqqO?=
 =?us-ascii?Q?fdqh+ChT/ly1OhBIytM151shcZi8+SmRM9J/LGdI8nBOqCxB4UhXKclMvfMe?=
 =?us-ascii?Q?aqjP+7zcbXSZe26O5rpJmasnOPm28n5xGHWjmpuUck5/O/YHgRN5ZLkns4bD?=
 =?us-ascii?Q?KfJfhS7BTfq3s1rek7t0nxzlWNJGiaXf1vSg8F2u8jsJdVKt4s2dvyy40WcZ?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DFj8lHKEY4VzJaAmw7ZPs2JbCljH43tpSfPSxRM6PyTs3KTIVmRCiRwVt+iatd8uzzvxp5LROKee4+cvLLDu6NQ72EZ015ku02B87WFF6RNMcEqzbkfRf/zjfAMU2YOfqadzJEbJuXJk+0IJErIucczAnny9+nb3DK32z1jdGXsfJ6wUp2oLjtcr+jEqrhgGQKVH6+smhXu++J0crSwBzEDPmD/zyXPYqneUcqIEapOVLqF01FcKrNkShGHLzGOQF4nvGzbuLwOVRbvcf3vsY0Bbi4tfdhO4aCJtsE4B5sqTG7iT5vbPGW/L5229OiS2FLs3DN7Lu05rBOVYiFllM4nX15U+Xeq4cnxdCP4qZ5+D7f+e4GocefSNd7qgDltJyblJMjmFCRztrd+bKp6pdzTctTVMjJhbrX872ACtU+MlZCCdB8f+fbLc3nadpXywajYUyJlReGvR3Y6r7AJt6rxyVGSdCxx4NyAFY5yXW7ErLGF3eWOkwTuQmLVoyQIuz0meSC+qzRDshJk+N6jtOa3GfuE6vNjIFNLqNiy4n+eW8Pk2MsffI9wJRRrr7utF4mVEn+zJl7rBMeeJnUnGNK77Xmmf7s2lzSLIqXUpVws5v1Ep1A2Ew7x61w/MRoFDZDVIRA0AzBAdzZy7K6Q+W2Q81VzP9GrDJmjBl9FFKutsZSFXdX6VIR4inGFljPy3fVNhT3e9eZVprJSYYY4H8Ls79FsejvI983lD+zeabBeLxK8V3YB2DncAPlrtd5xEoyZAlSBwZsFzOKly1b4c8VJnyZIeDsbgAlpHbrlD/L+5Uq/GxCE17pn43q2ISrmu+xMXQwgIh8B7xWLCqOiW5kKpfQt9++CCEHuH21nW7rrtHvkoeQr4s+qcAaEv2/yw+ExsYHlbVbiJki53ui1m4A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ec7d31-76aa-4eb2-b80a-08db14ce7992
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:23.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCLadXzokZ2guV3v3AcdBVP7q09CBe5Z8AoAsX6y6E2ZzRcpMgdaluj6tww8HxkXx6dECYS4P8nvhTwJ96mG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-GUID: 22vHkG5tMlZGXNGzhi1j4knnj6m0wfA5
X-Proofpoint-ORIG-GUID: 22vHkG5tMlZGXNGzhi1j4knnj6m0wfA5
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
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/soc/bcm/raspberrypi-power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index 068715d6e66d..58175af982a0 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -243,4 +243,3 @@ builtin_platform_driver(rpi_power_driver);
 MODULE_AUTHOR("Alexander Aring <aar@pengutronix.de>");
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("Raspberry Pi power domain driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

