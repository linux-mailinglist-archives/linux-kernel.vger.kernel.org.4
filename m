Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733B6A681C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCAH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCAH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:26:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28B20040;
        Tue, 28 Feb 2023 23:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677655606; x=1709191606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=grAFAKzmUP5434WZgnUehMK8Agrql5EsdslA0sNrk+Y=;
  b=YY73DieXDenxIZypG5V5JC5U6/9r6QdBNksC5CWwLy+RP62uXtyOamcZ
   V/t2neGed/qek1uiNzXLxqpzl+sI64jQQoI8HkwgqENjzvte7DteBnKST
   SlRBIi5rHee4dcwKrY6bN1whm4Q8w4JQ9Bl0EzbrDwRJ1zz3PBndMrCmL
   Tz+hoNvfyDbygkm5AOZ+3/NNSUNagHmk1YJ4uz9ZwjraM/DcpkeML8VEj
   0FFpf2OkO60cX6wmefO4Z8iPodmPU3dVQ4p1+d5cPzFoEGglDEO/C0O5j
   d44IAcmzSCyqws7zMWfJrMEcaQncqdFt78VokvnMX8VjZtZ4VmAlQEnQ1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="318143679"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="318143679"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 23:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676649150"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="676649150"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 28 Feb 2023 23:26:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 23:26:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 23:26:43 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 23:26:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLOYC+Y/rOrBXA6MEyxYro00rTilfVICioqtd/FKX5jhpzc9Wyaaoopp4BMDKPLBZsO+0IyKqroPA/V26pdx+wraelsDRj/UTD+MXZqhumkjoHgmFCr3JCwbYHcReR4NebNtr/7yO0pWIjPWHvS5pCW7jAB4aUR3G+b9vmV/OsLfvNPkfYr1FO9ftYd1CB7t7DCzYHZ4bL0to0Y71gHOOOH8KaWtz2gKSW+mx6ykdFcdxAo3uTNo6Qz3JruZJdblfMwSvcjfIXfHN5oO8nse9AqymACxDQnLH9aPh//guSFCOFy1Rl8yPViwUErKVfjr2KUVQJAgXA96Is625h5n1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grAFAKzmUP5434WZgnUehMK8Agrql5EsdslA0sNrk+Y=;
 b=R6KQfS1gziY1ToulPobDh8mB3YVUjaWxPk/d+T0AyzeeNFVvWtdw5Rq357Ple8NXQNMiykAjsQ2DvmIdZN/d6yyh6L7nybQRxENOIaA7bbEo8GqUtvgmJFSerFBQly06qpLz0THAAIrdjZMx3JCXEi5vanGXdCm6nbk+pL5iW7jxrwTzOIHaDf/YkicLFQgswf+t+AbsyWKWuXikasLcYK8gTPuDAPwGBv4CDVXz4gNxtyAjO03eU7PVpFV1eyp2+Xx/NVUM+akB0rXA4ob/OvUSlLgk2y8DtbJmk+bzMEoyuW/62eURaWiuWium2k1jY6sgT1dQShy+KC8l6k/ygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by PH7PR11MB7003.namprd11.prod.outlook.com (2603:10b6:510:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 07:26:41 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 07:26:41 +0000
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
Subject: RE: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Topic: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Index: AQHZP1Hum/btr+ww/kiynrKipZgIc67OndeAgBVeV6CAACETAIABdr6w
Date:   Wed, 1 Mar 2023 07:26:40 +0000
Message-ID: <DM6PR11MB43167D398FE7F280C54140B28DAD9@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <DM6PR11MB43169FAE93274F64AA7E06F28DAC9@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y/26BpJ15rpSAypW@kekkonen.localdomain>
In-Reply-To: <Y/26BpJ15rpSAypW@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|PH7PR11MB7003:EE_
x-ms-office365-filtering-correlation-id: 319adfb6-1413-4f4d-a895-08db1a264d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyHnGTtbVTuAXS7OqyaJr76mqF31c6vpmYaxkfdgW7fvr3TN9OO9+hD1DPwndpHdFVqnFia5r5/BOfQ7r0Yrnhuu+8f/p2VKelLaE5MgpdpzDHMGWYoNObHwQ1P2iYr30+7ZpaR+whBSscPKDQaFKe++7QaqEsO+h83lGBJ65KD2BThBskmEY2i/Kn/SxMX4IlcVZi/7P4y9f+bbiIOhktbEqGRsKQrtwZ2iqOnO5X8OZb4DdiyJk6Z/rTSTkkoPifmgpzXLQYcc100l5it1Vf8tJveKnblajU6B+3tbJ86Ae06tGQh2EeLTAx0mGxJyoGAKzkdu9lBFaenKe8xtwuWpNv0Abh3IycveeccPamHytAMH1/Q+npI2chvEaIX+VhDe7/FWf+tPyo1XEUyOAhY1tfCmjVjGgCVYMiHFmpEEYmJbSbZNp+Klosl+kOQcEdPFXWKsnM+Q/VJr8BVTJxjEbOeIU/DvOIAmnazRTrzFtwE0h4xrfS43Ds//1FbSA9lUhvAP0bYdolbfWrQ40tmRWpnmJEhHSUxgP1zvRR2OXocfyxk6oSKf0eCTFmYBX5dndNDI+zYvOn+UcB/o5LcDHaxwdabaPFxdBVOM2HvMtF2vSSItKv+mNlhF/O9HF6c+JO47ckBNVeGx6ssUWX7Bpx7P2rV/9d0mfkvQncdINWd8BxB9uUiEtJM5X0Xx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(66899018)(71200400001)(4326008)(33656002)(86362001)(66556008)(66446008)(55016003)(66946007)(66476007)(8676002)(64756008)(5660300002)(2906002)(41300700001)(6916009)(8936002)(52536014)(122000001)(82960400001)(38070700005)(38100700002)(478600001)(316002)(54906003)(76116006)(7696005)(83380400001)(66574015)(26005)(9686003)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1lSGbe1RGqK/SHQ0yEs2/rlUn4Av5pdhxFgbnZEzim19SKXYKDspH7MSixqY?=
 =?us-ascii?Q?xWs1HDwfT0AbsnvaAUrSGNoY+K66kvHHtqmt+WhDkx0nfEgtfVB751xIb7hr?=
 =?us-ascii?Q?matoGzyHgaPqngT2XAS1hHbXybxJTp73SBS3wc/u2QG14B/c0GfoNhI+LOA4?=
 =?us-ascii?Q?lvehvRPjOYDkSlIS9wMtdX0xcadCZ5AB5JD9vH+Hau5xDa3dItW5Rf36gFx/?=
 =?us-ascii?Q?8MreNtsjevSj81QNES/lcsYA4Q2Ac4NB7lhUuLp+lIRSXfeNny6/0G+78iGx?=
 =?us-ascii?Q?bJTSomelO25ys/Nj5G0fI0yxyX4+eDaYHB9a60WaN0oSWC6T8ufwrGDDuHZJ?=
 =?us-ascii?Q?Tr3uxEwNXbNQd2Fuw7UyVmYDUNs7lNaY3momdxXiMH0PhSg8PiPBRQlvp15a?=
 =?us-ascii?Q?uQwh3RaIQKVaCrmsCcFu3m78V9goNT8IDaaB8YN/9J4YQQ5lihO5hh2L342D?=
 =?us-ascii?Q?6HlXHMCnpKz9fDd9Pn39gi6K6KePWRlYiDlHXCvzx0L0g7xgPDo6HdXOv5xy?=
 =?us-ascii?Q?w9eR5pcL8/pj2A3uK8zU9z+tT/TetVRZ2BmZhiNnsuUns2cy56F9WVvXB/CY?=
 =?us-ascii?Q?vNBtJqHHWpG2QfxqBj7vmwYCy1gFjhxhawgB39VaA+1cW85r1LCBv2wKp6NL?=
 =?us-ascii?Q?MjQg8T8ZBkVXicLk2k/XOoYaVwT4GIIKmYPftDk5E18+mcQ7lFVQIt12GlwD?=
 =?us-ascii?Q?6ZF95jvt0wwc34aP+HGlfI9r28NU/fQEq4IDTAozyCH33LNrEbIqFiwubirW?=
 =?us-ascii?Q?AeUMYyr1kbZtNpc06kPD6X5kyeSB1AMZ+LoaOrCkKFNlN8tOtvIQZ3dcXSPy?=
 =?us-ascii?Q?BrTn3TDDfxfs/e5p3/QEuZq6P83yegC2M5CvWtGW6nl+771elBzLHj4UJc/q?=
 =?us-ascii?Q?QGUr1AyF+48XLfzxAWfWokYA1SPrWqFdJCazWU8RKXHYWtIcrE7yytpYfuK3?=
 =?us-ascii?Q?C1lm1PQPKqSpJ7UmYkenaM2mIfh77Ras81kSnQFPdf26RsP4f1GDW5DwF66Z?=
 =?us-ascii?Q?b/IM6i34J74hRHFlKL0/wSIPV4Nln5y8gPrnFrXvo4OzI0kH0CS3/TeMmGvw?=
 =?us-ascii?Q?9OPz3OksiHdVlVDilwRhGb7afZKgiQb3+jHzl4NU5PWTdgf/sTJjBpBNKPAg?=
 =?us-ascii?Q?eZp+Yp2+IIYey7GdRd4CrwBjEu+zb25qEb50ap/EeBAMT0LIpNDoeCsp1hjc?=
 =?us-ascii?Q?T8uGgWkNx9MiFHIGOIHbwQqdsJ4Q0j9tJuKcBeaj/5tjLyIvidjBGwVis+kc?=
 =?us-ascii?Q?wAH6pLNErO3JisKUTxgtPmqFfQaC2+veVXOppTDUAWqTHR6er0A7I4WapCH4?=
 =?us-ascii?Q?/J9xOPNNrJ2oyVxhRA+Ex3htvCTb8csoqRisF9qzK6fa5Nb6yLyNb3cvEJ//?=
 =?us-ascii?Q?IomZMW9bDhhTH6V0w/myfBGosANC+J1PbAVNzQk5Xrrh3wPp5XkAB6ac1Ny2?=
 =?us-ascii?Q?jtSJUdl2auXyXhe3kInDbM2n3DIid+XOZXw2qQ08UZ8VACnXUTcDUJlj11Jj?=
 =?us-ascii?Q?a4Bu2YuBX7EI9bddVLC1zVsSW6+JL6vOSf+1lVZnERIZwC1z9IjNH+u2rSGq?=
 =?us-ascii?Q?Nb+Rv2s71HXpUKerB6j84h+2HceCrOVozZpD2gjM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319adfb6-1413-4f4d-a895-08db1a264d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 07:26:40.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMiQAoYCaCc4KAnSQigG72fYxytO/dARooLpw7LXJaIKUlV/iIfbj/KIrNEzKeTRpVSJNpTLIawPeuW7iOLWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7003
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Tuesday, February 28, 2023 4:24 PM
>=20
> Hi Wentong,
>=20
> On Tue, Feb 28, 2023 at 06:35:41AM +0000, Wu, Wentong wrote:
> > Hi Sakari,
> >
> > few questions as switching to v4l2 sub-dev framework.
> >
> > > -----Original Message-----
> > > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Sent: Wednesday, February 15, 2023 12:06 AM
> > >
> > > Hi Wentong,
> > >
> > > Thanks for the patchset.
> > >
> > > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > > > IVSC directly connects to camera sensor on source side, and on
> > > > output side it not only connects ISH via I2C, but also exposes
> > > > MIPI CSI-2 interface to output camera sensor data. IVSC can use
> > > > the camera sensor data to do AI algorithm, and send the results to
> > > > ISH. On the other end, IVSC can share camera sensor to host by
> > > > routing the raw camera sensor data to the exposed MIPI CSI-2
> > > > interface. But they can not work at the same time, so software APIs=
 are
> defined to sync the ownership.
> > > >
> > > > This commit defines the interfaces between IVSC and camera sensor
> > > > driver in include/linux/ivsc.h. The camera driver controls
> > > > ownership of the CSI-2 link and sensor with the acquire/release
> > > > APIs. When acquiring camera, lane number and link freq are also
> > > > required by IVSC frame router.
> > >
> > > The more I learn about this system, the more I'm inclined to think
> > > this functionality should be exposed as a V4L2 sub-device. IVSC
> > > doesn't really do anything to the data (as long as it directs it
> > > towards the CSI-2 receiver in the SoC), but it is definitely part of =
the image
> pipeline.
> > >
> > > I suppose the intended use cases assume a single instance of IVSC
> > > (as well as
> > > MEI) but there can, and often are, be multiple camera sensors in the
> > > system. The decision whether to request pass-through from IVCS can't
> > > be done in the camera sensor driver, and should not be visible to
> > > the camera sensor driver. Exposing IVSC as a V4L2 sub-device makes
> > > this trivial to address, as the IVSC driver's V4L2 sub-device video s=
_stream()
> operation gets called before streaming is started.
> > >
> > > The information whether IVSC is found between the camera sensor and
> > > the host's CSI-2 receiver (IPU in this case) should come from system
> > > firmware and accessed most probably by what is called cio2-bridge at =
the
> moment.
> > >
> > > The privacy status can be a V4L2 control.
> >
> > This should be a control or event? If control, how user-space handle
> > privacy stuff?
>=20
> Changing control events generates events for the user space.
>=20
> <URL:https://hverkuil.home.xs4all.nl/spec/userspace-api/v4l/dev-event.htm=
l>

Ok, V4L2_EVENT_CTRL event which reports 'struct v4l2_event_ctrl' data to us=
er space

>=20
> >
> > For the required link freq and lane number, is v4l2 control the
> > correct way to configure them? If yes, seems there is no CID value for
> > them so that we should custom some CID value(link freqm, lane number,
> > and
> > privacy) for ivsc in linux/v4l2-controls.h, is this acceptable?
>=20
> You should obtain these using the V4L2 fwnode interface. Please see e.g.
> drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c how that driver reg=
isters
> a V4L2 async sub-device and a V4L2 async notifier.

Ok, something like v4l2_ctrl_find(source->ctrl_handler, V4L2_CID_LINK_FREQ)=
; is to get sensor's link
frequency, and the code like 'v4l2_subdev_call(source, pad, get_mbus_config=
, source, &mbus_config);
num_of_lanes =3D mbus_config.bus.mipi_csi2.num_data_lanes;' is to get senso=
r's lane number.

BR,
Wentong
>=20
> --
> Kind regards,
>=20
> Sakari Ailus
