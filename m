Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02008613F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJaVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJaVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:09:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A8413F07;
        Mon, 31 Oct 2022 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667250544; x=1698786544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mOSOfcbkTgFP6jiMvtfyPWKsl2KcbkKLJrYHEhDMtuM=;
  b=SjyTZpukiR4npwFzLkm3QdccYzQJNwPEeKfw6NNHIUxOSxxEZJPRHcjG
   xYR+QcUvIeLp5O4KmdNrVH4xcaKccMYJlBg+XoQF/YxonWls2g978zD5C
   WB4Ynf3YyiPtn82udFVwyK76ASkOwECvxgKMM6HIo0YABf+81i/LiPSaR
   H7c7G6UTaRJEB3T/vwwsiql7aSDAPyVUm133Hy8pX97kD4zh9BhXEhJvQ
   2a5MUkpRZcAuzhszeuZXGGwbRyP09/T2xhTwjs3lMrLiMtSo2hTqfiX1q
   1yOZ8txXS1nMmAskHXMmeWlfTrCVAwhUNI0reCTpuWY4xE+fFcUqv/XQf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296420278"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="296420278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="962912929"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="962912929"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2022 14:09:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 14:09:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 14:09:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 14:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0MWVNzHniifTBChJkRuXcT97g8ObdDmnwkhw0iqcOVfTZcoBOL5YJyW8+bUV38ltU8Qci+b3U+Z5PePqToS1hsEs6/hLin98uzjlBWEYrtwZgMi0QnsVZ00x9ChUhoDkbMqBNWYLpmtg/C/zjtim3E+xQj2Jqda+Z3FXs+ETxDsG4XuEA9x38iapx/xxYzlZoHilmAAkf4psr815h65clBjYQScP7+wRS3EN7r+eW7aqAIkclLxOWA5ZQyuhkwWy+RyPbcf6LlXT3JelzxryrTIaxTNzfY/cMobnvgVC+RenZKdkna4cGY2HU7ltD0ZppB0Ueu02aYfi0XO198lTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOSOfcbkTgFP6jiMvtfyPWKsl2KcbkKLJrYHEhDMtuM=;
 b=ZvKRi2B70chk4xoqfgif4d43a1OkmGZ//4y4ZB+tFGdim8gQ7zJBpoFoDt4hN5cAOE6g3tJmjpw2nWlPIsgjeduZwAtpoxba+nyFrBcywrmBMvCeSvOg4OjUHNgQBAGHWDLny7zNWJuvMBScGrS9uQI5/+h86yJe+1ExJUktwWLKov8RmRpI6haiyZZ7ROpBE9SwDZPI+ZB/PyOsILnIEkDIWjUPoQMDrbZfchvyfadjOTsdooXOXXnVdq1NGQwn792R7w5ZcbQsAwba+WZ0G6ADe03hfstQyngS8LVmet7p2DJo+Tzdu68pX1vh8T2aW2I2Hrdi4APBsqqykV0Kbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 21:08:56 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::18de:143c:207d:57fa]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::18de:143c:207d:57fa%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 21:08:55 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: "Bluetooth: hci0: HCI_REQ-0xfcf0" errors in dmesg
Thread-Topic: "Bluetooth: hci0: HCI_REQ-0xfcf0" errors in dmesg
Thread-Index: AQHY7WQUAstiqVDT206qOLonwYpy8K4o9koAgAAI5AA=
Date:   Mon, 31 Oct 2022 21:08:55 +0000
Message-ID: <beb8dcdc3aee4c5c833aa382f35995f17e7961a1.camel@intel.com>
References: <aac93511-d5e5-7a1b-6b1c-65e008ce068e@o2.pl>
         <CABBYNZKXYaRT_N9YTHX2aKRBRVHhORejT=+LJNvrJgL2QYjSLA@mail.gmail.com>
