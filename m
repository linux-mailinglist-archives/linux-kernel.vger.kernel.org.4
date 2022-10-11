Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102C95FBB08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJKTFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJKTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:04:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36685FB9;
        Tue, 11 Oct 2022 12:04:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BJ0gMl023365;
        Tue, 11 Oct 2022 19:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=G7zjC5wcVf5kjNCIH8/SJOAWq/hmsfJEJX5kliguHHI=;
 b=Ojy0lpr4KO1jabo/nvWjwjv/MtsED3y9xfWGq24v8YGU6qenXxUmFSLYdS2bdkzuuOQY
 BG6Nlav+Gm/nZNNlNSj0pJYFevL35j9obz4u8vwwsV/dejpgv+Sld0nYgFFbLsd9kcWM
 1Lc1GhNXQ/U1AzQBenh+lMxyi7ke4rK4U/cWJNtFsqjQ9E4O2JrL3xKbgg5N/fZHAhPe
 Hjr2N/w+bT4QcZ3t3Oya7SeqGXJaDMbbgUGX+rKjLEieM9cgjAaggWqB0Loio4YR+Zkd
 /Btm+v694QNTkD8dPGhP9U1LRftFfhCKtbRHHotibd6kdwHeIpua11yPR3HZWKLNGisv lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtfu11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 19:04:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BGI3Qf027339;
        Tue, 11 Oct 2022 19:04:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynag9n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 19:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpNCSaHsd3dSo/9PpPLO6c1p2bNO24phktk6kcOqqdX1asxZCFikDDF1CTGTmi6Zl1sUK5pYj30dfBlunwTS7k11BZAmLK0I0v2HPIt5eMe4CeiP8rudLdkz4tYugZMSqrQ1lrDCtdhhhrP9i6ctn++XeS8mTcB5IXTDxAtQNmsK/n0QvG9DHIGYByaM3B9mXPUZxQxRO7yleuparNhYru4WpoHeLxcXYd4F6sXO/wizNb/V0B1Ullqaz3gJ0iyM87vucHANYl3w9k3f6WM876BUX8cacrBdatWc31IHgTk1w5rn2HOZ7saOtHDF9W2IX9l7sdvs5R7aFXRIzOeKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7zjC5wcVf5kjNCIH8/SJOAWq/hmsfJEJX5kliguHHI=;
 b=b5aixcU1EhdT7kt1UYmPdXkDa5ec8tp32GCnecjJt6W91AeTB/xAb2BDxMAPym2wuuucQhOY+4ehW26FOd39NJ3UhGF9Quc2AEEzJPi16dNDXVOsr41mdhIWwVJPaBbXZgCCuqHEMqIxZ7+63SJ7qP8QguktFpAP17HIw8xkW4Zx3SQSTwinNnN0/mAXzfWxdKYwVifNFvmSinEmR2FfG73Y0fQpFniObF/V1JCxa9S71IVg+YFIduftGeOs451PHgwoZnmVrLzXRbOPEJmQiAgoyq4GUZGr2gQw+6g/RGFAvAMlKhSNDiMy+Me4JgftFUgoBgavdYzGQtBtFiLNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7zjC5wcVf5kjNCIH8/SJOAWq/hmsfJEJX5kliguHHI=;
 b=JI9VYz+mi1FG8bA2sxh6W5n4+dgNvSCmKTM9y7KTa7KoSkq30BqevO8CpWXgHdQ1Ph/2w6pbUKBdhCquaolwTxlv65Ka38exR2cqnhzLy0WziWkvB49nXXyO9oYkdTTUu+LEJYmnMAk9hh+gBqAwUgiY2cPXGG27cFMXnNwL+zo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4396.namprd10.prod.outlook.com (2603:10b6:5:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 19:04:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e%2]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 19:04:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Observed recent memory leak in __anon_vma_prepare
Thread-Topic: Observed recent memory leak in __anon_vma_prepare
Thread-Index: AQHY3V03loebH+661EK2n5Cgj3aUWK4JV7+AgAAFoQCAADB7gA==
Date:   Tue, 11 Oct 2022 19:04:37 +0000
Message-ID: <20221011190431.7avf4pitqy67doqf@revolver>
References: <CAKXUXMzmfeF9K4SkUcR2i6T+ZqEXvwod4hOzCPfQowMJULy7eg@mail.gmail.com>
 <20221011155051.qgwfbbeeshvoaotj@revolver>
 <CAKXUXMxzsmQO=trGzA7DJVpLw6HTaRMrcYeyTfqeX-3r0-KaJw@mail.gmail.com>
