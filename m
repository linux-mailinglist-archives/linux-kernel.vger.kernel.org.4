Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0174165A9FE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 13:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjAAM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 07:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjAAM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 07:28:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9432625A
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 04:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672576075; x=1704112075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Pr8hG2psBm1PiU/oazIp/oK7zkQ5K5FoJJeVP82L9Y=;
  b=iRAiKT7xrG3BxhJFhdDlo04jIzK2YCw6lP7MCM8SJhpNnoee/NiNyogz
   jr/za46KU2xxLtWLM+mcOgCHZknnm4IvaUSkhpR3uMiDns+yH7E32M334
   8GHd+Q8oIEpiBdKCOyCHnp9XmlWwFr8Byicrh0mOKovSd7VypxP3sJpv3
   V0hIBPC9OWGkejF+CE3ZCbdQWzoawBDJD2SVcFR08Th2ZXsaGYGrXiUHQ
   U3by8mKLlSsQ6IPZtm3MQnZHvMyp0Tgh+AmIqjkMqF7rNdx1w5tEhtS1+
   BjtL93vLVR1aVBB7cCWz5lEAxxpPr6h23HPrkFLXDvJ71kH1g3/gSPRda
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="385816317"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; 
   d="scan'208";a="385816317"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2023 04:27:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="761715309"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; 
   d="scan'208";a="761715309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jan 2023 04:27:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 1 Jan 2023 04:27:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 1 Jan 2023 04:27:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 1 Jan 2023 04:27:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAPz8QlCSEgH3vIxrIkh1habjImwqr6KIn9nLEzWNR5NFLAUvz27n5bVudwf6ajLX05LTNd5wWgcgV4q2WOVOqucEB+ViQPwwnt3x4/7Td1iAoXHELHIyTYsixORoQOtCQ75kHL8f+KNVIQc8jsCh9DAUJMElr7oKsJA+F7LZVSAJOlwJ1UI0FV/9VpBl/wdoiSq9YpJNxFbW60zWjQ7lS9WIaoOr2JtN39rnTNFZn9yfIqCdR/hTJxtQsebopyMuTE1Db3HeTGaa1QvjvMjj9jOcr6wizrZfCDKvWU7Gl3R2Qw+htutvjmFKxq1w2NYTkdosrcoBzxVq4/8rv8drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skc7nYg+hTtTjoz5B6PdlbHrc881VRkm/8H0ZE9fKLU=;
 b=l9BH7zrLQzl984+qeWVj/GtrAgLh0JFuwjl5MYBhBCYuehSBsBoYAYHtwyur4czHgtnInov6BMIxLoxXOjR7fIxbIByjKmQc1LsREXwcry8eRpnpGTiCaFcIbBuTmZXVM7wQSGAB9XAhCdIA4QdqlZKfx2hXgFpuugnBqPJYd+EuCMcIACAT9ZJ89y+F8mvH7ms8rjrRVdKg6cWRFXsMf/xJcYy5MSGJgbwVMMmewg4+sFieMIzFX68BMGUKb6hiQUfQS537BPDemjIym9F3hhfqwv9YKS7hoQVLu/wEcW+lciEE7cjngmfa+ycGo7dQD6k9TO0/xlUrCLiOf2UG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sun, 1 Jan
 2023 12:27:51 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::96fe:3ace:6917:1dd6]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::96fe:3ace:6917:1dd6%4]) with mapi id 15.20.5944.019; Sun, 1 Jan 2023
 12:27:51 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
Subject: RE: [PATCH v1 1/1] misc/mei/hdcp: Use correct macros to initialize
 uuid_le
Thread-Topic: [PATCH v1 1/1] misc/mei/hdcp: Use correct macros to initialize
 uuid_le
