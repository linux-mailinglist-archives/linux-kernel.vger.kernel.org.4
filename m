Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5E6803CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjA3CW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjA3CW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:22:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2A166D3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675045345; x=1706581345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wJRspG/0Zlciabon2Ho/pqOhZi4qvUUCzxdG+FKt+x0=;
  b=WyMo6kFVd487iiS4JM23MnCRWPImJQtIb/yMJN6iviVwsFiwrrlvzV2B
   e6DtYstjqu1RjU+luPQ8eTQa1kA3KDpomhZm8M2gn6AQWEo8LbsppSu8/
   2Myh4MPBTrjdvzca4x59oWNzJ6C6WTqg+TPw5I0ekOHgpROIXc0AEYphw
   EYWxS88MXbeGYCnAY7lhwB60R6iIeLJuGl7ZJksmflN+DfqP5jZOioS2Y
   nbPmWfnIVHsULsGfLP1fFljoTIDYUaFQPzhYR+Aii38dzkVNJj8e8Rc0Z
   wbq+HRNdRevrAnRYHRh22BuzgNHuzLPBeK2RUrWu1k2tPqTNtpVEeLMyr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="328738630"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="328738630"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 18:22:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="992723736"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="992723736"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jan 2023 18:22:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 18:22:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 18:22:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 18:22:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Hf/ZSUGOHepIyObZk+jrdrdoYUooKTrwQASdtft1nS+gB/ALT1wS9/kHYUnZe3D+QCGnyba6h9IdERrd9T7K7tNQImAHbJv50sjQ6KqFBj27Q9rHCC5ZTahoUNOXjFCinb5J+1Mxp0XOIq7/9NFKUov4AMC6nub5xe3QiHCFxwpy2qQL2PybVaIDrzPvTbjGWZ6YED9kO1BH0eVbyNbUSlYzkLzbzzyUsfXBavYai/gVTN80rqoUsHHdKvW6WBgaU7RJNRGwO2dEv49FpNInVymZUMm9XIITULiGoXpMcjwNzICueBGQ+qpuiCjmtMc0Eef/rLMUgiL9MoVJIRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJRspG/0Zlciabon2Ho/pqOhZi4qvUUCzxdG+FKt+x0=;
 b=a55dsXxmELJCqrogIYU571iY22g5dZglnTdPxWt8kgarJQX1Ln5UjQcFaSJm1sbKrgvPSANNJ/WwKQ17wOH8QFOm1akpESINfrbBqfQJAZjT//7h9iMMlBTnBPdgtzIk7zls2ljNdA3PLrS243AUr/vTYPw9AtEd/GViY6AQgqJ7gKpbIUF+Vg5ZftLif84o1q4NJeUYvU8/EBUWtT/SCDPFTqKi780ffI+7nOtWRd6MZZRBU4JUP3VvCgPA1DqYMSG3NkIrLRyBsPmDHauBTrIIwTPjDPjhEof2vxY2XqcCOwwm37ZQ/Cjc3QHvB5kRRMiXLNxr4c32J9XcopNTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 02:22:20 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%3]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:22:20 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Topic: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Index: AQHZM14a8sLMOu4lm0Wu+eywCVc4o661H9mAgAEcENA=
