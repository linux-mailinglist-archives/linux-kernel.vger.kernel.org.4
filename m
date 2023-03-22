Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6746C48FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCVLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCVLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:21:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064859E64;
        Wed, 22 Mar 2023 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679484101; x=1711020101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5CZEp6gv+IxNiKfjYj9X0AOiDspjP0RZi+nF9KAZV3w=;
  b=AxUcPkD6I7AZILiAg+SlROHfX9cXie22MoSTgn8WE4BOMeZ/+dv84UA9
   DjRcBJl7SnFCOrO5kTvfx43squKhucPuMICR/Aeksr0qRYjAdBtQMQs5X
   DQ7U7r4Nd8v57KwrRORa3FhoH4LDfGokK3/0k7wVV3Kv3tGy2060/LEtJ
   uVl5lDjQa0xPbSZ1i8EY27V1siLrJqmfmIGpkNvM205JlNSXhXSGDQp8r
   b2QV7ciSdfw7OieKEO5Rg+WHydt3UlqiCMx09ZHmio69Wc/Sd36qHLekL
   HzvW+UliDvOVC8JUXJ336QAOnOJnQqpz6ad0YpET4KPDBJtASzXzh/WDY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319578656"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="319578656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792512380"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="792512380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 04:21:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 04:21:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 04:21:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 04:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQCXnKGsLHSNiRiLPFazV0e36rgzrmQUvJaKUcP345bJS6F8h56vDeuPLeqaZsiz+YfhvLkodnSRIXQ3903SNzP0gAFhOpEFS5dgrnYrrGCx4dsApw2eABXFJmhjn2VP3bty+n6gPgTAI1GAAmcViEfiVZfMhl6RraKgbIaoQvVi81iaaL/4NRLZl2rbVfBLX8Y2fSOt/u2rF9DIn9ZtEkqccoAO+vmomwFdC78jlRxp/eh/qqFdX2UUq93SmTcz/zOB6IgU7VuE+2T8AIrv5iELCzmiIIH0OcZAt8Yax7M7XYwNyjtXPBgrl2kij/D8BbDZL+5fVitCUb/F4V+AZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8ZwyDW3hpmx5fU1GFKJZTB+iezdKBcsB85FjcNrejs=;
 b=Pa2aMHCKwBOYsYlavKJYEh1KuInf/5aLUUJKTEhNuU51BxtCSi5PuZXqTAU7VbGHRPn1yqPgWItPJKH1Ud6K9ioz1ohOI50QSuY63udbwnhRbgNE8GChj/hq5KKLMlFZG7ab+HPZzSb9ZJskxjiqolG8ZOMIrTwf90OHIMQAixzwisnxAleNO7CaEDXwH899+pdwsR/UY+KEfh4Ec2ANFk2e3brYzN09xbbFMfDit//JUkQxK/3vqp+nT+RBvP6XqL+3IWel/C4iEh2+gArGnvABhdaOwZWePBEWb+mwx4oZMYisVW5C1T3GjbIKREY3caUELUKxIsNeEP0xKceyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17)
 by SN7PR11MB7437.namprd11.prod.outlook.com (2603:10b6:806:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 11:21:33 +0000
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53]) by SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 11:21:33 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cgEn1/2PZAki4vZrvu1Ahi68FQZQwgAAWuoCAAKr2EIAAWieAgABHkEA=
Date:   Wed, 22 Mar 2023 11:21:32 +0000
Message-ID: <SJ1PR11MB6179262CF19173D094A38EDF89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <SJ1PR11MB61795652651F41A8F94B1E9D89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
 <ZBqlMxo4/vKYZ08K@pc638.lan>