Thread-Index: AQHZGtYXcHWV36/kLkObNr2HC3mdLq6JgzKg
Date:   Sun, 1 Jan 2023 12:27:51 +0000
Message-ID: <MN2PR11MB4093FCF4AD5486647237BAA2E5F69@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20221228160500.21220-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221228160500.21220-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|PH8PR11MB8062:EE_
x-ms-office365-filtering-correlation-id: 9f424851-5ca4-450c-1264-08daebf399d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6HQQsZ5PejzMdd1mx+PdKsn+Cm372COc4TUn3eHZqalWHyPAyb//rZ8G7qL6HfxCmBh6BZu6K+WXtU00tOyCvSXJohKva2hwRe1ZXXkxzNE3ph/RLx9jtYRW6gwtS1Lyl5vna9aWN3tYG1HjV03g9xk6Mw957ByYHcRm3MqBwHKcY93eognMjwiiXg+RCIK18difdCA2Vcnx4mh/cY3H3uQ9PX/4ZwypWZi5kOxNdmGgFlh8DnJt1MTnIRtesuO1dbc2UbQfj7aC7HKHlLHL2JZZphP7Ts3PbnUtxzZiO9aSo2MCOVh837WzKCtzhO6g9QkP1nRytNnGmlnfrCAt22DLm32MLO/VkqIl664UfnPc6pGyfFvq6jsOjl645JtFkPUNSXyoLrDKJyGbifUFpjQk19I7ipk1lVMPUfeytzhc/moV1Mzogok8PqfeCPKlwBpjLHMlz2F1dxUH6ThzrIddumkHGBof00KML2A2r3eiiwfQdRAyzfILUVOF4UOaI4MMQTaaIZ5vC1OXE3mph9Xf/ZqbaUIFTuLkiLw+V3F3t/znw8T81XTIG0b6bPl2/FLeamz/GgsKsYl++qzLdVZ9kz43TVX4SWACjKfXRIJE3hnaSeEt64/QI8GAjfQk5fTe9DT2GZiJ/ubTzhUqBaIqCq5jXOYD+3X3m7Oj1e8/tOKffMCU0le5uH0XAephuq7YG+1fnqM0LRZgZqiulE6F+3Xs5HY6SeEgoR9wto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(122000001)(38100700002)(83380400001)(86362001)(82960400001)(33656002)(8936002)(38070700005)(5660300002)(64756008)(66476007)(2906002)(66556008)(66446008)(8676002)(76116006)(4326008)(66946007)(52536014)(41300700001)(55016003)(26005)(7696005)(186003)(9686003)(6506007)(54906003)(110136005)(478600001)(71200400001)(316002)(22166003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?32PL+tBZoui7BP3YMyAugxs6N7FoRIdsxFys7bUSblbYBAriDtziy7783dDk?=
 =?us-ascii?Q?aQOem50HxM5/S01rs7jd+PMch3htpG3MVieJ/HhhIA3BJsoBgr8Fy6k5lUZT?=
 =?us-ascii?Q?v1WepdEP49ra9WmpIN8RfAuZjfdsZW/SgQYZhHIS01cpeUBdC/WCVeaTts4q?=
 =?us-ascii?Q?pSC3dccaDQSZgbeX7VPWiRFSyWlF5ZCc4SOso+0r/wQccbYUefxRpWyeFPgg?=
 =?us-ascii?Q?GB+bwqlAL9ZOvMjfMVDMxqa4EelQWvlMeQ/KC7mwj9Jykkuce+XMSzXeXtj6?=
 =?us-ascii?Q?+IyeBOA3bwskAeaAXCUqNWub2XItLXTLNEwkf3B5m3YBpp94vXWze/lgmbZC?=
 =?us-ascii?Q?gvOGKvOcbwCP5k29gF8JlFAUF9sZVU5lck1uZ3ZEl97RN+Vwwo/Z0ipgX0a/?=
 =?us-ascii?Q?lKM77mk8WBnZxF02NDWEwcyOln1ERjHqHgC2+nu62hbrFmcxx3z89AINUZE4?=
 =?us-ascii?Q?MCUpKDtZDZhDLHdhNgfpwzx3Z83cJYeEd25kERQQeEEBtkobwJ2ZibAUqdLu?=
 =?us-ascii?Q?zQbPsPyrhcrK2qZG/HUm7PrWUpl+GU95kkPBmOIj+6pVe7jPrWJoNf37OD19?=
 =?us-ascii?Q?8i8AOSc2r5P0tDw5gkYeMEo0qy7QHs7OU9FQP9GqXVPvObm9jtds8ZggDzwt?=
 =?us-ascii?Q?/4lqgNR8XKDWBj9PaNKkhFGusLK/LPVXrJk70vRKNCeXV01y1bPS2DGir0ZY?=
 =?us-ascii?Q?IY1GDvLqnf9jM9p75aFP7mXzcHexH0tUQLiT5ID4SAWoL/wbfW6H4WqnTwPD?=
 =?us-ascii?Q?7jUA0Q4WEqGy5ZuaofCspl9P4jME3pO4LW7Mh7wgvO5MO2tvjIP7BuVQGx2i?=
 =?us-ascii?Q?oNlloECKPjT5WIfUEIc5Rr2F+7YYS73zmJ7tQOy8aqqsEKa4C+oSR9/zi2cD?=
 =?us-ascii?Q?y6OKdjUACksNjAt371LdNKIin3JDEEk7qOjuHbXa3ATeoW/g3/m7YKCyvVtt?=
 =?us-ascii?Q?oU2pDcLDxL3nC0cQeswrLkRiGuf7xotgVtoVGMWMl/bYV9GtHzt2BUsw6BaI?=
 =?us-ascii?Q?vJt7bHumI3RFYOGZyq4HjlumDh7ugmPDsEobXIKZNO/VrwO8RsHkXpUEdclg?=
 =?us-ascii?Q?PJzk2Y90N6Xj8Mj4ZYu6uVtpLUZJSQok0DASJSbqEl3LhrrOds2vzHns/Ntt?=
 =?us-ascii?Q?T5QdkBIDYzsTRGSxYKRg/Oz1psdzMo7rJEqkVgUjsTdVmteYjknpPeR6Qk4f?=
 =?us-ascii?Q?mh0KArOs1ck9rSGMsJ5ydEHIpkbJjo3UPlNYox4korGLwzGE7XR1oC7FYZgL?=
 =?us-ascii?Q?NkdYh1okPIQGWqo0ZF22SJBfufqiczus19mAKvhjvI7dX+w3V8Y4zHYwSMN2?=
 =?us-ascii?Q?hOO9gSJ6AncvIk4zRM/+itPw1hYuA0A2RNtcY3VaWP3TvrIhuChTTVzrfV+w?=
 =?us-ascii?Q?+S5pC8hQeUZ5yLSp6rxuajxnbzzvkTWIAIwxUkpIgwjXnIzmiU/51CZ7vI/z?=
 =?us-ascii?Q?4WDI+MtnW0ei9KdWBQbARk+rpRjyqpNY7WjZpKQJdckBzcdVxOsJV+55WDls?=
 =?us-ascii?Q?D7bQZnTLFHvjzm3SD6s0M/9CGJLeKRl7Sfj675BGMOjHFtYLvNmTFZRahM4y?=
 =?us-ascii?Q?CDkGN3ornl4gpjOgvyuz+XiFD5PcYOOkwSm7LfA6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f424851-5ca4-450c-1264-08daebf399d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2023 12:27:51.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3J9YWUbsj1Ab2PBN8m4PTNr3G6NK7KXH8Z2XrQzp1fcDzhiTJYxcPsZ9K9v1yaGv/k7C57W7Eg1g9H+aMfgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> GUID_INIT() is for internal guid_t type and shouldn't be used for the uui=
d_le.
> I.o.w. relying on the implementation details is layering violation. Use c=
orrect
> macros to initialize uuid_le.
>=20
> Fixes: 64e9bbdd9588 ("misc/mei/hdcp: Client driver for HDCP application")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/hdcp/mei_hdcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c
> b/drivers/misc/mei/hdcp/mei_hdcp.c
> index 5a1c93a2d2f1..cc7f1169206c 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -858,8 +858,8 @@ static void mei_hdcp_remove(struct mei_cl_device
> *cldev)
>  		dev_warn(&cldev->dev, "mei_cldev_disable() failed\n");  }
>=20
> -#define MEI_UUID_HDCP GUID_INIT(0xB638AB7E, 0x94E2, 0x4EA2, 0xA5, \
> -				0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
> +#define MEI_UUID_HDCP UUID_LE(0xB638AB7E, 0x94E2, 0x4EA2, 0xA5, \
> +			      0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
>=20
>  static const struct mei_cl_device_id mei_hdcp_tbl[] =3D {
>  	{ .uuid =3D MEI_UUID_HDCP, .version =3D MEI_CL_VERSION_ANY },
> --
> 2.35.1

