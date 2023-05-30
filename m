Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4833716DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjE3Tk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjE3Tkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:40:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93426F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:40:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJW1se002469;
        Tue, 30 May 2023 19:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=L43E44kWSr0c0jV9sRrZTB0m3KhuZQDOHJYJYhQ2QY0=;
 b=LBID6qz8tU+rqzg0SvjhycBU53t+UUPJaT7lUJmjW5b6vBJyezZDfzVN5xH4gPAB5Gl2
 7H67q7TjzF9A+62JxWvNykzToPqmxUFidgEPhYK2ce3+oX1dUY/KbkyywbRZyGAX4RWL
 GZkXrILRj+adhncxsDfn0oRfKJ23LUEGzFXIWK0AH4vUlOsYWdOORevNmMKONK2CJVDk
 09GZowJBn4EzQD+IQ9ncs+J1aRKyTGHDMoA+ab57OD2V99Rj07VaoWUUejlLFKdYNQhM
 jAG8xc/iHn4WE+uGk1qxPDeu4dNuauAmZ0gWYf6/K/irCHEzyOMikJqx51YuCy6MG/yX zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9uuby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UIlE6u019825;
        Tue, 30 May 2023 19:40:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a4mb6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjEN5tXh6NyFisHuBMk8r5StuZuRepbJx/R8DIrJew72bXJ9DNMztRiJ9upI7AQ5L/rGbdmH+wL5niFATf5gRUVWXYqWvHj4LEn2u3mekpTxOkBnLTQ34jFPuIGJlxl8Ki1uhJQ4zAnufOOuDlu8JvaHqOtlDY29x2fD276yQEAIxVcd9hjb8FhrVQotIMpgNuGLqHL5efRtcq4QhHZuCVAwqpAQIBqEDOxn0YJRV8ncfL7RcV8w/AreiSIANpydLmEn2URzlnRG5O47ZocQP5VuD8GHzF6Q04riEi8Ahnpu3yKRwyE7IdvZilSkkJ1Y2u4v5Dt3fWuE5L7mF5MzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L43E44kWSr0c0jV9sRrZTB0m3KhuZQDOHJYJYhQ2QY0=;
 b=NVqp5rm1PuGcU+KSTkGnAbFpKaioalpe2XnC/Ddo/oilKdiKxOi9yu37+ugYE1lwwnOqaezQ62pUPl974H9YtjKhro9OEBqNmmGDFV8DkU0kkzj1Tsput5i94dF1oVso3CY2T65UuInOUORYZzDBQqDVc1BFuM27Vdm+Jf/yM/G29/bDRsemP65cdDW4vkjDPeFe2sCa27aout07zpifgZfHKIbRuvJJ+yvgcKpGf6X87Ntc8H4SqtEJTFZ8stTdi5R3cVMwhrq/DsuqBG/QLP2tb6Py8fX48tHUS4DNendZ1X3ZNtkkAP93UhbRqrkJViWOTUcj0iM1xLWKmAKHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L43E44kWSr0c0jV9sRrZTB0m3KhuZQDOHJYJYhQ2QY0=;
 b=tpKePSeHy3hoXL03NZu9CalGqAQ4EQXQ+qKxHIOWv7KeGps+q9A8u/I43+Djcf2eANRdD3OrBWAmOT6WX0duKhrUQ6RJ742qrMZGI7VrPIoizGgYDJudGYAtYcbI0nk5RBphPzACINoGPEMf0V7DPz7+QHZTllZeUgWKn3rigio=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 19:40:35 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:40:35 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/4] debugfs: provide testing for the min/max simple debug files.
