Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF973627673
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiKNHhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiKNHg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:36:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138095B0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668411419; x=1699947419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W5U6KsQ6Wm8qhTQRcfFXY2EnfwpSdC4oHAS48/3WYzA=;
  b=WnKs54Bg0AFvc5giPLo+vP87U6unZCfHoAp6Vbs7GdCzXDpl1gj3E5yZ
   MyEnsKDXnNTYevpxSeVNqM4i+7jpPFtaYJGqz1nPwgljGB96t9hBktDDf
   UKrHsrM2Zb7ob9Kdgs/ks9hZG4TIyNHQ3Z5oWG+FJkbBzzPVySQ+yv+qW
   Fdl0u2jmZsgAlAphdrM1uerMytI5rhHIEYFdm/oPm2S+KPlABFpCJNCgL
   E4HIzTmAlnaio5FocRgbdUFYIx8nvGZviJbjxkKhto0RHrSy+viRFy3AT
   vtIFX88/tPZClV6SBIKkv2jm5zPvPXW60ezB3FAZ/jWEMRInnN/Ymlzk1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398195471"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398195471"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 23:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="671456514"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="671456514"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2022 23:36:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 23:36:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 23:36:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 23:36:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/bL/cJeWPGe0zpTD39XdqHNU14i7vze+1qJOPUPdtZvZmoh1TVZowW/qf63oyIBdvvTx3sbEJnfVF/YBsP3PMv058trjnoFlFUAoTfvF1Dds4/JPiuM38W6UBZiV0UJUCiuAGaye3+P49ROyHe61Wd9pYrgxg4rzd8VgZHs+dqGvGnUe1diAKZ4ZyrsYTdTPt4PJ3wXZJOEQ3kqSRVrH2f/affDX/M8OX+cXjuHlMxh57mf2qW8uJj/sgofGRAibBYuhGKfUOyXQG/ZJKh3ejTW2IVcomnth3QncJ9OXWN0G1uaALj/eKd5fE74iHIy/pdvIzcKlRCkshkRmPtC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3/a0bWCsXgmBUzeXG6wHdbogITqCDy91IkLvbzS2/w=;
 b=A90MMFCp/W/ettWzACLZP6WdPj6xpSctP0byhytQVM9PH5jYkuCvQPT5O3svKVJewFQSH6RVdBRX9whTbirbf84kZlPpK0JSxPogg6uJVfkd+SYxrRbDxFmdzNhu3H8NvgjGLQdWEfnNAWG0NuZcNKgyQV9tCsuQncPj2YpgkndobrImEPWOiN0whNlFLZc9NqMim67MnGGN0g4CyDAX7v0/LKA8aOso9Sit3nCw3UcuL4guFMCDSC6jOvJzXF2pKb8FbqfBEBnTvd8eBKaGmBHhnK49eGmdtrl7kWaB9u1RfSLEmSXoeK/4B86ckq8NgqNW3WdeSd1M1OqNyLNE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 07:36:54 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::1258:f9e1:9d80:47f9]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::1258:f9e1:9d80:47f9%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 07:36:54 +0000
From:   "Chiang, Mac" <mac.chiang@intel.com>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Lu, Brent" <brent.lu@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Reddy, Muralidhar" <muralidhar.reddy@intel.com>,
        "Yang, Libin" <libin.yang@intel.com>,
        "Lin, Chien-Ta" <ctlin0@nuvoton.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v1 1/2] ASoC: Intel: sof_rt5682: add support for
 ALC5682I-VD with amp rt1019p
Thread-Topic: [PATCH v1 1/2] ASoC: Intel: sof_rt5682: add support for
 ALC5682I-VD with amp rt1019p
Thread-Index: AQHY8ypxoqRQYPxb406qxD+wLCJfG64+DPCw
Date:   Mon, 14 Nov 2022 07:36:54 +0000
Message-ID: <PH0PR11MB58329B470ABC721F95EAC6EA84059@PH0PR11MB5832.namprd11.prod.outlook.com>
References: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
 <20221108042716.2930255-2-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20221108042716.2930255-2-ajye_huang@compal.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5832:EE_|BL1PR11MB5222:EE_
