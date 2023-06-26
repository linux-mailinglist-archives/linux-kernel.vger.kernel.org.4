Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24B73DFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFZMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFZMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:52:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805FE10E7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687783900; x=1719319900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=12QfDdzSPxSWAhvrCmeGFLSXY4xfUun/8UxfSqoby/g=;
  b=iAnXL2Z1ktFSjmQiGStfCkdazvd1FONc644NBtF4TeS7DF+F/j7hSLG0
   F8lOZPyZ4qKCsxN2/F6tp36ayRPALYUKfaiEc1Moas1fW3C1MhJIg/ktg
   h96/zaXo3R6/hPclhK4WSCSQLcRITUM292wysgaz+T7F6wZqRF2ekTdBx
   GuVj/byWuCAxPe4cV0ftjtEsiGoIIJg4W/fE+luk7dEfwFQxy3BFUhMYF
   rsPQIRxv7cDfvUIqLpBNTA//9icpUwoQEV/M6pxFw+5c7E1VOoxCnomI/
   9alS5hvs+ggAwExgCMVxEelBS6oAVK0NxOPFcOcxpefFsycmLyQkLkp1p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="346009115"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="346009115"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 05:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840264107"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="840264107"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 05:51:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 05:51:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 05:51:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 05:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA0fFgbIU/upQ9TOGaWZ20Np2sMX0VwK4Pq4G6OjCbCx5rJRuQrOwbca+oMtJX1VUnS+8RJ6Gvwak9e65tosD/yJqVJUwEeQYEPmgeBgkOwmi3K0pnFr5+q6ARZNECVFLAxV4en4dEBU9ol0Ls5XbVUkPbR8rFjbzp4rFfmAzrRaXOlFQhuwVrX9+9yBjtnqlBJ95lM+wQGRM40n27IxUQaDDT28s+ro+V152WmszEUXlRyJ60JnBCfw2Ws8jedBoBhbnGPlga01SvyAOLJM5hko2ONcMJunpHB3bZIAy+fej5YiJYptFQB6/Qi9YwtU8HDX+SnBvvXiifP+AeFw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12QfDdzSPxSWAhvrCmeGFLSXY4xfUun/8UxfSqoby/g=;
 b=IOLcdgzKjzEM2FCR8oC7o1w+vAC7QBILfu11w3ykqTd/IMkEICjMLGa0pzVDXXZz6VhVB+Gmr9ddSAHAc9+M6Pa85RMGyEdNvHk2Rdz+0jKGMDZlyn9kscWMl+JE3OSuVw6lkYp1JAYW2U/T3I6OGtO8SIAypKDMdUxTreo0Ny351weFIN/WOuRlzyDI0++26ekCWiAgobg9cKTmW0rpAUKhGDyNZup0YztfIT5WBeYn2WCZ6qc4litMeWghK765a6Zd9QlI4654DPGMwNzjJaWHJ7TaEUIDSGx9rfzfkQ2RPq8q7xXA6msfzdOSaZkEFk2v8bNHDPkqm8NnNtZLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) by
 MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Mon, 26 Jun 2023 12:51:22 +0000
