Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9260717F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJUHyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJUHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:53:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3D24A546;
        Fri, 21 Oct 2022 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666338826; x=1697874826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XA6ROhbsMYF3Pl3yOxpjf1JHVk/rpH4SA7RrcJbW/Vk=;
  b=FpkGhvrV7xjsVsmMLB8CLgAgq+buRrtiTNjmkDFmVsta+cCO78D4TmJk
   MIdgrYzSln+V6lQDe33hvzV/UC94UhNtPXuDat9Sk2OaCDu/p8Kxl4Lzg
   oTxGuKchuGvTgL85WkiCx/jIoxxZbuEJyMNRshnWLVdl2MpZWjYYOk2NP
   0gc7rRlkVUVVeW1aVIRS1WlCn0xN7Q71lrc6enxY9aPNczjqq02PP2MSL
   E/G7Br3jwlTCnyMcr1NBSrzciqrST+rIRicZr9gIgqMJb3IFPK9RF7mOU
   lwn4I3eJ4HuhX5CeOBVlJej4UzseNwusJZIjaMGipD2+v+HpaleupKeJD
   w==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="212727674"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 15:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXTJAI4SNQgaDm8bt6gLyY3dL4cQX78HusEyRzBh75ZuixKoPhfjf5ztVC5umRynsTpIrP/+vEM/Oe7vy/2+89LUZNPYyORuLfstZNjeuH/d237iKD64hGvye+7U1H1l+H1dgTZu15zaK3zY5xGCqwBY/jl0ENUkR4v264V0ajJX80hRMjoPU+S3E4y4kzU23tmp9PPz+43Uy9cEywcBn1ko/jAp3sxX2dH3ad5KGFE5GnUhQr/BvJ3ihK1fn3iDb4KDBWUNup2IkeEtG40lmh1rkMBq0mjOZTwtp1lz0ShkpuVlXsJ0/XfKLEBDca77bKoExHBI5dHD3IHwzs7zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/OZgQH/VZTrelYNgEKcKyGUkzbAhp84FkopuzSXypI=;
 b=KuImFyQwsEcuBXeAwWaS0NFB6Smpk2mVZU0kODHjSPwv3vBvGvd0qHrBfH6HBtbUbPE5W5LcHIXPkTcWun5L1xialtq8W8EFZi83idHACh0VEl37BJKcH+i4tZ0caWFmoHhl0ERhmBtS0b3zpT0srE+UeiBpnI7N/P5GM15XDcE6ScuK7lH/ZIUKZHTtF9yRxRkMHaAoyVr+8toh108HgQjGvRAdo9CR6U7T+2lpZRHY3Auk6o5VfK2emNHtj4k5dILbz/w3LJNDwU/hx2jez0l+KhqhgACWzKqopx2y6jWgHnQNGC9ehnJ5f1/Us+/TyRewvv9zLVpH/YUzLFjJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/OZgQH/VZTrelYNgEKcKyGUkzbAhp84FkopuzSXypI=;
 b=z+PiVa5UqLjpom9s9n1Jr65RmODiba4ek5zSW3VqEiYLzWPnTpYRExXKXjohFi9FjIcZMEF/73wmXBIw7sHk1HHw0GifHvm3VkaSUerbIVnoQqyG87ntfiu1U0NZvt/vB/AqtJw6Hi/O9988fRaw4kfATMdeNv3DVtngxrQPrg0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8077.namprd04.prod.outlook.com (2603:10b6:408:15c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Fri, 21 Oct 2022 07:53:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 07:53:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kch@nvidia.com" <kch@nvidia.com>
CC:     "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: RE: [PATCH V2 1/2] mmc: block: Support Host to control FUA
Thread-Topic: [PATCH V2 1/2] mmc: block: Support Host to control FUA
Thread-Index: AQHY5R8OLfuUh6VcvUiWPq6FTK+Zba4YeSHw
Date:   Fri, 21 Oct 2022 07:53:40 +0000
Message-ID: <DM6PR04MB6575FC4EF5E3CF08A90279F7FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <20221021073025.18831-2-wenchao.chen666@gmail.com>
In-Reply-To: <20221021073025.18831-2-wenchao.chen666@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB8077:EE_
x-ms-office365-filtering-correlation-id: 2e325c50-cf8e-4cc6-9b71-08dab3395e96
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zB4DEZqgKufK7e/rY2R+PKbcSpoFBvUmtLIz8FBEtl/XZkejdeuuKwXEeP9ZvUkrfO1w4gJRoFVN2iS1RK/WKPbrAjjpx007TXollspEPTyr30bjX/AEd11ROlspUYhjysH/zJVrw6ADaCVtvq6ctEMDU3reDjTquXol4b41QnMSy8y7173usc+ugj1+N1oop+3+r9RycaYhJxfpQhOTKfBSyprsZidzDl5z/c1wGrwIaZaVPNe9Eh04kmB2k0nyWr1zaBeW6szobd5yi604Rt5v7X86br3qN+usIN4yRo1IKWwbISkWlsZi7c+ccIVflDJX90CkvfWvBJZey5e1HxK1gLFNVfpbjW6frvS7EC5ZS5tbHyr7kODIDd5+0udd6ItO6Ijbs0GXuF1cugtlMF8nhSCU07022eJqIGUevAppT0Xfd+BtPRLsLs6AGKYjmk0zOhNFEOgz4ZqCg7AdQ0XoaejQo6uWv4eUUKaSrfF3pnHMdYsJdQMYVUl6dqdhT+vSUjUJ42D53bq56TBoSz9nCgnRjRlz4YVryv16TlGuUGLGEcqgK7yproLJpEpCBT9GeUouYjl3GYzIbUcp1VJCHwboKgl5Reg7hIrpxPmn/9IIv+4xGvKMRbKw539/2F2L/696+rZHUzFDCrNMvn6WZJp43BNYUpka9dmpXSSgx159GT/qsHqi408Aqpu5CAe2h5Y6sUQo4lUPy4HawR2BBWaJw2Cvuzj3o8RmZgFowvtHLMVSyVyY7Ry8IOnF6Jisylly774ElkAd6GEmGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(41300700001)(8676002)(38070700005)(478600001)(83380400001)(86362001)(122000001)(7416002)(186003)(2906002)(8936002)(52536014)(55016003)(64756008)(6506007)(316002)(26005)(9686003)(76116006)(4326008)(5660300002)(7696005)(66476007)(66946007)(71200400001)(110136005)(66556008)(66446008)(54906003)(82960400001)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CTMwHmQg1qDiubggj9u0e6lgxv1tmRCV/VPrdDeynXKVvjaBAKr1EBAF8HQv?=
 =?us-ascii?Q?5i3rl8mHlZCWBTi1nRoCQsfrSaBQTQeSmRqdZhedHjXv0sTYQ2VOM/qvhYcy?=
 =?us-ascii?Q?dwAnQknS1wik106B/gK2OCEPnMUfm/nn22OSjazbF/yoBZAGag8nT2fjLVOy?=
 =?us-ascii?Q?oIss00kH9SvF55esl0lbEsN8f0ioTFPVXGjjDMEvkLtS9Z8Y34V4cePzyrKn?=
 =?us-ascii?Q?leO9JXHdTGR692i4waqglpkDw0FLx8soMNHxkyUb7+bnCOv9fYU95Z21vIuX?=
 =?us-ascii?Q?mjIWwTjhsLIgrd0kGF4LWfXAs3R1zDCRMERmvuZLbKPLW8yVuTU1Pvz/CtJz?=
 =?us-ascii?Q?P1WM6TeuEKMhbwLdYyAnH2OnrFBKMLSeDIoirCOI/koeYmovFPy9OaXT2nP3?=
 =?us-ascii?Q?FOKm2BYYkoczTP0Wzbo3dTyMQuVCaNlR2XA39c/pLySyGFIPRr7+jwA/q2eb?=
 =?us-ascii?Q?qL8HvChk2PYECPgBY3g5RGxiI64uZWOY6AzL+yT2IHuvvNcGryPP+ABbRviJ?=
 =?us-ascii?Q?BN+9B4swEY+XfPjfBZOGbLs6HzB2Rl6VljW80U47JUtW3figV1Erk0lsBKOO?=
 =?us-ascii?Q?IfV1mZ8eUVsXJhjKyEUz5+frmlmJ9N3onSTe4VHdX2nMIGRlAVY7+gHxgxHh?=
 =?us-ascii?Q?PHzvDlfuG/1Q1jTNpyvX3kq22DYDPeboxGRKYpBxDZZ0Ou4wngPvsK0e+o+l?=
 =?us-ascii?Q?WcpSSHGgk+mnWEAnFqRG9KotV8LH73RRsIEVismyffsB7sRdIaK1zE64hhnM?=
 =?us-ascii?Q?D27/CNSpNFIO6LUwbxaeSaOo98hX23NqDQrs/QVP6oFvIEr2rZWB+d1Y1tad?=
 =?us-ascii?Q?P/dy41OCJdoZGZtd6VEnPXzU0TZSw0CXieC1GUFcIsp3O9cakmVg6ePEeIj7?=
 =?us-ascii?Q?s6GD0gADY/mkb9GrNTB4+47tLuC9ku7su3v8r5PVTzWlMbQUi59eQGaUZmMN?=
 =?us-ascii?Q?CLOTZQRzuBI4JK6swPux8NiRbRqCyph2Yoyg1EcMg+AQh6GDhd4ihlfyjgAg?=
 =?us-ascii?Q?EpiBSwob61YTII1yYFnUARwbF7EPiVkb1svU5Bl+G3PJi7xRRhMkSNVE09tf?=
 =?us-ascii?Q?eW9SioZky41Xq0QSX0op2ECT1IPPb6WfGGCF9yKiZBVXDEmDqIut4ZIdIEgv?=
 =?us-ascii?Q?ndSURusQxYeMDMsoLMDiMa7t2alke0qhOF70MJlQsB/Ig2xG3PvbIOduAyWt?=
 =?us-ascii?Q?pAPOlbWZXBgXoNZQAKft9FWb0cg0lTeo0FOxEVY74tBTz5FdzKsdQipNfA2D?=
 =?us-ascii?Q?R0U9rbVtb4ejqbBV4i0A3dm2qnOf6n5K2RiFqHIgVsVrvr3l7KTUpF47q5NG?=
 =?us-ascii?Q?8bQZSHvet4j+O/IAifYwffzzPSWjmDDYkqel6H6uEmGbslU4H6k8t6szVB61?=
 =?us-ascii?Q?SmYi3vugRT+yeJ6hs3d/lIotfaqqy/TsLS1JeIN2DUh4PjCoJgnJRY42dnKb?=
 =?us-ascii?Q?GZbBrW6wTAjMNqeZWD/WCWOyP5jDi7wpM26M3nWwb5NG7IEIV4tFNIiMyoxj?=
 =?us-ascii?Q?DDEJiD3adD6y4md5WShjRNXMTMx4DFa0F/t0lk78x5dwrbINHLm7gQSwkqhY?=
 =?us-ascii?Q?d+U1jLxcugNaAdzh7vG15vMI60cmGqdx0qfKJrkb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e325c50-cf8e-4cc6-9b71-08dab3395e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:53:40.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozdUqBG7WwlK7Hc2+H1epjr3E4TQ7Drrl1iVcsT68B0jA88ZOpOBQD51MtV5DxZTW8Gw6j4+CzOcg7wFwtf3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8077
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Wenchao Chen <wenchao.chen@unisoc.com>
>=20
> This patch introduces host->fua_disable for MMC host controller.
> The host can turn off FUA to improve performance.
>=20
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
> V1 -> V2
> Address Chaitanyak's suggestions
> Address Avri's suggestions
> ---
>  drivers/mmc/core/block.c | 3 ++-
>  include/linux/mmc/host.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 54cd009aee50..333e819e077a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2490,7 +2490,8 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
>             ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>              card->ext_csd.rel_sectors)) {
>                 md->flags |=3D MMC_BLK_REL_WR;
> -               fua_enabled =3D true;
> +               if (!card->host->fua_disable)
> +                       fua_enabled =3D true;
>                 cache_enabled =3D true;
>         }
>         if (mmc_cache_enabled(card->host)) diff --git a/include/linux/mmc=
/host.h
> b/include/linux/mmc/host.h index 8fdd3cf971a3..16a5bee3eeae 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -517,6 +517,9 @@ struct mmc_host {
>         struct blk_crypto_profile crypto_profile;  #endif
>=20
> +       /* Host FUA support */
> +       bool                    fua_disable;
Why do you need to invent a LLD mechanism, when you already have a block ap=
i (QUEUE_FLAG_FUA) for that?
Which is actually misleading, since /sys/block/mmcblk0/queue/fua will still=
 reads 0.

Thanks,
Avri=20

> +
>         /* Host Software Queue support */
>         bool                    hsq_enabled;
>=20
> --
> 2.17.1

