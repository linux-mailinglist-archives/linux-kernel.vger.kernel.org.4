Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737E642CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiLEQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLEQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE055B1;
        Mon,  5 Dec 2022 08:32:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FpmXZ018578;
        Mon, 5 Dec 2022 16:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=LRN8OIYLleP6YrIa2ynS7Nm1cB4VQOU5c/CwRwYqKZ0=;
 b=d09+82YIV2r7GYeLZRojmnmNqw8lA+Vm+DKfVQONCdm9SDC9GeljaOBYry80JnKdPFzu
 5r+7NbZb6ZEzlBfGLeRa6Z7Tv8XYKhf5Ho6wVoHzmzKxhX1rpvt7gGaBLK61ql031BU5
 NStWWz/TZww0YB6rsIjyMvlRXQfr6kk/KZyNAWNiwAkm44p1DYVbNtylMkfG8bfKdVE0
 wWvL994cXCNLfsfdRBP6faZxkiV8glb8RwfS/gWCQG62nv8hu7Ud6B2kBL2uWbowT1n3
 hsCEBRTVCTBYgov8ZqQyUzKi5oqujTbA9lZGyEgvk7jPc5N8hvDyrrD7PEigjF+T9HrO +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yb3c9r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvK9009444;
        Mon, 5 Dec 2022 16:32:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ugeda2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq8nY6/YiI/sMKRAPn9JckWLuVBevy/soo9i/hh5J2aKd9ZjAOVGMRZ7rnUJlVsEn1hN6BK3LnCAxjESQCVjdvHWa8EeWc2E2S0N0uVeGKOGmbUkrQNjcBjBYGIkDt0sJaI9xfW0FZ3/oKu9noEtCaBIUJYF2B3i77BnwCRI9iGgOyMFqlMy78v1dMaGWxlAeuP8VAL5syiFDHP9sFbq5uA5cXFxCEfpUmUWvvgpH6VWiUWKTXEwD2t6ogPMmaUCRHi8rJ2jNj/VYbRTar85pOHyMmZl4rWJgCsN5eicK0qo4Y3aPle2lxTkUyXO+4NgrFe8yBUSdQ0Xl8uG1YE82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRN8OIYLleP6YrIa2ynS7Nm1cB4VQOU5c/CwRwYqKZ0=;
 b=kgjooX6K2MX2kZgLb0fjiAGy0ODDQCUOQSGMesOcD8E/5UGKWZL2sHLEh7ZmIbZ0d7UKYTdKXTW5rJOwrrsUA1NE/P3PnA46OXtVtLIJ4lyw9ozXN8AsWGAM2cWMhuFrHktMUoMmehRgJpKY9czUTUN+ZIGE1zWa8SA8nvvdC31E7WOLCis1/ZarnzecpdT1rWSSAyYlZ73vSzEcQIyKiwVkGpBL3jaD+zNhGArTlZi61MGRMQko83rkUO8djxUL9LQrAkWo9CxrThMhhz0yDA9TrV7nmOnMxZOBbkDJBOkzDbunXgJnmXiMFn6RY611ip36eODJiU3S3jZcpf2ldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRN8OIYLleP6YrIa2ynS7Nm1cB4VQOU5c/CwRwYqKZ0=;
 b=RvuGPWxJ/SQL9odI/wd2BG7hr7ZwGcSE5DBpwE/DdHZ9/tRW8XKjBiUfjmBOXjWLz4e+0xY9xav9htoiYfAoSTU2k+7u5KwBb5UUFsXjyF5E6aNN2WW4EVx9fn5nkvDd7RUZDo1SO8WP4DCZpi4ZRo+Yh7XYDBxM10bUX4Yg5mU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:27 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:27 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 03/13] kbuild: add tristate checker
