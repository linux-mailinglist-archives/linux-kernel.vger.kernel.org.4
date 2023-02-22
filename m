Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8269F4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjBVMfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjBVMfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:35:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1E38674;
        Wed, 22 Feb 2023 04:35:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xFih029564;
        Wed, 22 Feb 2023 12:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=grpEc1+NQTzecieoTcrCjDFvpZbOVv5h3vjLrw7wfSg=;
 b=uFGAwtUQ4nX/EggBQMLW2q06Ctzh1aLCrBGB7FPks2VxxPKeVrRyWnpcHhm0ESDdmaf4
 C9LvQWtCVdJrLcEYjG0j3sKvLwlGG60uEPGuxEGNZ5mWaPg7EJOMIC8nfOyTKSJ50G+g
 OOkkE1QJTRUqjoSrixrTDLfjLeNhogrnBEJSzXIkgTq3J1Kf4/85LtnVKRiBBe25Rhk4
 L3hjco4TVYXWhDJFHU1N+cjw0byN/n6UytYzF7y3K/7TY5DPdfv1LMEDxNddVlKI55eu
 uTHyBgLmzFFY1DwKXfr5rUNWf65QLihSZvetSRPZWPMLK/ZL5S4QBPgUa3qtcDwR3sWF SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dqqek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBaBXI027273;
        Wed, 22 Feb 2023 12:16:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46r02q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzsAsPpfZ7nRntrVOkeIG3XyusB2ZiS84Ck6E7xezSSOKplKgBX5AHqF5aJFJlzlN33Bsz+WWCjZN3dXXi03qPc4KRzfvkYyq/uuF8O+yJ/Q8dx3e7UqiurOkQNahkSqLXvHK6ck7auA8e3vkiwm8oDfWLQKOADnRStYDGi/z+InTCzy0EyvGXCFsPZAXoJHN6jFZP7Hsh6lMmsZ79eJbKF0IhwzUS1n4YjVakssaT6JtjjkFXOnsFapaiV5NPHJ+dNFSSd1PXoOU+gij3j27sOCbSEuYwmrfh1fVU4A5AUw9YLzsO7OESUCTwBs09jt6GTkVncdAAbqJwaE8YXhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grpEc1+NQTzecieoTcrCjDFvpZbOVv5h3vjLrw7wfSg=;
 b=N83ry82DitkWTC3aIHqWpXcyAC4SlhxDHnV6NOYrUxrvy9y5EO0ImlIo/IwFJFZxDU72lzTSmIzNlAm38ooO+BbRjHt9vu/jmTIExnDTJpLAf7CeGHWdqdksD87PGkrgcPi4Tt21m+J8aBfup0BYEnqv/izeiXIGxMtZnRvpDqNs1DgdUpiKlv3AGLlHFTypq/jazuPB3FL0+ti89FefR61kr5BcSFCofCehAqIU1ZX5inozzNHoOum7jBBxmZXkPEtXX6e6AmHTVfSEw/23MJ82E02oW0SXTqyAXLjXnWs1MGR5ML/yj0975GhDUC/IS0KyPl5IAfRsGXVCU2YDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grpEc1+NQTzecieoTcrCjDFvpZbOVv5h3vjLrw7wfSg=;
 b=ZgUKejT/CttF7E2d32bk87h8u7Vdj7GeSzGHcAvJU0kJMOMPokmQ0BR1vMAhhvTv5vmChvvcxublChyt4ng1BcVFBfYVEMZPiqX+h16gMploGi20T/W1jlL1zP7BMp18ecE63n3cSXtWyQQ8NT1B5BhemB+V0LRSPlFIcL7XPLo=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:11 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:11 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 15/27] kbuild, cpufreq: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:41 +0000
