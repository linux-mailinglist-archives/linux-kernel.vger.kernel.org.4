Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF41569C48E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBTDpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBTDpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:45:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44193D2;
        Sun, 19 Feb 2023 19:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676864730; x=1708400730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ZDQND3bhfhNBwQ9BAaFJ8NB4oRM1XTSP+2Z1w0bM7Q=;
  b=ISgSw1qJrtBOt5Yd1IqpT4ikqYXUUGQeHa+Fvspx09W22wmN9VYKeLY8
   OYS5x/ZPj07nAL7dwXZV4eyOUYEHzY/XBbiSvLuAa4E/5j7k1iL2G9DEp
   emzFZf1u7bxxM1RxHm1mCXU+84EFF8sYhNiXr4EyJ2svr+whs7M7kgfYC
   UPIqD0KpeTrU9lj5B1hqiVin9nXpQoUsac45vClaFrvcWr/6gLI6rzswH
   WxjlefaJCrYXKCdgXAUrXXIMBGS+6Uet2B9HquCb5gYDPJGb8q0Ess78m
   e4/YWz4F95rtmL5XQqJL+8mvAlRDXeJ0U9/0KZG5PyD+NOEUlj5HnaVS2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="332323231"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="332323231"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 19:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="780493253"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="780493253"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2023 19:45:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 19 Feb 2023 19:45:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 19 Feb 2023 19:45:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 19 Feb 2023 19:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqVIqNugOsP1EcpyEub01d4R7PE9iLO1b5M/1O97xt+tS7mhqamn5C8Fb2rOxctQFtl4WMOs7HZ6XEKJlxHwY0azIpBd7DIkLb857zyItwSKuSHdc9rrlZnweko+Q+CJ9baW2S4EMqRg7iykcdHa4KhpdXlE6xyZR82Cna5dyZESLROqC3nejf5LtF8zvkaG98VpvWKiFIU7WNue/GpzgepmRys21yRrI0RwEVsY9MR9rXyQ5FuWU4LypcI+MB1YmLytPS6xuioDBMRnxzW6vF90BawsXJXqg4DIkZtjcxi13J38rPPi6ngi2f5NlX0iLx6OkWEX0wSS0I2e6GKvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouY+XWKB8PlqzkS39JGmIecA8n+Z/w+VM5oCI5krCPY=;
 b=Hs0nmbMvdzOcoPMRAmkAk8WqYb+8RtAiaOfsuY190yLzEgi1U3YyRx3NihgmfIt5GrIa3udnCYvzChNRBn8LGGKvadOY8FSVsI9A5+NTLNjs3+uFNp600c5i22isUto0fFqbwDps9OiAsFlKDlbFbSdstNUYRphNBNwfxzqTStaW0FeEGw4IGkZ6RGrBYAVPXGNYFA8uiOTI/CTO7grEN+HZikrHbt87+XnN083mHlyyHT9R32TDCIHGhglGMEQNX6XT6Mgb05IDt/g1+l0ITZyatg8gQekBp3qRUSMtTwgf4SUsqCrzCewAMprYLPzfvd+zc/hv6SfGLA9ujwb83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 03:45:27 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 03:45:27 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Bingbu Cao <bingbu.cao@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7PxSqAgAApAACAAaPNgIAA0d4AgABNrbCAAErlAIAEKgKg
Date:   Mon, 20 Feb 2023 03:45:27 +0000
Message-ID: <DM6PR11MB4316B7A714EA1ABE62A4A46E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
 <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
 <Y+4rtSMArg5ow0Sh@kekkonen.localdomain>
 <8022b9da-e033-b77b-914c-d35a31aac2e2@linux.intel.com>
 <DM6PR11MB4316F7C9854B113556466BF58DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9bvl5SA2a1nXhe@kekkonen.localdomain>
