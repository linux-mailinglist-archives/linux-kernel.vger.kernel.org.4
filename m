Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0C68B0CC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 16:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBEP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBEP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 10:57:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E187ABA;
        Sun,  5 Feb 2023 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675612657; x=1707148657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qkQDNtPogUHzhTQUErxNAVlNIUtyW4RsYUpd6gZ0d5E=;
  b=bqPUy/FfAWws2GB65bnFu1iIawLmkFXrC4xt8saSbqFEIeR4WrJvlQ9t
   zBxbvZcGEB+vLbQIBTgCt3tvPm8jeWQu+F+F6yw7NDIRuxu1lVGroHoRk
   kSC61w0bvMEz43TadA3F8Jxrt1bpJZiGi/abHLbLmd3IgJql2wa7JnD/D
   QQR1eZQLSDrhy4kv4myqXOGGHXlaeHO1OAEZW2v/MrpN0JYqVZ0mHKxmn
   /5IQ7CHbwAzthOKbbM5li+j0vxs4jqgAFKQSBsxgVg8WvBTD+Aqs0qoVe
   MwvdvZWEIrXccuFFug446POpUVlbY3qovpvS3tBux5geONvlxkh0nkgov
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="326747749"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="326747749"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 07:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="616222024"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; 
   d="scan'208";a="616222024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2023 07:57:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 07:57:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 07:57:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 07:57:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoGjAG2xx3tX0odmf8iagGXRDUAfZoq6Cr4E1xe2U54kbVww19HdEL6zBLXAg4EVD4el6dobhjdzIssHfw4XJn8f9JK+tXIXoM76HwH6b6gJBksGVHyri0QBb1MZRGfkczRv02jaHj1ui2kZ+zP2xF/VDnVZOrKsGZavexW4hWc/MUzOJ78b4ssyHKYL7COTFRtWIgDiHupXiZqQudDfzhJprCGJv87n0ryHP37Dxh7ldclUCzr51xhwa0YqiOKWvVakXtxncKLFn5/N9VvyUvpVgWcI6G5UU8LJqTaXtWGGJ2byi6lKEc4Wump9RRS/sale8Ie/AofcM9dKwFHyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkQDNtPogUHzhTQUErxNAVlNIUtyW4RsYUpd6gZ0d5E=;
 b=jp6DDjuVsVo/tF9JF0ujOlWbhU2iMKKjUlg/bxy9KleElNiB9wsNFB5/nXU7wkrT4lo4pdZgkK2Dn+aTbvmBm4KB3xO0URXx4z7FU1bBQOzh7hlka7ZNB/dxrws5J0IVIqFR8tur1ma+cIOnCrEQd9VBNopBe05OUAD0OTclXY7h2bZc4+KFg6Ej4Xlm2fNU2UISwVIyKhSWHWgVaUu2KQY2CzHP2gp8+57dc+3nHw9GICi2U7QPfsW9tQ3g6EundVCVNZDlEfVELBpCp3sqX2YGkSFomYo1F6k+9ooeGhUAA+lFnczWiU7g4ctqQ3VAbgW8XoH2DanJUbCDZSS7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB5459.namprd11.prod.outlook.com (2603:10b6:610:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Sun, 5 Feb
 2023 15:57:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%7]) with mapi id 15.20.6064.031; Sun, 5 Feb 2023
 15:57:34 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
