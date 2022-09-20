Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365815BDED4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiITHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiITHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:51:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459D3880
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663660272; x=1695196272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/q0F2t5Vb2RHqeD4Fe5PkZk1Up7UJk/QmMZtqI7Q+zc=;
  b=WwRnh3PnTPHdnEwMzxtaC2TWK66a1vEdFCKr8LM2POtYft/OWiQ4HwF0
   LTvGCbnsvM7T9BnvWSA26hwZ49+RVZiAc9kU6uSjcJbNGSl9RBLqn/6S1
   /zu4+epWCzUdoCXhwyJya+PG3WfF7RpBDdO5nGO7P9PS9+i7fEvflwVas
   qvObEIukM0e8dOlhA5voK/tkdpqa0C6cW7T2NdAC+mNmXlUp1BvuG+FKe
   LgaJUMIUWGpGaAxFdyshcQ2oncEGOfQ6OphCtqEwiHJ1OeFSCZtpMojfU
   qT3FJBUR7KrpkwRe3za8std/5HoLHRy1XPlitlcg4TtiTdDbqb5B9Zy7v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299616714"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="299616714"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 00:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="651996487"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 00:51:11 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 00:51:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 00:51:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 00:51:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7e8AvJZ5ozQuYWYkIYzMHGRSsPcoRSkuV7oaiVtC7pCjk/1vJa9FpKZYdE61s9SPAjZ27HchWJ7T5sp2Ivf2Yt3xva/ygT75USZlrDwy1TYtH79/ZrbgwSz7jP5IvXvUutGI/E0lgamnrYwbmrNzAh+F/FH6zz/uWu+Ca9D04clcFoNQqVupfMeMpFGJpvsHr5oDYHnwQNjIoW87DrZNbWmTFbA55HaZCPU62PRshAbRY3B+jltt6b9xT6wDBuI5iPEVIjC513miS9GdXAGX6CpzR/CcR9MZsaLrmUSeGD9JMBNhJvNbBFyDo3d9n1Wbb1LCHdus4ShYSVRmKwz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnnNFugPXeIZJCCAVFs2RM3EkIhR8exSWgbdba6lCG4=;
 b=D8YUm5jGj+GmUTulrg9LgHxUG86c0DPoS7ul/Ow4WGDdEgu3Ge6fJvE1YR+wBikgOx4JjM6SZFop6xQx+n1wEg6s19XMqPtnOuWbJNdqvfQ3v4xpcM66W3h4ys1hutq/JJPB/dmQ6E+uzkmw1fgGBs+6Cs8BoXS/qQeU96/BhB5YBAEsqtyK4vOJm+5jtbW2gHagTPWiUz3GhO3Of+6QkK5yVW6Y475oU2szKrePuWw91vq5e9uhwPkEw1LvMtxM53tyZrUv3LoZpdiqG4G4ngf1VXj54gyNHtbOutyvma9pmZnowvkEaNKS+9n9XY4hoWB4mv9qufroUtu62PyR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5705.namprd11.prod.outlook.com (2603:10b6:610:ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 07:51:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 07:51:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Thread-Topic: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Thread-Index: AQHYy/F3/EWalWXJdE2oiCmU8rdmj63n7vnA
Date:   Tue, 20 Sep 2022 07:51:08 +0000
Message-ID: <BN9PR11MB52760E6985B16235A30B57978C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220919062523.3438951-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5705:EE_
x-ms-office365-filtering-correlation-id: 48487a9a-3a5c-421c-778d-08da9adce0ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4prxSaBEdnWW+UFmFwq3S/l8HYqkYxbrepn/PKj60+Mf2JHQ9iJDNBidFZJ7CnUek0op0eRlruJBEKKMXKguFoCxfo1TPKaqxYElLm209PyrPcVXj/TAFgCdoRP4GAQdsaMktas70Gbfhkv/CYHFyLSh9mtIBlMLK8TDG+w4cHo7uT38ss3AL/n3MC3nGV2s3+kYrGoqfo4tHEXPMzZqXBxzCP/c6ra/4A7vvnhW6CG78233CkuBf+qcHkNoc/KdAEbN81Quf0tqHcoRCN8n4sXl8icmsHFs7c2t3cVrL0mXKS7I79a4L2qo7fdi7y17VB3MGBlVywsaztC0JjGJupQZ/8HRJoLTh9/wPLIPEweLcWAxZEJBjwD+fu59eg7inpAGFAFniDQ3NLEwBIdcpnY/J33zbIAAB/Gxa8OnNINuYKSRq0hFBN1CaP6AqMlH7VkW6pKYGb7AI+eS3otyKyOt6YtNFQOmTHpmkJ9M3B9zcLzdT/ZnD5lpvbj8ZYtrt4KQDNIt9aYMgQqWDxSLFiHy958655IRLPBbZCsUaTCp6/KJ6ITzWuEtIqcszppBO+dX3hlPPIaUebdsAjNvQom4YztIMhyIbOxtsbKkj/6/cNDVR+ikIKG5vipYWKDgO0dRhm+fVu1YdnR2drlq1rUuVx5KEl+eLGO1DqkKBZEtitZ9T6yJz6VQxCiLWPZPz9a+B+cgsWPhP7BMLkRsOudaGgidR5KK9leEehgXM7T+pWgAr9WLMAvEuvZfZQ7YOJGJp97NNGdEViNF5Q7nPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199015)(38100700002)(110136005)(38070700005)(54906003)(83380400001)(86362001)(2906002)(316002)(478600001)(9686003)(26005)(55016003)(7696005)(41300700001)(6506007)(71200400001)(33656002)(186003)(122000001)(82960400001)(64756008)(76116006)(66446008)(5660300002)(4326008)(8936002)(66946007)(52536014)(8676002)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gIasX3DW76gSqhASLhFAusus1+Fy+6+RzM9b/D7BeH68UONYN/uZ9wrAdXHa?=
 =?us-ascii?Q?2KtfcxVlUPQ4DgHTJvpN8MvQnDB+9dSDvEiOjwyoBi3p5FYt3xYja8vhlDzM?=
 =?us-ascii?Q?GnXfmajLlH/4tJbgjwvkteolSAHaWnO+LIiuudTEl5W81tOl5DVoBnyw714A?=
 =?us-ascii?Q?DPFLBeEqr2+tGfWrRdyXqzLiWoK2m68wPrxcOpCMMMdHiLbKT83V9TTOLFkA?=
 =?us-ascii?Q?zSDQLAHy7ywrP/E8eSpMVLwdjswqSGeXAF37SNUkcfY6baaeag/XVSh2nY76?=
 =?us-ascii?Q?pyY355SPs5fckqUknO9DS7vFpm4k9JFf7XTsWhlpxAmxfBhaYRe8N7/I+XNf?=
 =?us-ascii?Q?gmHhz8wMMwNmAY41Y43w5UIKi4wpYNXklLg0RInQlD9ydhTwYPhU+OlNHvZZ?=
 =?us-ascii?Q?5IGcG/kS0+yEsgt3jM/fVFaWcfh0yIa2Uhg+o2UfEgCtZH1VQZSHzn+nZLTV?=
 =?us-ascii?Q?E1Somv96KBtpc3zAfkuEdWQuBkNqyC+ve5EmJgnOnknWDZCPkvR3wW60q1R/?=
 =?us-ascii?Q?a5N9PRn3OLeaGhdxl9QD2y3GOPojkgP3TgpWb0AynjZ2Ms/d+0ETslu5hyRl?=
 =?us-ascii?Q?vc/RlqCkd6LoS6Id2fhHDqzNMF3AwLDVkWbtZeMaLEfCCJELot2VYaD/ehF4?=
 =?us-ascii?Q?lVPps8iJJWv5sn1vxPk6L1AdtF62tTdFUMFvPls5QQVx3vvdNpGHu/Fyua65?=
 =?us-ascii?Q?Uy+Lta4LF16Gyu5+M0/SpKxTxa760tXGDRQjwApPmvmZIKRXPMjMcUAqUNQA?=
 =?us-ascii?Q?JgjicMvNfADLetNZppyck6y5i512jZDeI9sVusYe9oap8QIk4+jpuchINLyO?=
 =?us-ascii?Q?jSKqmISrkSs3PzcvE+EBp2m4Pk32zMrUe5v3omRt1HSzsa/d2zUb3OGwDtG7?=
 =?us-ascii?Q?ZO+FQNL/XnIpJGvKtOsFLnojkaQo5ju1BonKahciSkvf3c9XdKR/edoyfBjb?=
 =?us-ascii?Q?bFsHyOUEmFgYWpsLLafDeX9rf/y3G87BeHj6sAS8qZC+XK/KlhhdZuhoGBp3?=
 =?us-ascii?Q?o+TagbTVtADXxm8bH82Wo3l2zU09Ywu3hcBCZHnnChST0VMF6Cm9zFHfJYzQ?=
 =?us-ascii?Q?gJoqf2L9B7kz0gtlLuolC9Qlr0ODvkE7urcrgz9IUC+fAs5HrLCAIgoBJkHG?=
 =?us-ascii?Q?oX2a22NDV4e0VLoYgtamjMsj5zUPK8ZT8gQ9XkE9Woyz03R2VROI3XAeJWyb?=
 =?us-ascii?Q?fmcOhH1pZBlGOIBcbAXImGOZQAJ/FjGxg/41rs3GW0GP0f2mmPII9lfG8UWW?=
 =?us-ascii?Q?Cn3ZIhwepYzyDZrVah3WaPluOSS98BPJ9j1arD68jCxGNyWy3h2OaVY8JlQC?=
 =?us-ascii?Q?EpBnIBFEknmT0FfD7CY+i8/nZEOipqQsOSCZJBA9sArYJ1xQ8Os7lZ0hccQV?=
 =?us-ascii?Q?u5Vb26xaDYSvlqIj2Js1MyMi13hYLdz8ZGSMUFxSDzQrVAFKOHV/LosaFVX7?=
 =?us-ascii?Q?0+KWDlDr6dEMzi2rqAtauwtsSN+0bmG9hLPulWYgumoC/6t6R1OWL9pFMJOp?=
 =?us-ascii?Q?R0JVHB40m+7vrySOnFGON25JWrZXJ/h5vytlPKsOYvlph3vV/q8jJgLf8acd?=
 =?us-ascii?Q?1EtkQaX2tJXiF5w43MJlYLW5X+Vqig0lDf8wAe6w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48487a9a-3a5c-421c-778d-08da9adce0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 07:51:08.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ih14btTbKu4LcnyLKz/0PHY/HicI7G6o5XHBAqxDBMsfwMW2COv1O9pBMikQPOrbYAB0YeP4DpqNke4RPCEiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, September 19, 2022 2:25 PM
