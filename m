Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB86A59A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjB1NCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjB1NCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:02:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1040A30186;
        Tue, 28 Feb 2023 05:02:43 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6D8uI027473;
        Tue, 28 Feb 2023 13:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=WprWU7KQOKxrj0dRw2rDjqqChIUL9H+xdlK4PoUkXbs=;
 b=EFaNL/eueqr61AFLeuHdO5hq3m8riWAnAG4BVPb5srr+/B632SJ9T1DlD27C4aVACX70
 InC760qhKUogebwhRl5TUzyrBIvTPJ1+33mKT5X8aAbnC0hgSU0pSHn0Pa8toyI5d3Wh
 wrHQmxxs6mN09gYFOQ4OEz2muYxKAMU3VCvhnDg3P00dSUi6HGlPoJEvudQn2GtQgxCv
 RKpKrfZBQJ5wEmTBX2fto4GKBm/+DzPCSEhZF2/IAiOa1el2detOJnfe3S2gkRwOmOxe
 BuxxVs8dD42Nez92VPDOat4h/HQ6FFf04WzMKlcz4SkwV4vqVF4kbYVd/TuL8VjmJyUP zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9ae360-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBmTSe016044;
        Tue, 28 Feb 2023 13:02:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s71mj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNzN8SkjMfaBap8iiwYaKbsxFe4VUGs4qNmgTiMtnQaJf48oHRzyRkVknT+aEJwPkNvUCKlqse5eG+KWnSQmkkLkI/Vu9P3t6xNS4AMCfeFguDGyYf7yHWVk+TlIQZTfOAI63Ix+qC68JwoHaE6hPA5FMgPcDNoqlPidx1c5jmUnmKPICRmsLTBTuB7AL2P2e/ycHDmvsZ18+wHnw+/Ia+8NuLng5srEwTdlC1eSySTCSIdM8kvOGZgCT9EjI9ZVTcZk73fyoAXAtZKh9vDqYzxvIn74Y57YCqHjM6mTwDE/k+RaMgpSnW6dF+LMwmXnWq17eUGv2jaZ5k0HRBftyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WprWU7KQOKxrj0dRw2rDjqqChIUL9H+xdlK4PoUkXbs=;
 b=HrrI+gqXe5xIwEzUJmUz6Xgl851K5ZhBTWA7iCwjGv1P2eL4XLrU71MTmEHPkOFHZIRNrOViyw0lSJmlOvkN3nihZKQyMwCVoXCwWEDX0HtKIZnO1Q8NCYAJmQ2MFYJii/WvnkXFLutrOJ2tVKVC8bm7GiMm7NWqri1VcnjO5LW+0hwr4AerhQ9pqYjWJhRIZpCEb8Up3lIOSLK9hB9fnf7zFIUcpCa1CcBRYhOnXT267OMgd8c1URBnXwVntYBTwoZDIC6s4kfOGqqJfXkEy1kZpiw4u7UYICmdoTS3EU8C+TUuflfqhYE5JUXq8qrREN5qZFUPPDgVj+w0TbLkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WprWU7KQOKxrj0dRw2rDjqqChIUL9H+xdlK4PoUkXbs=;
 b=cNm0GV3xiRJueVCgXkEqIEMbga6VK7uZyRaQfWIqWdd5bSjPIENhoDYyDTHFsgsLoj5JdxflAbpVInwNvyqYZnlQcFERGZQlnQclxIGgs4qaRo6fEEJGzOKSasWVe5ge0jXu9GsL3i7YgOsh5FYOeq7//4fSUG3YJqY9h+3hpBY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 02/20] pinctrl: amd: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:01:57 +0000
