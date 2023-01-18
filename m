Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8A671575
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjARHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjARHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E066CDE;
        Tue, 17 Jan 2023 23:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674026450; x=1705562450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XD0eq6cEblanKkVtZenyEUf/+L5JR1m9vPBZ3ib13UU=;
  b=UORiU6LviGtbIX717t2hvvgwgEMAHmuws7Rk3d7YwfR1LbnWjaOgJvLm
   RTcFCAYMFqcAslhXMbmG/9oBTVsoezyYaUwLnv3kRCoIorbqo5u6Iypmf
   cFXU1HP1g57ZPx7EziEo+rbvzuSf6JxcCxnPZTdaXKthixXJe4Jb8sU6W
   cIcBUj4I21sXpxcH+PeAqOakRsfjW2+InHK5cxef9yL/fFdf25VJXXtS9
   rXz4NyvCdltCS+wEAOPjpf5jQfDk1YocrtvJmLjD+flZmO/LT5db14gXA
   VTWwCc2/bwNDxFbFau4dZRwzMmmhpCSTNGiC23/j+ZILuxudyX6byexUs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="323607752"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="323607752"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 23:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="728073628"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="728073628"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2023 23:20:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 23:20:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 23:20:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 23:20:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSCU8tKg9lHEFTL4IZ0c5+Ktg73CVWADF8Ie8PU9xQeLZtyKx3zgvYf1txzKI17f1uRHvyqpnAzJP0Wwq90ugZLvTzronof0XZNNBflIixiX4hoIvfvkUc7E/IzNrc7nm7m3l4xC7WlUmUTpDDVOPRxmjv+QXKr59Ap1Ku9qodSN/IHIhR1cjN4qe608BLC07Ckjxp9fYWV+vxTZkvpG76l78EtdwKrSAIEEzD1U8bsnYumVEOvzlkjJQ+DtJgBIXzxhmTUOs1n0/NtB7A1h/doHwEwyE7MAWaPGLLonqMt/lmYMasuJZFNJplXlK7k5purAdc0/w9PQbHSfLcbtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb7abpdhejOhUL17FfpWmSS4XnKNgkuYFXUufq22bK4=;
 b=iS5mbm94LLOEIXO9OLlGUYZU0OOnDFnRylu+rtbBrRcgXoP7Ov0NbwLlUezTMs+XNeV37cgYhQCq9cTa1qAXr5bJAYnZuJpiZsWYBjSBDbdwyfLNMs8tpYGA2JfqtE0/8526jv8lz/OdtIxmdOr0HqkF0Pusq6686tHxIHG14C++w8RFqYNwL7ntsWmDOTzi1yFARhlQ1rdcL7SLtbbOmvWaRUXUQCUUdqmKtd8ys66n7NXZogF8mbnIb2zYNdoQqh5YlbUOgShUls/4pdjTL/lbnapfS3sz4MKKIbycTPrmsC6XNP/jR1tYbIW1U7b+pKnRwL6enQKtNoEQ1rElDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:20:46 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 07:20:46 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Topic: [PATCH v2] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Index: AQHZKkbpBc99toz8qk+05nvOIQVTQ66ipEaAgAEhpAA=
Date:   Wed, 18 Jan 2023 07:20:45 +0000
Message-ID: <PH0PR11MB5880C1B54DC57E31B6225147DAC79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230117074443.1982347-1-qiang1.zhang@intel.com>
 <Y8aql+vHNcdth0T1@lothringen>
