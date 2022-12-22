Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF5653C17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiLVGOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiLVGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:14:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDC1A3BB;
        Wed, 21 Dec 2022 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671689687; x=1703225687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gpEXKx5Bs6q3ZKbAWt1JGV98OxQJG57CkUUwdDaFw7Y=;
  b=gJAyjawACPU89WY7jhFUAWRLErCTZMs2i92+DwT5Lu5+A3R7sTorjSRj
   e2p3gsHl6jrKUZGHh6T2McqSHqEcQU2qD2951gmoWdv6kkTQkFwFiGqE1
   9lNwF7KmNBwczm5At9WlE2elKuIHy1kcbJSwZ+8MYhTXP5dIqF+ffjJgR
   cYGLhkWZCcm3sL/KwLmMSseoXRqP9wjyUz1/QXc4Rq6FlNV3QeCbr1eub
   XZKfZxwymskcSOHx4bm7KprQvBR4tD1CYMFnlKYjJnKHiJZFbEvdFTze4
   9zoxtFDmRN9xjwAjcwxxhDhEbTd7F8zzCiX9R2UMajnm+LyRh+ooHRNS6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="347191863"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="347191863"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 22:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="897104824"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="897104824"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 21 Dec 2022 22:14:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 22:14:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 22:14:46 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 22:14:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1yc6Kr7RLylUUEq+s2HDreWb1m13dWGWKTx/f7XREw5yqjLukiCmqEDGqov+UP/qXqvKJAADOmuh+9MrG3Z2N8bruQuQIy/OBt1GMtS78RtlHqSKuGPBY6jZakYctn+dePBlZ5wJNRC4317f6AWUylgNeeWzI82XB+n9mBxx4mIkgTzniqlm6C3yOOa6k7RQISSuV2yvmoJijoa8P5+J7A88hbe8Fv6Ex+uKlcwprgW2vLbyFQGeBto8FxjXtG5sgk7tn9LwaV5viRU3PBJR6uGZ3ijkrTGapyEv4VDMxbqagI8GRLTlHBEbU8As8F3GbzoY5GbAUb6Mt+OgspuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYSDaGw0TUxUak4VXduig2EDGIUbnF5aOD7oOjSjbkQ=;
 b=TYbimaVKN3/hn9n+2JhKqJevfnswSBfvPYZ4TxiLAjWDjNNb4Fd9f3md16+b53Hx8ytgSCe7ClX6xXk07Pms3opXVTERFz4d8slrWfgAEtI2Q5EJ3i2yN/WVbhdcZPAOBf20p/bOUuu2p4C9wV+0HsX1Qx8p2tJhwYbpfNkFQkcpFkUuUUTa3Y592yD1D4I7K+bA50tt9A3/RiNRprdEflIqU9ojraNxkK3bOeSmbjzvvlbXnVVjrKTiVVUxIKo9moMBntUh5dTiTXN1d+58AiiSOrI7nC4y47D/FjbMGLOQOWOYErye7APjmpkkS0J1A0G451HLkcug7Luf1nuAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MN2PR11MB4726.namprd11.prod.outlook.com (2603:10b6:208:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 06:14:39 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::3bae:7fb4:c54c:9750]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::3bae:7fb4:c54c:9750%3]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 06:14:39 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH] thunderbolt: Do not report errors if on-board retimers
 are found
Thread-Topic: [PATCH] thunderbolt: Do not report errors if on-board retimers
 are found
Thread-Index: AQHZFMKPUIXW8R9Kak2+zwMG+Hb/Ca5353kAgAGHzrA=
Date:   Thu, 22 Dec 2022 06:14:39 +0000
Message-ID: <MWHPR11MB00485AA5C75D427313431A06A9E89@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20221220223006.3145568-1-utkarsh.h.patel@intel.com>
 <Y6Ksriv+VQQ9e4g/@kroah.com>
