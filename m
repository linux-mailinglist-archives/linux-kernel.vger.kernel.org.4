Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2636A250F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBXX2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBXX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:28:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B946ADCB;
        Fri, 24 Feb 2023 15:28:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEo1lc012052;
        Fri, 24 Feb 2023 15:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ust2a0tRvwOOv71HF5HGsctkYH9lu3wQupB2WsZSSbU=;
 b=ONbhH+NksiV9JD+kCDNJ3ez4hFYBREbVnk+0Xv0YI8LOBohQYpLbrU6hB2KiBmbh8tbn
 8oZlRL/jPUsTKdVRLrWp9oBBipiEzI8F5iPkPbMh8+EpiFl5KnX+37UEhE7mnWv4jobe
 n3gz37SfrvEjcUFz2XKwXn2lKjG7roLRAWYBwAwGxEmZAmiTgRI99IMXwqxK1S4HZzfH
 JtrEekwcQdkWR1lJQAMJf+0YU8Qvwq/Q7mAlPG9+FkjgoOoeDKhGBzj6OSGuv0iAc5fw
 PQLpufi2MkiGzWMCYJB3zBreVjNPcUsdjg3WiMoC7DOCeWGbvy4H35wNAu0jqHr1Slpt Kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpjad81c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OE1Zsg018074;
        Fri, 24 Feb 2023 15:10:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v94h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYC4qByHSbykGhM/CQD4eR2zsWkKbbdz65WDCzkC+pXaCHNjMPIMvXGeX42pbRtuN7BIui/uURAxyj8C5RciiFyVevbUE4pBREWVg9/4PuMT4xblcDzpshO+grhUqEzx9dTIC5FGlvX+9Me6DFiIf9+H1DbdMhHj9UegyONVmFayb+X0/2XciNqyZLWavj6gkQgz2z1IXzQVdpw90DcFCayNgmopeD0TcAqpwPwDSll04hr6nDYuClIfYcBFgAyG7v+sgOMmprx8X7/0tzmbFu8xOuvgsUjB8EZP2Kovpx8mRqo6QSaBQ054F2hkU7zIaH+LCYWlVOrk27enV7wfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ust2a0tRvwOOv71HF5HGsctkYH9lu3wQupB2WsZSSbU=;
 b=CJJuVCxI2IgNng/+hGNK7bGL823CDyA89FhrgkQ8/Ar460d5b97s7l51rZsgjWyrONbu6+MMRBen/G5SCD4PtdUlvFwj3Jm7QDDs3rSKthQxz0bKQ3KiWt2+NgE4WrXTbGynaMSQuIRbg2P/uxa4Qp1oK/q3DzPEO959w7MufDh6mowPeHTGKX47p2g1OhUquZENOCwFhwMic27JaBY/J7syAPQvgEJsWp9J8nUEL3BuJlRdNAN80mLOY+x2hKVGG/y2RYlrJwI57MGSC6aqRtqwWFTtLhE+rwqAffeqnojke3fFuWtGcO4jgmIqCdWzjeViqBhONS6ROWPY70mi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ust2a0tRvwOOv71HF5HGsctkYH9lu3wQupB2WsZSSbU=;
 b=I7+yRhK7iNBfdwpDWaojrMXpAwxc0uHkm4RNRSgq33FLK/DfKcfdwXMgGvmiHS21Mg2JRK3NLl5pAaL/3deVhKQK7GTfEAkVunWZ09vJH14qdzTyAsK6upZkQxVZQld3uq6bxkYbNzTztj96dgm4tkuZAdaJvzYvnpQN1DY9BIU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:10:00 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:10:00 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lee Jones <lee@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 21/27] mfd: bcm2835-pm: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:05 +0000