In-Reply-To: <Y+9bvl5SA2a1nXhe@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|MW3PR11MB4745:EE_
x-ms-office365-filtering-correlation-id: e6e20920-e1a2-4dfa-647c-08db12f4e7c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKN5bZ8298OGWMXaNWbHp5zVJCIMWyTy8a+kg28j+Urde4zTtL4o9rargWiFd6PGnceP9BDog5VyI9GhNzDauWh7GuWkVpfuJKJGQBKW6wpDp5TA7oO5tkJY1gDWOBgasuN3hhJcr5BFd9hIjx8kFnjGUTFBw+pXx4Li67sJx8yMIGBbtn5ueGxiqW+/Od8IxEf4LghlfSws30bBrn6OdxXXgf2IQQCtYV4GqfspIZz/nHFA0G8L10q0LdYiN9ZSsJjierjA9kAQT5CbotL9q4E48Kj7UZtMT441N+tV03Z42sgr5ocSJJXrSqDaQgXHTVSljL+qYb9OZ6v/pX0yiaM7thUOjgYatv6OO4I5loBB/MICkb2AQzew6VoARM3ANr34P06WbEnu1/6bZBbATjSnWuab9ZIELyTEWmDYz60ZPKcF6pVFDxp7M1MX6VV5BJIfTJ58v0WViUpuHYSAcE4SUDiHWIC+uIWn07K3xhgiAezVB7N3yPXMnYDbtIf+s50PZ5tjPzCHXPxO2cF6ettiU+UeI+eeGjEpWgEv7ILaivbnrd+dBM9XVMdh5F/BxDLQWN0KvkrTvfSEAllUo6Vd6HOxHWcW3N8O9LVXfiLJgQ97VFIWmzqNTTvIgOJ4KMmRshK5Aue4QpeHEpXPkZATZZLvR4LuU/uzxQGZO+N2wq3kHilFaeZHGXO8FcysTeTHD219M4aKXfECnepHfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(316002)(76116006)(66556008)(54906003)(52536014)(66476007)(83380400001)(66446008)(64756008)(66946007)(8936002)(8676002)(4326008)(41300700001)(6916009)(6506007)(53546011)(26005)(186003)(9686003)(71200400001)(7696005)(478600001)(38070700005)(55016003)(33656002)(86362001)(2906002)(5660300002)(82960400001)(38100700002)(122000001)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vAZffxRedT/GIPYpTFvkQx4pxdlVLnI4O/UHz1AdNhPpG8gU8v5WTxKB7pxV?=
 =?us-ascii?Q?m3ZQQQxq4n6q16kjyoChQsYULCb5w0qBS4Ejk7l6WxCY5eoP1GdYSnUJWAIL?=
 =?us-ascii?Q?PThy+phcnHtXeGPAyNyhUuv1k+WCqmDThfj4rMAbz3fkmuI7kyzm9q/n+Q4Q?=
 =?us-ascii?Q?7U7vgaVzBfcnwhEqgMkEM2rPeyVWEG9JffXtdU5E/NCMOGbbxk9xTJ8MVP5Z?=
 =?us-ascii?Q?x0/KQqrk/O1sakD2l18xaiLIepSG/F/h6R8eCjq1tULdjAafMDKSi4gWXNXq?=
 =?us-ascii?Q?XvljNxkiJmlqGcxmRdAL8O0Wi1G+kKKEO+Dogc5QiYyt3tqGRNhBF8YLiRUy?=
 =?us-ascii?Q?C84eTHwSZadFQehpHKWKYE0hhB+7I3vHpIJC6ibXWnJtZgBFlxmxZG/PHfE7?=
 =?us-ascii?Q?ZdguXQCHIQvqghoubWi8XjnGRbUSkuAdUxhjhWMJ6rsqShvGtt5iXvtfMfje?=
 =?us-ascii?Q?8FZElttJcBPqypd3j04UQJBHT/DvGRVgLhr1baZGjDHmzQirEv3tnWkErHeL?=
 =?us-ascii?Q?+xW1wpHTQZg4TJP3FmYSEmmIjDMkewzipWnqh55ECF4AD9ov/Ijfve7CMJIG?=
 =?us-ascii?Q?oEmZQ5ZtLbyEPDCC2lXs36bLw8N9vcYh5lsw8Ao2Nfu0rW0xrWHmFyKHtEno?=
 =?us-ascii?Q?YUFVRNo50yWDASMdIErpl6wt8piaHUETKinZGghyRoLeQNNdPRi6v4awPoYL?=
 =?us-ascii?Q?2n4RJbs4AAx/KDDTxiSp9ihcmZNYYxpofwo4lwdEtmxEnH2bjKgFO59BxuMM?=
 =?us-ascii?Q?4+jZdG4++Z6Y8DpNjdQ9g03LxoEhuC9E01jFmVae1voRUvMajdvsGXRKp0N+?=
 =?us-ascii?Q?duD58Zp6La1yscAxLxOJr2O1sO4pLEeEgpYoJwpwCIBesCP7rbabgcm0USxv?=
 =?us-ascii?Q?xHflmsqQeGugWWFbqaJozUbz/HoNdBTB1GXLfKNkWfWK2pF3GEJWWf30tpsh?=
 =?us-ascii?Q?+T3WOdETOynZxMVvnbx0Do5DOfZeyRW65QnRWO69BHGg1vpy8CdiDkSq3agL?=
 =?us-ascii?Q?rKbueY73OPPrCeqQDMm765y7HbRbPq/10LptlkXvisEPfAbNAYNkbfXoZYtj?=
 =?us-ascii?Q?TJhLVzD/foyx/WdCliiAXLj8gkKOL9WBqZEsc4s42dtycLp4iwMOyWFXbiP+?=
 =?us-ascii?Q?dCEi/c0DbZXpm/i7+Cf/MQbO8me4nltkc2vnIssK5+XBN5tOqmpDf/px62Xp?=
 =?us-ascii?Q?LYNZPX4ZK33D9zirfI0u9zHWSH0nTV346aFMynKHDXGRlpO0zFKTd54vAyRA?=
 =?us-ascii?Q?5m6JXRPgbqtZbx1oEaq6W2id1q1RIu+7V9Gzxn7pQjgrxpro+he36c/LET3G?=
 =?us-ascii?Q?xxr4e7Ybvclfiz255IQFw8UXA9MMBLsuk/SY6nuy+/e5PGs+7JlwaHcFwQ8k?=
 =?us-ascii?Q?/XiFwaBVs+yc8Sm1iI3QOQFXCGxLCw48HYg8L3sxX0JWZAwiGVfPAgaFTGQc?=
 =?us-ascii?Q?nUPYRRHrj756F4vJAb/5++ZKy8uYz5GTy7shW4g4iU/jKHiMgQMIz7IjHe+k?=
 =?us-ascii?Q?5ezIeED/0YUQLT6yboXYFe7J2GOaiMxmixBbBwsfwOdwCammVztR7mpCGovO?=
 =?us-ascii?Q?aKmF5lR7KSP0rfPBIN9yaHkWuYYTyc6tPuRmzd1h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e20920-e1a2-4dfa-647c-08db12f4e7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 03:45:27.2497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTSczhm1jKiJgOnb26IuHEvgHL4JV/CEiKsGNPeZLUWCXlnp5VMKitXUIrKfbzraG/I3xquhADE5ysaJVB+ywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Friday, February 17, 2023 6:50 PM
