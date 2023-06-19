Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B3735A87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjFSPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjFSO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:59:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D31B0;
        Mon, 19 Jun 2023 07:59:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9nJAs006963;
        Mon, 19 Jun 2023 14:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=uy/o3FgerajaMAGm7n2jMETUlBCCFeGfSqsYnbAzb0U=;
 b=WBam9PSUqWvsoelSlQj8ZO8NU0VnM89Hbn0Ti1c2rRVKOYJIQhI8K7QP/MPhwVOdGWXY
 bOk8NoMs3dGM55gdsxTb06s/TEey8zkKAUVNFzWowYyeReZ0tPqNNchtvJdzifCBqIMn
 b8lRjC2h6n0nbA2hYCpc1Z/w0+tpcQIn0tUuKXgMcT0bo102mumxsPWTm3W36ZsOjRp1
 7y2Ixe3yR2r82HsOg591EbSiN1teG9tUUjbAGyWdVPBVoOOML16aF9eHqtWvyqEqYetA
 mi6MiekJwmd8Vxb286/XoKWFSqpZCNBBGrExtuC2i9+A/+D/TGYSM3n1jtBs9GQa7Bcx mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3jx6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 14:58:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JClHwF008306;
        Mon, 19 Jun 2023 14:58:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9393sphj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 14:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHfPTqIn3x7HAf5H/mgNW+7ZLaOJToYXhl2NM9RirUrYGtPsWuJcAUQaOdJUV7Xt0rm1VMJOEVkUOYR498b4mleQu9ZJXOPG9dolb3xfEv2d5h9bAoa+AvmStEL02HAMDCOfH9jX4Sk9MeLy2V1aCG0U8YiyCRJR3cdERsVmKVuiVlmg8L8Skonw4XxrS9KOYYV9YBoPpqypgF5pXAq4iw8cin8VofN2eO5wbalKSDVtB6TlDrG5MVbUQhh6KX4TKGZ3AVgGRrDDM0XIaV1DwR/CS4fGiurC2jPcCVJshWTFecPznOLdHil3wkd1GBmxw+ISMeZdGhlKOw8j+6Pw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy/o3FgerajaMAGm7n2jMETUlBCCFeGfSqsYnbAzb0U=;
 b=fs4iyUoIAIKOYAR+vdnTreCN3WH6tyiHGyyCXmDM8NAqrCiojZN5LC9kxrecgekkXN3NhSCXwTOupOdGS2H/gKQlO/MoF68FOYTVOa53QxxciLCFcFByoZe33s5vSPp/9gCYRcHjd2v3/7HlsHnMSwjj0RLNbe6rT7UbnJ330o2TsXj6cHYHN6voTWGP1J/OKsiWjTpXBr7TY2D4rwUINEYwy/P4KgsGG0kujgD3CkwD1wBy+2XiKGMRCvjRG4aPSTbTt9SkQCbs4g6RaCfW50P1s7v0tpQiAhxBhzR6GtAnHiGgeMLJwe3uhNXpcw42I/42NtWPRY5n11w6t89tZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy/o3FgerajaMAGm7n2jMETUlBCCFeGfSqsYnbAzb0U=;
 b=AmkJFnOhO3Wf/KXw/5emKvAPVlRbc/kIXtrL+GS2kN/oG94nKd1z+PkZxLe8ETdKu5cdVDVhUTQGX396x+uuxoHlJIvEBpMCkfZEoky8tORQpIJC4QaYbesFctmTRRsgZH/Yxgyx4Ak3X1LZvFd7eOeUcfVlNG3nNeYGoA1LLIo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:58:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:58:37 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Cc:     kernel@xen0n.name, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, peterz@infradead.org,
        frederic@kernel.org, akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        eric.devolder@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 10/13] powerpc/kexec: refactor for kernel/Kconfig.kexec