Message-Id: <20230224150811.80316-22-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0251.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::22) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: bae8c32d-18b7-45fd-a307-08db167932fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhYoz6jPne4vvUEvJOd7X97mYPZYJX0W6Xyp+Lwmkhm2X5/2+ZIx4qB/EEvQsY0EieiLEM5AtytNx3jCQUL4UK82ILPYc2RZuP+9772r4hsPIoHBSX7ZqKZ5+Jq7z6+hTfdvWZBoC7y9FoHBECUDsOVWFOtsgpPhiB+0JZSYueb45+KOvz3Jdpf/BNK4NIJn7gpIEkm6sDD2Q4Iaco+vqlCNtIqYpEFZU62j2b3gywTeAoNfhzmjt0ST9RO6SZbr0rCZ0CkGmvuibyUoqjTPryBDWdd8tIkj9YrvlNpaE//ghUVxYsylPL4BURsSthgMkrFJ0sqLMpEIpR6lupjR6WUomPuOyGrWpIC9/1+BtDh5oBpaTReJ8nKmCNiCiREo3lQsPk766E1vQxLpZSQA5e+5btmodlHP5goy7xmh9lhd0vxx3g0yJt29VFN4XGqeVeuqrVEe6EE4VEtmMiMgv6cMNI3CkFnZoPeVcZxww3cX8VeHVwjh4D8jtumIascjjOONRAivWP+lSXiwyovv1GDjdNurkwfh/F3ouLuQGwWRgof82nZr3Bwt6TJny8NAf33pyUcj64f7euYJzYG8sQUWXuIJAa1FMx1uKjDm06h+LRLm/Y13D3pTvE6iGwgskXAvxEjPim+F71pb06lHzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(7416002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8VcUB9MEShpHkDB4i1eI0WHcMykOQfQcNI3ks0S5e4fD0OeOGhwqzF8u2eyc?=
 =?us-ascii?Q?A7py9h+PaHWH63CkGuSJFry3A2h669YVhf/edUiFAyn2ky9rgC4uNxK0BB8K?=
 =?us-ascii?Q?5QThV+E8b3zfY6qX6hRwuawy0kvdoabNgDGpRwB+11P7ljaYvJTrVXodeSQh?=
 =?us-ascii?Q?Wdrg7xQxk3lAfxZt0Ec5Fyam9QNk4LxNZqS7RbrMGx+oUnE5iVJG5syOhqdI?=
 =?us-ascii?Q?SPHqgpuD3ey+eNfBu68UXqV0zbsGkulB9mBOTahHQ2ovJ7RyBzQAB9OJmoBi?=
 =?us-ascii?Q?0u2e/oYh2pZY++SuxuF35isLDrCAh0OzFlEFpd4s5JvBGcRpmJB52fQc67eu?=
 =?us-ascii?Q?nb9nDpNh1gYuI3mpxsy9mecHMikoF+EYjLYNNK7KsZsioGVeeVMcMZoEoFP7?=
 =?us-ascii?Q?5yVrPZhxOBmYxs8aVYXVqdIeL7moRHCgIU7l7QiyByQb5BdSQS2ixhaFfOAK?=
 =?us-ascii?Q?jV9GsLw9VlCEpDTUFGTuMjuq4BJGJxiEvcL6JkjGuokjeicwfJYZ75BkboBG?=
 =?us-ascii?Q?l+pjbE1SGN0HQPb61BtVQ/Q2DAxZfxxKMpXdLwryp79L8TkHyo3Kx/L0dnph?=
 =?us-ascii?Q?D+pWB7b4gRqhc2OcQtQ51vvvQzT3uOd/LSJ8Ciy/JgI/6xUUmSjQ/xlGcE1U?=
 =?us-ascii?Q?Fd6KPwn9FsTAR554UpRKfVLs5ms/TFBD3yX+srILepZhdmvkoWl5UMy4ejvi?=
 =?us-ascii?Q?8xjE37IB0l8y7anYJWP0DsLeCO1aXo9h8z/eIGQm30FXS5R3h4kLVKbOaAPA?=
 =?us-ascii?Q?NTAXza3HbH19G2XZr+ZAdi0/ueK5hiGPJXdW6X7yGHWCT8RjMBKlt0/AxMq8?=
 =?us-ascii?Q?y4nv4SyyaHvNN9MAYjsk9rp59B2CeM6Za2TI0uuQawVe0zNGc9P8z3EvD280?=
 =?us-ascii?Q?7c1xk1PUuoYDPj0+zN8avnly4xAuoCiG37XG5eYTyxmwhUIv9ME0G1iwqkiS?=
 =?us-ascii?Q?g80hHVmczB+lgsvA6EZwO8Nmg8WVUhUOswxJGoXPAD0MQ9oAQSausdtUJKOW?=
 =?us-ascii?Q?oR1hKomsEvYgANIf5l26WjpW+2i5O6wIiZLh3LjI+HDsn5/lTOQ8Rknsobj+?=
 =?us-ascii?Q?tm5KLckSbrDFqNEY6Espa5ln9kg9lbmwnZz78Yp32W7g/Gc6weFvfUlx8n08?=
 =?us-ascii?Q?V8vvlns4dkOtMLX7SGp4jsb94fr6XJwr4ATYABQNpQ+h3MxGmdM4DDs9Affo?=
 =?us-ascii?Q?ihx4LabTSKtqKKap/vrwNrL8fR5ZYU0dUPNkNmM7brcb0d80VD1IrV9ALT4P?=
 =?us-ascii?Q?Au6yefJpq5Mcxen+gsqgq9UOUold0IjB18JmJANEE1yWNR60j87REimit3pn?=
 =?us-ascii?Q?SfSMUiS4lCx+zaMYZBhhxWkJUKB+KJw9/LlW4rExByC7/TOoxKNbzbDRd+2z?=
 =?us-ascii?Q?ehBB2cMQmbVdxYHrw7Uq+wEskzTYr1Q/eG/nCFdL7+is/LCGouTTRCXRy6yb?=
 =?us-ascii?Q?RcZJi5cr0UlvGwbA/ybOFfR/Jk3XYO+oFXH70Ulv4kq3TulZZEBLHqaWehbr?=
 =?us-ascii?Q?s3NAC4XctWSIt9j4UXi/LO2q1XAWJkCfin8iA3hAQzfXcwXWcc1nLgBZ2r35?=
 =?us-ascii?Q?nvwxERvqsDh0zaZjVZe2yfgL9qs26jy0RtREFIadVy4e5GrdM3QpegPz1xxq?=
 =?us-ascii?Q?48Z30rrwzH+7LzjSQWWsAJE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RuV6geNbDCoBA52GoyLFJpFwC4AWnRpxCU5NOPcuRcDpIVu+rB3ewUTElUO1?=
 =?us-ascii?Q?I5lLWiZhBqcBdZ2HIrgMI0jJ1ulQFc0aCZobNfQso3fvdF606a2OHudvDb1W?=
 =?us-ascii?Q?IPLZZLJOEJ6CG31SwL+iQPP1o5fSMWW9t9JbiQPM+GgvgHn5hL1o3LRQuuh+?=
 =?us-ascii?Q?41sdWLLEfoTyYMUcgZVEQTAKh3w0LCSAMryoMzrI3sP1rIgY6damswpwQYN0?=
 =?us-ascii?Q?QuDzDHVqNyWq3gaEM3noAlSNLbYwv4iueNfDjyMPdj99d39ym73bMm3Rf9rv?=
 =?us-ascii?Q?ozm9ZTvXglu8JB6MW7zSNBKEZtxUX8/KoWD5MXbW01Z/fq7TO7zGYIf0dAL7?=
 =?us-ascii?Q?rKLli9wUlwHKxw08jzmZi5oRIk0NzH2ymqVNso6G6f+/rJ8VjUHWTzqUDdSt?=
 =?us-ascii?Q?Thh6p8QNmzD35ehuGbR9WT12Jbr4tU7LkRH/ShAE+88alVEa2hkeXoQ97JnO?=
 =?us-ascii?Q?uCjQeEJURaUe0C3HS7/6iGn8WMjy5uuhFgXI8Enlc0C+8LWMq2G7F6n+UWUM?=
 =?us-ascii?Q?uV6r3tt6+hJWPO22t/ZVjMlapufhWT9pYs7tnt+ochMaPYyUBiRcsQJmRNWA?=
 =?us-ascii?Q?VEPv3sfManHwXA2y0wBzMKLDjjVAzEzcQpsLfGI1IirBwDamiPKSqIWEGTWn?=
 =?us-ascii?Q?CADCKv1cSCEfL20LZeYuthDgUh0fpoqbMyc4Idi5+W8sqYN5x8Er7T0ytTPW?=
 =?us-ascii?Q?2tn3KBXixmFaoFmecOKs/SEDNoe+umlqP2JcRROksB3TXQ5ZCsxxAuF03wkm?=
 =?us-ascii?Q?L5sMTVYxJmRdQoRDQpAdYfNTdadjuXPps98AHPu2oX7u2pLt2geTjuLBlGW8?=
 =?us-ascii?Q?23IL0eqctdgxHwi3jioQaSqVXcT2VXWFh5y7f2W2510Tm6tFrCI/QAWNS32o?=
 =?us-ascii?Q?4h39Ck9RodAdNGEV3bf0oEooQkg0pRrFEeMuSGVx9odyvj0IVHOwQN39E2gk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae8c32d-18b7-45fd-a307-08db167932fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:10:00.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4bsReJdn1URcAUxptxYcSeBPFSNuvGSlZIlAjuSPLMUiWyqSjGClPuU4J+xEhV2BkX9T4Dsc75VAK4skweQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: WeI552mI1FvVikzZ-TXnm7MiFBLHJObl
X-Proofpoint-GUID: WeI552mI1FvVikzZ-TXnm7MiFBLHJObl
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
Cc: Lee Jones <lee@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mfd/bcm2835-pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 49cd1f03884a..2c0aa2a2c893 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -123,4 +123,3 @@ module_platform_driver(bcm2835_pm_driver);
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("Driver for Broadcom BCM2835 PM MFD");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

