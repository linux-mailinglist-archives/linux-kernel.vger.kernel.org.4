Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461B669B18B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBQRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjBQRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:01:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AD6A053;
        Fri, 17 Feb 2023 09:01:06 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7httA012659;
        Fri, 17 Feb 2023 14:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rr1ZGAQU9YiWfGNY0woRgg/KbfJFaA0oDT0/ka1ECGc=;
 b=mSloWBlT8ZxV5HIKnz4XysDbFZIhuZ0/G6VPL5vkGKJQXhu4JBzK8/IjANOFAPH4WgMR
 LrN3gZbLmM61ltlt7MG5fo7P6951J+8L2UcmFwA7Iwkxg1MtPUgdnrPDmt3Tw0JYINgF
 V3eG7r+MhF2vyq4zJlZiOSNgUwtduuWMcwZw3LOFUIk7EPcoTcqkuNZzXjC5edUfz8IM
 n8gqHAeHGbSn3BQZkVFiFLwo0YvKavQ4Ls0a3WPz9cdofLAZdoWro/Z5iMRw+yspDUhk
 yl8HB7q9zp8nAt5bVkzBNHDy/hDId0Kl1kcYn7xyDlTSPGUJFAbTcISt0t54FCuOD93K 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3nw9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCuG7q012132;
        Fri, 17 Feb 2023 14:12:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa50gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWRYTTIzeB7+mBjRkENLBTPqrv1jWIqE9Pn5Tgb33h43hVwZPGKhqjH6xG2A6OonYVTI67ILZvikSxPQX/B18HuBRIAMHGX+yVcTwPIHvtxwDW0xiqm7JcBseHAf+GgJzzZC7hnwjUb5TSpYKthVSAaocDagsWlkwMNvSg2cHeNnLGhKWqjjlkKn1Fz31V+hMWMoZ5qu4/3LxIqQDUsKVOerh1ji3T+01lc5K1+J61Aszza8H2COUIk4jG9d7j9OHnr3wVrDY00RMCaDpepoE2BTDzrArTJN914qcjS3uP/9EXqwBXTxEHKi/ugxU93phI+l/t/ILFZ6rz1gVoO5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr1ZGAQU9YiWfGNY0woRgg/KbfJFaA0oDT0/ka1ECGc=;
 b=ZTBc6mI34IV5FljJ9igVb06vp0K8OU0qKWSGYI+Yk9SVi0R9r+S1upDnEwWcHM9iv+PGnvycgj0EyWFBNyD17lEVRKzkDXKTmTWlsuN4QznYgv7cscd+Q3cQXRhU0E4oaCPsyhPmODVRXMZ9+ZrwBOfUo0uatWVYKV7ipZsNPYyb62+s/ZLP/vG1FYc+aD98byuw2JO3ab1P210sB1R3C4wiI8PgngLZvPhX9Gli13lX3NCC6ibd+8nvF452pZpMYztNKpJkgxHcTYLoOtHvzhTxmohPaMubRVwpv1sDy3FFW63KB15TYrAsGDuMDZuFyOxTTHiZcT78cbU1mtr+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr1ZGAQU9YiWfGNY0woRgg/KbfJFaA0oDT0/ka1ECGc=;
 b=O8u9j3sgW5wmDb1SMhfxVN5Vke1lG0jSzQXPbpGMF5PlX+DSjXUDF6Lt9tUQYtXn71Xi0N+5wLvHhWjq7d/vZmyD+9TzEsmeND2JmUMxxe46F23CVRE7xPK66J4No1+xKzVD51ee/NxDsnQHG5cjuYPTyC3O/QbQxW5IwBeRniE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:12:49 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:49 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH 21/24] kbuild, serial: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:56 +0000
