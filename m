Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE775BBD84
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIRLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:04:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897571CFDB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663499096; x=1695035096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W4EyVzhepzKSI/LwNRZHQyaCM838AvEFbyk5MQ5X2bA=;
  b=Ekdo8ngCgGKeIndh28sWqO+EntyxA9Pv09ZT0ZgcVdFxxmJ6Ikeyv/BG
   mav1Ant/bJezkOUrxUlqZxAvFDqIw8C8ribwsVKDp8NDzRqWHoVIrKZhv
   JK2C5lCvhoYfDTm1qubxL43/E2g/lI+tRoxPUQYiSg9mETPn3/dWaM1wy
   LdMpPD0xq978lXGCxju/vGVsV+GW2+CraLfGMQdl1qQNDWzvXJYVp3/9t
   AhNWe/00gApt9B7bXEC2csK9Rq+26Cr0YFyBpjh8Fx1uFcow3BcyIyQDR
   CveXsy+K4Ibilf7VEvH6FRBK4XORE4TUv3e3L+/BPPj2bYRFvsGxEX5yt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="282250862"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="282250862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 04:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="618170509"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2022 04:04:55 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 18 Sep 2022 04:04:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 18 Sep 2022 04:04:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 18 Sep 2022 04:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxqnTWvya/IU2g0Tlqb/j2gtcGOVc5MLk0pBoUUj8oAUA1jmTJbOq8FMCnhTg527kPKxo7eJgPdxSu9SzcsLB2zCWKXHlEZY9w2l55TBZC4wUuu7xMPCCGCKwxCDbnvpQFYvfkYcSCqA4Py32LsnP6Xpu4yZ33mkb7adrGgIyAmOPlhGpXUIwGd9PxeyFPsdlBSejVRYuUj/YF3H+43Hnh+8wpDCDLWNd8uPhhtC/AYndwj07nEOUIhl2Xvp9G6hQeIXb7Un0yhS4GIpch0y8PkUN8NlGvdWFMVHikAELCU0VVFoS1yslfThIEeMf3GKD/1efCkDHeXvcGuK6b83SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llAmFqv+zITtr/IlmEIqK08Ht3qqgnC3nv3J1HPGUvg=;
 b=IL33XmsHt4RoZvA150YLgJ5qoHbog5ZYEG1pTkCA6VMwlOOzIyU+CaSC0sLetXbRc6xxEGmegT6wVuC2GsFbsA034fnvjhmSwvXSKikd5syP7WRvHxAT64vsyjoj+0KSvj2Ub50SUAzCspPDjA+ZQzL13cKYlZPNAnqwYYbRW0df4PqddmOxHyGpSM2gMgREetckjVEEegdSRi/ajPFRTfQfFS2vcfrS2cypvyoNpOCkrJieDmowMXIl3wdFZQ2GCdx3QV9VBD2jbP2DFJZwxVQWiZ8qDZXewbEytK+M1PhG/H23TtRlDymbfF4zmstv7fozSsZk7YMk0IqVJDJFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Sun, 18 Sep
 2022 11:04:53 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::a2a0:a5a6:cf4a:e454]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::a2a0:a5a6:cf4a:e454%6]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 11:04:53 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: fix repeated words in comments
