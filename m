Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E563373AD99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFWAFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWAFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:05:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C060CE2;
        Thu, 22 Jun 2023 17:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687478742; x=1719014742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ytVeTQHD8/qPr9FYaYtPaxrlyv9LXJFr5D1OeY/LU+E=;
  b=ZvSTmKUJRzpx/4CMPHZD+bLds+BX5veilHajr68USSD3U6lIQJCJdwZy
   QczDU8XRAXsi1gRoTcCiKEbXVb4VcnLH7C8s5Voodb8z4SAnkYD5C0YIx
   G7yEigqeaWVN1nhK6xOxkrIU8O48S/ppjRSgnpL1S4RHtz/EYeqwJNmut
   eFaiL0MuLA45HRtdvS8op15ij0BhxwAJurze5KezAskX+3DumvjWENyTJ
   fQ97fjD33/GSsbd5AY8vL5KWWvWhO0IVAsMv7yGpxFv8ogdHd95Yj3LFM
   S8cGSz2yav6xnVh6YAvcptHxEQbZ4/B6RXSWDQkgOG1ISrrO90kDXFHhr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="364092713"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="364092713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 17:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="859655338"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="859655338"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2023 17:05:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 17:05:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 17:05:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 17:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnBTPHytlWysPamKUWsh4WYex75TJrugIiOTE5vjyBSX1wL/uz1qgthyImszO/vBo0mz3RwkqWpv2+WKF6Fx3t/k4lGhnGthLgwfKOVyZ/36Idi8C+tb70UosAAn7+UXRkZ6vghbRsgYDnyFklHi9bFachnbVOIGu/9Of0RqBZFVeefkGMVg24wM8GePMjbgvkDT+Ec38JleDNDLV/wz0OymXyfgFwJWZgDd6DvV5o8lCwtdIpoXKW6yVLvHYdZzqAY3LtbsrlukxmT4C7rZTO1kc97W2MX5188gF/X/O3WR1n/IOYQddAPA3Yk7Ijyo6V6nfDcAOAUYE7TDoNgGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9rqbi2iQug28C1J+Lf6rAcQ5lg1zK7qRT5qlweonJ8=;
 b=nwOEwaQeAQ8JnlHFCrNG9lY6UHwhtg0oY59IOrJo82P4aMkw2QdRp4uhupVZ3aYC/96W4g/3wX+klzt9Oqqtd8fnCPB0kXnhAzr9ZHEm1vo9XkcS35Ex7DG3hE4AXhqVXEpfE+PiTqCg3oev9U+WeD6/surfmEtlwx5EnD4FsobtUfGvAMdbcbSduOL5vkeHTWZzUartS4VFZxA5HWbZurrNsJb6yWnzZqaXJgaZIdJ06J3W8yvmEETbVzvXDsFp1Jrzkdk1ayi0aPRwRFUgJJ57sFm2cRjaZU6f10V1e/JZMs6J8W4+AZIPePkW2eXcrkrJ/MCpOWrPd9vhBEUxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by SA2PR11MB4922.namprd11.prod.outlook.com (2603:10b6:806:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 00:05:33 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::cf82:c4e7:8e5f:750d]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::cf82:c4e7:8e5f:750d%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 00:05:33 +0000
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: RE: [PATCH net] net: stmmac: fix double serdes powerdown
Thread-Topic: [PATCH net] net: stmmac: fix double serdes powerdown
Thread-Index: AQHZpEgvZv2rokUmVk+XS3HYZ85FKK+XLV2AgABWhrA=
Date:   Fri, 23 Jun 2023 00:05:32 +0000
Message-ID: <BN9PR11MB5370CEFCA9D23A48015AF78CEC23A@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20230621135537.376649-1-brgl@bgdev.pl>
 <20230622185425.vfewm2qgxqpndfyf@halaney-x13s>
