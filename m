Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B4731A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbjFONhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344198AbjFONgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:36:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25630E1;
        Thu, 15 Jun 2023 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686836123; x=1718372123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w99qH5cMHeaWL2vSYUijN3yWQpcm6jZOXhv+gJb4BHw=;
  b=a3/d2F1fcjcQNY7BNykr23tOnOWy8EVBBF+D4OiV7SbhPQMnqdmTVGhV
   3wS5Rv8GDlK/G7BBUYh886y6BDcBw+7cSeKE5bIFOjpMCAHXup1uVtEap
   pSPUBXzfLAp796hrXVY+D2xS1rXTi7Hzdq26qgDVmQ+loi1zBAV5xh6oN
   xMgqcTXD+3ntzXAWa0GrH26ZXoBpEPU9xycXpl8KnjzAbFpqkmrZHGsE8
   doLJZkmUMDR1eqzClP8RDBNT5v5WVf3dSwOwcCiUVihxygCgnAQ35O0Az
   UQm1EkQS6BnpWG3uZ4EBSvtIZlTb9bZ+23iN7qjGtoIAxAnG67gMXlsax
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338538816"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="338538816"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742233894"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="742233894"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 06:35:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 06:35:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 06:35:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 06:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtM4sQPpNPKfP0fE2SA1tPk3dFZo0zuWi9EwZRC+/hpYiqqPvgvd5Cf6d/JPSu+qmCdH0OHiKijhVtv71Sc8Nl8v4bGh7DcAjn9CJ6MnaFQSefEsnelBZ9hzdoQGvrxCAwUf6Mw1gk5u+bA3RD2czppoktqFn29RfpM9v2HEpPYVF4l/Jakmu/WdodK4UIS1V1hTpbzV1oe05TICtQ4kxgbc2s8tb5rRM15OkWcZWBQZzw2nQVlUbPjxhxJhm/Ur39/XCamRGCxJObFbv/56OknzO65py2bzP2AMykSf5//1GCv09mIxcFv9Wx2sB3s9iUDKedeS5ooUgsOiITfrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo+TYnl1m2gf5tE7DXATD8ILPKDkQbXaz7Isw2Xdu+Q=;
 b=CYxMLcDleRcrYY55qAmCHABAtGbTiY9Ac4GJvxOZ0F3L/AzEyV6VN5O2CzMid22ECuSwcATJH9K2WJVANJMzeJUA3r93/y+H5CpvicjFGp+DkMX5ML935pIV7sltamzEO8TDZip6xueHfk2CnVnU48Prq4emqQ+te1UZjvEVonwZ66WQHlapWx2ffksPOJaLuzPEhhY1zuWMXfYQn8U/Pg8XEms1v60IAydoZIGveYDoHa3QpdXgBcJYTnVmcGV3Dchw+1ww7i5fQvF0k6zhXJRwUv7QXlOE3pCNgkFOy1cJFBbeVRuDNrQDU4jAVJ9O8ioIYRfLllylouQrkKKcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Thu, 15 Jun 2023 13:35:19 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 13:35:19 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Thread-Topic: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Thread-Index: AQHZn4gBPXOZzjOwf0Shiugls1EKsK+L15oAgAACIqA=
Date:   Thu, 15 Jun 2023 13:35:19 +0000
Message-ID: <DM6PR11MB2779FD7F6DF3A0126DB85E4B8C5BA@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230615125022.27421-1-raag.jadav@intel.com>
 <ZIsOvBGLJTCo45jp@smile.fi.intel.com>
