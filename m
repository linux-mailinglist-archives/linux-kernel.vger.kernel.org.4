Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96E685D17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBACJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Jan 2023 21:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBACJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:09:11 -0500
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3D53B14;
        Tue, 31 Jan 2023 18:09:04 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 31127xSS005323; Wed, 1 Feb 2023 11:07:59 +0900
X-Iguazu-Qid: 2wGrC6bcqMLgSPn61k
X-Iguazu-QSIG: v=2; s=0; t=1675217278; q=2wGrC6bcqMLgSPn61k; m=HaOc4odNts0Ujo+ifIKvJ1JmDnQB61uhmnvecXdB594=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 31127uh3034314
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Feb 2023 11:07:57 +0900
X-SA-MID: 54131619
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLNqDZxFdw1uW7TuiFLhaowqse28Bk3nQyamxvLewBdH1hLTVkIPxpeA4E5W76ea6NrR4FdhviB106WBwTXM6VjNlKfzYwO4NbE43kv8gMMxxdEKPTF/6rHPCOIP/TI3zIrFcBIL6FCyFrgrffBlZVtffYDs67284JuS92kUzQtvuqFdf1l3A9pSUfE9eRNS4UGF2NXb0+v6WJ7lFgeh6mduQl+brzGREQJffZwca83c3Ml6CJG9r+cosowsL7Fqd+HviwOeUWNQr9h81feKwfgvp6z9fAYGt7sVCJ3Sb+iDovn6reFJueE1n1iE7oLEiM5omg9TTncHkkaRUhRHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K82ZBU7ZQKQVbOosOb865/mcQ2SS4FoM0VGd794IUw=;
 b=O/leVwr+DCTe5tTKQj8wt2J7r0WVllJxbLbJbA+rEAaKeN2yQXL+87f+mPNoTaJ2k62YAR8yOH4BU+Djeo9gHxnoxt/WU/ZZTmBJBRc0A69CsD7Ha4NeyFtfRnhjpXzsK0FXHrsY4QZCj/rBBCeBoijL11P9NyBZb+SgDiXd9/CkKOZ0TgQm2JD8Hog4IhcfFKUzyoVy0qwLgTWywozaaQCow/Mg9I2JPXtU0XxNv43dsqtJaP0A3m8ozvwQsbQboG39XupebEUvYr1jOqC4fQOkXWdCyW1X3PEw8ao/i3HiW+59gZ7B78+6Uh1kmj4NHu89JvpfwyTm85se6D+MmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <sakari.ailus@iki.fi>
CC:     <hverkuil@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael.j.wysocki@intel.com>, <broonie@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Topic: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Index: AQHZJWP0bZ/zoVA7GUOz/bXYKEan6q6jPmEAgBY4AbA=
Date:   Wed, 1 Feb 2023 02:02:43 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62010040B750701D253C47CB92D19@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-3-yuji2.ishikawa@toshiba.co.jp>
 <Y8cjqoztUTIL61dP@valkosipuli.retiisi.eu>
In-Reply-To: <Y8cjqoztUTIL61dP@valkosipuli.retiisi.eu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYCPR01MB11068:EE_
x-ms-office365-filtering-correlation-id: bc3a971d-42b1-406c-384e-08db03f867f4
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V812TZmMaf3kFydp6Uju5YjxtXls7v1dOlW3eAUwVtzc/2i9UaYZmugSSotrpEsz29XsZl40QczS+aNc99CKEFdpaOoP+dC9AnZrulbEcv2mXEFFOMI5WJy/i2cut7JxFoo1Ay25O7Bk2OWOa/P9c5D07WUs/tx8yCFP/cmC1CQ7XZSDZTLmNd64sxWcKe9mBk5yEbKKapqZzz/Uir2KZVAsAPNYBhXZNnieWaBstfjTtIZbx+g/zK4S0OmWrjSLb9OPDV4G03+TtfuDwfvHdw5ws9NLwcrrpHTwNRVTplLN8GsBYOak8BM2SbrMlzkKKZStJMiqPUa8D9Z0lU33DuVRU92Gf+P4dv5GtUCe7Vpi6BHBvO7cwEb3HeLUsP7FNg/3bhGQm/4vkYMSgrdcdNdTQms8nmdg7xwCLGx2SjlLIj2kc2CaizGbe5roRv3v96QuDjTAq2vPUQ+XihxofWpQDKlrSvwUJK2EeWDCrtq3utFn9oR9WHFClxEvRmohFy+Ov9ioVqWKL0+yQHimZYwYq0M3cC0gxAQkWNP6osI+sUbWjldOkIM7SXEAAodKvmzT6sDDisYMkFYYBY3v4NX1MNQ+Xl2jUVgW8RM8wczMqARfGP0WVWJWLJBVMibUh15NvB9Lut2iVz0TXAYE5hSH6nzD9vcEQh3JEcNpVFwZ1+VrjGN3qhBOPYHwTV4Ho7v15zmSSRYbwoDfXe7Op1bv7OBqvBkrUodKZOHA8PzDXPzH2aDg9GU8TA8aX81Zz7VH6Ka3vb/YL+yQYLMj/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199018)(76116006)(66946007)(4326008)(6916009)(41300700001)(8676002)(66556008)(66446008)(66476007)(64756008)(55016003)(66899018)(52536014)(8936002)(316002)(54906003)(5660300002)(33656002)(7416002)(83380400001)(30864003)(186003)(71200400001)(7696005)(2906002)(9686003)(26005)(478600001)(53546011)(6506007)(38070700005)(86362001)(122000001)(38100700002)(21314003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NkpUaDVrNWhhOWtZcHNlbFU1WFkzRHNmT2djekxlcU00Vjd2YnZRWnpi?=
 =?iso-2022-jp?B?TE52MHRyNlpMNXAyY1liWVp2M3pVc2g0QnpWeGI2UU9KY3ZLM2NhQXdY?=
 =?iso-2022-jp?B?TXNnZVhjMHkySVptWjRDWnNFbklBU01hS1VzNmNKOG52UDh2ajA1MktG?=
 =?iso-2022-jp?B?cjNKL2xia09ESHhVajh4NFZqTVlPRzhicXVHaGtmM1FtYzU2NlY5QXdH?=
 =?iso-2022-jp?B?OU56SVRtN0xlbVc5a21ON2x2UVpKMDE0b2hZRzVlRy96clRIMUNuUWpM?=
 =?iso-2022-jp?B?Z2hzWkhQQmRrTFBZejFGanFHbzFvMTUrYzRhSGNjREJWcWhPcTREeGxI?=
 =?iso-2022-jp?B?eEpOTjlRcnQ1RjdzVXVCSUxTQW9SUzVOaUdJTUVlTUphS3RMcnJoRCtH?=
 =?iso-2022-jp?B?QmY5TUFnQm5PdUx1ZlhVTGU3WlVybnVIamtyQTVUMXVXZ2hxTjlkZVZ6?=
 =?iso-2022-jp?B?a3QyTWZHelBYRVozQjNTT2Foa1ExRnNkM3Nmd0pXUENzc1ZlVlZvYVU2?=
 =?iso-2022-jp?B?ZnVucnFRMk5MVFNBcklxcUtqN0FzdnNrRk1jbXVIaFprQnkvTEF3SUIw?=
 =?iso-2022-jp?B?WkxEVDdFbnVmRkVwcGtaL0RKZWNNNU9yT0p4OFI3R3hPQXdkbVJmK1NY?=
 =?iso-2022-jp?B?QU90d2FYeFhnOUVDaVVnK0phRVZ4Z1E1RDcxaktnZGJ0TkxlUy9WOEJw?=
 =?iso-2022-jp?B?aXV2eUV6alJieHplUWg2WGlrQ1ppTUk0WWhRWGgvZE1GMlZyZEFGV2RS?=
 =?iso-2022-jp?B?TGRxbU5aVThnSU5JZmtXc2lsV09KdnhISFo3RlVxRnJBTGlrTnJiME5X?=
 =?iso-2022-jp?B?TXlHQ3FwVXFwRXlKZmVFaWdKMlRIM3cxMVprOWhNbUR0ZEhTNEdIQWV6?=
 =?iso-2022-jp?B?ZmVJL3IwUGRRYi81amNFQ0tEL1VTT09LdWVkRGhSdWEzWkMyOGZ6NTRQ?=
 =?iso-2022-jp?B?ZGMyaGR0M25XdEg1WHc2VVlXbEMyVFlJeDUvVHNiMW1vRUFva1NnYjFC?=
 =?iso-2022-jp?B?M3lVWnA1Y2N0UmpRZ09JQmVrYklXU2FENmdkWWx1K09FYS9FSWZhQjUr?=
 =?iso-2022-jp?B?eVhoa1FKUjJzVlY5U0VpOUlIMTBOeDF4dERTOFh5UVVHNEFBYkRLbkVL?=
 =?iso-2022-jp?B?T0pCRGtESVhGcjBRYlEyOTlHUU9WR3JDeGdSS3NmeHk4OWxTSG9wdXpp?=
 =?iso-2022-jp?B?VHRrdExQU2lBbnM3NVJvRmJ1Ull2T0cxK1h2MWNtREM3dEczQnUvbDNu?=
 =?iso-2022-jp?B?RnEyZXF2KzhDV2FzekhZd3FaekRNRk54ZEN4K0x0N0ZlMERMOG5uMnh2?=
 =?iso-2022-jp?B?aVN4TURZUFhSdjRvc3phLzZkWkltNmZ5bklKWnpzU2NydDB3RGdWeEtD?=
 =?iso-2022-jp?B?UEZTYjBUcnVYSWw4Y1EwMnBib1Q1MUlBVlFXT3U1ZHRBSFBIa3Fod1Jy?=
 =?iso-2022-jp?B?UyswZ2RNcndPdkZDVVp0UVNUSkF1SHJpalhGOEk1ZVpoRUkrMEpFY2Rt?=
 =?iso-2022-jp?B?aFREelVCZ2tJZ2tJWmZaOWFkamdXQTZzbGIwUU1TRTk3blExb0VRVGx3?=
 =?iso-2022-jp?B?WUVla0I0d2MwSUNUMFROMkxHUG9teUdRcU4vaStWMlh0cGhlT0V0ZFJS?=
 =?iso-2022-jp?B?WFF6TDAraWFWb2Z6UW45Y0FHdkF2bnhQZjFYRUt3MVlqdklmSXoxUXQr?=
 =?iso-2022-jp?B?K1dxUkxKWjRMZFRyc3dURmJsRkcxc0M3bVVlU3FUY0pESmtTcVE5NmIx?=
 =?iso-2022-jp?B?eUVBQ09FcUNkVUdrbVA0MSt1bVZLZ0Y2S0ZPYnk3Qi8wNVpRdUw5K0xZ?=
 =?iso-2022-jp?B?TlBxWEVFSW1lOTJhbVVBOVo2NUZqVlJkcTVSVjN2MXpRTmE2SFdicVl1?=
 =?iso-2022-jp?B?WXF1Z0dob3VmTjN6M2dQb2FES3V1SVFPM081NEk0REhKN0RzcTJReXN2?=
 =?iso-2022-jp?B?NkhId1ZGZW8wMUQ1WTRzQzNkNlRVcGpWK1JKbk1uL3l0dUwvbzZGQXVh?=
 =?iso-2022-jp?B?Mk1teFA1aXBUTyt0SkMvZzVOWHlYR3dZSENTdDRyNFM3Q1lJUVFoRnZn?=
 =?iso-2022-jp?B?b0Y2Y290dUZwaFkzdVFOQjRUK0M3eGo2L1FKWGdHZjhwZHVHZkhVKzNO?=
 =?iso-2022-jp?B?NEljVm90cVV6WTJuM2RqU3B5WkRMbThKcnVlYWt0ZnU0V1BOTjFLUU1w?=
 =?iso-2022-jp?B?dEJETXVSNC9kY0x6aVZKUmRCMElxajhYdGt5MnRrTUxjYkNTN1l1SkVE?=
 =?iso-2022-jp?B?cEg4K0dXUjlkK3FjWlhqeVpjNktXeGZXVGJLRW5xZTNzVi9QNmQxQkNY?=
 =?iso-2022-jp?B?TnA4QUxQRXV4aVF0bjM0YlhGcnVieFZMVXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a971d-42b1-406c-384e-08db03f867f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 02:02:43.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFyL37xPzsgwMOoaXm0OXNV8I9TvLVBBSHC00Wact5TIPy6DjHervoDwkVkPSsBKKfp6TwO+apxReIU+LsWiGDIz3aqRNERneOJZNBfXzIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11068
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sakari,

Sorry for sending the reply again. 
My mail agent posted the previous one with HTML format.

Thank you for reviewing and your comments.

> -----Original Message-----
> From: Sakari Ailus sakari.ailus@iki.fi
> Sent: Wednesday, January 18, 2023 7:40 AM
> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> yuji2.ishikawa@toshiba.co.jp
> Cc: Hans Verkuil hverkuil@xs4all.nl; Laurent Pinchart
> laurent.pinchart@ideasonboard.com; Mauro Carvalho Chehab
> mchehab@kernel.org; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> nobuhiro1.iwamatsu@toshiba.co.jp; Rob Herring robh+dt@kernel.org;
> Krzysztof Kozlowski krzysztof.kozlowski+dt@linaro.org; Rafael J . Wysocki
> rafael.j.wysocki@intel.com; Mark Brown broonie@kernel.org;
> linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 2/6] media: platform: visconti: Add Toshiba Visconti
> Video Input Interface driver
> 
> Dear Ishikawa-san,
> 
> Thanks for the patchset.
> 
> I'd say this is a partial review based on a quick glance, I may have
> further comments later on. It's a big patch, some 8000 lines. Please see
> the comments below.
> 
> On Wed, Jan 11, 2023 at 11:24:29AM +0900, Yuji Ishikawa wrote:
> > Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> > The interface device includes CSI2 Receiver,
> > frame grabber, video DMAC and image signal processor.
> > This patch provides operations to handle registers of HW listed above.
> >
> > The Video DMACs have 32bit address space
> > and currently corresponding IOMMU driver is not provided.
> > Therefore, memory-block address for captured image is 32bit IOVA
> > which is equal to 32bit-truncated phisical address.
> > When the Visconti IOMMU driver (currently under development) is accepted,
> > the hardware layer will use 32bit IOVA mapped by the attached IOMMU.
> >
> > Signed-off-by: Yuji Ishikawa yuji2.ishikawa@toshiba.co.jp
> > ---
> > Changelog v2:
> > - Resend v1 because a patch exceeds size limit.
> >
> > Changelog v3:
> > - Adapted to media control framework
> > - Introduced ISP subdevice, capture device
> > - Remove private IOCTLs and add vendor specific V4L2 controls
> > - Change function name avoiding camelcase and uppercase letters
> >
> > Changelog v4:
> > - Split patches because the v3 patch exceeds size limit
> > - Stop using ID number to identify driver instance:
> >   - Use dynamically allocated structure to hold driver's context,
> >     instead of static one indexed by ID number.
> >   - Functions accept driver's context structure instead of ID number.
> >
> > Changelog v5:
> > - no change
> > ---
> >  drivers/media/platform/Kconfig                |    1 +
> >  drivers/media/platform/Makefile               |    1 +
> >  drivers/media/platform/visconti/Kconfig       |    9 +
> >  drivers/media/platform/visconti/Makefile      |    8 +
> >  drivers/media/platform/visconti/hwd_viif.c    | 1690 ++++++++++
> >  drivers/media/platform/visconti/hwd_viif.h    |  710 +++++
> >  .../media/platform/visconti/hwd_viif_csi2rx.c |  610 ++++
> >  .../platform/visconti/hwd_viif_internal.h     |  340 ++
> >  .../media/platform/visconti/hwd_viif_reg.h    | 2802
> +++++++++++++++++
> >  include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
> >  10 files changed, 7895 insertions(+)
> >  create mode 100644 drivers/media/platform/visconti/Kconfig
> >  create mode 100644 drivers/media/platform/visconti/Makefile
> >  create mode 100644 drivers/media/platform/visconti/hwd_viif.c
> >  create mode 100644 drivers/media/platform/visconti/hwd_viif.h
> >  create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
> >  create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
> >  create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
> >  create mode 100644 include/uapi/linux/visconti_viif.h
> >
> > diff --git a/drivers/media/platform/Kconfig
> b/drivers/media/platform/Kconfig
> > index a9334263fa9..0908158036d 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -83,6 +83,7 @@ source "drivers/media/platform/sunxi/Kconfig"
> >  source "drivers/media/platform/ti/Kconfig"
> >  source "drivers/media/platform/verisilicon/Kconfig"
> >  source "drivers/media/platform/via/Kconfig"
> > +source "drivers/media/platform/visconti/Kconfig"
> >  source "drivers/media/platform/xilinx/Kconfig"
> >
> >  endif # MEDIA_PLATFORM_DRIVERS
> > diff --git a/drivers/media/platform/Makefile
> b/drivers/media/platform/Makefile
> > index a91f4202427..1c67cb56244 100644
> > --- a/drivers/media/platform/Makefile
> > +++ b/drivers/media/platform/Makefile
> > @@ -26,6 +26,7 @@ obj-y += sunxi/
> >  obj-y += ti/
> >  obj-y += verisilicon/
> >  obj-y += via/
> > +obj-y += visconti/
> >  obj-y += xilinx/
> >
> >  # Please place here only ancillary drivers that aren't SoC-specific
> > diff --git a/drivers/media/platform/visconti/Kconfig
> b/drivers/media/platform/visconti/Kconfig
> > new file mode 100644
> > index 00000000000..031e4610809
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/Kconfig
> > @@ -0,0 +1,9 @@
> > +config VIDEO_VISCONTI_VIIF
> > +    tristate "Visconti Camera Interface driver"
> > +    depends on V4L_PLATFORM_DRIVERS && MEDIA_CONTROLLER &&
> VIDEO_DEV
> > +    depends on ARCH_VISCONTI
> > +    select VIDEOBUF2_DMA_CONTIG
> > +    select V4L2_FWNODE
> > +    help
> > +      This is V4L2 driver for Toshiba Visconti Camera Interface driver
> > +
> > diff --git a/drivers/media/platform/visconti/Makefile
> b/drivers/media/platform/visconti/Makefile
> > new file mode 100644
> > index 00000000000..e14b904df75
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the Visconti video input device driver
> > +#
> > +
> > +visconti-viif-objs += hwd_viif_csi2rx.o hwd_viif.o
> > +
> > +obj-$(CONFIG_VIDEO_VISCONTI_VIIF) += visconti-viif.o
> > diff --git a/drivers/media/platform/visconti/hwd_viif.c
> b/drivers/media/platform/visconti/hwd_viif.c
> > new file mode 100644
> > index 00000000000..260293fa4d0
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/hwd_viif.c
> > @@ -0,0 +1,1690 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/* Toshiba Visconti Video Capture Support
> > + *
> > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> 
> Happy new year!

Oh! Another year has come.
I'll update copyright notice.

> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "hwd_viif.h"
> > +#include "hwd_viif_internal.h"
> > +
> > +/* MIPI CSI2 DataType definition */
> > +#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
> > +#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
> > +#define CSI2_DT_RGB565    VISCONTI_CSI2_DT_RGB565
> > +#define CSI2_DT_RGB888    VISCONTI_CSI2_DT_RGB888
> > +#define CSI2_DT_RAW8        VISCONTI_CSI2_DT_RAW8
> > +#define CSI2_DT_RAW10      VISCONTI_CSI2_DT_RAW10
> > +#define CSI2_DT_RAW12      VISCONTI_CSI2_DT_RAW12
> > +#define CSI2_DT_RAW14      VISCONTI_CSI2_DT_RAW14
> 
> These are generic MIPI CSI-2 definitions, no need to re-define them for
> this driver only.

I'll use definitions in mipi-csi2.h

> > +
> > +struct hwd_viif_res *allocate_viif_res(struct device *dev, void
> *csi2host_vaddr,
> > +                                                     void *capture_vaddr)
> > +{
> > +    struct hwd_viif_res *res = devm_kzalloc(dev, sizeof(struct hwd_viif_res),
> GFP_KERNEL);
> > +
> > +    res->csi2host_reg = csi2host_vaddr;
> > +    res->capture_reg = capture_vaddr;
> > +    res->run_flag_main = (bool)false;
> 
> What happens here if res is NULL?
> 
> I'd advise to perform the allocation outside variable declarations, that
> way it is more obvious it may fail (and needs to be checked for).
> 
> No need for a cast.

I'll fix them.

> > +    return res;
> > +}
> > +
> > +/* Convert the unit of time-period (from sysclk, to num lines in the image) */
> > +static u32 sysclk_to_numlines(u64 time_in_sysclk, const struct
> hwd_viif_input_img *img)
> 
> Please run:
> 
> $ ./scripts/checkpatch.pl --strict --max-line-length=80
> 
> on the set.

I found that extra newlines inserted by a mailer surely made the patch difficult to read.

Currently, a source file has maximum 100 characters for a line.
I’ll limit to 80 characters.
Is it just for review process, or the source files should always have maximum 80 characters for a line?