In-Reply-To: <20230622185425.vfewm2qgxqpndfyf@halaney-x13s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|SA2PR11MB4922:EE_
x-ms-office365-filtering-correlation-id: c779af50-d811-4495-40dd-08db737d8ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pE/9vwtr0Fvjpywb9tXvSYXrZiZNNNnpDYTcxOe31eHU7R6sD7nI2OwCqlcmFPQDgEhXZFj7ACoIacNI9X4U3190cHDohyVK+N0O0wNaBZkyY0A4U16ydJFBXzZxgdrYxOjc6FrIYvGwr4aeHHMloYt/hcvbtzz8j/4cKxYJXr2pOOaRvuh0d/wEjIL2ZLUCkZL6fyXFO+0m1au7/UMpgMcwuVTevlvSOe0Ho5m1iG1BRv0Dv9dpmLWkGnARW/eukB/i9PZmFVvC4qcoi0hzVvy297lpo/5Z2uU89IqNxmNZGbOSfEe1hIqA73L82HL6Nty7z9N82XGhxu/wwF7ytC2StWIXKLst4MbTAI4PYMvsS0HfH780Qt5qSwF/aZ3qdNwWXK26WWA1nM4gw446nzJeSYrHMt/3AzYqyOlnwXqHLDfToBiqA1AQ/URyD4AlbV/rHdv1l1t2MNcp6fPpnqxSTZzpu+lM7HvEoKcPC9NSAtqCHS3aPq6XDS4NVYGhmfDcCySROk6DfQCYKi4KKukpjk6a9mAmwHh+uSQS42zUbgTt51YbV1EkOk+FnLCS4zOGNh4KOyIE/tFNEAdquRHLjEFCfwE0MSdeuRj5uZTAB2eQsciZvafuCXaT9oUB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(86362001)(54906003)(110136005)(478600001)(55016003)(7696005)(71200400001)(186003)(4326008)(41300700001)(76116006)(316002)(53546011)(33656002)(66476007)(83380400001)(64756008)(66446008)(9686003)(26005)(66946007)(6506007)(66556008)(52536014)(8936002)(8676002)(7416002)(5660300002)(38100700002)(2906002)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AazT9l7lV25YIRn6N7FBhv5Sv7gPFDA0LgZMN43iNAusaZvxAg6OCAFewBvV?=
 =?us-ascii?Q?SlufJPAOLVdozapIPQPyb776YHs4oUubx6690GH0skNd7sFi84pBwfJQ7k0G?=
 =?us-ascii?Q?xaalWKBlUJ1POHQB+rbvLpVGPQWVmMvSTb08AZHMa1W1qnefIS9wuvST+s/R?=
 =?us-ascii?Q?0kWBENyg4EGHP4HHZ3X4omq0ieiYZZZq/uSCkN2V0bHgc1Z1nB8sj5qqIxvN?=
 =?us-ascii?Q?3B7UHQGksB305D1rAcomIjsptRGnaUpcpYgSAmFwOSJTIgcO24zUDos7RwHT?=
 =?us-ascii?Q?AUf1wOalQ0fKEK0fFGGF+fzZLSlqFo2DGREjm2uYbqMcOAdobSMV7PhSXA/j?=
 =?us-ascii?Q?99iahQhy23925CP+o5VHdT2et5Ce3tritDaUVJCDk9S/yID3gjudORTfIGPA?=
 =?us-ascii?Q?LUoX5+IjCfZlVayIJ/D9vc/Qul7OhprEv3tHI1WaEFjEusJt+N833PgyQfar?=
 =?us-ascii?Q?Swl0HYwjKbJsYWUfwTuZ7CkkemAXvzQSMs0Be5mOpDtgbnZ5Erh8knmaTSLp?=
 =?us-ascii?Q?yX87JWbTmw2Vk5KshKQEQ0r4xFdShs/1MYEv/jCjcSwWZ9JkimOC5vqPXpps?=
 =?us-ascii?Q?d1zTNPARK5PdinbuYlDKk0rlZ4X+mFZvJHMvgp2FxWFBfy3TI3pZiah/Fn7k?=
 =?us-ascii?Q?MXyZSq0evCnmvvn7dSjr41F474FGQJHpsKvgZGOyfUEqQHTw3IXRIPCmTIfa?=
 =?us-ascii?Q?23/821wR+uZW3tw6uxXb99jFz0H3pULPrqYZBUuK4aWEEYt8beM0Rshu1PBO?=
 =?us-ascii?Q?m1cFALN36m2nyOPOCurDwK9bwE+4Kzz1RhJlkPSG2T+xfWayLdLOvJPOvY87?=
 =?us-ascii?Q?vefD92LOYRitjebms5K3jbFwRxYWnaoSd1CRGgTxuHhL7nm+d9eAr0sDvVFx?=
 =?us-ascii?Q?ZbiGNPBgqDaUS4Z7ssZe7fQAHOLioRlLAXJIROBVlYcGpCEf5BvyHasAyovX?=
 =?us-ascii?Q?6cJUtm6+gpi/xSJ+ck/zRaYPTO96bZFQzckTxV9HejxWc1dzDVo7WxLvf8qg?=
 =?us-ascii?Q?HUsBqBjWRDk0YCfXhDep3jfwcbROZnsXPgoMkhPZYCnD5b5oaRIf2jDsnoYP?=
 =?us-ascii?Q?c7RG+SZvs3CDPeKcSf2ajES7MVAp2SCibAhFUY1oUSVQO8t4A/z/OIWCUooK?=
 =?us-ascii?Q?MheiZ9JNdOhlLsFbYjl97HBRzIBg5E5U3keBZjY384PsAXkBJZ9RDWhpDQf2?=
 =?us-ascii?Q?jxhW8EKkuikocis4Bq2jiEDheQnTNNXqpvVs65j3SLzMjNwcbM1jhsTjxw5E?=
 =?us-ascii?Q?jsXsAX3hYEyi+2NHCBG2V8vHQ9zOJdJt9ltIDmNOJgmwVYdrmtWAOtUPWB/N?=
 =?us-ascii?Q?OfYWlVNAys32UpDvhgIKtBBZ3YQ278HEOGnBdWSwI7HjL0KPJfk/gPYEHm+D?=
 =?us-ascii?Q?9FIWyXoTRyFqy6U81mJvksq//NyPjuq8L/52M6pewiF+bhxKLnqMYKFqQDTy?=
 =?us-ascii?Q?MhJppWMg/EBl9tSzwr4Xt3WYzBSVGCJCeFh4Oo3AzZGcS1X5OmvcTbtWL152?=
 =?us-ascii?Q?xBJOdg/CtJZUpZZ+X1nZV6POe0s7tHAgbcFFTJKdjK2DQCG3IBK/AtpHPaxj?=
 =?us-ascii?Q?eZBxiXfwjo9RiUe9e0H0UQ1BXDcJ1rOk/r10FPtN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c779af50-d811-4495-40dd-08db737d8ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 00:05:32.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrLhdMY1/XBnCR93xr0BCTL3IqACv51DgBKuZhuBQccsFQJMCSYZBHA/H2HXNJLm320ZD98IeG8hvKmOTRprZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4922
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Junxiao Chang <junxiao.chang@intel.com>

