Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2B5E5D36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIVIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:17:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA683AA36C;
        Thu, 22 Sep 2022 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663834627; x=1695370627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7uqf9ZiKKVhxjvWokPqa/geCJgRrne8PpFucdVEJ0Ow=;
  b=RSTEeS/s3GDz9QB/XX/YIyeZ8sxUUrsyEnyxShFIB1GCS0FDmsMAre+f
   u0vDJNJ5vYtn0LQVf+i5t2TC0D9QQKDlj1g0Zsn78+HYApePO676hi7Mc
   KPE/jUafcSVFqISKLIuL++nq6encVQGizn9NCRDbxplOpu8QrzvBXgV6e
   8s213B/RBpOa89qXDlV4wZ73vTILurVsRVgDqlQF6uqeF0sw2yf4w742x
   6aAj6kT2CLRMR4KzXQzjifpK4RFphqiuEk1MyFCxmHuLrpLnQVxpOT3hy
   SsRZ/hMvXF6tWXaFtQFRHCdCgEU457JKNA70AuuFljCBzKft28cXslYCI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279956405"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="279956405"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="682120403"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2022 01:17:06 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:17:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:17:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 01:17:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 01:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPnfR6cij4LpxSxD35DFTpYRAuLZsrE8voYmp9RFXUpjSW4FiPwHt2M7BEARF9PJxW3I04R4gFzxWWkvU1I5MbKhBitQHTxabhwh6rI5Wax+oWu2WtqkufusZRgLKFwCzh9F9/jKz71KNMS2IsjHIyTkwhox6MpdbERKyo1P9o/f7KSSiB2EdTzSb40ow9Zn+KN0BKX9D6QaaDEtERViWlnYVxVD174phXN921fXWjUdlbvvw0XOIB8Ok2VQArjT3QkEf8frjP6S5rhPAE80XZkK2q9wfCJWBFXjHUaH0ned1+JsmYJEBX/DpzUNi2mm8xMGAacA7CPm8GJeuf/4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uqf9ZiKKVhxjvWokPqa/geCJgRrne8PpFucdVEJ0Ow=;
 b=RT4EBr1OyOv9H2GNjEg09n63pGFzoBIedfA+Uyh6BW9TCfe5tXalt1NTjhgXngvWsRRHXPWHvZ2C6A/kc96DXiM/jD0/UUNnO2esJfJx90QA3qE9oI5nl3ElVJRt6Q62UmyFvx5v2vnNqjQFY303Cq765b0Q703+3I86QEkeVhsleVv3mFCwkmvKikbSiDBfbIaAdBS5MlSDQ2BLKsRXlx7zqHjJerQowetP4C1ZQFYBAIBojtxw7oM6kTDdUUMf0CPHknU/CGw5Y681bIltt73hjZj3KKvFoRLMjKak0nYPybALUfLbcV72keGhU/8Kl+jKEJOFxd/cNwu2dx6UPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 08:17:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 08:17:04 +0000
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
Subject: RE: [PATCH v4 3/6] iommu: Add return value rules to attach_dev op and
 APIs
Thread-Topic: [PATCH v4 3/6] iommu: Add return value rules to attach_dev op
 and APIs
