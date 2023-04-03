Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A86D3CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDCFX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjDCFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAEC19A8
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332JQ2Rh032355;
        Mon, 3 Apr 2023 05:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=y6zZ9mDcZN70WvS73FRYC3Jj4sqIbQ5VCz5voVO71FY=;
 b=mF8EgTlCdrh+z3baDDcirXzK+T8vxoXi8OG4uobFjv/14NTbnG4VuXI5GdKML3KbANvb
 fUXQBzUzJ5V7Q1TJzCbldLA6wjdRG34ehgm+Y7Z4xJMGWRAr751ArJCet0vEzrw/lXMY
 AHtSVpv/QEvD59sG0MulFvZ9xpn1EnY5Nt68g831tqjurmxywSzM0nT/u0UdwCv7SZ+9
 nDM3DdHiEhktjGLRaIQXgCWksMmMv2hLlJTgUSz0k1CF2JuTMW67u3GQMjWLnK5jYsLA
 LcqV+9Zhrz6gurDGHO3FT5bZ/1P2k2uIfzRqQcelE+rsaoJstVRV4raY3LSwhTxah707 mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5ua4wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332Pl6J014039;
        Mon, 3 Apr 2023 05:22:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3djufx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8i9IE1oLxudNZL44XAt4jy6C1Wds+uh4CIdI4vrJgM+tHJiUFHWrw2imwyIIHDuji4pSep8cBfMNYZnqGJzlD2zT7v9eBS8dxGhubR6ZVrCr7+xF08Sr9nhJNiajrt4N0PFEj/WfLFrjRVPh18HhV4xJNIfJeUbF3WWAsfNtkPP/YMCWSMOmoRW6F/hyU4RNc8EJRFYkMPT48CP66Z2oHcR3UpBB6jFOkeqolJYjqGSHMiYaC7Y4+42q8uzP23X8DDZ1CTelfcezqT+SVSJ2Dh33TfmbPGRPsyrWcVEqA96dbDT1rBnCxb17tj1IBbOuzbdufHbTJYXKfwem6p6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6zZ9mDcZN70WvS73FRYC3Jj4sqIbQ5VCz5voVO71FY=;
 b=aVZqhQHtxeD6RaOb0KujqlOlifdDy5p5FPAOMwqLxbzIc7annysT81IXFOHgY4mb/ZD5EZSt8qf5H5fNDHY+aLaDTJU9RoTVnYhiqhOHjGV72Rcsvnab/gLPOgDP0yjliNcb2Z553+URJRMCZvMfW4VGhitaJJkgYTcK87Ghy9X49rozgZRpmuVRN4PNxlLwADWqMc4JOCY54N77vhsZEEUksB6TjA3p/BxAl/lvbheX5/pxUgL6FHrYp8JPKoK/Fyuo15eSaM8cJKFSN7Kb3Rt6VRUeRgFizh005Et7PzuQb6tu6tDjhfSasJMET2u08pLbkoVDoinaCXRr9szy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6zZ9mDcZN70WvS73FRYC3Jj4sqIbQ5VCz5voVO71FY=;
 b=fe8Tuc7JRjcRtxe/eGF5luUf/IcHgUMpXtNviziumUZJJqYtu4z+sGn2y4VwwstdJJRDO9+lkjPS5R3tu4sm+n8iQb7CM3TfppVSUiwrB9aywF2EDIysp+HbnY5OhL5fb5spupCHpHdHeBIcY8Gc/MuwJeAM/NkLNZ8w7dAjr2E=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB6398.namprd10.prod.outlook.com (2603:10b6:a03:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:24 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 0/9] x86/clear_huge_page: multi-page clearing
