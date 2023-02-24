Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320C6A1E32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjBXPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjBXPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:11:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AA69ACB;
        Fri, 24 Feb 2023 07:11:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEn2Lm003403;
        Fri, 24 Feb 2023 15:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ce6eJUF2k6XnFtxOewephDZpRcUvtcr+BhJjHDmtf5Y=;
 b=di0vARE/6nlbhQJZzByxg0vERrk4OTXFWrDyOG2eDapHhE5a6H2BAWdpXWnyMmt3YioB
 RxyoOv1w7IFNoZWYV1rYEywPz6t7BFeaZZzjZ+xqlfVdMLmnkqq1rW3beUao6PIfhhlT
 wuPZaKVgpB1hu4fyuovh+n8sZGhvvDalXLdyjeOp7Ty9surCRLyltdawEP35ilqbR5cy
 97VPPGzOaD2YHW5t6xPxQjJ33uXp1U07nUI3x/dWuLehZfUnGqq8na1ixzvkHNItAQ8Q
 kqgPJpnVcL9Y35O+xN6cUlczpE9Rb02upz4Eb4inF+En+wKbCJuuK2MK+f4dOyX4Kkq3 Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3nbc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OEkjl4000653;
        Fri, 24 Feb 2023 15:09:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nxsb4dutu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLjFAoUs2Ktt5b+mvNlB4gF8kNsHynFgQOVQPrR8GnrWJMg0Yq2ZCATvPql5dXx793tNg6ie2FTTSU/Erl+v83cbn8rNIMgeY+BgEg+spG2o//ESvmZzGxwTrPUFVdqXJIotg1L1upIFBJPszkqxiRN6MXk3w3CcL3Ku1Ct3BEJ9lxS7SGwchUGHtQajdgZNQXIO+x4mOFopnsjyAduBdUaEkQP+IetYZM5QJ1+biZDqnWKgj7M0I5ySauvqRvgxTXsN7TYRGzt5ymRfw2V1H64D1xWwkjQ2L3IEm/7i/a+gZd8BzsEI2nE7pQjrXz6JaPAT7iL2If+Y3DXJaeV1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce6eJUF2k6XnFtxOewephDZpRcUvtcr+BhJjHDmtf5Y=;
 b=ocogsQASh8OXTiG/oJTE/RPRsNr4NhtRGb3C5vY2wy4D2RBU8A4AfDFRu6lBcS+1N3vxl9MGGpU9RvXwUUjIlGD607LVJ/stVkBzPEPkd6wa3xRt9QUphyPkkzLoJKDe9B1EKg+CaoxIh4kxwanOx3wcWwdthpzXgAbNCkmT77bzkKkdFON/sj5X9TWgLB/1vuki1VNVfyE1DN7w9iU6aazcvB7uz6FrVSnM+x8znBTOtT+zZwPxLQlBm8YZRq+ktMD0FtudkcYjjc8lIRZLr/pztJdacEiGjp0epk3U3qrSs/VZdjB5pPJRenNvpWbAjT0KvgHORQ/THlvPA4skxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce6eJUF2k6XnFtxOewephDZpRcUvtcr+BhJjHDmtf5Y=;
 b=YVN0j/71D//eWVZJE1PUYxSSeL8ZKcP1g7naxn5MfQ8muzMSltXN1VHYqYSc+vWLUxkUMbLIDNF1kldNSHP4lNwugCNQ16QVK5u/uOs+IEkfhiQWvWYUDcVrZOgVMKdtdBaNdlg4DTNJmphh29fxeyq3790LlWDusvIUCNLpJ4M=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:52 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 19/27] irqchip/mchp-eic: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:03 +0000
