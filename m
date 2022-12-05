Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF96642F99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiLESJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLESJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:09:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308763BD;
        Mon,  5 Dec 2022 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670263756; x=1701799756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mfp7TCMq9ryWiMK+lVP1aMlK+DB77h7dG9vOrjXdEWg=;
  b=Lo+keSNe2pa5UTqZcuDVK7h8Nt9TJcx0zLBPCH7zUeGS+ocNNarDzWnn
   MV5/Six52HWdT3n1yQHgIiC3N/loIwz7+32MbzSyGdXfGkyJHmWV885wV
   UxOOy9OPx1B2nurV3nJ9ILvsuAJU2d3PHzJc6hTmf5QBeo/vO9AVJxDlQ
   ic+pgMuv9gBqQ5qYRQLee7JuJOP/c6QxrR1EVjS3g6tdErZ+wCArqv2kK
   evGA2r1pGYlb4JvLuETNGdFZ8mcU+rN5sKTwCm7KokH1c/L7uIMeaZjXa
   tCZ9XTD8JA9Q83oZtz1GZjClD8LfgnDsxOu91/TmtwMzIN5kYoJfECEhD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343422573"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343422573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 10:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="623597402"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="623597402"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2022 10:07:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 10:07:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 10:07:43 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 10:07:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcyJAef3CDNY7fTI936ga4VX+pM8f/GcofSQqnH8uqKAoeIYqAv6l2xSjZUg456dym0bJ6ABjJRgiK84h900ULdInOQGnvWj+uZdpb6HggXkBExcLYFcEmh0dzzAK6lPYamlfcwjJYdsO6QtjLqNPe2dGNiweHHVmaURkgIDYO7hLBSpT3TSx843uZUbQldRrJEO4PnFlC28Cu5q8TqfkDkWJpf7h01DDVVxPz0+Y6hQ7P+NjYR+bmMw/Y1z2rmSIIcam9K5XHLzVtfHUDWUArFJjhq4mzrGatHSRglLOY7cSuCVrTgzgEG1V/1Ue7pk/RaiiVtHLGumhB+WP/svEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNPcCB2THyT92H1++3774Fdq0FVzUR8QAlrbWmKx7gY=;
 b=JVNwKAeQKKMSR2stSGL6RzT+Dqvi3y0wkIPI1VDz3BLC5tVC+xbPNnnSC8sdCUANzPWQMZm5uabhcLRwAiAdfkYzouFAebB/LJ2xtKSA25qXHHhGUNFkCdelnQJ1S12SK91LU9zBG+KqjoQCiHbktvyXp9q//cCdxhzZyRHYGz2u026B1Vx6NGKvvev0uSl37bs0dl80WZ8GjW+LUHpun0NP+9AKkjPZMKcPFymOQ0P/Lz9I27W21N4H3+2n2rHISfHOEUDBNs8kAn3KEIqZy1u5gTRZnGL8ZT0/JJchLk81FWuNnurRah9iVVNtFd/RyAKFzNxabr9TV5DA8uV7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 18:07:39 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::f43e:351c:5a4f:3c3b]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::f43e:351c:5a4f:3c3b%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 18:07:39 +0000
From:   "Wang, Weilin" <weilin.wang@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: RE: [PATCH] perf stat: Fix multi-line metric output in JSON
Thread-Topic: [PATCH] perf stat: Fix multi-line metric output in JSON
Thread-Index: AQHZBoD5lGUsRu3DdE2l74CJjH33Pa5a/C4ggARKxgCAAFRu0A==
Date:   Mon, 5 Dec 2022 18:07:39 +0000
Message-ID: <CO6PR11MB563587FE3F6CC5475E9D8864EE189@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20221202190447.1588680-1-namhyung@kernel.org>
 <CO6PR11MB5635C3BB62A1B9FA532DF57BEE179@CO6PR11MB5635.namprd11.prod.outlook.com>
 <Y43sJkk79WMbg8Eq@kernel.org>
