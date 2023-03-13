Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A406B7DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjCMQi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCMQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D133447;
        Mon, 13 Mar 2023 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678725507; x=1710261507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VSaStMWe6qRqAoHoESgRtTBf+HOzvY/W1I679tHfQDM=;
  b=UjMzhOaYTAYIdEusqalVD+w5Mjwb/3AN4tRzytvKGCaOgzs4zfmojQgH
   swXMDftuxvEfexybfPEJJA8cmpx9ax5r4aWLVh+mAkGUkXtEVdksQT8jL
   4yZ2CD1HksMRqRWZ5hc4gkKqZv+xAZnVZtwkxtZK4TV2Mu0wY1kiY+vas
   Y8/3QbX+E4fYKZKvTpY+CENFH+xna+IGBR+OwoXHCpmGUuisjgdPSauRZ
   NN/6DXLycR2HCt1inRukbqROH3/E0GK15OzzM51aI/btuDpfqfjBoCcV9
   7iTN3VEWT1qnhm8bGYmn92mGOy9bu60XIk4ZPIrKviKU+Jv0WHWr7cRjc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325559948"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325559948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 09:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678768043"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="678768043"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2023 09:38:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:38:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 09:38:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 09:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpShTDjOWHfOn2xLndiHCzp+5B9WdxJeIqMs0Uj4QNqBjw1QCaM+ivSMWK7Ua2LVdRbTfTqWm1PE/hROiF/JjIO6q4lXvK8GFmZwfl5xi+Eth5NozSb7RIh9FKhfwkLvgscCfu8AfVQD41jWExeomuOPETcLFs8XLMJez7gj0gJze4/1XgYiWDlLE6JAo0se5j/+u7hEp+mL9AJ/Uw2O9s6OocIN4A0NQn4nxTh2RST+rnUvgjk0g7QBnb4rUq7D9xS4d63IhuG+DA1GKkQ4wWxh6RT3BGRY/KEwMv/sBI+HLkP3PcIkFsDlVnNHm7hs77IOz/Mz0YCB/2L6xOC6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSaStMWe6qRqAoHoESgRtTBf+HOzvY/W1I679tHfQDM=;
 b=dI3Ww99owDqXlGZlBYhVzcAFQcH18OGvexN4a9pH5JEXEFeK/o+/NAgK3izcl8ZARaOfbP0aeHiOflAxkg5D37ecCJA5ismAMRGx1E+ElszspqlUQyHyRaPG8pnyS0kvFX+RWAyvhXT9HKd+vB7ufe5bh9kTQnNLqSNoxaSWmEkDbvp99YbIzUCwUUoNOtiS8FNRbp7ffPwxJ7a5G7shlDn3s2WTBSLkT3SjlYBGyrgXwN2FhG4CUzByJ+iZ8u8cQGc22+GZalsuBVVsGjb4p4YJktfajv/e8OSEYBgInYH9leESb76WpKzGcPyJopBcvlX6baBwTWgmTfEfD8wZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 16:38:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:38:15 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled
 and initialize.
Thread-Topic: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZMbXnUEoONz5h40uCChzoDDCRa67i++8AgBGMxwCABC2sgIAAeAmQ
Date:   Mon, 13 Mar 2023 16:38:15 +0000
Message-ID: <SJ1PR11MB6083AC52EBEDC2C0DEC40147FCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-8-tony.luck@intel.com>
 <CALPaoCgnOWLdEqKtonNeq+d_Fj0yr3Y7tgwwmAHmuhL5xBhqyg@mail.gmail.com>
 <ZAtpTl+um3nbCOz8@agluck-desk3.sc.intel.com>
 <CALPaoCiQMxgjusRzQMWhKJHtB2CYVOp3UaXpwPYYpO4VC+0KzQ@mail.gmail.com>
