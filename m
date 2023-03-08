Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDA6B1254
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCHTpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCHTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0CCEF91;
        Wed,  8 Mar 2023 11:44:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiIa7011141;
        Wed, 8 Mar 2023 19:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ATkwqH9ZKM+29h1/vWasRcQ0+FHX1gb1SQDIAaSxnds=;
 b=fq09R6DW6NwIYgAsyRfyqPE/MwtKHQXofZhMpV2srAgIPMdWtIGcEEPCZrLb7sDngEJi
 Zfbk/oUpy3WizMST3v4uCmCxIIqgFtGpuh9aflodH7bPHcLDiSN/hkNcFmJU35uR1pf6
 fV5kNrQrEDYltRACSsc4o4W132lOHMehs8Ff6rW76lXjCmOIVk+lrC6bpbSxviI6BJdR
 NZtav3pZQRG5FrifXFpVCYwPtbOhkPicC//wNl/HsGLN9CnXljdnIPZcGm+Bb7djAsXb
 t3LdYEIgALR3H7Jp/GyGcjfFK6mK0DuMoVkvmyCDNM/FftGq3IYBfPaxPOyuew+9B4du NA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417ch1ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IMj9t036506;
        Wed, 8 Mar 2023 19:44:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g45y0gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAJG7Ty5emj7v9RCqxqwXaijK5WrMLmg3asRlcUbUcXiI1F1AU+zRfuC0f3v2lkqU9kgok9N/wnlJWDauCuwjhqJGEBRcOi17TFC8EUsS4ON0jK6ZgS+iWr0rRSEKUT6+5NqYaFDWPh4WrsnFesBG0hwN6EFK7N2547aogDD9K6jVs8Ru0TwVZazlKnCmHZQNyi1cr0UVMtPstK38dd0HNeVPCCrAxd85BWfnm+dzlEFNOLi4z5xqkS9yD19eflPh2P/5fcWNLevnKsavj/pprMI4DszXFeK+Ab0u48D5StcPp18xUzmzdxG38l0V5W0avWlXk37DceBZQnJS+MTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATkwqH9ZKM+29h1/vWasRcQ0+FHX1gb1SQDIAaSxnds=;
 b=VV4Ee4bcZpKNy2OO9lMyUjkx4ayUpDoWvhZLEuTeyiiFG7VZ+hx43lWX9fq1OMGGzZ3fe9bQfD+q8XKPGoBETuiU0R6GVshKOaN/eVvF4dFwC+w+byR8aaQUdw3tCjULt5tkTqBKyS2HjXq6kp3vpx+Z2DLvoDnAIfJYqnHBD/8/td5NkcoPBtF+w8IAgdz+PUqWXPTmP58B+MbdlQqGCbGuDfZE9ZB/EJHitpPQtv1+8dzwv/Xq8Zs4jDDLQSHTvC2Cwn7JrwC/GBKQTevZd9Ma7b5f25Hw8EdemOYE8iO2I7hQi5n05+7gu25B3q+5IXigc6mKKYHOSlhtk5uVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATkwqH9ZKM+29h1/vWasRcQ0+FHX1gb1SQDIAaSxnds=;
 b=AMpjUnCOMrJM/tevvxcLFfers8BVGXRccM24EMEQIrY32F1UmnHgOHOgwXKSOMyjhasTMWu04ILZR5H61RjCe24uu39tueGVu+vjm76j2UN5jU0GKLfXnimP1VsWxuGfLZvZMr8aTnNehLKCpDyYyuo80kmctgYp0zrRoLowumI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:11 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:10 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] mfd: ezx-pcap: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:02 +0000
