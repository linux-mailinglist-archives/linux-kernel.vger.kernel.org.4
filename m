Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E36DF0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjDLJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjDLJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:40:24 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F4272B;
        Wed, 12 Apr 2023 02:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh3oNnfTOpPWBMZPb950wthcKH01ky7eELf1t/sPjLuO3yPqro1iNIXxCXU8Xu2K1zfX00MbrM2dN2UWeWkTDb2W15XZHMGbMJDixlFUz4eYF6Tyz3iCFU18nmVCqQ8951frrgoINXuhqndAmrrkp/sE7x9A+kSuv/QpeGw+T3sa9daN41GFIC//wlbdDAbJN7VxI/LNjeKp+82spofvzdN3bUu2IUtemUzOihofbfK6Aa+7hiXo/723uGQVtz/ujAfcJMeMFARThIL3VaJLilTuadofPKoXqfKIWGp0dXXVL+CBmIw4sXE2vof5B+DGDEKWPebCg+j9THEOvL8Xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQeeUnw3lsoxNNCG1poiAycpyN9VoP2fGpMnJtTxc8I=;
 b=B3Yx+TmGZmfdA5Q/FHFM4PoKnDpJfcX3mF1YRZLqOsZgUHzIwWN0IaCsW7OCx4A84sM2RCCUQrczOjKuPWWo5tYjewKa3wC8lO8JUjvLtPK6EhQMv4UDyrnVjkyDlBs8rSHBoTdw4G7Hfswzz0zMT/Zj+tcUtIKGnT24RYy2lLsW9sgRb4UTPtoPp+9cHUFaGsz8YTxqgsJGEFqdbg55uJmI4Jcl+bPejPQFYNYpzwmBTyg7SSndcF8gfnsgXzSm2TBFtiKBr6sSuLHRhIAPaeV2aTo1qsVo2lweaDhWrH9oLlqvh31mb4ci96ZrYuRNgwv9honSxFPLB/sQQnpObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQeeUnw3lsoxNNCG1poiAycpyN9VoP2fGpMnJtTxc8I=;
 b=IOZNRndI3uOiB+2wuOQcvpmht2IuCAoN5hUecAdRll5iMcwiyxVqNsgxSkCsGhfrr2mds0r4+63e4O4vZt0Sin5sjkDB14aDYlcBNIHXgMSB3PAB/JiCcLyZYgbBBfSL4e1/kZd7smnR8FVHxGc3CXsi8lCL5CjFHyyAPWwr4p0=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 09:40:19 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::8735:c480:4ac7:165c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 09:40:19 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] crypto: caam - OP-TEE firmware support
Thread-Topic: [PATCH v3 2/2] crypto: caam - OP-TEE firmware support
Thread-Index: AQHZZ54rO9qNJeZtqU6iA+JQgLatfK8ndlBA
Date:   Wed, 12 Apr 2023 09:40:19 +0000
Message-ID: <AM0PR04MB60046DFB1484BFFCEA54DEEFE79B9@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
 <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
 <20230405090752.1708455-3-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230405090752.1708455-3-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM7PR04MB6822:EE_