In-Reply-To: <ZIsOvBGLJTCo45jp@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|CY8PR11MB6939:EE_
x-ms-office365-filtering-correlation-id: 3b1e860c-74bf-462c-2964-08db6da55cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e70GN+WXoBM8QBfaw0pAP7X0OAFmb3kIgDGkloqUtDsAt9WDAdze8knYGYtbavaZW/eGCpdaaY0c3IU5IY8Z841vX1/yTliWgTQSo3kwywpM0Sj8PApGXaEIls/D5K9KKVdLOG4zAqhM7+Kvy9nySojGE40GRW9FSIcJKkQpuupkdhtkWIhbAbPAQVntivLFZjPIUshPI7y4hvEkrr31PcW/2poOz+dGDVvoaGBm1xGAvs5lUM94FBKQ5cDgC53AEJGjT67dD+owvFoQVVhXIn+uB/cP6j+TUjGpTzGUb0AaA0zjWI8i1T2DQvRbzMAzuLmawZJKIIYLQ1CsOpzx9q8yaOL8Yx9sPZ+nOqkKDuinJJsoqp3CO4g2bKi1Li1xa4N7Ri0msyGbGj9OrQErpY/XvxpVradTmTz/7YVae4PX5g05HMQDtgYnvu7TMcolVTFo2Mgd23nXUOk3ElK5bgzKbpDOrVc4JnGtwX0lF6wFEILCpiO+GfPzpxxv60PJJCmMCXC9qAUqEWrAljG3SRpXNSLmCeAF+NmA96Eo+ZjizGbQSlryMMpZBLD+C7rVCLC2UpEETsmmE60V7PN7yJzdEOFGGXRjYRd0pfOYVZMdsdjfUxvAkP+I6dpmbGk7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(7696005)(86362001)(9686003)(83380400001)(38100700002)(82960400001)(38070700005)(122000001)(33656002)(6506007)(26005)(55016003)(186003)(76116006)(5660300002)(54906003)(2906002)(66946007)(66446008)(41300700001)(52536014)(8676002)(8936002)(316002)(6916009)(66556008)(4326008)(66476007)(71200400001)(478600001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ySQw1xrrAARAkwAmEWxsKbM9rPXe8sS5URqRepmxODKrLOxN/0xhHzbK9jWN?=
 =?us-ascii?Q?DsTKLETT94mo4Fkx8SVBY2F1XjI/oQmvA4X2acsJKLgY7aad6lJdR2mHPuze?=
 =?us-ascii?Q?olaYMh67NC5Uypi2d48H9mAM5BuGbHR6tBLYWPIh5Eo9NBGgTGEuJSajdrpx?=
 =?us-ascii?Q?QbxWwb3iRA0DeH2LJkaUzhOiS21NoODbhZGurLHkJUdfXEOai2YVcjfN0bZZ?=
 =?us-ascii?Q?ZUG9uOECoHqsRqsyBFs7lA7TDX7Ne1psqTnTGA+EBNNvpz3KMWhVsH6+ussK?=
 =?us-ascii?Q?ECZgPmWi+GamllHcy/k8ZnCxVT9/9eiEJe3YcAuEm3rayI2WwMOCYV9z75QN?=
 =?us-ascii?Q?2HIheb8/FzN+uydK7aCWCKqXx6CXLPcCrTugJkYhv3fYxaaLmgBAM9gpAxEK?=
 =?us-ascii?Q?c0oN5XOmu/UonedyM/MX9VdjMGcCa2yvDO3ebHFLoVtg30InYxCg8ZcMzF+b?=
 =?us-ascii?Q?MKgG04syFYmppAKc7DyxJRyE1pRBlRKrt7cdlbJ97D/UfeqLztSIy+osb7dw?=
 =?us-ascii?Q?W48q+aJi37kO+/ceaS/9Zavgbt3kFXNLpDwA1YUy9pbs3xQ3UFSxLuT3tsTR?=
 =?us-ascii?Q?98nU4aI90/PBcf4umVKc0aW2aIjjaRDCMauykzb9d0ujmQWTuUJPS5opVLM1?=
 =?us-ascii?Q?RavZ0jgYFG8/nGl2Plkofmw/wXOHAoFfdJ4JgDjnRBG+cATfMZMH2gdE+yBe?=
 =?us-ascii?Q?0PGBKA8nVwp+xOKiz78Um6kjlpF9EYtuuhBYU/kfWs84IBXr6oRwSMh1lGjH?=
 =?us-ascii?Q?aZmth/2nespyADfdEtM2l+xC3qmo7wtsgCLOwN2veIH8n6EG/CRCheD/hBZ3?=
 =?us-ascii?Q?+uMjq3nrdaRaARfVZpEX1GyXRGHoqE/ZKsip9ZfrJj8AiSw2AGORlWDdurnn?=
 =?us-ascii?Q?xbQfLmOUjugl8dtrr+LBUJcsmjKQbwENrQikihVh49CA9FLe6fepnOi465WL?=
 =?us-ascii?Q?kX+kP0ZNIx0DhfNNVIjvdOCkv9WiN+w3KMhBmzVHxdnJi3JcWXhCkp/1hRUA?=
 =?us-ascii?Q?PomiEtHeHRUv53oyFAHLKK/2FDZ3Fnw4OYGmg4az3ufsIy9gHvAm3WOteg9n?=
 =?us-ascii?Q?+RF1G9bENQfC93yO1wihPiGw3yT/KifrUpgCyLYRkMLxQa9sz6Y8jicUoKHD?=
 =?us-ascii?Q?NH4XAcVIlHE6g18uPCcrYcT7752x0HCZlMHW2Dwdow4xw+q8fyPl/S2nuo9q?=
 =?us-ascii?Q?1cXzziT75+CA9uEDdc7O12veCb1TVh2ftyNUXdsLdwhX8Yhx7wbVx55s/Vnv?=
 =?us-ascii?Q?uNaH5k8csx/XoWaYN3uOulSKrm7cJFlwCOLPqg7BHb3sL+6BewriBrhkS0Bd?=
 =?us-ascii?Q?rdiw8VaW8RoAuxBiJwd1PRNh8VWl/+zYMlLb1KrWpLFvJDVMLDI7cKJf5vML?=
 =?us-ascii?Q?xeII4QlQ2uTeAX3D4erVBUJxk3vNG8XZ05H4CPWz7Os7cwIy12lc/qyOGthu?=
 =?us-ascii?Q?WkwQz64jGOe7kmBGQI3aJ63V+dTC91H8caHCSnM7M3+keYdFRfdHAsULrM9b?=
 =?us-ascii?Q?DSiQdxGfC/Jw0Sv+54rronb67gIHmpoZkzNG9B2TYGxOLYgrlfLgFsCNa4iU?=
 =?us-ascii?Q?JP6yapoILhNxSZYCjKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1e860c-74bf-462c-2964-08db6da55cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 13:35:19.4490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35jTNLQKP4tjA+9OPFykyoyAe19h7oFOcywWe/hcholfoiZ1A3UGYYrZ9dpi2YzSq4aLWhy28AEX72GzWr2dEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 15, 2023 at 06:20:22PM +0530, Raag Jadav wrote:
> > Refine ->irq_set_type() hook and improve its readability by:
> >
> > - Reducing scope of spinlock by moving unneeded operations out of it.
> > - Dropping redundant PADCFG0_RXEVCFG_SHIFT and including it directly
> >   into PADCFG0_RXEVCFG_* definitions.
> > - Utilizing temporary variables for common operations.
> > - Simplifying if-else-if chain.
>=20
> Two questions out of curiosity.
> Do we gain or lose bytes with this?

add/remove: 0/0 grow/shrink: 1/0 up/down: 33/0 (33)
Function                                     old     new   delta
intel_gpio_irq_type                          317     350     +33
Total: Before=3D10469, After=3D10502, chg +0.32%

> > +	value =3D readl(reg);
>=20
> > +	value =3D (value & ~PADCFG0_RXINV) | rxinv;
> > +	value =3D (value & ~PADCFG0_RXEVCFG_MASK) | rxevcfg;
>=20
> Same question if we change this to be similar to the current code, i.e.
>=20
> 	value =3D readl(reg);
>=20
> 	value &=3D ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
> 	value |=3D rxevcfg;
> 	value |=3D rxinv;
>=20
> And I would keep blank lines after readl() and before writel() since we h=
ave
> more than a single line in between.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-9 (-9)
Function                                     old     new   delta
intel_gpio_irq_type                          317     308      -9
Total: Before=3D10469, After=3D10460, chg -0.09%

