Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A716A6FCDE1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjEISgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjEISf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:35:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728921FFA;
        Tue,  9 May 2023 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683657357; x=1715193357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bv3kHlCe3S6QGoNcfyxBsNha/dIV3FKGpKQhxUAfOTs=;
  b=OkhnyOen0xt/9Sg1W8mj7Sniy5FjA3PoD7KVSHMp4LNe9yeBwDjF1UMc
   wggAEhz4vf2V4I58lWlzvGmjnWpnZ+NfmnFClHb2OyfHjtOQ5v58W556r
   IvQLCyKNY2hvJ8ZRwJ3Qf5FRas5egv661ULuu48QOJ+4iknJRnc8Fy+8X
   43SISUxSkb7rozLL5gW3RhMe1bNaXu6GqDeMzibZsVCvEcNVz0VtdWetE
   KjDnSy1NVxYMCOIdvHZ9oBKov6lNWYTu5hsL9VLAQxQPnVkjKIsNKDpT6
   qqHJ+zx1pZ9Hq7rwx23ExqYZw5fn74eSqZKKAI+ydiSxvYxAJyX/ZbINN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="339256183"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="339256183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="731846994"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="731846994"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 09 May 2023 11:35:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 11:35:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 9 May 2023 11:35:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 9 May 2023 11:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjG8PJ36LTcJgLBgIduky8kPd9QqFgrg6vO0vThIX86au6nWHgzwbBTUZnWVjaQtLAZ0wIHNyZbPIVG9HHd+TuE1CVSkPOTxfpz0+E4u0kR50anY42/NKY5IkwWgDAQfiAcU6x8IB3aNGXj75h7rXgAj7vTH02QJbQxad79MZH2ywgAewso7jpGYCkHpiOuA40Jxv1i5SzCYWKRANyGHLdPK+wagMrAR+ptKStTPEdFy1n6BR/ZenQ0vmJGX6Y/Jxz0A/BmdvbB77NL+xUF6WTq5Bk5eqQZLIg128rfNcZ6MVpd33boAlXlq36jgQtDvJLbrBRURQC07SkfE5rdjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv3kHlCe3S6QGoNcfyxBsNha/dIV3FKGpKQhxUAfOTs=;
 b=YawMju2fTUjtE7QEwai4+59iBE7ET7twp7Dy7z3yuZCwRiHU95CUz4MIlilT3DGJ3Fyz7Vw7aiLyPjtTvxhqTO/Bv5uwnSbOvdR+rtNMPLCsI6m8xGX/rvg9Yq24X3H4dUM1Fv330DJxEe7dlmqRfSwWC5W0qpFg9NTDoUSlL7l6jXxeCGvqv4jjO88kcEDdi/kQGmzQjnJpvqk+PmL0ePlfDCv5laaS9KR+DaNUH3kCEklVbeFsmlEdV7bannagApiFuf3Q0Dh8c5C63vgHdI+ECdANqdTnYFuku36jv4LYGepa+PP2AVmmi+NSvRaLjvfI4aUonfh3zvmK0Z16Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 18:35:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 18:35:44 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: RE: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Topic: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Index: AQHZfoz/HoY7ASH3bUeV4msZv1/xf69KTa1QgABJGICAB3OngIAALJJA
