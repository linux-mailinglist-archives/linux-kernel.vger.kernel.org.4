Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5669F428
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjBVMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjBVMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:15:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E314937B61;
        Wed, 22 Feb 2023 04:15:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xH7I002769;
        Wed, 22 Feb 2023 12:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Bwc3OOW9WgedNktZ4mRSsYL6iPpgGSM96zdksZDN/ck=;
 b=cCnRREJ190xJ3gt8+TFDvyY0ve5On2thLNG3a8FTed/g1JxIlh7xsDm39l1qaOnAW1LK
 R+QC7DeOTZH9UBJ2pe6KbkvHP8GPfD7wqG6WeuHF8g7ds/EuoxN9ZKyu3nCH6bsqV9by
 ok4DEYghXIM7R6OZt+SBPxsv5IosYBJTnPjktVuz0n5wMUVdnPLEhcwbsor7dSFlN3h3
 u3hrGW2Miey7qV1BkHQe4QajNWkpYLGI378hYz+rTfE51O8ee2F3n4s4pP0fKy+B0G08
 lt/b0Rxz7xVeTgY/3EzDk3V+OsmXhCrhgBJiqLQzbm0eird40Y8EJhDRgysIb37ccQVN PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja7n8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M9posa023286;
        Wed, 22 Feb 2023 12:15:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46j3ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0RdO2V+fFLt0tv7uFRGB+qgPFeEPoqMNvLp20oIXfFT11JqyzV9EttG9MO6ZpbHm2VOk0NLqU8ZOgTHN3XzzMsRbz1Mbym+UpQo05xroDes6PG3lYzE2oC0O8hw23NqohesuK6CC41eTnR+jmAfnCGhONygapq4WPYvvut+tYYzFdxs3cGPpbP7chsQi3PqN5y9zqH0d2QopFmRcpvyQqg6Z0Fv2FhVvrVXPproAG2rrtpOtLRqNrMxdUNCBeC7pRbb9SuZSy1GgpIEXf3a39W49ZFYgLHij5r9/XXZMzxD3P9MK0QWTqBbmJNbnxU+U2C+9age61h377ghiZdkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwc3OOW9WgedNktZ4mRSsYL6iPpgGSM96zdksZDN/ck=;
 b=XVS750aINPYh7HRkbFdsPDq32ADtYmOj/GJ6lxsG+iOIWc1ooTuzSJRxYKWMoK81gmY2b62fOPHeIKD9L+1b7S0Qak72tXc/UJPAQ38L3j/EK8XeF6BHIlUpkb4122DeR3qgTpWnEnoZop+oMNp0trGOXkZtS+YhaKOf4BRKZcPwoVbSzkzxf1KLqvdhAFJoGytSEu6SMB4bKY3TD9HEIGoN1Rjdafgi/SZwEGs/iFaiVs2K5j6T08FP+jfHYhGhrXbFwOc3iTQP+JGmnpoq+Rkc3V92sp6RLfAePHeZ02T3MUAlr9+FIMlopQS18ZLbpSl9/glHrwQVEEsKOhXtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwc3OOW9WgedNktZ4mRSsYL6iPpgGSM96zdksZDN/ck=;
 b=qSBe6mZND8DnrRlI9CddO0JL9gYNqCCVYBXszs5yacScJ1cSqua35hkpd1ETz+wC7b6jkZ9CN4ycsR0cIQTmAouUgXQo9vkXLsRUjfVi5yhY4/2EU6yjlbzYRDPcUGipLsVkbQF+XLQFeUDq7Y6LCHQbETJgYTSudLIZB5r5fAE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:15:08 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:08 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 01/27] kbuild, power: reset: keystone-reset: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:27 +0000
