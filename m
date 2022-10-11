Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8315FB8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJKRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJKRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:11:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEAFA98CE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665508285; x=1697044285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XdCdZMug+BrcC8PeC4zxOxt8ArZW5sdEXJ6hrRcTdN8=;
  b=fUcm/HT9skxtmu3pSZYXNTZZCSqOy0/3IG/dWUKThrbMiDSRHzeTj5s4
   K9sJCHbNciIwKqpZl+BZt48T6gmc0or1Hv1a1r2D5BB6fGf3YHHO/06ft
   ILztG2ujwAzzQe+BwBQII3fnSDoDbFfMEBEJW8Kf/BsKaMpFaOOo+PKTC
   7WptgcFkiNkgVNiS9AHUyTdMYWHcfB4HDIfHf87H5W+TWduoWoBHHLWb5
   9VghzGZkAH94He31a/bBqw8y5EvQHS7FFQGb93xfqzTzWKCF97upQedZU
   gDebjwwg2wX8pUkn605E7TKf/A2RAwFhxYjcAix1eug4B3WGrCA+Y7kHe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="291890368"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="291890368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 10:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="801532125"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="801532125"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2022 10:09:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 10:09:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 10:09:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 10:09:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYdSgwLQe7A6/mBxjO8CtfeePQ50Wn0i7oowl+LqCIQuOZ22V2tuTmiOlnJpo0pa+R790ach7bdmok25BDbrc2TqU80YH+hlpr0ztWRW7++mpwmjBp4lw4LvnQmmgecIftlK3s3U46FdZAp0ztcDskcQHSyqbZP5KqECosRkreWqml6q2F1PjmC7Gckr3E/93KdmETUhc/4U+zreKIcN07TaHZiqm7eV9cz10/JdLzAtjFOILf4nQhr9+Kc4JBKaOLq96FMheUVN3/SndosN5dMY9eqgmVgj30wV+7N8zAdXkP/mi6tBSFC6A3idqOnJulRyQ1kJTIERS/wE3H8eHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdCdZMug+BrcC8PeC4zxOxt8ArZW5sdEXJ6hrRcTdN8=;
 b=WChfOp5HxtJUXJo5ebabmfZ3Jr/OyP4XyYr86XBQOA66EJOxaefz2uVGQPw0wtG/5UMVkcwHMXcbIau0Lj/PZttDQZA322Hs5C6KD1BfVHzZfABd8pIJC5u4b9Qf+82he7RkQEJjQHNv/H3s9R7tXaTxOacnVt6edmNTXuDEuvy7megd4h9lmeCvO2g2RZe4JuN2SNW68yXt5Dw6w1L0YeAmP/T/oPFKa1hcjzVmNRvyGxCXAJi3MDweJhk01UH9i099jm5Vh5msv2W5DaptJPu1/cA2AmXhBFYcL4kIbFWs/FqDkxx70TM2SDlhtRpVTZJpo8nTFf7FewMPaYVryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 17:09:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Tue, 11 Oct 2022
 17:09:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Daniel Verkamp <dverkamp@chromium.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Topic: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Index: AQHYzufCn81lK4uiX0SZXRx4bJPwP63s3TMAgABn1ICAAAdlgIAWBXKAgAXZaICAAF59YA==
