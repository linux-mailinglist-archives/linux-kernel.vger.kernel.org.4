Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E05B57E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiILKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiILKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:08:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A8736873;
        Mon, 12 Sep 2022 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977318; x=1694513318;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=r4wQh28IxKMjTCnSXaTTyYPQUYs1WkfqJXPoJOa5FEBkvSm2DAp2DjHF
   cJFI5FN8xBYIek+hy24fX6DgRL6Vl9lOiMIWSV74W/ssL7ezBHP24qjjw
   +7R/5fxGy6S9HsSnrifm/40PbxEQkOo139jhpjMZJPHmBoYzDcTCbSmJN
   P59T/FQBbEdWZ09ZgC0kvaaBIF0e5wfJhT4vpRG2cB35Pz4AX7Q3da8GA
   kEu/9hif2S/Djyq2nUpD/HRf3Hph75vzqX5tOKGEXK0bb5s2hW/RM37V7
   eBNz37Okc9utlDs7hEErNXfKQX2kXq9Q74u1DtUCMy6rfjMtUfgX6aHkW
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315397400"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:08:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTIn+FSzEWWiCmQInMcmS5bTSi1QskO2/6o4DIXNAonfiRXL3QEGF6IeahhRkJAFmQgrMym6Tm+Ce3s/t0e3Cnek7vqL/7/lRAtvevkJqs5guUSq/xcM8DHLzl8o+6UeKJ8T6xvzuE80sVRZXD4qz7kFzZ287BB17L1Lz3HlXcE6X8fHxZopRVLjI6KKQ7k4pRWQs5I5X95pqmz2iueV5t7cPn6Zkx9LgyIJyaicYTEaJaQrvQgL5yCh+CIj1zdbpsYhiEzbpmeM/UKKvb8WBZ5hFqoO/1WF6Exg6Iv2KEutvAkBV8FLAih7Q5PCAPJVZnxVxWMO9ld4q/WnWmbWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LWW+x4w4QWptq0j3xPMEhosvTVwAUXJf+vm6ot2c1vdTkFVoMVWRFsEh4RSN6l15Dj0Ia6kBTLY6N4foSMsEKyfC+/guW1RKLEkS65AraaXem76MjDjv8Ig+BwCJwvbTtYHzbGIpLVzA518Xbnz5HvWR9InGGfwskuBOzX3SGgc2vmGnE20hMdTsRgaCFXQzVNV21iFJ9F/y9fE0LgsW2aH9QhGvkmWh/FbMjdtbV5wx8ukuLdsEpVJ6csLKgxhYxPE5F/rZfm+B6at3JLd02z1bMVZ5xWxIdnhh5/sSfCBt8c5MBfoUFqzq/qDCtnm96fGMw4EgySLl/9MEB+0yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ihgo+vHqT4Y4WCQtPvI8nmIv6iLlowKO1j3aqOoFHR8hAo0jmWk5BcfCdt1ceyXvG+D4a+ufQUysxH3ZjnqH5kyVufO55oP4swLGXRI2064QQ8iK1KibeM48nxVNy5aHeNopNsuhGfA4EyXx5We6sbHn1GDZYCgdGCX2Q5QQaaU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4067.namprd04.prod.outlook.com (2603:10b6:406:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:08:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:08:30 +0000
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
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [PATCH v13 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Thread-Topic: [PATCH v13 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Thread-Index: AQHYxoDf7fMsUGcEdE2DBUSb1Oarhg==
Date:   Mon, 12 Sep 2022 10:08:30 +0000
Message-ID: <PH0PR04MB74163E8E098CE1D096EFFC859B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082217eucas1p15e4ba29d1438990db4acf5c3f6ca5d4f@eucas1p1.samsung.com>
 <20220912082204.51189-11-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4067:EE_
x-ms-office365-filtering-correlation-id: 6f7dc848-42f5-46f2-9f94-08da94a6be49
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92nhMJM2JugktHzIXJXX2np7dYUy1eNfTzIOUApxLhzOy5w0HlEyegv4mfOeuOg+/G8qMF1SM3thNlR9FuxKbTgT6WiQC5qn3Fe5dsezWl/D8D6CfoPUg/LK5UXAKj+IuA19v+M52DT15KGy5Z4EEwfY8O1+PM5U29NWD2/tIZZbSO9tGCIrJGTYwUGQSTLsA2aV2KscyglNb52bR94opJz46zE0E1cApQvNonXAsDoIhw6NBvxF00c2xaNvl2nFmnj8Y1C0SPxCgG2RABf5UGTHI8j05I/qS3Akvs4jx65MDhhXF7aRADeA7yDQ77zc4xQ+MNfkWKo0Z3Y05UoIIkZtcEOQDxtbQPut3ugvZWCe06mDwE+PmwHPB/iOpXURVn65AaahZLzHL0YbF7ICkClJ+eudSjumhz8vljzHDCB47hSLRb8mztazWimY6FS9883c6rHUbLvZBwtKcUHz7avHWn1D+vvVV38wRYlKfiwGzYTh9/P3l4Kh4G/4K5nw4fgqU9NI/9gYmg1anotdWg4Kj8XlNSw33IgHf4csruzVkyH2GDhung4sDvkERh0/XXzb0pNIr72xjOxE7pdgkqp+TstWle8XWu/fZerrTf73y/Z8PCxgs/QYVXkXvDNsHTiW2GxDBJdpnU0PlS5w3NbV3eNh11S7QiAKAmpjQTeVDAXuKZNjbPX21Gv2q1l0NVZc2ybA/NEFZdPZanq8dub8am94KQPme/4Mm7944hEB1nBAkNBZcKFdLSLcanZFxvwtgRbKbViU4RZVCkSZjex/zLnIefhzeD22waVexUz5wffNuNwtM0EfEvyuvraa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(38100700002)(8676002)(86362001)(122000001)(82960400001)(66556008)(66446008)(66476007)(76116006)(64756008)(91956017)(66946007)(558084003)(38070700005)(33656002)(71200400001)(41300700001)(7696005)(6506007)(478600001)(9686003)(4270600006)(316002)(110136005)(8936002)(54906003)(19618925003)(2906002)(4326008)(55016003)(186003)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OkFwr0ajt+fpkfCGtWTWPk54R8PRqyl/QKKmX2SePYcEFl/db7H6CyyIUS?=
 =?iso-8859-1?Q?59JmgI83sWQgVPFCBqvclPANXDkA/LAlJWXDSp7e2A+NfUFYu4uAPgza2g?=
 =?iso-8859-1?Q?KTbXre2UkgK4tHrPRcg0YIQrgGnO6XZ1J1g6WCJyimK2sf/CfkyNqDiYB1?=
 =?iso-8859-1?Q?y+Bw6ie1+f5L1B9FHv+HrD4mi/8Vhn4tJjdCf2dbKv4Ul5DkBgXKVyENN0?=
 =?iso-8859-1?Q?tzJuqViPjjMf5t2RSWqZWdIKaLaZkuOdl78HnqRc6cG969pOpwCfHSE2A7?=
 =?iso-8859-1?Q?ljBuITulcydB+NvwpQessvL+BO7IdBmRHsqPpmjx0pEaMgvgACJSFcwZvd?=
 =?iso-8859-1?Q?x2ITGJjxg0y3cnhUevSX2tdiLJ4E/BaaKcqCpnN09BoByzs6BK6z0XzJsj?=
 =?iso-8859-1?Q?Xmddi1o2P7Ry+2+gXws5x+KL1hw1v2c5gXxBXAOAmIeKU5eFF+tIPRMlVr?=
 =?iso-8859-1?Q?wO77v7WSw8bNkZAuYdpHli5CDwsHBVHPyfRMfSphVdLyGPH0hy/Yya++YY?=
 =?iso-8859-1?Q?dfLLaI7HzSM6PrdMaFlCczkRxU9IsyTZ/R3iEPrO6cV0RMMHNiFJIf6cve?=
 =?iso-8859-1?Q?dbn3OE3UTRnPP8on2TKpVOBZSUYMkuoZuKz8GbVrhfOMjWrBHa/dusASpI?=
 =?iso-8859-1?Q?+Fg8rJVkag9CnOZlIL1BIfVUD3CLYc41X6OuUsizK5Fcr1rFdhmF7/VR0Y?=
 =?iso-8859-1?Q?wwSf9HNhl2YbkyNk1h5mblk80vbQjCXAfPlcy1bPmZbaeEn4+s4iM+Kwnb?=
 =?iso-8859-1?Q?Gi62R4vO+TPaoPgCZDybtii3UOB8VRter37852pnK0hGXskjIG459GSyx8?=
 =?iso-8859-1?Q?ThFca/mqoygFtQGLon4FGU4Kw5op6lVphKHWrQYx8Az4+uDnLglaffgaQf?=
 =?iso-8859-1?Q?TFHbZsml7XTDjia7UcXFCtrBsWBrP0oGuFTQtv2fyOEwYB9ExDex6PjymV?=
 =?iso-8859-1?Q?Vc20LVAT7OV4Q/9saDwlzXbn/3jE1+s9yffSPK4IA47/XP+rR0JJqscG77?=
 =?iso-8859-1?Q?CPE5eHeoDG9KtURF9ez97xuIlzcqdx4UEz+sEe6l0Afnf4tNgs7rtDmpRo?=
 =?iso-8859-1?Q?Sq29XwsrT7KN9qbSFIyNhiIRq1zk+Lo6PeAbKkk24O5yq73djTrjZBU7R+?=
 =?iso-8859-1?Q?Hn7ZSoIaDC2W9A2QlsjXf5jK6UYH7PSiN5szpxqvzKXjwobg8+Rm2wSdzf?=
 =?iso-8859-1?Q?EJDurSHnDNjmPewH7GD+/ON8k+NdyaUR2nMvRZHXRA0iT5t1G4Qr7u8XTV?=
 =?iso-8859-1?Q?TJ9IuHVgqekVbt0a3v9N9fm0pXsTdfHoxd17WnNLq7UAHP8W2ttM1eguNc?=
 =?iso-8859-1?Q?NifepHqbfUiBqddTgGTx1NnVLzE2IfqylvA9U+OXWFNGvOj2S4Dy8ycnyz?=
 =?iso-8859-1?Q?63UUvtboXBSixxcm6QI3VC83ArZpulC17yg/z07aU5AeIat+U31hkjZ1si?=
 =?iso-8859-1?Q?b+RRrLZe8CArXqTGJksHGUhz22x2b1KBMK97G//xCFJmOEF0I6xsrNhAW5?=
 =?iso-8859-1?Q?FTIa799+uzWt+jPDNb6Kesxv06H0l58G13KRnoik8hbGB/DFduUjv/+qln?=
 =?iso-8859-1?Q?3uftOd8m+DR9vpSvT2KLKaDyw4PNeiBGDn7jV7WKBcZZODzmyNmJZU3Mkx?=
 =?iso-8859-1?Q?JGaWZBIwhCMCsGuH/cHjkgifPapDBuvlwSxRxFW9v2vBTXaehHfC06sNiY?=
 =?iso-8859-1?Q?N2DXwRVLbxBwmQkwY651EcpKT+ahCpylsnx9NM6a/dyWQ27iHogj1iGgzX?=
 =?iso-8859-1?Q?HIWQgDcMix2Urx1UQgBlm5WI4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7dc848-42f5-46f2-9f94-08da94a6be49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:08:30.4167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWCFs0c59VQ8pTFt+WQLmx3kOZnwJlSiEBsl+nJyDmFV/CbMeHhD0Q8YqxJo00K5ewh3QwkJ8lUIebrJevTk1wgGwD3Ce33SfpgHEkEJl5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4067
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
