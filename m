Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F846A59AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjB1NCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjB1NCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:02:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7BE30287;
        Tue, 28 Feb 2023 05:02:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5topL027510;
        Tue, 28 Feb 2023 13:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Kp1ECelG6OJENwDHiUOpQYLyRIhQa3K95aRaGLUOL9c=;
 b=FOPK7aX02tfB3on0r2slGKK/2TMu4flNdExY0Z//BJcOL38ByzL2A8nEVM5BAq39OTh/
 U8TkN5OoawBY5OsH9d8WAoo7OjE76iqDGV34aeXOO9Kbykeu87USbJBVD40m2rLhiPF5
 F+0d8rC4Omh152zeLSGn1EnaUxZQt6neDFJ7QL2fJD0qrBluOnSPEFHVEV9YtCyM2uAH
 jKS4aZZ/VY74z2taUos8up3JrSCen+UX4uuMvue1+kX2dJC9+F+aEDYIwAZJEnm0dNe5
 IGxGLAnRbOi/OQwuyeg1tO/rPFlvintrkCRdKRWdPmL0X9NAToJOWWaOmCEGptM10n5Y lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ae35q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBOUsk031538;
        Tue, 28 Feb 2023 13:02:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sdh6j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLUqqUvEpK18WO10DZbOrWdbMwDsUXdHKWslMnGcudFr0OxQLv+X7Z/RWDufjGzP5+H5L5qMJJb2PhXwWRyGM09NNRQXLUR2wUZUDeFnfr80AY3cHuCy4zRI/WdtlmFioBd1Cv8WD9MBgICOKBGKiHgMH0gnGhWl96zOpZpNHfzwkOrDYhEB3cJU10eWJGdjh1AvFKc4cqeHtRBL7K003oqkPAX/1ccHF8ry3jpGNa47J0/1YQ14TB0BEDDxjvA5O+j6lLVRO/sDPQEWtEEFgN4a+uUy+zj+h46Xd200oUyxGn63YaBemDAADwJOFiTOXJJA1+rVY3aRxoDUbnyngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp1ECelG6OJENwDHiUOpQYLyRIhQa3K95aRaGLUOL9c=;
 b=a5FDSgWy4/sJKIPmcb0B1ghkhw4qzSMLT8bfN6U+BfvfHIsF0MV4axjKmmpfSNNYsnRd4dxHC6q6FKMP1j9qtPG4PMosTBULPsfMA8A0ohWo7XRaoyiNz7WW8iqtU/K6v6IyORbk2SFgLWmZK3kZZEeeBQJAtLmvHZN+eMiS6a5OZ7podE0EL3mn/IJh8is/a73Vlepvn4Az3WQXQOFLNvtlfMH8ZNQymqi6lPYI33lE8K3vwg8w8appv3mAg3c/uUIvBTCfg7yMYhmEww1SLIWJfPKN2bhsihLtTdjTjYxr7/rznd5HIqpLtGdc6iuUFeOliBXulI5x3RG3BgZ/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp1ECelG6OJENwDHiUOpQYLyRIhQa3K95aRaGLUOL9c=;
 b=q0S3ouytcZhCJO0aWQW7fbWCo6k958/6uXfyzRv+FoA9sKpDqHdV7v3Z+luxKsAIcQpJVK120rr94qneHcGws82P95rYvcP0403v7icbSQnN86iC7EcC9apiZbFvrirY/mEVojaElW6MPc3AI5NlVKb2VDvRGSN12XpWsPRZ4rg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:24 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 00/20] MODULE_LICENSE removals, fifth tranche