Date:   Tue, 11 Oct 2022 17:09:19 +0000
Message-ID: <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <Y0VTS9qTF/GaMihP@zn.tnic>
In-Reply-To: <Y0VTS9qTF/GaMihP@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB7118:EE_
x-ms-office365-filtering-correlation-id: 325dc734-eb23-4265-6d79-08daabab5620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtCNrvfmDrCMeRTgYqmGcgAopNcNnfjtVl8p/IxRs9O5wpkCYVIO12Iz8cF9rsPfpnc2gUuv5hsU14PbW35Vuv6Bb5LE5/LXOdVZYhQ0Pv5IwB0JMmNRajVmf2dLxsNcJ6FyMZNrYPmTWV3oarxnJFu6PI2QVkLZuF8g4+lb0xTF1mzS90jgaQNJILsa/eEY4t82AqRoHDCoU1r8TxEjj+IuqhtitQSWD8qKrBKjIsmf5UjDujmmfWrdpYL1kJ9OYYblGKaZUTJgCLLL6WIsVN9ELW03Vlk9xC/xjgk4C2/37z/4ZQVV+WBpRS1sXleKjtZj3g9kP2DCIz+GbJQ4g4sP7o9hAfDLtJ2L4i6EKxj55MEF0v4xiDZTZR+MfmxK075xlStg+4W3D6YthZZxXJ9v7NloDZwye/P59PZvcqUGW+0H+nf8NCSuGUJCRJ9lQ+16bFSTjEWuoqnLWE0j8raqFx3e+rEIUQm0TajAQAhUA5J4LICdrQ4QgsF3Ip2gjWXsuWRJ+Gpa7xAqkJYkIdNAQqsqWGED5MPKvMiXLIaUY9LTAmS8oufSXmepbrvTa6ZIJEtLSSWpD3yR4m6v9l+0IQ18664pDKzGxD3PprPLDW4n3cLVWEjkgBXtnBwWMcs2+Lpr4msT1yPjwtFLs0Hhkwg8B4rqOA/PIL/JTzl8hl3iVov6KNB8TTprIkoNIhz5bNYt7EVNBl1GeMVdoNA9NZtgGAPwlQF7rVL54AHi5e6kncJRKG2+SfDiKgd7fKG04WJKhSMh+xmM+aetJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(26005)(9686003)(186003)(52536014)(110136005)(316002)(38100700002)(54906003)(478600001)(33656002)(38070700005)(122000001)(86362001)(7696005)(8676002)(6506007)(82960400001)(55016003)(76116006)(5660300002)(4744005)(64756008)(8936002)(66446008)(66556008)(66946007)(66476007)(4326008)(71200400001)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUZmRlJKTlBEU25jS3RTa0ExNlQ4OE9DMUw0MGtYWG1uTlZIc2FIUXdjRkNW?=
 =?utf-8?B?VFJWRkpaUTVLVHJSMmxQdmdyMU5xZVhXeWNHSHZLa0h5VUN1SHhEREozWVY0?=
 =?utf-8?B?TFNPTmVJK1kwazdTWGhkOU8yTEdPakM1R1ZJME1KQUhOSDZ3dWdpVGFCdGwr?=
 =?utf-8?B?cE01a0FKUkF6bWFmcmJsZjQxOU9tblM2ZklEVk5mT3ZTRXJET0l3cnJTV3Jl?=
 =?utf-8?B?K0dOOTJXTGI4N3NGcVdoL3FaSGF3TC9KdzRaSkVlVGZ6TmdJV3dlZEM0UndF?=
 =?utf-8?B?czcrR0M1aXY1REdzY0hHTksvQlAweVNuM216djZveGpZSGpaOGNmVEV4anRm?=
 =?utf-8?B?dlBFQkh4YXZDZ045NWtQSDE5RUEvWjhwUFBOTDIxOCt5Z1AvY0hUOWQ3SDVQ?=
 =?utf-8?B?QUtKenFaeWlRbW9QN05wSERTcmg2dWFsZ2JKUUVKYTQyL3MvUFE5Qmo0SzQ3?=
 =?utf-8?B?dU9YRUxoaWk3aTE5b2xUZEhYWEtqdENLbit4KzBjSXZHbkZlMVJiQXNYcHlG?=
 =?utf-8?B?MnJYalVGT0tzcmMrSmc5aVhJYndkTk9QaEpodmhZU2diTDRiTDFNaEVQMmtE?=
 =?utf-8?B?MGlONlViaUk1dDk0OUxzY2pLb3NqMmswOE5jT2drQmRnMStOWXg0SkRwUHBM?=
 =?utf-8?B?REVZL1MxcWRGd3Rhc05uMG9OUW1rWGwvcGZnU1RDQlBjRG9iRUUvODVCZGlZ?=
 =?utf-8?B?bFAyeWtwaEVvaUtjRzE4K2pzZGdURXNsckNnZE5ldHpzUkZtS2tCbHBUYkRs?=
 =?utf-8?B?ck1HSEUvd3YxRjNGSGtJeXZQYVU1STFJRVBYMG9OL3ZhcUdxdUlqNm1ibmtB?=
 =?utf-8?B?SmJSMUJHY3JLamJQSjRUdy9XSVd0dzhpT1BueVhUUWlDSU0vTHlwMlVZQ250?=
 =?utf-8?B?SElYSGx0dks2Zy9yZVhFL3kvU3o0RzhrOTFTWTkwNndXUFIzQ21rZFRqYkNQ?=
 =?utf-8?B?OGRZWTk4UzA1NTdEOGZ6QmFPMG8yQ2JXTXF3Sk5ZcTR2SVZQUWxnL0M5Uk0v?=
 =?utf-8?B?djVJWHVxVUVTdHhnR2pyT2ZuNDlXU1h0OVA4RWJ3b2JaaXpOUzJmc3FhbnNr?=
 =?utf-8?B?NkJidTJnRTNhbFV1Rml5R1lEcUNEM1kwMjVNVWZmc0k3dzZPaUJpb1lFUnZU?=
 =?utf-8?B?aDZQU1BycE1rNWttcVRRWTJORUNKR1FiQ05aN2JxdENuWFpjQkNaRDdzd1ZC?=
 =?utf-8?B?d1ZGVjY2NzRiQ1VHNEtsdUlpOHEzakZRVUZDT1FMVU9SZ2hiZG81NjdnVEZk?=
 =?utf-8?B?RlZkaDllN1dmNnppWHl2WUswcXlQakZoS1kwVm5lMTZvcnQ1WkZEY3A5TWs4?=
 =?utf-8?B?cWhqS3RmY0tXbEl0L0l5ZkRXOTR6KzdSbXAxODZxTHcrTE1uOCtONWZ4U25I?=
 =?utf-8?B?MUJJeGlRZG9PeXUvTEdnTkZMbzJPR01vYTVxK0RUUDBXK3p3TGwyeHgxZGho?=
 =?utf-8?B?alRnTWpJalY5N051ZGV6M2hCS2w4UU9ZVlFiUVByUWNsWWdwQ0hxbEZrczg3?=
 =?utf-8?B?ZDMzTFVDcWNDU0IvSEc5UXVMeVo0enB3cTVFa2ZvMnZML3V5U3YvWG5yRm5h?=
 =?utf-8?B?cmNQeUIwVEhMREliNGFGa2FOYTcvemgzdVNOWFZtUUV0NXBoNE1aamJKTFhx?=
 =?utf-8?B?NjFSay91Yit4S3RJSTlaQitIT1N6S01jZHkwalJzQmtLWmxETGxFVEdQTnhu?=
 =?utf-8?B?c3VtU2VuZGltVFg2VGJRcm9PQ3hJeXBna2UzS3FsaFQ3VnMzZFY1RHExV0xq?=
 =?utf-8?B?cTl5QlhqYk0rUjhBNDI2Q1dwU05PWlJYeTJMWmgvaCsySzdRUkRKbDRVMSs3?=
 =?utf-8?B?VmNud2crOTVWcElLUGJ1UHI1aHBRdTBjZ29Gdmgrd2ErbUszYUVWWXNTQ1Zw?=
 =?utf-8?B?ZlJYeEhlQUZpQ2JwZW1EVU8wcm1MRVBJYlNzTTBYd2ZFc0NHK3RMeWc1SmZ5?=
 =?utf-8?B?cGhrTitVZFQvY1ZSWVgzSTQ4STg1TEttZGR6M3FvWEY4a3ZzeFBEb2k4bVE1?=
 =?utf-8?B?MWI3STZ4cjMzaFNmL2lxVE5ldDQ1aDFhNGpWbzBkTGZHRHBqdVk4VHRFNWt4?=
 =?utf-8?B?YXdwTWxObDgrTkYxZW5hcnFlbURKL0x4NTRSOUFvKzJESXJneTNJa3V6K3Fk?=
 =?utf-8?Q?rwTo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325dc734-eb23-4265-6d79-08daabab5620
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 17:09:19.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RjchdOHfwwT5S8SsMNSkDGTI8eiQIHnadarjQuihKzA2CmtGUMA6TVpBOwPi1M+mG0NLvqv56u3RTf+SCWWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