In-Reply-To: <CALPaoCiQMxgjusRzQMWhKJHtB2CYVOp3UaXpwPYYpO4VC+0KzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: eb03ebc0-5bff-4b2e-accc-08db23e157d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rt4vNvZj4nfEZBEYVtxYNFdvb8p/zpfw40LgoGOVZh8W/Eedsz8zSpAaVaXgpz5koAVRpzxJhPDDo5Z2NU3vs3fpqY9dW2SiqR69golGXKJ7LJSgLwEjpE7Vz4WvvnuVqFPTEQvGe8VOIkUakdOfcGyXrkI1gI14s/TxxzYN6xnL6J6pPVN46shP2nGvNJbV3dfI+NltsTRY0JcdLllzuASEY+ojtl3s+K+JxdHHIBkg7bpZcp0JJ9n7MFHa+gSrZqwq7wUIBvtsJ+4Jbjwa598/H9Mdn0jB4n+8X7iGDJa8RQ70lwZI3fB4ohpTv5+rBswIz3uD4lkPfITkx4PHxB/1PVKzDN2I/YBuIZbA3PXBmS7XXqYPbArYYpN4FF70gqsB/1h/zKplBpRBeZHw6j6V+bdDFY8ckU46Twss2IQN92t9oTPafAyP2uV54943iGgEqVAWYbQSOOSbC6v4ftLawrHjE4pD1bC3Te940eaQ+faQcdGoQ0aBoW9szrKrTu/YoGgvWY8vFunk6STqw/62BulAS3F+eB61zBhAklq+XA4oRbGgJ7andGDpcC2ySsUPyy3Dj/osnYB8mrpUJDw1KWq/9olQ4Wcs1rMZNBLS8PiWRZNj2YuOo8PyQWaWn6wN3YbyVIyY8mVORwNkYEO9Iik6qEQ71aVQIZIr9F9IHQn7A0s7sSA5aBQSg3ircDXFw2hU+H57WKxVtJ0Wmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199018)(2906002)(82960400001)(122000001)(83380400001)(4744005)(7416002)(5660300002)(55016003)(76116006)(66446008)(66556008)(52536014)(64756008)(186003)(41300700001)(6916009)(4326008)(66476007)(8936002)(33656002)(66946007)(8676002)(38070700005)(38100700002)(54906003)(86362001)(316002)(478600001)(9686003)(7696005)(71200400001)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmJpdVp6TWdiN2lML3BwTzVzdWxUNUxueFIxS2FjeGxjSWZCVXJoTGgxcHBD?=
 =?utf-8?B?bjNvbjRwenhhMW9iWXJWc01xTy9ud00xeXdzK0h1VjRzY3JBaTlGWC9mQzBZ?=
 =?utf-8?B?eFg4aWNlNXVVUkJQZWtPYURiKytQbFBiYWVxQU9VdTdQekt6NUp0cFVTM2V4?=
 =?utf-8?B?OEJabjJlYUxwVEdzVCtCeTR0dGtJdnNTREJXQ1daaWc1bVpORG1VdTl2R0ov?=
 =?utf-8?B?cVNFMEhJbTJVekZwa3hGMTBBSEtRSVZ0N0JFVjZkUmwvVWxaeHUxcnNDazdi?=
 =?utf-8?B?KzZoMExtM3F3dFNIaUZsNHJPOE9GUllTSW1HOWNqelNyUDFMU2lNNU85UVJE?=
 =?utf-8?B?R3V0V3V6SUM1anJnRkNwYVFPZlRZbVQ5SE1zSW9vSFR3YmdGU0hieXZua0lo?=
 =?utf-8?B?azR4aW5RUzJiTlRiemllSkZ6K0JUczlYaytIaVZaQWNMQzkwYzJlWndiR2No?=
 =?utf-8?B?THVFSGFZaUVabGozd05mcHR2OGI4VzlRQXpWT1VxbzJzdWtzSnhBc2s2K3JZ?=
 =?utf-8?B?SDVrdld2VjhHN3M1eE9FSHVHWkZ4cURESy96QlZiZGlSQ1c4UEx1eEswRXEx?=
 =?utf-8?B?L0NYVTFZL291anZ2TkVKek9tRUNBWlNTNk9lUWFMUXJOa0QwcklaU3RvcFRu?=
 =?utf-8?B?UzNtckRlYytZQ041OWQ0Y3U4QjZxdmRGL1BlSE1QNkxMVEtkOGZlUXlFUHd4?=
 =?utf-8?B?Zk5WNEIyakJIdGFPNlRhYmI4dGRXL2xwTVdXQ21UMzlJa1NDMUltdHNBc0JZ?=
 =?utf-8?B?OU1hc1FRdjJWSnptYVZQc0FGVlpiZVhwVk0zUTBKRi93R24raGZyZ0lVV1Zl?=
 =?utf-8?B?b0VwMXNKTjJidjg2dEZlVlQvRFAxeDN0ajJTTWVqQWdtUmVGdWpKdENKbUtt?=
 =?utf-8?B?bDM4Lyszc3RuS3QrKzM0WXlnSDdscVdpTEJBRTk2Yk92cEx4WnRjYjRaa3Uy?=
 =?utf-8?B?MkRkV3puMFkvOGxHTWlGZ0Y0OFZkY2VjcVVPUEZkVzgwUGpwc2RmNkNwdVhB?=
 =?utf-8?B?YmM3UnZYTVk0anJGeFBVeSs2dTR1QmVDNCt5NTF3bW81MDZpRk1KVXdMMm82?=
 =?utf-8?B?MXk4czRrbWduR0g5WHFWbzE4NVhlSDVYamIzWGdwWUxseVpaekNJbzVrQU45?=
 =?utf-8?B?SmdUN29KS1VTSUgzRGdDU3F4ZStaTTUvMVJXQUZMNmM0dHhJTjc2NU8rdk9X?=
 =?utf-8?B?WS96Nk54TWlUM2NCNGtRY2lkWFpncHNWZkR2cytZUXREZThwS0NoTndkTVBU?=
 =?utf-8?B?VlRQN3FQcUdNLzNCVG1pa3FJajZwTUExZElDVXBwUXBwQVNWTy8xVTF2L3Rs?=
 =?utf-8?B?Nzl6czZYSXE1U2tzcHlqWjJ2UkN2TnJxOExlTmlHdTcvVkVEYkQ5YjRvbmQ2?=
 =?utf-8?B?cWZBTm1MVVNOTENRVE84K3RPaHVEeG8vbmV0Q3hXdXJrSUc2aWlHaDhKOUNC?=
 =?utf-8?B?Y3N3L0N1QXhETGk3NVNvZlZDY3pFblVFUWVHV0ZuYzByUTh2Mk1rMCsrRkVB?=
 =?utf-8?B?SG10NlJ0Q3R0WVBFYy9YQytxTFBPV2FyK3B2eTBkMlF5NWxmblE5Vm9PWmty?=
 =?utf-8?B?Mm05YzY4SmIvSGpQN2RWTVdiVDdHRmhjeHZUQ2Q5elJDUFdiSDBjREpVQnpR?=
 =?utf-8?B?NGJINDlJVjQ3VVJVZTBlOExMN1d4c0Y1RG0yWFExOGFQYjNhNUFSeG8wWGJ6?=
 =?utf-8?B?eFArc0tsUkExMWFYdnAzdzNqSlZHck9wTjg3VDNtL2NpK3psNmRQU0pOa05E?=
 =?utf-8?B?SWhYNnRzZ25pZ2ROdkQ0aXlESjRLMHMwWHpWZS9mMkswbzNyNkszV2EySTlP?=
 =?utf-8?B?TzNaUGcwS3JzVWFSNW9SR0wvSXowbEFaOHVEYkFHZElmeGdjeWlOR1M3eGZN?=
 =?utf-8?B?eXFTYUJobzl5NHNad3lBOTZIRndzSzNLQlVybVNaTWV5akxCK05RNGFpRk15?=
 =?utf-8?B?dk94NHozUVNRdFowZCtlM1hydW0vKzVKeUNMMitzN3dlYUtRa3ZlNzNmYytz?=
 =?utf-8?B?ODZvVWNvMlhBQm42TDZXYkxSSVJMY256MWY3Qzcwa1M4OEJRclN1OU04d2Q5?=
 =?utf-8?B?dklWL21jRDh0WWFNTHhOQVFoc2NYWE9OTWp6S2FGRlVGQUNoMFRaTVFmNTg0?=
 =?utf-8?Q?9NVk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb03ebc0-5bff-4b2e-accc-08db23e157d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 16:38:15.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+qL85CTq7jRp4ygYnNYQM7V+ogaSS3dNqOpa/lYv5QdTl1sUzPbChzlBqDg4Cpo4S2QcwMrmVc5MlQs3FjwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
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

