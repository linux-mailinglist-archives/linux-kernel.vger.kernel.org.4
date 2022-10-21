Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22360715D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJUHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJUHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:47:00 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4045248C8C;
        Fri, 21 Oct 2022 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666338416; x=1697874416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=04MmHlxAejo+8Sx1/fYKa8ZGMtPAtXN3xbMe4AQ6AJU=;
  b=nuObYDAB3WI5bKzu/N0LcVDI+RICRvgMyy6IHINdhkU2aiCcY2/v04gC
   +LEN4+sMzBACrDqENI6EeS3piPWa4ho1K9PO0406Eakc7+HSuLTnnOHS/
   jTx1te/NbedzMlM4s0cagv6WZUt0SK3gzXagJZHvPsTf0nZ7gEDq64OTt
   JdiYXaIFQXJWWbHg0s0eoaPi7OFKyEDG7GNHNugoVsRNq+g5fXb5RA8b6
   dyCXRcjfpLENkw3SBvdxnyiWP7nnCbxIHwP0XkapXKwjtjUdfoniblhHJ
   aGLhbcU3vRPyeaL8eDgL/OnU2ZKPTqO7f1us9AYwjwADDaMdKtyir3DoK
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214414846"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 15:46:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnuxLHNXigBIj57M4Kc1AOkOo/18IpN5mPrQHgf7yRTrZRQ/dgofP2dpptOPYFle3xsJUcjvUQt4xfLE5v0sP/OHtMVi2XK499a6yxrvLXj99JPhQLvYOt1xWOzWEhzMPst0T1WKEH1taoOSMlnYGVnV1ngxJBPCvKhOcsS4wnaJnn9gP+OWtwQ5VmZL8Tl+4oCa+gErzmGpV9DKuBNTCiLirImJEEF3oKE4YQ6skyil1zsg1VzimJruPsWjU2bp0BRyBhD4FuSCDFDt6hl2HooxS3YfDfBcscEKgrZ86HEqMMnxq+IL4kG0HgXolbm8QdKy/X4msSoLXy/YCYGH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7BnugLggFCcPzGU+yaJvt6zDQvbCd6QfLRe09+3Wro=;
 b=n6iKpMM1X7Z/7C2NyKjrXGMxHgrh6M+NNinTCmvQwseG209NokkwxNW3tV65nWZdnft1qgGRr6+QRsSJYsjvKE0ZGv9Jmxw1sNNe6I+5HlntPn0O1uAktXiqHj/mSzjvcZv5o1rljQ6IDoJkQcuKPDSBnGRtjnFmgK28BThcJttK1cUAQFodeCikW4eTjvzp8iFUoMr+AwOjkveMA0pBvopQvr+xiWqInHEvBC32DIa/wComXLMnCRLyW63JZJDRJzYcez+qSU+CTC7bZlZr/AlVs1NyZpZVKXg4ff06GpI0t4POqi1H7jsvecfQRsOG4SET+IpdQT+7H69fR12yWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7BnugLggFCcPzGU+yaJvt6zDQvbCd6QfLRe09+3Wro=;
 b=nWf/xg71S3xPN97ErfYDUNKHP/q+lqVpDUPT1CJSwXUjVm9ZaNAv4i1hodg0tHm/PdpkRH6a9k9vQo9JNSfD8oEe8KFfdU2IGZvVqqQgLACfsqjYMatSEvk32F4g7kh24kCiI5qxayeeybnKexWporBufE4INqBwVVXMXx+jhrU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB5725.namprd04.prod.outlook.com (2603:10b6:208:a2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Fri, 21 Oct 2022 07:46:48 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 07:46:47 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Zhe Wang <zhewang116@gmail.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "zhe.wang1@unisoc.com" <zhe.wang1@unisoc.com>,
        "zhenxiong.lai@unisoc.com" <zhenxiong.lai@unisoc.com>,
        "yuelin.tang@unisoc.com" <yuelin.tang@unisoc.com>
Subject: RE: [PATCH V2] scsi: ufs: core: Let delay value after LPM can be
 modified by vendor
Thread-Topic: [PATCH V2] scsi: ufs: core: Let delay value after LPM can be
 modified by vendor
Thread-Index: AQHY5O/X5SEUAJ63OEW7CeXMTgqbjq4Yd8SQ
Date:   Fri, 21 Oct 2022 07:46:47 +0000
Message-ID: <DM6PR04MB6575BA226F07DC4752235C79FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221021015217.20272-1-zhewang116@gmail.com>
In-Reply-To: <20221021015217.20272-1-zhewang116@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB5725:EE_
x-ms-office365-filtering-correlation-id: 2003a476-0a76-4b1f-cb2f-08dab338687e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmur4DsN8J2gArcFGmse6B7ZMvBKrdDYAA7hGlwcgrVlOQyg/1pu3hA29b+je+0Gs3gmCmd1agkY43Md/uQUE9+odAymki68raoujMlmriZ9CFfmzeyNc7gFy0o/Ut55ZTyTob8ObPrXfkzvp+5gXtGSdIragYNz9VUwl7Y/muHVBlcoHK/EpDlSWrCOyXqYcDChqKcJWURk8CdOc4JXXm1AlnfHAZWCRUYmIBmfW4xr7uTftMIXRpVaIv0VXWAr6L8u4/sq/Sf8wSnU3lyc7MrjuPgclqDHxH1Fov1277jbhyL48qs2KdcxrXAzJrqJcnBCxAFcpyYrZkKFvYWOwbJ94FTcE57VRaNncU2diFrUTep3Ys4GuRD87VEgK9+jcd8y6RsMvF2bu+mlEY3iizmtoOx6w0sEK5DAg2Gx4k760wseZJbUhNXsXG2aR9lkT+WLLwr6CH2YtGDjM0e6uU0EViW+/+9uaCCEbcVYeH+YA20wQP0EYCuzrjPYB+s4+HoPumZ5WhNXIRH4DvhB2iH2bR5YZn0bSFy40g/kg4oRrIwalO3EHDZ/1fk//8lyZ7IfPkQB2yMHMpPLVjdj5MXoZbQaMDvUKFGCak50Biqo1kmOtw2wcWOcTRIX62AS5HvZRGp3rcD+bEcUUtUhnh2PKLonkgd/e5V84T9EqAjRx/F0GvcL2x3HgNe/YRlQlIbwHAFND/YJjHrS5m8zYS6354DFA52KbeKwB0nQbwgNye12MSiwxXSZhFc2Ys8WvaBkwsZRdlCPjqDWJ6VlVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(86362001)(83380400001)(38070700005)(82960400001)(55016003)(33656002)(38100700002)(122000001)(316002)(54906003)(110136005)(478600001)(71200400001)(7696005)(7416002)(5660300002)(41300700001)(9686003)(26005)(8936002)(6506007)(8676002)(52536014)(66446008)(66476007)(66556008)(66946007)(64756008)(2906002)(186003)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QNToTbFb3uBSrFgM1xxiMSAXuQPk6JMUxkLJmeOem22HDaxHZNQOWbnIt3fB?=
 =?us-ascii?Q?c/Fo1SZOTfXEMk9obJ01ulnRDavy+k4wivVgJZpqVgGZMHqQ//l4qEc7rW9v?=
 =?us-ascii?Q?TTXoRS52ijqWJXgsvSvFvZWs2ZWJjy0mrghm8N/nkBSMBjXrS6HpFaZMZQsZ?=
 =?us-ascii?Q?t9qA376AFY2jSj+vuq0FCXmESy6+4g9HZpC+4buoqeaagiPCguctheYdPqHw?=
 =?us-ascii?Q?99KAxJ1AogJOrW94hijlpkFRueNIOHPLTq/NlkYvgCqZdD94UBuTqfCmX0wh?=
 =?us-ascii?Q?v+6NZizijuk7txyuNnpfXo9HrxgaMfe2WfJtZG0ToPLjfjgPf1qxCODPZ2sg?=
 =?us-ascii?Q?KpPvs69rcQhmyY1xMBzRhX88oEXYBr9hxZLxWOMg5b198hJ9s/vsVGzL6hjW?=
 =?us-ascii?Q?tCqpPifAETL33YNzhFJ7kR4g34dQ+6Ay+jzKH6CgkAnvbs9qVOHiuSG4pmwA?=
 =?us-ascii?Q?QKI0ZSB90FvYDjAEF+jAlfAZXXSljYAxmQo3qkI9hvCIDEKfjW0fGR92hMYi?=
 =?us-ascii?Q?DGgMLcT0qfjSoCrw2EqBc2akqQvRuXtB0JOI6goETSBYQdFhY2nQDaOZdf91?=
 =?us-ascii?Q?MlaDoQtFxSxK41kado/XDULbcrmyuUJXtU8E7HcWsVvfDI1ATNfhAaTBDNwI?=
 =?us-ascii?Q?UIgq3tK1SPfsvYVqkkQgkU+/0aSrnSdCh0qf+5nqw59VB0AGepYMV+phA2Wn?=
 =?us-ascii?Q?DojPqFPYAUgvaVw1ZUFNWfdD5URKGJMM//ja73YEKLquR6rEX0aYAHvWd+TP?=
 =?us-ascii?Q?7cyhdtvXyLqmqooazzxyM1WBvlTjWbR3KfRFII165NSwvetMdJjtf/01CB3X?=
 =?us-ascii?Q?PlHBsPclBEAvOvUHkNw7c3DyLebN927YrLUHF3wszeClUzrq2geONSHCXMli?=
 =?us-ascii?Q?sgUfh7YKtSX2TBcBpf+aDQD94WJn8ODMKI29ZgXyVnv/Ea9IrZoOExPDA0pW?=
 =?us-ascii?Q?ZysehXn/9vU1pl4W8LkaIEPw2XD90RUXyVIR9old7g88WtvArxSDmPcdaRv7?=
 =?us-ascii?Q?cB3nJ6sbHLpTbU1CoAa5h7aEbhhaZYbftBF4RKED+VF3zBASsvD8FEmb0TWr?=
 =?us-ascii?Q?mIYyVeR3O6/NYMjVGDdR2lnv8R/UAV7XDNUW19gV3EWx3ryvWddUqO9HH0qy?=
 =?us-ascii?Q?4fQzAnn6/ovwoJg3hNi6DTiXwDms9UZoEBjik/iM3yy3yzZQ1SD/xBpu3BOG?=
 =?us-ascii?Q?0ETF+MRTyhlzofP/4jfbso6uK3p4M0oKIrJtysiN6bv36M8Zd+RLlc5FVMCr?=
 =?us-ascii?Q?9wxNl6q9UXIyrm/ipBlKRX9+xbr0qk102Rl/+YqB/HFVOH8i+KqxUir+vmrk?=
 =?us-ascii?Q?QLKD3jbR+37e+BWTUFxg71qOqlv5y59SPoE86a7WrDVRZLAU/pXxBpsHoghD?=
 =?us-ascii?Q?VS9E7nchE0dZg7opGuFmYuOUpsaLMBGoFm5rPT9oZ6EIqw7p0HRAe71h/ccX?=
 =?us-ascii?Q?mluJgLnVksyIfezRgKQfu9bkEcsbMOyfkNi2xF/Rltf1lzGuN3Ja0+s413pL?=
 =?us-ascii?Q?R5e2WM6AmMQ2DczhSDFEvsC8fqNvOGnTkGtRs0X8MZL3amX8pv0I5GDAhsTG?=
 =?us-ascii?Q?ZaNuxKiU75a0xV9nwtkQWbmxiat+GC3tK31QxZlb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2003a476-0a76-4b1f-cb2f-08dab338687e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:46:47.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4mOIqPzS0jgkps54B6EnXHFZDgDRi8Vg+eTP/Gc+PXtrt7XtrolcgNLSC9HhVB+gszGlJm/5cM/0hNjHPfrKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5725
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zhe Wang <zhe.wang1@unisoc.com>
>=20
> Some UFS devices require that the VCC should drop below 0.1V after
> turning off, otherwise device may not resume successfully. And
> because the power-off rate is different on different SOC platforms.
> Therefore, we hope that the delay can be modified by vendor to
> adjust the most appropriate delay value.
>=20
> Signed-off-by: Zhe Wang <zhe.wang1@unisoc.com>
> ---
> V1 -> V2
> - move turnoff_delay_us to struct ufs_vreg instead
> - replace usleep_range with ufshcd_delay_us
>=20
>  drivers/ufs/core/ufshcd.c | 9 ++++++++-
>  include/ufs/ufs.h         | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7256e6c43ca6..386ff6ed2f20 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -89,6 +89,9 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>=20
> +/* Default value of turn off VCC rail: 5000us */
> +#define UFS_VCC_TURNOFF_DELAY_US 5000
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)                           \
>         ({                                                              \
>                 int _ret;                                               \
> @@ -7784,6 +7787,10 @@ static int ufs_get_device_desc(struct ufs_hba *hba=
)
>=20
>         ufs_fixup_device_setup(hba);
>=20
> +       if (hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
> +           !hba->vreg_info.vcc->turnoff_delay_us)
> +               hba->vreg_info.vcc->turnoff_delay_us =3D
> UFS_VCC_TURNOFF_DELAY_US;
> +
You answered my question to your v1 - where otherwise you are setting this =
value:
"We are still preparing and discussing our own UFS host driver code,
which will be uploaded once we are done."

Well until then - this isn't very useful.

Thanks,
Avri

>         ufshcd_wb_probe(hba, desc_buf);
>=20
>         ufshcd_temp_notif_probe(hba, desc_buf);
> @@ -8918,7 +8925,7 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba *hba=
)
>          */
>         if (vcc_off && hba->vreg_info.vcc &&
>                 hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
> -               usleep_range(5000, 5100);
> +               ufshcd_delay_us(hba->vreg_info.vcc->turnoff_delay_us, 100=
);
>  }
>=20
>  #ifdef CONFIG_PM
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index 1bba3fead2ce..792335dfd70b 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -569,6 +569,7 @@ struct ufs_vreg {
>         bool always_on;
>         bool enabled;
>         int max_uA;
> +       u32 turnoff_delay_us;
>  };
>=20
>  struct ufs_vreg_info {
> --
> 2.17.1

