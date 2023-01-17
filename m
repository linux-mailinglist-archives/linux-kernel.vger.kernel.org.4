Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD766E760
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjAQUDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjAQUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:01:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809D4DE2A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673981599; x=1705517599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lL0VNAnVPGLXP5lQRKZL8Z5EWiWOMDguugcmk+FrCmk=;
  b=et1fEi9vx6/E9IFsQBtLUyc+WECLeX7CWiFJP/9SNoA+2qw0tSdaprrw
   hCR3QDTCU2NIrfJfAgrE5AmTokAtaQviw/+le1detMtxr1pBAQ+8+IduY
   ySLv/gojLu8C2T7pCLE8CF2Fo8I3bZU39yK9fsfqZ3d7I49OUh6PEvAGj
   /z2pgDCQbvAmpg/K772k/6XMt8ukwjhhGmV5F27goWnJyCengRn+m9f+g
   pBYZ3kgM0bgVftYr0jht+eO7Cb/KKao+HM86UwBdOxmNHMAyMeOdcT+gS
   iDMNQoI1Qs3LENkdf5Y0gpJqoorWk6q9b0z3QN4eLBBIbR0NSijFHgNY3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="323476748"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="323476748"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="636961319"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="636961319"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 10:53:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:53:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:53:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:53:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhwVUe9NFy///imdajn4E3cFE5ZLzHeb77QRyJdNAYGk/HGdyTyQM2sLk/jpPA2wtT37WBP8choqKGoaDZwcPHFc/CY/PtU99kt+oBADfM1dtZiA34LBki42J+ujCSbeCk16QGRiIlnFLAb9Bf+38f1obI24DdgfIynNrOV0UdAReHI7GwD3XXv2atwuqftdrpYH3xkek10mJ1YXkzeTqg7Jmxwqx25xqf3lilgOHAyhXS3WPPaGOaWvI8Jk51hMH/x4NTUBs/H6i43dSG2zM8P1jMV9PDQT45fldmsVHIqKZP8NnHpBP7g3u5JS2HWVQUSQS8S50w/ksE5T5IYUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S4is/8y894WORKsI0BhaBWtsjrZlAgstbLSnfJ1F5g=;
 b=QDT/HFp6PUfIKyGQUpw7P11cUVgjNWrvJsZ+45DAWHs6D/F5vr+zccpj6jStntsD9fYaWlX0cc6lS8qq5Ysamm4aMjGAtTHKtAXqTr0E4kVQWFS4xFgIBEAxqjeQF2K0Kn7mKDJmQlPdT9v3BYCYNHLPay/JVZkKVjK1aM+M+hlNrJwZTmAYBBi7HhU+i3sk675e8cEdXexnNNuKSmrz65XusSVujbTQfEkWqxYTh2Lfn1PAbqO2Pz0PTXY/MvhkIjnt3upFYdw0wla2G7SY9IB71SO7R6nbkWtitrRx4ObWftMoBTxJADWhQ4vThn6ayVKNtgCiBGe0BUbxCwCiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 18:53:13 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 18:53:13 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