PiBJbiB0aGUgY2FzZSBJIHNhdywgdGhlIG5vZGVzIHdlcmUgQUVQIERJTU1zLCBzbyBhbGwtbWVt
b3J5IG5vZGVzLg0KDQpQZXRlciwNCg0KVGhhbmtzLiBUaGlzIGhlbHBzIGEgbG90Lg0KDQpPay4g
SSB3aWxsIGFkZCBjb2RlIHRvIGNvdW50IHRoZSBudW1iZXIgb2YgbWVtb3J5IG9ubHkgbm9kZXMg
YW5kIHN1YnRyYWN0DQp0aGF0IGZyb20gdGhlIG51bWVyYXRvciBvZiAibm9kZXMgLyBMMy1jYWNo
ZXMiLg0KDQpJJ2xsIGlnbm9yZSB0aGUgd2VpcmQgY2FzZSBvZiBhIG1lbW9yeS1vbmx5IFNOQyBu
b2RlIHdoZW4gb3RoZXIgU05DDQpub2RlcyBvbiB0aGUgc2FtZSBzb2NrZXQgZG8gaGF2ZSBDUFVz
IHVudGlsIHN1Y2ggdGltZSBhcyBzb21lb25lDQpjb252aW5jZXMgbWUgdGhhdCB0aGVyZSBpcyBh
IHJlYWwtd29ybGQgcmVhc29uIHRvIGVuYWJsZSBTTkMgYW5kIHRoZW4NCmRpc2FibGUgdGhlIENQ
VXMgaW4gb25lIG5vZGUuIEl0IHdvdWxkIHNlZW0gbXVjaCBiZXR0ZXIgdG8ga2VlcCBTTkMNCnR1
cm5lZCBvZmYgc28gdGhhdCB0aGUgcmVtYWluaW5nIENQVXMgb24gdGhlIHNvY2tldCBnZXQgYWNj
ZXNzIHRvIGFsbA0Kb2YgdGhlIEwzLg0KDQotVG9ueQ0K