Received: from DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::9aea:5d4e:5008:a155]) by DM6PR11MB3260.namprd11.prod.outlook.com
 ([fe80::9aea:5d4e:5008:a155%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:51:21 +0000
From:   "Deng, Pan" <pan.deng@intel.com>
To:     "Lu, Aaron" <aaron.lu@intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Tianyou" <tianyou.li@intel.com>, "Ma, Yu" <yu.ma@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Topic: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Thread-Index: AQHZpBf8y9gtMyr/606YJQEIlMf8Fa+cm1MAgABzSgA=
Date:   Mon, 26 Jun 2023 12:51:21 +0000
Message-ID: <DM6PR11MB326003DBEF9C00FAA44B12B19626A@DM6PR11MB3260.namprd11.prod.outlook.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
In-Reply-To: <20230626054756.GA435374@ziqianlu-dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3260:EE_|MW3PR11MB4570:EE_
x-ms-office365-filtering-correlation-id: 6f509506-7a64-4edf-46cb-08db76440ae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/4kSIEl4AsUvpn3PmxttOn7NqbJUmFLb2+/ds3bVBPrWzQFWq+nCjBkn67fOxYTPzI8fZX4Cd+Hdas5bUhQv1P+BUCMU3ExBPhsPNU2kue0RriUTnCOhwN86EpYccoKF/vu9jGxAJS0gaomkQMB2VdLLJXX9BziT60mhIJ+K+ZNFNlK3u47UEw3Pcn50NiDndf45EJSoeOJAs4zsYsZpAQ9Nk6t/xXHkDSFWffgT67/i26JTwnwhxKk00YW4jhkBHRj3KjnEC8CbauJJ6+iIsEhcbnxo/8+F86bpuxUgDLLqGOVcyUauUHzxHY4IxK0XPURgjX0sS52UmonIg5XI0G/W4Sg1XRJo+J8lkFn2PdSx2JQjMQAbIwPCotTwg92PhYYv3ANko34dXfy358k8HVlefithXEeLcgdTnhMFqTLHfFb4zHLkJVnOnGG0Cv3tuKBfELvEWqry3b74J/77MPw+z4YPPTbCwhDPcyRCJxQZ/wC6zB/cu8OsbLk8iP0MSJJt/FTUvXRHkPs9RQJ7hEDRTLv2zf5m4WqRODbKnwBIAgNaAy9z/jzSytZtOC+5nbtzGZqqzeGer6+rGW9XseCaMA5sk8MW6kLYCEmte0KcryG/UCA0ofchSmt0IeZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(2906002)(7696005)(82960400001)(38100700002)(122000001)(83380400001)(6506007)(26005)(9686003)(53546011)(186003)(71200400001)(55016003)(86362001)(41300700001)(54906003)(38070700005)(478600001)(66556008)(66476007)(66446008)(64756008)(6636002)(33656002)(76116006)(66946007)(4326008)(316002)(8936002)(8676002)(52536014)(6862004)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjFXME9OSVpnQWQ1WFMxcWRlQ2k4MTg4enp1SlQvZWZTVGhubDBZQkp6WHUv?=
 =?utf-8?B?N3Nva3hldXlQeEVYUTRYVDBlNkJlelBwN1doWjZaeDhSQkl5U1B5OUFyYUxD?=
 =?utf-8?B?VFd1SmJCejU0K3lzdkxpbXlVd3RQOTkzbys3NWlRemRPQ1Vzc0NZOWVRV3pv?=
 =?utf-8?B?dUh6YUVqUmZwc3JPSSsrZ1JjY3NvNGNzSHRzRXM2cUlIekpzdmpKQVJXcnBV?=
 =?utf-8?B?UjVvS05JM2hSM0RnM3FrbUVOU3M5aTUxU2w4eWE3aVB3WS9WaXBmUVl6ekpu?=
 =?utf-8?B?ZHhSZG5ZVlZXNkk2c1YrRWllckcxT3F6MWFWTUp6Q0ZWWE5uVjg2YXVtYUdr?=
 =?utf-8?B?VjF3VnVPRUdGRjhaVmdUd0R0ZTl4Z0gzZ0wya3J2VUE3TTVoM2Z3M1pYWnlt?=
 =?utf-8?B?QUhIZ3E1YTk5OTNOWDRjYWdPL0ljemZrdG9KN3RtZmtjOENhaEs0ejM1VHc4?=
 =?utf-8?B?bUU3dEgwZDlSVGEzRXMraks2N3hiSnBHWWF3QWp0OVd3bitrcEdDamFNeEtu?=
 =?utf-8?B?cG9jRnpDNU05N0dKZ2xIZ3FHZUdaL29USjFLbW01OVArUXNyOUhJOE5SVC9H?=
 =?utf-8?B?b3ZmS2N4Q0R1UjRSaGVBSUgxRGMwcDNydGJya0ZFelM3dVhPbzN6ZEN0M2F1?=
 =?utf-8?B?VTJJQ1VoY0F3VUl1RG03bWoxRFZaai9PMWhnSHc0MHlaZ1hvWlo4N3pmcnkx?=
 =?utf-8?B?eXlGa2ZnRlRCN0JIaGpGV3NoSFg3WjU5cFhFZGJoR2tZN0ZtY3dJUDIwS2ZR?=
 =?utf-8?B?NEdMSngySW5EUk1vZEdNVGs0REU4bUxOVk5lMkFuYWRkTzRVaHZHaC9hNW1z?=
 =?utf-8?B?T05pVllndWdtVGlyK0FzUWxvMHp4Mk40NWQ3dDV1YkhBNzVjaHhqZGpLK3g2?=
 =?utf-8?B?VkRmWkFZSmlySWtpMU5pZEdjMHBjSkxoUzErekY3bDU0OE9OWE5XSXpKNWNV?=
 =?utf-8?B?T21ud1VHWEhHNENWOWkrM0tISjBZeTc3WUFnRHMyNUJ0R1dnS1lCVE90N1pz?=
 =?utf-8?B?amxPT0x5R202OCtteTZZZU1TSlU3dUNhczlxL2YzcElsTHpYamc5Y0EwV3Zl?=
 =?utf-8?B?SXZIOEl1eVl2YVppOXZvajZCeU8rMEJVMzBpZG5vY1hRMDNUSFZSSjRvOVpl?=
 =?utf-8?B?VUowaUhuWHU1NDVlaWcrOCtOUTFoaHFweTZTOEsram1yc1QxMW9nMGdBdHV0?=
 =?utf-8?B?aHJXYk9UWnB0SWFmSkZTQmNtSEtVOU85MzM2bW9XQmE4VnZsNlVVempHc0xU?=
 =?utf-8?B?Nkd4enF6bkRoV1k4Ymt5My96eUY5RG80Z053Tzg5KzVpWXJINHNDOU0rYndI?=
 =?utf-8?B?WVRNVmdzZGpaU1ZEN1l1MHF1L0VsaldERUo0VXQ1aTBGenMyUnV2b1J4VmEv?=
 =?utf-8?B?NmtERDNWY2NpR0c0bU4wQlNxQVpnZjg5T2hib21rWHZ5eHFheDZRZndyaWJB?=
 =?utf-8?B?QzYvbEdXVWJ1WXRpbTY2VmZvWXJCQkpYb0JkMzd0b21rZU5iMEIzc3dMMGQv?=
 =?utf-8?B?MzAzUDVUa0FvQUlhT3cvRCtBZ2dyMDFabWJVTktMdURnY3JlQlNCSmR6SndV?=
 =?utf-8?B?WEUwcUtsOWJPT2ZIY1ZoSElVbzVlOWJIc3kzQTUxUDFvcW5SNmlMZ1hHWDJ1?=
 =?utf-8?B?YkthU3RNV0tyVUticlVwYTNyNWg1ZDdiN2s3U2tmZUNiendBT1FqczVFRzg5?=
 =?utf-8?B?SzUyRVJxa3gyVU1Jd1hPaTZmOExZang2NEtiZVVMakI3Y3RPbnVqN3lSRUVW?=
 =?utf-8?B?TUlOOWtyNDdIeXhGZkU2dDl2N2dTRzJCZVU4djFuYkZ6SzVjT0tvd09OTGNy?=
 =?utf-8?B?VE1LWDMzN1RPNE5TTGc3TEdMQnhPNlE4dVBOVVVsRnh3M04yVllUeklIQzl3?=
 =?utf-8?B?Zm5Sbnh2c0xOZFBRZkUrK0MvaHJWMjBlVGVtVUNscWdTQ3o1QWFPMVFqREcx?=
 =?utf-8?B?dXlIR1VtVTByeGtsYnkwUHp2TEVMaXNJaGV4eXNtbkwxbVViUWZ1M3o5ZnZz?=
 =?utf-8?B?K2JYS2NoQWc3cGsrWXRmQjhJSzNpRVFVWUtyb1NFSmo1Qlg5eE14OTRUT3Q5?=
 =?utf-8?B?TXo5NUowQTUyVjFWV0U0U1FwanBncG80em5nKzZ5enpPNWEwaXRiSVVLMm1S?=
 =?utf-8?Q?3shrvRuVSdML7u3gF62gKLmQA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f509506-7a64-4edf-46cb-08db76440ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 12:51:21.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbmr0o8iLgibbIa4a5YH4Fs2Ek6xIrsNdKdN+sNOa2NGhgkFx5UZWBWBHbbFV86sYyLD3Bt777i2r70NVuQaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHUsIEFhcm9uIDxhYXJv
bi5sdUBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyAxOjQ4IFBNDQo+
IFRvOiBEZW5nLCBQYW4gPHBhbi5kZW5nQGludGVsLmNvbT4NCj4gQ2M6IENoZW4sIFRpbSBDIDx0
aW0uYy5jaGVuQGludGVsLmNvbT47IHBldGVyekBpbmZyYWRlYWQub3JnOw0KPiB2aW5jZW50Lmd1
aXR0b3RAbGluYXJvLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGksIFRpYW55
b3UNCj4gPHRpYW55b3UubGlAaW50ZWwuY29tPjsgTWEsIFl1IDx5dS5tYUBpbnRlbC5jb20+OyBa
aHUsIExpcGVuZw0KPiA8bGlwZW5nLnpodUBpbnRlbC5jb20+OyBDaGVuLCBZdSBDIDx5dS5jLmNo
ZW5AaW50ZWwuY29tPjsgVGltIENoZW4NCj4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBzY2hlZC90YXNrX2dyb3VwOiBSZS1sYXlvdXQgc3Ry
dWN0dXJlIHRvIHJlZHVjZSBmYWxzZQ0KPiBzaGFyaW5nDQo+IA0KPiBPbiBXZWQsIEp1biAyMSwg
MjAyMyBhdCAwNDoxNDoyNVBNICswODAwLCBEZW5nIFBhbiB3cm90ZToNCj4gPiBXaGVuIHJ1bm5p
bmcgVW5peEJlbmNoL1BpcGUtYmFzZWQgQ29udGV4dCBTd2l0Y2hpbmcgY2FzZSwgd2Ugb2JzZXJ2
ZWQNCj4gPiBoaWdoIGZhbHNlIHNoYXJpbmcgZm9yIGFjY2Vzc2luZyDigJhsb2FkX2F2Z+KAmSBh
Z2FpbnN0IHJ0X3NlIGFuZCBydF9ycQ0KPiA+IHdoZW4gY29uZmlnIENPTkZJR19SVF9HUk9VUF9T
Q0hFRCBpcyB0dXJuZWQgb24uDQo+ID4NCj4gPiBQaXBlLWJhc2VkIENvbnRleHQgU3dpdGNoaW5n
IGNhc2UgaXMgYSB0eXBpY2FsIHNsZWVwL3dha2V1cCBzY2VuYXJpbywNCj4gPiBpbiB3aGljaCBs
b2FkX2F2ZyBpcyBmcmVxdWVubHkgbG9hZGVkIGFuZCBzdG9yZWQsIGF0IHRoZSBtZWFudGltZSwN
Cj4gPiBydF9zZSBhbmQgcnRfcnEgYXJlIGZyZXF1ZW50bHkgbG9hZGVkLiBVbmZvcnR1bmF0ZWx5
LCB0aGV5IGFyZSBpbiB0aGUNCj4gPiBzYW1lIGNhY2hlbGluZS4NCj4gPg0KPiA+IFRoaXMgY2hh
bmdlIHJlLWxheW91dHMgdGhlIHN0cnVjdHVyZToNCj4gPiAxLiBNb3ZlIHJ0X3NlIGFuZCBydF9y
cSB0byBhIDJuZCBjYWNoZWxpbmUuDQo+ID4gMi4gS2VlcCDigJhwYXJlbnTigJkgZmllbGQgaW4g
dGhlIDJuZCBjYWNoZWxpbmUgc2luY2UgaXQncyBhbHNvIGFjY2Vzc2VkDQo+ID4gdmVyeSBvZnRl
biB3aGVuIGNncm91cHMgYXJlIG5lc3RlZCwgdGhhbmtzIFRpbSBDaGVuIGZvciBwcm92aWRpbmcg
dGhlDQo+ID4gaW5zaWdodC4NCj4gPg0KPiA+IFRlc3RlZCBvbiBJbnRlbCBJY2VsYWtlIDIgc29j
a2V0cyA4MEMvMTYwVCBwbGF0Zm9ybSwgYmFzZWQgb24gdjYuNC1yYzUuDQo+ID4NCj4gPiBXaXRo
IHRoaXMgY2hhbmdlLCBQaXBlLWJhc2VkIENvbnRleHQgU3dpdGNoaW5nIDE2MCBwYXJhbGxlbCBz
Y29yZSBpcw0KPiA+IGltcHJvdmVkIH45LjYlLCBwZXJmIHJlY29yZCB0b29sIHJlcG9ydHMgcnRf
c2UgYW5kIHJ0X3JxIGFjY2VzcyBjeWNsZXMNCj4gPiBhcmUgcmVkdWNlZCBmcm9tIH4xNC41JSB0
byB+MC4zJSwgcGVyZiBjMmMgdG9vbCBzaG93cyB0aGUNCj4gPiBmYWxzZS1zaGFyaW5nIGlzIHJl
c29sdmVkIGFzIGV4cGVjdGVkOg0KPiANCj4gSSBhbHNvIGdpdmUgaXQgYSBydW4gb24gYW4gSWNl
bGFrZSBhbmQgc2F3IHNpbWlsYXIgdGhpbmdzIHdoZW4NCj4gQ09ORklHX1JUX0dST1VQX1NDSEVE
IGlzIG9uLg0KPiANCj4gRm9yIGhhY2tiZW5jaC9waXBlL3RocmVhZCwgc2V0X3Rhc2tfY3B1KCkg
ZHJvcHBlZCBmcm9tIDEuNjclIHRvIDAuNTElDQo+IGFjY29yZGluZyB0byBwZXJmIGN5Y2xlOyBm
b3IgbmV0cGVyZi9ucl9jbGllbnQ9bnJfY3B1L1VEUF9SUiwNCj4gc2V0X3Rhc2tfY3B1KCkgZHJv
cHBlZCBmcm9tIDUuMDYlIHRvIDEuMDglLg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIEFhcm9uIQ0K
DQo+IA0KPiBUaGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSwganVzdCBhIG5pdCBiZWxvdy4NCj4g
DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9zY2hlZC5oIGIva2VybmVsL3NjaGVkL3Nj
aGVkLmggaW5kZXgNCj4gPiBlYzdiM2UwYTJiMjAuLjRmYmQ0YjNhNGJkZCAxMDA2NDQNCj4gPiAt
LS0gYS9rZXJuZWwvc2NoZWQvc2NoZWQuaA0KPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9zY2hlZC5o
DQo+ID4gQEAgLTM4OSw2ICszODksMTkgQEAgc3RydWN0IHRhc2tfZ3JvdXAgeyAgI2VuZGlmICAj
ZW5kaWYNCj4gPg0KPiA+ICsJc3RydWN0IHJjdV9oZWFkCQlyY3U7DQo+ID4gKwlzdHJ1Y3QgbGlz
dF9oZWFkCWxpc3Q7DQo+ID4gKw0KPiA+ICsJc3RydWN0IGxpc3RfaGVhZAlzaWJsaW5nczsNCj4g
PiArCXN0cnVjdCBsaXN0X2hlYWQJY2hpbGRyZW47DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAq
IFRvIHJlZHVjZSBmYWxzZSBzaGFyaW5nLCBjdXJyZW50IGxheW91dCBpcyBvcHRpbWl6ZWQgdG8g
bWFrZQ0KPiA+ICsJICogc3VyZSBsb2FkX2F2ZyBpcyBpbiBhIGRpZmZlcmVudCBjYWNoZWxpbmUg
ZnJvbSBwYXJlbnQsIHJ0X3NlDQo+ID4gKwkgKiBhbmQgcnRfcnEuDQo+ID4gKwkgKi8NCj4gPiAr
CXN0cnVjdCB0YXNrX2dyb3VwCSpwYXJlbnQ7DQo+ID4gKw0KPiANCj4gSSB3b25kZXIgaWYgd2Ug
Y2FuIHNpbXBseSBkbzoNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvc2NoZWQuaCBi
L2tlcm5lbC9zY2hlZC9zY2hlZC5oIGluZGV4DQo+IGVjN2IzZTBhMmIyMC4uMzFiNzNlOGQ5NTY4
IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvc2NoZWQuaA0KPiArKysgYi9rZXJuZWwvc2No
ZWQvc2NoZWQuaA0KPiBAQCAtMzg1LDcgKzM4NSw5IEBAIHN0cnVjdCB0YXNrX2dyb3VwIHsNCj4g
IAkgKiBpdCBpbiBpdHMgb3duIGNhY2hlbGluZSBzZXBhcmF0ZWQgZnJvbSB0aGUgZmllbGRzIGFi
b3ZlIHdoaWNoDQo+ICAJICogd2lsbCBhbHNvIGJlIGFjY2Vzc2VkIGF0IGVhY2ggdGljay4NCj4g
IAkgKi8NCj4gLQlhdG9taWNfbG9uZ190CQlsb2FkX2F2ZyBfX19fY2FjaGVsaW5lX2FsaWduZWQ7
DQo+ICsJc3RydWN0IHsNCj4gKwkJYXRvbWljX2xvbmdfdAkJbG9hZF9hdmc7DQo+ICsJfSBfX19f
Y2FjaGVsaW5lX2FsaWduZWRfaW5fc21wOw0KPiAgI2VuZGlmDQo+ICAjZW5kaWYNCj4gDQo+IFRo
aXMgd2F5IGl0IGNhbiBtYWtlIHN1cmUgdGhlcmUgaXMgbm8gZmFsc2Ugc2hhcmluZyB3aXRoIGxv
YWRfYXZnIG5vIG1hdHRlcg0KPiBob3cgdGhlIGxheW91dCBvZiB0aGlzIHN0cnVjdHVyZSBjaGFu
Z2VzIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBZb3VyIHBhdGNoIGhhcyB0aGUgYWR2YW50YWdlIG9m
IG5vdCBhZGRpbmcgYW55IG1vcmUgcGFkZGluZywgdGh1cyBzYXZlcw0KPiBzb21lIHNwYWNlOyB0
aGUgZXhhbXBsZSBjb2RlIGFib3ZlIGhhcyB0aGUgYWR2YW50YWdlIG9mIG5vIG5lZWQgdG8gd29y
cnkNCj4gYWJvdXQgZnV0dXJlIGNoYW5nZXMgdGhhdCBtaWdodCBicmVhayB0aGUgZXhwZWN0ZWQg
YWxpZ25tZW50LCBidXQgaXQgZG9lcw0KPiBtYWtlIHRoZSBzdHJ1Y3R1cmUgc2l6ZSBhIGxpdHRs
ZSBsYXJnZXIoNzA0IC0+IDc2OCkuDQo+IA0KDQpSaWdodCwgdGhlIG9yaWdpbmFsIHB1cnBvc2Ug
aXMgdG8ga2VlcCB0aGUgc3RydWN0dXJlIHNpemUsIGFjdHVhbGx5IEkgZG9uJ3QgaGF2ZSBhDQpz
dHJvbmcgcHJlZmVyZW5jZSBoZXJlIHdoZXRoZXIga2VlcCB0aGUgc2l6ZSBvciB0aGUgbWFpbnRh
aW5hYmlsaXR5LCB3b3VsZCBsaWtlDQp0byBrbm93IG1haW50YWluZXIncyBpbnNpZ2h0IDopDQoN
ClRoYW5rcw0KUGFuDQoNCj4gVGhhbmtzLA0KPiBBYXJvbg0KPiANCj4gPiAgI2lmZGVmIENPTkZJ
R19SVF9HUk9VUF9TQ0hFRA0KPiA+ICAJc3RydWN0IHNjaGVkX3J0X2VudGl0eQkqKnJ0X3NlOw0K
PiA+ICAJc3RydWN0IHJ0X3JxCQkqKnJ0X3JxOw0KPiA+IEBAIC0zOTYsMTMgKzQwOSw2IEBAIHN0
cnVjdCB0YXNrX2dyb3VwIHsNCj4gPiAgCXN0cnVjdCBydF9iYW5kd2lkdGgJcnRfYmFuZHdpZHRo
Ow0KPiA+ICAjZW5kaWYNCj4gPg0KPiA+IC0Jc3RydWN0IHJjdV9oZWFkCQlyY3U7DQo+ID4gLQlz
dHJ1Y3QgbGlzdF9oZWFkCWxpc3Q7DQo+ID4gLQ0KPiA+IC0Jc3RydWN0IHRhc2tfZ3JvdXAJKnBh
cmVudDsNCj4gPiAtCXN0cnVjdCBsaXN0X2hlYWQJc2libGluZ3M7DQo+ID4gLQlzdHJ1Y3QgbGlz
dF9oZWFkCWNoaWxkcmVuOw0KPiA+IC0NCj4gPiAgI2lmZGVmIENPTkZJR19TQ0hFRF9BVVRPR1JP
VVANCj4gPiAgCXN0cnVjdCBhdXRvZ3JvdXAJKmF1dG9ncm91cDsNCj4gPiAgI2VuZGlmDQo+ID4g
LS0NCj4gPiAyLjM5LjMNCj4gPg0K
