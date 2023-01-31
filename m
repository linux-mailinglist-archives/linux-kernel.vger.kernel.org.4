Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6810683982
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjAaWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjAaWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593B4741D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIi744004116;
        Tue, 31 Jan 2023 22:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lIasJHV5RY2DlOlVGMTyiteQsaaXBEqgFZ/3hOF+230=;
 b=Brf2dCW0SFch/6vV+hP4wl7ZaLfStjEPqRmKLcy4DOMzXHXv+xZVeUDa7Z00iUaRrT7R
 vui029Y7wpKtGFB6Zw6PrN7Xr8SOYg/YGVeOrHt2pMYiajwY3IAP6vSKPxkCuUx8TkpB
 zfnkZf9smA1dz396m8952kGykMfH/q2pEnQdtLMzE40Zv6q5GbnB2oGseDo4IONWkZjY
 N+jQXuyExesV98jKrhU5pYQNlM/JyK9Xq1q7P6dSike+Ztw+M3maUm9ZEHy41BlOAhlh
 7RZMlfgSCVRSQ9pcgdodeg5O2wGF2WA4o6DehG1RkIvFGLu9ybaeKSdbG2D62tmuf5ku HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhpxrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLKJda031557;
        Tue, 31 Jan 2023 22:43:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d6y3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez42PTiF9xw06UDdrRIjp9+ASkhbSbuNtTFgC7kPJ1oj+E3CjoFlGaPezxDy9q3G1ymI0DmsqY3xGuDdwflmrmHkfsr1x+Bl9ygXO2qv088ptAxaO84pO+nFcfOzwATC49wys/qtQbqEQdSqHL/2j9Np4GxRwuPDB7uDIZgp8XMp71zMcldJBpNL3KNFBCPidpgOoXqb89oeaIvcTUHaxIAj909+Zb3Ra/N9uXGDzCALbDSjyqfMrLh260rBuHTxWATa1njeVpkj5ycAq4wCcUDgtOZwzGKAKeLAQFefS9rnCTscqeJEJH35hS8/0/FiYA6c2/JbgDMVFWfiWgpfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIasJHV5RY2DlOlVGMTyiteQsaaXBEqgFZ/3hOF+230=;
 b=gn12ZdvLN1JhayQmdwC9n1KjuxNYiuCHIKuHSfODCVpUT0CdSiUQcbJblwm2HCcOsQyRjyKxpVE2o/NXMydFvetOkHpUZdnFEWe303Hf9ViZY8gs7XHqj/LNTeyCvfMP9vWKv4KgWD9qx6gLObqQ6DhhBpCkkbKJpemTkO4GhGdKWuFucJAh1h6T59f01pyjSes2QUGr58ZJOCydr+hZJq4JO5dE7e84XPlMZhZpkfMzgqqaHa8A9kOFAu1DVkRWF3JUwOxY39q88lCwWNI6i46ScYQ6wSfQ6QLr/ZVKD7Mwm5f3zdGpIlknnf6z5EyKsB9Arc+SequvSO73KKkruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIasJHV5RY2DlOlVGMTyiteQsaaXBEqgFZ/3hOF+230=;
 b=YWsfejsTGy49MW6uOvPeT7HmtixZCRrUDb5UhaikXlKUAH43NAAZviUhccfMekOLoo6bJOPv34vJJIVbSHB/JaTy5VLJJI+odzg9NIA6V22E2fCT1DKcxVUBQeB00aeB8EJes6rZabvXOka1nXyTsqb53LrmM62naJS9EDFNhVo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:43:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:43:06 +0000
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
Subject: [PATCH v18 7/7] x86/crash: add x86 crash hotplug support
Date:   Tue, 31 Jan 2023 17:42:36 -0500
Message-Id: <20230131224236.122805-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4add91-6223-493f-27c8-08db03dc8495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zCvOtv/xQ0nUyUoutKqHXnGEsJQ9oVySVNwZiOYcehOnrKY02uXL32J59O6RAZwM3XozM/eDMXP0gtqhVnebUSE6XM04pqn5OqqxTkM83ADASKlff1soD+Hl9rZTD74V5tJnzk6MqW90s5QIhcHfUlUahQUE+GfCIqGemJzIzNHxH808yxk4nsDUK7GqLnObfaTm4QfdZhYfDV+/4eIWKW0uQ/rvreB0M6DR5UWTCi+CeKOKBkRGMMeD5wKmsfIPob4o6Wh17Z2OcKfasrVPajkv87Rp3/ZPsFZKUAKLtCSynnhQO9iWfEpmCdnrzpm6TMBOofzEwrX0+9QF54rh5yVYJVdtc8bja6gWUuWTHszAca/GyhlAV3kw5B9x+qSdqEaW0cLRNtnr/5hBq7MDLo6B9KViFRD/jp8PEnVwPC4z094GLUFG8sIYEy+ntynwlPJZ7QF8Zz1ASUlxxX8zQtlHYXkofOPpv+TMZTD0hJH7hX/31hftqJtC0zqGnkUoVx0W1MdbdzS9c46FolSCNkGG4M0bNWjhe01EFA1U/KEhWc4Nep0yO9EzC6aMd5n+gwEUc8g49EP/tf+AoOhmswUFT7LIml54qJZVDCvJVdB4bSBFb6+H8Y6uHxcQewbg40Wubadjaw8pjffkD4lhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(2616005)(316002)(83380400001)(66556008)(41300700001)(8936002)(8676002)(66476007)(4326008)(66946007)(107886003)(6666004)(1076003)(186003)(6506007)(26005)(478600001)(6486002)(86362001)(6512007)(36756003)(2906002)(7416002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BcfyleJgJj3ngckVCF5HYfY3BoIWUGoCSMU4S8F8aBI4avhgo48kHqbAfO0H?=
 =?us-ascii?Q?nq+1WOMBINlh16aaqtvp4BwICXUNdQoiw76/2iDn18EeekX1SWmXN04OdfBX?=
 =?us-ascii?Q?gd1BDmoy7H5Z27vswDC7HKjF6ASWz+FUVkmbKqSfnU1P9Jn+hJ7B03j24KhV?=
 =?us-ascii?Q?xNqm8JrkK9wRt0ZgTDhviAL8PiGIhZUiftO7EzeSaHlb/11n3P2swD10lqEH?=
 =?us-ascii?Q?Ajhrb+KTOTm1vip+NWr0tEKV7wtZC6FcHR2EBqU1QcvnZyUPJ06aOTcebHQZ?=
 =?us-ascii?Q?sUObnw3E/if0//IEDpSFaGZsZpcLvZfEBatGsXvSLEivEQnXP0ZC+GtfKqad?=
 =?us-ascii?Q?y4RXUqFnMClhjO/JiV6D3O8zjocMi/EQDDehkfMGwHo+JoFKeBAOq++ktd3O?=
 =?us-ascii?Q?kQbLpgwnNVyUovaPMsprW9U+zizJNSp3Rq/FOIN91/mHUR7FnDX2UFMHVI2W?=
 =?us-ascii?Q?kz3QViSVStkCbfVkxxnkVVL/W+7rPHstfdvnEmB+csY/kSSCRLa0LiCtsuTg?=
 =?us-ascii?Q?eY7XsKbrFvxOUqNb12X8jArTBMEFP1tAoRes/FvV1yT768vigVM2QB2Kn4+7?=
 =?us-ascii?Q?m9MQiFLM2AEchn5PTOWGFs+zt0aeTDOt+KAIsSo93r1n3Z7ec4mun2Z9u4LP?=
 =?us-ascii?Q?tg8V0DsDRl0hR0dwPtW4Y9uyI6DjvpwBWBAgnjCcBveqciuZnbO/J3hRTam5?=
 =?us-ascii?Q?3WMcM25Fq8g+MVPINXlM0RON25Ri7wj6HyU7wCs9vzkLt0TscyU71V2NLasH?=
 =?us-ascii?Q?NkgkSqIWaJZcQMSNN89TNtrr/CazfPi+i1N0pNLhKMMDYejwe0KKO0UeO4+A?=
 =?us-ascii?Q?+G6xmouzJhGflyBR1xWdiy+YkqevNqAZkhbuzpavs+qHgJqkhsF2SQ/DDru7?=
 =?us-ascii?Q?zcIiOwHu6llSfcRoWAvyRjPMcqoavvWwkAPs3k5UUh6eiN7x75a3PmaGCeOZ?=
 =?us-ascii?Q?dX+HOH/Uo8bgizbZpsDnNp2U/19qimmrlqCI8WOka4hEfNluiZXqjrumedDm?=
 =?us-ascii?Q?nQOSRRQDgLaUPN8/XeJFWC7lwcbHRpVT8+HSXslVHibNj/ZM1ePHBfg6XuMJ?=
 =?us-ascii?Q?fPzLaRCnC4eEjXF9yHR22dFM/UjuOe7MvcehsaTrzrcUF9S8VyY8yvA1ONHS?=
 =?us-ascii?Q?QfTcPMIN2N2HJW28jBljit65CpJBs/VVtsJElm2QnStv6RAuj7OiiWR1UbiM?=
 =?us-ascii?Q?3Xtuzxfa1i2q058+1OgVH7aKG1kDFXmp7SrkrebIcibcOVtozsrOzarloTxM?=
 =?us-ascii?Q?dUpup1x1/dJnMByPX1ZcXpDQmaim9AViQwrFE8PuI7IFTegPVP7NbkWSSBjp?=
 =?us-ascii?Q?RxzRoQjl2pC8vfTNb7K9Rm8r7ed1ALk2bq7kLwcbHZx3Ho7VaELRU/1cW1FG?=
 =?us-ascii?Q?Hx7MUv4O0AbmjHwbi3ArECfrT4mQttHERNjHUkUnwTQr5N/wYHnGWiacAGMM?=
 =?us-ascii?Q?08GuO2slHHdurlDmWISvgfvhg073Lztr1wL8ILYSRbS7E1dDhhcWrgxLeait?=
 =?us-ascii?Q?a3cUHGoH7DruRoq47hbVSWcDC1BIOOLZHmtUpCT5AapAtl8yJYDp6c/kZ3JF?=
 =?us-ascii?Q?iSYkzs24Kt0fw/bz+dNIVMpNUzvs74JvU2URumi4afzclOKZi8/a9SNzoe3P?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Y+vhv5CIBBtZ8Coc9yg6OnNtjfVHex6ADwFvbuMgYy5yMchDgni6O3JTBmN0?=
 =?us-ascii?Q?1CDnYYUiuO0OzIoyxqhszckUttVerqPJ8z5c+3nkExdKugz0W+BWjWnsu+pe?=
 =?us-ascii?Q?pwq7qCGdIHXM51mGJD1YYs0g1aslqFWD/R+GQydVj5TVTbkDFY/NC5MZELBk?=
 =?us-ascii?Q?jJ15zhYfTAbrI3CUwXkQ7m63m46+IKi8z8jPqNMeHGHxeFNNJ8ORB/HDfT++?=
 =?us-ascii?Q?bl4h+cApwjxfvuZl5vE0JQjBv85Ssak7zwJ3BNJl/CrFSdHOt6b1Ovc0wKc/?=
 =?us-ascii?Q?K4IZQgVb3fAerSD21QZMEsB4zdpmqi+xegR2b7hAVh1y+NKzy8dFsc/Q/l4B?=
 =?us-ascii?Q?bGIq9O8nTVfN+uAXihtBIVWy4vs2eA3B1/uoQ1yZV0gNrsS/yB74T+9YscYH?=
 =?us-ascii?Q?4Vm0mONsEzkfZ5a/ZKPTwvPtfpGvb2smAGzztnn57MjrakVF5F6CDhEJM/O7?=
 =?us-ascii?Q?pjcdRGqcpn28sAG3q2RVMjWSDSRVLcEDi5ko76TFjln/VWfGsR8/gcbY1Byc?=
 =?us-ascii?Q?lby1G/Io4Q0TNi60BKcTsMGRu7TlMv72fvdH/cVMs2T/Py9hAxp+2VvIqizT?=
 =?us-ascii?Q?ojy6ietnUKIHrTRvQCFbJs0nFaT0zCEjtLRWNO1vDUJ0Z+QHCLN5bwYRhYV3?=
 =?us-ascii?Q?VQxkpskcOOHMysy3lDFU6FjQaIERMWpSLTWY7nWPNaIT0BtIGzmmyu8HTFKT?=
 =?us-ascii?Q?mM8a+S/F4wxCh1Td6o1lOUNlX0cyvz4RVIJq9rNnhkMV4ST4s/MJxXrbsKST?=
 =?us-ascii?Q?iEDjfF7C2ZbMJSAn5urKkSsY/Ksa3NuQIJ2WzryDEAaD+f3U396xEVDtboLO?=
 =?us-ascii?Q?8P4/gkNwjxSzgXmoamgH2W/G4LV1VhNSmKsIFmZoVTi0WcRH90kgQKsTEURm?=
 =?us-ascii?Q?ZPzZcpPdet0biS8TgRtBr1bHDuFQRDtM/YEt2csOQPn8qnDwq4CdgRy6EV9V?=
 =?us-ascii?Q?3VmZ+dXTCxMhL2IsSs2tpaac/gggQxTS7qgzZSPsABg46ySfUiYP+DL1x1iN?=
 =?us-ascii?Q?CfI5NkbJhLhAjgDZNqkOmobr/N/ujBi+U1zBSxI21o0Bnvid+lRpDKvFbu/T?=
 =?us-ascii?Q?owhwzzUgo1aNbC+FgpGM9a5XVdMqG4RPJ2IgtSf9RZ4BF04ub9vn5SuG5kQK?=
 =?us-ascii?Q?lhENBU4FQFUMODTBCxE6+aoaaNN++XcdTT2Y3PH7/Q2rnJiIZDJ19rw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4add91-6223-493f-27c8-08db03dc8495
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:43:05.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waAUjZsrsrbp6/G9fFhIJ8thYR26Wj9yY6KyAYUhd45mze/3zYtFlXGdXozQXjJ9Q5y5LQWHVQwJWXqHVOzUbcgFZNMvQGhy5RtaYBaddAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310196
X-Proofpoint-ORIG-GUID: EZx_VPE23EtWISVe23gXYqq27SAYFdwX
X-Proofpoint-GUID: EZx_VPE23EtWISVe23gXYqq27SAYFdwX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

The segment containing the elfcorehdr is identified at run-time
in crash_core:handle_hotplug_event(), which works for both the
kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
is generated from the available CPUs and memory into a buffer,
and then installed over the top of the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
only on the kexec_file_load() syscall; for kexec_load() userspace
will need to size the segment similarly.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, and with CONFIG_CRASH_HOTPLUG
enabled, it is necessary to move prepare_elf_headers() and
dependents outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig             |  13 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 122 +++++++++++++++++++++++++++++++++--
 3 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..2ca5e19b8f19 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,19 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 8a9bc9807813..5c9e01fe27f5 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -42,6 +42,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -173,8 +188,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -246,7 +259,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -264,6 +277,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -272,6 +288,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -386,18 +403,45 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long nr_mem_ranges;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &nr_mem_ranges);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		/*
+		 * Ensure the elfcorehdr segment large enough for hotplug changes.
+		 * Start with VMCOREINFO and kernel_map and maximum CPUs.
+		 */
+		unsigned long pnum = 2 + CONFIG_NR_CPUS_DEFAULT;
+
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum += CRASH_MAX_MEMORY_RANGES;
+		else
+			pnum += nr_mem_ranges;
+
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+			kbuf.memsz += sizeof(Elf64_Ehdr);
+
+			image->elfcorehdr_index = image->nr_segments;
+			image->elfcorehdr_index_valid = true;
+
+			/* Mark as usable to crash kernel, else crash kernel fails on boot */
+			image->elf_headers_sz = kbuf.memsz;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+	}
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -410,3 +454,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * The new elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