Date:   Tue, 28 Feb 2023 13:01:55 +0000
Message-Id: <20230228130215.289081-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::28) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e29157-3c6c-4b2b-d3b3-08db198c0932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/tra7qIBfDQLQ/Wd9Hqe90NgQTbTKLi2pLeOwPycEUwzrI7a6zi5hLAOOZ2zPlnGZYR0kM/P0lvP2cOgj2epV90Zfib6TYc3r/xYdiO0sGEDxP8Qmu0mAMYB15c/H8a9t594HeblQ+qP3FaWpPeF2P4WLzclcHYzgfy2SGDtZ9HguS8DxIdddHadpawFWsr1LvVzBnepfp8Imt9J8ZNADShIpeOAVYL53d1duBPmsDlgSEyxIXPxrKiCiaC5IHGIc7kzVHQO3vHIB1eGK6xM7KAeaDhLEhq0sAic6hvTNqja//jFrCUCobGLSTe//fFBFAzvNXqgo87McyVhprkMVd/GRQLgA33Z6QYaAxd5QlxLYLqybsWowuunykIXfF99b3n2ZZuNUBuAN91e27VQ3NzQvAScKo3ZHgJD14VrINtIOmcdhHgh3PA9beD3DlXLRm+fc6W6FpH2cN1mdRX+LjKbELCk87Vb+PXcd6hualBttGHBa2kuwII0zchJLZH7lkREySImuteOxJJitt9B8LlKSpOSsj60T1cH2rKOPnVetbw0E9v5oWNHV/L9Je0XHKHDTk01/m2HruvqWTKE9FatpnsH75p8IAR04aKhGfX4vrzJgNSeeHWejKFfebn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(7416002)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(966005)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?emTKdlA5MaGNgNUhY7ZvnUad6pBw0fhB1EGJ9enLrcLDSK1+cSglKONroPjj?=
 =?us-ascii?Q?RSZ377aF502faCE4nnpzm5NcbVGayJyH0GSr/ebunOXCopRlbeOpxnOAwFy7?=
 =?us-ascii?Q?BtR6+Q0+tbmlbC5NjTYXpVQoJT4s8Q/KDD+74ltMOZR5RgK/nDiia0wByTAh?=
 =?us-ascii?Q?bD2gNkKXzVb8EPc5l7vIeavsnuE7YNmvdpLnUhG6qZPoc8YeeElsC/tqsn8D?=
 =?us-ascii?Q?8PfUS9pHcsI1xOs/0sJDwTOE6RZi28ZSoc2cY08DR99LP0PAba2dAkbBMfYc?=
 =?us-ascii?Q?fRJToDSWS1kHvBu46h+nhqAN2S1T8qHZmjOQo6L7Ulcs7eHtLFH3WdXSts1H?=
 =?us-ascii?Q?XEhb1hbWLmoZmiURWgslFdN1RFZfq9dG03pfs+wfaaNKBGZnhOkehrZZsGbu?=
 =?us-ascii?Q?fTesjK1qwRqZ+SD5tABrCJ8im4EbDbmb/7JN7DpwucAO5X8lQY6oM2TPCZmg?=
 =?us-ascii?Q?xnCGiv7wj//gDQ4QazOPQytWCBSdT2vjnwAS7y7eRSJ8CrfM/qkLakeqYe1/?=
 =?us-ascii?Q?jQ8Uh6lKWZQjNqz/1+k3ZXnMvA7kYlsiRRPYbKzSVQdlkNoGyrpQA1qTt1i5?=
 =?us-ascii?Q?dWhPuxrwFiFPmQyPVUyMcYrZq725UbB/iGsQlMvVtYKeZe+49J2XnSE52Iep?=
 =?us-ascii?Q?/3O0TCFKRgOYzAj/jIN0Q5pn3vMHJKG0jOTP8BCYYzoXwxKmSIGKndMXaspj?=
 =?us-ascii?Q?W0PDx2v1IxxNIoSH5DuqDCaw+TFjwvAIUlS1y9xYjJ1MjK/f6ft81hBhj18U?=
 =?us-ascii?Q?aLgc3O3yGryAtaO2JCHPxySIJk0wS9VHCNpF4PvVeEA5NxOo/efp77ZQTYZn?=
 =?us-ascii?Q?2DFOv5vNI8sHCMP+6oQ1CH8mhkgCDhXcAQfVrPAtOk/0LNGoyGhBkAVsowpM?=
 =?us-ascii?Q?sSX6/b6fp3wiKAFt1s+WeGE/NI/vskhkSaHdkUsw0OdSpvL1SgFdYJDzD63s?=
 =?us-ascii?Q?V6Klxrftny0ws2TcrczsmS5ZEK4tMu0Y+lHBvA1uRxA3BscF24/SAumfjoS8?=
 =?us-ascii?Q?g25+iKlKzxHdcoxFHmslOvFtTmgNMfllzymTTGBn0FKbVA56+pyWtKmeJR8y?=
 =?us-ascii?Q?RY5oy7oJHmulS+TbB5UECZAeS8Onjn+vMFbUQZlrkkfFa+LVTlUHOjZpTbcO?=
 =?us-ascii?Q?hYwibYwLPPR+6fPFlrefbw6wZNX4Sq6pRAgm6LVTBBlUjUeNx5X66LGEtqpB?=
 =?us-ascii?Q?R9Gnnd7xEMDAl8Y/ZSxuKmsw1Z1bWAPt69dniAFLm4R94VnG5BMg0t9xr5Vn?=
 =?us-ascii?Q?aYHhbaWymFyWmyQfLtDcDyatHOJtG60QnfLyb/j63Wreod/J8p6znBmjiwkK?=
 =?us-ascii?Q?/zs9vhErgDyhVayW/T6tOcrUT07ahmHfTh+GSbINZ3FTXN3a668px6R9y0wO?=
 =?us-ascii?Q?F/4KzsmwENdBXOjosWDRPk8/21czB2DODtM6Ns0izL/2BdgcpsxUiX4JGA+S?=
 =?us-ascii?Q?wkNh5ttvO0CtzovNm8OxohJNoxBEIoyXvcmEtbEAX/xsBfdpKlgXw6HLjSZZ?=
 =?us-ascii?Q?O2LTY/kCBeUvmTgGAlxFYX2b7kdwYuTGPYWfU2tCgPthhsdhf/GR12dw74dk?=
 =?us-ascii?Q?NybFP+JoDQGbxstQL+zWQ87V7iJAWt941bRgsoGCPMVJGYOtV5fQzDwRFrpg?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JzjOShtMGLUNzTep2nIBSFOvdFeWJA3SkP9N4nXcg9X9W/8oj2gHk9SzrRwPYqDwEqYEjIELAAE0YX+3UI+NJt2NfTWovX4sQND3ATvo4vM60wXQwIKtGwBIfZbsIB+lSe/6/YmIq8SjXpB3CU93Rh8vgCCToMHPBhzkUrkMdegOMoJDjaqDffs9AWMuLX5jMzpowtjdqgyO9h8rB+Z+P138ej/tEOACRyedATHmHh2Z00S8+ecQ6RXxFJK6pELLT9L0htlCQSYyp80yIS9A57X78azMME6sHHTZGmeCxt55byjYxtdGHPsTHVjrm3eZXMMyMuuuLfwrcCocu7DCB2eRsTBJAzrH6tm2XDRM65o7BbXaoqMOHI6SV2H0NJhBwYA+K8mIq2EiliL5vOWbZrHo1nPK5tOtS3bqADjVvK/u2Oubs9+Ac+CdAGvUfjQt1qBlY3vOEnHsBlEBYcwibIEJMS+OHVZJbpuWBELB7iUE1/JBIweYY8FYP0nqgdP/NO0hw76i37+snrH32ATTbNfE/gf2XojXzzeAdqHizz/IK+i18zAw2UDqarStWF7RrRqq8wwMWflgKYAA7JEmaJxKZcvJvHIROE6dpOBwtknSaw+OIHp4OsU0b5Z5APvOVw1WQ61s6D4hFr+KqA1fR6wiyMK0w/4EG+fmsEKSaeKujUUMfs2w4OGFIa/SFFD4x8MTId/KdA6y2Q0OnT6ggKbX8yR7sUkqrD6sbNMccU9IqNA8I4qZKvXvJtsLQ+FAOtL5wesKuyo52JgV222Jf/fB5JhjbTwWDJdHvVLZyFNKJ+AX1E1i8FDj6u2uqIxrpBW52BP5UiG/ofkK55fABgf/Gdz6eVOA2IxWVbhrT7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e29157-3c6c-4b2b-d3b3-08db198c0932
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:24.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBO8U2ki+Vlaw6zq4680IUYpN4TXcnMplZ801Um1cikaxIWFLZBl8TQpoe99+SaEFvI90fltk6PTuTk3BtJYoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-GUID: yS0PWM9CSruv-mml4anN20JmkUT8CdGc
X-Proofpoint-ORIG-GUID: yS0PWM9CSruv-mml4anN20JmkUT8CdGc
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series, based on current modules-next, is part of a treewide cleanup
suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
files/objects that are not tristate.  Due to recent changes to kbuild, these
uses are now problematic.  See the commit logs for more details.

