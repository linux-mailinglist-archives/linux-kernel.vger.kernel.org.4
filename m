Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80084615CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKBHXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKBHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:23:33 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366A82528A;
        Wed,  2 Nov 2022 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667373812; x=1698909812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bpIQTqHhl1hFrNZ9MkUVcOprMlui3d9MzZwvvRbnKu0=;
  b=pUoha7lPfh8y2AQ7Ii9e02TKaLX83ER9rnTv9Cs05IM8EbRSo0n3uGCh
   2El8ihPcLm8gHgNEZvd4hHkF/6v7BhlDPy/nYaRogtoFGWBIrbTAfBMcA
   uzjkSDshLxjyZj82hX0R8UVfeMchz46e/1Qzf6GHm4unXnNZZZHAaGFfv
   SIuNgZ0Ujer7VtEItzQ2QNv82rNPmD/gRviVin455diPXr52DBNIr0wiB
   fjVgTp7HgJIi4QRNHRBRsmyvEpM3xrMlblWuEC55+3rKm1BoMCZqdNz76
   g9cARjDdhwmsIG+QvrXm5EQu8jfhuVQAWoqG+RutFRbQHdZI5QSF/Ura0
   g==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="319623484"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 15:23:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjrnFq23UYreF9906cJIDBgEpi+GEEJ4/zPlQO48lgP/kzJKEP5Fy5FRDEuHd6As970pT2KW56uXAQROeiMNJxU5k5fWhnMy9hB/kLu7YGG+PrrJl69Z/m2t0aQvOuvEqaI+7qYQ3JnbPAiqI/qG1Aj4NCaL3eV2v8KIfrO5+w7IBUoAatkHNZajmKuIR3jYKtF0n05NHtMtEBDFJhM1OT2UNdxGUDZX5ZhICmeXcozbZL6BKwlEZCEy3vjGsk5ylqO90iXwor878UQjvqWcaaP1C3uSIR4+KhYIDbbb74uCaFHuGGhwmDRQm78hwnSRnLnYRw2FkuEBuuh/p8yYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka/z3HtH/fVU2Ruqu7N5mt9fDPJIXlPODkOxwMvT5TM=;
 b=Ih8IGslzLF2Nd9aP+JnryEFKfGcIESZG3Wo5ZSSe+qeNub7a5uNjzALEDHJrhNmZAJFVwRzOkiRM8H3Y/1trpWkLQnwgLrt7Tqsp5ZhGNKdHuUWWClhYpp/d522mDUG/y+qhVWC6QwqQzgkVyjUp6TjsZTGrSZvzJO14APc591IE8IsK5TPSm4t1kysCRH6yC0HoiyP2UAxO01rWZAZrpUmVcjZKukGkzxzTpRm7+oswktV5/3J49E40eKkaCXF2gW6LbP4nntKBQ9ix7SON6dat2P0Tkf6YnBNcMrCNhbRBDPecQZbuWA+xcoJAP7McVXtH0gFkn2lVJR/iCt1X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka/z3HtH/fVU2Ruqu7N5mt9fDPJIXlPODkOxwMvT5TM=;
 b=LkNTTQy6N5p0G+SKs/0PNDpDtbGoEpdvTJ3mgWZTjkGhXxKoN7RkIVBvpvaSIqNwGtJEwJeVgC14gghHjEOokYzqlBA4vl2yvxMF59ZH1VhDNRGguNhThA3w9gMC1KaUEyIM3tNTLhGv1kTOvloG3ezxCoAEKNo9A/VpW/TVdCQ=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by SJ0PR04MB7296.namprd04.prod.outlook.com (2603:10b6:a03:295::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 07:23:27 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::152f:249a:afc7:d6d1]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::152f:249a:afc7:d6d1%9]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 07:23:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: RE: [RESEND PATCH 1/4] scsi:ufs:remove sanity check
