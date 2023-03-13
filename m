Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA036B796A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCMNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCMNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:48:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4E1CBCC;
        Mon, 13 Mar 2023 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678715307; x=1710251307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jo37JS9AeqpWoXK1jvb6JY5OqNlBLUaFtJ84POEpuYM=;
  b=UyC/DE8fjB6nFwduNkFdW4xb9YhFgl2eXIiihdNNvD58tlkybBT8nKN3
   tuOGbBea/Fewt09GQ/jSe3TDSBaOvo8/SRQzJ2wZZK0RpCkt5HCJgHuno
   ap+8mPSagELZxaGBcv+x703M2wcZspSTtrHZNHmDw2N5LxzKx21Wc/lIE
   2OTP6hCkne5oOgGnbsu98xIcnuoXTuOf7CbbSq15aSxU/1fLS6YAMh9pG
   ukvyasVhA7OBjDpj1GBxSVmMnLibKMSKTvHR4X4Q3RBPChnmcguATZ0Ns
   jPzDBXmDrOPRDnlM+ARWx95MgjDXCxkQt/5G8MA0VTz7wj1aU8m6PdMOB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334623614"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334623614"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="767697155"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="767697155"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2023 06:48:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 06:48:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 06:48:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 06:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/KKk6JR5hbj1/sUUKddK0ZIpsfA9cjuVjtVxcUIFJFZ57XD9W7vt88wW16J6DvuzveZdBbKJWGtXf13wRZ/cVx8jzhb2fzLh8byikNEpmrApB0MkzHcjUzB9w42HBkSvq9b3dEJtzeGAtx8rwa1/rlZpv+9WuZOt2wQRzos8XNJsluEEYsZPa50W4m+7bBrJF3gUjJoBqJUxSxoc1lkW4SKSjnxIzaFZOg8yP0VyVz780PCtHmsRCOcz3GCCnmeHKEFkJJj1go1u47EWnDVQkXQjmSjh2b4RI71NqxCtSj91ghgP8O2V3V1bzX1WjRCKcrDBSWXe+0wWJEpsy2YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r6hCpYV/7CNlQnPuhZ03W3SQmrH7ZGqNC1p3dRY4lQ=;
 b=m+Lyxb/N/08RzKRspF4VISj2ZgFEOVY0tMSJwXBnj4IuDte14VH2I9CMpGlfKwF+dqCER7t5x71EGcAlniXpBvzDmjVQSOq58iLxsAMrGAUdnuY672R+JcUUhHdn7Jp0t8Imk6VW+s2w0/OJSWKYNkH9Xo7l77uUts97s4REuPbObCdvHdzCnVKJDA8SL1jT4guXbr40iopZj3ziem6m3i+mBK/JBsuB6lSJgmXy/OtQPjvHLsYTGjJtCe7RG7rVQYikJGid/T6JsLeIkIWfZzfKl/1Tt07Iahv3oIHTvm+H0xFB1u/KOXyIZHROankNihESG6XtTDXgBH6umlKEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:48:19 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:48:19 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Topic: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Index: AQHZThiYp3MlrzfqvEWnd0vYLxlOHa7vTckAgAAKtYCAAAJrAIAAPq6AgAAWxoCAAAkkAIAA7pKAgABU+wCAAXQ5AIAAmpIAgACz9gCAAWhKAIADXoaAgAArowCAABOeUA==
Date:   Mon, 13 Mar 2023 13:48:18 +0000
Message-ID: <IA1PR11MB61714FA7A6FA92307B7FEF7C89B99@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636> <20230309221056.GB148448@google.com>
 <ZArwZjcEYXAYwmqi@pc636>
 <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
 <ZA7yK6iznHqiBu5i@pc636> <ZA8WxjUL0eUPtVy8@pc636>