x-ms-office365-filtering-correlation-id: 88278201-ec31-478a-8f30-08dac61300bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtTfCRaASOfak06X2yUrEgkh2A9eJn8Cd92fz6kJypm7bpuEvJPeZwAGEJtRcMhxqivtRtLqx1sO9JoNNEYJhmC5E2kcqdFBZ65wuIqY5pv3G8D1YGg6AAkYZX1PmYLrUe2G93BA+FdelsTe1lP07DzWiTIpbYZX1zD9EzAyX/X3m/6jUno2vBER+TWL/1ke8r5qNEEamuU9k4P+j1vzXv3AefA05R4ojdNwZHcEnNBfG+tQE/+FNlzEvMkPhUbq6eQ9fVZ3sPF4kgvNKv2RWLWFNO6JGTu+lmhx7yqBAWdQ3VgB1miMBjDc4zpNj2kEtwaytWOQyN9ngsZOMzRHW5lcJK6+2Ttiana9xk/EbGauuyMDhJ/bhPQXC2i4ciKlBFozU35kn92W3P6BIhlXBkv/LF4PwatO1DqDyJmgjEGZ9u+6ckPLFFhgNYJeCqOnP+Ivo6YhLCqbtMZZft5MtXo09MafrzI6NE+JAumL9ljzpPgAx78gbliAr+pRj6wO/rYspoXkAGuFznizTGFrcm7PX+HwNRNp8/skb1aVnpFb91Aajpv+S4VkPw/UXb8jyFnfQ+vVEtSuKu+Rsln/vQVtBKK7fwCPlLB9xxiI5jDZCPmZpAyI6vSSjEtQi64KKE/2ZiKoCWQs9IZBNcdSbee+e32rUS1cLXhGFnuz7HINneg5gZBLLN51BrvfjBfRHQCKoX6m7MASo3BHyPl4a5tcSTU1DMLZ0Txuwljtiy8Fg3BGstSeeqtxf/AbRor+ZNEJQmhZWumagCqlVYSl2+G7oI1joH1bFnR9zt0ZwuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(52536014)(82960400001)(41300700001)(38070700005)(38100700002)(8936002)(83380400001)(478600001)(7696005)(7416002)(6506007)(5660300002)(71200400001)(110136005)(54906003)(9686003)(26005)(122000001)(86362001)(33656002)(66946007)(316002)(66556008)(55016003)(4326008)(66476007)(76116006)(64756008)(186003)(8676002)(66446008)(2906002)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ore8NLPaM7XtEc/iOsRYVRV1XW1oMpitMAbOp0akgHx1Fj3bUq0+HKMJIzn?=
 =?us-ascii?Q?qd3KVUsQ94bDsTP/+Rhon2bsRx57bJfEVAc++sULEt2rLvrQaTmPE3I8O0qH?=
 =?us-ascii?Q?42WkOzGui/05z8rdNIHqxIu2/p2oLay0H+aPIBP1gpGqxkXgq6cxAQW3wySQ?=
 =?us-ascii?Q?NN187O40vDz981PZlyUddTN6JG5MG/3Z7A31KYyezST6JKzeVdA8ofKC2dXZ?=
 =?us-ascii?Q?IksanfgWP+o2vAzOmjeuJYmjU1tOTjTQDBxTm+z32Al6qcNdtiTurRzuzWRT?=
 =?us-ascii?Q?bdiclF5FDI3NiLrhNuAOdhXgjkxppIx8GqwYUf3/gbDJMXTusRO/Vuu9Ie2r?=
 =?us-ascii?Q?Rd0TSKfQxatbI6RmDYh7vMui4ILSvHTMuJhD99IK9H5WaN1t4LUFjqbY80jM?=
 =?us-ascii?Q?5dpsgh7YdOzIVgXAbnYIY3ULp/09unclXi9Bor8VSGLqcPw2d2hUcqLh8MpP?=
 =?us-ascii?Q?z1u2JLYagyvGVKCRUlnULIGxzgNb6+Or30U7VLm0oqTCB5D/yrv5wtYEPQOU?=
 =?us-ascii?Q?B/l+C/mVfntOWz4SGJz/6fpdc0tOREjOu9YDcXDd7zhLsjof1zYm7vAR37iX?=
 =?us-ascii?Q?h4IQ6xvc1HoW70Lb1IjOhKnZE6mhStUvNY1JwMHoVHekMdC6+0+F5zYa+RaO?=
 =?us-ascii?Q?shD/zWU1JbQZhBmL6f40GD6V6PvjCN+FYKRYCs5zQdT+9kDv5Ycnnl7t7CEt?=
 =?us-ascii?Q?RxPPuoQ2O458/SKsYdiKcM8Hr93P6xp3TeLyIJ9+XJtdwL8l24IevURghzVw?=
 =?us-ascii?Q?BuipQrG3FheVRItouTZneDrJl/H1SnJGh1adTCNwqt9n7FTA+aHTOlv8TxT9?=
 =?us-ascii?Q?RzytNwoyTr52Zx6AFZzjwdEQS4Jq/aCzYF26hUkJWyEzO7XxZCGCrJAQUPxY?=
 =?us-ascii?Q?js46d+UDZ3xzsF8tIPO7FLk+s6hjNr7ibl3M0DRezh89c8Wh+Ytzzy09qI0m?=
 =?us-ascii?Q?Pffy/8GZWIVUSEP63Zgr51+Zv0wlt8BeVt3Mwe16q56myoR2I73p9BYRqWmd?=
 =?us-ascii?Q?jFKuRi398/vmD5lrwh0a/p/XCNn5P8iSi6dgtQ8/J/1OchNY+VwC1KqaeWmq?=
 =?us-ascii?Q?0f8OZpojjSfx5TejdkVv3aO8e9bGtmXnLWBYwOmOImXqRNBf07NItClhXLHa?=
 =?us-ascii?Q?S7v4asBLGLwUPLUj3UVCHCQxEJIWvN4GYgI1ajvMBhPXPDgt/k2LZOM+MqeK?=
 =?us-ascii?Q?lmszyfcuF668VnoewmTvO77AWDk5o68ZuVe3G3YHppDKIrIU2DAIi4PNsTmd?=
 =?us-ascii?Q?XUQPoHA0trbzIsroRb4uS0kI0ZFHoL35L+IiPAhoeJF/82b92Bee8niYoMwm?=
 =?us-ascii?Q?xiou0KcukJ0tP/t3HlKnkNiOdyBhBa3nA+eyqNr9xW77fIkGPQqNBW9eBhXG?=
 =?us-ascii?Q?1ydK7lwxG7Q+FBuDUznkEHUjcqVgTTCblT1PARNxXAnkmsSmTNz98lq0e4RL?=
 =?us-ascii?Q?PABVvWudDXs+thJiafeOTV6WVSwvPF1MNuHmn7D7lNGiyN8CIwkYNWIKse22?=
 =?us-ascii?Q?TLBhfQJtsNkZJSwzfuaI5A+h016oto9kjHIJ0rB6e9vq3yq6V2d8RRcX58ax?=
 =?us-ascii?Q?54G5dX6IcUA/M6luw5sERJ4E5BXkFCFjNYc4yZmE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88278201-ec31-478a-8f30-08dac61300bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 07:36:54.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5Zi1es0v5Zjm/jOBHu9TKAgxZsvDNKiQnAzqvNAGr5Nw7/LXl97QMAER5kwyhg65s2EccSAuYH8rhIw7/asuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per discussed with Ajye, the board co-layouts 5682VS and 5682VD and veri=