Date:   Tue, 9 May 2023 18:35:44 +0000
Message-ID: <SJ1PR11MB60831FCB30F2A642B95C9D9FFC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230509143721.GA10616@Dell2s-9>
In-Reply-To: <20230509143721.GA10616@Dell2s-9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4820:EE_
x-ms-office365-filtering-correlation-id: 5f7b0edf-aab5-4c23-e50e-08db50bc332b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8jlxwR5jTP1alnNi32c85/92o43KQ+dqrgtZ4v3W30lOZKcb1k3WavsVVZtXnQcJFshmxJJSaNSVCRGmzovb7MYbNhf546s43tZ6B80gXatUwChXRkm3+xvtR1/rFVZPz0wDBv1LzToCudAiL0qfQVUWTxZy2XK3oEBmnOwDaPutTba330QIzOSDbU5R3VbKsSzg2LBNd9sNKPUyJNGRrdjQ0VBh1TvlI23PamIxNgp6IDw9GDuY15hhCmQrglsPnGbJdNwXLnuaNL0tuMKoLyP04YwkJbJSEZsNDPc7D9snRxmstmv9gyu2OPM34QuDDvMWBLCXjgVvjxb7xwxEQ3XO0f9ZTuINbbZMe3vieQcaOs/FiOFBdExejNi77By4B/aHoxjUXwZbz50EMIgwqlhIPWSuTU4nRb6Bg4yU+Vl8kSAgRJHkmb7fJrlXzwep3j0HvZVfo6YFd6Zdc5/nbSjPWbhGltlct3D1xRHO894XT1JhPo3WtMQbbEYDhD1gczL+6YQWaWZG1/uHIJgZJqx7Dv/dOwCVL2eQDwj6XknJ08uFEUIIX6q4DWC0IVcIi/wzmm98j8FEMYQNiTNfluFchXGVks0yzzfbWGrkHJFQkRagfWJ0uaW4PhKY1eFz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(54906003)(33656002)(38070700005)(55016003)(316002)(122000001)(82960400001)(9686003)(41300700001)(6506007)(38100700002)(26005)(52536014)(8936002)(8676002)(6916009)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(5660300002)(86362001)(186003)(478600001)(7416002)(2906002)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J4JvQBekau29he7MLDxjaMqhT5ic8KxrOAadKm1S03F3sapGo7aYtL+UbEJm?=
 =?us-ascii?Q?dfBolg1SsHAzrQPD5d5BfMNYKqX2XCe+gGbMonBbkSQATTB26FrxYg/4oOn2?=
 =?us-ascii?Q?jwFu2b3xZOdjwXGWEeI3W74ac07icSn84BC5/88Pa55Pb/enaW0kCqlk8DDs?=
 =?us-ascii?Q?Y8RSYQvK31hu4lqsj70O3mJBh1RYDGLSTdO7Wir5mf0IEK6sAwlX6I6buPYm?=
 =?us-ascii?Q?iRX1w9Yz95IKE7jMxhnh8+sF0VKjcg8DaS4+IflCI+MceN/bD0/BvEJasbHA?=
 =?us-ascii?Q?Vo6hC3cka+b0FTNpaCQ2P4IMy1ZnCmAIkd24wFM6NWGS+fnL6lglErjVXvkX?=
 =?us-ascii?Q?nCaPBIL8ElGzIEGsru8qs3lIPoaFgfRnh88qGYaa+dTTOUFLYpy4Zd8uZlsM?=
 =?us-ascii?Q?o1aXzuGiwTNHFVYMruVB0kzu0RH6ZeVmUYvQk0g97TtUyDgokNtKUDD+RFVY?=
 =?us-ascii?Q?6aQnm0wko3/L6qaOzZA3Yy5Qq3P/WWRRg6UuPr9mWzfvBTjwqszaCP0M+WdX?=
 =?us-ascii?Q?vM2Hg54FQLnYLH4cA+GueBZXAcYcaWjtX9EtY16UsdAMD2tDUH1ldFh/spOz?=
 =?us-ascii?Q?PglKUmbRhEBG5V0EEgncXev1HWmvZIcYOz7MWfZ+1Hmr3sb6xZhIkaCdlwWc?=
 =?us-ascii?Q?kuATIEVZSaeiciP/TtgJl0hMVH7ymvhn669hL4YnThKl/O42z4VcZVn+WLkU?=
 =?us-ascii?Q?z9ZzjyUMvIPRFYCsec98Hcdk9zC6Z3XWwG1fSjr+ziHs1JhIO85aaik0QHEu?=
 =?us-ascii?Q?UEI0vkgBMbTObECSZrQ7KZPEWAhOsELl5g/yb2XXoPzf9nS/8bvNR45b1bvt?=
 =?us-ascii?Q?qjl688tSpciSbWa0+XU0y71oImDH4UrfiNN6ThZVkH4ALUDqUdk00H+ZaKxh?=
 =?us-ascii?Q?5td8o3CP8a9oPTkFOLWW3Ssg9LaAgJC7MPIUs0XYzORekX08lP0yP2K6D0Qq?=
 =?us-ascii?Q?dm3teglFSH6tLujYYPRbaolvI+TLzVBwM8XpzCUYOUqshD32mmTu54ibNG12?=
 =?us-ascii?Q?/AhyCT0cmoWtZpajLxge3/aXA4ueJDDQm5B3MGqV9hh5YzSWGPeP2SS9ysQJ?=
 =?us-ascii?Q?F2SdFOGaKHyOBlVTwPy9qlkBJG15iR9cDmqWuxF2WrtyGNsCpCiKNRZTVQGl?=
 =?us-ascii?Q?osildlRWF8ZCpljlPutAGO6UT+RWezw8aiSR5R9JpVxQ/u7103lpnDvIuAnI?=
 =?us-ascii?Q?M9hXcWnP4PG4GbFqxGA6mvRijyujxthMGGYoDAgSnjdKiacP9ughP6A0fXkL?=
 =?us-ascii?Q?C1QrP44dg8bm1PMHImuEXjiHNKZywIkYrnipK1s3VlOoxcowkioQp2T2liU2?=
 =?us-ascii?Q?MCgfl9Ratb9gGPH7UiHDWugHiyby+X12LXLz9AT3ZZFINp35UOcF5QKlhakJ?=
 =?us-ascii?Q?7ZAjsKg9mmb2dPPH+0WVjVArnlIUfPcNnpVh+oOaXHBoJhQ5/B0NHK4KaNhP?=
 =?us-ascii?Q?m/uWq4nJUSQCiwHI2o2WbJMLFvBpUbIefGxKnVXWQTzuVIzhtvaIMpbawKS8?=
 =?us-ascii?Q?g0ZpfG4XrZCvBSgOo331iqezLcSQOBATkc3n1odPAvOXmS/2Xw4hR8couvqH?=
 =?us-ascii?Q?btXBhbfJaTovU8M+rl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b0edf-aab5-4c23-e50e-08db50bc332b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 18:35:44.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AelWWMpVA/MrspC2vYJ9bX/3JM8TacaqrynEMr0ulsxDs6WwCzXJaRkJ0XQwycuVDBbAIl394/ZNxO68IpY7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If a platform supports einj v2, then the einj directory wont be needed, a=
s per spec,
> if a non-zero Error Type value is set by EINJV2_SET_ERROR_TYPE, then any =
Error Type
> value set by (einj case) SET_ERROR_TYPE_WITH_ADDRESS and/or SET_ERROR_TYP=
E will be
> ignored. So based on einjv2 is supported or not, we can have either einjv=
2 or einj=20
> directory with the related params files in it respectively.=20
> Kindly let us know your thoughts.

Piyush,

There are a lot of validation tests built on top of the EINJ v1 Linux inter=
face and interest
in keeping them working rather than forcing a giant "change everything" whe=
n the first
EINJ V2 system arrives.

BIOS team here thinks that the EINJ V2 spec change is (or can be) increment=
al.
Platform firmware can choose to continue supporting EINJ V1 while also prov=
iding
EINJ V2 actions.

So Linux should be prepared to handle:

1) Legacy systems with just the V1 interface.

2) Incremental systems that have both V1 and V2 interfaces.

3) Future looking systems that only have the V2 interface.

-Tony
