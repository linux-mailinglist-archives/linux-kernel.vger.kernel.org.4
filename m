Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936E6C106B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCTLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCTLMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:12:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10D12F14;
        Mon, 20 Mar 2023 04:08:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97HfS001693;
        Mon, 20 Mar 2023 11:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/inFTFjlyYR6uAMas9XoZcZOJZr375/LmYkj/irIkc4=;
 b=1F4T3hMhBu3VM5Q4QWpjJ2NZkfknoZ3XK9sebzQlJ10UrZ1GeenHPt3Y2hf2kHsKyrmx
 9w21h/nmc6rhQ9HBunuS3eVPzXfMlwZliI1js+0yIiqDRpUWGhmgJKhlOPjGsi8AM5p0
 hWo75XJTJ9jLQ/m1oXhwYznIfvc2eYGAOkrxTRuiY3vwJCWYqXi5GkoRO12nMgEllYCA
 dvhxwm6Vfk22/GCnhAXKLahSLvot7TCzeXml8USXN4xcLzROdl7ZZ/LK/1oc7r4bZro4
 M1aOPWJBsH2OABnV1BThEzTev1JwoPwoQld67/TrEjZR4BlrTc8d0n4pu7Q2TZswa3bZ Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56au1hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:08:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAbEkd030830;
        Mon, 20 Mar 2023 11:08:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rbkk8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+wQf3VILmZNpJ9+b4iiCwz31ZDDMQBt9wiXKEN5htfy+L+YLdPwzSRv4Xfqnnfw9qxPVc9VXpo6DrMuFHPBfikcvjia+l+VCbQEXgz28VdgPvWdbicE9Q+CxH/MosLGYV0NurwSJuiFFB50yO4UPassDJ2J6+55+LOPGW7eh9Wtpl2dJgM5Jh/ZEymty3QBc6/uR34iA40DG6JjVVgHP5PflM62PJOBjsGARzGXNV/V1BCzkz0NduWYls2ddY38JiFyB+u0oNt1oDXdRn0GmGNTSx7aeO3MwsdiHZQxtXaK/j/x+UxEO9vfyoqtnubiJK6TgOUkCqX5tQdO1EdFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/inFTFjlyYR6uAMas9XoZcZOJZr375/LmYkj/irIkc4=;
 b=HnQo8Bm/i09AeUj9AI6jH8AjPYKD7zBovLSLrv376mrNqtyhsV3wJoM4sltx8x1CQFi5iAN76Qa0Nq21lvweFuvyLicljOmID7sP0EIbqZJFU12qWThavMWe5AcG30kLUWXnopO24XBp2caIcBLF5LI6vCay16B2n3RUAhMVG1oGkiqFwvtVdQ2jDzYyMDJ020r9UTOItglzSxCvNVZgorIgCh8aYHxyCeI1oOsiFnWXrmz7QXmIKqU7kH6VgSqSRPlQLhUGJ/bYw+vYnCTbdW95EMn0M77eJcta4kXgySU9b844mpCEoCEWhL16ptOd5pHCHaA30LWp7W+YNhoh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/inFTFjlyYR6uAMas9XoZcZOJZr375/LmYkj/irIkc4=;
 b=nc4D2AQ1cYPYU5D0F5oZDNC//eKCE4nfrcczIL/2KnwIfWX7cqriIvOc0BPfnp83KKg9BhGY4YXdlDHjmSIgmoo9mg4uQuYIrFIohPrZS07HnBAu9g/MlVD/eWa5axKiD0s7ImbINgqUOBIqvD1rA/MHXrxUUx+15FOuSqGiVAk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:08:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:08:35 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 09/20] clk: renesas: remove MODULE_LICENSE in non-modules
References: <20230228130215.289081-1-nick.alcock@oracle.com>
        <20230228130215.289081-10-nick.alcock@oracle.com>
        <CAMuHMdUFePvbBk7ELH3s8QrTiqEoC0xwQN_YCr9brSaFede-ig@mail.gmail.com>
