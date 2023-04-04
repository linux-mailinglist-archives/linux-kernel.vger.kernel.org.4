Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72F6D6B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjDDSEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjDDSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CA40EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:04:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dwtr9022669;
        Tue, 4 Apr 2023 18:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lEFD23QmTLYYK8yQVsZjvDDMz2M6TsVx+IjtH4pAOEY=;
 b=sgYZZK56Y2qYHhPlF3NLhdqojdmiPL2wgxU9VtwXF1QPRkcqcXl2E801IeKHo7mO5dNB
 ly5tiGxsKts9lIz8BrpIstgV9mq4d9KCVBiOqfFpouBd3p+guKss6L4Dbv32qYQAkxZY
 /XTk/uY1Vx/TtPpQXf2fjmkejhMvmd22N43zx1+ZIEIAFMYW0auQVBTP8HrefKlwotEE
 P3irWBoGw3UY8W9ZwGA7nsXxKN5Dq5XQnNyJ+NA3W4lnn6gK96IskWGiZ3RKunL6YiIa
 AdwYQ6VGF6gGHyuCmj5ByCJRMi4RVdZvJ0O0FvtmqM/d7AHZ0ilhw37h9D3bsH/XpCoU 9g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7txfxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334GWQ0u002275;
        Tue, 4 Apr 2023 18:03:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3hg15s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvpU+MCjWmZJKaOTv7hVzXBOSP51NKvzGd2+QBt5fpbmpWL0nKSaWnCX6ghhvJC29bWW5o0gWfkaBEyBXlSnTXuWsYc1WjTM/EP240lsvZpJGY40qn3whIshOBCUPBNFL1OzrpsqkFza/n/kwFiNsnA/ch7UbPaKhof0sy/xqNwiEYjVbIzqPkA46rc7q3HfE8TjP5H4hqe4pKMXl/Z1Wu6hWEvIjGj7k14/is5LzPvSHvLufDdrpRfzxZrU/zcORyUcOooITMiICovZNd11A8GhJiGIw9/TDASMEhfBDI7jjtmK+jmMGVsHWYf49A0B2tly+iXgIt0t8sXzuHidkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEFD23QmTLYYK8yQVsZjvDDMz2M6TsVx+IjtH4pAOEY=;
 b=HvmSZV3NST0ma0elGMHXfh11N1K5izHv9cl8ZhHS+B5C9Ix22IfN/cYEWxBlpzvxtzjdDeNtAu/UR0C84yDZ6vjN5HfwHXnILsX8D9gfjvzDyw60RaTSSLhaFlGPalQXue1yyGn+P7yM4OtmF4tz+SIiT0sG9W2bGE2fSzUcNxtzn/Wra1J+MRaUBZ0dUXciqz5hB7rSdUFn/dl1Kz+rJCzZBQ6w2pBvJ4+M8z5mANBxDLUYT+LOun4iCd2ICKEU1o/QWuWIpsoNlr2aKCWj7bLZVQQAx4Cssaa5twKOEbqAPY/CFTOz1bYtbTYeywzEDh54wgVDI0jOPKAG2rCbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEFD23QmTLYYK8yQVsZjvDDMz2M6TsVx+IjtH4pAOEY=;
 b=vOx/6AUgtYeTxE6Fo6uZRVP1iuZi1GAj5wNOACunMCRro9p8jG+ScNeVvsomFYUIEuC4Cqdu3GR0rwCh8j+FIUxPixkcNDttXBx64PN4OSs8yjILA71sUHxrrBRzOYkkIRC1T0+myXRBm9iH7U3Q3koUoB7RLMl9AhsioPwWKJI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:03:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%9]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 18:03:46 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v21 1/7] crash: move a few code bits to setup support of crash hotplug
