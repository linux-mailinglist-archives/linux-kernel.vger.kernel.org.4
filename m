Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B014069AFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBQPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjBQPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:53:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B25B6BDF6;
        Fri, 17 Feb 2023 07:53:27 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hoOm027251;
        Fri, 17 Feb 2023 14:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=WBbLxvlPZ8varfSZqPo6vH4+OXGJJaY2zDoJ5V8p/mE=;
 b=TcwEKc4/+PWPGdmXYXFxi2E5GX0g2G5fXY1ZYtBbtWbLlsyw6/rsxDSiYQ1/G67IiMJ2
 PYYwTUfHtXfnVDTYei6c+tTozAfjYTdEHiR+z4mzR6+/jclaEHesNPidnC3Xghfd2Bi2
 LYdGnQQcdFiYQrNKi5d7Kt3D3G4darK8uzJIRTEtTO43kiqkHm5xTPPH0tfsie2g5OGB
 PzE11IV4RYpntUGhVIfxMstxGjwoSkRo9rf3Yq3OKDMqWe/9xRqQaImUFWRcYUHGe69n
 1AZt/kS0fegCthO2cNt1HDVyEXsd4DjGMvDLQnNisOm3vHBK25w3rJh4BR2C4ORJZW39 BA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cp0d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCkPaI012112;
        Fri, 17 Feb 2023 14:12:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa503m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGc7Z6+cH5SC09/FVxS8QUTb1NYfoUrwGB8ctDi35z8avheKkzoZQOEN6tbfMX7CYQ7lkC9NykbsJ5IIZfv00PazgKtE9xi+bEGmkA5xoGSYcQfoZuV0hF4HZa280/lo93zuPELrHspMtJFawxjo7L8NwoOv37XT/Zyg6jkR6xILefI5LWe+gQ5WFMuODNCPkNuSnQlrYPzOMAQz++nchDZOj+umY5pSFXELvR10I1W05n4xHevWJCdU0AMAb6suUF4T8T/DnGeFfjP5Gf4ntdD27P31dvBepSfsbwJDVNA10Xmnl1cKtVyCG6Lo9faEIEik10k6wlzRCQbbQwUjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBbLxvlPZ8varfSZqPo6vH4+OXGJJaY2zDoJ5V8p/mE=;
 b=MagUH8q285cwX02CiBUaQj/2pLuQO1NO1LEL9Bp1DFUwxn7WIPEkgo30J7VZK/j8vx6coThJKKoDPqeHVdyaQQjZys60wTQ00cnG23NkvMr8gNwEn2lDZG7rIhBukPG7hKEHzDfjnIVpbHwMf7tuH2ONB67R4dj2+9RMX98rCgzAeM6nFTO9m/fZlBh3/hD5s0Xb/4SmR9aGAWgS8Kr6oUDKtiRZblp58Jtr1lZssvdOjXsMbZClDhrSXJ85HQKgT7LgubtwtxDIirIZmFhShVXGnbOUstGT8gadTIgIazYSYL54VvNDK6eJZbLlclOBoVp4pkoL2srKIuWHQWD9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBbLxvlPZ8varfSZqPo6vH4+OXGJJaY2zDoJ5V8p/mE=;
 b=bmAdfN/Cm8AgUvGb+UASpJZvs8NNLvor5udxV3c2AQS+XoxtXo1CtCAaGA0bS87Ry6TU22viaOcuhFaSzP2N2moKq+tVuAHNAXKLFJ82XRjOrfhHQqLNxDutRZT2AVAqjIBpxeQDeehj/Fp8nD/dsQ5LXBQu9hb9yfr3pa5+imM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:20 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:20 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/24] kbuild, bus: ixp4xx: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:50 +0000