Message-Id: <20230224150811.80316-20-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9023e185-2a74-47f5-e905-08db16792e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzlJ/I2P/BTPf6zz01+nDJCrfNCR/th/XVLs0oulj3//fy8Zu9UND3QaHpWaj5ioiyj7mEZrlnSuvEKmhek3jj+kHJCxtlH7ROtzKlGuV8A4uT2sPGOrH8v6yeg+hx3AQ8gIHTiLTEx0jJ0SsKwdGyEsEwx3OrKpYSZ639RkDMU5Gki2djohjNNx8ERmm7SF74rntcrmn30ylVKpydR85XGhTpN7wBO8+DeTdbPdaZHVsGog+733MN5sZzvR5Ng2N2id4GMEEoezxZEwlHSamjYiXSYVr5MBy6pvUDZwzp9KdrJQHdDgJdtac1qCvC/TOUGcZixTYyBkIUIMIoYLfS3HzlZRgNvMI+jRBWF6Pw0IbMITs2cLNfWloDEtVbv/z4jscyV3/zB/qTNzfnl86Bv6SMoGYhgA014nrz/BrvnWUFC9n0RLM9VZffu00FW17Nx3Mhma0EvUoxOwx5a58/pvajOcWKxT66YrQOziFtjecGJJRHkV7tUp6h4u/ZHGRJPnZ1kdWIWia8i84sxP2orkSjV8XcNTfn4g4NvLfruWu4mlVSoPonzxzJ1u9Tow8WXDRp6YFjYRouISkPIyjJrVn5y5juzR58wtSS2ZViEPSKJxnGwRQJm46hxTH6q/T8foVM6yd3UzWvYPeL0BSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(6666004)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCLGY1o1HtQxeFuV92E+sGi6hlAq3zRGLuVpEn7GI1D5hBic1eeqKf449uUY?=
 =?us-ascii?Q?2hYLBIaVtbExU8fX0xFpuPExqrUIpqGfag2f8y/aLs3oGi+p+wooD9a8DUIE?=
 =?us-ascii?Q?Sws/qXM7T1CHlbKOVlAHUp94ChOlIknpAxRz6KenjnTDcDCHTssFk8z3ReOr?=
 =?us-ascii?Q?twvZWNAMrGb8f227J5cckxu1QSTVEQ3e0XJkNh1+9/O5uw16Am+N92lzpRTA?=
 =?us-ascii?Q?wu86Rv48wlg2TTeZWzHw7caalQFftnAiYMJQm8wYRTBVE2xFndgm5bs5RMFa?=
 =?us-ascii?Q?wP+SzLEZ++PtsUkBgQrf53FV/Oa8ucirFLqi3AHfebsU/PH8QyuuzjP2lPIT?=
 =?us-ascii?Q?xj4VulEICI41hO3317lC44PCniKuEw5jxP5I5FP9wwC7Wej27EleaxVfnN67?=
 =?us-ascii?Q?3NpDxP139ms/JBW6EQcyKvcRHEqG259XWS9Aeyr6fgonLU2lbPA1wz6tA2A0?=
 =?us-ascii?Q?c84YO761xF0HiAq2z1OOVNkPMdfyKn0oqEEpOOQt5Npe9y7hj4xkVDHZcs6E?=
 =?us-ascii?Q?fvYT2o+igmMb5vTd6mEv42Yn+Jt/xugR9bS+vf/Sbxe+31M5jUbqXsm//Rbm?=
 =?us-ascii?Q?x9vlalbtKAM3Lc0Z5LM2r/vBg8dH5EUSryzr5OLqwQgTLDwGkhnyeZR0JNu4?=
 =?us-ascii?Q?bcYZs8MB873Lw2u0al4NE+UF4LoiP23d1/tRnQXpsQux8W631LchqDjRzYH9?=
 =?us-ascii?Q?CUd2Xnoq3cMvlKk2VHFGNQn05zF1QoW6DGsa/YK33KzFnLgv4Lzt2+Z6qas6?=
 =?us-ascii?Q?ZkowYUZS2PhBbJDAo+peyKWSPLXgKtu1yP/swDvTeu7eWXgz0wCXgI569NCi?=
 =?us-ascii?Q?9YBeAnp5zbhAf88C4HbLm1v6qHXhO0t6aQWQEV0VdiQ9ENkb5imHswuIGdY2?=
 =?us-ascii?Q?8uJtm5wwTAeqZvnjMg1dhuqlLI4V3d+1Jf5vMNxdCnmZ9otUUtUB6/s9dGm2?=
 =?us-ascii?Q?k+I7AXIUNbMXs/brxZ83yE6n4bvkM+nR3L1Da+1hmLBQg9vU2/OWgTN3G5C5?=
 =?us-ascii?Q?GfZavM2p1/Khn3p+7i6InQoC9ETsfhubC+ITcjxFyQrIE3sbmzn7HpyPusTN?=
 =?us-ascii?Q?JxQ3apg/MdXMMrB0s6/zxqshjTYHEFEVzkSUuCpTRtXgTMIbakGYhqCZD4rw?=
 =?us-ascii?Q?02AMW0s/PpXHQDaOkS0A27oLKKwPZZN/plbz5ZOGoCtm+ab2CT0QtN5oKgc+?=
 =?us-ascii?Q?y4HJay4wB8qvY0S92PkvE9hYH5sDuAo1t5/cQf8UcQMJ2vOl8trUrALqGY+3?=
 =?us-ascii?Q?X6t61Ft08LSIk9u5LJLu3TGcxLw/SML5iaPATg46GzqtshkI3w1DUaxcBOML?=
 =?us-ascii?Q?yOi5mttpWnfbze3/Rqk7CJ7B8HZKvgYGbh54icodkBkF9Ss54AP+J+awL1ox?=
 =?us-ascii?Q?cFFUs5pc3nuDgp3ZccYEvtRubXFhBAB+xfPd+VKo1QA5JMa4nZssT1S6YgTH?=
 =?us-ascii?Q?1OyUF9KgRNPonqMxCPuJW1bJG6osUEx5MlGaiH25Aig1Bh/TuKbu4wyJbAHg?=
 =?us-ascii?Q?6XuR46pMnm8R3v0jilNw1/jIJ7RpVZBlQ971emG1LN2OT6m6sahxqn66NAy0?=
 =?us-ascii?Q?GWky8PNjCQXW4YJsIBaYszcSenTfj67UNDhTSc6XKhbeEOsYgEg+I+wUXQoF?=
 =?us-ascii?Q?Qk40M0oTF0DTQVGo9WkYVks=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MFmmcdEkJediS/hVnSn5oxqXLO6h5in2Ogf4gCY8fPDxIoKcS3s3tROjGXu0?=
 =?us-ascii?Q?CnAXtXFUVZMt/HMFlcFdsRW7/CB8C90Sv0BtfkJ61KO14oEmxmcQTSb11WdQ?=
 =?us-ascii?Q?QnHfBE0VSl5rq29i3aFzD0++WzYIZQTjRDWGIzPhLB/9+cC5J4hcSuWmYCsR?=
 =?us-ascii?Q?e4lBIZt42ol4uxvtRSgvxAVNF4/TFtog5wbVRc+4iXKNZR951iOVhSoMRTSF?=
 =?us-ascii?Q?1B26UddYJeAZ0CHC4ZY5Cf+uT3CklAh02EEthK41dIQo5eXKN1ivTwDUIv5O?=
 =?us-ascii?Q?5TZE3DsSR1RkxchKnS9ILmFt1IwS0jnOV781JZ684lv1pSjx2E6P/nmqW79G?=
 =?us-ascii?Q?1JB6M/PeyllXh7t4qUL9Qc6FOGJch3DBlDVwVfefIQBPaA/0t5j62W92vTwm?=
 =?us-ascii?Q?X49r2igPWaCuvz/CIFkG04NGAPjTKzbSf+ZJkDBMN1QmtJoGG2t4o2FbsjV3?=
 =?us-ascii?Q?7T7hjdVsZGFl0Xf6OW4vKOjAM4+u5TfcpO5El8qG6H9b9ZWYYJ1yBYDrEKy/?=
 =?us-ascii?Q?nAgwurWPrPQcoPYXQQjQz2s8yIR0T0HgrITbJdoK5fs/N31KCXoilhoSAJ1l?=
 =?us-ascii?Q?QE2pm13oLCBtstqsf7E3zD832ofYZhL+171v2AnNxNwZNrXdTSISxs2U46qb?=
 =?us-ascii?Q?el8rE35IccqGvoufvLXcKThF07FicANl1n0I+REgiNOTRjvD16Ht/V3DBfoI?=
 =?us-ascii?Q?M9TW4It7jtIFmCsFL32AfTq+ee4hGwJVh6P9F9HRZQkqT/1BHa/gyq0NMSDN?=
 =?us-ascii?Q?L1jjt/taKL7U8av9b8o0tjUIB4sNdDxsxCELlweF0tH/p2UQYIXU07PU8jce?=
 =?us-ascii?Q?dps1vma+wOVrwmDsvQESoKNhjBUemuV1oylQyoDjPDw7pcCMreDb/VRA87EZ?=
 =?us-ascii?Q?ZE7a5fF8PJ+Vee0dXsWcR06kMjY0ngB5PBzVE/STaCKRZG7WK5aHTDFty84a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9023e185-2a74-47f5-e905-08db16792e43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:52.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mytqBNwt7GpJCUzj33GeD3c6bEYY67WDqlrGqWstTRV8b8OMOIbDlBA4jKHku7uJLafCP9ZRG0/H0xqn85FpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-GUID: JCzj_EymxxuZ5ogUCtWiap0lkoBAMcZ5
X-Proofpoint-ORIG-GUID: JCzj_EymxxuZ5ogUCtWiap0lkoBAMcZ5
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
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-mchp-eic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index c726a19837d2..5dcd94c000a2 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -276,5 +276,4 @@ IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_init)
 IRQCHIP_PLATFORM_DRIVER_END(mchp_eic)
 
 MODULE_DESCRIPTION("Microchip External Interrupt Controller");
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");
-- 
2.39.1.268.g9de2f9a303