Date:   Sun,  2 Apr 2023 22:22:24 -0700
Message-Id: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebacacb-b7df-4886-9268-08db34036862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jebE8Yj18+FEJFwapp/wD5S/iHy4DdhDI1WFsREgzTC20FTOs0ETUmw2nN5CaNstHouJm/ZLenYS/3Cng/IJOHdZlwJstZh6p2Wfbpofe6q6cnef8dcJK9MTlqAnHNlQ6yIu0dxO6CbafvzGUEbiylgJiDRLBixDhQLReowcJEDyPI4IK8D+a1cVkcwrmnOZ2GLfUUegyxyKfWzhRxqb7j7+rG5V/FDYtAnwANwq50v2y3hdZNwdUnakhP6la6BTe354OCYv2gqdu1NNF+ecz2Kx1G9h8+mKKone2nRUDu62PK5hUVKtaRltSxT5Zg0pZe91kzaD774R05mii8y0Y+xYhQld0P6nGuvO93IJZzFOokXlsDcCX1SsHBM0kWpZggeHKXHmj6/LqLKbaUqf6p/jCGX4k4JpYf8KzeVA7i1htW9BktajDhg7K5krJbozdPvhRxrwKR1Rdm1vqWF6gYDW1itLV9NeysTjpfklHzmor9ninpFPMs1EsSdU3+fRhdBzYorduIHDStVsGLjx4clhY8tc06qJAH5otAIXbxFsYJDyV6JDLPG8rJJlT4gceYJ9rPoBkuuyGDh66CGGrXHAT/O0F0JGHB5s8Bb8g4SMvApOYk1v3Oq2rLaTUlqxODl/oIN4txQqqfV+bBgnFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(2906002)(8936002)(38100700002)(41300700001)(7416002)(5660300002)(103116003)(36756003)(86362001)(478600001)(316002)(6486002)(966005)(107886003)(2616005)(1076003)(6512007)(6506007)(26005)(84970400001)(8676002)(4326008)(83380400001)(66476007)(66556008)(66946007)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mof2RPDe2pSxFJ3UFOEA1Q2xASHoAL5mNlAqb04buuNII9XdQyM9ohoQaxFp?=
 =?us-ascii?Q?qoXHHAOwm4Iw+waa5FgoVMss9P4NtTbZhYAM7kSCMjl/pSYzK/oW0pkBdCKd?=
 =?us-ascii?Q?dD6351E061ugbhIUaob6vGsAGiyiTuz8JAFDTyCTKvXBJiSTDbxxjmXYtlGn?=
 =?us-ascii?Q?kZBhS7b5YbKpf40QdTZ5Tl2v2U1X9kPdYli5k13RrVr5OPOT3bwMWEcAFg7H?=
 =?us-ascii?Q?99JzlfHHwIIL312QDbxFV0xzycIza8qsxzSSyLIUSpiJaw9Ph1ESHD7Y0hPF?=
 =?us-ascii?Q?EmSqjzMGQWI/n9Sk57Vq2gsJ9r/EAvsdSeKaRcWB3pLOZIW6z2eS0jczoAza?=
 =?us-ascii?Q?W42gtSKbpUK9xIS3WFttkJCBXxo07XNdUbHoMU/zCQzH9va1zaTmyKQSflqy?=
 =?us-ascii?Q?EWM7xb5c0wHVzxJxtxhNYQbULviQ49mFH+w7ty1tDm/8xBc4WuNF3ElC0eaW?=
 =?us-ascii?Q?eygvuc8I7JfYcEnB4iRx7i7pu9TmrAEvxsfbgwg/dDK8i0TLqYOZTZMOivqm?=
 =?us-ascii?Q?5lLelwkchRVIxdo4/kGlFgtKwhm1O4akokUf2qC2tiAF3ugNEhKa73fgNAbL?=
 =?us-ascii?Q?sj+vfBQntz8ymQbMh9u+O0ztwdFeH3NeENKHe9+X3PDQfxQcArIEANd4tFNT?=
 =?us-ascii?Q?etIWYn4ipm1AFH3KT9w8tzLrIk4V70bcKYyaW/SxRpzI53QNzvVK/QKIkVXb?=
 =?us-ascii?Q?3J7gelhTVa+pfVtp85uyLaAtWAWDS2j8nCO1NguCzzdXOK4Lny4Gu09KJSsp?=
 =?us-ascii?Q?0sk4P/+9P/Cs81/t78aym6Tplyl4wdVSD5G4ifqlz1Xw4ElWzjkzAgVntndm?=
 =?us-ascii?Q?XHmqqUa3E7pwjVX7dOqvQW4tBWeglLmgkJoX8egzWVEJJImK8eRglIXZP8G1?=
 =?us-ascii?Q?R+i8nsl+PlFR/qAbJzO7YHMFGQdwhTX+3EO6OusCuFrJOPDyjNJv+3i1Z38d?=
 =?us-ascii?Q?by51Jgw6D0IOJaMinmqlSprKzBrL4EcjLhzAb870d1FiIxESJ0RaGXtGwRBk?=
 =?us-ascii?Q?rWUnc8ICfyrun3489CU36MfQ/t4EQOH2l7dWOnbqaC86ya5dLG0XySWZkbJD?=
 =?us-ascii?Q?UjSUdbNlTAyE+ohxwYW8oqOoBgihnpnve9+XbKNi0JlzMGBJ7stEXKZNfSB5?=
 =?us-ascii?Q?h843kjpU00HIDvg/PSt7Mhk2/uCTLuh9NHMLhh6typjlO3xHwT5Rg7xXOLRX?=
 =?us-ascii?Q?qtMmcyYAqwcVZglubP/jxF9oe/CEec1LgDODHEErqytDZNYcWCESKgHGM6Xr?=
 =?us-ascii?Q?qXqewmdExIiRUIWxZr/7yPpUqR/9A2VjRKthEk/+UHTChCh7uz8wSAX9PDIN?=
 =?us-ascii?Q?du7mhvdI0lGzEcD5SGiXFtHNM02J1bUDhcgnDSzRaBtijFMfR33pRsMOsX/h?=
 =?us-ascii?Q?N9PnJxwWyeZ0mb0TyIjPRx2WcrZZ/TpN6hEmxYgFzhMH6IyzapLQGdZ7PiXw?=
 =?us-ascii?Q?BaN0W7alMqwwKMIX5m6FcC47p0t6mLBlBWUiM27kUCq8fQpmZtuBXT0axxqJ?=
 =?us-ascii?Q?5347SGlutzF8ofk9g1k0DSo4vch8DpVkHpc/3cC8qTK9Egf0jW5KI3YA0IeY?=
 =?us-ascii?Q?zv2tNKWQ7iln0dxA1p5q0dOS+vNPVU9aAFm9NgN2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ejGk/i769rgE1OpdJSLttoKN0Y7+MNYjA0JDEFWr9uF7UAEWFSqJs4mvTM8H?=
 =?us-ascii?Q?A8kiu2yN/SMsqJZJawGNGvLLMPBFNDJc6f9yYpZSnOQ67rSPyiyw4G9Zofp5?=
 =?us-ascii?Q?kyzrshilw02Q6eWPQR6+zlrLSjg0vlUENMdVSvPkMxT6kn4jQFJIzG+c1ZKb?=
 =?us-ascii?Q?sIufKRhCrM0nhujztTrEkGIhEvNu40tEaKbmPEhmCN7Et8mycrhscWVE+YZw?=
 =?us-ascii?Q?sM1rXtZKQQOF4VrXQHcajNcGoWVX4d/vzYQu2wycHeScnu9sIhe0UXLncfFm?=
 =?us-ascii?Q?QbBOv6IRHA9rVWpE7TGUou90BDRnnyEZ8iPBYKfWmb24iUQf7ibg/+lZ1m4D?=
 =?us-ascii?Q?FjANSC3E4Mt+lIALjMFZ5zaJfKkuOHGp73vYRBrPak34/TIn7hRvIVRsHKSN?=
 =?us-ascii?Q?m+CA+c2cIgGEu627KVxxni80UGdAslSUFyKbF+4MDcPK0/A80D5aYgjZFlW0?=
 =?us-ascii?Q?EkqD9GYi5Qu/7skJbt6pNwoA+GnT5egG21nDD8yzNB+aEJ5MfLCdTPHeK7Cn?=
 =?us-ascii?Q?ZuIs371mDQuqbcBBeBkPNRSG1KmO9HOmff1WH5zV3C7SOkJSIqM2d5FkwUL5?=
 =?us-ascii?Q?exZyHlVweOprLVBJmm53HrIT+nDuABM/fnetuZUAr1FPUA5aZN6CiSwbfKRn?=
 =?us-ascii?Q?UAVenYgOxbc85VqObXLYKweqZBM3cGFklOecMliv/xlo/V/ci+iUzCqcf0rL?=
 =?us-ascii?Q?83ZP5D9JR21iAS7rfeAj/hL553jUmS8bbngQd4JORg5G68xgbQ3ZCR9qWhYm?=
 =?us-ascii?Q?gcJO4E7CuytHwpY8jOpevVQtB68ThX0Gb4Gm2cCS0LOuy1nZn+zPXEFxDK3h?=
 =?us-ascii?Q?6w1pIJFMv+u3dVbBnRZ8y0aGh5LGZZaFwfYfy2RcwtL6Q4AHtXJYkO+8dLtZ?=
 =?us-ascii?Q?22V+jX3imdQlxrTLmdxO8vWQ+O8SJLOLCiJ39DjqK/JFxpav2EKKronmNKdT?=
 =?us-ascii?Q?7Vwlw6miMDdHxI2QoIANLoavY2+EwF0BnvQ5zwnSAuTuRYf+Vfi1cv7o2Yrd?=
 =?us-ascii?Q?9RYOkBzDca9kLP9IJTo+eUbz3yS2hmZJk0oxwEGKgno9ltloL56gqaGVgJ+L?=
 =?us-ascii?Q?qR/BFSDKi2c85WuNwaKxGwCXl9DnqO2eX2/RcfB12KAHjGnAUWlAroD3fPnU?=
 =?us-ascii?Q?rA/75u1AAKaYeCuvLbqWl/E5mWcXo72gAxOOMuq6dQ/ihbHbm+pnkVY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebacacb-b7df-4886-9268-08db34036862
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:24.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTS7we/nHOi/x7atbimNiwvVe2HAwvK4mLUeINX6jNopL0HRzXkt17OA9HO5wIIUIrnMkSKrbDQ02LUOp+tIejlJtWHy6N6YjP0loiP4zFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030039
X-Proofpoint-ORIG-GUID: -TMqwRyxIkhf-Zmg8lWxz7GySq0-Vj11
X-Proofpoint-GUID: -TMqwRyxIkhf-Zmg8lWxz7GySq0-Vj11
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces multi-page clearing for hugepages. 