(The commit log prefixes and Cc lists are automatically determined.  I've
eyeballed them, and they seem reasonable: my apologies if they are not.)

I'll be sending a sixth and final tranche in a few days. (In total, there are 121
patches in this series.)


The series at a whole can be found here:
  https://github.com/nickalcock/linux module-license

(This is a respin with kbuild: prefixes dropped.  The previous series,
used in the mailouts of tranche 3 and earlier, is in the
module-license-kbuild-prefix branch.)

Cc: linux-clk@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-gpio@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org

Nick Alcock (20):
  perf/hw_breakpoint: remove MODULE_LICENSE in non-modules
  pinctrl: amd: remove MODULE_LICENSE in non-modules
  pinctrl: mediatek: remove MODULE_LICENSE in non-modules
  pinctrl: renesas: remove MODULE_LICENSE in non-modules
  lib: remove MODULE_LICENSE in non-modules
  powercap: remove MODULE_LICENSE in non-modules
  power: supply: remove MODULE_LICENSE in non-modules
  remoteproc: remove MODULE_LICENSE in non-modules
  clk: renesas: remove MODULE_LICENSE in non-modules
  reset: mchp: sparx5: remove MODULE_LICENSE in non-modules
  reset: lantiq: remove MODULE_LICENSE in non-modules
  clk: microchip: mpfs: remove MODULE_LICENSE in non-modules
  reset: remove MODULE_LICENSE in non-modules
  rv/reactor: remove MODULE_LICENSE in non-modules
  tty: serial: imx: remove MODULE_LICENSE in non-modules
  irqchip/irq-sl28cpld: remove MODULE_LICENSE in non-modules
  ARC: reset: remove MODULE_LICENSE in non-modules
  ARC: reset: remove MODULE_LICENSE in non-modules
  power: reset: remove MODULE_LICENSE in non-modules
  soc/tegra: cbb: remove MODULE_LICENSE in non-modules

 drivers/clk/microchip/clk-mpfs.c          | 1 -
 drivers/clk/renesas/rcar-usb2-clock-sel.c | 1 -
 drivers/clk/renesas/renesas-cpg-mssr.c    | 1 -
 drivers/clk/renesas/rzg2l-cpg.c           | 1 -
 drivers/irqchip/irq-sl28cpld.c            | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8188.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 1 -
 drivers/pinctrl/pinctrl-amd.c             | 1 -
 drivers/pinctrl/renesas/pinctrl-rza1.c    | 1 -
 drivers/pinctrl/renesas/pinctrl-rza2.c    | 1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c   | 1 -
 drivers/pinctrl/renesas/pinctrl-rzn1.c    | 1 -
 drivers/pinctrl/renesas/pinctrl-rzv2m.c   | 1 -
 drivers/power/reset/as3722-poweroff.c     | 1 -
 drivers/power/reset/gpio-poweroff.c       | 1 -
 drivers/power/reset/gpio-restart.c        | 1 -
 drivers/power/reset/ltc2952-poweroff.c    | 1 -
 drivers/power/reset/regulator-poweroff.c  | 1 -
 drivers/power/reset/restart-poweroff.c    | 1 -
 drivers/power/reset/tps65086-restart.c    | 1 -
 drivers/power/supply/power_supply_core.c  | 1 -
 drivers/power/supply/wm97xx_battery.c     | 1 -
 drivers/powercap/powercap_sys.c           | 1 -
 drivers/remoteproc/remoteproc_core.c      | 1 -
 drivers/reset/reset-axs10x.c              | 1 -
 drivers/reset/reset-hsdk.c                | 1 -
 drivers/reset/reset-lantiq.c              | 1 -
 drivers/reset/reset-microchip-sparx5.c    | 1 -
 drivers/reset/reset-mpfs.c                | 1 -
 drivers/soc/tegra/cbb/tegra194-cbb.c      | 1 -
 drivers/soc/tegra/cbb/tegra234-cbb.c      | 1 -
 drivers/tty/serial/imx_earlycon.c         | 1 -
 kernel/events/hw_breakpoint_test.c        | 1 -
 kernel/trace/rv/reactor_panic.c           | 1 -
 kernel/trace/rv/reactor_printk.c          | 1 -
 lib/pldmfw/pldmfw.c                       | 1 -
 37 files changed, 37 deletions(-)

-- 
2.39.1.268.g9de2f9a303

