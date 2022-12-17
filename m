Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4929964F6C6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLQBYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:24:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999966E9FC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:24:44 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH0R7ed027963
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:24:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=c8GLpi7XX90OA9fsdwUPO/6gcpaNRgc6vPTt84IuIrI=;
 b=WeWc6nBdL1PWn3tkiU3ZYMq/wgpflrkdV+KhOGA68dKcocJZsiy9nNRkC7mnzIx9f0Gh
 wbjuHEys/hBvpNtcCHdmi72ZerNCXZxT7dJFTq1o4hRMXe0vRE7w+yLfzLSWLsTt7f8c
 S8C7vggEZQ96bj4XmadM/rfG6vcTfGXgaZ8dvF8V9jEQgzteLGLBQc2eR3YFvwPsAXVS
 yO6HNXbuvATW9DW28vahl8o97OZNXC4UA+oivxWJIxBWTkpnJd0EgLCe+GawtYGyoJzV
 KOfTHoPkAcLsRNhlmZm/1D+N3iOXaUEV/y3c49kfI4caUuMCf4/W7rjQiZqpYbi/tOD2 kA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgxjy9vt0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:24:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O09usdX9zerH8EbMHlStm1V9z2wpDMfX3clyi0+wY+gkh7Lk37brXXOEltTCEAGPkDrkOdSubKTzmYXciG1x++seYb0MLb0zhmPF0VNTiHoPQ71CzKS4Tg1mh7MWTvUKNOwScPgKs0H+osLDoBfTiDHnKxaLINcJCdIthgd1KMlEcJE90wAUqmLYjHyaTru7bRJjD1YcLfRoL52poGTquvKWetMQ0OHnDWFvhEUogH7MVab9SZ+T/CS+u19p+G84XGBhwfkhJOgoUOXPRnMMv6cSZFZv5nbfc6Bhv4gXSNaYu/QtNMOOERgcSbREj+V5gfMm6zlhOqsobZm80VJBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWpWWLqalz31EhaSHFc8Rw7KQla7jlNXmGnwi87RFHw=;
 b=b1g6sDwu85vrN5uWdJ/cps9eYd89BFEQdY7O6RSP99bOURqNFAPqUwHodKJ4R63l4QiJAjnARnWvpnFD1HroadKJVXGl5Qbtft8gWN/6PEVQwxCDukqRlDrtYCLD6cqAenHpwqqOZvss+uYhRy2JOQoOqVW0sqx4K/HAiPjmB+vA4BKOh7JP4kGlnJ02DoIjFRy493h48irETmwIISFOQbmHhlvVH4dPmjhkdSpsjGytms2veFAJmk7crYRJiyxgbOkkLszL8lXV3vshmL0CB//5sWR7vr/IMOJpSV7GIU9iz+aQPurpsA8VxV7Q0NrcD7WnQ+Lg1NrdeczRcvHwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM6PR15MB4008.namprd15.prod.outlook.com (2603:10b6:5:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sat, 17 Dec
 2022 01:24:41 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96%7]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 01:24:40 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Sam Hardeman <natrox@outlook.com>,
        Kernel Team <kernel-team@meta.com>