In-Reply-To: <ZBqlMxo4/vKYZ08K@pc638.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6179:EE_|SN7PR11MB7437:EE_
x-ms-office365-filtering-correlation-id: 6a5f2fb6-242a-45b7-3dce-08db2ac796f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQVlXYiQgMBsE7fbvvl7C+2sWBjyqo9SyekhOLBr0I4t8wpt1KsQwwoB14jAmPqu/gjOnq9SsXeiqnvsoa2QnKEoTu25VwlyZU37UzmSxwNGYRsmwq7ivKdMVJdvocJXUK1S+SiLt4j96AbLAAXXLvP9DEBF8jsvCLCEsnNKz3nDwKh0Y6VzR5WH8qOQgfTu05W+ZHUv6T9mnOKB+WnOm8wggC9jeu+vhsaNvRp6Ob5ZitCbJjq6N514hWhyPpe5Yj+kcaK9XSauqRsnepXSB7BfBavthFgwv1yqudt18r6IGVBT2/i5nOoIP0aimpabnzCUWszw/pqLJ4G1rYFdVHt1szCA3uwPbfqMfH1GzLHfABEt24Yj8SiCRfWkX/S0uCTAz9LcnIP2L4VFaaVIzmgAkSjt4xazgwqc+SvozlXBtcMJlQjmjK7PM/zpPF559ej8K/01tkFLCPjeIWwbseDcEblJK42Cl0Cfe3IbT6uD/ZZwwbXx+00aUq7cCz4MaD7b7bKKABIvGxgQJoL6W1EY+gVAMxEUrLiHSKMUkJR2UIz0xrnChE9mMZDtK9fukhzuwjHk0r9qNkQNRCan1Oiu2OvhFBFRoNdo/xm6qQzOj1FGmk6r7aurXbcUxeqL7bxW8PiWqrzqTrUO/zcB8D1Vff4DyEBG1kshH+UCXCBtUwb3b3NjnqAkGW3uFi/P4IZ3FnSCNBSG8VoNZE5kEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199018)(53546011)(38100700002)(33656002)(83380400001)(71200400001)(8676002)(122000001)(30864003)(55016003)(54906003)(7416002)(5660300002)(316002)(66946007)(41300700001)(76116006)(4326008)(66556008)(66476007)(8936002)(6916009)(66446008)(64756008)(478600001)(52536014)(2906002)(7696005)(86362001)(82960400001)(6506007)(26005)(9686003)(186003)(38070700005)(966005)(559001)(579004)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aO/1Z13KFgCFOmYkyTyFKeRRg54AUvz2+uOi2CpgFN1MByu2/ja15IwZsXyd?=
 =?us-ascii?Q?KAFIXkHV7EUeZCIalYn3WXiSjKsbra2kg4LZXEPAT3UZwScO4i5RA116BjMu?=
 =?us-ascii?Q?ssLkhZ3AgANtWaZDjadvDQWUMIf0ZiojQhBy3cVsThlWGeJ+30mG17s8wHXS?=
 =?us-ascii?Q?RgLyRXDUhBBH1fVOemX4+E4jNkWnxrM9032se30Fo4ro4nSglXAnoE+rG8Ca?=
 =?us-ascii?Q?LVGhx1WyFZDvkAuB8oYfnmdi0N7DJQExlYKnqzabWOYt0ZE/IJN65i8f5Rum?=
 =?us-ascii?Q?KVUdx9lT0KWug57LXIs1f8ZQQ+WrI+JECs/90FUCe4TLQOg5KyEAUcRB4aFc?=
 =?us-ascii?Q?Bb6tCje9sma5i8EVFJg22lLx4eEz9ZZ9diaj436svh97SdYtSmMkp73wGdf7?=
 =?us-ascii?Q?OOA8d4M2D/ZumM6R9VyVGvrfQUHxP77uYjGQ3yO/JB6OkfYxC7Eb7WjEm1or?=
 =?us-ascii?Q?g7v1S/w16/P6jVRoz3F8oEmBGwfkvZzT/4kE8vUl48cnecPcYvhlcPasRDyd?=
 =?us-ascii?Q?TpLbGArXswROfd8r9rNslM2+Iy0G5Ql7pjW5GYstrpZJrs2xTWdVd5kkQJN8?=
 =?us-ascii?Q?sL0kQPXxhcDrtOMKRWIq0Ht/P5OusINyUBCPwJ9TSAqFNMgFmUBc8+JvV+ML?=
 =?us-ascii?Q?NLb8RFcvIHHcLssNrsyHROyFzMUIbZRapTO5ab2fKgeZUntScDwMnkTXvh72?=
 =?us-ascii?Q?bLrKEWeDPrAVT2Z3oO/lqlU1vUmWaVepv1Gy7qMB28WL9URcVrfEeOVU4fSn?=
 =?us-ascii?Q?Bu4pkyJsVm5NU9gXkRsUIrJvnztO3uF1G1CzuGvrze9WBFTi1fQXlQUKWfpB?=
 =?us-ascii?Q?SYAezA1aXDePggJUQQ63wOeGQ6aGnSbkWf5GlHjpTmoj51cIum6yV6k31GEN?=
 =?us-ascii?Q?uDPB+ozjBdeCoJQmIXM2UReyjV0jZJEmO6NVrEy82sawDtVNn9SEUkEhODcz?=
 =?us-ascii?Q?70BnYNxJKrYQ5T5UcmzwS/qGcvzMhsFf6hGWN8Us73eeZ1JPh6Jq6UP+P696?=
 =?us-ascii?Q?vuQDeaciZ2wRjAkMxqYGlnbSymbSivhGSGZylBPJQUQ29ejRjGtu58UtY4bi?=
 =?us-ascii?Q?7jnQ2yR/L0C2k8gE5Kzu82uew9G+ieiEWJ6WKLZZlcR/sbfAbdgiMV9cJPnm?=
 =?us-ascii?Q?9sR5S0WhFPjXtxdOfD6I+PzI9tH43WhmbKUfnScuYVKukE1nVl5YZIpKhD5b?=
 =?us-ascii?Q?/QEPSGxsaabCR2d6JopE3JSoYDkl/VWgk0UUu0P0L8009WCA5lkt4q6zLj7V?=
 =?us-ascii?Q?LUx7W8H7fgErqF+LcVLpk3HjRXZxgSd8BSsdQ8ujrZ2LcnJQEYxQuZlAJVem?=
 =?us-ascii?Q?Amwx1AL28M4iY3nuSpMuHzLSijAez8VlkHiqniRYN/IGCN1ID/VqXLL6Vlx6?=
 =?us-ascii?Q?O8ZBpHQ5O+Il34jQSktwe6V+h0QnxQCH1YVgcMJpqDS0DHaYBhM645DoCs+D?=
 =?us-ascii?Q?SvRj1XY7sbBZrP0kVDOasqrttniT3W3q2qppDenU/up1b/aJosU+A8bD3YOm?=
 =?us-ascii?Q?I/ZYFhi8eqV08EchEgjBxHh92FFS2BECo5B7ZMB9yCOURHdvzqwB879mQqK+?=
 =?us-ascii?Q?SARtpSQPGbVj5zE4YPjuDMM9ti0ucN7bTHExE93s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5f2fb6-242a-45b7-3dce-08db2ac796f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 11:21:32.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+1dW9Fc109pmWsopRFkV146qZTsrN8u/wqbGO9rrtItk7vr8Na8ioQmM76nfhc5swG/tEggAGC1CJqEFJIqbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rezki,

Thank you so much for sharing this super cool parser! ;-)
It will help me/us to speed up parsing the tracing logs.=20

-Qiuxu

> From: Uladzislau Rezki <urezki@gmail.com>
> Sent: Wednesday, March 22, 2023 2:50 PM
> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>; Paul E . McKenney
> <paulmck@kernel.org>; RCU <rcu@vger.kernel.org>;
> quic_neeraju@quicinc.com; Boqun Feng <boqun.feng@gmail.com>; Joel
> Fernandes <joel@joelfernandes.org>; LKML <linux-kernel@vger.kernel.org>;
> Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>; Steven Rostedt
> <rostedt@goodmis.org>; Frederic Weisbecker <frederic@kernel.org>
> Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
>=20
> On Wed, Mar 22, 2023 at 01:49:50AM +0000, Zhuo, Qiuxu wrote:
> > Hi Rezki,
> >
> > > From: Uladzislau Rezki <urezki@gmail.com>
> > > Sent: Tuesday, March 21, 2023 11:16 PM [...]
> > > >
> > > >
> > > > If possible, may I know the steps, commands, and related
> > > > parameters to
> > > produce the results above?
> > > > Thank you!
> > > >
> > > Build the kernel with CONFIG_RCU_TRACE configuration. Update your
> > > "set_event"
> > > file with appropriate traces:
> > >
> > > <snip>
> > > XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start
> > > rcu:rcu_batch_end rcu:rcu_invoke_callback > set_event
> > >
> > > XQ-DQ54:/sys/kernel/tracing # cat set_event rcu:rcu_batch_start
> > > rcu:rcu_invoke_callback rcu:rcu_batch_end
> > > XQ-DQ54:/sys/kernel/tracing # <snip>
> > >
> > > Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing #
> > > echo 1 > tracing_on; sleep 10; echo 0 > tracing_on Next problem is
> > > how to parse it. Of
> >
> > Thanks for the detailed steps to collect the related testing results.
> >
> > > course you will not be able to parse megabytes of traces. For that
> > > purpose i use a special C trace parser.
> > > If you need an example please let me know i can show here.
> > >
> >
> > Yes, your example parser should save me from a huge amount of traces.
> > ;-) Thanks so much for your sharing.
> >
> See below the C program. It is ugly but it does what you need. Please hav=
e a
> look at main function:
>=20
> <snip>
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdbool.h>
> #include <ctype.h>
> #include <string.h>
>=20
> /*
>  * Splay-tree implementation to store data: key,value
>  * See https://en.wikipedia.org/wiki/Splay_tree
>  */
> #define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)-
> >MEMBER)
> #define container_of(ptr, type, member)			\
> ({
> 			\
> 	void *__mptr =3D (void *)(ptr);					\
> 	((type *)(__mptr - offsetof(type, member)));	\
> })
>=20
> #define SP_INIT_NODE(node)
> 			\
> 	((node)->left =3D (node)->right =3D (node)->parent =3D NULL)
>=20
> struct splay_node {
> 	struct splay_node *left;
> 	struct splay_node *right;
> 	struct splay_node *parent;
> 	unsigned long val;
> };
>=20
> struct splay_root {
> 	struct splay_node *sp_root;
> };
>=20
> static inline void
> set_parent(struct splay_node *n, struct splay_node *p) {
> 	if (n)
> 		n->parent =3D p;
> }
>=20
> static inline void
> change_child(struct splay_node *p,
> 	struct splay_node *old, struct splay_node *new) {
> 	if (p) {
> 		if (p->left =3D=3D old)
> 			p->left =3D new;
> 		else
> 			p->right =3D new;
> 	}
> }
>=20
> /*
>  * left rotation of node (r), (rc) is (r)'s right child  */ static inline=
 struct
