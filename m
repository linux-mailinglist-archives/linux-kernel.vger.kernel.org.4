Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475E75ED617
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiI1H3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiI1H3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:29:43 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F733BA;
        Wed, 28 Sep 2022 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350151; x=1695886151;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dBZkNlRm74IO3i8Ev/nHP+HmN1N0U/fOgsluxMEb+qealuPE2ydcTDgN
   OdFQ7XbqLX84eqzELWjc76TjPRHfFh6t9Tf3uPgXeYRgbuR5T7FCCQpxJ
   NJ8fzDjNMFoJL+NM6VT84oIp8pARS3H438/JqOLZ499tUz9pactccviNb
   bcke7o1t355ZIvP6Cj+XUxF5DdGXOWMVlykfH6gTQhsfmU2GHyCmx1yOp
   c03PFHSihzS/WN1738RvDf5ropmTdl6ncLQk40aiReDFrhuinBlHRKspq
   zG0SlT1NsNzU5nPgXi+ph6dX1lski5Td1lSkfu7E4V2/CFpugIBlYMhhn
   w==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217644478"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:26:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PILsI0i4RGxQbYy5mcfnUlYczO11WjL8C3MWpOpm0P8jrsFVmdbWhkzQHZHgqaTa4F8pb7BZ0PhTG59bJvXrulsMmUgMMMqiqMlTXiz2nUkzWew5zK18pbawhqCg2GDpCkR/7NAfCW+lvxdx8c+ruzqnWQKDSe2GFyncPWBb3faPBrVFLQh4yvldFiB1PVfv9IkyPVTZNVbHuDcKy/k3EWhR92ZhtUhU69I82Bj30RCWwgvRzPBbS4gNSbLJP2R5Vk4GfHtHRFnBenqgLZPNk157axbL31YCueaBINQIJpJTp2hFNWpghNJX0XbRh7LqytolaDIW2DPy0KnECmY6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GvPNcKmgNLL3wQiyL1eA93kXeeMJp8FsP1QvjUrOt9keePJ7Ni93Z0xnvV/Yto/y2nGGRo5O4QwaOm6muWPG140eGLlSwMXCaLkDq1mpq3EermqG7PWD9rvGKJgN+z0WiuVf1I/pX5h709APBvv6QVNP4KIpkF/JngFIdKM2UcQ8YaoIkQOvCRA/mbOfQ7vShvfpu4iR2UoCja1tRQOAdds49YIlW+BpTli1BXt1eahQ4KK3jQ7ZAeGjKo0qXBy9PmjxORpu5JyvK0b8LkBkEkRnBBlBRd0AuXi1D+QbYmbch6N00KplHG6fRfcHPMfoYWx7YnStv5qz4V0RDZx11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tzzrbXm29QZkdqxE+XxFgJHcCOR31p2yjCzkunJHFQdFiYLJlzHgPI3zsXfOZbezWLjcC0T2N4rbZ+ur13c+PD/W8bIPsZZfPvl3H/j0NwVeaRSOoU3MOKziIdBHkBK4IqkWctPs6VRrNf/oJ7QhQBuU2omLz7YK6/bKV8E3tVY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4487.namprd04.prod.outlook.com (2603:10b6:a03:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 07:26:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:26:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH v6 2/8] scsi: libsas: introduce sas_find_attached_phy_id()
 helper
Thread-Topic: [PATCH v6 2/8] scsi: libsas: introduce
 sas_find_attached_phy_id() helper
