Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEF6E284A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDNQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:27:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE437D91
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681489638; x=1713025638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iWAP9n0J61mFh1kusmrXrKfbUbQSqUyIDhDMHSzyzPc=;
  b=VYuH7vmvw5jwl2wGlYW+TXYuk1cFUW331xxwj68D8BzuzgJVfuwPLPOI
   xtkyTg2z/2OOh2f1Ff7qUZzF0ohKrQI7HoEHVRPkc5iP2hEGKVnbRYevJ
   cjRmPlGezoOi4IH6LdwsmKnIrqkDrj5Pe2r3r/Xa0IT5PbVPCgS/QCJOj
   pa3qaQ5r+AfguKKdYvStOXZVwX7r0LiHfSGhRUAXf9xNYqk8fwSoLl+2r
   NJB8w1q6JGCs1zzsLLHTlAvrHTJrwA3eJXErpMY+J0GnpD2ga8HhgRf5I
   s2EiyiDf44BMhtyivopftZWaEc6PQ1EbLIo7YUEMMD6fUguS+0n4HBdQB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="346340743"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="346340743"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 09:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="801266353"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="801266353"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2023 09:27:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 09:27:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 09:27:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 09:27:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/PXpIwIo+TZr7wrTi0uPYyfXrk/r/BSgq/3rtQ4ULL7mJLaPbuOz4LujXkripyoH2fBeM0f2PF0+BhoAeKG0z6qgGmpuRYvgLiRq97CyPmRhVCdjcDddueIzAFxa1wCzpJ02lALOml5qiXla4rUaCJ4pKplqKRuG0Qo07/FTgYEgnkFPrXMOdYAjE94pOfEU1ukJC2ImxrHsOfYAkssevbx+uuvoxxBfkV8bj8+AVMdjKsCNRX2Qkx0pVOyuMMCffNikHdm6Uhmynm22OjWhp1x2mKX6IyfuEjgwPOwdsm+AbxcVYeUtKRT/rjzt8URpPPUA0RUzKi6ngTBemQ/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWAP9n0J61mFh1kusmrXrKfbUbQSqUyIDhDMHSzyzPc=;
 b=A5MpZTDRp0Lyj2Jms8BzC0wFdBzHgJmmaCCFrg9A36BKqawYNvwt7G4T/oM5FaYQHbpa7T3iykgjikUXxMQFr4QQVL9f/U6kJv4D/tWHWb1I07qYs4cTXHAx4EsJ1dQ0N+cLmgI3RrT6tcPnQwWhTc3IoXciOW5077f7D4m7b0YSvRU73naq6zpDFDYNJLqtvPvGtKR+Cz765b0brEfzYoxLbKNVqXRhTBCg9sCDwGODd7oe5Sy+LvlfXQzEy3SrbHKjx5lB39dGaHRN5kFDkBe6l0zBdMibtcASCCNFWkfEy8ucaBRZUXrLqsUzNWn3cfRcVYnQYWmGaLhL3GQoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 16:27:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 16:27:15 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Thread-Topic: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Thread-Index: AQHZbuGFm4Wq+BshnkmYPdeOWIdmDa8q/i4A
Date:   Fri, 14 Apr 2023 16:27:15 +0000
Message-ID: <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
         <20230414145728.4067069-3-Liam.Howlett@oracle.com>
