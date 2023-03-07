Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3E6AD95D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCGIkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCGIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:40:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F241B6E;
        Tue,  7 Mar 2023 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678178417; x=1709714417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cWCRiyUTy9aEC6NyLujEyTsk+EuJ/x03vb6PqhIBYYw=;
  b=TcAbYuAVOqgRM9tUBuqwpdgkyrOsksf2PwXGPSA9EyEj5G8BC8eS9dc7
   oxeskqk9ajF6z/1xkpnulLzkRmhrceQph9uO5a22tNLZriFPvuZSmYg06
   8XgzUtLipesmRJNmfjmrzy1FvJmMg/G2d5CqC1m1pS445IRsNwqPLT3tw
   avAx0kGG5lQ1plNqyDRhvrfvr5NmYuUeAO27i4zmqq2QBUgckTeHtWYyc
   0zRj3po/N5aU0CFD/9Oa2SvJXw8WyJ3BcgWqyDU8Jmy9yYpsw6FoDhH0g
   Mj7H3ScT6ccemgdqpT5ERqlyCgnZGOOPYQeePIGuo81fxmzCdx3aAI8o5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363419637"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="363419637"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653901897"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="653901897"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 00:40:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 00:40:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 00:40:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 00:40:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su7+iP0uY4o5oog+pzKG/J+YyrFZmHuqBcp+kf/EAW0u6kfi+mc018BtJO+L+gO975J01+OLdQ0U3sGASn+oR4dCBdn3y5LLyHxO17ybvXGcCg9moPn8BSIozwUThLQr8tiV8/lDuAI9Jl7vuq5nQDtPogAJJ5ie2g6YF+98VYg83+bzRXUmADdai+H+U8tas8y96hNUxA3TYLVrf11grb1sRC6m7DzfjcJn+cgpfAYmENrHgyGcq2OahAj0s3JpcTz3ffioyKqHi8+5yNADM8SvrgKiUZcFWWbsN3e+k/WM3ZrjVqdlMkKs7lmx/04FHBjGPjviI29Uf0kf7q7uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk1DOOe7wCLHemIiZn/yTB4vAdlQ06kF7V3tFxvg3/A=;
 b=Q4b3WMBi9oLy9zgbBgJDF63qpfAiG/AJA1i1aynCA/cyUSUWUrlah3cGTc3+heZnm36y9U+5a0U3egTQ57jktWW4RCPbJ6ZdsU2RjuOEu0810Jf86l06VtWJKtdGfNPWnJDc25no3ZAhVGXVh+q2ZM9x/lLL/lzxUKh2+JSlH9evvr8LrnCnmHqDVRjMbWwP0/GQ/uy3truYjBky16y3WpfDc6VxrnMRA8NIVc5ZDrwW4+blnpY7V8Y6mUnV+tvl8jx4+caj3dWI7twBR36TBgghMtdoqQJX/iLaW7CvDYrLJ1Q17/30ZfzJkqonrjJPXhw3IAbhgduUNVuwsGzOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 08:40:12 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 08:40:12 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
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
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7l1BmAgAACFoCACULV0IAABnKAgAABmnA=
Date:   Tue, 7 Mar 2023 08:40:11 +0000
Message-ID: <DM6PR11MB4316B4F865472CA998E696FC8DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
 <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
 <DM6PR11MB4316F4B72F98ADBF577412378DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
