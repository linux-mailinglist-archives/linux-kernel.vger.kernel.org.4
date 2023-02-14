Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FCC695CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjBNIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBNIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:17:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD1133;
        Tue, 14 Feb 2023 00:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676362660; x=1707898660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G6Uh2XSVZiMVJnLmFOB1dtDJTLGPtvqN7w/AANnx/0Y=;
  b=YYSccBDyB195oLCgGMHyIFZrhcMDZYfJp6h3ruHzxKIWEaueUVFDVv3+
   Nrto5OFktuuZpjhXr+wlXNNF00aaq2/RRUjYsLpGqdflJkQcf9swT2GOq
   XkHUvPvRwuzhZ+C8cf/nQIUmk4KqgCSsfgMPbQcaLGrtxFNdzH6SRFzy5
   Qbwdp2FXhiw8Vg9ATbDG3/hFPisGpV0eLUtbTCUnLKGIz9/RjdPWk0Mpg
   kIcTUjmM4RAEZJ10C2zXfJoW4yUeJv69sipzBF3vBxxd+s+VgIOJkwEc0
   53sx7MohCYuYw+bzZHJD1AP9vevT41Hthmgs8afkvvPnOKg//ik/jE5pS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395724247"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="395724247"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 00:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778226830"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="778226830"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2023 00:17:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 00:17:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 00:17:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 00:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFivmapridfBrSUi8zqe1GR6UCNIZW//b7p5R+ECVjbt1WdubsaKrEbtYlpMQieMZf4+DqG/uog8klnRH765vWSyVUBL4Z5EK8qeowZ8AeDTbcgxYzraRLQt1dQO8cMX3L37IrEhEqLM20F/BwyrdF3Kiq+BLGDbJ2IRVCyX035wzsa/r0namszYNkRl1e06hOG/W6WXcvM2XdYelvZBlLOrygJX0Fp4UtHhWcHZEeUfqEUkG8gSbCmrDRt8uTAzLdyQwEV9bFgBgBlXuX8qnWljVQUEMNin1DP/zd9wjRwOpGVXqaVGmR90Oj/12vaFlGYiLabITbKNXViYJci3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6Uh2XSVZiMVJnLmFOB1dtDJTLGPtvqN7w/AANnx/0Y=;
 b=S69rLvVJmJDW0AxI/GHlhSsIbI4mFynlxYDqK1jHPuh6GDNw3QJoAEsjoJlLinOff4x/RbVzfC0mGer+R9LAFgIxuABqN2NHo44Kpe5VO3UxxYWenMzGjTv4qEEoGa45zUsSJx2cCfr53VRw6eHYxzSOpNPRoCDMfrKsByekGvNbuokcSrWAyG1bbMnUOgHr6CGwjAs9wzzx73Wl2BhxdbGczdNmOuvF2fQsCexKAoLSTNwsGJhRHW1bL6JgxaCLOo/mVve4swmyG0UyVYCUMb4l8selrSWa547ttWJ0N34gBV3nrenhtzjAy0c+sf6MWBw1MoEKagL+s80hyooLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 08:17:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 08:17:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Topic: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Index: AQHZOD9ejAi0bsndXU+9RwTFzHNkO67DfmEAgAVk4YCAALWhkIADaagAgAElcnA=
