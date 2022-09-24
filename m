Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B15E89FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiIXIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiIXIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:16:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C772228E;
        Sat, 24 Sep 2022 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664007223; x=1695543223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0TYT4iG3jwAB+2GOx4ja8ud7WJIn9Z3aGXgPced/wYo=;
  b=UkHmP4t0Ejq6feX8v0eLxUQey3kneNrIBYoslZWJAVRinq8i6M+5NOo2
   hTnlNl84cdgtaKV+9LknD6E84Dq3lpe4B1SRnM2blwK0RzQJOXRpeoV0j
   yB247d5iTK4hPPWmA8hSFi9TEjKERvqZHHVLvHsh8BIwitSLKSxvQS+lf
   4HdgC5HT3Ht+j8WgX90/r2sZ17Q4c48J90KAoG6/Mwf4P91wDB/z314ut
   oD/VT2qWNywTZqqtqzghGDmUI/+NGWBpDMij+IdCUXE9URRSoqabh1C/9
   qfgypX8oZOkFKAB6Vr9kXyg1i28sbTkr7t4LhUNcsIXAZMzy5nHEeKq3J
   w==;
X-IronPort-AV: E=Sophos;i="5.93,341,1654531200"; 
   d="scan'208";a="316450015"
Received: from mail-dm3nam02lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2022 16:13:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTgo0YDr1jQFS6kgJQd8+ROYqWVK05igLjsDfqJk35Nx5m8csiNzB2shJlDN2cR/BPV4M6miTqzhjEvod8VhkyTWDsO3Ig3MI1b0XRTEfw30woVwlC/UiBGHhqQkYkK3ojm0ZLvWWdVSzzIoYezQ+vpJGBdPoQhgpm+ApvV39CqprE/6t4d7FtfssebOO4/bex0cKOtWEOSnCSYjbWNLWD33mPTeCdF6W50Zx5lSl/6aqX6Ps8yb8JYcNfg9n7msxt3f7Nog9YV/0mTna9TtHsKxu1Q9TnjkBQfSxfMSHy48tlgJalvBqnehOueZNp1EJq02pZfnF9iDa07iRooxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7hzBAhSODIqunQmH8ba6TYPUPYbU0358rZBJowqHks=;
 b=UKwkkolIxE99x65ZZDm3ckCQuryP0UOpcxdGEzGhYz8SM5Jj2C6c5CgzozA24VxE1ud0133vTPSTG/5aC1ZrvyT1tBAvTc+x/FJLnxlGgem/BpgM53IW2T46mDJe3KbptLb6XzKTLZwAxvpC+tzVhdtkLA4oQFFKSMJ5I1VGx/cNENiWMcbKO4osxNQmXKWCQrkfyM/LAKZkU31Oeq2cLSVHxzpHK8DgqjBA5ilA4JVvhOTaVK7KOq7MChB1j8TkyC3KnydHv4QDdWoLuNq/XBuU50CddIcrYXYE1yZrJhY6wq1dzPFLt8uNnk5sEAq34xi3nir2EvVP7wJYPDQhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7hzBAhSODIqunQmH8ba6TYPUPYbU0358rZBJowqHks=;
 b=S38TV3qSYrpiQ40WWa7yjVhLlUKq+UCjd3m7FPgkTbAWgEAZTDrJBTi78Z+5aoYGJUVo5e3Zp4mv+g8Aim288M772iIm5dvVdWCwKo/7JEHyRWzZm5prH7wvmL0ormcgAMVT1OZpYPopALqb1RtT9KlkKhSMg2irZlRXcSOux0w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO1PR04MB8284.namprd04.prod.outlook.com (2603:10b6:303:153::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.22; Sat, 24 Sep 2022 08:13:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::f4cb:405c:636:e0ee]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::f4cb:405c:636:e0ee%4]) with mapi id 15.20.5654.022; Sat, 24 Sep 2022
 08:13:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nitirawa@quicinc.com" <quic_nitirawa@quicinc.com>,
        "quic_rampraka@quicinc.com" <quic_rampraka@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v1 02/16] ufs: core: Introduce Multi-circular queue
 capability
Thread-Topic: [PATCH v1 02/16] ufs: core: Introduce Multi-circular queue
 capability
