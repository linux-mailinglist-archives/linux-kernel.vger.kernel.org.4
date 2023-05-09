Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C706FBDAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjEIDbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjEIDau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:30:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684610D3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683603048; x=1715139048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GR2H3TOISiyrj6Z9vHIsLChcrfPjXyWhQKj/gvPhC/E=;
  b=il18R93gk4LenA2Jr5HvaTYoMPvWOmxwT30S2x+53ZK+UYWy2iysa/f4
   lbr4yBrixwsqf0PkIRwGSHSThBT9PfQ5brhYPUu5OOdLBGwWPAtrcLxGy
   V+ZPwdKsBPJ2anp2DxuXubv7TxJm606um2Zt6wSvn5bIKjb3XN5WTD2UP
   myZ2znNuQsDY7S/VuwXWfrE8aoMvLFhFou4tAgi4M/FzNIoY0u/ARoWmv
   rlSifGjq2eH4VNgFbhP2dpGpHIRCG3bhdUifke2wpggm9ODjzb4XDSDUY
   Ww1z/syJJuLvs2HJwr29cXKxWv/EAi1k75FicLtRczweKQ4RKwv/ukSyJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377897716"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="377897716"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 20:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="701670008"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="701670008"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2023 20:30:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 20:30:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 20:30:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 20:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYMADBNZ3oTt5gSDBin+AItNsUAOCZLBp74/7JDHE01Y0MrVl53i0JmbjUnkiN2nnhj/1vj5k64fMcY1Uj/3a3UzGb48BItUFud4+hNIzn57M/EeicHjB4j3yuKWd16psqz2+LdwF+oDJA+h/lCYECWueq+2lv5GkIATOOHnrja92iwSYaBfJDHu/5HOKZKRO9Yln3R3GHCXKFh1Ce0vfmd2Qze91nJVSByI7N7F7Fo6tyLss/ZJelHoLmtmSqcJjEB/pR1Ch4E2R5AWKGTePnqtMyKSI7QV2S0YcESYGHpbOVUBPyl1pLCPMOsLUP7MEvuMJD0sXpcgAmwJjkIjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR2H3TOISiyrj6Z9vHIsLChcrfPjXyWhQKj/gvPhC/E=;
 b=bjCebzOVlBVD7yU+a2H/9Ol+RH+YBqKrQA4lOnmhgWyafu7mg3YAeuf3hTxabSVBHtJfRzJkh0y3KHPboqL8FKggj8xwE/cV2NxiJjM04Fd0ID27RDjFeRosm0Sp1Lim2dcQItAGbvl3p739jm08ednPj84zGU6FTc2HGecgmxtdnPre2JbFBVU2SnhopxKofZiwQpcJL+K859NCiYj7QlznXnsXZEDR6TU5jbVrSSI0SuYwQA9FjfTcqG0FNbriiyxjSE6pqK2gj0J+4p6tPkXNTboX1krG+oDjubz6quwmySoYhIOB+E5WlQHM4ZfuLfDF9wjO0VZ9O6VLvGvo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 03:30:40 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 03:30:40 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
 locked_pending bits
Thread-Topic: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
 locked_pending bits
Thread-Index: AQHZgYVXNOgy8IoOo0K7W+BWXJKqna9QgTkAgACz4HCAAAvkgIAAA5Bw
Date:   Tue, 9 May 2023 03:30:39 +0000
Message-ID: <IA1PR11MB6171DBBD1F386020667324DD89769@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230508081532.36379-1-qiuxu.zhuo@intel.com>
 <29297e16-2c79-8367-cd6c-efedd0a8d9ed@redhat.com>
 <IA1PR11MB617102EB293516D2DC81F28089769@IA1PR11MB6171.namprd11.prod.outlook.com>
 <3432de9e-6642-10c0-31e5-ac0ce65bea23@redhat.com>
