Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5186569AD92
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBQONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBQONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:13:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DBB6B326;
        Fri, 17 Feb 2023 06:12:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hw77020119;
        Fri, 17 Feb 2023 14:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1HFu3EFDbs4VxwsMNpGyEeIyQR4bjk7QKA8oWloRB1g=;
 b=a9OQwXUR1MqfWCkFZvO7tyPM5HA+JENgoOv/i8ScAGvRx0Pvso02wlQuj/bOdXqQqNbj
 N/pYLtELUQGx2aL2I0ebA8i7GY0M7vT0GwLS4fiSe9JihYdl0B0vQHaV3L8jfWJi7dvt
 y5oZWAnV39p9QA9c9j0R+AJj4gHLS+uWxMwLBaR+ovQqYn/p3U1NFMX/i2MRaIHSgoJm
 y7Jp8OGDCO8+t5sPrzl/zE9z1HT3NdU6XVLyCSPv0zl1lHlc2l17KGS/GVsN5Pgl070a
 akgMYPaA/sqbyV0SyEZtuqeC1EV2IhEObIBLS6tfHKDonMDa7pDX+ll9Q9cjOlDcej8A NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtny5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCjndx036124;
        Fri, 17 Feb 2023 14:11:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa6sgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9W+fvtuxSvNX/lKgC6TaHP+i/qOhqKriEYySIWrH/vcM7EiucIea/kzZbtF4GzdQmS1Dhs+dTc9/tKkBEJTdHMxhqBdFQUq03d0jp+fz4h3uf5X9/HX8i9/3d8L2xqc26BMmQjJ7Zody/3Ucsq1ZXczhC/+vkLkI9guN2d86ia3T902JFWp/oOma/hJwMPdpREVyn2M8iecRWzRFpQYR2yxIrzfT82W6KoIPJiyu4pDtSV4VAVfbCkegDj27raH2Jph4gBkArDTIMwWhZPlCgUCzyupz0fim0VxNlURi3Y4sflgqwrATb3+SO4ayr8udt8hNq6lCxIX0XCBdybJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HFu3EFDbs4VxwsMNpGyEeIyQR4bjk7QKA8oWloRB1g=;
 b=YGIZfVM7np16tANuUUkjPx3LwnbLVpufrsPqRe9yDMgFFmxSmxEdus8Un9i+GYIU5KhzLTjfsik8ZOwUF8zxeySq4xBRY08iUvEHl8jymPPTfcIQm4vmqvqfEQ09DdPHPA2RAJWgtMHOmpY+S1MG4oHgnrbvz1T5Oshl8plenI9PeGWjr84vRqT434okPKf4BjGb2e/zPUKSfFcDR3cCp0E9hGo59Dj4vDJRIY/kH8Zo0UYZuCOCZTgKSDexXHK9dK+J5V/XVGOqfAc4mi3tEp8LAqkrewA1asnLJ1IT/ouf6LTVj39PjcHRWyEdZwq4ri6wHR+JX8yUpBtfceizmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HFu3EFDbs4VxwsMNpGyEeIyQR4bjk7QKA8oWloRB1g=;
 b=zwplAOFEAn8PRukz/7nrl8HheOEHW59FM9eNEXKgHx9gjY+l9JHghh8sgles3IQCnbYSab9PIENLw9Hr6AzaEBFEJOIBRPlDBzED5TzzhhnX7L4Edq+Eja/LbXAkl4+AYWovCStzbCN00Pg41ic8UQadiURW2ISg3XgGa4XhrqA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:11:48 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:48 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/24] kbuild, drivers/perf: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:43 +0000
