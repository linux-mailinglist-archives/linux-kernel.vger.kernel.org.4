Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D169AF65
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBQPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBQPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:20:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE826FF1E;
        Fri, 17 Feb 2023 07:20:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iKOJ001690;
        Fri, 17 Feb 2023 14:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0aKEErcd9A6VB197VqZqajs8zTVg8JsEdlIub4mNDMI=;
 b=lW0ojMGoU89VFBvVLMbFvsMssnn8I1iRfx8vOpC1fKD0gvxCcCFSGeB8B3Ohb4am+tvw
 JGOkI2KklCHaZwzacF1U1tNmYH1RQAmoMxPjpc/12Hycop999zcl5N5t/lyM+jsXM1PQ
 FiW2EDR6mmezJMxYLQ01M3SMuc4Y+S7WiVC5OTcYe67M/3SwWlTcUCCqxqNcQiaoGxIl
 vSCAYmCH2AN2kC4D5JaP1Z6VKoNgbCQnfeOZsZ/5oNVDIpA3axJkHQ20WoGNxVAlXH17
 p8URGK/dRG4d4QWzxmb8qmUPLNo2xdd6JgfWg8ZpGOCn55IQRnlqyD8X70x+Sh29hsAu sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1ednujg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HDx21N022875;
        Fri, 17 Feb 2023 14:12:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa58jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6prd3Td1VF9Kp1ddYWak0YWMSCUGyA15htDvdcV9II/gzK/SsCjS4yUS9+xj1wOrvWU2x/kvEgMZRuMkxdRs+NT4YDJhseP8rrYDd89RJxlppQh2lQd82FV6yay20H6GJurIwbjiMPgIjDgglUyjJmFmAaXbt+5MpNHORIpwWkN9+q8vHvOzbYUX4/flH+IE4zIuCoE72jSk3DPbY6OCZGvKiSO8Mo9bv7qyROMv76zxytXqDpqFomzYsNHmdNvNfrt4Yd0mRoc+JOBb2XHVs8DbuGvx/6cl2xiAlQKIHpiI0IwH5/gcb8lkBZopPUn9jxzOLPmmF6YPLH3diIvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aKEErcd9A6VB197VqZqajs8zTVg8JsEdlIub4mNDMI=;
 b=Ix7NBcNMZmVFDZUfbZn/HIS8CWjQAdj9UPcCNtYgME/lkD4gDX25TGB7aB07Xth9rCBCEORaZpPkupSSeH6TWUCrqmUruQSQWQvKrBlvAFXVl7YXTpgTljUFNnAfHAvBYsyMHLINFjctr6RrpyAqp4YV2ScKNMxBQfsJuP2UYbnbdc030By29CaVZfGQUKNTkY+00Xrm84vMKeYi0VZSeaUY0B+3Vu99GmeYiNfVUHT7fz5CASow0uVn8HYh0M7ZTuTQxbc1xNMhncQv+zybpgyk/F5fLh5V8iI+DOUcbn5Psq4qlXw7vUAyX/bUKkInVIH4DIm/WHmkEWlO3vnXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aKEErcd9A6VB197VqZqajs8zTVg8JsEdlIub4mNDMI=;
 b=O4NN0ihQQZcqoB/Ohb9UeQD+eONCetDVEb0iUoYM1k4LJuLLxgmf8INACZW89+YwRKNOGNzqo7WvU1ArMrJEs6mfWNC7IFADeTAvIVOjvGtb2FfA0nVTS+Ss34JdZ4st/qjH62/eUFJ18QXCvnkt37/Yq7NvEICf/CzN5PIjtmA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:12 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:12 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 13/24] kbuild, clk: bm1880: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:48 +0000