x-ms-office365-filtering-correlation-id: 68e7497b-859d-4fcc-f5cc-08db3b39edc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RL/n37zVuEEMcjkzi6cmM9g2bVZj+IK56+NPhM88hf15fZ5JWuQv4B9XGkPZo/7ADneoXIfHN0/hZgqfvQT/FrRY3aRMqBVtHyxL6dET6w7ooQFwUGzvaXCklC94pK0m99sUxPy/pUbSpGKScSzUS/NL3vdWNLvUDQxbPH8910+L9eF+s5HANc5I5O6AJTeLMyrC0nM3leA8UkXlkvck+MMdNJCFI8C5F80M28okjfCzfgyoMfnLjw30Mp/iF/zzRhuHqZnVu1Gfci99Zkd8a3wNQoRlCDFSsmNrdO57CVKKyIgkIqw2oLggTCtKiw9AkMaluBGVhYj2m2OwlHHbitKbVJ1Hw4ImVSVUvqW9ie4hS5joOtg+2kJsRZeg6PhKCDqcqX3eBw1BqpW8wzOYmUnI8lB8s0wyGcOGqS582nkG/Tm5/w+/Rzs4+rqY8jL3tZZ5QjFPIpinJTWhPAjir/dSv45Fuj1j+qakPKqZPPW64NlMxRiio/rN6AADGd5zLOBl7uw+X0va8j+8qR1kZJIwu+nUoen34b68JfcCJO30KEPxn8/g4I74b7iCMV6QEL33Tg10XvTYM5i5cJYIDcKAi7Vdolf78mDcdrAt/hrPZ7hwaUJ5bp3GYMby+ebUBPuDoUeFBCUgIie0cnzDtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(76116006)(83380400001)(478600001)(71200400001)(7696005)(26005)(186003)(6506007)(53546011)(110136005)(55236004)(9686003)(41300700001)(2906002)(44832011)(52536014)(33656002)(5660300002)(38100700002)(122000001)(66556008)(66476007)(66446008)(66946007)(64756008)(8936002)(38070700005)(316002)(55016003)(86362001)(8676002)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJ7jmE/PExSM9Yoi61zQ1nkE+z3EVrDj8M6BpxYuo5OVXPlIxqqsLn7AmIEs?=
 =?us-ascii?Q?dS32nFVQ56m2KdlZvwyF3RP06eppo5Ixg/2Z87yhazzSvrho6fPX5ehaZpQM?=
 =?us-ascii?Q?sknay1ZctOswpFK3SrxWSfcITyKxmvUpPNGVxjLcyq2w6DxU6HsUeQ3IHr4l?=
 =?us-ascii?Q?gOTL/j5wrCk0MW56IHsDvMi8v595eody7EZMMs7dfUjKOVyxNIipotDQEHj4?=
 =?us-ascii?Q?NUB1W36u7aL6wmcC9Pso8lyy8O8he/2sxF5cV7mVVfbE415ifitHzzWdwgl5?=
 =?us-ascii?Q?Q2saKtppA6SzjWh0CfvvejLWNdyS6ZWOYkAIofZOmf1vRba6jtp0O9+CjwAf?=
 =?us-ascii?Q?lFzKL7RTL2GK2aTXitLCvJ/NKvwIXwbFjTjn6ixKpFPpzLHI5RuKKKwhwLU/?=
 =?us-ascii?Q?whKfXQf6f13jboWqcGOTOdBstrB3o5HIs89UvXrrQ+daVK4d+ZdskKtz3DZM?=
 =?us-ascii?Q?hhLCRsWVRMmLkEOS78lQE98oJFyVV76fJPcI45ANfyddAmlMo2LLPvbjitC/?=
 =?us-ascii?Q?PhbBepCE1ETyh3HC1xPtxACOX0Dkbj7oMDicMlT14zPxC6aPIP46pQio5T7+?=
 =?us-ascii?Q?YztAUP2WlQzKA5NNhO9AXylW27Me1jpU3cOFkDpzoy4BOGT50pNm/6/1sI8g?=
 =?us-ascii?Q?DLsM0g3JUHEofJj1JqrgLHRni96EZhucy/Iaresvs46Tp6qJFFEdnG4ihRhI?=
 =?us-ascii?Q?7XgMSpTncwPAb23fMJRzbX9qbVl8Vwq4F0mJqulc/b7eYRmkp/cVpcswb4DN?=
 =?us-ascii?Q?aQLZDJHcjtlGN6SiPk/umvoG+CtAgQug4cKDh9ws8PHYq8Lx8ElkIi1ee576?=
 =?us-ascii?Q?qSk04IFpRnxkUjvLPF164WandTDKaGacdrDrHNjtmlOB6g+vHD6UTeBmMZq5?=
 =?us-ascii?Q?3K3gWldFljrpCYn3RoDmlT0JmHF/Wwa2LbV+/o/hbQjDLKLEXJJxeisVO/EW?=
 =?us-ascii?Q?O0lJ3UK4z3sW7z0O2YowzVlt97UlSQjt08l4ZWNslaLhZhf8I6lR1NYIgTyp?=
 =?us-ascii?Q?KtoYa4Myp8t0yIFbSMxCGpTR2NsdZxdnAGV6j6vXMc46rx4o1KO/A2PyyyPV?=
 =?us-ascii?Q?sXnE4+o0mB4htkwmHE9a6vE0InJDAU5RoX18eWFxj1ZInz+IXeH+0SbYNByb?=
 =?us-ascii?Q?xfsDjIgqn4g5ymH60C+UShimG8KHbHiT97GqL1BMmTdpfu9z3SHGfOHnC9DU?=
 =?us-ascii?Q?zhQw71TfJZ+06OWgAlH+9riECoh8wStz5wp+SPDuMz9knQvwSC1Jkd379GwQ?=
 =?us-ascii?Q?f9bJK4W2UmdBMaZCM1T+p2tpgblPyKhdkHpIxrnDa+YlhI1RGY/O3wdTZ/cw?=
 =?us-ascii?Q?Oo+KBTBDZO3q56lyZf/0CqjZyE1MUneKPoI/MBgcHkHFdg6FXnl1D5x1lSr9?=
 =?us-ascii?Q?5/UaVgtoq1XOZsNAGnoTWmSpa53lx/W4U3OwvOirsIRYsAyzOGqAxWKLrIS9?=
 =?us-ascii?Q?8zhUA1sODGTx1ahGspbyXp8TKq5mzgrg9aYWUUwBN4kGCBC3MWdd4W7OSx+q?=
 =?us-ascii?Q?IDjlEKWdSyaqtnzaF6byNMKgSGoP4T/Xnchb7SgpdhVLdskcWOitJgPlufbO?=
 =?us-ascii?Q?fFF+m64vYC0US5hYfhEMiRMMbt/5+6WXOfY2GBsg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e7497b-859d-4fcc-f5cc-08db3b39edc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 09:40:19.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0HpYYYgkmBAd+fL6Jy1WN8ddbFqy+Ulo2btMH5zJ9F8va3QKwBSm1ThXeeZa6jGqbC34Mz5PG79bPbnsTMTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, April 5, 2023 2:38 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH v3 2/2] crypto: caam - OP-TEE firmware support
