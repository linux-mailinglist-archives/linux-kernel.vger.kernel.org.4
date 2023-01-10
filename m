Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A2664818
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjAJSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjAJSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:04:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B03C38C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673373721; x=1704909721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=faCa74eAKnXhw1sFByR+Y4Ljj4mE/8zY090Rg2MgZ3c=;
  b=P7HEeQZS8nb+2keLW77nD9nBoe9rHfQtEeT4Vkc0NkCgclDuM2h12AVw
   9byfBdHyCRLGa9mREoBIKPeCC8EiMOQn3ufbZK72R4o0A7BLCHf9WaPcg
   Xz26WYILqJAOcdJZt7SC066+BhSJw7rju/yk+l8KF1y/pW0+1oSsNFXDc
   lLJwn5nkhW8LvynQTSnFLRQfWsE/ZG0jhNJWYAged7LIvc62+YQW6j83h
   I9EgmB9G3RymtjQ2yW8rWagzuJIhk3ZMPg/SwMRaXxXeGn7lCaC7uR/zz
   KXuktp8EY5xNQqcnpm7gHgIchkNnAGfUcF06vN80PjypMAK84dpIV2FJY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="302916557"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="302916557"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 10:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="764837822"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="764837822"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2023 10:01:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 10:01:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 10:01:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 10:01:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZFp0LMIc0Po8CDtZXGabTRQH1Fi/yTSo+3hFtYE9cqU/LAdI0NjRnhoTZWGdtcS1NUkTmpuKEH6hSFWA5sNlg1T01y0bw5jqVD3o4lK7JxTEt9BTH1TDZrpQk2KCQ1XFaZAIpsi0AY3s8lfBmLH7ehbYCJbURPkft4vPfZfw+z8ICFyR7xGJshJIM+QWMLF2pkGv/IMaGUOLxcmCSBoppqEZWNKp9ilx2xv3tQzD96kN/byM77KBpanQNmAO17tiiaVEtAtzcxEEekJH7cGOuVqdps7Y6K9wvD7gq/RFfdpQi8v7J7FnWoF55aUcVvDMwVZJFJ3B2fjBLR+DPquKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faCa74eAKnXhw1sFByR+Y4Ljj4mE/8zY090Rg2MgZ3c=;
 b=WHEx8RGqkrnY9FbYFXeXJXKgzY6wxZkoshiobUeHhaYi2WPXAvl5z87J1qrIoWISDT+ALhlvaLpant7en+eQ2+rc78NS1tHeIY6wV4ukZ/92k+OOCB/GkSHOKET4TiU8eh+UTe3HZ2tA99ForjWWFInzJHwykxeR8cYFriNBo85XfPvR04dmxm8BHjU0k2/M9jAk1N7PXBm9B2iADX3CZqFMHmWzrtzkT8YE67MPAdIlJXWbf7pp84RgQon7/++hkvgpjG8yNuBNsTD9gjVfpM1dQtcRhL0jxhcDM6h3Iwb/UVKRKmv6tNbcBkeXlfimu4ibI/Cs7vGeQ5v3Fez1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 18:01:49 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 18:01:49 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
Thread-Topic: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
Thread-Index: AQHY5U7NN1fP90vsN0CwPOACtvugOK6RJhiQgAdJQYCAAACKIA==
Date:   Tue, 10 Jan 2023 18:01:49 +0000
Message-ID: <IA1PR11MB6097F30C481A74FE9305EEA29BFF9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-2-james.morse@arm.com>
 <IA1PR11MB609724963D5C6086A98AC0479BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <54d14a9f-5983-0a33-9340-c0ff48cc9757@arm.com>