Thread-Topic: [RESEND PATCH 1/4] scsi:ufs:remove sanity check
Thread-Index: AQHY7nxg7JegoaBYh0+mHw3z5ripcK4rOVqg
Date:   Wed, 2 Nov 2022 07:23:27 +0000
Message-ID: <BL0PR04MB65648BD218A08A3D55A6D12BFC399@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <20221102053058.21021-2-lijiaming3@xiaomi.corp-partner.google.com>
In-Reply-To: <20221102053058.21021-2-lijiaming3@xiaomi.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|SJ0PR04MB7296:EE_
x-ms-office365-filtering-correlation-id: ee34e60e-c675-4d77-a1d5-08dabca32293
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b57DOQb1kYAREL/nx4pYKlV4XxI6CTccvHpMOgEG3Es7Vbotlzx8nnuJ2Hcdz77GG2TQbtk8B1istQBvPc5C7oLUM17LPONrf+2pGQLC5W9IEmofR1fL3MpALOe5ibvkuwBXveHDJJy4fkrqCNxMM3u5ZUTUAQW6m2yGC14FBy4oZKJYe23QuhW6jVuPG1mjx7bs9wNCq8AgufNadx2YgxbwqdB6AFN0owUDnOSCmBLPVYyZs3f7wNERMtIhmxQDoHtWAWWLuwcEeFolMuJdaFObEo2ZpclZpvtQsNqCnoJ42wluwo3UJYI5evYSMawCRUAnEVInk9JIuXG1XkM2OJvwmuhu8YTrDUGLq2glx6D9vom1QZdiTsySSVtDKimEkqXyxZ5Di1TeLXmnxCJwUHyzJ/ollqrkBkjKK+PuAH1lPXZMRXPwhKe+hTb7aZmhRsd3b1h3Ew8tCNykMeVGG2YaBS29ozxXGGKVkcoP6o1ji4v0gM5ajA1MPW+w1CohnU+H0RdC6K2tWhlce/213Mzjp9nTJyydAwDLrWlFARfaiIO2Pn3vgqRpLjUkWZsaaYLcvKnEX3AM1OkdTmAV/1D3E455Tpb3Ddc/5c9vEvj0PITUAbBPI+vElowdPCk+dG8fJ0N/Y2Ty7Pyh5T0XCv2OUGGCMIupu2n+LBMm+tK+iyNEiIu3JxUA5TnIpafINaHbUEV73SYk5sVdXERjJ2mHnwokt9oJbYPjKtMDXwqkveb+QLdWXMsZhJaY5Qw2Uz8Hz8LCaJkt5HOxGebUkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(5660300002)(8936002)(41300700001)(52536014)(2906002)(71200400001)(110136005)(54906003)(55016003)(4326008)(316002)(33656002)(66446008)(66476007)(64756008)(8676002)(66556008)(76116006)(66946007)(478600001)(83380400001)(38070700005)(38100700002)(122000001)(82960400001)(6506007)(7696005)(186003)(86362001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MaPuQS0Un1oPgr54ua8PtU3+ZKg0vJ+EAhLE+OvriSQHCJJpnausuWgXxYpP?=
 =?us-ascii?Q?NV+2j6XIUuLC0Z4HJ4xQGf1HJQmZdb72lgItR9ZXDNl/0s/uCRVHIM6fWb+p?=
 =?us-ascii?Q?6Jx9Q+EMvEHqalIKQ7lOS7c7d6ikg1KnqYFETrIFKj9yJop/4Znd31H4xTO7?=
 =?us-ascii?Q?yRn66mkBmydOXjiqxkdZzZvPLMV+gXIyqcph9le1PYi5GZOZMzyblo/Y4mlT?=
 =?us-ascii?Q?+4G+gp6imw6sH6K25Ud1/F/IOTkxFjzHd+dO+t8P/d1eSFNbGiZ7/2kxhmBw?=
 =?us-ascii?Q?3smHPzy2yqZN7yFnC2Yy5r++MZUf8XwK/xV1THo6MCpyh/VPvVnXu+0gla2V?=
 =?us-ascii?Q?e0YMWUEo7D1XI6IF2kFFv0anVhcQwP+jG7vxiU+CH6ALleNBFDX+fwOK0bFK?=
 =?us-ascii?Q?sv4IAA8RzSii79pNNu03ssP3qPidQSPxIE2+8orMKIdAdRBFnFcalesO/+zn?=
 =?us-ascii?Q?JssVqurIRcQjPAvHzdmzXzIrHLtXbDVsAQiab7KxiunkAZVg3WZn8LcciFUU?=
 =?us-ascii?Q?WrC+pVstPiG2VohwUfXbCWg+uxaBWqmvAcDUx+keBoamw04SF/zixzFLhguA?=
 =?us-ascii?Q?uzM/prEXUB6Pa01y0xN2X8vV82oHf+Rzo7p2XfwDoNuNqu44dELEv94ClY4d?=
 =?us-ascii?Q?ixgU2kwqVUPnarXkucKTJCNV4tjqHph8zy91rtFm76b50t0NntMMo6cyWNGI?=
 =?us-ascii?Q?HKUlWXZFzm6eDyfRZ2J5tmu/Bj7/03IsguXXKR3bAlUI9P+pUx0w8gLNznRA?=
 =?us-ascii?Q?WfzPpJux/Q72/ThOZT20S/g1z/9JiQunUBYc7YPZZlFs5vbxo3cQWKist/Zp?=
 =?us-ascii?Q?q0AF9c6JEdcCpjjzFn1CcEXxNoyrO8baX2cGbfnoc/N7SA6QvtZ9ypTSU8vA?=
 =?us-ascii?Q?VfEukmgbvp3qWWiYyHDiCW+gq85IU/Y0tTl8hnqSap5/kVU+XmLxIAwxpPaH?=
 =?us-ascii?Q?QlSkcF4Y5z9YNkLtVlTLGqOG4ZVzS2PnyGJXauiXfoibaW7VSSluW4CYgJsG?=
 =?us-ascii?Q?p9Jm29lm7O8dpgSaur7Z3CMTXV3pJuKPcGtPF64PUP/RClR9euCFBK1Bh1Sl?=
 =?us-ascii?Q?BbbbhFCnTCQF65n9UWQTcshXEZUSq0ijVfbEtHNHWwvzSgEsL0tt9Y1wycni?=
 =?us-ascii?Q?AkCkswH3IlvWjo8APyXrjxh5jG5ApCRWBY7CYt9shObSrmOjgMH/E2Logjtt?=
 =?us-ascii?Q?fhahJvDYEAPW4Dg0hmFkw2ssj36qkmBLr/oT1YRS4Bzd6iV2/UT43J20/N6n?=
 =?us-ascii?Q?M+oVUpn1NpbjdU7e3e77Rd9visZAyo6+6J0607PhWlxMXE7MCt6ttRklv0+0?=
 =?us-ascii?Q?hoXng5Tzgq+tQiSOan1PRfo3wdS9eG7nWsCIupPLIAAK89rD8tGcm+ImDCSa?=
 =?us-ascii?Q?UCbNuejQ4OKwmjCdr+CokmZj0iZJRF/P4Rfenb+yGrNAUN6S9zC3KOV9x3dC?=
 =?us-ascii?Q?CMb/XBIHIxPOMl7RnPRwLzxkGQa5WIFv6Msz6lz2uzjwxgmrKjgxfywFIxwP?=
 =?us-ascii?Q?vlv3t8MmDGPljX8xh8/XcXc75WuXOCsjxHb+W1jnA1T/Ja6H9VRkybtojtuQ?=
 =?us-ascii?Q?CfkyJWmZf8afXpGM/38ll5nZiy7xv/pyXnQbgcCh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee34e60e-c675-4d77-a1d5-08dabca32293
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 07:23:27.1981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZZu/Dq5X6oFX869n7zXikj0NnladM4DQzreFtqgeQVwvRScyvSgSt2jfb7uT21qo54Owml6WMwU756KtWlFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7296
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: lijiaming3 <lijiaming3@xiaomi.com>
>=20
> UFS descriptors assumed to have a 2 bytes header:
>  - Offset 0 - descriptor size
>  - Offset 1 - descriptor id
> However, the ufs spec does not mandates this, and as a matter of fact,
> QUERY_DESC_DESC_TYPE_OFFSET is not being used anymore now.
So maybe remove it from ufs.h as well?

> And future descriptors no longer follow this assumption. So remove this a=
s
> preparation of introducing the FBO descriptor.
>=20
> Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
other than the nit above:
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/ufs/core/ufshcd.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> b1f59a5fe632..4bc5b8563a62 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3458,14 +3458,6 @@ int ufshcd_read_desc_param(struct ufs_hba
> *hba,
>                 goto out;
>         }
>=20
> -       /* Sanity check */
> -       if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] !=3D desc_id) {
> -               dev_err(hba->dev, "%s: invalid desc_id %d in descriptor h=
eader\n",
> -                       __func__, desc_buf[QUERY_DESC_DESC_TYPE_OFFSET]);
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> -
>         /* Update descriptor length */
>         buff_len =3D desc_buf[QUERY_DESC_LENGTH_OFFSET];
>         ufshcd_update_desc_length(hba, desc_id, desc_index, buff_len);
> --
> 2.38.1

