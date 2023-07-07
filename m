Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0374AAA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGGFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGGFiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:38:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68841BE9;
        Thu,  6 Jul 2023 22:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688708295; x=1720244295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r27CVZ92rRUWekQmVjv1Oqpphw9hrCcvMCU7TTw5gwU=;
  b=i41S79mC763NWCLHWEHPJ6ve3KyLVBsfKNQBBobUS06Jd0MqqlnEKakw
   Cn/dcNqaevXz5DWAR5kCAGqBtAW51XyI18Y0stOrOIGtoJCAkVhJix3Xd
   I112acNCfnL0nzJwxRzPSzfZjfYxnjd8oEyODJz+rdj3Z6ioGPaOYvLD1
   dFeoaeEOk9B5A5dJIoz7eIEGdYBHmjYqg82elmNTMi+mXRhgK6u0N0LvI
   ZXpjUt5lIWqmWxOHn0ZCnuqR6rNqShoh49c1i4ZRpzntVRWTN0ZHGp3ZI
   T5Y+eL67rrDLa6GwxF7ELO+0zLADgh6fEdBPRDwV3ffpB6gbLX72AE8qI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="344140989"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="344140989"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 22:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="843981287"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="843981287"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2023 22:38:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 22:38:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 22:38:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 22:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eucGoeKic+sKGjuOyRQFnl657XIVuhBl1BtNLDzRTpT+IftyuOLle1TN5GtaUqdCDONgo1QlzZL0YeaYPQISNDYmf25xqahfKIekB1HTgAmx/dg8131YovpRwHb15HgvhKnyg++9yVqoX7kU3owkIRXfGdvBqFLbPlyXWqiycUNDYSqzriBovChp5LDK9a5KNz6cj4nQtiyy3fafnZwnGmtkq1k5bCw5eLrt2AnaUCd3ur3XPWRme/kGosfmYpcUBzUySyndq3OlMwchyBb4kZWpn+pE9XgZm7Lau6jRAQEcMntVWxdap9JoiRiWJbm4aSUZcBKCTnzeY3HzQfRE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r27CVZ92rRUWekQmVjv1Oqpphw9hrCcvMCU7TTw5gwU=;
 b=eksgVidhQHO+zXobl+2FQtgZLLEaAMmUue0he/jSuaf2bYwuh/MYAaoexYFQEnGkV9QAxXB8U8YVZB1j8T/KQLTJN9AYu4VTt+Bdx/C1Sh6vI8Hv3CBcWiqtvF3RgYHVreGMvW0T7G13fZvYxz+vDNFRoVCnmUYq7O0mN9yxvAYxrj8ypEnkI6/mE9IHWse+g3FMNzTqog5atlmzYgY4gpfGDf3D/9ZmlP7/o9HyHoVfDtuzoskqOBRtqPVKRR8ui0bLcACgNLd98Ce2ZP+qAY1kUC7ti9K26nL2JaTOYh5tCOC9Ip9YKgv+9K47Iv1fcyNj7eEdTkYeGfsEGY3wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 05:38:10 +0000
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::b46a:9f6b:4413:7dd1]) by SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::b46a:9f6b:4413:7dd1%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 05:38:09 +0000
From:   Kumari Pallavi <kumari.pallavi@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "rcsekar@samsung.com" <rcsekar@samsung.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Nikula, Jarkko" <jarkko.nikula@intel.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: RE: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to avoid
 communication stall
Thread-Topic: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to avoid
 communication stall
Thread-Index: AQHZpbEJFNWZ6ahAAkGbf9aW8zW0xq+rKfIAgAKsd3A=
Date:   Fri, 7 Jul 2023 05:38:09 +0000
Message-ID: <SJ1PR11MB608478D62EDFAEDDBE8C0890872DA@SJ1PR11MB6084.namprd11.prod.outlook.com>
References: <20230623085920.12904-1-kumari.pallavi@intel.com>
 <20230705-return-slogan-36c499673bb6-mkl@pengutronix.de>