Thread-Index: AQHYzZN6ZQK0d0lv/0aG9snUQP1bO63rGkjg
Date:   Thu, 22 Sep 2022 08:17:03 +0000
Message-ID: <BN9PR11MB527632E5F21AD412991509458C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
In-Reply-To: <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5989:EE_
x-ms-office365-filtering-correlation-id: bb73864f-612f-45f1-9ba9-08da9c72d503
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0yihMkRwN03hdj7kBcFHlFAc2ewnn29VP9LSF00mwfstNbNGgZgjaT0G8dygILzHPQtxi7+xW79xuuzSk8zutAULsBtXVgwwqD37jHFKFwdyFmsmRHG00zW/aQ0TP6AzrQM2iUCXfjIrY41W+A462SFK/miWXjxjH9jhjCayicd0K/d9uCM8pFRh3KPUF4O1krVgDEfzeH4qAGnzfRuST2xIvqrVTiAtt2rZBJrocS/NBWYkJRvY52sQ+yBuxh6iqFn9pXyRONc17As4OOwq0HMIRW500+zQkHswOwyAwsTd110vhpoFFAjHsncjcLXy9gQjqL+ecl5mkJ8Dh++hvscghTjsuTggtCEW2ocAuwqvh/+EEkM3nodcfDG2+LOypHKOUUOpwc9uFc1GaikzHgFHXRevLxt7WyaH8ImqjLIl5sisDwSAzVUvOTPiTnZYr4xQctjCdJ/eYIxuXCccK3Y1aMTLdqXkZ8e+ueEv/Mi1rOmei0OOi/Bkkq8XlHZFk5ToQHxEDGI37Rxyplov7TzyOdqTtM5Hch7YcYzvCJCxURHNKHp+zVy4ac/DAGQ+tj+neKxtYsw9L98gLO9cJjq73bVYLyqcYF7+KJCCin01CVDjcDdyQJwaCy4kbLGbuvPmBm7K3tX/fp4YJbo049K1IJjStglvvwwRNDAc4dppKM8XM3YZhXnWzyk6E+85C+6eP+nNniVtN70PaLVj8+JiTKv+so7kGP43SVDgHbsjtoL6MlU4EU/mNBj/7xWVFMbfiTgR+llGoB06/UGPB/EnkvQw/I2qsbVw0stWm8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(8676002)(66476007)(76116006)(66446008)(66556008)(122000001)(82960400001)(4744005)(921005)(110136005)(54906003)(55016003)(5660300002)(8936002)(7406005)(66946007)(64756008)(7416002)(316002)(52536014)(4326008)(33656002)(86362001)(186003)(83380400001)(38070700005)(478600001)(71200400001)(26005)(41300700001)(2906002)(7696005)(6506007)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HKkscBaVo75It3IqUo+/D6GNuWIO5yxjuKnDOj+drWIg1uzsyqsBwMV1VmYg?=
 =?us-ascii?Q?8V0eUJ7pKusyUICSeHIkZZ9uAQO33YGrhRGU6+q0/eMgSal6smkf/AFsbnYI?=
 =?us-ascii?Q?vQ1UdVy6cITIdYQBuNR1utmzy+Db2iMCVRMHiH4W9RNwb7Mxx8pbtfupBqu9?=
 =?us-ascii?Q?ol+KJWtucndGu/Lq9wRXMf7DM1W/wsvGzhUGxjtmsdFpN+/ok4OgR+QhNw4G?=
 =?us-ascii?Q?GjEh85ej1rUYboz/DdA7DtimqnSntUJfZCcA08MG6wFJN4Cd/oZB8jcccI44?=
 =?us-ascii?Q?ccs8nLsNLcZ4GpdIMzh2sZv1rb4T9iMYJDXkuWO66zxxz2phyO2A+vGjtUiC?=
 =?us-ascii?Q?RTsS5n/fntqV5mo/J/xDmyNQzOhQLC8MldmTIFvQM2qcH4YnNEqwCu5FPb5y?=
 =?us-ascii?Q?kSXHs5EaI+lsm7GM8ZLSX8T9uCW0L5EEtRJVRmMWfAYJg5mE+LbzrnOCnGe/?=
 =?us-ascii?Q?84G+q2XNN4plHBRYaPZu5pzO7nIhJzCZ6afo2GDWs5GBsC5p18oXHrHLPiyB?=
 =?us-ascii?Q?JCQBBZGcrJ2XkYMIR0BB7aHRFvRiMZUL0y2J9BXJqOXQPA1PU8ovZjxQkLa8?=
 =?us-ascii?Q?5CpQMiDehra6nf22qQe5RKSnBTdcTR+FUPPjtuW36v1PW/D3RY3h0SGcdjW0?=
 =?us-ascii?Q?eFF+RyPWrTgcOYIKaQrZub+iBp3lkeJHRF360CIFfNkEA53BxHdCYy2I3UKM?=
 =?us-ascii?Q?odub6iklfjoQhWQdSiQ29fkD5maqQfOlH89UUq3IaUaNjXhrH7nR67o2Nie8?=
 =?us-ascii?Q?KdrlFwunrEasRpW5FrTBsBsaS7B6GIDcDomrdgoz9X7Gr7KS2vQp30ui5MJv?=
 =?us-ascii?Q?L44lXIhJ9dEAGKOuwHB8tYDnJejvafLACJGDMmqoq/ykvnx1v2DiNJopiDyf?=
 =?us-ascii?Q?s/LIkds76j9YosqCylXJBlMf3ZFWXC/hbCfvJtBLqBG825SV93PkokPkagR4?=
 =?us-ascii?Q?hGbmuZDqJfZYWVvY90vbzrnaaUcfjXeqheH7TvgwPnfKjfYnSk/9l1IP1GI3?=
 =?us-ascii?Q?E1uvfWjkxOvImuqA7pvBMQBK02MbrV4wRCj+dqp4NOxJjK/YARJUTqADRSmj?=
 =?us-ascii?Q?8iSq8BpKJxXG/urRJEumX/ZTdKCFX1Ti9b9KXsdvhoT6bVjX1XJesrFSudnA?=
 =?us-ascii?Q?GVCV7mCPRcuogHXRfUjUP8afUhyrYhbOsTUxJi8tyaufAwM8ed5n/0I4ypMh?=
 =?us-ascii?Q?om9ZYwTEZDfvICXF4EtrV5Hk19GGgH/xKed1Q0/AfpdxAW68Mpyd1XmqIHz7?=
 =?us-ascii?Q?lHqdaqXH1egePnIQrfJW0WO1OePEbjG+jLV/A0PH1MSQsY3jql1V0TH9q5xM?=
 =?us-ascii?Q?djT/EJaKU4pCajdsWNvsLAZSkNpmU/U4S8nxC55tdZXbOth+Y8cDt22MQX2W?=
 =?us-ascii?Q?hq/4mO8PXJoc/lYzO27IeJa3D+bKvt++Q/gcMgF/76hmLt0THxaJb2dthDOP?=
 =?us-ascii?Q?/HFSEzMe+8IqqzXsbR0KpKjUVYSeDhFZIMBvR9hoPWsRQ3tX7XN0iUvNab8e?=
 =?us-ascii?Q?p6AOwGU24Pxa+epUgWGitG696RfPNIXKrgMAwh8AP4Ots6Ph9iC5/HdblGnZ?=
 =?us-ascii?Q?p2IoFPWzQ6P1Nup0QpSsgw5mPGB3Zur3yPpgJMAu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb73864f-612f-45f1-9ba9-08da9c72d503
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 08:17:03.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzlozUEBt6KwTh96SenVWvzhrrlN/ldexvxoHdqtVYwV5ASpMuSm8rcT/NSrEFBmjSfOCEcJ5tI2gmHJp1ouyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 21, 2022 4:23 PM
>=20
>=20
> +/**
> + * iommu_attach_device - Attach a device to an IOMMU domain
> + * @domain: IOMMU domain to attach
> + * @dev: Device that will be attached
> + *
> + * Returns 0 on success and error code on failure
> + *
> + * Note that EINVAL may be returned as a soft failure if the domain and
> device
> + * are incompatible due to some previous configuration of the domain, in
> which
> + * case attaching the same device to a different domain may succeed.

Revise a bit:

 * Note that EINVAL can be treated as a soft failure, indicating
 * that certain configuration of the domain is incompatible with
 * the device. In this case attaching a different domain to the
 * device may succeed.

Apart from that:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