In-Reply-To: <ZA8WxjUL0eUPtVy8@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH0PR11MB4904:EE_
x-ms-office365-filtering-correlation-id: 9d6f1353-7a53-4d6b-dfb1-08db23c99a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VmCT5LswW7GX6OLJudiwjVmSD3fovo3YVsJi3ZIhhQDcNcg+xCHL8lSiwVwa2s+z3dBZJ1xW7dwv2zLifsJ+RM0St4R8mHWU1tnQmHl5jVmaEz9sq0nlcrsPwHBAXtYpj0utbXepxtuYrXES71NqGE7Ni2AqneQfN791Wk13epAeaDw975Bf1ShtYIdIweOV5wyYLcOupRnloJteDq3TH8ObmTywJsHv4EE/vvjEfZ5iaSVPnIlFUURnxrQtkLcuXg6pXpLuFnymnkDgHawYQFKMcxP/bBmt3oOag20U+XMHbpJJI9sPWB4YPRRZELLdCQrJxiOcu8oXojApvgUmn60A+GF8BSvY/QhzF7RCMA7Mwu76iJwnw3US8/IoYndclNVI6t2OMKzP2YgKsh6uLUXDwE10bX1RyixwfHqcTC2Pcs22xNfu1mHSLc9NF3zbF/qQfi3vbXMXxpQupBHY/su9zzEPJe+j2QnabHETvaTVcPAc8idpMKLLjq9ph+DDlgYxJxqqTBNOBvRdmHD6X/QVgsS50TFQ8Ws15WZupvp17wD45hXvmks3KlPu9VaCKiEqstjAXlstRZcDFjpxsYzIwdynxOdEuN5iI6aA2lvkHRX9B3j3eN+e7zW1Cx4h18r/qqNtdC9LRcG2RteiZvxASkJxrgFx+O2r7vAu2v5rErHojFLVzXPREzAmMxwBmVphqZeVTGa1Sr60wXkLbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199018)(33656002)(86362001)(186003)(9686003)(41300700001)(4326008)(26005)(6506007)(5660300002)(8936002)(52536014)(316002)(71200400001)(7696005)(55016003)(478600001)(110136005)(54906003)(64756008)(76116006)(8676002)(66556008)(66946007)(66446008)(66476007)(122000001)(38100700002)(82960400001)(38070700005)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oHHr49i4vR8DGFeaH8z/vIStQrrBKqNyJk1X8ut3ygjB4kyL8TLj5Zl/TVdj?=
 =?us-ascii?Q?DQWULw/wRFtoLKKs8cAfbWDdUXi1iZ6ZHIsH1LnsnHUkDb90YVZ5eJ9m3ixC?=
 =?us-ascii?Q?DJIeUI0pkRda4UbZy5OjLjHPPoenqt23u88KLXQPNFzOqvAplM347KEsKz25?=
 =?us-ascii?Q?jL/NDbY3JKmfkICELigpSEUBn55bYqJItbO04CnxalF3gqu6NAGD661+iitp?=
 =?us-ascii?Q?hKVMNLBXZ4bxzlMhBlF1jD8FsYz16wx9gBw9tMbcIs3oiGIwUcFR7hCb5sxv?=
 =?us-ascii?Q?F4NSRREc2Rc6s7Z1d9A3r+kAXn2jjvTt6QfR3cgXjSWfYayu+MllE4YpY+Cx?=
 =?us-ascii?Q?opMCKGUsZIVp5clE2FWAHuGzmbNzTMIJXy0LX5oveE3amtESYy5jsTRfc3+l?=
 =?us-ascii?Q?UttfFQB0zANVz07fal4mHOeWf9AmleEq6i0tX446R9iG/+cYd5XPCtUcQMfX?=
 =?us-ascii?Q?IHEOHobmnQQ29A0m5buR4rtIuHxiWNxSuq8nLphsoo0guWgL7rb4Xx1KvPOG?=
 =?us-ascii?Q?iLYGpuTg/+XsbnUpRdZmlBd4zt/GJ5i1LLDKKCOGFEb5XRs27bCp4KwiQQ3N?=
 =?us-ascii?Q?06tXKP5zI6N0MESD49xRaaMbSxCBOB4eaVi44MVa8XmHZrP6XAWFKt97HDzp?=
 =?us-ascii?Q?zcPyp6kqVBYeGvp8sqd+PQMz7JKYB0oTvIi5bUK6D96glTp7uQ5ds800/eAd?=
 =?us-ascii?Q?IAfCEZWQ5MGrWthnd4FiK0SwZolOx180N6WMxZotYgihYzd0jvJsdNZWgp/y?=
 =?us-ascii?Q?KQBjvDHm7nwOw0uGW8Q9s4UwfKJpYk0Dx6PYzuAzKXog2CVbbogHY4PZI8UA?=
 =?us-ascii?Q?zKWIMH51Li8MdLDccAHRn7Ngil+eJHxH4KTli7+hMeuW3xI+hFCCPrJvPfvL?=
 =?us-ascii?Q?Du3KDLMid+dGMQiLqITJeM5xu50PJS184CrL3ONA6DzEO11QrSprFkkr1H+D?=
 =?us-ascii?Q?0g5tZUk18Kf3dv6jXgZXEVZ54FCfY1adfo5MBWPsEAxEEzazZEKmeOZAbbZs?=
 =?us-ascii?Q?9mBTew5vT9nbo6t+k2wSmjRlOSIUWoAj/oFAouDPKm9gy2E1HVuj13qslpzf?=
 =?us-ascii?Q?HDlrBGDN4ocoz+aN8b4Pr3wsEXTck6kMYDckVJo/7WNgiWHrbCh8gSvwr3+T?=
 =?us-ascii?Q?wPLJZIoxRGHc0S2pjmGJJk6PHgsATG1WOc4D4kG3eMVNJeyTEbvVyV3545LC?=
 =?us-ascii?Q?jM+gm9hWDS7wwyxlzzIb1Vr7OYtOQHyEPgs2G7BNeDw20Tx/1ay4L6ectKJD?=
 =?us-ascii?Q?OpDYMR2JKIrir8I+fHfQQEF1fp6e9AKHOzPY0tYzVurISD5yEto8IglBv8ix?=
 =?us-ascii?Q?rVk/y8XLI8hr1XtsyNral6A7xA2iSMRZ9d57StBXH0PldtewiLTSe3IAZ2lR?=
 =?us-ascii?Q?KirtxExkb7ufA0BbpFxJ6OrgZJtEJN1XA6pvWzJ4rPez4nhxmXeVUxenx0TB?=
 =?us-ascii?Q?2yMOsQtJCZB4WcftcczOkexCUq9xQoBo3xbC80I+WTfmqJ2A3sTBbz0Ou0dj?=
 =?us-ascii?Q?6n+mewlJnMyuIFLP5Hgl1UholJhB3suzuaUMkpuFiZLivw7A1tn3q4DRDMKR?=
 =?us-ascii?Q?sivJTu0O6gnPeT8HKvDZlHR8+pyNaDik03MLNA5P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f1353-7a53-4d6b-dfb1-08db23c99a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 13:48:18.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1KxpVkvUn4HH9cYJ91IX/l5K2eCQlTicU9Y/DmM2G5RQVUpSqF5gj0yaMLo3F2d+SIY9XXfzDxiG3f/H3SoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Uladzislau Rezki <urezki@gmail.com>
> [...]
> XQ-DQ54:/ # echo 1 > /sys/kernel/rc
> rcu_expedited       rcu_improve_normal  rcu_normal
> XQ-DQ54:/ # echo 1 > /sys/kernel/rcu_improve_normal=20

Hi Rezki,

I applied your prototype patch, but I did NOT find the sys-node:
 "/sys/kernel/rcu_improve_normal" on my system.

What is this node used for? What am I missing? Thanks!

[ There were only "rcu_expedited" & " rcu_normal" sys nodes
on my system. ]

-Qiuxu

> XQ-DQ54:/ # exit=20
> XQ-DQ54:/ $ exit urezki@pc636:~/data/yoshino_bin/scripts$ ./test-cam.sh
> 533
> 549
> 563
> 537
> 540
> 563
> 531
> 549
> 548
> urezki@pc636:~/data/yoshino_bin/scripts$
>=20
> the taken time to run an app in milliseconds.
>=20
> --
> Uladzislau Rezki
