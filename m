Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259386A4293
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjB0NYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjB0NYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:24:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1565159F9;
        Mon, 27 Feb 2023 05:24:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCWVKN022928;
        Mon, 27 Feb 2023 13:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/byUsYSPkCUw9YwaqM7sxOiPRsVXlDP7lhBRMK3gZIo=;
 b=OzzjOtOIBVCHAVjLfjoVRSNrIjhReVkyExqNgxKLiVDFmDPA5JNMD10nCvT2XviUlJkb
 rCJoln6r6PYWRBoTkfvRWEDjmZ4OOY5VQipN8QGK6yeohD0A1vnbcq3eDyE/QC3fWMqB
 bl1vZNltHWm2U78fyCztlEd/bhxG56p8UUXP59f5YW0L2Vr5UNVs2ihtv+iYX+F04OIT
 8DnOrL1yUcmD/w345dLXDAu3WjCg3n8og7QN6KgZ33sbFVY9gSfZ5gNcLihX/wkuTH2T
 KhdKVtZSRF0NpMOqqAdoYhFPy6rpmE/qJgxX+1mge3wlT7aoPS0CXFzsqIW4M9AOIB1H BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6eb4c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 13:24:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RBoeP2029360;
        Mon, 27 Feb 2023 13:24:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sb9p89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 13:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agl6/LEIUHDavhY28oUKItIV5edqyoa/s0zwzOHxdxd5Hcryso3Rz0yWPHjDMjNcxvoLmzghvGNGfDisKeYkCyxeGtL9u4jCzcMhdswRTxXXgf7VV8vSjK6cOwuBaPF7H5S8NThyZgeR9HdVYxM3zrcfeb3fbtvy90GCcgn7PNMYxg/M3VX3sns2AbmXdLy+qZI5uwP7jhi1KqZQ6cd8JdNv69vuMk8rPz9mat18HT0ByMfJj6AY1hcOFHEF8blwHxvmVR+SKs+eexVDTYvIzU0YJsiLAm+opp6PcXBr5Al8y8rWVr7aQ5j5qbrKMK87D96h2tI0uQ7Wnor3sCfTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/byUsYSPkCUw9YwaqM7sxOiPRsVXlDP7lhBRMK3gZIo=;
 b=g8BNqJPKGjr91Y+pIcM7RnrAEaEio8s5/sDhZU74YfSGd4gUcTxuz1XEkUJ7g7d1A7It/3HSFidHDElnEY/dolKg6uqzLpyp0XPNxOx8T1AATV7fakn2KtFx9n97q+fBYHdwBLWNbZGm2Hv1p2oxlabZFeShe6Qn3yTaLaFqZbaP94IPa6Dbh/B/tT/hOu5kgrUBb6EMV/Nb9bKfZYCSzP6wkWyVnJEEfEWvF68758gocnlmiR8WOUdGNq15ZKa9uFEI/HRh2T/UAI7tPX8l+9yYhuuifgCem2YaECpTqPJdtdpatQyFWjxZa6kdZ4bvfMdyEaKeW6M0gNmnMjjixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/byUsYSPkCUw9YwaqM7sxOiPRsVXlDP7lhBRMK3gZIo=;
 b=uXEYqM+7ajMpM+tOTQNrYkfZwZg4RgtJc4ZFMSP+0DSURqwnd15xdOCtqGlo9MN99K4+fYynysTY0hqFHNKFMmKjGXQyvVVuFjEIExJ+koFznajmhNiZcpSlxRaGkHjK49nZ0mMTp6KAIPXrSkmVIfIq+bIif5SKVWyLV2mme6A=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB6515.namprd10.prod.outlook.com (2603:10b6:930:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 13:24:36 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6156.014; Mon, 27 Feb 2023
 13:24:36 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-10-nick.alcock@oracle.com>
        <86y1onw02k.wl-maz@kernel.org>
        <Y/jyJFXqlj9DlX9z@bombadil.infradead.org>
        <86wn47vue1.wl-maz@kernel.org>
        <Y/kXDqW+7d71C4wz@bombadil.infradead.org>
Emacs:  featuring the world's first municipal garbage collector!
Date:   Mon, 27 Feb 2023 13:24:31 +0000
In-Reply-To: <Y/kXDqW+7d71C4wz@bombadil.infradead.org> (Luis Chamberlain's
        message of "Fri, 24 Feb 2023 11:59:10 -0800")
Message-ID: <87v8jni6ls.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 512c1012-4bf1-4ee1-f778-08db18c5f86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yyb3jcnW1KfQLpjcLM044hoe9qgaXppiQWFil9J9YNXdmGf6mvX/xfJ3RrVMPklEdu0lkHb5gnI56z3G9Z2r0JfWyoTnOUOfxw7KmyARylY5nMgbiMLHFaGmjYLsNPLqJVt2QeAZtoIdV9epWdjnHwDALx3QaOHw8eELW9HOEpYvSOqmL/7QdPBFFrp080eqryUf0UVzJp5oaO45HOtX2dLt1jEOGNHtOzAAgqz9wrJZAYBgXf6Navfn2wcYERi/DiMbxyXPMMEaDw7DNBIr93zmIZ3l9Cxi0Quf+O6oFrNtEgw+6M9AXVJ0+gQmQVmC2ot+TqbZHrBU8o7RMZdJlQZmU24maCgeW2zjuYwj4j03QHV3+oxieG/7XJvgNqVSkKxYddGIBRh78smVbEkjRXKT7EEUCHlwzF7LjsjcZbzDK+z7g5BS+HWIBFrGvcWRINZu0p6pTEQ0LxDec2m2fH18WQ2nDPPqOGvWPVdLnKsWfavfZByWgdz1D3XJlLuesItma/TSv9aCxnVb8Ob/muedy2/rkl6fPHBUIEeHJyKkSPr6e97xyhWQydJYQneyhvg89SrSRHZ8pNacy3+1QBDU+im27wcEd5yJHaWGAf3zFh2D9qlUXc7+lvzFqdPqKeoTzdcyOhtfyWARkcSusQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(66476007)(66556008)(66946007)(4326008)(6916009)(8676002)(41300700001)(2906002)(5660300002)(8936002)(44832011)(6506007)(6666004)(6486002)(478600001)(186003)(316002)(6512007)(9686003)(83380400001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OuWEIqJVMQdppAp98xPL01/SUXLnJTeEmj4AyZ6dT6tWfVGpgRVuoUa4edBp?=
 =?us-ascii?Q?WzEMCVNUo9kXy47kCdnnkP2xQD2BzTvkDBNREAT71LiD0fglFXorDL3ozwOu?=
 =?us-ascii?Q?45HomXDnDEOuOpDAS7RAez28v+OhOgI2uRDzj2m9QIa/CeqK0+gIReaWjRF7?=
 =?us-ascii?Q?FANLcLb94jiWERtv8/7atcYFldKp7uICzDa1OmtvbLEvibafzsZm/mO5HVhE?=
 =?us-ascii?Q?q2nFKmA6eBMzTWWbwAWIwRuAHu/X9y0Keq9dYEeEkny57hHgiCVJo05opQSD?=
 =?us-ascii?Q?EBCk8o6HWxPuv9DaKP0E0+BaIsEOltuo3Xaz4UqaUBJrHTBd/IPgRcJxYTg8?=
 =?us-ascii?Q?pi6iEWLHu/XGq4z+L2RjbDlTCPYnTJg96FG8vemjBrm8LeY7pwH2lrUDo1RO?=
 =?us-ascii?Q?TxSRV8liHhcv7jjfDhc1DT0SqXjK9lrAB3oWipjv/J6uSk0S756m7B/c9hwH?=
 =?us-ascii?Q?Agfk1kCfeS3BmlSGtXPE0muR3VZOewo/AulRwYNP8HWLfyKCYj4ZzONCY0fl?=
 =?us-ascii?Q?2J1uN8oFBGn5p5WrDJVfYgQi/+69svfHKml4H61pC0+I2HXrurQzHwiyCAKx?=
 =?us-ascii?Q?or9qL/cuzR3nYkjuBGWwshWxpG+9aHgM+JnkZDXZxbIyAvapAevl4JTzAU3E?=
 =?us-ascii?Q?y9pARJKFeobFir2AcDXAmu3sLu5PtSRYQoRCHbFjbM9lHr9aCRmTuRBhflOH?=
 =?us-ascii?Q?7Xoj1qOVrm4fU8vSTGc9Rh6txi6fg2iLvRRXrn20VibSlLY3MspDEGbl1r/r?=
 =?us-ascii?Q?jDQVPpRF67jALUHjSuJZFfCTjdCDXL6B6pWXkQP8d24JtSDFTJc7Iufa1FPu?=
 =?us-ascii?Q?eJY6XLonvunuPa4OFTcGr4gizsbSKLAU96d6nClLKywMtllDHAI6E/++Az/M?=
 =?us-ascii?Q?Qrxb9oVsQ1zwih+wQQJMncbDENWvfcQBHHT5gubzTft2QAFKShww900O2vMh?=
 =?us-ascii?Q?0R6c8bvPXOVAwrSl+0/KqGnK33jTLcSe10zaDSnhSFHCFg207zEFpDzJCPKn?=
 =?us-ascii?Q?2qND7WB9KlkzWJd5gmNCA3vTKboPpYtjDNDA0HCYQrpjMx7mSne1oIAisp8X?=
 =?us-ascii?Q?CMGYp2GoKSnCdcf3MG31z2E5cReTcfV7L6Hyk4oMJiSQww0lgk/+9+Kd1kJj?=
 =?us-ascii?Q?t3oWpu8+gRm8yL26ZqzUe6CCgjykzCjXsArdsE6tjVYI4fk1hV400fWj2u8g?=
 =?us-ascii?Q?66jeuZwlPgH5l5hBNTIUhb2GKjmUMMa8Mx+kPTrEeObd6j8Ew78yr18kHu6u?=
 =?us-ascii?Q?nxQXuI2gZUwB6tvN0MnHpqeSEGdhbgG47tI314xobNBH/7WKXrvskP87lRs2?=
 =?us-ascii?Q?q95HF4eI0IMrrbJxiXXuiHUBEh1aI7e6LT0jZ9+cmrx56RqsnNYVdBxQfysw?=
 =?us-ascii?Q?n2yfDVSu1paj8Fzppl4LmIsuuf9axwiHofUJSO91KlQKUDPyXGlCtjRcxUxy?=
 =?us-ascii?Q?HpN3hduUJMVnruYHIkAH/jy4BgtEB+d+j5ONpB/foj5aR53jlO6VqXPTs730?=
 =?us-ascii?Q?Mv/7HGe1hV1B3LQ5ihQeekjksr7+qjeEpfx5fpJRqNHbEyVC1ANBMmQfQq1w?=
 =?us-ascii?Q?F3FSXaBHpyRC1Yhcpi+8sAVAXBX6zM6tHsLQqDkmbafENORdF0rDoB+iXL5o?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Au6mLE2U3GJzZlld+4rOMEncTWucVKr0BBBDngF3nZJCcMMkBulAPb54BitsbgoqV/AO08gbcae9zZXv7MwapduTCzA04DbGS8X1l758I1t+j1s9qf7DzZhFdV2zuAHehRFiI8C9JOpCS4Ld3wc+8Vqjf+mjMTIvZ8zAeQMoW+8QvqCrziG5Hf/NqkLTFCUyr9BqvBt660ktJOZrErb4K4F1nBUH/i8mjJjO9GfuGGRg5C3Y/azql6nhCJQAi285RXJn1i6HgePKY0wVx6VA2VQ59KX3a2bl0af8pBMX49SMVm0INsqA0WaxqmzDwKf9ypIu9gXohjxwZsvL67YLplgwr9BrUaw9IFEjFpJfwDywr3DxurMktbN8kQTU4gufDhKYOkuFGijT3H0DPS/ULEMUXL//U/NX1dnoQuaIfCUmlt8wgSkjtdpJw7H9m3lKG5iSnlvLXSi5N5hth7Ih8aTMTiJhkbVs9Lc6PpIzvlCq/Kr7aLSli0GCZpcJ1wmCEEGcMYVIfaV11sCNxdl2t/Z0GTx466jbmz96OWT3uWWwuhT/vNngEOb6XyGNdAm4NOHqxZFUQbNxb64fiKhQiIYHCHyt6Jaf2BwWN3TOF31TWwJuAQANbai9fCJddfbxNZHpZR7QkDX01p3XrnsvygLtlto6cTm/+VrLjbdw7yBUN6yXsjZW2Zv1uAd4wMaECxA4tJR/52UTgTx05cPJlQ8Fw9XaKCKcr4PIs6evRQvyaRoDpjpwTjSZe/n9CfceHJffaoP6IT5il91mQGuzigy+DUtS93J9IH6jHsVUyCM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512c1012-4bf1-4ee1-f778-08db18c5f86f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:24:36.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKQKyGwQItya+yqjboOIF5P4KBTN1wWtN9qFoVACbBKmMKUTt+VSt0lZ+sfosCHnMEsGhPnVSqai1WGcfzHmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=962 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270104
X-Proofpoint-ORIG-GUID: juEv8DuEIoqHK5NqwS7JJ6ig8ZnJCVif
X-Proofpoint-GUID: juEv8DuEIoqHK5NqwS7JJ6ig8ZnJCVif
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Feb 2023, Luis Chamberlain spake thusly:
> Modules that are compiled in should succeed with a modprobe call as its
> already loaded. The construct we're looking for is a way to detect
> things which are built-in but *could* be modules. The annotation today
> is done at build time for something built-in using a file path using
> modinfo.
>
> All of the module macros which peg .modinfo section information for
> built-in code can be extracted from vmlinux using objcopy -j .modinfo, and
> that's exactly how modules.builtin.modinfo is built:
>
> objcopy -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
>
> From this we grep out the "file:" and sed it with a ^kernel prefix.
> You can look at the commit 8b41fc4454e ("kbuild: create modules.builtin
> without Makefile.modbuiltin or tristate.conf") which did that.
>
> If a module is built-in then MODULE_FILE() is used we and we add a
> MODULE_INFO(file, KBUILD_MODFILE), and so the modinfo exists for the
> "file:" tag for it. At build time we sed for all those with a kernel prefix
> to build the modules.builtin file. That file is used by modprobe to tell
> us "yes your module is loaded as its built-in".
>
> So the thing we wish to not have present is when built-in code is being
> compiled but *cannot possibly* be module, and we have no way to verify that.
>
> So one way to go about this is to simply *not* use the MODULE_LICENSE()
> which cannot possibly be modules so to simplfy the build process.

I do wonder if I should drop this excellent description (up to the place
where you start musing on alternatives) into the cover letters for the
remaining two tranches in this series, to forestall further confusion.
Any objection? (I doubt it, but it seems right to ask.)