Date:   Tue, 30 May 2023 15:40:11 -0400
Message-Id: <20230530194012.44411-4-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530194012.44411-1-chris.hyser@oracle.com>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca88047-85c1-4911-d352-08db6145bcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Trtk8dU6wD59R/GKVqVadu8aBrgJvDz2eaE5/JHexPZ9gBbBhRiCTZidPh4NQvTfT+527pA1wh6v51/7u5EnCpSyy8dOGQg2HT/j2DnhOptqa5cuXxkfhf1O8iBo5byMWbKzmv1VOcu6oHWiRlXrWamXP/LS15qU91I3SjZpfOj0auloZQbRtSAK1Br1KemA/UFPHEQ/l8R5+Bfvb4v1Ni+gJ+OCKugk2wmx3ZPWhZDVjwnrp+Wrf1VFBw+HaFwHMAEM16a+Bsrbyz6IQo186HDlp1N7fYe5ORMdkkaSEpgepKQoi37gmK2s0uoYj+ShVHMxHU0QlqwfZTS5P81GoE//c8K1i5fgvTOdTMGHYOfQoM/54P4bpeBxGZJGiBeuiaiWmrGCHHV222en8GauQ0aDbvY7Ndu8NEXGnEr8Qh9wE9dXbL+lf6N3WEucpEPJAT2zX7NGXUAJWaLpjr0oFHunOfLGY4Kv0wz2LNKDwKHr6tLziVrE3BDiYB9D9R4lt4aFipuEk+VuoW16TwIAWFs+AMNQl/BW04lpGJW8hzz5NpvN0lNymaskdFpEn9upDYnnZ6sPvcll7Njy64fv2eEsyWiNMkBjJ2+9X4psTGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(478600001)(8676002)(8936002)(5660300002)(6916009)(36756003)(2906002)(86362001)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(6512007)(26005)(1076003)(6506007)(6486002)(6666004)(83380400001)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dUgy34BowQh5MoHiM1kt/DnD678Aagk42GJ2xixHw1CoiGTrLtbrZQ9goMS?=
 =?us-ascii?Q?ToAgmwAvHuOsPcONa67Ox0PZWFsL8NckMUBWdNUhS3IpZntkBz5HbURwhPGI?=
 =?us-ascii?Q?XYrZ6v4CtGOySNiHRDaVrmFVW7fdL8SuM0plbarNf+MHVV32RMmO9u43DN0D?=
 =?us-ascii?Q?8ce36zmiRrjxynQQeocAABf3mXzXj/hXoMpDrvNHZDceAABClTryjtegIDqQ?=
 =?us-ascii?Q?ZMKRDS+N+DEEWaTzRQbkVJAYk9J4hod5LJ7XEi2J//Hw0dbcehVc5kOS5inn?=
 =?us-ascii?Q?fY5rfMzx1UCnhNHivp9E/NHFkd0OOLgMiGO5vQtikuwtJZIftXBoBbZVdlP6?=
 =?us-ascii?Q?dTxSBdQerXzMgGMmiDyEyXfc1ZjfcoWWLwhGw7Ni+tGzvYLgOXHKYWqH7+V8?=
 =?us-ascii?Q?qi7cnWHAM6rXm+UYsPxe0qwmn7YcoR8IvVCR27cgdwrhS+nEsSFAd0V49Oyl?=
 =?us-ascii?Q?pous+4gl43fLKiht10MierLmwDLNIsctJE9VdRlyonwqp/rhNMJwbQLtKa2H?=
 =?us-ascii?Q?ba7zUR75F/uk+26ovHM9OikbAFbq9YKGYVrElKMmlMITISfCaGzyyKpFOt8P?=
 =?us-ascii?Q?QKb+2J/vlNjwi94OB8/Fi62GDQyFiVrhdKhQOX9bRDGHFDg4BVlj8hZyM4wR?=
 =?us-ascii?Q?SGMES41Etz8Oo/PpSVYjF4kEqvGRldrxIuAO6p1W99z7BcOKI8w14tKcV47u?=
 =?us-ascii?Q?LzJacfQm0dKAthBC3RpeZxAlhrC+FTyxZXB6PWoBadys0iHPU+R9bqut/JX5?=
 =?us-ascii?Q?8L/w4QP46AJ1PRbPHtUatCf1HA7CnXcJ5BbctmWxbZbG5vTyCwGlJ72ZU6RQ?=
 =?us-ascii?Q?DLBdooVXBemP8WKsZmEV0HhwvyG2cVdxZxBgCJRyGwQiPCL3uslmuJtEzMhj?=
 =?us-ascii?Q?foxggpCTzZI0ErzhTqXU0L8ZNaXy0+lGLcWpUkMy48iWFFoT63PY3XB1+lxo?=
 =?us-ascii?Q?zWMZf75kuudcZzKCnaXarK2fQqILPa6j+Y2xQJb1rlgx6w+FnxTPKiuWWoX1?=
 =?us-ascii?Q?iHu4YIrdoARAMUsYibmZO38HY9KtQ1r/9sDd2jGQmvvRyz43XmyeCLYawbJ6?=
 =?us-ascii?Q?xm5iRN4tBmcFu3UHdCC1angF+NWxT5cHu2WTVJENV9S8mdDqDmW+0AmSrYrm?=
 =?us-ascii?Q?eBuP9NWgPgLK4EyXyfTyPY38u1cPizQikXLvRc/x0EqlUft777X1h6yswv12?=
 =?us-ascii?Q?xV+1wlR39M9DwvTmSPXXFvXiiDCUqL4mhWuzX/WwLlfemDOP8UByFt2pdKD7?=
 =?us-ascii?Q?Xrj4C++8o3qM/5EyTbq2vxyTAOmpB9XLlxGrB1RDiBkbwkg321ohl1A9sEg1?=
 =?us-ascii?Q?gePWHFYuZOww5XnhbQiFQR0pyMDt1X8biyGryzF/+kcWPUlqpN8UkPV/z5q0?=
 =?us-ascii?Q?mPIUNIaOfVBLWeqUP6VT8Z2uqZFjikyZUmMbsu9Y9U94n5PWW55oFeH2lC78?=
 =?us-ascii?Q?Z/Ku5l+fJ/3aogjftHyGIgOFUNj/YOUxSXLjEx8c/gG+tnCujJMO8eXRaLsp?=
 =?us-ascii?Q?a8IlDWREddAjnDZBt/j8do4GHUgRCXkycVeLDrONsNGH7yTCD6X4eLnquDEo?=
 =?us-ascii?Q?uhA6jiUoeURbVXt3BUS1yAwgs9Yf8FpgesRCbOiF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5nwE3OFj78sBMmadpP+geI7VpETmmXIQ4a1TfoQVkogNIZhwTeS4actnc9QJTI7Kaln3g4wwHXA0dhP6wiDWeh2aM2tdoD1wO44QR8k+uxFmB02BYrV5PsE6lWwsuOmJyvWpyJ5ZxZaKfD8ozBF35mOLxdwE+BpuHUaTWInlIr26amKHL8vVjOPgrUdHX2O5dLuhXLq4QefalVGCNiIfuaJZbDV4ovDiCFO6VBaLcmKjK44THMNAPM6Z3xuByvx9kPkQlllCFP4yHl0cEjk4/ncngmBO3zUtaTC6hMLTHczbkFK3qZVC5+8s6W3e+V0S+ou29hEFqbnN1gbE8MWlRI3UKqLdWyRk4mQD5pK2Ej4HkyJojT/4llkZhhJ/U6NOQKbAgTtGNNUli/8BK4+aWAkuCCR8abNn6QFYAo1IUC/tCPnAVMYY9utpijohzQ7qUFVEI6VTxhfvJvVqqfcSrzEBhw3kAuarkVhkTu8mEFH2X6AI10zT6ROX+JmUCvOCnwSscGG0IT0epD7y9yxmE2Us8xKGqQ15QFyH7iOBnK2MzmCJwRZGKYV5lwZqMtGBkoJ8YxbUt6jBNlsmP8DsgptaDlE6TD1GWzHEQaqLeRHwdnmZbPPJakF9Ostxz336ciXa7Yar46fro5Bqydj3JsuaTQ4nqyDsmOqx3CeYhgYaDjimYTzOc0fyKrNCVrLkQ1e+LKI1YZ+UJ4d4TOvCz8iC7zY3dPxvfu5LrGgX79cdHlP4hl1lIraKxhxwmwE+4PRDBVHiMyVI8CYV+JlBzhX9q8J7t+jFswVrvBANCILryIaLPiCoftJF7QVfd2v/gAZ9LnBXS5gTZRLckkj8wEHLgqx59lgIuCXdvy2OgxvHZIuu05oaQqmJ90ZGJjZj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca88047-85c1-4911-d352-08db6145bcbe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:40:35.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /InH29DAdB6ng/Nrj5oIGlmrwsBzoaUkRf3chrfeBALXIy7cvyy6TZg2FiOvtCqSvWJR+b8DIODq16SlmtcHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_15,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300159