Date:   Mon,  5 Dec 2022 16:31:47 +0000
Message-Id: <20221205163157.269335-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 572f9481-2485-4ea6-34a4-08dad6de4c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AksKE9AP3j2vWNdLWJpNMPFJ8ANmkf3uHyZyBa49Pa/pREY9fS2NmApOUsGzL1R6GezxlgSzs2R4/r3kjrRian2TqXv6kT7BnwZWmYz7+4Xqbr8WT2Dx95mrF754SetQMEmGZWOmzInmFj6W9yjXt+VXJL8htsjedxYeR8PTMcjXU90fwHKq7Yzq9ebFAmVpQqk+vk/hNy2c87tdxu/89JywEwtqqhtLr5lrjdtrwSvsMMsO1x5qrxGGiUD222W3Hq6KybGQ9CVhH1igccNIMB0cxgrTlWPSZaSj4GBaTTP1NJiKLL5eqOIqhgBIlK0oC++j1YnvnqryTcSshTAU4R6ViJpSMIW37nKvS/jb+iCkn2LoTB0sXRcfe5l5cmKKuuNwJ7CHiKhc3zXnpcGRpesN6mzpOrViCeT9A7qEyVURSriiNrcGSmC7BHVQIQMuIiYdKcOvYTSfLWKTJGY/aCGWJwqtyiaJRlHk0C5Gy0HeRg5s/dakZstlZrZIaXxkye1VImd3hCbs8OF0llbIvzc1yo9LYBjyaQTekZa4BNq8P7IaVlrEYjjAUg0PZiLSk9Z8w3WpATnDvyzuSXGaEGvtNpstFYvpvbzqWJWZ6qjvRQDLFkU651B5wN99knoc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1LwX+FR5RuhAJpsvDjDuGat8D5K9qzan+A5entO3t4zH+3i6JiJ/rpZNwDL?=
 =?us-ascii?Q?enUzlUN9MteaDU65PJ3olDmvZVPtu0ce5trQu50Ho7sVeAmI3jI1VDV+TMr8?=
 =?us-ascii?Q?r85vEO68qrQnNwoxbWodWTAzHq1Fsd64vNmCRh7gmjwccc1uYsqsZz+6LX1w?=
 =?us-ascii?Q?i9Klnb9Pl3zsVG80XMRV9wk9Lb+vAsKesTR2yhwJxfokqw7iYCCRkOL648ln?=
 =?us-ascii?Q?NWRFQ7SRvdApKCBgrOvxOC9+t6E1XyclvAg7vfmO/NiUuYJrDxM/PiJ8+c8e?=
 =?us-ascii?Q?IHy9/ktMJ7yrxTkddIoo/FCm6BXC3bxa3QbaqRK2tFop0+0vvf4/tS5wcP6w?=
 =?us-ascii?Q?rBKHewteKod8vgxvObOOhGh3Dv5hlL/rTz0V6LEnys8ABPf7GxY3qhuJ8UdM?=
 =?us-ascii?Q?Zld7F5xeGw6jRuX5EhgdU7mxsegRqqiwz97tJ6h6IxRVr9z5qvm9osjjFwqp?=
 =?us-ascii?Q?WzUqIEQpVjVNAyWhMwdm8REws8PX5KvWo3dMCkHJfFIqJ/+Qi4VCXVy+cwYB?=
 =?us-ascii?Q?aaKNiBakX+4WHIyJD959wJdm2CoEALYu67wuxkQ9cJhA0JF28G/H5dV0aEiL?=
 =?us-ascii?Q?NG26upu3vWHFnpBWstjcSIj6cOMptLalErw5d40pKBNY3r6T38Lpd0X2oA9c?=
 =?us-ascii?Q?/MkBLN+AVfHXNj+R71Z5aK5mt/ljhI2ZgkoMYwQSSciUZ1EXt6pbikWl5ubD?=
 =?us-ascii?Q?LarDtQNi2b6uLerPH2sF4o3GQ/CwYXD2ylXugIdLVK9IFHud+pJ3A/Noag9N?=
 =?us-ascii?Q?mQ8r5pTYbwzk1zczpS6aCzayqzLKOo+P6Fvp8S3f1+i8Apw1crvcnZVrrbST?=
 =?us-ascii?Q?ZvUYSiTCGYlV3CWjh8agTboouiBWA8/pkXoB3rEMw9DIUgiOcPyaZIGp/flt?=
 =?us-ascii?Q?eKhpg4cpJ0rDmoxREd5sVWyH8GExc+JZWvJAUx6Skm/U42QcwL01ALIbGj7+?=
 =?us-ascii?Q?SQ5MfjKzhYTrbxgCJe6caIJvXyLAUuZijbwr1uEPLvSWuDHLIYPUEBSinUuh?=
 =?us-ascii?Q?DLUlojcE4L8CtnfruFXhKQ0yI8/pI9syrhj2Rd74qg4tMIRYfrvrNLPsXQhv?=
 =?us-ascii?Q?yNjEOGUqfxdY3kKiYqSqIcNey2nLb5fw7WwU8/hXYMJhyhbt/br5MhP+ypse?=
 =?us-ascii?Q?xNxc00DNaEg9hEwujd1oIpjq2JMcwcn+cjQU+/FP4/O1lJGRstyywh1EfVnK?=
 =?us-ascii?Q?SKX3h1rzxJ6qt4EH8MPoxqxNe9U2+ayD9IH5nXzS/CHCUb7CLBYrK25+xe7W?=
 =?us-ascii?Q?/pB0EDxy+v3nSpNIilTwgfT+4QaUqZKevoyH7OdM3el6GsbQ0KSqnFOQa4Za?=
 =?us-ascii?Q?02GRvllO9Cs5JDWYv+/tJ4gTGRVOMx1Aj9IoI8xoCsP7kDsVd4CizyNksEwF?=
 =?us-ascii?Q?oI5uCyurGATx8252d86YPMXy7b4jgOQjD7foYYbUauHzozfDSU97reZx/ii9?=
 =?us-ascii?Q?NbuwvX/qIPuuVvrJ1e/gy4FC5wqcU4hOJiVzf4h1kiufLayQ4qWR1t5Jolax?=
 =?us-ascii?Q?+aFPfzHxEvMfEf1Sgqid50uFG2g0vNFPsM2ID6Aw4LaG7FdHnzo7MFisLORc?=
 =?us-ascii?Q?mGBdmuGlvXHcAM8TOki/Syw59niVnLjM3wK9FpO4zqwOuNDTRPezrVgxZ/eS?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ctFbSl9917EXtN8agEhIv0qVqSvzU/kGY9R3epMr0rRwFCUzR3J4QN24F1FS?=
 =?us-ascii?Q?jbMDDEEacY/qjhRNESPinv65zRogJy80PCiVn+W3YlpcAHV8FLlVaJt/K6VZ?=
 =?us-ascii?Q?HuFEh34zXASWQH5BLXbYU2NTJgq3ImAyNn33/4KXyuW0XJ1fmU/RVJTB+q89?=
 =?us-ascii?Q?bw/ASqUBjsZuYlmXQwfX/tBni9Mu9RLoogC2nPIua6NHcvVWUPYS0nWMC7aU?=
 =?us-ascii?Q?4I2xfCONGLEdtgTGuHGWfFPqEuhVwG1Wmak0lt+Xxy4ySz7U9NeMPTKFlObD?=
 =?us-ascii?Q?ajjPgRSA6yVPYB8zwn2pB84w1nR33o9cHvBd8Ih3AmezLV213UtIfazG66Be?=
 =?us-ascii?Q?VxpKSn09AgTssbKECxZZWd1i6gxR5GkmTlFT1pjQtrLD5u2U7ae+HOHlM6dR?=
 =?us-ascii?Q?ESCojxHutJdX8BKnqZgQi8wpCzJAeRz9pCjVssQrKjN9HQH/KumcFj4c2TBf?=
 =?us-ascii?Q?cm1pyaV23bXDeLIcEZv3gAaLnp7XpAB+L5yq6IgU04PrdBpvX6DlgmVZTxCD?=
 =?us-ascii?Q?sCM5J+wdyU6sc2ReoX2DloNJt8ohZ6ekxXl/GHgZuBP0a0x+ttvZx08lEshY?=
 =?us-ascii?Q?/WSCr1F2FnSg3Tc/TTFDuaLQlz1wxWJHQAuzKMYTEUOSZ97Vbq+3fhbuBnF8?=
 =?us-ascii?Q?KvrDWe6p+XqVAWysBL0jxIh88bSGPQmx3hnODXV5SM8Un6spguMDApzPxS+j?=
 =?us-ascii?Q?rPaKl6oh/ue/5Xw87q5PXiGKNJFz741rRy+53pT222USApDo5h4zlcA/jBw9?=
 =?us-ascii?Q?JRX14bEJclG/j6ej7nULBP/53GLNif9Gt5aKXm/syeRilJVAGSQ3nwwXivDg?=
 =?us-ascii?Q?6k/28A7ljb/Sy9u3ITHWCpVOPhu8VwkZrfQnucN2itK1PWyMh28Fkw/pCp7H?=
 =?us-ascii?Q?Le5ApbvyiPpypSk7I99TRhARCEvQK9MZkFzf/2a6iSsGY3JcI2DjJgPQU+gI?=
 =?us-ascii?Q?4DgWCKacFKBmzAqQHRM8m2C5gqQ2rWhrnljdPORgmbw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f9481-2485-4ea6-34a4-08dad6de4c13
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:27.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVydv0SkuCWL8jD+mSl42OfsfWeqWN7wd7JMSP+DIPITClNomTVJfBIZFd/4CDpAJt/hf0SCyAOKON/tgEmi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-ORIG-GUID: Qo4mhr2BaQisWaGQRxquRwXQMqHSMUaN
X-Proofpoint-GUID: Qo4mhr2BaQisWaGQRxquRwXQMqHSMUaN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new check target uses the tristate.conf machinery just added, and
modules.builtin.objs, to identify source files that have MODULE_*
declarations despite not being modules according to Kconfig.  After
commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), all such declarations will cause
modprobe to misidentify their containing object file as a module when it
is not, which might cause it to spuriously fail when trying to load
something that is built in to the kernel.

