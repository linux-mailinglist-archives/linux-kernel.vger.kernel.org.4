Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824A6A1D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBXOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:20:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38315C88;
        Fri, 24 Feb 2023 06:20:48 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ODp5sw004942;
        Fri, 24 Feb 2023 14:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=edMyL/kIdrX9RY3gaZo4yysRJBYcqcjJ2t2rk8ZwGhI=;
 b=m3uePtMPN9AM7GNG9w3lY8f3p4/zptLF0X8YkFtsBfBB9PmCineCXheolVAXVnWTqP4k
 hQ5N1M/3jpveyoiR8gPWVUu5RwTcx0sJ3gTjkxbvl7e+zzF2Aq79pEjMNprNS0gyhalL
 IPLteImG1fM7igRdmLyTKcx7fIQZaves2Omd0USWMG3KBytx10R6XWsZ1sAfb2ImUNOX
 j2ABMB76ArymguknU168rYTM+wxioatx374TbOierEgR9QcosfwD7iGtKsM65MbjLd55
 m8bhIxj+3vnBRwW4CtfT4/WlVSQPyLj5uKpCIsRN6m5F+QEoupHlde+NiYhNc+m+imjr Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7un1d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 14:20:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OCf5VE031603;
        Fri, 24 Feb 2023 14:20:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49nstu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 14:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc0wcms4qQwm27D+oWmIwOy9zmWP9x7MQRScHyEA9WOvWpHLPex3pN6wQdt4aaCQKcs/5RasMPsx0s+nOCabwJotgf06C0ctTSOLjgh5aT697z19l2WPnxKyQheK6mizEQFXPrYI8yyu1sdMT2VRkREhjftOb9L4bVcC2UQuZ+w21Uwxa3t5dCFcQ6QgaW0QmUwhhPxUP8T5OIEt7ILos28JKtDGQ/nuJzL4KXe9pIwMDTq0PyOwl3eYc75nO0ccNiNtmh/O0dbN1HCR4S6yGIX2B7iP43obocjnvbKUIinOozvXWVYvZnDNIvZ9VIR8Ydcpo+RniXlBwZg+lGcW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edMyL/kIdrX9RY3gaZo4yysRJBYcqcjJ2t2rk8ZwGhI=;
 b=Uki5pCucYmG0ArySpCmOC7Y6fhCCQu/wGMTYocKFhhIFC1W3T3DlQIE9Jyh/q+vUC/Yh3fK3T1n50U7bKLzBVpOhAWxCuzpTtYVrYAcUJq9pnHApm+FP6HswYl6tOm0x/CFsPQiw1V3EZyIscQHGHak4uGvGZCDSh8hSmYrPlj0YcCffLV+v1MxBLPgsLn1WD6hBPJNRUoE3vz/wS2ABe9kixOCKIS5VoZuzh5Ud/I1yTN8e1pNEhpWGgGK0tZ1lIG+VNBD4PNY2LgIA/wjkcWH5B7FnK2RYiXd7UXA4i20BXngfWvkhd32xvrK36g2xP06648nTiiWC5X1juqrHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edMyL/kIdrX9RY3gaZo4yysRJBYcqcjJ2t2rk8ZwGhI=;
 b=d9ecWSogyc/5P9CtuL+6wGzltMbFsqIlN7amUXZd69F+jG10xKaRXAq7zZ4DwY95aPvJk1Yue9w8CVVVuimZZ7zyklX8Hmnf/nNN6TRjrk7mFP8N0SfH0+Ur3bTEtdnQVpeyYzqPPfvTxxZnLVRrAiR8cm+NSI8i7mrto3M6gBQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 14:20:22 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 14:20:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
References: <20230222121453.91915-1-nick.alcock@oracle.com>
        <20230222121453.91915-22-nick.alcock@oracle.com>
        <20230222144856.GA14220@lst.de>
        <Y/acoc6MDKNnrG+g@bombadil.infradead.org>
        <878rgopfdl.fsf@esperi.org.uk>
        <Y/fR0KnxKP2rF3Da@bombadil.infradead.org>
Emacs:  a real time environment for simulating molasses-based life forms.
Date:   Fri, 24 Feb 2023 14:20:16 +0000
In-Reply-To: <Y/fR0KnxKP2rF3Da@bombadil.infradead.org> (Luis Chamberlain's
        message of "Thu, 23 Feb 2023 12:51:28 -0800")
