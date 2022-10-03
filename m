Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4915F387F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJCWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJCWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:01:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15A1D33E;
        Mon,  3 Oct 2022 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664834463; x=1696370463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I7QqYUFMbprdkdMqcvuyHVAOBfY74p3ukXLxjMb3b3Q=;
  b=opHl+Ai4/8gQKQxy3nHKR4Fobgog3XjVuXqBkWCAD9eUTyDhGdof1QWL
   eI7XIn8KwNC/Buydy2U0KzgI6xJcHjriyp/BTCCJ92aQV1M2/xCoYs2+A
   RchC+JelriinE9rKpDGkiGZbkeB2hgj5bm5bWh27Juw5vKJoFM8N+SRQp
   UF4Xw2c91eXYGLXAtLb8TJ0BevJ4UjbF5F0PEO9tCooFWk0eBwgPZUgqC
   grG5Ose8/fJO/ambnMIMMey5Dwmx277//zVsaCJGfEmOJ7o4rQfAL2uXY
   66SH17RM+KmPzCe2pnlxNyZm8lTSg+SEWnZQ9ZByYdSaUWUB8aybZglBv
   g==;
X-IronPort-AV: E=Sophos;i="5.93,366,1654531200"; 
   d="scan'208";a="317177134"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 06:01:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/grnKEEh4S6tYU+A6XP+NDY0DphcE4hQGQE4bvEteurgFI4Xr4XBnhMtH89FlFCSIHxoBCB/fc7xJ5AnOmLM21d/n58EcuakJPuRrcK4mczHPiCANw45JX39uBjAAAJPwLxfE037PjUVSJipPjzMV5lzRsUwnUH2tPEO5WOGogOdcMrtuEbPMzLFXUFVGVTnuWuT1ZZGwWq5WzLMZhcJ12VU/P7B5B1QOShAyCilzYdNwsu8ygJoA+xZKT3EJUR98ELhiU3fsDlBpReOTiIBYrsuglrot1oPNl1j+cKjxb/Mgr78Pyxevs7qNG0Dz0GEpBpQZMbkxOdNYVWQHYMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP4ENu2upeAZkC0V9/2Kfig/cfYkZTlldOR6yreFuSo=;
 b=idv7DYGGCKZ4gZAEVenUVhob2M0YFRJ2L3LY6Xdu+Hdp30fercRK4N5vNmggKWZRV2vDKEcJkOABnDTIxzsrlNermu1Wnlha3VTQYY0lgquPc5swy1JyVUJKYhMyHeKpR0sRk4NODpOSNkVoWAuWt67/tqDs3qBmq1/LZP8/RR9MFMvbq9GgPuaRsX6X0TI/VPy0s3sBXkw5xhcGsu6OGgQUBEdQhN04/2AXmGnyoeH/tyXpCq+55qMa7lznHSnRx3NkkSaBBywrO1mu1D9z1qL4kBlGe+Gt4xA0bT82TIg4lzjU67LPh0OkqQvrLEp/ky9b+JHSnOyzUUXJnQ7VYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP4ENu2upeAZkC0V9/2Kfig/cfYkZTlldOR6yreFuSo=;
 b=k/J7lzxmcAUcsP+CK4moIqM1SbIO2KhOF2zM8evpjenRLB6vI/2ob40QIsmJsv+fdgpAfHDxcgXI5AMcZMV00MIVTJTrimr5wdwRgAJOZLI9xrgLpKz7gRh/m2VsC54fjpVeXZLsWfNTDEjrZsKmR7V50lS58B7xyOhee4hOENg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6340.namprd04.prod.outlook.com (2603:10b6:408:78::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Mon, 3 Oct 2022 22:00:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:00:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Thread-Topic: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Thread-Index: AQHY0yDOaUJLRu52/U+MvPPMhQxPMK39QDmg
Date:   Mon, 3 Oct 2022 22:00:59 +0000
Message-ID: <DM6PR04MB65758C73ABC2DD731167158BFC5B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220928095744.16455-1-avri.altman@wdc.com>
In-Reply-To: <20220928095744.16455-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6340:EE_
x-ms-office365-filtering-correlation-id: 4b6d9529-e491-48a9-73f7-08daa58ac15d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QW/zsxB1YBPQ97iakz7FW9e2MVz9POPsguypFqRycXIUAuXY/JCLi44Fw/QzgFNqUAQpszd+PjB1RITU0O67Ygv65uWJ7xrcEdpR9RNxFHaJhMKPe9dvxhfS4IAxZQbfHIbb/zlkkTL9Abkk+rB9upLbU5PpP/g3FS/8c3XCUch4TmBbi1+lctQrofqlzj1AT0HJDk9En1SApVFf9yfeHyPzyiGXXVrBxRnDaaUhxczNFDl5JHxLBXZb1ZBniLhW/fCo9r3yMx6Bb/v81H+N45cZU8SYZpkotxOIoG6P1a4x7yqqArahyj9+VeFBR9ce+9hMnzYa18O2ex08GexiP8gVkJ4lhl7rULF19KjvoUv+dddbUmv3dxN0qXsch2fGa1VghiSFk74yE853l93o8l2+Rky2LMUyrKSPordwHjYpoLo+fMe8CkLfeTjul4M9PtfqZFPKAAIXCdarSzH2ilW5ZZM+Wc1GDnbUeMaHwPD7I8PWGanFmrW3yrpw7PnIf2ULL9SR+etkuUJ5mo70lwnPwQ0s+W1NDbslzEsoF/X4p/0GxxWTjzKAusTD8DKIX6Q+DMuYSJDuIJe3cociloxpUxb2tlPpi0eQMP5sH8O3s5QnRuT5vLsAk0AdwoefsqnCle/iyjzgA+Jdcyk1W7R0WOuPsSm/Y/cgPv2k/4POUcj0Q3tW7n2SajhPCEfr+JwNJjofCeG+i1KYcDP89gzMIfFO15Xsp7LnYm0PjyfU5hO80H9mDaIGWg5dc6NUV9mysOWiKbc1ejsXdWeXiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(38100700002)(122000001)(52536014)(82960400001)(186003)(38070700005)(83380400001)(33656002)(86362001)(26005)(6506007)(7696005)(9686003)(478600001)(2906002)(71200400001)(5660300002)(316002)(41300700001)(8936002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(55016003)(76116006)(54906003)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EU9BM834yrXO7GqsQoUIZr33Bw3/JA2x0lmtut/EzJGDV2HC1+ZWEniAqRl3?=
 =?us-ascii?Q?XO3joovKIyqX2Nggz7FLwWIBKkE55EgH1JXUkfZV+oWdJow8BC792eiysfI8?=
 =?us-ascii?Q?jy5mSblpdQqSRgVGfFS6iPTNatDJYJSZ4rtGEjeMgjsRiI4pBSffQ48blpcw?=
 =?us-ascii?Q?v0R/w7V3Nmz2m/BkygwEa2J1tuxNWfqNVbLoOC4lVtWF7bovygq4VeTIazLt?=
 =?us-ascii?Q?xB0ZlnobQEnaI8H3Gl6JkomjP5BgADQvIYqcu+/g2S6cjsc5rkiSC+OMQSck?=
 =?us-ascii?Q?XPgCEjqtdhpRABkiVkWb9d5/ZKqROojIiAiKERBpypXdj2kqRc6qg7kcTBKm?=
 =?us-ascii?Q?97io1gmcFwkaFKiMSdc6Wy93tTnjAXOicTCSe+bMEclyoV8ouRpo+nZTpG+n?=
 =?us-ascii?Q?ZPSTk+rj5/H8sv01GgTW82ZnHaJ4cvNOuD2CbKACaMv8xeUzxtkhuwPsUDU7?=
 =?us-ascii?Q?Dxc4inZrauIXnuEvBJHMafa0ltc5zCNeEjez8Xzq1aztsGUUE6C0sMBSdR2h?=
 =?us-ascii?Q?NeUraZdZN1KjssvJgSvzH+HfLMb74prf3SWLgDS4JvJeRLAVx3fmaQeKEKdb?=
 =?us-ascii?Q?5MvMPzK5KOsqkx45GHEYbdJbKvw2gcliCcDl9eRoeGAiTyJmGoxRRpHzp2OE?=
 =?us-ascii?Q?Q+WMfKnN8Ppi/urxCOxXM6l+AqhdqYecciK+OEzG0vFPcpnHyCvxLCzhWoDa?=
 =?us-ascii?Q?OS1FbXMF8N1bSToOPCTi6Wqp++F7z7YNnl9vOs55lZm70RIEm8MlD5KTlRcZ?=
 =?us-ascii?Q?QBCdz7W5oUuXmnc+RHP16B/x/isiDuMXwq74iYfcYDMZqh3G7AdQRG/kEBGt?=
 =?us-ascii?Q?n2StYpk7rz4ukD0wfunqOcp9BfEHT90uEUp7eiwzM/uyZj1rEPz1900VTkaN?=
 =?us-ascii?Q?0wHEgJfwgQQECgZBNw68Ifw+yEGDerTUQP7ccTHiwc8lHXCAEKrp6/n1hKR8?=
 =?us-ascii?Q?B8rkJJs83Fldd72rQ3Jnd7MhpHI21cCz40zWbb4VKjGJ36LJF2Zer+x1rAsS?=
 =?us-ascii?Q?wIoGeaVJriOsepN7ttNhudg/8B18Y5W0TPRQRBha5/BPWQf8KBUBkOkNd45b?=
 =?us-ascii?Q?YOOZMdIlD/mq60xgWINIa4OH+WkO5+R63L39o0d8VCaOONPGZ/7+Y8rI8kpu?=
 =?us-ascii?Q?j3QENWywgjuMOJkRiIs3qzGIoYZ7XqMkXBPt8cgPQgw1lOs4wSkCPILiwaYY?=
 =?us-ascii?Q?im6W2xT0uwoKfhTY8YUPPyZel1rIDKQ30qwrUt3Cr9p/yaou8gEAIje9eQhr?=
 =?us-ascii?Q?3LS/uBVyxor5yS64yKSCUI+kWENiKSNlJSO7ygPTWQ5mYx5OmB2xfFW2F/fw?=
 =?us-ascii?Q?P7Ve/Df9LvwEFSzUtWiTzGikRd7dUs7Jc6MWNI5eLXIY5BJ2wVwsL3hivP2E?=
 =?us-ascii?Q?kNN7iYJhtoLl3llGFGX93xjrqz9bGNkpcYXLP0/sOGwVv8A/ChbAFwkbwIjY?=
 =?us-ascii?Q?KfRRdPPc8aZKi+6yFbFwoiR7sb3XSaF9eji0C37bsuND/UIei2A8RiHBVt7X?=
 =?us-ascii?Q?HVtAChyydDKjqfb2kLtsLuzqJGhTmUCTNgZ0TZGDufieFDkgeit9aeUqzB+N?=
 =?us-ascii?Q?izhMudsJHq6zNT2hbLhIOXL0vSWR+uJw2Cng+MG5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6d9529-e491-48a9-73f7-08daa58ac15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 22:00:59.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZJAujNKiYEX7YmFDpt9DbOz+lbRwWFxAuGIWtGq3jBv1iliPAsyKmVskUMXkAUwV4BVuguQAOBRRjisePQmdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6340
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf hi,
I would appreciate if you could take a 2nd look at this,
So it would make it to 6.1.

Thanks,
Avri
=20
> v1 -> v2:
>  - Address Ulf's suggestions
>=20
> Some SD-cards that are SDA-6.0 compliant reports they supports discard
> while they actually don't.  This might cause mk2fs to fail while trying
> to format the card and revert it to a read-only mode.
>=20
> While at it, add SD MID for SANDISK. This is because eMMC MID is assign
> by JEDEC and SD MID is assigned by SD 3c-LLC.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c  | 6 +++++-
>  drivers/mmc/core/card.h   | 6 ++++++
>  drivers/mmc/core/quirks.h | 6 ++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce89611a136e..54cd009aee50 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1140,8 +1140,12 @@ static void mmc_blk_issue_discard_rq(struct
> mmc_queue *mq, struct request *req)
>  {
>  	struct mmc_blk_data *md =3D mq->blkdata;
>  	struct mmc_card *card =3D md->queue.card;
> +	unsigned int arg =3D card->erase_arg;
>=20
> -	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card-
> >erase_arg);
> +	if (mmc_card_broken_sd_discard(card))
> +		arg =3D SD_ERASE_ARG;
> +
> +	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, arg);
>  }
>=20
>  static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 99045e138ba4..cfdd1ff40b86 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -73,6 +73,7 @@ struct mmc_fixup {
>  #define EXT_CSD_REV_ANY (-1u)
>=20
>  #define CID_MANFID_SANDISK      0x2
> +#define CID_MANFID_SANDISK_SD   0x3
>  #define CID_MANFID_ATP          0x9
>  #define CID_MANFID_TOSHIBA      0x11
>  #define CID_MANFID_MICRON       0x13
> @@ -258,4 +259,9 @@ static inline int mmc_card_broken_hpi(const struct
> mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BROKEN_HPI;
>  }
>=20
> +static inline int mmc_card_broken_sd_discard(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_BROKEN_SD_DISCARD;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index be4393988086..29b9497936df 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -100,6 +100,12 @@ static const struct mmc_fixup __maybe_unused
> mmc_blk_fixups[] =3D {
>  	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY,
> add_quirk_mmc,
>  		  MMC_QUIRK_TRIM_BROKEN),
>=20
> +	/*
> +	 * Some SD cards reports discard support while they don't
> +	 */
> +	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344,
> add_quirk_sd,
> +		  MMC_QUIRK_BROKEN_SD_DISCARD),
> +
>  	END_FIXUP
>  };
>=20
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8a30de08e913..c726ea781255 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -293,6 +293,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling
> SDIO_CCCR_INTx could create a fake interrupt */
>  #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
>  #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI
> support */
> +#define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD
> discard support */
>=20
>  	bool			reenable_cmdq;	/* Re-enable Command Queue
> */
>=20
> --
> 2.17.1