Emacs:  it's like swatting a fly with a supernova.
Date:   Mon, 20 Mar 2023 11:08:35 +0000
In-Reply-To: <CAMuHMdUFePvbBk7ELH3s8QrTiqEoC0xwQN_YCr9brSaFede-ig@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 28 Feb 2023 14:45:51 +0100")
Message-ID: <877cvbu1cc.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0504.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::23) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: b3535ad9-2d68-4534-c929-08db29337315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMWz0v2OHXRdVTGJSNRGhC3bZZsrlp07SHbO6V4/elG9fYKEmcW6pReU1WYC/lHNIAMygVvgLEmlc3MNO3wUyMI78NweB3lMI5U8mDvCXosr2x5wb/GmBUYO7dg7LBcoEy5BLbxXSc5GoM4SmSdDY3fpg4EmNaJBfQ2utyLRd2NPWdi0t6e6AXSbQywKGyh6e7+MhwH+cTdlm6HuR1mo+Fbtfg3UZwue3DAqpeeOadtwq8cfT6ix4k2mgRcIwhSb3M8ofef7R74eHycgnMMd+6zw8lpQdRPBMSg/rP5reTRGt7zrvlku8OWD+Uxk9ucsjSy3ZsMEEiYNNWyqQANmbjhDcwERebCji4mLpfms4noRvkoUO7HZ3gwoky1IyTo4J5180md1pNN3rBswgv6KzWfVdSdTqi0Q/bTAgNraQZcwalaLpfCwaqh1azggvAZLQvx6je3/+FBa5A9LW2tqrAF2AIJnqWBhxTMK1GYEQfeM4qC56a48ftCz5YuBSNJK5jZ0orakvAUW+b4JTORhxAMQoqdTPCbMSCQQ4HufEL0+fylSEICzV8kQogAXcXNgTyk84r1XsA+nEAiSXcnvfI5O43t1YEZwIsc5BJEMtQWxN1GG9RQ5W4HNl33WFHbGFjgFmOPMSPpdeteMteu/tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(6486002)(53546011)(6506007)(186003)(9686003)(6512007)(38100700002)(478600001)(2906002)(86362001)(83380400001)(8676002)(44832011)(54906003)(316002)(66476007)(8936002)(4326008)(41300700001)(6916009)(7416002)(5660300002)(36756003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSjBD1p+OrCKIvD+thRtNGrXPjs1pDkyUN0queExdNU9EJO+guUT5WYVsXV9?=
 =?us-ascii?Q?sw0DwXuuEMf4c/yL2b4BioXnpxCWast6b8qtNKHlnOP7X+v41hQVS3YA5Ao9?=
 =?us-ascii?Q?rO5lQiLqLMkK3hnXMQUdFNLNF1ucVQZ8VlCOU2Sa2kJLVwNqM1dNVIczZn4D?=
 =?us-ascii?Q?0f8HCl7INT5ekBw0iT0gCQFJRq6t5fW/Nfrf25m3xHpqJUUiCDUZ9GdOrXVF?=
 =?us-ascii?Q?HACSi28YwEwr5n0JlxXHAr8skoKNmb1MOXStaU7uEK6sd58OBKPGOsJzmvtL?=
 =?us-ascii?Q?ewu0hQc3erd4BtKmREOVRPER8njfX9mUgQKPb5wg4KNprDzeOPUn1DqIF3zH?=
 =?us-ascii?Q?AcWiyW1DHWMvuRGS5nsJTItnw8hy3ax/+S3skLZH1uUmMefo0S4h8nINocGt?=
 =?us-ascii?Q?7/pSqcVsK4B5fjFDllBQAyO/e4ysRmNOyzItfap/4eZ5USQrFZWi74XMhBtr?=
 =?us-ascii?Q?K3RZY0tRHYt1b27IWNRRUXphWPo7ZlO5LXOho/GIS3lu+Fs3CmCYC7UMOGNL?=
 =?us-ascii?Q?WHyfm4oyGXQcrc84cGLnnOcc1tmXODIspTDPa7Muhm1mnaHqo1UuHnUj1f9Y?=
 =?us-ascii?Q?AFL1b48Rlk43ijdAjpB1HIaIL1hUPFJ5jzOWbPf9/CtJN6DCdaRlge4U/2e0?=
 =?us-ascii?Q?AZCfSMJKxXKI1vunmCQm3rEZiJ8KIEcP9rQX3KBg+BDnZV43Nt5PHDEAGIWW?=
 =?us-ascii?Q?cT0P5RymKbVniqSQSBeJBxcBUbYsfTrkfNVxooAPREyDolurvl//cSj/Th/s?=
 =?us-ascii?Q?wDujb9nfmhqWqr2JYJ2QQMOPdPS5UYm9byAAOruTfR2igUrj7nXvWIltx50f?=
 =?us-ascii?Q?KSta1UeSQ7V6xieOAFZOZ0Bl4rLTEfM1hzAYZkoxRl+v3J2z/oNl2bdbs9xN?=
 =?us-ascii?Q?iT719+zVqAcbfXlH9yevA4PTNHj7nIRBdc2V/53YU6IQ5INhgjEbO0sTEOTk?=
 =?us-ascii?Q?uGCrMOBUnY2eaoUnFzncnvTRqHXtWWw79qMRR3TrRMDhtk/VbuV0Xg81l5Vu?=
 =?us-ascii?Q?/JfWZozIGPdgH3senha7OUWZUjHB+jw2ehvghIq9CRYSkIKIMr11Y+jN31Zz?=
 =?us-ascii?Q?zIpZDLcjqfS7QUvfRRpotOZZ3NAX1smJolnbU+2yt8gdngLc7TMgpXXgeb/S?=
 =?us-ascii?Q?ZnzbsLO7puu4YFat2ZxLnG84DHpkCcYTK4qSldD0regos25AVVOgACVlQZ/P?=
 =?us-ascii?Q?PCGFoyRqe40Pul/Bs5bSC/Zrcf0H8qZleTVIE9OdILeqHEimz8VQ0JVRLZ9o?=
 =?us-ascii?Q?BNKDMpW4OGosQs8GrVlNSm5yaqH/Tldu9DBAkPLEZ4YO70CRK2eum8X6SIys?=
 =?us-ascii?Q?k5K64Dw0OWtNtOo1hbW1024qKzNot/B8Labn3SZh6LW4dQ2gmGNb+6EPdDpR?=
 =?us-ascii?Q?kt2uCvsaAejYBefkMU7CwLpwW2NAL/PK2HwUXwwivwuPpHaz57bD5UHO0Q1v?=
 =?us-ascii?Q?BVpmT47QlLayRCbPTA6C6P79wKks+vpnF7Sjmybp6mxl49yEAczt23OZFuPZ?=
 =?us-ascii?Q?eMBeBuO6swM+fIr5c3WJI4EzliBOoWzNSJ3eAzryXIB7qevqL7EWB/8phxaY?=
 =?us-ascii?Q?wUI7dt2CjYHFfANdr0fHFzgVnExpkR3ZRosAaLHpbmuf6daZxrCHsJtdO1dj?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VPc6a1rnrm1Vq7aWPnjajr7fdJ+FuWY/hd+rqWVy7iVYbu3rAXEYTGa0xhfR?=
 =?us-ascii?Q?9xTpSmGBUba3NDYO9MknZUy6X3pg+wa3XfTFB98jxsn5Mng8jcYX7+nWKNK/?=
 =?us-ascii?Q?fTOxK+WJSt+hnFk6wRNauYiW2uDX99+MX8EqnWEG0HGvbeJAxdiRnlDqfXyd?=
 =?us-ascii?Q?8YvWLNXaE76PwxEmyH8c80gnbsR9tX8GadVwF4S/zZE9XyLKIpOOR+TT1FZh?=
 =?us-ascii?Q?OAV//h+RW+CUMrXcVYmy3iW5jqm/+QLJ+6yUgJUNnZFUCm5XOPbumQfY9MKY?=
 =?us-ascii?Q?ekGPakAchjFsE7dSHYg9ipJAWS4wpCDTp6XMNt+80yPNre99MQXjREt+t717?=
 =?us-ascii?Q?04NFv0b+cXMDiy3uk3UIPeRybJ0Yf5qPZYQrgTheET3NdVZBO6DxJjf71UnF?=
 =?us-ascii?Q?ffF13JcXswS5iCI1LVf3NFHvnKFPwjl6HC8osgYGelbEdF87OqIVEjciOja0?=
 =?us-ascii?Q?CUP7/enombJMvjNn3rmvh/87/eBnpC+aKGEDFQNW197A4lSD1qmtmCh8RTcM?=
 =?us-ascii?Q?UqjYfmzlH4+wqpQ7M01By+QGxB9UZmGWmYIjl3BSyp0H7L63wbD6dMNi1Qf/?=
 =?us-ascii?Q?2+9uHz4K7DSB645hO3ZlqYTtOCuImDOiTIH1yAExDEDSmn/fIdyAZzUnjWyQ?=
 =?us-ascii?Q?tcY/Wbxs8LsfkwJu9/t424rMk5s8tLNTjwn945HqibvjlDotzA+UqrlWoJG1?=
 =?us-ascii?Q?fII0oiyMmcHNfGgPPk6Tamu6pssiBmytS93fIIJ1YFac3yATzv/3llkeh+Pq?=
 =?us-ascii?Q?WHCkUgD0gC/JEHZpHsrNNyLJ0SLWphJ8V6/eKDiQT2pj3WMTd4YzdUW6T6T3?=
 =?us-ascii?Q?JFrwrXwK99T2h1KRxxzXwLvVxt5himZ4YcejDNnj3XmGWN5Sg04T8M2ZfZUd?=
 =?us-ascii?Q?71Zd/pVimWdgaj9dfRpT+DiyaJhNGLk3g/dA9sASdsoVF63ui+jeYrlNjUga?=
 =?us-ascii?Q?JdNryKk2LlTL9NfCfBUAaGn7//UvOzN2FBV7jnp0tRcLkftaxW3QU5zcpGej?=
 =?us-ascii?Q?C/s5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3535ad9-2d68-4534-c929-08db29337315
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:08:35.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFoLvWaTUL+vmxu/ZchUaB/N/SsHqOxIb1JuLEAkkqj0NilHZYSQBO5FANCkpfq3u8Ph8UVSOGZHLnqSy0i+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_07,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200095
X-Proofpoint-ORIG-GUID: VnrnTygh5q8i3ckV4rFirPtwSOHaAcAV
X-Proofpoint-GUID: VnrnTygh5q8i3ckV4rFirPtwSOHaAcAV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 2023, Geert Uytterhoeven outgrape:

> Hi Nick,
>
> On Tue, Feb 28, 2023 at 2:03 PM Nick Alcock <nick.alcock@oracle.com> wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>>
>> So remove it in the files in this commit, none of which can be built as
>> modules.
>>
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Thanks for your patch!
>
>>  drivers/clk/renesas/rcar-usb2-clock-sel.c | 1 -
>
> I think it would make sense to make CLK_RCAR_USB2_CLOCK_SEL
> tristate. Shimoda-san?

This patch touches three files, so I hope that means the MODULE_LICENSE
removal from drivers/clk/renesas/renesas-cpg-mssr.c and
drivers/clk/renesas/rzg2l-cpg.c is OK :)