This is a follow up of some of the ideas discussed at:
  https://lore.kernel.org/lkml/CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com/

On x86 page clearing is typically done via string intructions. These,
unlike a MOV loop, allow us to explicitly advertise the region-size to
the processor, which could serve as a hint to current (and/or
future) uarchs to elide cacheline allocation.

In current generation processors, Milan (and presumably other Zen
variants) use the hint to elide cacheline allocation (for
region-size > LLC-size.)

An additional reason for doing this is that string instructions are typically
microcoded, and clearing in bigger chunks than the current page-at-a-
time logic amortizes some of the cost.

All uarchs tested (Milan, Icelakex, Skylakex) showed improved performance.

There are, however, some problems:

1. extended zeroing periods means there's an increased latency due to
   the now missing preemption points.

   That's handled in patches 7, 8, 9:
     "sched: define TIF_ALLOW_RESCHED"
     "irqentry: define irqentry_exit_allow_resched()"
     "x86/clear_huge_page: make clear_contig_region() preemptible"
   by the context marking itself reschedulable, and rescheduling in
   irqexit context if needed (for PREEMPTION_NONE/_VOLUNTARY.)

2. the current page-at-a-time clearing logic does left-right narrowing
   towards the faulting page which benefits workloads by maintaining
   cache locality for workloads which have a sequential pattern. Clearing
   in large chunks loses that.

   Some (but not all) of that could be ameliorated by something like
   this patch:
   https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/

   But, before doing that I'd like some comments on whether that is
   worth doing for this specific use case?