Only source files compiled by the current configuration are checked, so
a make allyesconfig is probably a good thing to do before running this:
output if you don't do that won't be wrong but will probably be
incomplete.  Note that it is quite possible for things to be modular on
only some architectures, in which case a make allyesconfig build will
give false positive reports on other arches.  (This is rare, but does
apply to e.g. KVM on aarch64.)

The checking is done by comparing modules.builtin.obj to a new
check-tristates.objs, which is built in a way more or less identical to
the way modules.builtin used to be built before commit 8b41fc4454e; the
principal difference is that it's only built when running the checker,
so doesn't slow down existing builds.

This file is similar in structure to modules.builtin.objs, and
constructed in a similar way to the way modules.builtin used to be built
before commit 8b41fc4454e, via tristate.conf inclusion and recursive
concatenation up the tree.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v10: adapted from modules_thick.builtin code: adjusted to use
         modules.builtin.objs, turned into a tristate checker.  Top-level
         Kbuild changes no longer necessary.

 .gitignore                 |  1 +
 Documentation/dontdiff     |  1 +
 Makefile                   | 23 ++++++++++++++--
 scripts/Kbuild.include     |  6 ++++
 scripts/Makefile.lib       |  8 +++++-
 scripts/check-tristates.mk | 56 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 scripts/check-tristates.mk

