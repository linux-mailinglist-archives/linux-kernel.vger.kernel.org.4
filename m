Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23116A90C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCCGKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCCGKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:10:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D8F1EBDD;
        Thu,  2 Mar 2023 22:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677823838; x=1709359838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YrKuHJ/CHmE2xNy1oEID2orL+MSUhoUQ7c3OIv240vc=;
  b=Rmg3sT8PBwf4uZKOg9css+fd25NW0V/zq/f8ItZhjwr4QQJwj4hb8Q9+
   4qzYw+f/7ACVDGEsIesIGZsHJcu8cVMLexuuDeJG6JbQRHu857KC2hyuj
   pVeXCSmTA8wTm2DkaMFOSIamcz8h3XRJp8MEQslVISean1huYagchMu8d
   FuA2c7E0rKz9agx8LM3VV0w32nmQNuQQCr75eqtOyZ/8kQq8J3d9J9PU3
   x1AYgcNdRk3qztcY/nw/56brlNeXz/NuEsUe1tGS12ypllCTBk5gKYSPe
   UluFDSYLhGEA6IoDHMRr9jTib3WCtGBhH4GEwjt/+utYKOI/MbzcAhi2x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="332445060"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="332445060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="799127923"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="799127923"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2023 22:10:29 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 22:10:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 22:10:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 22:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiGwjpisGlqRXELNZBG3auoccz2euxOErgg7h1ReE8jCglFz7BKOkHMj06bqT4l4mmVJRX0HB+e1Q3cP8prBOwFFA/aSjRGogCkjM0qlHgCAzmRN2Cny/hvYs7Nd3O+tAGug5s4g3yeT7rw08iffUGjKlYjMp3BVXeUha1/k3tYtsoKs9oOp+q1MfBfaL5uGA8ZfPaIvHOmT6cdpwQEJMrRGT2aVnkAMlrtsnfePpnM2BQoODLzht7/wkuqACt8fi5qrEVMMWM8v/h589hZMsr6KtP7qmLwD8WLnIED7As4dteltdhkreV+OyrOvZAXYdr11vJCMzlK77f/95f8Wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O5M8vSKudsyJU28ctRZwvEo9KcqWzOBIFTRfd8eq3E=;
 b=MU3uBPm3PdtM5izBLSQ0S6CRYEV/FDG6etZarw+5to8yaG3DrECEscdX6MeKJzR+POIfg7deKC9BUYmFtnxl5LO8F354gSLcntBiW1pNyL/nRo0L83L9dT6J3cju8ZvgkchMUyYqMNGaEc5lQXzQsHwgvomHGTRC0x8F7QOH/vuY2bSOcJqSE7naEX6PPzA0nyBb3iHd7+DVZFoeiwjKbgbFd+umA0alqQlJ7IjNnfus/6Rxn7xW5ePOiLKOZsVM5YqYjwZ1ZTMG7zVnSpVmTeDZYP+mLfJK2zV80bGf7zw5xZ7BjY4/mRHsDUF6qvcQe8pFbEzIfl4lBp5EyX7Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 06:10:24 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 06:10:24 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7l1BmAgALVIdA=
