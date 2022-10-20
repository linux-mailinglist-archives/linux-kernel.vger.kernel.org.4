Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C07F6058EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJTHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJTHo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:44:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B7491D9;
        Thu, 20 Oct 2022 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666251894; x=1697787894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V/HW/rO6Hv4IvYaQdWWqQMcKcwo1so6lW9Y/tHyC4xY=;
  b=SlZDs+8WkHm90Eu4OMo42/arXvOStTLaD1XhGavwoFZXrmiG76U6dLzj
   o67q0nJh9vUdTBgQz0MD69Qn8xqMVpt22kVsByAN5A6gW6UqTxg9gKi//
   W+GuwAfOyFwxJSi04+y1uwl5HEtHesC2iUOqMDBVd8zzpd/W5F3vamC50
   Nsa7nxp1TUIk4S8InQ2atfgAZ9mzYmf9agwMKCI6YUHEt61CgpGdYW5HG
   LjteZpCwb4gUXfM+cTScSxhRtp8uSmIvfS//ZHinJMxRoScPFTveV3hub
   NeL9/Oq/4wnowVlX1C8fwFEJWAivmplm4RYYel72/P8duGHAR2VvxfXGi
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="214304329"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 15:44:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA2+jMg0c0Tm7I47fop21omw8c3sIqrmZp2X8lqIAoCqOPiGTDVB4jZnE9M/oVJWdokG1mJ75ds5D8OhfE9O22nyiJqB+g0Lfwenl/Nz++xbIyxLHYwRRI7AWIiGFWNUa7Y6zb0wkihwhB8r7al0hV9zq/foRcPTypyrC7hwC8InXhtx8l3soK3xg1P/uCH6Q8cG+aPBWK/dyEaQ3O5AVYhInfXJrtntnXU73DlgmLCTU+FKPAYtZiDwjSPseG/ynXDRYogK3OCN+b4YvBGOuJdcAhUY85WmdJy1okiolPUDO5wTAc/00KhUXVCeP8gkHOoOZ26vCnC/bL4P2LEs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgDH0BPWmPwnPEjO3EmbfQYWoUynI8nU4RoKgJ1CWmg=;
 b=bS8myO1eIBGyo8jpoLrs0lbzOIJ1uUbhJpuqMr4dgAOnOZ8GKTQDPno8Itlwohvyl+x5jluShkG8sl5iG50Ysijmpu9Xnmf5u7SD9WCMDzNgQHrkb5+g0m7RtgDZqiVV8Pdh0u6ArjdyuP16ZWE7bdQiAx4uS0gHO1ecgerK4z8qku2aESegfpB9BRikk/BDDLc5sc1LvIx6bvPP0RscKZWTFyw5CnemzCyYoMo1IaErX6VLXD/dcMPm+EEZTqL0qlXBJVCYD81y9Sb0oCYIteVDWx0ljrbcIi76NSx/wOxKvaCICDsgtXNjwBUzezvgCd8tm2WNHfPscs3Y9m/UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgDH0BPWmPwnPEjO3EmbfQYWoUynI8nU4RoKgJ1CWmg=;
 b=oQcWkn60yLwzzSG+inxFA1XP7l/9DbdND57BU8Bzpu0adQIs0JWjGfoOlxZBkrO1i4PsWLhZiJ1LVTbgl/75fIkQc6uJ2fpQklN6auLkuftqzPNFsmMJKee9NHQ1Ou8y37mthfbBpFLsBiO/dnZYnqeWS/pfUZ9Arx8jPPWCpFQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB4648.namprd04.prod.outlook.com (2603:10b6:a03:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Thu, 20 Oct 2022 07:44:48 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 07:44:48 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: RE: [PATCH] mmc: block: Support Host to control FUA.
Thread-Topic: [PATCH] mmc: block: Support Host to control FUA.
Thread-Index: AQHY5C4UnrZumHGL3Em7avruJ6gtnq4W5YSQ
Date:   Thu, 20 Oct 2022 07:44:48 +0000
Message-ID: <DM6PR04MB6575C38931D2BB4A560A355BFC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221020024529.25227-1-wenchao.chen666@gmail.com>
In-Reply-To: <20221020024529.25227-1-wenchao.chen666@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB4648:EE_
x-ms-office365-filtering-correlation-id: d1c37d80-9ed1-4407-231c-08dab26ef6f7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZv3r9QuAEgsU4mXtvnI/V1zr2TF3OSPsqWZ5U4WjrHsj163K7aSfdhP4MZb2V5f5QdwvCLY/3+WRw25kmXGfgHp52DFDtgkMJF7WmKky1wlgIY6EdRATW10KxChT5Ffr1JKNyCxCxNRmLdrSNLSKyXyMXcV/uLKl5nM/z01bsw6wCZSSp4oDsDAtQy7ybyODiN0n3cF9WpdOgGOiuNta5eR+5qJz8c7Jmtusn0b3aTTzpIZY6h9i8NbwP5RZ3O+DfPDeNUCkbCBIhPhu5VwKrKm7nYEruYkcOR+GhGAejYnZTOH63BgZRJQPPr2Zp2sN5wXWnAnkooJs870NqlzQahO54CNv3i+WUu7483/ASJGF4m05P4UBGbRd17vm0iID8wP9FXBkwTcl6LpcHEdxGSGI7k686/rBqWkDd8UV3FapkeMUhhrop6JIf5P8vDlpBUGaQRdzVoveUk2NMChnGHaKX3fGgtt47pyJW1b1ayqzO4ynS5smmAs4Zp/T7OzpECglVmyz7xxkrcIrbxMfuGkP8MgXD36CeAvH/n1/EID9r3nRZYFDwb1ZKyxDXceogrjZV/7/8iE8OGl/0iE9m/pPc5+RJf6u2bY8fE+lYgrO4nPL5q2bO3Ty3IXejsRRygi/k2NnWcM15R5dwzw54BQlzi/f4iZD5ljLUmYyzYSy/9OoJxZ6KsSvfvYrAzmem3zNmNFZ4BHb6u5Be/yrMFgkvLn0LI0j079ay50r4Tn5BFbUZzgvN8/hUucApwplEAmnF6foahwqokPk54KLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(55016003)(122000001)(38100700002)(478600001)(71200400001)(38070700005)(82960400001)(66946007)(316002)(110136005)(5660300002)(8936002)(66556008)(6506007)(41300700001)(54906003)(76116006)(4326008)(8676002)(26005)(83380400001)(2906002)(66476007)(66446008)(7696005)(7416002)(52536014)(33656002)(186003)(86362001)(9686003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VRRN8Odkw/BT8oyRSbL9ZNTWtHv/1+Cemi3TnmWIa6dS2sMvOF9E3cSGykUy?=
 =?us-ascii?Q?Pb9ZWfU+R/4RVNZpb6yXfmkf94+Y1PcU/bw2IGfZ2bnuTomJ1AdrDRIZVj8j?=
 =?us-ascii?Q?IDiXGx4GIBHDAbCixHw1odV6cja/IF7nql56uSnkkDNV4u44sGGaFpvs9Do5?=
 =?us-ascii?Q?gSYuhBklld7vF3axArfORT0uOe3EZ7nBM7JpJAEA/B1DDajHQhbbIlDxTFjh?=
 =?us-ascii?Q?11HK37xvLkaiHwpYLNDWND8++GjpZfloW2gpNScz4GicMBpvlV5hjCXBt8AP?=
 =?us-ascii?Q?Hjqi4uqHXAYNHqRDFH1Bnk8yQ4ieCeaNyvRFzuswdTWilQGQ2/T3gw643Jy8?=
 =?us-ascii?Q?EbVIrBde/BMNanOpwwnPIQsN0GKQImvKsDc0bdEgYS6oSm9htMdYMmpGNSeO?=
 =?us-ascii?Q?6Ap+SW7EoGRob8lmevhGfeKXABgSS9kJFrtPxtdKv4036stu6U4SDvn3vJxl?=
 =?us-ascii?Q?N+TWPSM0utM8P4FizNK8DDBp9KWjbeI8ZRJNL7G4xL1GgyFpQGlHv0xMduII?=
 =?us-ascii?Q?26SCsnpmOVr1abFkzQWr+5IdsqV+YEt5gKfvNk1Z1PJ12XCLOSRHXCT55F6R?=
 =?us-ascii?Q?GLP/G2RZuQ38Kmlv/sITWlz2oN/W4kcHGqONFlSsSK6sPnWPITdJfJKCpOEi?=
 =?us-ascii?Q?kZz2qSfEChKLn0DVmv0qd3N1vlOuS6x78tmA/2WXjOk4GHpScOWZWtH/mWmL?=
 =?us-ascii?Q?NOXOudqmpfkKgts+eWoojTSvvLUc1yGGoMosgKX4NY2Ga26XWpiTbMQC5cmp?=
 =?us-ascii?Q?3ETFF1qONepRt8jWdE/fxI45P2mSi2EQQ27rKaoO6qrKnsFY0uOtnPWE33pJ?=
 =?us-ascii?Q?+blOkSftb7C2nrFvJUHxR12aNWM4iH5BmQdwSGy65FNM0xfflCTZOtuNwDRS?=
 =?us-ascii?Q?NwJDpbv7eRO4Z8mNfq7Ihxyp5qxX97ypXNNNw6Sw6knlf8CTmzXWBz3Y+gSg?=
 =?us-ascii?Q?iwMoCRwQ+DHJVB576DirsWgj2y/uH2/5jRuqvZhm5+N/hT3dveAXn65P1EKJ?=
 =?us-ascii?Q?tDSk1cp4KTNvVPGCborq5ES8zElh9IEmhuzk9ifkH4l/HPElC1K0bTrSH4B5?=
 =?us-ascii?Q?nQ/3ADrSPBateesHogXa5ctluqlkPKa3UXdsxZNourSvmr8wxFUSN3MA5Iiw?=
 =?us-ascii?Q?HMD2xXz/BtXG2EIrlmh23py+CMRLHJsVfTl5WaQbwVtY1oyV5L0w9Bj6RYgS?=
 =?us-ascii?Q?OfOtj8pNHJF4Z1ZxJAt8KoCJ6M5tYmZuTpc3BIIZ20WajofGoKflbunN6j4l?=
 =?us-ascii?Q?ZzEceIjMUOpZx9+3bXqKjq8UOp+BaYIkanpgi9ZFpKUlgIS5JPHsCLwgQMbj?=
 =?us-ascii?Q?/OHQxbrSvXQCDe2QO+fbwqKGrA80kMuQA6vooI7rdpi7FeuqXaw59czu/zYf?=
 =?us-ascii?Q?aPRCDPMZpSxTfjKtXfOzo9hXvIOVchUV7ha0QY8ZrwoTX0WKqU7GU9KcD5Di?=
 =?us-ascii?Q?aiUJQ2d9+KMVYjj5XiCnMusQc6ZHtk+C/Aq13uxcjcCGUrT/eJ84Uy39XcaO?=
 =?us-ascii?Q?GwnsQ8yPbVKfkBXfLxbuRot5glNv45V0B/D1AA4TWIp/K/6CtB7Iscxo5S20?=
 =?us-ascii?Q?27hWox5p4q30sGkYsHbyfd/uARHmEif8SqTkhOD1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c37d80-9ed1-4407-231c-08dab26ef6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 07:44:48.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqYqEK1umzQDpn9L7XKrHtsC7jYTsQbrehT5DS3XCmTh6TnORHGm9z1oomW4klYMDs7Xkd4OXgJIxSQMqU+v8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4648
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> According to the above data, disable FUA (fua_disable =3D 1) improves the
> performance. Therefore, it is recommended to support the host to control
> FUA.
>=20
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
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
Where are you allowing to set fua_disable?
And then I would expect you to call blk_queue_flag_set to set QUEUE_FLAG_FU=
A.

Thanks,
Avri

>                 cache_enabled =3D true;
>         }
>         if (mmc_cache_enabled(card->host)) diff --git
> a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> 8fdd3cf971a3..16a5bee3eeae 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -517,6 +517,9 @@ struct mmc_host {
>         struct blk_crypto_profile crypto_profile;  #endif
>=20
> +       /* Host FUA support */
> +       bool                    fua_disable;
> +
>         /* Host Software Queue support */
>         bool                    hsq_enabled;
>=20
> --
> 2.17.1

