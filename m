Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4336B53CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjCJWF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCJWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56015CBF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:01 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALhsf5029162;
        Fri, 10 Mar 2023 22:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=D6xeXYXIkgxlteVxLTDjwh3tQBqZDQy+RqjxJ93917A=;
 b=yhqVIbD5DXgCu+WPCadaUEu0+Va65xGQTgTGZGGT42e2LcixOp326ZhSwEOsduFlrp/V
 jhEJWKjJUGvOe/iMz2DXG4RwTiJNX3PGy3fM3IfynWIFddIETpF8K/kZW3LS3zMMF05P
 tRYQEOMIduQzgtRl/PTYXu2I67JUdneKNchrCD+TsMB9AL+JC4fdg79gAgnmwUjR49S1
 AlBC9AjtKVaZhzzTh8zt3PR72jSjg5l4sk/bJjksC2Tw/usim1DSnYlGF0eWHNLABj/u
 w8arFurfqGAcgHdwRPS4flSuZ0qEG9dxRhFvmEotHykM5JfRhpxwHu5XKqPA1wzxrcrL cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j6dep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AM0NIW025577;
        Fri, 10 Mar 2023 22:03:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g490exs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0N6O6Rupi8NueTaYK+G6wy370DyS8bPHwG0R8aurk0u2z8ruWZRYVtibArngLw/w7XudcEo721Nx4Ymc+eIjfsGEHEpCJH7sKGHuL1UWakLUqW+IxmGEIadlYmkMTMi04nX4x/U/xRJDCiXRa8gfUTFz4wQdN5e9+CrqILtoxxL0mTZ65kiAuHqn5kRbXtjfpGc3lxohJyc4N0tHl0YAHB1nSvz51QhNu3hXkvO9QBxM3olUYP6LilLxn01bxJO6qPSLqqUvhBhqGVb6uNFnKNl12jowQy6yQCkCKt5zBaqp3SEGQApSBZlqoocQTxWj1llDb6pTMV/2UF3kgYNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6xeXYXIkgxlteVxLTDjwh3tQBqZDQy+RqjxJ93917A=;
 b=MsKbxE1jtg1BycLIedhiJu6On1zpNmqYBoVkqBO3F39sBkQQpcRmez0f4vCnbY1nO5MlEZyOI/0PF0Pgpa2ezhXAmGsst8CNSEEF+KGDaBYKI4Q9sfVlCo6B2QZ1XxoP0uFLmB2KGYZvp1Bg/rEnLfILuknBfmyz3NZEV05ca9iARi3YAEQiAwy2aRjKdMffcvzO8arJ+mTsP1kD8I36oXibqgxwyTHmMHxUZSECXVj7Uf2tdW7L5Q6tHtX31pz1cEepu9qhQv7TLUmOKktyNArBsbonNBIK7/gm65cRujkiqegHglyhbncbDroJOtStVD6IuPFQFoVq8GmYudM27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6xeXYXIkgxlteVxLTDjwh3tQBqZDQy+RqjxJ93917A=;
 b=hGY+CB0gfVAh3MmfQWsRfxJzBoqAUf/Z2qhYcpGgFJUHdcLZ38wll1Cr1wub4kYwVHodwYXOEI9yCrDFbgo9cCdir4fqF2yZXfqiyGkghGskD4uh58Y5wMVJdeM/xhyt88RICCBrRgDSWl66v2Uq9xnesC/AR2LMgffW5Z9fhdQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:38 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:38 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 02/11] kernel: Allow a kernel thread's name to be set in copy_process