> splay_node * left_pivot(struct splay_node *r) {
> 	struct splay_node *rc;
>=20
> 	/*
> 	 * set (rc) to be the new root
> 	 */
> 	rc =3D r->right;
>=20
> 	/*
> 	 * point parent to new left/right child
> 	 */
> 	rc->parent =3D r->parent;
>=20
> 	/*
> 	 * change child of the p->parent.
> 	 */
> 	change_child(r->parent, r, rc);
>=20
> 	/*
> 	 * set (r)'s right child to be (rc)'s left child
> 	 */
> 	r->right =3D rc->left;
>=20
> 	/*
> 	 * change parent of rc's left child
> 	 */
> 	set_parent(rc->left, r);
>=20
> 	/*
> 	 * set new parent of rotated node
> 	 */
> 	r->parent =3D rc;
>=20
> 	/*
> 	 * set (rc)'s left child to be (r)
> 	 */
> 	rc->left =3D r;
>=20
> 	/*
> 	 * return the new root
> 	 */
> 	return rc;
> }
>=20
> /*
>  * right rotation of node (r), (lc) is (r)'s left child  */ static inline=
 struct
> splay_node * right_pivot(struct splay_node *r) {
> 	struct splay_node *lc;
>=20
> 	/*
> 	 * set (lc) to be the new root
> 	 */
> 	lc =3D r->left;
>=20
> 	/*
> 	 * point parent to new left/right child
> 	 */
> 	lc->parent =3D r->parent;
>=20
> 	/*
> 	 * change child of the p->parent.
> 	 */
> 	change_child(r->parent, r, lc);
>=20
> 	/*
> 	 * set (r)'s left child to be (lc)'s right child
> 	 */
> 	r->left =3D lc->right;
>=20
> 	/*
> 	 * change parent of lc's right child
> 	 */
> 	set_parent(lc->right, r);
>=20
> 	/*
> 	 * set new parent of rotated node
> 	 */
> 	r->parent =3D lc;
>=20
> 	/*
> 	 * set (lc)'s right child to be (r)
> 	 */
> 	lc->right =3D r;
>=20
> 	/*
> 	 * return the new root
> 	 */
> 	return lc;
> }
>=20
> static struct splay_node *
> top_down_splay(unsigned long vstart,
> 	struct splay_node *root, struct splay_root *sp_root) {
> 	/*
> 	 * During the splitting process two temporary trees are formed.
> 	 * "l" contains all keys less than the search key/vstart and "r"
> 	 * contains all keys greater than the search key/vstart.
> 	 */
> 	struct splay_node head, *ltree_max, *rtree_max;
> 	struct splay_node *ltree_prev, *rtree_prev;
>=20
> 	if (root =3D=3D NULL)
> 		return NULL;
>=20
> 	SP_INIT_NODE(&head);
> 	ltree_max =3D rtree_max =3D &head;
> 	ltree_prev =3D rtree_prev =3D NULL;
>=20
> 	while (1) {
> 		if (vstart < root->val && root->left) {
> 			if (vstart < root->left->val) {
> 				root =3D right_pivot(root);
>=20
> 				if (root->left =3D=3D NULL)
> 					break;
> 			}
>=20
> 			/*
> 			 * Build right subtree.
> 			 */
> 			rtree_max->left =3D root;
> 			rtree_max->left->parent =3D rtree_prev;
> 			rtree_max =3D rtree_max->left;
> 			rtree_prev =3D root;
> 			root =3D root->left;
> 		} else if (vstart > root->val && root->right) {
> 			if (vstart > root->right->val) {
> 				root =3D left_pivot(root);
>=20
> 				if (root->right =3D=3D NULL)
> 					break;
> 			}
>=20
> 			/*
> 			 * Build left subtree.
> 			 */
> 			ltree_max->right =3D root;
> 			ltree_max->right->parent =3D ltree_prev;
> 			ltree_max =3D ltree_max->right;
> 			ltree_prev =3D root;
> 			root =3D root->right;
> 		} else {
> 			break;
> 		}
> 	}
>=20
> 	/*
> 	 * Assemble the tree.
> 	 */
> 	ltree_max->right =3D root->left;
> 	rtree_max->left =3D root->right;
> 	root->left =3D head.right;
> 	root->right =3D head.left;
>=20
> 	set_parent(ltree_max->right, ltree_max);
> 	set_parent(rtree_max->left, rtree_max);
> 	set_parent(root->left, root);
> 	set_parent(root->right, root);
> 	root->parent =3D NULL;
>=20
> 	/*
> 	 * Set new root. Please note it might be the same.
> 	 */
> 	sp_root->sp_root =3D root;
> 	return sp_root->sp_root;
> }
>=20
> struct splay_node *
> splay_search(unsigned long key, struct splay_root *root) {
> 	struct splay_node *n;
>=20
> 	n =3D top_down_splay(key, root->sp_root, root);
> 	if (n && n->val =3D=3D key)
> 		return n;
>=20
> 	return NULL;
> }
>=20
> static bool
> splay_insert(struct splay_node *n, struct splay_root *sp_root) {
> 	struct splay_node *r;
>=20
> 	SP_INIT_NODE(n);
>=20
> 	r =3D top_down_splay(n->val, sp_root->sp_root, sp_root);
> 	if (r =3D=3D NULL) {
> 		/* First element in the tree */
> 		sp_root->sp_root =3D n;
> 		return false;
> 	}
>=20
> 	if (n->val < r->val) {
> 		n->left =3D r->left;
> 		n->right =3D r;
>=20
> 		set_parent(r->left, n);
> 		r->parent =3D n;
> 		r->left =3D NULL;
> 	} else if (n->val > r->val) {
> 		n->right =3D r->right;
> 		n->left =3D r;
>=20
> 		set_parent(r->right, n);
> 		r->parent =3D n;
> 		r->right =3D NULL;
> 	} else {
> 		/*
> 		 * Same, indicate as not success insertion.
> 		 */
> 		return false;
> 	}
>=20
> 	sp_root->sp_root =3D n;
> 	return true;
> }
>=20
> static bool
> splay_delete_init(struct splay_node *n, struct splay_root *sp_root) {
> 	struct splay_node *subtree[2];
> 	unsigned long val =3D n->val;
>=20
> 	/* 1. Splay the node to the root. */
> 	n =3D top_down_splay(n->val, sp_root->sp_root, sp_root);
> 	if (n =3D=3D NULL || n->val !=3D val)
> 		return false;
>=20
> 	/* 2. Save left/right sub-trees. */
> 	subtree[0] =3D n->left;
> 	subtree[1] =3D n->right;
>=20
> 	/* 3. Now remove the node. */
> 	SP_INIT_NODE(n);
>=20
> 	if (subtree[0]) {
> 		/* 4. Splay the largest node in left sub-tree to the root. */
> 		top_down_splay(val, subtree[0], sp_root);
>=20
> 		/* 5. Attach the right sub-tree as the right child of the left
> sub-tree. */
> 		sp_root->sp_root->right =3D subtree[1];
>=20
> 		/* 6. Update the parent of right sub-tree */
> 		set_parent(subtree[1], sp_root->sp_root);
> 	} else {
> 		/* 7. Left sub-tree is NULL, just point to right one. */
> 		sp_root->sp_root =3D subtree[1];
> 	}
>=20
> 	/* 8. Set parent of root node to NULL. */
> 	if (sp_root->sp_root)
> 		sp_root->sp_root->parent =3D NULL;
>=20
> 	return true;
> }
>=20
> static FILE *
> open_perf_script_file(const char *path)
> {
> 	FILE *f =3D NULL;
>=20
> 	if (path =3D=3D NULL)
> 		goto out;
>=20
> 	f =3D fopen(path, "r");
> 	if (!f)
> 		goto out;
>=20
> out:
> 	return f;
> }
>=20
> static int
> get_one_line(FILE *file, char *buf, size_t len) {
> 	int i =3D 0;
>=20
> 	memset(buf, '\0', len);
>=20
> 	for (i =3D 0; i < len - 1; i++) {
> 		int c =3D fgetc(file);
>=20
> 		if (c =3D=3D EOF)
> 			return EOF;
>=20
> 		if (c =3D=3D '\n')
> 			break;
>=20
> 		if (c !=3D '\r')
> 			buf[i] =3D c;
> 	}
>=20
> 	return i;
> }
>=20
> static int
> read_string_till_string(char *buf, char *out, size_t out_len, char *in, s=
ize_t
> in_len) {
> 	int i, j;
>=20
> 	memset(out, '\0', out_len);
>=20
> 	for (i =3D 0; i < out_len; i++) {
> 		if (buf[i] !=3D in[0]) {
> 			out[i] =3D buf[i];
> 			continue;
> 		}
>=20
> 		for (j =3D 0; j < in_len; j++) {
> 			if (buf[i + j] !=3D in[j])
> 				break;
> 		}
>=20
> 		/* Found. */
> 		if (j =3D=3D in_len)
> 			return 1;
> 	}
>=20
> 	return 0;
> }
>=20
> /*
>  * find pattern is  "something [003] 8640.034785: something"
>  */
> static inline void
> get_cpu_sec_usec_in_string(const char *s, int *cpu, int *sec, int *usec) =
{
> 	char usec_buf[32] =3D {'\0'};
> 	char sec_buf[32] =3D {'\0'};
> 	char cpu_buf[32] =3D {'\0'};
> 	bool found_sec =3D false;
> 	bool found_usec =3D false;
> 	bool found_cpu =3D false;
> 	int i, j, dot;
>=20
> 	*cpu =3D *sec =3D *usec =3D -1;
>=20
> 	for (i =3D 0, j =3D 0; s[i] !=3D '\0'; i++) {
> 		if (s[i] =3D=3D '.') {
> 			dot =3D i++;
>=20
> 			/* take microseconds */
> 			for (j =3D 0; j < sizeof(usec_buf); j++) {
> 				if (isdigit(s[i])) {
> 					usec_buf[j] =3D s[i];
> 				} else {
> 					if (s[i] =3D=3D ':' && j > 0)
> 						found_usec =3D true;
> 					else
> 						found_usec =3D false;
>=20
> 					/* Terminate here. */
> 					break;
> 				}
>=20
> 				i++;
> 			}
>=20
> 			if (found_usec) {
> 				/* roll back */
> 				while (s[i] !=3D ' ' && i > 0)
> 					i--;
>=20
> 				/* take seconds */
> 				for (j =3D 0; j < sizeof(sec_buf); j++) {
> 					if (isdigit(s[++i])) {
> 						sec_buf[j] =3D s[i];
> 					} else {
> 						if (s[i] =3D=3D '.' && j > 0)
> 							found_sec =3D true;
> 						else
> 							found_sec =3D false;
>=20
> 						/* Terminate here. */
> 						break;
> 					}
> 				}
> 			}
>=20
> 			if (found_sec && found_usec) {
> 				/* roll back */
> 				while (s[i] !=3D '[' && i > 0)
> 					i--;
>=20
> 				/* take seconds */
> 				for (j =3D 0; j < sizeof(cpu_buf); j++) {
> 					if (isdigit(s[++i])) {
> 						cpu_buf[j] =3D s[i];
> 					} else {
> 						if (s[i] =3D=3D ']' && j > 0)
> 							found_cpu =3D true;
> 						else
> 							found_cpu =3D false;
>=20
> 						/* Terminate here. */
> 						break;
> 					}
> 				}
>=20
> 				if (found_cpu && found_sec && found_usec)
> {
> 					*sec =3D atoi(sec_buf);
> 					*usec =3D atoi(usec_buf);
> 					*cpu =3D atoi(cpu_buf);
> 					return;
> 				}
> 			}
>=20
> 			/*
> 			 * Check next dot pattern.
> 			 */
> 			found_sec =3D false;
> 			found_usec =3D false;
> 			found_cpu =3D false;
> 			i =3D dot;
> 		}
> 	}
> }
>=20
> /*
>  * find pattern is  "something comm=3Dfoo android thr1 pid=3D123 somethin=
g"
>  */
> static inline int
> get_comm_pid_in_string(const char *buf, char *comm, ssize_t len, int *pid=
) {
> 	char *sc, *sp;
> 	int rv, i;
>=20
> 	memset(comm, '\0', len);
>=20
> 	sc =3D strstr(buf, "comm=3D");
> 	if (sc)
> 		sp =3D strstr(sc, " pid=3D");
>=20
> 	if (!sc || !sp)
> 		return -1;
>=20
> 	for (i =3D 0, sc +=3D 5; sc !=3D sp; i++) {
> 		if (i < len) {
> 			if (*sc =3D=3D ' ')
> 				comm[i] =3D '-';
> 			else
> 				comm[i] =3D *sc;
>=20
> 			sc++;
> 		}
> 	}
>=20
> 	/* Read pid. */
> 	rv =3D sscanf(sp, " pid=3D%d", pid);
> 	if (rv !=3D 1)
> 		return -1;
>=20
> 	return 1;
> }
>=20
> static void
> perf_script_softirq_delay(FILE *file, int delay_usec) {
> 	char buf[4096] =3D { '\0' };
> 	char buf_1[4096] =3D { '\0' };
> 	long offset;
> 	char *s;
> 	int rv;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		offset =3D ftell(file);
>=20
> 		if (rv !=3D EOF) {
> 			s =3D strstr(buf, "irq:softirq_raise:");
> 			if (s) {
> 				char extra[512] =3D {'\0'};
> 				int sec_0, usec_0;
> 				int sec_1, usec_1;
> 				int handle_vector;
> 				int rise_vector;
> 				int cpu_0;
> 				int cpu_1;
>=20
> 				/*
> 				 * swapper     0    [000]  6010.619854:
> irq:softirq_raise: vec=3D7 [action=3DSCHED]
> 				 * android.bg  3052 [001]  6000.076212:
> irq:softirq_entry: vec=3D9 [action=3DRCU]
> 				 */
> 				(void) sscanf(s, "%s vec=3D%d", extra,
> &rise_vector);
> 				get_cpu_sec_usec_in_string(buf, &cpu_0,
> &sec_0, &usec_0);
>=20
> 				while (1) {
> 					rv =3D get_one_line(file, buf_1,
> sizeof(buf_1));
> 					if (rv =3D=3D EOF)
> 						break;
>=20
> 					s =3D strstr(buf_1, "irq:softirq_entry:");
> 					if (s) {
> 						(void) sscanf(s, "%s vec=3D%d",
> extra, &handle_vector);
>=20
> 	get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);
>=20
> 						if (cpu_0 =3D=3D cpu_1 &&
> rise_vector =3D=3D handle_vector) {
> 							int delta_time_usec =3D
> (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);
>=20
> 							if (delta_time_usec >
> delay_usec)
> 								fprintf(stdout,
> "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
> 							break;
> 						}
> 					}
> 				}
> 			}
>=20
> 			rv =3D fseek(file, offset, SEEK_SET);
> 			if (rv)
> 				fprintf(stdout, "fseek error !!!\n");
> 		} else {
> 			break;
> 		}
> 	}
> }
>=20
> static void
> perf_script_softirq_duration(FILE *file, int duration_usec) {
> 	char buf[4096] =3D { '\0' };
> 	char buf_1[4096] =3D { '\0' };
> 	long offset;
> 	char *s;
> 	int rv;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		offset =3D ftell(file);
>=20
> 		if (rv !=3D EOF) {
> 			s =3D strstr(buf, "irq:softirq_entry:");
> 			if (s) {
> 				char extra[512] =3D {'\0'};
> 				int sec_0, usec_0;
> 				int sec_1, usec_1;
> 				int handle_vector;
> 				int rise_vector;
> 				int cpu_0;
> 				int cpu_1;
>=20
> 				/*
> 				 * swapper     0    [000]  6010.619854:
> irq:softirq_entry: vec=3D7 [action=3DSCHED]
> 				 * android.bg  3052 [001]  6000.076212:
> irq:softirq_exit: vec=3D9 [action=3DRCU]
> 				 */
> 				(void) sscanf(s, "%s vec=3D%d", extra,
> &rise_vector);
> 				get_cpu_sec_usec_in_string(buf, &cpu_0,
> &sec_0, &usec_0);
>=20
> 				while (1) {
> 					rv =3D get_one_line(file, buf_1,
> sizeof(buf_1));
> 					if (rv =3D=3D EOF)
> 						break;
>=20
> 					s =3D strstr(buf_1, "irq:softirq_exit:");
> 					if (s) {
> 						(void) sscanf(s, "%s vec=3D%d",
> extra, &handle_vector);
>=20
> 	get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);
>=20
> 						if (cpu_0 =3D=3D cpu_1 &&
> rise_vector =3D=3D handle_vector) {
> 							int delta_time_usec =3D
> (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);
>=20
> 							if (delta_time_usec >
> duration_usec)
> 								fprintf(stdout,
> "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
> 							break;
> 						}
> 					}
> 				}
> 			}
>=20
> 			rv =3D fseek(file, offset, SEEK_SET);
> 			if (rv)
> 				fprintf(stdout, "fseek error !!!\n");
> 		} else {
> 			break;
> 		}
> 	}
> }
>=20
> static void
> perf_script_hardirq_duration(FILE *file, int duration_msec) {
> 	char buf[4096] =3D { '\0' };
> 	char buf_1[4096] =3D { '\0' };
> 	long offset;
> 	char *s;
> 	int rv;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		offset =3D ftell(file);
>=20
> 		if (rv !=3D EOF) {
> 			s =3D strstr(buf, "irq:irq_handler_entry:");
> 			if (s) {
> 				char extra[512] =3D {'\0'};
> 				int sec_0, usec_0;
> 				int sec_1, usec_1;
> 				int handle_vector;
> 				int rise_vector;
> 				int cpu_0;
> 				int cpu_1;
>=20
> 				/*
> 				 * swapper     0 [002]  6205.804133:
> irq:irq_handler_entry: irq=3D11 name=3Darch_timer
> 				 * swapper     0 [002]  6205.804228:
> irq:irq_handler_exit: irq=3D11 ret=3Dhandled
> 				 */
> 				(void) sscanf(s, "%s irq=3D%d", extra,
> &rise_vector);
> 				get_cpu_sec_usec_in_string(buf, &cpu_0,
> &sec_0, &usec_0);
>=20
> 				while (1) {
> 					rv =3D get_one_line(file, buf_1,
> sizeof(buf_1));
> 					if (rv =3D=3D EOF)
> 						break;
>=20
> 					s =3D strstr(buf_1,
> "irq:irq_handler_exit:");
> 					if (s) {
> 						(void) sscanf(s, "%s irq=3D%d",
> extra, &handle_vector);
>=20
> 	get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);
>=20
> 						if (cpu_0 =3D=3D cpu_1 &&
> rise_vector =3D=3D handle_vector) {
> 							int delta_time_usec =3D
> (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);
>=20
> 							if (delta_time_usec >
> duration_msec)
> 								fprintf(stdout,
> "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
> 							break;
> 						}
> 					}
> 				}
> 			}
>=20
> 			rv =3D fseek(file, offset, SEEK_SET);
> 			if (rv)
> 				fprintf(stdout, "fseek error !!!\n");
> 		} else {
> 			break;
> 		}
> 	}
> }
>=20
> struct irq_stat {
> 	int irq;
> 	int count;
> 	char irq_name[512];
>=20
> 	int min_interval;
> 	int max_interval;
> 	int avg_interval;
>=20
> 	unsigned int time_stamp_usec;
> 	struct splay_node node;
> };
>=20
> static struct irq_stat *
> new_irq_node_init(int irq, char *irq_name) {
> 	struct irq_stat *n =3D calloc(1, sizeof(*n));
>=20
> 	if (n) {
> 		n->irq =3D irq;
> 		(void) strncpy(n->irq_name, irq_name, sizeof(n->irq_name));
> 		n->node.val =3D irq;
> 	}
>=20
> 	return n;
> }
>=20
> static void
> perf_script_hardirq_stat(FILE *file)
> {
> 	struct splay_root sproot =3D { NULL };
> 	struct irq_stat *node;
> 	char buf[4096] =3D { '\0' };
> 	char extra[256] =3D {'\0'};
> 	char irq_name[256] =3D {'\0'};
> 	unsigned int time_stamp_usec;
> 	int cpu, sec, usec;
> 	int rv, irq;
> 	char *s;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		if (rv =3D=3D EOF)
> 			break;
>=20
> 		 s =3D strstr(buf, "irq:irq_handler_entry:");
> 		 if (s =3D=3D NULL)
> 			 continue;
>=20
> 		 /*
> 		  * format is as follow one:
> 		  * sleep  1418 [003]  8780.957112:
> irq:irq_handler_entry: irq=3D11 name=3Darch_timer
> 		  */
> 		 rv =3D sscanf(s, "%s irq=3D%d name=3D%s", extra, &irq, irq_name);
> 	 	 if (rv !=3D 3)
> 	 		 continue;
>=20
> 		 get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
> 		 time_stamp_usec =3D (sec * 1000000) + usec;
>=20
> 		 if (sproot.sp_root =3D=3D NULL) {
> 			 node =3D new_irq_node_init(irq, irq_name);
> 			 if (node)
> 				 splay_insert(&node->node, &sproot);
> 		 }
>=20
> 		 top_down_splay(irq, sproot.sp_root, &sproot);
> 		 node =3D container_of(sproot.sp_root, struct irq_stat, node);
>=20
> 		 /* Found the entry in the tree. */
> 		 if (node->irq =3D=3D irq) {
> 			 if (node->time_stamp_usec) {
> 				 unsigned int delta =3D time_stamp_usec -
> node->time_stamp_usec;
>=20
> 				 if (delta < node->min_interval || !node-
> >min_interval)
> 					 node->min_interval =3D delta;
>=20
> 				 if (delta > node->max_interval)
> 					 node->max_interval =3D delta;
>=20
> 				 node->avg_interval +=3D delta;
> 			 }
>=20
> 			 /* Save the last time for this IRQ entry. */
> 			 node->time_stamp_usec =3D time_stamp_usec;
> 		 } else {
> 			 /* Allocate a new record and place it to the tree. */
> 			 node =3D new_irq_node_init(irq, irq_name);
> 			 if (node)
> 				 splay_insert(&node->node, &sproot);
>=20
> 		 }
>=20
> 		 /* Update the timestamp for this entry. */
> 		 node->time_stamp_usec =3D time_stamp_usec;
> 		 node->count++;
> 	}
>=20
> 	/* Dump the tree. */
> 	while (sproot.sp_root) {
> 		node =3D container_of(sproot.sp_root, struct irq_stat, node);
>=20
> 		fprintf(stdout, "irq: %5d name: %30s count: %7d, min: %10d,
> max: %10d, avg: %10d\n",
> 				node->irq, node->irq_name, node->count,
> 				node->min_interval, node->max_interval,
> node->avg_interval / node->count);
>=20
> 		splay_delete_init(&node->node, &sproot);
> 		free(node);
> 	}
>=20
> 	fprintf(stdout, "\tRun './a.out ./perf.script | sort -nk 6' to sort by
> column 6.\n"); }
>=20
> struct sched_waking {
> 	unsigned int wakeup_nr;
> 	char comm[4096];
> 	int pid;
>=20
> 	int min;
> 	int max;
> 	int avg;
>=20
> 	unsigned int time_stamp_usec;
> 	struct splay_node node;
> };
>=20
> static struct sched_waking *
> new_sched_waking_node_init(int pid, char *comm) {
> 	struct sched_waking *n =3D calloc(1, sizeof(*n));
>=20
> 	if (n) {
> 		n->pid =3D pid;
> 		(void) strncpy(n->comm, comm, sizeof(n->comm));
> 		n->node.val =3D pid;
> 	}
>=20
> 	return n;
> }
>=20
> /*
>  * How many times a task is awaken + min/max/avg stat.
>  */
> static void
> perf_script_sched_waking_stat(const char *name, FILE *file, const char
> *script) {
> 	struct splay_root sroot =3D { NULL };
> 	struct sched_waking *n;
> 	char buf[4096] =3D { '\0' };
> 	char comm[256] =3D {'\0'};
> 	unsigned int time_stamp_usec;
> 	unsigned int total_waking =3D 0;
> 	int cpu, sec, usec;
> 	int rv, pid;
> 	char *s;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		if (rv =3D=3D EOF)
> 			break;
> 		/*
> 		 * format is as follow one:
> 		 * foo[1] 7521 [002] 10.431216: sched_waking: comm=3Dtr
> pid=3D2 prio=3D120 target_cpu=3D006
> 		 */
> 		s =3D strstr(buf, "sched_waking:");
> 		if (s =3D=3D NULL)
> 			continue;
>=20
> 		rv =3D get_comm_pid_in_string(s, comm, sizeof(comm), &pid);
> 		if (rv < 0) {
> 			printf("ERROR: skip entry...\n");
> 			continue;
> 		}
>=20
> 		get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
> 		time_stamp_usec =3D (sec * 1000000) + usec;
>=20
> 		if (sroot.sp_root =3D=3D NULL) {
> 			n =3D new_sched_waking_node_init(pid, comm);
> 			if (n)
> 				splay_insert(&n->node, &sroot);
> 		}
>=20
> 		top_down_splay(pid, sroot.sp_root, &sroot);
> 		n =3D container_of(sroot.sp_root, struct sched_waking, node);
>=20
> 		/* Found the entry in the tree. */
> 		if (n->pid =3D=3D pid) {
> 			if (n->time_stamp_usec) {
> 				unsigned int delta =3D time_stamp_usec - n-
> >time_stamp_usec;
>=20
> 				if (delta < n->min || !n->min)
> 					n->min =3D delta;
>=20
> 				if (delta > n->max)
> 					n->max =3D delta;
>=20
> 				n->avg +=3D delta;
> 			}
>=20
> 			/* Save the last time for this wake-up entry. */
> 			n->time_stamp_usec =3D time_stamp_usec;
> 		} else {
> 			/* Allocate a new record and place it to the tree. */
> 			n =3D new_sched_waking_node_init(pid, comm);
> 			if (n)
> 				splay_insert(&n->node, &sroot);
> 		}
>=20
> 		/* Update the timestamp for this entry. */
> 		n->time_stamp_usec =3D time_stamp_usec;
> 		n->wakeup_nr++;
> 	}
>=20
> 	/* Dump the Splay-tree. */
> 	while (sroot.sp_root) {
> 		n =3D container_of(sroot.sp_root, struct sched_waking, node);
> 		fprintf(stdout, "name: %30s pid: %10d woken-
> up %5d\tinterval: min %5d\tmax %5d\tavg %5d\n",
> 			n->comm, n->pid, n->wakeup_nr,
> 			n->min, n->max, n->avg / n->wakeup_nr);
>=20
> 		total_waking +=3D n->wakeup_nr;
> 		splay_delete_init(&n->node, &sroot);
> 		free(n);
> 	}
>=20
> 	fprintf(stdout, "=3D=3D=3D Total: %u =3D=3D=3D\n", total_waking);
> 	fprintf(stdout, "\tRun './%s %s | sort -nk 6' to sort by column 6.\n",
> name, script); }
>=20
> /*
>  * Latency of try_to_wake_up path + select a CPU + placing a task into ru=
n-
> queue.
>  */
> static void
> perf_script_sched_wakeup_latency(const char *name, FILE *file, const char
> *script) {
> 	struct splay_root sroot =3D { NULL };
> 	struct splay_node *node;
> 	struct sched_waking *n;
> 	char buf[4096] =3D { '\0' };
> 	char comm[256] =3D {'\0'};
> 	unsigned int time_stamp_usec;
> 	unsigned int wakeup_latency_usec;
> 	unsigned int total_waking =3D 0;
> 	int cpu, sec, usec;
> 	int rv, pid;
> 	char *sched_waking_wakeup;
> 	bool sched_waking_event;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		if (rv =3D=3D EOF)
> 			break;
>=20
> 		/*
> 		 * format is as follow one:
> 		 * foo[1] 7521 [002] 10.431216: sched_waking: comm=3Dtr
> pid=3D2 prio=3D120 target_cpu=3D006
> 		 */
> 		sched_waking_wakeup =3D strstr(buf, "sched_waking:");
> 		sched_waking_event =3D !!sched_waking_wakeup;
>=20
> 		if (!sched_waking_event) {
> 			/*
> 			 * format is as follow one:
> 			 * foo[1] 7521 [002] 10.431216: sched_wakeup:
> comm=3Dtr pid=3D2 prio=3D120 target_cpu=3D006
> 			 */
> 			sched_waking_wakeup =3D strstr(buf,
> "sched_wakeup:");
> 			if (sched_waking_wakeup =3D=3D NULL)
> 				continue;
> 		}
>=20
> 		rv =3D get_comm_pid_in_string(sched_waking_wakeup, comm,
> sizeof(comm), &pid);
> 		if (rv < 0) {
> 			printf("ERROR: skip entry...\n");
> 			continue;
> 		}
>=20
> 		get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
> 		time_stamp_usec =3D (sec * 1000000) + usec;
>=20
> 		/*
> 		 * Let's check if it exists, if so update it
> 		 * otherwise create a new node and insert.
> 		 */
> 		if (sched_waking_event) {
> 			node =3D top_down_splay(pid, sroot.sp_root, &sroot);
> 			if (node =3D=3D NULL) {
> 				n =3D new_sched_waking_node_init(pid,
> comm);
> 				splay_insert(&n->node, &sroot);
> 			} else {
> 				n =3D container_of(node, struct sched_waking,
> node);
> 				if (n->pid !=3D pid) {
> 					n =3D new_sched_waking_node_init(pid,
> comm);
> 					splay_insert(&n->node, &sroot);
> 				}
> 			}
>=20
> 			n->time_stamp_usec =3D time_stamp_usec;
> 			continue;
> 		}
>=20
> 		node =3D top_down_splay(pid, sroot.sp_root, &sroot);
> 		if (node =3D=3D NULL) {
> 			fprintf(stdout, "error: no sched_waking event for %d
> pid yet.\n", pid);
> 			continue;
> 		}
>=20
> 		n =3D container_of(node, struct sched_waking, node);
> 		if (n->pid !=3D pid) {
> 			fprintf(stdout, "error: sched_wakeup event does not
> match with any sched_waking event.\n");
> 			continue;
> 		}
>=20
> 		wakeup_latency_usec =3D time_stamp_usec - n-
> >time_stamp_usec;
>=20
> 		if (wakeup_latency_usec < n->min || !n->min)
> 			n->min =3D wakeup_latency_usec;
>=20
> 		if (wakeup_latency_usec > n->max)
> 			n->max =3D wakeup_latency_usec;
>=20
> 		if (n->avg + wakeup_latency_usec < n->avg)
> 			fprintf(stdout, "error: counter is overflowed...\n");
>=20
> 		fprintf(stdout, "%s: %d wake-up latency: %u waken on %d
> CPU\n", comm, pid, wakeup_latency_usec, cpu);
>=20
> 		n->avg +=3D wakeup_latency_usec;
> 		n->wakeup_nr++;
> 	}
>=20
> 	/* Dump the Splay-tree. */
> 	while (sroot.sp_root) {
> 		n =3D container_of(sroot.sp_root, struct sched_waking, node);
> 		/* fprintf(stdout, "name: %30s pid: %10d woken-
> up %5d\twakeup-latency: min %5d\tmax %5d\tavg %5d\n", */
> 		/* 	n->comm, n->pid, n->wakeup_nr, */
> 		/* 	n->min, n->max, n->avg / n->wakeup_nr); */
>=20
> 		total_waking +=3D n->wakeup_nr;
> 		splay_delete_init(&n->node, &sroot);
> 		free(n);
> 	}
>=20
> 	/* fprintf(stdout, "=3D=3D=3D Total: %u =3D=3D=3D\n", total_waking); */
> 	/* fprintf(stdout, "\tRun '%s %s | sort -nk 6' to sort by column 6.\n",
> name, script); */ }
>=20
>=20
> /*
>  * Requires:
>  *   rcu:rcu_batch_start
>  *   rcu:rcu_invoke_callback
>  *   rcu:rcu_batch_end
>  */
> static void
> perf_script_synchronize_rcu_latency(const char *name, FILE *file, const c=
har
> *script) {
> 	char buf[4096] =3D { '\0' };
> 	char buf_1[4096] =3D { '\0' };
> 	long offset;
> 	char *s;
> 	int rv;
>=20
> 	while (1) {
> 		rv =3D get_one_line(file, buf, sizeof(buf));
> 		offset =3D ftell(file);
>=20
> 		if (rv !=3D EOF) {
> 			s =3D strstr(buf, "rcu_batch_start:");
> 			if (s) {
> 				int delta_time_usec;
> 				int sec_0, usec_0;
> 				int sec_1, usec_1;
> 				int pid_0, pid_1;
> 				int extra;
>=20
> 				/*
> 				 * rcuop/5-58      [007] d..1.  6111.808748:
> rcu_batch_start: rcu_preempt CBs=3D23 bl=3D10
> 				 */
> 				(void) sscanf(buf, "%*[^0-9]%d-%d", &pid_0,
> &pid_0);
> 				get_cpu_sec_usec_in_string(buf, &extra,
> &sec_0, &usec_0);
>=20
> 				while (1) {
> 					rv =3D get_one_line(file, buf_1,
> sizeof(buf_1));
> 					if (rv =3D=3D EOF)
> 						break;
>=20
> 					/* Do not care what a string format is
> on this step. */
> 					(void) sscanf(buf, "%*[^0-9]%d-%d",
> &pid_1, &pid_1);
>=20
> 					/*
> 					 * rcuop/4-51      [007] d..1.
> 6111.816758: rcu_batch_end: rcu_preempt CBs-invoked=3D1 idle=3D....
> 					 */
> 					s =3D strstr(buf_1, "rcu_batch_end:");
> 					if (s && pid_0 =3D=3D pid_1)
> 						break;
>=20
> 					/*
> 					 * rcuop/1-29      [005] .....
> 6111.808745: rcu_invoke_callback: rcu_preempt rhp=3D0000000093881c60
> func=3Dfile_free_rcu.cfi_jt
> 					 */
> 					s =3D strstr(buf_1,
> "rcu_invoke_callback:");
> 					if (!s || pid_0 !=3D pid_1)
> 						continue;
>=20
> 					s =3D strstr(buf_1,
> "wakeme_after_rcu");
> 					if (s) {
>=20
> 	get_cpu_sec_usec_in_string(buf_1, &extra, &sec_1, &usec_1);
> 						delta_time_usec =3D (sec_1 -
> sec_0) * 1000000 + (usec_1 - usec_0);
> 						fprintf(stdout, "{\n%s\n%s\n}
> latency %d usec\n", buf, buf_1, delta_time_usec);
> 						break;
> 					}
> 				}
> 			}
>=20
> 			rv =3D fseek(file, offset, SEEK_SET);
> 			if (rv)
> 				fprintf(stdout, "fseek error !!!\n");
> 		} else {
> 			break;
> 		}
> 	}
>=20
> }
>=20
> int main(int argc, char **argv)
> {
> 	FILE *file;
>=20
> 	file =3D open_perf_script_file(argv[1]);
> 	if (file =3D=3D NULL) {
> 		fprintf(stdout, "%s:%d failed: specify a perf script file\n",
> __func__, __LINE__);
> 		exit(-1);
> 	}
>=20
> 	/* perf_script_softirq_delay(file, 1000); */
> 	/* perf_script_softirq_duration(file, 500); */
> 	/* perf_script_hardirq_duration(file, 500); */
> 	/* perf_script_hardirq_stat(file); */
> 	/* perf_script_sched_waking_stat(argv[0], file, argv[1]); */
> 	/* perf_script_sched_wakeup_latency(argv[0], file, argv[1]); */
> 	perf_script_synchronize_rcu_latency(argv[0], file, argv[1]);
>=20
> 	return 0;
> }
> <snip>
>=20
> Running it as "./a.out app_launch_rcu_trace.txt" will produce below resul=
ts:

Thanks for the usage example.

> <snip>
> ...
> {
>     <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> CBs=3D3613 bl=3D28
>     <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_pree=
mpt
> rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
> } latency 7270 usec
> {
>     rcuop/5-58      [005] d..1. 21951.352767: rcu_batch_start: rcu_preemp=
t
> CBs=3D3 bl=3D10
>     rcuop/5-58      [005] ..... 21951.352768: rcu_invoke_callback: rcu_pr=
eempt
> rhp=3D00000000b995fac1 func=3Dwakeme_after_rcu.cfi_jt
> } latency 1 usec
> {
>     rcuop/6-65      [007] d..1. 21951.804768: rcu_batch_start: rcu_preemp=
t
> CBs=3D5 bl=3D10
>     rcuop/6-65      [007] ..... 21951.804769: rcu_invoke_callback: rcu_pr=
eempt
> rhp=3D00000000b995fac1 func=3Dwakeme_after_rcu.cfi_jt
> } latency 1 usec
> {
>     rcuop/7-72      [006] d..1. 21951.884774: rcu_batch_start: rcu_preemp=
t
> CBs=3D3517 bl=3D27
>     rcuop/7-72      [006] ..... 21951.885979: rcu_invoke_callback: rcu_pr=
eempt
> rhp=3D000000005119eccc func=3Dwakeme_after_rcu.cfi_jt
> } latency 1205 usec
> {
>     rcuop/5-58      [007] d..1. 21951.912853: rcu_batch_start: rcu_preemp=
t
> CBs=3D193 bl=3D10
>     rcuop/5-58      [007] ..... 21951.912975: rcu_invoke_callback: rcu_pr=
eempt
> rhp=3D00000000b995fac1 func=3Dwakeme_after_rcu.cfi_jt
> } latency 122 usec
> ...
> <snip>
>=20
> now you have a pair.
>=20
> --
> Uladzislau Rezki

