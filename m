Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108763D025
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiK3IJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiK3IJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:09:56 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363BB2F65C;
        Wed, 30 Nov 2022 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669795795; x=1701331795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r5RS8dbw+LohJM2u9KUUCL9KH6qfA3vYKHYQGmNR3kw=;
  b=VVLvPoaPDgMM2bdwTCios0xpIlUn4gQlPZ1eWoozHTHWPuHCutGKpmQc
   loZ53YwSZHIt09VD0JpEIqebF/d/Q8B+3LbS4RZ4LPtt+fFjawzZ8mRE8
   Y2ExXVixqrudfec+/B80GrToBRIQfnWC27a7Z5P8nstNePP9kYHJ2AnOj
   WPrkjufvSY38nD1zM0BT1vL4aOzV8lv/yuf0IOdK9dngxOApVN/YfHIbO
   sT4MpEa/yYJx914pdXChor4cvXigZWKTtgMwMj2/qsc1mhuF36bPgp2Sv
   Oi7exAuyJQPn/BfL6098BsodWPBdIkayH9t65PTESDHVgOCQ3RC2icFI0
   A==;
X-IronPort-AV: E=Sophos;i="5.96,205,1665417600"; 
   d="scan'208";a="217819466"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 16:09:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMTEw3gQ490yKRQJqWXcuSF43/1NbQczFYKAGq7HjrrQZBlOPB0d7nkbpBjdYS68sJlYMnrRkq6FrR4j9XEMnCT5BZpPiB/aGohfVtgSuOoZPQZPQW169eyPYlJUOAEz8Jya40nCPgA6FwbhkWIyt27n+1+KfaIHQjgcedLLfKRCXWcu8ok4u/BFgOS9/iVbO5otYhJTmt0MHzv4IVTDzGYWiMaNQHxzRgnM2BGbTT2758fCmosM2+2ypiK7yCdh1n8d0HruhZHFwd2Ar7DbrgvYbXiYdOulZq789/wj7ir3q79xdybbyFsK7c1cFvDDDG0PHd1OCqA6k9rTPUrfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5RS8dbw+LohJM2u9KUUCL9KH6qfA3vYKHYQGmNR3kw=;
 b=bxPi5+kk/eoBw/fWrTVzSHn2GygzhDcXFZGTEZJPYrGb6qG8WP0OjLuoWKscv0jH0wZ+VljFNYBOaLnaKLT30y5JeTUD+N2FnYw/zaG92FgXFDRf926rv0sNFhmVpXeI88X4L2LOUjIzyPSKdLK+zlEBS4uUx/AFNeMMaiEYNEz2xI1wUD4jrzCEmuDhEfz36I1JY4aO+IxqFbgUjmfrJtDphorxj8s4fEF4ps4xSOGC2gTEWZtdFBzKzQMNC4pzn118MJtVazlmTKWBjGm7sNKDN3tBEdRUrfmnsaOTydcOqSWnWmLZQ7kAAOnog3lhM5U/3LZ8SyYRelNC/pDZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5RS8dbw+LohJM2u9KUUCL9KH6qfA3vYKHYQGmNR3kw=;
 b=rKz/cgpc0jvW7nJNJP4nOl5+wir1a43oM3RTzzIREMcaPy4a8xIgYVt9WPK1bA+irGrfcNMXLW+VU+n/QSw/+/jEMlbqs8IZfwDCcbvIebDnqy4ac8OM8/eVJi/Ye+BbXD4htEGt6WetamqLYZoTAWFSI8TAVd4rDDxXYQyDUs8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0411.namprd04.prod.outlook.com (2603:10b6:3:9d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 08:09:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 08:09:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 7/8] null_blk: add param to set max write-zeroes sects