Message-Id: <20230222121453.91915-16-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: e94d15a0-85d8-4e37-e612-08db14ce95fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL8CsODZwFMlgC8VPcOAJ8Fg1ZYXvLYWyW9ZsenvfcAMq16rmq2Mz/eCGU9Un+8u4oJ3IJNf5szPlirfvHW6MgkgR9zbHcq/pW63X+xW1jBo0npgVkK/U5KMCIgk//zKHc8vCL1C9fDZvd9ayePLm1M9kmf6E2GGh8At/gLeObo2SPtmqL1/xj+Pc29z9fbNm8fDDPkf2wQaj6DjLkT+Y/q4p1asVvn02QMdfwiyAhdEbFs7aJfOSPuvNo5L5oUjUeMaG17CXW98aoAMR4+9NjwkedALCBeIWr2Q4vVlO4Kzei5pIx50iypiR/O2mu9sFwKMNJXzALeDRptopcy6p5d+23VZtBFQOIuxua/MZBE2HLZenwHNo4MTnpI2GAu4gewIiOo4WjuwMSUj2FaLU1UmofTEHziLD3uO+iJ52aEZvKGM+Dt8RqqCXDFRJgE8R3dVkFx1ztCOSSJV/jW8Vcg24vDTrO2uBWk2nXtS1XPGATS+llbzH2+Ywv9xWN4QclAJubwG/EIaIPDsJDqB2KijZPauhyOnbl5D0NUPNpCLuR7Mabith5jOaJ1i6on37O1F5MfVx4ryQv0d0O6GCaaGGskxjQfnsoNguT3di3BobOUJ5cdK1Kb5FP4et7lG9bMVDCjgHS6Le5VEUYI6JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmZrHb+qIijbdUrDZbPJn4SomYqGW1pj476Z3pdJDhNW8Gp/2IqiNSobpQtj?=
 =?us-ascii?Q?kDZCp2+shMGaQfFm+2yUzvAVyKtEja/R8yGv5T/nf6c56uuSBQG7u6Vh+aPX?=
 =?us-ascii?Q?m6q7vRjhy6MKqsbyoI454pvgltpCDtRUM+leduX3EIhmxqT3MIndQUG4GEMF?=
 =?us-ascii?Q?If0w4MGHxWMpzXc2xBC6YKaBbphl7RgvgfAbQqkkndeiihc7sZ5T8E6diXCa?=
 =?us-ascii?Q?7BEUhpfWlDQjbDEwutN/W4JATeiqhQCVNRZSnCqFDKEpxYj/UCXAtKhe2B/C?=
 =?us-ascii?Q?D6b1FlXkjluZRLhiU4YMdrqTfu010NnNsU1bIzsacoDMnIbB+zS1dUswxGZ0?=
 =?us-ascii?Q?X5/5ppFzyrFliqczS58QSetP/7oa7HZnLdSh2tr/dtkBs69/VWC40WLbrxHz?=
 =?us-ascii?Q?VUJcQ8TI8CDEdW7Xk8GWfOPHqZ6GHLXZmfA6Pm7X+GYxOB27HQRvlxQDoNxe?=
 =?us-ascii?Q?w5P12zM49JF7Ld1m23ztX3wfxjg/ZFoBMn1Z0IPTjUkvCLTAcz7BNH8j7ohc?=
 =?us-ascii?Q?3MTknylQEg2r2yK92hWqxNg7dD9yt+PtoGf0bOC6zk68cVY/hY6EhoC2CEFL?=
 =?us-ascii?Q?aVhnpVbriQATvCRTYy3+LeutbwNsOzEz2LsoLgw5UY5FomOJ5vM0VC7Cjn+E?=
 =?us-ascii?Q?ms49IBD1jaOmwXB4GFIObaC1WLaUwAMZi1zIaEiDFAKuiXM1ANWlJ8ejoAmz?=
 =?us-ascii?Q?Ji9P4ojcj/EURT/bWJQyhRweYP1FC0Ep/2yBgmcBkbytsDdy9HV+69R4hqkb?=
 =?us-ascii?Q?verSW6lyGollwZ6iBGCucweBfGUUY4vc+Yides2TBXx23ZKSxSGXX9Ljhzhp?=
 =?us-ascii?Q?gTSevPgUpTfhhm8JehjxvaPmkkueAaXwYznhZviSSpd+2me2K2wIIIXiGaOV?=
 =?us-ascii?Q?+y90N0i6AekCU86RYd2bXMrpmBMCbOKKXZIZWrY3VzUvYZlwDXLPSVnVPAwf?=
 =?us-ascii?Q?JPdqQLLN5Ai4LXeXJctt+HFQLhKFbAsySAqVngtJJzX2Tgm7QtEHDoc4G5a6?=
 =?us-ascii?Q?SiYNz95947Ob1AxpKj7bStG+qmSyaRaHOzKT+3xSEjfZLLtL55p1UxKZREy+?=
 =?us-ascii?Q?+YPNa019QwPN5XhN3rhVG9NOvYnRFflo/yp1Hb5pBKCnykynsoKLz4B2tmXt?=
 =?us-ascii?Q?C8kTsA4TF9wQicdBdbecgLKQIy3G1yFUjbjqlvzC8rBEkB2uCXyWoH9Bsq3Z?=
 =?us-ascii?Q?sKKkwUhlD+5BGs1h2JgxFPBaN2qqEw1Wx4EDaEoRzfa42olRhjq9d6ceqf4e?=
 =?us-ascii?Q?dNQrZuhVtXxZ66rPF6yncBDFNoKogoJb8Wo69R9t7iyQeFqGo5m4EzgMvDum?=
 =?us-ascii?Q?ww5vkHno0gc4mMnC/u6OsisO7bTDBrI21WQF7j595NxfhQeKbtu4aFGQf9Lj?=
 =?us-ascii?Q?7V1fQOp5Mrd3UsD+uEEt2j7uqKRibbWMmBQwiswn1A/C31Q4brZt96JhU6/E?=
 =?us-ascii?Q?WlF+g38xvPgzthenK5ZWPNIASgUeEnLmUBqZgFzZxr9HOWn4/FNPHUbClptB?=
 =?us-ascii?Q?0fiGpHe+SSve2WbbVC3Z5d9CEbi9mm+pFN5NErc2N4MDakY9jx1M6dzksM8A?=
 =?us-ascii?Q?8jhqovcEqYat1SN79FobwVxkn4RRFhhaOjRKLcwN75sAXsiAJJXo3sm1CgpT?=
 =?us-ascii?Q?qnrB7+0b+LqlpWjP7h7hAqc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8qWMTPOrTGnfwVK4KsndiZjIKLlYO+QZRPm8uSueabS7Ci3RpDFNoSbKpTexokgzrWpHiOonF5VZTx9W8tTy8mGIM68s4XWU039kqQ7jHPpt1Su5SHlmUVh1E0We8/kkD/FvDict2RRLo2Nf1B5F+hHEonsyVPJ/r0szbPndV2aLoTFRGZNXZk8wZ9UhUGHttonc2bnLDii6+DH3II2RqwC35ySpy3DelEbzb1IlJ+n5hO+rGE36sZ1gnVhV4lll/DgqFxXf9aZz3L4TdCSBUt/S0Ed2bqvNzamLAIrI7AIll3su5wUlAaEkvNynGMoxx01z8lLVEd+S7MeDLwmnflmoiK7kmIOhyZltcH7pmGnmSBNKusOzA+IRtq4xEjnrReRP8pZ1bwFV+wB8qdrIv1kAzJXg9FZ2z6SE6xwR474EiDvfDgjHPzCFtBzeqWDtZfNsEBox+2qeK7jNBiLGfikBq/sp1K30Ab+YR8E86RzyjBzHh2gqfmXVESOf6NB0Z3mQA3PxBoYJuFVDxd0FwQqjUJLIPzIyxDTXoIiUBZ6Ob0sXUVxFEx1LdRjop7dwqSqSTnKS+SgR+Bm7YC8jK5F1HanTXzlukkylbqrbmKvI4IvoxfutBCkYZlZpbxbDabilGRt/Povx/KJxAFofXznRhOEmiIeDrT/weUGZCMaCMRZf7qt2Bw49q3LGNmRR8pmOIJZfolIsi6vZqxquRkzC9bBgBmTUlwKD0vn8iEIyR8eofkfNTIxdBCutwhC93tl1i8t8oS0mGrHjS6ZT6ShzijKF1s5LcC6T6nx7RdfEzJkkJGaGvgo36KDWJNr0CLyohKewS4UBMBqxtMvTegT3Sa/oEMfbyCNVl2fwT48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94d15a0-85d8-4e37-e612-08db14ce95fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:11.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym08H/UW+U9zRhpY/MdVVopzIE7OPPUfWA/LN55/T5GjUP6k4yGiyQRhItiGtN8HkqEwuHNtVX4WsyYNn4lg8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: MYwHSYPg8reYXdW0AndmqbSMfW5l9r_5
X-Proofpoint-ORIG-GUID: MYwHSYPg8reYXdW0AndmqbSMfW5l9r_5
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/freq_table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 67e56cf638ef..90bfc27ed1ba 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -367,4 +367,3 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq frequency table helpers");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

