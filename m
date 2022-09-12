Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AC45B57D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiILKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:06:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEEA1CB0A;
        Mon, 12 Sep 2022 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977198; x=1694513198;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dY0CV/M1VcWzbeUf3sGDWoLXULHZjXmXqu1iOYVjsY3DrKBKRhxpPFmU
   +FK6YQug3W7ZU8LY8v1HxatukCUhKTgPgvdxmtvGqPZKjZN6gBCUVs8cn
   WAUygJyXnqJk7P0WnXX0xlw7ZbRrtTEQ5D7V4/Fg+SrCejtkMnjJtq9U8
   4hhz9FlfnsY0PH+1PDQC3qfaZ0q9yGcv2qPM15MfMTMpKubI31ay2JWZr
   XAq3k/FhtF5qF53qXqbljHSrqJ6ZI173bkAZYzV3kTB+382rM8d1M0LVs
   37XPd7FpsK71nR7hevPWea4K81TxCLNmHLm+erOKuZiEquYxAKZ+vyOU7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="323221226"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:06:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNwFsYXFPr2PAhJNT/gUC7ZtgFiKwUA1VzmQNYn3v1t69juPyfgkrnuwfzpXxvGcJUsPRdJVov8FQzSHLlBFq8BlqhP2BPpZ7tkrpWuBUjkWz39mA8IfVunJ1D25ghNtnP11VvT52KEGJ+NdFLdRrcT7iLkrYDvk3T0XEmvPszVQ+ydkhubKGhkHi9vQHCKZJUQOaaXC3lA7twzQxJeTjWUg5kbfFHJM7U7DBJIsrVjOzn1OcnExDBIFF3nQo4Ta8MKD08q98JgAWe9M/5j+d5ZhztWlfRdssPbUyo9IktrQfWfhSueUWVVuBjsf2FlnvbO2ghiJJBcGpU6ZEIrzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FDTpP+3V78yi4psSw6L8uzoQ+j6F7zQP1UqYEsSpPbF9WD7MH5Zq+5fz95N+2YF76L4m/M2NvFyyXEnzavpfzobnsTrjVjF1idJb3JgJ5zfKaCpZ19odGcMR6uLPTSwFMqD4d/UaRcWARJPM/MZD4sbz1sFmDoTAjJdHBc7MgxxmDUFhMNNqq4m5PwVh8mrSuh18ZHcSQfiYAq0A6hRxUcemJi1PDdxEyk2YpMc3mis5SS7qKguynY/ICcllXZ+t179oGvxKQIkPGc4AT5UiOaWkGFsK/tC91oy01dQod7hwBvfstv8BgJHMLd6gNHKuD0eARjoBqmZRsiJbmZ88MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=n3OIMmySGN4bBuMKEKYR1xuCFatu8BHcgrQYkykAI4fzDnieUUE3Tog8ame1SOVstk4bEJL2fUGUCMl4PKaR0qsnhy6SFj6zxb5lq/G+3e2aTXtwwnwtmATz1Jqg8Z1LO3wipPLa1H40uWjfRt/7D5RALY/qVCXOun90BsDyCF8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:06:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:06:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 06/13] null_blk: allow zoned devices with non
 power-of-2 zone sizes
Thread-Topic: [PATCH v13 06/13] null_blk: allow zoned devices with non
 power-of-2 zone sizes
Thread-Index: AQHYxoDYe4IHkDWBLkuW20Jl3XLfgw==
Date:   Mon, 12 Sep 2022 10:06:32 +0000
Message-ID: <PH0PR04MB74163531ED71D55BCF9A1EEA9B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082212eucas1p1032064dd2ac1638d7d18be7e6fe5344e@eucas1p1.samsung.com>
 <20220912082204.51189-7-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4740:EE_