Subject: [GIT PULL] zstd changes for v6.2-rc1
Thread-Topic: [GIT PULL] zstd changes for v6.2-rc1
Thread-Index: AQHZEbZV5qoraRNshUawOMeFXbcGPg==
Date:   Sat, 17 Dec 2022 01:24:40 +0000
Message-ID: <9956A306-DFFD-4D23-869A-8B6EC0B88EE6@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|DM6PR15MB4008:EE_
x-ms-office365-filtering-correlation-id: 83688216-e98f-4a47-85ed-08dadfcd7876
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gLxDl5ZryoTFFhRD5tt1I5TrhHmPoc8F/U8MS084dENG2GZDzx+wJa24p2rkqIRJNQRS64HQkQXTv6H2sYS20oT+fFZYaIzuKynLk4PREMJnYlySsb+MOMTvPxE75sLnzzi4UKGAh2xzlNuQ/tbaETDYjPZEcBjbiS1zq2pWhE++bpmeiTLmVQ5ab19ODmBJK8hhfxQ0ZsyIFqgert5YHPRwqzU7FGwN7Dn2vTZnbmrQO7SzGh4NAn4TV+hz6kXuvzxBs8yp8B54qebqVcfV1Xf1hpexgVt0yk/Xpv3ji4IrxxEyW3WOdS1zmD1bS7q9qx1tHRzBBoB4LwQvjZEh3eooeAxpIU53hJZzG79qDF7/Ulf2PHOwijcFs7MkLsq74b2zBXhYTu4rieS5lMXJkSsuW3hparRFJHv6aYBTAHrfg4tEVnupTDttD4XICIIxCTo5JSuO5nXgV3GO6MIwV/MSq9g8hOqzhNNLb17VpwPyPqhjhpHQeWwMvg+2NPws1j9qshp/P7FVr7BZMnUSMTyQ0K39Nph5mKmIoXTfrLtS0LZ2p9tEN1iW49dnQ3ELnmVZv9QsvTRkbpsJW29k7m4dk8ZGbWPxXA9gilopnC9UIvUg4VVNsX9KxxWUH+neYbzdV2zIU6gZoylwRwTQBrAuZdrbaMvU0RW2BKXjj2M3lITsfkW7TTXOSGBYdkBpk2hS/idDc9NzaUw/ccnrxX8CtP3n9pH0Jtrvj0z/7wo00F2/V0sFgKo+8bW/O71+WhT7zgGYI+PnS3C1k2eYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(36756003)(966005)(316002)(6486002)(6916009)(478600001)(54906003)(33656002)(38070700005)(9686003)(38100700002)(71200400001)(122000001)(186003)(86362001)(6512007)(8936002)(107886003)(26005)(6506007)(41300700001)(8676002)(76116006)(5660300002)(66446008)(4326008)(83380400001)(66556008)(66476007)(4001150100001)(2906002)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+4uf2K/YtRexObfO8Y913dJiYM1evFqIkkzKjWN2cDVYaIB7LzxfC68vMy?=
 =?iso-8859-1?Q?4aKPY12CGloaEKR/MC+NKmcggQfGtxbup0SQqbTJ9suLa40gSzRGxXWsjw?=
 =?iso-8859-1?Q?yIaFAIRq8HsScAVsnDPLsZoJtA0tX0W89UC4Dc5H2ifuC6Y4ge1JQu+Iyj?=
 =?iso-8859-1?Q?scDhXSnrEjhGyjKosg8Ua2sldCZlRIgmUwl4P/E37v1boKPmMUimtlUMxv?=
 =?iso-8859-1?Q?ljA8fmSkbT8O6YhPxfXSB+EPX/n6QNTQusMwyzaY3rL0xBgrohEE242G1x?=
 =?iso-8859-1?Q?1ypsYeg2UndFOP6gIoEUPt+0u0+x/2V/hySAH379BMbejVoRcMW0baBpJp?=
 =?iso-8859-1?Q?B5XHDmxjh3TPkySEadmsknpgmEjOG/MqUTp735zN33gFduIIU1YRG8+EaF?=
 =?iso-8859-1?Q?0703yzW/I817uFikoytWWRGu1guz0J7l+Z38ri6Smy8qdNjZWgsyWTlH3p?=
 =?iso-8859-1?Q?tk6fg/fhYncuIR9wYUpwSXWBhBr+QNSsRPDfh+pctVbRbChaE3BSVWZB1C?=
 =?iso-8859-1?Q?pndv94kB70MsaUj9eEZXSQM/3DpySQi8tEstnDL6733kNINqrA9VWWhEgM?=
 =?iso-8859-1?Q?QTice/ozdD00BORgqnWmM2cuud8QiQxZ6VbWu873nnBoxKT3/GBno7hI5A?=
 =?iso-8859-1?Q?XwPwZkFatHRVi61cFuTIeQhbPJJ9js5C/WDts6gAyuOWGmHlkEPDGnbfJm?=
 =?iso-8859-1?Q?97rbty0JIU2HfFV99mQkbySdxvw0qU7ETijUHlBgMFQGcbzyf/WJ0/gXnZ?=
 =?iso-8859-1?Q?wozmO2knlfZHpYiBXm6cHo4dmEBKtM61wSyHwlJjgTsLjGLM1KFAcuTlpD?=
 =?iso-8859-1?Q?Nd10Vg5soLlK/W88smIv9HqGqR1jRC5DCpAtfmypnh2bOp0fqUZbqcQdD0?=
 =?iso-8859-1?Q?5bQDKssIfNVz54h0gR6VFLzf/kPh9XtWrTOydRtZVEOiUagg21WJ3umIvj?=
 =?iso-8859-1?Q?JhX66qRObzqJmc1a1kU3w8brqOq0Wollw9LZm6z4ceBxw/9wxkPRNTGm1y?=
 =?iso-8859-1?Q?sNLXH4TlKgAwwKpbwHq0nklYfLHVQnl52U0gfkSnJsbwKhKLUDurOSvRlI?=
 =?iso-8859-1?Q?vX8XJ6ANe+mOSgGB4amFiAWW8ZZcdYySh4+fJNd/Wn8KXRJ1h2P1w0ho5S?=
 =?iso-8859-1?Q?RLDU77pzsKPN/x97uXHMxOdETzAmuINo9OjTeHxkTvEZGqi6xVCZ7noeD2?=
 =?iso-8859-1?Q?ciOuQmEcCgKRhZlYF61nhIinefgdY6mZGqyAXp5ccgNNbWi4/h832lDyf9?=
 =?iso-8859-1?Q?5sSOFed0zEbRV2F4J0M54UY/7Z77FpdbEMl05HF1pf6fJpcv/5ewbraJI9?=
 =?iso-8859-1?Q?No1yCqn8RswjDWiH4SbXfRDmZu20FlwULrYwppCv/WwSpMN2VQGS48Mb85?=
 =?iso-8859-1?Q?4PLS0npDnoTYx+zoLAL7NXjsISAm5xBU+xxnpgjfYHCp/EnB25GcPdjTDq?=
 =?iso-8859-1?Q?NQW6CTp5e9767X/gYDIpeb9CqXdlT7kyeJIZmEuTz0OE+cehq9dzJxCxmD?=
 =?iso-8859-1?Q?lJ6kBSYrYc3wMC2SbcAMtYxk0drBKFEW0csipGbCUjjFSgbTOQ9BlsVqdD?=
 =?iso-8859-1?Q?4H7unykoCgmHPOWO5a6O3seKCu+NGnCJjNZY/wGbtWQuHdOzRJG+I5QFdR?=
 =?iso-8859-1?Q?KQKllEtc5EKBA8lhyU4G0RAbzoUDhEjycI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CC96D8F79D5F654DBB4ABE64BEC5A5C0@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83688216-e98f-4a47-85ed-08dadfcd7876
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 01:24:40.8200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0NkggQeDLFx0TkFanYILnGUO5NraciGuYmAPQRKug8zF24iapcysTd7fMVGWeMp5/PO8vAU743E5nK3VmoYbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4008
X-Proofpoint-GUID: vlcL9-7cji57LMAfGr-rqKSzYPx7WAbO
X-Proofpoint-ORIG-GUID: vlcL9-7cji57LMAfGr-rqKSzYPx7WAbO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  https://github.com/terrelln/linux.git tags/zstd-linus-v6.2