Rest of the series:
  Patches 1, 2, 3:
    "huge_pages: get rid of process_huge_page()"
    "huge_page: get rid of {clear,copy}_subpage()"
    "huge_page: allow arch override for clear/copy_huge_page()"
  are mechanical and they simplify some of the current clear_huge_page()
  logic.

  Patches 4, 5:
  "x86/clear_page: parameterize clear_page*() to specify length"
  "x86/clear_pages: add clear_pages()"

  add clear_pages() and helpers.

  Patch 6: "mm/clear_huge_page: use multi-page clearing" adds the
  chunked x86 clear_huge_page() implementation.


Performance
==

Demand fault performance gets a decent boost:

  *Icelakex*  mm/clear_huge_page   x86/clear_huge_page   change   
                          (GB/s)                (GB/s)            
                                                                  
  pg-sz=2MB                 8.76                 11.82   +34.93%  
  pg-sz=1GB                 8.99                 12.18   +35.48%  


  *Milan*     mm/clear_huge_page   x86/clear_huge_page   change    
                          (GB/s)                (GB/s)             
                                                                   
  pg-sz=2MB                12.24                 17.54    +43.30%  
  pg-sz=1GB                17.98                 37.24   +107.11%  


vm-scalability/case-anon-w-seq-hugetlb, gains in stime but performs
worse when user space tries to touch those pages:

  *Icelakex*                  mm/clear_huge_page   x86/clear_huge_page   change
  (mem=4GB/task, tasks=128)

  stime                           293.02 +- .49%        239.39 +- .83%   -18.30%
  utime                           440.11 +- .28%        508.74 +- .60%   +15.59%
  wall-clock                        5.96 +- .33%          6.27 +-2.23%   + 5.20%


  *Milan*                     mm/clear_huge_page   x86/clear_huge_page   change
  (mem=1GB/task, tasks=512)

  stime                          490.95 +- 3.55%       466.90 +- 4.79%   - 4.89%
  utime                          276.43 +- 2.85%       311.97 +- 5.15%   +12.85%
  wall-clock                       3.74 +- 6.41%         3.58 +- 7.82%   - 4.27%

