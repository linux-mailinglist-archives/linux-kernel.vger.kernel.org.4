Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07B6A5D35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjB1Qfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjB1Qfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:35:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA232CE7;
        Tue, 28 Feb 2023 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677602132; x=1709138132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HE/9ALuoKh8iSpwu5fHL5A+FuZwzjxoZQQP0Euf4BF4=;
  b=hFgaMgf6tW0taoN1zMJrFmNeijGvW8blWmP5xXOI4R+oLyzl/v++uSSw
   uGqExz+PZXaJBCy2qprBV2BerZO9RtV4syqPczjPw3aKlS7Y7JTyoTVqo
   7rF6kq4nPKY988zsDxy977ledFlADh1ki9j0w9fymC8F0i3NDWwBJrTY0
   zBefz8GCJDjpr8AV466phh96jPp1tYPYKTStpAaeotLJFEdBsfXQcmwNG
   JBzhyfRFf/wtH/AvmG4exRTNUNu3Ezo2dporjcjNSf71qFBspF3FrcYCo
   OE6Kn8rDqSHLf+3kildsb4qOG5UR1mUqtORRoLZq7IDK/sB1Ls/e0wfHj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335672873"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="335672873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="667519537"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="667519537"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2023 08:35:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 08:35:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 08:35:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 08:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrTuCUNmqiNh6zbEoRrrgU0U+G28dPVQ//+hsMYiFMXNflc7l6zUJPfFlzOwcGXO8juvI5/5F4R0/lA4PSIi2RXYu9KwdMOS2rA164iJ6Sk/KDYLL43fKLiGKZ1P34YnpeDTV/XwgH+lk3uOzVZyi1nc0Z52Y/eF0iStmVKgfP4PIGQW81GLDLWD2+7YwbgO249wDWbV11UJdtlPl8X78zfLxFYOxCJWeY6dnby5+9bsh3QrFWAK2wgReG7orZ8pm4IkW2mRvgASxZcLsO/KM7Bz5JqmXjaNw9cs2QqaM+CFxStsBJtQb9IOHOkrfkqd/QV5ZlspU6MWVEegvCE22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyyHZ0vuiekTNc90Q21s/1IqF3s0rA4ZvbxLKJBErfQ=;
 b=jmPHr4U1IrkN5ni1eCFuvxeMRC/wtQPg/NhE/h5P1OX9spIds+5M0/fslkkKfm8BOlL130hEHD17e+ree1XdhQbr120AiI3p5YPbGKYqo0igy+nBN+MQb1LELlZETtAeRKJRHvIfdA6JcDn2anbXwo2p9c8fkznpp7/6MPORGV7OkOYtMY/uyy1Nn1TEiqVCAZC4pGDHfwI/+hcap/OB/YJFn5NDKIm0ed+EVkv7cBncUcXeA5Lyq85HEEwqTK271/kZu3V/ZWcguLkCdvq3LVs5EjI494f530ftkrPATOl3MoOHQ38JWAMGCTZKr2k+GzygXSNNCSbjcnm612ZizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB7375.namprd11.prod.outlook.com (2603:10b6:8:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 16:35:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 16:35:27 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Nick Alcock <nick.alcock@oracle.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>
Subject: RE: [PATCH 05/20] lib: remove MODULE_LICENSE in non-modules
Thread-Topic: [PATCH 05/20] lib: remove MODULE_LICENSE in non-modules
Thread-Index: AQHZS3T+krC1hSoIl0yf6T1wa1Trsa7kjkKg
Date:   Tue, 28 Feb 2023 16:35:27 +0000
Message-ID: <CO1PR11MB50892FA526AADBCA960D05B9D6AC9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
 <20230228130215.289081-6-nick.alcock@oracle.com>
In-Reply-To: <20230228130215.289081-6-nick.alcock@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB7375:EE_
x-ms-office365-filtering-correlation-id: 77314944-7137-4ac1-1e8a-08db19a9cc7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pkq0Wi9CptkeSvekX0REMGmdcfvFsDdRGbjgQdtn5S7BSVg0bgwN5Egn1H8hjHIhpX7uady41upjT4K3BlvHW/47VqDtpIRdohyl7g5HgxfmAyIFipYz1KkQADd9bpYQcbOU0RldUIzWtywsxMmI7p4hR4xbpHwF6RFnd44uRDTa+i/FRNHN2E9G5N+s4JXYKls3Dyvamm62TUeKDsDLgdx1QhvO3m3k7Re9Ar9/pUH+G8JCMbB58k+iT/cU2Uh3Ax9avp02Bzm5JxfAF+jrrW3yk17JKjPXJEu0wh8CCEuq1pvw9vo06CtFegLmXqFoieFpqoeJRoC9imcAumXzSU8cKVNFIw+O4FGQiwS2nk66yS3L2Bl+jjPb1Q40mC1/92Aw/NTBA3pyFlzlIZLmYwg2Va/zhkeeIDI1ht3n6kR7NtmCF//FSds/nmIV7OkIuT/uFQIYxWtTtP18cGxkODTTEhjkR6Jsf9xZPdXUX55CvK35VenXgLoBK0YZ5DM2W+8Z+lfXheaU0/p8yCHkxaVq8jFLw951VStGh8V5e96YHJbmxP7QJuJ9mMaZFWzj4t+krDDTBsVScCnrTyvKSBohWwP4EA5WRAOIBP3BdsN4uZsp+mpBpOP5fBlAaZrdSs2uUOOWOw2g2Ih7Vj53N3vV7Ut6l73tO/MyTA1wWcJjcOY0EdCx/7iHTgFHM2ffvKCM9nrvIMLPO5KN/apuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(122000001)(316002)(83380400001)(38070700005)(82960400001)(38100700002)(55016003)(26005)(186003)(478600001)(71200400001)(6506007)(53546011)(9686003)(7696005)(33656002)(86362001)(110136005)(2906002)(54906003)(66946007)(76116006)(5660300002)(52536014)(64756008)(66476007)(66556008)(41300700001)(8936002)(66446008)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+W3jJ39AS8bRSR5tS3YLBiBSs2plNqDHa4lVQccb/pdOJ2ApYaMex42RimYr?=
 =?us-ascii?Q?BG/Rzn4YOygcbvILeynu4gp6yIFuWhFIaAGBi0D8qDUcKVlEzFiVYaAgDANd?=
 =?us-ascii?Q?PC48EKiFvmc0F3AgAz2iviKvIqL7MU/g1q4Hig1V7F7kLLqe8vLP/ypykZhY?=
 =?us-ascii?Q?jkGMEqYxPGYmjNpH3spKbNI2SnfGALqMd9NpFiW++jsajxL0S33963AN5sDb?=
 =?us-ascii?Q?+zISNTagqi33tyDwO0xnc/4TsHl9eXdfygjyebKwE7t86T32F35Amyw/Z4tX?=
 =?us-ascii?Q?/YNwj2yS85H68K4ceIHUYdbPd0ac4aDyOSaO5bLPqaTYwFhYrEPmQgrqnbNh?=
 =?us-ascii?Q?5FVTglwLKQRLaXNh9zsdyyMne48umI4ot+p733lNjqYp5XsUz0Zxj7ZSCUwo?=
 =?us-ascii?Q?l1ep242+3LFvPu1bws5cF6708O6uiU4d7/5FBlOdXdtGOEBIZgCTFKoomEPV?=
 =?us-ascii?Q?XqBwH1sf+EeAc3hRmU7Yso6mHKQTnMjWF0dzPdE8jLuO3WHDZed34yY7UuCt?=
 =?us-ascii?Q?BvEAtHJ0EP+8kquAT+IQyTxSUfIfAE02HMMUQID0WMR3MSCgBf4nvWL/ryYb?=
 =?us-ascii?Q?ea5L/yB45de08I6p7JOdVehQqimFB8V+WjmaUFBs1vuPyUy2Usef8gkCOkiy?=
 =?us-ascii?Q?Yv3bvckUnxDSP2rAoScqMWU6wwLTKFynT3negjzqvT8neLRa67Nbl7n5NkeX?=
 =?us-ascii?Q?yiMEsRKpnKKYcv71K/G/m/e/GHyZu3lrIRijkL/EgF8geoMW1Xp6w4x/N3kK?=
 =?us-ascii?Q?c3EQEOqZpI5a/s8onBfRsdMLQduU60UGRt9utKs6ZHsaX8PqSSkZNWInlSho?=
 =?us-ascii?Q?pTQGqxp6NEn0bcvjRg5MlRYSwqZEYYbf/fw/s6M8GlnivWzjn0LBQTH7O3g9?=
 =?us-ascii?Q?kUUpBbKXRri0g5bVy85Dix4S5SNcQ+LshqaArf4SLJ6tfJ1v6cVCMo0OkzWd?=
 =?us-ascii?Q?01tib+dJT2K+uu0zM1LTkeEu8Ffdd3ayzqCO03x0KnLooXjH8HjqT0QL65Cr?=
 =?us-ascii?Q?HAcqJ36AV3uT+w7FhYFedD4lsqlGCaGGwDmClR6oKYN7iCJmSxL2Rvv5Tfr0?=
 =?us-ascii?Q?cMDO0udRJ0mX97z2QZWKDUJVnzAkGA5ecJ4om/Mnt+a7KG8r2/DeJl4w5Swh?=
 =?us-ascii?Q?AsMt2Mq71AgEdhOWmx5o164dBjJfSiwH4XsALb+nZJrEwxygJrHjNIdFetfX?=
 =?us-ascii?Q?hO1pAiWGFfQb1/lVAPjgzJXyzt5FQkUej225igz7IzcokeNsWWh0NBcLStly?=
 =?us-ascii?Q?1ZQAtdZIop+MUzBTBN+mTy7F2V02BL5y00OS86SGXM8JgUuuIdGu/kuqysve?=
 =?us-ascii?Q?jT6J9fqRdXBU9brHQg/r91EQOmHGaC/efeM7MxdJbBwjSnZxchYZ5DNPz7EO?=
 =?us-ascii?Q?42fZiT68JH9N/Um1zTFWBQFq5TM5JRYClUp9qh+r3DbWQKnYjEx7JA0x7kbX?=
 =?us-ascii?Q?5ip8zIrpWRz7qC/wDdT21aae7BxY7mbINWSq0O7XB7vKSA3Dw4iZtjnhG2zA?=
 =?us-ascii?Q?j48+jUNYMV24a8YM5I0nsrWw1kUY4Mjm8vMNJ6ypThQfVsSl2UCkcy7O6zg3?=
 =?us-ascii?Q?ZSfN0ZDHnWArwyYJYGp6kewsp7LUFkiNbZolWhte?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77314944-7137-4ac1-1e8a-08db19a9cc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 16:35:27.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BM3rCMcdsd3BsOpq7f634bm9Y27l1/6lGZyCgZxDbte7GzmBSwTwzpUJ9rOqmlcNKTVPy/rxkdyQl7i30cWNIoo8Nn21V23MJcQcesIAv74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7375
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
> From: Nick Alcock <nick.alcock@oracle.com>
> Sent: Tuesday, February 28, 2023 5:02 AM
> To: mcgrof@kernel.org
> Cc: linux-modules@vger.kernel.org; linux-kernel@vger.kernel.org; Hitomi
> Hasegawa <hasegawa-hitomi@fujitsu.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: [PATCH 05/20] lib: remove MODULE_LICENSE in non-modules
>=20
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  lib/pldmfw/pldmfw.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
> index 6e77eb6d8e72e..54e1809a38fd9 100644
> --- a/lib/pldmfw/pldmfw.c
> +++ b/lib/pldmfw/pldmfw.c
> @@ -875,5 +875,4 @@ int pldmfw_flash_image(struct pldmfw *context, const
> struct firmware *fw)
>  EXPORT_SYMBOL(pldmfw_flash_image);
>=20
>  MODULE_AUTHOR("Jacob Keller <jacob.e.keller@intel.com>");
> -MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("PLDM firmware flash update library");
> --
> 2.39.1.268.g9de2f9a303

