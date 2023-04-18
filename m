Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289776E6AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjDRR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjDRR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:27:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C850286B1;
        Tue, 18 Apr 2023 10:27:19 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IExLfm023722;
        Tue, 18 Apr 2023 17:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=QmV9JU2HcdLKT9UGm9qbANTgfnzPtBJMwoa0b9mGlUg=;
 b=vqInxa72jw5XQYX/fQdslUb39pHnDRFJ1T8trtq7o6hrdhEUl0Fnd1VDKj27WT0WCiis
 6Wwb1PIuxgjSzhVNWXo2W2blW7akb4afIpsqasSiK3G07tQkIDw55LXPyrEZi5egC4lz
 ZRL1ynNejUWsZgDdBzoRPstp7JsGO9fomEBzeyWn1cTxW6uw7gByIOUjX6wRu3Kx/6wz
 +eskB+A7dZzkbgyMBlpWJJ1zwiNJL5m3bW+rVsUvRbJ5iBcZlcvjOc5kGBN7y5V4dCZR
 tSVzmC0FlaITuVAKgREbbkk70V8CyCezGGRjmQCnpOeSsQc6YSDeG5r/2u30/1UWtDiQ 7g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc6cj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 17:27:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IGvewg011102;
        Tue, 18 Apr 2023 17:27:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc5c423-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 17:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0XhSH9I79P0Ju/jp79LJVlBKemV7kX+LB+iftB22VT8dx1iVy+nm/rmFol8KkD3bUIEu2i/cxLppK/8Yh4xK+wQ1S2CM26vZqHmQ8SQ+Ax3it0E1yZuHmCtzPvLIJyfBvreR7ThUsUGqL10+QtYqRy/EApMlR2LIrNJVoYtQexf2NnVL1Sd0iCy/MwsYUbmeLfkMrts1bgzo7xUvcHMxh0YSbuxHshBbbqBE8eE0DXdwRxvU3sCUyf3CLVbhd2+IvkogGd2bIW6b+vje71GcEYbl6HMGG+ETnBabY3HLwx1owD2TNRP8OLZmTV6LleS4hJEE6M/v0IIFMD3jjgSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmV9JU2HcdLKT9UGm9qbANTgfnzPtBJMwoa0b9mGlUg=;
 b=dmrMSQ/nfxPFnOca43khIO0eC8TvCR9ZwVO+UfKVIZNaRXJ7KMjSTjzQILxixv6lD1bsYb2RKfm7eGl6rkzgm6hIDDJQt2BCe83QpfEDrKlKU9Mb1rKGgpZiYqidEoKywfClBGlABPkDvfd4Hqf+IZ2iOSBWJdb9VEVcbHIThIuAOmorSSwdvzw8k+pR+kx38j2k5QBTaqHoa5HFTFgTENY2w6WFXYtwneoqz+5O3aZDc7LSdOI7VHZRZkiGvnDQHw5v5cAt3Vwekg/yS3qYP3LzNFRYhlj2SqpStbJi3XFgoswPhQ/a9wvcFmGXjfKVy6v92IJu+065A5BbOUK+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmV9JU2HcdLKT9UGm9qbANTgfnzPtBJMwoa0b9mGlUg=;
 b=xWY2KKsc2tWvuCmbB2CyusoglxKn9cHIDe4sYb9WieqoiuzpEXI9kFDEPaIfY6E1lC8rPmoWgtnRhq9/6zcXwPqRUb9jJ2/kknI9yjvwY81F1xeL1rMRVG7ieTbXo7k3h3g/31TY2IvGS5cEDnujDuWs5X1GkqUiQ1O2KDlEU8E=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 17:27:02 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 17:27:02 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, axboe@kernel.dk,
        jmorris@namei.org, serge@hallyn.com, konrad.wilk@oracle.com,
        joe.jin@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH V3] debugfs: allow access blktrace trace files in lockdown mode