Thread-Index: AQHYzujOjRzRZsX1YUi97UOeZb9uua3uO/+g
Date:   Sat, 24 Sep 2022 08:13:38 +0000
Message-ID: <DM6PR04MB6575F55C0A33C049E22C72B6FC509@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <fa3d70c1642c64ce75461f630eabe84b3b974d4e.1663894792.git.quic_asutoshd@quicinc.com>
In-Reply-To: <fa3d70c1642c64ce75461f630eabe84b3b974d4e.1663894792.git.quic_asutoshd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO1PR04MB8284:EE_
x-ms-office365-filtering-correlation-id: c61f4ecf-f9a2-48df-603e-08da9e04af27
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+ZM0TqwXExv5dc9v+0mmNG6ydj7VSCatU9rMNajBStluM1oaCoab1wuUGo4l2GdadQ89EuaDtgHbQAbhJFeEI1D3aG2fncVA009FuiPJOgztg3zRgvwyuL2jolZWfNgUxRiJNsL78gFIJeIEp+gTLeKTckeiSTsdoRe9dLamzVctyd9ePyc10YptuppCv2u72wzICOrm+RP2P9pdQhqAKdvta9kV1pjl5vtyc7vkJ+N21lJzqlGNKT1oKGyLsPNoU9sUJjxV0G0n8YfEbzOQgt9MuyDQwAK6+uiMA4SLFaVHnBSHPhZPUemuO+yrs3bQM8mdPGDmTe3uWjbuBtTiL6ICBQwrdNhFSyOo1jlmlpLDZPcqYkz8wYX3R0kDw55cmCs13zo3GxIKH1TqXfakwQRjuiCcybBRfPRjPTNkfxD2pBUaKP18VA599c0QSFoQfRlGF1UXRrkQftVnLyzxa92vOibN7Z4Y8fdwSjl5THWyaNaJPpT6ckMbpCkikjxXXOVIUGLi8quIzkPStJdr82gaynToZkJK7JKJRRAuHI6ExHmoy92+7IF2KqIOrYPwj7AylW+6ft6dWulocShljaiSCpeN5gsPeH5C05qJsDEu91bf3uX+bfQhKUV1pmdl3Edye4quq8iVmJTNx04AZ0COsQlIl6bRszYa+44mq8Wx0ztff1xZmfE78KP5HHc+EyfD4rKzC7BQUUx6uyktql1Xf8xQXhXC5022uQX+akG8YwiLs6noeklDoBO+S5+G5exyz8FZ6JhM1D1OCjP3c910i8GRBQI7II7hKeY0WE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(41300700001)(82960400001)(4744005)(9686003)(316002)(122000001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(26005)(7416002)(2906002)(921005)(33656002)(38070700005)(38100700002)(5660300002)(86362001)(55016003)(52536014)(8936002)(186003)(8676002)(4326008)(71200400001)(478600001)(110136005)(54906003)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oH08onJLXsrpa6cf5EEmi2J7T7ZfUWgIzEfcoMsmFnmqxsirviz0HQAUZkqe?=
 =?us-ascii?Q?qwKGA1fqJUW39yBI/ma4VlpYmJkBfQAWtewytWbXez4Mwa3rcnjrLolTy2RD?=
 =?us-ascii?Q?kHSv9utwz6xnWVUsVK+EVWrj1+Mz9BhTn8uNgU982rKql/PPzxECZGGRf1wm?=
 =?us-ascii?Q?DfEeNQPRi2Uposg4NKnX3A5tI33wi4SsEXLuQeRq/9NxdxzsRktzzw9uXU+l?=
 =?us-ascii?Q?2ZpLSdDedR+807E60QcJjYkp1epiPGT3hbQLpcowMzxOe06myEkxgILK/Tgs?=
 =?us-ascii?Q?JZvMRYIugNsdspwAQexSQCe42itbt+FR/rhpJ+QnJCzdd0S1hKEvsT2Ky188?=
 =?us-ascii?Q?bwKhBQyD+GWvrUJnvBGXWz+eHZH08KPy1Lv1DQa9lWqbsQC6Kt1+obwSJVFR?=
 =?us-ascii?Q?586L2rl1MXiwPFotnQmagMmwRHW3WDj7TcolsHMN+MT/KRGv6m/Im06bD7tD?=
 =?us-ascii?Q?vVna2lBhCFqgGT+zxG5DbgTkFvgoFSTYFlVZjdRfCpZrUxMyLKSI31CrwyIe?=
 =?us-ascii?Q?OCvf7hxrXL1y8mn9V7UCEfntc/GlCPoNCiu+oX6QW6om9AUFnESRzmPbL2H0?=
 =?us-ascii?Q?t6JNGkJygjK/6sULC/xof9vjnyNdt/rNrcVVKdDtB37Cnb0WxKKavxfxWsnT?=
 =?us-ascii?Q?g61LAsmUQ34LyNWhatQWIfdsii1BePVD+awbX+CFDxFPOMKh6u0iFs10pxSW?=
 =?us-ascii?Q?RjjvG7bHtPbp4OrzU1To7XawGbTvleNsSgw37Is2M2zHP0Mrf5c7/6vd90sr?=
 =?us-ascii?Q?LG5kfAmrx+DIS6cjtpCqnT1YfJXRlx377Zvbd3Q1ZoFNsfnI4im37Q4+b18u?=
 =?us-ascii?Q?WADbaGxPqJloeDaJHUkEgGPQIUwOx/Gvc5xm9Rk/hSRiGIbRu4Wexl2T+Gla?=
 =?us-ascii?Q?qy2fNeGRwQlTyuzcS3xg1MJnRldLcChSaSgrMfVl8dQyhn9BTYc0HI/GCXmC?=
 =?us-ascii?Q?M+ceotKoP1T0iHPXoCgV/s+NTODY9Z86UJ2SUp/N6V8imbge8RsX8GhkY68P?=
 =?us-ascii?Q?H0qxFJQQZsGbp959k9B5/zWnavlZQs8+rC2XZjS8DXdQ+QCFtsn7483BhQBD?=
 =?us-ascii?Q?y0tJ5KbdGLI/Oy/8M1n8AMXy0u6yBh+FlfiEfSN3NOgLT45Oe+aFNWQZZyG/?=
 =?us-ascii?Q?z3lXeV6S7viCPNE7pSwJtDPt4aSUs/XubSh1IL55ZZ9kUDLVjU/6aPYPGAsw?=
 =?us-ascii?Q?LQvMz5bkau2ZQ1kIftDnQmgdE5QJSyDFfykYtTECn9AncOl2bCTcP2jQ0wXS?=
 =?us-ascii?Q?rjOObM+9ZUlesVgFN6yCsnlAYpzBNb7+2xxM43jFstcQA9AE29J/TtniXbeI?=
 =?us-ascii?Q?rmaHjdfhAlAsLI+dxFV7d4g+bo7NM7u3cl+8Ci9e6BPRBx34PbCiVpzXfjB4?=
 =?us-ascii?Q?7my22+VxGil0LBG4XqmCMDV83eV09tMziXR6LtMn8flwQg5bnHPKofv08Umh?=
 =?us-ascii?Q?xCAGXulJz8QhtZBLjEaSuUFou35L9Pca/d2McUe01c0w/W9RtCtIJkmRnUnG?=
 =?us-ascii?Q?GCe4A/2D2MJpnhAATGxRFS5vWoOLa5wD+ujEtIbfd96nd1Ze7MbJx1gkDu+x?=
 =?us-ascii?Q?JyE3QX6Vj4ZZ9ieAwlB7WzCD4KMN+5VVu2sFfxH8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f4ecf-f9a2-48df-603e-08da9e04af27
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 08:13:38.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBtlOlsgyOdv3820V4pbxF4vjVGm5jz3UNClPu+7R5VACyqanQWbkuWGf1zF7Mu2SmrUCKNwV4BJ8eYK0Uwo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8284
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
>  #define EXT_IID_CAP_SHIFT 10
> +#define MCQ_SUPP_SHIFT 30
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)                           \
>         ({                                                              \
>                 int _ret;                                               \
> @@ -2240,6 +2241,10 @@ static inline int ufshcd_hba_capabilities(struct
> ufs_hba *hba)
>         if (err)
>                 dev_err(hba->dev, "crypto setup failed\n");
>=20
> +       hba->mcq_sup =3D (hba->capabilities & MASK_MCQ_SUPPORT) >>
> MCQ_SUPP_SHIFT;
Since you are just testing for bit30, MASK_MCQ_SUPPORT is not really needed=
.
Maybe just:
hba->mcq_sup =3D (hba->capabilities >> MCQ_SUPP_SHIFT) & 1;

Thanks,
Avri