In-Reply-To: <CABBYNZKXYaRT_N9YTHX2aKRBRVHhORejT=+LJNvrJgL2QYjSLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|DM4PR11MB6216:EE_
x-ms-office365-filtering-correlation-id: 1c7511d7-e557-4959-6f26-08dabb841f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBnidVlcB2QKrsWnduL/BHwPpca//kFDADfm+sjhpx3+lpkQewIxp3Suk6/3090mLFUw1g/mqC/BhCBCc94WM0wwMSiFoHsaRRbZkyJ00hzJYgKMFWUBcalLm+A8XIjnz6lwH86wkEBPOVsN7onjm9PvD0+XmgoUChA7t1fZ7ZG1/PkWQPph3oFHsN0DaGLhf/gvwMmiBtOE3W2r3T7CqZ9PzOb6Ks8/qA8/zCetwjQATAkuZV81t9pGMgcfQHJjk+QSE0JxNUvanEckCt63DMKThJrAlytS5zgGRct2w4psD5jr0dYw3dytJ0hyOBRXSgLxWwCUxmXWcygCZN1FN+docaHTy77gps28/vJVakz4qPmdrMkgXO0xHZdIMhpUSK49UHX+6VIjJtNJYDt4iYlRq+1zouLD2T7TU94w6N3UInYwXTvLCUvJwQF6b3kJq62+/l+osMI9yQs2dA1cNEfL0Yo2GYIzh0RYkqf1ZqWiQEqV2GnBFc6q37//+H+SyNKF5RSDEAVBHTZwlrpyadFIk3zV1M0UP+MO+0EMiC1AJVa1P60fUWIU/x5FNMlcfk1aPnoBZudiIOcVZW0VYTNYnYHseSDRtv+FCQcEdBK129VJte0LqWd0BvDdk8Q0Mde5C3+9PnOa6RilJvVr3M3M9eZQJU4YdsMBfy6vczb/7BITnsAiDw7Ic3WF/SX2fIqIn25QjPZYkI9T1RmMdtoZxXyyKzzzhGnVoWe6evWcoWNlB0L6T3Fw4BHHGs8E1boKqB50w0PR6CkM53oqHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(66574015)(83380400001)(6486002)(71200400001)(2906002)(4001150100001)(36756003)(122000001)(86362001)(38070700005)(82960400001)(38100700002)(6512007)(26005)(53546011)(91956017)(2616005)(186003)(5660300002)(66556008)(66446008)(76116006)(8676002)(66946007)(316002)(64756008)(66476007)(110136005)(4326008)(6506007)(8936002)(41300700001)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXJUam1wMGloYnlUazVWTDNMR3lURitpdmlSaW9IU254TFFLd2ZJQ2dtdktu?=
 =?utf-8?B?UnJ0emJnOVBQb05mblg3SER0NkZWMElGWElhdVE2b0hVajlNNWszbDJEVC90?=
 =?utf-8?B?YnFvaUpOSXdsdWxFdVNXTmVQWmJjcWQ5LzdqL3VlZDBwQlg0UzNSd29sUEFY?=
 =?utf-8?B?ME5uTXBHV3JCSTFHTEsrUUQ3WEdLQ3MvUE5KZ3JTQzRkSk1xbGJDTzZ5UlBG?=
 =?utf-8?B?Vk82NC9wVEhpTkFQMC8wZXZGKzZJY0JEemZZZUFFK3NTZDBzc0d3aFljWnZO?=
 =?utf-8?B?U21MOGJFZ2V4ZEZEREFITld2NnF5YVRQaWtvMVpuTUZiUWZBZzVzdTNxQU52?=
 =?utf-8?B?UTMxaERTYkdoMWdobVRYVXJDZlQzVXJ1YnRqQWJjQ3ovWWZTbnMzQlFvclZP?=
 =?utf-8?B?UC9WeW9pNUUyWXkwVHg1YktqMW5lV1FJWW1XUlMzbVdNRUVZQSs2ZW9PbE5X?=
 =?utf-8?B?Z0JveUxTWFlCTnBNZTdoVU1IZVkvNTVsdEI0N2M5WGFiSnZTRktFaXdmRnRI?=
 =?utf-8?B?SXdGZG9jbCs5V2JUS2QrZDR6Z1F0TGY5Unc2T0l4R1Rwenk0dlFOTE9leUJ0?=
 =?utf-8?B?Z3FkdkdOTEVyQ2x3aHE2N29MKzZSOWlFZ09GSnlpUEQ0L3NyR2dxNnFnc1Bo?=
 =?utf-8?B?dEhpUE8zemtRbUZNNFZFM0ZpYStWZUtVVkxIdkNSZ1VXR2tqTVAzWWlyWndJ?=
 =?utf-8?B?T1lRTFNuU0ZlK3V2ZFNzTW1KaWZzNWJaNitrWFg0RjA1Ymx3dmVOdmpVZUk5?=
 =?utf-8?B?RGhHeWx6dDJBdXNkUURHOWxURUMwa2Q4TThheVozVWFjdjc5eWl3OWZtL2VO?=
 =?utf-8?B?MCt4STV6c1o5N1NZWlF3b3FSajQva2Q2eGd1Wk8zWEhtb2tiaWZCSXdFdUNu?=
 =?utf-8?B?TTFsM2RKZVU5NU1SQmpTT3AxNWlHM2RsTGJmZ2xPdlMxRzB0cDBvVGU2WnJa?=
 =?utf-8?B?NFIzOTlHdFFlZzM4ZjhsODR4MDJteUF5NWtJMlBZOGQ1T0dlOTF1bThFMUd1?=
 =?utf-8?B?a0tpZnlXdUN3RU1pVWg5WktSTWtPZGNBam91UUhwV3EwdHVUUC9xM1ZmOWRC?=
 =?utf-8?B?Q3Q2R2pZdGR2WnMrQ280VzR0Zk5XRmk5ZnhWR0JUSE9mQXJHbjdGb1kzK2hH?=
 =?utf-8?B?T2JHK0xVVUhiQ1hZaE5jSWNkcWl6cUZYaDFKdW9NSFprZHdQTldqaE9kTEpD?=
 =?utf-8?B?VmV5OUtDYjhEbWRxUXZRUFNQQTF3YktKejV4MHdQc3RNU01EcHAzaUF1OFBq?=
 =?utf-8?B?b2dCM1hzeEhtdlNnTVRjVTB3UXVnNWdTSndtUFFFTHRmUjY5cXlDdGZlM1pR?=
 =?utf-8?B?aXNITnJxUDRRWmhRNThmbzVZMi94MlBWVmNFWGQzNS9VZEsvQ0xlSWUvK1ds?=
 =?utf-8?B?L2hkSmtiRUdwWkUrc0FsTm9Ja0g3cEUvNnhPaEVmd054ekh4K1BSYVhzYW9v?=
 =?utf-8?B?RnUxVy91UVdtU1NqazZNdjNtZUNIR1U3eFRRSUUzNmFSMGtmbklBc1ZuUTh0?=
 =?utf-8?B?cUl2UUNDbXJ5WHZ3eVlHcUF6YmVEL3Ira0FJckh0NkczQ2NwZ2NjZ0k5by92?=
 =?utf-8?B?V0FNbWJrTGF3NXhhZXVLQXJSMTFrU0VVMmsrZG5TalVXM0YySnN0aTdObitk?=
 =?utf-8?B?Y3pwVUhLOTV2Ky85R2trVThzZWNjR2I5ei84bnc1c0RMWUVwTXM4emxyQTlk?=
 =?utf-8?B?R3RkQUVMTXBSMHdpeWF0ejFzYVFlNndRNGtoeXZkcnBZQ1FOaWo2K1NrakJT?=
 =?utf-8?B?c081L2tvKzEwUk9Tdm12M0xvdDRxcUhReUJRN1BOK09sT1ZnQXp3Y2xjL2E0?=
 =?utf-8?B?SDExb2FLREpiV2gwUExBb2dmYjZoZm5ZK0phcnl6UEswNnM2cExSQTdpQ1Bp?=
 =?utf-8?B?N0hEbVFWZHFDWmxQT000cGxwTXRkZndETXRxdzhFU3YrYWF3cC9lUm1CMEdE?=
 =?utf-8?B?VXlNZVNJc3N6bk9ya3FzM1g5OGw1azJEZkx3Tk04dFFLcU1EemU5RU9FVm5m?=
 =?utf-8?B?Z0Fyd2wyYlJtZlVXRUQ5b21qcmRXSThjRHZSQ0pRVzVRUENyaG4ydFNjeExt?=
 =?utf-8?B?am5zNys1MENKRDZ1dE1mUjgveW5hc1duS0dlcVFXdWdzaW8rSm9CbUhYclVW?=
 =?utf-8?Q?FdPKZXffMHe8pCt1P3mdmDlWG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462B99A4651F95458601EE0E636CCEC7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7511d7-e557-4959-6f26-08dabb841f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 21:08:55.8552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04RiGlcEb6jTejdAjOpz7G45ECgM4SxpUll8w9xMP3gdwe55igJ214ydm0mttBDlofdH5EhkjRi1XW3wJNRjaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDEzOjM3IC0wNzAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBPbiBNb24sIE9jdCAzMSwgMjAyMiBhdCAxOjE1IFBNIE1hdGV1c3ogSm/FhGN6
eWsgPG1hdC5qb25jenlrQG8yLnBsPg0KPiB3cm90ZToNCj4gPiANCj4gPiBPbiA2LjEuMC1yYzMs
IEkgaGF2ZSBiZWVuIHNlZWluZyB0aGlzIGVycm9yIG1lc3NhZ2UgaW4gZG1lc2c6DQo+ID4gDQo+
ID4gwqDCoMKgwqDCoMKgwqAgQmx1ZXRvb3RoOiBoY2kwOiBIQ0lfUkVRLTB4ZmNmMA0KPiA+IA0K
PiA+IEl0IGlzIHByaW50ZWQgb24gZXZlcnkgYm9vdCwgcmVzdW1lIGZyb20gc3VzcGVuZCBhbmQg
cmZraWxsIHVuYmxvY2sNCj4gPiBvZiB0aGUgQmx1ZXRvb3RoIGRldmljZS4NCj4gPiBUaGUgZGV2
aWNlIHNlZW1zIHRvIGJlIGZ1bmN0aW9uaW5nIG5vcm1hbGx5IHRob3VnaCAoYnV0IEkgaGF2ZSBk
b25lDQo+ID4gbGltaXRlZCB0ZXN0aW5nIG9ubHkpLg0KPiA+IA0KPiA+IEFmdGVyIHNvbWUgaW52
ZXN0aWdhdGlvbiwgaXQgdHVybmVkIG91dCB0byBiZSBjYXVzZWQgYnkNCj4gPiDCoMKgwqDCoMKg
wqDCoCBjb21taXQgZGQ1MGE4NjRmZmFlICgiQmx1ZXRvb3RoOiBEZWxldGUgdW5yZWZlcmVuY2Vk
DQo+ID4gaGNpX3JlcXVlc3QgY29kZSIpDQo+ID4gd2hpY2ggbW9kaWZpZWQgaGNpX3JlcV9hZGQo
KSBpbiBuZXQvYmx1ZXRvb3RoL2hjaV9yZXF1ZXN0LmMgdG8NCj4gPiBhbHdheXMgcHJpbnQgYW4g
ZXJyb3IgbWVzc2FnZQ0KPiA+IHdoZW4gdGhhdCBmdW5jdGlvbiBpcyBleGVjdXRlZC4NCj4gPiAN
Cj4gPiBJIGhhdmUgYWRkZWQgZHVtcF9zdGFjaygpIHRvIGhjaV9yZXFfYWRkKCkgYW5kIGdvdCB0
aGUgZm9sbG93aW5nDQo+ID4gYmFja3RyYWNlczoNCj4gPiANCj4gPiBPbiBib290Og0KPiA+IA0K
PiA+IFvCoMKgIDE4LjQ4Nzc2Nl0gQmx1ZXRvb3RoOiBoY2kwOiBSVEw6IGZ3IHZlcnNpb24gMHhh
YjZiNzA1Yw0KPiA+IFvCoMKgIDE4LjU0ODk1MV0gQmx1ZXRvb3RoOiBoY2kwOiBIQ0lfUkVRLTB4
ZmNmMA0KPiA+IFvCoMKgIDE4LjU0ODk2MV0gQ1BVOiAzIFBJRDogMTA4IENvbW06IGt3b3JrZXIv
dTk6MCBOb3QgdGFpbnRlZA0KPiA+IDYuMS4wLXJjM3VuaWY0LTAwMDAxLWdiMzNhMDk0OGU5MzIg
Izg2DQo+ID4gDQouLi4NCj4gPiBvbiByZmtpbGwgdW5ibG9jazoNCj4gPiANCj4gPiBbIDE2NzEu
MDQwOTcwXSBCbHVldG9vdGg6IGhjaTA6IEhDSV9SRVEtMHhmY2YwDQo+ID4gWyAxNjcxLjA0MDk5
Ml0gQ1BVOiAzIFBJRDogNTAwNiBDb21tOiBrd29ya2VyL3U5OjIgTm90IHRhaW50ZWQNCi4uLiAN
Cj4gPiBNeSBoYXJkd2FyZTogSFAgbGFwdG9wIDE3LWJ5MDAwMW53LCBkZXZpY2UgaXMgYSBSZWFs
dGVrIGNvbWJvIGNhcmQ6DQo+ID4gDQo+ID4gIlJlYWx0ZWsgUlRMODgyMkJFIDgwMi4xMSBhYyAy
w5cyIFdpRmkgKyBCbHVldG9vdGggNC4yIENvbWJvIEFkYXB0ZXINCj4gPiAoTVUtTUlNTyBzdXBw
b3J0ZWQpIg0KPiA+IA0KPiA+IEkgYW0gcmVhZHkgdG8gcHJvdmlkZSBhZGRpdGlvbmFsIGluZm9y
bWF0aW9uIGFuZCB0ZXN0aW5nLCBpZiBuZWVkDQo+ID4gYmUuDQo+IA0KPiBAR2l4LCBCcmlhbiBD
YW4geW91IGdpdmUgYSBsb29rLCB3ZSBzaG91bGQgcHJvYmFibHkgY29udmVydCB0aGUNCj4gbXNm
dF9zZXRfZmlsdGVyX2VuYWJsZSB0byB1c2UgdGhlIGNtZF9zeW5jIGluc3RlYWQuDQoNClRoaXMs
IEkgc3VzcGVjdCwgd2lsbCBiZSBhbiBvbmdvaW5nIGlzc3VlLCBwYXJ0aWN1bGFyaWx5IHdpdGgg
VmVuZGVyDQpPcGNvZGVzLCB3aGljaCB3ZSBkb24ndCBoYXZlIG11Y2ggZGlyZWN0IHZpc2FiaWxp
dHkgYW5kIHRlc3RpbmcNCmNhcGFiaWxpdGllcy4gIFRoZSBlcnJvciBnZXRzIGxvZ2dlZCBiZWNh
dXNlIGl0IGlzIHVzaW5nIGEgZGVwcmVjYXRlZA0KKGJ1dCBzdGlsbCB3b3JraW5nKSBtZWNoYW5p
c20gdG8gaXNzdWUgSENJIG9wY29kZXMuDQoNCklmIEkgY2FuIGdldCB0aGUgc291cmNlIGNvZGUg
cGF0aCBvZiB0aGUgY2FsbCBhcyBpdCBpcyBiZWluZw0KY29udHJ1Y3RlZCwgSSBjYW4gdHJ5IG1h
a2luZyB5b3UgYSBwYXRjaCBNYXRldXN6Li4uICBCdXQgeW91IHdpbGwNCnByb2JhYmx5IG5lZWQg
dG8gZG8gdGhlIHRlc3RpbmcvdmVyaWZpY2F0aW9uIGZvciBtZS4NCg0KDQo+IA0KPiA+IEdyZWV0
aW5ncywNCj4gPiANCj4gPiBNYXRldXN6IEpvxYRjenlrDQoNCi0tQnJpYW4NCg==
