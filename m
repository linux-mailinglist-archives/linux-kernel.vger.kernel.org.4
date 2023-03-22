Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D16C5046
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCVQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjCVQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:13:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B222CB9;
        Wed, 22 Mar 2023 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679501632; x=1711037632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1sJmy1RzfsQBVl7d3Q8hSeGJ+HqSTeb+xcub4T8Hr7U=;
  b=I13A1E0kg4fw157ca3dOgQ1uzDkV2gvGg12gFvwmf0x7ywu/UbLlt6cv
   tzU1Z1Mb3ZsZcbbiX16xiMo41TWmPUDhxcjT/fcU5Oi8uZ2wPet8E8kmF
   N5s1Zjd4qP0z/uaqsuMQkoNszDl3js62akqGeMCsRc2GvLL5LtMv70gjP
   vM4QL9iRvvEDfQ2SmOls6AYEzLGZPjFy2kV+QjFY70nWOfRiR9JMYu/uy
   4tkbAbbB/osaCujkqiOPysKGDSsI0asCwlCaKuH0qq6PkR8c6xHZ5SSBE
   tPXpMyjZp+ZJ+d85+c0VNXKGI2O28kq0ibO0ayZEhFW4eJGFrtmCdGSci
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="318903568"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="318903568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="714455193"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="714455193"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2023 09:07:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 09:07:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 09:07:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 09:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDr1AC2dww9yWn0EuYrs3QgpQ2xaPJ1DG2+kiAde8plkWGqFFIU5L/vuGhv+wzhL55v4V/NnPKyGNiOXFCOGbHO0NOf1CyXF+duUOTXOAisY1Vhd2lKcSB+X6FRFq6EffRiybKi+vzk/wVYjtcWin2Q9ZsMh388EcVDrYlnAy3qbwjB3pwuTBLpK/y1pAnAslHncyxEZQKvRJf9FGMqBqgUWOHIfUEvP7KutWVksiTvv6grA2vnKRa9idQNWOtKz5NMCdarxE7dqZAXkKGnXLxNPSML9vQGv9ZOt2XY4go/KGmiXP7G/7QgwfDpB111+CJTq4d9OnI78FuNnkrzm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sJmy1RzfsQBVl7d3Q8hSeGJ+HqSTeb+xcub4T8Hr7U=;
 b=LijYN2DVMmYHfgzvLrzUayAKnNHsKWMslvevwLsYa35kw8SVz7WPivo2TPbuMfAyEZgJbedfj/BPZJz8NdBc13ev8jvtUM8wanpdgTBgArFBnUDPngWxM8gmZ2Kgplv0pxCy4XdtPmMJaGYpOuEuLWi0beN6fYhvW70bMotvq2rv4rWN33c399HTlzfGS8UVr8CHj8CJWPRAL7AGF41m462GeNvy1JMq0heWzHP44bJnNqY1id3JcVeWDD0Agn3ls060dSV2f1RCs/1zx3P/Pd3NrqGcKd5QoLHefbt6CFnXkHk0E3JhcsEJgeFtnNVnw7vRDe+De+dUWJnXb/RA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:07:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:07:51 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Thread-Topic: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Thread-Index: AQHZWKLi/0R39JELJU+i6OTnfLpOoa8G/tPw