Date:   Tue,  4 Apr 2023 14:03:20 -0400
Message-Id: <20230404180326.6890-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR1P215CA0027.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:201:2::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9fa7d1-aeac-4cb7-c69e-08db3536ef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XQ61bHeZ9c7GlXRgPtWXYTd5CUPwjoS/NxK69vq1dSKKlzvGZpUv/AzJlCq9mYriZTrogmCd2uzCbK7ozO5ap8jrfUBLXpk2K40b+NYRnNmplf8IbpzePyAXiw4Pb0ocjCNsvy9fH5v8V8dwg/I2l2p8LDVdDj3jmhXORHJ+ryX069wIc1mrS5PJOL/qooLh6xwdKp56ubYVcp4gwaH7ewg6gBYhmNwWjh+ZSxqKegHDRQeHJRgt3pOAP+gNJe8RkALJtM/8D7rz4JYRe5N/9LcSvJTZPzoYAaO+GUiWhCMLtqDJ3+pv0X1alqFJfqY8chARrlgcyj40HnGX2Hop4GVJA5GXd2knIDL8OEGrbrQsbkQcnPxp5R6xQCelJvu/Nt1Bt3u27h8/JxQvb1osWa4NoNXq1SNFlgYDZn7xiovBhmYT0qwl478OGTuAP6P5yojqZcodAncTyNyUj+uyrPBqw501TC7NGMOUaGNoDyO625JTXqxZJBIuO/HCJJY/jPBE1FV1kWVMFKQtaQrNXq3A6ZZLgF67knZET/Fc1ZrJKDMvAeQzwJ/Vxw1mrxc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(83380400001)(4326008)(8676002)(66946007)(316002)(66556008)(66476007)(86362001)(2906002)(41300700001)(478600001)(36756003)(38100700002)(2616005)(8936002)(6486002)(5660300002)(6512007)(7416002)(186003)(107886003)(30864003)(6666004)(26005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0pJrG14eyKP/7UOMREY43yAHtxX8at+EA7iDtXpfRfN31o11QY6MZk/l9Uy?=
 =?us-ascii?Q?s5CiXEmshM7V1NDvc0j8C6ZR6yuTlDRip8DAUPsxehZQbgjBkoZAqkSi4bZE?=
 =?us-ascii?Q?NHCqYlUlbOStM58cRUJw9VnMqwTp2EBC9vE/Jlg8ouWPLZyokmbfV/oUmD8F?=
 =?us-ascii?Q?maPTJ8EaK+sbBTKxsP8qXTuswWICTb0DTpEQub67g14hIFPhisJHYhXa/irr?=
 =?us-ascii?Q?wCJF0AhPGUXP9idJGAx1J7ugDtwZzLc7hlex2Pjs3hj4dN+sZ9jVGQMDAVlP?=
 =?us-ascii?Q?y94D242yG+/CrjmSKAShvy5W1+To4NrxQOSzT2XdbRZOuZmpsa3rB/h/vUKX?=
 =?us-ascii?Q?npM0SPr+6cx7Lbkx3eLqcGZmgGfy44q4/P2yJmY2c2i2l9K9ryoz4v+Bmwgl?=
 =?us-ascii?Q?mzsE4kr5Nv/sdsUkht4NmsFjerIKYy0CaUCX0YL5Z7dyzQ+wrxuQVaeopVrS?=
 =?us-ascii?Q?UhlcEyAEPnSpP3KYfF1r1lWf9AZNHbCvRJyMCT9fUR8E1+UmKGqk9Vl9vnYh?=
 =?us-ascii?Q?gLkOXr6IE4vvchfK6rvBFyWn+RA0FuzjxtA69xUR1F+1WJ7Cl+D29STqfMLm?=
 =?us-ascii?Q?iQ0DaW/CwE94df3ko+wSA2jk9gtwD6Pt9h6Aiu35HfFU+rRtmBdModJVnfVc?=
 =?us-ascii?Q?fyQf8bHrHSwH8YP6EHGVSlKCMjeqx86SM7BasusVZ/fyGcLUr8HdPPEg9ifn?=
 =?us-ascii?Q?ffOqqpjoGuLOl79w0MEW9KKik7YZffiCsjUTosOTL0pQihhplaDbWwhJUXD3?=
 =?us-ascii?Q?BwtBoZY9GwXdU7YZtD9ujMFurgB5omyyjy3Olfwb5sHnFe1ZnEVfS742cx0L?=
 =?us-ascii?Q?LTKcSYXu6LFqvz4Z5jgLzBdMCH5VwVqnvsr5Ud9MKY6Jz3Nw9yAz7g44fQnf?=
 =?us-ascii?Q?iwo42DjUFqrraFt9FsBD7ZY+77Lck9PqA+od95BypMXxYKao3g+0pCizOB94?=
 =?us-ascii?Q?p/9tqX3ykG9Kwiw0IzRnwqEZex8KProvT+mTWK9n2nfM8abTuXJfHZiesy9r?=
 =?us-ascii?Q?tN3QcAeP2GMrV0oN5rmZA18uKeB0pYHvLywdRC6ZPVS5T+pyXmitPGoC9uSO?=
 =?us-ascii?Q?qxebtT41KkoxiXBllcRDBtJOMAo+ic/rIAG67ONZMHFG3NYRrnm7b3fWM5pW?=
 =?us-ascii?Q?XYCnf+wWFOkMCgbnMESl1CKmJBX6s+X6Hn52wsnnZI2JGefPsNnq4hz2TxIk?=
 =?us-ascii?Q?Oc6BD/EEsuWjmlCFBqFPrjzfeRaPv/1+UB6DgWcAaFzGh97FcxD22+/yOZHk?=
 =?us-ascii?Q?Z8Q0qxHUxTRtkllIg70SxVZzaCoXHAgjx2cY5CsoSDfgt80Y3mAY1wbjKRaj?=
 =?us-ascii?Q?VtENibSITlNvyotD4UpCEFLLM9CF+6Kdu9JsVON5uKFFId6V4UN9zNICXZG/?=
 =?us-ascii?Q?HuIS9Ie/xsjvbzdOD1RaTRguU2DsmQyggo4ODGFyWVKthCfmafgTFm3LckH5?=
 =?us-ascii?Q?dNVaEWHI3Nhp7c7qXFijotR30cSRMLiKe4wOiuM45+KbsdmEYf+OpGQeAX/4?=
 =?us-ascii?Q?gjKVbzDoyPU2lZI5Zf9erzTluBT98x74UP0jCSc603pFxVB1frYGEmFtpmT6?=
 =?us-ascii?Q?TPkA/1wdK/uZoGQaWLKsNqXj0US5hS7o0/jqWv+9eARuT5F0pbaxzHJTOqHZ?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/mHAN4Mfnp/u1qQRFHC5WTWOOU0NvQ7Z8j3AEXgvBiWU+ApKXxLh96emyqwn?=
 =?us-ascii?Q?gCA4Yg++kKgS1w9fQgzDX4eCdLF6fjrayhHm+emKWTb8VHw3uA/4gA4AaY1Y?=
 =?us-ascii?Q?kmLcCc4SCfbXU6e5tZ1eU61shi2qqth0MF1sBVlodCK6cNgj/w0a9zSJNsVF?=
 =?us-ascii?Q?D4xnzwfo/nGo1efoy/yHgTvQDBpiBhPhfY5i5mpY5jZa5WxMa0wbl6Ez/KTD?=
 =?us-ascii?Q?PKS4bYRkc45oCq/B9sf17R47BF7lvbLNAXxutYwUvHooCRY1GMbHy6GinE1H?=
 =?us-ascii?Q?Ae2Q2KA3z6SXV1TiUwkjf9XVrQckhCk72QP/8nhJVzi3GDy9lcP2HhFVUVXO?=
 =?us-ascii?Q?pNx7vZvQ19vWQgex8eR50rRjAElMxeDdRqIBErp32zgLx6XaShkYSBvffEb/?=
 =?us-ascii?Q?l92cj5pHTypF6irmA/5m/yYGhpcWlXcukVKigBZZwtw1mJwaqqRGZAP6yXhV?=
 =?us-ascii?Q?ue6xpPa0JY9VeVI3uVeuXtXYBB341DFOKE3bcwdeQnQzxQ+pQBPKyJLVTdz3?=
 =?us-ascii?Q?2lpIpcUwVT0A8TWvTI4jE0v6W5m4JtsTUt0aSPpEpUDxZd8FQaKutCXsNAp7?=
 =?us-ascii?Q?K9Bs/mghOiRX2zkote6a+1I1Cq9nuIHBNQc5BUBVUy1psopesdfx1z7sCGTM?=
 =?us-ascii?Q?O6TToJx3kZ81cirMQmh8zvGWkOOeL2x5cNfyLRamr91OoBbUMKL1oj1lb3/+?=
 =?us-ascii?Q?v9+4B/zeOD1Hl72zhbDYVun87DrXtswNSnyGXv1wFwOgClAthZfqrti+31aG?=
 =?us-ascii?Q?7P6my7Drkp59jPA08qug9/bA3ah2AJ0ER/Q9xtXBkwy7N/LrhDPrKmmRSdSv?=
 =?us-ascii?Q?wf6BwGxDIL5icwHtFFmL5p1TQ+at/Hxe9hjY0MUHyI6X7PtNP2R+S1th1ZWe?=
 =?us-ascii?Q?83l3XjqusBYlTZ3gHpABQiPBq028VpdHA8d/g6dVzoxMq8E++7ddetxw93cL?=
 =?us-ascii?Q?74j/MmUJPDshvAoWOA1U+s+4f9mW6febZeli0d3glFxE7GKd1u2iqrcqYcDw?=
 =?us-ascii?Q?PClCyJQZAUE5FI00r0CjkLl6LP6hq4LMNf/PTz93SKv9JzBrfyAHuau+2Yfa?=
 =?us-ascii?Q?0ZUuOy/FaRuxguIhX5Y2S3IOfh4kmjE7Z9saQ0m4/Bqvj6HZ0O/sTiEKCkOT?=
 =?us-ascii?Q?YMQ0T0XBwN6F8rTs37CDXrGFZGGQ6RfkUDX1tFpIcWda1YLvyWLipcs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9fa7d1-aeac-4cb7-c69e-08db3536ef2d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:03:46.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dt0vK0xCQdveCYQt2cxxWr4ntDb2HaRusoyKGKKUp92nPehTguNvM+XjnsmBGTyj9eifWXjUJ8EwnnG39LkPfIx67qV1xg2qLGbLtP1IGt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Proofpoint-ORIG-GUID: F4uBQtCyztpptcYvNnLBd05mZihhWnzT
X-Proofpoint-GUID: F4uBQtCyztpptcYvNnLBd05mZihhWnzT
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6883c5922701..61443f8395f7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -238,21 +253,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 755f5f08ab38..45d241aebe3d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..0b560064579e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1138,184 +1138,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