In-Reply-To: <3432de9e-6642-10c0-31e5-ac0ce65bea23@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SA1PR11MB8448:EE_
x-ms-office365-filtering-correlation-id: 78b2625f-db2f-4add-d5db-08db503dc31f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cHnOs1DqSYSJ8aUIEDTradhAkFX6o+TjVG2oYrrh9LPkQin65KyRpuemmwdWGe9/1O/dQmiLVxNVaqzqulAeCPQs5JVPFkQ/Ep9+WqmVTCi5iTtsFjRvAMflfTOYO8NeA+y/2HsIGfvx4fpBjIw+rvGp7ekDSGuS1psx6WXNtugrXt7OZd30xhfCddbTkHm2EA4TwaIxoRdEQpYvJj0iyw8fOeKearaVlWeijNSAQpX93P8n3RpWcQw0wd6ogl7JjMvaGqW4Xjd6rYuzS+NJTdCYNzmGpN0lL44SzDkrSeaBAfjEuaLLlCuW3ib+JudwlpOpNvtyVQSE7GiwCvTrg8teOPT7SjU+Q/v1mtBTZwPWd7l1MUvB9SAsA4eWAg+OWlDkBdfWJlY/zcWBksxMdh9uoVRp/OOqTYbK6rPV/zjcTkzrBz+BCVaCEQo34lIBUA6BjC+s5YoyoQMudHNheN5kYqWrz2Dg/ETcKwkT+AProyrO5PAkA4B/VHZo9azXiCK8dFMx5WSARPCNKuWFmgBBGz0ei6gIwkZGMxUe1G7wxI6x0T24eTrE5wTY5tFIo+of3pxGnv11qjrTX4AlJKLEmKA0pFGAcE1o8G8/eag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(86362001)(66476007)(33656002)(966005)(54906003)(110136005)(66946007)(316002)(478600001)(76116006)(66556008)(66446008)(64756008)(4326008)(7696005)(55016003)(5660300002)(52536014)(2906002)(71200400001)(41300700001)(8676002)(8936002)(122000001)(38100700002)(82960400001)(38070700005)(186003)(26005)(53546011)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWFzT3VXcFJIcVVVRXdnbGZxYUw1ZUJDYXZpTEN6czJEckc5ZU1RbVhhbnY4?=
 =?utf-8?B?SnJtTGwyWEJZRHYwYytuQW1UbVZTT0prNGpLWEIxeU5udXM5cngyb1dJRm9S?=
 =?utf-8?B?VDY5cXdFekNOWFlMejZDclNlc2oyaVY3NDI0dGY4dmg5UDBxdnp6cXAzZFpZ?=
 =?utf-8?B?U2NZUFdaWlNxazFwZTZpeTBibTRtU085MndzTmJvZi9QL3JKNW16aXlXNWJt?=
 =?utf-8?B?OFhSRWJ3UWJhWkVLT1pYclJXcnY2ZUJkUFBIdEZjRkRkZWNqTE16VUVHQzNn?=
 =?utf-8?B?QktLaHZpb29qTHNqYzJIYk1PMXMwdDBIMEpvNkNKdGNMNFFIQ000RUFjRkxv?=
 =?utf-8?B?U1ZKQytzZkNzV1pJbmU2d2JOSlhSVGNOUGNnNWc4ZnVHQ05TTzRjZnYyNUhw?=
 =?utf-8?B?RmEwRFFNQ2FQbDhNRzN5dFJEOEEzVEpvK1RNaVVpbFJlZlp1YVNjMHh3Yi9Z?=
 =?utf-8?B?SVlhTkpoUFFERmttOWE4NTcwbEpjNzJ5K1BUTkNsR2FHcDdaTVpmcU1WbGww?=
 =?utf-8?B?UzhuRVFZdCtWWkRUd1JKU28wVjR1MDErdGlleHdjLzhMYXlFMXhxenNKaFJK?=
 =?utf-8?B?aFVoZnpGOGYyZmlJVG1kSFM1dDdIS2hQclZVczFXZGNjY3JoZ2pGSVN2UTN2?=
 =?utf-8?B?Q1V4czhSa1F0SUM3T3o0czBxTDFxQ0htTFpLZlgydG5BV29MS1ZkK3hZb09X?=
 =?utf-8?B?ZzR3QWZwKzJyZXh1MmxwejE2bDRxdFF5QXMzZm82aHMyUWhCdmFvbE1EVWhs?=
 =?utf-8?B?SncxREJETFdCNGt1NHUrMURWRnhjZk5WdUJJSWxUekdBUlpyUXRTRkltOE1L?=
 =?utf-8?B?TnNTOEw0dVNxR3BscTJWZ0M0VjhERFpxWEVPLzk1VXVOSnBoSVNkRzhwRG5m?=
 =?utf-8?B?eWsxUzZqbkMrZzQ3NWlKSU5FRS9qdEExR3c2d0t1dmwyMnlGdFBiVUpXTlZW?=
 =?utf-8?B?S2ludjc4V0k2alNQY0Y5UDRVa3pKQTZsdlVJSkhZR2l4R3BHWlJxcTAvbWlm?=
 =?utf-8?B?aXpKaEZNL3RZWWJ5aEVxYUFOV2JNamtaMitNd2JqSzA3WkRSWUt5aVc0S0xl?=
 =?utf-8?B?V0Y2eXNNSzNSMzk2MFJTWjRQNk9jZGJGVzIzWE5pTGg0VXY2d2pPc21qME1l?=
 =?utf-8?B?bmdqRFBtK1lSeXFMMDBpa3hOMHN0M1JBUWt4TTFsNVhRc1JpelVpNXpKKzd0?=
 =?utf-8?B?Mzg3b2JYUHJEdjF4eWpzL1NPTUczNHRPK1Y0OUlkOHN6cHNsYjJwMDF2dEdu?=
 =?utf-8?B?WitMYkRMaHIzejNUV2cyV0pSY0I3eGxLdmVCYWd2NkgvVWcwNVhJTldhL3ZV?=
 =?utf-8?B?Ym5SbmN5MUZxeklRbWRpMzFaSVRxN3FPNWhRTTlIQ1FxR3pQZzdqWmVqYmRD?=
 =?utf-8?B?VHlUQWtKQnlCeUxPMHppU2dWc0dYamQ1QXFQR1gvWUJKOGJUL1Arei9sNGVh?=
 =?utf-8?B?SnZ4blRyYnlUV0hCeWtRY3dNUDRBL0thRGRNMGl5WDVoU2MvaGQ3Mzd2S0Jz?=
 =?utf-8?B?KzJjMThmeFZOb05kQnVSMGQyMUJwMVl0TVh4bWNERmkxSnpIQndNRHg0Nkdj?=
 =?utf-8?B?SXdoYlpOaVJWeUdndkw0Q0JjamFiSmVvZTZpOWlpRnhRdnU5bUhzUWJXZVhQ?=
 =?utf-8?B?TE5RRVNqV3VqTkJPbEZSU1FVUi81OW0wMFRwWFFNR2hZNldRQXZiTjd4amlC?=
 =?utf-8?B?aC9TMnJYTVRoTGlYZVRqb3FUNTd6YUxwQXM4QlJ1RWNxc29aOWYzd3A0dXI2?=
 =?utf-8?B?V2RicklTMndUNHJITUFjc2F6c3BLUTVOOWFLbHByLzdLNktWM0xrVGRCbm44?=
 =?utf-8?B?UE93Y25NcEJibjVhY2w1TkJrSlVtbXRjbTR5aC9KaEZHOHIvNXR2ZC9HQzRQ?=
 =?utf-8?B?MFJ3R3ZVUzB5RWpoRFNxQXFUejNnSExMdmdJOGNJK1NIWWZHYlVMcE9zWi9h?=
 =?utf-8?B?SEl3MDBFbWFqTjc3ajhIR2FSWURhMmNuWFZ6M0Yvcm92M3A2WWVNaVRISzFv?=
 =?utf-8?B?NXdCTjZ1dUttYTZaR1pCdkY3TWhHR0JvTEk2SzZlVGpJYkYreDdpOHRlMW5T?=
 =?utf-8?B?dE1QTVY3cmliMVozbStYMFNWQkR6ZURKb05BMjVrU1BBR0k4WFVXR1J4Q21S?=
 =?utf-8?Q?zR9ah8AuH8kZI6aMuDCCui09Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b2625f-db2f-4add-d5db-08db503dc31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 03:30:39.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILvG5MFjwaTvMDo2B6Y+Q3uyCZq0tQyeFV4cZV0AZf3ExucmpA0xTYnaLa/rBMRLO2fN+E/kAbutafeW64t4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBNYXkgOSwgMjAyMyAxMDo1OCBBTQ0KPiBUbzogWmh1bywgUWl1eHUgPHFpdXh1LnpodW9AaW50