Message-ID: <87pm9zm9gf.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d395cff-f34a-470e-6d3a-08db1672438f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2T94rAZAXBKWg7iY1NdRBLVYKdoZddH2/yKpBBM/cv7n51pnM+teJpwD1CnTdAAn9twWWnP9V4Jz0axJD5X/cCE+R8H8qlcxyXjW2GqF48KlbljUe1QtlElOviYUhXAEEva+7di6SOg0zs8apCWFDTRfFIu1F/aWzx1398BP3p3lYgf9PVJGgJy7GtprElBXCQ/eta198JBqfEuBi0MK+iDQ0CprO2uqiho6kxODECIEArFbjWJJrShuYhMwjaO7758TQy6vZXHp5xViIjtL2XnpEivaRm2S51YT+v0r/3I0dwClSe2HaVNyRmLkQfkljlD2kPKf9hYE21AMMjUB6fcBKT4CimSoJKPpSx3b08q6DmhLdyI+Apo4u2qNcZpwGGUnKcqIsw+xbxzFBdGOng0LifQCK8n0lUgpoxRkezVlhqEBDBbr0o1Y/sepXgAx8SCEtNuw5HuKKj3DmZpIYv0nyycbzClJSz3AH8lOvYfs7dzAaxBFGaBqutOpWzUX6GhSOYOrQZ0grREbCYI/r3TSGL7TDVrOPdi9FFz5I677E2gb/8nH21Zs7+A1Me6Vf7r1MsxPsyl5SdMMonLPAkyz8Xkpfuoc25ufVQanWr4kLSENbypVcBdWPSY0g/QQwCFGS75u47UMLplPdxXkjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(36756003)(6666004)(6506007)(186003)(478600001)(6486002)(316002)(9686003)(54906003)(41300700001)(6512007)(6916009)(66556008)(4326008)(66946007)(66476007)(44832011)(8676002)(8936002)(5660300002)(38100700002)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v85IbIoHJ/UqQsBZhF8RvFtvJ8HD0/CmwJf29PE4btDkcWCOMdpictxPC9Ok?=
 =?us-ascii?Q?otaEg5ZDpxvDnNenvY7mhzsIBA+fCXCw1aIAJIzUhIGoOC+4wWSPNX/Xikwj?=
 =?us-ascii?Q?Yj5qet9nfpHHPh8Tgv3SZZdeyc4a5cwW+kYjQMbigBuI76tG8KcDKdn8J2pB?=
 =?us-ascii?Q?a7YJiJkPztEwwSs8DfiCtkzxF2tDRLtDSEk5xeT5fI2XMVY22AatdPOsm7pV?=
 =?us-ascii?Q?OGaEbg88rx1vrWF1d8/P3HeHrnZd7ZzLtfCsFB3oN4+6Yx15FZqya0mntFVf?=
 =?us-ascii?Q?FzgqzsMtGZosCQATMlsFQbbY3G9yRmh5o5L6RScs0dJPdJEVpRWGlLcqeIgc?=
 =?us-ascii?Q?oG4HAnX6y8qlolvLX+WRSdzOCOW97sxMh4TJnFU+Rd+37VC9nUmhzTX5fpEG?=
 =?us-ascii?Q?BYvbvhBf9b1IaPo5gASJ9PqDW/wW/RSdngiZKN2lk9S85o0arZaO5rAjpy7e?=
 =?us-ascii?Q?aI7fv9/9n3eBYVf8sYbRc9k/6vgz/lbWWNUBPYDv51EivHigbEeZfslAhCJt?=
 =?us-ascii?Q?e16PfRXTUGGO5CFfzKK4VGj7fYolRwVqqDyJmZx+VWuiR4zkPDl9Um3RTqWg?=
 =?us-ascii?Q?BIJLWfm5K7JHi1Uun63WknEr/fWohVf84XL9iP0cWvlRqIn+eBDxaUQCuqaw?=
 =?us-ascii?Q?0MywvIAr+i+oDxryY11gp3ib5M7BnttQ83l8kme22ndR/OZtOgrEtsE1axV1?=
 =?us-ascii?Q?SjpqdKi4ahcaIlzlcbDBaXSFdwDlL8cetEJSaXmKXxyCajg5OPNLoSzIIRav?=
 =?us-ascii?Q?E6009ftuHwWdqoD8/eQANq9TxMAsrvv37fNd0fyLl4130uFKg3+0qU1dy9Ps?=
 =?us-ascii?Q?i+ZIOYqIIKCrOJxEoi+v356d0nCDB++wua7scEdakjeXQ/Ejiif3TSHsPUZf?=
 =?us-ascii?Q?QUEYDxF0pT8HhnkrwEUyguNwq86eEZd1V5d2JdHnrGg1rMe46Fw6ilRq2hXS?=
 =?us-ascii?Q?vFR+AGQ7Z+MRUWpim0rHFetg3ZM5T7MSnrCyB0l8395g4qNFGhmJPH0suUW4?=
 =?us-ascii?Q?Yjs5Hpy9kfp3Wve+wJ023Y8rjEpaYIk/MLZjqQzxWk0hIJ5hIqB/bud8ku5L?=
 =?us-ascii?Q?GwsRNo2g7Uf8OBvAyeCW+/6n9/B2hKHVZKv/zVx9pwCY+hXjwMgGTg6q14ny?=
 =?us-ascii?Q?DYB3OqqnI4icYZz6q2jiFrjno56r80l13SGNQQ0cofrV149DozpijbKcPts0?=
 =?us-ascii?Q?pk3Hd72Ie9C0KM8cE+HA3xR22cc69yV5DmL6hgsdRnYJbTCgDMlJLSm7V49R?=
 =?us-ascii?Q?VVZWktmuiXPsNOmK0eTwHCbwjtYLO58GPDBblPkWYf/s0JRLix3PFp2lpBr7?=
 =?us-ascii?Q?2b1edx8rnjCjZdhcgWPWEDUadzzCLo4zYGRQVrhr1q3KrKVNgXRbDfMXwzgy?=
 =?us-ascii?Q?M2dlOeqPIdedJaMLxgPyoSBz7wJB3TDb2NZAuGCs6I0XX6QgLhzcQvDc4K5a?=
 =?us-ascii?Q?/TjS39sZsINTi4bsJvcAuR9FjnICmxY4xjrSP9xUpvj32PSq17/Hd8iX/OOo?=
 =?us-ascii?Q?D0gVklB3h/m0auhr4nV1L9IRmy0C9QiWG1pI1VUH0beoTHqDowOPBmsjAudg?=
 =?us-ascii?Q?BLykFaReE7BF9HK9pojikkYh/FUp7GkQslTEweBzQpRLMn7GAdtSbHiUZIYY?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?P9LxLLB2CtaODGCIVkrSteOvbKc/t7h+zIuCcuIEav9J2L0w6wuwPRDaYuKL?=
 =?us-ascii?Q?yO21UnwO1zwgG91wnO/orTPluoYbMk2M8nkDFpVykw8TvvNy/8SGonaZcLvh?=
 =?us-ascii?Q?Vo9ywMiNI/Va8GULwBPYNX4LfAtUqtLBGZNEKmyNlky7mj3DC9Pvgaiga2sf?=
 =?us-ascii?Q?XXY0iW88kc+/OkJ8nldlkN3CuCSGeF9BALKCb/S1NtybntIPy9IpKwUxJms8?=
 =?us-ascii?Q?a73BFrXkXExfaOZ6rhaHb1l6xn6pkL4jUl/pSTeTXH5pQGyPwLodF2A9N+zZ?=
 =?us-ascii?Q?yykctF2hJvj7AEIi3AJEcoVRlIZyPjxMDzW323eSHERf0uLpDV1N8DCF9Iwm?=
 =?us-ascii?Q?LKvixMzE/JJmHqywhKhj6OytW/L7fAfcwHC3WoQaC5QjMICvkYpgbNoQnftN?=
 =?us-ascii?Q?GsmjYD2QPr3+sgH4tYKBWcCIv7nnk2jMCU5Zjeyy2zbJyBrDN5Vmekcz8Vkl?=
 =?us-ascii?Q?aMumVFzuqQ8q6bYZiVabSi+wod0KIRtfTTlFOeAF9l6qWSNObH9VpCJGp3QJ?=
 =?us-ascii?Q?UuR0HPAyRk/cGg27I3Ibe7tGhRnf3UlRCZhcNIkSuVsZm8hKT6v3e4nuAbyC?=
 =?us-ascii?Q?ktGAscIRxRQU0NBMnyocSnDJR+6J/Xr+fbXXesgOTwkZbGFDlVqekprNoHJq?=
 =?us-ascii?Q?mq8EEmTG0k5H/qTgR11NzmYdJMsAGFog8zZSQVksThixbMqtRvORnpdt190G?=
 =?us-ascii?Q?K6Mj182zGYORFry2LJP50PVJa6v4ij39HnWrmAE5GFl0wO2DKl2mndzqd4VI?=
 =?us-ascii?Q?Lf4xEVY40KWlpp2HYcQgs0f4kxm6LFb0iUTObn8L6Go2B52myJLqdsaHiCP7?=
 =?us-ascii?Q?njHoZanfQXd4xWo5DNdez+WoHVB2b9Dem5LYyecl4sT1+EGPIr/jFb4kS5cY?=
 =?us-ascii?Q?0GTjqTPnqG+QkjNgn9577SQAIr8Cn7BSjJp0pyWvnGiFaJrk6xpKJaUp5vMW?=
 =?us-ascii?Q?Kn4nlxy9efNDROqQEIdxYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d395cff-f34a-470e-6d3a-08db1672438f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 14:20:22.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rW4U6y865M9vsiFeS1k1e7ZI5dprvLfOn8aYzwN2KzKmk2Wwhp9SGZEyUwm/zSfx/tEr9m24TFhcv2UmZsqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_09,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240113
