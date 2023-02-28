Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2926A59B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjB1NC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjB1NCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:02:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36673302BF;
        Tue, 28 Feb 2023 05:02:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S69Wa9027314;
        Tue, 28 Feb 2023 13:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HdWSHhT9etaw7RH+d2W9I3ajz6baIXkmPrDLfWAw++w=;
 b=klaTgQ28mfqImlKsmtJm4EyLfqNWFOtPIiugS6UhFj4+BI6Ev6kdvOi12Y0ZGV20z3Dx
 w2mU4NSGfjigy/RT9TMQZ+24Fz7hdwH5F1EDWvpPYOpAuVSgCZOCWUrstnoQAod+LeWw
 2mx2o0NKlClW5FJF5dRcQ1TRSWA7Dcru8tqZR7pzGSe56JZchmQPb9GF0gfTEPDGP4B0
 lnobqyW7W0JkL3VGEvG2sWab2i68ntkEN1b6AX+w6XiB7SsNtbGxL5+dSLsUSXIjL8bq
 IRZOCnwE9PYV2D7U2DfEHwHvX7dVOZqxE/R5cXIlfm/0MYqgJZSiHkR73pKaes1G/F2C OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ae368-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBmaeU001067;
        Tue, 28 Feb 2023 13:02:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6geem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYHgXT/9MFWuwwmHZnnzunAeuuXquHkLZ/rAEbbWa0WF2JvxZpuW9pQyjrtuBT+b0DYS2FBfZid6QeybohFZhbWw4tAeF+VfC+TMNf/jqQ3zgiCGabFA19BYAIyQg+lvzWPPkPRqmu6HNIA5anabMwSzOwc7MLKSq26+S7MNBkOB2kQt4dv4Tl3EeHODPg2Deuy7wdj/+AmUHskzwQZoWVwbRva0khnMa0rywGhdGmMOini5G52IcgTpIhSz5crrDj/+ZGHdI3Ap5PNOr+zJ2viKzVrjbjGIQBvy1YNf9+0o1AOOPoQ3mUTFEwQn/+F+3Rsa00c9EznkGqTFSrR/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdWSHhT9etaw7RH+d2W9I3ajz6baIXkmPrDLfWAw++w=;
 b=Hogr1/Rv1GUFha6rxq4UYhMzPzjIPp2g2OWxW2zSTNkr91+nOYcDgqnetW7E61bLc4xRrRo/672GK5uZ8f0ZbyaKYaqWSIyr4orLWGkJUsVHOL2qhBdwvyzoOP3DyAejuRwnd15J/4ByNmpYXhOJH8Tnlr2iYe2SBCZTXo8casi/l+eybnHlLxgD74SwKuR8Wv2RH1ckmN1FD7xNdxvnmm1CYfbo6ER9STkeuzUa7oa/2dlfmSAMXtqAZpoyCLnNn/7yJIDeCX/2tkDOV54XZ3ZvEFW4fIn2A5me8GSpVAir2tTCRuQNoHYs/XvVhjabKktXjAAP0+F9xafl1tBlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdWSHhT9etaw7RH+d2W9I3ajz6baIXkmPrDLfWAw++w=;
 b=w9YN3HR8BLFteUsig/JU6z9KYox5TImb0WaWeD5iWxToF4xb7LqUBCLZPiVhpzWp2ymqDraL04IemIAati4I1FtpoLLo8dZfdB9zg8xlql2cQ2pozfcDPMRA53CExLSCjb11USZVBpYlGOnT6/ylSvWeyj6jLkDIlLK7H+vKCHg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/20] pinctrl: mediatek: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:01:58 +0000
