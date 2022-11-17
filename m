Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5762D077
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiKQBM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiKQBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:12:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0026A6B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668647552; x=1700183552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9KTZuh5ZYxLDjKEZrilHNWY0n6dQrxQ/yhbatic79HI=;
  b=lm/RpBSkUo4F9JQq52X2nlNrSRrE8ppZC1DP7Mx0CYnO7a0JkRv+yR+C
   GzcrIDnmfx4dGGe+a+QOg+uHCCLQHsq3gn/+1L3cwsFHQMNuNJrClA6/B
   eOJ5Sdx2WYN/F2IpLAeOWGBg+6DBmuBgW8tLZjcxeZdAhiUQikE6wRJR6
   mc7O3U/o5v12fVQ2Z5MXia4lDjYrWmeRZoju+mEyREM4DmnTaTGSm/QZv
   qBn45PXDtT3RCy9zxudKlqwNPYzmcaZBCEN8cxZ4rlIv1ls4OMGnTfrNC
   9GV0TWgfF9LNQQX20QcMZhaHVimNk4Jmf3xWdYO3watuwYFSN8mXWTz12
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296080319"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="296080319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="814309621"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="814309621"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2022 17:12:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:12:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:12:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:12:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwX7yIoxknOby7EYQFKeQmjCNKf+uwocL3BrkTLvO4kdoxDoQj8HLG4izHAT71ZCxbABOljbhK3cJAapVs4H0i749UwdYUsdSddjhSJY/rEeC43BytoqTWVGoG/Dm7OgOioFDlzKXXmO93m09czqsZYhRweIxZv551lwJn+U0mKovtaJMeDPcp/Ma1YtTxwfxAJcCVyX637Uw/jIkT41SWwbW51qAZE9E0lW3eFpovyIC6+o7Lv8wwlwiO++Qqi771rolAHX3p7KopJotV74ODN+CtktS7OmfEMVjgsxHXuvSgYURJKZNq338uv0vYpsZKhZSqhCYkr0xUTY/oymxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9i13sVbnFrchHuZpkSXfN5r6rHq1tw4EzMp24gtMEo=;
 b=Vax17jP6OHqQZhzA9s4ZlO5LUP8Zj5qZK4SUwCGUomrT2Ym2iCbnDYicr5R2fOAhW2RaOjGwa1MJ749z3hs9wpotTdrJDKFIOQMAIfXxMkCcvqsbaYNfuIVipU2gbSjIWYvomUqfjBfWI3yEwaQJ7NP9M3Pnbjv0wAOh+v1tvIKIc1I3Les2AMaZLtX2LTd0pNuQShO1MqBwEbMSFhMJqQsvnF+pz4OawmeG/hIn+pvvNV3rY35QhQUy3J1zMWBJqTtsDR2EvRiwc49eDvuA92QkVNvb9jzvmAYBJUqAzkdMfLknfZLttC2qmw0uGYhGGsZbYgyemVZPYtcV9pFZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4092.namprd11.prod.outlook.com (2603:10b6:5:192::24)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 01:12:29 +0000
Received: from DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::eb15:8484:2adb:5521]) by DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::eb15:8484:2adb:5521%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:12:28 +0000
From:   "Sun, Yunying" <yunying.sun@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tang, Feng" <feng.tang@intel.com>
Subject: RE: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Thread-Topic: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Thread-Index: AQHY+ZJ1xXsis4rp9kmS/pgu4XQ8G65CAZCAgABMr6A=
Date:   Thu, 17 Nov 2022 01:12:28 +0000
Message-ID: <DM6PR11MB40924705F72403D0E7B534C6F2069@DM6PR11MB4092.namprd11.prod.outlook.com>
References: <20221116082221.25243-1-yunying.sun@intel.com>
 <20221116203107.GX4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221116203107.GX4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4092:EE_|BN9PR11MB5289:EE_