Date:   Fri, 3 Mar 2023 06:10:23 +0000
Message-ID: <DM6PR11MB43161891523B407883E9B4488DB39@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
In-Reply-To: <Y/8qJzScTfFucpP9@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|SJ0PR11MB4816:EE_
x-ms-office365-filtering-correlation-id: d3bcacad-e620-485a-e275-08db1badf9af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3sNi6Rhd4XH/PF0Vk+125EoW0OUbejXIUDMIpmsieD6P1FALiT4AfcIHHmddlheFmV7pN7BqHO86QqhqHk/fmuIxysqAYkNu/FlufuiY3+b7+50DZksY/wNtV9CxDlum8qgI0uLMQ4SXCHeZZLyPz0t3LDzZAP2w0sEV3CAnOO/6UPVykR2WqOCKpiqzdHBpUmv+1A4ldf0+cJerj5sZuanTgAbve014pJ6FKRasCYS0KwjoErleRiYGL6UtfNWHaXLlzElVsen9qlMvKrPwul5hY+GRV8OlFHcUg5dTRyJh2c7tvKtovKSceSe8+GhkrYIkNJ5iWFOTqMFMp3rYJLliy41FheTgSoInUzTZLdI8pidBks6yfXpIxz+5enj5sf2FD8mC5T9NZ6igksCEr911KxKznN/SfENz3ZM9Bh19f925U4IvubX7QMngIvBHilCMcW9XdZm9AKBUqsnguRRUILoo0eGkTvmU0PxX8Yl7YNUF4z/Ml8dZQONLf5wDpQR08m2tXUodQ3HvyqS23EMSQigT2kGC2MmueGZ6WSAByyqylHJKQTTu+iz6o/dHSGaOcK2P1zoSg9BGP/7mQ15iKvsUJarb3RUg5EMhT7uwI4BdmAc9Kpg1a79BWp7KumF27IwxwBNw80TFXHhcmH1eZC5ES1Tk8ERj8QKlXmsy7Y4kRzHhLCDgbQ2N2HTeSyeyBMXLFtNsbfAQ14UKgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(478600001)(71200400001)(86362001)(122000001)(186003)(2906002)(7696005)(6916009)(4326008)(76116006)(64756008)(8676002)(66476007)(66946007)(66556008)(66446008)(83380400001)(54906003)(316002)(33656002)(6506007)(66899018)(41300700001)(38070700005)(52536014)(8936002)(55016003)(5660300002)(82960400001)(9686003)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pP8+hwh0gfT+wKBr6TYoF/xeOxiLzBB4fzEFH6LS1KVdI0T5ZB/2fmKQlO?=
 =?iso-8859-1?Q?KJPe6ecC+hJfz64DR4fMeFbtW9A5oznmSF1iAccXvlAM1/5wv5Cr71GCEc?=
 =?iso-8859-1?Q?2TGTDY01BBmDqaLBr4R0sI7jmIWe9LX+d9dZEK/eEHpCJTiSHutfbwHYkz?=
 =?iso-8859-1?Q?GiucDs1zwpWhyOaudAO3mdzpLydzczKxoGskMqhFg0+2/YjHUVuDyRSO4S?=
 =?iso-8859-1?Q?UlcgeUvH2GNZuuZtTcq3aEkG7RQ2Zi/XZYiybx9kBJ+MNGb+iBaS0ah+g5?=
 =?iso-8859-1?Q?QDGXHhjXvNUUTGaEGwCbq7bFbgd2j6C7y+vLP5cySpzL6y7E9BM7/anQOz?=
 =?iso-8859-1?Q?tWBOGn4VN3C3FaCkZh0V+N9YMrMvgcMIIHegPoIQw3alThw+OfJIpkhA1k?=
 =?iso-8859-1?Q?JRmx1ea5dI6EiMmEAwH13qshOgrFPd43bxbWOCmVtP/QNQM6iM8/MrCvZ4?=
 =?iso-8859-1?Q?8SeODPPZVzmF09C/u8LrtVpLTqmQxw1qk2+RPXxkV2aGptVYk/BF85yfj8?=
 =?iso-8859-1?Q?9jo783GD6LPxdaBIWXRMgx/d6k7w98CW/92OFq3z5Xj4Va1AnvCAA76WR5?=
 =?iso-8859-1?Q?ycdYGUUPbnJ8YSEvTdbX3xzS2nQ0wEISavIBC2CAEj83PSfMwHnRz7vepM?=
 =?iso-8859-1?Q?2iuwo10CbFQSug06vxsTWw7OqGjBitmXnCLb3Jis7Z+gqkAJUqoUT7pkUv?=
 =?iso-8859-1?Q?9L0qf25U4isr+OBCOpbJhmW1uIUWhYNenytFCrUijcv3848FS7ROqNUgbI?=
 =?iso-8859-1?Q?7nQXWlKxEpJOM5LuZQ0JAYA6VpGwxiEzcGsAqs1OqrC99b5drvqA3EZDWh?=
 =?iso-8859-1?Q?FLsY9b7nwiG4Vxh08ieseJyvks6JKN3OxEfltFIywl2Xf+uhrW58gZA3pv?=
 =?iso-8859-1?Q?Hhbsj6vLMsvUnepekL0/9QYo8KWtryIwuJpM+UQK+0zhSkUL/Zm7pGUiXQ?=
 =?iso-8859-1?Q?8igN6ydX09ee3Y85gVxPvO+1mlvr39z1gLhbuL5dEQvWaTEQCZqcWylBP7?=
 =?iso-8859-1?Q?EbLgbrXDGo7DkX8/3wek4pBcWQq69bGLErwjc57yu5iotfdODZsqhulZ8n?=
 =?iso-8859-1?Q?hjjebOHpjHcGHf9Gvi23sh80jAsuGeH2I+S48kpTMecFh1q9C3OhF4Yr2h?=
 =?iso-8859-1?Q?C+vU+hydZtsggAgDKr/ZWEbjSxhm89v/jUrtmZ6JgLqcEZ1Lnm5MHzVLop?=
 =?iso-8859-1?Q?LtUOHR0Ifk8Tu7fOZaIaphmIcYSJxTzOTcfnmvQhSVwLoySk884WM2qm7A?=
 =?iso-8859-1?Q?O/n7HzcafoXdBJDMpJpCn9DuUJKrVTIeyPuysoD7DYNbSVkKa2kMKmIG5o?=
 =?iso-8859-1?Q?nEUSfuUvPvZMNyopIiCJC9rhx3B8sz55WPSp0HYfA8/r2cNR7yYitIaHyR?=
 =?iso-8859-1?Q?H6Uq9j5vPAcoZtFtNijE5cN2EvAHK+dH3sIFvlxkQityI+k1APV6l2KSE8?=
 =?iso-8859-1?Q?r4H2qADJBJ4n3JBYMFd2TLXK7yt1xdrZETkx2cDQ7Xuil5fsuFO3aESw7V?=
 =?iso-8859-1?Q?dUXTZdsGC3D/eT3bitCUvJ8fpspAyMNv4dfO1teKA9EopocA3psKphGgwl?=
 =?iso-8859-1?Q?Iw4L/vDUigK2Yu7lmtWJgHPUlN5GpV2b59nBOXPX7URcazKk1wihmk/L9u?=
 =?iso-8859-1?Q?URUavg0U+MjURxHWexgR9sn3LU7nizIb8M?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bcacad-e620-485a-e275-08db1badf9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 06:10:23.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kakxqi3fiNTQiVytyGJLN9P6XpSSSHXfp0w8IOcmRPne6l9u6BzyhhOunUhvlkTuwYejCZ/+r4PJEIQLroxpFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Wednesday, March 1, 2023 6:34 PM