Date:   Mon, 30 Jan 2023 02:22:20 +0000
Message-ID: <DS0PR11MB7529E920AE8F2CF39135CFE9C3D39@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB52764F6D34C9252A58DDA69D8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52764F6D34C9252A58DDA69D8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|LV2PR11MB6021:EE_
x-ms-office365-filtering-correlation-id: e5aab976-ec6c-450e-d4a3-08db0268d0aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBU7+AFkfu8FFqQi88ocWHqcgYX5WYknIzJi7I1dheofZLjLxf+wh+GtvMdDl/4S7d76z+FZADAXFSqHXTIDbBrnQP3SnQnHPaLEVNqNAWyyVYLyhZJGl3RJpFH8BH8XwPqeV/6jk7vYj8ZHhOcryCuPbuaI6jv+z2zYSGFOIfynf7BE7iC9WPxSA1MkymY0sXvuS5BuqlUT/KJA6IVDXDtipH/spUsOj7ej1qGl2PsM9UMAlVDVQcaEBpsOQI5hQAFfjF6cR2mnvcFAiQQgY0tj37r1FxXkUFTPBk7uRZ1nWvYgbrliEuyGN+DrVZAatHTBovMtOy11xcsf3jvR4uHfCTei1jcioJ4FkxePUGTdZVJX9gwZgN3vueZDnZzilf1OKCl2JgeE4AB+VVjg9i2N2afwgpqtSVxDeh2OuSC5sSgvQWvWlsb9oHYUlLKDYARF+w0U3BGep/NVWW1tBTg7ArjlqPorEEBoKLMc+0iU7/vok7w/Icf8eg+RQEtpYgRM6wMxns6i4gv6vQTzUjm3zRsAOK3OEhG+xVYOciBXBm70hGRoBeuiDEoUjSwV9CZfPPywm7DJgkQBJHaFTf5p48hkonvIGGNYHcXx5vI22mHH31mlsGK5fM3M0qrhr3sHmKeMjq2Y6mDMJcLn+jut+4+6nmb1H+2XRXNb7K5e7xFBPHDX86bFXJ2eSMjSS51DF+evklq72CLEUDTuQrsZy5VpHnA2bCf7yGAjL+PwfBcHcX3U5XAg/n5YF8ZA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199018)(55016003)(82960400001)(26005)(9686003)(122000001)(38100700002)(186003)(5660300002)(2906002)(966005)(71200400001)(38070700005)(478600001)(7696005)(52536014)(66946007)(76116006)(8676002)(86362001)(4326008)(110136005)(64756008)(66476007)(66446008)(54906003)(316002)(66556008)(41300700001)(6506007)(8936002)(33656002)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pBAQOkWzZeDMZ9UBcIgGzdPYkjQndg1+knX0ahRg2BCfCoG4w/tEUPYAe0kQ?=
 =?us-ascii?Q?oBP94P1hkf1tSQL9sLpq22xUwgJU+K5Lkc5DHlsbR6BFHy2OwHW1ra/CkP15?=
 =?us-ascii?Q?eQSXEs8a8rnNl4yqtJYjpdoQUmtHfPeRZhXAfl5VmxYixotKP3ZI4AxZE45G?=
 =?us-ascii?Q?9WUj+0TRCa0AHzyFIFox7iKwgbc/WONVe5T8rY7v/8TS+ZICC6ciKUT/L6qc?=
 =?us-ascii?Q?NuvsWPAGFTxrvNSX1lCs+moGD9kljrgUCDeLFHYuix/6qJr25mBTpzbKRgti?=
 =?us-ascii?Q?XsuejB4D40sxqIemkK+2QxMjV5dMYey3B7WpoBqA/R/y4FXq9y9Rvqqw0gaT?=
 =?us-ascii?Q?cWO7555Mnqu5opT73OvldemIAYvtNKu7KMskfRKZJ10dqkfdUQAbierF6Evi?=
 =?us-ascii?Q?ZBapKZl5/6kgIM3JVSVCEpGKnEohrQN8saQddjf5DzZdXkX+gSSLXAULGBB+?=
 =?us-ascii?Q?QXf4WMBbC8PUK0jMaT3m8dcD3/ebnb7shyMlJ2KOCENI/3rXJkfdO0Rs9WIu?=
 =?us-ascii?Q?qP9AVOF3KTuk3IqiqOVoS/+WFxBxuKbOE2P/5cCX12g4sXUWk2BdTC3XRFwb?=
 =?us-ascii?Q?oqJ/NF1lujYYS7b4k+NN9eFomvnPC51rBoNH+0BQteZLC1JMj0o6Ri0VMhoZ?=
 =?us-ascii?Q?QoZZ1u44f606SKk5sLq5njCrPBcITx9zhpro8CMQ25ze+vqmSJJLvw8DJLQw?=
 =?us-ascii?Q?WBk7aTo+yuoVoAvDPI3UeoCzxc3C9xfoDzqEEwTCmWb8v7WPSka0xeQC/bjh?=
 =?us-ascii?Q?2QRQy6OlAmlnwEtTH9dRfZZEcGmkkZkauekCpyAyyHEY72s6zWgzfQB+UtCQ?=
 =?us-ascii?Q?0jB2PxFYTuHvYXrOGSJ3vQ+plMU26dzMEQHq3Vdwxffmf442Ln+UbHoNpDP8?=
 =?us-ascii?Q?nvTSGzymyHbJM220mnJiBl6Nf/hQCUFnWLJh6KdlTCZLRqsG3A6S3qxxntUj?=
 =?us-ascii?Q?ecrs2XntxeaiR4X/ZysAI/IinMdIFMOSXNYgQZWtRXy+uJH34MF7AvlbpxCK?=
 =?us-ascii?Q?EGLhqDc7VnJNuCsMO6FH51bkWdj493lm72hqmQrXow0QX7wCkFkFWDFGsX6H?=
 =?us-ascii?Q?g4Qd6snRlnJcjtfL7R53d0Lh7xQL5loGDeGZWHw4v7s9iinBIWvfLPKVOoj7?=
 =?us-ascii?Q?ZXFzVJcRwrcVQGdkkzCAjo1Ns8xCLG9+avM66VxZWCsWcwRjjqpJpukh9p1s?=
 =?us-ascii?Q?T7U+qol76oZfxuTmJMrLB8UPYHfAR5kqw4S2Zy6+HJKsah8ilNCMfVWHjRET?=
 =?us-ascii?Q?jZLjSsowNveg3kf39pRgb2oSwvVuAb3jOS5Qqa9G1qtGCYr1KHfh1Mn0Magk?=
 =?us-ascii?Q?ZQxLbkMS5F5K9CEE9euBHAJm7nqCS4CtNVrZt4tI8zgikZHTTqGCaD+svpLJ?=
 =?us-ascii?Q?3GCAu3PaGZVM+m32nMgwwpM6XlndV1dDAKo4iQdY8Q4j+Rp6VnP3sEcntX0W?=
 =?us-ascii?Q?QVloX02cWUf66OJqkBWgJuu7GrxlFbjzTPtXcF8O9j7wOhVF1yGusvpjZ/RM?=
 =?us-ascii?Q?fcnL5wLIqw+Zi/POuiqJiWD3+PIo8mn8R7U+3BZMCybs3OzmfLhET2IOw574?=
 =?us-ascii?Q?9O0gmFzcPXfqAksXomwoCCOoeK/IKve6vLyO2xRr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aab976-ec6c-450e-d4a3-08db0268d0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:22:20.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMPk+o98ERHXq9fFh3w/8uImXbxXBtLuDZUhaJpy3JboFfD/sCIsIRx07IWKsICfxbF9LgWa+NMYJZJCu9+wfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Sunday, January 29, 2023 5:23 PM
>
> > hw_pagetable by the attached devices. Make this field as a pointer, onl=
y
> > allocate for a stage-2 hw_pagetable. A stage-1 hw_pagetable should
> reuse
> > the stage-2 hw_pagetable's devices_users, because when a device
> attaches
> > to a stage-1 hw_pagetable, linking the stage-2 hwpt to the IOAS is stil=
l
> > required. So, with a nested configuration, increase the devices_users o=
n
> > the stage-2 (parent) hwpt, no matter a device is attached to the stage-=
1
> > or the stage-2 hwpt.
>=20
> Above is very confusing w/o seeing the full series of nesting support.
>=20
> As a preparatory step this should focus on existing code and what this
> series tries to achieve. e.g. I'd not make device_users a pointer here.
> Do that incrementally when the nesting support comes.

Yes, in the below branch, I've moved this patch to be together with the nes=
ting
commits. Maybe I can send out the nesting RFC.

https://github.com/yiliu1765/iommufd/commits/wip/iommufd-v6.2-rc4-nesting

Regards,
Yi Liu