for you to fetch changes up to 70d822cfb782ebed5c41bdad9fa520b5ec1c6923:

  Merge branch 'zstd-next' into zstd-linus (2022-12-13 16:24:40 -0800)

----------------------------------------------------------------
Update to zstd-1.5.2

The major goal of this PR is to update the kernel to upstream zstd v1.5.2 [=
0].
Specifically to the tag v1.5.2-kernel [1] which includes several cherrypick=
ed
fixes for the kernel on top of v1.5.2.

Excepting the MAINTAINERS change, all the changes in this PR can be generat=
ed by:

```
git clone https://github.com/facebook/zstd
cd zstd/contrib/linux-kernel
git checkout v1.5.2-kernel
LINUX=3D/path/to/linux/repo make import
```

These changes have been baking in linux-next since 2022/10/24 when I put up
my patchset [2]. Notably the first commit is a small refactor of the only z=
std
commit since the last update [3] to fit the upstream import scheme.

Additionally, this PR includes several minor typo fixes, which have all been
fixed upstream so they are maintained on the next import.

[0] https://github.com/facebook/zstd/releases/tag/v1.5.2
[1] https://github.com/facebook/zstd/tree/v1.5.2-kernel
[2] https://lore.kernel.org/lkml/20221024202606.404049-1-nickrterrell@gmail=
.com/
[3] https://github.com/torvalds/linux/commit/637a642f5ca5e850186bb64ac75ebb=
0f124b458d

