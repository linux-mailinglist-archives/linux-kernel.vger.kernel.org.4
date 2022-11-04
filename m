Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0674618E2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKDCTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiKDCTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:19:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7671B1EEC7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667528350; x=1699064350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZDHOgVVqJA1Lw60iMBoTvqbqZyUcvFLgGYICU8lVHT0=;
  b=fx9lGDqUjzu2FrL93TqRpRuUYqIAnC59epB7MrSoM+5hQPVTsrlTHIS5
   6Cf5jgiNNsolA3KHLKaPhP+LKDLAxzWqTV+xzxJ6ghO77f7KyIssUIcKs
   rvuYPHXkk5WLs0eMJEknZL7+XljFeozoMOLDus/Gfh8BmFgv8cKd3Q9mg
   gn0AbB8S9hIQNiPaXKZB1KFhbfRwSAbBi6nDwoZ3FBhILUxHoVgqfdWL1
   PlD/9KScHLjcpsYSNnPUO570Bf93m6X5znGpqzg+2DT83hwN5RND43OrY
   ycGWrx50pK44KpH6DJ+N+VHc6qQKoTsuUDZKj21mxUfegcnkS1fPjwwpE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="289576689"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="289576689"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809900235"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="809900235"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2022 19:18:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:18:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:18:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRAQoFbDCS++wNYNFCLOpHfkREGrXO9PF303qwK747Ct+pJ5f9ysd/9v00qhNazwDBUSMDLRDIfHLbLcRXKDjuMJyoyo3l5Ig2d4KbN557OZNjXxyWUxsDFwx3pOGI4YSFwDbudk4glDByONRV7n5splmEuY1HviYRXkCyJh6j7PD8zvLSxTQNM9xlID/B4nKH++mOkfViDKX5gwcaFVUxOmXqDa5Iu7rC7yVlSwnTZSdrk55G7+qr8I4KMdbcbET4ExpfX8fLqTeCL5eS7EVe5xFlM12Jc5OYRRoQlXZnNCkldDKyQJeSpkvXPvrvzobjwDFIywkKaaAili11vipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDHOgVVqJA1Lw60iMBoTvqbqZyUcvFLgGYICU8lVHT0=;
 b=P2Alw7D8QRLA0CAa94bXolbfFKthTCdCHnyq3Jd979SD/8JJQSol2GUYGk9gtQA8Sp9SZ4oH33vUi5VZgU7d9kgYSsYzQQoqwbP629LnvpmOyqx9Q+juIIb/0jUws/mJhcUm1c0sYVr/brgSn4omT5gJ5mNQf2y04+8ZGwnv2R7f35y/jTnlxNeQR6lbVaU64cTSBzqgCxsooOtWQrR103xVCoXBDSNWWMoOtZrXkDtJXoMlL0e85OGTulCu/4mcgdI4G5VuKM4sWxEcLVwoU/tgeJRoXsWX+La2Un/xIY3GVRgaWNFEzeV4nST5oa5lSxW9BpHi821Fu7JnP6kiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 02:18:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:18:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] iommu/vt-d: Use device_block_translation() in
 dev_attach error path
Thread-Topic: [PATCH 3/7] iommu/vt-d: Use device_block_translation() in
 dev_attach error path