Message-Id: <20230217141059.392471-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: a67b0f1f-1610-43a0-7f68-08db10f0e83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSRlwjf28SIb/yBP0NtTpEMuOIBFrFIukl9Jj3siL9u6qyY3AK+EIPBF7+rxTKntlansX018bbg14PsKGN5PqRRmWTRdTtzanOR+Z7e3VUVyeI1Mu0iWo2gkJsQAzbXrQqHu1ONT//oz8fg1uoi0yBFYuW2qcsnHlQxS35JPm5b80iwcxQr/nhApkl5FQZNy+ylwMu7UlSnAw7CA86O5r7ucBKV8hVhzKqzNSZSr9dVij4RCd1TyN4bCJaWQzFl6/tfEWT4Kzd7ionVFyBRSLqKKDTlkv+fCm0psEU4KQNHsoG+VfVSyQfMeyZuG3e+r8L7M6YqfQvcAI2LW/S7Ulq1V7T2IQnSQCu670QxtETwbEGWVsUdy8ffkXylNpcAVTRUxl3cAlzcBo8tIDRXK7g9PddPab7bDrW2byf8BxDlWZFwEzzoMZ7pbyRIRGw+rYIfaTh2n62ztxrqS2/0Xw3Sp7QWVZgXjFGI+zV3ZlZe7Ye7XeT+iYKxzkWOhHpv5EzM+8QWR6Ev31hlf4tcPK8i/z0dfzagW/S6Lwc0ohKkHmu6TbxbKSgA3GqbM6eJ1bKauiVt0MQ8EO5UE0bPzSWdp8THRgirEjCJGWbwGGAHt5+r1FdAAClj7vpuoFfod7vEDzZq5bMdC6D9o4IwMNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mt1vA0vWSVA3AkNU3YKeGUpaXNJw4c/zWsb3kwQ8pnUiB1uWH78YquGhVDnf?=
 =?us-ascii?Q?Mv95TtnuknZDS/9TyiNJHfFZpAus7danwIZvoQbrmvJk28KS/a/OW7/tjy9P?=
 =?us-ascii?Q?23HaNSiwX6bZE3TeRHB8Cp3gwSf1l+wzUTr+0BzVFMdFR0IofzkckOZamxl3?=
 =?us-ascii?Q?v4aC5cR6OHoSSegBrsdj2JoMgXCp19z6mAEhhaRa23jpZaJzPZmSFSXU8zpi?=
 =?us-ascii?Q?2lRTPiMps6r83kyH/8+65oOHbJsZexo3awVY8SQYGORSX0m8yZCw6SnEzOxG?=
 =?us-ascii?Q?tGLXyQwmUuP2b5pJA0hoYEgTZNvNNLx6lyu+dUSsG2hfy+4bbfjdXZjeAG4p?=
 =?us-ascii?Q?hiqWkP4N35KRc/cXcTKU+cpCGdwfbm+Ae5XvkRQfhBJnzTdB+94WaSuk0Wfy?=
 =?us-ascii?Q?vr2q3tASL6aeRcQkhRBihioZNP6HIobxKqI3d7l5hyrNoh//2HWpnyeflW4y?=
 =?us-ascii?Q?2cd12qKcEvmCqBY/xH6+hDMW4n+l8qkGWffdpRSNywqRRodPabneu35v00mI?=
 =?us-ascii?Q?HMSKhgc77rQktUtqDNZD39uWm6NhFmUu/2qZhbFjQ+8TbqrrWEHhRBPDtn67?=
 =?us-ascii?Q?0YcestR3AF+zn7Yqa4tBq9K15Qr2j3W8O070CTpPufLsWyPFzci0iL1dBTQl?=
 =?us-ascii?Q?TigjK0rnU29QwzOosfS/2gACXpK5wvdQY/I0Qg+PgCr7HmPNVGkDtortkJl7?=
 =?us-ascii?Q?kFp0f+HOUJ5ShAN5m2kjMxq7lykBk8ePmfUNbNUlj90fxx0kZ9I8HjqK0HH5?=
 =?us-ascii?Q?Pqfd9HKHvnUktqfVoCk+GYZvhz74BDmaTUMLofc9QXWjONnck0yW0QoGCMOT?=
 =?us-ascii?Q?+cJDcCkcW0YwkuoR1464k86WfEtRaYIcekzbmE9ie1TBbp+hfcs5adwHlkml?=
 =?us-ascii?Q?6Wi/JCwn977ZSXWNgC9fk11x/DySADlSK9+TbLQk/AsVbZlhFkIe0NR3ildE?=
 =?us-ascii?Q?wA4mpEWOZRLHZK8ntbiIHnpvcy7LlWQLnVxuH3goVz5eF4xOzkANuoZAS+/C?=
 =?us-ascii?Q?lJqABmskrtLrwefvfl02MCqOMDEpCDcOrk+G/ki6HxuE/C2FdUdTIbnkCk7a?=
 =?us-ascii?Q?5kFAM/8HsesNJQ22tl3qOXvtvxaHdc9TyKWsGYH5diGdW3G9ylNuT/USF8Ws?=
 =?us-ascii?Q?d5K+pzrSJ8RDsiSGxOgs0ArrY26yqQ/zVFZdIbN4fQECoLBMdmBPDyhIc/XX?=
 =?us-ascii?Q?ifS/QfpisHayq3dN4ZKUBswRGiNSU5otJE9pfUTq+HmnBpRtprM3jtZP71VU?=
 =?us-ascii?Q?tjME5pqkZ/aOXLKN/5sfj541708HD1obASaH1lrX8LBAmB8apyk1dDk/irYM?=
 =?us-ascii?Q?s3Lk9wdf7mr/up3etkcNwfxnQe/3TUsMSdECRQcgVmBItqCWAiPRGGyMLIGs?=
 =?us-ascii?Q?AFH2OzdL3WPm9TgFjU2DjMFBmCFfW4nAjCFza7RdKQzvTt5SL75WT5AiC2bF?=
 =?us-ascii?Q?rSFCDLOELjaJmEQUjzqsL3Vsba/CRuFNB6wenmeYuKEaqjaUvoV/K8X/HvZz?=
 =?us-ascii?Q?L1B1QysG21xh4J0ZBDwbAjl/BL+HrcCEERLl22V6KREtsAqacuNFZGiUmQZ2?=
 =?us-ascii?Q?OUYQaSszptWi6fqN0RVF/vbbsChX4Jpqz9duZMBhuzqYc3rmbqm+eFbmNZeY?=
 =?us-ascii?Q?RKDM/w1KhnRyl/0cEEu0KcQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vr3SgZbLatXBxqC7viL7S7cWnznUA7Oxx+KaIW1cy0KLGw7rxsZeoKmrKSQt2njdPSoBNmBaaxx7gGUKzExccVwP9hwAGCSt8VbQQ0xTMl+V76CBryTRg9cWoGbYCH6FaVUDo/ngqmbLjd0yMx/6thVHZ51mPJnJi94Fd/KtU474MtfPrAmcFTEzd3zf/CocyhMSjPN7v9GkSzkOZqg+xhewRJoYHiLqKCeB0ILLPjR72KN5pRd6c3FjBTMC+XgWvFSUUu4XRlw6EUfc2rAWmrS1+ecn+t4tqpnF1vhKNooKTAwR8iluQDKNOF1c8k8EKLjMfcRixZKObUONCvyQ4odTPYLs6omqXmsExbNnslUEN0Kq5TZ1iTJE5GYVYy3ybhs3qrp07DKPjzQ0Vz4EOflNO4HIseov5I176p/2uJqq8IQbxlrNcbahmPP2VBD+kjQkOe1PXUnNly60v0oh31FDYYsjsiAOH8+zlFs5AyKd3c29xbIl2x7dnj9iFoULTuQgES7g/Zw0jPJIZ44Wnp7UHKBOtGPQjKUGzqAKOmrJGhq71W1qiJD5AMiB1hfEVHXi9Q7OBGGcFJ6I9GMK4DlzNXY5IHrn2Tp+8DNrj8UFjXzF/CC9ZnunZN8vYJBLmtKOoY36lXaYKLBkpoJRAvxP2uXAHGP9zxydV2aVuYswSVQIT42yp0rtVeRUev2eC5VwAOmR4L6wCkkWAjA5O+aLwiTtXaOvCVghe3Tfl1bhb4jbRsoS+QTJGpXaSDUK/L5mhV7U3hw0tQCB6jU2nJdn3tQrjWz+oeLqmkRLMD8nEA7N3QCfB8PpsL5x+XxwLQGQptjfDwErzCEq+ZcL+Ypliv8/ihb5vmT26OugyaBvzZR8g98dR+oaBli6v+82Udgwgcd8NJzY2J5wZZIZBA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b0f1f-1610-43a0-7f68-08db10f0e83b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:47.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8H/RQN5VIZaw5Js1PpWN1EiS4dMMIKUHIhII3mchV3WfvQso/WrnMS0F0AC31prp0LY7DeZo2x6yE1js4wtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: QhhZL01W0C6eopNbvZ74AhDn58oCIeNw
X-Proofpoint-ORIG-GUID: QhhZL01W0C6eopNbvZ74AhDn58oCIeNw
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
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/perf/apple_m1_cpu_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 979a7c2b4f56..7123beeb992f 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -581,4 +581,3 @@ static struct platform_driver m1_pmu_driver = {
 };
 
 module_platform_driver(m1_pmu_driver);
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