Signed-off-by: Nick Terrell <terrelln@fb.com>

----------------------------------------------------------------
Jilin Yuan (1):
      lib: zstd: fix repeated words in comments

Nick Terrell (6):
      Merge branch 'main' into zstd-next
      Merge branch 'main' into zstd-next
      zstd: Move zstd-common module exports to zstd_common_module.c
      zstd: import usptream v1.5.2
      Merge branch 'main' into zstd-linus
      Merge branch 'zstd-next' into zstd-linus

Palmer Dabbelt (1):
      MAINTAINERS: git://github -> https://github.com for terrelln

Tom Rix (1):
      lib: zstd: clean up double word in comment.

Xin Gao (1):
      lib: zstd: Fix comment typo

 MAINTAINERS                                    |    2 +-
 include/linux/zstd_lib.h                       |  479 +++---
 lib/zstd/Makefile                              |    1 +
 lib/zstd/common/bitstream.h                    |    9 +
 lib/zstd/common/compiler.h                     |   67 +-
 lib/zstd/common/entropy_common.c               |   11 +-
 lib/zstd/common/error_private.h                |   81 +-
 lib/zstd/common/fse.h                          |    3 +-
 lib/zstd/common/fse_decompress.c               |    2 +-
 lib/zstd/common/huf.h                          |   46 +-
 lib/zstd/common/mem.h                          |    2 +
 lib/zstd/common/portability_macros.h           |   93 ++
 lib/zstd/common/zstd_common.c                  |   10 -
 lib/zstd/common/zstd_internal.h                |  175 +--
 lib/zstd/compress/clevels.h                    |  132 ++
 lib/zstd/compress/fse_compress.c               |   83 +-
 lib/zstd/compress/huf_compress.c               |  644 ++++++--
 lib/zstd/compress/zstd_compress.c              | 2000 ++++++++++++++++++--=
----
 lib/zstd/compress/zstd_compress_internal.h     |  375 ++++-
 lib/zstd/compress/zstd_compress_literals.c     |    9 +-
 lib/zstd/compress/zstd_compress_literals.h     |    4 +-
 lib/zstd/compress/zstd_compress_sequences.c    |   31 +-
 lib/zstd/compress/zstd_compress_superblock.c   |  295 +---
 lib/zstd/compress/zstd_cwksp.h                 |  225 ++-
 lib/zstd/compress/zstd_double_fast.c           |  413 +++--
 lib/zstd/compress/zstd_fast.c                  |  441 ++++--
 lib/zstd/compress/zstd_lazy.c                  | 1352 ++++++++++++----
 lib/zstd/compress/zstd_lazy.h                  |   38 +
 lib/zstd/compress/zstd_ldm.c                   |   76 +-
 lib/zstd/compress/zstd_ldm.h                   |    1 +
 lib/zstd/compress/zstd_ldm_geartab.h           |    5 +-
 lib/zstd/compress/zstd_opt.c                   |  402 +++--
 lib/zstd/decompress/huf_decompress.c           |  912 ++++++++---
 lib/zstd/decompress/zstd_decompress.c          |   80 +-
 lib/zstd/decompress/zstd_decompress_block.c    | 1022 +++++++++---
 lib/zstd/decompress/zstd_decompress_block.h    |   10 +-
 lib/zstd/decompress/zstd_decompress_internal.h |   38 +-
 lib/zstd/decompress_sources.h                  |    6 +
 lib/zstd/zstd_common_module.c                  |   32 +
 lib/zstd/zstd_compress_module.c                |    6 +-
 40 files changed, 6989 insertions(+), 2624 deletions(-)
 create mode 100644 lib/zstd/common/portability_macros.h
 create mode 100644 lib/zstd/compress/clevels.h
 create mode 100644 lib/zstd/zstd_common_module.c

