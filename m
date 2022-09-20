Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889ED5BDD76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiITGjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiITGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:39:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E05F11B;
        Mon, 19 Sep 2022 23:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663655908; x=1695191908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g+4lU1YmHASVEX/F0Cmho+Fih+NvVfmXqcZFKe13s+8=;
  b=gOmZdKXTkVNNldpyT5wttqglNq/j5KP68k6YuZ9xExXZPDJE7MeeJYfb
   7qEQ7WcXDNcd686lk2oGUIgmhrW7TZDAvG/r8mFNVaTGtgTsPc7uDS/NO
   gRijDIVJBbSHBid8QWOdrhkIHX+xFKIaTEoAR0tq5427eazsb397kTSVB
   3vJxVQY1APUKhzi94msF0iwzghI+PmloG7E3uFAPxTi4wq+osGDEcqOkC
   VVw2ZWRs3GPvPs9hilL6LlaZgpNSl1XyJndlZ/z42kMfs7XEw8bWzttSD
   O8xYxhI/Rt1dGQeb0x16QF6QEfehpEa8hy9uqKfSjbjpuHt8UWBt+vRYF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363571888"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="363571888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="649459959"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2022 23:38:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 23:38:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 23:38:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 23:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvxcdHWofyMzWa3ko/9Kg3PCH0DiAJyCAhYalcAhIddMAcIvojXhj7HQD7E5E/u0w2PXEoX8y+oiGdtCL/3NArSKFE4k2HUt+BrFaj6ZODupzFxf8TgjjfjQlOIpVu3GJyTsRKi8NMauxSZY8pk1H6tLwkJAeQ+fkAuau5oIIXJ/VsuZKU6iwiOzDcvGPaDG8VPQvQQP4eWruWUS7XvkcD0SOnJIRYg3+l3BQP0AzQGZDqDVeaq94aA8xr1zYtD3Jn4xk2ydO589gXjeDSSgCgrwvD5HqXBl6JfeFOHGjaQzHjddQdu+JgvGxyVwBcKG9pmlOWOixF33HGlvdnCdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/s2m0kBs7NsRgk7mNaKYHAgfDY0Bt1BNE4WSeGKZrA=;
 b=MUD5nEKiSYEEPU/tq9C3M84R2N41Ke6F8OO0RRruic9w1YOQTdiB7X8aVhc0rxXb2ESBmSpyYuwERU7CKTPwwE2E0w7Lg2c9zUUVOJEaQbJ6V3KJZNrEPrdz8cAYVXr/oOic62fEHzED0CvI8X1KfqFxSKH4Hcd+yRVNmn2xH98KfdU50BFNpagDSLckFORSRX0wA7KdCanz2abwWDR6Sej+BlCkRpbT09+VzGKwcIrAeTIeKsJxmQiU+K6evgZ76Zj/vcMHkBA3x1KUL0pDUiAPRhKs0gDEfmjHyjJJNXjyuJH0UT5cbzN1+1WVdIFL6rrjPpXxt2cDc5nqjPzblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 06:38:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 06:38:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v3 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Thread-Topic: [PATCH v3 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Thread-Index: AQHYyNhbGOlsL7Jv8k2J8zrFcwHpQ63n4xNw
Date:   Tue, 20 Sep 2022 06:38:18 +0000
Message-ID: <BN9PR11MB5276595A0BFC49F096C2D3968C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <effc9efd2160ec19500e1f4c59799991f46674c8.1663227492.git.nicolinc@nvidia.com>
In-Reply-To: <effc9efd2160ec19500e1f4c59799991f46674c8.1663227492.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6690:EE_
x-ms-office365-filtering-correlation-id: e2e35ca9-fdea-45e8-1e16-08da9ad2b455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYLWD3yxYu25aE6HCnmEqu7BBRfl28ddX3UuwkZj09aq4f4oLYHcCCpvR580w5OjTb9JWLiP91PIg1BjLTOUtvFFTwPscJYFDIkwYDQoBbsoWbdej+EtCTRow/Kq2pArGvdv5QJKpAj6QoSlD1BBX6bEMArFn7HRBZQU9bRwMnZCuKD17VG++NSh/1d916lyVAI1qyrkLHJgNy/bxCkvPdiRv27u4kZJapne2cDqljV4i2sYfvHie1b3UgW2u2iGw77EyfelNks/6InvS4DoMJ/3Or9d3w+NMgz1kUjj1m3bNVp6g1yRpZ3zA3DxghM1qqLsaRmKrHLAugNjoswxfW1fq7SgD3Tx1d8Uu95E9S6gYxszL/5UC7LgZWIcCoHPlyIgNZhVZZbr+frKYr0x2BwLM5SWmKExCL4dR7Owr5MICo+juYMfrYXt+m7C6HD+y8ZLf1C4FMxj38/DNllmlFeSORP/fBt31QxBgRI4XYDj6fUtyabBe8WLb9o/M8UPzHW1JjID7srDWXSbMnZGBpAwRmnPMEh8Ohj+HM3toKHukBcSPwWnhyBpdy6ywIIFFpoN5/COrnN0GnJIiSgWoMagmDcxqNOZ4wdyrYL6hrqfVgB18mBi10LHFKrK9wB9ySG4+DCQ5XuIt1wBuyMxaWHdq2wHzsrPt5q6k7++kDvB/iZjmD5t8rUJYL7FFk9Z2UIGJehfbAhKmMnN6YeboWkedR/srcboExbLqKz2AKRJ6imUeJ0xcwTnBuC49op1QwuHQt57RyRj5ar7WAk4WPPKReRSPpYw9vxdWZwUFxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(86362001)(2906002)(52536014)(54906003)(5660300002)(110136005)(8936002)(7406005)(33656002)(7416002)(83380400001)(316002)(38100700002)(7696005)(38070700005)(55016003)(26005)(9686003)(82960400001)(6506007)(186003)(41300700001)(71200400001)(478600001)(921005)(122000001)(4326008)(64756008)(76116006)(66556008)(66476007)(66946007)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12ICoAT5r0EUH4rz0uC6CAYBXZ2rqe9cLUKqNHlS1aqCHnNS3yaUhzlKcGJ6?=
 =?us-ascii?Q?tMOWzyElMRE8at9i6GWdPg4Xh0EUJwN5BbvKIlH/DTD7Fy66Uw8Vwo3pShA7?=
 =?us-ascii?Q?ZHS9a8DXRqBuJ7b8xkYGNmNzkXPC03Keq+HmaDMVzquqIT5bc5LrZZFlf/ov?=
 =?us-ascii?Q?t50+/f3gllW79tZWPuMbwI9l1M8Bx/Sj3NIqINC5lHDSbbB8q0l+52GmHxRB?=
 =?us-ascii?Q?m3rQ7EhYvKOe+AbfiHJsHsXNgLf2KQWAjsh41Z/SfXwRJu5l4KXMpZPQJcj/?=
 =?us-ascii?Q?/AGS7Af4mJ3hfAVvqYGUVFH++jay6z1rezwuY716egWPkKE6O1ZBRbSoO5CQ?=
 =?us-ascii?Q?RMTp9ru+4tyxiOHYA9JzL0HooIn1RqHZ2hPnDkIwEhgth2E+jR2E1pDKbIce?=
 =?us-ascii?Q?baCg8K7GDxwbI8t0G/d/i35dFI2S6QBszV8Obz5Dbf6GEZInl+IyPCWMoyPf?=
 =?us-ascii?Q?w0TepnxqX2Fn6b6Gvn+S6YNVlt7SG/gmShyp71g2XIDCrCxGNnTPUVNFttDT?=
 =?us-ascii?Q?2Bh4EJ0gI125FfW5q15DQNqqACyl0amFLEafclIghugwFcq4GdHyX5uAnIRe?=
 =?us-ascii?Q?zvjFf1tEGEfivm0naMHivxsDJ4Zk3BuPvjiKadyIZFAvfdHiX3PGEmt9qrmV?=
 =?us-ascii?Q?1svo4rOjLXlaOHA6sSyKu8SJAdHEpRrkbh8Ha3+NGjfC09NJ2A/2MKY8hfOo?=
 =?us-ascii?Q?SEXfLB8ErPrytJcYmZO6Kz5Rj+6xQX0x+kA2nvTBJncQHGW/aVQxHUa93wQg?=
 =?us-ascii?Q?DKmiU5X1j5d+eZC3yQvDbIu3Y+TNqGPp5zYosbvb5SZSoB9bk4sKaboaok5W?=
 =?us-ascii?Q?UERj4Htn2MD4D/W7q2fd7EOsRShVkzb7YrdWMScHtAk0r5UZPkBF0Dp1HLy8?=
 =?us-ascii?Q?pgfhu2KpCiM00uH4aj3+1ScZqfVGu5lEaf9Um52q7LoUACiz+h3M7MwTuDlc?=
 =?us-ascii?Q?DNVmz1eIjzjWi6Ba28gGcfvcgQWxarSfvS6/gChn+iB6UBFjBaWQLZqJTSLw?=
 =?us-ascii?Q?QPgajcCwoIi8g3V64beWShU2IH9e5p3YdFlaso2CJN94atSS02CD5AL8xaE4?=
 =?us-ascii?Q?li/ASwtt5UCK0xy2/z5NeyHWgJNa73ZdZZxpsLHWhBQIGz9ZU2fOLs84raaT?=
 =?us-ascii?Q?i6jX/T8+cnPUqTypl/S9U/MprI8vk1GTJ7nMQWQehV8LQc9UYxm1nE8j6Daa?=
 =?us-ascii?Q?wjJWX6TSOjt+ga7Q+VThCcrztbW64F4cV8BssaioiDD6pwxHigprOMBstbp7?=
 =?us-ascii?Q?H+h1z9RjtWe8O/0tTPvACh5CFIOnAczQDxA+qt3VxLsYXQFSc8SwuIB3/LUo?=
 =?us-ascii?Q?vvd04D7Fqop13+M8UPAJck8mC08v4WMlo4Zs2h56P33x3E318tz7XROs2gFg?=
 =?us-ascii?Q?2bTDN6Ml0OLJLQHdTIpuu5jWmQhiZ9jT1ychQKoHc96Zzleffku/ywXfvTit?=
 =?us-ascii?Q?mk0MBtpJ9hIZWgpuOGPC+f2SBL9ci9yQ9XTTNmdNFJrCPDJi1pkHUedZMC2E?=
 =?us-ascii?Q?Ise8NyBiICG2Pc084NzKCPU2gQr/wBDQSWJx5VeCwruygrEd2Nd1oU0YdZMy?=
 =?us-ascii?Q?quVuliQfwi5IafzYoeSuczaF8m1s6MbIwhWvdg4U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e35ca9-fdea-45e8-1e16-08da9ad2b455
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 06:38:18.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zb5V19gr6xpb3wfBumYOoSWbBeOVT92yKklLuUEVORHLLqMwQ8BPdyntuIBAqqhoGFcRSFBgr+xzMlf2aALLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, September 15, 2022 3:54 PM
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1f2cd43cf9bc..51ef42b1bd4e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4158,19 +4158,15 @@ static int prepare_domain_attach_device(struct
> iommu_domain *domain,
>  		return -ENODEV;
>=20
>  	if (dmar_domain->force_snooping && !ecap_sc_support(iommu-
> >ecap))
> -		return -EOPNOTSUPP;
> +		return -EINVAL;
>=20
>  	/* check if this iommu agaw is sufficient for max mapped address */
>  	addr_width =3D agaw_to_width(iommu->agaw);
>  	if (addr_width > cap_mgaw(iommu->cap))
>  		addr_width =3D cap_mgaw(iommu->cap);
>=20
> -	if (dmar_domain->max_addr > (1LL << addr_width)) {
> -		dev_err(dev, "%s: iommu width (%d) is not "
> -		        "sufficient for the mapped address (%llx)\n",
> -		        __func__, addr_width, dmar_domain->max_addr);
> -		return -EFAULT;
> -	}
> +	if (dmar_domain->max_addr > (1LL << addr_width))
> +		return -EINVAL;
>  	dmar_domain->gaw =3D addr_width;
>=20
>  	/*

Above lacks of a conversion in intel-iommu:

intel_iommu_attach_device()
	if (domain->type =3D=3D IOMMU_DOMAIN_UNMANAGED &&
	    device_is_rmrr_locked(dev)) {
		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platfo=
rm RMRR requirement.  Contact your platform vendor.\n");
		return -EPERM;
	}

since it's based on the domain type, picking a different domain
may work in theory though it won't apply to vfio which always
creates unmanaged type.