Pj4gVGhlIEludGVsIFNETSBzYXlzOiAiU29mdHdhcmUgY2FuIGRpc2FibGUgZmFzdC1zdHJpbmcg
b3BlcmF0aW9uIGJ5DQo+PiBjbGVhcmluZyB0aGUgZmFzdC1zdHJpbmctZW5hYmxlIGJpdCAoYml0
IDApIG9mIElBMzJfTUlTQ19FTkFCTEUgTVNSIiwNCj4+IHNvIGl0J3Mgbm90IGFuIGludmFsaWQg
Y29uZmlndXJhdGlvbiBmb3IgdGhpcyBiaXQgdG8gYmUgdW5zZXQuDQo+DQo+IER1bm5vLCBkaWQg
SW50ZWwgZm9sa3MgdGhpbmsgYWJvdXQgY2xlYXJpbmcgdGhlIHJlc3BlY3RpdmUgQ1BVSUQgYml0
cw0KPiB3aGVuIGV4cG9zaW5nIElBMzJfTUlTQ19FTkFCTEVbMF0gdG8gc29mdHdhcmU/IFRvbnk/
DQoNCkkgZG9uJ3Qga25vdyBpZiBpdCB3YXMgdGhvdWdodCBhYm91dC4gRXhwZXJpbWVudGFsbHkg
Y2xlYXJpbmcgYml0DQowIG9mIElBMzJfTUlTQ19FTkFCTEUgZG9lcyBub3QgYWZmZWN0IHRoZSBD
UFVJRCBiaXQgc2V0dGluZ3MNCmZvciBlaXRoZXIgRVJNUyBvciBGU1JNIChvbiB0aGUgb25lIHN5
c3RlbSBJIHRyaWVkIHRoYXQgc3VwcG9ydHMNCmJvdGggb2YgdGhlc2UgYml0cykuDQoNCi1Ub255
DQoNCg0K