fied.
Hi Pierre, could we have your reviews?

> This patch adds the driver data for two rt1019 speaker amplifiers on
> SSP1 and ALC5682I-VD on SSP0 for ADL platform.
>=20
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c               | 3 +--
>  sound/soc/intel/common/soc-acpi-intel-adl-match.c | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/intel/boards/sof_rt5682.c
> b/sound/soc/intel/boards/sof_rt5682.c
> index 2358be208c1f..0e803c1c2b06 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -1092,10 +1092,9 @@ static const struct platform_device_id board_ids[]=
 =3D
> {
>  					SOF_SSP_BT_OFFLOAD_PRESENT),
>  	},
>  	{
> -		.name =3D "adl_rt1019_rt5682s",
> +		.name =3D "adl_rt1019_rt5682",
>  		.driver_data =3D (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
>  					SOF_RT5682_SSP_CODEC(0) |
> -
> 	SOF_RT5682S_HEADPHONE_CODEC_PRESENT |
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_RT1019_SPEAKER_AMP_PRESENT
> |
>  					SOF_RT5682_SSP_AMP(1) |
> diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> index 9990d5502d26..3ca0a96d94de 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -489,8 +489,8 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_adl_machines[] =3D {
>  		.sof_tplg_filename =3D "sof-adl-max98360a-nau8825.tplg",
>  	},
>  	{
> -		.id =3D "RTL5682",
> -		.drv_name =3D "adl_rt1019_rt5682s",
> +		.comp_ids =3D &adl_rt5682_rt5682s_hp,
> +		.drv_name =3D "adl_rt1019_rt5682",
>  		.machine_quirk =3D snd_soc_acpi_codec_list,
>  		.quirk_data =3D &adl_rt1019p_amp,
>  		.sof_tplg_filename =3D "sof-adl-rt1019-rt5682.tplg",
> --
> 2.25.1