x-ms-office365-filtering-correlation-id: 0d97bb5d-fb98-4c3f-3fb7-08dac838cb8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10kurhAaNwFg8nmzmsnQRCXkShtzrnLE0fZyocck37pXhBauUqXkyeTyOn7t+mkCtTFpGxXuZJL/KHCsQIMSVJmEwWvOdSD0Or6U7VQ6NybtNMd+hn3P3Wzb9gho4iSWoyOtdxxe9j/op08XHXuN9sJI3nIBpi/sfLc3bwfeNBxf7ZKXGp1aregn2BTqAZX5e196AhPlylSYXd34QscC8PaDsbqWibhh4PfOQClkHRargMbrdZpxpqA6IRSOQjUjAqSgbaMJlry2JwX9cjU9xtAoYbBr089AoBLlwhNBiyWkRH951T+sDHhVd6CDqCHxge0ZflCRdIV/FBfibNpLImvEGKoDm9pkVsI/x/VdypMoeOVr12idiX+IjEvARnkphnk3AaI55kLR5OB5n4T1aavoNlI9AQU/MeyiPxg4SEpUkA1GQO8sl/mFfuuXHrI8q+dbiPn53fw4nvgXvDsGThNi+Gk349OFZovyDyVe9NB1KcZLBVyNbWGEOngjZjX0qUpSFYBj3qDOsta0x9qjzCoflTW9Abc1inYYMhPn3DhRMyyfgWHEr3d2ON++HxQVds4rPEReJ/lPcGWKjUefdNQvBcX29DAhblBa9vL/+XobzwjYYrzmPXSSRfkmAl1VVNQuiYK/jsrI1izhKpSVguuw/cNhilAD/OV41BeTGbZZ8E8fIN8ZwEdd39iSRzpDsbCOd98mC5aC5MrXY5kmgWxsQBroPFxf9oSOqBP0BBTgftZEtBM0WwX8w9oWMmgfQVnhqRZidW9nLk2/5n009A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4092.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(83380400001)(86362001)(33656002)(38100700002)(82960400001)(122000001)(38070700005)(478600001)(71200400001)(7696005)(6506007)(53546011)(107886003)(52536014)(55016003)(66476007)(4326008)(76116006)(66556008)(66446008)(64756008)(8676002)(66946007)(316002)(41300700001)(54906003)(6916009)(26005)(186003)(9686003)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?INcYnLqYY5sBB9lS0m7Be4KWlrKT3sDPI3N7grDn0g/XKuOBuX/yRNrBqe7x?=
 =?us-ascii?Q?xdskkgXArKcY/4DGDr6svgCOiOuHKCcsrMHeT59hkJFQqrSDWdYzWzBfzb4y?=
 =?us-ascii?Q?wI3HGmzmSJ1l33xI4CqE3H7van9jQBNPIsE5PKo0T/hWyMOWImQKH9x8kS7l?=
 =?us-ascii?Q?Zukc7O2MfWr1wpnAZFGN/9my6QCZ4lEdh4Ba6D+tzLDYYsuyp/1Cjf+Wc8aq?=
 =?us-ascii?Q?6YG9q62WArjCT2G5A7qAFI98C2nxgJFYW2SjSZEYvgSY56l4xpNyL0I1u6Io?=
 =?us-ascii?Q?U7dGY+xIh6hOPkSkhJchxQIA0/Zpj1kxNZ3GetH3dxq7C7WIIT68DuBCCErg?=
 =?us-ascii?Q?yi+m0BJuy8+FQgXH6AHASkhbqigKbVnF2V5284WVXiZBdYnPinM1cKvASYyU?=
 =?us-ascii?Q?Yc9x7YFBluaiyIuqby+1oHuDdVPvNOpsrUJXhGju3Aw7UzCDNFj1mzSHlg1Y?=
 =?us-ascii?Q?nnzBkmNACTqbsH781i7zNkXDSvUL6kkwP59KMTol6Dx0Z225buzdUm+yxvHH?=
 =?us-ascii?Q?1tFWYFWtllCH5uUuQuihycy+tV2V22vX/pxJhBQjka9kU2Kb+1H6AvrpYJ62?=
 =?us-ascii?Q?4LM5XN6nbsFc/sqqwRb+5xd6YHDAb36UhHX8dxXu0VD0RVNyCqSbKe/lQNgA?=
 =?us-ascii?Q?j0ZCp2osPBISA66f9hN8aGtNuDyUrhuBeAu07RRGMSQ665hnSyUo0NqGxZwE?=
 =?us-ascii?Q?9NysjUeiDGoGTBuyWdijTAHs+LDfyBf5xrF/D1dE6xVEJagZuGCq3DtpiI9B?=
 =?us-ascii?Q?vOrZkposWiOf5PwlLl65eXNffV7EmRGN/BTA7md4bkS6jsAki3wmXACP8b4P?=
 =?us-ascii?Q?4NjEF1C0TedqhCXUbzlOlaINwTn+rPazE02TQhjvWcLb7N0SeOZQb//Adbbg?=
 =?us-ascii?Q?iAVLbr8rk23bE5m/7afttUlhkPTGq+88QENiHWeO7F6bW8QJyp+yf+FLWP8/?=
 =?us-ascii?Q?Q5B0E7N6370Zr14oubJGjMJDXkUyHWT7UCD4kv+KUj05TXhGHuI1BpfwK9C2?=
 =?us-ascii?Q?hy0R+nXojm7eX9ZxF1wJHCocTNnB4JtxpMazSurlDoMOuhhxM1FsXbEovDeM?=
 =?us-ascii?Q?bZM+UdWFj7gPwWZc+LgyWXEyQZP+Vlu5+v4zge8USB9tA5PiwEg0cRaehNfn?=
 =?us-ascii?Q?A8iGyd1b/k4W8pgvscupDGyDAXVejwsofjCiCID7g/CBGTsoAl21ZyN9Yxja?=
 =?us-ascii?Q?L+gPCH2L5BYXmTUp/IZ8au2KeTvO0da6rYwiyIXNCrZsd8P5aEjflQwg17MY?=
 =?us-ascii?Q?yku6oI6rAMhMiMyx676usRXKdfuO8HXDVTkNZlo1KIZii8/DouoisKGbpeMW?=
 =?us-ascii?Q?FdIKHp3g1IeOYILDDkrmFehslM7lvkLChK2bZZbonsAK7CGPrNy9erikm0m/?=
 =?us-ascii?Q?ZgV1XmuAvRG7nxJ/bFwCmpkJSeHlMIuYTBbEf7zmfX3bNq71laYXv9ZL9ist?=
 =?us-ascii?Q?JJPjsYvPeTb0kuMGZkyowMC8EGS3NfuIGM7vbfP/SDNG5m8i1weu19n4Zw4f?=
 =?us-ascii?Q?yb2HwpRHz6pfsMPv8WgsdM92iKKb82sECk0nn+x/2COAm+Z9Q1oSlMsqOYNB?=
 =?us-ascii?Q?xxgPBzx73RIXNCvq85wtg9eYgbO+pIvUzj2Lmfyv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4092.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97bb5d-fb98-4c3f-3fb7-08dac838cb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 01:12:28.4658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lxyJ/imJot16qDKssDRVhEPuOaTYhr8gM3uxP2re6MvnGLE9eCDBRNXSLv3bL2WkkbYXEGEwH/XYLDSHawTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the quick review. The commit message looks more accurate and =