In-Reply-To: <Y6Ksriv+VQQ9e4g/@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|MN2PR11MB4726:EE_
x-ms-office365-filtering-correlation-id: a5d84792-fb33-45df-5eea-08dae3e3cead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeJN0PeZeplqyxTzMrn0FTQubYnVUiPKbALR6H2jDQdgEViq086QXaQIcq55bRGRFNVUVzZIOxgYkapoeX9kxOywEXFm+PtHIkkfVqZcemabzR2OE53YHxWIwR7Yq+YYLMWW1yF+6Nl0NnHn9fT3XPFhzmIHo84rQwMBuxBmquZu0gB5HGLA/soVSt+RiI1v+vbulir+we+T0sCF0ERLeSnWSqEQaSVjSXE1wVhzyWuVKDh0dGFN/Zd0GRqgOitHewyhDj/3BL+s73n0yWTijVaTW6tte0rnqSxKd7vv9S2ve8QCKeGFbmNIa2UYkS+6Q4ZtDuv/8YwMkiglLDNswsBOyxh/GnBPSaDB6XTouEn5CTHE9umwjF6m0lMq1BxV7cOscL1I2T823tl+RuPENmwuU53XuyfICdNYuq7K2UjASqC74jSbLw/jnon9prnhBibwmi4DvXuYszYBUpnKrFPYSrKG5nSrcb8zkea1fp5vRQC442raQWx9537Gu5XzJV8U4Cb1FezPl0kbhmEj5Q2wOKYy/poQi7/x7YxQHO5j8XMtcgXCKn66EIi3LemNdQoQXM/f5fUgS5nUL7l8qZT+PRVUqum+I+OUzFKy4ZZ0kI+5aOaBlA+caoYaqze4k/ShWQGfokfAIlnIjxlrdAAfGsPcUMqs9mPJ9guGkzXZvBbcVnnGnl4pMJ/vud+y43pA2txAAvuXTkBB90ICDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(64756008)(66556008)(66476007)(76116006)(316002)(66946007)(4326008)(55016003)(8676002)(8936002)(26005)(83380400001)(38070700005)(52536014)(5660300002)(66446008)(41300700001)(7696005)(478600001)(6506007)(33656002)(71200400001)(9686003)(53546011)(6916009)(54906003)(86362001)(186003)(2906002)(82960400001)(38100700002)(4744005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?90bgbqKrFApQA26pM+n4HMF/+JIBri6lHAOxGEPC4koGfATsGnnZPr1Q8lvF?=
 =?us-ascii?Q?njHt6+1We4eSiAG9E60p7wDFQ/SBpmjTqg0k2XRbe4UdAb+MUHSMDZQMGQWc?=
 =?us-ascii?Q?InaE925dLAgXpjDGEj8E6Vn9jDwBKFqCNZPvFhEkUglJZQMJIm7Cz04Gvf2W?=
 =?us-ascii?Q?IXUjZd4tyWDMo8NVvOVHi5+OYTmgg1uaX6TJmfp6DcAf/rPRMGP2MKLcGGZ0?=
 =?us-ascii?Q?G1cfa6Jff1R7qmzqcKpMZiZZ3x8plHkIQugozbif6Ms3FI/ajqF0VvVkiB/Q?=
 =?us-ascii?Q?msog4tYFze//ZiHRlW0XokVXYuPcUmybmVlEfWm2794bONfPcKhMUbDEpGdd?=
 =?us-ascii?Q?HJEJylrcQvou++NgZIn8sYQj1o9p9dLqH7Os2q69DyKKyHGBGJWIH7DQP0me?=
 =?us-ascii?Q?K8r6+22q2akfxCYTEFIYXR+Dp792rvvFlTwHyd5vme8e0EoaZ38vYrQjPbkl?=
 =?us-ascii?Q?5XgVzXKuXYzxVuh6SHsoC7VHXAduRL/YilLjzU+6H8CjEIBzHpzlrJtZVY9n?=
 =?us-ascii?Q?hWcREas0Ry2RuT0QLzkbE20j2/KhzQwhBvAJKUrYn79uj6iJZp36bP6ltCob?=
 =?us-ascii?Q?FQlKL2TtQw3IUDeGdtUddKQXcloJeepxzqu+CNGaaKFDDIPljhGGKOnS5n/2?=
 =?us-ascii?Q?xVEfGKIRYfmAMc28C7uf5QgOm7/Dm7+Q4JYs7i4ySyngmSWe0aTsC0nhiLyw?=
 =?us-ascii?Q?RO5lsqrqAfAlhVy0ZEdscs57nEce4X2xQ1GfxGiSMCBP4em7NyUiQeWtqSy/?=
 =?us-ascii?Q?rjKcsLlFlmplgk0aoBNcAkjDDkffMtkPVkY/1R1rV9odRJ779c1LhLXQsqSq?=
 =?us-ascii?Q?+/UCXDmAQna14Z74bNSmA9h9IibadHHeSxVQppAZe+L2Lo3wWdmXjsoBUmiq?=
 =?us-ascii?Q?ZacLRqq8v/kWvBu/SYUh8Txf7bTg5vuEc1ihCwkJanUPzuLZzjAFN1llmGSx?=
 =?us-ascii?Q?mpRYCi/xGWSTmKAyTMd/3VDNRzGZ9ZAQw/Bf8jRC9DdV2Rq4qBUKX4mxIQSt?=
 =?us-ascii?Q?kPxmVD/gqQ8LTLzZ62pqaEWq2BnA0Pee3sBYKFwolGPIddoY4eX0puxDGRXZ?=
 =?us-ascii?Q?jk22x9gAMAEGYfrc03hBqiIgoBksNSQ11CdJzBn8X7kOG8/xDYaQseD4b1ja?=
 =?us-ascii?Q?8jFMiIyGFyE5a49eockLQ7mklBWU7gpF/G3QhlMO+Ih6NKYUxa1OaIfXuICp?=
 =?us-ascii?Q?4jLfrFqUxJTXWGBWLVRyx8yND7rucJ+0H9BPeU/9Ge0M2NSmNIAw2sBR4IAW?=
 =?us-ascii?Q?UMQuIjeOSozOtyuuzmc4Y9YV0RtyrqQi1QoAViX7SVyiYy+47hASIsHlK3n1?=
 =?us-ascii?Q?b6wvm5w7e69bOn0Wu0BQmG3+3OJs0SKF/odUFcG5Bcry7a6C+zeoxZqdTqDe?=
 =?us-ascii?Q?6YN1ZjJBzX+8CtwKiJlca+m0uZVxwkpDeVEnIaOM9D3ATRB53Z65xvwntDgt?=
 =?us-ascii?Q?fEQm37vlqia6V7wGycNn0l9Z09L/Dnk3ZvKJ3D2vLiodEWUXK/3zGKLx8k6B?=
 =?us-ascii?Q?1Oxnlh8Vp81j67kVDqqBWEkD5NxMgsrh0TatRSJkYXVxwZyoWhhPm/ftfNzX?=
 =?us-ascii?Q?gL9XtGvj4mNOwiQsGWv9tlCVOWNWS1AAC5KXY3oY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d84792-fb33-45df-5eea-08dae3e3cead
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 06:14:39.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQsQBwqW5vUiCN+Njv6+RxfFmsMyF71r4Q0fjp+Zc3p0581jM5xidlyMWyksnq2Cwl5Zo5QlHjrvMmrSlVVWhtNnUQxrIxbj0nymHuvOIXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the review and feedback.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 20, 2022 10:50 PM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: mika.westerberg@linux.intel.com; linux-kernel@vger.kernel.org; linux-
> usb@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>
> Subject: Re: [PATCH] thunderbolt: Do not report errors if on-board retime=
rs
> are found
>=20
> On Tue, Dec 20, 2022 at 02:30:06PM -0800, Utkarsh Patel wrote:
> > tb_retimer_scan() returns error even when on-board retimers are found.
> >
> > Fixes: 1e56c88adecc ("thunderbolt: Runtime resume USB4 port when
> > retimers are scanned")
> >
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
>=20
> Please do not put a blank line between the "Fixes" tag and your signed-of=
f-
> by.

Ack. I will correct it in v2.

>=20
> And is this also needed in stable kernels?  If so, add the proper tag ple=
ase.

Ack.

Sincerely,
Utkarsh Patel.
