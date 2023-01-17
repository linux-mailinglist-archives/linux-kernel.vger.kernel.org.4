Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EE366E6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjAQTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E237B71
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980145; x=1705516145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73szchDAZlSY2S2+6dLP3GdgTlruElswdm2u43VgWvE=;
  b=fe+L3CTMLGZY6KwqBG1Oqw45GtsoVN1CD38WKYu4BITCuu2XUNCbFd8h
   T22YQVv6c/YB2sOhhTsQFwB0m98xoHH+10XPqy7VG2/uQ3LBS/IEJogAK
   TD5pWGYm5mWr5LL6FKx7TWHsR/OoViMPE4E7KThPW080vLytS6uTfHHat
   98otCP5FXfEy9LeCVwct//TfLN7fy/dg82kYQ3GRGJjY1HnVXomA+h6ma
   dP1Zk6nPdb/m5NN7fJfu9a7bxKBujcnv1UlvrJBg+BnLEh4KNLlyq0jyu
   m2v9TY7ne1GtGfYwUkNR+SfRErTPxBat/lbuPfJif/09e1E4HRi/D4TrH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326851838"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326851838"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="748134842"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748134842"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 10:28:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:28:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:28:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:28:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYuqjt2bKYbIqNdwpMFtwX+NPHmWL8OeSWpzzuVgstXXx046vPGaFXncsPQ/fINPrSTVgvV/V5y4W3zZkmu44twEoJmarJ+WWYficgvU0nFEHrbodY5QfQL7HIVeWLRu8LCmY6pL3DfY1Om3mWGdKVCKpEFfodnvfdr8n9ZvUNO1jSz9mkgR7xz3pvFl5fLIFpt7eVcrOmiy7ISIWqtj5tuCXbbXkmIL1wrHwX68ALDeAg4dQhDCw3xlVqK2BVH2Eroctue7J1zQElPWHJdZkmAHbCCBckNJVSaxNF2KHuJXSYfBnYP8wYfeir9po7E0u7xzCYp5YaPRzj9QafxB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA1XI2v4mody9mjIVcdNuQhDc6uDg1b09qjZaKnESI8=;
 b=k6hCMFb8kxvb3e2rKCLzx2M+6OzZ+6LHOq58hIEmVwPl0zUBbXpF+0FS7qTOf+1PVepWHW7es6ervFs6DPLi1VMKB/uPPsKJG2rVFgUDo4OcRz4yVnALhKHhZ785cJmMH9+epmbKChLDdBbve8JbgX2jl0Hl8c5Zv+UJoOgexRsJeoeHq7lilwhoCoz/CQEk1UMAZhS1IKlDPoYKaZOyWZtyivTAvIoAJGkOtCa1uvYTIybu7ITUK4WI2HpFcBTUcpQ4HqlEakK9Iu5PmaTit6/B2M2fSPwVGwnnISeG3W6YIPzAtuUjmn6bGFG+kVVnQAuLYF8CRja3/M7GJTYatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 18:28:52 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 18:28:52 +0000
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
Subject: RE: [PATCH v2 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Thread-Topic: [PATCH v2 04/18] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Thread-Index: AQHZJ3hQClxQPZZwV06267jEE779pK6hLBBQ
Date:   Tue, 17 Jan 2023 18:28:51 +0000
Message-ID: <IA1PR11MB609785B819CB4558F211DDAC9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-5-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-5-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: 6f980f4f-88cc-47a1-7875-08daf8b8aef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7dXIboB2cDs2jF04NFVgaP31CbCwyxEY0fTZVjqYCMBbqNWAJBa11x80MVfN/r3p7hAhybt69md/nTpjVbnaBN68GxI6au6UrLtlNgzWowOzPbCK+VGmBG3q/DpUA/O8RyPUTMnleLXsRmumJeaIDnqbB8ofhFGDE4aEKskCABfF0rsAKcVAMSty1xlzLDqFD/n8Z5HLioQ49TvcFkS8aJRzIjZ7eh0pSii8uPNKQ8OIm3Fo0nlZ+gCjQbCChN570L4Nh/QXHZd3/RPn26HOZTB6q7Iu4G95vQUNtpv1LtWNwV/kRIa2SFoIrlc1gq5UZ72nfr0ifqrSX4Q3153zwkUc22qYbXqHbkv5u/eUN5a58j5HXcYpMWk2TENInSh1MTU/GPhj2XjK3LD+QfaufzgHiprYcAOvNCiBTUBuTVNVMKYqUox29v8E80WMeDbLjnvJi6bTg/hCzpKZtTdzIuxA7/SGxanPZSigmmD1xBAa9/9n7fgPNgz2BW9GWxpqtS0lseDoopeb8sEiBaKVOpjEC7ueWM4HMrts5KeV6AjfAvYuqagXU8sHej5Z4C3K86b9V6BO4RAgEBtFC3RO/BMlBNc2Ck1nBWML1kkTgyPFEU6SVh6BfLS2UYcLgoLoM7n+x3zKt7hg/H1rOg3M9sN1TlCgiArhQtCEB7VSITBfZs7ulBlIFEe8KkBTKCQ7nNuyS0MFoP+78hHyluG6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(83380400001)(55016003)(86362001)(7416002)(38070700005)(52536014)(122000001)(82960400001)(2906002)(5660300002)(8936002)(38100700002)(316002)(8676002)(478600001)(6506007)(66476007)(9686003)(71200400001)(26005)(186003)(64756008)(66556008)(7696005)(76116006)(66446008)(4326008)(66946007)(110136005)(54906003)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A+kqgUYhacql/eOqbhx3RnBwdMi/MJCYL18ehPGsv21Jl7FLKShA4O4MlHmV?=
 =?us-ascii?Q?0b6RbltpwasXUh0iU7ufp0hntSbcIHWYiV3VrXozN85zYzDP3XuhtLdwsmtt?=
 =?us-ascii?Q?TJ+SkpdLVE2fUzDXV7jCgMA6PBFdpTFXnucUb4wPGOzBYRy3puxIHE1eYgHs?=
 =?us-ascii?Q?+yI9zbCXHrsgK1Oev5cMAODUH5hgW+wyO35BGac08CdlRReqe9sV/2oqNYS3?=
 =?us-ascii?Q?38A2oPt3t2NyOCW3dB+tgC1QunKgIMQ/7Ur0BLz4jbtjZTE3qpIEQNUa0fO/?=
 =?us-ascii?Q?AD5Go6hzNNa+RcjT8tn94K+AuxXElE7TCaaCpGYomCBOafxtD8qIUKYZyn4O?=
 =?us-ascii?Q?AkM9LvXDwGXnoUhnnvekGKUFc2BawTa7ZVarkemQSW0gil+N1GOF1aExKXcP?=
 =?us-ascii?Q?ilRxg+t8ecXkIyRSQ01cK2wQ09Z1XRjj0VdYfhAzE0+l4uu5EgiyL0p4bCOJ?=
 =?us-ascii?Q?JeBMaRFLyeAKInY/2I9JO2dJOGc2Fa232l2y/kYyQjN20PyK89nq61Sie4EE?=
 =?us-ascii?Q?EA3oZficSW9ew3LlarM6ByZicpB6nFJkyFAGcCna6EBktdPKPre8qjwQTjEc?=
 =?us-ascii?Q?el7tniLVLVWWqofH1nktgytHIP+GxA390gxZvgLoO8to2LZCVSdZwddzWL5F?=
 =?us-ascii?Q?WRNg+rKuPjyf7sMI016u0VS0hDS1C8YgAo41TsKkVcqzBatnKmLNTvp46G3j?=
 =?us-ascii?Q?jhOTcD+HO+0Akbu+522IPjMX57wQqcFk4kvCGg+hPr1Bj2D3QetJeVJVxonm?=
 =?us-ascii?Q?ekmkm+iqyVud5GbSoDCdTEd2ZqO1Uc1qniX1bA+F+CixydL2SvnlFuQtPmac?=
 =?us-ascii?Q?quARIlg0RnU62GUvyvJ8uHHy5nSbP9LBA+EXbEgUJBJue9F+biFtsqUUqUGI?=
 =?us-ascii?Q?eEqtgN6aMZb9KNVuFeQV/9W8wcAkJqUlFpvACYfBHw4PuUihUYZk448ix2MY?=
 =?us-ascii?Q?RTngU3IUErDVZT0a1W4WXDn2gCmGdYJoqaK78y9WtbTZqB6fgb9O1BLeJTeK?=
 =?us-ascii?Q?xbueS0SDDEwJA6HLzY4N5414F+vpKVHKfkzguyGLWeQJ8JfO89r1M7N96eYX?=
 =?us-ascii?Q?zZ9fQF97796Z/jSpH+ncJCkDhiB9qbZhaI6kUwYF1YkvugKz6Jb+UXA+ukXm?=
 =?us-ascii?Q?LHYdPdvbC9qx3BKdV26CJq6MQsHdol15bwnDXSJmVG++y/DBpGjRaXbqjWoL?=
 =?us-ascii?Q?TIL7gdrhZKU/RJgsiMe8kDyINhUN24YWYWG+wAu9me3pg1OWwykb2qtMbzKQ?=
 =?us-ascii?Q?r5FOQdbiFuTW16BCf6qaGGg2JD1dA3Tm80ueEEDzaNoCoD9iwm2NuFEGNtSB?=
 =?us-ascii?Q?3niAhpnLPXch/t787X2Six6j4XpZ8/Xa7WeVrN+BEpM8Kf4FdoptJavF7plY?=
 =?us-ascii?Q?P/+nactZLfWJKcWMd+TJ8EHF7HljL2YKOA5zFRMRQn29g/fXxGkQVbmZbXdB?=
 =?us-ascii?Q?3jlVNm8QX8p8kMxbGX5wVcEEcUYmjXMHIM9UcbDDh2H04I08x8B7dL0kN7Ow?=
 =?us-ascii?Q?DBmArkwP9R7UJlqPLBuBnjr4RqvvTaXuGlX39argSPK9YeoIvYRU+lXeKFis?=
 =?us-ascii?Q?7CUJxFT2U0ulfY1Oi5dTwi3/tgz5dco3fbjj0PnT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f980f4f-88cc-47a1-7875-08daf8b8aef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:28:51.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDzAbCXXcDG3GrkrdouCxuT+7Z6f78Pmxyy0dgn2EGePcy3Iatmj1dE+gzUW7zG2CsCZa+YIJYqYEEpaY6Sqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
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

> RMID are allocated for each monitor or control group directory, because e=
ach
> of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
>=20
> MPAM's equivalent of RMID are not an independent number, so can't be

s/are/is/?

> allocated until the closid is known. An RMID allocation for one CLOSID ma=
y fail,

s/closid/CLOSID/

> whereas another may succeed depending on how many monitor groups a
> control group has.
>=20
> The RMID allocation needs to move to be after the CLOSID has been allocat=
ed.
>=20
> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its calle=
r, after
> the mkdir_rdt_prepare() call. This allows the RMID allocator to know the =
CLOSID.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 +++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 841294ad6263..c67083a8a5f5 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2892,6 +2892,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
> rdtgroup *rdtgrp)
>  	return 0;
>  }
>=20
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp) {
> +	if (rdt_mon_capable)
> +		free_rmid(rgrp->closid, rgrp->mon.rmid); }
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -2957,10 +2963,6 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,
>  		goto out_destroy;
>  	}
>=20
> -	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_destroy;
> -
>  	kernfs_activate(kn);
>=20
>  	/*
> @@ -2981,7 +2983,6 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,  static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)  =
{
>  	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->closid, rgrp->mon.rmid);
>  	rdtgroup_remove(rgrp);
>  }
>=20
> @@ -3003,12 +3004,19 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
> *parent_kn,
>  	prgrp =3D rdtgrp->mon.parent;
>  	rdtgrp->closid =3D prgrp->closid;
>=20
> +	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret) {
> +		mkdir_rdt_prepare_clean(rdtgrp);
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * Add the rdtgrp to the list of rdtgrps the parent
>  	 * ctrl_mon group has to track.
>  	 */
>  	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
>=20
> +out_unlock:
>  	rdtgroup_kn_unlock(parent_kn);
>  	return ret;
>  }
> @@ -3039,10 +3047,15 @@ static int rdtgroup_mkdir_ctrl_mon(struct
> kernfs_node *parent_kn,
>  	ret =3D 0;
>=20
>  	rdtgrp->closid =3D closid;
> -	ret =3D rdtgroup_init_alloc(rdtgrp);
> -	if (ret < 0)
> +
> +	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
>  		goto out_id_free;
>=20
> +	ret =3D rdtgroup_init_alloc(rdtgrp);
> +	if (ret < 0)
> +		goto out_rmid_free;
> +
>  	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>=20
>  	if (rdt_mon_capable) {
> @@ -3061,6 +3074,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct
> kernfs_node *parent_kn,
>=20
>  out_del_list:
>  	list_del(&rdtgrp->rdtgroup_list);
> +out_rmid_free:
> +	mkdir_rdt_prepare_rmid_free(rdtgrp);
>  out_id_free:
>  	closid_free(closid);
>  out_common_fail:
> --
> 2.30.2

Thanks.

-Fenghua