X-Proofpoint-GUID: NCYLMpkoE6_OjbnK1UGAvw_OVnbvhB7x
X-Proofpoint-ORIG-GUID: NCYLMpkoE6_OjbnK1UGAvw_OVnbvhB7x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains a module and a bash script which tests the new simple
"unsigned min/max checking" files.

The module creates the debugfs files and encodes the test type and test
parameters in the file name which the script decodes and tests.

Currently the files were placed under testscripts though auto testing is
not yet enabled. The hope is that this eases testing of the patches.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 tools/testing/selftests/debugfs/Makefile      |  15 ++
 tools/testing/selftests/debugfs/minmax_test.c | 140 +++++++++++++++++
 .../testing/selftests/debugfs/test_minmax.sh  | 147 ++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 tools/testing/selftests/debugfs/Makefile
 create mode 100644 tools/testing/selftests/debugfs/minmax_test.c
 create mode 100755 tools/testing/selftests/debugfs/test_minmax.sh

diff --git a/tools/testing/selftests/debugfs/Makefile b/tools/testing/selftests/debugfs/Makefile
new file mode 100644
index 000000000000..5dddaaf6c7a2
--- /dev/null
+++ b/tools/testing/selftests/debugfs/Makefile
@@ -0,0 +1,15 @@
+obj-m := minmax_test.o
+
+KDIR := ../../../..
+PWD := $(shell pwd)
+WARN_FLAGS += -Wall
+
+.PHONY: all
+all:
+	$(MAKE) -C $(KDIR) M=$(PWD) modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(PWD) clean
+
+
+include ../lib.mk
diff --git a/tools/testing/selftests/debugfs/minmax_test.c b/tools/testing/selftests/debugfs/minmax_test.c
new file mode 100644
index 000000000000..0e0f6bcd6302
--- /dev/null
+++ b/tools/testing/selftests/debugfs/minmax_test.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test debugfs minmax simple files.
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ * Author: Chris Hyser <chris.hyser@oracle.com>
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this library; if not, see <http://www.gnu.org/licenses>.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+MODULE_LICENSE("GPL");
+
+#define MIN_MAX 1
+
+static struct dentry *dir = NULL;
+
+#ifdef MIN_MAX
+u8 test_max_8 = 250;
+DEBUGFS_MAX_ATTRIBUTES(test_max_8_p, &test_max_8, 252);
+
+u8 test_min_8 = 250;
+DEBUGFS_MIN_ATTRIBUTES(test_min_8_p, &test_min_8, 25);
+
+u8 test_minmax_8 = 250;
+DEBUGFS_MINMAX_ATTRIBUTES(test_minmax_8_p, &test_minmax_8, 100, 253);
+
+
+u16 test_max_16 = 250;
+DEBUGFS_MAX_ATTRIBUTES(test_max_16_p, &test_max_16, 0x1fff);
+
+u16 test_min_16 = 250;
+DEBUGFS_MIN_ATTRIBUTES(test_min_16_p, &test_min_16, 100);
+
+u16 test_minmax_16 = 250;
+DEBUGFS_MINMAX_ATTRIBUTES(test_minmax_16_p, &test_minmax_16, 100, 300);
+
+
+u32 test_max_32 = 250;
+DEBUGFS_MAX_ATTRIBUTES(test_max_32_p, &test_max_32, 0x1fffffff);
+
+u32 test_min_32 = 250;
+DEBUGFS_MIN_ATTRIBUTES(test_min_32_p, &test_min_32, 100);
+
+u32 test_minmax_32 = 250;
+DEBUGFS_MINMAX_ATTRIBUTES(test_minmax_32_p, &test_minmax_32, 100, 0x1fffffff);
+
+/* test setting everything directly */
+u32 test_minmax_32_s = 250;
+static struct debugfs_minmax_params test_minmax_32_ps = {
+	.value = &test_minmax_32_s,
+	.min = 100,
+	.max = 0x1fffffff,
+	.flags = 3,
+};
+
+u64 test_max_64 = 250;
+DEBUGFS_MAX_ATTRIBUTES(test_max_64_p, &test_max_64, 0x1fffffff);
+
+u64 test_min_64 = 250;
+DEBUGFS_MIN_ATTRIBUTES(test_min_64_p, &test_min_64, 100);
+
+u64 test_minmax_64 = 250;
+DEBUGFS_MINMAX_ATTRIBUTES(test_minmax_64_p, &test_minmax_64, 100, 300);
+#endif
+
+u8 test_reg_8 = 250;
+u16 test_reg_16 = 250;
+u32 test_reg_32 = 250;
+u64 test_reg_64 = 250;
+
+u8 test_regx_8 = 250;
+u16 test_regx_16 = 250;
+u32 test_regx_32 = 250;
+u64 test_regx_64 = 250;
+
+
+/* File names consist of test_<test_type>_<1st param>_<optional sec
+ * param>_<storage size in bits>.
+ */
+
+int init_module(void)
+{
+	pr_err("minmax_test: init_module()\n");
+	dir = debugfs_create_dir("minmax_test", 0);
+	if (dir == NULL) {
+		printk(KERN_ALERT "minmax_test: can't create dir 'minmax_test'\n");
+		return -1;
+	}
+
+#ifdef MIN_MAX
+        debugfs_create_u8_minmax("test_max_252_8", 0644, dir, &test_max_8_p);
+        debugfs_create_u8_minmax("test_min_25_8", 0644, dir, &test_min_8_p);
+        debugfs_create_u8_minmax("test_minmax_100_253_8", 0644, dir, &test_minmax_8_p);
+
+        debugfs_create_u16_minmax("test_max_0x1fff_16", 0644, dir, &test_max_16_p);
+        debugfs_create_u16_minmax("test_min_100_16", 0644, dir, &test_min_16_p);
+        debugfs_create_u16_minmax("test_minmax_100_300_16", 0644, dir, &test_minmax_16_p);
+
+        debugfs_create_u32_minmax("test_max_0x1fffffff_32", 0644, dir, &test_max_32_p);
+        debugfs_create_u32_minmax("test_min_100_32", 0644, dir, &test_min_32_p);
+        debugfs_create_u32_minmax("test_minmax_100_0x1fffffff_32", 0644, dir, &test_minmax_32_p);
+        debugfs_create_u32_minmax("testss_minmax_100_0x1fffffff_32", 0644, dir, &test_minmax_32_ps);
+
+        debugfs_create_u64_minmax("test_max_0x1fffffff_64", 0644, dir, &test_max_64_p);
+        debugfs_create_u64_minmax("test_min_100_64", 0644, dir, &test_min_64_p);
+        debugfs_create_u64_minmax("test_minmax_100_300_64", 0644, dir, &test_minmax_64_p);
+#endif
+
+        debugfs_create_u8("test_reg_8", 0644, dir, &test_reg_8);
+        debugfs_create_u16("test_reg_16", 0644, dir, &test_reg_16);
+        debugfs_create_u32("test_reg_32", 0644, dir, &test_reg_32);
+        debugfs_create_u64("test_reg_64", 0644, dir, &test_reg_64);
+
+        debugfs_create_x8("test_regx_8", 0644, dir, &test_regx_8);
+        debugfs_create_x16("test_regx_16", 0644, dir, &test_regx_16);
+        debugfs_create_x32("test_regx_32", 0644, dir, &test_regx_32);
+        debugfs_create_x64("test_regx_64", 0644, dir, &test_regx_64);
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	pr_err("minmax_test: cleanup_module()\n");
+	debugfs_remove_recursive(dir);
+}
diff --git a/tools/testing/selftests/debugfs/test_minmax.sh b/tools/testing/selftests/debugfs/test_minmax.sh
new file mode 100755
index 000000000000..67ed7b9abac2
--- /dev/null
+++ b/tools/testing/selftests/debugfs/test_minmax.sh
@@ -0,0 +1,147 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test debugfs minmax simple files.
+#
+# Copyright (c) 2023 Oracle and/or its affiliates.
+# Author: Chris Hyser <chris.hyser@oracle.com>
+#
+# This library is free software; you can redistribute it and/or modify it
+# under the terms of version 2.1 of the GNU Lesser General Public License as
+# published by the Free Software Foundation.
+#
+# This library is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+# for more details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this library; if not, see <http://www.gnu.org/licenses>.
+
+rmmod minmax_test 2>/dev/null
+insmod minmax_test.ko
+
+cd /sys/kernel/debug/minmax_test
+pwd
+
+function split_wds()
+{
+    words=()
+    local IFS=_
+    for w in $1; do
+	words+=($w)
+    done
+}
+
+function test_max()
+{
+    echo $2 > $1
+    local res=$?
+    local rv=$(cat $1)
+    if ! (( res == 0 && $2 == rv )); then
+	return 1
+    fi
+
+    local max=$(($2 + 1))
+    echo $max > $1 2>/dev/null
+    res=$?
+    rv=$(cat $1)
+    if ! [[ $res -ne 0 && $2 -eq $rv ]]; then
+	return 1
+    fi
+    return 0
+}
+
+function test_min()
+{
+    echo $2 > $1
+    local res=$?
+    local rv=$(cat $1)
+    if ! [[ $res -eq 0 && $2 -eq $rv ]]; then
+	return 1
+    fi
+
+    local min=$(($2 - 1))
+    echo $min > $1 2>/dev/null
+    res=$?
+    rv=$(cat $1)
+    if ! [[ $res -ne 0 && $2 -eq $rv ]]; then
+	return 1
+    fi
+    return 0
+}
+
+function test_minmax()
+{
+    test_min $1 ${words[2]}
+    if [[ $? -ne 0 ]]; then
+	echo "$1: min error"
+        return 1
+    fi
+    test_max $1 ${words[3]}
+    if [[ $? -ne 0 ]]; then
+	echo "$1: max error"
+        return 1
+    fi
+    return 0
+}
+
+function test_reg()
+{
+    if [[ $2 -eq 64 ]]; then
+	local V=313
+
+	echo $V > $1 2>/dev/null
+
+	local rv=$(cat $1)
+	if ! (( rv == V )); then
+	    return 1
+	fi
+	return 0
+    fi
+
+    local max=$(((1 << $2) - 1))
+    test_max $1 $max
+    if [[ $? -ne 0 ]]; then
+	echo "$1: reg/x error"
+        return 1
+    fi
+    return 0
+}
+
+rc=0
+for f in *; do
+    split_wds $f
+    echo file: $f
+
+    if [[ ${words[1]} == "min" ]]; then
+	test_min $f ${words[2]}
+	if [[ $? -ne 0 ]]; then
+	    echo "$f: min error"
+	    rc=1
+	fi
+    elif [[ ${words[1]} == "max" ]]; then
+	test_max $f ${words[2]}
+	if [[ $? -ne 0 ]]; then
+	    echo "$f: max error"
+	    rc=1
+	fi
+    elif [[ ${words[1]} == "minmax" ]]; then
+	test_minmax $f ${words[2]} ${words[3]}
+	if [[ $? -ne 0 ]]; then
+	    echo "$f: minmax error"
+	    rc=1
+	fi
+    elif [[ ${words[1]} == "reg" || ${words[1]} == "regx" ]]; then
+	test_reg $f ${words[2]}
+	if [[ $? -ne 0 ]]; then
+	    echo "$f: reg/x error"
+	    rc=1
+	fi
+    fi
+done
+
+rmmod minmax_test
+
+exit $rc
-- 
2.31.1