In-Reply-To: <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|DS0PR11MB7879:EE_
x-ms-office365-filtering-correlation-id: 8f5e1c50-27b5-44f8-4d58-08db1ee790e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cfdGKa+zqQNGf7IqKrE/9TGJ/R/eyl3uegNZvOrs5X9NVx0pXGUyBJynjvTzk82LhWhSBzLfo4cI5COCUR9wkM7pgj2R264+BmN50OT62K8QcZs0w17gbshDXjSBoCUVmTxiwp9jPhYCyIrtZeaIDOb7yShdHo9zowR0gsVcwMloRsKo2drEr2c2Ccon6xl/q07xYR+MMCo1DYJm8XecPM736PRdEO1eZfuE2SkJuIV+rpBZmT6xpXDi7L0b6mTnl1+sZMnmCfNrNj2lRKsLsMfnem2J9JhBpTBV4wfn8W/sW0Vp8N/XfJEp5Zq/ZkF7AkSGX5JOI+21nDCEnSUSrtrWOIk1FIEZRF2+orFJOUtQG2usLxdWJNHQHDWaC3FPSsX9qjczCCIYDhjd3Gcl69Ps37d9bSNTL8+rBvPsjyuGp17NVnYR3gvGuTSK3i865cbVZ0zktKjyIPruCmaWxcKjTT7WHaROY3SdQzzu9A089pqnxk37mlrS8ZKHpJrBTcbba6ZyzKMtIUIRdjeH1Pco2RDJiSIR2vg40HgX2iHoviP2lL0rcSg1u3vZXR2SzlJlcZynEgJ9mHqzUDau1r6NG+Dw8Bw/Hb1cMkfYUznId/wdYqFjzPABUFaCq5nrW4C8D2CWrmCq337B9KVUYu9oW9R95G0Hs6QS84xZwZ84YV2NOgE/r7yPgoiYvz1hChu+elkqjToKX0aLwlhB8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(316002)(54906003)(66899018)(83380400001)(55016003)(86362001)(33656002)(64756008)(9686003)(186003)(82960400001)(76116006)(5660300002)(66946007)(66556008)(8936002)(66476007)(8676002)(2906002)(41300700001)(4326008)(478600001)(53546011)(6506007)(66446008)(71200400001)(26005)(7696005)(6916009)(122000001)(38100700002)(52536014)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5hygwlz17LoXYfIRRZMRO5DM0itqQMqTkMmmGfY5cB48k8Vjp9etogXS+z?=
 =?iso-8859-1?Q?JFJM7/l2XrhuCBAM+SMQgk0HYFo5zUGYXPLhFr631UVocDJVca39O5LKqf?=
 =?iso-8859-1?Q?kThFF05cXs3ikXOhhu4cMZooGg3BqwqAxPyCUsBjs1TSd4cLwu+1mSJKsk?=
 =?iso-8859-1?Q?ZbezsTgHitRbBXixKicQLNDpLGPot+UVyty9yBx5+gkaNTzLb6wqs8vkdl?=
 =?iso-8859-1?Q?07iu+8KVhXsof+TnpPA5H1KJHzJIWSJVRXsYLL/UMP0fEO6kdEV7WvQN7N?=
 =?iso-8859-1?Q?dKID6zRN+QSGlUmka65m1g+wQeM1GwRVEKlXF2909L1FbBn5it3j/07G5l?=
 =?iso-8859-1?Q?MzM3Lb8gDHv1x2Bgul2E93fM1WBC/BPUrMxEbwv3T97dela38RsmMrx1Ds?=
 =?iso-8859-1?Q?jFPirMjqU31S7/Lugv+0+DJhIm4e8IRShgJUdzIv/AIbFl9OPtqBP7tkuK?=
 =?iso-8859-1?Q?ykJC2Z47RAZwH9rnemznrfH0scDaymMyntFNPKQlXSfQmVLLbthFmN4zKw?=
 =?iso-8859-1?Q?KABKOgphnQY1oTeiFJ1JeVYqyx5RLwomXSOEI+pXNxGpzNsJHgwuPHdAaz?=
 =?iso-8859-1?Q?0yqNc+39IgI59GzgA2+yTSNhYGSK9yFoXwOATby4ikVesmuPEDD/Adalkc?=
 =?iso-8859-1?Q?k26RkiJ3/h7m1k0oM00htiZV+Q/fkJz2Cct/OeC06R7/4vKu7rvC3c4uLr?=
 =?iso-8859-1?Q?zELiH92VRHgYAehL9LrZb0wLFZRXAdO/CCdI917xjXO5De0Z7fawCab8zg?=
 =?iso-8859-1?Q?HaiiVaMWNpPuzsS65N+C++IHDt1syuFgd9Sqf+MbxTlIsMyPjRjrsomMFb?=
 =?iso-8859-1?Q?XBnWFB8Y5yZ30DMUeBCCIP0QVh/iexDa5Zo2l8RHUzBuRKByrpMVHR2mNj?=
 =?iso-8859-1?Q?DsS4OGpShilom2EFXjhBg9fe4bvcAFWnTKJuckZ8e23lKq5m9pYz28/mOM?=
 =?iso-8859-1?Q?xj3Ob5ckoCy6K5d2gfZozdpdkU/3fztuoLcO0iak1UncJdq9V0KD1KSoKE?=
 =?iso-8859-1?Q?Dxc3i4u0cfCRLx5TBq3qoGaC4H5X5tXLhYzhOiUXwp6XmgTU6X8EayitHW?=
 =?iso-8859-1?Q?oHNExvKh7+VSqeiArGlSHCN1NiPmzhnzZ7///iG2vGywU3qlFFsnoUgu7x?=
 =?iso-8859-1?Q?81W2YACr+7Y0XuzeFdVyTBqryvuRGmuRYYcwc4m/vzBrcvxFBjVTe7lcO1?=
 =?iso-8859-1?Q?V1o1C3WQfIBnmEiC5+gmhS/zWrT/vi7VRaQRx0bFRsJ8wC4cLS8XGQL03c?=
 =?iso-8859-1?Q?zHuU4YB6Eavm0hFBwPkif0dAzny6+iFyAqqYI1DQQBFdXT6tm/DSLqU+ow?=
 =?iso-8859-1?Q?80wqFx24ug/4hEtlH94D89j+wWjz+G5kn1D+bS0goHDe6ElZAZofk4vMdd?=
 =?iso-8859-1?Q?cdgN8S1sgsVT1fqOexan2baR4eemkKv/u1XY+gBWLNYujxsyZMGzyikFG3?=
 =?iso-8859-1?Q?OgEpK7Pc+pEk7TgMkZE0yi3i299WM4MVI3wYp93nA6cAKlPhJG7wM+BiEX?=
 =?iso-8859-1?Q?jk4/cOpabbVCSo77yBEAo+PbpIhJvuNgKVHHpjs7iOZPdBc7jEbbxvdnIw?=
 =?iso-8859-1?Q?QsgBifUZPxqwb1E2pW+Pv3a9SDNsqCc1LorbNNXtrz2oxSYPYT8FZwPlUX?=
 =?iso-8859-1?Q?ytBDoFqXrnsvpwie+82afzUyfm4M3C1z4Y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5e1c50-27b5-44f8-4d58-08db1ee790e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:40:11.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YU/FdHBNq/A0PeP3ckXxFX2IeclQEYsJL2/rugdUlIo8M0SEbIl8oTTxi1mrN8x0feEX+MG59DSo3TDAhUdcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Tuesday, March 7, 2023 4:30 PM