Date:   Fri, 10 Mar 2023 16:03:23 -0600
Message-Id: <20230310220332.5309-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:8:57::21) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: b6738802-5315-4901-8d4b-08db21b34d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO8ItI+NDcfNZoevq3BUZBvm0qJ+vF77AGHFSVP/RlGNslzRf/gQf80wuaPbG26snCwq6lc0bhvXChueQam68N4FVNSimUZw683+xYtrsybWGJl7xIK2sfKpz+NBB2xD703IAZYHXeKXIocIvlrMkrCKcL8BVECxCEU+II8Y6/6rd9yn1XAy5gT43tUPyoq3UHBgskUcUXL8YLt1PbmQVLIKlT5C/7326mP+oWs0fAldgxb1gkKW3EwrQsL8c15dixdM3DM7EMHG9zWIDpNMjHRjug1w7/vc+GnN51L+rqmeZqEROAsd6pFeZ+P63m7rVVMfK1O7Agjdg921w7gB5Kf8u+PLQEPkKAJNgoVwdZX/3Z5oTEHlxDbT2LOr0fFgUuB+NsK/547Etxj1x0k+aMV539RxwFANVbP5tPCikfjJvHwrcD33SxR7K/eeSpM7KsdGXDRL3NueWhSe+Dc/m1S4dMzSQ+o3AeYeBlw/3seFOjEJfpQ1jR0ZotfyzFwuCtYDAFxKwDhkNZ4swydr8BausnbbU9T453BECU3jv16oQdMaEw9phE+gad/1t3oKgxjDyRsLPEFXOsBglcHFEmx5f+bIuY+Y/fdpxE/UKEcCmGfwMDnM8nbKnFfUlZZMUj5iHzGHwOrIO9x9qJL6G7xuCjZCf6qyxPtRTzLsQIclfmvoUNZQAm8A0eoMZ6tK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(6486002)(186003)(6512007)(66556008)(6666004)(2616005)(107886003)(1076003)(7416002)(83380400001)(26005)(8676002)(66946007)(4326008)(41300700001)(5660300002)(2906002)(66476007)(8936002)(478600001)(6506007)(86362001)(316002)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhjaqwJHSf4ZkWY5pOsOIKi1ZOeWjQR8WsiAwQMcuwWzUY+5SKraWpu64Njx?=
 =?us-ascii?Q?WKb5Foq486hscqg8QNxG0fjaua3D41Koe1svwhVdOGGEMlrnAVPzZc8bKt1T?=
 =?us-ascii?Q?oo3T9kNclqqd/FuRpj+PF8pt4l6RfmlOwd5mHkRNiUyKmWcvaaVyPxWO+Q9e?=
 =?us-ascii?Q?x01qDSKkuwEcvwJF9JjXuU7Ll6qCzbM7NpsJDrplETJPK4TtFkOC8Q/NYo2/?=
 =?us-ascii?Q?DwIh3jTn6cWU5yovk+lWLZUsAI3pvBGcGk7i4wkQX8gbg764LYJvKjyr9yTQ?=
 =?us-ascii?Q?T16Pb53FlQu4yqTGzYDNDrnCOCneMP2O2HAhIXfSBke3+FFsQ0wfxAmQm26I?=
 =?us-ascii?Q?ggjHPbRdgmFAzfmsppQhqVw/kyBV5fHjZATqtTUvgssGlKMxwLigfVEPEzce?=
 =?us-ascii?Q?ebVsr+n3rSkSKpQ/zddnS8X1HtvE2i+grKk2k6ho869AJoE/TGJgJQQGWbgD?=
 =?us-ascii?Q?lTutKCnk7ExVnjYIGDkV8FfyxOll0OluWwmIcyWm7Jzq9UJqrA307BmMM7jy?=
 =?us-ascii?Q?cbev7rKk6pcVZBq+LD1E9aqewGT/mlTOm4Y0P27kMUMyxOC0j8M7IT3AkRus?=
 =?us-ascii?Q?SWJleINA78YiGaQpHSvJZW0WBiouVh3Pwlq5m6oXh/1xuFvWPl6yjTJekPPt?=
 =?us-ascii?Q?AEaHi2TFpXTmVvdlf+YOtgSnH2IPv9/1T8v7IuAO3uxPQIBkm9Pfjqz0ZwkL?=
 =?us-ascii?Q?c/M26rGjAZEtZJjox1URj6hQXJAjr+NBQRolScumhw3cCB4ypdFUqa3udvW1?=
 =?us-ascii?Q?ADZzPlt84bHCZAom8hOVrt2tD/bMpfbkXWM9rAYektEk/bhmfUN1rg//8RS2?=
 =?us-ascii?Q?KP2/SvjezEc+NGqc045MBT6LTt2KSQgxDAffUhV2TqkzPKRGFDTmcunRQkgP?=
 =?us-ascii?Q?Men6UhmlIjgi579pWXpKDA1Pp9O553tauVjgTQWh7ajY5c0aIpe45/KaLlMV?=
 =?us-ascii?Q?IQTwV+1u6/4aqRm+/aWfSqbbA7RDTpjmxT17Ti8lncNK1gXpdRsduBREvZYJ?=
 =?us-ascii?Q?d79o/uKDg+aoBpQTtvcY8nb26jx6/thPf1A4B2jEzLzzGeCC3PvewE9XfDi5?=
 =?us-ascii?Q?5ChJPtlw/stObk6COMNXxDKQqnODvXCl/6UTToKDppDEPVrNnlvQmhbUiVw9?=
 =?us-ascii?Q?UJ161+UWbb9IxedzNmRk1djpk7wh1slBKVNM2ynb5P4zljbscDlwOFhLLmP9?=
 =?us-ascii?Q?62O/5vetUBEJGXC6UEAbE8ROn6M0fc1H0zVgfmHye7h2BxUhvVMCw3LPZh+N?=
 =?us-ascii?Q?xcCUNzY46C135qSbvY+XfvP8rrAESaLTl2ynYb+JI1YU0th6gHDzCOjEXe2p?=
 =?us-ascii?Q?UI3bXH8x5GEDGv1IVmrNSxZPyYyOCg11a6SzJxytICoGPAtcCL73w88WbyNM?=
 =?us-ascii?Q?XDBiBEaVWALsHrDViJxR9/dWECecR9VXCAkinnFGnIwjNuHRvKrQWyihkTWM?=
 =?us-ascii?Q?iM83uODUcD9kuGQ8GZ4Yc9ZoyDPHoUQloCP+dsKlvS//P96NVUGsohSSDduu?=
 =?us-ascii?Q?HEL+eSteLu845u8HE/zm6XZem4qp4FYXytN6Gvz9xyI4bfT9Bdj3cGXU4ii0?=
 =?us-ascii?Q?MJ8+CjgXDD00IGrsggtd9Zlxmxdb4F4G/3q7b/l1HPo5Ql2oki/BgEf9wyo8?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?65WqZ0v8FURIxBqKSr8wzZzKhGh+JvLAzBZBN/eip6zvhts2DIchDAybQxGe?=
 =?us-ascii?Q?+aVL50rJWzmwTzMZO//vPXlmjRVhcSrfCkplA/B9OMrP7xY1mmFrfMcjiH3D?=
 =?us-ascii?Q?I4qXN58Ja+BZWlDAxGwkcUZMOrnylOKWmq0VwGAhh1Vs9Zj3jo4X6fSXChSR?=
 =?us-ascii?Q?BJ/HFrnqVLKTZEMVtqS/No4Md6r9UR8tga3n55kjRWTivUKxgadRJn5fTVVI?=
 =?us-ascii?Q?SbifC4SVxQurtXQEtfB4bR8GzvqO4ngepH0Ntl61CJzCGMduxbEC9G3ltJ25?=
 =?us-ascii?Q?U1nw0G31dlDOhTrHHNkglgPqbJY9/MIbBuHrh4CbOKUIc+f8uunmjPj5XSSh?=
 =?us-ascii?Q?tU7/dnsK5GXxB5aylAcsNgM8LKqSDXSNr3Qj7B/yVHqzkBKneqZF0egiSm35?=
 =?us-ascii?Q?UVmeGqPVRL1+wtfQD7BqeFDTp9ECugD3lBNZgy2bzImluMKo56g/M9YNiC1o?=
 =?us-ascii?Q?y2Q4yjO0XaAWBx/d6fSDiy/zyjAojEXXhHbCkTv114NfBATVkkGTKL75hbK0?=
 =?us-ascii?Q?qsB/GNFOAlhLfwBX+XLvzWkxgYd5fLVl5aoLa9poaMIjz1e2GJp8uqXUzmHT?=
 =?us-ascii?Q?nY4QSA91k/jV+mXM6pzzJ4hk+R1NF2iw0sm3BAuw0qMoSZOb7a0voXy++wey?=
 =?us-ascii?Q?JCyYcU0bPAYO2zKl7tPRrNMQRMZPkzL4WaYt2Ud/e/g1p2HhZ1uaWy2L5UAK?=
 =?us-ascii?Q?iqnOprsHouBumT9H2Pbyq5rMk7TzUSevnNTsuim6ueTXS8snBQwtZzPE+vlo?=
 =?us-ascii?Q?sWheWpgKGbk/0PS1LX/lHp/agyTaK2GfHD2tc3PpXG0WR8Ip4nTD4RWXDb/L?=
 =?us-ascii?Q?wV4RADsgJh7SiHBNAsU6oEmdlJYRVvwn+QKE8x4rQkQR7R1euAZY+WJ/k+jW?=
 =?us-ascii?Q?FU98b2d/XZOZqQkmTmuy6wU9cByoc/47bepuZaaLbO1Tamv8VPbhixp2nabY?=
 =?us-ascii?Q?O6tYlPfn0xoFNYDc57Bns+pMZOj/hHgQRA82ENaSSIXb8EAGz7H+tt+ckLw+?=
 =?us-ascii?Q?WAiW/FyDX5OUzk1nqguTO0c+tQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6738802-5315-4901-8d4b-08db21b34d4f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:38.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Kyc0E6MLiV54r3ZAxNn/NOoVKzOHy9N13FHgDfyEqyAKX7pskigrFFGQptTMdM0GCSPVbV78OH1Z/08Yyb7Jyd6ROhVx8baFZATFp5vPfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100176