X-Proofpoint-GUID: ngxZ9HphhDdEpuMpsaKZd42OTVUhwQyh
X-Proofpoint-ORIG-GUID: ngxZ9HphhDdEpuMpsaKZd42OTVUhwQyh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Feb 2023, Luis Chamberlain outgrape:

> On Thu, Feb 23, 2023 at 03:31:50PM +0000, Nick Alcock wrote:
>> Nor can I -- and more generally I can't figure out a way to get from the
>> Kconfig symbols to the source files that constitute them without
>> retraversing the tree, since the only place the relationship is recorded
>> is in makefiles, and those makefiles use a lot of make functionality
>> (including more or less arbitrary make functions).
>
> $ grep "_MODULE 1" ./include/generated/autoconf.h| wc -l
> 560
>
> $ grep "_MODULE 1" ./include/generated/autoconf.h| grep XFS
> #define CONFIG_XFS_FS_MODULE 1
>
> I *think* the trick will likely be to have new a possibilities.h or just
> agument autoconf.h with POSSIBLE_MODULE for each module.
>
> The next complexity lies in inferring the license and doing the license
> output given a combination. I *think* you already figured out the objs
> from the module, and in fact your new kallsyms extension I think prints
> these out right (which I find highly useful)?

Oh, of course, I forgot about that (how stupid of me). Of course the
double-traversal is only necessary if we're trying to *compare* the
results of tristate in Kconfig with the result of the modinfo objs=: if
we assume the modinfo objs= is right (which it should be in the end), we
can just rely on it and then we don't need to double-traverse after all,
except when verifying that (which is a rare intermittent maintenance
task).

