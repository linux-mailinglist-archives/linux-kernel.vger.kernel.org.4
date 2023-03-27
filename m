Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB56CAD10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC0Sct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjC0Scq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:32:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E2271D;
        Mon, 27 Mar 2023 11:32:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RIT9DH020614;
        Mon, 27 Mar 2023 18:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=P5m+PHchG1MWgHS0klrYJ5mOFY2zM9P/eIQASuTIR8o=;
 b=Yk+Q7JzCKhZE0/31cBFImeT9mGPlNfpWzj39Nub4MQW3boh7V++G8tM5ztgh2k19N33S
 Fga9YRfdR4mvr6UOWcMwdCGecmxUyXA5NP2zghF97yCwGNiwowIRXiHReEycEro4fXCB
 d70JD7nSFdWaPGLs9Bg8yM26e5YNJ8AUm+P64CeiGj5kWpVmvbtcU37jiJJg3/qA4WqK
 su+pFa2Uayrg3laWXjfbGGCxoqz3RrLcmJamKa4VzYnLUkq6ozz8fBnGgKNJ4ni5K/zr
 7N7lcrmCcJpUgIGCHteWol+lF0rEpiSbYc+wjUE+ZpvUpd1rlFEHdaHSIVxp+cXLv8M3 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkgfar175-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:32:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RHSRTD009382;
        Mon, 27 Mar 2023 18:24:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdbuakj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfuhxt1fOokRcV21NiFLyjnfEoNx+v8m4AlHqCHWaKya53suOyVQwrkNG9CkV0iVycrDtUoTMkv1noguMN5qv/Vut64fGpX3ydGYALYuu0kn7sHam9UHb/+G7VZjzV1gs7CnjvxjLEE/O+bXs5DaFSo2Fzf6oOSUlOugq6UgMhgxBbYWx44rnecsy+EaIXh+iwwA1mTyfwIedhtyxXXnSqhv27BmgD7r7DJOVcPzJnlaUsYS0UbgryOfFjobniLq8yEsa/rF+0wb0yRRh1jEx3lmENM8OixX7y5vcB8J4wfzOfRMBrjmP43bfEQEAhVPSGWYJ9uNsCZCzi1fdtmyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5m+PHchG1MWgHS0klrYJ5mOFY2zM9P/eIQASuTIR8o=;
 b=UkziBv7DsshBKL6/iveOh695g+zEolaSSssagKJoaBlIvV1XvgtUBzSfkJC1LUjv7p4Zcyxw/1LzMqyTqDbXrHHhCAYskvI4RpnFHY0U9QelKf2/RAQOmHf5oKWaH+BX/nRmsx2Sv2vSzxD8bqia2S9ym7duk9DroYWuO2IW5RYiifM8Fj1VQf+X0MHapY+nrBVb8ZKBaRdZclI+AGfhlNqL9UY6c25rcd2v69+p6n9ELGmCgGMJp7I0R4U5DO1nQDu23BYJpBYtZ4/SiMH2Dt3MtuRAeD9sZzSPYq0sBuofuHxfwHWTGlGJ8M9pybtySvTxVQ10MWutTcihgbVLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5m+PHchG1MWgHS0klrYJ5mOFY2zM9P/eIQASuTIR8o=;
 b=S5H++ietK1nxRaOLkPzaE4/j0VPqDDtr2tPdGtTXrWum2deAsFyLObwjggRNwI60RFehXaYOX4ZwcuYaMptMYpsmfKS5OYLtq9FSIzD03zuzO7920FEnOpekYZxOnC7/fDGBKsDkaTOPPsn7MvIsuIDKaXGa4+aXrCGNgjiouYU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA1PR10MB5885.namprd10.prod.outlook.com (2603:10b6:806:234::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:23:59 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 18:23:59 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
References: <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
        <ZArc0ib697JIwKou@kroah.com> <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
        <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
        <ZB1p5zRp7rlGGuCP@kroah.com>
        <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
        <87h6uamdzw.fsf@esperi.org.uk> <ZB2zrHSzmi8FXABI@kroah.com>
        <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
        <87tty6lbed.fsf@esperi.org.uk> <ZCGBfbZztfBpgIXf@kroah.com>
        <87355qnt27.fsf@esperi.org.uk>
Emacs:  more boundary conditions than the Middle East.
Date:   Mon, 27 Mar 2023 19:23:53 +0100
In-Reply-To: <87355qnt27.fsf@esperi.org.uk> (Nick Alcock's message of "Mon, 27
        Mar 2023 15:54:24 +0100")
Message-ID: <87wn32m4sm.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA1PR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 24029f6f-0867-41de-69aa-08db2ef06ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysFycqvt1dyEXmW7hiUMjLD36dH9RdwtWNx2PVNxuckltmpwD8ZQ9ypci0ClPj90ZpncrlCx0DEhUNdn1sHfbPzoyx+hrPUts1tUDspHpCdvOXjbE+wNJszvt+CRmcfKUr8MXOcqNk82Jh7BLroGTDTuSqli6Q/mwBt4NskY/UsVvAedGJICecveJ45S/BweVUJ6uilYF7HDNR7i5JeRsUXxw+9igWAVPbT++FGZQWK6W9/ZsSY5KTrHQa7llM/j8LQzeWI+22gKgGFkXLGVdVS2ZYDiZneW90yOOYOxAvS567u8qUaTKez+F5ApV3KsLuM686pZOnkHa0tk/3dlb+lOENRHKt5xnamHZC/fTSxldeVnuR9/Pw0Jki/Xp6gSV1cB0i6bybu4CCfvHQAyMJ+RG3n4Lq0b5w8A00CdosuhmkWHJz1Y9gKoSnA6W1aj0QC04ciLaumCFmm0oGayST1z+8HyGJiwV8fjzr6HhLntgeKA8TrGiipdLm5E2nPXxglsRR0dB+HlLlihOtncLvB+kLEOesnIskVG90uXsyYann3t+wM57cZYko8U2uRj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(9686003)(6506007)(6512007)(41300700001)(186003)(6666004)(6486002)(478600001)(54906003)(316002)(4326008)(66476007)(38100700002)(44832011)(2906002)(4744005)(66556008)(66946007)(8676002)(36756003)(6200100001)(86362001)(5660300002)(8936002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+2d7RT46b8ueiS++WQhrq7S1n8Oy1KUrwM8lie3QbcpbxD+0jIOUh3O1mC0?=
 =?us-ascii?Q?i0+r2jShzrgg9Efap1gcaBAf59uxS7WayKBFWtAQ+qa/Ceig9ypR2F6dGN6X?=
 =?us-ascii?Q?FdXnOcyiKGlYdjVydXCPNDkXrM1/6XjlOVKOKEuWoG5kW+ck1eAxH0shLUAi?=
 =?us-ascii?Q?Fs7lXDXdZ2HJjLKd9oz07GFM76RUItcUcU4sTxI2ukhpgzKfb6RsDMrtDXm7?=
 =?us-ascii?Q?qViGu22R408AGNopf0qJe5eL2XcB8GsR7lDInDbj1m2pNbi3eiLRHK+g3Mye?=
 =?us-ascii?Q?Fg18VesQG2dA6AipIjNRyfaIUgZxlNE8oPZihHBLFVMvuIE/Bu3x/JocbLdp?=
 =?us-ascii?Q?z/eZDNA7Yoehn32vlfUAaJ7sWKcNAbh67rDi1g050cMDssAKLA+YS/8HlK3z?=
 =?us-ascii?Q?mHvmUjAHLtIrDle/z6VD/pm92/mgj9tZnePfOzegkQ/0gzIes7LHkqP7QbbG?=
 =?us-ascii?Q?CHwf0HX1xj3HEf/jX05dXoy6dh8DqHTQW+cOK2jJCiaVGXINyc7ptG5v1Dp4?=
 =?us-ascii?Q?ANE0sxC6LpN3CVU1Z2Laj5PcmJXYPcqqYWs6wqwwY4zTZ6U3jnClfsv+xvY8?=
 =?us-ascii?Q?oAcLKShUoPORS2P9lYbGLLjs+KcEnHp0vlvvCv4hB6hKmebFJ6idM8luJOfE?=
 =?us-ascii?Q?v1PbRu2xTg4gthBCh+ZzuzQfKE8rnl0GLcavveqtBIWGTfC+Gy2WsZoCDeic?=
 =?us-ascii?Q?gS54aAqlnhdI7QxwDv3AoVASCwVMXnJoaFVwJ3R0bSQr1RqYbCs8KKAP4Tmk?=
 =?us-ascii?Q?VW8+la518Y5w53AwPOCjoFJOHwso4jVSQxbmPTmoJl3YdK4vlM01bnOnVJC5?=
 =?us-ascii?Q?EOI9kW+GkEW2Zlxbae4//JX7dx7LvXd9wadXnBiTRPljDlBjPHqnonVKNuYK?=
 =?us-ascii?Q?GQ1DF1OaY+Xe8q6MmCzLccLdQ+xiizS30z9fx1NC6grS+oPwMq+awPc2//Ir?=
 =?us-ascii?Q?G32FfB/poDvhB6UwfsAPmVwoQF4PrTnq6KsZCkO/islzrIsGKbSKOGiVN714?=
 =?us-ascii?Q?k5uQgMlSHOxlDSYB0kIzyJCcYHNbRlFJmff0f37V2bB6EQOlT51Yb4vzQAeD?=
 =?us-ascii?Q?FDqetP6Y9GNbe5ItKChixudNCk3V2iT6CRLtKCBWw4YEsCRMeehVvdNoSu0m?=
 =?us-ascii?Q?CMUWfC2WkV9rVNii34CrhRZ7uQZ1CVAwERQyirYmOIofPY2tH9r2iRusqaxX?=
 =?us-ascii?Q?fah+hSWPxgaXEb43AFJZnLRgUIQfh7rP57rnJDT05Kzd4tp2wnKDZj6uV8FN?=
 =?us-ascii?Q?sTR4PVGoza3X2UhxVbk9IhwktyYZs1KOFNzJ+QGliyfSM77/AG2TpB7DA93y?=
 =?us-ascii?Q?f1O+7NkwOkpSDJbmN8eYCNkFQnp2ZEqf5VUkuvTL1DDwlwCnGUcp+dmMM9zO?=
 =?us-ascii?Q?7s+LKwH/N0icoDSGLu//5WLOSjTNGfAxHWCn1SgWDIsfSX+ojdgj3G9Tyy/U?=
 =?us-ascii?Q?+PkU94luLHCEKVuP7D7Vps7r6/Cd6EL5QMC8thR9J5seoNAwi2ZIODoIJiuH?=
 =?us-ascii?Q?dmg9mZ9sYV4TAcJb7jxbtSE0Fr2Dm+Man+Zky8NBKgiQKmatcIkKjf4fpxCq?=
 =?us-ascii?Q?8BRjVymWJt6DnG3BSMOrg5uGJMCShPM6K4vb0jUUFOajN3wp6b26IArelqgP?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6BRyzxSoMjT5vviQbzsNGCLQlx0tBxBMBvwZqyIuIXXx86xTzK/7onqSSk4N?=
 =?us-ascii?Q?ZQA3hvNtxxx3TkOGD9v6p0l6nSMbWbqSR4uJAh95RI1EvkZLJ3SBCzcJMsT+?=
 =?us-ascii?Q?k8kluWzeYO4ZxgqRDM07Qf9b9RCAStMuTxmJtbbxF7aZeeCd5dnyr22VC5hN?=
 =?us-ascii?Q?y9oGpt9OFUtD/OVaj9mBFFKD+4VYvk+50KaMZkp/28b9CMaScmDisIeIJ4mv?=
 =?us-ascii?Q?zDVGRG8SQLV+1hOl4d8lMxYkBOLDEuULUwo7g8wGnY17HxeOQdaFm+CNSdbl?=
 =?us-ascii?Q?xYoRbt81z8UBF/j610OapLsxdbSI38n2txN+FYGFCs0Lpb5M4L138ThlOfNo?=
 =?us-ascii?Q?aQec4Zhpre1XU4SLVqTpJpzGNvg7HqybWj3/SUEBP9IqjEhalf7d9NDEQn+X?=
 =?us-ascii?Q?yF3BaNaWJkoBiw5gqEaYRYGI5Fn0rQPOUYsuMY0bYBvSSScigmsGGD2r8jdt?=
 =?us-ascii?Q?sZ0KO0+NmfnJXwskfux9kGblwcAgzkzQNZAalvNdOl0VgkDwkZ+aUWOxss+W?=
 =?us-ascii?Q?JVncJeOoLam4Ms7KQTiQ4l36Smbbjl9zSHRhCLTcRvgCdGWn6+rpJt697cpH?=
 =?us-ascii?Q?QrO0n707jjpQBGFzb3IVZYMiRERAM/DkQdtn/ERV4Sd+GOXaAV+ccNmUigK4?=
 =?us-ascii?Q?MCASTTaJKmFisD1B9hOxVrQGN5BPL43riLE+j1EeJfcUPhOyH+k7Mla/FAgC?=
 =?us-ascii?Q?vaApGAk2DRd4uXYk1gPySR228VGUHddqw95Mf2tJXHdMOl1HJSJPAosgJEJ8?=
 =?us-ascii?Q?Llxnbc6hLNjYklSbgr4FAOb492pLg6pN5ZQ9CrVSfhEqciOfywSoRE4s1Vlo?=
 =?us-ascii?Q?gYg6JPmU+B5/cbmEuT2IpJIMxyIu1nqejub5eR9cBhOfit2nDof2API6Ww+O?=
 =?us-ascii?Q?7sDsvhvwHFzAI5YsQ7JSwqvHpuuyY+e83BULaOIWhosTXawVYGb4cEosMN8y?=
 =?us-ascii?Q?HqIzPKPh5TSe/K/BhfyHh1RqHKIQC+xu4+mcXI3sw+4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24029f6f-0867-41de-69aa-08db2ef06ec5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:23:58.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc+4W+qyo5froLG87T614yU2wAbF3VdUfx6/VmFlI+3KlMU+GG9+SLgxiLvizkdl5H7Kyv5IW+6jJ/pRRxMS1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=742 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270151
X-Proofpoint-ORIG-GUID: IilZrbZO3RDqxD0N2w61QPCEXZdfaNB6
X-Proofpoint-GUID: IilZrbZO3RDqxD0N2w61QPCEXZdfaNB6
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2023, Nick Alcock uttered the following:
> Well, it seems to me that you're really objecting to the consequences of
> a years-old commit that I didn't write. Since the person who did write
> it seems to hate me for unclear reasons,

I should probably apologise: this was uncalled for. Stressful day and I
typed without thinking (and then rephrased it repeatedly without
thinking). So, sorry! Mea culpa etc.

(I am *good* at putting both feet in it)