clear after your wordsmithing.

-Yunying

-----Original Message-----
From: Paul E. McKenney <paulmck@kernel.org>=20
Sent: Thursday, 17 November, 2022 04:31
To: Sun, Yunying <yunying.sun@intel.com>
Cc: tglx@linutronix.de; peterz@infradead.org; longman@redhat.com; x86@kerne=
l.org; linux-kernel@vger.kernel.org; Tang, Feng <feng.tang@intel.com>
Subject: Re: [PATCH] clocksource: Print clocksource name when clocksource i=
s tested unstable

On Wed, Nov 16, 2022 at 04:22:21PM +0800, Yunying Sun wrote:
> Some "TSC fall back to HPET" cases are seen on systems that have more=20
> than 2 numa nodes. When this happens, in kernel log it has:
>=20
> clocksource: timekeeping watchdog on CPU168: hpet read-back delay of=20
> 4296200ns, attempt 4, marking unstable
>=20
> The "hpet" here is misleading since it prints only the name of=20
> watchdog, where actually it's measuring the delay of 3 reads: wd-clocksou=
rce-wd.
>=20
> Signed-off-by: Yunying Sun <yunying.sun@intel.com>

Good eyes!

I queued this with wordsmithing as shown below.  Please let me know if I me=
ssed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 72ff63e2d3f19963a4ef401e5f8c1bd16646b587
Author: Yunying Sun <yunying.sun@intel.com>
Date:   Wed Nov 16 16:22:21 2022 +0800

    clocksource: Print clocksource name when clocksource is tested unstable
   =20
    Some "TSC fall back to HPET" messages appear on systems having more tha=
n
    2 NUMA nodes:
   =20
    clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 42=
96200ns, attempt 4, marking unstable
   =20
    The "hpet" here is misleading the clocksource watchdog is really
    doing repeated reads of "hpet" in order to check for unrelated delays.
    Therefore, print the name of the clocksource under test, prefixed by
    "wd-" and suffixed by "-wd", for example, "wd-tsc-wd".
   =20
    Signed-off-by: Yunying Sun <yunying.sun@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c index 40=
15ec6503a52..6f681d56a843f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct cloc=
ksource *cs, u64 *csnow,
 			goto skip_test;
 	}
=20
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, att=
empt %d, marking unstable\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldn=
s, attempt %d, marking unstable\n",
+		smp_processor_id(), cs->name, wd_delay, nretries);
 	return WD_READ_UNSTABLE;
=20
 skip_test:
