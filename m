Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763DC693CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBMDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:21:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B9A9EFC;
        Sun, 12 Feb 2023 19:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676258472; x=1707794472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q5hPu8ZN5BnRrcT9aC4jTls+30o8RCme+DjO5qu7E5E=;
  b=ARyw+AcM58R/IO6s/aOXPeIXSOS7VQVeNDmF6Jq6/G5DN/JAITnsVRZo
   n06fRtMBSk9zE1pyQDcJNuJwhtpgBkADRL+94pcWZWBZmaY5SWxZ78lCm
   O/t4JobojcWtwBkQB0rNI9r8RFuKvoF2dxlxg9vnAy5C/4/Rfhb9YzjnZ
   86l+w036KB9/SkNdaS6LJazosD916M/qPCYTcLqCXNzTV2NsD6l5EekYq
   6WGg+zLCJ/YivMhZCi+8F2P/qGUzABsI9oaUTekoxHgPiwTTQl7Ytfr8z
   yXhlFQoudnQndGYRerPrchuLzDFM2yY6Rg72wxs4kXiUsNnFl/hhBNnyW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="311158545"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="311158545"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="732335896"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="732335896"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2023 19:20:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 19:20:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 19:20:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 19:20:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRcDAm+GRGwGWiQZb49f7MYhOwHoBTJSUHHvQizH5iFaT7Fa7N6VXvnvzJO4LaGr5OJIula3cxK1qvkZ6j5GmkhuV46B2XCgoLJTB+ChYySi5vH73nlzk+pMoLlOLxqpqb8nNSZE11GCNpBwpHjkkbpUwCdw4irV5GPuvx9yfweS99LcDJLr3fWEBqxbk/FdNlRGxQHfXEfePC5VmSVvkvYYf/vKOvhU8T1yeUy8IVksOc8zPjtZxu6pJV87evYS6TPrtq6EW+vCiFoTL0fz8kB05dkJIWTbAJ61ycMi2Zco74P+RcaSQiM326MWh4is6Nsz2uXeWjJ0LZWlpG0o5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5hPu8ZN5BnRrcT9aC4jTls+30o8RCme+DjO5qu7E5E=;
 b=MiAWAfPWh2X0157n502LA90n1gwjVpBRXdhizxB+3vHZRPhqF0rL4HsIou5uEx59xakOBjdlvbF4BEYhuJHL+Jh8t4JB52MaDGshHo1U389yqe2IqD40ETnPINZkglI7XqJnVdePAMOUd02okkL5xw6yyPiElOYywwqFjZ/Cnk+lFm6PvIRI12NLVwGYaBxbk/4YILcODeO8cQBxAfwDJxfWttoSpgFcM6KpX1CQ6c3Ptl6ij8Rv+0xZnCzL1cheGn7hPhytVNpankg1tpbpEH6Jlr039sYm+VaXEZ4g8YaUrwuY8vtL5wWEuZg8eSXdFNx8mGh/A5do+Dt0v7U6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH3PR11MB8095.namprd11.prod.outlook.com (2603:10b6:610:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 03:20:50 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e9c0:eeac:5553:aba5]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e9c0:eeac:5553:aba5%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 03:20:50 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC:     "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cao, Bingbu" <bingbu.cao@intel.com>
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlZhLdN6VSZkmXifw5lc/5F67MNbKA
Date:   Mon, 13 Feb 2023 03:20:50 +0000
Message-ID: <b6555f44430286416c66e2ecd7ff4f4b2bd3642e.camel@intel.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
In-Reply-To: <20230213022347.2480307-1-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH3PR11MB8095:EE_
x-ms-office365-filtering-correlation-id: 75b032f1-7a79-4699-5d3e-08db0d714ead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jLdLSVn4tQD+/4/h/gQp8aryNNIJNInnScoyHu0MeYo4aip1bG9r7pFX3r2Z04gd6pRnSgn7EDpaLCcBSfKJ5Ae0xinnC7QdfSLqlsITkkDvZWmpemYb+4jd+VMQD88asFJ1CD1pP1VFxqQAKVS7L10E5wZE0qcHkHQp3UGi0W/TaCQvffrTuOmnzYKC+7I5A7nT4+eIQr0Pv+dMABa7oTKQCUemq6fotYaVqLf3+EXN37qZWCHS3rwPg3t9nTIiwfAdPca4+wYrHWPmWFbU+6zgt5C8u3jNCU8bYSDSYPrxzwx2Xa0aZGgeqiIhtFYX9eUJy5392JuM047Jv+St/u2dl0URYdGGE4174gnbKSY/K8dZBSRUJRefRLqF2i2DSBALf14me2cs+UWuZN9oZVfq3kb0TT7yaXrKKWqGtzSn90D0BWt+zs7mUT3RZnbAfd2ctKEFDrZh/opT2Y5j6eSmY+ZiXCR54rA+webzw8F+MqoSHuYwgPAqNpp7k/uDMEA4WUZ8seaXYGwAA1k+YyhZIXAPkUQCX3n8uVptx/ZsGh6oSWEyW7PzEd2tUe/DDBpsNS/qn1KV5dhaQu7xjWnEgqpyo0uYQTnPxcVw0AEVLCFqV0qc14nJQ39t3N/qeP2VNjeWmIP2+B42kUYRTqPR+YUsFv5J4nRvk3fnNMm7jM0nlZgp6mktnP2hbGKB6W5s2mb8JUrIgXdrwNp9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199018)(8676002)(71200400001)(8936002)(38100700002)(2616005)(2906002)(36756003)(5660300002)(86362001)(122000001)(186003)(110136005)(54906003)(41300700001)(6506007)(6512007)(478600001)(82960400001)(6486002)(316002)(66899018)(66476007)(66946007)(4326008)(76116006)(66556008)(64756008)(66446008)(91956017)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkhjeFA1SVBJT3M3YlB5YmI4SkxtdlFqU0Y2RUhnek0wd0NGNE9LemtycFBV?=
 =?utf-8?B?K0FoaEliZFRpTUkwNjBqZUQzWEQxaGNEeHRkV0JYeVdoZkJpSE9OaWxNSlpL?=
 =?utf-8?B?YWJub1N0bkl2RVpRRFJyc0ZkbEpMcEV0TEliOS90aFZ1Tk9MSUs4eHN6UzlT?=
 =?utf-8?B?a1dJUS81U2JMRTF6ZW91ZmdIOG9RemovcmRYZHp0M1ZLZjk1WHhJUEUrRGdR?=
 =?utf-8?B?bFVRWnVWckdGaERvN2V5ZXZDcytxSEZOSDR6dHdpY3pJbXA2N2puMzlwcWcw?=
 =?utf-8?B?eXY3S2FSRnVCWTV6RzlnaTk4ZG0yVjNGSWswQ0dORXN2R0JtdzByK2tVRmpo?=
 =?utf-8?B?S0l3YStFRFo0aVpnQ0RKSVBIbEJTS0cvaUV6WEhSUlMyNUFYbGoyMmkrQUdz?=
 =?utf-8?B?L3lqSzRpYWo3MXFkcE5GOWFlUkVPU3RQSVZza2lGY3lybEI1d1lQdTFkUU1Y?=
 =?utf-8?B?Ym16R3M0MkJsMUZDY3E2ekx4L2NSdWx3QWtTTFgvellxRFhhTWk1ZUtZdGFM?=
 =?utf-8?B?UzJFUEozU0xtTGoycDlWV2dtYVVNTTBmdko5a2NqRGhGVEM4SUFjL1ZETWRL?=
 =?utf-8?B?cHZkSkZ3Z2N1N3BjejgzcEJXdVNYbWJJNmFnWThtTmNxLzRPR3dxSlZTZFRs?=
 =?utf-8?B?dmZYbGllVElxTzEzbXd0RDBSNExHczBmemt3UTdGSVAyMjJpT09NZEtKWTA5?=
 =?utf-8?B?QWE2a2xkdTFsY0pkQ0FTTXpVM2VxSzZobXQvSzZmNmZuRGNkUTNaWG00NlMw?=
 =?utf-8?B?a2hGM0Z2UCttZTNSeW9QUDRhWjVpRnNBbnVFQThIMTEvSkJGblJRcjUydTFV?=
 =?utf-8?B?MXhZczBUaTRjQk5aQ3QzQVNkWlZsaXlCaWp3azBQQVJIdFZOd3RFRy9PNzBn?=
 =?utf-8?B?R09kdklrUHRkRUREVXpvcVpVSk5FYTI0dmJJeHlqVkhpQk5jNTM3dW5JYitQ?=
 =?utf-8?B?NitIaGdiTVYvSXFoUDBUTStUMk9TdnM5WDljUVZkWFdtdHRBS0lNUGU4WWp1?=
 =?utf-8?B?R1A2UTlCWCtFc2J0Uko3WU42M0tHWFpLbG0xZ2w2UDBmc3dXYklPbkRjQUFm?=
 =?utf-8?B?Vk1NTk8yNHhvMFNrUG5pWU1lQUw1bXlJVFVPVEk1SlVKZmhYbHNKN1YyK2NC?=
 =?utf-8?B?bWlWR0NNYnJSYVhYSWo2Ly8xc2ZWak9DQ1NCWUtsYnV0NkJqaFNRajdFQ1lL?=
 =?utf-8?B?YWNuaXZQaXJwME9ibEQyYW0rbjg0S3FKbXUxRlZHQVU3M3I0VVVkcTZnUHpN?=
 =?utf-8?B?cWp6OXNjd3JsYzF1MllNZ3RPUTN5b2VRNXg4a21LVHN3bWNOSWsvMGpiSHNl?=
 =?utf-8?B?Tk5McUxpQkVVN0N4RlcvWDZBbm1WQ2Q2cmJyOHdNNGxGTkpMcDF5TWJ6bWhs?=
 =?utf-8?B?eUpMZHRvTXk1QkJXNHhVL1dUOTNRcUlWY29YSU43Q0htWXhNNHNFdG1UV080?=
 =?utf-8?B?dzdyVXNrNE9xclZiWmNoUVVPWU1hQzd6ckNYY1hrRHgrbFNMaDR1em9pb1or?=
 =?utf-8?B?aHRKTFVHWFZkdWJJbVB5QzN6T2s4WUxmVHA2ck9raG1iSnVHMXIrS0VmRUh6?=
 =?utf-8?B?N3Q1SGVFa2Q0UVRTQUdzRVErSnAvbWpQN3c4RVpEOWJmZi9YeFpZbEl4SHhP?=
 =?utf-8?B?NDF2QnpWbzdPcmc0MDdOcEV2MWhUUVFNZ09qOWR6a2RpSkZoQThWZnl5S2V6?=
 =?utf-8?B?SHU5bThsSTFTZUIzVnJYZ0ZHVkhHOW1qdDRKdVBYUnNyRWZueVBnUnNPWDFX?=
 =?utf-8?B?WlErYlB4TVFESDJUTkZ2OFRCVXZqWjBrampRZU5YM2ZTRkI4TWxGdGpVaVdM?=
 =?utf-8?B?NXVOTmt2WUswYllXZ1JPdHhRTkZXajdIbWljNWV2TTVrakZsTG1FNWdRb3Fx?=
 =?utf-8?B?cEY3b2lqLy8rNmRhVGNWNFd3U0QxcGUxb0oyTDN1OGFPTUhPYzdwczdlSHF0?=
 =?utf-8?B?Q3NJejhHaVZna043Vk9jSWhRaWVmdnRNb3VUT2ZpRWFVVVVhSWphWW4rci9v?=
 =?utf-8?B?bUxhTEN4M0ZCNHFOb3RrdHVTQ2J3QnZXNHFHclJXRk1KTk5VbUYvVHBzSnI4?=
 =?utf-8?B?YXNCaGt6UnZyY3ovOXFzSVFDck5ZQ2I0YUZ2RG1HbXZEZDZYSk9YWkJnbG1o?=
 =?utf-8?B?Y2FYb3NDT2srdDV6NHBwTEZyUm5ESmlZemRJRThBSzVzZXJJV3c2WG9iSzBy?=
 =?utf-8?B?SHNhblc5OVJnWDF2ZHplUmN3aFZVOGo5UHIxYlQ1Wjh2ZkFOMjJhMDlwM0R5?=
 =?utf-8?Q?pJeFTwMMQBFuD0Gi9d4/jWLe3WhFo5nOx0Veyvg3RU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5575A0C4BB0F439AE53E616311E001@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b032f1-7a79-4699-5d3e-08db0d714ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 03:20:50.5026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtKdPNVy8CqXK3ipP9H31YFqein3KJxyTAAl+7g3fsavDtIWmygMSe9wIvNvvBNphoCFFmMIqBLn3V0Sz1J+9rb/xOWdv3oKgT5UlSsOuA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDEwOjIzICswODAwLCBXZW50b25nIFd1IHdyb3RlOgo+IAoK
djIgd2l0aG91dCBjaGFuZ2UgbG9nLCB3aHk/Cgo+IEludGVsIFZpc3VhbCBTZW5zaW5nIENvbnRy
b2xsZXIgKElWU0MpLCBjb2RlbmFtZWQgIkNsb3ZlciBGYWxscyIsIGlzCj4gYQo+IGNvbXBhbmlv
biBjaGlwIGRlc2lnbmVkIHRvIHByb3ZpZGUgc2VjdXJlIGFuZCBsb3cgcG93ZXIgdmlzaW9uCj4g
Y2FwYWJpbGl0eQo+IHRvIElBIHBsYXRmb3Jtcy4gSVZTQyBpcyBhdmFpbGFibGUgaW4gZXhpc3Rp
bmcgY29tbWVyY2lhbCBwbGF0Zm9ybXMKPiBmcm9tCj4gbXVsdGlwbGUgT0VNcy4KPiAKPiBUaGUg
cHJpbWFyeSB1c2UgY2FzZSBvZiBJVlNDIGlzIHRvIGJyaW5nIGluIGNvbnRleHQgYXdhcmVuZXNz
LiBJVlNDCj4gaW50ZXJmYWNlcyBkaXJlY3RseSB3aXRoIHRoZSBwbGF0Zm9ybSBtYWluIGNhbWVy
YSBzZW5zb3IgdmlhIGEgQ1NJLTIKPiBsaW5rCj4gYW5kIHByb2Nlc3NlcyB0aGUgaW1hZ2UgZGF0
YSB3aXRoIHRoZSBlbWJlZGRlZCBBSSBlbmdpbmUuIFRoZQo+IGRldGVjdGVkCj4gZXZlbnRzIGFy
ZSBzZW50IG92ZXIgSTJDIHRvIElTSCAoSW50ZWwgU2Vuc29yIEh1YikgZm9yIGFkZGl0aW9uYWwK
PiBkYXRhCj4gZnVzaW9uIGZyb20gbXVsdGlwbGUgc2Vuc29ycy4gVGhlIGZ1c2lvbiByZXN1bHRz
IGFyZSB1c2VkIHRvCj4gaW1wbGVtZW50Cj4gYWR2YW5jZWQgdXNlIGNhc2VzIGxpa2U6Cj4gwqAt
IEZhY2UgZGV0ZWN0aW9uIHRvIHVubG9jayBzY3JlZW4KPiDCoC0gRGV0ZWN0IHVzZXIgcHJlc2Vu
Y2UgdG8gbWFuYWdlIGJhY2tsaWdodCBzZXR0aW5nIG9yIHdha2luZyB1cAo+IHN5c3RlbQo+IAo+
IFNpbmNlIHRoZSBJbWFnZSBQcm9jZXNzaW5nIFVuaXQoSVBVKSB1c2VkIG9uIHRoZSBob3N0IHBy
b2Nlc3NvciBuZWVkcwo+IHRvCj4gY29uZmlndXJlIHRoZSBDU0ktMiBsaW5rIGluIG5vcm1hbCBj
YW1lcmEgdXNhZ2VzLCB0aGUgQ1NJLTIgbGluayBhbmQKPiBjYW1lcmEgc2Vuc29yIGNhbiBvbmx5
IGJlIHVzZWQgaW4gbXV0dWFsbHktZXhjbHVzaXZlIHdheXMgYnkgaG9zdCBJUFUKPiBhbmQKPiBJ
VlNDLiBCeSBkZWZhdWx0IHRoZSBJVlNDIG93bnMgdGhlIENTSS0yIGxpbmsgYW5kIGNhbWVyYSBz
ZW5zb3IuIFRoZQo+IElQVQo+IGRyaXZlciBjYW4gdGFrZSBvd25lcnNoaXAgb2YgdGhlIENTSS0y
IGxpbmsgYW5kIGNhbWVyYSBzZW5zb3IgdXNpbmcKPiBpbnRlcmZhY2VzIHByb3ZpZGVkIGJ5IHRo
aXMgSVZTQyBkcml2ZXIuCj4gCj4gU3dpdGNoaW5nIG93bmVyc2hpcCByZXF1aXJlcyBhbiBpbnRl
cmZhY2Ugd2l0aCB0d28gZGlmZmVyZW50IGhhcmR3YXJlCj4gbW9kdWxlcyBpbnNpZGUgSVZTQy4g
VGhlIHNvZnR3YXJlIGludGVyZmFjZSB0byB0aGVzZSBtb2R1bGVzIGlzIHZpYQo+IEludGVsCj4g
TUVJIChUaGUgSW50ZWwgTWFuYWdlbWVudCBFbmdpbmUpIGNvbW1hbmRzLiBUaGVzZSB0d28gaGFy
ZHdhcmUKPiBtb2R1bGVzCj4gaGF2ZSB0d28gZGlmZmVyZW50IE1FSSBVVUlEcyB0byBlbnVtZXJh
dGUuIFRoZXNlIGhhcmR3YXJlIG1vZHVsZXMKPiBhcmU6Cj4gwqAtIEFDRSAoQWxnb3JpdGhtIENv
bnRleHQgRW5naW5lKTogVGhpcyBtb2R1bGUgaXMgZm9yIGFsZ29yaXRobQo+IGNvbXB1dGluZwo+
IHdoZW4gSVZTQyBvd25zIGNhbWVyYSBzZW5zb3IuIEFsc28gQUNFIG1vZHVsZSBjb250cm9scyBj
YW1lcmEKPiBzZW5zb3Incwo+IG93bmVyc2hpcC4gVGhpcyBoYXJkd2FyZSBtb2R1bGUgaXMgdXNl
ZCB0byBzZXQgb3duZXJzaGlwIG9mIGNhbWVyYQo+IHNlbnNvci4KPiDCoC0gQ1NJIChDYW1lcmEg
U2VyaWFsIEludGVyZmFjZSk6IFRoaXMgbW9kdWxlIGlzIHVzZWQgdG8gcm91dGUgY2FtZXJhCj4g
c2Vuc29yIGRhdGEgZWl0aGVyIHRvIElWU0Mgb3IgdG8gaG9zdCBmb3IgSVBVIGRyaXZlciBhbmQg
YXBwbGljYXRpb24uCj4gCj4gSVZTQyBhbHNvIHByb3ZpZGVzIGEgcHJpdmFjeSBtb2RlLiBXaGVu
IHByaXZhY3kgbW9kZSBpcyB0dXJuZWQgb24sCj4gY2FtZXJhIHNlbnNvciBjYW4ndCBiZSB1c2Vk
LiBUaGlzIG1lYW5zIHRoYXQgYm90aCBBQ0UgYW5kIGhvc3QgSVBVCj4gY2FuJ3QKPiBnZXQgaW1h
Z2UgZGF0YS4gQW5kIHdoZW4gdGhpcyBtb2RlIGlzIHR1cm5lZCBvbiwgaG9zdCBJUFUgZHJpdmVy
IGlzCj4gaW5mb3JtZWQgdmlhIGEgcmVnaXN0ZXJlZCBjYWxsYmFjaywgc28gdGhhdCB1c2VyIGNh
biBiZSBub3RpZmllZC4KPiAKPiBJbiBzdW1tYXJ5LCB0byBhY3F1aXJlIG93bmVyc2hpcCBvZiBj
YW1lcmEgYnkgSVBVIGRyaXZlciwgZmlyc3QgQUNFCj4gbW9kdWxlIG5lZWRzIHRvIGJlIGluZm9y
bWVkIG9mIG93bmVyc2hpcCBhbmQgdGhlbiB0byBzZXR1cCBNSVBJIENTSS0yCj4gbGluayBmb3Ig
dGhlIGNhbWVyYSBzZW5zb3IgYW5kIElQVS4KPiAKPiBJbXBsZW1lbnRhdGlvbjoKPiBUaGVyZSBh
cmUgdHdvIGRpZmZlcmVudCBkcml2ZXJzIHRvIGhhbmRsZSBBQ0UgYW5kIENTSSBoYXJkd2FyZQo+
IG1vZHVsZXMKPiBpbnNpZGUgSVZTQy4KPiDCoC0gbWVpX2NzaTogTUVJIGNsaWVudCBkcml2ZXIg
dG8gc2VuZCBjb21tYW5kcyBhbmQgcmVjZWl2ZQo+IG5vdGlmaWNhdGlvbnMKPiBmcm9tIENTSSBt
b2R1bGUuCj4gwqAtIG1laV9hY2U6IE1FSSBjbGllbnQgZHJpdmVyIHRvIHNlbmQgY29tbWFuZHMg
YW5kIGdldCBzdGF0dXMgZnJvbQo+IEFDRQo+IG1vZHVsZS4KPiBJbnRlcmZhY2UgaXMgZXhwb3Nl
ZCB2aWEgaXZzYy5oIHRvIGFjcXVpcmUgYW5kIHJlbGVhc2UgY2FtZXJhIHNlbnNvcgo+IGFuZAo+
IENTSS0yIGxpbmsuCj4gCj4gQmVsb3cgZGlhZ3JhbSBzaG93cyBjb25uZWN0aW9ucyBvZiBJVlND
L0lTSC9JUFUvQ2FtZXJhIHNlbnNvci4KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAtLS0tLS0tLQo+ID4gSG9z
dAo+ID4gUHJvY2Vzc29ywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgIHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiDC
oMKgwqDCoMKgwqAgfAo+ID4gwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tLS0tLcKgwqDCoMKgwqDC
oCAtLS0tLS0tLS0tLS0tLS0tLcKgwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tCj4gPiAtLcKgwqDC
oMKgIHwKPiA+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IHwgSTJDIHwKPiA+IMKgwqDCoMKgwqAgfMKgwqDCoMKg
wqAgSVBVwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgIElTSMKgwqDCoMKgwqAg
fMKgwqDCoMKgwqDCoCB8Y2FtZXJhCj4gPiBkcml2ZXJ8LS18wqAgfAo+ID4gwqDCoMKgwqDCoCB8
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+
ID4gfMKgIHzCoCB8Cj4gPiDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0tLS0twqDCoMKgwqDCoMKg
IC0tLS0tLS0tLS0tLS0tLS0twqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0KPiA+IC0twqAgfMKg
IHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gPiB8wqDCoMKgwqDCoMKgwqDCoCB8wqAgfAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0KPiA+IC0twqAgfMKg
IHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiB8wqAgfMKgIHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IElWU0MgZHJpdmVyCj4gPiB8wqAgfMKgIHwK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgCj4gPiB8wqAgfMKgIHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tCj4gPiAtLcKgIHzCoCB8Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+ID4gfMKgwqDCoMKgwqDCoMKgwqAgfMKgIHwKPiAtLS0tLS0tLS0tLS0tLS0tfC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0KPiAtLS0tfC0t
LQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IENTScKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IEkyQ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAKPiB8U1BJwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gfMKgwqDCoMKgwqDCoMKgwqAgfAo+IC0t
LS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLcKg
wqDCoMKgwqAKPiB8wqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiBJVlNDwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgCj4gPiB8wqDCoMKgwqDCoMKgwqDCoCB8
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoAo+ID4gfMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4gwqDCoMKgwqDCoCAtLS0tLS0tLS0t
LS0tLS0tLcKgwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tLS0tLcKgwqDCoMKgwqDCoCB8wqDCoMKg
wqDCoAo+ID4gfMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAKPiA+IHzCoMKgwqDCoMKgwqDCoMKgIHwKPiA+
IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAgQ1NJwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKg
wqDCoMKgIEFDRcKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoCB8LS0tLS0tCj4gPiB8wqDCoMKgwqDC
oMKgwqDCoCB8Cj4gPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoAo+
ID4gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiDCoMKgwqDCoMKgIC0tLS0t
LS0tLS0tLS0tLS0twqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0tLS0twqDCoMKgwqDCoMKgCj4g
PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IEkyQ8KgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwKPiAtLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0t
LS0tLS0tLS0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IENTScKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiBJMkPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoMKgwqAgY2FtZXJhIHNlbnNvcsKgwqDCoMKgwqDCoMKgIHwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gLS0tLXwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gCj4gV2Vu
dG9uZyBXdSAoMyk6Cj4gwqAgbWVkaWE6IHBjaTogaW50ZWw6IGl2c2M6IEFkZCBDU0kgc3VibW9k
dWxlCj4gwqAgbWVkaWE6IHBjaTogaW50ZWw6IGl2c2M6IEFkZCBBQ0Ugc3VibW9kdWxlCj4gwqAg
bWVkaWE6IHBjaTogaW50ZWw6IGl2c2M6IEFkZCBhY3F1aXJlL3JlbGVhc2UgQVBJIGZvciBpdnNj
Cj4gCj4gwqBkcml2ZXJzL21lZGlhL3BjaS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgMSArCj4gwqBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9NYWtlZmlsZcKgwqDCoMKg
wqDCoCB8wqDCoCAyICsKPiDCoGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvS2NvbmZpZ8Kg
wqAgfMKgIDEyICsKPiDCoGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvTWFrZWZpbGXCoCB8
wqDCoCA3ICsKPiDCoGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvaXZzYy5jwqDCoMKgIHzC
oCA4NCArKysrKwo+IMKgZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9tZWlfYWNlLmMgfCA0
NzIKPiArKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqBkcml2ZXJzL21lZGlhL3BjaS9pbnRl
bC9pdnNjL21laV9hY2UuaCB8wqAgMzYgKysKPiDCoGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2
c2MvbWVpX2NzaS5jIHwgMzQyICsrKysrKysrKysrKysrKysrKwo+IMKgZHJpdmVycy9tZWRpYS9w
Y2kvaW50ZWwvaXZzYy9tZWlfY3NpLmggfMKgIDYwICsrKysKPiDCoGluY2x1ZGUvbGludXgvaXZz
Yy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA3NCArKysrCj4gwqAx
MCBmaWxlcyBjaGFuZ2VkLCAxMDkwIGluc2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL0tjb25maWcKPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL01ha2VmaWxlCj4gwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9pdnNjLmMKPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL21laV9hY2UuYwo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvbWVpX2FjZS5oCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9tZWlfY3Np
LmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL21l
aV9jc2kuaAo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvaXZzYy5oCj4gCgo=