>=20
> Hi Wentong,
>=20
> On Fri, Feb 17, 2023 at 06:28:32AM +0000, Wu, Wentong wrote:
> >
> >
> > > -----Original Message-----
> > > From: Bingbu Cao <bingbu.cao@linux.intel.com>
> > > Sent: Friday, February 17, 2023 9:44 AM
> > >
> > > Hi, Sakari,
> > >
> > > On 2/16/23 9:12 PM, Sakari Ailus wrote:
> > > > Hi Bingbu, Wentong,
> > > >
> > > > On Wed, Feb 15, 2023 at 08:09:50PM +0800, Bingbu Cao wrote:
> > > >>
> > > >> Hi, Wentong,
> > > >>
> > > >> On 2/15/23 5:43 PM, Laurent Pinchart wrote:
> > > >>> Hello Wentong,
> > > >>>
> > > >>> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> > > >>>> Intel Visual Sensing Controller (IVSC), codenamed "Clover
> > > >>>> Falls", is a companion chip designed to provide secure and low
> > > >>>> power vision capability to IA platforms. IVSC is available in
> > > >>>> existing commercial platforms from multiple OEMs.
> > > >>>>
> > > >>>> The primary use case of IVSC is to bring in context awareness.
> > > >>>> IVSC interfaces directly with the platform main camera sensor
> > > >>>> via a
> > > >>>> CSI-2 link and processes the image data with the embedded AI
> > > >>>> engine. The detected events are sent over I2C to ISH (Intel
> > > >>>> Sensor
> > > >>>> Hub) for additional data fusion from multiple sensors. The
> > > >>>> fusion results are used to implement advanced use cases like:
> > > >>>>  - Face detection to unlock screen
> > > >>>>  - Detect user presence to manage backlight setting or waking
> > > >>>> up system
> > > >>>
> > > >>> Do you have plan to support these features in the ivsc driver in
> > > >>> the future ?
> > > >>>
> > > >>>> Since the Image Processing Unit(IPU) used on the host processor
> > > >>>> needs to configure the CSI-2 link in normal camera usages, the
> > > >>>> CSI-2 link and camera sensor can only be used in
> > > >>>> mutually-exclusive ways by host IPU and IVSC. By default the
> > > >>>> IVSC owns the CSI-2 link and camera sensor. The IPU driver can
> > > >>>> take ownership of the CSI-2 link and camera sensor using interfa=
ces
> provided by this IVSC driver.
> > > >>>>
> > > >>>> Switching ownership requires an interface with two different
> > > >>>> hardware modules inside IVSC. The software interface to these
> > > >>>> modules is via Intel MEI (The Intel Management Engine) commands.
> > > >>>> These two hardware modules have two different MEI UUIDs to
> enumerate.
> > > These hardware modules are:
> > > >>>>  - ACE (Algorithm Context Engine): This module is for algorithm
> > > >>>> computing when IVSC owns camera sensor. Also ACE module
> > > >>>> controls camera sensor's ownership. This hardware module is
> > > >>>> used to set ownership
> > > of camera sensor.
> > > >>>>  - CSI (Camera Serial Interface): This module is used to route
> > > >>>> camera sensor data either to IVSC or to host for IPU driver and
> application.
> > > >>>>
> > > >>>> IVSC also provides a privacy mode. When privacy mode is turned
> > > >>>> on, camera sensor can't be used. This means that both ACE and
> > > >>>> host IPU can't get image data. And when this mode is turned on,
> > > >>>> host IPU driver is informed via a registered callback, so that u=
ser can be
> notified.
> > > >>>
> > > >>> How does the privacy mode work, and how can the user trust that
> > > >>> the closed-source IVSC and IME firmwares will honour the privacy
> settings ?
> > >
> > > As I know, without IVSC, once user enable the privacy mode, the
> > > Intel Converged Security Engine will configure the IPU camera mask
> > > (security register), which will mask the specific CSI2 port and
> > > produce dummy imaging data. For the case with IVSC, there is no final
> solution on Linux so far I think.
> > >
> > > Wentong, is IVSC trying to cut off the stream and then notify user an=
d IPU?
> >
> > yes
>=20
> Does the CSI-2 transmitter on IVCS go to some LP mode during this time,=20

Yes, The low power mode is following the D-Phy spec.

> or does
> the receiver need to initialise the bus again when the stream resuems?

No, it's the same link.

>=20
> >
> > >
> > > >>>
> > > >>
> > > >> Continue with question from Laurent,
> > > >>
> > > >> How IVSC handle the privacy request from user? Is there some
> > > >> notification mechanism to user-space?
> >
> > IVSC has already defined privacy callback for host IPU/camera driver.
> >
> > > > I'd have concern if IVSC driver
> > > >> need private callback to request back-end(e.g. ISP driver) to
> > > >> handle stream
> > > cutting.
> > > >
> > > > How does the privacy mode work, does it just pass zeroes (or other
> > > > dummy
> > > > data) towards the host or nothing?
> >
> > No data on CSI transmitter side
>=20
> Can it stop in the middle of the frame?

No,

 Or is it guaranteed to produce full frames
> (assuming the sensor does)?

Yes, full frame will be guaranteed as camera sensor does.

>=20
> >
> > > >
> > > > A V4L2 control can be used for the purpose of passing the
> > > > information to the user space at least.
> >
> > I will take some time to review V4L2 sub-device and control mechanism,
> > and then update the driver.
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
