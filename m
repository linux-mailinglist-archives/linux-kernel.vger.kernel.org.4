Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F86876CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjBBHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBBHyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:54:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38424CB2;
        Wed,  1 Feb 2023 23:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675324478; x=1706860478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P0pEkl7CvEBl4dOJizTi1Rcn5N2DqC907PsHri9cZ9M=;
  b=NbOSLu4I6yZjPf6/f5M80vPvxAW0x/3RVis1xov0v9hgJDRWmHwtTUA/
   49I1+dQo8pzmWu5YHiBxsR5MZ3TDVQAXV3AXJBmNBsFM0azHgFqZXofJ+
   iP95W02hLOTcYAy+O09wuMx3mnE6VEvoj3eNDkbr1jKFo3AKZKA+GCkch
   tyB1bxZY+68i3qCptsROgxZrDN4tI6dlZ2e1jT7bitmkZtANIPsUKctTD
   sYq3jdxK8Zfn9hNa8YGCxWjkYrG5YzkZQ4QgdpxM86qD6yvij7uSB+9ks
   Ku3b9ERZtlKYttlXTFheIqdGOtUYwR7hMHUyjqd3PTtMFbUF2w/A3ud/L
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="328397912"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="328397912"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 23:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="697598485"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="697598485"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2023 23:54:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 23:54:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 23:54:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 23:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf8riTwS2DClZX6njfI2NozPVV9tjlK9qeYHqWmLoNp+kFiU2G+zTBHEZH6EXyS8eXAV4l5d0HUpdnYA8lP8NqdsycQ8TZd9stuBytqbXi0yhmBH+CiddEcDimSYOL+ApZBR+DMflwKoTenDB9r+79lZBFM2K2m0cJRBJGauD26ptxG68rD0jd0Wp2LBtvrXUEBXsGINhkD8S8b+5FfJOn1N9+7OvdUwDHtN7UmcA7/21TT20O1M1CgSNQUtBimwZxky7Qyr6XX28Kzt9sJSXv6Fup9wuq5a2pBezt4ry71J3yXsICJtv4Gc51DG+24TDVj5qvtRYT1T9pNR7q6cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0pEkl7CvEBl4dOJizTi1Rcn5N2DqC907PsHri9cZ9M=;
 b=m8lIqeNql0VkXfpNkT7oeH4DIPHZgML4PwUzaIf1PUxQCFY4pMA1Blg0r7W/LDuBYJxFzuKexvDPfa79WskDsCb8w0kdqzSCyg348JmIQwXhvzpFL6Qr2k4E2EVdORMx61PTxij5A0nHO3t9AE566fZNqwiRImFVMlPpG43TVHtHVBg/7YLUhN95p2obkLbbo9aRPJYEK6rxV1onyL8Z8vZe7H5kniy0h0Ayfs/h5E7PjRVP1Ml3ozc8RXENB9wGmYLc00oJsLWBPoRgQShGSxLeaCaCD2+iam1y61TdgDwbR/HvUb4bam7eJsSFYd14OkzDUp5U2+XL9CzPHVkong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Thu, 2 Feb
 2023 07:54:31 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e%9]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 07:54:31 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: RE: [PATCH 01/13] rcu/kvfree: Add kvfree_rcu_mightsleep() and
 kfree_rcu_mightsleep()
Thread-Topic: [PATCH 01/13] rcu/kvfree: Add kvfree_rcu_mightsleep() and
 kfree_rcu_mightsleep()
