Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377805FAD38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJKHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJKHH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:07:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98947C33C;
        Tue, 11 Oct 2022 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665472075; x=1697008075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pGonhR4W9bMpLp8MVkxQEHT01K83vVCpFN/E3x9lApg=;
  b=XjtPDKukf93ZobRRon4ta0ppr/0t6fI2+6fwJk4gRMN+0iBIFRRS3v/w
   Dm1cyld4bFps4SXJbR6/fwZUfis75lzAMjKL/ZCUw+NDucJ77OHN9rpH2
   Mm5oSJKrrf209V5hqYzSW/Kl+6uf2TJxNMdLeHmQB8T6qJ2uD0Vrud/7D
   aTQkvfn2Sm1DcixBb26WNnvMeCM844DWhQPQTOlryaT2+Dt25xk7CK26s
   XyRJG+kzJnQ9rZ9nT8CiQspx5WvAWNSxxDMdeFscZdPBjk34zsHgslRoG
   w1pCJWVW53+qNDTTppYer0iuaAEcPeqSObjZJdqyIjvkJ+nfYbUD0vJzA
   w==;
X-IronPort-AV: E=Sophos;i="5.95,175,1661788800"; 
   d="scan'208";a="211809767"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2022 15:07:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxttr8YifU9W3k55n4Rzuq1gAmcAS4ZpmcUYtRubO7FJigyg3q+B1XKwdTPL5TFCtqgdez3ykBjNfsfhMydUjSBaJMLal5gt0UeMPKqxsJLo9YyoprAI0bKdJpJzuZCC1FlwrfVZle9NVOrlcaw0is/TCSquis94Hh8fBkhovu+1BYRLzRBsdjjFGnvxLE2CfR4qei+HwPfcKAeYa6v25ze29L2GvOWwM0BDxQ3VP02IhJcx5jkgS/EfGFZU/izmT72ivWE3rNpH1mO8LOd+cfQrFI2jNftky+m6NZF4JVwhoVigtegkoKfQ3qXWzUm9HafwBv4t8vsqPVrbdRIVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4Z381hnswbCuiQxQpEEvLNwNhvqF0Q/iJX3dOJsmFQ=;
 b=JnKyytDz4EHeV0dq+1uQQmufrQYeSIv5MDLXz8zVM8FufVRqeEk3qFKH+eJtntxoJbNfPXuPFLB9DbJTx2TE+U2XNOxwM22BgNLwLAZ4Z0rRVrXAk6rshpKn9m6Xsp20MoTQYjEvgxGzvN2AMYF7icOhmO8BKxmWLAHi8o+gjL3m5HniYHRVu5+VxxiZtH5vZXzAnIuZdR/THEiAqvVcpLzpl2mBOPUNhqylLjgjr7asRC26IWZtdBWx+lffm+L0fSd76Jg1Ltlq4XfV/gdG89Qx1mpbNez6Kh6ZeIj1JjFa/jdaFIUI/w8df7xtvcUS1FzoufLUKuL1DoJXdeQBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4Z381hnswbCuiQxQpEEvLNwNhvqF0Q/iJX3dOJsmFQ=;
 b=YHmXQSY50ehavXqHBlezaI8/iPhZtR0FsKzwvXSYYUK7OcKoan4Kxminwn+d79CwaXzt2HvjjAoGRctw+R2wPwh5rlsWIjOK1B9AK/GiEvM/hXwWO96vWhiD+rULNnl/xsj1Yfh4zmAjM9Q4FAYPdDwpqd+ITJO6MhFsBx2EEk0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB5683.namprd04.prod.outlook.com (2603:10b6:408:a9::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Tue, 11 Oct 2022 07:07:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 07:07:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ten Gao <gaoyankaigeren@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ufs: core: Disable auto h8 before ssu
Thread-Topic: [PATCH] ufs: core: Disable auto h8 before ssu
Thread-Index: AQHY3ReOb6qYvQkkBU21f4ndI5lc+q4IxU1w
Date:   Tue, 11 Oct 2022 07:07:52 +0000
Message-ID: <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
In-Reply-To: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB5683:EE_
x-ms-office365-filtering-correlation-id: ee2bf2f4-1ebb-4d60-e16a-08daab57505d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YT44n7o7vf0IJOK1MMiuABWaVdugH7Pi4222rGF0WT+NTYVH3hSRE8p+SgU5fIhcFgUpmExPKsjdhVmLIgDCWIT/4bUHKXOXf78vusQUFLD2S56gwGwk9Uok2uJLkbtZ8xKKFAQRpKRYam7sSsUx0L8nStmptAY7U6jEbC/gwjpiWXAC0ZsdEfrQ1OP7iqf1Y1Xin1xrbd9WxVcdw4y6BizLwbTfghx7Gr9KuMTSQONSgk4ghw1+t85A/v6L24zqgtPDQNNaK1hRLrRoFRY+9xnwPWwWErXCPsfZIgk7fIDI5jp5/RtNjWh9GqgzJebuuXOKtDTyV4osstvQLoTM74tHo1CsxhCu7ErwRs6ednAUgQrZD0z67wP+4sLcNbMvGWdQ5G4AXpaCavMk9ZLOQJJwGhwKasUcIMfEXIMhNbISNwMC2H7tQg9xO8XRFpPjRWuR7c4o1ssMYIScveOEcjVAS0sZES8V4uFr3xWJPdmeW4a3Idu8dSulLVZ3kP6bVX9ZbC+Qu3cBnVzdvhAGw9Kq5E+3pyGnu+8/OeXTlvezvdjxqmq5bYohkR2TxBDCHLegfoogkoFm2Q9rXVKdgSoIDCaUWOPQReEbn8pzJ0OfFTYdzr8Laot9oGvVPnW6EwjW95WSvREg1Seaj78jhDaETrzmZBbOTlKkSEDtCBdY2gksbp0q7hiMVf9YQcz2e60dIZAayJAZ5naCByc1Swf38hivFnAvBZO1LtUw3txQe+jYXTjBiv9NDQVfpURD69mkmoFhV9ClxSqJ/eV/LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(7696005)(316002)(55016003)(6506007)(478600001)(38100700002)(122000001)(66946007)(4326008)(2906002)(33656002)(76116006)(66556008)(52536014)(64756008)(66476007)(71200400001)(86362001)(5660300002)(66446008)(8676002)(82960400001)(8936002)(41300700001)(38070700005)(110136005)(54906003)(186003)(83380400001)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iYsSo4G2HDVhFQRu4YgBAv9r8qIUFCt00Xamji4t5xH479ygdNlEPSThNtKu?=
 =?us-ascii?Q?cagY/AWgWnB5B158otL/clui3ePTrRjakv8riUMXe6KYePG92y+4/oCK3ycn?=
 =?us-ascii?Q?V3tJuBj3kMe6ZQwt9lAZtwSVww6e05GgMdp/w2XEdxCByG400Q4DRGvPTn+p?=
 =?us-ascii?Q?RgLy4rXJc2y/zysk7rWS1VnReezMUbJNW8SktyXFtA+bx3fP/+d5IlheQCVn?=
 =?us-ascii?Q?hOj/cq1VmEZ/6TcppXZxAzQT5KdHGGR2bKqp6Fe5IJiufY/Qt/0QIyZ/xTO/?=
 =?us-ascii?Q?bq4MaJHvWJ/EIx8bisNKcgK0bDz80Y69Eqq2+bDpPR/fL+GRiyVcBF4apRMe?=
 =?us-ascii?Q?4GR2h/PN2nfxUtW6y4moNTSFsGscAh36opIxvjB4XeSYWEQ5svbVdFbaD/he?=
 =?us-ascii?Q?gPUoj2LUVFOlki0e7Ku6oNXbR+hxKqo8xXypgOIaibCakZhhDanK3ty/kRja?=
 =?us-ascii?Q?pYDyQ4f9zrRnblDmbd8MeOJyZ0oMod3s1fEkwjVD+6+Yqqp6tKiOIkr4B25w?=
 =?us-ascii?Q?NKbCO3WBw8LByOPDDehTzjfg42TL/lQAa3DUBMy/eIgwmd53DSNmT4tDV+Pj?=
 =?us-ascii?Q?LMA0jVxKmXWOwwVYMFLmUpeEoZWMqGo8wBx3KRf5OG2VprXvEtKg0UpvgOey?=
 =?us-ascii?Q?f0bX/tgtEQ96E1A8nWObSgFGYzz0vf7eu2WSEhhTFCQCPen5q524FmGphn/x?=
 =?us-ascii?Q?+BmuoX5aWtfUTfyEnL+7blicmvSvpq56AAUqNXOYpRMe+pSiCtrqE4YTr++q?=
 =?us-ascii?Q?P+pNBSLCQZ+3H6lIys4XlvznvznLumeNjPABw+Ju3FVdco4Yrb7P6yubk8jy?=
 =?us-ascii?Q?iFtwpjH/2redghKeMKATv5woI2/t0k/U/Ys1Pu2Q+srxoXgTJn6axeq3amAu?=
 =?us-ascii?Q?bqr80qVcWaoCXFPLYlfw+4UuCm+AKAxUtSc2PdPFTMswG1lNHk0vhtM/dCVo?=
 =?us-ascii?Q?Bv7qCojxpjGDEAukKTHXRMG86PlGbFGwHpPaJJywurNa8GTbqqp7JFT+hLYF?=
 =?us-ascii?Q?3HLcACuK0sLio5Mg4bnLCkwkJg7NnOq5nBgIkOvYwl2SjH1snaZjOhHiVY5o?=
 =?us-ascii?Q?u9iXCxf4yMLhdqVyIo4e1FlTtZZ4KdR0YD8KcRxDuXi/FTCgaUiB4QGyNz/L?=
 =?us-ascii?Q?U84PvhG3QsfQqKnPtyPIg66biz4reoulvhTMF5HoxxWcOXaG//CvJ+B+35Vh?=
 =?us-ascii?Q?g/6+diL10D/6mfvB3b+ttA59ikRrIx78niRJdwtZflQjhrS+V5KSGsgaVNr3?=
 =?us-ascii?Q?Tl9aY1ECyWwjDTEx099QHBF5E9zXBrT9AIEV5XD0iUSlfXmJyBfbnDkFXjES?=
 =?us-ascii?Q?CcrrFvtrXz3PfNoLY2qJO55f0n7w4dm6dI9z7qMXzvfs7THwCqzlny28VBIL?=
 =?us-ascii?Q?GQeFfFygZanb7/fZnaPBUhoFl0erK1JIMtvrs3emXIwP/pxyOK0Wnxbcvpn+?=
 =?us-ascii?Q?jKdd4hYasMUbFjIENZN/eT7AOpq1mJUCnAqsASa3PUvmoDLqaYaQK/XTT2Le?=
 =?us-ascii?Q?Zt1KV3LCqi1BVUoOTuJ4fXLAGJXbYStmQpJuAc1cuNgJVWCndRyCh5/yfJLB?=
 =?us-ascii?Q?4BqOO0Aq3NDfLbQcgBc8D2HNkEQsa4s6gFkGbtWJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2bf2f4-1ebb-4d60-e16a-08daab57505d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 07:07:52.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+lp4XoojVzWRgY7IMpHwg3IykVPebx6/sUbTK/7zQj88FZeUZ4a1OZJeN2/zWKUzrwUBWrPxwys1tD5Z1ggCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5683
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ten Gao <ten.gao@unisoc.com>
>=20
> Ensure auto h8 will not hit dme h8,and there won't be two h8 in a row aft=
er
> ssu.
I don't think the hw should do that.
Can you please share on which platform/host controller did you observe this=
?

Thanks,
Avri
>=20
> Signed-off-by: Ten Gao <ten.gao@unisoc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> a202d7d5240d..42f93648d796 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4256,6 +4256,14 @@ void ufshcd_auto_hibern8_update(struct ufs_hba
> *hba, u32 ahit)  }  EXPORT_SYMBOL_GPL(ufshcd_auto_hibern8_update);
>=20
> +void ufshcd_auto_hibern8_disable(struct ufs_hba *hba) {
> +       if (!ufshcd_is_auto_hibern8_supported(hba))
> +               return;
> +
> +       ufshcd_writel(hba, 0, REG_AUTO_HIBERNATE_IDLE_TIMER); }
> +
>  void ufshcd_auto_hibern8_enable(struct ufs_hba *hba)  {
>         if (!ufshcd_is_auto_hibern8_supported(hba))
> @@ -9036,6 +9044,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba
> *hba, enum ufs_pm_op pm_op)
>         if (ret)
>                 goto enable_scaling;
>=20
> +       ufshcd_auto_hibern8_disable(hba);
> +
>         if (req_dev_pwr_mode !=3D hba->curr_dev_pwr_mode) {
>                 if (pm_op !=3D UFS_RUNTIME_PM)
>                         /* ensure that bkops is disabled */
> --
> 2.17.1