X-Proofpoint-GUID: mioaakJSdvN5s6aooTZxqR2InI6NyU_c
X-Proofpoint-ORIG-GUID: mioaakJSdvN5s6aooTZxqR2InI6NyU_c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows kernel users to pass in the thread name so it can be
set during creation instead of having to use set_task_comm after the
thread is created.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h | 4 +++-
 init/main.c                | 2 +-
 kernel/fork.c              | 7 ++++++-
 kernel/kthread.c           | 3 ++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 357e0068497c..32c9f01af0a6 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -23,6 +23,7 @@ struct kernel_clone_args {
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
+	const char *name;
 	int exit_signal;
 	unsigned long stack;
 	unsigned long stack_size;
@@ -91,7 +92,8 @@ extern void exit_itimers(struct task_struct *);
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
-extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
+extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
+			    unsigned long flags);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..9dc816aa904f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -707,7 +707,7 @@ noinline void __ref rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
+	pid = kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILES);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..cb8f85c88c75 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2109,6 +2109,9 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+	if (args->name)
+		strscpy_pad(p->comm, args->name, sizeof(p->comm));
+
 	p->set_child_tid = (clone_flags & CLONE_CHILD_SETTID) ? args->child_tid : NULL;
 	/*
 	 * Clear TID on mm_release()?
@@ -2727,7 +2730,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 /*
  * Create a kernel thread.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
+		    unsigned long flags)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
@@ -2735,6 +2739,7 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
+		.name		= name,
 		.kthread	= 1,
 	};
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f97fd01a2932..63574cee925e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -396,7 +396,8 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_thread(kthread, create, NULL,
+			    CLONE_FS | CLONE_FILES | SIGCHLD);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
-- 
2.25.1