Thread-Index: AQHY70mgBp/z3YbhiUy3Oq8gjYJbXa4uBuMA
Date:   Fri, 4 Nov 2022 02:18:44 +0000
Message-ID: <BN9PR11MB52763EB6CDF2E171210D04E48C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-4-baolu.lu@linux.intel.com>
In-Reply-To: <20221103055329.633052-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6468:EE_
x-ms-office365-filtering-correlation-id: aa4330d8-de0f-4540-929f-08dabe0ae651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7aUZnbfk0nZxedFq+WEwRQro5KREXmShyq7EE8ZPSErUw/aefckwFvjWcT6AUydF7cVEdzZKYbdvjlEshRX7T+xJi383u4v11FZJQE7qtpB7+IM0gpY/JD+ItXE6BboGDuXnNB/9Fwvu1xTCxiBT6YKUDkkSQGnK70Xz2hVbVBi9ql3LyMz6tu7v8VZFUhWM5qqYPeoVe0dlQ65Jio8BwNcweIa7LqSnbZDIvnXE+vtd27tkphoUzM+/FQUPG4slKR6v5U2dUK7mQHKIlIdjy/zyHSItswad4Z9v+j9O4n2pY5KA6j+vJWN59rDCtYq62xBj+qPvSXzASdBbsrWG/THQKMqndetFPnrmRasTn/7ZVFmQ9pE10H96gYWCC9bWRnq9lO4xoSACshMl3X01HcSYLvfbi+a0GoUvz4Emkv+FvUDWAvoEgScoAIFlIlAQVCR5BzB3fvEZ5vuJ1avOsjIXHdGe+oeQASuWKxtnGhdlFYp9DO2wVBU96FAv5HqZXmH8IAUVc96PVx35/XcVl4ppAGvfX2EeWNxP5zbOFWSnUjjOuyLc9Hs0WUmllN9RjVQ8XgDn6XD8IK/d4k0kPLM1HgRRWjQHsr1jyJBs+Y1PfyJQaxJRsMAdpjttu0tQlfVPOg5Wh8q5k91Zb031vb7QV4Q2+bwpIREIPfoOE/D+CNR3l2W5mlnfoeNhutvXYuIp8VdULmlKnLMxm4YpRjrfTSd7P9QnHOLR22tXdTDeGlduVMwHFH2KuX/Ttoh78fiwkNRx5FKE0CGqwUuiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(33656002)(38070700005)(86362001)(83380400001)(82960400001)(38100700002)(66476007)(122000001)(41300700001)(2906002)(5660300002)(76116006)(6506007)(52536014)(66946007)(66556008)(4326008)(8676002)(7696005)(64756008)(110136005)(55016003)(316002)(9686003)(26005)(54906003)(66446008)(478600001)(186003)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YFeiShgNXZ1J51K6lqL7YRzRKXiWpOuUCpBMZfDqzxbRn6C4XeyLUkfGrku4?=
 =?us-ascii?Q?mqswLu+XpAUAVsPcaPHmss3et0meB8p2OB2EmPB1MH7ACtrN0iMq+Ruz3uQV?=
 =?us-ascii?Q?sw6qxiYcROvDscpRzSAV7oeQyq/0U3o7JTu4x5v7pyTTTAe5kJW4Gctv/jaw?=
 =?us-ascii?Q?cm2vAhVj8/rL3jgSVJJc7ra8ExltV4WzklU/Se9G8vJS13F5FR+1U0QtqNYC?=
 =?us-ascii?Q?owkeldNWsLs/VB9Hk7bi+/BEby25LDMyO9HHqRMrZ2BeML5s6/gSY+v45wu3?=
 =?us-ascii?Q?0QQYMjfg6hmyKJWKpfQ13di8ca+jiXdtqAp3AVTqJeyn5E9dpG+cca7gNZ6h?=
 =?us-ascii?Q?1NevBIHZpEErpobfeacuM47blPreqVlKINjljLVGkh6ZRImUiDZB9d9ZYX9X?=
 =?us-ascii?Q?QcR53Q1sUfu1ZOJrhQa0ggcOCAEkiWYyKkRKpwt4xlApV218INxhcAx5v5a7?=
 =?us-ascii?Q?nMhowX/89twCYby0hs3ZRXVkNs+ohQQ29jEDKbUNyN/baDHR0Kv9TkRAS+yn?=
 =?us-ascii?Q?AQFxaKnKMhAptxEu61c1V0sQxOXB18knE3QJOXFUlO0R7p1VDrRouUUQ4iq6?=
 =?us-ascii?Q?JVtqk/+syLNAhtkkmYof7Hvv8SNcdqYb3u/0vNV8G2OtatEVYUryAdY4zup/?=
 =?us-ascii?Q?9JawcbJ3+HABRBI3WdNv5hftOrVLExD6Ww8WnLG+h/Bzd70HM6GYHKKYMSV2?=
 =?us-ascii?Q?BgUEEwIHVDtZennwZyYKy78fhMKq6TgvRz2tIyO+xZQYltUhMu+2FnjQW/lZ?=
 =?us-ascii?Q?xUk64zxaZb7lLB6QZz/A/wkYD1KSK8cJuRY33jve1XDVY+Lc46m8LXh362Ku?=
 =?us-ascii?Q?sI0m0ZrI3ask/okQTGDPofgRSS5mpB3sAicrfmac7c4UAsl/JJny13VMcqFz?=
 =?us-ascii?Q?7S0qPUKmbSazoQNN114MzhSgKtZ0BYlUv3qeb/wx3OGycsvPnMdndVlWdaC1?=
 =?us-ascii?Q?Csrmd1wq45hzlVRYoqWGH3wsFELD2rHgGe30lCg5iG3YlnZyTa6FVrKuymyl?=
 =?us-ascii?Q?F77wmXgYxVo1KxjQMhrAah6SORPcrfgaKLhAa/usHWvW4OohceaYVle3DHk5?=
 =?us-ascii?Q?W5/Ajhol4Xgj2OElwKGrHXNdSZWUPppxztmOQ/0Tz+hgHVt5tJAJaQSRCJed?=
 =?us-ascii?Q?P16jmOr3TEdhgDfT/7mrAJdiZz1PL0DRTSKe5BN4I8uGTyVsf1IXX7og4zpT?=
 =?us-ascii?Q?jfiffhGTuRGkMrYITfzfZ+gsMjoztmhZzoIzg3m3pZbzdUh0Wtl1kGcd8Sc+?=
 =?us-ascii?Q?wI9SXYIQJxgDc5sXYJpFr3ijP9/opNv9pgxkXrbNHBtGyNQQkvpXnrrWCU5c?=
 =?us-ascii?Q?u77XsnE+q81dNE8CndH54BurMuIYk3OnWU1NEplVmYZfGTHgkL3VbKtCh8NU?=
 =?us-ascii?Q?/UpY+xE+KnudIHCwXdX+XozStESEv1a6fcbdAJpjY31COsjtJywqLH8NIzTW?=
 =?us-ascii?Q?R7IH4x/q9gEXAJYtb1BuuuxXhRshgKAj4yCJGvWObUPiiAxBs8Lbj42s7Y78?=
 =?us-ascii?Q?b9Fmat98NiEE1PRuUPOkE4F5kED57MgLFCgxnWDK5xzywpG3n4K8nHMw/Aws?=
 =?us-ascii?Q?PK1c4lks+Urgdqj2uIeDQK8RulZunq3CwHN09jOf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4330d8-de0f-4540-929f-08dabe0ae651
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:18:44.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGmrXxFUfYDJBBWJ/IrLivo1ktE4JRPkhtz/GiE7Io2R+gWv42sRk16XZHqHPjrDyy0Kw7nxjVQExSEuFvqm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 3, 2022 1:53 PM
>=20
> If domain attaching to device fails, the IOMMU driver should bring the
> device to blocking DMA state. The upper layer is expected to recover it
> by attaching a new domain. Use device_block_translation() in the error
> path of dev_attach to make the behavior specific.
>=20
> The difference between device_block_translation() and the previous
> dmar_remove_one_dev_info() is that the latter disables PCIe ATS and the
> related PCIe features. This is unnecessary as these features are not per
> domain capabilities, disabling them during domain switching is
> unnecessary.

well, the opposite argument is that when the DMA is blocked what is
the point of enabling ATS/PRI on the device.

btw this change is partial. @attach_dev still calls iommu_enable_pci_caps()
which always tries to enable PCI capabilities w/o checking whether they
have been enabled or not. Then user will hit -EBUSY when related PCI
helpers are called.

another difference worthy of pointing out is that in scalable mode it is
the RID2PASID entry instead of context entry being cleared.