> > +{
> > +    u64 v1 = time_in_sysclk * (u64)img->pixel_clock;
> 
> You can drop the cast.

I'll drop the cast.

> > +    u64 v2 = (u64)img->htotal_size * HWD_VIIF_SYS_CLK;
> > +
> > +    return (u32)(v1 / v2);
> 
> div_u64()?

I'll use div_u64().

> > +}
> > +
> > +static u32 lineperiod_in_sysclk(u64 hsize, u64 pixel_clock)
> > +{
> > +    return (u32)(hsize * HWD_VIIF_SYS_CLK / pixel_clock);
> 
> You can drop the cast.
> 
> And I think you need div_u64() instead.

I'll use div_u64().

> > +}
> > +
> > +/**
> > + * hwd_viif_main_set_unit() - Set static configuration of MAIN unit(CH0 or
> CH1)
> > + *
> > + * @dt_image: DT of image [0x10-0x17, 0x1B, 0x1E, 0x1F, 0x22, 0x24-0x27,
> 0x2A-0x3F])
> > + * @in_img: Pointer to input image information
> > + * @color_type: Color type of image [0x0, 0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
> > + * @rawpack: RAW pack mode. For more refer @ref
> hwd_viif_raw_pack_mode
> > + * @yuv_conv: YUV422 to YUV444 conversion mode. For more refer @ref
> hwd_viif_yuv_conversion_mode
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "dt_image" is out of range
> > + * - [2] "in_img" is NULL
> > + * - [3] member of "in_img" is invalid
> > + * - [4] "color_type" is out of range
> > + * - [5] "color_type" doesn't meet the condition shown in the below note
> > + * - [6] "rawpack" is out of range
> > + * - [7] "rawpack" is not HWD_VIIF_RAWPACK_DISABLE when color_type is
> other than RAW(0x2A-0x2C)
> > + * - [8] "yuv_conv" is out of range
> > + * - [9] "yuv_conv" is not HWD_VIIF_YUV_CONV_REPEAT
> > + *       when color_type is other than YUV422(0x1E or 0x1F)
> > + *
> > + * Note: valid combination between "dt_image" and "color_type" is
> > + * - when "dt_image" is [0x10-0x17, 0x1B, 0x25-0x27, 0x2E-0x3F],
> "color_type" must be [0x2A-0x2D].
> > + * - when "dt_image" is valid value and other than [0x10-0x17, 0x1B,
> 0x25-0x27, 0x2E-0x3F],
> > + *   "color_type" must be "dt_image"
> > + */
> > +s32 hwd_viif_main_set_unit(struct hwd_viif_res *res, u32 dt_image,
> > +                                   const struct hwd_viif_input_img *in_img, u32
> color_type, u32 rawpack,
> > +                                   u32 yuv_conv)
> > +{
> > +    u32 total_hact_size = 0U, total_vact_size = 0U;
> > +    u32 sw_delay0, sw_delay1, hw_delay;
> > +    u32 val, color, sysclk_num;
> > +    u32 i;
> > +
> > +    /*
> > +    * 0x00-0x09: ShortPacket/Undefined
> > +    * 0x18-0x1A: YUV420
> > +    * 0x1C,0x1D: YUV420 CSPS
> > +    * 0x20,0x21,0x23: RGB444, RGB555, RGB666
> > +    * 0x28,0x29: RAW6, RAW7
> > +    */
> > +    if (dt_image <= 0x09U || (dt_image >= 0x18U && dt_image <= 0x1AU)
> || dt_image == 0x1CU ||
> > +        dt_image == 0x1DU || dt_image == 0x20U || dt_image == 0x21U
> || dt_image == 0x23U ||
> > +        dt_image == 0x28U || dt_image == 0x29U || dt_image >
> HWD_VIIF_CSI2_MAX_DT) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    /*Case: Generic Long Packet, Reserved, User-Defined*/
> > +    if ((dt_image >= 0x10U && dt_image <= 0x17U) || dt_image == 0x1bU
> ||
> > +        (dt_image >= 0x25U && dt_image <= 0x27U) || dt_image >=
> 0x2eU) {
> > +                  if (color_type != CSI2_DT_RAW8 && color_type !=
> CSI2_DT_RAW10 &&
> > +                      color_type != CSI2_DT_RAW12 && color_type !=
> CSI2_DT_RAW14) {
> 
> Could you use the data type defines where applicable? Same above.

I'll use definitions in mipi-csi2.h .

> > +                                return -EINVAL;
> > +                  }
> > +    } else {
> > +                  /*Case: Otherwise: YUV, RGB, RAW*/
> > +                  /*Constraint: color_type must be dt_image*/
> > +                  if (color_type != dt_image)
> > +                                return -EINVAL;
> > +    }
> > +
> > +    if (!in_img)
> > +                  return -EINVAL;
> > +    if (rawpack != HWD_VIIF_RAWPACK_DISABLE && rawpack !=
> HWD_VIIF_RAWPACK_MSBFIRST &&
> > +        rawpack != HWD_VIIF_RAWPACK_LSBFIRST) {
> > +                  return -EINVAL;
> > +    }
> > +    if (color_type != CSI2_DT_RAW8 && color_type != CSI2_DT_RAW10 &&
> > +        color_type != CSI2_DT_RAW12 && rawpack !=
> HWD_VIIF_RAWPACK_DISABLE) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK ||
> > +        in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK ||
> > +        in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL ||
> > +        in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL ||
> > +        in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE ||
> > +        in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE ||
> > +        in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE ||
> in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE ||
> > +        ((in_img->hactive_size % 2U) != 0U) || ((in_img->vactive_size %
> 2U) != 0U)) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->interpolation_mode !=
> HWD_VIIF_L1_INPUT_INTERPOLATION_LINE &&
> > +        in_img->interpolation_mode !=
> HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->input_num < HWD_VIIF_L1_INPUT_NUM_MIN ||
> > +        in_img->input_num > HWD_VIIF_L1_INPUT_NUM_MAX) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->hobc_width != 0U && in_img->hobc_width != 16U &&
> in_img->hobc_width != 32U &&
> > +        in_img->hobc_width != 64U && in_img->hobc_width != 128U) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->hobc_margin > 30U || ((in_img->hobc_margin % 2U) !=
> 0U))
> > +                  return -EINVAL;
> > +
> > +    if (in_img->hobc_width == 0U && in_img->hobc_margin != 0U)
> > +                  return -EINVAL;
> > +
> > +    if (in_img->hobc_width != 0U && in_img->hobc_margin == 0U)
> > +                  return -EINVAL;
> > +
> > +    if (color_type == CSI2_DT_RAW8 || color_type == CSI2_DT_RAW10 ||
> > +        color_type == CSI2_DT_RAW12 || color_type == CSI2_DT_RAW14)
> {
> > +                  /* parameter check in case of L1ISP(in case of RAW) */
> > +                  if (in_img->hactive_size <
> HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP ||
> > +                      in_img->hactive_size >
> HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP ||
> > +                      in_img->vactive_size <
> HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP ||
> > +                      in_img->vactive_size >
> HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP ||
> > +                      ((in_img->hactive_size % 8U) != 0U)) {
> > +                                return -EINVAL;
> > +                  }
> > +
> > +                  /* check vbp range in case of L1ISP on */
> > +                  /* the constant value "7" is configuration margin */
> > +                  val = sysclk_to_numlines(
> > +                                      HWD_VIIF_TABLE_LOAD_TIME +
> HWD_VIIF_REGBUF_ACCESS_TIME * 2U, in_img) +
> > +                        HWD_VIIF_L1_DELAY_W_HDRC + 7U;
> > +                  if (in_img->vbp_size < val)
> > +                                return -EINVAL;
> > +
> > +                  /* calculate total of horizontal active size and vertical active size
> */
> > +                  if (rawpack != HWD_VIIF_RAWPACK_DISABLE) {
> > +                                val = (in_img->hactive_size + in_img->hobc_width +
> in_img->hobc_margin) *
> > +                                      2U;
> > +                  } else {
> > +                                val = in_img->hactive_size + in_img->hobc_width +
> in_img->hobc_margin;
> > +                  }
> > +                  if (in_img->interpolation_mode ==
> HWD_VIIF_L1_INPUT_INTERPOLATION_LINE) {
> > +                                total_hact_size = val;
> > +                                total_vact_size = in_img->vactive_size *
> in_img->input_num;
> > +                  } else {
> > +                                total_hact_size = val * in_img->input_num;
> > +                                total_vact_size = in_img->vactive_size;
> > +                  }
> > +    } else {
> > +                  /* OTHER input than RAW(L1ISP is off) */
> > +                  if (in_img->hactive_size <
> HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP ||
> > +                      in_img->hactive_size >
> HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP ||
> > +                      in_img->vactive_size <
> HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
> > +                      in_img->vactive_size >
> HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
> > +                      in_img->interpolation_mode !=
> HWD_VIIF_L1_INPUT_INTERPOLATION_LINE ||
> > +                      in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN
> || in_img->hobc_width != 0U) {
> > +                                return -EINVAL;
> > +                  }
> > +
> > +                  /* check vbp range in case of L1ISP off */
> > +                  /* the constant value "16" is configuration margin */
> > +                  val = sysclk_to_numlines(HWD_VIIF_TABLE_LOAD_TIME +
> HWD_VIIF_REGBUF_ACCESS_TIME,
> > +                                                            in_img) +
> > +                        16U;
> > +                  if (in_img->vbp_size < val)
> > +                                return -EINVAL;
> > +
> > +                  total_hact_size = in_img->hactive_size;
> > +                  total_vact_size = in_img->vactive_size;
> > +    }
> > +
> > +    if (in_img->htotal_size <= total_hact_size ||
> > +        (in_img->vtotal_size <= (in_img->vbp_size + total_vact_size))) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (yuv_conv != HWD_VIIF_YUV_CONV_REPEAT && yuv_conv !=
> HWD_VIIF_YUV_CONV_INTERPOLATION)
> > +                  return -EINVAL;
> > +
> > +    if (color_type != CSI2_DT_YUV4228B && color_type !=
> CSI2_DT_YUV42210B &&
> > +        yuv_conv != HWD_VIIF_YUV_CONV_REPEAT) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    /* Set DT and color type of image data */
> > +    writel((color_type << 8U) | dt_image,
> &res->capture_reg->sys.IPORTM_MAIN_DT);
> > +    writel(0x00, &res->capture_reg->sys.IPORTM_OTHER);
> > +    res->dt_image_main_w_isp = dt_image;
> > +
> > +    /* Set back porch*/
> > +    writel((in_img->vbp_size << 16U) | HWD_VIIF_HBP_SYSCLK,
> > +           &res->capture_reg->sys.BACK_PORCH_M);
> > +
> > +    /* single pulse of vsync is input to DPGM */
> > +    writel(HWD_VIIF_DPGM_VSYNC_PULSE,
> &res->capture_reg->sys.DPGM_VSYNC_SOURCE);
> > +
> > +    /* image data will be input */
> > +    /* set preprocess type before L2ISP based on color_type. */
> > +    if (color_type == CSI2_DT_YUV4228B || color_type ==
> CSI2_DT_YUV42210B) {
> > +                  /* YUV422 */
> > +                  color = 3U;
> > +    } else if (color_type == CSI2_DT_RGB565 || color_type ==
> CSI2_DT_RGB888) {
> > +                  /* RGB */
> > +                  color = 0U;
> > +    } else {
> > +                  /* RGB or YUV444 from L1ISP */
> > +                  color = 1U;
> > +    }
> > +    writel(color << 4U, &res->capture_reg->sys.PREPROCCESS_FMTM);
> > +
> > +    /* set Total size and valid size information of image data */
> > +    sysclk_num = lineperiod_in_sysclk(in_img->htotal_size,
> in_img->pixel_clock);
> > +    sysclk_num &= GENMASK(15, 0);
> > +    writel((in_img->vtotal_size << 16U) | sysclk_num,
> &res->capture_reg->sys.TOTALSIZE_M);
> > +    writel((total_vact_size << 16U) | total_hact_size,
> &res->capture_reg->sys.VALSIZE_M);
> > +
> > +    /* set image size information to L2ISP */
> > +    writel(in_img->vactive_size,
> &res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE);
> > +    writel(in_img->hactive_size,
> &res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE);
> > +
> > +    /* RAW input case */
> > +    if (color_type >= CSI2_DT_RAW8) {
> > +                  val = (in_img->interpolation_mode << 3U) |
> (in_img->input_num);
> > +                  writel(val,
> &res->capture_reg->l1isp.L1_IBUF_INPUT_ORDER);
> > +                  writel(in_img->vactive_size,
> &res->capture_reg->l1isp.L1_SYSM_HEIGHT);
> > +                  writel(in_img->hactive_size,
> &res->capture_reg->l1isp.L1_SYSM_WIDTH);
> > +                  val = (in_img->hobc_margin << 8U) | in_img->hobc_width;
> > +                  writel(val, &res->capture_reg->l1isp.L1_HOBC_MARGIN);
> > +    }
> > +
> > +    /* Set rawpack */
> > +    writel(rawpack, &res->capture_reg->sys.IPORTM_MAIN_RAW);
> > +
> > +    /* Set yuv_conv */
> > +    writel(yuv_conv, &res->capture_reg->sys.PREPROCCESS_C24M);
> > +
> > +    /* Set vsync delay */
> > +    hw_delay = in_img->vbp_size -
> sysclk_to_numlines(HWD_VIIF_TABLE_LOAD_TIME, in_img) + 4U;
> > +    hw_delay = min(hw_delay, 255U);
> > +
> > +    sw_delay0 = hw_delay -
> sysclk_to_numlines(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) + 2U;
> > +
> > +    if (color_type == CSI2_DT_RAW8 || color_type == CSI2_DT_RAW10 ||
> > +        color_type == CSI2_DT_RAW12 || color_type == CSI2_DT_RAW14)
> {
> > +                  sw_delay1 =
> sysclk_to_numlines(HWD_VIIF_REGBUF_ACCESS_TIME, in_img) +
> > +                                    HWD_VIIF_L1_DELAY_WO_HDRC + 1U;
> > +    } else {
> > +                  sw_delay1 = 10U;
> > +    }
> > +    writel(sw_delay0 << 16U, &res->capture_reg->sys.INT_M0_LINE);
> > +    writel((sw_delay1 << 16U) | hw_delay,
> &res->capture_reg->sys.INT_M1_LINE);
> > +
> > +    /* M2_LINE is the same condition as M1_LINE */
> > +    writel((sw_delay1 << 16U) | hw_delay,
> &res->capture_reg->sys.INT_M2_LINE);
> > +
> > +    /* Update internal information of pixel clock, htotal_size, information of
> L2 ROI */
> > +    res->pixel_clock = in_img->pixel_clock;
> > +    res->htotal_size = in_img->htotal_size;
> > +    res->l2_roi_path_info.roi_num = 0;
> > +    for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
> > +                  res->l2_roi_path_info.post_enable_flag[i] = false;
> > +                  res->l2_roi_path_info.post_crop_x[i] = 0;
> > +                  res->l2_roi_path_info.post_crop_y[i] = 0;
> > +                  res->l2_roi_path_info.post_crop_w[i] = 0;
> > +                  res->l2_roi_path_info.post_crop_h[i] = 0;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_main_mask_vlatch() - Control Vlatch mask of MAIN unit
> > + *
> > + * @enable: or disable Vlatch mask of MAIN unit. For more refer @ref
> hwd_viif_enable_flag.
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - "enable" is out of range
> > + */
> > +s32 hwd_viif_main_mask_vlatch(struct hwd_viif_res *res, u32 enable)
> > +{
> > +    if (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
> > +                  return -EINVAL;
> 
> The function would be nicer to use if it took bool as the argument. You
> could remove this check, too.

I'll use bool type. Same for other functions.

> > +
> > +    if (enable == HWD_VIIF_ENABLE)
> > +                  enable |= HWD_VIIF_ISP_VLATCH_MASK;
> > +
> > +    /* Control Vlatch mask */
> > +    writel(enable, &res->capture_reg->sys.IPORTM0_LD);
> > +    writel(enable, &res->capture_reg->sys.IPORTM1_LD);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_main_status_err_set_irq_mask() - Set mask condition for
> STATUS error of MAIN unit
> > + *
> > + * @mask: STATUS error mask condition
> > + * Return: None
> > + */
> > +void hwd_viif_main_status_err_set_irq_mask(struct hwd_viif_res *res, u32
> mask)
> > +{
> > +    writel(mask, &res->capture_reg->sys.INT_M_MASK);
> > +}
> > +
> > +/**
> > + * hwd_viif_main_vsync_set_irq_mask() - Set mask condition for Vsync of
> MAIN unit
> > + *
> > + * @mask: Vsync mask condition
> > + * Return: None
> > + */
> > +void hwd_viif_main_vsync_set_irq_mask(struct hwd_viif_res *res, u32 mask)
> > +{
> > +    writel(mask, &res->capture_reg->sys.INT_M_SYNC_MASK);
> > +}
> > +
> > +#define VDM_BIT_W00 BIT(0)
> > +#define VDM_BIT_W01 BIT(1)
> > +#define VDM_BIT_W02 BIT(2)
> > +#define VDM_BIT_W03 BIT(3)
> > +#define VDM_BIT_W04 BIT(4)
> > +#define VDM_BIT_W05 BIT(5)
> > +#define VDM_BIT_R00 BIT(0)
> > +#define VDM_BIT_R01 BIT(1)
> > +#define VDM_BIT_R02 BIT(2)
> > +
> > +#define VDM_ABORT_MASK_SUB_W  (VDM_BIT_W03 | VDM_BIT_W04 |
> VDM_BIT_W05)
> > +#define VDM_ABORT_MASK_MAIN_W (VDM_BIT_W00 | VDM_BIT_W01 |
> VDM_BIT_W02)
> > +#define VDM_ABORT_MASK_MAIN_R (VDM_BIT_R00 | VDM_BIT_R01 |
> VDM_BIT_R02)
> > +
> > +/**
> > + * hwd_viif_sub_set_unit() - Set static configuration of SUB unit
> > + *
> > + * @dt_image: DT of image [0x1E, 0x1F, 0x22, 0x24, 0x2A-0x2D]
> > + * @in_img: Pointer to input image information
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "dt_image" is out of range
> > + * - [2] "in_img" is NULL
> > + * - [3] member of "in_img" is invalid
> > + */
> > +s32 hwd_viif_sub_set_unit(struct hwd_viif_res *res, u32 dt_image,
> > +                                  const struct hwd_viif_input_img *in_img)
> > +{
> > +    u32 sysclk_num, temp_delay;
> > +
> > +    if (dt_image < 0x2aU || dt_image > 0x2dU)
> > +                  return -EINVAL;
> > +
> > +    if (!in_img)
> > +                  return -EINVAL;
> > +
> > +    if (in_img->hactive_size != 0U ||
> > +        in_img->interpolation_mode !=
> HWD_VIIF_L1_INPUT_INTERPOLATION_LINE ||
> > +        in_img->input_num != HWD_VIIF_L1_INPUT_NUM_MIN ||
> in_img->hobc_width != 0U ||
> > +        in_img->hobc_margin != 0U) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->pixel_clock < HWD_VIIF_MIN_PIXEL_CLOCK ||
> > +        in_img->pixel_clock > HWD_VIIF_MAX_PIXEL_CLOCK ||
> > +        in_img->htotal_size < HWD_VIIF_MIN_HTOTAL_PIXEL ||
> > +        in_img->htotal_size > HWD_VIIF_MAX_HTOTAL_PIXEL ||
> > +        in_img->vtotal_size < HWD_VIIF_MIN_VTOTAL_LINE ||
> > +        in_img->vtotal_size > HWD_VIIF_MAX_VTOTAL_LINE ||
> > +        in_img->vbp_size < HWD_VIIF_MIN_VBP_LINE ||
> in_img->vbp_size > HWD_VIIF_MAX_VBP_LINE ||
> > +        in_img->vactive_size <
> HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP ||
> > +        in_img->vactive_size >
> HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP ||
> > +        ((in_img->vactive_size % 2U) != 0U)) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (in_img->vtotal_size <= (in_img->vbp_size + in_img->vactive_size))
> > +                  return -EINVAL;
> > +
> > +    /* Set DT of image data and DT of long packet data*/
> > +    writel(dt_image, &res->capture_reg->sys.IPORTS_MAIN_DT);
> > +    writel(0x00, &res->capture_reg->sys.IPORTS_OTHER);
> > +
> > +    /* Set line size and delay value of delayed Vsync */
> > +    sysclk_num = lineperiod_in_sysclk(in_img->htotal_size,
> in_img->pixel_clock);
> > +    writel(sysclk_num & GENMASK(15, 0),
> &res->capture_reg->sys.INT_SA0_LINE);
> > +    temp_delay = in_img->vbp_size - 4U;
> > +    if (temp_delay > 255U) {
> > +                  /* Replace the value with HW max spec */
> > +                  temp_delay = 255U;
> > +    }
> > +    writel(temp_delay, &res->capture_reg->sys.INT_SA1_LINE);
> > +
> > +    return 0;
> > +}
> > +
> > +/* DMA settings */
> > +#define VDMAC_SRAM_BASE_ADDR_W03 0x440U
> > +#define SRAM_SIZE_W_PORT         0x200
> > +#define PORT_SEL_SUB_IMAGE     3
> > +
> > +/**
> > + * hwd_viif_sub_set_img_transmission() - Set image transfer condition of
> SUB unit
> > + *
> > + * @img: Pointer to output image information
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] Member of "img" is invalid
> > + */
> > +s32 hwd_viif_sub_set_img_transmission(struct hwd_viif_res *res, const
> struct hwd_viif_img *img)
> > +{
> > +    struct hwd_viif_vdm_write_port_reg *wport;
> > +    u32 img_start_addr, img_end_addr;
> > +    u32 data_width, pitch, height;
> > +    u32 k, port_control;
> > +
> > +    /* disable VDMAC when img is NULL */
> > +    if (!img) {
> > +                  writel(HWD_VIIF_DISABLE,
> &res->capture_reg->sys.IPORTS_IMGEN);
> > +                  port_control = ~((u32)1U << 3U) &
> readl(&res->capture_reg->vdm.VDM_W_ENABLE);
> > +                  writel(port_control,
> &res->capture_reg->vdm.VDM_W_ENABLE);
> > +                  return 0;
> > +    }
> > +
> > +    if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U))
> > +                  return -EINVAL;
> > +
> > +    if (img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH ||
> > +        img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT ||
> > +        img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB ||
> > +        img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    img_start_addr = (u32)img->pixelmap[0].pmap_paddr;
> > +    pitch = img->pixelmap[0].pitch;
> > +    height = img->height;
> > +
> > +    switch (img->format) {
> > +    case HWD_VIIF_ONE_COLOR_8:
> > +                  data_width = 0U;
> > +                  img_end_addr = img_start_addr + img->width - 1U;
> > +                  k = 1;
> > +                  break;
> > +    case HWD_VIIF_ONE_COLOR_16:
> > +                  data_width = 1U;
> > +                  img_end_addr = img_start_addr + (img->width * 2U) - 1U;
> > +                  k = 2;
> > +                  break;
> > +    default:
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if ((img_start_addr % 4U) != 0U)
> > +                  return -EINVAL;
> > +
> > +    if ((pitch < (img->width * k)) || pitch > HWD_VIIF_MAX_PITCH ||
> ((pitch % 4U) != 0U))
> > +                  return -EINVAL;
> > +
> > +    wport = &res->capture_reg->vdm.w_port[PORT_SEL_SUB_IMAGE];
> > +    writel(VDMAC_SRAM_BASE_ADDR_W03,
> &wport->VDM_W_SRAM_BASE);
> > +    writel(SRAM_SIZE_W_PORT, &wport->VDM_W_SRAM_SIZE);
> > +    writel(img_start_addr, &wport->VDM_W_STADR);
> > +    writel(img_end_addr, &wport->VDM_W_ENDADR);
> > +    writel(height, &wport->VDM_W_HEIGHT);
> > +    writel(pitch, &wport->VDM_W_PITCH);
> > +    writel(data_width << 8U, &wport->VDM_W_CFG0);
> > +    port_control = BIT(3) |
> readl(&res->capture_reg->vdm.VDM_W_ENABLE);
> > +    writel(port_control, &res->capture_reg->vdm.VDM_W_ENABLE);
> > +    writel(HWD_VIIF_ENABLE, &res->capture_reg->sys.IPORTS_IMGEN);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_sub_status_err_set_irq_mask() -
> > + *  Set mask condition for STATUS error of SUB unit or VOIF loopback
> > + *
> > + * @mask: STATUS error mask condition
> > + * Return: None
> > + */
> > +void hwd_viif_sub_status_err_set_irq_mask(struct hwd_viif_res *res, u32
> mask)
> > +{
> > +    writel(mask, &res->capture_reg->sys.INT_S_MASK);
> > +}
> > +
> > +/**
> > + * hwd_viif_sub_vsync_set_irq_mask() - Set mask condition for Vsync of SUB
> unit or VOIF loopback
> > + *
> > + * @mask: Vsync mask condition
> > + * Return: None
> > + */
> > +void hwd_viif_sub_vsync_set_irq_mask(struct hwd_viif_res *res, const u32
> mask)
> > +{
> > +    writel(mask, &res->capture_reg->sys.INT_S_SYNC_MASK);
> > +}
> > +
> > +/**
> > + * hwd_viif_isp_set_regbuf_auto_transmission() - Set register buffer auto
> transmission
> > + *
> > + * Return: None
> > + */
> > +void hwd_viif_isp_set_regbuf_auto_transmission(struct hwd_viif_res *res)
> > +{
> > +    u32 val;
> > +
> > +    /* Set parameters for auto read transmission of register buffer */
> > +
> > +    if (res->dt_image_main_w_isp != 0x0U) {
> > +                  /*
> > +                  * configuration is done
> > +                  * only when dt_image is not 0, means image data is input to
> ISP.
> > +                  */
> > +                  writel(0x0,
> &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
> > +                  writel(0x0,
> &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
> > +                  writel(HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT,
> > +                         &res->capture_reg->l1isp.L1_CRGBF_TRN_RBADDR);
> > +                  writel(HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT,
> > +                         &res->capture_reg->l1isp.L1_CRGBF_TRN_READDR);
> > +                  writel(HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT,
> > +                         &res->capture_reg->l2isp.L2_CRGBF_TRN_RBADDR);
> > +                  writel(HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT,
> > +                         &res->capture_reg->l2isp.L2_CRGBF_TRN_READDR);
> > +                  val = BIT(16);
> > +                  writel(val,
> &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
> > +                  writel(val,
> &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_isp_disable_regbuf_auto_transmission() - Disable register buffer
> auto transmission
> > + *
> > + * Return: None
> > + */
> > +void hwd_viif_isp_disable_regbuf_auto_transmission(struct hwd_viif_res
> *res)
> > +{
> > +    if (res->dt_image_main_w_isp != 0x0U) {
> > +                  writel(0x0,
> &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
> > +                  writel(0x0,
> &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_isp_guard_start() - stop register auto update
> > + *
> > + *
> > + * This function call stops update of some hardware registers
> > + * while the manual setup of VIIF, L1ISP registers is in progress.
> > + *
> > + * * regbuf control: load/store HW register (settings, status) values to backup
> SRAM.
> > + * * vlatch control: copy timer-counter register value to status register.
> > + */
> > +void hwd_viif_isp_guard_start(struct hwd_viif_res *res)
> > +{
> > +    hwd_viif_isp_disable_regbuf_auto_transmission(res);
> > +    ndelay(500);
> > +    hwd_viif_main_mask_vlatch(res, HWD_VIIF_ENABLE);
> > +}
> > +
> > +/**
> > + * hwd_viif_isp_guard_start() - restart register auto update
> > + *
> > + *
> > + * see also hwd_viif_isp_guard_start().
> > + */
> > +void hwd_viif_isp_guard_end(struct hwd_viif_res *res)
> > +{
> > +    hwd_viif_main_mask_vlatch(res, HWD_VIIF_DISABLE);
> > +    hwd_viif_isp_set_regbuf_auto_transmission(res);
> > +}
> > +
> > +#define L2_STATUS_REPORT_MASK 0x1eU
> > +
> > +/**
> > + * hwd_viif_isp_get_info() - Get processing information of L1ISP and L2ISP
> > + *
> > + * @l1_info: L1ISP processing information
> > + * @l2_transfer_status: status of L2ISP transmission
> > + * Return: None
> > + */
> > +void hwd_viif_isp_get_info(struct hwd_viif_res *res, struct hwd_viif_l1_info
> *l1_info,
> > +                                   u32 *l2_transfer_status)
> > +{
> > +    u32 val, l2_status;
> > +    int i, j;
> > +
> > +    if (l1_info) {
> > +                  /* change register buffer to regbuf0 where driver gets
> information */
> > +                  writel(HWD_VIIF_ISP_REGBUF_MODE_BUFFER,
> &res->capture_reg->l1isp.L1_CRGBF_ACC_CONF);
> > +
> > +                  /* get AWB info */
> > +                  l1_info->awb_ave_u =
> readl(&res->capture_reg->l1isp.L1_AWHB_AVE_USIG);
> > +                  l1_info->awb_ave_v =
> readl(&res->capture_reg->l1isp.L1_AWHB_AVE_VSIG);
> > +                  l1_info->awb_accumulated_pixel =
> readl(&res->capture_reg->l1isp.L1_AWHB_NUM_UVON);
> > +                  l1_info->awb_gain_r =
> readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAINR);
> > +                  l1_info->awb_gain_g =
> readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAING);
> > +                  l1_info->awb_gain_b =
> readl(&res->capture_reg->l1isp.L1_AWHB_AWBGAINB);
> > +                  val =
> readl(&res->capture_reg->l1isp.L1_AWHB_R_CTR_STOP);
> > +                  l1_info->awb_status_u = (FIELD_GET(BIT(1), val) != 0);
> > +                  l1_info->awb_status_v = (FIELD_GET(BIT(0), val) != 0);
> > +
> > +                  /* get average luminance info */
> > +                  l1_info->avg_lum_weight =
> readl(&res->capture_reg->l1isp.L1_AEXP_RESULT_AVE);
> > +                  val =
> readl(&res->capture_reg->l1isp.L1_AEXP_SATUR_BLACK_PIXNUM);
> > +                  l1_info->avg_satur_pixnum = FIELD_GET(GENMASK(31, 16),
> val);
> > +                  l1_info->avg_black_pixnum = FIELD_GET(GENMASK(15, 0),
> val);
> > +                  for (i = 0; i < 8; i++) {
> > +                                for (j = 0; j < 8; j++) {
> > +                                              l1_info->avg_lum_block[i][j] =
> > +
>           readl(&res->capture_reg->l1isp.L1_AEXP_AVE[i][j]);
> > +                                }
> > +                  }
> > +                  l1_info->avg_lum_four_line_lum[0] =
> > +
>           readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES0);
> > +                  l1_info->avg_lum_four_line_lum[1] =
> > +
>           readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES1);
> > +                  l1_info->avg_lum_four_line_lum[2] =
> > +
>           readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES2);
> > +                  l1_info->avg_lum_four_line_lum[3] =
> > +
>           readl(&res->capture_reg->l1isp.L1_AEXP_AVE4LINES3);
> > +
> > +                  /* revert to register access from register buffer access */
> > +                  writel(HWD_VIIF_ISP_REGBUF_MODE_BYPASS,
> &res->capture_reg->l1isp.L1_CRGBF_ACC_CONF);
> > +    }
> > +
> > +    if (l2_transfer_status) {
> > +                  /* get L2ISP abort information */
> > +                  l2_status =
> readl(&res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
> > +                  writel(l2_status,
> &res->capture_reg->l2isp.L2_CRGBF_ISP_INT);
> > +                  *l2_transfer_status = l2_status &
> L2_STATUS_REPORT_MASK;
> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_isp_set_regbuf_irq_mask() - Set mask condition for ISP register
> buffer
> > + *
> > + * @mask_l1: Pointer to mask configuration for L1ISP register buffer
> interruption
> > + * @mask_l2: Pointer to mask configuration for L2ISP register buffer
> interruption
> > + * Return: None
> > + */
> > +void hwd_viif_isp_set_regbuf_irq_mask(struct hwd_viif_res *res, const u32
> *mask_l1,
> > +                                                    const u32 *mask_l2)
> > +{
> > +    writel(*mask_l1, &res->capture_reg->l1isp.L1_CRGBF_INT_MASK);
> > +    writel(*mask_l2, &res->capture_reg->l2isp.L2_CRGBF_INT_MASK);
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_input_csc() - Set input CSC parameters of L2ISP
> > + *
> > + * @param: Pointer to input csc parameters of L2ISP
> > + * @is_l1_rgb: input information of L2ISP
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] Member of "param" is invalid
> > + */
> > +s32 hwd_viif_l2_set_input_csc(struct hwd_viif_res *res, const struct
> hwd_viif_csc_param *param,
> > +                                      bool is_l1_rgb)
> > +{
> > +    struct hwd_viif_csc_param hwd_param;
> > +    u32 enable = HWD_VIIF_ENABLE;
> > +    bool csc_enable_flag = true;
> > +    u32 i, val;
> > +
> > +    if (param) {
> > +                  if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +                      param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +                      param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET
> ||
> > +                      param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET
> ||
> > +                      param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET
> ||
> > +                      param->b_cb_out_offset >
> HWD_VIIF_CSC_MAX_OFFSET) {
> > +                                return -EINVAL;
> > +                  }
> > +
> > +                  for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
> > +                                if (param->coef[i] >
> HWD_VIIF_CSC_MAX_COEF_VALUE)
> > +                                              return -EINVAL;
> > +                  }
> > +
> > +                  if (is_l1_rgb) {
> > +                                /* translated parameters are used */
> > +                                hwd_param.r_cr_in_offset = param->b_cb_in_offset;
> > +                                hwd_param.g_y_in_offset = param->r_cr_in_offset;
> > +                                hwd_param.b_cb_in_offset = param->g_y_in_offset;
> > +                                hwd_param.r_cr_out_offset = param->r_cr_out_offset;
> > +                                hwd_param.g_y_out_offset = param->g_y_out_offset;
> > +                                hwd_param.b_cb_out_offset =
> param->b_cb_out_offset;
> > +                                hwd_param.coef[0] = param->coef[2];
> > +                                hwd_param.coef[1] = param->coef[0];
> > +                                hwd_param.coef[2] = param->coef[1];
> > +                                hwd_param.coef[3] = param->coef[5];
> > +                                hwd_param.coef[4] = param->coef[3];
> > +                                hwd_param.coef[5] = param->coef[4];
> > +                                hwd_param.coef[6] = param->coef[8];
> > +                                hwd_param.coef[7] = param->coef[6];
> > +                                hwd_param.coef[8] = param->coef[7];
> > +                  } else {
> > +                                /* original parameters are used */
> > +                                hwd_param.r_cr_in_offset = param->r_cr_in_offset;
> > +                                hwd_param.g_y_in_offset = param->g_y_in_offset;
> > +                                hwd_param.b_cb_in_offset = param->b_cb_in_offset;
> > +                                hwd_param.r_cr_out_offset = param->r_cr_out_offset;
> > +                                hwd_param.g_y_out_offset = param->g_y_out_offset;
> > +                                hwd_param.b_cb_out_offset =
> param->b_cb_out_offset;
> > +                                hwd_param.coef[0] = param->coef[0];
> > +                                hwd_param.coef[1] = param->coef[1];
> > +                                hwd_param.coef[2] = param->coef[2];
> > +                                hwd_param.coef[3] = param->coef[3];
> > +                                hwd_param.coef[4] = param->coef[4];
> > +                                hwd_param.coef[5] = param->coef[5];
> > +                                hwd_param.coef[6] = param->coef[6];
> > +                                hwd_param.coef[7] = param->coef[7];
> > +                                hwd_param.coef[8] = param->coef[8];
> > +                  }
> > +    } else {
> > +                  if (is_l1_rgb) {
> > +                                /* fixed parameters are used */
> > +                                hwd_param.r_cr_in_offset = 0U;
> > +                                hwd_param.g_y_in_offset = 0U;
> > +                                hwd_param.b_cb_in_offset = 0U;
> > +                                hwd_param.r_cr_out_offset = 0U;
> > +                                hwd_param.g_y_out_offset = 0U;
> > +                                hwd_param.b_cb_out_offset = 0U;
> > +                                hwd_param.coef[0] = 0U;
> > +                                hwd_param.coef[1] = 0x1000U;
> > +                                hwd_param.coef[2] = 0U;
> > +                                hwd_param.coef[3] = 0U;
> > +                                hwd_param.coef[4] = 0U;
> > +                                hwd_param.coef[5] = 0x1000U;
> > +                                hwd_param.coef[6] = 0x1000U;
> > +                                hwd_param.coef[7] = 0U;
> > +                                hwd_param.coef[8] = 0U;
> > +                  } else {
> > +                                /* csc is disabled */
> > +                                enable = HWD_VIIF_DISABLE;
> > +                                csc_enable_flag = false;
> > +                  }
> > +    }
> > +
> > +    if (csc_enable_flag) {
> > +                  writel(hwd_param.g_y_in_offset,
> > +
> &res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETI);
> > +                  writel(hwd_param.coef[0],
> &res->capture_reg->sys.l2isp_input_csc.MTB_YG1);
> > +                  val = (hwd_param.coef[1] <<
> HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
> > +                        (hwd_param.coef[2] <<
> HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
> > +                  writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_YG2);
> > +                  writel(hwd_param.g_y_out_offset,
> > +
> &res->capture_reg->sys.l2isp_input_csc.MTB_YG_OFFSETO);
> > +                  writel(hwd_param.b_cb_in_offset,
> > +
> &res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETI);
> > +                  writel(hwd_param.coef[3],
> &res->capture_reg->sys.l2isp_input_csc.MTB_CB1);
> > +                  val = (hwd_param.coef[4] <<
> HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
> > +                        (hwd_param.coef[5] <<
> HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
> > +                  writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_CB2);
> > +                  writel(hwd_param.b_cb_out_offset,
> > +
> &res->capture_reg->sys.l2isp_input_csc.MTB_CB_OFFSETO);
> > +                  writel(hwd_param.r_cr_in_offset,
> > +
> &res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETI);
> > +                  writel(hwd_param.coef[6],
> &res->capture_reg->sys.l2isp_input_csc.MTB_CR1);
> > +                  val = (hwd_param.coef[7] <<
> HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
> > +                        (hwd_param.coef[8] <<
> HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
> > +                  writel(val, &res->capture_reg->sys.l2isp_input_csc.MTB_CR2);
> > +                  writel(hwd_param.r_cr_out_offset,
> > +
> &res->capture_reg->sys.l2isp_input_csc.MTB_CR_OFFSETO);
> > +    }
> > +
> > +    writel(enable, &res->capture_reg->sys.l2isp_input_csc.MTB);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_undist() - Set undistortion parameters of L2ISP
> > + *
> > + * @param: Pointer to undistortion parameters of L2ISP
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "param" is NULL
> > + * - [2] Member of "param" is invalid
> > + */
> > +s32 hwd_viif_l2_set_undist(struct hwd_viif_res *res, const struct
> viif_l2_undist *param)
> > +{
> > +    u32 grid_num_h, grid_num_v;
> > +    u32 i, val;
> > +
> > +    if (!param)
> > +                  return -EINVAL;
> > +
> > +    if (param->through_mode != HWD_VIIF_ENABLE &&
> param->through_mode != HWD_VIIF_DISABLE)
> > +                  return -EINVAL;
> > +
> > +    if (param->roi_mode[0] != HWD_VIIF_L2_UNDIST_POLY &&
> > +        param->roi_mode[0] != HWD_VIIF_L2_UNDIST_GRID &&
> > +        param->roi_mode[0] != HWD_VIIF_L2_UNDIST_POLY_TO_GRID
> &&
> > +        param->roi_mode[0] != HWD_VIIF_L2_UNDIST_GRID_TO_POLY)
> {
> > +                  return -EINVAL;
> > +    }
> > +    if (param->roi_mode[1] != HWD_VIIF_L2_UNDIST_POLY &&
> > +        param->roi_mode[1] != HWD_VIIF_L2_UNDIST_GRID &&
> > +        param->roi_mode[1] != HWD_VIIF_L2_UNDIST_POLY_TO_GRID
> &&
> > +        param->roi_mode[1] != HWD_VIIF_L2_UNDIST_GRID_TO_POLY)
> {
> > +                  return -EINVAL;
> > +    }
> > +    if (param->roi_write_area_delta[0] >=
> HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA ||
> > +        param->roi_write_area_delta[1] >=
> HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA ||
> > +        param->sensor_crop_ofs_h <
> HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H ||
> > +        param->sensor_crop_ofs_h >
> HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H ||
> > +        param->sensor_crop_ofs_v <
> HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V ||
> > +        param->sensor_crop_ofs_v >
> HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V ||
> > +        param->norm_scale >
> HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE ||
> > +        param->valid_r_norm2_poly >=
> HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2 ||
> > +        param->valid_r_norm2_grid >=
> HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
> > +                  if (param->poly_write_g_coef[i] <
> HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
> > +                      param->poly_write_g_coef[i] >
> HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
> > +                      param->poly_read_b_coef[i] <
> HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
> > +                      param->poly_read_b_coef[i] >
> HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
> > +                      param->poly_read_g_coef[i] <
> HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
> > +                      param->poly_read_g_coef[i] >
> HWD_VIIF_L2_UNDIST_MAX_POLY_COEF ||
> > +                      param->poly_read_r_coef[i] <
> HWD_VIIF_L2_UNDIST_MIN_POLY_COEF ||
> > +                      param->poly_read_r_coef[i] >
> HWD_VIIF_L2_UNDIST_MAX_POLY_COEF) {
> > +                                return -EINVAL;
> > +                  }
> > +    }
> > +
> > +    if (param->grid_node_num_h <
> HWD_VIIF_L2_UNDIST_MIN_GRID_NUM ||
> > +        param->grid_node_num_h >
> HWD_VIIF_L2_UNDIST_MAX_GRID_NUM ||
> > +        param->grid_node_num_v <
> HWD_VIIF_L2_UNDIST_MIN_GRID_NUM ||
> > +        param->grid_node_num_v >
> HWD_VIIF_L2_UNDIST_MAX_GRID_NUM) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    grid_num_h = param->grid_node_num_h;
> > +    grid_num_v = param->grid_node_num_v;
> > +    if ((grid_num_h % 2U) != 0U)
> > +                  grid_num_h += 1U;
> > +
> > +    if ((grid_num_v % 2U) != 0U)
> > +                  grid_num_v += 1U;
> > +
> > +    if ((grid_num_v * grid_num_h) >
> HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM ||
> > +        param->grid_patch_hsize_inv >=
> HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV ||
> > +        param->grid_patch_vsize_inv >=
> HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_HSIZE) &
> GENMASK(12, 0);
> > +    if (((param->sensor_crop_ofs_h / 2) + ((s16)val)) > 4095)
> > +                  return -EINVAL;
> > +
> > +    val = readl(&res->capture_reg->l2isp.L2_SENSOR_CROP_VSIZE) &
> GENMASK(11, 0);
> > +    if (((param->sensor_crop_ofs_v / 2) + ((s16)val)) > 2047)
> > +                  return -EINVAL;
> > +
> > +    /* set parameters related to L2ISP UNDIST */
> > +    if (param->through_mode == HWD_VIIF_ENABLE) {
> > +                  /* Enable through mode */
> > +                  writel(HWD_VIIF_ENABLE,
> &res->capture_reg->l2isp.L2_MODE);
> > +    } else {
> > +                  val = (param->roi_mode[0] << 1U) | (param->roi_mode[1] <<
> 3U);
> > +                  writel(val, &res->capture_reg->l2isp.L2_MODE);
> > +                  val = (u32)param->sensor_crop_ofs_h & GENMASK(13, 0);
> > +                  writel(val,
> &res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_H);
> > +                  val = (u32)param->sensor_crop_ofs_v & GENMASK(12, 0);
> > +                  writel(val,
> &res->capture_reg->l2isp.L2_SENSOR_CROP_OFS_V);
> > +                  writel(param->norm_scale,
> &res->capture_reg->l2isp.L2_NORM_SCALE);
> > +                  writel(param->valid_r_norm2_poly,
> &res->capture_reg->l2isp.L2_VALID_R_NORM2_POLY);
> > +                  writel(param->valid_r_norm2_grid,
> &res->capture_reg->l2isp.L2_VALID_R_NORM2_GRID);
> > +                  writel(param->roi_write_area_delta[0],
> > +
> &res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[0]);
> > +                  writel(param->roi_write_area_delta[1],
> > +
> &res->capture_reg->l2isp.L2_ROI_WRITE_AREA_DELTA[1]);
> > +
> > +                  for (i = 0; i < HWD_VIIF_L2_UNDIST_POLY_NUM; i++) {
> > +                                val = (u32)param->poly_write_g_coef[i];
> > +                                writel(val,
> &res->capture_reg->l2isp.L2_POLY10_WRITE_G_COEF[i]);
> > +                                val = (u32)param->poly_read_b_coef[i];
> > +                                writel(val,
> &res->capture_reg->l2isp.L2_POLY10_READ_B_COEF[i]);
> > +                                val = (u32)param->poly_read_g_coef[i];
> > +                                writel(val,
> &res->capture_reg->l2isp.L2_POLY10_READ_G_COEF[i]);
> > +                                val = (u32)param->poly_read_r_coef[i];
> > +                                writel(val,
> &res->capture_reg->l2isp.L2_POLY10_READ_R_COEF[i]);
> > +                  }
> > +                  writel(param->grid_node_num_h,
> &res->capture_reg->l2isp.L2_GRID_NODE_NUM_H);
> > +                  writel(param->grid_node_num_v,
> &res->capture_reg->l2isp.L2_GRID_NODE_NUM_V);
> > +                  writel(param->grid_patch_hsize_inv,
> > +
> &res->capture_reg->l2isp.L2_GRID_PATCH_HSIZE_INV);
> > +                  writel(param->grid_patch_vsize_inv,
> > +
> &res->capture_reg->l2isp.L2_GRID_PATCH_VSIZE_INV);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_undist_table_transmission() -
> > + *  Configure L2ISP transferring grid table for undistortion.
> > + *
> > + * @write_g: grid table address for G-WRITE(physical address)
> > + * @read_b: grid table address for B-READ(physical address)
> > + * @read_g: grid table address for G-READ(physical address)
> > + * @read_r: grid table address for R-READ(physical address)
> > + * @size: of each table [1024..8192] [byte]
> > + * Return: 0 operation completed successfully
> > + * Return: -EINVAL Parameter error
> > + * - "write_g", "read_b", "read_g" or "read_r" is not 4byte alignment
> > + * - "size" is out of range
> > + * - "size" is not 0 when all table addresses are 0
> > + */
> > +s32 hwd_viif_l2_set_undist_table_transmission(struct hwd_viif_res *res,
> uintptr_t write_g,
> > +                                                                  uintptr_t read_b, uintptr_t
> read_g, uintptr_t read_r,
> > +                                                                  u32 size)
> > +{
> > +    u32 val = 0U;
> > +
> > +    if (((write_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_b %
> HWD_VIIF_L2_VDM_ALIGN) != 0U) ||
> > +        ((read_g % HWD_VIIF_L2_VDM_ALIGN) != 0U) || ((read_r %
> HWD_VIIF_L2_VDM_ALIGN) != 0U)) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if ((size != 0U && size < HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE) ||
> > +        size > HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if ((size % 4U) != 0U)
> 
> size % 4 is enough.

I'll drop comparison with zero.

> > +                  return -EINVAL;
> > +
> > +    if (write_g == 0U && read_b == 0U && read_g == 0U && read_r == 0U
> && size != 0U)
> > +                  return -EINVAL;
> > +
> > +    if ((write_g != 0U || read_b != 0U || read_g != 0U || read_r != 0U) &&
> size == 0U)
> > +                  return -EINVAL;
> 
> No explicit comparison with zero is needed here. Same below.

I'll drop explicit comparison with zero. Same for other lines.

> > +
> > +    /* read_b: t_port[8], read_g: t_port[9], read_r: t_port[10], write_g:
> t_port[11] */
> > +    if (read_b != 0U) {
> > +                  writel((u32)read_b,
> &res->capture_reg->vdm.t_port[8].VDM_T_STADR);
> > +                  writel(size, &res->capture_reg->vdm.t_port[8].VDM_T_SIZE);
> > +                  val |= BIT(8);
> > +    }
> > +    if (read_g != 0U) {
> > +                  writel((u32)read_g,
> &res->capture_reg->vdm.t_port[9].VDM_T_STADR);
> > +                  writel(size, &res->capture_reg->vdm.t_port[9].VDM_T_SIZE);
> > +                  val |= BIT(9);
> > +    }
> > +    if (read_r != 0U) {
> > +                  writel((u32)read_r,
> &res->capture_reg->vdm.t_port[10].VDM_T_STADR);
> > +                  writel(size, &res->capture_reg->vdm.t_port[10].VDM_T_SIZE);
> > +                  val |= BIT(10);
> > +    }
> > +    if (write_g != 0U) {
> > +                  writel((u32)write_g,
> &res->capture_reg->vdm.t_port[11].VDM_T_STADR);
> > +                  writel(size, &res->capture_reg->vdm.t_port[11].VDM_T_SIZE);
> > +                  val |= BIT(11);
> > +    }
> > +
> > +    if (val != 0U) {
> > +                  /*
> > +                  * Set SRAM base address and size.
> > +                  * t_group[1] is used only to transfer UNDIST table
> > +                  */
> > +                  writel(HWD_VIIF_VDM_CFG_PARAM,
> &res->capture_reg->vdm.t_group[1].VDM_T_CFG);
> > +                  writel(HWD_VIIF_L2_VDM_GRID_SRAM_BASE,
> > +
> &res->capture_reg->vdm.t_group[1].VDM_T_SRAM_BASE);
> > +                  writel(HWD_VIIF_L2_VDM_GRID_SRAM_SIZE,
> > +
> &res->capture_reg->vdm.t_group[1].VDM_T_SRAM_SIZE);
> > +    }
> > +
> > +    val |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) &
> ~((u32)0xfU << 8U));
> > +    writel(val, &res->capture_reg->vdm.VDM_T_ENABLE);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_roi_num_1() - Set ROI path condition when ROI num is 1
> > + */
> > +static void hwd_viif_l2_set_roi_num_1(struct hwd_viif_res *res)
> > +{
> > +    struct hwd_viif_l2_roi_path_info *info = &res->l2_roi_path_info;
> > +    u32 val, x_min, x_max, y_min, y_max;
> > +    u32 i, x, y, w, h;
> > +
> > +    /* ROI0 is input to POST0 and POST1 */
> > +    if (info->post_enable_flag[0]) {
> > +                  /* POST0 is enabled */
> > +                  x_min = info->post_crop_x[0];
> > +                  x_max = info->post_crop_x[0] + info->post_crop_w[0];
> > +                  y_min = info->post_crop_y[0];
> > +                  y_max = info->post_crop_y[0] + info->post_crop_h[0];
> > +                  if (info->post_enable_flag[1]) {
> > +                                /* POST1 is enabled */
> > +                                x_min = min(x_min, info->post_crop_x[1]);
> > +                                val = info->post_crop_x[1] + info->post_crop_w[1];
> > +                                x_max = max(x_max, val);
> > +                                y_min = min(y_min, info->post_crop_y[1]);
> > +                                val = info->post_crop_y[1] + info->post_crop_h[1];
> > +                                y_max = max(y_max, val);
> > +                  }
> > +                  x = x_min;
> > +                  y = y_min;
> > +                  w = x_max - x_min;
> > +                  h = y_max - y_min;
> > +    } else if (info->post_enable_flag[1]) {
> > +                  /* POST0 is disabled and POST1 is enabled */
> > +                  x = info->post_crop_x[1];
> > +                  w = info->post_crop_w[1];
> > +                  y = info->post_crop_y[1];
> > +                  h = info->post_crop_h[1];
> > +    } else {
> > +                  /* All POSTs are disabled */
> > +                  x = 0;
> > +                  y = 0;
> > +                  w = HWD_VIIF_CROP_MIN_W;
> > +                  h = HWD_VIIF_CROP_MIN_H;
> > +    }
> > +    writel(x, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_H);
> > +    writel(y, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_OFS_V);
> > +    writel(w, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_HSIZE);
> > +    writel(h, &res->capture_reg->l2isp.roi[0].L2_ROI_OUT_VSIZE);
> > +
> > +    for (i = 0; i < HWD_VIIF_MAX_POST_NUM; i++) {
> > +                  if (info->post_enable_flag[i])
> > +                                writel(0,
> &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
> > +                  else
> > +                                writel(HWD_VIIF_L2_ROI_NONE,
> &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
> 
> This might be more readable as
> 
>           writel (info->post_enable_flag[i] ? 0 : HWD_VIIF_L2_ROI_NONE,
>                         ...);
> 
> Up to you.

Thank you for an advice. I'll try.

> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_roi_num_2() - Set ROI path condition when ROI num is 2
> > + */
> > +static void hwd_viif_l2_set_roi_num_2(struct hwd_viif_res *res)
> > +{
> > +    struct hwd_viif_l2_roi_path_info *info = &res->l2_roi_path_info;
> > +    u32 i;
> > +
> > +    for (i = 0; i < HWD_VIIF_L2_ROI_MAX_NUM; i++) {
> > +                  /* ROI-n is the same as CROP area of POST-n */
> > +                  if (info->post_enable_flag[i]) {
> > +                                writel(info->post_crop_x[i],
> > +
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H);
> > +                                writel(info->post_crop_y[i],
> > +
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V);
> > +                                writel(info->post_crop_w[i],
> > +
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE);
> > +                                writel(info->post_crop_h[i],
> > +
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE);
> > +                                writel(i,
> &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
> > +                  } else {
> > +                                writel(0,
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_H);
> > +                                writel(0,
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_OFS_V);
> > +                                writel(HWD_VIIF_CROP_MIN_W,
> > +
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_HSIZE);
> > +                                writel(HWD_VIIF_CROP_MIN_H,
> > +
> &res->capture_reg->l2isp.roi[i].L2_ROI_OUT_VSIZE);
> > +                                writel(HWD_VIIF_L2_ROI_NONE,
> &res->capture_reg->l2isp.L2_ROI_TO_POST[i]);
> > +                  }
> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_roi_path() - Set ROI path condition
> > + */
> > +static void hwd_viif_l2_set_roi_path(struct hwd_viif_res *res)
> > +{
> > +    if (res->l2_roi_path_info.roi_num == 1U)
> > +                  hwd_viif_l2_set_roi_num_1(res);
> > +    else
> > +                  hwd_viif_l2_set_roi_num_2(res);
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_roi() - Set ROI parameters of L2ISP
> > + *
> > + * @param: Pointer to ROI parameters of L2ISP
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "param" is NULL
> > + * - [2] Member of "param" is invalid
> > + *
> > + * see also: #hwd_viif_l2_set_roi_path
> > + */
> > +s32 hwd_viif_l2_set_roi(struct hwd_viif_res *res, const struct
> viif_l2_roi_config *param)
> > +{
> > +    u32 val;
> > +    int i;
> > +
> > +    if (!param)
> > +                  return -EINVAL;
> > +
> > +    if (param->roi_num < 1 || param->roi_num > 2)
> > +                  return -EINVAL;
> > +
> > +    for (i = 0; i < 2; i++) {
> > +                  if (param->roi_scale[i] < HWD_VIIF_L2_ROI_MIN_SCALE ||
> > +                      param->roi_scale[i] > HWD_VIIF_L2_ROI_MAX_SCALE ||
> > +                      param->roi_scale_inv[i] <
> HWD_VIIF_L2_ROI_MIN_SCALE_INV ||
> > +                      param->roi_scale_inv[i] >
> HWD_VIIF_L2_ROI_MAX_SCALE_INV ||
> > +                      param->corrected_wo_scale_hsize[i] <
> > +
> HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE ||
> > +                      param->corrected_wo_scale_hsize[i] >
> > +
> HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE ||
> > +                      param->corrected_wo_scale_vsize[i] <
> > +
> HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE ||
> > +                      param->corrected_wo_scale_vsize[i] >
> > +
> HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE ||
> > +                      param->corrected_hsize[i] <
> HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE ||
> > +                      param->corrected_hsize[i] >
> HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE ||
> > +                      param->corrected_vsize[i] <
> HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE ||
> > +                      param->corrected_vsize[i] >
> HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE) {
> > +                                return -EINVAL;
> > +                  }
> > +    }
> > +
> > +    /* Set the number of ROI and update resource info with roi_num */
> > +    writel(param->roi_num, &res->capture_reg->l2isp.L2_ROI_NUM);
> > +    res->l2_roi_path_info.roi_num = param->roi_num;
> > +
> > +    /* Update ROI area and input to each POST */
> > +    hwd_viif_l2_set_roi_path(res);
> > +
> > +    /* Set the remaining parameters */
> > +    for (i = 0; i < 2; i++) {
> > +                  writel(param->roi_scale[i],
> &res->capture_reg->l2isp.roi[i].L2_ROI_SCALE);
> > +                  writel(param->roi_scale_inv[i],
> &res->capture_reg->l2isp.roi[i].L2_ROI_SCALE_INV);
> > +                  val = (param->corrected_wo_scale_hsize[i] << 13U) |
> param->corrected_hsize[i];
> > +                  writel(val,
> &res->capture_reg->l2isp.roi[i].L2_ROI_CORRECTED_HSIZE);
> > +                  val = (param->corrected_wo_scale_vsize[i] << 12U) |
> param->corrected_vsize[i];
> > +                  writel(val,
> &res->capture_reg->l2isp.roi[i].L2_ROI_CORRECTED_VSIZE);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_gamma() - Set Gamma correction parameters of L2ISP
> > + *
> > + * @post_id: POST ID [0..1]
> > + * @enable: or disable gamma correction of L2ISP. For more refer @ref
> hwd_viif_enable_flag.
> > + * @vsplit: changing line position from 1st table to 2nd table [0..4094]
> > + * @mode: Gamma correction mode. For more refer @ref
> hwd_viif_gamma_table_mode.
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "post_id", "enable", "vsplit"  or "mode" is out of range
> > + * - [2] "vsplit" is not 0 when "enable" is HWD_VIIF_DISABLE
> > + * - [3] "mode" is not HWD_VIIF_GAMMA_COMPRESSED when enable is
> HWD_VIIF_DISABLE
> > + *
> > + * see also: #hwd_viif_l2_set_gamma
> > + */
> > +s32 hwd_viif_l2_set_gamma(struct hwd_viif_res *res, u32 post_id, u32
> enable, u32 vsplit, u32 mode)
> > +{
> > +    u32 val;
> > +
> > +    if (post_id >= HWD_VIIF_MAX_POST_NUM ||
> > +        (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
> ||
> > +        vsplit > HWD_VIIF_GAMMA_MAX_VSPLIT ||
> > +        (mode != HWD_VIIF_GAMMA_COMPRESSED && mode !=
> HWD_VIIF_GAMMA_LINEAR) ||
> > +        (enable == HWD_VIIF_DISABLE && vsplit != 0x0U) ||
> > +        (enable == HWD_VIIF_DISABLE && mode !=
> HWD_VIIF_GAMMA_COMPRESSED)) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    /* Set gamma parameters of L2ISP */
> > +    val = (vsplit << 16U) | (mode << 4U) | enable;
> > +    writel(val,
> &res->capture_reg->l2isp.post[post_id].L2_POST_GAMMA_M);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_gamma_table_transmission() - Configure L2ISP
> transferring gamma table.
> > + *
> > + * @post_id: POST ID [0..1]
> > + * @gamma_table: Pointer to gamma table information
> > + * Return: 0 operation completed successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "post_id" is out of range
> > + * - [2] Member of "gamma_table" is invalid
> > + */
> > +s32 hwd_viif_l2_set_gamma_table_transmission(struct hwd_viif_res *res,
> u32 post_id,
> > +                                                                 const struct
> hwd_viif_l2_gamma_table *gamma_table)
> > +{
> > +    u32 vdm_enable = 0U;
> > +    u32 i, base_addr;
> > +
> > +    if (post_id >= HWD_VIIF_MAX_POST_NUM)
> > +                  return -EINVAL;
> > +
> > +    for (i = 0; i < 6U; i++) {
> > +                  if ((gamma_table->table[i] % HWD_VIIF_L2_VDM_ALIGN) !=
> 0U)
> > +                                return -EINVAL;
> > +    }
> > +
> > +    /* table[0]: LUT0-G/Y: t_port[12 + post_id * 6] */
> > +    /* table[1]: LUT1-G/Y: t_port[13 + post_id * 6] */
> > +    /* table[2]: LUT0-B/U: t_port[14 + post_id * 6] */
> > +    /* table[3]: LUT1-B/U: t_port[15 + post_id * 6] */
> > +    /* table[4]: LUT0-R/V: t_port[16 + post_id * 6] */
> > +    /* table[5]: LUT1-R/V: t_port[17 + post_id * 6] */
> > +    for (i = 0; i < 6U; i++) {
> > +                  if (gamma_table->table[i] != 0U) {
> > +                                int idx = 12U + i + post_id * 6U;
> > +
> > +                                writel((u32)gamma_table->table[i],
> > +
> &res->capture_reg->vdm.t_port[idx].VDM_T_STADR);
> > +                                writel(HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE,
> > +
> &res->capture_reg->vdm.t_port[idx].VDM_T_SIZE);
> > +                                vdm_enable |= BIT(i);
> > +                  }
> > +    }
> > +    if (vdm_enable != 0U) {
> > +                  /* t_group[2..3] is used only to transfer GAMMA table */
> > +                  /* [2]: POST0, [3]: POST1 */
> > +                  writel(HWD_VIIF_VDM_CFG_PARAM,
> > +                         &res->capture_reg->vdm.t_group[(post_id +
> 2U)].VDM_T_CFG);
> > +                  base_addr = HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE +
> > +                                    (HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE *
> post_id);
> > +                  writel(base_addr, &res->capture_reg->vdm.t_group[(post_id +
> 2U)].VDM_T_SRAM_BASE);
> > +                  writel(HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE,
> > +                         &res->capture_reg->vdm.t_group[(post_id +
> 2U)].VDM_T_SRAM_SIZE);
> > +                  vdm_enable = vdm_enable << (12U + (post_id * 6U));
> > +    }
> > +    vdm_enable |= (readl(&res->capture_reg->vdm.VDM_T_ENABLE) &
> > +                         ~((u32)0x3fU << (12U + (post_id * 6U))));
> > +    writel(vdm_enable, &res->capture_reg->vdm.VDM_T_ENABLE);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_output_csc() - Set output CSC parameters of L2ISP
> > + *
> > + * @post_id: POST ID [0..1]
> > + * @param: Pointer to output csc parameters of L2ISP
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "post_id" is out of range
> > + * - [2] Member of "param" is invalid
> > + */
> > +s32 hwd_viif_l2_set_output_csc(struct hwd_viif_res *res, u32 post_id,
> > +                                       const struct hwd_viif_csc_param *param)
> > +{
> > +    struct hwd_viif_l2isp_post_reg *reg_l2isp_post;
> > +    u32 i, val;
> > +
> > +    if (post_id >= HWD_VIIF_MAX_POST_NUM)
> > +                  return -EINVAL;
> > +
> > +    /* disable csc matrix when param is NULL */
> > +    if (!param) {
> > +                  writel(HWD_VIIF_DISABLE,
> &res->capture_reg->l2isp.post[post_id].csc.MTB);
> > +                  return 0;
> > +    }
> > +
> > +    /* param is specified: go further check */
> > +    if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +        param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +        param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +        param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +        param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
> > +        param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    for (i = 0; i < HWD_VIIF_CSC_MAX_COEF_NUM; i++) {
> > +                  if (param->coef[i] > HWD_VIIF_CSC_MAX_COEF_VALUE)
> > +                                return -EINVAL;
> > +    }
> > +
> > +    reg_l2isp_post = &res->capture_reg->l2isp.post[post_id];
> > +
> > +    writel(param->g_y_in_offset,
> &reg_l2isp_post->csc.MTB_YG_OFFSETI);
> > +    writel(param->coef[0], &reg_l2isp_post->csc.MTB_YG1);
> > +    val = (param->coef[1] << HWD_VIIF_MTB_CB_YG_COEF_OFFSET) |
> > +          (param->coef[2] << HWD_VIIF_MTB_CR_YG_COEF_OFFSET);
> > +    writel(val, &reg_l2isp_post->csc.MTB_YG2);
> > +    writel(param->g_y_out_offset,
> &reg_l2isp_post->csc.MTB_YG_OFFSETO);
> > +    writel(param->b_cb_in_offset,
> &reg_l2isp_post->csc.MTB_CB_OFFSETI);
> > +    writel(param->coef[3], &reg_l2isp_post->csc.MTB_CB1);
> > +    val = (param->coef[4] << HWD_VIIF_MTB_CB_CB_COEF_OFFSET) |
> > +          (param->coef[5] << HWD_VIIF_MTB_CR_CB_COEF_OFFSET);
> > +    writel(val, &reg_l2isp_post->csc.MTB_CB2);
> > +    writel(param->b_cb_out_offset,
> &reg_l2isp_post->csc.MTB_CB_OFFSETO);
> > +    writel(param->r_cr_in_offset,
> &reg_l2isp_post->csc.MTB_CR_OFFSETI);
> > +    writel(param->coef[6], &reg_l2isp_post->csc.MTB_CR1);
> > +    val = (param->coef[7] << HWD_VIIF_MTB_CB_CR_COEF_OFFSET) |
> > +          (param->coef[8] << HWD_VIIF_MTB_CR_CR_COEF_OFFSET);
> > +    writel(val, &reg_l2isp_post->csc.MTB_CR2);
> > +    writel(param->r_cr_out_offset,
> &reg_l2isp_post->csc.MTB_CR_OFFSETO);
> > +    writel(HWD_VIIF_ENABLE, &reg_l2isp_post->csc.MTB);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_img_transmission() - Set image transfer condition of
> L2ISP
> > + *
> > + * @post_id: POST ID [0..1]
> > + * @enable: or disable image transfer of MAIN unit. For more refer @ref
> hwd_viif_enable_flag.
> > + * @src: Pointer to crop area information
> > + * @out_process: Pointer to output process information
> > + * @img: Pointer to output image information
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "post_id" or "enable" is out of range
> > + * - [2] "src" or "out_process" is NULL when "enable" is HWD_VIIF_ENABLE
> > + * - [3] "src" or "out_process" is not NULL when "enable" is
> HWD_VIIF_DISABLE
> > + * - [4] Member of "src" is out of range
> > + * - [5] "w" of "src" is not equal to 2 * "width" of "image"
> > + *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
> > + * - [6] "h" of "src" is not equal to 2 * "height" of "image"
> > + *   when "half_scal" of "out_process" is HWD_VIIF_ENABLE
> > + * - [7] "w" of "src" is not equal to "width" of "image"
> > + *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
> > + * - [8] "h" of "src" is not equal to "height" of "image"
> > + *   when "half_scal" of "out_process" is HWD_VIIF_DISABLE
> > + * - [9] Member of "out_process" is invalid
> > + * - [10] "alpha" of "out_process" is not 0 when "format" of "img" is not
> HWD_VIIF_ARGB8888_PACKED
> > + * - [11] "format" of "img" is not HWD_VIIF_ONE_COLOR_8 or
> HWD_VIIF_ONE_COLOR_16
> > + *   when "select_color" of "out_process"
> > + *   is HWD_VIIF_COLOR_Y_G, HWD_VIIF_COLOR_U_B or
> HWD_VIIF_COLOR_V_R
> > + * - [12] Member of "img" is invalid
> > + *
> > + * see also: #hwd_viif_l2_set_roi_path
> > + */
> > +s32 hwd_viif_l2_set_img_transmission(struct hwd_viif_res *res, u32 post_id,
> u32 enable,
> > +                                                   const struct hwd_viif_img_area *src,
> > +                                                   const struct hwd_viif_out_process
> *out_process,
> > +                                                   const struct hwd_viif_img *img)
> > +{
> > +    u32 pitch[HWD_VIIF_MAX_PLANE_NUM],
> img_start_addr[HWD_VIIF_MAX_PLANE_NUM];
> > +    u32 i, val, loop, k, r[HWD_VIIF_MAX_PLANE_NUM];
> > +    s32 ret = 0;
> > +
> > +    /* pitch alignment for planar or one color format */
> > +    u32 pitch_align = 128U;
> > +
> > +    if (post_id >= HWD_VIIF_MAX_POST_NUM ||
> > +        (enable != HWD_VIIF_ENABLE && enable != HWD_VIIF_DISABLE)
> ||
> > +        (enable == HWD_VIIF_ENABLE && (!src || !out_process)) ||
> > +        (enable == HWD_VIIF_DISABLE && (src || out_process))) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    /* DISABLE: no DMA transmission setup, set minimum crop rectangle
> */
> > +    if (enable == HWD_VIIF_DISABLE) {
> > +                  res->l2_roi_path_info.post_enable_flag[post_id] = false;
> > +                  res->l2_roi_path_info.post_crop_x[post_id] = 0U;
> > +                  res->l2_roi_path_info.post_crop_y[post_id] = 0U;
> > +                  res->l2_roi_path_info.post_crop_w[post_id] =
> HWD_VIIF_CROP_MIN_W;
> > +                  res->l2_roi_path_info.post_crop_h[post_id] =
> HWD_VIIF_CROP_MIN_H;
> > +                  hwd_viif_l2_set_roi_path(res);
> > +
> > +                  return 0;
> > +    }
> > +
> > +    /* further parameter check for ENABLE */
> > +    if (out_process->half_scale != HWD_VIIF_ENABLE &&
> > +        out_process->half_scale != HWD_VIIF_DISABLE) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (out_process->select_color != HWD_VIIF_COLOR_Y_G &&
> > +        out_process->select_color != HWD_VIIF_COLOR_U_B &&
> > +        out_process->select_color != HWD_VIIF_COLOR_V_R &&
> > +        out_process->select_color != HWD_VIIF_COLOR_YUV_RGB) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (img->format != HWD_VIIF_ARGB8888_PACKED &&
> out_process->alpha != 0U)
> > +                  return -EINVAL;
> > +
> > +    if (((img->width % 2U) != 0U) || ((img->height % 2U) != 0U) ||
> > +        img->width < HWD_VIIF_MIN_OUTPUT_IMG_WIDTH ||
> > +        img->height < HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT ||
> > +        img->width > HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP ||
> > +        img->height > HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (src->x > HWD_VIIF_CROP_MAX_X_ISP || src->y >
> HWD_VIIF_CROP_MAX_Y_ISP ||
> > +        src->w < HWD_VIIF_CROP_MIN_W || src->w >
> HWD_VIIF_CROP_MAX_W_ISP ||
> > +        src->h < HWD_VIIF_CROP_MIN_H || src->h >
> HWD_VIIF_CROP_MAX_H_ISP) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    if (out_process->half_scale == HWD_VIIF_ENABLE) {
> > +                  if ((src->w != (img->width * 2U)) || (src->h != (img->height *
> 2U)))
> > +                                return -EINVAL;
> > +    } else {
> > +                  if (src->w != img->width || src->h != img->height)
> > +                                return -EINVAL;
> > +    }
> > +
> > +    if (out_process->select_color == HWD_VIIF_COLOR_Y_G ||
> > +        out_process->select_color == HWD_VIIF_COLOR_U_B ||
> > +        out_process->select_color == HWD_VIIF_COLOR_V_R) {
> > +                  if (img->format != HWD_VIIF_ONE_COLOR_8 &&
> img->format != HWD_VIIF_ONE_COLOR_16)
> > +                                return -EINVAL;
> > +    }
> > +
> > +    /* build DMAC parameter */
> > +    switch (img->format) {
> > +    case HWD_VIIF_YCBCR422_8_PACKED:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  loop = 1U;
> > +                  k = 2U;
> > +                  r[0] = 1U;
> > +                  pitch_align = 256U;
> > +                  break;
> > +    case HWD_VIIF_RGB888_PACKED:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  loop = 1U;
> > +                  k = 3U;
> > +                  r[0] = 1U;
> > +                  pitch_align = 384U;
> > +                  break;
> > +    case HWD_VIIF_ARGB8888_PACKED:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  loop = 1U;
> > +                  k = 4U;
> > +                  r[0] = 1U;
> > +                  pitch_align = 512U;
> > +                  break;
> > +    case HWD_VIIF_ONE_COLOR_8:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  loop = 1U;
> > +                  k = 1U;
> > +                  r[0] = 1U;
> > +                  break;
> > +    case HWD_VIIF_ONE_COLOR_16:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  loop = 1U;
> > +                  k = 2U;
> > +                  r[0] = 1U;
> > +                  break;
> > +    case HWD_VIIF_YCBCR422_8_PLANAR:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> > +                  img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  pitch[1] = img->pixelmap[1].pitch;
> > +                  pitch[2] = img->pixelmap[2].pitch;
> > +                  loop = HWD_VIIF_MAX_PLANE_NUM;
> > +                  k = 1U;
> > +                  r[0] = 1U;
> > +                  r[1] = 2U;
> > +                  r[2] = 2U;
> > +                  break;
> > +    case HWD_VIIF_RGB888_YCBCR444_8_PLANAR:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> > +                  img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  pitch[1] = img->pixelmap[1].pitch;
> > +                  pitch[2] = img->pixelmap[2].pitch;
> > +                  loop = HWD_VIIF_MAX_PLANE_NUM;
> > +                  k = 1U;
> > +                  r[0] = 1U;
> > +                  r[1] = 1U;
> > +                  r[2] = 1U;
> > +                  break;
> > +    case HWD_VIIF_YCBCR422_16_PLANAR:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> > +                  img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  pitch[1] = img->pixelmap[1].pitch;
> > +                  pitch[2] = img->pixelmap[2].pitch;
> > +                  loop = HWD_VIIF_MAX_PLANE_NUM;
> > +                  k = 2U;
> > +                  r[0] = 1U;
> > +                  r[1] = 2U;
> > +                  r[2] = 2U;
> > +                  break;
> > +    case HWD_VIIF_RGB161616_YCBCR444_16_PLANAR:
> > +                  img_start_addr[0] = (u32)img->pixelmap[0].pmap_paddr;
> > +                  img_start_addr[1] = (u32)img->pixelmap[1].pmap_paddr;
> > +                  img_start_addr[2] = (u32)img->pixelmap[2].pmap_paddr;
> > +                  pitch[0] = img->pixelmap[0].pitch;
> > +                  pitch[1] = img->pixelmap[1].pitch;
> > +                  pitch[2] = img->pixelmap[2].pitch;
> > +                  loop = HWD_VIIF_MAX_PLANE_NUM;
> > +                  k = 2U;
> > +                  r[0] = 1U;
> > +                  r[1] = 1U;
> > +                  r[2] = 1U;
> > +                  break;
> > +    default:
> > +                  return -EINVAL;
> > +    }
> > +
> > +    for (i = 0; i < loop; i++) {
> > +                  val = max(((img->width * k) / r[i]), 128U);
> > +                  if (pitch[i] < val || pitch[i] > HWD_VIIF_MAX_PITCH_ISP ||
> > +                      ((pitch[i] % pitch_align) != 0U) || ((img_start_addr[i] %
> 4U) != 0U)) {
> > +                                return -EINVAL;
> > +                  }
> > +    }
> > +
> > +    writel(img_start_addr[0],
> &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_G);
> > +    writel(pitch[0],
> &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_G);
> > +    if (loop == HWD_VIIF_MAX_PLANE_NUM) {
> > +                  writel(img_start_addr[1],
> > +
> &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_B);
> > +                  writel(img_start_addr[2],
> > +
> &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_STADR_R);
> > +                  writel(pitch[1],
> &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_B);
> > +                  writel(pitch[2],
> &res->capture_reg->l2isp.post[post_id].L2_POST_OUT_PITCH_R);
> > +    }
> > +
> > +    /* Set CROP */
> > +    val = (src->y << 16U) | src->x;
> > +    writel(val,
> &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_OFFSET);
> > +    val = (src->h << 16U) | src->w;
> > +    writel(val,
> &res->capture_reg->l2isp.post[post_id].L2_POST_CAP_SIZE);
> > +
> > +    /* Set output process */
> > +    writel(out_process->half_scale,
> > +
> &res->capture_reg->l2isp.post[post_id].L2_POST_HALF_SCALE_EN);
> > +    writel(out_process->select_color,
> &res->capture_reg->l2isp.post[post_id].L2_POST_C_SELECT);
> > +    writel((u32)out_process->alpha,
> &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTALP);
> > +    writel(img->format,
> &res->capture_reg->l2isp.post[post_id].L2_POST_OPORTFMT);
> > +
> > +    /* Update ROI area and input to each POST */
> > +    res->l2_roi_path_info.post_enable_flag[post_id] = true;
> > +    res->l2_roi_path_info.post_crop_x[post_id] = src->x;
> > +    res->l2_roi_path_info.post_crop_y[post_id] = src->y;
> > +    res->l2_roi_path_info.post_crop_w[post_id] = src->w;
> > +    res->l2_roi_path_info.post_crop_h[post_id] = src->h;
> > +    hwd_viif_l2_set_roi_path(res);
> > +
> > +    return ret;
> > +}
> > +
> > +/**
> > + * hwd_viif_l2_set_irq_mask() - Set mask condition for L2ISP
> > + *
> > + * @mask: L2ISP mask condition
> > + * Return: None
> > + */
> > +void hwd_viif_l2_set_irq_mask(struct hwd_viif_res *res, u32 mask)
> > +{
> > +    writel(mask, &res->capture_reg->l2isp.L2_CRGBF_ISP_INT_MASK);
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_err_irq_handler() - CSI-2 RX error interruption handler
> > + *
> > + * Return: event information of CSI-2 RX error interruption
> > + */
> > +u32 hwd_viif_csi2rx_err_irq_handler(struct hwd_viif_res *res)
> > +{
> > +    return readl(&res->csi2host_reg->CSI2RX_INT_ST_MAIN);
> > +}
> > +
> > +/**
> > + * hwd_viif_status_err_irq_handler() - STATUS error interruption handler
> > + *
> > + * @event_main: information of STATUS error interruption of MAIN unit
> > + * @event_sub: information of STATUS error interruption of SUB unit(CH0
> and CH1)
> > + * Return: None
> > + */
> > +void hwd_viif_status_err_irq_handler(struct hwd_viif_res *res, u32
> *event_main, u32 *event_sub)
> > +{
> > +    u32 val, mask;
> > +
> > +    *event_main = HWD_VIIF_NO_EVENT;
> > +    *event_sub = HWD_VIIF_NO_EVENT;
> > +
> > +    val = readl(&res->capture_reg->sys.INT_M_STATUS);
> > +    mask = readl(&res->capture_reg->sys.INT_M_MASK);
> > +    val = val & ~mask;
> > +    if (val != HWD_VIIF_NO_EVENT) {
> > +                  writel(val, &res->capture_reg->sys.INT_M_STATUS);
> > +                  *event_main = val;
> > +    }
> > +
> > +    val = readl(&res->capture_reg->sys.INT_S_STATUS);
> > +    mask = readl(&res->capture_reg->sys.INT_S_MASK);
> > +    val = val & ~mask;
> > +    if (val != HWD_VIIF_NO_EVENT) {
> > +                  writel(val, &res->capture_reg->sys.INT_S_STATUS);
> > +                  *event_sub = val;
> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_vsync_irq_handler() - Vsync interruption handler
> > + *
> > + * @event_main: information of Vsync interruption of MAIN unit
> > + * @event_sub: information of Vsync interruption of SUB unit(CH0 and CH1)
> > + * Return: None
> > + */
> > +void hwd_viif_vsync_irq_handler(struct hwd_viif_res *res, u32 *event_main,
> u32 *event_sub)
> > +{
> > +    u32 val, mask;
> > +
> > +    *event_main = HWD_VIIF_NO_EVENT;
> > +    *event_sub = HWD_VIIF_NO_EVENT;
> > +
> > +    val = readl(&res->capture_reg->sys.INT_M_SYNC);
> > +    mask = readl(&res->capture_reg->sys.INT_M_SYNC_MASK);
> > +    val = val & ~mask;
> > +    if (val != HWD_VIIF_NO_EVENT) {
> > +                  writel(val, &res->capture_reg->sys.INT_M_SYNC);
> > +                  *event_main = val;
> > +    }
> > +
> > +    val = readl(&res->capture_reg->sys.INT_S_SYNC);
> > +    mask = readl(&res->capture_reg->sys.INT_S_SYNC_MASK);
> > +    val = val & ~mask;
> > +    if (val != HWD_VIIF_NO_EVENT) {
> > +                  writel(val, &res->capture_reg->sys.INT_S_SYNC);
> > +                  *event_sub = val;
> > +    }
> > +}
> > +
> > +/**
> > + * hwd_viif_isp_regbuf_irq_handler() - ISP register buffer interruption
> handler
> > + *
> > + * @event_l1: information of register buffer interruption of L1ISP
> > + * @event_l2: information of register buffer interruption of L2ISP
> > + * Return: None
> > + */
> > +void hwd_viif_isp_regbuf_irq_handler(struct hwd_viif_res *res, u32 *event_l1,
> u32 *event_l2)
> > +{
> > +    u32 val;
> > +
> > +    *event_l1 = HWD_VIIF_NO_EVENT;
> > +    *event_l2 = HWD_VIIF_NO_EVENT;
> > +
> > +    val =
> readl(&res->capture_reg->l1isp.L1_CRGBF_INT_MASKED_STAT);
> > +    if (val != HWD_VIIF_NO_EVENT) {
> > +                  *event_l1 = val;
> > +                  writel(val, &res->capture_reg->l1isp.L1_CRGBF_INT_STAT);
> > +    }
> > +
> > +    val =
> readl(&res->capture_reg->l2isp.L2_CRGBF_INT_MASKED_STAT);
> > +    if (val != HWD_VIIF_NO_EVENT) {
> > +                  *event_l2 = val;
> > +                  writel(val, &res->capture_reg->l2isp.L2_CRGBF_INT_STAT);
> > +    }
> > +}
> > diff --git a/drivers/media/platform/visconti/hwd_viif.h
> b/drivers/media/platform/visconti/hwd_viif.h
> > new file mode 100644
> > index 00000000000..100afda8436
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/hwd_viif.h
> > @@ -0,0 +1,710 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> > +/* Toshiba Visconti Video Capture Support
> > + *
> > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> > + */
> > +
> > +#ifndef HWD_VIIF_H
> > +#define HWD_VIIF_H
> > +
> > +#include <linux/errno.h>
> > +#include <linux/types.h>
> > +
> > +#include <linux/visconti_viif.h>
> > +
> > +enum hwd_power_ctrl {
> > +    HWD_POWER_OFF = 0, /**< Power off */
> > +    HWD_POWER_ON /**< Power on  */
> > +};
> > +
> > +/* MIPI CSI2 Data Types */
> > +#define VISCONTI_CSI2_DT_YUV4228B  0x1E
> > +#define VISCONTI_CSI2_DT_YUV42210B 0x1F
> > +#define VISCONTI_CSI2_DT_RGB565              0x22
> > +#define VISCONTI_CSI2_DT_RGB888              0x24
> > +#define VISCONTI_CSI2_DT_RAW8    0x2A
> > +#define VISCONTI_CSI2_DT_RAW10                0x2B
> > +#define VISCONTI_CSI2_DT_RAW12                0x2C
> > +#define VISCONTI_CSI2_DT_RAW14                0x2D
> 
> Please use the definitions in media/mipi-csi2.h .

I'll use definitions in mipi-csi2.h .

> > +
> > +/* hwd_viif_enable_flag */
> > +#define HWD_VIIF_DISABLE (0U)
> > +#define HWD_VIIF_ENABLE             (1U)
> > +
> > +/* hwd_viif_memory_sync_type */
> > +#define HWD_VIIF_MEM_SYNC_INTERNAL (0U)
> > +#define HWD_VIIF_MEM_SYNC_CSI2              (1U)
> > +
> > +/* hwd_viif_color_format */
> > +#define HWD_VIIF_YCBCR422_8_PACKED         (0U)
> > +#define HWD_VIIF_RGB888_PACKED                               (1U)
> > +#define HWD_VIIF_ARGB8888_PACKED             (3U)
> > +#define HWD_VIIF_YCBCR422_8_PLANAR         (8U)
> > +#define HWD_VIIF_RGB888_YCBCR444_8_PLANAR     (9U)
> > +#define HWD_VIIF_ONE_COLOR_8                      (11U)
> > +#define HWD_VIIF_YCBCR422_16_PLANAR       (12U)
> > +#define HWD_VIIF_RGB161616_YCBCR444_16_PLANAR (13U)
> > +#define HWD_VIIF_ONE_COLOR_16                                  (15U)
> > +
> > +/* hwd_viif_raw_pack_mode */
> > +#define HWD_VIIF_RAWPACK_DISABLE  (0U)
> > +#define HWD_VIIF_RAWPACK_MSBFIRST (2U)
> > +#define HWD_VIIF_RAWPACK_LSBFIRST (3U)
> > +
> > +/* hwd_viif_yuv_conversion_mode */
> > +#define HWD_VIIF_YUV_CONV_REPEAT      (0U)
> > +#define HWD_VIIF_YUV_CONV_INTERPOLATION (1U)
> > +
> > +/* hwd_viif_gamma_table_mode */
> > +#define HWD_VIIF_GAMMA_COMPRESSED (0U)
> > +#define HWD_VIIF_GAMMA_LINEAR               (1U)
> > +
> > +/* hwd_viif_output_color_mode */
> > +#define HWD_VIIF_COLOR_Y_G     (0U)
> > +#define HWD_VIIF_COLOR_U_B     (1U)
> > +#define HWD_VIIF_COLOR_V_R     (2U)
> > +#define HWD_VIIF_COLOR_YUV_RGB (4U)
> > +
> > +/* hwd_viif_hw_params */
> > +#define HWD_VIIF_MAX_CH                   (6U)
> > +#define HWD_VIIF_MAX_PLANE_NUM (3U)
> > +
> > +/**
> > + * enum hwd_viif_csi2_dphy - D-PHY Lane assignment
> > + *
> > + * specifies which line(L0-L3) is assigned to D0-D3
> > + */
> > +enum hwd_viif_csi2_dphy {
> > +    HWD_VIIF_CSI2_DPHY_L0L1L2L3 = 0U,
> > +    HWD_VIIF_CSI2_DPHY_L0L3L1L2 = 1U,
> > +    HWD_VIIF_CSI2_DPHY_L0L2L3L1 = 2U,
> > +    HWD_VIIF_CSI2_DPHY_L0L1L3L2 = 4U,
> > +    HWD_VIIF_CSI2_DPHY_L0L3L2L1 = 5U,
> > +    HWD_VIIF_CSI2_DPHY_L0L2L1L3 = 6U
> > +};
> > +
> > +/* hwd_viif_csi2rx_cal_status */
> > +#define HWD_VIIF_CSI2_CAL_NOT_DONE (0U)
> > +#define HWD_VIIF_CSI2_CAL_SUCCESS  (1U)
> > +#define HWD_VIIF_CSI2_CAL_FAIL    (2U)
> > +
> > +/* hwd_viif_csi2rx_not_capture */
> > +#define HWD_VIIF_CSI2_NOT_CAPTURE (-1) /**< csi2 not capture */
> > +
> > +/* hwd_viif_l1_input_mode */
> > +#define HWD_VIIF_L1_INPUT_HDR                               (0U)
> > +#define HWD_VIIF_L1_INPUT_PWL                              (1U)
> > +#define HWD_VIIF_L1_INPUT_SDR                 (2U)
> > +#define HWD_VIIF_L1_INPUT_HDR_IMG_CORRECT (3U)
> > +#define HWD_VIIF_L1_INPUT_PWL_IMG_CORRECT (4U)
> > +
> > +/* hwd_viif_l1_raw_color_filter_mode */
> > +#define HWD_VIIF_L1_RAW_GR_R_B_GB (0U)
> > +#define HWD_VIIF_L1_RAW_R_GR_GB_B (1U)
> > +#define HWD_VIIF_L1_RAW_B_GB_GR_R (2U)
> > +#define HWD_VIIF_L1_RAW_GB_B_R_GR (3U)
> > +
> > +/* hwd_viif_l1_input_interpolation_mode */
> > +#define HWD_VIIF_L1_INPUT_INTERPOLATION_LINE  (0U)
> > +#define HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL (1U)
> > +
> > +/* hwd_viif_l1_img_sens */
> > +#define HWD_VIIF_L1_IMG_SENSITIVITY_HIGH       (0U)
> > +#define HWD_VIIF_L1_IMG_SENSITIVITY_MIDDLE_LED (1U)
> > +#define HWD_VIIF_L1_IMG_SENSITIVITY_LOW                (2U)
> > +
> > +/* hwd_viif_l1_dpc */
> > +#define HWD_VIIF_L1_DPC_1PIXEL (0U)
> > +#define HWD_VIIF_L1_DPC_2PIXEL (1U)
> > +
> > +/* hwd_viif_l1_rcnr_hry_type */
> > +#define HWD_VIIF_L1_RCNR_LOW_RESOLUTION           (0U)
> > +#define HWD_VIIF_L1_RCNR_MIDDLE_RESOLUTION     (1U)
> > +#define HWD_VIIF_L1_RCNR_HIGH_RESOLUTION       (2U)
> > +#define HWD_VIIF_L1_RCNR_ULTRA_HIGH_RESOLUTION (3U)
> > +
> > +/* hwd_viif_l1_rcnr_msf_blend_ratio */
> > +#define HWD_VIIF_L1_MSF_BLEND_RATIO_0_DIV_64 (0U)
> > +#define HWD_VIIF_L1_MSF_BLEND_RATIO_1_DIV_64 (1U)
> > +#define HWD_VIIF_L1_MSF_BLEND_RATIO_2_DIV_64 (2U)
> > +
> > +/* hwd_viif_l1_hdrs */
> > +#define HWD_VIIF_L1_HDRS_NOT_USE_MIDDLE_SENS_IMAGE (0U)
> > +#define HWD_VIIF_L1_HDRS_USE_MIDDLE_SENS_IMAGE      (1U)
> > +
> > +/* hwd_viif_l1_lsc_para_mag */
> > +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_EIGHTH (0U)
> > +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FOURTH (1U)
> > +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_SECOND (2U)
> > +#define HWD_VIIF_L1_PARA_COEF_GAIN_ONE_FIRST  (3U)
> > +
> > +/* hwd_viif_l1_lsc_grid_mag */
> > +#define HWD_VIIF_L1_GRID_COEF_GAIN_X1 (0U)
> > +#define HWD_VIIF_L1_GRID_COEF_GAIN_X2 (1U)
> > +
> > +/* hwd_viif_l1_demosaic */
> > +#define HWD_VIIF_L1_DEMOSAIC_ACPI (0U)
> > +#define HWD_VIIF_L1_DEMOSAIC_DMG  (1U)
> > +
> > +/* hwd_viif_l1_awb_restart_cond */
> > +/* macros for L1ISP condition to restart auto white balance */
> > +#define HWD_VIIF_L1_AWB_RESTART_NO  (0U)
> > +#define HWD_VIIF_L1_AWB_RESTART_128FRAME (1U)
> > +#define HWD_VIIF_L1_AWB_RESTART_64FRAME     (2U)
> > +#define HWD_VIIF_L1_AWB_RESTART_32FRAME     (3U)
> > +#define HWD_VIIF_L1_AWB_RESTART_16FRAME     (4U)
> > +#define HWD_VIIF_L1_AWB_RESTART_8FRAME       (5U)
> > +#define HWD_VIIF_L1_AWB_RESTART_4FRAME       (6U)
> > +#define HWD_VIIF_L1_AWB_RESTART_2FRAME       (7U)
> > +
> > +/* hwd_viif_l1_awb_mag */
> > +#define HWD_VIIF_L1_AWB_ONE_SECOND (0U)
> > +#define HWD_VIIF_L1_AWB_X1          (1U)
> > +#define HWD_VIIF_L1_AWB_X2          (2U)
> > +#define HWD_VIIF_L1_AWB_X4          (3U)
> > +
> > +/* hwd_viif_l1_awb_area_mode */
> > +#define HWD_VIIF_L1_AWB_AREA_MODE0 (0U)
> > +#define HWD_VIIF_L1_AWB_AREA_MODE1 (1U)
> > +#define HWD_VIIF_L1_AWB_AREA_MODE2 (2U)
> > +#define HWD_VIIF_L1_AWB_AREA_MODE3 (3U)
> > +
> > +/* hwd_viif_l1_hdrc_tone_type */
> > +#define HWD_VIIF_L1_HDRC_TONE_USER   (0U)
> > +#define HWD_VIIF_L1_HDRC_TONE_PRESET (1U)
> > +
> > +/* hwd_viif_l1_bin_mode */
> > +#define HWD_VIIF_L1_HIST_BIN_MODE_LINEAR (0U)
> > +#define HWD_VIIF_L1_HIST_BIN_MODE_LOG           (1U)
> > +
> > +/* hwd_viif_l2_undist_mode */
> > +#define HWD_VIIF_L2_UNDIST_POLY                         (0U)
> > +#define HWD_VIIF_L2_UNDIST_GRID                         (1U)
> > +#define HWD_VIIF_L2_UNDIST_POLY_TO_GRID (2U)
> > +#define HWD_VIIF_L2_UNDIST_GRID_TO_POLY (3U)
> > +
> > +/**
> > + * struct hwd_viif_csi2rx_line_err_target
> > + *
> > + * Virtual Channel and Data Type pair for CSI2RX line error monitor
> > + *
> > + * When 0 is set to dt, line error detection is disabled.
> > + *
> > + * * VC can be 0 .. 3
> > + * * DT can be 0 or 0x10 .. 0x3F
> > + */
> > +#define VISCONTI_CSI2_ERROR_MONITORS_NUM 8
> > +struct hwd_viif_csi2rx_line_err_target {
> > +    u32 vc[VISCONTI_CSI2_ERROR_MONITORS_NUM];
> > +    u32 dt[VISCONTI_CSI2_ERROR_MONITORS_NUM];
> > +};
> > +
> > +/**
> > + * struct hwd_viif_csi2rx_irq_mask
> > + * @mask: mask setting for CSI2RX error interruption
> > + *
> > + * * mask[0]: D-PHY fatal error
> > + * * mask[1]: Packet fatal error
> > + * * mask[2]: Frame fatal error
> > + * * mask[3]: D-PHY error
> > + * * mask[4]: Packet error
> > + * * mask[5]: Line error
> > + */
> > +#define VISCONTI_CSI2RX_IRQ_MASKS_NUM                6
> > +#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_FATAL   0
> > +#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_FATAL 1
> > +#define VISCONTI_CSI2RX_IRQ_MASK_FRAME_FATAL  2
> > +#define VISCONTI_CSI2RX_IRQ_MASK_DPHY_ERROR   3
> > +#define VISCONTI_CSI2RX_IRQ_MASK_PACKET_ERROR 4
> > +#define VISCONTI_CSI2RX_IRQ_MASK_LINE_ERROR   5
> > +struct hwd_viif_csi2rx_irq_mask {
> > +    u32 mask[VISCONTI_CSI2RX_IRQ_MASKS_NUM];
> > +};
> > +
> > +/**
> > + * struct hwd_viif_csi2rx_packet - CSI2 packet information
> > + * @word_count: word count included in one packet[byte] [0..16384]
> > + * @packet_num: the number of packet included in one packet [0..8192]
> > + *
> > + * each element means as below.
> > + * * [0]: embedded data of MAIN unit
> > + * * [1]: long packet data of MAIN unit
> > + * * [2]: embedded data of SUB unit
> > + * * [3]: long packet data of SUB unit
> > + *
> > + * Regarding word_count of long packet data,
> > + * word count of odd line needs to be set in case of DT = 0x18, 0x19, 0x1C or
> 0x1D.
> > + */
> > +#define VISCONTI_CSI2RX_PACKET_TYPES_NUM      4
> > +#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN  0
> > +#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN 1
> > +#define VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB   2
> > +#define VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB  3
> > +struct hwd_viif_csi2rx_packet {
> > +    u32 word_count[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
> > +    u32 packet_num[VISCONTI_CSI2RX_PACKET_TYPES_NUM];
> > +};
> > +
> > +/**
> > + * struct hwd_viif_pixelmap - pixelmap information
> > + * @pmap_paddr: start address of pixel data(physical address). 4byte
> alignment.
> > + * @pitch: pitch size of pixel map[byte]
> > + *
> > + * Condition of pitch in case of L2ISP output is as below.
> > + * * max: 32704[byte]
> > + * * min: the larger value of (active width of image * k / r) and 128[byte]
> > + * * alignment: 64[byte]
> > + *
> > + * Condition of pitch in the other cases is as below.
> > + * * max: 65536[byte]
> > + * * min: active width of image * k / r[byte]
> > + * * alignment: 4[byte]
> > + *
> > + * k is the size of 1 pixel and the value is as below.
> > + * * HWD_VIIF_YCBCR422_8_PACKED: 2
> > + * * HWD_VIIF_RGB888_PACKED: 3
> > + * * HWD_VIIF_ARGB8888_PACKED: 4
> > + * * HWD_VIIF_YCBCR422_8_PLANAR: 1
> > + * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR: 1
> > + * * HWD_VIIF_ONE_COLOR_8: 1
> > + * * HWD_VIIF_YCBCR422_16_PLANAR: 2
> > + * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR: 2
> > + * * HWD_VIIF_ONE_COLOR_16: 2
> > + *
> > + * r is the correction factor for Cb or Cr of YCbCr422 planar and the value is
> as below.
> > + * * YCbCr422 Cb-planar: 2
> > + * * YCbCr422 Cr-planar: 2
> > + * * others: 1
> > + *
> > + */
> > +struct hwd_viif_pixelmap {
> > +    uintptr_t pmap_paddr;
> > +    u32 pitch;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_img - image information
> > + * @width: active width of image[pixel]
> > + * * [128..5760](output from L2ISP)
> > + * * [128..4096](input to MAIN unit(memory input))
> > + * * [128..4096](output from SUB unit)
> > + * * The value should be even.
> > + *
> > + * @height: active height of image[line]
> > + * * [128..3240](output from L2ISP)
> > + * * [128..2160](input to MAIN unit(memory input))
> > + * * [128..2160](output from SUB unit)
> > + * * The value should be even.
> > + *
> > + * @format: hwd_viif_color_format "color format"
> > + * * Below color formats are supported for input and output of MAIN unit
> > + * * HWD_VIIF_YCBCR422_8_PACKED
> > + * * HWD_VIIF_RGB888_PACKED
> > + * * HWD_VIIF_ARGB8888_PACKED
> > + * * HWD_VIIF_YCBCR422_8_PLANAR
> > + * * HWD_VIIF_RGB888_YCBCR444_8_PLANAR
> > + * * HWD_VIIF_ONE_COLOR_8
> > + * * HWD_VIIF_YCBCR422_16_PLANAR
> > + * * HWD_VIIF_RGB161616_YCBCR444_16_PLANAR
> > + * * HWD_VIIF_ONE_COLOR_16
> > + * * Below color formats are supported for output of SUB unit
> > + * * HWD_VIIF_ONE_COLOR_8
> > + * * HWD_VIIF_ONE_COLOR_16
> > + *
> > + * @pixelmap: pixelmap information
> > + * * [0]: Y/G-planar, packed/Y/RAW
> > + * * [1]: Cb/B-planar
> > + * * [2]: Cr/R-planar
> > + */
> > +struct hwd_viif_img {
> > +    u32 width;
> > +    u32 height;
> > +    u32 format;
> > +    struct hwd_viif_pixelmap pixelmap[3];
> > +};
> > +
> > +/**
> > + * struct hwd_viif_input_img - input image information
> > + * @pixel_clock: pixel clock [3375..600000] [kHz]. 0 needs to be set for long
> packet data.
> > + * @htotal_size: horizontal total size
> > + * * [143..65535] [pixel] for image data
> > + * * [239..109225] [ns] for long packet data
> > + * @hactive_size: horizontal active size [pixel]
> > + * * [128..4096] without L1ISP
> > + * * [640..3840] with L1ISP
> > + * * The value should be even. In addition, the value should be a multiple of 8
> with L1ISP
> > + * * 0 needs to be set for the configuration of long packet data or SUB unit
> output.
> > + * @vtotal_size: vertical total size [line]
> > + * * [144..16383] for image data
> > + * * 0 needs to be set for the configuration of long packet data.
> > + * @vbp_size: vertical back porch size
> > + * * [5..4095] [line] for image data
> > + * * [5..4095] [the number of packet] for long packet data
> > + * @vactive_size: vertical active size [line]
> > + * * [128..2160] without L1ISP
> > + * * [480..2160] with L1ISP
> > + * * The value should be even.
> > + * * 0 needs to be set for the configuration of long packet data.
> > + * @interpolation_mode: input image interpolation mode for
> hwd_viif_l1_input_interpolation_mode
> > + * * HWD_VIIF_L1_INPUT_INTERPOLATION_LINE needs to be set in the
> below cases.
> > + * * image data(without L1ISP) or long packet data
> > + * * image data or long packet data of SUB unit
> > + * @input_num: the number of input images [1..3]
> > + * * 1 needs to be set in the below cases.
> > + * * image data(without L1ISP) or long packet data
> > + * * image data or long packet data of SUB unit
> > + * @hobc_width: the number of horizontal optical black pixels [0,16,32,64 or
> 128]
> > + * * 0 needs to be set in the below cases.
> > + * * in case of hobc_margin = 0
> > + * * image data(without L1ISP) or long packet data
> > + * * image data or long packet data of SUB unit
> > + * @hobc_margin: the number of horizontal optical black margin[0..30] (even
> number)
> > + * * 0 needs to be set in the below cases.
> > + * * in case of hobc_width = 0
> > + * * image data(without L1ISP) or long packet data
> > + * * image data or long packet data of SUB unit
> > + *
> > + * Below conditions need to be satisfied.
> > + * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_LINE:
> > + *   (htotal_size > (hactive_size + hobc_width + hobc_margin)) &&
> > + *   (vtotal_size > (vbp_size + vactive_size * input_num))
> > + * * interpolation_mode is HWD_VIIF_L1_INPUT_INTERPOLATION_PIXEL:
> > + *   (htotal_size > ((hactive_size + hobc_width + hobc_margin) *
> input_num)) &&
> > + *   (vtotal_size > (vbp_size + vactive_size))
> > + * * L1ISP is used:
> > + *   vbp_size >= (54720[cycle] / 500000[kHz]) * (pixel_clock / htotal_size)
> + 38 + ISST time
> > + * * L1ISP is not used:
> > + *   vbp_size >= (39360[cycle] / 500000[kHz]) * (pixel_clock / htotal_size)
> + 16 + ISST time
> > + *
> > + * Note: L1ISP is used when RAW data is input to MAIN unit
> > + */
> > +struct hwd_viif_input_img {
> > +    u32 pixel_clock;
> > +    u32 htotal_size;
> > +    u32 hactive_size;
> > +    u32 vtotal_size;
> > +    u32 vbp_size;
> > +    u32 vactive_size;
> > +    u32 interpolation_mode;
> > +    u32 input_num;
> > +    u32 hobc_width;
> > +    u32 hobc_margin;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_csc_param - color conversion information
> > + * @r_cr_in_offset: input offset of R/Cr[pix value] [0x0..0x1FFFF]
> > + * @g_y_in_offset: input offset of G/Y[pix value] [0x0..0x1FFFF]
> > + * @b_cb_in_offset: input offset of B/Cb[pix value] [0x0..0x1FFFF]
> > + * @coef: coefficient of matrix [0x0..0xFFFF]
> > + * * [0] : c00(YG_YG), [1] : c01(UB_YG), [2] : c02(VR_YG),
> > + * * [3] : c10(YG_UB), [4] : c11(UB_UB), [5] : c12(VR_UB),
> > + * * [6] : c20(YG_VR), [7] : c21(UB_VR), [8] : c22(VR_VR)
> > + * @r_cr_out_offset: output offset of R/Cr[pix value] [0x0..0x1FFFF]
> > + * @g_y_out_offset: output offset of G/Y[pix value] [0x0..0x1FFFF]
> > + * @b_cb_out_offset: output offset of B/Cb[pix value] [0x0..0x1FFFF]
> > + */
> > +struct hwd_viif_csc_param {
> > +    u32 r_cr_in_offset;
> > +    u32 g_y_in_offset;
> > +    u32 b_cb_in_offset;
> > +    u32 coef[9];
> > +    u32 r_cr_out_offset;
> > +    u32 g_y_out_offset;
> > +    u32 b_cb_out_offset;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_img_area - image area definition
> > + * @x: x position [0..8062] [pixel]
> > + * @y: y position [0..3966] [line]
> > + * @w: image width [128..8190] [pixel]
> > + * @h: image height [128..4094] [line]
> > + */
> > +struct hwd_viif_img_area {
> > +    u32 x;
> > +    u32 y;
> > +    u32 w;
> > +    u32 h;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_out_process - configuration of output process of MAIN unit
> and L2ISP
> > + * @half_scale: hwd_viif_enable_flag "enable or disable half scale"
> > + * @select_color: hwd_viif_output_color_mode "select output color"
> > + * @alpha: alpha value used in case of ARGB8888 output [0..255]
> > + */
> > +struct hwd_viif_out_process {
> > +    u32 half_scale;
> > +    u32 select_color;
> > +    u8 alpha;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_l1_lsc - HWD L1ISP lens shading correction parameters
> > + * @lssc_parabola_param: parabola shading correction parameter
> > + * * NULL: disable parabola shading correction
> > + * * not NULL: enable parabola shading correction
> > + * @lssc_grid_param: grid shading correction parameter
> > + * * NULL: disable grid shading correction
> > + * * not NULL: enable grid shading correction
> > + * @lssc_pwhb_r_gain_max: maximum R gain of preset white balance
> correction
> > + * @lssc_pwhb_r_gain_min: minimum R gain of preset white balance
> correction
> > + * @lssc_pwhb_gr_gain_max: maximum Gr gain of preset white balance
> correction
> > + * @lssc_pwhb_gr_gain_min: minimum Gr gain of preset white balance
> correction
> > + * @lssc_pwhb_gb_gain_max: maximum Gb gain of preset white balance
> correction
> > + * @lssc_pwhb_gb_gain_min: minimum Gb gain of preset white balance
> correction
> > + * @lssc_pwhb_b_gain_max: maximum B gain of preset white balance
> correction
> > + * @lssc_pwhb_b_gain_min: minimum B gain of preset white balance
> correction
> > + *
> > + * Range and accuracy of lssc_pwhb_xxx_gain_xxx are as below.
> > + * - range: [0x0..0x7FF]
> > + * - accuracy : 1/256
> > + */
> > +struct hwd_viif_l1_lsc {
> > +    struct viif_l1_lsc_parabola_param *lssc_parabola_param;
> > +    struct viif_l1_lsc_grid_param *lssc_grid_param;
> > +    u32 lssc_pwhb_r_gain_max;
> > +    u32 lssc_pwhb_r_gain_min;
> > +    u32 lssc_pwhb_gr_gain_max;
> > +    u32 lssc_pwhb_gr_gain_min;
> > +    u32 lssc_pwhb_gb_gain_max;
> > +    u32 lssc_pwhb_gb_gain_min;
> > +    u32 lssc_pwhb_b_gain_max;
> > +    u32 lssc_pwhb_b_gain_min;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_l1_img_quality_adjustment - HWD L1ISP image quality
> adjustment parameters
> > + * @coef_cb: Cb coefficient [0x0..0xffff] accuracy: 1/65536
> > + * @coef_cr: Cr coefficient [0x0..0xffff] accuracy: 1/65536
> > + * @brightness: brightness value [-32768..32767] (0 means off.)
> > + * @linear_contrast: linear contrast value [0x0..0xff] accuracy: 1/128 (128
> means off.)
> > + * @*nonlinear_contrast: pointer to nonlinear contrast parameter
> > + * @*lum_noise_reduction: pointer to luminance noise reduction parameter
> > + * @*edge_enhancement: pointer to edge enhancement parameter
> > + * @*uv_suppression: pointer to UV suppression parameter
> > + * @*coring_suppression: pointer to coring suppression parameter
> > + * @*edge_suppression: pointer to edge enhancement parameter
> > + * @*color_level: pointer to color level adjustment parameter
> > + * @color_noise_reduction_enable: enable/disable color noise reduction @ref
> hwd_viif_enable_flag
> > + */
> > +struct hwd_viif_l1_img_quality_adjustment {
> > +    u16 coef_cb;
> > +    u16 coef_cr;
> > +    s16 brightness;
> > +    u8 linear_contrast;
> > +    struct viif_l1_nonlinear_contrast *nonlinear_contrast;
> > +    struct viif_l1_lum_noise_reduction *lum_noise_reduction;
> > +    struct viif_l1_edge_enhancement *edge_enhancement;
> > +    struct viif_l1_uv_suppression *uv_suppression;
> > +    struct viif_l1_coring_suppression *coring_suppression;
> > +    struct viif_l1_edge_suppression *edge_suppression;
> > +    struct viif_l1_color_level *color_level;
> > +    u32 color_noise_reduction_enable;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_l1_info - HWD L1ISP processing information
> > + * @context_id: context id
> > + * @ag_cont_hobc_high: analog gain for high sensitivity image of OBCC
> > + * @ag_cont_hobc_middle_led: analog gain for middle sensitivity or led image
> of OBCC
> > + * @ag_cont_hobc_low: analog gain for low sensitivity image of OBCC
> > + * @ag_cont_abpc_high: analog gain for high sensitivity image of ABPC
> > + * @ag_cont_abpc_middle_led: analog gain for middle sensitivity or led image
> of ABPC
> > + * @ag_cont_abpc_low: analog gain for low sensitivity image of ABPC
> > + * @ag_cont_rcnr_high: analog gain for high sensitivity image of RCNR
> > + * @ag_cont_rcnr_middle_led: analog gain for middle sensitivity or led image
> of RCNR
> > + * @ag_cont_rcnr_low: analog gain for low sensitivity image of RCNR
> > + * @ag_cont_lssc: analog gain for LSSC
> > + * @ag_cont_mpro: analog gain for color matrix correction
> > + * @ag_cont_vpro: analog gain for image quality adjustment
> > + * @dpc_defect_num_h:
> > + *     the number of dynamically corrected defective pixel(high sensitivity
> image)
> > + * @dpc_defect_num_m:
> > + *     the number of dynamically corrected defective pixel(middle
> sensitivity or led image)
> > + * @dpc_defect_num_l:
> > + *     the number of dynamically corrected defective pixel(low sensitivity
> image)
> > + * @hdrc_tnp_fb_smth_max: the maximum value of luminance information
> after smoothing filter at HDRC
> > + * @avg_lum_weight: weighted average luminance value at average
> luminance generation
> > + * @avg_lum_block[8][8]:
> > + *     average luminance of each block [y][x]:
> > + *     y means vertical position and x means horizontal position.
> > + * @avg_lum_four_line_lum[4]:
> > + *     4-lines average luminance. avg_lum_four_line_lum[n] corresponds to
> aexp_ave4linesy[n]
> > + * @avg_satur_pixnum: the number of saturated pixel at average luminance
> generation
> > + * @avg_black_pixnum: the number of black pixel at average luminance
> generation
> > + * @awb_ave_u: average U at AWHB [pixel]
> > + * @awb_ave_v: average V at AWHB [pixel]
> > + * @awb_accumulated_pixel: the number of accumulated pixel at AWHB
> > + * @awb_gain_r: R gain applied in the next frame at AWHB
> > + * @awb_gain_g: G gain applied in the next frame at AWHB
> > + * @awb_gain_b: B gain applied in the next frame at AWHB
> > + * @awb_status_u: status of U convergence at AWHB (true: converged, false:
> not converged)
> > + * @awb_status_v: status of V convergence at AWHB (true: converged, false:
> not converged)
> > + */
> > +struct hwd_viif_l1_info {
> > +    u32 context_id;
> > +    u8 ag_cont_hobc_high;
> > +    u8 ag_cont_hobc_middle_led;
> > +    u8 ag_cont_hobc_low;
> > +    u8 ag_cont_abpc_high;
> > +    u8 ag_cont_abpc_middle_led;
> > +    u8 ag_cont_abpc_low;
> > +    u8 ag_cont_rcnr_high;
> > +    u8 ag_cont_rcnr_middle_led;
> > +    u8 ag_cont_rcnr_low;
> > +    u8 ag_cont_lssc;
> > +    u8 ag_cont_mpro;
> > +    u8 ag_cont_vpro;
> > +    u32 dpc_defect_num_h;
> > +    u32 dpc_defect_num_m;
> > +    u32 dpc_defect_num_l;
> > +    u32 hdrc_tnp_fb_smth_max;
> > +    u32 avg_lum_weight;
> > +    u32 avg_lum_block[8][8];
> > +    u32 avg_lum_four_line_lum[4];
> > +    u16 avg_satur_pixnum;
> > +    u16 avg_black_pixnum;
> > +    u32 awb_ave_u;
> > +    u32 awb_ave_v;
> > +    u32 awb_accumulated_pixel;
> > +    u32 awb_gain_r;
> > +    u32 awb_gain_g;
> > +    u32 awb_gain_b;
> > +    bool awb_status_u;
> > +    bool awb_status_v;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_l2_gamma_table - HWD L2ISP Gamma table physical
> address
> > + * @table[6]: table address(physical address) 4byte alignment
> > + *
> > + * relation between element and table is as below.
> > + * * [0]: G/Y(1st table)
> > + * * [1]: G/Y(2nd table)
> > + * * [2]: B/U(1st table)
> > + * * [3]: B/U(2nd table)
> > + * * [4]: R/V(1st table)
> > + * * [5]: R/V(2nd table)
> > + *
> > + * when 0 is set to table address, table transfer is disabled.
> > + */
> > +struct hwd_viif_l2_gamma_table {
> > +    uintptr_t table[6];
> > +};
> > +
> > +struct hwd_viif_res;
> > +
> > +/* VIIF common */
> > +u32 hwd_viif_csi2rx_err_irq_handler(struct hwd_viif_res *res);
> > +void hwd_viif_status_err_irq_handler(struct hwd_viif_res *res, u32
> *event_main, u32 *event_sub);
> > +void hwd_viif_vsync_irq_handler(struct hwd_viif_res *res, u32 *event_main,
> u32 *event_sub);
> > +void hwd_viif_isp_regbuf_irq_handler(struct hwd_viif_res *res, u32 *event_l1,
> u32 *event_l2);
> > +
> > +/* control MAIN unit */
> > +s32 hwd_viif_main_set_unit(struct hwd_viif_res *res, u32 dt_image,
> > +                                   const struct hwd_viif_input_img *in_img, u32
> color_type, u32 rawpack,
> > +                                   u32 yuv_conv);
> > +s32 hwd_viif_main_mask_vlatch(struct hwd_viif_res *res, u32 enable);
> > +void hwd_viif_main_status_err_set_irq_mask(struct hwd_viif_res *res, u32
> mask);
> > +void hwd_viif_main_vsync_set_irq_mask(struct hwd_viif_res *res, u32
> mask);
> > +
> > +/* conrol SUB unit */
> > +s32 hwd_viif_sub_set_unit(struct hwd_viif_res *res, u32 dt_image,
> > +                                  const struct hwd_viif_input_img *in_img);
> > +s32 hwd_viif_sub_set_img_transmission(struct hwd_viif_res *res, const
> struct hwd_viif_img *img);
> > +void hwd_viif_sub_status_err_set_irq_mask(struct hwd_viif_res *res, u32
> mask);
> > +void hwd_viif_sub_vsync_set_irq_mask(struct hwd_viif_res *res, u32 mask);
> > +
> > +/* control MIPI CSI2 Receiver unit */
> > +s32 hwd_viif_csi2rx_initialize(struct hwd_viif_res *res, u32 num_lane, u32
> lane_assign,
> > +                                       u32 dphy_rate, u32 rext_calibration,
> > +                                       const struct hwd_viif_csi2rx_line_err_target
> *err_target,
> > +                                       const struct hwd_viif_csi2rx_irq_mask *mask);
> > +s32 hwd_viif_csi2rx_uninitialize(struct hwd_viif_res *res);
> > +s32 hwd_viif_csi2rx_start(struct hwd_viif_res *res, s32 vc_main, s32 vc_sub,
> > +                                  const struct hwd_viif_csi2rx_packet *packet);
> > +s32 hwd_viif_csi2rx_stop(struct hwd_viif_res *res);
> > +s32 hwd_viif_csi2rx_get_calibration_status(
> > +    struct hwd_viif_res *res, struct viif_csi2rx_dphy_calibration_status
> *calibration_status);
> > +s32 hwd_viif_csi2rx_get_err_status(struct hwd_viif_res *res, u32
> *err_phy_fatal, u32 *err_pkt_fatal,
> > +                                                 u32 *err_frame_fatal, u32 *err_phy, u32
> *err_pkt, u32 *err_line);
> > +
> > +/* control L1 Image Signal Processor */
> > +void hwd_viif_isp_set_regbuf_auto_transmission(struct hwd_viif_res *res);
> > +void hwd_viif_isp_disable_regbuf_auto_transmission(struct hwd_viif_res
> *res);
> > +void hwd_viif_isp_get_info(struct hwd_viif_res *res, struct hwd_viif_l1_info
> *l1_info,
> > +                                   u32 *l2_transfer_status);
> > +void hwd_viif_isp_set_regbuf_irq_mask(struct hwd_viif_res *res, const u32
> *mask_l1,
> > +                                                    const u32 *mask_l2);
> > +
> > +s32 hwd_viif_l1_set_input_mode(struct hwd_viif_res *res, u32 mode, u32
> depth, u32 raw_color_filter);
> > +s32 hwd_viif_l1_set_rgb_to_y_coef(struct hwd_viif_res *res, u16 coef_r, u16
> coef_g, u16 coef_b);
> > +s32 hwd_viif_l1_set_ag_mode(struct hwd_viif_res *res, const struct
> viif_l1_ag_mode_config *param);
> > +s32 hwd_viif_l1_set_ag(struct hwd_viif_res *res, u16 gain_h, u16 gain_m,
> u16 gain_l);
> > +s32 hwd_viif_l1_set_hdre(struct hwd_viif_res *res, const struct
> viif_l1_hdre_config *param);
> > +s32 hwd_viif_l1_set_img_extraction(struct hwd_viif_res *res, u32
> input_black_gr, u32 input_black_r,
> > +                                                 u32 input_black_b, u32 input_black_gb);
> > +s32 hwd_viif_l1_set_dpc(struct hwd_viif_res *res, const struct viif_l1_dpc
> *param_h,
> > +                                const struct viif_l1_dpc *param_m, const struct
> viif_l1_dpc *param_l);
> > +s32 hwd_viif_l1_set_dpc_table_transmission(struct hwd_viif_res *res,
> uintptr_t table_h,
> > +                                                               uintptr_t table_m, uintptr_t
> table_l);
> > +s32 hwd_viif_l1_set_preset_white_balance(struct hwd_viif_res *res, u32
> dstmaxval,
> > +                                                            const struct viif_l1_preset_wb
> *param_h,
> > +                                                            const struct viif_l1_preset_wb
> *param_m,
> > +                                                            const struct viif_l1_preset_wb
> *param_l);
> > +s32 hwd_viif_l1_set_raw_color_noise_reduction(
> > +    struct hwd_viif_res *res, const struct viif_l1_raw_color_noise_reduction
> *param_h,
> > +    const struct viif_l1_raw_color_noise_reduction *param_m,
> > +    const struct viif_l1_raw_color_noise_reduction *param_l);
> > +s32 hwd_viif_l1_set_hdrs(struct hwd_viif_res *res, const struct
> viif_l1_hdrs_config *param);
> > +s32 hwd_viif_l1_set_black_level_correction(
> > +    struct hwd_viif_res *res, const struct
> viif_l1_black_level_correction_config *param);
> > +s32 hwd_viif_l1_set_lsc(struct hwd_viif_res *res, const struct hwd_viif_l1_lsc
> *param);
> > +s32 hwd_viif_l1_set_lsc_table_transmission(struct hwd_viif_res *res,
> uintptr_t table_gr,
> > +                                                               uintptr_t table_r, uintptr_t table_b,
> > +                                                               uintptr_t table_gb);
> > +s32 hwd_viif_l1_set_main_process(struct hwd_viif_res *res, u32
> demosaic_mode, u32 damp_lsbsel,
> > +                                              const struct viif_l1_color_matrix_correction
> *color_matrix,
> > +                                              u32 dst_maxval);
> > +s32 hwd_viif_l1_set_awb(struct hwd_viif_res *res, const struct viif_l1_awb
> *param, u32 awhb_wbmrg,
> > +                                u32 awhb_wbmgg, u32 awhb_wbmbg);
> > +s32 hwd_viif_l1_lock_awb_gain(struct hwd_viif_res *res, u32 enable);
> > +s32 hwd_viif_l1_set_hdrc(struct hwd_viif_res *res, const struct viif_l1_hdrc
> *param,
> > +                                u32 hdrc_thr_sft_amt);
> > +s32 hwd_viif_l1_set_hdrc_ltm(struct hwd_viif_res *res, const struct
> viif_l1_hdrc_ltm_config *param);
> > +s32 hwd_viif_l1_set_gamma(struct hwd_viif_res *res, const struct
> viif_l1_gamma *param);
> > +s32 hwd_viif_l1_set_img_quality_adjustment(struct hwd_viif_res *res,
> > +                                                               const struct
> hwd_viif_l1_img_quality_adjustment *param);
> > +s32 hwd_viif_l1_set_avg_lum_generation(struct hwd_viif_res *res,
> > +                                                     const struct
> viif_l1_avg_lum_generation_config *param);
> > +void hwd_viif_l1_set_irq_mask(struct hwd_viif_res *res, u32 mask);
> > +
> > +/* control L2 Image Signal Processor */
> > +s32 hwd_viif_l2_set_input_csc(struct hwd_viif_res *res, const struct
> hwd_viif_csc_param *param,
> > +                                      bool is_l1_rgb);
> > +s32 hwd_viif_l2_set_undist(struct hwd_viif_res *res, const struct
> viif_l2_undist *param);
> > +s32 hwd_viif_l2_set_undist_table_transmission(struct hwd_viif_res *res,
> uintptr_t write_g,
> > +                                                                  uintptr_t read_b, uintptr_t
> read_g, uintptr_t read_r,
> > +                                                                  u32 size);
> > +s32 hwd_viif_l2_set_roi(struct hwd_viif_res *res, const struct
> viif_l2_roi_config *param);
> > +s32 hwd_viif_l2_set_gamma(struct hwd_viif_res *res, u32 post_id, u32
> enable, u32 vsplit, u32 mode);
> > +s32 hwd_viif_l2_set_gamma_table_transmission(struct hwd_viif_res *res,
> u32 post_id,
> > +                                                                 const struct
> hwd_viif_l2_gamma_table *gamma_table);
> > +s32 hwd_viif_l2_set_output_csc(struct hwd_viif_res *res, u32 post_id,
> > +                                       const struct hwd_viif_csc_param *param);
> > +s32 hwd_viif_l2_set_img_transmission(struct hwd_viif_res *res, u32 post_id,
> u32 enable,
> > +                                                   const struct hwd_viif_img_area *src,
> > +                                                   const struct hwd_viif_out_process
> *out_process,
> > +                                                   const struct hwd_viif_img *img);
> > +void hwd_viif_l2_set_irq_mask(struct hwd_viif_res *res, u32 mask);
> > +
> > +void hwd_viif_isp_guard_start(struct hwd_viif_res *res);
> > +void hwd_viif_isp_guard_end(struct hwd_viif_res *res);
> > +
> > +struct hwd_viif_res *allocate_viif_res(struct device *dev, void
> *csi2host_vaddr,
> > +                                                     void *capture_vaddr);
> > +
> > +#endif /* HWD_VIIF_H */
> > diff --git a/drivers/media/platform/visconti/hwd_viif_csi2rx.c
> b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
> > new file mode 100644
> > index 00000000000..f49869c5bdd
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/hwd_viif_csi2rx.c
> > @@ -0,0 +1,610 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/* Toshiba Visconti Video Capture Support
> > + *
> > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/timekeeping.h>
> > +#include "hwd_viif.h"
> > +#include "hwd_viif_internal.h"
> > +
> > +#define CSI2_DT_YUV4208   0x18
> > +#define CSI2_DT_YUV42010  0x19
> > +#define CSI2_DT_YUV4208L  0x1A
> > +#define CSI2_DT_YUV4208C  0x1C
> > +#define CSI2_DT_YUV42010C 0x1D
> > +#define CSI2_DT_YUV4228B  VISCONTI_CSI2_DT_YUV4228B
> > +#define CSI2_DT_YUV42210B VISCONTI_CSI2_DT_YUV42210B
> > +#define CSI2_DT_RGB444    0x20
> > +#define CSI2_DT_RGB555    0x21
> > +#define CSI2_DT_RGB565    VISCONTI_CSI2_DT_RGB565
> > +#define CSI2_DT_RGB666    0x23
> > +#define CSI2_DT_RGB888    VISCONTI_CSI2_DT_RGB888
> > +#define CSI2_DT_RAW8        VISCONTI_CSI2_DT_RAW8
> > +#define CSI2_DT_RAW10      VISCONTI_CSI2_DT_RAW10
> > +#define CSI2_DT_RAW12      VISCONTI_CSI2_DT_RAW12
> > +#define CSI2_DT_RAW14      VISCONTI_CSI2_DT_RAW14
> 
> Same here.

I'll use definitions in mipi-csi2.h

> > +
> > +#define TESTCTRL0_PHY_TESTCLK_1             0x2
> > +#define TESTCTRL0_PHY_TESTCLK_0             0x0
> > +#define TESTCTRL1_PHY_TESTEN      0x10000
> > +#define TESTCTRL1_PHY_TESTDOUT_SHIFT 8U
> > +
> > +/**
> > + * write_dphy_param() - Write CSI2RX DPHY params
> > + *
> > + * @test_mode: test code address
> > + * @test_in: test code data
> > + * Return: None
> > + */
> > +static void write_dphy_param(u32 test_mode, u8 test_in, struct hwd_viif_res
> *res)
> > +{
> > +    /* select MSB address register */
> > +    writel(TESTCTRL1_PHY_TESTEN,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* set MSB address of test_mode */
> > +    writel(FIELD_GET(0xF00, test_mode),
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* select and set LSB address register */
> > +    writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
> > +           &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* set the test code data */
> > +    writel((u32)test_in, &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +}
> > +
> > +/**
> > + * read_dphy_param() - Read CSI2RX DPHY params
> > + *
> > + * @test_mode: test code address
> > + * Return: test code data
> > + */
> > +static u8 read_dphy_param(u32 test_mode, struct hwd_viif_res *res)
> > +{
> > +    u32 read_data;
> > +
> > +    /* select MSB address register */
> > +    writel(TESTCTRL1_PHY_TESTEN,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* set MSB address of test_mode */
> > +    writel(FIELD_GET(0xF00, test_mode),
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* select and set LSB address register */
> > +    writel(TESTCTRL1_PHY_TESTEN | FIELD_GET(0xFF, test_mode),
> > +           &res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +
> > +    /* rise and clear the testclk */
> > +    writel(TESTCTRL0_PHY_TESTCLK_1,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(TESTCTRL0_PHY_TESTCLK_0,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* read the test code data */
> > +    read_data = readl(&res->csi2host_reg->CSI2RX_PHY_TESTCTRL1);
> > +    return (u8)(read_data >> TESTCTRL1_PHY_TESTDOUT_SHIFT);
> > +}
> > +
> > +/**
> > + * enum dphy_testcode - DPHY registers via the local communication path
> > + */
> > +enum dphy_testcode {
> > +    DIG_RDWR_RX_SYS_0 = 0x001,
> > +    DIG_RDWR_RX_SYS_1 = 0x002,
> > +    DIG_RDWR_RX_SYS_3 = 0x004,
> > +    DIG_RDWR_RX_SYS_7 = 0x008,
> > +    DIG_RDWR_RX_RX_STARTUP_OVR_2 = 0x0E2,
> > +    DIG_RDWR_RX_RX_STARTUP_OVR_3 = 0x0E3,
> > +    DIG_RDWR_RX_RX_STARTUP_OVR_4 = 0x0E4,
> > +    DIG_RDWR_RX_RX_STARTUP_OVR_5 = 0x0E5,
> > +    DIG_RDWR_RX_CB_2 = 0x1AC,
> > +    DIG_RD_RX_TERM_CAL_0 = 0x220,
> > +    DIG_RD_RX_TERM_CAL_1 = 0x221,
> > +    DIG_RD_RX_TERM_CAL_2 = 0x222,
> > +    DIG_RDWR_RX_CLKLANE_LANE_6 = 0x307,
> > +    DIG_RD_RX_CLKLANE_OFFSET_CAL_0 = 0x39D,
> > +    DIG_RD_RX_LANE0_OFFSET_CAL_0 = 0x59F,
> > +    DIG_RD_RX_LANE0_DDL_0 = 0x5E0,
> > +    DIG_RD_RX_LANE1_OFFSET_CAL_0 = 0x79F,
> > +    DIG_RD_RX_LANE1_DDL_0 = 0x7E0,
> > +    DIG_RD_RX_LANE2_OFFSET_CAL_0 = 0x99F,
> > +    DIG_RD_RX_LANE2_DDL_0 = 0x9E0,
> > +    DIG_RD_RX_LANE3_OFFSET_CAL_0 = 0xB9F,
> > +    DIG_RD_RX_LANE3_DDL_0 = 0xBE0,
> > +};
> > +
> > +#define SYS_0_HSFREQRANGE_OVR  BIT(5)
> > +#define SYS_7_RESERVED        FIELD_PREP(0x1F, 0x0C)
> > +#define SYS_7_DESKEW_POL       BIT(5)
> > +#define STARTUP_OVR_4_CNTVAL   FIELD_PREP(0x70, 0x01)
> > +#define STARTUP_OVR_4_DDL_EN   BIT(0)
> > +#define STARTUP_OVR_5_BYPASS   BIT(0)
> > +#define CB_2_LPRX_BIAS         BIT(6)
> > +#define CB_2_RESERVED         FIELD_PREP(0x3F, 0x0B)
> > +#define CLKLANE_RXHS_PULL_LONG BIT(7)
> > +
> > +static const struct hwd_viif_dphy_hs_info dphy_hs_info[] = {
> > +    { 80, 0x0, 0x1cc },   { 85, 0x10, 0x1cc },   { 95, 0x20, 0x1cc },   { 105,
> 0x30, 0x1cc },
> > +    { 115, 0x1, 0x1cc },  { 125, 0x11, 0x1cc },  { 135, 0x21, 0x1cc },  { 145,
> 0x31, 0x1cc },
> > +    { 155, 0x2, 0x1cc },  { 165, 0x12, 0x1cc },  { 175, 0x22, 0x1cc },  { 185,
> 0x32, 0x1cc },
> > +    { 198, 0x3, 0x1cc },  { 213, 0x13, 0x1cc },  { 228, 0x23, 0x1cc },  { 243,
> 0x33, 0x1cc },
> > +    { 263, 0x4, 0x1cc },  { 288, 0x14, 0x1cc },  { 313, 0x25, 0x1cc },  { 338,
> 0x35, 0x1cc },
> > +    { 375, 0x5, 0x1cc },  { 425, 0x16, 0x1cc },  { 475, 0x26, 0x1cc },  { 525,
> 0x37, 0x1cc },
> > +    { 575, 0x7, 0x1cc },  { 625, 0x18, 0x1cc },  { 675, 0x28, 0x1cc },  { 725,
> 0x39, 0x1cc },
> > +    { 775, 0x9, 0x1cc },  { 825, 0x19, 0x1cc },  { 875, 0x29, 0x1cc },  { 925,
> 0x3a, 0x1cc },
> > +    { 975, 0xa, 0x1cc },  { 1025, 0x1a, 0x1cc }, { 1075, 0x2a, 0x1cc }, { 1125,
> 0x3b, 0x1cc },
> > +    { 1175, 0xb, 0x1cc }, { 1225, 0x1b, 0x1cc }, { 1275, 0x2b, 0x1cc }, { 1325,
> 0x3c, 0x1cc },
> > +    { 1375, 0xc, 0x1cc }, { 1425, 0x1c, 0x1cc }, { 1475, 0x2c, 0x1cc }
> > +};
> > +
> > +/**
> > + * get_dphy_hs_transfer_info() - Get DPHY HS info from table
> > + *
> > + * @dphy_rate: DPHY clock in MHz
> > + * @hsfreqrange: HS Frequency Range
> > + * @osc_freq_target: OSC Frequency Target
> > + * Return: None
> > + */
> > +static void get_dphy_hs_transfer_info(u32 dphy_rate, u32 *hsfreqrange, u32
> *osc_freq_target,
> > +                                                    struct hwd_viif_res *res)
> > +{
> > +    int table_size = ARRAY_SIZE(dphy_hs_info);
> 
> No need for a local variable.

I'll drop it.

> > +    int i;
> 
> unsigned int

I'll fix it. Same for similar cases.

> > +
> > +    for (i = 1; i < table_size; i++) {
> > +                  if (dphy_rate < dphy_hs_info[i].rate) {
> > +                                *hsfreqrange = dphy_hs_info[i - 1].hsfreqrange;
> > +                                *osc_freq_target = dphy_hs_info[i - 1].osc_freq_target;
> > +                                return;
> > +                  }
> > +    }
> > +
> > +    /* not found; return the largest entry */
> > +    *hsfreqrange = dphy_hs_info[table_size - 1].hsfreqrange;
> > +    *osc_freq_target = dphy_hs_info[table_size - 1].osc_freq_target;
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_set_dphy_rate() - Set D-PHY rate
> > + *
> > + * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
> > + * Return: None
> > + */
> > +static void hwd_viif_csi2rx_set_dphy_rate(u32 dphy_rate, struct hwd_viif_res
> *res)
> > +{
> > +    u32 hsfreqrange, osc_freq_target;
> > +
> > +    get_dphy_hs_transfer_info(dphy_rate, &hsfreqrange, &osc_freq_target,
> res);
> > +
> > +    write_dphy_param(DIG_RDWR_RX_SYS_1, (u8)hsfreqrange, res);
> > +    write_dphy_param(DIG_RDWR_RX_SYS_0,
> SYS_0_HSFREQRANGE_OVR, res);
> > +    write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_5,
> STARTUP_OVR_5_BYPASS, res);
> > +    write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4,
> STARTUP_OVR_4_CNTVAL, res);
> > +    write_dphy_param(DIG_RDWR_RX_CB_2, CB_2_LPRX_BIAS |
> CB_2_RESERVED, res);
> > +    write_dphy_param(DIG_RDWR_RX_SYS_7, SYS_7_DESKEW_POL |
> SYS_7_RESERVED, res);
> > +    write_dphy_param(DIG_RDWR_RX_CLKLANE_LANE_6,
> CLKLANE_RXHS_PULL_LONG, res);
> > +    write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_2,
> FIELD_GET(0xff, osc_freq_target), res);
> > +    write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_3,
> FIELD_GET(0xf00, osc_freq_target), res);
> > +    write_dphy_param(DIG_RDWR_RX_RX_STARTUP_OVR_4,
> STARTUP_OVR_4_CNTVAL | STARTUP_OVR_4_DDL_EN,
> > +                                res);
> > +
> > +    writel(HWD_VIIF_DPHY_CFG_CLK_25M,
> &res->capture_reg->sys.DPHY_FREQRANGE);
> > +}
> > +
> > +/**
> > + * check_dphy_calibration_status() - Check D-PHY calibration status
> > + *
> > + * @test_mode: test code related to calibration information
> > + * @shift_val_err: shift value related to error information
> > + * @shift_val_done: shift value related to done information
> > + * Return: HWD_VIIF_CSI2_CAL_NOT_DONE calibration is not done(out of
> target or not completed)
> > + * Return: HWD_VIIF_CSI2_CAL_FAIL calibration was failed
> > + * Return: HWD_VIIF_CSI2_CAL_SUCCESS calibration was succeeded
> > + */
> > +static u32 check_dphy_calibration_status(u32 test_mode, u32 shift_val_err,
> u32 shift_val_done,
> > +                                                            struct hwd_viif_res *res)
> > +{
> > +    u32 read_data = (u32)read_dphy_param(test_mode, res);
> > +
> > +    if (!(read_data & BIT(shift_val_done)))
> > +                  return HWD_VIIF_CSI2_CAL_NOT_DONE;
> > +
> > +    /* error check is not required for termination calibration with
> REXT(0x221) */
> > +    if (test_mode == DIG_RD_RX_TERM_CAL_1)
> > +                  return HWD_VIIF_CSI2_CAL_SUCCESS;
> > +
> > +    /* done with error */
> > +    if (read_data & BIT(shift_val_err))
> > +                  return HWD_VIIF_CSI2_CAL_FAIL;
> > +
> > +    return HWD_VIIF_CSI2_CAL_SUCCESS;
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_initialize() - Initialize CSI-2 RX driver
> > + *
> > + * @num_lane: [1..4](VIIF CH0-CH1)
> > + * @lane_assign: lane connection. For more refer @ref
> hwd_viif_dphy_lane_assignment
> > + * @dphy_rate: D-PHY rate of 1 Lane[Mbps] [80..1500]
> > + * @rext_calibration: enable or disable rext calibration.
> > + *                    For more refer @ref hwd_viif_csi2rx_cal_status
> > + * @err_target: Pointer to configuration for Line error detection.
> > + * @mask: MASK of CSI-2 RX error interruption
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "num_lane", "lane_assign", "dphy_rate", "rext_calibration" or
> "input_mode" is out of range
> > + * - [2] "err_target" is NULL
> > + * - [3] member of "err_target" is invalid
> > + */
> > +s32 hwd_viif_csi2rx_initialize(struct hwd_viif_res *res, u32 num_lane, u32
> lane_assign,
> > +                                       u32 dphy_rate, u32 rext_calibration,
> > +                                       const struct hwd_viif_csi2rx_line_err_target
> *err_target,
> > +                                       const struct hwd_viif_csi2rx_irq_mask *mask)
> > +{
> > +    u32 i, val;
> > +
> > +    if (num_lane == 0U || num_lane > 4U || lane_assign >
> HWD_VIIF_CSI2_DPHY_L0L2L1L3)
> > +                  return -EINVAL;
> > +
> > +    if (dphy_rate < HWD_VIIF_DPHY_MIN_DATA_RATE || dphy_rate >
> HWD_VIIF_DPHY_MAX_DATA_RATE ||
> > +        (rext_calibration != HWD_VIIF_ENABLE && rext_calibration !=
> HWD_VIIF_DISABLE) ||
> > +        !err_target) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    for (i = 0; i < 8U; i++) {
> > +                  if (err_target->vc[i] > HWD_VIIF_CSI2_MAX_VC ||
> > +                      err_target->dt[i] > HWD_VIIF_CSI2_MAX_DT ||
> > +                      (err_target->dt[i] < HWD_VIIF_CSI2_MIN_DT &&
> err_target->dt[i] != 0U)) {
> > +                                return -EINVAL;
> > +                  }
> > +    }
> > +
> > +    /* 1st phase of initialization */
> > +    writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_RESETN);
> > +    writel(HWD_VIIF_DISABLE,
> &res->csi2host_reg->CSI2RX_PHY_RSTZ);
> > +    writel(HWD_VIIF_DISABLE,
> &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
> > +    writel(HWD_VIIF_ENABLE,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    ndelay(15U);
> > +    writel(HWD_VIIF_DISABLE,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +
> > +    /* Configure D-PHY frequency range */
> > +    hwd_viif_csi2rx_set_dphy_rate(dphy_rate, res);
> > +
> > +    /* 2nd phase of initialization */
> > +    writel((num_lane - 1U), &res->csi2host_reg->CSI2RX_NLANES);
> > +    ndelay(5U);
> > +
> > +    /* configuration not to use rext */
> > +    if (rext_calibration == HWD_VIIF_DISABLE) {
> > +                  write_dphy_param(0x004, 0x10, res);
> > +                  ndelay(5U);
> > +    }
> > +
> > +    /* Release D-PHY from Reset */
> > +    writel(HWD_VIIF_ENABLE,
> &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
> > +    ndelay(5U);
> > +    writel(HWD_VIIF_ENABLE, &res->csi2host_reg->CSI2RX_PHY_RSTZ);
> > +
> > +    /* configuration of line error target */
> > +    val = (err_target->vc[3] << 30U) | (err_target->dt[3] << 24U) |
> (err_target->vc[2] << 22U) |
> > +          (err_target->dt[2] << 16U) | (err_target->vc[1] << 14U) |
> (err_target->dt[1] << 8U) |
> > +          (err_target->vc[0] << 6U) | (err_target->dt[0]);
> > +    writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_1);
> > +    val = (err_target->vc[7] << 30U) | (err_target->dt[7] << 24U) |
> (err_target->vc[6] << 22U) |
> > +          (err_target->dt[6] << 16U) | (err_target->vc[5] << 14U) |
> (err_target->dt[5] << 8U) |
> > +          (err_target->vc[4] << 6U) | (err_target->dt[4]);
> > +    writel(val, &res->csi2host_reg->CSI2RX_DATA_IDS_2);
> > +
> > +    /* configuration of mask */
> > +    writel(mask->mask[0],
> &res->csi2host_reg->CSI2RX_INT_MSK_PHY_FATAL);
> > +    writel(mask->mask[1],
> &res->csi2host_reg->CSI2RX_INT_MSK_PKT_FATAL);
> > +    writel(mask->mask[2],
> &res->csi2host_reg->CSI2RX_INT_MSK_FRAME_FATAL);
> > +    writel(mask->mask[3], &res->csi2host_reg->CSI2RX_INT_MSK_PHY);
> > +    writel(mask->mask[4], &res->csi2host_reg->CSI2RX_INT_MSK_PKT);
> > +    writel(mask->mask[5],
> &res->csi2host_reg->CSI2RX_INT_MSK_LINE);
> > +
> > +    /* configuration of lane assignment */
> > +    writel(lane_assign, &res->capture_reg->sys.DPHY_LANE);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_uninitialize() - Uninitialize CSI-2 RX driver
> > + *
> > + * Return: 0 Operation completes successfully
> > + */
> > +s32 hwd_viif_csi2rx_uninitialize(struct hwd_viif_res *res)
> > +{
> > +    writel(HWD_VIIF_DISABLE,
> &res->csi2host_reg->CSI2RX_PHY_SHUTDOWNZ);
> > +    writel(HWD_VIIF_DISABLE,
> &res->csi2host_reg->CSI2RX_PHY_RSTZ);
> > +    writel(HWD_VIIF_ENABLE,
> &res->csi2host_reg->CSI2RX_PHY_TESTCTRL0);
> > +    writel(HWD_VIIF_DISABLE, &res->csi2host_reg->CSI2RX_RESETN);
> > +
> > +    return 0;
> > +}
> > +
> > +#define PORT_SEL_MAIN_LONG  0
> > +#define PORT_SEL_MAIN_EMBED 1
> > +#define PORT_SEL_SUB_LONG   4
> > +#define PORT_SEL_SUB_EMBED  5
> > +
> > +static void config_vdm_wport(struct hwd_viif_res *res, int port_sel, u32
> height, u32 pitch)
> > +{
> > +    struct hwd_viif_vdm_write_port_reg *wport;
> > +    u32 start_addr, end_addr;
> > +
> > +    wport = &res->capture_reg->vdm.w_port[port_sel];
> > +
> > +    writel(pitch, &wport->VDM_W_PITCH);
> > +    writel(height, &wport->VDM_W_HEIGHT);
> > +    start_addr = readl(&wport->VDM_W_STADR);
> > +    end_addr = start_addr + pitch - 1U;
> > +    writel(end_addr, &wport->VDM_W_ENDADR);
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_start() - Start CSI-2 input
> > + *
> > + * @vc_main: control CSI-2 input of MAIN unit.
> > + *           enable with configured VC: 0, 1, 2 or 3, keep disabling:
> > + * @vc_sub: control CSI-2 input of SUB unit.
> > + *          enable with configured VC: 0, 1, 2 or 3, keep disabling:
> > + * @packet: Pointer to packet information of embedded data and long packet
> data
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * HWD_VIIF_CSI2_NOT_CAPTURE
> > + * HWD_VIIF_CSI2_NOT_CAPTURE
> > + * - [1] "vc_main" or "vc_sub" is out of range
> > + * - [2] member of "packet" is invalid
> > + */
> > +s32 hwd_viif_csi2rx_start(struct hwd_viif_res *res, s32 vc_main, s32 vc_sub,
> > +                                  const struct hwd_viif_csi2rx_packet *packet)
> > +{
> > +    u32 val, i, pitch, height, dt;
> > +    u32 enable_vc0 = HWD_VIIF_DISABLE;
> > +    u32 enable_vc1 = HWD_VIIF_DISABLE;
> > +
> > +    if (vc_main > 3 || vc_main < HWD_VIIF_CSI2_NOT_CAPTURE || vc_sub
> > 3 ||
> > +        vc_sub < HWD_VIIF_CSI2_NOT_CAPTURE) {
> > +                  return -EINVAL;
> > +    }
> > +
> > +    for (i = 0; i < VISCONTI_CSI2RX_PACKET_TYPES_NUM; i++) {
> > +                  if (packet->word_count[i] >
> HWD_VIIF_CSI2_MAX_WORD_COUNT ||
> > +                      packet->packet_num[i] >
> HWD_VIIF_CSI2_MAX_PACKET_NUM) {
> > +                                return -EINVAL;
> > +                  }
> > +    }
> > +
> > +    writel(HWD_VIIF_INPUT_CSI2, &res->capture_reg->sys.IPORTM);
> > +
> > +    if (vc_main != HWD_VIIF_CSI2_NOT_CAPTURE) {
> > +                  writel((u32)vc_main, &res->capture_reg->sys.VCID0SELECT);
> > +                  enable_vc0 = HWD_VIIF_ENABLE;
> > +    }
> > +    if (vc_sub != HWD_VIIF_CSI2_NOT_CAPTURE) {
> > +                  writel((u32)vc_sub, &res->capture_reg->sys.VCID1SELECT);
> > +                  enable_vc1 = HWD_VIIF_ENABLE;
> > +    }
> > +
> > +    /* configure Embedded Data transfer of MAIN unit */
> > +    height =
> packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN];
> > +    pitch =
> ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_EMB_MAIN],
> 4);
> > +    config_vdm_wport(res, PORT_SEL_MAIN_EMBED, height, pitch);
> > +
> > +    /* configure Long Packet transfer of MAIN unit */
> > +    dt = readl(&res->capture_reg->sys.IPORTM_OTHER);
> > +    if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV4208 || dt ==
> CSI2_DT_YUV4208C ||
> > +        dt == CSI2_DT_YUV42010C) {
> > +                  pitch =
> ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN],
> 4) +
> > +
>           ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LON
> G_MAIN] * 2U, 4);
> > +                  height =
> packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN] >>
> 1U;
> > +    } else {
> > +                  pitch =
> ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN],
> 4);
> > +                  height =
> packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_MAIN];
> > +    }
> > +    config_vdm_wport(res, PORT_SEL_MAIN_LONG, height, pitch);
> > +
> > +    /* configure Embedded Data transfer of SUB unit */
> > +    height =
> packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB];
> > +    pitch =
> ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_EMB_SUB],
> 4);
> > +    config_vdm_wport(res, PORT_SEL_SUB_EMBED, height, pitch);
> > +
> > +    /* configure Long Packet transfer of SUB unit */
> > +    dt = readl(&res->capture_reg->sys.IPORTS_OTHER);
> > +    if (dt == CSI2_DT_YUV4208 || dt == CSI2_DT_YUV42010 || dt ==
> CSI2_DT_YUV4208C ||
> > +        dt == CSI2_DT_YUV42010C) {
> > +                  pitch =
> ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB],
> 4) +
> > +
>           ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LON
> G_SUB] * 2U, 4);
> > +                  height =
> packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB] >> 1U;
> > +    } else {
> > +                  pitch =
> ALIGN(packet->word_count[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB],
> 4);
> > +                  height =
> packet->packet_num[VISCONTI_CSI2RX_PACKET_TYPE_LONG_SUB];
> > +    }
> > +    config_vdm_wport(res, PORT_SEL_SUB_LONG, height, pitch);
> > +
> > +    /* Control VC port enable */
> > +    val = enable_vc0 | (enable_vc1 << 4U);
> > +    writel(val, &res->capture_reg->sys.VCPORTEN);
> > +
> > +    if (enable_vc0 == HWD_VIIF_ENABLE) {
> > +                  /* Update flag information for run status of MAIN unit */
> > +                  res->run_flag_main = true;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_stop() - Stop CSI-2 input
> > + *
> > + * Return: 0 Operation completes successfully
> > + * Return: -ETIMEDOUT Driver timeout error
> > + */
> > +s32 hwd_viif_csi2rx_stop(struct hwd_viif_res *res)
> > +{
> > +    u32 status_r, status_w, status_t, l2_status;
> > +    u64 timeout_ns, cur_ns;
> > +    bool run_flag = true;
> > +    s32 ret = 0;
> 
> int, please. The same for return type.
> 
> This applies to the rest of the patch. Use s32 if you're e.g. dealing with
> hardware registers with a sign bit.

I'll fix it. Same for other functions.

> > +
> > +    /* Disable auto transmission of register buffer */
> > +    writel(0, &res->capture_reg->l1isp.L1_CRGBF_TRN_A_CONF);
> > +    writel(0, &res->capture_reg->l2isp.L2_CRGBF_TRN_A_CONF);
> > +
> > +    /* Wait for completion of register buffer transmission */
> > +    udelay(HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME);
> > +
> > +    /* Stop all VCs, long packet input and emb data input of MAIN unit */
> > +    writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.VCPORTEN);
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->sys.IPORTM_OTHEREN);
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->sys.IPORTM_EMBEN);
> > +
> > +    /* Stop image data input, long packet input and emb data input of SUB
> unit */
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->sys.IPORTS_OTHEREN);
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->sys.IPORTS_EMBEN);
> > +    writel(HWD_VIIF_DISABLE, &res->capture_reg->sys.IPORTS_IMGEN);
> > +
> > +    /* Stop VDMAC for all table ports, input ports and write ports */
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->vdm.VDM_T_ENABLE);
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->vdm.VDM_R_ENABLE);
> > +    writel(HWD_VIIF_DISABLE,
> &res->capture_reg->vdm.VDM_W_ENABLE);
> > +
> > +    /* Stop all groups(g00, g01 and g02) of VDMAC */
> > +    writel(0x7, &res->capture_reg->vdm.VDM_ABORTSET);
> > +
> > +    timeout_ns = ktime_get_ns() +
> HWD_VIIF_WAIT_ABORT_COMPLETE_TIME * 1000;
> 
> Wouldn't it be better to calculate how long you expect to busy loop here?

Sorry I couldn't catch the point.
The maximum time to spend at busy loop is HWD_VIIF_WAIT_ABORT_COMPLETE_TIME * 1000 [ns].
Do you mean that it is better to clearly show the timeout? Like...

  ret = -ETIMEOUT;
  do {
    if (...) {
      ret = 0;
      break;
    }
  } while (timeout_ns > cur_ns);


> > +
> > +    do {
> > +                  /* Get VDMAC transfer status  */
> > +                  status_r = readl(&res->capture_reg->vdm.VDM_R_RUN);
> > +                  status_w = readl(&res->capture_reg->vdm.VDM_W_RUN);
> > +                  status_t = readl(&res->capture_reg->vdm.VDM_T_RUN);
> > +
> > +                  l2_status =
> readl(&res->capture_reg->l2isp.L2_BUS_L2_STATUS);
> > +
> > +                  if (status_r == 0U && status_w == 0U && status_t == 0U &&
> l2_status == 0U)
> > +                                run_flag = false;
> > +
> > +                  cur_ns = ktime_get_ns();
> > +
> > +                  if (cur_ns > timeout_ns) {
> > +                                ret = -ETIMEDOUT;
> > +                                run_flag = false;
> > +                  }
> > +    } while (run_flag);
> > +
> > +    if (ret == 0) {
> > +                  /* Clear run flag of MAIN unit */
> > +                  res->run_flag_main = false;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_get_calibration_status() - Get CSI-2 RX calibration status
> > + *
> > + * @calibration_status: Pointer to D-PHY calibration status information
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error
> > + * - [1] "calibration_status" is NULL
> > + */
> > +s32 hwd_viif_csi2rx_get_calibration_status(
> > +    struct hwd_viif_res *res, struct viif_csi2rx_dphy_calibration_status
> *calibration_status)
> > +{
> > +    if (!calibration_status)
> > +                  return -EINVAL;
> > +
> > +    /* arg0; test register, arg1: error bit, arg2: done bit */
> > +    /* 0x221: termination calibration with REXT */
> > +    calibration_status->term_cal_with_rext =
> > +                 check_dphy_calibration_status(DIG_RD_RX_TERM_CAL_1, 0, 7,
> res);
> > +    /* 0x39D: clock lane offset calibration */
> > +    calibration_status->clock_lane_offset_cal =
> > +
> check_dphy_calibration_status(DIG_RD_RX_CLKLANE_OFFSET_CAL_
> 0, 4, 0, res);
> > +    /* 0x59F: data lane0 offset calibration */
> > +    calibration_status->data_lane0_offset_cal =
> > +
> check_dphy_calibration_status(DIG_RD_RX_LANE0_OFFSET_CAL_0, 2,
> 1, res);
> > +    /* 0x79F: data lane1 offset calibration */
> > +    calibration_status->data_lane1_offset_cal =
> > +
> check_dphy_calibration_status(DIG_RD_RX_LANE1_OFFSET_CAL_0, 2,
> 1, res);
> > +    /* 0x99F: data lane2 offset calibration */
> > +    calibration_status->data_lane2_offset_cal =
> > +
> check_dphy_calibration_status(DIG_RD_RX_LANE2_OFFSET_CAL_0, 2,
> 1, res);
> > +    /* 0xB9F: data lane3 offset calibration */
> > +    calibration_status->data_lane3_offset_cal =
> > +
> check_dphy_calibration_status(DIG_RD_RX_LANE3_OFFSET_CAL_0, 2,
> 1, res);
> > +
> > +    /* 0x5E0: data lane0 DDL(Digital Delay Line) calibration */
> > +    calibration_status->data_lane0_ddl_tuning_cal =
> > +                check_dphy_calibration_status(DIG_RD_RX_LANE0_DDL_0, 1,
> 2, res);
> > +    /* 0x7E0: data lane1 DDL calibration */
> > +    calibration_status->data_lane1_ddl_tuning_cal =
> > +                check_dphy_calibration_status(DIG_RD_RX_LANE1_DDL_0, 1,
> 2, res);
> > +    /* 0x9E0: data lane2 DDL calibration */
> > +    calibration_status->data_lane2_ddl_tuning_cal =
> > +                check_dphy_calibration_status(DIG_RD_RX_LANE2_DDL_0, 1,
> 2, res);
> > +    /* 0xBE0: data lane3 DDL calibration */
> > +    calibration_status->data_lane3_ddl_tuning_cal =
> > +                check_dphy_calibration_status(DIG_RD_RX_LANE3_DDL_0, 1,
> 2, res);
> > +
> > +    return 0;
> > +}
> > +
> > +/**
> > + * hwd_viif_csi2rx_get_err_status() - Get CSI-2 RX error status
> > + *
> > + * @err_phy_fatal: Pointer to D-PHY fatal error information
> > + * @err_pkt_fatal: Pointer to Packet fatal error information
> > + * @err_frame_fatal: Pointer to Frame fatal error information
> > + * @err_phy: Pointer to D-PHY error information
> > + * @err_pkt: Pointer to Packet error information
> > + * @err_line: Pointer to Line error information
> > + * Return: 0 Operation completes successfully
> > + * Return: -EINVAL Parameter error,
> > + *         when "err_phy_fatal", "err_pkt_fatal", "err_frame_fatal",
> > + *         "err_phy", "err_pkt" or "err_line" is NULL
> > + */
> > +s32 hwd_viif_csi2rx_get_err_status(struct hwd_viif_res *res, u32
> *err_phy_fatal, u32 *err_pkt_fatal,
> > +                                                 u32 *err_frame_fatal, u32 *err_phy, u32
> *err_pkt, u32 *err_line)
> > +{
> > +    if (!err_phy_fatal || !err_pkt_fatal || !err_frame_fatal || !err_phy
> || !err_pkt ||
> > +        !err_line) {
> > +                  return -EINVAL;
> > +    }
> > +    *err_phy_fatal =
> readl(&res->csi2host_reg->CSI2RX_INT_ST_PHY_FATAL);
> > +    *err_pkt_fatal =
> readl(&res->csi2host_reg->CSI2RX_INT_ST_PKT_FATAL);
> > +    *err_frame_fatal =
> readl(&res->csi2host_reg->CSI2RX_INT_ST_FRAME_FATAL);
> > +    *err_phy = readl(&res->csi2host_reg->CSI2RX_INT_ST_PHY);
> > +    *err_pkt = readl(&res->csi2host_reg->CSI2RX_INT_ST_PKT);
> > +    *err_line = readl(&res->csi2host_reg->CSI2RX_INT_ST_LINE);
> > +
> > +    return 0;
> > +}
> > diff --git a/drivers/media/platform/visconti/hwd_viif_internal.h
> b/drivers/media/platform/visconti/hwd_viif_internal.h
> > new file mode 100644
> > index 00000000000..c954e804946
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/hwd_viif_internal.h
> > @@ -0,0 +1,340 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> > +/* Toshiba Visconti Video Capture Support
> > + *
> > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> > + */
> > +
> > +#ifndef HWD_VIIF_INTERNAL_H
> > +#define HWD_VIIF_INTERNAL_H
> > +
> > +#include "hwd_viif_reg.h"
> > +
> > +#define HWD_VIIF_CSI2_MAX_VC                     (3U)
> > +#define HWD_VIIF_CSI2_MIN_DT                      (0x10U)
> > +#define HWD_VIIF_CSI2_MAX_DT                     (0x3fU)
> > +#define HWD_VIIF_CSI2_MAX_WORD_COUNT              (16384U)
> > +#define HWD_VIIF_CSI2_MAX_PACKET_NUM               (8192U)
> > +#define HWD_VIIF_DPHY_MIN_DATA_RATE                  (80U)
> > +#define HWD_VIIF_DPHY_MAX_DATA_RATE                 (1500U)
> > +#define HWD_VIIF_DPHY_CFG_CLK_25M        (32U)
> > +#define HWD_VIIF_DPHY_TRANSFER_HS_TABLE_NUM (43U)
> > +
> > +/* maximum horizontal/vertical position/dimension of CROP with ISP */
> > +#define HWD_VIIF_CROP_MAX_X_ISP (8062U)
> > +#define HWD_VIIF_CROP_MAX_Y_ISP (3966U)
> > +#define HWD_VIIF_CROP_MAX_W_ISP (8190U)
> > +#define HWD_VIIF_CROP_MAX_H_ISP (4094U)
> > +
> > +/* maximum horizontal/vertical position/dimension of CROP without ISP */
> > +#define HWD_VIIF_CROP_MAX_X (1920U)
> > +#define HWD_VIIF_CROP_MAX_Y (1408U)
> > +#define HWD_VIIF_CROP_MIN_W (128U)
> > +#define HWD_VIIF_CROP_MAX_W (2048U)
> > +#define HWD_VIIF_CROP_MIN_H (128U)
> > +#define HWD_VIIF_CROP_MAX_H (1536U)
> > +
> > +/* pixel clock: [kHz] */
> > +#define HWD_VIIF_MIN_PIXEL_CLOCK (3375U)
> > +#define HWD_VIIF_MAX_PIXEL_CLOCK (600000U)
> > +
> > +/* picture size: [pixel], [ns] */
> > +#define HWD_VIIF_MIN_HTOTAL_PIXEL (143U)
> > +#define HWD_VIIF_MIN_HTOTAL_NSEC  (239U)
> > +#define HWD_VIIF_MAX_HTOTAL_PIXEL (65535U)
> > +#define HWD_VIIF_MAX_HTOTAL_NSEC  (109225U)
> > +
> > +/* horizontal back porch size: [system clock] */
> > +#define HWD_VIIF_HBP_SYSCLK (10U)
> > +
> > +/* active picture size: [pixel] */
> > +#define HWD_VIIF_MIN_HACTIVE_PIXEL_WO_L1ISP (128U)
> > +#define HWD_VIIF_MAX_HACTIVE_PIXEL_WO_L1ISP (4096U)
> > +#define HWD_VIIF_MIN_HACTIVE_PIXEL_W_L1ISP  (640U)
> > +#define HWD_VIIF_MAX_HACTIVE_PIXEL_W_L1ISP  (3840U)
> > +
> > +/* picture vertical size: [line], [packet] */
> > +#define HWD_VIIF_MIN_VTOTAL_LINE            (144U)
> > +#define HWD_VIIF_MAX_VTOTAL_LINE           (16383U)
> > +#define HWD_VIIF_MIN_VBP_LINE                  (5U)
> > +#define HWD_VIIF_MAX_VBP_LINE                               (4095U)
> > +#define HWD_VIIF_MIN_VBP_PACKET                          (5U)
> > +#define HWD_VIIF_MAX_VBP_PACKET                         (4095U)
> > +#define HWD_VIIF_MIN_VACTIVE_LINE_WO_L1ISP (128U)
> > +#define HWD_VIIF_MAX_VACTIVE_LINE_WO_L1ISP (2160U)
> > +#define HWD_VIIF_MIN_VACTIVE_LINE_W_L1ISP  (480U)
> > +#define HWD_VIIF_MAX_VACTIVE_LINE_W_L1ISP  (2160U)
> > +
> > +/* image source select */
> > +#define HWD_VIIF_INPUT_CSI2 (0U)
> > +
> > +#define HWD_VIIF_CSC_MAX_OFFSET               (0x0001FFFFU)
> > +#define HWD_VIIF_CSC_MAX_COEF_VALUE    (0x0000FFFFU)
> > +#define HWD_VIIF_CSC_MAX_COEF_NUM      (9U)
> > +#define HWD_VIIF_GAMMA_MAX_VSPLIT      (4094U)
> > +#define HWD_VIIF_MTB_CB_YG_COEF_OFFSET (16U)
> > +#define HWD_VIIF_MTB_CR_YG_COEF_OFFSET (0U)
> > +#define HWD_VIIF_MTB_CB_CB_COEF_OFFSET (16U)
> > +#define HWD_VIIF_MTB_CR_CB_COEF_OFFSET (0U)
> > +#define HWD_VIIF_MTB_CB_CR_COEF_OFFSET (16U)
> > +#define HWD_VIIF_MTB_CR_CR_COEF_OFFSET (0U)
> > +#define HWD_VIIF_MAX_PITCH_ISP                    (32704U)
> > +#define HWD_VIIF_MAX_PITCH              (65536U)
> > +
> > +/* size of minimum/maximum input image */
> > +#define HWD_VIIF_MIN_INPUT_IMG_WIDTH               (128U)
> > +#define HWD_VIIF_MAX_INPUT_IMG_WIDTH_ISP  (4096U)
> > +#define HWD_VIIF_MAX_INPUT_IMG_WIDTH              (2048U)
> > +#define HWD_VIIF_MIN_INPUT_IMG_HEIGHT             (128U)
> > +#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT_ISP (2160U)
> > +#define HWD_VIIF_MAX_INPUT_IMG_HEIGHT            (1536U)
> > +#define HWD_VIIF_MAX_INPUT_LINE_SIZE                 (16384U)
> > +
> > +/* size of minimum/maximum output image */
> > +#define HWD_VIIF_MIN_OUTPUT_IMG_WIDTH           (128U)
> > +#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_ISP (5760U)
> > +#define HWD_VIIF_MAX_OUTPUT_IMG_WIDTH_SUB (4096U)
> > +
> > +#define HWD_VIIF_MIN_OUTPUT_IMG_HEIGHT          (128U)
> > +#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_ISP (3240U)
> > +#define HWD_VIIF_MAX_OUTPUT_IMG_HEIGHT_SUB (2160U)
> > +
> > +#define HWD_VIIF_NO_EVENT (0x0U)
> > +
> > +/* System clock: [kHz] */
> > +#define HWD_VIIF_SYS_CLK (500000UL)
> > +
> > +/*
> > + * wait time for force abort to complete(max 1line time = 1228.8[us]
> > + * when width = 4096, RAW24, 80Mbps
> > + */
> > +#define HWD_VIIF_WAIT_ABORT_COMPLETE_TIME (1229U)
> > +
> > +/*
> > + * complete time of register buffer transfer.
> > + * actual time is about 30us in case of L1ISP
> > + */
> > +#define HWD_VIIF_WAIT_ISP_REGBF_TRNS_COMPLETE_TIME (39U)
> > +
> > +/* internal operation latencies: [system clock]*/
> > +#define HWD_VIIF_TABLE_LOAD_TIME    (24000UL)
> > +#define HWD_VIIF_REGBUF_ACCESS_TIME (15360UL)
> > +
> > +/* offset of Vsync delay: [line] */
> > +#define HWD_VIIF_L1_DELAY_W_HDRC  (31U)
> > +#define HWD_VIIF_L1_DELAY_WO_HDRC (11U)
> > +
> > +/* data width is 32bit */
> > +#define HWD_VIIF_VDM_CFG_PARAM (0x00000210U)
> > +
> > +/* vsync mode is pulse */
> > +#define HWD_VIIF_DPGM_VSYNC_PULSE (1U)
> > +
> > +/* Vlatch mask bit for L1ISP and L2ISP */
> > +#define HWD_VIIF_ISP_VLATCH_MASK (2U)
> > +
> > +/* Register buffer */
> > +#define HWD_VIIF_ISP_MAX_CONTEXT_NUM          (4U)
> > +#define HWD_VIIF_ISP_REGBUF_MODE_BYPASS (0U)
> > +#define HWD_VIIF_ISP_REGBUF_MODE_BUFFER (1U)
> > +#define HWD_VIIF_ISP_REGBUF_READ       (1U)
> > +
> > +/* constants for L1 ISP*/
> > +#define HWD_VIIF_L1_INPUT_MODE_NUM                             (5U)
> > +#define HWD_VIIF_L1_INPUT_DEPTH_MIN                             (8U)
> > +#define HWD_VIIF_L1_INPUT_DEPTH_MAX                                          (24U)
> > +#define HWD_VIIF_L1_INPUT_DEPTH_SDR_MAX
> (12U)
> > +#define HWD_VIIF_L1_INPUT_DEPTH_PWL_MAX
> (14U)
> > +#define HWD_VIIF_L1_RAW_MODE_NUM                                (4U)
> > +#define HWD_VIIF_L1_INPUT_NUM_MIN                                 (1U)
> > +#define HWD_VIIF_L1_INPUT_NUM_MAX                                (3U)
> > +#define HWD_VIIF_L1_AG_ID_NUM                                                        (4U)
> > +#define HWD_VIIF_L1_SENSITIVITY_IMAGE_NUM                 (3U)
> > +#define HWD_VIIF_L1_HDRE_MAX_KNEEPOINT_VAL                          (0x3fffU)
> > +#define HWD_VIIF_L1_HDRE_MAX_HDRE_SIG_VAL               (0xffffffU)
> > +#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_RATIO
> (0x400000U)
> > +#define HWD_VIIF_L1_HDRE_MAX_OUT_PIXEL_VAL                           (0xffffffU)
> > +#define HWD_VIIF_L1_OBCC_MAX_AG_VAL                                          (511U)
> > +#define HWD_VIIF_L1_IMG_EXTRACT_MAX_BLACK_LEVEL_VAL
> (0xffffffU)
> > +#define HWD_VIIF_L1_DPC_MAX_RATIO_LIMIT_VAL                           (1023U)
> > +#define HWD_VIIF_L1_DPC_MIN_LUMA_ADJ_VAL                  (1U)
> > +#define HWD_VIIF_L1_DPC_MAX_LUMA_ADJ_VAL                 (31U)
> > +#define HWD_VIIF_L1_VDM_ALIGN                                                        (0x8U) /*
> port interface width is 64bit */
> > +#define HWD_VIIF_L1_VDM_CFG_PARAM
> (0x00000310U) /* data width is 64bit */
> > +#define HWD_VIIF_L1_VDM_SRAM_BASE
> (0x00000600U)
> > +#define HWD_VIIF_L1_VDM_SRAM_SIZE
> (0x00000020U)
> > +#define HWD_VIIF_L1_VDM_DPC_TABLE_SIZE
> (0x2000U)
> > +#define HWD_VIIF_L1_VDM_LSC_TABLE_SIZE
> (0x600U)
> > +#define HWD_VIIF_L1_PWHB_MAX_OUT_PIXEL_VAL                          (4095U)
> > +#define HWD_VIIF_L1_PWHB_MAX_GAIN_VAL
> (0x80000U)
> > +#define HWD_VIIF_L1_RCNR_MAX_DARK_ADJUSTMENT_VAL
> (63U)
> > +#define HWD_VIIF_L1_RCNR_MAX_LUMA_LINKAGE_ADJUSTMENT_VAL
> (31U)
> > +#define HWD_VIIF_L1_RCNR_MAX_ADJUSTMENT_GAIN_VAL        (3U)
> > +#define HWD_VIIF_L1_RCNR_MAX_ZERO_CLIP_VAL                           (256U)
> > +#define HWD_VIIF_L1_RCNR_MAX_BLEND_VAL
> (16U)
> > +#define HWD_VIIF_L1_RCNR_MAX_BLACK_LEVEL_VAL
> (64U)
> > +#define HWD_VIIF_L1_RCNR_MIN_0DIV_GUARD_VAL                         (4U)
> > +#define HWD_VIIF_L1_RCNR_MAX_0DIV_GUARD_VAL
> (16U)
> > +#define HWD_VIIF_L1_RCNR_MAX_CALC_MSF_NOISE_MULTI_VAL
> (32U)
> > +#define HWD_VIIF_L1_RCNR_MAX_GEN_LUMA_SIG_BLEND_VAL
> (2U)
> > +#define HWD_VIIF_L1_RCNR_MAX_UP_LIMIT_GRGB_SENS_RATIO
> (15U)
> > +#define HWD_VIIF_L1_HDRS_MIN_BLEND_RATIO                  (0x400U)
> > +#define HWD_VIIF_L1_HDRS_MAX_BLEND_RATIO
> (0x400000U)
> > +#define HWD_VIIF_L1_HDRS_MAX_DIGITAL_GAIN_VAL
> (0x400000U)
> > +#define HWD_VIIF_L1_HDRS_MAX_DST_MAX_VAL                (0xffffffU)
> > +#define HWD_VIIF_L1_HDRS_MAX_BLEND_PIX_VAL                           (4095U)
> > +#define HWD_VIIF_L1_BLACK_LEVEL_MAX_VAL
> (0xffffffU)
> > +#define HWD_VIIF_L1_BLACK_LEVEL_MAX_GAIN_VAL
> (0x100000U)
> > +#define HWD_VIIF_L1_BLACK_LEVEL_MAX_DST_VAL
> (0xffffffU)
> > +#define HWD_VIIF_LSC_MIN_GAIN                                           (-4096)
> > +#define HWD_VIIF_LSC_MAX_GAIN                                                        (4096)
> > +#define HWD_VIIF_LSC_GRID_MIN_COORDINATE                  (1U)
> > +#define HWD_VIIF_LSC_PWB_MAX_COEF_VAL
> (0x800U)
> > +#define HWD_VIIF_DAMP_MAX_LSBSEL                                 (15U)
> > +#define HWD_VIIF_MAIN_PROCESS_MAX_OUT_PIXEL_VAL
> (0xffffffU)
> > +#define HWD_VIIF_AWB_MIN_GAIN                                                        (64U)
> > +#define HWD_VIIF_AWB_MAX_GAIN                                                       (1024U)
> > +#define HWD_VIIF_AWB_GATE_LOWER
> (-127)
> > +#define HWD_VIIF_AWB_GATE_UPPER
> (127)
> > +#define HWD_VIIF_AWB_UNSIGNED_GATE_UPPER               (127U)
> > +#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_SPEED
> (15U)
> > +#define HWD_VIIF_AWB_MAX_UV_CONVERGENCE_LEVEL
> (31U)
> > +#define HWD_VIIF_AWB_INTEGRATION_STOP_TH                 (1023U)
> > +#define HWD_VIIF_L1_HDRC_MAX_THROUGH_SHIFT_VAL
> (8U)
> > +#define HWD_VIIF_L1_HDRC_MIN_INPUT_DATA_WIDTH
> (10U)
> > +#define HWD_VIIF_L1_HDRC_MAX_INPUT_DATA_WIDTH
> (24U)
> > +#define HWD_VIIF_L1_HDRC_MAX_PT_SLOPE
> (13U)
> > +#define HWD_VIIF_L1_HDRC_MAX_BLEND_RATIO                 (256U)
> > +#define HWD_VIIF_L1_HDRC_MAX_FLARE_VAL
> (0xffffffU)
> > +#define HWD_VIIF_L1_HDRC_MAX_BLEND_LUMA
> (16U)
> > +#define HWD_VIIF_L1_HDRC_MAX_LTM_TONE_BLEND_RATIO
> (0x400000U)
> > +#define HWD_VIIF_L1_HDRC_MAX_LTM_MAGNIFICATION
> (0x4000U)
> > +#define HWD_VIIF_L1_HDRC_RATIO_OFFSET
> (10U)
> > +#define HWD_VIIF_L1_GAMMA_MAX_VAL                               (8191U)
> > +#define HWD_VIIF_L1_SUPPRESSION_MAX_VAL
> (0x4000U)
> > +#define HWD_VIIF_L1_EDGE_SUPPRESSION_MAX_LIMIT
> (15U)
> > +#define HWD_VIIF_L1_COLOR_LEVEL_MAX_GAIN                  (0x1000U)
> > +#define HWD_VIIF_L1_AEXP_MAX_WEIGHT                                          (3U)
> > +#define HWD_VIIF_L1_AEXP_MAX_BLOCK_TH
> (256U)
> > +#define HWD_VIIF_L1_AEXP_MAX_SATURATION_PIXEL_TH              (0xffffffU)
> > +#define HWD_VIIF_L1_AEXP_MIN_BLOCK_WIDTH                 (64U)
> > +#define HWD_VIIF_L1_AEXP_MIN_BLOCK_HEIGHT                (64U)
> > +#define HWD_VIIF_L1_HIST_COLOR_RGBY                             (2U)
> > +#define HWD_VIIF_L1_HIST_MAX_BLOCK_NUM
> (8U)
> > +#define HWD_VIIF_L1_HIST_MAX_STEP                                  (15U)
> > +#define HWD_VIIF_L1_HIST_MAX_BIN_SHIFT
> (31U)
> > +#define HWD_VIIF_L1_HIST_MAX_COEF                                  (65536U)
> > +#define HWD_VIIF_L1_HIST_MIN_ADD_B_COEF
> (-65536)
> > +#define HWD_VIIF_L1_HIST_MIN_ADD_A_COEF
> (-16777216)
> > +#define HWD_VIIF_L1_HIST_MAX_ADD_A_COEF
> (16777216)
> > +#define HWD_VIIF_L1_HIST_VDM_SIZE                                   (4096U)
> > +#define HWD_VIIF_L1_HIST_VDM_SRAM_BASE
> (0x00000400U)
> > +#define HWD_VIIF_L1_HIST_VDM_SRAM_SIZE
> (0x00000040U)
> > +#define HWD_VIIF_L1_CRGBF_R_START_ADDR_LIMIT
> (0x0200U)
> > +#define HWD_VIIF_L1_CRGBF_R_END_ADDR_LIMIT                            (0x10BFU)
> > +#define HWD_VIIF_L1_COEF_MIN                                             (256U)
> > +#define HWD_VIIF_L1_COEF_MAX                                            (65024U)
> > +
> > +/* constants for L2 ISP */
> > +#define HWD_VIIF_L2_VDM_ALIGN                                               (0x4U)
> > +#define HWD_VIIF_L2_VDM_GRID_SRAM_BASE
> (0x00000620U)
> > +#define HWD_VIIF_L2_VDM_GRID_SRAM_SIZE
> (0x00000020U)
> > +#define HWD_VIIF_L2_VDM_GAMMA_SRAM_BASE
> (0x00000640U)
> > +#define HWD_VIIF_L2_VDM_GAMMA_SRAM_SIZE
> (0x00000020U)
> > +#define HWD_VIIF_L2_VDM_GAMMA_TABLE_SIZE       (0x00000200U)
> > +#define HWD_VIIF_L2_UNDIST_POLY_NUM                                 (11U)
> > +#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_H     (-4296)
> > +#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_H     (4296)
> > +#define HWD_VIIF_L2_UNDIST_MIN_SENSOR_CROP_OFS_V     (-2360)
> > +#define HWD_VIIF_L2_UNDIST_MAX_SENSOR_CROP_OFS_V     (2360)
> > +#define HWD_VIIF_L2_UNDIST_MAX_NORM_SCALE                  (1677721U)
> > +#define HWD_VIIF_L2_UNDIST_MAX_VALID_R_NORM2
> (0x4000000U)
> > +#define HWD_VIIF_L2_UNDIST_MAX_ROI_WRITE_AREA_DELTA
> (0x800U)
> > +#define HWD_VIIF_L2_UNDIST_MIN_POLY_COEF         (-2147352576)
> > +#define HWD_VIIF_L2_UNDIST_MAX_POLY_COEF        (2147352576)
> > +#define HWD_VIIF_L2_UNDIST_MIN_GRID_NUM                         (16U)
> > +#define HWD_VIIF_L2_UNDIST_MAX_GRID_NUM                        (64U)
> > +#define HWD_VIIF_L2_UNDIST_MAX_GRID_TOTAL_NUM
> (2048U)
> > +#define HWD_VIIF_L2_UNDIST_MAX_GRID_PATCH_SIZE_INV
> (0x800000U)
> > +#define HWD_VIIF_L2_UNDIST_MIN_TABLE_SIZE         (0x400U)
> > +#define HWD_VIIF_L2_UNDIST_MAX_TABLE_SIZE        (0x2000U)
> > +#define HWD_VIIF_L2_ROI_MIN_NUM                                           (1U)
> > +#define HWD_VIIF_L2_ROI_MAX_NUM                                          (2U)
> > +#define HWD_VIIF_L2_ROI_MIN_SCALE                          (32768U)
> > +#define HWD_VIIF_L2_ROI_MAX_SCALE                         (131072U)
> > +#define HWD_VIIF_L2_ROI_MIN_SCALE_INV                                (32768U)
> > +#define HWD_VIIF_L2_ROI_MAX_SCALE_INV                               (131072U)
> > +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_HSIZE (128U)
> > +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_HSIZE
> (8190U)
> > +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_WO_SCALE_VSIZE (128U)
> > +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_WO_SCALE_VSIZE (4094U)
> > +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_HSIZE                 (128U)
> > +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_HSIZE                (8190U)
> > +#define HWD_VIIF_L2_ROI_MIN_CORRECTED_VSIZE                 (128U)
> > +#define HWD_VIIF_L2_ROI_MAX_CORRECTED_VSIZE                (4094U)
> > +#define HWD_VIIF_L2_CRGBF_R_START_ADDR_LIMIT
> (0x1CU)
> > +#define HWD_VIIF_L2_CRGBF_R_END_ADDR_LIMIT                   (0x1FU)
> > +#define HWD_VIIF_L2_ROI_NONE                                    (3U)
> > +#define HWD_VIIF_MAX_POST_NUM                                            (2U)
> > +#define HWD_VIIF_L2_INPUT_OTHER_CH                      (0x50U)
> > +
> > +/**
> > + * struct hwd_viif_l2_roi_path_info - L2ISP ROI path control information
> > + *
> > + * @roi_num: the number of ROIs which are used.
> > + * @post_enable_flag: flag to show which of POST is enabled.
> > + * @post_crop_x: CROP x of each L2ISP POST
> > + * @post_crop_y: CROP y of each L2ISP POST
> > + * @post_crop_w: CROP w of each L2ISP POST
> > + * @post_crop_h: CROP h of each L2ISP POST
> > + */
> > +struct hwd_viif_l2_roi_path_info {
> > +    u32 roi_num;
> > +    bool post_enable_flag[HWD_VIIF_MAX_POST_NUM];
> > +    u32 post_crop_x[HWD_VIIF_MAX_POST_NUM];
> > +    u32 post_crop_y[HWD_VIIF_MAX_POST_NUM];
> > +    u32 post_crop_w[HWD_VIIF_MAX_POST_NUM];
> > +    u32 post_crop_h[HWD_VIIF_MAX_POST_NUM];
> > +};
> > +
> > +/**
> > + * struct hwd_viif_res - driver internal resource structure
> > + *
> > + * @clock_id: clock ID of each unit
> > + * @csi2_clock_id: clock ID of CSI-2 RX
> > + * @csi2_reset_id: reset ID of CSI-2 RX
> > + * @pixel_clock: pixel clock
> > + * @htotal_size: horizontal total size
> > + * @dt_image_main_w_isp: Data type of image data for ISP path
> > + * @csi2host_reg: pointer to register access structure of CSI-2 RX host
> controller
> > + * @capture_reg: pointer to register access structure of capture unit
> > + * @l2_roi_path_info: ROI path information of L2ISP
> > + * @run_flag_main: run flag of MAIN unit(true: run, false: not run)
> > + */
> > +struct hwd_viif_res {
> > +    //u32 clock_id;
> > +    //u32 csi2_clock_id;
> > +    //u32 csi2_reset_id;
> 
> Please remove these if they're not needed.

I'll remove them.

> > +    u32 pixel_clock;
> > +    u32 htotal_size;
> > +    u32 dt_image_main_w_isp;
> > +    struct hwd_viif_csi2host_reg *csi2host_reg;
> > +    struct hwd_viif_capture_reg *capture_reg;
> > +    struct hwd_viif_l2_roi_path_info l2_roi_path_info;
> > +    bool run_flag_main;
> > +};
> > +
> > +/**
> > + * struct hwd_viif_dphy_hs_info - dphy hs information
> > + *
> > + * @rate: Data rate [Mbps]
> > + * @hsfreqrange: IP operating frequency(hsfreqrange)
> > + * @osc_freq_target: DDL target oscillation frequency(osc_freq_target)
> > + */
> > +struct hwd_viif_dphy_hs_info {
> > +    u32 rate;
> > +    u32 hsfreqrange;
> > +    u32 osc_freq_target;
> > +};
> > +
> > +#endif /* HWD_VIIF_INTERNAL_H */
> > diff --git a/drivers/media/platform/visconti/hwd_viif_reg.h
> b/drivers/media/platform/visconti/hwd_viif_reg.h
> > new file mode 100644
> > index 00000000000..b7f43c5fe95
> > --- /dev/null
> > +++ b/drivers/media/platform/visconti/hwd_viif_reg.h
> > @@ -0,0 +1,2802 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> > +/* Toshiba Visconti Video Capture Support
> > + *
> > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> > + */
> > +
> > +#ifndef HWD_VIIF_REG_H
> > +#define HWD_VIIF_REG_H
> > +
> > +/**
> > + * struct hwd_viif_csi2host_reg - Registers for VIIF CSI2HOST control
> > + */
> > +struct hwd_viif_csi2host_reg {
> > +    u32 RESERVED_A_1;
> > +    u32 CSI2RX_NLANES;
> > +    u32 CSI2RX_RESETN;
> > +    u32 CSI2RX_INT_ST_MAIN;
> > +    u32 CSI2RX_DATA_IDS_1;
> > +    u32 CSI2RX_DATA_IDS_2;
> > +    u32 RESERVED_B_1[10];
> > +    u32 CSI2RX_PHY_SHUTDOWNZ;
> > +    u32 CSI2RX_PHY_RSTZ;
> > +    u32 CSI2RX_PHY_RX;
> > +    u32 CSI2RX_PHY_STOPSTATE;
> > +    u32 CSI2RX_PHY_TESTCTRL0;
> > +    u32 CSI2RX_PHY_TESTCTRL1;
> > +    u32 RESERVED_B_2[34];
> > +    u32 CSI2RX_INT_ST_PHY_FATAL;
> > +    u32 CSI2RX_INT_MSK_PHY_FATAL;
> > +    u32 CSI2RX_INT_FORCE_PHY_FATAL;
> > +    u32 RESERVED_B_3[1];
> > +    u32 CSI2RX_INT_ST_PKT_FATAL;
> > +    u32 CSI2RX_INT_MSK_PKT_FATAL;
> > +    u32 CSI2RX_INT_FORCE_PKT_FATAL;
> > +    u32 RESERVED_B_4[1];
> > +    u32 CSI2RX_INT_ST_FRAME_FATAL;
> > +    u32 CSI2RX_INT_MSK_FRAME_FATAL;
> > +    u32 CSI2RX_INT_FORCE_FRAME_FATAL;
> > +    u32 RESERVED_B_5[1];
> > +    u32 CSI2RX_INT_ST_PHY;
> > +    u32 CSI2RX_INT_MSK_PHY;
> > +    u32 CSI2RX_INT_FORCE_PHY;
> > +    u32 RESERVED_B_6[1];
> > +    u32 CSI2RX_INT_ST_PKT;
> > +    u32 CSI2RX_INT_MSK_PKT;
> > +    u32 CSI2RX_INT_FORCE_PKT;
> > +    u32 RESERVED_B_7[1];
> > +    u32 CSI2RX_INT_ST_LINE;
> > +    u32 CSI2RX_INT_MSK_LINE;
> > +    u32 CSI2RX_INT_FORCE_LINE;
> > +    u32 RESERVED_B_8[113];
> > +    u32 RESERVED_A_2;
> > +    u32 RESERVED_A_3;
> > +    u32 RESERVED_A_4;
> > +    u32 RESERVED_A_5;
> > +    u32 RESERVED_A_6;
> > +    u32 RESERVED_B_9[58];
> > +    u32 RESERVED_A_7;
> 
> These should be lower case, they're struct members.
> 
> This way of defining a hardware register interface is highly
> unconventional. I'm not saying no to it, not now at least, but something
> should be done to make this more robust against accidental changes: adding
> a field in the middle changes the address of anything that comes after it,
> and it's really difficult to say from the code alone that the address of a
> given register is what it's intended to be. Maybe pahole would still help?
> But some documentation would be needed in that case.
> 
> I wonder what others think.

I understand the risk.
I'll remove these struct-style definition and introduce macro style definition.
I've hesitated this migration simply because it seemed difficult to complete without any defects 
especially on calculating the offset of each member.
I try find a series of operations that will complete the migration safely.

> > +};
> > +

snip

> 
> --
> Kind regards,
> 
> Sakari Ailus

Regards,

Yuji Ishikawa