Also at:
  github.com/terminus/linux clear-pages.v1

Comments appreciated!

Ankur Arora (9):
  huge_pages: get rid of process_huge_page()
  huge_page: get rid of {clear,copy}_subpage()
  huge_page: allow arch override for clear/copy_huge_page()
  x86/clear_page: parameterize clear_page*() to specify length
  x86/clear_pages: add clear_pages()
  mm/clear_huge_page: use multi-page clearing
  sched: define TIF_ALLOW_RESCHED
  irqentry: define irqentry_exit_allow_resched()
  x86/clear_huge_page: make clear_contig_region() preemptible

 arch/x86/include/asm/page.h        |   6 +
 arch/x86/include/asm/page_32.h     |   6 +
 arch/x86/include/asm/page_64.h     |  25 +++--
 arch/x86/include/asm/thread_info.h |   2 +
 arch/x86/lib/clear_page_64.S       |  45 ++++++--
 arch/x86/mm/hugetlbpage.c          |  59 ++++++++++
 include/linux/sched.h              |  29 +++++
 kernel/entry/common.c              |   8 ++
 kernel/sched/core.c                |  36 +++---
 mm/memory.c                        | 174 +++++++++++++++--------------
 10 files changed, 270 insertions(+), 120 deletions(-)

-- 
2.31.1