In-Reply-To: <CAKXUXMxzsmQO=trGzA7DJVpLw6HTaRMrcYeyTfqeX-3r0-KaJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DM6PR10MB4396:EE_
x-ms-office365-filtering-correlation-id: 7622cb90-3711-4f8d-70b2-08daabbb717d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: toy+PwoistpgKDacEuFfBEIMGyYosvaUgcX1lNCEyDS4IAODbo39vTVEY/BffjWIu8BlZou5dhlxzXAwPq/hoU3PaC4+BJkIRvR4EeSsMjhmqIBBblUF4/QKxVysZPfRUzsMR/Rp77T56OrzGUgwHyuQogCkQoHrtQYTcOFOnnHCiA2ULoHzMfCtnNkhMXey9KlyzcJ0ehFu4VEGj4EmWcYrRVZsyGoYGmBrhrimaxJRnbtNKteTOk7jpC3427vXBc8wtwOIy44GXTRfCtnrq+03c7WHxClo1jc8Q+iU/cot47zdII9YoIzj/KIpjvL3G0TFxEoWmTMBYQG7GuP2PajvZPL7f/NOFxj2oiSPxpeoX/4NH4Tg9b9yYFc+7yCYHxk86VZ/nNtu96u4asB7XfTL/GTw0yM+UTZGYzDxFG02mXoa+6YUW1IM19ghyLCPXB/z7C+4V7ePwd3DhpiZ9UGPpe01pSsJveznGBJNoQL+PXWAtEKRQKKbTswH0DQYEDAT3LP4h1qoMBPVd2P4BpJHNfoMEB9imOCbpWY7AF/i2ddEkbxtdaFHZVFJ3ssbTGNg9gny6Uq3RPtf+4UqbBG7MqCHCw5xIyEO6e6QXhioe8iLLZkh+RwmsBmrdm9h/Y3Md+jRVBz7sii7D+8IOLvUNPRQbbSZw5FPRnAkzJrJWJ8mB0ArG+TfORlTsbDz7iKA8fY9mBGKJZ/HhfKYFAJjoaz+Bt1UoD6m02M6qbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(2906002)(6916009)(54906003)(316002)(186003)(1076003)(6486002)(41300700001)(66476007)(66946007)(83380400001)(76116006)(66446008)(33716001)(66556008)(8936002)(91956017)(8676002)(38070700005)(71200400001)(4326008)(64756008)(5660300002)(966005)(53546011)(9686003)(122000001)(26005)(44832011)(6512007)(6506007)(86362001)(478600001)(38100700002)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ejPZZbSkBqnTJtHAD7IrlTIA1J+dS3XA7UiZaMtTp8S/EgzfA1FmrIwOSA1o?=
 =?us-ascii?Q?0ffZyUToSW0WKVlCm8taIiAzw/rxzlFPBXUWS3cc9FV4oNJj9wVAZoVy9t2J?=
 =?us-ascii?Q?pU3WlUva59zkAewwmxc3S4y9BaAL/h+xBf6s5A3dK0BnFigJLJwzyXuQQTWD?=
 =?us-ascii?Q?pWfmSAaBfxla3rDKs06De3Ncf75jqfkdT8uWAIjIE9vxpn4dAmo/P89y7Mb1?=
 =?us-ascii?Q?yh7Oo3Jrt6B7hstsYQTsphhlBp0CYh2xEuSvmbr8DSaKtBfw6ELDFlMFmsST?=
 =?us-ascii?Q?YZVPDqXhNak2kDxmLCbwWlwgB3/Z3RyMCF0YgakQlkvYDd5GVcaAQX8XfK8f?=
 =?us-ascii?Q?d5knPdP8lubTeQ4xbLSR36ubZ24GF8xpOYppfoCxlp8i23gLzCGK2xEApFj1?=
 =?us-ascii?Q?c66oXgvWMFx4YQQbPN7Eb6nqmtX9hlDDqqXI5sGcN6Fvu0Q3Jf5+l4MAB1Ex?=
 =?us-ascii?Q?ykEd1V6J11jhwSt6pc2z39Vi4nQa/VyzbJG8pA2af2KJxbgyZCdXjQdJoBK6?=
 =?us-ascii?Q?kEeoEJfbpN6Yz5L2yye7mYFAoio7wDJB3P55jFJvSvUWKe835QOMWHWXN8V3?=
 =?us-ascii?Q?bpG4ofix+R+rF4QwGhvWFDZkaZcshs3l4LuVDoXW8yM25EeIgN3E4nARx9Eq?=
 =?us-ascii?Q?ViT8wUsr/ztw5QFqAkku4SziqQ2NX+UdVIWSh+7+hZ4IoOi1p7SKjoUmn0XE?=
 =?us-ascii?Q?EOdTwE3ofcvyBZ6H4AMED6wiWarZTXBzBI6Ww9dsvmSHJXaXwbNKAKw4zkFd?=
 =?us-ascii?Q?V7sLiHwzAZPY+zQ5AIBoh7EK2M4yTNMw7Sfz9Ci1ZO6XAc1Znqs/uaI5MBUm?=
 =?us-ascii?Q?ubV+REYx4qFQbDJNKF2B4BbJ8cwr+q3GDHbIYAWAU0q5enM6QPHTXB+vCS9D?=
 =?us-ascii?Q?5lVGkId8vgCUeXpyFLP3Fq94GXRD91b0/SciMzxld03PjfNJ4dqDePlSbIcb?=
 =?us-ascii?Q?VAqxwkfMPP0CdeHo5U6baDTWy9adL+i3G/rv+V+rDlmFbpbOjMcgOq0daNLS?=
 =?us-ascii?Q?k9dW19bDXJbHhG4C7Z8tqaVg7RDCqMOYZNK05eVxVfhdjUkzcdTSof8poC4h?=
 =?us-ascii?Q?6cw39f1pXvIsP9ZfM06PCbKRJx8lo71u/CHzfJzq9Ej43pCcVettoyiNXzmk?=
 =?us-ascii?Q?ooLPtGCn/dON1FQ8WruSrIjkuE16Nufx01Pfdz1spSrizMBulfsVfM4dW9dn?=
 =?us-ascii?Q?YXaN5WQ1WoI0eO18wMR93LCdIfO5IHpu73PO4jySK2KI432WzZLNlLgsCKUm?=
 =?us-ascii?Q?2TJgNoNl9Do/RvhSgYpZed5zACPvP2JxbH2fuuwmrUMtkDPhngWpJL+pqWxb?=
 =?us-ascii?Q?ArRsxfVW9OSkgJQtl3G/Uy59woAqrZM/Q95efFVhzG4Os+NUrlyRMgXtUDOX?=
 =?us-ascii?Q?pwvNSNQ5CGkSbEDuTsGgC6HBMXDtVZL+vfmeWefJZ6AFmPooZ2BanOqcHY+P?=
 =?us-ascii?Q?TSDbdc4pOuuP5gFAgGSIVJicCWCRmWRDw8WuZgLh56bcGlT5nOKsa2ziTCSu?=
 =?us-ascii?Q?89SIR/hxQur6Aq+W+9REmv5lX0VMJ7Cdw28uABwFXKjH9vpq0UzHUmoFg0KF?=
 =?us-ascii?Q?IwsvPhZ11THpQfTCj+DYL4cifQKc4TdUASop2mxc6UlPitR2vvL+xT5+uFED?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9633F0DF8CCC3744B53F61B2F76DCC01@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7622cb90-3711-4f8d-70b2-08daabbb717d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 19:04:37.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3/9h7gLBTZcW5xBqLPSGAYRJbe7S3DKNu9M+Gafau1jY4VwvRYL4q+nYQfPqqD+ClWo9lmm6FDxjjIedi5QEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=714 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110111