>=20
> Hi Wentong,
>=20
> On Tue, Mar 07, 2023 at 08:17:04AM +0000, Wu, Wentong wrote:
> >
> >
> > > -----Original Message-----
> > > From: Hans de Goede <hdegoede@redhat.com>
> > > Sent: Wednesday, March 1, 2023 6:42 PM
> > >
> > > Hi,
> > >
> > > On 3/1/23 11:34, Sakari Ailus wrote:
> > > > Hi Wentong,
> > > >
> > > > On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> > > >> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls",
> > > >> is a companion chip designed to provide secure and low power
> > > >> vision capability to IA platforms. IVSC is available in existing
> > > >> commercial platforms from multiple OEMs.
> > > >>
> > > >> The primary use case of IVSC is to bring in context awareness.
> > > >> IVSC interfaces directly with the platform main camera sensor via
> > > >> a CSI-2 link and processes the image data with the embedded AI
> > > >> engine. The detected events are sent over I2C to ISH (Intel
> > > >> Sensor Hub) for additional data fusion from multiple sensors. The
> > > >> fusion results are used to implement advanced use cases like:
> > > >>  - Face detection to unlock screen
> > > >>  - Detect user presence to manage backlight setting or waking up
> > > >> system
> > > >>
> > > >> Since the Image Processing Unit(IPU) used on the host processor
> > > >> needs to configure the CSI-2 link in normal camera usages, the
> > > >> CSI-2 link and camera sensor can only be used in
> > > >> mutually-exclusive ways by host IPU and IVSC. By default the IVSC
> > > >> owns the CSI-2 link and camera sensor. The IPU driver can take
> > > >> ownership of the CSI-2 link and camera sensor using interfaces pro=
vided
> by this IVSC driver.
> > > >>
> > > >> Switching ownership requires an interface with two different
> > > >> hardware modules inside IVSC. The software interface to these
> > > >> modules is via Intel MEI (The Intel Management Engine) commands.
> > > >> These two hardware modules have two different MEI UUIDs to
> > > >> enumerate. These hardware
> > > modules are:
> > > >>  - ACE (Algorithm Context Engine): This module is for algorithm
> > > >> computing when IVSC owns camera sensor. Also ACE module controls
> > > >> camera sensor's ownership. This hardware module is used to set
> > > >> ownership
> > > of camera sensor.
> > > >>  - CSI (Camera Serial Interface): This module is used to route
> > > >> camera sensor data either to IVSC or to host for IPU driver and
> application.
> > > >>
> > > >> IVSC also provides a privacy mode. When privacy mode is turned
> > > >> on, camera sensor can't be used. This means that both ACE and
> > > >> host IPU can't get image data. And when this mode is turned on,
> > > >> host IPU driver is informed via a registered callback, so that use=
r can be
> notified.
> > > >>
> > > >> In summary, to acquire ownership of camera by IPU driver, first
> > > >> ACE module needs to be informed of ownership and then to setup
> > > >> MIPI CSI-2 link for the camera sensor and IPU.
> > > >
> > > > I thought this for a while and did some research, and I can
> > > > suggest the
> > > > following:
> > > >
> > > > - The IVSC sub-device implements a control for privacy (V4L2_CID_PR=
IVACY
> > > >   is a good fit).
> > > >
> > > > - Camera sensor access needs to be requested from IVSC before acces=
sing
> the
> > > >   sensor via I=B2C. The IVSC ownership control needs to be in the r=
ight
> > > >   setting for this to work, and device links can be used for that p=
urpose
> > > >   (see device_link_add()). With DL_FLAG_PM_RUNTIME and
> > > DL_FLAG_RPM_ACTIVE,
> > > >   the supplier devices will be PM runtime resumed before the consum=
er
> > > >   (camera sensor). As these devices are purely virtual on host side=
 and has