diff --git a/.gitignore b/.gitignore
index ef8665c64f21..75f246e0565f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@
 *.zst
 Module.symvers
 modules.order
+check-tristates.objs
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index ed1fbc711f33..17686f59039c 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.*
 modules.nsdeps
 modules.order
+check-tristates.objs
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Makefile b/Makefile
index 248f780cb75b..4d8a4c231cc1 100644
--- a/Makefile
+++ b/Makefile
@@ -1689,6 +1689,7 @@ help:
 	@echo  '  coccicheck      - Check with Coccinelle'
 	@echo  '  clang-analyzer  - Check with clang static analyzer'
 	@echo  '  clang-tidy      - Check with clang-tidy'
+	@echo  '  tristatecheck   - Check for non-tristates with MODULE_ declarations'
 	@echo  ''
 	@echo  'Tools:'
 	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
@@ -2012,7 +2013,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*' \
+		-o -name 'check-tristates.objs' -o -name '.tmp_*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
@@ -2082,7 +2083,25 @@ coccicheck:
 export_report:
 	$(PERL) $(srctree)/scripts/export_report.pl
 
-PHONY += checkstack kernelrelease kernelversion image_name
+tristatecheck: SHELL=/bin/bash
+tristatecheck: check-tristates.objs modules.builtin.objs
+	$(Q) for name in $$(comm -23 <(sed 's,:,,' modules.builtin.objs | tr ' ' '\n' | sort -u) \
+				    <(sed 's,:,,' check-tristates.objs | tr ' ' '\n' | sort -u)); do \
+		grep -w $$name modules.builtin.objs | while read -r line; do \
+			case $$line in \
+			$$name:\ ) printf "%s " "$$line" | sed 's,: ,,';; \
+			$$name:\ *) printf "%s " "$$line" | sed 's,^.*: ,,';; \
+			*) echo $$name;; \
+			esac; \
+		done; \
+	     done | tr ' ' '\n' | sort -u | while read -r name; do \
+		test -f $${name%.o}.c && echo $${name%.o}.c; \
+	     done | xargs grep -l '^ *MODULE_' || true
+
+check-tristates.objs: $(build-dir)
+	$(Q)$(MAKE) $(tristatecheck)=$^ tristates-file=$@
+
+PHONY += checkstack kernelrelease kernelversion image_name tristatecheck
 
 # UML needs a little special treatment here.  It wants to use the host
 # toolchain, so needs $(SUBARCH) passed to checkstack.pl.  Everyone
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2bc08ace38a3..8042c067312e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -78,6 +78,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/check-tristates.mk need-tristates=1 obj=
+# Usage:
+# $(Q)$(MAKE) $(tristatecheck)=dir
+tristatecheck := -f $(srctree)/scripts/check-tristates.mk need-tristates=1 obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f7e5a83572fa..3bbfa99259cd 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -39,11 +39,17 @@ else
 obj-m := $(filter-out %/, $(obj-m))
 endif
 