>=20
> Hi Wentong,
>=20
> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> > Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is a
> > companion chip designed to provide secure and low power vision
> > capability to IA platforms. IVSC is available in existing commercial
> > platforms from multiple OEMs.
> >
> > The primary use case of IVSC is to bring in context awareness. IVSC
> > interfaces directly with the platform main camera sensor via a CSI-2
> > link and processes the image data with the embedded AI engine. The
> > detected events are sent over I2C to ISH (Intel Sensor Hub) for
> > additional data fusion from multiple sensors. The fusion results are
> > used to implement advanced use cases like:
> >  - Face detection to unlock screen
> >  - Detect user presence to manage backlight setting or waking up
> > system
> >
> > Since the Image Processing Unit(IPU) used on the host processor needs
> > to configure the CSI-2 link in normal camera usages, the CSI-2 link
> > and camera sensor can only be used in mutually-exclusive ways by host
> > IPU and IVSC. By default the IVSC owns the CSI-2 link and camera
> > sensor. The IPU driver can take ownership of the CSI-2 link and camera
> > sensor using interfaces provided by this IVSC driver.
> >
> > Switching ownership requires an interface with two different hardware
> > modules inside IVSC. The software interface to these modules is via
> > Intel MEI (The Intel Management Engine) commands. These two hardware
> > modules have two different MEI UUIDs to enumerate. These hardware
> modules are:
> >  - ACE (Algorithm Context Engine): This module is for algorithm
> > computing when IVSC owns camera sensor. Also ACE module controls
> > camera sensor's ownership. This hardware module is used to set ownershi=
p of
> camera sensor.
> >  - CSI (Camera Serial Interface): This module is used to route camera
> > sensor data either to IVSC or to host for IPU driver and application.
> >
> > IVSC also provides a privacy mode. When privacy mode is turned on,
> > camera sensor can't be used. This means that both ACE and host IPU
> > can't get image data. And when this mode is turned on, host IPU driver
> > is informed via a registered callback, so that user can be notified.
> >
> > In summary, to acquire ownership of camera by IPU driver, first ACE
> > module needs to be informed of ownership and then to setup MIPI CSI-2
> > link for the camera sensor and IPU.
>=20
> I thought this for a while and did some research, and I can suggest the
> following:

Thanks a lot

>=20
> - The IVSC sub-device implements a control for privacy (V4L2_CID_PRIVACY
>   is a good fit).

Agree, thanks

>=20
> - Camera sensor access needs to be requested from IVSC before accessing t=
he
>   sensor via I=B2C. The IVSC ownership control needs to be in the right
>   setting for this to work, and device links can be used for that purpose
>   (see device_link_add()). With DL_FLAG_PM_RUNTIME and
> DL_FLAG_RPM_ACTIVE,
>   the supplier devices will be PM runtime resumed before the consumer
>   (camera sensor). As these devices are purely virtual on host side and h=
as
>   no power state as such, you can use runtime PM callbacks to transfer th=
e
>   ownership.
>=20

That's pretty cool, and the device link will be setup during mei_ace's prob=
e with
device_link_add, but we should guarantee there is no i2c transfer during se=
nsor
driver's probe. And most of upstream sensor drivers don't initial i2c trans=
fer
during probe, but I have no idea what will be like for our upstreaming sens=
or drivers.

> - The CSI-2 configuration should take place when streaming starts on the
>   sensor (as well as IVSC).

IPU driver should make sure start sensor streaming first and then IVSC sub-=
dev,
which will match the command downloading sequence required by firmware.=20

>=20
> - Device links need to be set up via IPU bridge which now is called  CIO2
>   bridge (cio2-bridge.c).

Reviewing the code

>=20
> Any questions, comments?
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