(Of course, kallmodsyms elides all objnames that aren't necessary for
symbol disambiguation and reduces the length of what it keeps as far as
it can, but I'm open to an option that just stores the lot, unelided: it
would eat ~750KiB in the kernel image for all but very small kernels,
but for debugging that's fine. Saving more space than that requires
storing the things in a per-path-component tree or something, and would
likely still eat >500K because the leaves are extremely numerous.)

>                                               If so then we use these as
> input source for an SPDX license lookup. Instead of having this
> relationship grep'd after at build time, I wonder if might be good to
> just collect all license associates to all files in a header file
> similar to _MODULE prefix so maybe SPDX_$(file_path)_LICENSE_$license
> which creates a header file 1-1 mapping.
>
> Not sure if that's too much noise.
>
> Just a thought, to get the wheels spinning.

The only problem that I can see with that is that this stops us using
MODULE_LICENSE for modinfo construction, since right now things like the
objs= and the module name are dependent on per-module #defines passed in
via -D, which obviously can only have one value while compiling a single
file. But it would be perfectly doable to rename MODULE_LICENSE() to
something like a zero-arg MODULE_INFO() and relieve it of the
responsibility for setting the license, so we could put the license info
into a single file as you suggest. Non-builtin modules could just stuff
a single MODULE_LICENSE line in the mod.c.

-- 
NULL && (void)