Message-Id: <20230217141059.392471-14-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: d03f81f0-6607-4ff1-b490-08db10f0f6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8RzSonSOgAk9+2qOg6k68DxQM0cHY0v2OPn5OUYmKZgaNykRZZPyecxl+O7Vhl/zKXrJJZYDrdvfONG4H31b+W2UBU3V6Mb+SafX2FLbmTrvBgqr31ELCdcrVOnHwoscSXZtohHKoyCVcYItTcbZID+dr3hMw6Pd481AqPyPHoEVnlbGlI2cqA8wtVTvZRkISDR+2MSWBR/FwZwNxhk7mRmx4zXZgIvsIc25MSuEqP7i/fQ7JJhnplAjyBJHm4h33d3J9rNBi//icySF/aUxrPmq8/BhOjy5/pvgy7jXnd2Px2cuiuOohr+hbHAJdXtj5EV/J9rfRwyfK+jVJzcu6g8LhWaia3FGGH6wG6q0t+TmsZ56rRhlOYAYuWhX53H7w7Y2WUZhXjfpWlAIvg4wyl6hZ6/EYAZcVn2NmkK3GI3AXrz9UZcO1l1x3ixZTg2ALV0rTl4WHSp1w0Hd6nh7heEMy9AvzMe7BTtcsTUD/CVHNqqBANW+WLdw8PRCJ0fw4EoGfKcqDHXQ+VPE1rKn0Sq6nmmhNH1nOgHexYVePbmWS/VYSqSMbxfTRfIB/h0K1XCbhxydns9dKq7H2alWYQcFMEKyc3NHay2O2noMmuPNeU+nHpvo8QWr6eRKSa+D51r6+hGGospx+J0jJkLJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aHskLeaXUONzLrKeGeqVpF4mT1HOD+q0vN2UufrfXc0bmXtUxFWx/E2SvM/U?=
 =?us-ascii?Q?3nmvgv+g5BjOG8fyiiUY8OP4iKpyl9Ng0NuOTJLilyoxXDVkJKTApnrT2W3q?=
 =?us-ascii?Q?P+UagbWnfSyWhA8xWgt51kiRvHG9Fmu5uQ8q3c/4gBHXUAKFsk/jiYrX3QiC?=
 =?us-ascii?Q?/4tNEM9122GP12hVvoC8KGnEGMpSKSuNDuUKisV60RBnWGOA/6NOrTg/XWR7?=
 =?us-ascii?Q?HaGjsUEaL3coKctAxEqXB/P3tfgy/ew5R9Dgj1QixGScbtH6zxo5cerV3dr7?=
 =?us-ascii?Q?u/690QPsdKNqMmWsBO/mxOLoZPsEdxSlV2LuAzmSdHskkfyqZ3dBdVHJDW5/?=
 =?us-ascii?Q?7FZgqY1XnmuAcB025I0qJzvRQFQGLEq2tp0KKiP5/uLpQotfMbUutT93eZjs?=
 =?us-ascii?Q?RUl1E6am59IbPP+Zdi8iXg70u4PxAtib1S7dQrPeCwS5Z2EKbmf5koGtgvIN?=
 =?us-ascii?Q?2Mhe0MKyk1Hiv8ITCnp3ey++ceIRKlBQyebumcHh9RKdKx6BMllkx32mkmqu?=
 =?us-ascii?Q?iQmkvXFtTAmo4lpdcPlZp1wR8RMI/bnyYu63FW19vWmjx8c5x9iilUYqrN+R?=
 =?us-ascii?Q?suYVdASnRu+yfbs2Z1posJsq6+cWyALS2gadXd7S8f7jvCsw/QDDcARKKtvb?=
 =?us-ascii?Q?tUE/VJkoatfS0kZyVWoBlXB/1q/AiUDxZP3pRVbbRTzSRcJzqYcc8IPfw7hI?=
 =?us-ascii?Q?scff64BOD1rXoCeIuizdC0AZDui+vgA/wqe/TrIpY2ACFq1PZ4mb9ZXKzll5?=
 =?us-ascii?Q?0Nb3qU+C5gfUibBpGWF/NJK5cA/ew21NMTP26Hgro93KyGm7vcJNQEDwqQ/g?=
 =?us-ascii?Q?wu6pSN+v4x/A0OogRnzCal5LyBE9uQIo7jcSpqkcSO+r7vlNPY4aJpLErhTv?=
 =?us-ascii?Q?uKaR8CBUqDED0fJLaDLk/bfMtPtqYQeLFWFVYQg6T2ONadSFqFI23IhesxHx?=
 =?us-ascii?Q?X5DHe4On/9VnyqCol69kzVvJLT0Pl8Dvgw08ti+VV7jT2rxETjdtAc26dFkT?=
 =?us-ascii?Q?XTCNxC5YA9aRUB0NMRX+49t4jrZ7HaOx+lo95kycsVmZsRm5xZyuEeO0TNhr?=
 =?us-ascii?Q?M1MCY9ItxhG7ldpQrTRZxsRCETRPYvns9zLyUEH2VruqMNIvSQCLT8RlFxuW?=
 =?us-ascii?Q?RmqJLOxZ3y7YoxRdicU1eRskj5FdW9sED0fclXwukM93Sz6+ZqAfYRv1bTOO?=
 =?us-ascii?Q?nXi5DhTtuKsr8CDMpCfKtrjt44roRBX119J6wDO/bG3viz9vyTSzR8NKUIcO?=
 =?us-ascii?Q?+9Vtay6mOPviEQCsewWKs7MFwbusEf+q8AL7SSfhpHPyPPTJoMsNooy+ZhPn?=
 =?us-ascii?Q?6r+JOqfRRVhp5a5SC0OeEzrFDGcP1EvJfncpgtGChoz0xGuMsY4scpWry6nj?=
 =?us-ascii?Q?bzalCtkSQhTHEnTztp3ree0opdhf9v21yj2w4lw1xjfGxAu2zbpzc/U8LUea?=
 =?us-ascii?Q?H6rtPz6dS+EcVPBGTSBM5B/9KXjg3AnlOdq/TqXZoK4TGLz8/s8cStivanaU?=
 =?us-ascii?Q?qqbqccbOcLVWFkPl1DrwGqgykdTLKxVgKZaJjWWkergsIk9FEdQoGV0gOMQw?=
 =?us-ascii?Q?GVzxepT4vFfXae4yu1LSJoGJrDnfXwhu7+vLuX6DGRGoWTvDLc/gi5RYcd41?=
 =?us-ascii?Q?Io/lV9j1v0zR8Xfc7cHjG4A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YEPTuJJmFRVY9yI0xqm8lBs0orUkjdVMVxviUBDmojTll/XATh7gZOU5Uc/l63qyR+k2alz5u9i30itKPoVwPbX2rH4WBhQkWTwNgQrmrbSi4B85/jpZ3f2ZFqCMw7jbUocxx5lbOvOhSusSQFPIAFIiNVPW+BaMs3c4rWC87AMqVDzzV56BJxs5+imHtxbJJheunwv9PVPPq+XHPBZ01160weAgneQQar4jjlWWvlp6vNK9Jm2QO5jQ7pgGtzyPEu5+qcqzCbmaTIZBX3nLUd4VSOqu8eEPquo8lzYdsUwqxWb1Tx75pDa4doW3FRAgYWByKqQ204WxfhxpsnLjXH6bz6k41ekU090kYTkCAdMAnTN+CwEpdqS/7p8U+zZp6SdkgFJpmYsUJr+0/Xne6RSz02+g7NdZAe42sR6SoLgwKMdepzJ6wBubzXnXeRa14LcpB2q8DT3TE97Kr4SP6dMG4AwbQMIOvUfujzMxZS4lKkG/UmjHOgrsOnwgKo8GNl6J3s8GXOb06Y/bcvbqrts1K8mNZ6WkwJQN31/nsIeuf/7c0kjJgKtmTsyLPQ+xepn8tRmRUlkE++Y5ITcVN7JZHACvzY1u218Avc2d53X+2y/aouDiWvhvBTbCnLwyqNYGxzNK9CgJfgttJ6MopPRegtkXnVFlm/GeOPRUEJHGs+Dvw9OpPtvV6MApdGQwZI32CR1uiBdo2bTTaEtSdUqwZGeE7hTY2QHiDjx5jqO/zmQF6LaHKdIjQu0MqCy7QQeuse7+ATa3p7zTdZnf0K5Fhy7IgSMMjj4+MsaD+mvL2Gb+QHN9HG9kNaj6B/QCVV13ntc0jB6hJp36mL+sQdfVflcbG3z3QZqO0gP5Orx9uNcCv20h5++DQZSq3Mmc3mHoe6zHRA3Wd9yhXij+ifbMpboxscW5+Uy+Tr1W/Jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03f81f0-6607-4ff1-b490-08db10f0f6a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:12.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK54ekW2glS0VGjYOwgO1PApe8bWQhhH6AZDfYMBtXpaP1QLrdEVU8rxIhE3/a44CASmOmF6W0gdwN5tgDvuzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: kzNX5W793Bcy83KS8RDpCRbyF6Vogt-g
X-Proofpoint-ORIG-GUID: kzNX5W793Bcy83KS8RDpCRbyF6Vogt-g
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
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/clk-bm1880.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index fad78a22218e..2a19e50fff68 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -949,4 +949,3 @@ module_platform_driver(bm1880_clk_driver);
 
 MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
 MODULE_DESCRIPTION("Clock driver for Bitmain BM1880 SoC");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