>=20
> From: Horia GeantA <horia.geanta@nxp.com>
>=20
> caam driver needs to be aware of OP-TEE f/w presence, since some things a=
re
> done differently:
>=20
> 1. there is no access to controller's register page (note however that so=
me
> registers are aliased in job rings' register pages)
>=20
> 2 Due to this, MCFGR[PS] cannot be read and driver assumes MCFGR[PS] =3D =
b'0 -
> engine using 32-bit address pointers.
>=20
> This is in sync with the fact that:
> -all i.MX SoCs currently use MCFGR[PS] =3D b'0 -only i.MX OP-TEE use case=
s don't
> allow access to controller register page
>=20
> Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c    | 23 ++++++++++++++++++++++-
>  drivers/crypto/caam/debugfs.c |  3 +++
>  drivers/crypto/caam/intern.h  |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> de1f0acdb712..9c5a035e1b96 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -633,6 +633,7 @@ static int caam_probe(struct platform_device *pdev)
>  	int pg_size;
>  	int BLOCK_OFFSET =3D 0;
>  	bool pr_support =3D false;
> +	bool reg_access =3D true;
>=20
>  	ctrlpriv =3D devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
>  	if (!ctrlpriv)
> @@ -646,6 +647,17 @@ static int caam_probe(struct platform_device *pdev)
>  	caam_imx =3D (bool)imx_soc_match;
>=20
>  	if (imx_soc_match) {
> +		/*
> +		 * Until Layerscape and i.MX OP-TEE get in sync,
> +		 * only i.MX OP-TEE use cases disallow access to
> +		 * caam page 0 (controller) registers.
> +		 */
> +		np =3D of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
> +		ctrlpriv->optee_en =3D !!np;
> +		of_node_put(np);
> +
> +		reg_access =3D !ctrlpriv->optee_en;
> +
>  		if (!imx_soc_match->data) {
>  			dev_err(dev, "No clock data provided for i.MX SoC");
>  			return -EINVAL;
> @@ -696,7 +708,8 @@ static int caam_probe(struct platform_device *pdev)
>  	caam_little_end =3D !(bool)(rd_reg32(&perfmon->status) &
>  				  (CSTA_PLEND | CSTA_ALT_PLEND));
>  	comp_params =3D rd_reg32(&perfmon->comp_parms_ms);
> -	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) &
> MCFGR_LONG_PTR)
> +	if (reg_access && comp_params & CTPR_MS_PS &&
> +	    rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
>  		caam_ptr_sz =3D sizeof(u64);
>  	else
>  		caam_ptr_sz =3D sizeof(u32);
> @@ -761,6 +774,9 @@ static int caam_probe(struct platform_device *pdev)
>  	}
>  #endif
>=20
> +	if (!reg_access)
> +		goto set_dma_mask;
> +
>  	/*
>  	 * Enable DECO watchdogs and, if this is a PHYS_ADDR_T_64BIT kernel,
>  	 * long pointers in master configuration register.
> @@ -800,6 +816,7 @@ static int caam_probe(struct platform_device *pdev)
>  			      JRSTART_JR1_START | JRSTART_JR2_START |
>  			      JRSTART_JR3_START);
>=20
> +set_dma_mask:
>  	ret =3D dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
>  	if (ret) {
>  		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
> @@ -842,6 +859,9 @@ static int caam_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>=20
> +	if (!reg_access)
> +		goto report_live;
> +
>  	comp_params =3D rd_reg32(&perfmon->comp_parms_ls);
>  	ctrlpriv->blob_present =3D !!(comp_params & CTPR_LS_BLOB);
>=20
> @@ -944,6 +964,7 @@ static int caam_probe(struct platform_device *pdev)
>  		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
>  	}
>=20
> +report_live:
>  	/* NOTE: RTIC detection ought to go here, around Si time */
>=20
>  	caam_id =3D (u64)rd_reg32(&perfmon->caam_id_ms) << 32 | diff --git
> a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c index
> b2ef2273298d..6358d3cabf57 100644
> --- a/drivers/crypto/caam/debugfs.c
> +++ b/drivers/crypto/caam/debugfs.c
> @@ -77,6 +77,9 @@ void caam_debugfs_init(struct caam_drv_private *ctrlpri=
v,
>  	debugfs_create_file("fault_status", 0444, ctrlpriv->ctl,
>  			    &perfmon->status, &caam_fops_u32_ro);
>=20
> +	if (ctrlpriv->optee_en)
> +		return;
> +
>  	/* Internal covering keys (useful in non-secure mode only) */
>  	ctrlpriv->ctl_kek_wrap.data =3D (__force void *)&ctrlpriv->ctrl->kek[0]=
;
>  	ctrlpriv->ctl_kek_wrap.size =3D KEK_KEY_SIZE * sizeof(u32); diff --git
> a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h index
> 572cf66c887a..86ed1b91c22d 100644
> --- a/drivers/crypto/caam/intern.h
> +++ b/drivers/crypto/caam/intern.h
> @@ -94,6 +94,7 @@ struct caam_drv_private {
>  	u8 qi_present;		/* Nonzero if QI present in device */
>  	u8 blob_present;	/* Nonzero if BLOB support present in device */
>  	u8 mc_en;		/* Nonzero if MC f/w is active */
> +	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
>  	int secvio_irq;		/* Security violation interrupt number */
>  	int virt_en;		/* Virtualization enabled in CAAM */
>  	int era;		/* CAAM Era (internal HW revision) */
> --
> 2.25.1