In-Reply-To: <54d14a9f-5983-0a33-9340-c0ff48cc9757@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: a3516a17-11e5-4a60-dfd3-08daf334bec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4o41VgctASxSRVFFQE6sk/z1xg+9I04vASyiXaXAn1wKqia9gAB6y9VTRF18Bv21A2y8lw0IREHQuiWuomxryCZK+Xfmz8vSMC9o8BAzFEXqMhwE4YxjFnyAFCIsnDVQlY5xyS8+NYypaoBhZ330dJpxOfrl2YQ2e3XKP1555qtaj8kmOdEWu0VGOGwYzu4CNQ3Sjgt+NXh3V75rzQpHWtqqVV9XXvBAXrVZu9FrPwVqmW9qcOl7L6/PG18u0rqipU94FON+PoZ9AmBhxtZMyZ7dCYKtVOmYCRPDgUp+0a+4ltuqpKeRmdg/N7oh3yKXt4WaCnz90Ggn6/HbECjJSUypQ4qqevqN9i8C6jhTYLBEhiSYyeIoM5mw2kQBzDBX4SVcBvVFeeKzrknnCIcUlxVljg/ostaeUolEUcuIda1JBEZfF1BZf0sSmfqeHj/WORLYrXhNpG2erUmwduTK58WK6eiu5ArZV3Z/DLx3GJaAP7sAiMqCQ8sgN6lzy7aWxK0wQei1LlxaJzquuL1bVXiXTmBtYxm/wFGboM3+IgUCCmT9CZujcydCSAxe6YDVw6AqJv77zhwIeHUXAd5H8tfkSNlw4xJRXitmoKhzUTjy6+MLekw16nFNDc6GeCbhvvtC2RsRe8mOUtbx81RrQ2TpQSS/p/evQ7vJ8gyRA8mapTpuGv4k6TR/KDqn8qcaGxhGoxBsZ1sspeMuT4xcAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(33656002)(6506007)(478600001)(4326008)(55016003)(26005)(186003)(9686003)(64756008)(66556008)(316002)(76116006)(66446008)(8676002)(66476007)(71200400001)(110136005)(54906003)(7696005)(86362001)(122000001)(38070700005)(38100700002)(82960400001)(83380400001)(41300700001)(52536014)(66946007)(7416002)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVNiSlVoYmlWQWsrWFR2WjVNclNxeGpKRkZGb3YrQjY1QVhZMXRDdVBJSWpN?=
 =?utf-8?B?R1JpM01Balc3RWFJVkZ4QU1CZGU3YVBvRW1ZMmZ4d3ZhRzVHNEFtUHRHdTJJ?=
 =?utf-8?B?NGhqdW5WZEJRNCtPUzFJS1BaUjRmYWt4Sys0MXNFQzRueGp3cFI0aWVNeVlh?=
 =?utf-8?B?Q250YmNkRk9wY2pVUjBYUUZISUtlb2tjTEs0YW5DbnpBRmNUT0djU2Fscjh1?=
 =?utf-8?B?Y1RLTDM0WlAwcThMTVdqMFJqUHhMcGY0OEZoOUlMUXQ4dVNjY2tzMVpndy9U?=
 =?utf-8?B?d0xVR2RhNTY4L3ZsS3IyTmRuSkd5MFN2UGJaUUh0NkVTdlFST29VTEtxWWpI?=
 =?utf-8?B?T0VTN3RYdmUvcFJVNk9Taml6dEVldzhreFFLMVpUT2NqS0VOZW9vWWdvcm1m?=
 =?utf-8?B?SVVlZVVyckNFL3dncVBQdmlqaTJpcFJrV0d4eEdYekVqVGRkMzJFTXVSN1RC?=
 =?utf-8?B?bjBFWkFvd1pJSGczVnVwa2xkVFozWEhhS3NiMzBvTGtTRk5HMzgzWmlmNXhL?=
 =?utf-8?B?RHBxVEFrdEZRVWFGMzJxZHg4ZzQ5T3JQQWkyUUxVMmNiVEs4TUVlTkpwYkMz?=
 =?utf-8?B?bG1BT1Nab2xEUndxdVFiS0EzWTBpeXBwT0tKWHdiVXJYQ0VyeXY4U3ZzL1N5?=
 =?utf-8?B?V3FxTFAxQjZsVXVYQVFJd3E0c3hIdFhOUDE3bkFScDRIdU0xQXFVTlZYQThO?=
 =?utf-8?B?V0RENGo0WnUyU3B1cFRPeWNweSszN2pSbWN0UzYvdjI4b0pLVGI4dmUvaXN3?=
 =?utf-8?B?eWY4Sk1CL09ESzR5cGM1eUxIcFdpMmpUVnNJY3ZJV05lUEdOeEZzRUxVN1FV?=
 =?utf-8?B?eW1HVnJRUG1BTTFmOVZ5RkovanJRTHh0YzYzNzcreW1YMW5GNVV5aGx6Rkdr?=
 =?utf-8?B?RkRObWxHV1ZUdnRJR0FVcHk2d2Ewdk1rRW1qQjJEeFk5Mjg0U0J1d0ttbjZ4?=
 =?utf-8?B?ME1ZbEYvR1VRREdSVWpBdXhHZ2x1Um5sR2wya3pzWm1DQWg4WFUzbHRLMVZM?=
 =?utf-8?B?U0x2bDlrc0hIVVhKZ0pyNjVzNnJDWDM0QnpWSnpIQzhac1FtNmI5NUFPUGha?=
 =?utf-8?B?RFkyYlV1M0JDSE4wYjI1OWhFeW9XZmtyakFZVWxVN1dBKzVlY29VdkdaVjdK?=
 =?utf-8?B?R3dmWFNMNW5tR3dlOHBEQjBVUEFQOENPbHprcWwvcmJOQ09wYm50c1l6eDVC?=
 =?utf-8?B?YVcvY2Z4bVo2dU94emxKUlk2LzFEVXZoTU1reWRweUpPamdRSWpCRDV1WG5O?=
 =?utf-8?B?TEdldVlTejUyWGJYRXJDVDh3cjRVdytsMHlRWVVuNGYxd2VrcDF1dzFCTFdj?=
 =?utf-8?B?bEZydHZWTGNRRDNtWFdaQ0NJVWJkR0tjREFYMjJmVStZSTR2cmdSVzJHeDZU?=
 =?utf-8?B?WW1Mb3VpMGw1ZkhDM0xabXF1d3lyaGVvbCtadHQ5U0traXBRaXFVZnF1cVJs?=
 =?utf-8?B?M200cldzd2pKUGpxbzk3REtqTndvSEVkcWRWb3l0ZjdNVTBvMkV6OFI5Nk9k?=
 =?utf-8?B?WlpoeFZsUjdpTDhzbkhyUGI2blhzeUo1U05zQkh0L0QxL2ErVEVkMUVId2JX?=
 =?utf-8?B?cmFQajFVZENYT3RCRGI3VjBlbWdXOUpkVktqZnI4T1BZaitGejBHRDRJdXJk?=
 =?utf-8?B?c01yTi9ZdENiQkNhS3Z3anpoTXlQeTJrN3NSMVpDVFpKaFgxQTBEZ3lHTjVo?=
 =?utf-8?B?dmt1Ulc4RzJ3UExiNTA1NmgyckF1ZnBHRmwxOXNFTGJXOXVTQ1BqZTFJWlc0?=
 =?utf-8?B?K2lLbGUzMm04ZGh6dms0cDIwcFBZTEQvWUxMWEtwM3pVck4yRzI4L0FqVmVy?=
 =?utf-8?B?cFlzY2Urczh4dlZhZ0Zha0hIUjlzZlZDOG1CUG9RaUZVT2tqcFZoay9xYS9Q?=
 =?utf-8?B?UmszcmJYUExPblZ2TGZQZFpKQk14L3l1eWF0NjZwZ1hNajRzajNRNU45SldW?=
 =?utf-8?B?SUI0UlVsRTdmeUZQbUhyc2xNeWtiZXBFdHBKTHh3Y3ljK3htalV2aEJCaEo3?=
 =?utf-8?B?SUxOMHRDWkVsSzIrbG9hR2xIVzR5VG1pRjNnTHF0bzBramFpanZPcndMY0pR?=
 =?utf-8?B?Rkh5R3ROZlpnYXlINnNiU1ducUk4NVVDMndoMG5JNzdCZGNOWENQTGNSMjBm?=
 =?utf-8?Q?86iu6HtvKFJse0eqCtk+ZpR+g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3516a17-11e5-4a60-dfd3-08daf334bec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 18:01:49.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxYD9twLYmzS6q6kYZdFCTtj4eKhFeV3GlBMHkdhMoWY/1GuZi3dYQLbouw/0oUj4EuOR31RHzn7Lk1VZmi66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphbWVzLA0KDQo+ID4+IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL21vbml0b3Iu