Message-Id: <20230222121453.91915-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f80881-d122-4766-3329-08db14ce7063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqG1yi+hx3opVEbvv94FRjhJE4lGjKboj8DZqp4iRzwoHKYKDrdkDFJgRfT+mPTQ7+xbjNWLkddAZS8qhDdlyyv8uWTBpWDn20iYL6e3geExQQ+MYul7QB3Foplzt2Aztg7qC57MLbmZahyzrOMvpTgXyUEErDqVmUFQ+68sL5sMFlmtMFQjtGj6tBWSFXHZWp7FC1CyiTXDXrqEIB3Lo5PMImrVKn/NYE5/FxzW5xIot7nzPpo1uoQ164DGUY//1sG81cckQlTz4I9AUpT/Io4+XIcxx/r8ojCfIbC6zdN8DkWd9//tyIvl6FJMvXK3WrEC4ShbIcwaiNmK80uZ6CrRgDXC27RG8L9d3DqN11D2c1AQMWPOwCA3slnK3VIb+2gTa5YvMPAvFKcM558aQjTEs4c0yxg3BUjCvdhJuusT3/bI+xA5FuESePwHUOTO5Rjsz/Rtv1GrauU2dk9Kk/XxFRrNhNtwgxRw+qosM+5kC2dALC3XwQV/bHEDC36j1BHmi9L5sNxaZl0OhF74uV+nvnIijaut9UuSpaEpp9OONrGOS6zZOjCCt2ZhP3o/BYehdr6zzP6LSNalFqZjD7gvgrPbm0hOQaEHU2yGj0s+mztF2Jn/02kOm4enG3UoH8qECN94jjCEvRtM6O/ydw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5SVPsehIyhqjZZ/RuUJcOuNiahDYrQDBm1dF5Od+t+TC6QK4FEHMXvqe6VhQ?=
 =?us-ascii?Q?vy1IwPufOLV8O6zthX6DcwGNh4U/yzicdhg0KGuTigXDje77eStaiCQwFX6c?=
 =?us-ascii?Q?PkrRQgHkRsSQVcMvOGR+rcmQBb2qM5oPLoEM6F/WOGOefD0wdtqPHIxMHQai?=
 =?us-ascii?Q?PVqcj0/G02i5NaTWjjesOOwGk1dSTJXiiR5KPMkIBi3XdZjtgYBrieTy+uOK?=
 =?us-ascii?Q?d4WQ1ob9f82P8GR2qtjmBSR+mJW8FpJkCtsafc/T4ig1cIhQSfCR0bTtlg6g?=
 =?us-ascii?Q?UtnaHVwbBKq3WjBgTtQwVIAxkMfNgMRJZ2jlTDztWdaogZC9sc8Yts+HS9EN?=
 =?us-ascii?Q?ziEtpArgeszcf4iVQVwk4oj5GaMDDYn5D1rEIwWtS+LukD2hvIRh5afDkVa6?=
 =?us-ascii?Q?SYldcD/XZSwCtDx89t7yNyJraYUqh2SQuJt+AymH/KRtDrEnecc0NF+uO/UL?=
 =?us-ascii?Q?wc5UHTJCqiJbk4G0x/P48oqMmAMYYjs4D10U/IQZKAhXy/Rqly9Q/uCGB5QY?=
 =?us-ascii?Q?kS+kBuWusJsmO7eT4sdqFqQ0YJX523VJgjO09S+e9P9XW3PaHiNc309qOeek?=
 =?us-ascii?Q?yv2z9NgFXcf3PUo3liuDa3G+/iMXb+Kl77u4owKFcg80+XStawvjbDsPct6m?=
 =?us-ascii?Q?0TgWAOiq0dJxM/ndczMbiPoeyX6QuXYHjicH70yKw9f6wzPa1neBgU1B3XY/?=
 =?us-ascii?Q?PG+pzP9xX86tgB5jeUq2dPFjrTnOdIQl/O+OK0TtoX+DKE//E7XJEyPZ69J6?=
 =?us-ascii?Q?IGopXJOReN7/PDEsASlk8T8G+aqbOgT68O244XvsZlvYZZn1q87kLWtltrpt?=
 =?us-ascii?Q?YRTLc4Tuocs5wOVlvcIr10oSTC4GKp2qWlTjWvn4HMgUGu1S1Q4Psffc8Z6o?=
 =?us-ascii?Q?ynLWK1HCjATlhCuUB2a0J7Eb6CZqS3hECxH6o4Xu4qprl94eYNFMxe9gwI9z?=
 =?us-ascii?Q?25P8zhMib0m/yd6qPv+LwTymJkGIWJXMfwdlvgD7qYfw+DFGgQi5OuGW84Kp?=
 =?us-ascii?Q?Zyl2gYmWeMoZN0xHX48bgvQanIZMFZG7yFPzQyE4On5qmfRTOblRPOpbMxHe?=
 =?us-ascii?Q?/og7YIHLXl5TZ5kaE7aYcsEq4yXVstBRiLkPetFCf9iY2MkaHoP0/ObvRiMD?=
 =?us-ascii?Q?6g7yHRRqiBusx6hNUYMo3heo/kvcsqjvYcV8vfBaFf6O6GBUMYky+MDz4ZsC?=
 =?us-ascii?Q?zLPxbX/707n5mRjzqB0c1lsEmiYv6xsw2OdajR+Exg2zENRNNMY08dtQ6iXz?=
 =?us-ascii?Q?5WzJ1aoXhT7ULGggCPywaTdmDy3++Tv5BpttPqyXHR/nGG2YBt1RAoBJqYTc?=
 =?us-ascii?Q?O5G5fChoxs79B98pYemrEuWMgvRH5PtynVDTJFPP3CNWQ2UyTwQf9Z1TqcrU?=
 =?us-ascii?Q?jGkocM/dSVAymofpCatQzIe0j8PCVRN6BxiMYsXwYj8uN/U2Ors37gppGql3?=
 =?us-ascii?Q?a2GKlvcRZVHO3KAe3UuvB+kiYbuFgYKCo2LtdKLFh1N9b55f6m2qRqc0t07C?=
 =?us-ascii?Q?Z11m2VKihq9nTNi0CkIirTnJ1OAHs+eHS6TEFpDtRBwKXBwtwb1gMpAsO9ph?=
 =?us-ascii?Q?mzTRvxw7FntBjrBEGHJQA+lAnw5Bh8C5yoWB2zv1mtvaKlVjrG+r3hzEkXqP?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Oy1DzMEjPzRPtX7AGnq2vnnog+xeUEZfB6a3OIQPExztil4yVa4NAFDCkiLYhCnQK4vYk0lzti/yX00dqzf73BSa6FrG3764dFSwR9/fdkYSeZZMwgzEM3FFVrRtDBueJegfLw8kQ024BmqV8bnjW/XD+45So1QcYsUWaB7hLDsC3B4g8m6xiQZkkrZpVjRNPUyNQ6WkDdQLUwpmxzjQSq2T5ygpqbixWeQ0MtLXL1Blrip2TNc7uVRb3b3/vtDHGkAKA37bp7SAM2Id9fTKNc6kw5tZjw7GrSOXQco409FLDaPO5rwX+vwmVDUwn0n9e5+8Eaw3gsp1V1dreUSpbpWXsEA0i0GmmfO8tVNMPZbRhNCmgKWtVd0D4dwY+hAiO5luocnC2Mj23xHbvNCXn/oqoa3CKhRUb+MZhvSYwrl/jo310e5yoZMv07w5JXWx3qEBQ5ckx1EzLb3MaE1bm7sG0oLBl5LMAOHjV+uJJjhaW1d2oA59QLV8Hwo44+PiT5lRSyg9sWdUT2Ow8gbceaPvaWEeaj+LpJiDtN+v64eaqMo6n5YIFtF5UV/q20V9jtWICCSiuHp4EI2fGsLcKNVM/tPMId52HfJaybFSXs0ZnAgXHbeE+vn6qQR0xbs5KX4oVCTSbeNxCy5pHDiKgrT82+fQ3bYL5SejaPyrbR1U4VJyoGygLe5XwpGhCTFrdev063NHSg5mlsWmIhdaRaB1uF1+NbJpF1kP3ctV/3c0eSNQltrd8mJeOBjxehbaoa78JA214Jn3g2e7rGK3C1s91BDiZpwn6bCKREv890I/HpqSmupMQGtqp/7SITeETVFiIswNoHHBN5wGVyujg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f80881-d122-4766-3329-08db14ce7063
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:08.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3eh7uUi4r+D7CjXUB8ByEqCdXOm5vZJ/6ch9ZY8FZBL/VB53sHF2lssIh3tJsCtOIoJxbgb3u3Uuq/JxCXDiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-ORIG-GUID: AUw-ZQG6LSj6jw4ehMiU324xvvAKdkSO
X-Proofpoint-GUID: AUw-ZQG6LSj6jw4ehMiU324xvvAKdkSO
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
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/keystone-reset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index c720112db704..83a4e1c9bf94 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -169,5 +169,4 @@ module_platform_driver(rsctrl_driver);
 
 MODULE_AUTHOR("Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>");
 MODULE_DESCRIPTION("Texas Instruments keystone reset driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
-- 
2.39.1.268.g9de2f9a303

