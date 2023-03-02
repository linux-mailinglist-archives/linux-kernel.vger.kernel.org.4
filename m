Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC18A6A8CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCBX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCBX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:27:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF401EBF1;
        Thu,  2 Mar 2023 15:27:06 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6bHL005201;
        Thu, 2 Mar 2023 21:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1r9GU7EMXJyLn322042CwF5nNW6TvZvKaMbg27E+1es=;
 b=P26bEy5uAR5WXx3kXHSX0E3uBLeSMSfnc63ZzNqFeBdTzlRuPLqENshnW3v8aVCaHOtX
 oh23KNUDVf3AwW2P1zo3zxNC3RjyiV881NBNYewTH8XpnacjaQMOJ2y12UAMfwYKyBOc
 n/pBwk5VDH3w0O8FVsW9AvfLimHLedj9HDq8S5u5jrdu1h+cI1Eb447wudMf5t17BO5T
 RsLBzMzvAohr6+51vm6w9XjLPHG9t4rSLih290A5Y0SmXzyV378KHBqzCgWqbmYbfxHE
 YwKBikdDIOQ0gfxeDuT5sbkTEZw2nCA1qV2Kh8rkBrIPo6LCfxbBSsytn2ce7bDmDas3 aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7mw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KhBc4005168;
        Thu, 2 Mar 2023 21:18:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saxwah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn0BimVL/IKk25oAUeckUdEgqk3IWu8IefOWf2A6WQHZ4Lf8b+LXErcLzCJ8ur4JMn1A3jNSr4oEKnIznpGn1SHq9ZmQ2wojo3D0W5DODpIWjAPrs+lR2rVJq7fpwG9RQC1bsh8pO76KKqUrcmXUcd68vJaVKtB6JoQfdAl0X2S8GB0tHZjMoj2+P7yoIXopdtxMiMq+2BAFTmvWw+ZT3lmkYdl8wkgyCOdTbet6r8AWFuHht1ZoG51pQY71Xz5gksKfSqPCNmuQ0X7YTQb+H7OkjkPFYyTAQe8eS76cjpgkKcjvJIEvJvnefEvirc3mEj1KH0GJ731tS2ttVxYL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r9GU7EMXJyLn322042CwF5nNW6TvZvKaMbg27E+1es=;
 b=oJJrwm8t6w7cmmJuEbIUmLnn8RbT06Ay1zWpMBkf38pxQjlVu7shQb4SAHEa4Ij1fyZ8XS8Js5AueNgvz/MqVpmR2q8YvUWBLjBpu58zUTBGzps0Vadq+gY0QuTeywL5//3sp2ljypFshJu0M0stL4y3e7iu5aNgMtIsZORjEDeNygCbshEbVC3vLxG2CDaEEkm4KpGdXLhJ5BKW4LYnoi8AV5FKJt0XcnljhJ3F5oztJvZ6aJPkKX0hyNMK9eSZW2QVOZwDm53t1dKS7HE4xH3LsQlpilBJgZQX0jMG9YBCO5GK+yNffys5Oem8FjxH4e+YDLa/UUsx6cHdaJz6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r9GU7EMXJyLn322042CwF5nNW6TvZvKaMbg27E+1es=;
 b=j9qd8lb9DNcxOy9CwagE52hy3Kcm/aQ3asxYIX+RLnjD7c0/zO/YsdCeh6yurIzXFCLs+VXAEQm0/sx5h8I1+w0WBBoIguVVn1v9QV4H9GL/Il0lrGDtFm4NS5FmhSJhmB5dk/h7dmCH0anmrf/FVs+cVrDZC89L4y/CH9i67/A=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:16 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/17] irqchip: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:43 +0000