-----Original Message-----
From: Andrew Halaney <ahalaney@redhat.com>=20
Sent: Friday, June 23, 2023 2:54 AM
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue <alexandr=
e.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>; David S . Miller =
<davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <=
kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin <mcoquel=
in.stm32@gmail.com>; Chang, Junxiao <junxiao.chang@intel.com>; netdev@vger.=
kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@list=
s.infradead.org; linux-kernel@vger.kernel.org; Bartosz Golaszewski <bartosz=
.golaszewski@linaro.org>
Subject: Re: [PATCH net] net: stmmac: fix double serdes powerdown

On Wed, Jun 21, 2023 at 03:55:37PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
> stmmac_open/release") correctly added a call to the serdes_powerdown()=20
> callback to stmmac_release() but did not remove the one from
> stmmac_remove() which leads to a doubled call to serdes_powerdown().
>=20
> This can lead to all kinds of problems: in the case of the qcom ethqos=20
> driver, it caused an unbalanced regulator disable splat.
>=20
> Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in=20
> stmmac_open/release")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=20
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 10e8a5606ba6..4727f7be4f86 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7461,12 +7461,6 @@ void stmmac_dvr_remove(struct device *dev)
>  	netif_carrier_off(ndev);
>  	unregister_netdev(ndev);
> =20
> -	/* Serdes power down needs to happen after VLAN filter
> -	 * is deleted that is triggered by unregister_netdev().
> -	 */
> -	if (priv->plat->serdes_powerdown)
> -		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
> -
>  #ifdef CONFIG_DEBUG_FS
>  	stmmac_exit_fs(ndev);
>  #endif
> --
> 2.39.2
>=20