>=20
> Some VT-d hardware implementations invalidate all interrupt remapping
> hardware translation caches as part of SIRTP flow. The VT-d spec adds
> a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
> 11.4.2 in VT-d spec) capability bit to indicate this. With this bit set,
> software has no need to issue the global invalidation request.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h         | 1 +
>  drivers/iommu/intel/irq_remapping.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index eef1a166b855..5407d82df4d1 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -146,6 +146,7 @@
>  /*
>   * Decoding Capability Register
>   */
> +#define cap_esirtps(c)		(((c) >> 62) & 1)
>  #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>  #define cap_pi_support(c)	(((c) >> 59) & 1)
>  #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
> diff --git a/drivers/iommu/intel/irq_remapping.c
> b/drivers/iommu/intel/irq_remapping.c
> index 2e9683e970f8..b4a91fbd1c2f 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -494,7 +494,8 @@ static void iommu_set_irq_remapping(struct
> intel_iommu *iommu, int mode)
>  	 * Global invalidation of interrupt entry cache to make sure the
>  	 * hardware uses the new irq remapping table.
>  	 */
> -	qi_global_iec(iommu);
> +	if (!cap_esirtps(iommu->cap))
> +		qi_global_iec(iommu);
>  }
>=20

Same check is also required in iommu_disable_irq_remapping().

The spec says that:

--
For implementations reporting the Enhanced Set Interrupt Remap Table
Pointer Support (ESIRTPS) field as Set, hardware performs global
invalidation on all Interrupt remapping caches as part of Interrupt
Remapping Disable operation.
--

While looking at that code I think it's problematic to invalidate interrupt
cache before disabling interrupt remapping. Presumably invalidations
should be done only after a configuration is changed, no matter it's 'enabl=
e'
or 'disable'.

Thanks
Kevin
