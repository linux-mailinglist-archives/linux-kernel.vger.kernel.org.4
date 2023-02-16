Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75981699C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBPSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:46:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8186646174;
        Thu, 16 Feb 2023 10:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676573166; x=1708109166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BX7WBMsm/0aIZhYRNVxgPMyYyDO9NsVmhx1YDPVCCO0=;
  b=FjEkGV3x1oX8c4z/Sb/4Kzy8vQRycqMtLHwfBWY16l0dlD2jmbiF4aQ4
   +/BEbtj4t5vQbfAJuVEuFOO4HKgIwT/7NpdyXYEc7Dzgf1sjc9ccGvd6a
   UxxImGjV39ixkOELr5TRdx5LV6MtYFYrlWrD2v0p7OzEHcSwXrNwN/msG
   TmTl33q2bQ9NHnfjKSAj8nzbKIQMs11zBFP0HPw/uCRPGEX+NmnmuVy+i
   privV5PCV6Xlc7OLJoYR0mmTfG2tDmqn0Dcnf18cLO3mpKnGRxH4iwLBH
   paQcjYzCZF+oLMg5bm0/oYN7ySOO4Wo2qz+afKsDC09bKxXFUvWJ3sAzq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359242685"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="359242685"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="734008804"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="734008804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Feb 2023 10:46:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 10:46:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 10:46:05 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 10:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxcAaFmzPIlC8bdcJpnGx2LkfBbfjnYQEQyR38CwRhcLnHGnDtdu16RvyXg9tsYuaJU/9AcjeU7UJB7KAdiMM1Do3GVfwkhwl7/GFSAedk7gdztKtv9+T9NBIWQsofZmNlvlRfSvN67Sh256goZTOaxWFk7SEtHZZIIAoZWekre5ahLMujv0yST2HFDtqO6e/4uElLrB0aHVM+1XieKyIW26aBbHGMb3+wzTN+RRY3vP9DiEuCiPPCySlFwyZc/LMzL1UQY7aJe90k2OaDh9+/AsjAxBeygl8EaYhVn7+xg5A2XjHtJ6qyGFykK9aY/nneGSp90vnpvqFxGvkurUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3rcDuiVh5w443603T+QyVHSUCPI+yQwSob0K6vKXv0=;
 b=EN9jpI3N4MTw2QBifWLzc+CCVSVSfm7eCp0qRQ2GeV9hQTkGlwwFuxWoXZp2/j/lITqUbPSiDxSVt/Fl3Sg4exkqfW4Y3CzCHTPBE3/1T3FAlF81Wnh/psjEypFzfbwQf3XdQuarMpxz54lyNk2uzbNveMixpMX9at6oxVLuHVfgnlIxVhl3k/fNz8uW58JmBjWJIvJo8hewK7KilraEbzIo/Vf0WTuJNXRiXeChlhp4j8dhn4CgWhe0tLEGanbkX4bbq8vkSGjnV9XaVns+ZUPfPJiOrZmWZvaNiSrcvEV1bHY6iu4dKxl2KetZfddpUr2Um9h54aT2NpjlfQNcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5555.namprd11.prod.outlook.com (2603:10b6:208:317::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.28; Thu, 16 Feb
 2023 18:46:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 18:46:03 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH v2 2/7] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Thread-Topic: [PATCH v2 2/7] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Thread-Index: AQHZQM5/4xlF/uj2HEirLPJ9j7kt167RhhoAgABjzuA=