In-Reply-To: <Y43sJkk79WMbg8Eq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SJ0PR11MB5008:EE_
x-ms-office365-filtering-correlation-id: d58318e8-e596-4420-5bdc-08dad6eb98bf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0G0G4yv4M77yxrtF9YtYU7whdetAOKoXKGn180mcoAR5DOZdKO5p1fhkyZrjOLVPP/l7XirOsMbUnSTH5wksJpEP+Mg+dbkWCU0+F3hZLC5hhPR97oKgYk8UWxK2ZfRWobPMhqJPnQAIOxX/8DQ+M1zpwwdhkqknO05IJxcAispSl2ayuarPLwPrd2P7RzhkkernqQaJ4Vaop68nb7DZElxXjdEkIHtAnTJ6qq227gVvwgvVnl2jDCqbs0u0VqqVgavNl5duMzh9ElPfzR6e/hyba+lVWTI0yz4LnVdUF1CUeU/T0otMtBrknntrZL81c+Ho6JnEu4sVom1KZIxUSixbVMtIr3hc1R7o5BVXEabyLwosQope5hcWFJCeS/QinafdACWtMcFLWkxpjsduxuGe3zGV1B/Q9LeUp7qAjBIm+r8cqsjK1aTNDk+5H6MbpeBbgzpxEbg3c+YmL4JebFsWsI0s+WxqNv4BL0ODrwiiYTNfydGib6bs32dMR5r9iKVPG2vPTubZ7Q2Bd7jkupuWrIFHfCIPxhsKR6eqSa37Owz+yoBpUSApPQOUIrTBZqmRC+FnggiBmDk0CJE2a2an35XRWZ9V2mdcH3HxmXTTC1GbLfIDbBv73bMye6D9eKs98igtzc6lmYd66WlOb9JRh/D848e8TtjlfQDn7QKJ/ubPOxHSzE21xU/xH269cK1KvWgmDx53EUidS4fsiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(38100700002)(82960400001)(86362001)(41300700001)(8936002)(2906002)(4326008)(38070700005)(5660300002)(7416002)(122000001)(83380400001)(33656002)(66556008)(478600001)(66476007)(66446008)(76116006)(66946007)(316002)(54906003)(6916009)(71200400001)(55016003)(52536014)(8676002)(53546011)(64756008)(186003)(26005)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j6MN/7JYHD93N38xUkDo2WVwIRq3JjrgPdYttkHA2zeiIsEH6bMcK7dqQCCq?=
 =?us-ascii?Q?OATMULiD+SHnauHyUngHhfJep2p4FfIL7mQio0VxoToFvek08xdGfF2LEMsC?=
 =?us-ascii?Q?EvBUt/UQ5eTLQ/8T/FCiO0e8qF73Witx6WG3E9I6nnqakN5gCNTs8E5y+4ZQ?=
 =?us-ascii?Q?oLvkXVLopJeocgl4qgKbvMd5vJpmC2oRyC0oYn3rruLRXCmcbgKrLRrhH7q8?=
 =?us-ascii?Q?yGeClJQdX4QuSG8eP/b/wUUFstrY5joWKFuBnj6nj6xT0/rxqcPslhu/QsKp?=
 =?us-ascii?Q?IzsWFWOd4PuwDOPr2V4lHLP01Jn+vUClh7OMhKHN3OVdsdmzaHnrbGIN/e+d?=
 =?us-ascii?Q?DS/a6xAMaLOu+/VVt3exu15OtbHVzhmaDN14NTO4fA60d7dK9Bfn+q9M5bd9?=
 =?us-ascii?Q?kBiCJeOCk8BycEid8fntCGMRjc664ehDpoYvATjy+Mk4PDsTGusaYQJ7XrM+?=
 =?us-ascii?Q?1rUItZFzG/QerYA2cL3+USQF0LmjjjD4wCJJln1C+ITi487SKlAYO6z+Psd9?=
 =?us-ascii?Q?x/Z7Zlgx485e5Bud43CEhXL1YFkgLlOnTwob7aKYjsWg0iE/K8AbjAdvzRbo?=
 =?us-ascii?Q?CJH55T44jc7DVV3j7hGj6HPmOp+ZxGc3QpcgMPUeB1TLaDuzIlmehRFURo8T?=
 =?us-ascii?Q?upaBNULL7HNBA+QumQqjVcOme8N0q58RLVWDgJiEsJwXkbA7MRoG0B4bHNPR?=
 =?us-ascii?Q?IkxrsIx0n/gX1GiIHIVOGyG8nCYHX9cRRDiOoV7F3TUfuLTfQaBXU9Yd6zDr?=
 =?us-ascii?Q?5JEh3qE2RmDFPSoG3lOSCDEOMPKG9RUSvR7HvS0vhUuwElMoHgNSi92qS9ou?=
 =?us-ascii?Q?2J02dBBAnuKd7uhw8L6AwqwNMc7jai3jHCGcef0EzrBfoSoyN34hbSu6jjNh?=
 =?us-ascii?Q?Ze/1Zx2W+Ci1Jlejrles2YGZUgq3hg5LjNZebYw8tPKVMQu8Qu7ZAkbyfVf8?=
 =?us-ascii?Q?VxEOwLZIxOZW2FYz96ROxa8j20FYdCGm+NV2zqsmlkdseZprfoXmQk9Gyp/+?=
 =?us-ascii?Q?OQfY+Tz1A2c49ylaLfKEWL+fxXY/J7W9ZI78AmFwGk7s8mU97UUkNO2I2qXP?=
 =?us-ascii?Q?rj9kCJZ6gaTar6bkfyWjWL7+RSOe1op3Z1wa1PvpuLHemniMwbOikZKXm3s/?=
 =?us-ascii?Q?Vt71ZBnhgDTzjIhnHb+ZjN69uO3t6QmD8FBOZuukVWV1fI7UUeSa8IIAYLHL?=
 =?us-ascii?Q?X5yknGsf4/bPkuXT8ndwuk/w1laj4Hr9eMeC8IpymaX2jLXto4H0q4ioFh/K?=
 =?us-ascii?Q?Ib7uURDZlnavNI/Pdo/ZHcFZHdIPpRcZQmQe4LjNJz/2oYDL1Dn4+Ek288vP?=
 =?us-ascii?Q?D0oIQABFUeO8WlMt12UzOXr8XWGmf9giTNCH35IpFRG7JuC7TeZHR2c4aODQ?=
 =?us-ascii?Q?Oq7nU2El+0CRW57zsBaS+x0JJrZpORJRiRWDAY1vEBp01+YNkRwLqCNyDmO5?=
 =?us-ascii?Q?dQ/lKbfkKFwt4P5OIBTXqmvuxymq95pRqCetKHbs3eP87xERF8ahZbm714Bg?=
 =?us-ascii?Q?2hrq9RuTLQu+M7nGJmdVYAyVDxe+PGsPrgjxrAvGSA9wXW8Fqs3myvyGwoEn?=
 =?us-ascii?Q?lxgRwg3oZcMaZ2q31Y3fagRBrI1qvRj5t+Tm6xW9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58318e8-e596-4420-5bdc-08dad6eb98bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 18:07:39.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNr93o/9GOWVjw52mpkpkrBD+M/l/PkEdCerrUXj7dNXsmHZwu/YJ8q1D+qNOrt+vX0XOsFYQoC+R7ZpXgkYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
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