> > > >   no power state as such, you can use runtime PM callbacks to trans=
fer the
> > > >   ownership.
> > >
> > > Interesting proposal to use device-links + runtime-pm for this
> > > instead of modelling this as an i2c-mux. FWIW I'm fine with going
> > > this route instead of using an i2c-mux approach.
> > >
> > > I have been thinking about the i2c-mux approach a bit and the
> > > problem is that we are not really muxing but want to turn on/off
> > > control and AFAIK the i2c-mux framework simply leaves the mux muxed
> > > to the last used i2c-chain, so control will never be released when th=
e i2c
> transfers are done.
> > >
> > > And if were to somehow modify things (or maybe there already is some
> > > release
> > > callback) then the downside becomes that the i2c-mux core code
> > > operates at the i2c transfer level. So each i2c read/write would then=
 enable +
> disavle control.
> > >
> > > Modelling this using something like runtime pm as such is a much
> > > better fit because then we request control once on probe / stream-on
> > > and release it once we are fully done, rather then requesting +
> > > releasing control once per i2c- transfer.
> >
> > Seems runtime pm can't fix the problem of initial i2c transfer during
> > sensor driver probe, probably we have to switch to i2c-mux modeling way=
.
>=20
> What do you mean? The supplier devices are resumed before the driver's pr=
obe
> is called.

But we setup the link with device_link_add during IVSC driver's probe, we c=
an't
guarantee driver probe's sequence.
>=20
> --
> Regards,
>=20
> Sakari Ailus
