Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE15B57E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiILKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiILKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:08:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14B736867;
        Mon, 12 Sep 2022 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977293; x=1694513293;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HcgkRoli6IvaIrqZ8bFsV/mm4GiG7vKoJWQmE0wX/uc0tkPtvX4geDv9
   eWae8RYQeRah9UgcHLhwFEEFixh/aMb9QyKXZsYiQteqJY+NcdYkhXFmM
   ZPyB1ItjlFUCqWkP3JrbOlzf5bFUGzblgPlVzzd6uSirnJfiGYxZ4giRV
   a/p1Fz92zBH/emSx6StlIK5mP1Y9RXcHNXcwQdt8Wb9z3qw03OkK8FCOe
   DC1GH5+k0zrmLYPhl0CH2zzBwvxpHAsFQT1LzXMtgGzGBsBgweUs+qPQW
   ZuGbzkSaRWSkkSYKbTwaid2HWGb5CcaffeHwmMBaLBVgGA3Z3YYmuzBZL
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="211576789"
Received: from mail-sn1anam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:08:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixp159TXQwwl9fWCIdohz13DnhiJbEmO/pSDPTG1WuUJdPfpXJSxTvy9CRFboVU2TNFl/ORLfK92N10KVDWrLDsuiJ5GOI31X9ECpUsH1yX2GY6hau6XgphE3oUC6lZWgdNJbVYstjOAXx8hhVW/FT1j25mmLw07Rrs1ylu0A8PIN7njZQKCbOcjRW4f5uMQNUXa4XL25Cx6AC1yA3UOyjLEOphJAIi23/i4Ya1d2CfQ3xGCmbT6RBM1o1IVwXW07JsKKl1MuU5hTFbD8D+iumDF/iLJU4VWDSdN7YmpIqg+39LISddMj4qUNrqyYs+0L5HLj5IH81kSTn55MY54bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DDES/sL6WfVYZpiu9xSC4h0VLx5JVOGp0QR8VRtWBqfmwkUmmjV3aCub7DOBi6pRlo1QmMqZxNPeZjpgZEz6QZVlCZXrgZLs+nOpEAXUSJHR7Wkw3v7YWJR4LLUQVIDiAMwRzh0ld8+/6FH0fCt8aXDgnRIq7ZlhDFB5ID41HQHWBcyyHlyGC+VDNtHx1UYzigMgYdeziXwEAZ9jU5BS3HzVfAfxdh4YWi1i7f+K5tRfcfywkjSzWsgRwpnGcxpBLawHUDlh4t8AKwXwcLJ2K8+kaa9bexTTURm9WOllEBy5SMMtGOWlr8mAqOdwhlmn41El7ZbpxzBwW5b4CFeCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kkdae+srBXnWmYa5T4Mkv4sHHe//Z+Z9YtAtdA6+D0HGHMEiW769hIw/1QVTu8SnGh8b4ccHlEwNoFkOv5tu7woiI4nSfPjVey3cDFof3Y2mHmeW+GO1QVG4l+mIdjJGOdma6QokQouQHvGwquOfhYtaTHaYI+jxjhvaayS+okE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:08:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:08:06 +0000
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
Subject: Re: [PATCH v13 09/13] dm-zone: use generic helpers to calculate
 offset from zone start
Thread-Topic: [PATCH v13 09/13] dm-zone: use generic helpers to calculate
 offset from zone start
Thread-Index: AQHYxoDcRAw+J+Kn9E+jUkr7Kineaw==
Date:   Mon, 12 Sep 2022 10:08:06 +0000
Message-ID: <PH0PR04MB74163DA1F438B28750E2D8829B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082216eucas1p1d3068e7578a88007515c2f4f5ebcc2a8@eucas1p1.samsung.com>
 <20220912082204.51189-10-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4740:EE_