Date:   Wed, 22 Mar 2023 16:07:51 +0000
Message-ID: <SJ1PR11MB6083FE558641F0E57FF1F5A4FC869@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB7672:EE_
x-ms-office365-filtering-correlation-id: c55af7dc-43e6-4d56-953c-08db2aef9693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nseq0TYazF3xeX7Sx1rXTsZ8R1beKoaKT3r0b7iA6cLXuVytPI+y5lap1L39gnZ7B9AOBxC2cH5V1VPdhFRlAjDB+QFTDKd4sCWVkUpz2YOk+Fg3gQwK79TjeROELa4ZMo67Bx7tafFVLM0UTTxyJD/vr8YvLaPjPyR//4sJ49ES5al6NnINo9pEia507kBGnMcDIFCV5o4PLSCiC3xeaspFDO3gYWBidlW62Wv1wjTeRxOK/qiqnNlbFwZ7QwijIRAtWZCe30MUsWjqWEei5IBHvbq+zuhNv7RTxnyhuFBG8c9kwPrEf7MP5MjAOcXGzDtFsNKpT6Omc/yTyL5ythV9Zw4LhguCA6V4FzjoZag+ssenwD0IQ66aaMfS4ON3AMPOQoNP8KbQgm7AzNJQBLoYONkTeYQEDilfozl+bUDDKFLSR/or5htFjzBqfM+Tlux2l4Yqva7msxCkeNgmiZhxQfTfwXK/W2wZUxg3CHCDxdq3pSahSACiLKh2GZx1NlaKmBDMRRnN/vsvzw3J3CeCDLGZEqGXE5nqbKcMvwZt6HcGiEWdO87tKCfcOWZquTqHrr1hohwnQpRgPczPVf6qOCqzYB1v9DOZE+KMGIM8RzG+32nygbu20aNDY8EW77DHXeVdTjAwbtvznqchv+nbZNH6FxpJRegAzPzdmMVkdCCGRry88DZE2y/Su9vzJsahbGFJJnl1nVim3GxbaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(316002)(55016003)(4326008)(38070700005)(38100700002)(86362001)(4744005)(8676002)(66946007)(66476007)(66446008)(82960400001)(64756008)(8936002)(41300700001)(2906002)(52536014)(66556008)(122000001)(76116006)(26005)(7416002)(33656002)(5660300002)(478600001)(6916009)(6506007)(54906003)(9686003)(186003)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jsl8m5fEzAYpJ78Y4Gu9w/uFSdynuwU9P9eNkbDPi8hkzJmH30EYo/6+B8cv?=
 =?us-ascii?Q?A/8XFkuJBNARDVZdlZmsbn6DrcgzWj9lkW8dp1TQJMkZCD5bTzBoTOguDfa1?=
 =?us-ascii?Q?yQ6amp5Wq3g8D8AOF7rw3iZ8VJ7SI3N9JAXx5sWRWp2i6VwObAGhD1pNGwkN?=
 =?us-ascii?Q?IqIghkQzXx0b8C/mdqMhjakPE6bRk93CUURgpMXAkBgmw343CR1AfdvCMKRC?=
 =?us-ascii?Q?3wfzFtm9WJZffSihPxTanD0mpTGjIvtHJRfip4bA5uOqAk4jan7a0EbalALk?=
 =?us-ascii?Q?Ip0Xe6LFBj13sof/4Qfk15DNCSSzEKJ8KuQL4yuxuexRNujpKWhrZDwED6Xx?=
 =?us-ascii?Q?ISoy16b11zFC6d1Lq+3Hk7uasHoIGKiCBKl9gFG/9+NLZWnNLIP/vvNkbqnT?=
 =?us-ascii?Q?TC96Mfa98q7+MQJ7koV4+6PtWQZzrRgqimBtXj7QGgUfU9yb8nhXAYn3KQCI?=
 =?us-ascii?Q?Fm8b5FEWBHx/0Hg1xinUqQsYqDoC8UpToPxhj9GOsg16IOcZRZwlqnuwinwM?=
 =?us-ascii?Q?19PpZsGrZG10xkIu9HSFaLyV9HxIUJaqgx8bBzqGJGkoDPV66ibvDwtiH+D5?=
 =?us-ascii?Q?d3UlQD/dCMzcQ3QW3AFtP+ivJFc0X4P/W1hoGe55+9Dj1rCd5u0B9FeupfBu?=
 =?us-ascii?Q?z17rXbcVd9JM69ArhwCmgCuEoorKCTo1fy3TJf/wdNfjguXHztsNR4bnlsjz?=
 =?us-ascii?Q?hhckKnLBBXMcAfZy/VjHO5q56GL7BRzdvK+wkpD0TnSYoziatIJM+ClM3+uf?=
 =?us-ascii?Q?Im7Fr/6aOWwmrAoKnpU2ri+jsC/epa2dE7XyhbMoWuL1uAyclx70XMRcorBE?=
 =?us-ascii?Q?506Mec/KtzXUjFTTsiPRojtJshjhitXt7DwaBySH7aMZbPcAoy8Nx7GCRPCr?=
 =?us-ascii?Q?Wc27Jmmn1uiSVNVGgLE7x0m55A4iFAeQNtQo1xhPRLDwgEWkMs+BWm4ZPSvR?=
 =?us-ascii?Q?TnFxVd65odA9Falrk4zMAhCI2dK3Y5s1aRqmcFD2OCXldgD4MaMpK3hST8QN?=
 =?us-ascii?Q?HMXSb0PJtAQ0s6pmA2RGt/KeY+pG0fA9h2j/RdgJP7NytMThLOgS3Wqu+YFz?=
 =?us-ascii?Q?071Xr0MN4fWaX01FhFDZMaegixKvpx2OuBTayNp7+GXDGb1f/AZeSCh6O3+c?=
 =?us-ascii?Q?YGlpRb3H4xjYJzYUd+RyClKEVcpDLkmsXETDS2UyxMhQRdvwpYFPjfkf0DUD?=
 =?us-ascii?Q?idSCnNy42DWSWFwrB59DgOt92tPub8PjCdYL2hvEaRfiGzcy+qWLjyKXB6ne?=
 =?us-ascii?Q?zlWAEJWFCZGGPHfF4SaOhRQJT192Y6JSd7XxsYcWlTtc82Qb3iBemVpGNCr7?=
 =?us-ascii?Q?9XtSU0WY6OFz9i3cNezfSWTz+mX1mAyyR6MagAeo7ej1wRf1NzYR/Kuz3FMj?=
 =?us-ascii?Q?JXj2C67s9/mXidrw0c95O5oalb/miyjMEn9BF4UjXhpOl8WMRVdKKaOVYh4k?=
 =?us-ascii?Q?s/sc6398eApHiuJs5DyYAz/9xpjT8Lh5woz3SDUIx7xRrVJ9fwlPvA2OJPqh?=
 =?us-ascii?Q?9xSByKNUgNYgYb+QWstBkrN2f7TeEAsh38qdQHR3ltKTIH2BMNIOMZAFQriM?=
 =?us-ascii?Q?Jx2j96nyVHsFlv7jbSlF3IIQepcyFNY7abG5SvL5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55af7dc-43e6-4d56-953c-08db2aef9693
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 16:07:51.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyRyRcqjWV/b1j/PmGKOiUTCXMROwKo4M7vLk2Chmsa0hqDMGzvRWiChjfkamXw6pVyGnvAyS1vlisJ3vFKm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix to return -EINVAL in the __einj_error_inject() error handling case
> instead of -EBUSY, when explicitly indicated by the platform in the statu=
s
> of the completed operation.

Needs a bit longer description on the use case based on follow up discussio=
n.
Key information is the EINVAL is an indicator to the user that the paramete=
rs they
supplied cannot be used for injection.

But for the code:

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