Message-Id: <20230302211759.30135-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: d04a8924-962c-4ee6-50d2-08db1b63a375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Kn0Vsq4Yu3QKrMTzS8Hstjm8Nmt872UGMV4lq2iS4x8S01mqA0kEkPO+qh70z9MZ+0eEiNilZJXe4CkmkOPDKSmckigtm1E8lzkWWKaairfbSkbxj9KoWnk+3Qf9xER2M3iYsKQ60A/pKvScrrnsn5QLVKWgtv0fZG0rNAcC8M0TIGGPP+to2MnQEf/9z6MdX1pVCkrAibIqfKrcb5KWlCOepw46VLf3jXInq8bWj52U4yfg23DY0nESsl7h03MF1sRVH/YJhRTUc2zv0zkVnr+aBbi2b6EVKNjXuA5aR1hEMJssz+lCFS0kdLtd/l9h6+vpT1GrEetKtgomDk5/I7GbfTZ7utdCDhS3mbOMbPu7XUqSzcYxZIFLglAaZplCFnfwKKtnJAAk6vD5Hr+4f4VzjsilQK9VXA1yN4Se49FRSgkwvLv5psEN0fbPIeOQY8XpYqdvV7ofH20TZ7DGAyK5dnKY525z5/z/6US64c/xTJnUWeXF8PdI/Ft/rxREb5vDvcbQQOSs0c0MeivjzkClzjzqtVom2Yu0F5zmakYi0XJVX9oSvkaNKRE/asGVsRfksXJAsJASRhmOmX64jS0auAjjNErhGWMRNPvs5mjPrWaqyinFoF/D3uABEpOm9uAdRqNxHOoVEDbR6akyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(7416002)(8936002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(66574015)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vekh22zazn5L85x7m5WHmrePboIcnLs5Qz4Vrb1vXERXNcb1nm+A8OZdTB/?=
 =?us-ascii?Q?GyZvy+mJvITp2nPh+NqENjSxT6v8atscHchKPF259NRpId1GquFeCFZSCR77?=
 =?us-ascii?Q?OuR6SQ+lYZNP5U9oVgTcsdBFaMEn3IjE7FX9OQRnJ74ntiUJHw9c73wfoH2s?=
 =?us-ascii?Q?psy6V70GsTZZrcc02sxbK4uUHG9duW+YCHSQFDRVYw7oFCtC/N4qz+SrQHx3?=
 =?us-ascii?Q?mUwvZ9UjcA9j27qLOk97PUF/LSZ0C79SMwT5gFyAYdB/GHjczSXFpeWTd1vC?=
 =?us-ascii?Q?uox46WdXMpdFAWt9o/98SrQFzC7Z16AwenG8T36cztYtnVRkEsJ+Qcw6EbPC?=
 =?us-ascii?Q?rGraSlSnN5NZIDgY4oWrYDnynKPZGN43C4BGu3rMF9Agm56AK2CPjxiEb0ch?=
 =?us-ascii?Q?VEPFYnt3PWlV3wjTQd7W8lvwjqFbAxgF0P60S3agOe/DBxM8xyihNPLgSc/4?=
 =?us-ascii?Q?NN+3TOJUKRY+kgTJUcfPpJDVLQHC3uiafvpzYdoaGiwYqDnk/eHizRYOzn2W?=
 =?us-ascii?Q?fkGPXDSNFeOBa3pgWfR+/TCqyRFVoySBZ7+L2VfUTkQamttT3w+fLtQp7QWH?=
 =?us-ascii?Q?JFohWPy2igiD/SUxgRGIZArb5Lj4nihSM1rsnjGMIfJ49R3NtaTJDZL2KdG+?=
 =?us-ascii?Q?sNIEY9YOd9nxGD5fydM0DfenMFrdBNcZurvSu2QC+/wuIjE1ni5Ll/JQDrXt?=
 =?us-ascii?Q?1rku8NsFInJ3Ji+R+26YGvCNR3uaSEnQMZK08TthQIIAEdrkBmNQiDc0HfKr?=
 =?us-ascii?Q?iQdLHx9Dcl/TUj2SyP4BaJH0veS4jWy17uuVL8Pvsi3HNVpZ+c1BVnWpp3bM?=
 =?us-ascii?Q?RmwAiVj1XxdND8evPSxMCu/hFkLNN882ggRys6peMwNUcH3yPG6K5FQlWb75?=
 =?us-ascii?Q?RpCYQLVxXs1Op2jVDmhRM2TAJq+C9V5CyITmqjg8LqxqiLUjh3Ixif8aqseW?=
 =?us-ascii?Q?ccOzG+B6aLm0ae+4pcCZDvFdCjHywyK+eIZhkmxeTHGT8+VjSCKesnrSbO0/?=
 =?us-ascii?Q?TRn1bzrEAG2/Z8wlux6ba3UYedIoaa92yH2m7XnWCdLtzcUIg0Wwfzk7dxw2?=
 =?us-ascii?Q?XAfyBbjScOSUoVQqKkL80ah3Li7TWQt729Kmw1b6771qu6RYQiHDor8gNuYE?=
 =?us-ascii?Q?ruMqYxg+I1S9t/vbkPxob/nwh+haqm5I7sGjxAzPFNAbNCE7+Xaqxv34WEH/?=
 =?us-ascii?Q?jviljWM8SW173lBm0yepNhDcT9fE8SQMoIMzGW/2sNViD9mpnxd6D1R40NEY?=
 =?us-ascii?Q?beWbHwwmiEPONio+QUFqgFQImNh2YwvYw4myZxkEIRBmGRvDWaVEqcw8GB8Y?=
 =?us-ascii?Q?cKa/Fx45uChsMwiTrJGSGxUND9/j4I7vR02JnB4F9SUSgBgP01X1FiFWVQVz?=
 =?us-ascii?Q?YUUaJHjqFwgkVSCCjSvEoleP5LmG+VJyLVb+fT2sb8GDbKK6NP995PBwMP3j?=
 =?us-ascii?Q?eD7f2Mt9lpGKgDYq042g6hZ6CuiV0kxqoo+NOeEDt1CPAXhvwM/ucbUivkar?=
 =?us-ascii?Q?+0hcgCslTLa9O4ACj/RjB4PRQr2JGCCyOsTG/AD6uNw6I/z9gYOpU2A0/yIc?=
 =?us-ascii?Q?sFl/ixfAoXut3wa1pZR9qm5e9qBEFyZtKUxqX7ZqEbc9JhD3dyZRMQsjEG1s?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AR7JRgLzqHEMN9KgrV6YAapecG0t/5REF5gsACBP84rzfIodlsxVMStUM/vy?=
 =?us-ascii?Q?uBkYHtujPzo6APhpbWDfQ76l0jiSSk01eT3hIO7YLdz8Tymx8aXVLbnU7JsS?=
 =?us-ascii?Q?zGOI3sMMFDkQfbrn1+3yxfThETSCxQS9DfY9wURNPIkLgDt/pBSYfO6wjmG7?=
 =?us-ascii?Q?qAzvfXpRtue86gCtAyOmrwOreR0DId83DQK1OmoCJ1wOYYOWaEz3kbREJo5Z?=
 =?us-ascii?Q?LRdv6Iuv518znXzkJnF3NB2Xmy1iV/6seZphMfMMojY9QuXvIpg0FqIKoFo2?=
 =?us-ascii?Q?qYtUm0OS4dbsvfjGMGxP4Ui02GWS/WtdW1BZiDAm2pxi/DGu/M5O023XDt+1?=
 =?us-ascii?Q?zodAV9n+y0DzhmHImz6ouZN8IGHeKz+PKsYXkV+wLL1PbbiVeVms32+R5P+d?=
 =?us-ascii?Q?l7h+952Y9DZsds22ihSD7Z/3qgFdFAkjPMJ/vgEwC+Bu+CbyeA64oBxXiib3?=
 =?us-ascii?Q?+xmQVIsxXjxyxEH5be2qPw0OKFhgn+dA9cVomeFDmfA4huKr/rNP6lM7YFOa?=
 =?us-ascii?Q?ZfFDJizk/y8T3ZMwTz0L/TVrWEBR6LdP3PZ94qdTkUUnPm2kYZMFY2f6lWyY?=
 =?us-ascii?Q?gcSS419gOAK0H2mOmFFS9xfQE5vagmONgBkzOFAwzqQEmRI9yWDGtE89ieI/?=
 =?us-ascii?Q?IZIkwGvr78BhagemMb/u+nmw+33oFcsHw4AJ1svaBh97DHK8FJPPoMbFN6CB?=
 =?us-ascii?Q?rbytx+MqDbsfEfQHaA6RS/mMKGqsZ0OljEDfj0swuy4YONf47+BRZzhGAYIy?=
 =?us-ascii?Q?5ZTa3+iiQryueX2Omni6Rm3FmQi82/8ilTL4YKqdW8Pea0PU6J0g8yhMY3Oo?=
 =?us-ascii?Q?iQZ3NYWzkpJjwPPTlR2oPlVwoBwdefaNiwMyIe17EA4fiiT9yJ/WRjHyetOn?=
 =?us-ascii?Q?Kicfgwudbo3EK3twWgJg/63a58E3FgXOcGOHtsEErmHTW47QuuHKgdUcdbgf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04a8924-962c-4ee6-50d2-08db1b63a375
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:16.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFC4sQMFn/77erPSzUzOdw+cAlxoRAYZ0qgg4qcnckqf8DWgNCZK97SHbSivmAU/WgYT5ozCSNMMRMjrBAxdxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-ORIG-GUID: iv8SaFV4JwBG3t7rFNiVsY5bMCzAoT8T
X-Proofpoint-GUID: iv8SaFV4JwBG3t7rFNiVsY5bMCzAoT8T
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
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-ti-sci-inta.c | 1 -
 drivers/irqchip/irq-ti-sci-intr.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index a6ecc53d055cd..7133f9fa6fd9e 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -743,4 +743,3 @@ module_platform_driver(ti_sci_inta_irq_domain_driver);
 
 MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
 MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index fe8fad22bcf96..939201b2c871a 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -302,4 +302,3 @@ module_platform_driver(ti_sci_intr_irq_domain_driver);
 
 MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
 MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