In-Reply-To: <20230705-return-slogan-36c499673bb6-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6084:EE_|PH7PR11MB6378:EE_
x-ms-office365-filtering-correlation-id: 8242987b-1c69-4f66-6cad-08db7eac5918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qI3TACHJzC0AVHj1omkt1LkA9iE9ZLVmJS7siI2irnz+Wv+6njM5FArXeXIzwO51BP8C7TMfAE53BmYF2CNxZFi2KFlpA0aLmSY/fLcDeva+PLPLI2/vMcgaKwLKCLaMtRPxTPPBGL6u0rqouLX/ufXlXumxMDlCs7i3jxY0bgzKNw8lOp+EGTlMzgiW66GpUAMsZdU+88NmCN640VBgMBDkthU8W/w7b8nAuZnOoJ3N8QZCXjP/kNauYbGxWotcjYgFW+mmrKo81bovl6vm5SWCJwnCiMAzHFLxIQ2I2KmxpNnYUbehHN9J/kUQpK/+yOIccl8TowovDvXRKbv3kFv7ym27/Nv8cZ+xgcvyhzcBPL8lPkw0gzqFEjwd2/FNq47Al64j+Qj9i/VjYiGdd1OsQ/edDWNWzXz408kAtuI6HGjQE+cdnqXAD0eKcU1Mlz2GLL3Z6lrkFiqE2z473rdnwNczqyYCEjbzSSEGfbCsu93A/gYqK05Dd70MmJKFzbXNNmRzAb80TaYIDh63zCEkeRJ0ir/Y8nBtgsZstCkEcbvk7zpU2ZOilQJynRwwPJWLl4YCmbElSDMR+8QFSbmmplnWKR28ovMJjjn1XXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6084.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(71200400001)(33656002)(7696005)(8676002)(8936002)(316002)(107886003)(41300700001)(186003)(9686003)(55016003)(966005)(6506007)(53546011)(26005)(478600001)(83380400001)(52536014)(38100700002)(66574015)(66946007)(54906003)(76116006)(82960400001)(44832011)(4326008)(122000001)(6916009)(38070700005)(66556008)(64756008)(66476007)(66446008)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXBhK1JpR0Z4aUltVldKcjdBbmZ2czkyWFU4d1U4U1g2QnByWU9KN1d5V0Fm?=
 =?utf-8?B?VmRVbjJ0eElNdUlUZk1wZEl4Umh2VThvZFNEb3ZRQWVjdGpTSFFJUU1ZKzB3?=
 =?utf-8?B?bDQ3QUxuU3ZJN3MyNjdZUXk5cG03dm8vRnVCTHZGTGIrUkI5V0FQb2ZaRENo?=
 =?utf-8?B?WExzWGFjbDBrVTllU0dib0kvbThnTW84QVNYR0NrNjhicjFiMnJnaFFzMFMw?=
 =?utf-8?B?SDBWd2hWNU9qbXZlUUlzMDZMUXg2NTlPSE5OcVVaeG95R3BtdGdaTk13MU9V?=
 =?utf-8?B?M0pnSjYybEhKQ1lTaElBaXVVVWp6ZndhelBiK29lWXJUQ1dqVHpwdi9vbXE0?=
 =?utf-8?B?VXJrWjl6a1BuZ0pEQjlyRGNtWmRlUzdDRzNRSzhPM2RoSjhGeWMzRXBjUWdY?=
 =?utf-8?B?azAydEdvZ3B4bjhVY2xESlEzQWZyazdpZGNVTUwwN1o2TGdWT0JzWUxRZlhi?=
 =?utf-8?B?VWppcldyY3RyRzF0aGRXa3pvOXliTXR3Kyt6ai9yYkdJRVpKVzBsZGluV3Jj?=
 =?utf-8?B?aGx1ZDd5TXFqMjVFMHNNR1FibkVMMlF2WkwvSi9JNmRXZkRDeDFieHhHS09H?=
 =?utf-8?B?MUk0aU90b1orMWdsc1g3UjBySzJmb0I4M09rRTdsOThsbis3WmxReUozeVN5?=
 =?utf-8?B?Z01KK3oxK2ErUlBad3BRMHhHSDJTeFZIaXJlMTFySHQ2am1USDhTUDFkdGZV?=
 =?utf-8?B?dlozU082WFNPUTRManFoVDZNVHhML0IzZUd2SlltRmlrWk40N0ZHT25pN08w?=
 =?utf-8?B?NktGdDU3R2U5UUN0ZE5JaDVEWm9kK0lLMVJlVVhKZWY2bEs2cVF2MlJ6eFBD?=
 =?utf-8?B?OThQZ0lhQkhZeE1BRWIwSnNLbGJkcmh5NHhhcG8xbnhVSDZCSk1mYTR4bzhQ?=
 =?utf-8?B?NUExM0hkR2FjcEsxKzlLUUxLYkhZNzFOU3ZmUGtqMHJWbmp1M0VOc0x4UHd2?=
 =?utf-8?B?ZzhRaWlVMXhDR0dweGlNYllOZkFpRVdSZloxbXdtakVKVHRiRjF1MUhKZWpU?=
 =?utf-8?B?QTJWckM4ZklXNjh2RzRUOE5McVNsUUFyN1FrQ1FBS1hJemthVmVQVC9Nbkxn?=
 =?utf-8?B?M3NRSTRnMENjTXRvTkd0V25zSlBQbnFiZXJpUmxMak9hWHMyZ3M1cWFmamdF?=
 =?utf-8?B?R24veGxnbkNJNWJZWXFwb2ZCeVpwZk13eXZaUDk4Z29pYTZ6VXBCTURXU3NT?=
 =?utf-8?B?RXE1UWhWNlpCcWhGbkZNZnJ6cGQyQ2hBUzhvTE56aWJXK0xBQi9ZNnBrV2U5?=
 =?utf-8?B?YTBhbFkvRWRuYm93K2x1S0wxenZvajBnZEtnSmVnVk02MnJLZnBTWTJqSmVJ?=
 =?utf-8?B?MkI4bEVNQnhBQ2hCUCsvU3FiaG5BUFRHM2NqOENYVnpHR2hTdUZJWEduNnpy?=
 =?utf-8?B?TklYSysxdTlER25qdHQzdG5lb0NoOStlNWhyek9KLzU0WFVJbEt1YUFGNEZK?=
 =?utf-8?B?Z0dzL0hKa3ZEemVqZE1QQnhQdEt3S0E0ejhBM3dvN0dLbTAzSmxGL3BrdlZ5?=
 =?utf-8?B?Mkhhc0Q4d0JlbXBBZklYSVh1N2ZvVklDa053WWY1SlNsQXdxQVprb0pNc3By?=
 =?utf-8?B?ZHFmVC9HWlhQOUNUaEIxU3F2WTdLa2h0dndZZ0szOTZDU1B4RGVndncvem9t?=
 =?utf-8?B?RDlFa1pZNVdZVGFXUElWaUV6cHFLY0c4b2NaalNWcWNPTkw5aitTV3R1TTc0?=
 =?utf-8?B?amtwdEg1NzlWaENKN3BkUmh4WDJTb1U0WkdSSzlHQyt5S3NNNFlaS2FnaEJL?=
 =?utf-8?B?TzFUeEZYK2xMRVJmekVPam9vbXRQRmZRQjU1TU4yMkJOc21yMU5JMG1SQmt4?=
 =?utf-8?B?RThBUkhKVEtsOVRBTDA4Lys5L2hwS3RjZHFXckJ6c3RIV25qcW5jM2l1cURV?=
 =?utf-8?B?Q0dDb3J3WGowaEhSc2pidnhGZmY0YkdybE5nYjNTRzlQVVJNTVVrWHZtRGJ3?=
 =?utf-8?B?MHZpeWxxYlE1bEFPeVVpTWErV255Q01XOFNVcXBGOERRWWhObGsrbUZFMFVp?=
 =?utf-8?B?TkI0dlY4YzRtMWZVYXJzbjVxWWFSSS9lSCtQTG5LYktRb2ZtMmNUU2hWU1g1?=
 =?utf-8?B?ZGc1a3JNbHA2ZENZd2VNcWF3Wmc4Y0xUTkZCR0RMSkZmVThxSXZZN01pWjBy?=
 =?utf-8?Q?XtRxEmfH9ylyemLmoLuzY2fZd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6084.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8242987b-1c69-4f66-6cad-08db7eac5918
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 05:38:09.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iRP84mHaiixq3xgHu0Qhe3tWGA/anmRg3MDs3G0Q1CN0g0omJf4Hraety4T+PJHDVB8botEKvLgDd4oSedgsqe1ZXuaTMw/e4IkkHTF92n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXgu
ZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA1LCAyMDIzIDU6NDcgUE0NCj4gVG86IEt1bWFy
aSBQYWxsYXZpIDxrdW1hcmkucGFsbGF2aUBpbnRlbC5jb20+DQo+IENjOiByY3Nla2FyQHNhbXN1
bmcuY29tOyBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBhDQo+IDxtYWxsaWthcmp1bmFwcGEu
c2FuZ2FubmF2YXJAaW50ZWwuY29tPjsgTmlrdWxhLCBKYXJra28NCj4gPGphcmtrby5uaWt1bGFA
aW50ZWwuY29tPjsgbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGhva2FsYSwgU3Jpa2FudGgN
Cj4gPHNyaWthbnRoLnRob2thbGFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JFU0VORF0g
W1BBVENIIDEvMV0gY2FuOiBtX2NhbjogQ29udHJvbCB0eCBhbmQgcnggZmxvdyB0byBhdm9pZA0K
PiBjb21tdW5pY2F0aW9uIHN0YWxsDQo+IA0KPiBPbiAyMy4wNi4yMDIzIDE0OjI5OjIwLCBLdW1h
cmkgUGFsbGF2aSB3cm90ZToNCj4gPiBJbiBiaS1kaXJlY3Rpb25hbCBDQU4gdHJhbnNmZXIgdXNp
bmcgTV9DQU4gSVAsIHdpdGggdGhlIGZyYW1lIGdhcA0KPiA+IGJlaW5nIHNldCB0byAnMCcsIGl0
IGxlYWRzIHRvIFByb3RvY29sIGVycm9yIGluIEFyYml0cmF0aW9uIHBoYXNlDQo+ID4gcmVzdWx0
aW5nIGluIGNvbW11bmljYXRpb24gc3RhbGwuDQo+IA0KPiBJcyB0aGVyZSBhIChwdWJsaWMpIGVy
cmF0dW0gZGVzY3JpYmluZyB0aGUgcHJvYmxlbT8NCg0KTm8sIHRoZXJlIGlzIG5vIGFueSBwdWJs
aWMgZXJyYXR1bSBhdmFpbGFibGUuIEkgZm91bmQgdGhpcyBpc3N1ZSBkdXJpbmcgc3RyZXNzIHRl
c3QuDQoNCj4gDQo+ID4gRGlzY3Vzc2VkIHdpdGggQm9zY2ggTV9DQU4gSVAgdGVhbSBhbmQgdGhl
IHN0YWxsIGlzc3VlIGNhbiBvbmx5IGJlDQo+ID4gb3ZlcmNvbWUgYnkgY29udHJvbGxpbmcgdGhl
IHR4IGFuZCByeCBwYWNrZXRzIGZsb3cgYXMgZG9uZSBieSB0aGUNCj4gPiBwYXRjaC4NCj4gDQo+
IFBsZWFzZSBlbGFib3JhdGUgdGhlIHN1Z2dlc3RlZCB3b3JrYXJvdW5kLg0KDQpTdXJlLg0KDQo+
IA0KPiA+IFJ4IHBhY2tldHMgd291bGQgYWxzbyBiZSBzZXJ2aWNlZCB3aGVuIHRoZXJlIGlzIGEg
dHggaW50ZXJydXB0LiBUaGUNCj4gPiBzb2x1dGlvbiBoYXMgYmVlbiB0ZXN0ZWQgZXh0ZW5zaXZl
bHkgZm9yIG1vcmUgdGhhbiAxMCBkYXlzLCBhbmQgbm8NCj4gPiBpc3N1ZXMgaGFzIGJlZW4gb2Jz
ZXJ2ZWQuDQo+IA0KPiBDYW4geW91IGRlc2NyaWJlIGhvdyB5b3VyIHBhdGNoIGltcGxlbWVudHMg
dGhlIHdvcmthcm91bmQ/DQo+IA0KPiB8IERlc2NyaWJlIHlvdXIgY2hhbmdlcyBpbiBpbXBlcmF0
aXZlIG1vb2QsIGUuZy4gIm1ha2UgeHl6enkgZG8gZnJvdHoiDQo+IHwgaW5zdGVhZCBvZiAiW1Ro
aXMgcGF0Y2hdIG1ha2VzIHh5enp5IGRvIGZyb3R6IiBvciAiW0ldIGNoYW5nZWQgeHl6enkNCj4g
fCB0byBkbyBmcm90eiIsIGFzIGlmIHlvdSBhcmUgZ2l2aW5nIG9yZGVycyB0byB0aGUgY29kZWJh
c2UgdG8gY2hhbmdlDQo+IHwgaXRzIGJlaGF2aW91ci4NCj4gDQo+IFNlZToNCj4gaHR0cHM6Ly9n
aXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL0RvY3VtZW50YXRpb24vcHJvY2Vz
cy9zdWJtaXQNCj4gdGluZy1wYXRjaGVzLnJzdCNkZXNjcmliZS15b3VyLWNoYW5nZXMNCj4gDQoN
ClN1cmUsIEkgd2lsbCByZWZvcm1hdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gPiBTZXR1cCB0aGF0
IGlzIHVzZWQgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZToNCj4gPg0KPiA+ICstLS0tLS0tLS0tLS0t
LS0tLS0tLS0rCQkrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiB8SW50ZWwgRWxraGFydExh
a2UgICAgfAkJfEludGVsIEVsa2hhcnRMYWtlICAgICB8DQo+ID4gfAkrLS0tLS0tLS0rICAgIHwJ
CXwJKy0tLS0tLS0tKyAgICAgfA0KPiA+IHwJfG1fY2FuIDAgfCAgICB8PD09PT09PT0+fAl8bV9j
YW4gMCB8ICAgICB8DQo+ID4gfAkrLS0tLS0tLS0rICAgIHwJCXwJKy0tLS0tLS0tKyAgICAgfA0K
PiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0rCQkrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4g
Pg0KPiA+IFN0ZXBzIHRvIGJlIHJ1biBvbiB0aGUgdHdvIEVsa2hhcnRsYWtlIEhXOg0KPiA+DQo+
ID4gMS4gaXAgbGluayBzZXQgY2FuMCB0eXBlIGNhbiBiaXRyYXRlIDEwMDAwMDAgMi4gaXAgbGlu
ayBzZXQgY2FuMA0KPiA+IHR4cXVldWVsZW4gMjA0OCAzLiBpcCBsaW5rIHNldCBjYW4wIHVwIDQu
IGNhbmdlbiAtZyAwIGNhbjAgNS4gY2FuZHVtcA0KPiA+IGNhbjANCj4gPg0KPiA+IGNhbmdlbiAt
ZyAwIGNhbjAgJiBjYW5kdW1wIGNhbjAgY29tbWFuZHMgYXJlIHVzZWQgZm9yIHRyYW5zbWl0IGFu
ZA0KPiA+IHJlY2VpdmUgb24gYm90aCB0aGUgbV9jYW4gSFcgc2ltdWx0YW5lb3VzbHkgd2hlcmUg
LWcgaXMgdGhlIGZyYW1lIGdhcA0KPiA+IGJldHdlZW4gdHdvIGZyYW1lcy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEt1bWFyaSBQYWxsYXZpIDxrdW1hcmkucGFsbGF2aUBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU3Jpa2FudGggVGhva2FsYSA8c3Jpa2FudGgudGhva2FsYUBpbnRl
bC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jIHwgMyAr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jDQo+ID4g
Yi9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYyBpbmRleCBhNTAwMzQzNTgwMmIuLjk0YWEw
YmE4OTIwMg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nh
bi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCj4gPiBAQCAtMTEx
OCw3ICsxMTE4LDcgQEAgc3RhdGljIGlycXJldHVybl90IG1fY2FuX2lzcihpbnQgaXJxLCB2b2lk
ICpkZXZfaWQpDQo+ID4gIAkJCS8qIE5ldyBUWCBGSUZPIEVsZW1lbnQgYXJyaXZlZCAqLw0KPiA+
ICAJCQlpZiAobV9jYW5fZWNob190eF9ldmVudChkZXYpICE9IDApDQo+ID4gIAkJCQlnb3RvIG91
dF9mYWlsOw0KPiA+IC0NCj4gDQo+IG5pdHBpY2s6IHBsZWFzZSBrZWVwIHRoYXQgZW1wdHkgbGlu
ZS4NCg0KU3VyZS4NCg0KPiANCj4gPiArCQkJbV9jYW5fd3JpdGUoY2RldiwgTV9DQU5fSUUsIElS
X0FMTF9JTlQgJg0KPiB+KElSX1RFRk4pKTsNCj4gDQo+IC0gV2hhdCdzIHRoZSBwdXJwb3NlIG9m
ICAiKCkiIGFyb3VuZCBJUl9URUZOPw0KPiAtIFlvdSBlbmFibGUgYSBsb3Qgb2YgaW50ZXJydXB0
cyB0aGF0IGhhdmUgbm90IGJlZW4gZW5hYmxlZCBiZWZvcmUuIEhhdmUNCj4gICBhIGxvb2sgYXQg
bV9jYW5fY2hpcF9jb25maWcoKSBob3cgdGhlIG9yaWdpbmFsIHJlZ2lzdGVyIHZhbHVlIGZvcg0K
PiAgIE1fQ0FOX0lFIGlzIGNhbGN1bGF0ZWQuDQo+IA0KDQpTdXJlLCBJIHdpbGwgcmVjaGVjayBh
bmQgZml4IGFzIG5lZWRlZC4NCg0KPiA+ICAJCQlpZiAobmV0aWZfcXVldWVfc3RvcHBlZChkZXYp
ICYmDQo+ID4gIAkJCSAgICAhbV9jYW5fdHhfZmlmb19mdWxsKGNkZXYpKQ0KPiA+ICAJCQkJbmV0
aWZfd2FrZV9xdWV1ZShkZXYpOw0KPiA+IEBAIC0xNzg3LDYgKzE3ODcsNyBAQCBzdGF0aWMgbmV0
ZGV2X3R4X3QgbV9jYW5fc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZg0KPiAqc2tiLA0KPiA+ICAJ
CX0NCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJY2Rldi0+dHhfc2tiID0gc2tiOw0KPiA+ICsJCW1f
Y2FuX3dyaXRlKGNkZXYsIE1fQ0FOX0lFLCBJUl9BTExfSU5UICYgKElSX1RFRk4pKTsNCj4gDQo+
IC0gV2hhdCdzIHRoZSBwdXJwb3NlIG9mICAiKCkiIGFyb3VuZCBJUl9URUZOPw0KPiAtICJJUl9B
TExfSU5UICYgKElSX1RFRk4pIiBpcyBlcXVhbCB0byBJUl9URUZOLCBpc24ndCBpdD8NCj4gLSBU
aGlzIGJhc2ljYWxseSBkaXNhYmxlcyBhbGwgb3RoZXIgaW50ZXJydXB0cywgaXMgdGhpcyB3aGF0
IHlvdSB3YW50IHRvDQo+ICAgZG8/DQo+IC0gV2hhdCBoYXBwZW5zIGlmIHRoZSBidXMgaXMgYnVz
eSB3aXRoIGhpZ2ggcHJpbyBDQU4gZnJhbWVzIGFuZCB5b3Ugd2FudA0KPiAgIHRvIHNlbmQgbG93
IHByaW8gb25lcz8gWW91IHdpbGwgbm90IGdldCBhbnkgUlgtSVJRLCB0aGlzIGRvZXNuJ3QgbG9v
aw0KPiAgIGNvcnJlY3QgdG8gbWUuDQo+IA0KDQpFdmVuIHRob3VnaCB0aGUgUlggaW50ZXJydXB0
IGlzIGRpc2FibGVkIChpbiBJRSksIGlmIHRoZXJlIGlzIGFuIFRYIGludGVycnVwdCBhbmQgdGhl
IFJGME4gYml0IGlzIHNldCAoaW4gSVIpLCB0aGUgUlggcGFja2V0IHdpbGwgc3RpbGwgYmUgc2Vy
dmljZWQgYmVjYXVzZSB0aGUgVFggYW5kIFJYIHNoYXJlIHRoZSBzYW1lIElSUSBoYW5kbGVyLiAN
Cg0KPiA+ICAJCXJldHVybiBtX2Nhbl90eF9oYW5kbGVyKGNkZXYpOw0KPiA+ICAJfQ0KPiA+DQo+
ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KPiA+DQo+IA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5n
dXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAg
IHwNCj4gRW1iZWRkZWQgTGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5n
dXRyb25peC5kZSB8DQo+IFZlcnRyZXR1bmcgTsO8cm5iZXJnICAgICAgICAgICAgICB8IFBob25l
OiArNDktNTEyMS0yMDY5MTctMTI5IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2
ODYgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkgICB8DQoNClRoYW5rcywgDQpQYWxsYXZpDQo=