Yw0KPiA+PiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gPj4gaW5k
ZXggZWZlMGMzMGQzYTEyLi5mMWY2NmM5OTQyYTUgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gPj4gKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9yZXNjdHJsL21vbml0b3IuYw0KPiA+PiBAQCAtMjUsNiArMjUsNyBAQA0KPiA+PiAgI2lu
Y2x1ZGUgImludGVybmFsLmgiDQo+ID4+DQo+ID4+ICBzdHJ1Y3Qgcm1pZF9lbnRyeSB7DQo+ID4+
ICsJdTMyCQkJCWNsb3NpZDsNCj4gPg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgYWRkIGEgY29tbWVu
dCBmb3IgdGhpcyBjbG9zaWQgZmllbGQ/IEl0J3MgZXhwZWN0ZWQgdG8gYmUgZm9ybQ0KPiB4ODYg
Uk1JRCBlbnRyeS4NCj4gPiBTbyBpdCdzIGRlc2VydmVkIGEgY29tbWVudCB0byBleHBsYWluIGEg
Yml0IG1vcmUgb24gdGhpcyBmaWVsZC4NCj4gDQo+IFN1cmUgLi4uIHdoYXQgZG9lcyBpdCBuZWVk
IHRvIGNvbnZleT8NCj4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4gYnkgImV4cGVjdGVkIHRv
IGJlIGZvcm0geDg2IFJNSUQgZW50cnkiLg0KDQpNeSB0eXBvLCBzaG91bGQgYmUgIm5vdCBleHBl
Y3RlZCIuDQoNCj4gDQo+IE15IG1lZGl1bSB2ZXJib3NpdHkgdmVyc2lvbiBsb29rcyBsaWtlIHRo
aXM6DQo+IHwgICAgICAgIC8qDQo+IHwgICAgICAgICAqIFNvbWUgYXJjaGl0ZWN0dXJlcydzIHJl
c2N0cmxfYXJjaF9ybWlkX3JlYWQoKSBuZWVkcyB0aGUgQ0xPU0lEIHZhbHVlDQo+IHwgICAgICAg
ICAqIGluIG9yZGVyIHRvIGFjY2VzcyB0aGUgY29ycmVjdCBtb25pdG9yLiBUaGlzIGZpZWxkIHBy
b3ZpZGVzIHRoZQ0KPiB8ICAgICAgICAgKiB2YWx1ZSB0byBsaXN0IHdhbGtlcnMgbGlrZSBfX2No
ZWNrX2xpbWJvKCkuIE9uIHg4NiB0aGlzIGlzIGlnbm9yZWQuDQo+IHwgICAgICAgICAqLw0KPiAN
Cj4gDQo+IERvZXMgdGhpcyBjb3ZlciBpdD8NCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KVGhhbmtz
Lg0KDQotRmVuZ2h1YQ0K
