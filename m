Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369C56E61A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDRM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjDRMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:25:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C00B461;
        Tue, 18 Apr 2023 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681820743; x=1713356743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sUqtlLT1NA53vpvEeaxtu96uJ5O+n4JwZvwRupoZBOQ=;
  b=GEZL0ld6hf9Z8VtJ0wXo54qSOz7L/yblMNytzND+pRgWll1WcIfgPIfd
   JiyqM1ntcm6vg83bhs5xOuBooq2rf0vSCtTxju0Cg3+N23MJIgPy8LUxP
   d3o0VdrxwCedWouLQ5xfw2M05ES0gT47vqsspimoQeHNy3wdl7SywPnmP
   kNto4PFbr4Dizyjgrmhfflu8D3b7iV/wGdBknUKg58qzTzlpNiYgRR5ap
   O9LbUbiGwYESW9LyTkfnq9BG4vTBfM5DgWf0Z7Qbpv1/FA2QV2OKxvXBK
   GuNLF9r3MQuHsgre2uHxrsawMEAyCtzGWay6M3upQXT7pz6syiu0X6rTI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="431439239"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="431439239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 05:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="834868324"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="834868324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2023 05:25:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 05:25:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 05:25:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 05:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q20myagunNyayERDYR4/RHnluKzJMwXy9fUhLXFAwQxpwpt4iv+FCFo3hJSSPMxU3bPlF13iw9PEwZlBD8cHf5q57+eQnXPZ/+uYrqEIl4ad5d6NOnNR4LRgxGqw4UJfVfNR/btxoH1QkuVp0QmxmHaprtReCTZnnBDa4yRP04nnvVivRpZHeM7v6VvcKebdvRb28ILW4FU3Wdnv6mupVIMQ5R1IxcaQ+I7U5xNIJeg/UYG5vS0Wb1GxrY4NyRwY32jrSxIWWLBSIJ6ifpPzIk/wAujHWn3VkboE7kEgRlAjtiv3rHMYz9pXu9RU/21wKMxrFBzNbbfjyLYqc667rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVS52/mId/OQLz8jmBe45lhPmP6TvvuoP4naHhGXMbI=;
 b=CA+F0D2Nprhw7j1Tc0rYhOz5/cjT6XanESQfFe2BaKes9QI+UkFEDPh7ZolrkLtAPaD0MEsG54pwSH2BkeEeT5oJYbGRL4trG/ZzkaFB4EHH2DZE/FQDTV9Vq0x0xUHDVIDjK8pATFLEuz0GSU62Brm7TH+CR31IrITrxZpd27ephcZAS5h7D+G+lsJxlD7bf6NSwrzE23FjRQMa3CLel7MtHa8shRX6tULEMKQ9ccgKBG9qf0d01qpDVLMpVP34HdMwLyACCBo5dzT2yrhJnzZyw4aGf3BCiUXz+oDd5Yt18XC+SKbRWit7/gxF008L0W9gDYVM24AJgKVQ0WSLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB5526.namprd11.prod.outlook.com (2603:10b6:208:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 12:25:06 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::bafe:8b7e:75b:b337]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::bafe:8b7e:75b:b337%5]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 12:25:05 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu/kvfree: Make drain_page_cache() call return directly
 if cache is disabled
Thread-Topic: [PATCH] rcu/kvfree: Make drain_page_cache() call return directly
 if cache is disabled
Thread-Index: AQHZccPEWdRM6G1nJ0qeE9btSFp9uq8w+IQAgAAFIzA=
Date:   Tue, 18 Apr 2023 12:25:05 +0000
Message-ID: <PH0PR11MB5880F84715F490999F790A62DA9D9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230418070259.1353785-1-qiang1.zhang@intel.com>
 <ZD6HdrXAueycm/bX@pc636>