Thread-Topic: [PATCH] mei: fix repeated words in comments
Thread-Index: AQHYy0YhhBEJ4g+D70GCPQoJ0S4ala3lBj8Q
Date:   Sun, 18 Sep 2022 11:04:53 +0000
Message-ID: <MN2PR11MB4093E4A1203BBE50815F55E4E54A9@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20220918100431.28381-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220918100431.28381-1-yuanjilin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|DM6PR11MB4708:EE_
x-ms-office365-filtering-correlation-id: 9c356569-761a-4bc4-8286-08da99659d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2R6qoO4X+pu+51+VhVDHR0M6a6EmisFVZxgZphUMogoZ19UXeQxOrFHEYkBJtXwRR8VuzF/yXp3HZrJimr519eO2Zx2Gji60S7VAmlWBpmAqXsB1P9v/BLIr5uATBPzEtmsQ8oC7RHAFGT+yHbM7yf1LYRhzNjFphLhQO1MhWwUqsbLl8A+rs5dprwjB4feaNtIFJk2+sCtaHVx+2Rlo2X63uw8J5Db4EDCsbMnDwMMw6afFS9VQ/8v1Bh61POxoMIh7iP9NXpMhh1m/E0XvcK2dsIoHGUkMq1f+tVBw1QeQD6IPxe3jhYrUkbVYsCj8hZjdzK9rvdDuu5Xjgu2KxmL7BDN0kv14DNxVupo7d9en0k6eT7IeqsR+vjlqakEPbx76siodvOH2TA+U86Vjia40HfaL+f+R0eJCjhpuF8Im+g9JH48nkFLE46rAduXNBM/gnJLtent6ZJH0/Ow37Mzl9Jm4Qkr2HOmc5djALn1mK7kWjXC9zkRU1zD552NeQIOno4OfFSjQQ0MVJ9PI12qVl7nc5HMzNVAc6lzFouaNSli778m3es3cvKrrABiyZTw+77yhk8a7yHBoGfGqvzXY5x9i2ZxwEiZrPXEcTvIJ9X1MvZZQRFSFqRI8KWnu3Nx06HYXpjCJWgEZlomt/eNPDjhgBiOtLkJ3erHTXu9y50yLdlEDbwRcCqSBq7UIehrNN2RspXMzhn5MpRj6/MsoKVe48zrHSe5k8jaiVSgPVMtSdf6n3OD6om7UZvGvb9SpDdqEqSVpYFSEf278PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(9686003)(38100700002)(26005)(122000001)(82960400001)(55016003)(6506007)(33656002)(8676002)(76116006)(4326008)(64756008)(2906002)(4744005)(38070700005)(41300700001)(7696005)(86362001)(186003)(478600001)(5660300002)(71200400001)(8936002)(110136005)(316002)(66446008)(66556008)(66476007)(66946007)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lYYDZah3u1fu4bT04nwdzW0CvqsKcHvBKZU8pw8UouakwCz8z11/xHUtrNPV?=
 =?us-ascii?Q?DtKV2bMhDTCY1ryWwJL3FDcUv2nGXcEJbmxEPLJFZRyzfO1U3UF3Av5X0uQh?=
 =?us-ascii?Q?9zWFDaS7skz7+SqLPUuG3MB+KdUG3y8GWdYDkF9LOic54eyRsT8ZW8LZ3eXc?=
 =?us-ascii?Q?kU2kz1zDhQaLNyDjmnWBITeWfDl9Z0jDh4QkKYl+EULWnLC2hGhjBitngaVj?=
 =?us-ascii?Q?BBxt62vVaYkYNOsZ8jeGOxsTUdyo2mTOsD1fKjhrN+uxhwTyp09BNrZcU4O5?=
 =?us-ascii?Q?BVLHpV+DZBCnbogC4HHjLja5MNpE8WvIfPXPiuvsJOWBbuW6+LeVCR2bGEl0?=
 =?us-ascii?Q?pq72i6mrBaLbhyQsQWIDqRW15L7EdghaiWsGmntnzSLboyT2p0Yb2XjL96s5?=
 =?us-ascii?Q?wWmGtAwXs/At2R5HuKSGVyt2q39oS0gMngQhkJ3V10Z7uzduBA9DI70Wkc4e?=
 =?us-ascii?Q?xOV2SDi9+EG2u1DR38Vv483p5x3E8m1QtfmK9dZHOFA7czd7tgh1Ci7DhAxI?=
 =?us-ascii?Q?7LWkPTvsrc6r68EBSNeqcdhU1CiOVbW/tVoIFXrKPXnghSCNoj5ZZNzlGw/J?=
 =?us-ascii?Q?SfArle9qDaw4VqF/bTGiPfKDNu4STZsReZjziXDhKqIrvLE+FDIoCR7xdKAE?=
 =?us-ascii?Q?ymX4Hw4KxvnS9V3DJ9pZuBSphRO8dC2LTYO2XNEAqkwnC2uGvpbdcRUT/LsV?=
 =?us-ascii?Q?blnRMHhQYGsjQ+PAdQW/pQKkbVhfwjmxlzaqNihvwd0notN9F0DRmEJKqqlJ?=
 =?us-ascii?Q?PmdRXS90hZiAsDtxI8zo3AzBgN0OVAureA1WeKSpwppb53Bz4BeQmL+w18nq?=
 =?us-ascii?Q?tZZ6n9B1ZlCgwLe6mYHbic5geBgAQRSjocTiixze3LKy/l9VU1Pay0kWTM4E?=
 =?us-ascii?Q?pIn9NlUfw6LBhQCqhXkpjLBgLq40+lWjhIekm9Du29frlmee20tLW/nek2IZ?=
 =?us-ascii?Q?7q8i4/7CJWAOjlGJ+/nz1dRRA3LcPumVsbXZRCoIshwxugzV8IKEIAMwqQka?=
 =?us-ascii?Q?yvm+1u01bTWezd6If2oN9oTg9CNTvKg+NQrZPk+dUDZ5RfsSNCgr9CMt36iP?=
 =?us-ascii?Q?K9OzUrHTtss/mZaT2giJCiIqVymcEij/lRnZL8cAYlfLqnIrvDiKLlaDqWYG?=
 =?us-ascii?Q?Aug8FwgQIPzOGbRKe8d+fpqodqQe24nZ2mNAxEsEzSVgd52TivJGvVyTTlbF?=
 =?us-ascii?Q?PYqHIA0upYq7gVMGG/XV3hi9GarA47u/3u6fzKR6ROsIUULxlSF1LwdnLtIU?=
 =?us-ascii?Q?9trYnW9f6PP8JWmW4URlo2C9FENnH30WhawjX7sR7OvC+Wsnkq9OL4qxTClg?=
 =?us-ascii?Q?YE/NQddKhHEexYZHA4xgEcxwzRIsp5jFBn/HymFMxuN+rK0jRIVPWUPjTEG5?=
 =?us-ascii?Q?kYwobuyHiqRG8mE9egADXxvct6ovECqIxWHK5DbD/pkx/kK6GcbP7kMPq2qU?=
 =?us-ascii?Q?FDCQA4Q2hU9QVHUFP91tgsmpvUF/MZW5KKRQ7MIEcHLMRKeseuRTsvSLwgcb?=
 =?us-ascii?Q?CjiuNZy4kBrGUZwSvLGk9yC8WGxViSVvM2rte2Z/UY5MRAWNjnytkUtHnkIS?=
 =?us-ascii?Q?LGNqu9qjVSHK59VGv4jgsdWdw/5xwFoLRwUMYxN9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c356569-761a-4bc4-8286-08da99659d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2022 11:04:53.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wlrovQy9DyKoKXtZ+lAKf0QDuy8YumJVVCcd5Ax2/y3/Qj2ISF6VzQIIm758yDDCisLMSVIHu78IgHsOUFb+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Delete the redundant word 'from'.
>=20
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>

> ---
>  drivers/misc/mei/hw-txe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c index
> 00652c137cc7..1f72bbd5ee51 100644
> --- a/drivers/misc/mei/hw-txe.c
> +++ b/drivers/misc/mei/hw-txe.c
> @@ -176,7 +176,7 @@ static bool mei_txe_aliveness_set(struct mei_device
> *dev, u32 req)
>   * @dev: the device structure
>   *
>   * Extract HICR_HOST_ALIVENESS_RESP_ACK bit from
> - * from HICR_HOST_ALIVENESS_REQ register value
> + * HICR_HOST_ALIVENESS_REQ register value
>   *
>   * Return: SICR_HOST_ALIVENESS_REQ_REQUESTED bit value
>   */
> --
> 2.36.1