In-Reply-To: <20230414145728.4067069-3-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: 3bf4f22e-5554-4b6a-5377-08db3d051b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8HXb91nrlvfrnSbTGxUcvwP5JxojWUtlPGNup4khrziaTFoMFgkk5MYM76P3Glm7yBypefxT+JPS3yMB3HaK0Arzl66NBnd82o4Eu56ZmioDxNaW/h1ZkdfPjqGMKIdG/rIyX0c/WKbTRjUYePIba9+hj5DorPkw/bjxFlmyD3GetMg6ZBsBcz4TQL9gtVLHSd8KSJXV72gy+Ri+hvr4V4OCx/R2j3VERTKLnfba3lxQOJ0z4Fp+G568Fr9ieFjU+V3/WCg/DtC4RpqqHB+yllRzWY0emKtEIqI8NwU3qRZPhLw5apkxDZ6WQ6SwP6Vp2nqssAkEZKoCFRAj3lNCPG542d15+maYm+l/i2UVxFp7A7ozm/ye5r7TZwoN1pNUceAiZ0LPoyjed5OQ6EOQUYbppoCqpadzZCmkXvyj2y2NOZ7Lozk6JTSUMw8eoQUoDHewuNUZzMfz/olT0/hdnmBqqtDs8B1WPyz/ZqcZvAFAyYvlvvTJw6YayrxJkICBM6FQtXwvxkwsdO3lzNCeRPyadKm8X7TfDDJe3gQskZzX1pMNUKTxksH0jeybxJd8RSrXzSAYf+RO7OFiw4+gjy8iNNHgAM6Oj8zxo+tNqWKKUWRdKROwgFvW/uKQ4RT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(71200400001)(4744005)(122000001)(5660300002)(36756003)(2906002)(38100700002)(316002)(8676002)(38070700005)(86362001)(8936002)(64756008)(41300700001)(66446008)(66556008)(66946007)(66476007)(82960400001)(4326008)(76116006)(6506007)(91956017)(83380400001)(2616005)(54906003)(186003)(110136005)(6512007)(26005)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Slc5ODVNaDNLR3J1S1lRejNWdnU5QmVtaG1qWTkrQUpiWHFsbXcra1EydTUr?=
 =?utf-8?B?SmhPWHFNN2hFMmM4K3kveXAraVd4a3h0ME11Rk9BR0hXOFkxRTlTL3J5QnpF?=
 =?utf-8?B?REZGSHdGcDN3WktLRXJ4cU1KWW50MGdqckVWRDk1WE9wOHpOVUUzaE80c3ZI?=
 =?utf-8?B?VzRZdWNIWkJjWmlucnczeVRpMmxLVHNMTHkzVFlPS0Z5K1hJb2Mza2ZTNHpV?=
 =?utf-8?B?NFlNS2tUWHRBSy9pMFVmYTlWdjdaT2FVRlMxcWIzcms4bE1CdDdUSllaNStU?=
 =?utf-8?B?QWdyT2c1MFRoNzNtV3p2ZXA3YkVYd2ZZQlo4S29iSmtXSmtXRzA3MmtvQUg1?=
 =?utf-8?B?Y2R2aSs1KzBKdHdNekhSU0V6R0lnc05jZDRIWHlRRy8zRFNUVHM3M2d6UlF5?=
 =?utf-8?B?TUIrVTBoVDZGdzkvZ3FmZzZEV3dVbFk3T2JOUFNzU09SRy8rYlZteEhKMk9Z?=
 =?utf-8?B?cGJGYXNtamRLNFFWTS9OLzVWd2JyZUpSaEExTGYvb3l1QW9BbjVmcTYwc2xI?=
 =?utf-8?B?ejB2MzB0NkNnT3UzWWhLQUVDV05iajdIWnpHMzRHblhBQWlLN2VUUFZCc0Fr?=
 =?utf-8?B?TllXQ2IxM0dXTXBDZG45OFhCREU5c1lkV0NPQXZmYUs3UHhMeGY1cDV6RTFn?=
 =?utf-8?B?NFFpS3RYMURNdld4eWEwdDBWT2oyaFp6T3FNRG43eXBtQW9PNGtwWVpwSUp3?=
 =?utf-8?B?b1k1S0d1bktjblA4blMrdVBxOGQxYWxTdmhaMXRDN0FJNUVacExsdFE4NDRr?=
 =?utf-8?B?WFRLUnFaM2pNYkhZNEFXeUNBaWtXNUhtUVlENzAzN0xlbVhBb3dyREZKb0FN?=
 =?utf-8?B?bkFMd1pmcWFyb3ZtU3FFZDQvOVRwMkVzM2FhaG1QK3EwYkJWbjkwYzBoMks2?=
 =?utf-8?B?aXpWeEZEem9kR0xJWHVjZGhZanBoektmN0R2NHhjdHJuTkZIeFcwQ2JPZi9x?=
 =?utf-8?B?MGhqWU9BWHI2ZTNoL1RxYkNSZTF0WW5MSG4xc3VZMXJUM0lyMnVPcUJRc0Vh?=
 =?utf-8?B?Vk9kT211WjhNaWV1SFpkd3psMnZWY3FsNm56SktJQ052bk4rZEtSdndFYS9B?=
 =?utf-8?B?dlNPejArNENkSmVrY0x0QkYrQmdDT2k5Yk5lNFI1M0ljc0tVS25kSzBEdC9E?=
 =?utf-8?B?Unl4TWFrLzJZOUZvTjUwUVBQV3FoNnlsWWM0UGhmNUhXMzVaa3RqOUNUU0t2?=
 =?utf-8?B?NGo0RDdTQWJIeDk1N1V2eFd5SHNndEpzSHJ2TktndFZSZ1FBbWtNUUs4MVJS?=
 =?utf-8?B?K0NFMysyRll6SFk3bkQzRVJRNDROM0N1QldZcFhzVktOSUtWc2ZMQXRIUGF2?=
 =?utf-8?B?Y2ZYQjlSZnd3SzhzV1JpRGhIUGcrVmp5NVJ0QmlIaE1iQXRQWitzRkFoUTdD?=
 =?utf-8?B?cUs3eXNBejBJeXU0UG9DbjVRSkhkUEtxWWVSZVpNeGw3VHE2aW1SSmpwOUpM?=
 =?utf-8?B?cTE5elZCY0RRRzVBMWNVb2RZc00ydTQ4OE5FNlR4QnZJSEFzSFVLeEJlQXlM?=
 =?utf-8?B?cXdJT2piM1I2bk9QMTBJMjVKUUlsUzF2eWx3VnFZY1R6RUlWSGlmdWNFdVIy?=
 =?utf-8?B?YmVPcGE2S3Y5dmNZaWNtZWE1Ymd5b1dZZjYwdFphSlRhUENnNGNRWEtXYkcr?=
 =?utf-8?B?LzFzVFArZnRxWG84UElhK0RwQU5tSUkycGxSZkd6UEd3c21zOGpIclp6QXp5?=
 =?utf-8?B?NjNTRThBNnk5Z3dZNkFjMDl3dHJnSjlnSjFEMEFFVzVzVnFtbFV6WkZPemps?=
 =?utf-8?B?T2ZqSEhjc05pNlVBMnZ6dHBORHo2cTVQeWZPOWk0b09yMG9TUGFnRGFyM2F2?=
 =?utf-8?B?TTQyM29saFora054VldJL2U2TTMwdWlqc3lUZzJVck1zVzM0UDlsRTJya2wx?=
 =?utf-8?B?R3A1U2xHZjNOc2tYVDhPL1hYcTVsbWtwQ0F0TGtZcU8rZTRTKzl5dlQ5aFMw?=
 =?utf-8?B?bTRsZnJIWDFwMWhCaDd5MFhXbENMUUc0Y0dLZFVGcHlxdEVGL3hhRFF6ek1L?=
 =?utf-8?B?WXprZzRudnByY0dQK1ljQ2FqbmtjSjRiRXprQ0F1b0tzbitOMFZjMXhhWE1s?=
 =?utf-8?B?UVVCRlBTeGNTWEdmM3BydGx0ZDI2MVh3MWtnNWo1blpSM3FxV0NmS29HbVdP?=
 =?utf-8?B?bFNhalFOQ2Zlczc1RFdwMHI1ZTBuSEVLaFptZWYrUmM4K0xwOVViR3VWRVZq?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD7DB48E10ED9A4986F5C352C0B84D44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf4f22e-5554-4b6a-5377-08db3d051b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 16:27:15.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuATHLS79bJf79e7jVZ01ixED7jvo1jJp2NiSeRJg830PEQNv5uoH8HL+pak0W1QOIOIE4mFdSyMPWncP57kqUTOyTtTLg6/QT34vgCxdt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDEwOjU3IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6