Thread-Index: AQHY0wUaVFu7A8/DgkWi+q9Cy3iZiw==
Date:   Wed, 28 Sep 2022 07:26:15 +0000
Message-ID: <PH0PR04MB74160811019547780BBCFE3E9B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-3-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4487:EE_
x-ms-office365-filtering-correlation-id: 07c53da0-1203-4d93-fbc7-08daa122ba7a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5Ubk3r4IQJq4UaCkcHevw8qw9nJNGzY6u02/ea18GrKQH+bxIVO4XIFZu6d5ROHs7v7p1tiHhl6v+1gnNkvl+glmWKN7maHcA1k7qUvMWEVJ5JtBti9MTYI11aAmpeW3/khYXVLP9QRczUmscHXMTlfLPzYUVSS8TeRrQ/jnSMbfpWJoFP0ESkuglBz9tTN+Izsj+/G2zjQID+pnROHWeHLYC1Bhi/BXnhoappW14Ht4EwH9+G3qRiRpBDX6LtrbVWCBp0JUgTWzxUCqWSLIVPZJVvf270hbMZD/KCKqiUbnB8lkE8TCdygk51hfDxKEGjS2hw1UnZAASyIXVt1xdCZYiRWJWCDWBgccJR4w9+4rif4NLJ3YllgcpvPqj+0pIFvWxa9OWlM15eYTaGmDGZwK5cA0RvmamX9x4X5cbnB/vVL+RhJZaZT4jOUP5sCTO7ph1MxwegitzS+W/r1lN/eKBSU76p7u0diDDEmhkVTrdyVMU4JmOeeQMz4585tCc1GyHnrLVhc2yAaw+foAI1E9ooyL+m7Ynuwlval9Xhqz0zodFD/qwN+YSMCjaFCXs13fjvSse2t/vdAhf1M6o4No91peIqUIKMmxustIKMUYiICGjKvWzwMdW4OpbwZeBraiir4CXUtcDSwFOpk51M93zZE2ve9cXUAkVnv1aYKKavob/fcv1ufo8wDy+VkzvkgQw/S8WnAxQS+KiM+kVeNCMy4p0lLeeIjn+ssVAZVaHWYXib9vor1AY7dHzpyID8Bq+dDVxiQoJ3rhDVTzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(71200400001)(55016003)(86362001)(110136005)(316002)(54906003)(66946007)(7696005)(9686003)(82960400001)(8936002)(52536014)(2906002)(19618925003)(33656002)(8676002)(66446008)(64756008)(4326008)(6506007)(91956017)(38070700005)(478600001)(66556008)(66476007)(76116006)(186003)(41300700001)(5660300002)(38100700002)(122000001)(4270600006)(7416002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VIBV1zMctA1T5jEBLLQhqxfEIpoKBNTutKb5385a1Dj5ZpsHqrZFxoZkVJV7?=
 =?us-ascii?Q?OAvmNc5o2xuP5FSra+iqBa6H3ZTkNrjhTml3TDKS/wIXB9LiSTIrW2Vr9EvX?=
 =?us-ascii?Q?W7zW54rR7csZpg0f1d733+Q3/V47g7QD/mNUfRbf7nXJTdcttBvBkdJptCW0?=
 =?us-ascii?Q?ZsUo4pqcxoIPcMstfBh/KkO9LxG45l+jnKtUICj5mo1l+ibcsihvmgUv6XCe?=
 =?us-ascii?Q?oZBooPMxQpfpehk/IaJIukChXA+s7UbQYzNzryt9GxSTTNZLtL5cqN2DCh8N?=
 =?us-ascii?Q?KkipIH6CDU6PMMfsuVqnYA0tl7wtRb31/Wt0QHmM6PkegKfZRRfGY7tJ8GK/?=
 =?us-ascii?Q?keaavnJ3orfBWi7Fg1N3WQ4nyWhK43iYOin8JYHCYcHPakSYONKPOjii3Rne?=
 =?us-ascii?Q?+4OzytyBlyWmic5lXDhZeQLn5FRI9Wnz7XWYElYaW++FFOiUTf+83Lt9PkEJ?=
 =?us-ascii?Q?iine0B4czuCCrAPRBXTTp/U4vw0JfcbNkbB+5YTJqbeGw14Y4/jW4pGJWmOB?=
 =?us-ascii?Q?O8aWG6lQ58VgMs4mpvlxkJiuq29lLz40rsLkOGb8ZDx8bHJj6dKDLAobF5+3?=
 =?us-ascii?Q?CBPSceqjgVvPdcr1zf9FnsnrkrbFGLI6MbGl4nWUQb557pz0RJzg3ej9mRwp?=
 =?us-ascii?Q?XGaMK9yHrWmtU3EuccFdqbviQKxCfZyHMmZVfLEHP+p5b+u6XcR6UTKgFd7y?=
 =?us-ascii?Q?O1DBHoYJo/ZQ/kP133FcCP8wNNiDUdRcmRZPRJVuk8FSoCK/xwjpJlgpDMVG?=
 =?us-ascii?Q?ai8PFVm2FPOkU5auIvzgsg5SzqEblbhvvPEHqo3437tfaEhYwwJWi8KgT/uL?=
 =?us-ascii?Q?q8ySfTPFsUah3xQy49UsasloQQ1uXEN3tM35M4BFGYOlA1Mf0MiwUSEj8upM?=
 =?us-ascii?Q?QqYMh1N0vtlr+os5gKOKlVlJ8/ajCa7+8YilhRxFqEvNJ4vmE31bbrbcFbkQ?=
 =?us-ascii?Q?avoyMYf6Zx6WtCw+iB0k36R0stYiJsmivsWy0slGCIAZMmJbnjtysDPSO2XR?=
 =?us-ascii?Q?UF1UA+EsxIqaPxC39HnTxeDYeD7giC137YhYfu5WgHr1r07OS9RZ7P4CyopH?=
 =?us-ascii?Q?0+MqF9wULIBojB5s3TaR/8jehH9bMD/fJem/IGY+b82gbm5xFyFAeIQ4Rmw9?=
 =?us-ascii?Q?sRtZrQ2KbnQt0k0lL2YlADkCUzJc7clM03JeYc9pxmN8qsEZOQ5OErFq+TzZ?=
 =?us-ascii?Q?R2SZPHAOMelCi2BPuOl7DyTW/k617QmM2lp7yP6ccPEiDYEAJ8QZBV+LPVyu?=
 =?us-ascii?Q?YqMYA/yVJEMYGO+BcMf+T4GYTSl76pqiFpkvP7CpsMOOpNP0i2+hs5BSFDxs?=
 =?us-ascii?Q?DCBuHpCJfNhp3R3I7CchHskyY78we7zn4xo3l6aLYjXowZvl9bj4xfIUdM4T?=
 =?us-ascii?Q?JNWgcMai/LRQeFIrV4Gm52N+Yd0Sb+yEqFTkiPRqZwE2nZ5XEdx0JEJUtEkq?=
 =?us-ascii?Q?0+MhyEpPFjJddHRbsANIxtMTloCI8rR/AdOF/rgvhzenfV69Fr6CWECLa+sE?=
 =?us-ascii?Q?InEgqnYru5D4ItbTERsN8xRdMlPwYKS6jwKbcF/1Unc2E9ahb4DGYelt6TEW?=
 =?us-ascii?Q?7CrB6B3Jddbh0gI/ozLjSLxNOiLUJERZO4+Akt281FnhDemoSebVvk1CGOFA?=
 =?us-ascii?Q?Y8hnbiraP6M3Au6WGtgTe/4L7pSSJgL+BDdxNGorzAdcwICoemEdLOfsEWeM?=
 =?us-ascii?Q?9y4if8M/d17lMbvuAY5oNNo5Q/A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c53da0-1203-4d93-fbc7-08daa122ba7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:26:15.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2rgKuWn2CWC7wlXh7Ie0KwEGCk/Ajcvo3l4DZbc8Dkq0oQUVoUz2D2mHtuHag6awrul4aPSMv71Clk8R/DJVdvNe6bJzUJ5Jh5Vr/JQD2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4487
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