x-ms-office365-filtering-correlation-id: 34821fda-bebc-41e3-2a98-08da94a6b010
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWR3RztVCwPlcHvRSbhKMzDI6VPbpIh2KbxgTE1/WSjtgHv/Sscd8shcPt8dqmSJeFw4isPJj3HDoQ0p/raTX+R9m8PngCpuqsFvBaPe0aK2+IG7QslSF++yzwlAs5HKSWmbTAwFBKwYqElzrk8zos4dIOn7T3ON1CgPXyP5nSL3dutJKjX8ge98GibqAft6sIgzDWrjeJltwaaavLgGCU10gHO417vTI5MVPe7w4Ru6CWTbTtZQGM0ALeekk0qJvswp10bHCObwjaH3REAyHW3KrSFw76cbsBjYpyrnS9N+f6XF9hp5HSuHo9zJ6ITKjJl83r72OZkeMHJb1uaCNTLYgIWPjSmDRgsMo5e94Uy2JOofuknB8EpFZo3gppas1vb37PTU7dsh1wavJ9/5r9xKwyzaOcOX1Efj9AYRCQMPI0xWxBHqjqlTFw4fEzz9yiJq/1yZbeW1WeuhiOOpjHS5iag5/xS2YJE5fGAFNGA8YsOup2r1YPeICcrEETmwPh3amoYho5Xh9LGW/ZfxXRFnM9OMfTXmL9ido5G+/8jUXo8cIyKRvvAGagsA83auN7kM24YnbR76Ne/uMxs/8oEJgnH1MTle3qWMFonVjVjlz7t6bEVvNl6VqHAvpcsXhYjM/HgB0LS/VbksYTtbI2bOvg+gQBnzDuyhEO8WeeGm+GxgQ45evurv/UAJMD/g8KXoY51ZiFjshraNXbBhxl/otwJgTQrJpKF64Vdrzewxks5GdJnoSx5d0zcN15oHnnSFNEWoEDniIr7DXRm535Xj2kJVrnvG2Lsmb2FRRKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(33656002)(5660300002)(186003)(4270600006)(52536014)(2906002)(8936002)(19618925003)(7696005)(6506007)(9686003)(7416002)(41300700001)(54906003)(38070700005)(55016003)(64756008)(122000001)(76116006)(478600001)(91956017)(66446008)(66556008)(4326008)(110136005)(66476007)(66946007)(8676002)(558084003)(86362001)(316002)(82960400001)(71200400001)(38100700002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UM7YEfYi1nD3kBVSxhT4nTAYzgkQOe2ER4MrQe6wtwtJZriqTEIES1DkpT?=
 =?iso-8859-1?Q?9HqlDpChFV7U+7wEWweA6Jph/bmmKYYvgZcJx684Y1HewLRlOrX7131600?=
 =?iso-8859-1?Q?5nUYFmhuUgmUWwg9meSJkWdxUfPX5r68F0GHqUlcTH0JE/lpbYFOw7rYPV?=
 =?iso-8859-1?Q?pS1q6gIBZ/in4O24pgmIf2ZGQjevz6o1r8TdWisAzVSCAovc8Ubg9hqqOQ?=
 =?iso-8859-1?Q?FqWWVWYDNiEAPQVKBn6ncqCWEmYuE3w7vJEL4xwXBYfAkSzoy9JZLPV0dC?=
 =?iso-8859-1?Q?l6oigKIYXo4kZf0mY3VBe5VH6vy+M1z7jA53uERF2bDcqQlxzL79YXptf9?=
 =?iso-8859-1?Q?Bd6S/CU9VczN8POepgM28Q7fke7a0mOI7UdMyeNGrKlJ8KojkGCAFvICjn?=
 =?iso-8859-1?Q?hsxuq6VnM1OGXwrBcGb45wKQCUwTfZvg8DJSYNll4qgOhghExfe9iSzruk?=
 =?iso-8859-1?Q?WRSlDMqX2KowVzdzQldEIP0tE6ecTt8VQ/4v+utb0GtUf9SVryXuSIE9dm?=
 =?iso-8859-1?Q?gzhk3EqHBI/c+cu4tQ7a8K1haA8X/lO7ZxUwSfj+voimC5cieIt5kzvvoB?=
 =?iso-8859-1?Q?nvIuunlGEdwq0KPqhedOhv+am279B6ZQ0HVvophAWb4hfY1Uvl7+4yHZ0W?=
 =?iso-8859-1?Q?WcuOQuY0vZkPA3die5+VAIFTfm+pSSrTnTWSd7NgvWJEhDaXesb/pQG9Yf?=
 =?iso-8859-1?Q?EINNTxj7/fhdsgjsgdLvFzcKZ9dsm3oKvUwG4/W2p179/PWcGpfg2nV5n2?=
 =?iso-8859-1?Q?DoKXNSaF/UtCwNY69aQdslQt1OpatV057C0o+BcbAoPB2a4eIrb7yl6qk6?=
 =?iso-8859-1?Q?uyBpexGrZHNRr1TZ1rYkMdWS+2Hai+mUmhdy4olytGEBP2Y+LNeMKiMFXj?=
 =?iso-8859-1?Q?zpHyyQeDsWkAeWmbF3LcGQap1byzqrvIPjfiiX0IsjvmspbbGjDF8RHMum?=
 =?iso-8859-1?Q?CzzzuFxwrJTB+mBK1PVI+ECLKIs3mAqOlAi+jQTClvx28meTofREboBpOM?=
 =?iso-8859-1?Q?D13IVKuCZ9LfUUGJgxitQMLVwxsqoFDw4sUbNc2hbRz0PCSkH2lOMlR2Ex?=
 =?iso-8859-1?Q?tOs4Igf+8lcSDDTH4eT2gXnX5sxKPys2qKvdL7pyrp+clYoip7qwSbdYYq?=
 =?iso-8859-1?Q?ew7hX8EvLRxYOOnqUQbi59xy0l/J9/8NspRwDJ+kM9auC07HAFTR06s5yn?=
 =?iso-8859-1?Q?lpmf24/u7t64i2c+7hlXUq/qxfk96cSx6vcYc59nsfEiSfoFxWHZmNggp1?=
 =?iso-8859-1?Q?Q4oD0tnz8FeG876Y89K0gRXzDxHOI4AEMua5Saw/nWF7vhjMRNP7TJJ6o8?=
 =?iso-8859-1?Q?9NoYZ2cyfUU/CKnfTYTJtYmZ8sWKlCfwXh9+W0GqxyKYZ3tZlK1ct0jsjH?=
 =?iso-8859-1?Q?VldZDhRV/d9fCaUGD6uHg/vtxdRMboD1RsK7eVuw/jczVavzVrWEXe7qHS?=
 =?iso-8859-1?Q?1JAPBhlKzHqyTsvZ6nzjASGD0tv7hk/vqr9tqDou+arsZSf5BnIcXtzM/a?=
 =?iso-8859-1?Q?VAvRX7v4JYLl98JnYUGHHjdpCEcZmwHtA/EVCYTHXRyMUR/JDr8PZAynpO?=
 =?iso-8859-1?Q?9CCP1ccZVgiW1uejkpmj5Ii1ea6iWxl6tOSJqhomLt+D1rZ6qCh3ocUUFZ?=
 =?iso-8859-1?Q?i7dbxnndQV08hM2Xg+SqGCBDUQF4Pjc3VS3YZiaZCRDUbeQFACHHh5GY7f?=
 =?iso-8859-1?Q?MmG2CLSqpddc3U2AfuFnHYuk3O7Tog9uvebCWe6bqYKfw4TOThTSUdlHEw?=
 =?iso-8859-1?Q?pntwQknYryXyf1X3wR0870x9Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34821fda-bebc-41e3-2a98-08da94a6b010
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:08:06.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SzuZvstdJ6Qnpl5nZpfs/eUcJ1EHxc3boKstXoH+HPvoa2Bhsplsvvo47rjoVq1+fDTBUtchYm0V6yFV+lRmQTnWUsv2/hkOr99fHsN4Fc=
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