Yes, no problem.=20

Thanks,=20
Weilin

-----Original Message-----
From: Arnaldo Carvalho de Melo <acme@kernel.org>=20
Sent: Monday, December 5, 2022 5:04 AM
To: Wang, Weilin <weilin.wang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>; Jiri Olsa <jolsa@kernel.org>; Ingo =
Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>; LKML <lin=
ux-kernel@vger.kernel.org>; Ian Rogers <irogers@google.com>; Hunter, Adrian=
 <adrian.hunter@intel.com>; linux-perf-users@vger.kernel.org; Kan Liang <ka=
n.liang@linux.intel.com>; Zhengjun Xing <zhengjun.xing@linux.intel.com>; Ja=
mes Clark <james.clark@arm.com>; Athira Jajeev <atrajeev@linux.vnet.ibm.com=
>
Subject: Re: [PATCH] perf stat: Fix multi-line metric output in JSON

Em Fri, Dec 02, 2022 at 07:31:59PM +0000, Wang, Weilin escreveu:
> Namhyung, it works. Thanks!

Thanks, applied and added a Tested-by: Weilin, ok?

- Arnaldo
=20
> -----Original Message-----
> From: Namhyung Kim <namhyung@gmail.com> On Behalf Of Namhyung Kim
> Sent: Friday, December 2, 2022 11:05 AM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>; Jiri Olsa <jolsa@kernel.o=
rg>
> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>=
; LKML <linux-kernel@vger.kernel.org>; Ian Rogers <irogers@google.com>; Hun=
ter, Adrian <adrian.hunter@intel.com>; linux-perf-users@vger.kernel.org; Ka=
n Liang <kan.liang@linux.intel.com>; Zhengjun Xing <zhengjun.xing@linux.int=
el.com>; James Clark <james.clark@arm.com>; Athira Jajeev <atrajeev@linux.v=
net.ibm.com>; Wang, Weilin <weilin.wang@intel.com>
> Subject: [PATCH] perf stat: Fix multi-line metric output in JSON
>=20
> When a metric produces more than one values, it missed to print the openi=
ng bracket.
>=20
> Fixes: ab6baaae2735 ("perf stat: Fix JSON output in metric-only mode")
> Reported-by: "Wang, Weilin" <weilin.wang@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> Weilin, could you please verify it fixes your problem?
>=20
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c index f1ee4b052198..8d0bdd57163d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -440,7 +440,7 @@ static void new_line_json(struct perf_stat_config *co=
nfig, void *ctx)  {
>  	struct outstate *os =3D ctx;
> =20
> -	fputc('\n', os->fh);
> +	fputs("\n{", os->fh);
>  	if (os->prefix)
>  		fprintf(os->fh, "%s", os->prefix);
>  	aggr_printout(config, os->evsel, os->id, os->nr);
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog

--=20

- Arnaldo