In-Reply-To: <Y8aql+vHNcdth0T1@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA1PR11MB7174:EE_
x-ms-office365-filtering-correlation-id: da6b6547-7824-4641-7111-08daf9248420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojaKZrEHEu6bBHicT4oodl2p7tU6Bq5SNi2N0htNoK3cJGL8wF0nM5B5OSR+hKuRJlVHCbmEXpr8fGNQnuxj/aZB3V0WsJqQdarQ5tjLinKdiipDOyBNkrhVKm1H6clsEyq2tQR+bwbq3DWYA4MSHQnxOJKybHQe8VcXcJmudwi3k0DiVCrTzbA12VCy2bdOdPUFKpy/JAMuTNrlIfhPbuB1YTu10tNsMHuWl8E/9H6m7L5RWWrXGaV9415et9SXA96YeZuDVdo8AmhFmoK9QRxIam/ANgbqdB4EnQ99wsBgUe201zXIUGPz/AW7r7ZeltzBxk8NfH6ZM9bJp4g2NPDerW6ZhkJiFRewTvNJ8Ci4Snc13Ujw3h7nLMQfWkmGn3tw91ATuLbfkRomx58LH9Z0TGvGI57wnd6ikt2xUWfQLjSgjdYFzci3v4o5Gr+rIs7jT413Lukdpic4CFsa7dwpMUfMxWtE0m9818gXpVGwzKqvzbwIRc7D0YMtmMdKngUNpmyjtD8uMki5n7xjdOYUI8zM8E+QH3SiC3/TGfdTyd3HuLDtJsLjQilzmGqSC/MSSXjdbb1TbE6acm6E813yzLh5gwYcHmeUUavBh/qJwP+04XpANek9cuwGbnxDScBOsOLa3KVhLEuGGpwHLJEF0Cw/zCYxqabcsnnKtPHuSOheQeVJj3meeX5DQ+A83BvnXXYWIGheJbOVEnUYTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(2906002)(82960400001)(122000001)(38100700002)(66899015)(66574015)(33656002)(55016003)(316002)(71200400001)(54906003)(86362001)(38070700005)(7696005)(5660300002)(66556008)(6916009)(8936002)(8676002)(4326008)(64756008)(41300700001)(66476007)(66946007)(66446008)(76116006)(52536014)(83380400001)(186003)(9686003)(6506007)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gx+TbRJgAOPBrBbJA2AAIt7M6yBLoFhiuqqkxk69R9a/J7lSQOWqAGAnH5pI?=
 =?us-ascii?Q?ASyr6wjYd2E/QOIvvSUwyLuCqy44RrGreLU5ZNTpcrmn38MLaKcYtgLEHP44?=
 =?us-ascii?Q?UQ5pm5qoTuFTPO8W80iZcbCre8DtWuJiW3TLhK2FnwF6zYxRWorKYTYXBU56?=
 =?us-ascii?Q?vaaVo7b5rVnqnIOKRs7EPF4kXg091+PHAkYO9tjkyi3EMQlB0w/5zHjXUnWb?=
 =?us-ascii?Q?p9gOLv2YBNj6yBZv7mcnnD9CZTtJHZSYXjUal1FJm+CRe2BsPOUDTzhLzwgU?=
 =?us-ascii?Q?+ARUm+WLE21qd5liFaQnTALZ2YWSlQLuYTo4DzN9h/7tapKQzVLJqIZoln56?=
 =?us-ascii?Q?+OHyWlCVf/IP1229Xsfns5+IJozpKJ8E6IccR8ix7xnKPCR5zbIdqi/aZxnO?=
 =?us-ascii?Q?QzIVyUsDxCt1RW1VyEWF3z4llQpqk/P1ik+WAnf7Pco3gFQeme/gM954rZ0c?=
 =?us-ascii?Q?6iiv5HDLiyOTBwuXHx6nOfhup6gBacMItpEpEu9xodVkDeBm3C9L6oFZ7WTu?=
 =?us-ascii?Q?nkOsrlI6PcjTI++55ZOhTe96aREhpc/cHsJTwx7DWnjaq7bDIvlHM3ItcSzz?=
 =?us-ascii?Q?fIrKe9pwdWWqUn8Hcz3Mmg/PRVhbXeI8S/W8gYuj+aA6Wyj3hyNpJ9zGzh3t?=
 =?us-ascii?Q?Mb428H5CfTWanDU8pozfw/4EQ0GxpI8Mn2sFljA2BIVNKKMMgHbC9QEtuk8K?=
 =?us-ascii?Q?DbKP3GG8EZSqfROWP58e6jdmacrNbEm8VIAhKY46MJ8akdIKDYfnzDr2Md27?=
 =?us-ascii?Q?+zN+8ZYpxtrHS7jjqLOPzAOk8P1eAPTrWRYlykJAEl8pEqDdnzW1Kx7UPtpM?=
 =?us-ascii?Q?YfmiN6gH2i8MRclYIo4DDUjLIo24G0QIvsK9a1Tirf4I6n07PpPnChF6hPf1?=
 =?us-ascii?Q?h7Pb0EEze69YI9rF39EFu+PX/pRwQj4Gxl8IiFegvj5aCq66AKOeffB1piEK?=
 =?us-ascii?Q?N3wcgpM1Lj3JAVTB7NyBc/eYPgsm63QW2SoMOkdJtMOLrakQWQV0EHeLXIDa?=
 =?us-ascii?Q?+cHUJicbqSEVLh+bI8NbbHEJ3Wntwe0A9gqoPLBtFN0srjrUMalyG6W/AY/v?=
 =?us-ascii?Q?Sb92+KE/iQepwjxPfmR2pIqZzQrtkqqJoRic8bOdB1E/N79TZxgPjzp0lONa?=
 =?us-ascii?Q?1Obi7raDj0lBJPwALix+8GbBuOEyBoI+6bIwGS0rL8euG3Px+oCijdGlMj/L?=
 =?us-ascii?Q?Y9nLQJw/67VeaxoswLLmwgQTiQqThAlFVv622cv+s3wuW1NuZ7+YxNn3NBSx?=
 =?us-ascii?Q?N0bDEw6s4P3pmUVaWX2TVq7oYSj3ULp8FXS5knL2UG/Qa5WYglMnDNFizcn4?=
 =?us-ascii?Q?XAHmjFac8JDc543FUjZYoC3d6Rwhm0+LZKPhxL1AMuYptqNyp3yBXr1sMCIK?=
 =?us-ascii?Q?JWHo2gZLcCxOK/O1lNWuY2pCPnDnR3a0JMhBC+sdpW7KI8SCubN/kap4S/Uk?=
 =?us-ascii?Q?IweaGAahFozqFZGgN3vKlTFsPLmRzOB3qiCSHDE23G6cryLa9jhAcMzq/WS3?=
 =?us-ascii?Q?9MMZqumBMA5Qg75IJJK5P3Oozqa709Jt39n75eopAHUztwo6aHdBtlqyUIpZ?=
 =?us-ascii?Q?AXBl/ArxPMZ9jcMkYt7yI8NYHeeEz5It6PuT1AvC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6b6547-7824-4641-7111-08daf9248420
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 07:20:45.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmvrOZJNksS9kbGPjCQ/cPkx3wT+0R1PemRasa23Vk7vTluaC/Jc7/SwAxixR/q2xDB1FpvlmDrHmUuhQ1eCDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:44:43PM +0800, Zqiang wrote:
> When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> grpmask has not been cleared from the corresponding rcu_node structure's
> ->qsmask, after that will clear and report quiescent state, but in this
> time, this also means that current grace period is not end, the current
> grace period is ongoing, because the rcu_gp_in_progress() currently retur=
n
> true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> to return true.
>=20
> This commit therefore remove impossible rcu_gp_kthread_wake() calling.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b2c204529478..c78d48482583 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	bool needwake =3D false;
>  	bool needacc =3D false;
>  	struct rcu_node *rnp;
> =20
> @@ -1988,7 +1987,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		 * NOCB kthreads have their own way to deal with that...
>  		 */
>  		if (!rcu_rdp_is_offloaded(rdp)) {
> -			needwake =3D rcu_accelerate_cbs(rnp, rdp);
> +			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
>
>Please also add a comment explaining why we don't expect to have
>to wake up the GP kthread.

Thanks Frederic, I will add comment next version.

>
>Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
>Thanks!
>

>  		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
>  			/*
>  			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> @@ -2000,8 +1999,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  		rcu_disable_urgency_upon_qs(rdp);
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>  		/* ^^^ Released rnp->lock */
> -		if (needwake)
> -			rcu_gp_kthread_wake();
> =20
>  		if (needacc) {
>  			rcu_nocb_lock_irqsave(rdp, flags);
> --=20
> 2.25.1
>=20
