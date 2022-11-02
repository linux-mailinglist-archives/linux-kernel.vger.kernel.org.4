Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB82615D62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKBIL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKBILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:11:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7013F8A;
        Wed,  2 Nov 2022 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667376711; x=1698912711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2NZd1ULSy33tO6Qdc9kHXDJjnJEiVv6Ql0rpj79lNqg=;
  b=nGSLAiHRl5YvndIr7opp9EpO6wrmfocjInbHve5Z/2ZPzohgseUD+LXe
   WMNQ1e+/TiWB5SouEYeFFWefEdalhiksdGUKNOMFyvZhSH1Kgta8nm3JA
   9oz/Bn6g+ndMEnalHWmNzRsR5X2pw1F230XdxYVq9XLzV2S0lsFVi/DqS
   IErBRt0ueifDhsquEmsTDJal1wV4ABTZdfeeKq3YGvvipAhOqac1nekEN
   cp2KngDGXUyenfSJb/yNYT5r7mar8LEjTY+yxcJ1YjTqWALWTVCSISmEx
   Bf20WjDJz/MKhF5ZQtPusWLG7yunw1H55O9mI2w54wNTVC73nimnMFgVo
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="215296179"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 16:11:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHBJVXER/xeXdZH6phSX7RvGIHEiysaWP1sDTI2r5CgTs1LJHNOd+BySV8nYyK7O06Qqi7Nzt42mKsbNBbxIoqyoGsCGJgPUqHNMMW0DftVitQ2P9ERMcZuyf15h+mdl89uHBurmSrZQ/iIwLJZZLiAxOGGOAB1UCOct1wSqsWtmhv2rNdbWQpTpHnfBZe3jQUIGpqMF6Ws2UYlV3Yfdsle1G4KYWMzfjYcHU5Az7SlWM1FrdBt08G6xGbi5qujs5/qQHt1R+xgwEns4fsyMbra+ands5Kd0ZyST+FkOHcdsnvqcAgKzE3Jvmyn4wHEojwTQI1LmoNI7Gn1GhT3Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsGhth2f146onqGXA71dP59yZpFFyhhO3UblY5KE7e0=;
 b=TMbk7vImvInr/tSNvv4NdXN//u2hHC2zx9tg4NcZ71jTlm1vkMWGPkwNDerfK7b8ooxRfXoKyqarrqKnNQobsjAqGiCqHZiIStvQDx6uP8/cb5t3jN5L57bbvf8Z+TcAg6v1YBZtn4M0dwNzJ+N4YgwBWnZfHENr4hGBOjyJBvRX9lKCzAiNuNcR68cyG3Abs8e2eJafjA6GW5N8oFdEeqvRSn4DZj+gIzzF8iBBGCxKCaSsPJrjSxMm4SHjaUhlVqbSMmCiJdcdwErnbxpONDmW3SaY/ktzMbx8R/2Z55TU4RiZPDM4h3ZPrHLsL2/HtEkuGNK/ydQ4LT0J7z6d/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsGhth2f146onqGXA71dP59yZpFFyhhO3UblY5KE7e0=;
 b=ruJMUkuhfwDa6xNHJ4JNCxSo2h/BRhM+8JcU5XefIcnLOIK8GUc8iVLYFASIQjl7zyN7jFcyBKtBE53T26hCoO7ipG6YQbxClUJbdeagGQjZdadZAznV7tdKy8prEnG8BvnFAQuEX9eHijCnqerGy4/nmV3MxA9hPFuIEC75cAk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB5933.namprd04.prod.outlook.com (2603:10b6:208:a5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Wed, 2 Nov 2022 08:11:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5791.022; Wed, 2 Nov 2022
 08:11:45 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: RE: [RESEND PATCH 3/4] scsi:ufs:add FBO module
Thread-Topic: [RESEND PATCH 3/4] scsi:ufs:add FBO module
Thread-Index: AQHY7nxj7+HGrRhWeUGNMH9fsrYtxK4rQcaw
Date:   Wed, 2 Nov 2022 08:11:44 +0000
Message-ID: <DM6PR04MB65757FEDD2FC50077760913EFC399@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <20221102053058.21021-4-lijiaming3@xiaomi.corp-partner.google.com>
In-Reply-To: <20221102053058.21021-4-lijiaming3@xiaomi.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB5933:EE_
x-ms-office365-filtering-correlation-id: aa483320-7e2c-44b1-8a31-08dabca9e1d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcEQgHLepYvbG1P5zqKfa7dzSyuROomfLomU+Metdgu6hv9eZy0git5wbaJrbofOQejennIVhPwESjalRXtqAtKVS3u872ElSfPOy38IDWikYgepWgBgijVchMt7ODUbzK7EPAkeQon5f0mckVVw/dRt5E1iZCdAypd/PKbgVvQRC9CXZK6TKCmo29id04T+wCghnwJ8Nz6E5jAkBE+ziaZ2QDdTAa17ZfcNAEd/jehvKorer7qcNE1DydWYayRQuQJIc3dGvxKg5Ox2ZFoGw09QdeEFvSsxnDIajSRywZD7rUoDYrzPHPwcjC8cYq89JHijagpyuC5fSr55Sj4+dm7gchVkAqu5Gi7mtXFyZLCG5DBNm1M2qpXN+nS00lr811aVSlfpZrgtS+hbsr3D9ZxsS6iaQ5KtbGsEZHSv0ibu7Rs/9+rLjDVPjWoimpy1PDiIt/hVZtFt8XfX2qz73o4ZzW5At7gXE8dn78MHB+OSHnUqnRKj4boef3Ji0FsjpQDAdPjm3XuXIM3RSCdKv66D8wCwsi+NNAVyaJZ9CKijg4K6PJXSdRJTMZ1JObOSwdU/JfGDHzgAsKv2Yqz0z4WyB36x4v+GbI2JGmGSiphlB4JrHW6vP2gnPEVow3clJsreINQ2tCv2foFTJZhVEeuFeqjL56sTHQUoe9rcBw1YrJaUXLuxt1ntO2L/EnLuKliqJIDuUYWFuRcsk5CNkQapLPw86j4F00JVPxk1sJ62ebTJ7l4rC+vkD+OU6cwet4Dlu/X1kBeghu1SMiIlkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(71200400001)(55016003)(38100700002)(122000001)(82960400001)(38070700005)(8936002)(5660300002)(33656002)(83380400001)(86362001)(7696005)(6506007)(186003)(26005)(9686003)(316002)(478600001)(110136005)(54906003)(66946007)(76116006)(52536014)(41300700001)(2906002)(66476007)(66556008)(4326008)(64756008)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nEpnY68SBGeEdhbNYMXBVYAM6r1sAcrSjQeM/8Sf3IbeS0j25nP7XuRVZ+f5?=
 =?us-ascii?Q?hV79pKsGV4Gipxzu9oX+GL9DWw+FTVIryoO9F48khbSbE5sgVnlBvh4T1X5H?=
 =?us-ascii?Q?5FxfxmGHR6GgJl4rwvmZ8co8dSsdSec+hm+dxJOqwBfRmaI7vShMWH9rFCbr?=
 =?us-ascii?Q?J9ZLEIL7HTGldJ9G/UgWujgFSwE4t9urPTUQryjpdJmMvIjPM8TQ0ZOK/cSn?=
 =?us-ascii?Q?hss1Y4J4Zb4ippeowHmhuYdBcPZgRz+/vVXfbExT/T/r7RhsvgfY+JFI0w3V?=
 =?us-ascii?Q?Y7PuVf3xt5UKWZ6qpPDkBAI1PqvMddb30pOb/1YDshsW+LZ0hjj6ic36LO2/?=
 =?us-ascii?Q?COnggl8gQc9ccsRsJqbe6wVD2ZBp8px7l6WngPK3cGC6wtvps4WLW0tgRVEO?=
 =?us-ascii?Q?M2l3vsvST+IVK+l3zcEfG+CYxaHZpb83JO2TexkfIMwGBHfvkY1AkjJtK8kH?=
 =?us-ascii?Q?uUNoCz+IC0X79bti1ZM33nxTggCdvGZTUi5Fk3MXzIRL/fpbuzzdgM5vBT2p?=
 =?us-ascii?Q?THPonEM74p/u+eqLalDSH1OhTH1aA7at8jjPCOp+kufDquJU3rfd7xiZE+ml?=
 =?us-ascii?Q?sp4QgQyv8X14rorXWh9Dsi52DC8ytD/AoysJtOibm7p9DwWaIAzDXwcYyZQf?=
 =?us-ascii?Q?SxZJ1DmoKOknG3y7fLpLD/sPJJmIqrQLsONIwZVeKAN0ZJymoYd8tx1w53ez?=
 =?us-ascii?Q?zYQJ3YZ/D93npV1X8lbX1IQMHuB50urb74QnRTOEP5iSr9D/d1KZ++9xdJRr?=
 =?us-ascii?Q?KQmu2BQumTiszyz6LLlITkuPAQqF7eYfQGvPqfIALR0Er3/YGJ2uEgZ5mr0o?=
 =?us-ascii?Q?O9AWhxCkbJLOPJbfcgKY6y2Y8pRvPem3JbFB7KDi4cabs1qqdGHYIkht0z8M?=
 =?us-ascii?Q?TTbKvYwARjA4KO7kMUmufoQvEdTqdJxlrM00JylfmdHdZmXQNx8xwn8Q3IJv?=
 =?us-ascii?Q?4/7YDyajoBysjmrACJymO8ZzUye6l5tNEy3rVQ44aAl1RWQRNUWTnlYqj3lW?=
 =?us-ascii?Q?sV+SwaZKp95f9AreecNPEx0CiFyMXScmzLnEINY1i/a0sDqn8FXv2ZuOSCG8?=
 =?us-ascii?Q?QhZWWUVYPFjInhxUo31gK78bpk5gbN3WAOlwBJeTrN62S+mDvo4TA5HE0jGv?=
 =?us-ascii?Q?/xRSaQ7yGnp30onI/nGMo5YNBaVccIfCe/YHjSJPNp7ZimEOFSg1XaT9BH82?=
 =?us-ascii?Q?RWMI9Zntob9MFKzGjVRusqKWshjTGHmzBbMt5ASJXgfcU+oDAAT/Z3c442Dh?=
 =?us-ascii?Q?dBRshGVfmMgtTQdFt7KiFSfip2QHRJvnWbsWYFaw+DAD+z72jZ+5JHR5ca2Q?=
 =?us-ascii?Q?FqgFx0IE3HHnIJMnnHiWADI4p9y/rAopLj4LD+65r0cDm6iPQtKL3lD/hTld?=
 =?us-ascii?Q?PGbQetPMFNT8LY/3kNniE04h1WoVISuVLL3d3kzF4Tu0mf5K5OQ0yz8DaPmL?=
 =?us-ascii?Q?dsRnHxVnof18Ht3BGRcKAGnwCqUI5QKk/l1cUk4nWGfUq4+9rF3FbP4eaSVy?=
 =?us-ascii?Q?hWzcecIcP4bPsloC0ICkn5o1J3C2BvT4xgFEnGPST3epbttY39BBh5ZbQALl?=
 =?us-ascii?Q?f5ZpPeTPCyrQwxANNY2DN4jsUTEorSLUKP+B6LmN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa483320-7e2c-44b1-8a31-08dabca9e1d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 08:11:45.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubRpLJIpyz1DE8ruZG7sM+9T2a3/Vwg/e8Gq6/dgdL6GtyI3/msQ3PI6SYV4FOntMQ2fhE4X9WoIVU8Jix9thQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5933
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: lijiaming3 <lijiaming3@xiaomi.com>
>=20
> add fbo module, determine whether the device supports the FBO function
> and initialize FBO related info
>=20
> Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
Here also spaces missing in the header + minor nit below.=20
Other than that:
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/ufs/core/Kconfig  |  12 ++++
>  drivers/ufs/core/Makefile |   1 +
>  drivers/ufs/core/ufsfbo.c | 120
> ++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufsfbo.h |  23 ++++++++
>  drivers/ufs/core/ufshcd.c |   4 ++
>  include/ufs/ufs.h         |   3 +
>  include/ufs/ufshcd.h      |   1 +
>  7 files changed, 164 insertions(+)
>  create mode 100644 drivers/ufs/core/ufsfbo.c  create mode 100644
> drivers/ufs/core/ufsfbo.h
>=20
> diff --git a/drivers/ufs/core/Kconfig b/drivers/ufs/core/Kconfig index
> e11978171403..30d3b6f07f5b 100644
> --- a/drivers/ufs/core/Kconfig
> +++ b/drivers/ufs/core/Kconfig
> @@ -58,3 +58,15 @@ config SCSI_UFS_HWMON
>           a hardware monitoring device will be created for the UFS device=
.
>=20
>           If unsure, say N.
> +
> +config SCSI_UFS_FBO
> +       bool "Support UFS File-based Optimization"
> +       depends on SCSI_UFSHCD
> +       help
> +         The UFS FBO feature improves sequential read performance. The h=
ost
> send
> +         the LBA info to device first. And then instrut the device to an=
alyse the
Instrut -> instruct, analyse -> analyze

> +         LBA fragment info. After the analysis, the host can instruct th=
e device
> to
> +         return the LBA's fragmented state. Then the host can decide whe=
ther
> to
> +         optimize based on the fragmentation status. After the
> defragmentation is
> +         concluded, it is expected that the sequential read performance =
will be
> +         improved.
> diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile index
> 62f38c5bf857..af7870126815 100644
> --- a/drivers/ufs/core/Makefile
> +++ b/drivers/ufs/core/Makefile
> @@ -8,3 +8,4 @@ ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)   +=3D ufshcd-
> crypto.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_HPB)     +=3D ufshpb.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_FAULT_INJECTION) +=3D ufs-fault-injection.=
o
>  ufshcd-core-$(CONFIG_SCSI_UFS_HWMON)   +=3D ufs-hwmon.o
> +ufshcd-core-$(CONFIG_SCSI_UFS_FBO)     +=3D ufsfbo.o
> \ No newline at end of file
> diff --git a/drivers/ufs/core/ufsfbo.c b/drivers/ufs/core/ufsfbo.c new fi=
le
> mode 100644 index 000000000000..81326fd2fb3d
> --- /dev/null
> +++ b/drivers/ufs/core/ufsfbo.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Universal Flash Storage File-based Optimization
> + *
> + * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
> + *
> + * Authors:
> + *             lijiaming <lijiaming3@xiaomi.com>
> + */
> +
> +#include "ufshcd-priv.h"
> +#include "ufsfbo.h"
> +#include <scsi/scsi_cmnd.h>
> +#include <scsi/scsi_device.h>
> +#include <asm/unaligned.h>
> +
> +/**
> + * struct ufsfbo_dev_info - FBO device related info
> + * @fbo_version: UFS file-based optimization Version
> + * @fbo_rec_lrs: Recommended LBA Range Size In Bytes
> + * @fbo_max_lrs: The Max LBA Range Size To Be Used By The Host
> + * @fbo_min_lrs: The Min LBA Range Size To Be Used By The Host
> + * @fbo_max_lrc: The Max Number Of LBA Ranges Supported By
> Read/Write
> +Buffer Cmd
> + * @fbo_lra: Alignment Requirement. 0 Means No Align Requirement
> + * @fbo_exec_threshold: the execute level of UFS file-based
> +optimization  */ struct ufsfbo_dev_info {
> +       u16 fbo_version;
> +       u32 fbo_rec_lrs;
> +       u32 fbo_max_lrs;
> +       u32 fbo_min_lrs;
> +       int fbo_max_lrc;
> +       int fbo_lra;
> +       u8  fbo_exec_threshold;
> +};
> +/**
> + * struct ufsfbo_ctrl - FBO ctrl structure
> + * @hba: Per adapter private structure
> + * @fbo_dev_info: FBO device related info
> + * @fbo_lba_cnt: Number of LBA required to do FBO  */ struct
> +ufsfbo_ctrl {
> +       struct ufs_hba *hba;
> +       struct ufsfbo_dev_info fbo_dev_info;
> +       int fbo_lba_cnt;
> +};
> +
> +static int ufsfbo_get_dev_info(struct ufs_hba *hba, struct ufsfbo_ctrl
> +*fbo_ctrl) {
> +       int ret;
> +       u32 val;
> +       u8 *desc_buf;
> +       int buf_len;
> +       struct ufsfbo_dev_info *fbo_info =3D &fbo_ctrl->fbo_dev_info;
> +
> +       buf_len =3D hba->desc_size[QUERY_DESC_IDN_FBO];
> +       desc_buf =3D kmalloc(buf_len, GFP_KERNEL);
> +       if (!desc_buf)
> +               return -ENOMEM;
> +
> +       ret =3D ufshcd_query_descriptor_retry(hba,
> UPIU_QUERY_OPCODE_READ_DESC,
> +                                       QUERY_DESC_IDN_FBO, 0, 0, desc_bu=
f, &buf_len);
> +       if (ret) {
> +               dev_err(hba->dev, "%s: Failed reading FBO Desc. ret =3D %=
d\n",
> +                               __func__, ret);
> +               goto out;
> +       }
> +
> +       fbo_info->fbo_version =3D get_unaligned_be16(desc_buf +
> FBO_DESC_PARAM_VERSION);
> +       fbo_info->fbo_rec_lrs =3D get_unaligned_be32(desc_buf +
> FBO_DESC_PARAM_REC_LBA_RANGE_SIZE);
> +       fbo_info->fbo_max_lrs =3D get_unaligned_be32(desc_buf +
> FBO_DESC_PARAM_MAX_LBA_RANGE_SIZE);
> +       fbo_info->fbo_min_lrs =3D get_unaligned_be32(desc_buf +
> FBO_DESC_PARAM_MIN_LBA_RANGE_SIZE);
> +       fbo_info->fbo_max_lrc =3D
> desc_buf[FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT];
> +       fbo_info->fbo_lra =3D get_unaligned_be16(desc_buf +
> + FBO_DESC_PARAM_MAX_LBA_RANGE_ALIGNMENT);
> +
> +       ret =3D ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +                               QUERY_ATTR_IDN_FBO_LEVEL_EXE, 0, 0, &val)=
;
> +       if (ret) {
> +               dev_err(hba->dev, "%s: Failed reading FBO Attr. ret =3D %=
d\n",
> +                               __func__, ret);
> +               goto out;
> +       }
> +
> +       fbo_info->fbo_exec_threshold =3D val;
> +
> +out:
> +       kfree(desc_buf);
> +       return ret;
> +}
> +
> +int ufsfbo_probe(struct ufs_hba *hba, const u8 *desc_buf) {
> +       struct ufsfbo_ctrl *fbo_ctrl;
> +       u32 ext_ufs_feature;
> +
> +       ext_ufs_feature =3D get_unaligned_be32(desc_buf +
> + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +
> +       if (!(ext_ufs_feature & UFS_DEV_FBO_SUP))
> +               return -EOPNOTSUPP;
> +
> +       fbo_ctrl =3D kzalloc(sizeof(struct ufsfbo_ctrl), GFP_KERNEL);
> +       if (!fbo_ctrl)
> +               return -ENOMEM;
> +
> +       if (ufsfbo_get_dev_info(hba, fbo_ctrl))
> +               return -EOPNOTSUPP;
> +
> +       hba->fbo_ctrl =3D fbo_ctrl;
> +       fbo_ctrl->hba =3D hba;
> +
> +       return 0;
> +}
> +
> +void ufsfbo_remove(struct ufs_hba *hba) {
> +       if (!hba->fbo_ctrl)
> +               return;
> +
> +       kfree(hba->fbo_ctrl);
> +}
> diff --git a/drivers/ufs/core/ufsfbo.h b/drivers/ufs/core/ufsfbo.h new fi=
le
> mode 100644 index 000000000000..843fa8a75c2c
> --- /dev/null
> +++ b/drivers/ufs/core/ufsfbo.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Universal Flash Storage File-based Optimization
> + *
> + * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
> + *
> + * Authors:
> + *             lijiaming <lijiaming3@xiaomi.com>
> + */
> +
> +#ifndef _UFSFBO_H_
> +#define _UFSFBO_H_
> +
> +#ifdef CONFIG_SCSI_UFS_FBO
> +int ufsfbo_probe(struct ufs_hba *hba, const u8 *desc_buf); void
> +ufsfbo_remove(struct ufs_hba *hba); extern const struct attribute_group
> +ufs_sysfs_fbo_param_group; #else static inline int ufsfbo_probe(struct
> +ufs_hba *hba, const u8 *desc_buf) {} static inline void
> +ufsfbo_remove(struct ufs_hba *hba) {} #endif
> +
> +#endif /* _UFSFBO_H_ */
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 4bc5b8563a62..f769fcb72392 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -35,6 +35,7 @@
>  #include "ufs_bsg.h"
>  #include "ufshcd-crypto.h"
>  #include "ufshpb.h"
> +#include "ufsfbo.h"
>  #include <asm/unaligned.h>
>=20
>  #define CREATE_TRACE_POINTS
> @@ -7778,6 +7779,8 @@ static int ufs_get_device_desc(struct ufs_hba
> *hba)
>=20
>         ufshcd_wb_probe(hba, desc_buf);
>=20
> +       ufsfbo_probe(hba, desc_buf);
> +
>         ufshcd_temp_notif_probe(hba, desc_buf);
>=20
>         /*
> @@ -9534,6 +9537,7 @@ void ufshcd_remove(struct ufs_hba *hba)
>         ufs_hwmon_remove(hba);
>         ufs_bsg_remove(hba);
>         ufshpb_remove(hba);
> +       ufsfbo_remove(hba);
>         ufs_sysfs_remove_nodes(hba->dev);
>         blk_mq_destroy_queue(hba->tmf_queue);
>         blk_mq_free_tag_set(&hba->tmf_tag_set);
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> c3fd954ce005..2ab79760dafe 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -165,6 +165,9 @@ enum attr_idn {
>         QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       =3D 0x1D,
>         QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    =3D 0x1E,
>         QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        =3D 0x1F,
> +       QUERY_ATTR_IDN_FBO_CONTROL              =3D 0x31,
> +       QUERY_ATTR_IDN_FBO_LEVEL_EXE            =3D 0X32,
> +       QUERY_ATTR_IDN_FBO_PROG_STATE           =3D 0x33,
>  };
>=20
>  /* Descriptor idn for Query requests */ diff --git a/include/ufs/ufshcd.=
h
> b/include/ufs/ufshcd.h index 9f28349ebcff..5c7367a54bbb 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -973,6 +973,7 @@ struct ufs_hba {
>         struct delayed_work debugfs_ee_work;
>         u32 debugfs_ee_rate_limit_ms;
>  #endif
> +       struct ufsfbo_ctrl *fbo_ctrl;
>         u32 luns_avail;
>         bool complete_put;
>  };
> --
> 2.38.1