Message-Id: <20230217141059.392471-22-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 8515722b-7e2b-4d73-1593-08db10f10cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTt374ODYZp/yyhviCkHPORK9siI4ou2cG8mjGPsgEpcDnPF7ax7JDVJhK6b/2RF0ObjsnFgwkdBW5jCf4xaGAOQYijdOT/EqUkH1MEm992C+ME9whDPbNjWoz9bSIS+Lebn0W68835f5k30iugT7yzz/lcCtK09JLdBadi8mQnS98d6SwUbU19ffE3C8gq8d1m1mo/oaxJml8ZUcS0mUwRAnAIlJeRnZMlB+QZT52rrHY04JeAjaq3u8AsBgJW1XcvmcL2lfmF3CSWU0PbQM89XYJShGIKeahTtG8meCj4SsdpQLntklBq1BIkmtzCsp4XDXOQSEUJI2RFP8bXE42Du8IFWGNMXMyWvvG3DNylgpyyVdIKWQqK+dzb+Tdhk3uSoDZbwbCsS9Zql2NxQbagNGZ0Jh6frlAa9S7697ZcxVDqxfYRPl6L/kEHpfCWv4nvELgwL6+0+1RLub7EILbt88eY08ygkOEe4edjtHjmFcM0FeJ3bBoujeC1xesIGmEEDcNrLFZTGDc/aIE2FP8eBvrj14cIFNJPTCTDzTOo3wAz03J4kvsNWew7Jt5dje/H3IVMuiuMbBAj2Loln26TF4tz3wJGaTNwzT+7FFGfeGZIlpzIuQYr6biW1S+r/0DtXNO8PgPCNChdLHRsasQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199018)(38100700002)(2906002)(36756003)(6512007)(2616005)(478600001)(186003)(86362001)(1076003)(6506007)(6666004)(6486002)(83380400001)(44832011)(41300700001)(8936002)(6916009)(5660300002)(7416002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NM95f82BvWi9OZCzGzt2/myKSg/xT/S9GvV0XZVlH+OQPSXKyYgPfqApvQJj?=
 =?us-ascii?Q?4hAY9sLbIwvMZk2mmOPT7aZ5276xW/5TR/gs+cNDbQ/5stW7VbbzQQDvDpNZ?=
 =?us-ascii?Q?uVGzglnrtc92bKnXXY11gza6bXkCotGxsA0/CpQnoT5Euz5l1XDn2YO2cm5T?=
 =?us-ascii?Q?J8it91yh7mgLTPSeD+UPgAmjCKh9XDEcclyeBQOgTl9g2Sg8o82DuCxzVa0L?=
 =?us-ascii?Q?BJff3eLii+4y+aaxNcaXlz3yQhxR6ea4i1brEQakuwmk5i2XRtnMhlUYXRNg?=
 =?us-ascii?Q?DYAId9D3PiOBlYl4Dt28ovQy89iLia3+/kNIMIDFV4Ue8UhS23F6YhoBw+Ci?=
 =?us-ascii?Q?92qdxn/fDLJXH/jUoDfEUbErQLk0l4GVgfQN9eTSGR07xIffWemLYdHp6bBd?=
 =?us-ascii?Q?fOWZgfBks0BqNfKrgS6LIUchS/ktuDikq6Z580uzadWw1/K5cMgeM3g/VRCW?=
 =?us-ascii?Q?A1FIj1ft5OL3dRjmOiD5hAR2Fn87H5hZ/KA5d6hmAXU9fEA7vxMpG87XEIbL?=
 =?us-ascii?Q?qgbZm1BxSrFnRms73IZTbJRhGhOmXj07JDZenAsX3Bg8NKjjeKJry6GHaQIy?=
 =?us-ascii?Q?fYLGIP61/id970jPnsrp6gQGe9h9MqPGjtHRueVFMxB+fN3sgBr9YuG0KuxS?=
 =?us-ascii?Q?Ngfro4UjPqKXSiMlW9Oe0rXZPXeOJ9KLxOU7MBPKYg234AeknWbQQKUQYzk3?=
 =?us-ascii?Q?oJzzUlwJuwLS+zx3GjqZI9S0PyPF+O16dKh30qLnt67UZJXg1/BdRcoPDUvr?=
 =?us-ascii?Q?aTR0UhxBx4gssA7UVfqgb03wSIip4Y//7G1LMdbN83Og4C+sdgoReL3X6e55?=
 =?us-ascii?Q?87w2Yo5j9XBq+XEChSV48eOxZzb6QWCbQ5CQpB8XWGcu80Vn9juTLHL6GZJg?=
 =?us-ascii?Q?nFPoAwMcG8QZBmDuDajtlf5ifbatKH21bVbXAp95n6adbloNLhdgvPigIb9R?=
 =?us-ascii?Q?KCjmsMq95MfQF8FBBmPQ+zOY52CtJnVZLk2Yn7KpmJrI1hb1gUUEfdm/GhJj?=
 =?us-ascii?Q?X1SxTIFgwf7TyP7yZ1mou+qNwxvoxr3Ru6wILNzIY2nvtgAJzIHUuFy0A/K7?=
 =?us-ascii?Q?9BBFpTZDnImjoFPnvDySVrFAyTzbH51kRR7lkxOTKIjjd8idE2c9qqRQ6mtK?=
 =?us-ascii?Q?y3lUI5AokMGrnh0LjjcAy+N2LUT6JJIgZ6vXg3PHLvOaUtiv7MYskEu1cTXa?=
 =?us-ascii?Q?Y4RJtgC78ChpbPua0xFRHcKwrwmSO4/X/0Ih1H0KS5iHe9jm9zCRNYWmcbc6?=
 =?us-ascii?Q?rPhxNqU8oHq2RUL6j85rlzQr342jWR3TjKTgCBoqToJKObyYp6ZIDDydLrwl?=
 =?us-ascii?Q?2mMNj7WNbfVa6CSJJit6UYCcO+EJsKf+5RKTvb+smB2mvphEfjMKDDNif3xu?=
 =?us-ascii?Q?ECX1TZvPtI4BM8ScA1fkt+lQRjvmxuIjeb2/EPBDnuip2mZP0uY4+/yBjd4g?=
 =?us-ascii?Q?FBtM8dIHBuvI6xsl9LigXJXiIZC/gHJICEHzGyg4HIk4Rz4OCY7SAXc41FxV?=
 =?us-ascii?Q?7awFB4gwzfk8dL3yToldj9zT0tPbxJ+v8DWtunVQhWnEkXGfarzAN3Y62rj8?=
 =?us-ascii?Q?/lrllTJ3KExmE4GTBZ90pCDus0LkibCIFFVh5hNtntY5jnmbeb/kIsgsUeuP?=
 =?us-ascii?Q?31OXjfjzJ5bPH3zcMRE2KB4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nDR8gEHoh2aA2kQTTi9/qB2TLfjH76BLAOZeN6KDvdKtMCikCbb1guRlXnWf?=
 =?us-ascii?Q?V32lrPTOb+H5ZNF0oZ+FqckImWxp1J55QX3h51cMzgaa7LH2ByxURC/MlEBp?=
 =?us-ascii?Q?giC2pKfWyYVhHoJ9xlxBMKvwa0r82FQy9XpyyYPaKEugcvAoPEchoC28UU4e?=
 =?us-ascii?Q?H9vBBNQUleRdgEazJwo4LfgJ/WVh/EAJXYK9q1XmRHJMiLyhc/aFR7Tk9iW6?=
 =?us-ascii?Q?+iKkL5CXCyAkHrOP8pR7UZjxQ8tSuA2zS6o0j1jq3p/UU9rRbY+WZTq+6aNK?=
 =?us-ascii?Q?F5fVMuOjd5F6wRk8JBcm4dQMCbbl0BNnZEjibEDuSoIF5ljQFFI8gADtP7Et?=
 =?us-ascii?Q?6rr1jdAlvqKf+lCiH8j5PyAVDNFZ+anIokBT8i0u4mtMl2j0Lt2nRQh/gkck?=
 =?us-ascii?Q?LDmsdTgIwgWvPRqzG7VJ3lk0qPFI1/vpQsU9dtbU5xwOhcVI5rExkgNDm5Bo?=
 =?us-ascii?Q?oy7bVVRa9QznmqwGL4ImXWzL7NImboaEFUYQtbUpt+cG8OnjMnzNrOw9Yroj?=
 =?us-ascii?Q?vEEDpDmm9+nO0fY+HkUffqEIOsHo3JaIYlRmOWGljrqgmMjngP6jnOewgf4n?=
 =?us-ascii?Q?zKJ4GlFMKKvcul2CaBt3F+ZWaxjkO+3c49BF7uQKLLkDTaNPow5JgbY1N5Sh?=
 =?us-ascii?Q?FAUQvNgxr31wM949jBs2KHfyde0sVyCjX4HdWQEO/wD65yB1IxKaGFcLyNn9?=
 =?us-ascii?Q?urjFRL9BF+tgBTJeizP0GffaBtjBjqgeF4lKiMdFvJE6zHTMOIiUTP5hdSSt?=
 =?us-ascii?Q?uD+dSa96E55KVNycJBjqloShL0UZqCufYBrfLv9UUlhAGmLcfc1OAXoH/T3K?=
 =?us-ascii?Q?g0sIgKmN2z5xAWF/7x/z04QYl9jFj5+JKqXwyw0yhHTklQd7zSVOedEx8ILO?=
 =?us-ascii?Q?4G9L+wG5XBG4ieni+oOtEAfNX0FlSUGndohHodfH6OdfPOunlTeL7kT9PXzf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8515722b-7e2b-4d73-1593-08db10f10cb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:49.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoNsRLuCmXdevqgb8UNXg+Xy+M145Sd5EzyFPbmvZNlVSszvRrYLz2VItXrCEktzl8blk2izoxr4tawRzfPWpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: 3DPw333sBHacy_T6UDgHWv3YhpRtwaWr
X-Proofpoint-ORIG-GUID: 3DPw333sBHacy_T6UDgHWv3YhpRtwaWr
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-unisoc@lists.infradead.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/rda-uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index be5c842b5ba9..c3b29d124759 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -825,4 +825,3 @@ module_exit(rda_uart_exit);
 
 MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
 MODULE_DESCRIPTION("RDA8810PL serial device driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