Message-Id: <20230308194307.374789-13-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: afd9b563-e2e7-4959-78ab-08db200d7d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdn3F5bWWjUjr0WIHUzxSYYe8/6l3QA7O/vnZTdPOl8OTEbRi4DIeBaAFD8lI8ZuvpZISMd9MjYgnb7UYrnGkXMbZX3rM4efK5QDjcXdkBXrQhsYib0NBZC0IEZCYFz0UHJyMVjAh6Qi9Y7/mJc/yDdDUh3wIJ2zHx0dlfkkZ3scFY9ige9lEDFpk9RO1tTnCnRj51acgmiJCNIgKWJZh/9BUeOGU8RGGgwI7C+L86W3IUl22nd1SVFmjJpDcL8Lhmp4IRz/O8oXdA/lMmlLwN/wGbN6JqHqSR2lru5QjVABu7ZxodRDlzQAJsdrl29xRr2A99gPdKpSIxxApw1yg9/s4c5N0wIvooIsukb6vY2//O23XaP37Vza5psYmiJvhXY2IgA1jZFznV+2kM23Mi/1fQLQxkqUHWGkS26Wkgp7vQhpLWXo24HPxaYiZ1Kntg3XePLFlvWEPfrKQyVJ1XCj6nVXPvqrPIhJj4nEuQZiY1+oo4UrE0W3xpj+vRvBe9Nt4lksjdsZMo9ogrZz9k3dIpV4CxMREj9sl6jW+0b9xO5TW83y9H6UVJv/4SJ8eD+gJ98tO96M0YMvyQT4cY3ggASK8qnczT5QWciQ+YZMhBInvzpU+/6pmgqML4fMhn0lqx/kAincKLLRAktp1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCKW0Myv3bd7y47mIf6EENewiDYB2knYdUhu2D4GRKqdOmGJDS/DlR6g12wa?=
 =?us-ascii?Q?B9aFnN+r+ELiNv1JergUXMW41ywSL5xCgW8/qleLaMcrHXXwbjUwG+POLFbG?=
 =?us-ascii?Q?YGhjOg5gKrP/sFQsmikENc3Geop/aMWybfFrmQ+DJ98Ewm3rF6HcGUTDCK/8?=
 =?us-ascii?Q?/FLCeU5I7DYhRP7T2KAy8MpJ67OQWIrVcmD01bwN0pnChqQmIjInDbRGBXJy?=
 =?us-ascii?Q?vMzrfXSh3YYvl6EbS8PBUvBjoZZNMtgFErfd1lOiO0qyMlSk90BsBs/Old8X?=
 =?us-ascii?Q?xqwQS35gBeP3XosWCBR1hQ+NffXJeF7DOtkW0QTRNVO30SDpqVQrErohd3zo?=
 =?us-ascii?Q?beCl13mWrZTRySTAb0xs8Z98YdWVNqX19IDDXVvi+w71/N6GvFXTw528jKJC?=
 =?us-ascii?Q?tmxe62PDX+EgpyAbbYalGpXapSL3O8QG4Hg0QjrRdXMwwx25vQJ6kVfbJfo6?=
 =?us-ascii?Q?NiuIMEL2n0ABZ3Ha21/thpGYNu4hVrPpw3fmGvaa3r6G1Cv8aF2EYX5pc9qN?=
 =?us-ascii?Q?eufLlWmYZ2y91niI7HOQA4AWYTkPn0INamkHple0xOzAVttvURMHAy6XoFge?=
 =?us-ascii?Q?vKkKz+BgLmIgYXB9qkZxd3hu+6tDf1n0WwL4cKwyvhWudGa0Dbq1bl5tK9kr?=
 =?us-ascii?Q?Jt2mcz0xAM3eu0F3meqBVC+0ppbtm9VDmD8FqtrZD2jU+WEeJE3LJ/1PdOL/?=
 =?us-ascii?Q?t9nTLZRDG9iUOKJGj74rGOeIR9gq0Re5uTw5805ugj+m97W77mb/k0pFsM20?=
 =?us-ascii?Q?A40W49Xwuv6bEIfSjQoTz0k0vVSCoMS/ZYHKb1yaE1LQdY/lMym9+7AeDl2N?=
 =?us-ascii?Q?iPQ9nfNQ7W73zVuZzI+Rjw9gF74wPPPsB/PdOAJlJFTMB4isC3sVHIh+Uxox?=
 =?us-ascii?Q?XSZmtC7EisKqzR1fYxAPQurPnrI1y2FTpNZO38oLcx10Zk+16QQIRlHjBtpU?=
 =?us-ascii?Q?deA3GmcvZzGBDR5DSqm0IxBHAZP22R9KMGKxpV8PuUGb3fGVFJsMdGxgnacV?=
 =?us-ascii?Q?OPLa5gl/XiWjNjbXV8/Hel0UnaFrTcn2XHANxCe024Thre+lcwXp5uX8xQrl?=
 =?us-ascii?Q?/FHp+CKEb5lYpJIf4MXhCNCY7ufsTSuA5LvWa/+z+yLL7L37YsUcUpShDFmI?=
 =?us-ascii?Q?lglqv33RQQlGWrkNZ/385CFVaya48af4gCNnt6S/mnG3cDBnkdBrQBrlo0Q+?=
 =?us-ascii?Q?AgJl5gChj6SJy8isfiYHEacNfviJLrRXoMuhZ+wgg5psrXW2tferPKkNdk8/?=
 =?us-ascii?Q?4YxJdd5OIh/HWMh0s1yrlYjv2ErBMkfHVyWEti9E+Wl08SkvtGhnkgVhbu5Q?=
 =?us-ascii?Q?x/6VpidMDWsj05wGXDBulKkA7Bu5ItGT+LoRrWHAKQdjL7V41bKtj48dRcfg?=
 =?us-ascii?Q?fdmkQhbPfONGRXStuE3IlqbMeJd4AhM9mTcCY+AGm2MwBwEV6nYaG/DR3Iax?=
 =?us-ascii?Q?QgXk3fPqHJEj7w70k4+YLRDQX/g6yni+F/ZTHgNqn4hkcuD/H2xbBnHXc/GM?=
 =?us-ascii?Q?zJZ0Jb9rTGH/7zoRQDkTHI2IpPPfHlAPkbstS5mZ2lmTrqdvmSmvQUGOOgSw?=
 =?us-ascii?Q?ttL8nb0PVNKIO7LzeVvEEeV1G2zVNpXaGj7VP51azIoreFVsP6+pu20BHFmI?=
 =?us-ascii?Q?H3PjqFKCqXOSOLDSH6clork=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j9AifCtJI7UO97qIE33qx4oKzc/rMP+GN9Pn5GXiR0VmiH9KVTIRWcQWVjkcIIu63s2/V1FhkDPh1QmDJlzev12YvOZ1gObTi+o/iNJh5O9HdMYxViKvuEUZgPx9X/C3b8zWQBSAdBVjrRvzkxHu0KRSbi+kosKJ+eLLJVVrjFGvu33bJbFESuFdrSPgjDM/7V6NRQNqJEfvpyw/UkRqqqvV6BUXhQj2NgwhDC4rNv387q6VGY2vcrEMnfgW2XPHbQ3+QSbEMmbFDy9xQti6/QD1KWSYoLupMgVAl07ckhq5YoAVU3mxaTEovVm2a0ykTXY0OtWPbyKUFCHKLi/sBAiKYE6q/FIVCGKMkc/bE+Tv28byn65pH+B25IweE5piBGZAIXGsuV0E54i2gFarLDw9EWMMEYtq6WxwAgzZ45mgPaJYHR9FI9SsSXX+kd27GeEEfV6wpwA2/Nt4udz8o1SNOXzAwaj9jNC+yzpEI8mgv/dV7LqFO877If6CuBZeJS0+BsguQT2vzWhwYSsIf5mU6/vI6Uvmo8PzLsWMEvnrXGqbkoqUJhFrSO1Fac8WC83flXNcsT+oyjgD3k901/70mxi/JayqRML7HdhoCX35plbRC8HZPCsN+9cu3no6K9B2kAMmewq2niSV5VzBeywPTh8ABY6n34zLYfE7p/WECN3gS0IJVhFSOisr0gTFF2xsNGqKmWssncSGAxnh8r66dBxdQksKxfrEmEGDjAaEBC6gVIHQ8cjwXyqMEujfN82QlMd+b/ajg4ntgaURviJJVVIpCSSY5ebc5lTUv40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd9b563-e2e7-4959-78ab-08db200d7d11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:10.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2tubETHd2dyXpI9gRwscTDSn/BH4IWWV+WZrkNV54URs7V+IszrsPAGRcRqDnQFtja/hMOjb+3veGnzvE6bew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: dYzjhSUjUWhxq-HEy2aE7VOdCPDSHwbz
X-Proofpoint-ORIG-GUID: dYzjhSUjUWhxq-HEy2aE7VOdCPDSHwbz
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
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ezx-pcap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 3d5ce18aa9ae7..8d006f6be48c7 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -528,7 +528,6 @@ static void __exit ezx_pcap_exit(void)
 subsys_initcall(ezx_pcap_init);
 module_exit(ezx_pcap_exit);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel Ribeiro / Harald Welte");
 MODULE_DESCRIPTION("Motorola PCAP2 ASIC Driver");
 MODULE_ALIAS("spi:ezx-pcap");
-- 
2.39.1.268.g9de2f9a303

