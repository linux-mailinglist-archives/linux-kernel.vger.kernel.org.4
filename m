Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA8652D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiLUID1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiLUIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:03:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2821266;
        Wed, 21 Dec 2022 00:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671609779; x=1703145779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfB4LwMDE7ubbuMUiA8cwyMO/VDbM8UnTj5p3wE9jZo=;
  b=jVmx5F6hi+DIBdgdKwnk2B/QEixpU0yxfOo0Ff96oxwsZ1C6EAItqlCj
   T7z6mtzYdN3O40LLExZtR9o2reXBjp3XlyhY5WY68QiiO+slYZc5C4GQY
   PVX9+27fRNZx6sdKVrT0tsbwU36x8LAO2sTCAAtJYT2IjG2IhsHM2IO63
   mdzUkWPM9+94Ay4c4oOwcrWwP5GftCh0HdoSy8Vg64p0FyqHOJ18ITv+b
   m/kmgDATu0iqgltA0hm+xeM1H8E1MtOkCpq2gm/7ntuswVkHoyLyBm5a3
   vsBD9XkQSRW0Y1yXIl+kGTMjRkBAFBuNWQ6s7DxsaiyAiOQfslzaT0kzM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="303239230"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="303239230"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 00:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="683701620"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="683701620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 21 Dec 2022 00:02:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 00:02:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 00:02:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 00:02:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTXpJvHtGgOSIMM8AGNAgFe+HjnI3vVOkvZPO3uHRT6l9PDv0i84hmFZ2z4+Lno5Tph1jq9xaIAVfYemQQmUs5aypRwevAtqzszYxkx4hU2Ja4uUQlTbCoPbfSiHplDSOA4RFlHYwkA/HuXY04V4v7WrHgf6+v3MZFkKl5FScsjpZehKrDu0gQC3vOxcDJecnl56d7nd8CRHVWimiKFIv/WjV+EWbU05X/FKbwOHt9QhOYDulxXbZAdQ+KvdJe5mQIdTrujoJoQG46BHzCjw0noUAGSgaHUaBjfuL14Y6IvwCut/9DRCUKogBfJnDCeY/Aq43ijRVDqzdbYUriOOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfB4LwMDE7ubbuMUiA8cwyMO/VDbM8UnTj5p3wE9jZo=;
 b=ghJuahmhffUUQnH3ASNid/7JuZ/C67EFOayqsgUC+mzfeiAta+5Me0VZItpQKgk9j4V4MQQN7pRbg0E8fTdH2RcO2YG7CMmqML9fdVqsuxmjqusl8PlEz5XWVzkQWc23kVw1zQSkVvZGCSbif7mTLgjESqfcJxvM0kaV0m2EeLxYRlTENnw0LE4ATBP5p2hQQS5E8We+NjLaKGc91WPDjTdqoMX9INf1FCXeLdziVBDrGQKzBN5znd/x2fisKkbF2z2dmDsf5+TkSz5e0/QF8iKMgfdtTd32eXMWwKmxzXiUM4bs2TxnFdE3+YIuVPKSsXNJbqe1CzaCo10jhPr+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2618.namprd11.prod.outlook.com (2603:10b6:5:c0::30) by
 PH0PR11MB7561.namprd11.prod.outlook.com (2603:10b6:510:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:02:49 +0000
Received: from DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::651a:609b:5f:6009]) by DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::651a:609b:5f:6009%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 08:02:49 +0000
From:   "Xu, Even" <even.xu@intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: intel_ish-hid: Add check for ishtp_dma_tx_map
Thread-Topic: [PATCH] HID: intel_ish-hid: Add check for ishtp_dma_tx_map
Thread-Index: AQHZFJWlTVdQleTULUmaQT0k8Sz2YK53+3+g
Date:   Wed, 21 Dec 2022 08:02:49 +0000
Message-ID: <DM6PR11MB26189BEF9321FE7E0D954821F4EB9@DM6PR11MB2618.namprd11.prod.outlook.com>
References: <20221122134823.540-1-jiasheng@iscas.ac.cn>
 <c8e7fdb0e29b975537551ed6331f91b76e426246.camel@linux.intel.com>