PGJyPgo+ICvCoMKgwqDCoMKgwqDCoHRtcCA9IG1hc19uZXh0KCZtYXMsIFVMT05HX01BWCk7Cj4g
K8KgwqDCoMKgwqDCoMKgaWYgKHRtcCAmJiAodG1wLT52bV9mbGFncyAmIFZNX0dST1dTRE9XTikp
IHsKCldoeSBhbHNvIGNoZWNrIFZNX0dST1dTRE9XTiBoZXJlIChhbmQgVk1fR1JPV1NVUCBiZWxv
dyk/CnZtX3N0YXJ0L2VuZF9nYXAoKSBhbHJlYWR5IGhhdmUgY2hlY2tzIGluc2lkZS4KCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2bV9zdGFydF9nYXAodG1wKSA8IGdhcCAr
IGxlbmd0aCAtIDEpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGxvd19saW1pdCA9IHRtcC0+dm1fZW5kOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWFzX3Jlc2V0KCZtYXMpOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byByZXRyeTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRtcCA9IG1hc19wcmV2KCZtYXMsIDApOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodG1wICYmICh0bXAtPnZtX2ZsYWdzICYgVk1f
R1JPV1NVUCkgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZtX2Vu
ZF9nYXAodG1wKSA+IGdhcCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbG93X2xpbWl0ID0gdm1fZW5kX2dhcCh0bXApOyAKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1hc19yZXNldCgmbWFzKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gcmV0cnk7IAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfSAKPiAr
CgpDb3VsZCBpdCBiZSBsaWtlIHRoaXM/Cgp0bXAgPSBtYXNfbmV4dCgmbWFzLCBVTE9OR19NQVgp
OwppZiAodG1wICYmIHZtX3N0YXJ0X2dhcCh0bXApIDwgZ2FwICsgbGVuZ3RoIC0gMSkgewoJCWxv
d19saW1pdCA9IHRtcC0+dm1fZW5kOwoJCW1hc19yZXNldCgmbWFzKTsKCQlnb3RvIHJldHJ5OwoJ
fQp9IGVsc2UgewoJdG1wID0gbWFzX3ByZXYoJm1hcywgMCk7CglpZiAodG1wICYmIHZtX2VuZF9n
YXAodG1wKSA+IGdhcCkgewoJCWxvd19saW1pdCA9IHZtX2VuZF9nYXAodG1wKTsKCQltYXNfcmVz
ZXQoJm1hcyk7CgkJZ290byByZXRyeTsKCX0KfQoK