Date:   Thu, 16 Feb 2023 18:46:02 +0000
Message-ID: <SJ1PR11MB608391B38FF4836192D37BC6FCA09@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-3-jithu.joseph@intel.com> <Y+4kQOtrHt5pdsSO@kroah.com>
In-Reply-To: <Y+4kQOtrHt5pdsSO@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5555:EE_
x-ms-office365-filtering-correlation-id: 51c7e154-b24b-4703-9c45-08db104e0deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXTW8e5p8am6MhAtGkrpbWvyBmMNyZcrDawGLDBaBdwU8BYQOVzldE8dWTnYdtK66RiCnJQ2GQMZI1Lpk1T+lVwLAyBkUKwV7dhpuxr9seW6KJy5uyd83sGptm0XQI50hXA6x4OKtiwlmZoJ9xuf1hEJcBKT2Sm4i5K+KGqT4WKMl8EqlmHmdiK0fNjKuDL+LhNyk7LSZbd33M7FWSXXqXiucxYMOs7YsxV7ig04vSVcOuI3ZrWG9wOmUAmRet0n+XjjDyPoKQXJJDwSLVKML1zRyz6p4lN2onq2kN36o1AzoH1gILBTz+sulYxpGarkFa49HFokK1ygcPrTRKv/S4RO8Nge4eUA8CxaMqZf6n/Ya+IFjREBQtVxiU02AtpQ2jddgciT6phdR9dN73jw3SrZdOE/EMUqSt2gP6TGSNA4Rlq9mZcJhIVSZyTSlDKUNgX2NHT4cO74ntexqUqov7iVdxC/Ynz9rF2LGJxNuPZMsMJ6OcNMwMQvKTPaNw1p9Ny2ji7dwyFYnTPRlsVVphytG76eRard2gnvuZywK6GD0OgpiE3kWHSHFCgjBXIXhRBff29uU9j2atZD6bRTi8lqaMqBySOBPYWzzX6wY9ogaSMGG4QA67U47rHrXt41F3tmAlB00F66P7HUD+VxH0TJwmHIQqAkeBWKW+3i+rPR1lAIDtEU2si0tdz4F+A2SC9l1sPIO7ed2ztbnoB6Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(2906002)(110136005)(4326008)(54906003)(122000001)(38070700005)(82960400001)(316002)(8676002)(66556008)(6636002)(76116006)(66946007)(66476007)(66446008)(64756008)(55016003)(38100700002)(7696005)(478600001)(41300700001)(33656002)(86362001)(8936002)(7416002)(4744005)(26005)(71200400001)(186003)(9686003)(6506007)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K3Qqe48wm/jCsvU5tHI6ty9JNyZNFyyiQJNxh4Abrr3/s1RNpGS4tEePS17+?=
 =?us-ascii?Q?45+H6q3+FwPtjELK5kVzTlDTTYZ2pGax2JOzZFV0U82tv1LZFmZ3In5G247B?=
 =?us-ascii?Q?OfhYUskgR7z1/178huTrXX0Ct8brOfbzw2Lry7uW+6mYXVRV2xdaHfneZUcP?=
 =?us-ascii?Q?zhH2OTQh4Uy2adWxEqKxVzZveYj1vUzHb244n80PvGdZcTv0zSpHu0lzEcf+?=
 =?us-ascii?Q?TN/FBAWSFgSy4uZayk7rIfxl4huvVfSJBFpfP/gqmtxbXEAdo2puDqFGxMYR?=
 =?us-ascii?Q?5+yu/F7rk0k/zBoR41vR1Afx5SFwbW1/J7HvJqmf4JylYX8b/XfWkJQLjzMf?=
 =?us-ascii?Q?deWDf3CB71p2VsLvmRrpuPw2e4Izcnh13zkfjojtN2+ipc3jWscG42Qt2eJP?=
 =?us-ascii?Q?u236swoKb0ieiVD1HLyR7NFyFzJInWuJIdkA8yaPSdaRorQ9zyqjYQrXNg+/?=
 =?us-ascii?Q?8uCG0e2shiiVqNGiIwJxVzLohxrMvvUAIa4Wv3C5fuh+JVm9Hhuc5/B9c0hQ?=
 =?us-ascii?Q?Ldpyv7DsXMYd9Dg+5Ek0zilUgPi4ko64BlvF6aoGTpt4RrWcybk0+4ExWqjA?=
 =?us-ascii?Q?54rFZNmWw6wmNAOJLwrEqVgYgOxMWSW0bMFJPkOqDvSYdG8iT7sidaLLq3Fa?=
 =?us-ascii?Q?hCAKBwyG3I+PugVyfRji1KC8+BopY7jP+2x0+lQUWhYGFlLrPvXb6/r7/PIb?=
 =?us-ascii?Q?rWF4m9VpuMLi507fKHiDqVE0E88WNHrdcuyRkkPapR404jMDFdqjeTFkhpVI?=
 =?us-ascii?Q?1GAVVefR66FKz0sHn6oIh6ruOJYf1R1KSwG/1Z1I8Y40NEvjQcnCVoG0YVsZ?=
 =?us-ascii?Q?jsd1c5px7c+wCgydZymZF1QxOHuwFtOK00ZTLosk+1YcVpRwzX8b9CDgfeTp?=
 =?us-ascii?Q?sIj/2ccPzb+jw74CcBqV8ly6KiSRTy+ILf/1PuM2L6jfTRORtdIia4puE/pJ?=
 =?us-ascii?Q?b03KlDVpC6a3eYRqxOiXdfjcTY1GGR9OFS/QJmfbgqiHk+FCIfLKOOwUljq+?=
 =?us-ascii?Q?7HTwa4cAStA3z7iTrPIaMUA7Apw7jWWHJ5Tb5j/K1qZ4fidURtbXolzvYG09?=
 =?us-ascii?Q?W5eckg27oCxrxFzAkDwj7TP4qeKYXr67jlB9gRM56f0AOc/menUl2t9NzI8m?=
 =?us-ascii?Q?+CgOBhE2u+vhooCtAiYM2OkEf7gnrI5YAlUqYRVtR7/+cN+HSl70DXWrAfN2?=
 =?us-ascii?Q?ZxOl+rYw4kED1O81Qxqld5w6/V1m8U5MyUjEMWRSHmNjzM7mBA1gyix2rW3B?=
 =?us-ascii?Q?OhmxajYUwq+xKY3Qbh7U5JxfThG0HOg2zpusJYdpb8jgVxVy0ql7H6PX8eAL?=
 =?us-ascii?Q?JcI+6ZOz/rEg+rkGN41LUVXBnN6Qyx/V5QWZrUTfCmY5T20Hsdh8dR8Mq2r/?=
 =?us-ascii?Q?qH9YbNwLURx34VdoAhpT1W53T22Bl+PGFjp86M377wNalS452qUG1MxdCzzw?=
 =?us-ascii?Q?Y2xtK2XZQ10Tq3atpQuLV3vqMajR0i2JVdsuIG2VR33QCEEkEgEO4KoUnM7G?=
 =?us-ascii?Q?2oP94rzfeso0Dm8Y8Pg3Mi2VMsdsK3U9WlcQ7de/wcc7RbNY1sAfS/qH1VT7?=
 =?us-ascii?Q?qhBfrdhfoSQ34JbZ4xMKWginAd8x9F1Q4GlriijX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c7e154-b24b-4703-9c45-08db104e0deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 18:46:02.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4F2LeJ/pShPigkASk/LmBBgVAFYyKKELE0AkxlIqt2kuVg3Boun9wyPD+bxRzDQ3Au9OBJA2UXjmZ62pp9ldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5555
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

>> +enum test_types {
>> +	IFS_SAF,
>> +	IFS_ARRAY,
>
> As you are using this enum to index an array, don't you need to set the
> starting value to be sure it's 0?

C standard says: "The value of the first enumerator (if it does not use =3D=
 constant-expression) is zero."

>> +#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
>
> Don't do this, just have a list with a NULL entry at the end, makes
> things much simpler and easier over time.

Maintainers seem to be divided over this. Personally, I'm also
in favor of a NULL entry to mark the last entry (I think it was one
of Kernighan and Plauger's style guides "End markers are better
than counts"). But the tiny footprint folks have beaten me up in
the past for wasting a whole extra structure element just to include
a terminator. :-(=20

-Tony