Message-Id: <20230217141059.392471-16-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0464.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 362043c8-81a1-4e5f-d9f6-08db10f0fbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFXSqZ6L6uXCoz7197U2h2yMsTj93rcWJUNLAHQ3eMzGiliH3AzzAVUbMlav1Eh53+lZwC8OBbcn0weL2UnqlLzH6nIcdvkB4g//I1Two/eVPMSwTlRTfh/tC+t/ce6338tzcZKdFOpT/SgysyFSx4wvaDC9tXXJkgiwK+xdKiS9HE+mxynhXrXnvjYEmlLVgMDRavMJZWLeeBhp4opuNEM558JIBxmAgSS7qyY+BfTPY9m8hHa6x5+DGRiN/ytodF9oU5fdkfqjM8jE9ejN8sCvxH3LQ50Kzl+fHjpQrCJ6Z/6gKJlOnxghGbLmgILgmKkAciq2dvpYHP+XJoO2lcK8HkIB2Y+pF6baBV5/tSXmSw47Sv3egAk5c/JpGT6xBM3fPEf59FQtg0gEmpbd5ierQdQQnQElF+e72+CaDHtMYnW2Re9wLZcqX7eH1v5UXMFTZf0Ks7pl2Np9HIPswBA3M6VlNVY1dUOvbMBEUDuClTi3nXX/FJiHxrkdgFsN1uwLhHJCCi70JueIMHUeGydF+xYRb+6SR1hwTSQDe3nrNSwE+zQr0mMFBRzJg38WjYHegEKLIaFPKpSh/OdiWEygz0nRrLRov9PRul1+QX3jIq5uL4ERxYO/u4P0ikeJ8ION1+y8/KvYXtUgcrvGCddQOH4ShQrl9k+7QpA8IIcwgTlgIzsnf7uumNj0AjWJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KmpXaAIAhcL1fh4ZlB55KIZR8lv8YS9KHI9sWCrTQE4uepAJgZt5PcnWhzb?=
 =?us-ascii?Q?PBffDPhpkkWh07SpArTwl2iFuh2Opgd5FLUOzmZFWMQFxmCtyVCYVF3W5nvG?=
 =?us-ascii?Q?s62z5BfYJ1uX6khJVfMjQP2uzp3nhqDQU53vJ8Xi/IJc1cpYRNOF0EF6A8lC?=
 =?us-ascii?Q?YnO9APZK4CFWvUS4Shnse6/EaNjszQ8z39qAUvDNdD+zAEWbBRNtZKzL0h3w?=
 =?us-ascii?Q?XdEdw1MBvQTNr5o7MeDxSW9HI+uKeB4B8VCCQAGLlo9WnPPGYmXhAxFZUAKY?=
 =?us-ascii?Q?KFBQ7voFGF5fL2BzpaSRS5BIh+W7HqGkTmTH7Id0e8OHMXPZ/ObeWbAsxYT0?=
 =?us-ascii?Q?2k5tALm7cNzGIaMiIh+J1Giju9uRFf1nLEem9Vpep07f+SwJxnGYZyYYFJ0l?=
 =?us-ascii?Q?pm8MJJAnbXufiDpxmT2hksugRVZVbamMiZ0dU8AjglyeopmftPPl4XV51gTl?=
 =?us-ascii?Q?EVUQdtJKfG4doMb2EcrxplbrMy/T1rCVTMapv2KLFz8+v3CIct5s9C86nrOQ?=
 =?us-ascii?Q?Y5TrszX/AQ5jBbvxjfvTTXqSo6Aw17ar9aRXiinIGj8ArrWBZvvRbBQepZjR?=
 =?us-ascii?Q?9fphu06eAN+YagBRZOWf3j0rxNdAh2ObZldbJAdzHH8HQugKqhdyE/npKEDU?=
 =?us-ascii?Q?ceQqFYWRDFh48gsdc1ynOJGnIMxUPFecEGA2f+cWSzydQlpLRyu90Z/oYAna?=
 =?us-ascii?Q?E5BCAuQBmc5utYc/uRvd/jqy/oMIhPve651qmE9I3max12+lxvI+5Znm/Psb?=
 =?us-ascii?Q?TJ2ZefJq/qGqdUzs94XQtCFxvtm1Sb1xTOLSjKIUQS6ak++bao5SLz8Csvnz?=
 =?us-ascii?Q?CRCwPiyQMI52mnBJC3IRdiQCJqc1lqsdMNoqQgmbVGys5EohgniSMEXjfOCh?=
 =?us-ascii?Q?/CIMFt9VPfGxa38Z0r9n7jQle0659yeErZAYknQ74rrF73JOH1aCNbc5koIG?=
 =?us-ascii?Q?lRX7VrazdntJqf+3l94OzVwfyiXzaoBTnQH4Kj2CpZtsDHjs3jANnzB8kczE?=
 =?us-ascii?Q?dpRlGw0quLmavjBLRBsg07e5xNG1zoH3slE6KC02djTd+q7h7i7SzC20Lqj2?=
 =?us-ascii?Q?z8BDCu5fkfEjUDuirSpn1wscZ6FTTI4LelXdVv6C7mq2M08ChbNaIuVSiCfx?=
 =?us-ascii?Q?yT0BJ8VA8GYTZeCKNhs+nu9NuvWp1OMdpM0Q5LAaZoh3IZDkJI9+3V5FFbyp?=
 =?us-ascii?Q?vZrVsciH1p6jcgijqNcaGSRohcsn7qq02s0YB1UaGeUga9S4IESLVAixU2cx?=
 =?us-ascii?Q?Tq5QiGEn1/3Ol8cGPRYhjSjqFo04EgXoMSt3Qw577YWsI18XjpMW8Hy9BbDL?=
 =?us-ascii?Q?WU8KI//2SkrE+gEl7pBKYapGw9wD/4MMt5lB3ZsmuAnJLI1E3dYjY3CTvAzE?=
 =?us-ascii?Q?X4l1247N/R3App+SZJ5CYE1J+SsOZPCtRHlVVYUAcwTx7sYI/L6oM9RQIQq9?=
 =?us-ascii?Q?WbTAatAhWWyF38grgDXY2yUIEAlHAFVvyr//55c2XBr32wX5bLLy7q2AigMY?=
 =?us-ascii?Q?4ondCNw1NO5QkL34Ys/TrXMy83Whtpk2LATX2+mw5uBvljUw8vGCPTO4eJVU?=
 =?us-ascii?Q?CALwqc8AqPUaBEUSfC3zZhprXfn/IVm8IcxKvSOiQO4W8JmV2ArdT3cHRjOl?=
 =?us-ascii?Q?ADR5hOE5Su47jQkdzFw3SAU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aSA9j/iGDNzHwlt9H5UHP+YrECLHTC/huSMKP8uDfL7AVXvl4AlZmbDHCKqf44Ac+4FdJkO/ay3rXzHsModaP4FHl61g8Rax2pgZ+cIeKNInB0sIOzD//FDX3oJnP+ydrxUIOXJdCxV0OehTmg+livMPOwfD5n3TkmnJlJSYHhXEgTZbrVvExdVmr2D46qbSe7vF67wp2MLvDJJ/oI6v6UVYc22QL10uRCY408QbFMVCbqFnF45uHG1u3jGBoTYJInY+e2c/f+5hGlRBJVPOkwm1RUfO/gdhD6Pj6gzRqxI2q8AMkiTe0KIL47mhbt8c9fl1OSRRUGjVgPx9U52Zb3AdDJqoRdFVU/R0pS8WOduScHT2pKtVyvYrqNRJ0uMz/au8s288yjGiY0bXGiyPn+iF13dKZeqfQEE2KnJd4978zDiajtxRUG49WV0GWP2EGF2CfX52uN7AK0QgIyqo2p2ehcdU9DCT/YQm6MhyIcRaotJz+xxyBnnwZeocE1TSHWdUpsjclw+1iMeOQY+4yy+sn8ZvFo0hTkRRS7lhLwvjTtHoaWjR+OW4Ld5ia1StUnku17UoTLHyAP0fR3oVDHx83pVEW6Qv0D6lg082wa0Gbzu0bX6+bnAmiryN4MXRXWzvbMb9NGWjiXT9MYEIrwVMps1OYE+qvWzXjqGpvZwKgxWunNJfHw5mXo6aVPtU6zjuZcUpo2QFu/YqfH+K52x/J8UwMxCUGIJkLkCWHi4D3dKwwzHFCqSJtuHDK7Fd/9My9GUOWQ6qkEFQIgS3zW97wkbLaCiIbLcpiSXnXLls4eOFxtmHhgoPeN56NTlLQpMlOfsAP7jHRuB/3zLaST2SU2qB8+iH9vFfwJWAdGK+zhrIIAjWRVtnNqYTJZ5DggGJkM//fO53Ml9xXaPZGL+LyWUbgFy4aSwuY6SkjjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362043c8-81a1-4e5f-d9f6-08db10f0fbd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:20.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDwzkWedPWXoUvtbRd3TKFJmEQKK+bv4DZ6obdSlsFx3Ssn3mdJvBlkNPr11KkiC+BB0WKySGKa0mAQwU4SsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: 6bvVMXJ0AW-8M7I6xixXcwAOutVHu5Ge
X-Proofpoint-ORIG-GUID: 6bvVMXJ0AW-8M7I6xixXcwAOutVHu5Ge
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
Cc: Linus Walleij <linusw@kernel.org>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/bus/intel-ixp4xx-eb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index 91db001eb69a..f5ba6bee6fd8 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -423,4 +423,3 @@ static struct platform_driver ixp4xx_exp_driver = {
 module_platform_driver(ixp4xx_exp_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Intel IXP4xx external bus driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