Date:   Mon, 19 Jun 2023 10:57:58 -0400
Message-Id: <20230619145801.1064716-11-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230619145801.1064716-1-eric.devolder@oracle.com>
References: <20230619145801.1064716-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:5:bc::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ef0668-0762-40c8-5eb2-08db70d5a91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWQHUe9FwV9aVWBcHHfAZmPhXkc5V8/2FjS1CNqPaR88zzzWnCHWuSneEFQbfE+8aSBsQi3MPJypniVjxhM7MqTpvvQ4XZI6ZBWd/xAqrWFsD6sH85LjvyGSxV1LTXQoeE7BxviIoFxqhej55qs5V1bCv+EF66nQoAqfb5IcGntLsYZC3hYtKHNrM90GHxao4nTxCJUghTVPoAnxtMylkmghX2i8xg4gqB6VjlJ/RevgCVpVRSJR4ppcMhg0Qhz3LI2ocgc935OllIyl2GdSN8tukX9HvjwZmLKojViojLsri19YGfIi2/Kmq7lKM/1jP7Ug3TnbNmHhOG25F7I8fS4e4MEPC08aFrhpvSAjgokVKVNUV6y2ykr5I+fFk/2P0BMb3YmjlPYwPuTAwky/GbAkINR2GURjs0UKunr7GK2DMQ3EMJrMRfRd2DMkLP2ubSUHHusSnkz7ysy84OIwcdz/p/Kd2XFwuRgvJlhQR1gUujtWEXtT+D58mmj6QP0KXmDVWrH35HJGHcBkrAFN2oV7G95H2bu2CB7/HOYRRLHi1dhWSDfRbuOivj6NEZLyzXhMAi5NFW7uleJm3lOfXzlxDHZBt9YCk602KzwGgp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(7416002)(7366002)(66946007)(7406005)(8936002)(8676002)(66556008)(66476007)(107886003)(1076003)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(41300700001)(38100700002)(5660300002)(4326008)(316002)(2616005)(921005)(6666004)(6486002)(478600001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0EdLcV0OFh27y6tGV5xlLwnNysfxwFnlQMJGZNwltiZ4u7d8cNUmgbxMhMQF?=
 =?us-ascii?Q?3Kvaoiu1kIE+fIil8lFGlzktHrQqGgq8ZTzPuEwDfC62dK32ch+TocjBLXt/?=
 =?us-ascii?Q?KGh0vth1AheiCUzz5thCCuBIjeaue5/kP6c0NT16rTsJVzA1X5AELE1LGlvg?=
 =?us-ascii?Q?P61mlgvpiOKpdGoy9i7y3bACTptnPcs+GI1o/seZ9Hi6RN8kalGBZEpOR4Ss?=
 =?us-ascii?Q?O4xNk2ljxUWOQ7x9uqkc4tM9F0sosbVSdrAvCCQiFGdWM+BfPAXNWZ69+P3R?=
 =?us-ascii?Q?xYJPs+ovtLmIUHPqbSrP1gsFICx3gumFt0YpUSwpMm2mOFjum1ww0r58LyXH?=
 =?us-ascii?Q?G3s2eOY0h1aRx+S3sc5Epotw749hDGhOcf6mwObB+3KM3oy5CQCMOoYG8TJp?=
 =?us-ascii?Q?984p17vdQs8HJD6u5mHf6W8abgaTs2a9XWtwzikjUEwo/lt5ebpHHEUcexsm?=
 =?us-ascii?Q?YoL/p8gwyJCui3xxJrC0Ajs3ERntOY1LBGV41cmKeymeLb2taX6x+PyYC+37?=
 =?us-ascii?Q?XyjfA5Y58PwKzGg4EOiqggeSs8c0AUVDZo2seBnSFPS38aNYf6eg26dpsGJo?=
 =?us-ascii?Q?E3+r5E62U1rlMhOWABI8XfT/DWqFHUPVHQn/h9ocaNj/wAzXM/BnZVu3pVcB?=
 =?us-ascii?Q?5rmO3uOy646ArzzReFIbloxpV8EbTZVBYPPu4PBcJ2fPMYk9cdixGs1keitU?=
 =?us-ascii?Q?5gNzjWLJNNC68c8rSwE1RUKDfFowgCZoCbMYSSTp2wuFzLY3b8q0u8RKxt52?=
 =?us-ascii?Q?1256SvfH4JCB17PNP/g/nMdT8wurF9oUK7KuZkusBhF86hXBGJHKAAAjB/n+?=
 =?us-ascii?Q?GGrwYQPuQTzBEo0uF3nQT7AsJY5M3/6UlaOcvskG3QqMaVDKSzeC01YNHdsj?=
 =?us-ascii?Q?EhQ21wzg2nzI++kQgoDwfyimz3P1Tkd7BbcOCidoHATFalxvMahW29KPZgyx?=
 =?us-ascii?Q?ENQBYJg/Sa/ClLFYdCj91tnmRvCwbcFB9HbeQU+rOXCjmX4NdHXErdQFe/wv?=
 =?us-ascii?Q?MFSrW7nbGHMRljForABG7G1MMecpgMoLaz3QypCpBIdGBEaJrH3MWEV+/GW4?=
 =?us-ascii?Q?QBHSCuf7pVS4Z4gz+ekzcsRzQ+SGbcuATbZInjzT7GBN3tnp7rkrAsiIhwbC?=
 =?us-ascii?Q?6ZZifSkrmszHVEyWDqF3KEG6lV2TDrOepZI6C4zTETLVInG7KL70uqbEP4QN?=
 =?us-ascii?Q?tybEIdD0/qx/tluigg0iIxfLtRbCPE5MW4ObrnGAPAPnYfXHapTdANgSzDJZ?=
 =?us-ascii?Q?J632Hl2cRDpGtZuaJV4F2xaJfyOQs55ja0y5ARZVhrTD9A8v/vBltkTIYS6w?=
 =?us-ascii?Q?lBdZtgCUBoPyJLggyrcBntuojSHFX8nd/E2A7O188otw3zhSyZAXhMqRp+jb?=
 =?us-ascii?Q?whsaWIFD6n9NE4jkA4lCURU0pRd5E+k+i03Mp9Tr065LTS+gN2ZT+kquRrSP?=
 =?us-ascii?Q?IpybM9QQE1rBULR1sp20gLjb5QVvCZqqMgxavFBK0iK6OgfzpxzSJR+IZN/h?=
 =?us-ascii?Q?WnqapfHD7KcE6UiR0yRcGDGGE4QLI4lTZlFfk0/0A2f5ETxZCL080QGal8wQ?=
 =?us-ascii?Q?OEnUmtkP6lJebyhqWPoRCfocvZTFUFoGC9TzfEyC75193GBANTma7h6+co/1?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GlFYz2w18Z6314r6zZNw3192TA5XmXQev7t++VWztaSmrMh6HF3dXiGD1xy6?=
 =?us-ascii?Q?sq4GGjxwpfcxiswl4IR6i53HIJ/SHARL5QfVyl667YDyH8FPHriVtsi/jwjR?=
 =?us-ascii?Q?tKSsiFCaoiLfUPx2sWZdQNC7WvFjkbvXCmwcBpIWRtT58BrVOMT3B4K4yEsA?=
 =?us-ascii?Q?B2YZ4JrlGFnCveAvmIVd+tItrQpCk5SVsJK4Bv//dgZLuSrAaXU6gju+8vw/?=
 =?us-ascii?Q?H5htN20TIkhQe68cWfYYp59x/QBbQhVPHbJro40iFhtMmVQ6S8geQ9dmMVCM?=
 =?us-ascii?Q?emUYGLu2fEy6tTSO1SpZDOtMI/rPm3t0+xQAfzI2khZNdFa3bcYBgVUN64WM?=
 =?us-ascii?Q?WI1CoavpKrpw7A12qYmFktVRi7pz7zv90SndtnIOgL+pMYBY+cJFwul5phZl?=
 =?us-ascii?Q?0d1PKjIZEDIVG5/AS8Ya0+PIB/mZFxYtI+iCCETaR6+MNPKas3yl1bwThWHd?=
 =?us-ascii?Q?3htDfMnAZny1ocTGGA98ednpYNZcmRSz8owf4iRCPqCaqj4l3aahAP1cYMbQ?=
 =?us-ascii?Q?4MIV194re7Kp1PJU86mrdxoilKaC1BelTacMJka9CrHzyOTpkIcrxV3vXpTd?=
 =?us-ascii?Q?UejnxoGKFQnYMOD/fxwQtSoOma8Ivw6jkJL2nBaG+YIU770xF6Cqw1XIsjF3?=
 =?us-ascii?Q?6VLtBnkMbNFmC9O3HTK4MbB8TuydW84Rr+m+EiHlEqnUXTBh/hb8ncnYmGZd?=
 =?us-ascii?Q?f6jtAI0v8FKv99BHE3zFLYMSU5DD8Fp1P84g65LB9ec6oSr2OwMu5p9CRL2g?=
 =?us-ascii?Q?+B3Ydli8iE9JNRhPF4twy7tz9LK10REnUWB/mk+w1QgUQGjUcVQktkGQY4Pl?=
 =?us-ascii?Q?Jp5qoXrzIG6D8ox1h5Nj2mdAGD/30+7qsQrSksxLVZc4eRg2G9Lp9X+92Liw?=
 =?us-ascii?Q?/9nPepausJ1s5WQUGsFM0oM9PA/lbMqGMW+icOOoHSkxQ9D3xw3uh3LunZiJ?=
 =?us-ascii?Q?jm/vG5Vr4t8ZDzW5BueSVNa3LES8YAthRdAuTR5+aq8+8+jhukj/yd4+Ftlb?=
 =?us-ascii?Q?VOXwUObTigZnHsJtOVGHEiGITEIse4wss5VYJe246cq2XMEo2u3SWV2lGkAD?=
 =?us-ascii?Q?OykjYIwEfJ5OYF4WN8XN2s/rU57XIydA0wFIn8S0rPHPUhGY9j0nd59p3NhU?=
 =?us-ascii?Q?UrnSV+qFOflrjNtbdbC1VQ2vP76nuOqCWe7Nfh0/esYHIEf+TSDofISsqtTb?=
 =?us-ascii?Q?VvYriByqK3t5PDkNexbN987UFrv6Mf2Yb8mMFLOXtCIYy1sQIjy+pV806IDX?=
 =?us-ascii?Q?ss6shhWgbKZsyrX+6SM/B9vazzZuxnVf93PBmwF8Y6DV04ktacWs4u3JO7Vy?=
 =?us-ascii?Q?3eo6Kf+uI7/6pMvrPL5WLSJGbGoSqnZikQ9oz317PFSH8nKtbEHb5g3ojaKk?=
 =?us-ascii?Q?2SaYAhs7LwW2n3A8G/r+5MwctIFjQqZdcfSmjNfEQwRd+63b+TB6hrAya3br?=
 =?us-ascii?Q?eDHi6wo7JLVlxpWTqcJ+OKJMenKep0TfmejSYIKztYQjISSlSpb9WXPHLloh?=
 =?us-ascii?Q?ie73ZXACcrFWldncxfjCupARwIZzYBm7iklngivNGGohoY5WkxM+CvSpUjiq?=
 =?us-ascii?Q?AooBHPeoWCUB2PyedxfVBRkyLa4IcW5keOM8PwRbQIC0IwJG7gYbEpwwj15h?=
 =?us-ascii?Q?Og1kqhedB/cC6Hum6+JB/bFQO+vYM/NOPB6I4p2Dfoqth1DdxQbybI2VO7W7?=
 =?us-ascii?Q?6KbFL9ECShoeRNiMgpVaIYV12Slan0cOtAS7pYY2XU5M/gxXtkMhD6ThBmNj?=
 =?us-ascii?Q?WkyYDjtUFjw4oQTpLU3sWIjhgZAmvi7swKfkg/gx7jtgeRglADPl4KwTsaf9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: YYhCAQe582ywlG6ghe5tK9JxMREtRq01t2Kk4NUgTkR9UJ09hS7W9n7WK5hsicu9mTiMYr+wyHij5E8Dz6RLrFkwLlr5y28FuZshvFIdPkobREGAy6MRwgvGmFeLUNZ5vnErYLGAyzhlqKfzFq7XF9Hjh02XnONcI6fM5XVOjrM4CCCgzzPdkbxT0LfZBpeF47sZbs+giQEQ43iQstjWL77dOEyH+/0z1MNpzzr884riRuGnywE26WmI857GN7dy3L2C93VaUl4n+przR+9j+sdNy6n8SDICRWbCInb3aNX5fNgkg7pGIpGAO8/55/EmFEDKSIs0KpjVQbXN7LJyQ78Z5v2ivylWLMyXX2h9WOo9m3IbnhYvFB2iw5dc0JtOj5rObaCXoRXP/7Ukb6MK9SQlmtcDcexVjUsXjsR2sNSPIR5XTFE+UBrl78KeHeCJgBxWass4h4GXXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ef0668-0762-40c8-5eb2-08db70d5a91c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:58:37.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5JKBropzNdAz/mKwRSnQAplpDoWpGiqr/POpXiGD0l/qN1d2m1Vk2+XlIHGH1YLJWI8hdvP4rEvOHuDiy3UlqB/314DVlfmRDap40kxsRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190137
X-Proofpoint-GUID: 4xrmKHApVN4nWURIZTDgX2IyR_VN_FAY
X-Proofpoint-ORIG-GUID: 4xrmKHApVN4nWURIZTDgX2IyR_VN_FAY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec and crash kernel options are provided in the common
kernel/Kconfig.kexec. Utilize the common options and provide
the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
equivalent set of KEXEC and CRASH options.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig | 55 ++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index bff5820b7cda..70edbda08ae3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -588,41 +588,21 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
 	default "y" if PPC_POWERNV
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
-config KEXEC
-	bool "kexec system call"
-	depends on PPC_BOOK3S || PPC_E500 || (44x && !SMP)
-	select KEXEC_CORE
-	help
-	  kexec is a system call that implements the ability to shutdown your
-	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is independent of the system firmware.   And like a reboot
-	  you can start any kernel with it, not just Linux.
-
-	  The name comes from the similarity to the exec system call.
-
-	  It is an ongoing process to be certain the hardware in a machine
-	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  As of this writing the exact hardware
-	  interface is strongly in flux, so no good recommendation can be
-	  made.
-
-config KEXEC_FILE
-	bool "kexec file based system call"
-	select KEXEC_CORE
-	select HAVE_IMA_KEXEC if IMA
-	select KEXEC_ELF
-	depends on PPC64
-	depends on CRYPTO=y
-	depends on CRYPTO_SHA256=y
-	help
-	  This is a new version of the kexec system call. This call is
-	  file based and takes in file descriptors as system call arguments
-	  for kernel and initramfs as opposed to a list of segments as is the
-	  case for the older kexec call.
+config ARCH_SUPPORTS_KEXEC
+	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
+
+config ARCH_SUPPORTS_KEXEC_FILE
+	def_bool PPC64 && CRYPTO=y && CRYPTO_SHA256=y
 
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
+config ARCH_SELECTS_KEXEC_FILE
+	def_bool y
+	depends on KEXEC_FILE
+	select KEXEC_ELF
+	select HAVE_IMA_KEXEC if IMA
+
 config PPC64_BIG_ENDIAN_ELF_ABI_V2
 	bool "Build big-endian kernel using ELF ABI V2 (EXPERIMENTAL)"
 	depends on PPC64 && CPU_BIG_ENDIAN
@@ -682,14 +662,13 @@ config RELOCATABLE_TEST
 	  loaded at, which tends to be non-zero and therefore test the
 	  relocation code.
 
-config CRASH_DUMP
-	bool "Build a dump capture kernel"
-	depends on PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
+config ARCH_SUPPORTS_CRASH_DUMP
+	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
+
+config ARCH_SELECTS_CRASH_DUMP
+	def_bool y
+	depends on CRASH_DUMP
 	select RELOCATABLE if PPC64 || 44x || PPC_85xx
-	help
-	  Build a kernel suitable for use as a dump capture kernel.
-	  The same kernel binary can be used as production kernel and dump
-	  capture kernel.
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-- 
2.31.1