ZWwuY29tPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBXaWxsIERlYWNvbg0KPiA8d2lsbEBrZXJuZWwub3Jn
Pg0KPiBDYzogQm9xdW4gRmVuZyA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBsb2NraW5nL3FzcGlu
bG9jazogTWFrZSB0aGUgMXN0IHNwaW5uZXIgb25seSBzcGluIG9uDQo+IGxvY2tlZF9wZW5kaW5n
IGJpdHMNCj4gDQo+IA0KPiBPbiA1LzgvMjMgMjI6NDUsIFpodW8sIFFpdXh1IHdyb3RlOg0KPiA+
IEhpIFdhaW1hbiwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcgb2YgdGhpcyBwYXRj
aC4NCj4gPiBQbGVhc2Ugc2VlIHRoZSBjb21tZW50cyBiZWxvdy4NCj4gPg0KPiA+PiBGcm9tOiBX
YWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE1heSA4
LCAyMDIzIDExOjMxIFBNDQo+ID4+IFRvOiBaaHVvLCBRaXV4dSA8cWl1eHUuemh1b0BpbnRlbC5j
b20+OyBQZXRlciBaaWpsc3RyYQ0KPiA+PiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1v
bG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFdpbGwgRGVhY29uDQo+ID4+IDx3aWxsQGtlcm5lbC5v
cmc+DQo+ID4+IENjOiBCb3F1biBGZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGxvY2tp
bmcvcXNwaW5sb2NrOiBNYWtlIHRoZSAxc3Qgc3Bpbm5lciBvbmx5DQo+ID4+IHNwaW4gb24gbG9j
a2VkX3BlbmRpbmcgYml0cw0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA1LzgvMjMgMDQ6MTUsIFFpdXh1
IFpodW8gd3JvdGU6DQo+ID4+PiBUaGUgMXN0IHNwaW5uZXIgKGhlYWRlciBvZiB0aGUgTUNTIHF1
ZXVlKSBzcGlucyBvbiB0aGUgd2hvbGUNCj4gPj4+IHFzcGlubG9jayB2YXJpYWJsZSB0byBjaGVj
ayB3aGV0aGVyIHRoZSBsb2NrIGlzIHJlbGVhc2VkLiBGb3IgYQ0KPiA+Pj4gY29udGVuZGVkIHFz
cGlubG9jaywgdGhpcyBzcGlubmluZyBpcyBhIGhvdHNwb3QgYXMgZWFjaCBDUFUgcXVldWVkDQo+
ID4+PiBpbiB0aGUgTUNTIHF1ZXVlIHBlcmZvcm1zIHRoZSBzcGlubmluZyB3aGVuIGl0IGJlY29t
ZXMgdGhlIDFzdA0KPiA+Pj4gc3Bpbm5lciAoaGVhZGVyIG9mDQo+ID4+IHRoZSBNQ1MgcXVldWUp
Lg0KPiA+Pj4gVGhlIGdyYW51bGFyaXR5IGFtb25nIFNNVCBoL3cgdGhyZWFkcyBpbiB0aGUgc2Ft
ZSBjb3JlIGNvdWxkIGJlDQo+ICJieXRlIg0KPiA+Pj4gd2hpY2ggdGhlIExvYWQtU3RvcmUgVW5p
dCAoTFNVKSBpbnNpZGUgdGhlIGNvcmUgaGFuZGxlcy4gTWFraW5nIHRoZQ0KPiA+Pj4gMXN0IHNw
aW5uZXIgb25seSBzcGluIG9uIGxvY2tlZF9wZW5kaW5nIGJpdHMgKG5vdCB0aGUgd2hvbGUNCj4g
Pj4+IHFzcGlubG9jaykgY2FuIGF2b2lkIHRoZSBmYWxzZSBkZXBlbmRlbmN5IGJldHdlZW4gdGhl
IHRhaWwgZmllbGQgYW5kDQo+ID4+PiB0aGUgbG9ja2VkX3BlbmRpbmcgZmllbGQuIFNvIHRoaXMg
bWljcm8tb3B0aW1pemF0aW9uIGhlbHBzIHRoZSBoL3cNCj4gPj4+IHRocmVhZCAodGhlIDFzdCBz
cGlubmVyKSBzdGF5IGluIGEgbG93IHBvd2VyIHN0YXRlIGFuZCBwcmV2ZW50cyBpdA0KPiA+Pj4g
ZnJvbSBiZWluZyB3b2tlbiB1cCBieSBvdGhlciBoL3cgdGhyZWFkcyBpbiB0aGUgc2FtZSBjb3Jl
IHdoZW4gdGhleQ0KPiA+Pj4gcGVyZm9ybQ0KPiA+Pj4geGNoZ190YWlsKCkgdG8gdXBkYXRlIHRo
ZSB0YWlsIGZpZWxkLiBQbGVhc2Ugc2VlIGEgc2ltaWxhcg0KPiA+Pj4gZGlzY3Vzc2lvbiBpbiB0
aGUgbGluaw0KPiA+PiBbMV0uDQo+ID4+PiBbMV0NCj4gPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyMzAxMDUwMjE5NTIuMzA5MDA3MC0xLQ0KPiBndW9yZW5Aa2VybmVsLm9yZw0KPiA+
Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29t
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBrZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYyB8IDEzICsr
KysrKysrKysrKysNCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+
ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5jIGIva2Vy
bmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMNCj4gPj4+IGluZGV4IGVmZWJiZjE5Zjg4Ny4uZTdiOTkw
YjI4NjEwIDEwMDY0NA0KPiA+Pj4gLS0tIGEva2VybmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMNCj4g
Pj4+ICsrKyBiL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5jDQo+ID4+PiBAQCAtNTEzLDcgKzUx
MywyMCBAQCB2b2lkIF9fbG9ja2Z1bmMNCj4gPj4gcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aChz
dHJ1Y3QgcXNwaW5sb2NrICpsb2NrLCB1MzIgdmFsKQ0KPiA+Pj4gICAgCWlmICgodmFsID0gcHZf
d2FpdF9oZWFkX29yX2xvY2sobG9jaywgbm9kZSkpKQ0KPiA+Pj4gICAgCQlnb3RvIGxvY2tlZDsN
Cj4gPj4+DQo+ID4+PiArI2lmIF9RX1BFTkRJTkdfQklUUyA9PSA4DQo+ID4+PiArCS8qDQo+ID4+
PiArCSAqIFNwaW5uaW5nIG9uIHRoZSAyLWJ5dGUgbG9ja2VkX3BlbmRpbmcgaW5zdGVhZCBvZiB0
aGUgNC1ieXRlDQo+ID4+IHFzcGlubG9jaw0KPiA+Pj4gKwkgKiB2YXJpYWJsZSBjYW4gYXZvaWQg
dGhlIGZhbHNlIGRlcGVuZGVuY3kgYmV0d2VlbiB0aGUgdGFpbCBmaWVsZCBhbmQNCj4gPj4+ICsJ
ICogdGhlIGxvY2tlZF9wZW5kaW5nIGZpZWxkLiBUaGlzIGhlbHBzIHRoZSBoL3cgdGhyZWFkICh0
aGUgMXN0DQo+ID4+IHNwaW5uZXIpDQo+ID4+PiArCSAqIHN0YXkgaW4gYSBsb3cgcG93ZXIgc3Rh
dGUgYW5kIHByZXZlbnRzIGl0IGZyb20gYmVpbmcgd29rZW4gdXANCj4gPj4+ICtieQ0KPiA+PiBv
dGhlcg0KPiA+Pj4gKwkgKiBoL3cgdGhyZWFkcyBpbiB0aGUgc2FtZSBjb3JlIHdoZW4gdGhleSBw
ZXJmb3JtIHhjaGdfdGFpbCgpIHRvDQo+ID4+IHVwZGF0ZQ0KPiA+Pj4gKwkgKiB0aGUgdGFpbCBm
aWVsZCBvbmx5Lg0KPiA+Pj4gKwkgKi8NCj4gPj4+ICsJc21wX2NvbmRfbG9hZF9hY3F1aXJlKCZs
b2NrLT5sb2NrZWRfcGVuZGluZywgIVZBTCk7DQo+ID4+PiArCXZhbCA9IGF0b21pY19yZWFkX2Fj
cXVpcmUoJmxvY2stPnZhbCk7ICNlbHNlDQo+ID4+PiAgICAJdmFsID0gYXRvbWljX2NvbmRfcmVh
ZF9hY3F1aXJlKCZsb2NrLT52YWwsICEoVkFMICYNCj4gPj4+IF9RX0xPQ0tFRF9QRU5ESU5HX01B
U0spKTsNCj4gPj4+ICsjZW5kaWYNCj4gPj4+DQo+ID4+PiAgICBsb2NrZWQ6DQo+ID4+PiAgICAJ
LyoNCj4gPj4gV2hhdCBoYXJkd2FyZSBjYW4gYmVuZWZpdCBmcm9tIHRoaXMgY2hhbmdlPyBEbyB5
b3UgaGF2ZSBhbnkgbWljcm8tDQo+ID4+IGJlbmNobWFyayB0aGF0IGNhbiBzaG93IHRoZSBwZXJm
b3JtYW5jZSBiZW5lZml0Pw0KPiA+IGkpICBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlIHRvIG1l
YXN1cmUgdGhlIGRhdGEuDQo+ID4gICAgICBCdXQgSSBydW4gYSBiZW5jaG1hcmsgWzFdIGZvciB0
aGUgY29udGVuZGVkIHNwaW5sb2NrIG9uIGFuIEludGVsDQo+IFNhcHBoaXJlIFJhcGlkcw0KPiA+
ICAgICAgc2VydmVyICgxOTIgaC93IHRocmVhZHMsIDJzb2NrZXRzKSB0aGF0IHNob3dlZCB0aGF0
IHRoZSAxc3Qgc3Bpbm5lcg0KPiBzcGlubmluZyB3YXMNCj4gPiAgICAgIGEgaG90c3BvdCAoY29u
dHJpYnV0ZWQgfjU1JSBjYWNoZSBib3VuY2luZyB0cmFmZmljIG1lYXN1cmVkIGJ5IHRoZQ0KPiBw
ZXJmIEMyQy4NCj4gPiAgICAgICBJIGRvbid0IGFuYWx5emUgdGhlIGNhY2hlIGJvdW5jaW5nIGhl
cmUsIGJ1dCBqdXN0IHNheSB0aGUgc3Bpbm5pbmcgaXMgYQ0KPiBob3RzcG90KS4NCj4gSSBiZWxp
ZXZlIHRoZSBhbW91bnQgb2YgY2FjaGVsaW5lIGJvdW5jaW5nIHdpbGwgYmUgdGhlIHNhbWUgd2hl
dGhlciB5b3UNCj4gcmVhZCAzMiBvciAxNiBiaXRzIGZyb20gdGhlIGxvY2sgd29yZC4gQXQgbGVh
c3QgdGhpcyBpcyBteSB1bmRlcnN0YW5kaW5nIG9mIHRoZQ0KPiB4ODYgYXJjaC4gUGxlYXNlIGNv
cnJlY3QgbWUgaWYgbXkgYXNzdW1wdGlvbiBpcyBpbmNvcnJlY3QuDQoNCllvdSdyZSByaWdodC4g
DQpUaGUgYW1vdW50IG9mIGNhY2hlIGxpbmUgYm91bmNpbmcgd2FzIG5lYXJseSB0aGUgc2FtZSBl
aXRoZXIgc3Bpbm5pbmcgMzIgb3IgMTYgYml0cyANCihhY2NvcmRpbmcgdG8gbXkgbWVhc3VyZWQg
cGVyZiBDMkMgZGF0YSBvbiBhbiB4ODYgc2VydmVyKS4gDQogDQo+ID4NCj4gPiBpaSkgVGhlIHNp
bWlsYXIgbWljcm8tb3B0aW1pemF0aW9uIGRpc2N1c3Npb24gWzJdIChsb29rZWQgbGlrZSBpdCB3
YXMgYWNjZXB0ZWQNCj4gYnkgeW91IPCfmIkpIHRoYXQNCj4gPiAgICAgIGF2b2lkaW5nIHRoZSBm
YWxzZSBkZXBlbmRlbmN5IChiZXR3ZWVuIHRoZSB0YWlsIGZpZWxkIGFuZCB0aGUNCj4gbG9ja2Vk
X3BlbmRpbmcgZmllbGQpDQo+ID4gICAgICBzaG91bGQgaGVscCBzb21lIGFyY2hlcyAoZS5nLiwg
c29tZSBBUk02ND8/PykgdGhlIGgvdyB0aHJlYWQNCj4gKHNwaW5uZXIpIHN0YXkgaW4gYQ0KPiA+
ICAgICAgbG93LXBvd2VyIHN0YXRlIHdpdGhvdXQgdGhlIGRpc3J1cHRpb24gYnkgaXRzIHNpYmxp
bmcgaC93IHRocmVhZHMgaW4gdGhlDQo+IHNhbWUgY29yZS4NCj4gDQo+IFRoYXQgaXMgdHJ1ZS4g
SG93ZXZlciwgdGhpcyBwYXRjaCBjYXVzZXMgb25lIG1vcmUgcmVhZCBmcm9tIHRoZSBsb2NrDQo+
IGNhY2hlbGluZSB3aGljaCBpc24ndCBuZWNlc3NhcnkgZm9yIGFyY2hlcyB0aGF0IHdvbid0IGJl
bmVmaXQgZnJvbSBpdC4NCj4gU28gSSBhbSBsZXNzIGluY2xpbmUgdG8gYWNjZXB0IGl0IHVubGVz
cyB0aGVyZSBpcyBldmlkZW5jZSBvZiB0aGUNCj4gYmVuZWZpdCBpdCBjYW4gYnJpbmcuDQoNClRo
aXMgcGF0Y2ggcmVtb3ZlcyBhIGJpdHdpc2UgQU5EIG9wZXJhdGlvbiBvbiB0aGUgVkFMIHZhbHVl
Lg0KRG9lcyBpdCBjb21wZW5zYXRlIGZvciB0aGUgb25lIG1vcmUgcmVhZCBmcm9tIHRoZSBjYWNo
ZSBsaW5lPyANCiANClRoYW5rcyENCi0gUWl1eHUNCg0KPiBDaGVlcnMsDQo+IExvbmdtYW4NCg0K