Thread-Topic: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
Thread-Index: AQHZJ3hZXJ6AsSgW8kiqml8Vi5hlD66i9LXg
Date:   Tue, 17 Jan 2023 18:53:12 +0000
Message-ID: <IA1PR11MB609709D870E9B379840592FD9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-6-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-6-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA1PR11MB7385:EE_
x-ms-office365-filtering-correlation-id: 45ed2206-03c5-49b5-fa39-08daf8bc15ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YMu0nFNwUnpW9e3HclAOk5i2/1bJ2S0vCHCOgqrgXhflYrGOtOvRh9HOpMTIeW1kbn+E+uJDI5iTBqdYf3g80u4KF0NTI9sqDA5s915w0lqNyGFkzCBdTHRkXiPkd3zK4dEknBiBz5WfFdYKzZI7gzrzr2EHvi3vnfhGEhQTOB/97OKKCFa95U1IRIp/8YH5cgwbfrZuAPi8Y+gQIRKbtXZJBP4KEABzcl7+guC3tPSq6wPzw2rBavHKDYceIyDQ4jSh3ANGHMRGhKCv2d+1sRS8CeTZGiehMpeToOz/hfBiaoJHlLNg8mxF5amowhsPlQ0l7zPJTSV7XqZNnua1ipwKfInMewc7pijTPFO44eQaApqxw7uRVG68pX3HAQs3gZE/sRFpDXXJj1uUke/14gfefp2xq+tdMRLQw428OzXgTw8zuNFyTMHFCvEHrSWgXEEKz7s6d5LtvSClgdICQnKujoKgzbeoPzDsWxWAGwcZDkX7aoHZ11RUgzH0o2rZQVItb8QTmjRgrU1uimPuWEVejw8Ykg5x4ehCtvGkeugHR9i+4dLjDfXVeU1X0nWoxJFicDOjt2i+vAkm3bhKeXXt07GVJFIwliPiioWdM11+0IOWs5K0+l3A//yYGAip3bT2QkYETPzx5Vd4qbclUcvZ72EjnhkUtiXblxEMxMUyP+qr+3cnHy6B8HNZPv+Krr4J0+uSlp4J9VaEA+ZbGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(64756008)(33656002)(66946007)(66446008)(76116006)(26005)(9686003)(66476007)(66556008)(41300700001)(186003)(8676002)(4326008)(86362001)(5660300002)(82960400001)(52536014)(55016003)(8936002)(110136005)(54906003)(478600001)(6506007)(316002)(83380400001)(7696005)(38100700002)(7416002)(71200400001)(38070700005)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PeBNZb44hPle7o5CvyDE1aDPYLY9SRd/q6ndx7ytsfL61W5kBe+BcjD8Z7Zy?=
 =?us-ascii?Q?cbirEO9hmnJlZPaTmOrBE6tws/3QVU0W+zxZ9W6CKmT9ct0YZ5gZtLkT+zBp?=
 =?us-ascii?Q?2c8P316xzXz4Yc4Xz7l4d2HqA104WUwf0Db607XAK/8StT9vAe5Z3xV+2Xjd?=
 =?us-ascii?Q?5FC/U74y9aYe9iwPeoTH8KR6fv+a3C/XFldUmhotYTdk22xk7ZbuZA56PRdF?=
 =?us-ascii?Q?Uza8LwF61kworBTT20vjGA16ODuDeLy+Zvc5emEOnRk3ugA+P9/MqutXJbDt?=
 =?us-ascii?Q?W3PYer2KxujvZRiIkjDUsMllUQV0SXluaE69L0JkU5RGfTdTA88Ryx8CBbB3?=
 =?us-ascii?Q?TH82w/zN6+rVvcbaKpw7XReFNay5c2D5bBp8gmDcOkWVkss97ckx5hC09EWC?=
 =?us-ascii?Q?3pA/fk2EJIg5UfxzwxYUDSAqAouJmo/VYksh5ZuVh3AgNm98n4r8fbwGlz8Q?=
 =?us-ascii?Q?6xf+Xe1CBsRDtovvEN4lLg7alnwhhQN2zYcvM/x39jn8Zv+Q3La+rWQev+z2?=
 =?us-ascii?Q?r2GAZ904/LSmE+DBkZGuCqwKumF3A1b+T9RpE3BFZlvTG5f2qma4Badlkl0w?=
 =?us-ascii?Q?Aod+lDNebE+vzVTOJha1sm2JzwFj1Ip6AfoQQYkHceU/fNXqo3KKwn5b3XcH?=
 =?us-ascii?Q?BMnfoyF5crNCVk6y/zMJEJTv7/MAGGuTxZJnTK0US7HzquFSmXygNeQA8IYg?=
 =?us-ascii?Q?D9Z+vv8Eo4PaCyV8A3J2DI2llPXb/JqwRMfJgriVd4o10QXyd8JY26kxzX7D?=
 =?us-ascii?Q?Q9EIjZKxhQn+3UHc4kkN05jLN/8JomUNG4R/gSqwkg7P8488geYqL4rJkhcN?=
 =?us-ascii?Q?YqOwbtpLSdL7f69GqOiaqf0/V8rrRiZ3bBGr0hjX/UKD7/T5UO2D7LksmMgC?=
 =?us-ascii?Q?oGomrqPdylYUTWRAi9DpfU4UiiGLmFgq7xyOaZEqO7zg2K1WHAtH2mjlwF+C?=
 =?us-ascii?Q?jYXzJAMTkrlDkHLdhhWss+gveRgiI7yceyUzCepvLnoEwY+6FAiWv3LsYLUN?=
 =?us-ascii?Q?DX3nyWlMF1+nDpkqJ7izfg5viG3DJVSN8+VeHmfH49yk9hr/2+osX2uW6MUI?=
 =?us-ascii?Q?41HZOcO65GVNDlC2Rvbl0BO84t6jo7wcFrpcdfMC8r6DHQkLR6QMkFebZpQH?=
 =?us-ascii?Q?mLqtFXd/jvuI/vfrTh2ZIgzO9QeO+IhzPkzDNVk/yiAn3oJVsdqu39Xn7vcq?=
 =?us-ascii?Q?2GCxKAB+WFSJ5OplvdoU6BuwCiBMRUCDfpx+6+ndNuXJnrVZoxZK+iwH29VY?=
 =?us-ascii?Q?q/it57NDMkyoCKa0sguR4znNnpNqqNxPbj+OyXTAY4eG+3ISdhzFV4eR7+E/?=
 =?us-ascii?Q?dW23nMvTxDaAl/okao+LUQw0NZP77mkMQASBsQ6wTO66xf4DMRgiAPwHEfnH?=
 =?us-ascii?Q?0P9rm9jpUR35toZlaUnFOuIu8BOnW8h4Kx07X/fkraceDyavsMmExsbtVoGe?=
 =?us-ascii?Q?oC3KadKJZfp14rJ7u8Z15qIRY/zGtGetXGvv0SFVKF+15C2d3rQ/R/wjU0Vp?=
 =?us-ascii?Q?+WoBPJaMTpCkC+zXMRBDfL+14RkQDKBEKZotU/bWsAuon/ppfQGgiNHjYPd8?=
 =?us-ascii?Q?mkLsRKZrSPuxFVXYnQ9RFhspFdxrCk8iwRKI++lR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ed2206-03c5-49b5-fa39-08daf8bc15ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:53:13.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yXSBVvAojEvlsdoPR8XysEDMlFh4rMhiTwSuOfMrAVFq3c4aW6TuqynM7YFUN25NRslK4YoJBMnCaLWCIs5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> MPAMs RMID values are not unique unless the CLOSID is considered as well.