In-Reply-To: <c8e7fdb0e29b975537551ed6331f91b76e426246.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2618:EE_|PH0PR11MB7561:EE_
x-ms-office365-filtering-correlation-id: 40ae5d41-089c-48ba-6c17-08dae329c0db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KieFc/A0s60VEI+ja4jCsh30OMevT5VIvR2hkMLRmyFdBrk67b397LAsnoMn5oQPh5cofKe3FXZepjJKUqisVzyHCP2tHxvUu5e7i+nvWVG7htDUmkAtFkIgGd096qoqdXyPzn9I2e83u330E5EHlYJbqa2hUUyh+b3gHWLHP8TYNY6Pod3IGnblDqqh7yM4GxW0tfS2BHHkDhIwEU3M64aI0hBnBfUoAK+yQzlndd5S3tiLzKRNLjTqofFmRCd4Sb62V+xPcUvzF2Juo10J9khsSYtPkO0dyOy5UxDE9oTVo9AHJ7uREZNZxXFKUznr9Az/Zk1PajpWxvV1dWshPieb3Z5NGZDKTLin3Dm6qcsppM6cT2MMD6cmQwWRuDdbw0sYCMp5wRhx722M57SSWVhrTScymUBExbCxiJtoDFX5Tz7uOJ/NZNYpeTdnWJqnT6+xFyzwfLQrcJjcB35FziCl4ewjMSQzvNBgcjB/Y3LA7q/bxP6TDsWbVfhgaWTnkm/7twoAW6hvxfrg6CcFuw8eD0V/3ilXOOwPQ7esTH9tIAE4VwyrYPkZL4w6k08ll5ytWCI1q1U8Hdnw8wPc5F6mMgbi0RNDXWLCvHzlbRfjtPw1eRZw+ZnN92RVf7tby9V1aISWjsxrwHHUnCUV71ZT8MJfmzfaiYW2TNkVcYRRTAV8bKfhCJa/9cPbgFwwllByjju98quKd1FNoY0DBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(8936002)(33656002)(5660300002)(83380400001)(52536014)(41300700001)(186003)(55016003)(26005)(4001150100001)(2906002)(9686003)(478600001)(316002)(6506007)(82960400001)(38070700005)(7696005)(54906003)(53546011)(86362001)(4326008)(66476007)(76116006)(64756008)(66446008)(71200400001)(66946007)(66556008)(122000001)(38100700002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTFad1l3Rm1DQnNPWTRmMFcybU9WUm5BQkNiWElEenhLZk9oU2YvUkxTZVVl?=
 =?utf-8?B?TmxveVp4d2J0OXpiTmNlV1ZqSVR6UlNXWXpvY2hqZ0luamVIUlg1R1NyNGdJ?=
 =?utf-8?B?VFBCUUlmRksvajdEcGRTd1RqS1NtNXpHSGNEVGJHb1hZamhSWGN6YnJvd3V4?=
 =?utf-8?B?cklGcWFEZHM2ZmVPK29nbHZRNEo4NGhrMVhEc0V6VktCd0xJWllWbFNjMUNh?=
 =?utf-8?B?V1pFQlZVM25MSFdXNE9lYTEyZ0ZuWitWS0ZOOCtCNWhXYnYxR1NhMCtKNXpF?=
 =?utf-8?B?dzlkNlp6SGFYaHpGK2VCL3ZCYzdDdFBSOUlxSGsxODltY1c3WVh1M1VvK1FE?=
 =?utf-8?B?dWVKQmxadENDZGR2T216Z1FPbVFCa05RRVN3K0UxZENYUFZaWWUxeXhSUUh6?=
 =?utf-8?B?TFpaQ01BK2FGbFBaVXJPS004bEpKSEZ4VFBsNnh6bmNKRmZKR2JOdG1lNnpl?=
 =?utf-8?B?YXp3ejA5eDVyemFoVGJFUnNHMnFrSTBTdzhsRmRtcWp1MlliM0FTNEFoRnpr?=
 =?utf-8?B?dm1aVUtOU0pTYTZNeldJb2FybnJqMUFvc2NONzAyUmNIbVNGVDlnK0FyL3Vt?=
 =?utf-8?B?ZnN0dzA5c0cxZ3NOQ08zK1lIRXBibnFpMXd3SnZGdjh1OTNoRWFvbWF1WWNz?=
 =?utf-8?B?WFVUTlpXaUY0VmpNNXVhS2R6L1pQTDUwdGVGV1BQcXBFTFFONWN1bS9zamth?=
 =?utf-8?B?dUloSXNUcmtkbnEweGhjUVVLQmNQYjgxck55eTl3QWwxYTFjZ25qK0FrYmRE?=
 =?utf-8?B?ZGVIdzdGK2MvMnpzQ3dVai82SHBTa0JOMyt6NlNMUFpib2N4VUtpbnVQckhR?=
 =?utf-8?B?NTJ3ajVSbGovcU1vMll6U0lDTlFYUUZLVEc0L2tWaEZkRVk4dUhJbkdKZGl1?=
 =?utf-8?B?Zlc4M0E4T0VjZHdRNUR1a0VGK3pNbjR1MlprY1ltYzlhTDFYNENMTyt3M2Fw?=
 =?utf-8?B?ODhjbkdXcExHTVppMEx5TDJnVzdrVXdtbWIvZ3kwYm03K01jbDhzWWlZdUtK?=
 =?utf-8?B?dFdZRnBhdXZxN2YzNkNmS0lRb3puT0wzTkVZbGlibGdpcGZKUllPV1AxQlNm?=
 =?utf-8?B?MUpqZHFQNHJQVnJ2WlFKS0FlZWtZRjAyelgxR1VnSW5NVFVqQ1lycFF3RGNE?=
 =?utf-8?B?Z21YWEU4UEtsUjUvNnJFcU9ESGo5WW4vQ0FSY2ZoazdORVQ0dzhjeFpaL1pk?=
 =?utf-8?B?NmVLQ3kxR1hUYlgwbmxKWUV2MWVhbGNvV2pCYmNWUWxiMWRRc0JVcytXUWZ5?=
 =?utf-8?B?UkhSTkFaY2xOVEgreHhKTmpUdE5EZk9ybllhRnYvaWdGaklFOENZUkc2UnNy?=
 =?utf-8?B?QTU4akprMFhPOCt2UGNKaW9pRDFNdW1iS2w3NWFPNUhPRStxS0s1dDVtSVdS?=
 =?utf-8?B?aTdRQkloOEpDdkprb3VSVCtySGl5aXptbTQ0SlZiZzMzcHA4eHQ0Y3lFV3VT?=
 =?utf-8?B?REd6SzdxUmx4N2pQK2dtTVMyQnpwUElwMnVOTW9RQ1gyMDlUbGxVZFhUUGtC?=
 =?utf-8?B?ZGlaS2NuRHlJTVdoejdjYytYd0Z6a1p6b1A2dUxZR01UYmFXRndnSzQ3eGpQ?=
 =?utf-8?B?YzE2TUljdVM3QVZROUxhV3dwMW0yeU1VdzlFMXkrYUtkblJlRTVqTTg0WU1q?=
 =?utf-8?B?Z0NwOTdseHZjSGovR0xmYzdiandiNkoyWmt3UVBacEpXeFhrVWthUEtVUndO?=
 =?utf-8?B?cWZQVkNHNTUzN3kxeWlYQzlSenhrR1BidWx0SExEUzFBa3pVQUthZ1p3WGQr?=
 =?utf-8?B?YkMvdmo2WHhoSThCNlIwRW5ERUNBQy9EUFRNK3k3cW96MzdTeWo2Mjdzd1F6?=
 =?utf-8?B?UWRXY1hwemhPaVJUYkdkTFJPcFp2OE5zd3dwTXJHZFk3ai9xTXBNV0lZU09Z?=
 =?utf-8?B?YkwwQU1sQmRkSmJhTDR3QUx2Z1dMS0haNHpwTzg1L3VtOUhMa0JBc0loWkgr?=
 =?utf-8?B?SEtJTG9FdWZTelBIdS9RTE4vdEZMVnlaZzREUTdpUGp0YVo3SEhHeEZ3eGpK?=
 =?utf-8?B?c29yYlVqaGRuSythcytxVlJqeklodTlPczRjdXpsaktOdUR4NVJVMHpGWXlv?=
 =?utf-8?B?ZGZNOXRlUkpqRjN2elNjaTdtcmZSL3psSXZoblVxRFl5Z2JCZnlzNWNYV0pu?=
 =?utf-8?Q?xBHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ae5d41-089c-48ba-6c17-08dae329c0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 08:02:49.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDbR9r25DC/95rV78YYby5lMEa97+yt3o6+cQzgv8DrIU4GeneFUO9/MFESndtXsP2de2Ao6mYFJTwbqkcoZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBTcmluaXZhcywgYWdyZWUgd2l0aCB5b3UsIHRoZSBlcnJvciBoYW5kbGluZyBzaG91bGQg
YmUgYWRkZWQgZHVyaW5nIGFsbG9jYXRpb24uDQpXaWxsIHN1Ym1pdCB0aGUgcGF0Y2ggZm9yIGl0
Lg0KDQpUaGFua3MhDQoNCkJlc3QgUmVnYXJkcywNCkV2ZW4gWHUNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IHNyaW5pdmFzIHBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZh
ZGFAbGludXguaW50ZWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjEsIDIwMjIg
MTowOCBBTQ0KVG86IEppYXNoZW5nIEppYW5nIDxqaWFzaGVuZ0Bpc2Nhcy5hYy5jbj47IGppa29z
QGtlcm5lbC5vcmc7IGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tOyBYdSwgRXZlbiA8ZXZl
bi54dUBpbnRlbC5jb20+DQpDYzogbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBISUQ6IGludGVsX2lz
aC1oaWQ6IEFkZCBjaGVjayBmb3IgaXNodHBfZG1hX3R4X21hcA0KDQpPbiBUdWUsIDIwMjItMTEt
MjIgYXQgMjE6NDggKzA4MDAsIEppYXNoZW5nIEppYW5nIHdyb3RlOg0KPiBBcyB0aGUga2NhbGxv
YyBtYXkgcmV0dXJuIE5VTEwgcG9pbnRlciwgaXQgc2hvdWxkIGJlIGJldHRlciB0byBjaGVjayAN
Cj4gdGhlIGlzaHRwX2RtYV90eF9tYXAgYmVmb3JlIHVzZSBpbiBvcmRlciB0byBhdm9pZCBOVUxM
IHBvaW50ZXIgDQo+IGRlcmVmZXJlbmNlLg0KPiANCj4gRml4ZXM6IDM3MDNmNTNiOTllNCAoIkhJ
RDogaW50ZWxfaXNoLWhpZDogSVNIIFRyYW5zcG9ydCBsYXllciIpDQo+IFNpZ25lZC1vZmYtYnk6
IEppYXNoZW5nIEppYW5nIDxqaWFzaGVuZ0Bpc2Nhcy5hYy5jbj4NCkFja2VkLWJ5OiBTcmluaXZh
cyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4gLS0t
DQorRXZlbiBYdSwgV2Ugc2hvdWxkIGRvIGR1cmluZyBhbGxvYy4gUGxlYXNlIHRyeSB0byBzdWJt
aXQgYSBjaGFuZ2UgZm9yDQp0aGF0IGZvciBsYXRlciBrZXJuZWwgcmV2IGFzIGl0IHdpbGwgcmVx
dWlyZSBlcnJvciBwcm9jZXNzaW5nIGR1cmluZyBoYm0gZGlzcGF0Y2guDQoNCj4gwqBkcml2ZXJz
L2hpZC9pbnRlbC1pc2gtaGlkL2lzaHRwL2RtYS1pZi5jIHwgMTAgKysrKysrKysrKw0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9oaWQvaW50ZWwtaXNoLWhpZC9pc2h0cC9kbWEtaWYuYw0KPiBiL2RyaXZlcnMvaGlkL2ludGVs
LWlzaC1oaWQvaXNodHAvZG1hLWlmLmMNCj4gaW5kZXggNDA1NTRjOGRhY2EwLi4wMDA0NmNiZmQ0
ZWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXNodHAvZG1hLWlm
LmMNCj4gKysrIGIvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pc2h0cC9kbWEtaWYuYw0KPiBA
QCAtMTA0LDYgKzEwNCwxMSBAQCB2b2lkICppc2h0cF9jbF9nZXRfZG1hX3NlbmRfYnVmKHN0cnVj
dCANCj4gaXNodHBfZGV2aWNlICpkZXYsDQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmVxdWlyZWRf
c2xvdHMgPSAoc2l6ZSAvIERNQV9TTE9UX1NJWkUpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKyAxICogKHNpemUgJSBETUFfU0xPVF9TSVpFICE9IDApOw0KPiDCoA0KPiArwqDC
oMKgwqDCoMKgwqBpZiAoIWRldi0+aXNodHBfZG1hX3R4X21hcCkgew0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYtPmRldmMsICJGYWlsIHRvIGFsbG9jYXRlIFR4
IG1hcFxuIik7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsN
Cj4gK8KgwqDCoMKgwqDCoMKgfQ0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tfaXJx
c2F2ZSgmZGV2LT5pc2h0cF9kbWFfdHhfbG9jaywgZmxhZ3MpOw0KPiDCoMKgwqDCoMKgwqDCoMKg
Zm9yIChpID0gMDsgaSA8PSAoZGV2LT5pc2h0cF9kbWFfbnVtX3Nsb3RzIC0gcmVxdWlyZWRfc2xv
dHMpOw0KPiBpKyspIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcmVlID0g
MTsNCj4gQEAgLTE1MCw2ICsxNTUsMTEgQEAgdm9pZCBpc2h0cF9jbF9yZWxlYXNlX2RtYV9hY2tl
ZF9tZW0oc3RydWN0DQo+IGlzaHRwX2RldmljZSAqZGV2LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybjsNCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gK8KgwqDC
oMKgwqDCoMKgaWYgKCFkZXYtPmlzaHRwX2RtYV90eF9tYXApIHsNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LT5kZXZjLCAiRmFpbCB0byBhbGxvY2F0ZSBUeCBt
YXBcbiIpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOw0KPiArwqDC
oMKgwqDCoMKgwqB9DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoGkgPSAobXNnX2FkZHIgLSBkZXYt
PmlzaHRwX2hvc3RfZG1hX3R4X2J1ZikgLyBETUFfU0xPVF9TSVpFOw0KPiDCoMKgwqDCoMKgwqDC
oMKgc3Bpbl9sb2NrX2lycXNhdmUoJmRldi0+aXNodHBfZG1hX3R4X2xvY2ssIGZsYWdzKTsNCj4g
wqDCoMKgwqDCoMKgwqDCoGZvciAoaiA9IDA7IGogPCBhY2tlZF9zbG90czsgaisrKSB7DQoNCg==