Thread-Topic: [PATCH v2 0/2] intel_powerclamp: New module parameter
Thread-Index: AQHZOQ3UaWBU+zkoFEWPd2N7/3LBpK7Agv+A
Date:   Sun, 5 Feb 2023 15:57:34 +0000
Message-ID: <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB5459:EE_
x-ms-office365-filtering-correlation-id: a37cd0d1-5824-4499-7c7d-08db0791b200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CD5RKNl5ZkB+vOerojXZgiKMuUxiEgswm26xF3ONePlJpL/RPxKsUsMs1uIO4hC4klPEb/7anEixUp9XlChxJOmlMmvHKqLKUAB00WaCmWHzeAD/V9gpTKNITP08fLrIJqnzftbugHU5yvcrVGfy/R1vxSq41E2bl377a7h8QMJ0s19j57DJHrqiQznAv7UmNF4+gg60g1uxRGOXg2bIh+WQXenTKOOyJvxq3zDtUoQeH1P1pbJgLH09XqdOwIoDVmI2cJHvCwm9HvS3sjW2xT2PCPOUjzBd+ybcq3B440/as8Ra626BP68LseiRKa/GOLFDmgMOcY5y8EsVqRIrgyCjxBg5T2eMx38WUPN8mTN4B/bt+XHfHoc4p7P/2TBaEy9JdNStKmn3PzarVrnD6icJKlVxbTxTpzu75AQd9aActE83chLKTQfhdMX+FAS6gUM+joVFkYD9iRPt5+YPYPVx7V2rU/IdPIT4T+fSi4klnY4SMtCqtWKrPPGEPMpzc0kXKy8HtE5UvAsZBKkPpR3t+UKfI5txghSjkS3XPtK9LI9NjIinulzSgoUwErTPTEUaqW4weisORCb5SN5bNI+mnHJUKIAG0/DkA+mxeXvSFDQJY5OBEAWy6vbbgJ4SfIxoi1TJypGDn1XKAIE9Zp8xUSfcPnErrMHeq6hmsrGIsqebFZZf2OD9iFc0EgkvwyFFM7k6w3ZAEA0eOe0MJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199018)(6486002)(6506007)(478600001)(2616005)(26005)(186003)(6512007)(4326008)(91956017)(8676002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(316002)(110136005)(38070700005)(6636002)(54906003)(82960400001)(36756003)(86362001)(38100700002)(122000001)(83380400001)(5660300002)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkpmNmhHSnQ1YzlWQVdLalNyUlZoY25oc050bmpjUzRvWHZJNTFTaHp2ekI1?=
 =?utf-8?B?emQ3Y2paa29MbWR0Q3h0azlkTHNYbzhYWlJJL3psd3R5TmZTNFdmVmVsdVY2?=
 =?utf-8?B?c0lPMWUybnMyTjhtRThoUEV0VkY2R2RQQ08rd0JGV3JEVlFueG40ZnRaZU9D?=
 =?utf-8?B?WFJIV2k3ZW1lQ3V0dGpKeS9FcjBiZ2tEellRSklidnArWFBrcjk4ZXZLM0FD?=
 =?utf-8?B?WVQrODdkaWxqVXMvNWt5K1FKMzZFOCtReTV0QU9rV0xtQ0pIN3ZIQWU3RDBF?=
 =?utf-8?B?VWFqVE01WWRkNDUrQTBEWWhEWG02aUZZV1lGcFZWckNpci9waVY2K05UWHdN?=
 =?utf-8?B?UENLbWMrT2JBWlJVV1VHcVZXM3VmelRTeWhOK1FnQ1ZFc3dMMFdPTVJqdTFV?=
 =?utf-8?B?cm5rQUY5SkZxMVdYTHo2bGVCMmNZR2dReHN6TWdHdUkwYnlhOUtsNk03OHZJ?=
 =?utf-8?B?bW9QVmNEUURKMFIyNkJDb2F3TnhaQy9MREpQbGxiWTF5OS9hV2pmMTF0S3Iy?=
 =?utf-8?B?ekZOeDFyWUxXamdMSktRbkk3VGVLcnhNOERaNFpxYVgzUzdxUTJ0aVJzSFM0?=
 =?utf-8?B?bm9oMXdMek9CdU12cHhyaGdnY1JUazlIeU9lcXZrZXFFa0JabngxK2pacFVi?=
 =?utf-8?B?KzRCK3BkdjkrTlBaTlE5VkpkeTFUZG5EMEZjUWVCWWF1OFozMUliUHFERVhj?=
 =?utf-8?B?TmljK2Rod3RnUUNjbmhKZFBPU1ZhMU1VbmcrNVpDcDQ2MzJ4MzNrZFRvMEtS?=
 =?utf-8?B?WXovZ3MyejdqUzNqMWM3TWJXWXZGaGNsbnZmOTZkbHlZQUpqSWlpVDY5WjE3?=
 =?utf-8?B?dkNSQW5Od3Ywd1doVlVTZjk1UXdmRTJUR2M0Vm1Kdnl0M1hCSlNLS0h5TzEz?=
 =?utf-8?B?bTlrQmtvbW1NYWxYOE5EaE83U3owS1lkVEI3Z3NPSDlUT3pJeFBPbjE1dzd2?=
 =?utf-8?B?Q0g5UGlsSHY0YVVKUWFrUCtDUHp2d2lOWHVLRmw4dEdDK3VidTFRTjN2bFlZ?=
 =?utf-8?B?d1dVVzUwU010eCtzS3ZuUWphQnk1VHFJWUdxcW1hYTZxR1pSRVJjTlBLcXFZ?=
 =?utf-8?B?ZHd1bTNaUFJPYmowaGhHM0t4K0QxY012SzdROXJqbGR3OFIwY1AwT1lvWmNz?=
 =?utf-8?B?UFUzRWVoeWRhSkswYml3blIzcXE0VzBLODc3WjZsMk9OQzVBY0dLT0lqWUla?=
 =?utf-8?B?alJBa3lMSnhyQklFOForZFVFU2xSUVVDTFduS1hGaGxtRzd5cHNoTTlxcklG?=
 =?utf-8?B?UWJvUjYrY05oS1d1UVhJQTFhMmVZR0M4a1NNZjd1cE5FNGE5eVFRZ0pIVHNF?=
 =?utf-8?B?cmhPb2NNYytmdVZPRmJiS3ZxR1Z6V21qYWNoOVFwVDROdGxNV2pIcHpGb0dR?=
 =?utf-8?B?TkRCME05Snpva251dHBzdkhYSGJJSFpJQncwc1lGelAvUTc1eDkzMllvK21V?=
 =?utf-8?B?L2RVYUlVVlJlVEs3aEhwaGRWYlM2SlQxbkk5cllwM3dCT2dqekJZTFZpMml6?=
 =?utf-8?B?eW5nTmM0MlJYTTRTYVlzVTZONk0zSU5tVHl4MDhXdk1XK3JSU3BWZ0ovbzc4?=
 =?utf-8?B?U2FKelpuU0hVM2lPOWhIQ3R6V2R1UUJUbnJWSUtZNXhZa3JhTTRDZW4zNlUx?=
 =?utf-8?B?V244UVhzTjA0b2s3SXQxVjdDTWdoYitiTkk5Z056WGlUUm5oczg3Yy9Nc3Ji?=
 =?utf-8?B?MERFRXdtaGd6VnlZUzhXbi82MFFGemszVnJ4Y0hmUnV4cVo1a3JlcHZqWkJV?=
 =?utf-8?B?YWY1T1RKaTVmVWtuSkE1SzIyYW1QbEJpUllYaWF5Wnc0M1ZCMmJZUVE2Qmlx?=
 =?utf-8?B?Qmk3dG52NzNIT2JlOUlBdkRLemk2NEtUNC9URHN0dml0NUZ1enFwYnJubHFv?=
 =?utf-8?B?N282VVpLcVo5UXlNRFRLR0pjdGNTeXlGeEdQV1JHN3RlbXFwQVdsTnEyYktM?=
 =?utf-8?B?SDJUc1hQYlpWU0xYVGtLeTFCcEsxYjZqVzZzRkxOdWNTUGJldDFhWUU4QVl0?=
 =?utf-8?B?aEJjTDFrdWtTNmw1V2tMZVp4d3g3RkZrV096TTh6Ynl6dzMxK280YlVvVVpw?=
 =?utf-8?B?dlVYK0szZ0o2WXEybUlHQndHYzl2Q1lJSWpVOS91MUxUVXM5ZFcvckZKTTVI?=
 =?utf-8?B?K1lRWmdBTWREMmdWZDRDWktRTEdwTUZ0ZHhqdTFZSWRHT3k2c3pOTUord28w?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32202079A881D44C9CC4CD47C2D75E63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37cd0d1-5824-4499-7c7d-08db0791b200
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2023 15:57:34.0929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FVB3ynRghJpMuSAYonm10MyVh3MBqaXRdqnhRVbM3lcd+nyrdAt2cui5vqu+HPdibftbnK8gqdEFKFt6Hsa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNyaW5pdmFzLA0KDQpGaXJzdCBvZiBhbGwsIHRoZSBwcmV2aW91cyBidWlsZCBlcnJvciBp
cyBnb25lLg0KDQpTZWNvbmQsIEkgZm91bmQgc29tZXRoaW5nIHN0cmFuZ2UsIHdoaWNoIG1heSBi
ZSByZWxhdGVkIHdpdGggdGhlDQpzY2hlZHVsZXIgYXN5bS1wYWNraW5nLCBzbyBDQyBSaWNhcmRv
Lg0KDQpUaGUgdGVzdCBpcyBkb25lIHdpdGggcG0gbGludXgtaW50ZWwgYnJhbmNoICsgdGhpcyBw
YXRjaCBzZXJpZXMgb24gYW4NCkFETCBzeXN0ZW0uIGNwdTB+Y3B1NyBhcmUgUGNvcmUgY3B1cywg
Y3B1OC1jcHUxNSBhcmUgRWNvcmUgY3B1cywgYW5kDQppbnRlbF9wb3dlcmNsYW1wIGlzIHJlZ2lz
dGVyIGFzIGNvb2xpbmdfZGV2aWNlMjEuDQoNCjEuIHJ1biBzdHJlc3MgLWMgMTYNCjIuIHVwZGF0
ZSAvc3lzL21vZHVsZS9pbnRlbF9wb3dlcmNsYW1wL3BhcmFtZXRlcnMvY3B1bWFzaw0KICAgZWNo
byA5MCA+IC9zeXMvbW9kdWxlL2ludGVsX3Bvd2VyY2xhbXAvcGFyYW1ldGVycy9tYXhfaWRsZQ0K
My4gZWNobyA5MCA+IC9zeXMvY2xhc3MvdGhlcm1hbC9jb29saW5nX2RldmljZTIxL2N1cl9zdGF0
ZQ0KNC4gZWNobyAwID4gL3N5cy9jbGFzcy90aGVybWFsL2Nvb2xpbmdfZGV2aWNlMjEvY3VyX3N0
YXRlDQpJIHVzZSB0dXJib3N0YXQgdG8gbW9uaXRvciB0aGUgQ1BVIEJ1c3klIGluIGFsbCA0IHN0
ZXBzLg0KDQpJZiAnY3B1bWFzaycgZG9lcyBub3QgaW5jbHVkZSBhbGwgdGhlIEVjb3JlIENQVXMs
IGFsbCBDUFVzIGJlY29tZXMgMTAwJQ0KYnVzeSBhZnRlciBpZGxlIGluamVjdGlvbiByZW1vdmVk
IGluIHN0ZXAgNC4NCg0KSWYgJ2NwdW1hc2snIGluY2x1ZGVzIGFsbCB0aGUgRWNvcmUgQ1BVcywg
aS5lLiBjcHVtYXNrID0gRkZ4eSwgaW4gc29tZQ0KY2FzZXMsIHRoZSBFY29yZSBDUFVzIHdpbGwg
ZHJvcCB0byBhbiBCdXN5JSBtdWNoIGxvd2VyIHRoYW4gMTAlLCBhbmQNCnRoZW4gdGhleSBkb24n
dCBjb21lIGJhY2sgdG8gYnVzeSBhZnRlciBpZGxlIGluamVjdGlvbiByZW1vdmVkIGluIHN0ZXAN
CjQsIGFsdGhvdWdoIHdlIGhhdmUgMTYgc3RyZXNzIHRocmVhZHMuIEFuZCB0aGlzIGFsc28gcmVs
YXRlcyB3aXRoIGhvdw0KbG9uZyB3ZSBzdGF5IGluIGlkbGUgaW5qZWN0aW9uLg0KDQpTYXksIHdo
ZW4gY3B1bWFzaz1mZmYzLCB0aGUgcHJvYmxlbSBjYW4gYmUgdHJpZ2dlcmVkIG9jY2FzaW9uYWxs
eSBpZg0KdGhlcmUgaXMgYSAxMCBzZWNvbmQgdGltZW91dCBiZXR3ZWVuIHN0ZXAgMyBhbmQgc3Rl
cDQsIGJ1dCBpdCBpcyBtdWNoDQplYXNpZXIgdG8gcmVwcm9kdWNpYmxlIGlmIEkgaW5jcmVhc2Ug
dGhlIHRpbWVvdXQgdG8gMjAgc2Vjb25kcy4NCg0KSXQgc2VlbXMgdGhhdCBQY29yZSBjYW4gYWx3
YXlzIHB1bGwgdGFza3MgZnJvbSBFY29yZXMsIGJ1dCBFY29yZSBjYW4NCm5vdCBwdWxsIHRhc2tz
IGZyb20gUGNvcmUgSFQgc2libGluZ3MuDQoNCnRoYW5rcywNCnJ1aQ0KDQpPbiBTYXQsIDIwMjMt
MDItMDQgYXQgMTg6NTkgLTA4MDAsIFNyaW5pdmFzIFBhbmRydXZhZGEgd3JvdGU6DQo+IFNwbGl0
IGZyb20gdGhlIHNlcmllcyBmb3IgcG93ZXJjbGFtcCB1c2VyIG9mIHBvd2VyY2FwIGlkbGUtaW5q
ZWN0Lg0KPiANCj4gdjINCj4gLSBCdWlsZCB3YXJuaW5ncyByZXBvcnRlZCBieSBSdWkNCj4gLSBN
b3ZlZCB0aGUgcG93ZXJjbGFtcCBkb2N1bWVudGF0aW9uIHRvIGFkbWluIGd1aWRlIGZvbGRlcg0K
PiAtIENvbW1pdCBsb2cgdXBkYXRlZCBhcyBzdWdnZXN0ZWQgYnkgUmFmYWVsIGFuZCBvdGhlciBj
b2RlIHN1Z2dlc3Rpb24NCj4gDQo+IFNyaW5pdmFzIFBhbmRydXZhZGEgKDIpOg0KPiAgIERvY3Vt
ZW50YXRpb246YWRtaW4tZ3VpZGU6IE1vdmUgaW50ZWxfcG93ZXJjbGFtcCBkb2N1bWVudGF0aW9u
DQo+ICAgdGhlcm1hbC9kcml2ZXJzL2ludGVsX3Bvd2VyY2xhbXA6IEFkZCB0d28gbW9kdWxlIHBh
cmFtZXRlcnMNCj4gDQo+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2luZGV4LnJzdCAgICAg
ICAgICAgfCAgIDEgKw0KPiAgLi4uL3RoZXJtYWwvaW50ZWxfcG93ZXJjbGFtcC5yc3QgICAgICAg
ICAgICAgIHwgIDIyICsrKw0KPiAgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3RoZXJtYWwvaW5k
ZXgucnN0ICAgIHwgICAxIC0NCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcG93ZXJj
bGFtcC5jICAgICAgfCAxNzcgKysrKysrKysrKysrKysrLQ0KPiAtLQ0KPiAgNSBmaWxlcyBjaGFu
Z2VkLCAxODAgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ICByZW5hbWUgRG9jdW1l
bnRhdGlvbi97ZHJpdmVyLWFwaSA9PiBhZG1pbi0NCj4gZ3VpZGV9L3RoZXJtYWwvaW50ZWxfcG93
ZXJjbGFtcC5yc3QgKDkzJSkNCj4gDQo=