>=20
> alloc_rmid() expects the RMID to be an independent number.
>=20
> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when allo=
cating.
> If the CLOSID is not relevant to the index, this ends up comparing the fr=
ee RMID
> with itself, and the first free entry will be used. With MPAM the CLOSID =
is
> included in the index, so this becomes a walk of the free RMID entries, u=
ntil one
> that matches the supplied CLOSID is found.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 44 ++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>  4 files changed, 38 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index af71401c57e2..013c8fc9fd28 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -510,7 +510,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup
> *rdtgrp);  struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_res=
ource
> *r);  int closids_supported(void);  void closid_free(int closid); -int
> alloc_rmid(void);
> +int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);  void mon_event_count=
(void
> *info); diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index dbae380e3d1c..347be3767241 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -301,25 +301,51 @@ bool has_busy_rmid(struct rdt_resource *r, struct
> rdt_domain *d)
>  	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;  }
>=20
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid) {
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
> +
> +	if (list_empty(&rmid_free_lru))
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-
> ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, these will
> +		 * always be the same. Otherwise they will only match if this
> +		 * RMID can be used with this CLOSID.
> +		 */
> +		itr_idx =3D resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx =3D resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx =3D=3D cmp_idx)
> +			return itr;

Finding free rmid may be called frequently depending on usage.

It would be better to have a simpler and faster arch helper that finds the =
itr on x86.
Something like:
struct rmid_entry *resctrl_arch_rmid_matchd(u32 ignored, u32 ignored)
{
	return list_entry_first(resctrl_free_lru, itr, list);
}

Arm64 implements the complex case going through the rmid_free_lru list in t=
he patch.

> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
>  /*
> - * As of now the RMIDs allocation is global.
> + * As of now the RMIDs allocation is the same in each domain.
>   * However we keep track of which packages the RMIDs
>   * are used to optimize the limbo list management.
> + * The closid is ignored on x86.
>   */
> -int alloc_rmid(void)
> +int alloc_rmid(u32 closid)
>  {
>  	struct rmid_entry *entry;
>=20
>  	lockdep_assert_held(&rdtgroup_mutex);
>=20
> -	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +	entry =3D resctrl_find_free_rmid(closid);
> +	if (!IS_ERR(entry)) {
> +		list_del(&entry->list);
> +		return entry->rmid;
> +	}
>=20
> -	entry =3D list_first_entry(&rmid_free_lru,
> -				 struct rmid_entry, list);
> -	list_del(&entry->list);
> -
> -	return entry->rmid;
> +	return PTR_ERR(entry);
>  }
>=20
>  static void add_rmid_to_limbo(struct rmid_entry *entry) diff --git
> a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index c51932516965..3b724a40d3a2 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -763,7 +763,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>  	int ret;
>=20
>  	if (rdt_mon_capable) {
> -		ret =3D alloc_rmid();
> +		ret =3D alloc_rmid(rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Out of RMIDs\n");
>  			return ret;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c67083a8a5f5..ac88610a6946 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2875,7 +2875,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
> rdtgroup *rdtgrp)
>  	if (!rdt_mon_capable)
>  		return 0;
>=20
> -	ret =3D alloc_rmid();
> +	ret =3D alloc_rmid(rdtgrp->closid);
>  	if (ret < 0) {
>  		rdt_last_cmd_puts("Out of RMIDs\n");
>  		return ret;
> --
> 2.30.2

Thanks.

-Fenghua