Thread-Topic: [PATCH V4 7/8] null_blk: add param to set max write-zeroes sects
Thread-Index: AQHZBEp+OsGAtgqQokWWJUgXPnCtJa5XHaaA
Date:   Wed, 30 Nov 2022 08:09:50 +0000
Message-ID: <20221130080949.3hzjio5x4hagvgga@shindev>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-8-kch@nvidia.com>
In-Reply-To: <20221129232813.37968-8-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM5PR04MB0411:EE_
x-ms-office365-filtering-correlation-id: 95f59663-94ff-4131-5ecc-08dad2aa40ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ipxVO0ClKW0qrA2UgiV2SNDi47UWFQOw1l/HK22kbvRqarDKt9rOcVMiIrHnW8H2i8AzqlExT9wgTuXJ6ZuM0cOmcXczK9P5wiXxFGFBXtnACo17JNnzW2El7SHId3VNIBogwELzSVAQ9T4ENZvy9ZED+fR0WHPyLNYgkB79ul20FLIxpKM41jge3WRvTmblGALUDE8xBOmVy/kbZrrhvTox4F3UCD31NWrAA4I7auxAxDi4h2xZQ1BqyShvEZWdDnhdBhkGad7jUnTlYevAQB48xP+KpURovrWQliIxn2k+eaAsQKv/R4KmLgiSB6/ZR4QuMvu72BwNphH1emr4ZqzSqENSjF4gh06hsnrXbyl9HH/2XRWr8GDm2c9w59zwbz4BXlAZpNEiv9sHgC5kgiKACojnVQC/2Q4D2E1Fx75S9EkrxPQ9Nfn3V5HLH5IgVzJLHGh05qpkPSiN0P3OExOsoXL3MxMmj8vrjTzySXw276ZOZfY6Xo14km9tfr1w7KO61vb1qdpf7S6/gY4vEAKrDwvElwL6sQJW6y4z8QyJS3BJh+pmRTn0v01bfV5wFg8KP2ewY0bO/wf7cQZpBiT80cFhEpvKdzG99gmRF0fXs8UutzGtkSVOmM5sQBewkZ0LMDPXNQ6jPmnQWopChvvCQXhgYv2W1ZluAbIN180hqMos8EVQEN903MPaxCh8QTMEdyTnwoCQn4erTpeoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(83380400001)(2906002)(41300700001)(4744005)(5660300002)(1076003)(186003)(44832011)(8936002)(86362001)(122000001)(38100700002)(82960400001)(33716001)(38070700005)(6512007)(9686003)(71200400001)(316002)(6506007)(54906003)(6916009)(26005)(8676002)(66476007)(64756008)(76116006)(66446008)(66556008)(4326008)(478600001)(66946007)(91956017)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zRPBEImJ5zCckyKa+2RJqInmIow1cB+tXxRX7yTwiLw+OV42Gvju4WlC0LrI?=
 =?us-ascii?Q?6NhK5iKmFlikJ+MD3Jh4MWYg7oo5vrmo58z+/D9Oxrs04B5lkFLKPG8hlM52?=
 =?us-ascii?Q?GgZlqibrrxJsSCsCMsOeHKHlzvQLpBLCvGL41CJJ8GAc47GO9wIBbYAS1vzF?=
 =?us-ascii?Q?oSyVVUeVumUc2bZSKGfM/WYxu8sudrBoNV4NhHi2m3eldV+ffxU1Pqem2vA+?=
 =?us-ascii?Q?/YXzWHMz4B5X0qmaYNEmfG1ao9s/3EAtkResCoU3X5+TsFz8Ya8Ym6C3UgmR?=
 =?us-ascii?Q?LQGKI7IRZyuhOpclizc1P5TmNdhB++Y8UCKHrRLwZ8fiOWZxgqPn2f4A706y?=
 =?us-ascii?Q?IEBSoLghE0dPNsdYvM0xILtJedyPYkxeZz2hRobMmCR0aevhTTW2iywfV9/N?=
 =?us-ascii?Q?qDKd0LY8RapXPJfaT+BWe1fMa8ofXQPLDhwO4n/Za0/aUvaeq9yzMRBQJMOK?=
 =?us-ascii?Q?NrNLu6RkwoPXBLQdPsrxoFUo8ZG+SZqwL7HTBy+lObHPXSKFt8w1dBMmeUMZ?=
 =?us-ascii?Q?i16jKz3UU6kBtPN7Zhrgmf7apB1WBZCMoF0Q3bzp7HmpkELWbzVIrkET6s9U?=
 =?us-ascii?Q?BoptTXSu2B3KAzgo4lMRyd+pJd70ToPCdhxJLeIYhv4uGxoc/1BKhKq0tK4D?=
 =?us-ascii?Q?kVqa8EdHEB24cTjduUp10lzSq9AhHczr3Mds8LmKbc0u++pN1EZ3EprltJjy?=
 =?us-ascii?Q?W8ticz2qFn6ualhBD5LicmIWBbR6fedAD4Yn6rQ4S9qErVDgCy5Ven9XBM8w?=
 =?us-ascii?Q?xAiyw7C8oMXkCz/x8w7ioVOZ5nbEj6+2jUxqDoql3QQkvYzrIQOUtpH8j/N9?=
 =?us-ascii?Q?Q2OaQ5K+Naezr34pABYAoDWjTUFnlH1Ya9piN2KNDTWODiVNBCNZYDYMu02o?=
 =?us-ascii?Q?C8K9zU89OCO1rPvwL5Mf7ligCMriGxhyhE4VFO9l7CbNpf+UHFKObPtinRWN?=
 =?us-ascii?Q?KjWP1fK02rMQykddeSaVN3+mAU0i3rB057/TEs4v3UfbuVTRq9+vXF0NK8va?=
 =?us-ascii?Q?sVz6h8G7jXVcwmZZxVIBE8ujtGjkbMTOKIoKLsSKNtK/VuoUYRsbGQh4tGJ7?=
 =?us-ascii?Q?Jlbh8tUNfeCjCTzmS/gfvgMlNxdo5XH5ZV6k7GE2aVd2l09MabkNUA1a1syZ?=
 =?us-ascii?Q?AV2nj9tonUSkghTBtE/+kYVwDkRDvATT3SLV6/M+5RWRzdPniq2dhHwkNabM?=
 =?us-ascii?Q?ztOZo1lAHDSyK/uAs1eQOhNUgVw3ICAKvpnqlei79IsAF+h1cWpb8WERu6mF?=
 =?us-ascii?Q?tMKy5v8HbJvSFO0KU80JF5+JAgC8h19T4gWD3PPO1zBjgD/diuFiW8LBRQR2?=
 =?us-ascii?Q?zZHfp/2dGKJlKr8f52rDVBnUuA1yt3waJZKgPSXn5NglYmkghcKQahxQvc34?=
 =?us-ascii?Q?SDI1CDn33I37xChFPJLMJf201lxoGgWOroXqq+cJqNk23gVOoVGpBexDmtbb?=
 =?us-ascii?Q?9DoglYuW4RmHesmPXRzJT7VFxwLbhxNILYKf7CwtUoPVyH+TAC/4WMsR7m9P?=
 =?us-ascii?Q?LHitUmmxjRg/Xlsufh1QNXoBiMsf0wQMCHNNtA2s4OST75TXgvcuTdKaKVv3?=
 =?us-ascii?Q?FBZ/KcWxp96JrhbQYoeYF4BI6z7WjN4hlZUItHZg1AXtNKAs4M1KtFVxkUD2?=
 =?us-ascii?Q?RdoXMcHoKC70q+5j+WV+Vig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BD75020AD37324A8FCBFC9671A811F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xHGJcd+BT4Gy9IvCQENnWHI0GWyi7NP2TBfSqVuDUP3Koc1WW5e5GlWlorxg?=
 =?us-ascii?Q?dIKxrM5YvMZGQHz0AnrW07WECd5Vpmm9cwZF97WLe/3i8ZdZdVoAlIHjmB3n?=
 =?us-ascii?Q?LtL1XCYO2bZ+5yxsOWQryw8zXZmju6TWbsptF+HiV6g5N2l9ZGvjuxRnnxpQ?=
 =?us-ascii?Q?rWtBWuU3UsMrzJefOR7uVEHislICpXY5BIoWSPa9Q2vMcNqD9j7619cxXcMl?=
 =?us-ascii?Q?kN+hdl+xhxEv9DikzB9WGyLv1NGJOgh0lYJSELF0JlLVTshyigEmZq0VyhK/?=
 =?us-ascii?Q?pqu+ETTMf8xRaKlQ6i7lK6OWhR1uHccBXaTdbO9FTSgLvJ1sdgWuBXOGqMDW?=
 =?us-ascii?Q?2yjz1zRsaKOewD5gCLPBy6HaYaUcRayWuvuSJkZ4qqGnga+Rk4Vc6e9f68Y0?=
 =?us-ascii?Q?lwwYuhyP1UJ8tq6qxUMjlVW53N10A7YHELKoVIBdK2CUzvM99FTwo22QGQ+z?=
 =?us-ascii?Q?UclLJMmZ2MRhnhxtqlPwNoKYu+UYOrVsVjdNJpPZ9SN2MDu5AJuWBoqDiKpe?=
 =?us-ascii?Q?wHYrrURqTw3jVDlY8TSj1y0uIIuK5WsPOXGq1fKDvikGecgl1QLZdBGu0ydj?=
 =?us-ascii?Q?ba9+j2td5T4Lnj6yAKB/YuWmOvXQoeHpNyywJd0IzB3Hq0veI/LJRpzcHd4V?=
 =?us-ascii?Q?qopsbNLvz9kjjgCxs1y6t793BIxYWtn7Ib+ETxAVvxCZynjweDHQUQE91qZR?=
 =?us-ascii?Q?ZecNb3ArbXnxNdwPDGm1fhqbO2od/apVf+mghnNTH8ovuQToLjmqEUdca547?=
 =?us-ascii?Q?qIiJigfd9lNNNhXLsVHPJo3+FkyPV2HV4Ku0RbI6SK093buN+OOMrLQ8CyDy?=
 =?us-ascii?Q?ga0GC/NeL2DYIjbhvGIkkHLLFPLKtkWH0nz6v7JPrwSSdiVMnYqGALzGnrVp?=
 =?us-ascii?Q?S/8kx8aA1UTKjbOy8dp5KTFc8q59fw4dzWteB9TXbS/65nRYEB59cPqOWIIL?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f59663-94ff-4131-5ecc-08dad2aa40ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 08:09:50.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7kJEY0ePUVbIZx+tWStST0W6tP2FTrozuHiyq4IyDXTgYS+Qd2uHcDEqK3EpqWfimcX+Cl46l10sWhPya1Cr9bnGF8mRXZpikOxCt6y7Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0411
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2022 / 15:28, Chaitanya Kulkarni wrote:
> Instead of hardcoding value for the maximum write-zeroes sector to
> UINT_MAX >> 9, allow user to set the value with newly added module
> parameter max_write_zeroes_sectors.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Nit: it would be the better to note in the commit message why the default v=
alue
is UINT_MAX >> 9. Other than that, looks good.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