In-Reply-To: <ZD6HdrXAueycm/bX@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL1PR11MB5526:EE_
x-ms-office365-filtering-correlation-id: 6817c3e8-3dff-47dc-aaf9-08db4007f0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzuXwVSWgyU3w0dK/1NZ5so1gs8f40RKUKSHKlK3XRSCcgapSy8Ac8gvxFGu8ol2bk8mINHy3YBkQKHUsa5QwvaIJo2eB9PAxzE8eW8onTFyjKMrefC2PeEGofEIo7BGGD0madPAYk1p5g94LRX9SPgYWxA7+dRyM30WKI5b+JemABtluBDcxNTaP4wSu4hDixfrMsdx20RMYPo1dga7PxrAjjE/kjqbNc8GRR1H7WNKzC2l9Np6LQudOgzesX6utRLYxebvRhs+wxwIaPfEAOzBdcA4WQNvHqTI0GkwAM6Xoh3/5CzAX98PvKqNOl6LRvLtEnXgltpPM7Kdj04wV+mwno+jpySanhszSKOPIG/C8R1xLyBkoEAdgAvTM2ctSR3+Qri5GUrWADUL+307+i8xngarsEtzYpFIBcgBrSRb58rg/hsdew8w1UZevNJdMveL24+cHPjaKRUhqxIHR+pdYqI8h2BKVRdK4pZueS2WzFWFE+D8vejVjTk3K5c3xuWJzt0gATKunWQWCU3Kxh6NuBPPuReYkBpZpW37F0d9I2XM3FkJXnxUPoIwlSguIbtl9E8AgJPyTiyBsU3bqRGF25hd4OErSLGHzL44bfERgvB0R8tbWBt3DwdDU5iY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(38100700002)(8936002)(8676002)(122000001)(38070700005)(5660300002)(2906002)(4744005)(33656002)(86362001)(52536014)(55016003)(478600001)(7696005)(71200400001)(54906003)(186003)(9686003)(66946007)(6506007)(76116006)(66476007)(66446008)(26005)(41300700001)(82960400001)(316002)(83380400001)(6916009)(4326008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HF20HouaQ8AkxJQQ0yZm57f5BFAqwI3nHB0hZjRYICSn9IbyyLGxaRHgCX1q?=
 =?us-ascii?Q?0htYGLems/JN2IFtN6XiqrRM509knRopGo+gi/XEFtIemnk/R+QUCUnf+JHw?=
 =?us-ascii?Q?YuBnwDIISCjvIicHspWWXoiNFPWhGJS0ROtdamlbIctgk3vJaI82QqdyeIry?=
 =?us-ascii?Q?Vvdw5YBcjsCG0JT3tsF/fiL8vL2nZO6BQZkxXaqppLnGDpQfKWAnJUWN9M+9?=
 =?us-ascii?Q?Ln4+gSm1/y7ezBBkT8f2RSLuhRd7d+2GC6HMCpos/nGTrJncQ/n/EKuOhyWl?=
 =?us-ascii?Q?DzFe9lEPCLR6LIGZ2lqQwYhDSub+nTdm7WE8o2evqJ3+xIVACKgeaUgaccLu?=
 =?us-ascii?Q?zopU0pO+8aMcgKuob71ngB27DFogag3lH15qmOB1OkAgs8KXD85jeTSnYuGY?=
 =?us-ascii?Q?lWPT18b+OiXIrIdQFP6l1bmbDeZcxTwHR4J1mAcQySzTQKKBdJwuoqMMRx0P?=
 =?us-ascii?Q?bAyaCa6cwVsnXb6eyadVUch6QaGCbrhnLPGqt/8RB58Ifqb52EoBd6q6IQ5d?=
 =?us-ascii?Q?tkO50Mko547aTN0R+wBYzGCDRgd3bamOyGdUENx8kJaHoq93tm+PIlSjNpPM?=
 =?us-ascii?Q?DEPw2x9RusfQlND3+nUjyxzvBBJxcZ8+1pnE2NS/ZiWgMRYn+MwLS8PcosO9?=
 =?us-ascii?Q?SOnLxCMnnAF+zV9wcvysm0QdzALUyV8h+SCzKa95sB3KG9O7QXVYNFCOj4Cv?=
 =?us-ascii?Q?3NRC2iAkxtdinhy9Cc4EjRGId6EMytOFOoshb3AQSCbH5UWZqoSATFZctqYj?=
 =?us-ascii?Q?YhPfLnf+Umh74CL0sjizcNhToskd5lLSXAWPekWsv1TELlOLQ9R7s+i3h9LE?=
 =?us-ascii?Q?7wj3CLkMJlBzc50MEgWO6U1VesTBqmZJ3as5SuK11V4DfgMr2jxIEFOi2SIj?=
 =?us-ascii?Q?nMi73u8BnTohBvwlm5gxzUiKfv9sdqFn8k7OuqOXPc7gErCmxWmsbp0wSL4x?=
 =?us-ascii?Q?ccXn/DyLPy4jfuZ2r+g9/uMwZ/beZQHtbpPp3cYRs6tFs3hcW0t9nMqsQ1MP?=
 =?us-ascii?Q?RKKkjiZJmcfy6e9Fc7VNjpjPNyMJMh2CKzQ0zn/5u2UnUntQd6Mk0gHdpvNc?=
 =?us-ascii?Q?3cddwSWLLwwN3r1ZJJTUWwQwgC3vJYmVNR+MiVp7iXcwgi5txH/0zbxWP70D?=
 =?us-ascii?Q?Oq36goLf7yYZCrhD7psez9prNApJUEKwregOunzGHSz45eI5C2NtyGN2uAd8?=
 =?us-ascii?Q?KLOLibv9WvoZcogzG8rMBqsxPKeHoyCcG/W3xbgvvqRZIA3cyZFnBfhJv+tJ?=
 =?us-ascii?Q?7M8fZmXP7XBOVLVNyS0NPeOHLoyuuZZ9qUZrMqZpkdqMSZyegPcCPdKjOSFA?=
 =?us-ascii?Q?whZ9SjxvVEaH0+RbSMOIteFxZ5YeVTWCabovSeZo8Bn4tcGxGZPxulsCHc6S?=
 =?us-ascii?Q?j9Vv3/88Cl/4R4R5WIzdteNH+PnoxchwB+2ek2YVVt8qgThevAGYjq/cQcxb?=
 =?us-ascii?Q?SxW4oG67S9DAC8eRzPYeNBScC5xWz8AKrR6derzbsKbJktRAM9TUeiILuhqe?=
 =?us-ascii?Q?TzyZvSDYtaJisGhS/iaja7tV4x0mwfv5lxRn8wKlxHVs0h+QFkcIVhzhXuqj?=
 =?us-ascii?Q?Dme9npdwlzTrg5Gs9zYqD0IajcMV5Uc6LUVTU6DJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6817c3e8-3dff-47dc-aaf9-08db4007f0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 12:25:05.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U764KsqYz8t4l6aMWSoxUrPHEQjxlnqOyo3xkREYr9dAH7HBNORdUO10Kw8RxyRQm+ROOwb4cbxvkLT+XPnbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5526
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

> If the rcu_min_cached_objs is set to zero at boot params, the
> krcp->page_cache_work will not be triggered to fill page cache,
> and the put_cached_bnode() also does not fill page cache, this
> also means the krcp->bkvcache is always empty, so not need to
> acquire unnecessary krcp->lock to get page from krcp->bkvcache,
> this commit therefore make drain_page_cache() return directly if
> the rcu_min_cached_objs is zero.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c8ba2be026fa..ce995fc1c644 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2924,6 +2924,9 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
>  	struct llist_node *page_list, *pos, *n;
>  	int freed =3D 0;
> =20
> +	if (rcu_min_cached_objs)
> +		return 0;
> +
>
>Should we check for zero?
>

I am so sorry,  It's my mistake. I will resend.

Thanks
Zqiang

>
>--
>Uladzislau Rezki