Message-Id: <20230228130215.289081-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e23e419-2c48-4972-53c9-08db198c115e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSWNYACJ5KwCXYTmxZmabrST6IdxReLuKo9OWhLRBGoJrffe9mSrsiD9VKHteIgvC9K/9l9KNx8B9zghn51jFqsv/L9esBz7LMJ3EmQVfkTkigJH/Us7zP0MJWLYmbvOjvNHjPqzdvUwDLMXJAnKe+YbVY+s8ZDzdsGHbqF9rdfPDWMAmgOSdtxfNpqv/iIYOlUNi2/T4UtiQSUJeW6CW1QFDFVACcRNb5AI5Z3t+rDpCOikwoRvcLHvhV8caI7qJ8BSqbP3A3fbQQXYYteOfitxIsqGQVNixUvEeFqNNQ4KhdZmoqJuBL76FUwX9EXiasGzFgVEuhELh/U4Q404H+Q3K/iSClgus1Js+pxLYss8MfMyjkTfsUhL6dfELaeXxKrzr6uNm1Tfo4yonDGbkYRqKeXmLxn/R6DTGFMRGFTd/W/w0G6Tq6N/b0bpzjvetTeXXUtFqmvRK9TsgKjyME+0pBodkDdkOxf7dGtExO5hgzyjSmWTG2kewC5SvlCn5PDOySPBXW4xf/xyHVgWI0L2HnwGKYPEkKz+dhr0zVswxjX2+TcQ/gmWtrYGcmOTqnAq/pX3nmEAZhvFeWoCO2FUK74JIHQnlOS8crBEVpbxIZncdSBHXLTPntqRU4jg6gU0UMAHR1qQspSN3RLQ4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(7416002)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ClyPNLFND6RToAA6ec2cvjvN1RefgoOMHIuQ2/asqFx4WhXRC5n8fciLBfkO?=
 =?us-ascii?Q?CU6gNJEGbJMsZZdZblKvnxg5fDfYE88cgxq12pLrQiaphYT+Gw85jfDrcu/D?=
 =?us-ascii?Q?TrgYLFQd9jgpMzHOWulA7GwK9nH65m/5e7b4wAc4SaRi9RduthViXKggy2wk?=
 =?us-ascii?Q?BzEEqY8tDRuo+nffH/FD9hVsiTUEVg0LmpMozA6tMlHW4AcAcpz99a5Ini5O?=
 =?us-ascii?Q?LCOegAL3XO72Cvr4igB4yS4RM6k+bKWWrnBGg+w2g5cOPerxzDlZ9AX3I+Xq?=
 =?us-ascii?Q?Z97wF6dhsEn+qyG7SsetXrYLfhsn7tP5D0+ZIs0p8zFfSvWZLddiluyKLWVq?=
 =?us-ascii?Q?G8xcYhHzSKEuK0kDW3yMKQq/TlPe001Rq/Qot1blkP0j88JaYShZWOyPQSUf?=
 =?us-ascii?Q?GFki94Vl5sDQjPp5bJqUkaCYJF1DWCxHKVTMgx1o1ZHRqhjwfmhMFVXA1itn?=
 =?us-ascii?Q?fVcgwDUOpowiyYc9YzgxWYrKCdJ+zqF5RQN4QaYW9wyc+eqbgq2wrbymO7jg?=
 =?us-ascii?Q?eZywYWKwPHiSkrO9OxsTkG61u/AEO96Jq89irPY6RBumS9RnRZY0zUdh933H?=
 =?us-ascii?Q?WKEFzi0obFGlkuNDHZP88AcCh74u6qBmCp6m1KxRhQ/EyKFRewuZOEvyNGpk?=
 =?us-ascii?Q?WerOT4eyMtjAJWny0wgzs8zWN8nb/LPAZ/WAcXKZ72kgRSAPeFGCJtI1F8Jw?=
 =?us-ascii?Q?y3deAcBhgY2c4p13CatZiY8rgW2QycHPyfZuoPbPVomVQcuqY9eZsHbjLezH?=
 =?us-ascii?Q?e5zgVvhBJzcReG3PtkTQ5tNCwqbpdLM+wA7CM59HoN0Ph4IZh9KClqI1jr/z?=
 =?us-ascii?Q?fM1wseIkiO76c9d0fYBuNShUr32kLdVXP3KoNoBQ8BeZEx9HL8iw/dBMPdnD?=
 =?us-ascii?Q?fg8YSGpRYFPuRqQNBlBAhNhTd/1HWGycI4oFKyFOumznIC8JzE+if1vykEVb?=
 =?us-ascii?Q?Wcs5PQrfQn+Cix+ZLRqRVjCugEKLNSp812ZlK0EHnsAaAEDlRGUgnHBD6q3D?=
 =?us-ascii?Q?LxvTUt8o93ss2N05BX+AiLXCAptAftKKuVGcTeka52iyYspqG3Ed7pcxInCM?=
 =?us-ascii?Q?wx9Xv5Bui17eCO8Fqm+YniyZhXZEuXKl2vhtOlGm5p8UYOPfZOniBjmDY0E/?=
 =?us-ascii?Q?qwWeprntlUtxyAfxbBERnhCo3edXFYaWcTcFyvbe4OwDEuRhsrIR8AoAKWer?=
 =?us-ascii?Q?Qi8clbGrho1c1/C7qqdi4yA7Zx1JxjaLWh1MS6p9CDvywAD9m4EJXZjbCKOE?=
 =?us-ascii?Q?c90C5tTqIpzx2XD8qlYjmoxJ4/aQbYrb5g/ERMk2+cv39jyNA7di3KkosCFm?=
 =?us-ascii?Q?gYAWfg4SN8vi0y0+VjyU5n51oQFpxj3hTJB6L+wpKGthMP08+4PD2ZzzsXV1?=
 =?us-ascii?Q?DijobhKiIZDGJa7zQICSgnxDI6Nk3fAWvvoW44boqZ28ZUL2VoaokzK36VMA?=
 =?us-ascii?Q?8fcO+IAcQVjk7aM97EdbE6si6bkGQUXyQpx3xUhMffwq7jP3Afoo+ifBCcyk?=
 =?us-ascii?Q?+QLZNKdzJxBJ/5IN/mbRWdqDqv2Ggo0K0KuMCDoVFLe7/v8DMCioe6iFen6p?=
 =?us-ascii?Q?VfX53hKdW1wUbfjk57KjRoEpj0fB9CeVaD0i8cK4P9eDONJXPtNHBq0uIXJF?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8wGjw3U0wumW2Zlj6m4Rh2jsq8y2LGVVKuIbfQ8OZWpChFu7w29K8Qyo8ud7?=
 =?us-ascii?Q?tN7L/LanBhkPh50Ztq811ghzkOpDF/dIlT5j206YNjbeYDznwvKOODUxgOo3?=
 =?us-ascii?Q?NSOxl1MXHzrXCt/794QTg+YZuXZr8Pvf0wbgiTMzLlh92T60AiY5dWjxMojU?=
 =?us-ascii?Q?r54bzJdh6a2Nd+CPkgD024kZ0fb9IO3HRKCkxnThehtNUDkWHnkMQwGjB7Bf?=
 =?us-ascii?Q?HTZzDuh29n6Oblim2UWW0WSROfK8hA+gGfEfZDdsGW0yFj6LuxoY4e8L8QCn?=
 =?us-ascii?Q?wZn2+nbs16giduq3cxnf4NuGCw7i1LJWnI/w6xAe/b34bJtuz/IVhZzSoto0?=
 =?us-ascii?Q?yrMSnUZZeLHs41rNpAheTd2kItgMj1uhDHQVeVcM+oGjWJd7Q9porjacv6KA?=
 =?us-ascii?Q?7/MRxIPVZcKiq0ZPer1dkWg+ONsdGjKCrUSC6bHD99jJohH9zSwc2fzfamqV?=
 =?us-ascii?Q?7VxVdiJGQr2/GPvLNVaErlq1OnwPfPSrRIyOWkRNjuSgD7jpFE/n8HU6YfJ/?=
 =?us-ascii?Q?Rs8q4om8kpYn8Qc6r/3sThvRV6wrP3TkREC/XYGyBp7Zbu5LZZ6fJYm68+5D?=
 =?us-ascii?Q?DbPykAI/naEziI51dJ9pGyHpYEgr4r0TXkUuK/bJDJtcPgfHGErjjM9ykvRi?=
 =?us-ascii?Q?PzB0AzhCaXzeeo45DDNikJBzjZ37HnsGCUJGifatxNnLqklB2pPTQ02/MF+y?=
 =?us-ascii?Q?jn2RBg74hX2pt6eArPxE2s1HQmRCcmgY8mv4NLR3MDbCFqgV8lvhlcuXmWID?=
 =?us-ascii?Q?HAeJpkto5LaZTazFHODNrmQBD/Fqy+jyauf2V9Ht5PCxGLk2bBZNNAeJrHyE?=
 =?us-ascii?Q?CwYH6kK2opNOWnkrpnlml2hDhZ68RNzPgQE5Xsesu6v09qhesCHdaTIDvgu9?=
 =?us-ascii?Q?SH/VMo2YEXwqUoGkIOLPO33tCqSztu8CczLYxnvPTwrnUcYDBkW7NxMe+Ai3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e23e419-2c48-4972-53c9-08db198c115e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:38.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EynijOqPjgvpPgE2dCJjYxLMTf8+xsTgdtE8tcpMeCVWV/CmQrzFdOSTzrleTH0BB5X9JX0B1xapOmRl2ebB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280105
X-Proofpoint-GUID: 5OwZAJ7TL0Sd-B9Lecsm3ToUe85mphXW
X-Proofpoint-ORIG-GUID: 5OwZAJ7TL0Sd-B9Lecsm3ToUe85mphXW
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
Cc: Sean Wang <sean.wang@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pinctrl/mediatek/pinctrl-mt8188.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8188.c b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
index 6a3d0126288e2..c067e043e6192 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8188.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
@@ -1670,5 +1670,4 @@ static int __init mt8188_pinctrl_init(void)
 
 arch_initcall(mt8188_pinctrl_init);
 
-MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MediaTek MT8188 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 9695f4ec6aba9..dee1b3aefd36e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1431,5 +1431,4 @@ static int __init mt8192_pinctrl_init(void)
 }
 arch_initcall(mt8192_pinctrl_init);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek MT8192 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index db4492e9ee673..75a505035e96b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -495,6 +495,5 @@ static int __init mtk_pinctrl_init(void)
 }
 arch_initcall(mtk_pinctrl_init);
 
-MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MediaTek MT8365 Pinctrl Driver");
 MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
-- 
2.39.1.268.g9de2f9a303