-ifdef need-builtin
+ifdef need-tristates
+subdir-ym	:= $(sort $(subdir-y) $(subdir-m) \
+			$(patsubst %/,%, $(filter %/, $(obj-y) $(obj-m) $(obj-Y) $(obj-M))))
 obj-y		:= $(patsubst %/, %/built-in.a, $(obj-y))
 else
+ifdef need-builtin
+obj-y          := $(patsubst %/, %/built-in.a, $(obj-y))
+else
 obj-y		:= $(filter-out %/, $(obj-y))
 endif
+endif
 
 # Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
 suffix-search = $(strip $(foreach s, $3, $($(1:%$(strip $2)=%$s))))
diff --git a/scripts/check-tristates.mk b/scripts/check-tristates.mk
new file mode 100644
index 000000000000..fa9fadb79143
--- /dev/null
+++ b/scripts/check-tristates.mk
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating check-tristates.objs
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __tristates
+__tristates:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+check-tristates-subdirs := $(patsubst %,%/check-tristates.objs, $(subdir-ym))
+check-tristates-target  := $(obj)/check-tristates.objs
+
+__tristates: $(obj)/$(tristates-file) $(subdir-ym)
+	@:
+
+$(check-tristates-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s: " $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(check-tristates-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(tristatecheck)=$@ tristates-file=$(tristates-file)
+
+.PHONY: $(PHONY)
-- 
2.38.0.266.g481848f278