x-ms-office365-filtering-correlation-id: 3ea78402-36f3-4ff3-4d58-08da94a677d9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FtlENEO9REp+0k/7v4tyMLwILJwF3/RFbWamh5QUppcx3rNvZDIwsXCPhMJBLt1rK7QQEeFM/ztC5u3c2UkfMH9/kgJmeJ7HJTpFI59/SZIrEQwpjCE25MO7PKzc+9G06aY1FAtzgihma3JrctdW0zxJp2NXOxDRv8qU4fVaAxn5MDZKh+PiwSpcDj+wfqKETzHhLGC1uMEckgmwM1b5pHPqc+sR3ZH7s59l7fKqfUxOSzft+8fJY/TSttzGMDlYvKA1hm3xM+T0Gkr8cpMWt6k0qj7tMCob7r5E5a7whfaAeECdS4KOm9uFfVwQCLBzIdEzbT05VIJbZIekxfajHXVL/ITgmcJIzkg1t7Hn84TykCWRxmnJBd8OcSJt4MsDQPU7WXnoGkBkYMA03VOnmsMnlLw0mXfOZEjszjIkYVrsWMSWXGe4hy6wcWKdChZCcF/XfcGIFUugJXA6qFJqiIlYpKE0RThzColjFbKea7Fs3/btkwwlBDhjypteE5+jdCDlF88bgEBMzzQxMuFu5t4+ronf0XyF4bZhKLMq2i/N0KJAwTpj8Dhw8z+J4vgNhkZXJ3E6s11OLXSjFfKqyqSVGGT3PAzxOWtIiam3r3t7bRkl+l1Q5pwqkJk8RSbkaRuylRggT576OzrCA58abnmg5czL4J+Yspj25BrRnJsJrokXBUlYJ5HXkhAvSAunTkmsoSqSyTpHh8HStMzZ8KLI/aidJJ6JXyhPj92VaFSBc3rQg3gr/BL2nbkUMIZBdqREAFfcV1TrL8fnkHiCIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(33656002)(5660300002)(186003)(4270600006)(52536014)(2906002)(8936002)(19618925003)(7696005)(6506007)(9686003)(7416002)(41300700001)(54906003)(38070700005)(55016003)(64756008)(122000001)(76116006)(478600001)(91956017)(66446008)(66556008)(4326008)(110136005)(66476007)(66946007)(8676002)(558084003)(86362001)(316002)(82960400001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?edKMZmFmBO9aO0bB2DwgnXbK3tQQ78YbqSnftHtnEj6vRBKo6GfOAge7hu?=
 =?iso-8859-1?Q?bmzY2KOO0IxCebr3ji7xUveJfImo54HiuzEhkxQKGjlkwG/lmQ3dnxI3X0?=
 =?iso-8859-1?Q?HAoao4JzQDipeZkDNCM5uj7XGTXVZHbRsr9fzQEAnmahf8a8cmg6cuSUzn?=
 =?iso-8859-1?Q?dlAtItMLv8OSKulUiba18aWuYTPgMYY7u8Js2/5Y8UrQumiJD3Hphw9Hw4?=
 =?iso-8859-1?Q?VHyu+bnTIT1XQ7cfIwCLJ0icVphJ/FGFBolwV3DhT6zwCThMyoqoOsGMeB?=
 =?iso-8859-1?Q?SgPfsz+JFUX4ZccfdTj0XGWMfHDPGUEW8QzZYOReMrs7X+9mEB6IV9QF4A?=
 =?iso-8859-1?Q?gI9m5MLcs7iwUV8DBvdOaJs9cqYHVqvpEhgKzcSwYExZ2yWFTlJcbRR2Hb?=
 =?iso-8859-1?Q?hn8oMNvefbsuhG8GwDvViogetr8XAH4qOCYEXD5CJIagGbrOSTPsCdYED2?=
 =?iso-8859-1?Q?GYsSTain+K5RNlM/wOvHrDlYbMKNan6QDxidpMNk2KpzAaRceBmIuV4B5u?=
 =?iso-8859-1?Q?mHMrE1k2PzvbPMfSsrSqgjk9UZsr4zOlyeqct4xfStIDC1gK4ZiySpUzzd?=
 =?iso-8859-1?Q?h4P7ic7YGegYx/pvsdLYZhkCYchskf0QER8jt0opJVLOorKgANLJR77jmf?=
 =?iso-8859-1?Q?MYsuBUHtrf8BOfLUzHslOC3IcqVMlNg+1M+s3h4aBGQSykFucECTJlMz2h?=
 =?iso-8859-1?Q?4fxrhnwNvHUs51D/d30wY0nZPAaaoQLdlC3HHqFNDKNGn4Zr9i8ugvLV6l?=
 =?iso-8859-1?Q?Yw8nxG9iOlEUPxWNW+L+P/6El9VdyqUE/0VvIQt6j/aYYZvEZjvcw1SX2A?=
 =?iso-8859-1?Q?QuvW64VqBXlpaLGdDbD9vqVDULdu/BDOB0iY2nElyAQgmSEvqePk6Shb3B?=
 =?iso-8859-1?Q?b9OCJuCyHvQsmCUwwb48isIA0i+lThgUe1vz6PMJ4usESQJ8nJ91rbWqxm?=
 =?iso-8859-1?Q?bf14oWDhRTarBMmK+ML5beBWlQxF0rKhrIgcAq0KpMpmG+L+NRuYdlJjaz?=
 =?iso-8859-1?Q?ONr/0aVqt58MBQSYjO+MjmPMOcBLtlcf6v+1AT73NEVC7gdHVH/JFETkRg?=
 =?iso-8859-1?Q?riP3irHpRotcbUbHetr0C77TL5yzIm7ELAZwbDzfg85eEKpaGbHoYeaENQ?=
 =?iso-8859-1?Q?ByZ4UOjttIWhz+sxWrDW9/KwSQnFQWnAw1S0YxDGNXR6wilBIejNP9SjPT?=
 =?iso-8859-1?Q?NXfo7vToV9jX4oxmzscrVIqfhkcPirK0W7LVYy5Q3N6VSGBQMXrC2BaSx+?=
 =?iso-8859-1?Q?eeV5w7IQMHeMfMWzI7U/D+jMT3mTX4epa050enWegrr3u5glZLbzaqW6Ym?=
 =?iso-8859-1?Q?TiqIeMf6aQXacGjep5KhZjeuarRg2vJFOdJpFmPdAQ8+ZVjD2frpIt1Ijb?=
 =?iso-8859-1?Q?yNz7dhIKTGSJBz3k3/IFrcBZCT9nFjR2vhTDvFc5NbwJwhVKNeKWtMcJmM?=
 =?iso-8859-1?Q?OZ+rnXRQrqAiPjEjHPARBqR9WukjnOgNcMq6EtdnlIsem1dyTwRlfAlEIk?=
 =?iso-8859-1?Q?HWGpHi73JsaEUl+02TI/M+lE8jPG9VJ/DZBaDCMuW7vzoNb5QfPszuCceF?=
 =?iso-8859-1?Q?zReVmKzsULoghwqeMYSJwkjeE3+ItfxmCSf4FQycpJ5tPgmXwp/6Vmk9CC?=
 =?iso-8859-1?Q?azmpNWi7YI4AeuEMfKKJ2iQawbFMUzz5yMZFJtcZxr6NjQa8TLHc+XKbHQ?=
 =?iso-8859-1?Q?YQpetB7N/fA89YoF95X7XLbxDUr2oQQwxrZDIVgMm9WVIVN1/72kH3P4cj?=
 =?iso-8859-1?Q?PiCVzc1YGKQMTzgLOZQwBLFY4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea78402-36f3-4ff3-4d58-08da94a677d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:06:32.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ICACrpq8olvDiDJo531LJUuH3oWRDnAlJ5dOL2h7Gk8aJaMN3lPzyixY3dp8GmoQr8bnMQ7YerOQzN2pGS3YMbkdaAbYKg+YbPCuW2xTb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4740
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