Message-Id: <20230228130215.289081-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6af093-28c3-4172-76ff-08db198c0e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuL+Y/H6K0hO1MfrueOcAQWqwnLwA6z81JMdcuJ/lCLWOtdO6DU4AQo/WSSWdRWIghZ41YlWLOGwpABO+xwfrVl8OcCfZbi1pbl9giPuDHLYLXiHNSKYwLpRDqkRRHEmTuEt06+INqY/2i4uDgSEuKG6IPWH9XIZgH8B7GtDXxojc3FiGSuOHBAQxrCrfklumaZA0Zk2hPoe9Ez5iZBcidZRYBsk8SE10Djei+QfH4rsPAHM6sLVMtSD6RDFUXaDhZ10AudalXWqlFhmmM9iMOTzunN22lbPLxFmja4ROwhOnEwT67XQgxOQN4XfhndPdlI3NmRBuPEdhKWFGP/EARWWlzG84Ks8Ur1axQr1MlIgXZOqJ+ZGLARYysf4DVqVbOQdZ94GoJ1lImZ3sakwunyLNyPwuoizlK+x6Moe6UVmE1RDFE52YIthQBYK0xdifQ+E5JoZknashSf0SkBagR51xcDuwHqLHVGVANrJdYZg1ig12lx34mOnNZJDyN4A8tLaGDIR52HI+5FwXVkNpg7YXE3ULwmTtrUSB1iHI0Kyb466x3jzd06N7a5VyKYtzr+Z4l08uzJH5RSrAsyuF/pa9CEtN6K4P5FiOfIid4x7l6fSmBtrePRLFcikIH8xVXdqH6+KTTep0eE7tbM1rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bG2KiEpp+tFdOAIrWh+PjgRhXW3bw4cHxD9FJMz3ktOwIlNqJHDsXJvynzl+?=
 =?us-ascii?Q?qyZaLri4mJodw+XhU2ttqa794Ee2IF9s+QPYffSO08bfNGInd2lXzgV8Mefh?=
 =?us-ascii?Q?xiFce0ocr98Kr0W1IgFdOLlWr8e2x0ZKdgJSAdQKWlv5f8bpDNo33O8G5pyz?=
 =?us-ascii?Q?5rPzC8p7DKLyD4AaAnTx6AooXvvy9IFB2Ps/unBp5518XZOTFL9CwZW4IbQ1?=
 =?us-ascii?Q?qkkv8IKK0pGhGYDfS2hSDJU2qyP4Yh1vK7o/NnbPlo/ESoavPVL1XvFGK31L?=
 =?us-ascii?Q?MrrajsUiTXfU8IFfKX/R8DI/MtQdH3GKD2hh6cvyrnEFXl9uKR77yu1P6ziy?=
 =?us-ascii?Q?r2lE45VzmgRo3MBjxkyDT98iPA54BrAQpTS82F7Sc6Vv7LFCmvSWWRc9CqGP?=
 =?us-ascii?Q?nTOBytedZABAX0F5oBNn+i7M6GuNDGLGKtvUI3biGnP0TdO/GzGTmWUwcxa5?=
 =?us-ascii?Q?9OlDqvTgrbqvNtVP0xbbk13TMdfgFw1tCCpa4LFzkXgYLiaukZ5NT8+xTfZQ?=
 =?us-ascii?Q?bgiSX05HVWZusqQ68nWD5174cwKY/L2RWxf6rDppUXytzo+moGrEz5m8SvSY?=
 =?us-ascii?Q?LrTUPeOCA/GIW+c6et2kWefiDIwSxIB7apql28j+LFnCthEPie6fioOKf8K3?=
 =?us-ascii?Q?QPuGS1LNupJ6QpE979HSugcqeHgS0x1lp2ZY+MUI5rai4flK2Vf1U6NPhdEy?=
 =?us-ascii?Q?XXxBj94T7P6Pbc4jwojOxkVQoi2LlW7oAip/FhtnbagT7MLShpnJpCw9fLRD?=
 =?us-ascii?Q?fOrDAXS/lWARZyCeZbs/whRogVWTNZb+IYxnnLcQ7WfigTMNJoR2hFX4k3Xe?=
 =?us-ascii?Q?fA4LADCBKRD2cqB+Wn8aOcIvEjXOPP+oLdctnnOnuaDXYOkXWpm+lZm2PIg1?=
 =?us-ascii?Q?IoAoX3k0HTlAL15sBkfVRs34essaTZ447XWqTpVncThbYRPma9ZtnXjFNxzC?=
 =?us-ascii?Q?kUi73NWgdREL5Bov0bMUZ/4y0cztnxxF4747LN2b0froU6GB/mMZ2obPrv9E?=
 =?us-ascii?Q?HVwRc8e+IJ7HYdm4gxYIVloEQpj9qud1zDhJvqPOb7M+9GhlO3ynltTE0U8R?=
 =?us-ascii?Q?WlXfuoUk9TF7ganzDTfmHxOWW1nYWe+QTMDMD6rPBlCqhNNZcXQR6RMTaqCi?=
 =?us-ascii?Q?JinARENk7Uep9pvMXfSOrzX8eu5Q+q/YwDeGVsfZ/ujJpnE+MjZx07FQSLBA?=
 =?us-ascii?Q?GWnL3r1yCnQ/Bc4kZcXXERH3l1J8v4WePCpmiCl8ThI97CdJgZnbN76nBLEf?=
 =?us-ascii?Q?zFpFymCROvN4IAc71OoUpEtHc2KyH7CloN+Vj0N+SQjlIeGQvFZbDEOt078D?=
 =?us-ascii?Q?sCYsf/V9uj89hgFnac9ElN+QUkAi1TLp/KgvmG5Vxs3fLn/k77B3TQ046Kp0?=
 =?us-ascii?Q?mNafF+z/BRxgCQtsc5XItXMFY4HTATtPzlIH1l2ToOiQL7cE6EYbDWtLf5ME?=
 =?us-ascii?Q?AX5YedAUHURpLRoYfPVVsw5n+YB3ulWtXIdw2J21VyBwq+AR3gsAF3aq0auC?=
 =?us-ascii?Q?D73B6UAryQasOn505WpV7jOjrvnPKtFsjFlp2fnSHMLhlM2I77GbXfYhw6zZ?=
 =?us-ascii?Q?DMtKG+OO3v2v29Or/fixIkImFld/NZWdhDLAaFpfqc2uaF1dumpGRdglBPsQ?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5T+eyif65pMulg/wsoefhqWsHlGE7amw1EMWIlKoH+rCP2Q1FTb092nRIy31zFE8sexFQbcc1dpYam5j1mozVfhHr+WwP5quPVeFh2zhzOhOFUYyAbxRou/ixjsD/TyETNCtPoSi9MeGJ91wnH5nJxocAeFpwopikq8+EgKxTta1jKbtliQMioyU1vBPv17jZhapIwTRlKtY4whOTwuazKBqH0BWTohKE+Y5IsS3FTRPwSyU/Hlf35Uk0zHbWhrUD+dR3LhGTsteYrIDk2GW8x3c9duNA0cJCpn/TPvW0ERKYFFZYHSrfQkPhsTfZejnaTHtlXacWhjqBU6pAJIIewLNLiMNxeh+tvCpR8aW4fFRcy9P+zI0kp0YX9eCyDdK8vGJXGf46xFMD61BKiVWDilj5At4vBxp87QVp4sVAPtVL/gXy0xK0w4RD09sYYZyibj7sKKB9hhOrssGGK9JtQ+bHWwjLKyhx75scxIWoMm+xoSHvLhxGXwFNoI4K5Kq1WELoKiZx58pOHbZgQph/UQreQBA76zv8a9+2lUuUmwfnRL2w1/+8fwnReuRV9sScpW1B+Y8+R+Yzd2+wi8L1cyrNG53AbUlbbWTzm4sJDEZKIkxxaiQZp2c7ILQ3nIHqYvEYD+ehxiwVmFMJr7+4yDzn3Jc99fa6o1pKgg9gWgHlqU+BVTZIzcdzuGK8CH1BdsveGRasM4zxrKPwJTkHg2yxQSsBYWnnlcU/uC68f+7l3+LivwmWJLYiHMnh0ayCl15+99GnhjC413syki9S53ApgEcyqiCF3PfXts0rNL3yWBUy/jkUZm3ecp7VRvJ1CBluGyrkQs/OcYXM+infPsc/nIE6KuqekomC87VfyaeNQU0yRcJP+YP3J7pWdQw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6af093-28c3-4172-76ff-08db198c0e95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:33.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alQYHv3WBfb7+BMj5FZOjm3r+10zhqWTnvRtmnWmVO4dR9pjjvJ+0glmjDiDn3wsowLpDgqzOOpnzgGxKffrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-GUID: U5GJDhJ5TGiW94zpUmy2kpLZuivOuj-Y
X-Proofpoint-ORIG-GUID: U5GJDhJ5TGiW94zpUmy2kpLZuivOuj-Y
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
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
---
 drivers/pinctrl/pinctrl-amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9bc6e3922e78e..f9928469c1d04 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1205,6 +1205,5 @@ static struct platform_driver amd_gpio_driver = {
 
 module_platform_driver(amd_gpio_driver);
 
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Ken Xue <Ken.Xue@amd.com>, Jeff Wu <Jeff.Wu@amd.com>");
 MODULE_DESCRIPTION("AMD GPIO pinctrl driver");
-- 
2.39.1.268.g9de2f9a303