Date:   Tue, 18 Apr 2023 10:26:56 -0700
Message-Id: <20230418172656.33583-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::22) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1271699e-f10b-4af6-d024-08db40321f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3Yx9oqC77r3TsYCgBy5FokO+oV9ZKDT8WVVy5sBoxgqVmitq3yiWZTNpAzoJNqfF8WDxOxPEINcKnf4pt8FrcY00FxHYiAoyoTIQv4JJIpG+9AV6QRIFVSzefMFhWqbTajFCPhyH/kBrk3fg0Xeqmx4dgiAlKzZGIq1wqTJZ/vLsB12ejlYNAgyj/x4SSZ0/c9HUwPT2+8Ca6q8kmUH4zIdlKNp71kZZ1Gl3ccI2Oj85YJjSysHMExJSf2Jg42R709TsnGe8doc8UWDbmIReHYYtfCsnWNu37LZIvCnu/9aYNm2teUHyyFF/FWHbnES51n2R0nKMmiABe/kYHj23OChu7LQTQiAIsjUF2JSWS56tTv92vdT3ZrK15f5DeAYHBFpcBYADjb+R6QjH0wuq7FSI3glZW1Fxb5ei3Zv9+h9nO3IKupHmFXMolcpBVup2TA9lOurPWQeB/b1aA6coELU43gRA/YNNNjGaGnSRTcwoh3Q235WuiEeiX2qiXCxc2+clKTz32RyBULcoUfis6t2LoR1bw1IkBjWVBY7RepV5mJLJ665fyyg2k1SXWi6Gk5m7RcaP5Tr6b8pfxQQxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(2906002)(44832011)(2616005)(478600001)(6666004)(86362001)(966005)(1076003)(6512007)(6506007)(107886003)(6486002)(36756003)(186003)(41300700001)(8936002)(38100700002)(8676002)(66476007)(316002)(66946007)(66556008)(83380400001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kwjkr7EbstKQS9yYlRYuSXa27wYI7BhK88rIKTDFr64AkTMGQlFvANIVi8fA?=
 =?us-ascii?Q?MLWxfLmtZHfJLyhbSV9CaW8taaDZolH0YJCEPYdH5RKBnDh047QsWq1W6VRN?=
 =?us-ascii?Q?vUdEjldxQAweRx3R11Zwv/bxhPcGuIlw3k8noSbrpE1+VyaD0eJgPrjJ4385?=
 =?us-ascii?Q?IlytvR0YBFDq4CaWxlfYd/CW5qoxKIcTIhiKwt1D0K8JT3ClQeV9PPU5ArFr?=
 =?us-ascii?Q?cVUqxkyp4/SaSt5rnFmvZhNMsI4ptvbK1sPte706cPdC8FuD+b0JyGtCHbj1?=
 =?us-ascii?Q?qMFDH93frZu60dE+0X+GzQBC+CMiqCxPLY2/eimWHwZf/5kqVqoBG53o3tcZ?=
 =?us-ascii?Q?LFqQy5pLJQGSc1UOMn8ExiZREESNOdcBi7p8FQhz2UENA39hB5m0k00SrbCs?=
 =?us-ascii?Q?hl7zSOPMRBOkSS/QyXH1lc1v0n5VSY6Z0/d3vuXgdtRUVDX6ILrAcBjFOcqE?=
 =?us-ascii?Q?/6yyde3L5/YnGX9G1OW32GCQU08k+BWlIY+Kr6CXmxFZ27j4ghBJJubMRzc3?=
 =?us-ascii?Q?U6Hc1+lk5E0jSGrIQlht+4N6ywk1f7ZHW9Xx2ujTK9STMu0F/Drd0X/HM0wk?=
 =?us-ascii?Q?mqEjE9sYL5+RtlebVMYP6grnpUmzf2xdxBXzkWDokdJY6lh61NWmVk9eMJJv?=
 =?us-ascii?Q?WWCa97JNPCIT69kv6zwCsURNi3D5iRUL6g62xQyjEBUyEsJnj5LX6flPCkIQ?=
 =?us-ascii?Q?KMJdY7+bXVoPPwdExORZ230YJ4rLIXUzRRf1sxCOvuRkFvPhJMb2AZBBsZy8?=
 =?us-ascii?Q?zShtx5m2uwlWaY+Y4XBNR0rKPAoeqcXomIpVl3sTXD0fGwPIR+Iov5ojGk0Q?=
 =?us-ascii?Q?SyYc3++i18DheuGW5PosvTaTJrldij4PvpSju8AXQ0gw/rsnLscpn7nuJA6+?=
 =?us-ascii?Q?X0EEO3pxasUYt2ZYTOaooDp9+JcFqWfQ/jCVfzuhlnxjmjhJe05fjm6GAWDx?=
 =?us-ascii?Q?vuXFlTqdIH+iE0D3A12H7EASevwJ4emS096XZkJq9U2uQmUurdN1mtQW4uFu?=
 =?us-ascii?Q?RJtnX4z6FddM9jquRkbb5WWUrN0Ux/+2+xHl6/itT4yUCgxflgyc5O8jd9NK?=
 =?us-ascii?Q?QhMQuaD+aX0t5J9gkzL0cgZ+ZLDW9Arz5CIxVBWLUmJJmBBQ0AxT/Pbr7NSy?=
 =?us-ascii?Q?7KJ6aNv4E0LaMb0qosNQosxiMWJNpcaJtvonbYr+SPQaQgg8MqaeaEiQcPYT?=
 =?us-ascii?Q?rSRVDpoqUDvUxkPOvveKCssDeHCPWxZG7HTEFeahh9Gvfm1obYqxOWDzOFnQ?=
 =?us-ascii?Q?jTg/jy9W3+/P6VBNcnYwmcO3Qv+Muf92+1SD1X7nQCjIqMUckzA8fg0LTRNQ?=
 =?us-ascii?Q?w7Kl7iImdBo7JMqF5ZdB1pn3z8E2FD3f3KqKj0MIhP6EwjoBa9sEqG1JhASf?=
 =?us-ascii?Q?KKa1NAW7Q5WG91KnngbdktH65q69ogPvxJJ8OL9nVBWfG06IrS+wjHpa1kgX?=
 =?us-ascii?Q?qPfOUD+UotrDL5uEhrMicKYWV8/LdIrnc6UXoYtr2iCiPjo1lcaRHZndZZm7?=
 =?us-ascii?Q?9AWYmkMkttr+kKs1gABUCBtRUYuPqDYtY0Vbu2uwPTYfF963nyGEScb83knv?=
 =?us-ascii?Q?foKjPP+zsfeJTrZYwfbRKQhzbbEVxXuDsTbnrmtg1D6s9PiHInv5SvR2BSds?=
 =?us-ascii?Q?r1C6qHx/yk2m1Ld+i+tbeAY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c0KueAfCBENnFgiz5lY/Y/nYJFx+oPSFVRapPRPjN8lB5WialYlnA4FnfJPJ/H0d2dPgeMFpS0cfsN4OreXfIi+UpuuAupOcf+a18dZiLDnic3AQo2hAMT22P66XojyqSA13INJZ9lQ4DzjYfAYQLpTcb59PUUXfGlZ3OoGerTs4dxrTMhvK7cCncwRNMOi3y51NOgaoLTg5+aj9nCvaHXyc9pvW0lIQaRfNSYmIwV7Fop5jCgLdCYeNHOsJSXteqWbBU5c1/x3o7ec6Sf4GFwXOUKIvFgjNPXI1EfDmSOHG46khMe+J85AbbIGWUB5DeAFhLgsCjOvJj+mDbJjtQV4tRwmXlDFjW6syUuaJa/gtafpc5WpxfU3q0YxIheW5L/ROFQeB2T8GxRNuppE1ajHP/76yqsrwEwmtvJLxU/gX7UiWjQ8O9jBPC79hRWAMXIsH2LnGtjIUe/JIoFbG7Yo7enjTmomXtdQBrMA4pONsXReP4rPg5pqS3MhYsZCwnZWDF2R8rpfrLoN7k32fqv8kTRKup5QjKp8fHQ5lmvlsAS0qoobRdLywUdad4bNh9Abx/ZDxkiMxV0UQ5ppqtkiDTSBb4JT7YnlYoY0ipWLR3X2Hfy5Ya/zrVibsPxP5nEOC32W7bZqHh9V80dzYDMCArEXuMms9q0Q3Rw6mWZ+ZkUSbfhiYcaq/s0GjoGQDCKifp2E52KDqame5abwVZ4aEqaNjzC0+owNU31qZmsze9CCu+ocsY6nWtTXfrsXhpkHguhOYEBpihpxLGFvJvyg7vpnXcfGPMhtrjnTpdhCSH62RtpFkIG4NdXX56+bRY+4KNtA4sgIwmxj76bhCjqli45rPTfhulLFPz9EpNLbbu9bLmairgimoCltcHIkUJWFGRzfsuwtA82GcxjI63HIE+LGhBAo5G1MwLpBfDGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1271699e-f10b-4af6-d024-08db40321f98
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:27:02.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAX2K4HIRXs2BrB9rXP1BlTMMzKh6D+OuKD9TlOM/GJC84pCtuyj6ProKj0aDzznmO40/hdeM5FAOM32d/0olg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180144
X-Proofpoint-GUID: nyqa9DsxJZAmKxBVjdE_Q0YhGvNJ0BWa
X-Proofpoint-ORIG-GUID: nyqa9DsxJZAmKxBVjdE_Q0YhGvNJ0BWa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blktrace trace files are per-cpu relay files that are used by kernel to
export IO metadata(IO events, type, target disk, offset and len etc.) to
userspace, no data from IO itself will be exported. These trace files have
permission 0400, but mmap is supported, so they are blocked by lockdown.
Skip lockdown for these files to allow blktrace work in lockdown mode.

v3 <- v2:
allow only blktrace trace file instead of relay files
https://lore.kernel.org/lkml/b68c9e1d-71c8-adf9-f7da-1b56a3d4bfbc@oracle.com/T/

v2 <- v1:
Fix build error when CONFIG_RELAY is not defined.
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304121714.6mahd9EW-lkp@intel.com/
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/debugfs/file.c            | 10 ++++++++++
 include/linux/blktrace_api.h |  3 +++
 include/linux/relay.h        |  3 +++
 kernel/relay.c               | 16 ++++++++++++++++
 kernel/trace/blktrace.c      |  7 +++++++
 5 files changed, 39 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..973e38f3e8a1 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/blktrace_api.h>
 
 #include "internal.h"
 
@@ -142,6 +143,12 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
  * can bypass the permissions check.
+ * Exception:
+ * blktrace trace files are per-cpu relay files that are used by kernel to
+ * export IO metadata(IO events, type, target disk, offset and len etc.) to
+ * userspace, no data from IO itself will be exported. These trace files have
+ * permission 0400, but mmap is supported, so they are blocked by lockdown.
+ * Skip lockdown for these files to allow blktrace work in lockdown mode.
  */
 static int debugfs_locked_down(struct inode *inode,
 			       struct file *filp,
@@ -154,6 +161,9 @@ static int debugfs_locked_down(struct inode *inode,
 	    !real_fops->mmap)
 		return 0;
 
+	if (blk_trace_is_tracefile(inode, real_fops))
+		return 0;
+
 	if (security_locked_down(LOCKDOWN_DEBUGFS))
 		return -EPERM;
 
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index cfbda114348c..42db54434d7a 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -78,6 +78,8 @@ extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			   char __user *arg);
 extern int blk_trace_startstop(struct request_queue *q, int start);
 extern int blk_trace_remove(struct request_queue *q);
+extern bool blk_trace_is_tracefile(struct inode *inode,
+				 const struct file_operations *fops);
 
 #else /* !CONFIG_BLK_DEV_IO_TRACE */
 # define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
@@ -89,6 +91,7 @@ extern int blk_trace_remove(struct request_queue *q);
 # define blk_add_trace_msg(q, fmt, ...)			do { } while (0)
 # define blk_add_cgroup_trace_msg(q, cg, fmt, ...)	do { } while (0)
 # define blk_trace_note_message_enabled(q)		(false)
+# define blk_trace_is_tracefile(inode, fops)	(false)
 #endif /* CONFIG_BLK_DEV_IO_TRACE */
 
 #ifdef CONFIG_COMPAT
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 72b876dd5cb8..2346137adc94 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -279,8 +279,11 @@ extern const struct file_operations relay_file_operations;
 
 #ifdef CONFIG_RELAY
 int relay_prepare_cpu(unsigned int cpu);
+extern const struct rchan_callbacks *relay_get_cb(struct inode *inode,
+				 const struct file_operations *fops);
 #else
 #define relay_prepare_cpu     NULL
+#define relay_get_cb(inode, fops)	NULL
 #endif
 
 #endif /* _LINUX_RELAY_H */
diff --git a/kernel/relay.c b/kernel/relay.c
index 9aa70ae53d24..c97ade998311 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1234,6 +1234,22 @@ static ssize_t relay_file_splice_read(struct file *in,
 	return ret;
 }
 
+const struct rchan_callbacks *relay_get_cb(struct inode *inode,
+				 const struct file_operations *fops)
+{
+	struct rchan_buf *buf;
+
+	/* Not a relay file */
+	if (fops != &relay_file_operations)
+		return NULL;
+	buf = (struct rchan_buf *)inode->i_private;
+	if (buf && buf->chan)
+		return buf->chan->cb;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(relay_get_cb);
+
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..67e06a65d552 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -639,6 +639,13 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return 0;
 }
 
+bool blk_trace_is_tracefile(struct inode *inode,
+				 const struct file_operations *fops)
+{
+	return relay_get_cb(inode, fops) == &blk_relay_callbacks;
+}
+EXPORT_SYMBOL_GPL(blk_trace_is_tracefile);
+
 int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    struct block_device *bdev,
 		    char __user *arg)
-- 
2.24.3 (Apple Git-128)