Date:   Tue, 14 Feb 2023 08:17:35 +0000
Message-ID: <PH0PR11MB5880DF0A8272675395C2520BDAA29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB588015D6429D592BBD599733DADF9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B0B5741B-2A89-4092-935B-39B23EFEDC27@joelfernandes.org>
In-Reply-To: <B0B5741B-2A89-4092-935B-39B23EFEDC27@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6508:EE_
x-ms-office365-filtering-correlation-id: 2a0e7671-53f6-4783-a8b5-08db0e63eda8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cp6D66qU0qHUyTBA/6BJcfhinz2Ix/Zp+9Q2qtrCnUDJM0EZd6fjMk0uhIQIlYIAOIA/BfjkwZaN2eeCMclN8Tt1Xh9ebiuoumlBZXovkwaE5lfSEGs2MWvQY0oZiVv45BXC2RnM2J4hnnUIuA3g6f3XuEtl5dE26Pp138Y9lfoLvRio1KCESE1VmVY+FEKY1fwW/prIqzOmWljnsudyhrny5GWn1Mjf0BXE1p/PGDHuzb1cBZj233Mjm+vyBf3hW+apfmW55V11XMdHOIJml6WL5V45hs5Ru/RZq2qkmSu16NpWnqYu9Z1s6LmZ/fDWONxYHqWXse5S5/EnxJ0LmrLXEWcSyqz8iDskHUxJeW2/pL03H4SkAcUtftp4oXkoRONWV+7m3dtHO3wyK1p56QBXpHCi6Y0A46BMqbiGeC8BmnQ9bZe/B7VAMPxPw7jRrPglOHSM8NKhsMbMUgX2ky1m0OMSHt76QmsYHQqdkNti3IiovjY3BzcER0woPKKL/lGNsyLQmwkyIhG+SZQiXuS7u+ZqH/zVZokleRy6QSqSXBB5vFL4//9G+8i/1zSWLUZEYJCyWKYCuR4zWgRhSh9TXKTiz9cF4KEQzlOCZV/Ihx1PZTWCU1pd/RGJXnO2WSSFSg5xFJlEB0CPcTevVXrzBzSBQMq1oxYdJ4AKGeVzkgMXq2Ga1ZK6plaMncY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199018)(7416002)(41300700001)(86362001)(2906002)(52536014)(38070700005)(33656002)(5660300002)(8936002)(4326008)(83380400001)(122000001)(38100700002)(82960400001)(7696005)(71200400001)(76116006)(966005)(478600001)(8676002)(66446008)(6916009)(186003)(26005)(9686003)(55016003)(316002)(64756008)(66476007)(66946007)(54906003)(66556008)(6506007)(53546011)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGNncmx6V2NFODNSL3liMXZ0akh2bytSOXhkRzZZNGs2QXpqaEJpc3pNMHE3?=
 =?utf-8?B?TGJZeVFMSVJXTG9KQzdjYnRrdlBYY25Uc1h0QkphQ1o0dTBMTXlNeVhRNVdX?=
 =?utf-8?B?bnJYVElheml0T1pwTmh4KzhOOFJUWVJGd1V6S1JqVUJTQTBxODFXd0xGVjVB?=
 =?utf-8?B?RnErN0w0WE5YZFFSR2RLckw2a3UrS3BXVk9PamdKUlV0a0o1WTVkS0JKekF5?=
 =?utf-8?B?NldpNnlFVWdoN2c0U0VBTWRscmpjZ3AvdUxDS1RwV2FJUnZFdlFuaEducXI2?=
 =?utf-8?B?VHZCSnRJKy9QUENMeTVjWDc5a1RWVG1taCt2c3dDc2pDaUE5WWc0eHZ5MG02?=
 =?utf-8?B?Mkg1bmlLRjRlemNWKzZJK25CMGlWZWxpeVByYU1TSmd5em5oNVc5SUY4Uk1q?=
 =?utf-8?B?cmkwSDFFL1l4UE5vTm01bGpCN2hzVEFwVHljcnk3WkpMZmg2QVo4ZElGTERN?=
 =?utf-8?B?Zk9sSWdZZ1lDNmFoK1Z3WE1Jak9oeVgwQ1RyamFndHJRTjNmRWhXUm9Wc3BI?=
 =?utf-8?B?WkNjdGg0eEN2R1BlNVFKeStRY2dHdHpPVUFZdFhHVS9jVm5RY21iQXA0bmdp?=
 =?utf-8?B?cit0NFN4bEFEZXhhbVJ1TjQ3b20yd3dyckZabS9oTlIzNEZQcGQ2dkJyNzRE?=
 =?utf-8?B?L0JHUDJTbGpnSGM3VUVxeHE0cENaWjlwUlhQUlZrRzMvRDZCdEgrS09qaFZZ?=
 =?utf-8?B?SjQ3T1BSYll0ZnFKZlRzTnpPdTZaVzZNSkljbkltMDBBU3l6eVc4TVZuTFZz?=
 =?utf-8?B?VW5LQWJrK2NPOFdjZFFYb0JjTzd0YzdOMnA5dkhMK0VzMWNrVjRXRTR3b1cy?=
 =?utf-8?B?V1VaQW1na2sydGIyQzBRTW1CS2xVSVNkTVlIcC9rUEROaG16M2htdnVWSXVt?=
 =?utf-8?B?NnF1bW9OK0prYk1jaXNRNzEwM0cwSkRtT0NEZzNHdzd1SUlGSmFKUlNsRGFP?=
 =?utf-8?B?c1BNQkZqeWlVVGdRWW1XTlZlY2VlWmt5T1A1TUxLNHB0MDFrOGFSYzhPNjg1?=
 =?utf-8?B?bjd0b2sxaWxFWFFBakg4UWpnc3RYdURGb1p0VUZuSitnd2wwajRVZ2JqTjFj?=
 =?utf-8?B?NkwrbmdzeXRvbHpVeUUzVDlva2VmOEJHdDQzbVpnN0dHZGE0bTEzSlpTYVZ6?=
 =?utf-8?B?V3dQUXJNb1hFd2tKL3BlU08wdnJxajdIcm14ZWhFZEZORE9nU04zaDB6T3pB?=
 =?utf-8?B?ZUVuTUxxYWVMdUtrMDBpaVhnam11Z0M0TmFLSEIwOFZ2R3lpZXRxQUxXeTF1?=
 =?utf-8?B?ZW5lQ09tUzlEbHRTSTE0NEZRb3lsakpaTnVLNHo4dVFpN3dUZDRxV3NGZ0k2?=
 =?utf-8?B?ZHpoSExDQUdud2VFMktpREZoTlU0YW9SZnlQQ3dBQWQwdklNWkQ0Y2IvZjFo?=
 =?utf-8?B?d0tMRWRwNkpIbjlaK3JhaDlZNjAyTDVlVnVTcWRHUjNubTdReUtnTlY4T1ZD?=
 =?utf-8?B?QnlGbFJjMjkrb3hQVi9lYm0yRloyZC9RbmZGSzV1N1BKayswbC83cTZyUmJN?=
 =?utf-8?B?cml5SS8vZTlIMjdhQVJUNk5leGZsVGRDK3A4d1VVL1lKS1F4NzRQalpBM0Uz?=
 =?utf-8?B?bHdZcy9QRHk5b25RSG5XOGkyWlpxTnVkbjVRU1Y3TytrbWIrMVE2aUpXTjlQ?=
 =?utf-8?B?ZUFkVDM1Q25uS2xwQ3hLcFNoWkMvVlFLbytuWi81SkNRUU52UlZ4Zmd3OWtr?=
 =?utf-8?B?QjZhSjU5T1VEMWxwNWJvS3cwai9XamtjaWlYTlFQbXJkU0RvdlFCQ2M4cmZ1?=
 =?utf-8?B?blppVDFNaWNWdWdOWEZTZmM3U0lidDBnc0QxYTJjaVpzUnJEL016UDczcUVv?=
 =?utf-8?B?Smo2ejNIYXBkc1hQajhhUDIyb2hLNE5EWEpjVmY3UkUwSDg4UzU4MXhKa3J1?=
 =?utf-8?B?MmRZcW9zTTZLaTFWQmpPcWJSVlQwV21hc1ZidHI5bTBEL2N1a2cwODNBcUR3?=
 =?utf-8?B?L05mQU90ckVoT01XRmJTVHozeW5rcC9lRUVRVSs5RmpVNjNUZ0hKZnd5WWdD?=
 =?utf-8?B?UERGNG1LaWQ0Qk01Nm93ZytPeTlVa1JQS0kzVnJRQTZxYnpsWjZMRXUreFRD?=
 =?utf-8?B?YVdxTVFNaVhFZUpBSmFiMzJybzI5aW94MUN1WlhGVnROT01nM0swL2p5cXlY?=
 =?utf-8?Q?Hh63MgUU9Kxd9vCTSkbrIP4Te?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0e7671-53f6-4783-a8b5-08db0e63eda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 08:17:35.4393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkHbtzQomL0cdRgMTcd6BnwF3SAlNR6TN58aUqaaMYvWzlWW0lN4ZYWTQ7rYG6Ifm0PZXAfpqS3nWFD/DdKljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEZlYiAxMSwgMjAyMywgYXQgNjoxOCBBTSwgWmhhbmcsIFFpYW5nMSA8cWlhbmcxLnpo
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4+IA0KPj4gDQo+Pj4gT24gU2F0LCBG
ZWIgMDQsIDIwMjMgYXQgMDI6MjA6NTBBTSArMDAwMCwgSm9lbCBGZXJuYW5kZXMgKEdvb2dsZSkg
d3JvdGU6DQo+Pj4gUmVjZW50IGRpc2N1c3Npb24gdHJpZ2dlcmVkIGR1ZSB0byBhIHBhdGNoIGxp
bmtlZCBiZWxvdywgZnJvbSBRaWFuZywNCj4+PiBzaGVkIGxpZ2h0IG9uIHRoZSBuZWVkIHRvIGFj
Y2VsZXJhdGUgZnJvbSBRUyByZXBvcnRpbmcgcGF0aHMuDQo+Pj4gDQo+Pj4gVXBkYXRlIHRoZSBj
b21tZW50cyB0byBjYXB0dXJlIHRoaXMgcGllY2Ugb2Yga25vd2xlZGdlLg0KPj4+IA0KPj4+IExp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDExODA3MzAxNC4yMDIwNzQzLTEt
cWlhbmcxLnpoYW5nQGludGVsLmNvbS8NCj4+PiBDYzogUWlhbmcgWmhhbmcgPFFpYW5nMS56aGFu
Z0BpbnRlbC5jb20+DQo+Pj4gQ2M6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5l
bC5vcmc+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9lbCBGZXJuYW5kZXMgKEdvb2dsZSkgPGpvZWxA
am9lbGZlcm5hbmRlcy5vcmc+DQo+Pj4gDQo+Pj4gLS0tDQo+Pj4ga2VybmVsL3JjdS90cmVlLmMg
fCAxMyArKysrKysrKysrKystDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMg
Yi9rZXJuZWwvcmN1L3RyZWUuYw0KPj4+IGluZGV4IDkzZWIwM2Y4ZWQ5OS4uNzEzZWI2Y2E2OTAy
IDEwMDY0NA0KPj4+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+Pj4gKysrIGIva2VybmVsL3Jj
dS90cmVlLmMNCj4+PiBAQCAtMTk4Myw3ICsxOTgzLDEyIEBAIHJjdV9yZXBvcnRfcXNfcmRwKHN0
cnVjdCByY3VfZGF0YSAqcmRwKQ0KPj4+ICAgICAgfSBlbHNlIHsNCj4+PiAgICAgICAgICAgICAg
LyoNCj4+PiAgICAgICAgICAgICAgICogVGhpcyBHUCBjYW4ndCBlbmQgdW50aWwgY3B1IGNoZWNr
cyBpbiwgc28gYWxsIG9mIG91cg0KPj4+IC0gICAgICAgICAgICAgICogY2FsbGJhY2tzIGNhbiBi
ZSBwcm9jZXNzZWQgZHVyaW5nIHRoZSBuZXh0IEdQLg0KPj4+ICsgICAgICAgICAgICAgICogY2Fs
bGJhY2tzIGNhbiBiZSBwcm9jZXNzZWQgZHVyaW5nIHRoZSBuZXh0IEdQLiBEbw0KPj4+ICsgICAg
ICAgICAgICAgICogdGhlIGFjY2VsZXJhdGlvbiBmcm9tIGhlcmUgb3RoZXJ3aXNlIHRoZXJlIG1h
eSBiZSBleHRyYQ0KPj4+ICsgICAgICAgICAgICAgICogZ3JhY2UgcGVyaW9kIGRlbGF5cywgYXMg
YW55IGFjY2VsZXJhdGlvbnMgZnJvbSByY3VfY29yZSgpDQo+Pj4gKyAgICAgICAgICAgICAgKiBv
ciBub3RlX2dwX2NoYW5nZXMoKSBtYXkgaGFwcGVuIG9ubHkgYWZ0ZXIgdGhlIEdQIGFmdGVyIHRo
ZQ0KPj4+ICsgICAgICAgICAgICAgICogY3VycmVudCBvbmUgaGFzIGFscmVhZHkgc3RhcnRlZC4g
RnVydGhlciwgcmN1X2NvcmUoKQ0KPj4+ICsgICAgICAgICAgICAgICogb25seSBhY2NlbGVyYXRl
cyBpZiBSQ1UgaXMgaWRsZSAobm8gR1AgaW4gcHJvZ3Jlc3MpLg0KPj4gDQo+PiBBY3R1YWxseSBu
b3RlX2dwX2NoYW5nZXMoKSBzaG91bGQgdGFrZSBjYXJlIG9mIHRoYXQuDQo+PiANCj4+IFlvdSBh
cmUgcmVmZXJyaW5nIHRvICByY3VfY29yZSgpIC0+IHJjdV9jaGVja19xdWllc2NlbnRfc3RhdGUo
KSAtPg0KPj4gbm90ZV9ncF9jaGFuZ2VzKCkgZG9pbmcgdGhlIGFjY2VsZXJhdGlvbiBwcmlvciB0
byB0aGUgIHJjdV9jb3JlKCkgLT4NCj4+IHJjdV9yZXBvcnRfcXNfcmRwKCkgY2FsbCwgY29ycmVj
dD8NCj4+IA0KPj4gQWgsIGJ1dCBub3RlX2dwX2NoYW5nZXMoKSBoYXMgYW4gZWFybHkgcmV0dXJu
IHdoaWNoIHRyaWdnZXJzIGlmIGVpdGhlcjoNCj4+IDEuIFRoZSBybnAgc3BpbmxvY2sgdHJ5bG9j
ayBmYWlsZWQuDQo+PiAyLiBUaGUgc3RhcnQgb2YgYSBuZXcgZ3JhY2UgcGVyaW9kIHdhcyBhbHJl
YWR5IGRldGVjdGVkIGJlZm9yZSwgc28NCj4+IHJkcC0+Z3Bfc2VxID09IHJucC0+Z3Bfc2VxLg0K
Pj4gDQo+PiBTbyBJIHRoaW5rIGl0IGlzIHBvc3NpYmxlIHRoYXQgd2UgYXJlIGluIHRoZSBtaWRk
bGUgb2YgYSBHUCwgYW5kDQo+PiByY3VfY29yZSgpIGlzIGNhbGxlZCBiZWNhdXNlIFFTIHJlcG9y
dGluZyBpcyByZXF1aXJlZCBmb3IgdGhlIENQVSwgYW5kDQo+PiBzYXkgdGhlIGN1cnJlbnQgR1Ag
c3RhcnRlZCB3ZSBhcmUgaW4gdGhlIG1pZGRsZSBvZmYgb2NjdXJzIGZyb20gdGhlDQo+PiBzYW1l
IENQVSBzbyByZHAtPmdwX3NlcSA9PSBybnAtPmdwX3NlcS4NCj4+IA0KPj4gTm93LCByY3VfY29y
ZSgpJ3MgY2FsbCB0byBub3RlX2dwX2NoYW5nZXMoKSBzaG91bGQgcmV0dXJuIGVhcmx5IGJ1dA0K
Pj4gaXRzIGxhdGVyIGNhbGwgdG8gcmVwb3J0X3FzX3JkcCgpIHdpbGwgbm90IGFjY2VsZXJhdGUg
dGhlIGNhbGxiYWNrDQo+PiB3aXRob3V0IHRoZSBjb2RlIHdlIGFyZSBjb21tZW50aW5nIGhlcmUu
DQo+PiANCj4+IE15IGd1dCBmZWVsaW5nIGlzIHRoYXQgdGhlDQo+PiBhY2NlbGVyYXRpb24gaW4g
cmN1X3JlcG9ydF9xc19yZHAoKSBvbmx5IHN0YW5kcyBmb3I6DQo+PiANCj4+ICogY2FsbGJhY2tz
IHRoYXQgbWF5IGJlIGVucXVldWVkIGZyb20gYW4gSVJRIGZpcmluZyBkdXJpbmcgdGhlIHNtYWxs
IHdpbmRvdw0KPj4gIGJldHdlZW4gdGhlIFJOUCB1bmxvY2sgaW4gbm90ZV9ncF9jaGFuZ2VzKCkg
YW5kIHRoZSBSTlAgbG9jayBpbg0KPj4gIHJjdV9yZXBvcnRfcXNfcmRwKCkNCj4gDQo+IEZvciBy
ZHAgd2hpY2ggaXMgaW4gdGhlIG1pZGRsZSBvZiBhIGRlLW9mZmxvYWRpbmcgcHJvY2VzcywgdGhl
IGJ5cGFzcyBsaXN0IGhhdmUgYmVlbg0KPiBmbHVzaGVkLCB0aGUgbm9jYiBrdGhyZWFkcyBtYXkg
bWlzcyBjYWxsYmFja3MgYWNjZWxlcmF0aW9uLiAgIGludm9rZSBjYWxsX3JjdSgpDQo+IHdpbGwg
YWxzbyBub3QgdXNlIGJ5cGFzcyBsaXN0LiBpZiBhdCB0aGlzIHRpbWUgYSBuZXcgZ3Agc3RhcnRz
LCBiZWZvcmUgY2FsbCByY3VfcmVwb3J0X3FzX3JkcCgpDQo+IHRvIHJlcG9ydCBxcywgIGV2ZW4g
aWYgcmN1X2NvcmUoKSBpbnZva2Ugbm90ZV9ncF9jaGFuZ2VzKCkgbm90aWNlIGdwIHN0YXJ0LCB0
aGlzIHJkcCdzIGNhbGxiYWNrDQo+IG1heSBzdGlsbCBtaXNzIGFjY2VsZXJhdGlvbiBpZiByZHAg
c3RpbGwgaW4gZGUtb2ZmbG9hZGluZyBwcm9jZXNzLCBiZWNhdXNlIGludm9rZSByY3VfcmRwX2lz
X29mZmxvYWRlZCgpDQo+IHN0aWxsIHJldHVybiB0cnVlLg0KPiANCj4gSSB0aGluayB0aGlzIGlz
IGFsc28gYSByZWFzb24uDQo+DQo+SSB0ZW5kIHRvIGFncmVlIHdpdGggeW91LiBJIGFtIHdvbmRl
cmluZyB0aGUgYmVzdCB3YXkgdG8gZG9jdW1lbnQgYWxsIHRoZXNlIHJlYXNvbnMuIFBlcmhhcHMg
aXQgc3VmZmljZXMgdG8gbWVudGlvbiBhIGZldyByZWFzb25zIGJyaWVmbHkgaGVyZSwgd2l0aG91
dCBnb2luZyBpbnRvIHRvbyBtdWNoIGRldGFpbCAoYmVjYXVzZSBkZXRhaWxzIG1heSBiZSBzdWJq
ZWN0IHRvIGNoYW5nZSkuDQoNCg0KQWdyZWUsIGp1c3QgbWVudGlvbiBhIGZldyBtYWluIHJlYXNv
bnMsIGFuZCB0aGUgZGV0YWlscyBtYXkgYmUgcHV0IGluIHRoZSBkb2N1bWVudC4NCg0KVGhhbmtz
DQpacWlhbmcNCg0KDQo+DQo+SSB3aWxsIGxvb2sgdGhyb3VnaCB0aGlzIGVudGlyZSB0aHJlYWQg
YWdhaW4gYW5kIHRha2UgYSBjYWxsIG9uIGhvdyB0byBwcm9jZWVkLCBidXQgZG8gbGV0IG1lIGtu
b3cgd2hhdCB5b3UgYW5kIEZyZWRlcmljIHRoaW5rIGFib3V0IHRoZSBuZXh0IHN0ZXBzLiBUaGUg
bWFpbiBiZW5lZml0IG9mIGNvbW1lbnRpbmcgaXMgd2UgZG9udCBsb29rIGF0IHRoaXMgaW4gYSBm
ZXcgeWVhcnMgYW5kIHJ1biBpbnRvIHRoZSBzYW1lIHF1ZXN0aW9u4oCmDQo+DQo+VGhhbmtzIQ0K
Pg0KPkpvZWwNCg0KPiANCj4gVGhhbmtzDQo+IFpxaWFuZw0KPiANCj4+IA0KPj4gU3VyZSwgdGhp
cyBhbHNvIHNlZW1zIGxpa2UgYSB2YWxpZCByZWFzb24uDQo+PiANCj4+ICogX19ub3RlX2dwX2No
YW5nZXMoKSBnb3QgY2FsbGVkIGV2ZW4gYmVmb3JlIGZyb20gdGhlIEdQIGt0aHJlYWQsIGFuZCBj
YWxsYmFja3MNCj4+ICBnb3QgZW5xdWV1ZWQgYmV0d2VlbiB0aGF0IGFuZCByY3VfY29yZSgpLg0K
Pj4gDQo+PiBBZ3JlZWQuIEluIHRoaXMgY2FzZSB3ZSB3aWxsIHRha2UgdGhlIGVhcmx5IHJldHVy
biBpbg0KPj4gbm90ZV9ncF9jaGFuZ2VzKCkgd2hlbiBjYWxsZWQgZnJvbSB0aGUgcmN1X2NvcmUo
KS4gU28geWVhaCwgdGhhdCB3YXMNCj4+IGtpbmQgb2YgbXkgcG9pbnQgYXMgd2VsbCBidXQgc2xp
Z2h0bHkgZGlmZmVyZW50IHJlYXNvbmluZy4NCj4+IA0KPj4gTGV0IG1lIGtub3cgaWYgeW91IGRp
c2FncmVlIHdpdGggYW55dGhpbmcgSSBtZW50aW9uZWQsIHRob3VnaC4NCj4+IA0KPj4gLSBKb2Vs
DQo=
