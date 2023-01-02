Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F165AF94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjABKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjABKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:31:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C7101D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672655491; x=1704191491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=dxb6anmngps4coY8thJR5yP8hqdNKfFxKA+k9t7rEYg=;
  b=fDheTPUAPNfQ5Sq0oapn0Mm7+Z4Efks6ISltJQ+AUWa+YQQtNgcrk+Pd
   rcGpEJfrZjcA+b+MAhRU/Kwu2+Chd1a287l8XOKLKzfwYVmggD3SR1HH3
   X6UsKrgcUDnw/TYbzz4LB7duMQwQNI3zXMIX4Zq3iI71SSdX2ZpK0bOmg
   4ejQVMacFBGdUSGIeZ25waLS5fkj/zrdv+9F9qhuI6ldKdiGrWXAPLvbx
   kGa9ANJdIJ4OhOcfwtcucOXfSOcejPU8MKki4t3qPin8jHrwSSvMApJCV
   v4NTm2CXqaQ2fih2suHRbweWITvjjvHMbLSXXglVeH9+coaetMZaMFd9E
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="348680137"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="348680137"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 02:31:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="647883829"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="647883829"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2023 02:31:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 02:31:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 02:31:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 02:31:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsGWqPCpLjSD91nld9UjI7DPf5Vw5Hf8OW1MYF6I7dK7kmDe6tU7BONrBjHb5etXuGCI4XIzquug0w0FLfCo9IuTLe/M1lpY0sfSbUHCSEPeIZ2pKSydXw89m/PsTjpUXeXCwNz1erEha7eZN6LR4hvrZHu9Us3shsE2QdYJRg2ifHxPexjOzpRzNW39XMiGupLB0paavqAJk7t8v9eKZnRkEFDHcX1xDuZVbBbEkzrJRXV4CFQsvdnXgdaUT6VNr1gj3XOnabdwKQNAdsHtQ2SCpQqh0RQq9Ds4GTqNzwZAPzOTk3C9ZWjCpA6NzZUo+0QqnalsxSbjEqurwmHJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfTIUlIwk5DpBVFVMRNUTUIBiahigb+BgQACKyv+a2c=;
 b=HjIcZovGMDbS7GRPRIaUwTGImmjxhBs9ZH6Frw1vKmPrIxSy97YJxB42TyFY3zeHwwH0XkFeDkJlwmIs+UsbVzvpmSs8PXcJ3gUCKbhdbbW8Oy/+yLdGcK9eQjIs29msC/sbdoK9skMHdz/r1NMbjxlIgRvL5rLg6LBFpAOJlWKyH0QczhK8XfmEMSRp3US6Wxwu4o6zse3Y/4LffAKkZvti2osDs2zHSeTxC4kXZCd1Z87YZVeNPN/3Q5sWDe09NHIjh2rJbU44Qduls0J3GVGwNVhAslJB37VadmfOo0qrkUFIsLHq6Soeob97rrIhyaqrYNIQclN7UbKHTRJ+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4401.namprd11.prod.outlook.com (2603:10b6:a03:1be::13)
 by SA0PR11MB4768.namprd11.prod.outlook.com (2603:10b6:806:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 10:31:28 +0000
Received: from BY5PR11MB4401.namprd11.prod.outlook.com
 ([fe80::5f0c:8736:f13b:1450]) by BY5PR11MB4401.namprd11.prod.outlook.com
 ([fe80::5f0c:8736:f13b:1450%5]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 10:31:28 +0000
From:   "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
Thread-Topic: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
Thread-Index: AQHY6UzmweU+5tAt7Ue7AVvC+BW8sq4zJsUAgEHrhACAFkXWAA==
Date:   Mon, 2 Jan 2023 10:31:27 +0000
Message-ID: <818f7164f374ddabb3230cd6c8a75708cc72ac97.camel@intel.com>
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
         <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
         <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
         <20221219012313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219012313-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.1-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4401:EE_|SA0PR11MB4768:EE_
x-ms-office365-filtering-correlation-id: 60f74064-51dd-4306-804c-08daecac81ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vlz+ZTCJe34y0AjPBGQz855HQFb9g8FQcYD4ykD5JAp9/iPcGcjwePMvWD3z3U9N4043iwxbDM/XlxZfsF4vDwlZE3jMFaXbLz4G6yp69PdUBnVxsIhdZUwLaVFtAHWvRgzb5Jea6nmHnjlDp8IWMOrOLLBTrpKyx0W8lQyEqQsGImIjsL5L4iwCHkOtCk3Vnw1DjDuV5SKYWuHOvD+zxp7JGyL8eXSAR8M7/79na6lZ1iXalNafUhbCYWSmPsL3cdYT672FVs/YyfAkfplEVjn8GTgf+br0IWjtdAqgswCaaV0U22kwstHz5ymXSLpKHddKYtmAGsrA673xF5iYkRdRkiIewMQ6MCHaGUzZTZpRYF8Zd9EGS/XMibg77quxsLd5hJ6yWhMkWxHn7Jo1sv04KJd1VP1CU5gZOY2h153uN0kUro4PKc4nB0oQy09ez2to9ukqu9OLnXZL/8UboDOcYr4WjA0DdXmGekVxDJFxVVJEtb2sNTObN24cqNLwoKGWVLgWmlk+nFSxuAz2S3xMjt6B+UiQwQ+lZareKjNqQpdokBg3CLX3zogkyAm5WCNRcK+Y8xj/ZjjVaQGiTHQRaiv8wyeWTo89k7noOUfF5rF1LnBeH02UmENQ+CMeRQ67o65Epu9bQJKGqoJwABuCEdvHqt3PIJ6MxWZNjT7r9a2r+AbSmy8myS91z7L42Hg95LEq8+Qi83TvyQvfgmDdGxLLVkLrGPnh998qGuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4401.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(8676002)(66476007)(66946007)(64756008)(66446008)(4326008)(66556008)(5660300002)(2906002)(4001150100001)(110136005)(54906003)(8936002)(76116006)(316002)(6506007)(478600001)(6486002)(71200400001)(53546011)(41300700001)(186003)(6512007)(26005)(83380400001)(2616005)(38100700002)(122000001)(36756003)(66899015)(82960400001)(38070700005)(86362001)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVF3RDR5bEVNUWNPODJGK09LNVhTYVRtc3IxNFJRVUJVd2psM3VzU0RpMEhD?=
 =?utf-8?B?ajlzdnFKcEVyYXNKVkhqSTdFMFNqRG1mT1UzY051Mit2akw3Q0hLaXQ3MHRi?=
 =?utf-8?B?Ry9wVk5UN0RRMXF0cHcxSmIyNjZ4VUh6bmc0UHVCU3Q1OHF2SjZIb29YTG1k?=
 =?utf-8?B?QVNWNkVGaVF6aXhwODU1ZWFObURQNU5SZHI0K3B6Z1dKUnJHd0F4VkluOXpT?=
 =?utf-8?B?bG9UVlRoRzhET215cWpqejBmNEJiNzNiOUlWRmdaRG1jb0xuSnUyVUZ0YWtX?=
 =?utf-8?B?OEV6VitiUUM5dnJVOFRVVG5ZLytKb3lqTGN2citHTE5BeFEvZ2hySlh0QjJq?=
 =?utf-8?B?ckNQcjg3WXQxSmEyNllkVnh2Nlk3U3dHeHJTMmJCVlBxdkNzL0lma2cwbmdV?=
 =?utf-8?B?Q1dWY1FYSm1hclU5WVJWZ2FhL1l1NnF0NG9NZnB0UUNpcW1WSVkxVlRXZThp?=
 =?utf-8?B?Q2NMTHhJMkxBRXVLdi9OdU9iWkxDaTZucEFPTzQ4K0l1L3ZZdWcwYnJJS3V3?=
 =?utf-8?B?ZDNqbGw1ampSY1RlZHRTVHEyRDhzK3g2bHAzZWV0aUtkRkRRdFFCaEozek8z?=
 =?utf-8?B?VnlZaHZ2SmhkK21CL3FwdTNWQ3ZGVjkxQU1VdjVvUTR6WjBtczVxZkw1UnFV?=
 =?utf-8?B?ZFRRbncwNE1pUkN3a1gwRkxVdkFRMW9SRFd0emUzMzVXZXpsNStZL1VFbyty?=
 =?utf-8?B?aTJ2dTRkQU5CTlA4TEsrWGFrdllGekFsM1l6eVE2QUtPMFBkZXRnZzY2WGlY?=
 =?utf-8?B?RXdiSmd4L0ErNmFOOXdhSEc3ekxjWXNEQkVlUC9tT0FPSllCc3FTRXprU3lt?=
 =?utf-8?B?MC94MlB2ekhZZTdQV2lKSXBOZmFNUWF1UStpSlJBaEwxNEltQ0tucUJ5dThB?=
 =?utf-8?B?aXBlUWc5cW8vdGtPK25kTnpwZG1MUlhVcC82T2xnUTF6ZzFZWHluWS9GV2dZ?=
 =?utf-8?B?UlFPNHhjZWQrTGlyY3FwMW1pT09CM2tNNzFTK25sOS8wRGc4YXl4QmlaOG0v?=
 =?utf-8?B?VDlFNjVQUkJJS0pQVjV4c2tGeGtPVXNodnpTMkhqMVZidWxZeFBBU2lzSlg0?=
 =?utf-8?B?aGFxMjBkZ1U1bnE5RkRaNjdMUGt4bEdPOWwxbXVjK2dpL3pRVllVSzJuVk1T?=
 =?utf-8?B?L084aFhnOUJBVnBxb1F1M2xtSlhrYUFkeHBQcVYrNlZpdDRDR0ttQjBTL0NB?=
 =?utf-8?B?YkxNZ1RYVFlGYlRqeTdNcTQxZ2xNaFFNT0NKWjV2TzFzNU9uNW9BcWVnckZG?=
 =?utf-8?B?VzI5a09ZdlJneGRkZ2xjWkJwbUtqV1YvZGVwRER4TlFmMkRNQ3NXOHdtOTRv?=
 =?utf-8?B?b1BzQ1IrRjMwMld0Y1lxK3NienRja3BhYzkxeXRjVHROdlNwNlg4cllxeExq?=
 =?utf-8?B?OFBCRDB6cm83UnhmN3lDMEF2M0h5MVBCR2diRFo0QkhLcGxQQ3NDT2FXajB3?=
 =?utf-8?B?ZzN1c29wR0kvZTBjdEV0ZzNUeGwzOGMrWlhkaXl4TlBIZ0FGWENqbXVaeDhK?=
 =?utf-8?B?YzFSR0cyQmJRRGw4dkVqRndPUGdoQ1ptOTdQRjJJenpodk5EOWV5UllyR25q?=
 =?utf-8?B?eXVDekpoY281NHVDSWJNcVVVaHE1eWNaaFRSZ2U4Y2p4VlFKbEZmNDRQWlo0?=
 =?utf-8?B?U2tEZDR3VGgrMEJZTXVuSmN6YTR3blRwdXBNUVNROUs3WCtyRmJiRHJSV2h4?=
 =?utf-8?B?OTZuTUN5UEU5d3pnRDI2NlI3cTZabC9vdHdjQkdQQnRXTjN0L04vRERZcy9X?=
 =?utf-8?B?N0RPWkNLcnVXbUgvSXVrVGNMR1RTZVBpNzQ3QUlmZDZHTCttMStyWHlRSGhj?=
 =?utf-8?B?T3h4UjI3SDBlME1jUExxaXBxTWlkbzAwdTh1SEZlWjdGVmo0MHFaWkhkakt0?=
 =?utf-8?B?WVZUcm43ZFpkZms4elFBZG1xY1d4c0pYMmRwQmpIbDBIVjR4VjhDY1RpT2Ra?=
 =?utf-8?B?OUZTcU95WWFHaVdkS1FMTlVDRkJ5TnFuc2hWNFVWNksrUE5WemtEekt6dVph?=
 =?utf-8?B?N3NMTFU1ZWJBY2FkanhzNXgrUEtwUjhEWlRsMUxZOUFOZmhJb1p1WWVjNjZs?=
 =?utf-8?B?aEZyUzVPaVhmdm9qMlJBRnR4TE13L0pLOGxYVXlzU0lKcmNabHh6NGd4cjFX?=
 =?utf-8?B?MVkrYVZldTJLZzFQdnJFQWJGcWljdFdiOUlyZ0pTMk1DUUxTNXc2SnNGVm1o?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72EBA26A9DF31040A43EED553909833F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f74064-51dd-4306-804c-08daecac81ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 10:31:27.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6GnVMXlJGPrSZKb+3RGu3zrOm+kJqOKsZBfrKIwawpYHig79P2VoemyIcPsNTTJCItJVbz7TlENG0dmDXv7sPdPwya/HvUi9e6eEZnFxqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4768
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTE5IGF0IDAxOjIzIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gT24gTW9uLCBOb3YgMDcsIDIwMjIgYXQgMDM6NDM6NTRQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+IE9uIFdlZCwgT2N0IDI2LCAyMDIyIGF0IDExOjA5IFBNIDxzZWJhc3RpZW4u
Ym9ldWZAaW50ZWwuY29tPiB3cm90ZToKPiA+ID4gCj4gPiA+IEZyb206IFNlYmFzdGllbiBCb2V1
ZiA8c2ViYXN0aWVuLmJvZXVmQGludGVsLmNvbT4KPiA+ID4gCj4gPiA+IEltcGxlbWVudCByZXN1
bWUgb3BlcmF0aW9uIGZvciB2ZHBhX3NpbSBkZXZpY2VzLCBzbyB2aG9zdC12ZHBhCj4gPiA+IHdp
bGwKPiA+ID4gb2ZmZXIgdGhhdCBiYWNrZW5kIGZlYXR1cmUgYW5kIHVzZXJzcGFjZSBjYW4gZWZm
ZWN0aXZlbHkgcmVzdW1lCj4gPiA+IHRoZQo+ID4gPiBkZXZpY2UuCj4gPiA+IAo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTZWJhc3RpZW4gQm9ldWYgPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+Cj4g
PiA+IC0tLQo+ID4gPiDCoGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMjgKPiA+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiDCoGRyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbS5oIHzCoCAxICsKPiA+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2Vy
dGlvbnMoKykKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+ID4gPiBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gPiA+
IGluZGV4IGIwNzFmMGQ4NDJmYi4uODRmZWU4YmIyOTI5IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYwo+ID4gPiBAQCAtMzU3LDYgKzM1NywxMSBAQCBzdGF0aWMgdm9pZCB2
ZHBhc2ltX2tpY2tfdnEoc3RydWN0Cj4gPiA+IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgaWR4KQo+
ID4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2lt
KHZkcGEpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZx
ID0gJnZkcGFzaW0tPnZxc1tpZHhdOwo+ID4gPiAKPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIXZk
cGFzaW0tPnJ1bm5pbmcpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmRw
YXNpbS0+cGVuZGluZ19raWNrID0gdHJ1ZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuOwo+ID4gCj4gPiBJIHRoaW5rIHdlIG1heSBoaXQgaGVyZSB3aGVuIHRoZSBk
cml2ZXIga2lja3MgdnEgYmVmb3JlIERSSVZFUl9PSy4KPiA+IERvCj4gPiB3ZSBuZWVkIHRvIGNo
ZWNrIGRldmljZSBzdGF0dXMgaW4gdGhpcyBjYXNlIGFuZCByZXN1bWU/Cj4gPiAKPiA+IFRoYW5r
cwo+IAo+IFNlYmFzdGllbiBkaWQgeW91IGZvcmdldCB0byByZXBseSBoZXJlPwoKQWggeWVzIHNv
cnJ5IEkgZ290IGNhcnJpZWQgYXdheSB3aXRoIG90aGVyIHRoaW5ncyBhbmQgZm9yZ290IGFib3V0
CnRoaXMuIEFuZCB0aGVuIEkgd2FzIG9uIHZhY2F0aW9uLgoKSSdsbCBsb29rIGF0IGl0IHRoaXMg
d2Vlay4KClRoYW5rcywKU2ViYXN0aWVuCgo+IAo+ID4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ID4g
Kwo+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAodnEtPnJlYWR5KQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2NoZWR1bGVfd29yaygmdmRwYXNpbS0+d29yayk7Cj4gPiA+IMKg
fQo+ID4gPiBAQCAtNTI3LDYgKzUzMiwyNyBAQCBzdGF0aWMgaW50IHZkcGFzaW1fc3VzcGVuZChz
dHJ1Y3QKPiA+ID4gdmRwYV9kZXZpY2UgKnZkcGEpCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+ID4gPiDCoH0KPiA+ID4gCj4gPiA+ICtzdGF0aWMgaW50IHZkcGFzaW1fcmVzdW1lKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+ID4gK3sKPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1
Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+ID4gPiArwqDCoMKgwqDC
oMKgIGludCBpOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZ2ZHBhc2lt
LT5sb2NrKTsKPiA+ID4gK8KgwqDCoMKgwqDCoCB2ZHBhc2ltLT5ydW5uaW5nID0gdHJ1ZTsKPiA+
ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgIGlmICh2ZHBhc2ltLT5wZW5kaW5nX2tpY2spIHsKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUHJvY2VzcyBwZW5kaW5nIGRlc2Ny
aXB0b3JzICovCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7
IGkgPCB2ZHBhc2ltLT5kZXZfYXR0ci5udnFzOyArK2kpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZHBhc2ltX2tpY2tfdnEodmRwYSwgaSk7Cj4g
PiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmRwYXNpbS0+cGVuZGlu
Z19raWNrID0gZmFsc2U7Cj4gPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gPiArCj4gPiA+ICvCoMKg
wqDCoMKgwqAgc3Bpbl91bmxvY2soJnZkcGFzaW0tPmxvY2spOwo+ID4gPiArCj4gPiA+ICvCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gwqBzdGF0aWMgc2l6ZV90
IHZkcGFzaW1fZ2V0X2NvbmZpZ19zaXplKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+ID4g
wqB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gdmRwYV90
b19zaW0odmRwYSk7Cj4gPiA+IEBAIC03MTcsNiArNzQzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMKPiA+ID4gdmRwYXNpbV9jb25maWdfb3BzID0gewo+ID4gPiDCoMKg
wqDCoMKgwqDCoCAuc2V0X3N0YXR1c8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1f
c2V0X3N0YXR1cywKPiA+ID4gwqDCoMKgwqDCoMKgwqAgLnJlc2V0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fcmVzZXQsCj4gPiA+IMKgwqDCoMKgwqDCoMKgIC5z
dXNwZW5kwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9zdXNwZW5kLAo+
ID4gPiArwqDCoMKgwqDCoMKgIC5yZXN1bWXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA9IHZkcGFzaW1fcmVzdW1lLAo+ID4gPiDCoMKgwqDCoMKgwqDCoCAuZ2V0X2NvbmZpZ19zaXpl
wqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2dldF9jb25maWdfc2l6ZSwKPiA+ID4gwqDCoMKgwqDC
oMKgwqAgLmdldF9jb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2dldF9j
b25maWcsCj4gPiA+IMKgwqDCoMKgwqDCoMKgIC5zZXRfY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgID0gdmRwYXNpbV9zZXRfY29uZmlnLAo+ID4gPiBAQCAtNzUwLDYgKzc3Nyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzCj4gPiA+IHZkcGFzaW1fYmF0Y2hfY29u
ZmlnX29wcyA9IHsKPiA+ID4gwqDCoMKgwqDCoMKgwqAgLnNldF9zdGF0dXPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3NldF9zdGF0dXMsCj4gPiA+IMKgwqDCoMKgwqDCoMKgIC5y
ZXNldMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3Jlc2V0LAo+
ID4gPiDCoMKgwqDCoMKgwqDCoCAuc3VzcGVuZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA9IHZkcGFzaW1fc3VzcGVuZCwKPiA+ID4gK8KgwqDCoMKgwqDCoCAucmVzdW1lwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3Jlc3VtZSwKPiA+ID4gwqDCoMKgwqDC
oMKgwqAgLmdldF9jb25maWdfc2l6ZcKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9nZXRfY29uZmln
X3NpemUsCj4gPiA+IMKgwqDCoMKgwqDCoMKgIC5nZXRfY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgID0gdmRwYXNpbV9nZXRfY29uZmlnLAo+ID4gPiDCoMKgwqDCoMKgwqDCoCAuc2V0X2Nv
bmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fc2V0X2NvbmZpZywKPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCj4gPiA+IGIvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPiA+ID4gaW5kZXggMGU3ODczN2RjYzE2Li5h
NzQ1NjA1NTg5ZTIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5oCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCj4gPiA+
IEBAIC02Nyw2ICs2Nyw3IEBAIHN0cnVjdCB2ZHBhc2ltIHsKPiA+ID4gwqDCoMKgwqDCoMKgwqAg
dTY0IGZlYXR1cmVzOwo+ID4gPiDCoMKgwqDCoMKgwqDCoCB1MzIgZ3JvdXBzOwo+ID4gPiDCoMKg
wqDCoMKgwqDCoCBib29sIHJ1bm5pbmc7Cj4gPiA+ICvCoMKgwqDCoMKgwqAgYm9vbCBwZW5kaW5n
X2tpY2s7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIC8qIHNwaW5sb2NrIHRvIHN5bmNocm9uaXplIGlv
bW11IHRhYmxlICovCj4gPiA+IMKgwqDCoMKgwqDCoMKgIHNwaW5sb2NrX3QgaW9tbXVfbG9jazsK
PiA+ID4gwqB9Owo+ID4gPiAtLQo+ID4gPiAyLjM0LjEKPiA+ID4gCj4gPiA+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4g
PiA+IC0tLS0KPiA+ID4gSW50ZWwgQ29ycG9yYXRpb24gU0FTIChGcmVuY2ggc2ltcGxpZmllZCBq
b2ludCBzdG9jayBjb21wYW55KQo+ID4gPiBSZWdpc3RlcmVkIGhlYWRxdWFydGVyczogIkxlcyBN
b250YWxldHMiLSAyLCBydWUgZGUgUGFyaXMsCj4gPiA+IDkyMTk2IE1ldWRvbiBDZWRleCwgRnJh
bmNlCj4gPiA+IFJlZ2lzdHJhdGlvbiBOdW1iZXI6wqAgMzAyIDQ1NiAxOTkgUi5DLlMuIE5BTlRF
UlJFCj4gPiA+IENhcGl0YWw6IDUgMjA4IDAyNi4xNiBFdXJvcwo+ID4gPiAKPiA+ID4gVGhpcyBl
LW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJp
YWwKPiA+ID4gZm9yCj4gPiA+IHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
KHMpLiBBbnkgcmV2aWV3IG9yCj4gPiA+IGRpc3RyaWJ1dGlvbgo+ID4gPiBieSBvdGhlcnMgaXMg
c3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkCj4gPiA+IHJl
Y2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMu
Cj4gPiA+IAo+IAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpJbnRlbCBDb3Jwb3JhdGlvbiBTQVMgKEZyZW5jaCBz
aW1wbGlmaWVkIGpvaW50IHN0b2NrIGNvbXBhbnkpDQpSZWdpc3RlcmVkIGhlYWRxdWFydGVyczog
IkxlcyBNb250YWxldHMiLSAyLCBydWUgZGUgUGFyaXMsIA0KOTIxOTYgTWV1ZG9uIENlZGV4LCBG
cmFuY2UNClJlZ2lzdHJhdGlvbiBOdW1iZXI6ICAzMDIgNDU2IDE5OSBSLkMuUy4gTkFOVEVSUkUN
CkNhcGl0YWw6IDUgMjA4IDAyNi4xNiBFdXJvcw0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3INCnRoZSBzb2xlIHVz
ZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlv
bg0KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZA0KcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUg
YWxsIGNvcGllcy4K