Thread-Index: AQHZNk9xqPIV1FPN0UeasOQxTpt8Na67Rzwg
Date:   Thu, 2 Feb 2023 07:54:31 +0000
Message-ID: <IA1PR11MB6171B7FD584BC5546714379889D69@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-2-urezki@gmail.com>
In-Reply-To: <20230201150815.409582-2-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|DS0PR11MB8049:EE_
x-ms-office365-filtering-correlation-id: 9ed9ca82-e061-4202-a346-08db04f2b7c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QppphLMUTxRknVqdjPcJ2UfbfCm4tLTdcZl6GS8FsNnjxKmcu5R0/Xf4aOz/2ovqWEw1JDxaQsf5Z7Zi5vSfDs77HEoOY31H2ij6yEkVuCJJ8buPmdER4Q8B5xigfP8sPQZVp1xWhjAaI2gdVMC7HYxmm2f+3ksbX3ekuiUETnUfBtHRTAZNaw2LOh7zjzRGZatppn0r7dskkOHaUYIvQqcn7B1I7dcdNhQtoH68PRr02MGQAAgdB/uWqS29XDAuzCUYgcvYLcEegh9A0XQgoPTzKsa0dQyH0hXHBBfElHZD7Cqbd+O3PP6D90BtscUnGVjgBcgu3WyAM/KAgI6AxNDlK2elAYHKk0zk3r2cUoiPTTdXPfrvojwfbO37R4KP+5erO9vgjINwjJy1u04VaxWNkJud6O7WvMxdZFUrUUOiMZBIcGAjhMDLOw2Zr/dNZC0kAYgNxo/s2MKarynn6RtL09ZjWsxSOQwgNbgppId7EZsrUNPqJV3zGnSZqDyKs3WJaQqKEUG+vl8phuhoK6j84e8MmH7U8zaXSRVoHEihd+oZHGzwbaqAbshwvOQJRbrlMFRwNY3JPyhWVyRSIJ4ciir9KViY9ObypBAKYfscva52horfxO8o6ZClAxzzS6Mz8k+0Ij6cvKyLbZ33VdBpU+/UCJTkHBdZYlXIg1lYo9+GQM6PkX5wMHuKX5B2dEGVjDIP2o8eZhlD83EXfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(52536014)(8936002)(122000001)(53546011)(38100700002)(86362001)(82960400001)(26005)(6506007)(71200400001)(9686003)(38070700005)(186003)(4744005)(7416002)(33656002)(7696005)(55016003)(5660300002)(110136005)(478600001)(2906002)(316002)(66446008)(8676002)(54906003)(41300700001)(66476007)(66556008)(76116006)(4326008)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tp8aJgGbfsggdiEdgKJnYhHYhbkbV2P6u4ZQ++0yn2+ovu/OnjsESsa/xHW7?=
 =?us-ascii?Q?9wVLFXrbbPSBhfMVdIGqgdhXwdgR9ZvLcgVAY71THdCS4yv0p3Cg2ezVuqNS?=
 =?us-ascii?Q?qpIZ/IsipnWH0/lneurDblXNMpHX0Kj3PA8ycnNoRb1xv18irt1/8h/pRtCa?=
 =?us-ascii?Q?uNFrTCnDH8IJ0IkCHvxUWHMniblzohzLLNxHvrpS3RKPi+jttWFA+fj7Bh/V?=
 =?us-ascii?Q?NJLE5x08VLVQTGVx/tCvdgyEaKHxAFa5Dzp5rNn//Nmml0Td2NLqTa8P6Bx1?=
 =?us-ascii?Q?0+7r8aWo//RtJpqPNkoxh5NnOHGs2cSzJ5ons2y28en5z9wagtVxSkq+Eh2S?=
 =?us-ascii?Q?nx/nIlZfHm1iSfeP0m0sJ3DOHAIRidtOu15rcMo00aviRt9JZ7migsEPkKSC?=
 =?us-ascii?Q?9HLSFGKJlQS3lkRqDO6oCpa3DHZ8HtTM+oFzQYSLwQRI3vWeufGLP+KGAxUt?=
 =?us-ascii?Q?d6jP35SasJ1pTZrbmWigK+zwK9Qr1O8ASYrVfnq0lfFXb7HIBAYvY4l7s2YY?=
 =?us-ascii?Q?ungzed40FxcXLpHpJIPL6Aia0Ou7GSzK9t9ahWnpYjrxS5B0/c9VAnYJ+ACA?=
 =?us-ascii?Q?og5K5oGVXfSL0UVddi8Vzi+HFE7IZBVhxBt5uaDlfqXT0rdobn0PtVnIlphL?=
 =?us-ascii?Q?4nz1FIbZK1ieOBrsyi098sY4JAwgw8ewCHgfYDp1K0IUkmQd7RZ6nEi9I6Ax?=
 =?us-ascii?Q?vVMw+eJvVlFDzgf2hCvBib/ISl4+mku/QpBpwPQqZzmEwfDWVyjRXG2mZp+z?=
 =?us-ascii?Q?fmRN01tYqQzh/1lXdAI3LBvFMgx4DlTRfiCC4dhOIludA/HIljgbJAUL1AHb?=
 =?us-ascii?Q?0j0vENDmlZ45/LEkBivhDrnoA0R+QEiF+6wXYtDqsP7LPS01o3iBvZn33j6I?=
 =?us-ascii?Q?hA0M/nH3V7b0eCnrUzc4i9iSoGiGehprEi1HG43UHBG6URNiZuZHA6kqleO9?=
 =?us-ascii?Q?fa0vPQPvNuxb0C/HFr2gtg5bWdAphBhwmUnoL4JDbn3+Z27VARpV8j2T5yR6?=
 =?us-ascii?Q?7ZxLWV3Q76sif3rq4DtqEtD+u7u8eSL3VN4jIXO12KYp+cO9083iwl5h0X9t?=
 =?us-ascii?Q?93HZpMpBeJMt+0TUd5KvZrMJkfvQ8HE+sr2uYHhXGw44B3fWEegdkVOInwBX?=
 =?us-ascii?Q?3utHYg4ZXOt12YWL2PPvzusjDNstCmvNVlpa+h0LytKlyD6S54K/nKRqFRKm?=
 =?us-ascii?Q?LDG/lQ5yIXAf0OTbV39LIRhKkdl2/QQm3pk968jXsQY7w6Laj1HVs5EptuMP?=
 =?us-ascii?Q?3bZydC6pLrDAVS1YApVPbB9FoajtxUUz0SQPnFpdB1XAyrVsGJCG1TuAGSmZ?=
 =?us-ascii?Q?Ia4N6koPFwHD8SqirDAj9f7OZsS1+gV4W+61YoZ/ZsV9/aTKi+bo8aHiDLSh?=
 =?us-ascii?Q?WtdFp4kRkTG4e7HYyqbe8oFaUT25zhrOt1g5Egc85KQVGz+mHKOtwGdHYD7k?=
 =?us-ascii?Q?x7xvfpvEuvUoL2AnLPSKyMjgyTj5CGa0goyCAR8XJt/5dHqdqCxOYekLc5+s?=
 =?us-ascii?Q?Zv53uMpJClFBahw9SSK7uVzV4WZw1qdn388n+gFan7u3StnS0MKXiMQVn6RK?=
 =?us-ascii?Q?jFl0Ueo56Y7QDqIn+SsJlcSBtQi5kCPQzn4NlWMI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed9ca82-e061-4202-a346-08db04f2b7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 07:54:31.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyZ1KFcRv2UWT5/hwkmsJagelLOirsjhTYMxV2/wRfD+HOv2cQUvkpL9YT8Hy29d+q8DTS0ofH8+dCzv20vSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Sent: Wednesday, February 1, 2023 11:08 PM
> To: LKML <linux-kernel@vger.kernel.org>; RCU <rcu@vger.kernel.org>; Paul =
E .
> McKenney <paulmck@kernel.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>; Oleksiy Avramchenko
> <oleksiy.avramchenko@sony.com>; Jens Axboe <axboe@kernel.dk>; Philipp
> Reisner <philipp.reisner@linbit.com>; Bryan Tan <bryantan@vmware.com>;
> Steven Rostedt <rostedt@goodmis.org>; Eric Dumazet
> <edumazet@google.com>; Bob Pearson <rpearsonhpe@gmail.com>; Ariel
> Levkovich <lariel@nvidia.com>; Theodore Ts'o <tytso@mit.edu>; Julian
> Anastasov <ja@ssi.bg>
> Subject: [PATCH 01/13] rcu/kvfree: Add kvfree_rcu_mightsleep() and
> kfree_rcu_mightsleep()
>=20
> These two macroses will replace single-argument k[v]free_rcu() ones.
> By adding an extra _mightsleep prefix we can avoid of situations when som=
eone

s/prefix/suffix

> intended to give a second argument but forgot to do it in a code where sl=
eeping
> is illegal.
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ...