X-Proofpoint-GUID: UfM-XjIi475OgWF3G5KDjKcQGq5UDHhr
X-Proofpoint-ORIG-GUID: UfM-XjIi475OgWF3G5KDjKcQGq5UDHhr
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [221011 18:11]:
> On Tue, Oct 11, 2022 at 5:51 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Lukas Bulwahn <lukas.bulwahn@gmail.com> [221011 12:35]:
> > > Dear Liam, dear Matthew, dear all,
> > >
> > > The reproducer for the 'memory leak in __anon_vma_prepare' bug (see
> > > https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3D31138=
10b9abd3dfeb581759df93d3171d1a90f18)
> > > is reproducible, it is triggering the memory leak on the current
> > > mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
> > > build config is a x86_64 defconfig.
> > >
> > > My git bisection showed that:
> > >
> > > 524e00b36e8c547f5582eef3fb645a8d9fc5e3df is the first bad commit
> > > commit 524e00b36e8c547f5582eef3fb645a8d9fc5e3df
> > > Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Date:   Tue Sep 6 19:48:48 2022 +0000
> > >
> > > The git bisect log is below, note that the commits 7fdbd37da5c6,
> > > d0cf3dd47f0d and 0c563f148043 are marked good in the git bisect as
> > > they caused bugs "BUG: Bad rss-counter state mm: ... type:MM_ANONPAGE=
S
> > > val:2". This bug report might have overshadowed the actual issue, and
> > > hence the bug might have been introduced earlier, but was only visibl=
e
> > > once the Bad rss-counter state bug disappeared.
> > >
> > >
> >
> > ...
> >
> > > # first bad commit: [524e00b36e8c547f5582eef3fb645a8d9fc5e3df] mm:
> > > remove rb tree.
> > >
> > >
> > > If there is more information needed or other bisection to be done,
> > > please let me know.
> >
> >
> > Lukas,
> >
> > Thanks for the report.  I am trying to reproduce this issue and have no=
t
> > been able to trigger a memory leak.  So far I have built using the
> > defconfig from arch/x86/configs/x86_64_defconfig and run the C code fro=
m
> > the end of your report above.  It also produces some output that is not
> > captured in your report.  Are you sure it's the defconfig being used?
> >
> > ------
> > # ./repro
> > write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such
> > file or directory
> > write to /proc/sys/net/core/bpf_jit_kallsyms failed: No such file or
> > directory
> > write to /proc/sys/net/core/bpf_jit_harden failed: No such file or
> > directory
> > write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such
> > file or directory
> > ------
> >
> > Note your output does not mention softlockup or hung_task issues.  This
> > is on 6.0.0-rc3-00207-g524e00b36e8c.  It is also worth noting that the
> > resulting kernel does not have /sys/kernel/debug/kmemleak.
> >
> > I have also tested your reproducer with my own config which does have
> > the kmemleak debug file, but it did not trigger a memory leak either.  =
I
> > suspect I am missing a config option?  Are you using gcc or clang?
> >
>=20
> Liam,
>=20
> This is how I am building the kernel:
>=20
> make O=3D$BUILD defconfig && make O=3D$BUILD kvm_guest.config && \
> ./scripts/kconfig/merge_config.sh -O $BUILD -r $BUILD/.config
> kernel/configs/syzkaller-recommended.config && \
> make O=3D$BUILD -j`nproc`
>=20
> My syzkaller-recommended.config is:
>=20
> CONFIG_KCOV=3Dy
> CONFIG_KCOV_INSTRUMENT_ALL=3Dy
> CONFIG_KCOV_ENABLE_COMPARISONS=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_KMEMLEAK=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_SECURITYFS=3Dy
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_KASAN=3Dy
> CONFIG_KASAN_INLINE=3Dy
> CONFIG_FAULT_INJECTION=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> CONFIG_FAULT_INJECTION_USERCOPY=3Dy
> CONFIG_FAILSLAB=3Dy
> CONFIG_FAIL_PAGE_ALLOC=3Dy
> CONFIG_FAIL_MAKE_REQUEST=3Dy
> CONFIG_FAIL_IO_TIMEOUT=3Dy
> CONFIG_FAIL_FUTEX=3Dy
> CONFIG_LOCKDEP=3Dy
> CONFIG_PROVE_LOCKING=3Dy
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> CONFIG_PROVE_RCU=3Dy
> CONFIG_DEBUG_VM=3Dy
> CONFIG_FORTIFY_SOURCE=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_WQ_WATCHDOG=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D140
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D100
>=20
>=20
> So, it is "defconfig" + syzkaller debug features; sorry for being a
> bit too brief in my first report.
>=20
> The gcc version is:
> gcc (Debian 8.3.0-6) 8.3.0
> Copyright (C) 2018 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>=20
>=20
> But I doubt that the gcc version is really relevant.

Agreed.  I had a bug where gcc vs clang made a difference with out of
bound writing iirc, so I just wanted to make sure I was testing with the
same compiler.

>=20
> I am running this in a pretty simple qemu instance. I can provide more
> information on my qemu setup if needed.
>=20
> Lukas

I was able to reproduce it with this configuration, thanks.

Cheers,
Liam
