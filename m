Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1D6A5323
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjB1Gmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Gma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:42:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4422002;
        Mon, 27 Feb 2023 22:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677566548; x=1709102548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94sLeJHYVshc1znzWV/shsBYyBi+XeHGsnXAT0lVRBg=;
  b=RhcXWyta0OZxTZviyC6MWFCynncR6pahL4X5sNYQEEIQyg4W4VwIu6dP
   GHA72d1DzyRin3T6A/nWjym525UWxpQAmMvUioWU+JJGrk1N1qEQsSD87
   nf05Hydscj9XVU2j4WER0VYDaTt8adOZFpH1huGfuwLsx3EhxZUN/DDJK
   sBmIgm+XkEQYISvJehtY6aqZ1DmOWtXlH6OeQ9fjHXb0IQJ+5Hy6lZ+Wf
   btOJBCsPROarKZYRcO3NeeQ88cwjoZ/G6DvAeOWQXrd3zFCv3dCoL9Zxe
   ZCPCXOyEvyOP5sBS3Lt+51/7Nz/3wIDJBggjgWphF+BTn2+5PC9Nwk1Lk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314487342"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="314487342"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 22:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="706463527"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="706463527"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2023 22:42:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 22:42:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Feb 2023 22:42:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 22:42:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbLCcJG/5YRZXJaMfHOlavIIASc364oof1iZ+p6tdBljL81HuwAzbFWVCQ4mNmqmyVlaDYdYRZM8II9HE46BFkZJ/WokUyP2u+wFE+u+LrPT2nw8inLsQg5uhohaFLy3RZ3s9bcf8hONybBbEtElkir1puzlXoRodQo/b6cY4BU4fu2iHOnX3Q+Nzun6KttXjY6V0ftEChDwKjwHNSkkoB1XFnNQSmDL0Rgx7b1wBRj+yFEzgYHK344frhQ08ailNtmX06svGegAe0BKixqwhs9wBkZCJzUZcYB/U4uDRQvDFhEd3EahTip4xb/c7ecYqYFjSq1lpg6+6f6wfQGFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94sLeJHYVshc1znzWV/shsBYyBi+XeHGsnXAT0lVRBg=;
 b=oOfDsXXC4dVv1gD6CP6WjzARYcRRrm9U28QgQWT6PwzB/rVgobI12ufCgu16ps6VRDM/phXLdmJv8xJ3QNjoN5y7NZ2Iq0Pfkq0KQbMVZx0bn8phlx7ze8/+QCc92Xni1kYT3fYW9c8xic6yRgsX9EQq0VlmCm2yVp+tSeBcA377sLuQjIDiDCLY48n6DW956sAPau8vMzJ5+L1HV+PkEQ3+pXxNZmdnIyNUm1gC/XwMMUiuPpJgfha3j6OIDsrSUk5izEG9F/f1CW+ngr1jwswgQpDQ4de4P8XfnJS2AeZWIIPy99Ayn2x+LEoE7zCr/6DAH+uik4krD22Gcfi2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 06:42:10 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 06:42:10 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Topic: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Index: AQHZP1Hum/btr+ww/kiynrKipZgIc67OndeAgAEcQoCAAAvHAIAC4+MggABa/gCAEPqTgA==
Date:   Tue, 28 Feb 2023 06:42:10 +0000
Message-ID: <DM6PR11MB4316EE7979CE57BAF65DE7128DAC9@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
In-Reply-To: <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|PH7PR11MB7513:EE_
x-ms-office365-filtering-correlation-id: f2f4f4bb-ca47-467d-10cb-08db1956eb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnl49WWDS9ex8wNfEJbFSWqoneil4FN8rQkR245lyl1RxLlqXYSnLTAR5344ccq9oXIZyBUTHP5zf80Q3wYdMKHhzn7kY9MF/ZzG1DglZZZGyzBvj0JMD5V5lYml7ES8AaszouKSyNPHX6v6ZcEToD238/kuAHe/KV1MI+cueflE4Lk8KlL5pds/Va9EGRFmcfJYhUkLmIp0U/xydXhdaS7Mf0sBKYfg6xTVhP485UakpYMIr7R0m2AErPMYF8hqL7GNiLg2PBwgREMlI4ZPWiUb7H/AyLBfQP3GCTAqF5vr4TTIXeaDedgF3PJGAGzltlJlEbUCF6wORGUm9NVFd7CLt27PVtLFtWptHJmiYPYJYgcDAqXJlNyzhhCdTHU3ZWrS1TzjSgpKAeZJWP86aNurTFQdxEektdPQWA/rj6sl84tgLgohzIIqTlPZiMqGusA6zn4yHo+HBAyseiP83yvxymTWs3TTRaK3uhUsBaTiLwxYSvRxjX0h9sARsdj7zqo3TGUMMHPpz/N8witz5uayC5jKEaV1SsiD3DRe8h9k6rbHZO4E78Aj7NmcLFm4Qcme2wQDuZUtbzcXjqBGETpQk4IP3Ae0t4STQFdfGaSDoWxHPjCHP47bIxPBOA9I8QQp1IzvsudPiy3MfrxdrPgOzo2UIXZZ2Lm33nl086J2tUHTZuNby4jPE8GwglEe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(38070700005)(33656002)(66946007)(55016003)(86362001)(7696005)(8936002)(966005)(478600001)(52536014)(41300700001)(6916009)(66446008)(64756008)(66556008)(4326008)(71200400001)(76116006)(8676002)(66476007)(316002)(2906002)(54906003)(5660300002)(9686003)(186003)(83380400001)(122000001)(26005)(66574015)(82960400001)(38100700002)(6506007)(53546011)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmtUYytRbEN4WDVEOUlPYmYrd010TndRTlhNOE16R29STDJiOGxJbWZnbnFF?=
 =?utf-8?B?SzVNM2VCdmc2dklySnNQZEFzOFZia2xKYUNCUmdmQy9aYU8rODBUOFA0cklp?=
 =?utf-8?B?ekUraXEvVVEzYVhjMnQ1VWVkSlNPdE5ZYW1xQlpMNTVwVW9XR3RmaEtMWUhO?=
 =?utf-8?B?bDN4b01TSWxzTGFxU1piSE1CcC9Tb3gxeVM2ek55QXhVcDVlcGw5NmhBbkdH?=
 =?utf-8?B?bzNhUkNMNmVUNWpmNkpkVmd6NjE3WlRWaVQwN041M2RMMEdqL09yb1o3Y0Y0?=
 =?utf-8?B?NXU1K2E5SGtmcEpRZWZUNHluK0Z2WVZkYlBGVkJxZ3JkOGFRZmFUSllFYmtr?=
 =?utf-8?B?MDVuWW5lZThkWnlhbmdwQXlQaGsvMjJLRjFCUHE4RmRESlEwTGtZMzI0azBk?=
 =?utf-8?B?LzR6YXhuQjU4THhvaVJweWVVYjJpb3VOYjVxR1VUYVVheUNkRU51YnpKdTRt?=
 =?utf-8?B?S2NGU0pXSzFCZFltd2FvM0VjWFJoZlA4QVlJdmFnQTA4ZkN2bVBBVUIvZXVQ?=
 =?utf-8?B?K05pVWdHWWoyQURiRHNhdlRtTG9ZMy9SM0JVNmk4RDdFRk9SUjJoSk5JZ3N2?=
 =?utf-8?B?bHVGMm8wd1J4RHErYkpHbXNNaGJSWXZGcnF5S1M5a3ErdXBuVWY4ODhQMS9H?=
 =?utf-8?B?bmlpM0QxY1VuTHZKU3JIMjVxZ0JMcjV0ekdLVWNpUmhtb2dLR1ZZcS96YTA3?=
 =?utf-8?B?bGcvWTZBb05BZE1SRE1USGFOUjUxNmVxUEpaeVV4UG9GTXM2NUIvOU52U05H?=
 =?utf-8?B?d1Q2czZLOFlLRDJ4NllvcVV4dU4zd25aRTFRNXJJOUNSZUR6NkwwbVc1NWk3?=
 =?utf-8?B?LzViVy93eWhNQm9jZURGK0RmUHdVNUVmTzBuUkVuMTZwdG44WEwwM3ZmcWFE?=
 =?utf-8?B?TWw0ODRkRDVabXM0T3p3VGtQL25NWXBqOXhoblpsb2JOcmVtV3FCVFdlUGVM?=
 =?utf-8?B?R1pDY0pHc2tRK3d1M2ZKZHh1NVEycXZQMXJQdWtVTm4wdmJHYmNkMllMRXpl?=
 =?utf-8?B?MEd0WjhhWHowQTJpTE5QN2hLSENSZ08xTlh2a1hhUXNiOHBHWkY0bGlhaXJB?=
 =?utf-8?B?ZW9RY1JWWUMvWkwyY3piNEtoZmZid2k5dEpEOGd4VmNnejBSVkRkaWJGVUJG?=
 =?utf-8?B?Qy9iWSt1a2lxWWx5bTdtNC9GWU1ybk1BTE5xazlQSlpoQXZNb2E2S1NpdFhP?=
 =?utf-8?B?SHhzNjF2OExFZnEvWEdUeUFnUE1oVmxnaXIxUk1ZNmZDcVFzQVh3aTlkcHRm?=
 =?utf-8?B?R1BxbnY3a0piVnNGWHd1b0FPYXQ1TzJUTmRKVEtqQklnNFY2SHRwdEJtOWVn?=
 =?utf-8?B?ZFEyWGFjeklaNm01bnRHYzBMSW9kcXMwbzMxSVpISlpDUDNkN0h0SWg3QUZh?=
 =?utf-8?B?K0w2T2x1WWpvOGttb2cwWERhTG5mNDNQb0dRNWZvOTQ3UTB4NUJwbU1FbDU0?=
 =?utf-8?B?N2N4bzRWamJNRDlHS2hOSSs2M1p3SmtBYmVINWQyODlsVWNISzNNckNrTkcz?=
 =?utf-8?B?YlJJRnUxcFlBZzJIVTdDazMyOURlN0NMMkJNbm1BT0hXRUZJSitXNFdNVUJV?=
 =?utf-8?B?STdiVnkxaXlsVEVIR0FOS004VnM2RFROUldJcEF5ajh3a1pqam9PV3dudGQy?=
 =?utf-8?B?RzZvSnU1NDQ1Wjk3NFlhTkIxTXUxRTFVSGVucXRraFJMQUJGVXcxOGduTDZk?=
 =?utf-8?B?c1JjS05QU3R2YXNCblZwNG12T2hVTmtNNkFFdlB4ZTRBaHFWWXpQRUdUK3Rk?=
 =?utf-8?B?cnorY3dYVXcxREZEenphMTBUOHZrZTBOSll2ZFRET3VQL3dvaC9sZWhyTXB6?=
 =?utf-8?B?YzhVUzB2d1V4elNaRmxkOVpvOU5pV0hDOWpZMEYyVm03Vmp6ZzdWc2pQY0ph?=
 =?utf-8?B?T0FpM1puQ3BPQXRQSURsRTd0NmhsZTRsQlJadmxsa05hT2M0bmM4ckxaQW5j?=
 =?utf-8?B?a09LU01ZV1M5SVcwY1RYbVVzUm9BY09ITnFMSmhSNnk3UXZOZjNydEIvQ0tX?=
 =?utf-8?B?UDlaODZXRU0rTi9ZRXpaL1JKbjJpbjIrVFRWZ285YXNycnNoNTU3TG9ja3kw?=
 =?utf-8?B?emJHOFZZd3k2bW5jdUhYSmZjQ0Fhb1dlZ1lKMVlmd0dKdkl1aGdTSnFHc1Fz?=
 =?utf-8?Q?IIJW2YdTbajD07pCEGS5TLUq1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f4f4bb-ca47-467d-10cb-08db1956eb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:42:10.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIJQuE0KmvInbUI021r6Bgys8fViXNA6kM8U6Q3rLgZOoabDKhERB0sUwexMg2V+sRR/cCQTXZWeWxNHlPO/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
dXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBGZWJydWFyeSAxNywgMjAyMyA3OjE5IFBNDQo+IA0KPiBIaSBXZW50b25nLA0K
PiANCj4gT24gRnJpLCBGZWIgMTcsIDIwMjMgYXQgMDY6MTA6MjJBTSArMDAwMCwgV3UsIFdlbnRv
bmcgd3JvdGU6DQo+ID4gT24gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMyA1OjQ2
IFBNLCBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBGZWIgMTUsIDIwMjMg
YXQgMTA6MDM6MjlBTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiA+ID4gT24gMi8x
NC8yMyAxNzowNiwgU2FrYXJpIEFpbHVzIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgRmViIDEz
LCAyMDIzIGF0IDEwOjIzOjQ3QU0gKzA4MDAsIFdlbnRvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+ID4+
IElWU0MgZGlyZWN0bHkgY29ubmVjdHMgdG8gY2FtZXJhIHNlbnNvciBvbiBzb3VyY2Ugc2lkZSwg
YW5kIG9uDQo+ID4gPiA+ID4+IG91dHB1dCBzaWRlIGl0IG5vdCBvbmx5IGNvbm5lY3RzIElTSCB2
aWEgSTJDLCBidXQgYWxzbyBleHBvc2VzDQo+ID4gPiA+ID4+IE1JUEkNCj4gPiA+ID4gPj4gQ1NJ
LTIgaW50ZXJmYWNlIHRvIG91dHB1dCBjYW1lcmEgc2Vuc29yIGRhdGEuIElWU0MgY2FuIHVzZSB0
aGUNCj4gPiA+ID4gPj4gY2FtZXJhIHNlbnNvciBkYXRhIHRvIGRvIEFJIGFsZ29yaXRobSwgYW5k
IHNlbmQgdGhlIHJlc3VsdHMgdG8gSVNILg0KPiA+ID4gPiA+PiBPbiB0aGUgb3RoZXIgZW5kLCBJ
VlNDIGNhbiBzaGFyZSBjYW1lcmEgc2Vuc29yIHRvIGhvc3QgYnkNCj4gPiA+ID4gPj4gcm91dGlu
ZyB0aGUgcmF3IGNhbWVyYSBzZW5zb3IgZGF0YSB0byB0aGUgZXhwb3NlZCBNSVBJIENTSS0yDQo+
ID4gPiA+ID4+IGludGVyZmFjZS4gQnV0IHRoZXkgY2FuIG5vdCB3b3JrIGF0IHRoZSBzYW1lIHRp
bWUsIHNvIHNvZnR3YXJlDQo+ID4gPiA+ID4+IEFQSXMgYXJlIGRlZmluZWQgdG8gc3luYyB0aGUg
b3duZXJzaGlwLg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBUaGlzIGNvbW1pdCBkZWZpbmVzIHRo
ZSBpbnRlcmZhY2VzIGJldHdlZW4gSVZTQyBhbmQgY2FtZXJhDQo+ID4gPiA+ID4+IHNlbnNvciBk
cml2ZXIgaW4gaW5jbHVkZS9saW51eC9pdnNjLmguIFRoZSBjYW1lcmEgZHJpdmVyDQo+ID4gPiA+
ID4+IGNvbnRyb2xzIG93bmVyc2hpcCBvZiB0aGUgQ1NJLTIgbGluayBhbmQgc2Vuc29yIHdpdGgg
dGhlDQo+ID4gPiA+ID4+IGFjcXVpcmUvcmVsZWFzZSBBUElzLiBXaGVuIGFjcXVpcmluZyBjYW1l
cmEsIGxhbmUgbnVtYmVyIGFuZA0KPiA+ID4gPiA+PiBsaW5rIGZyZXEgYXJlIGFsc28gcmVxdWly
ZWQgYnkgSVZTQyBmcmFtZSByb3V0ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgbW9yZSBJ
IGxlYXJuIGFib3V0IHRoaXMgc3lzdGVtLCB0aGUgbW9yZSBJJ20gaW5jbGluZWQgdG8NCj4gPiA+
ID4gPiB0aGluayB0aGlzIGZ1bmN0aW9uYWxpdHkgc2hvdWxkIGJlIGV4cG9zZWQgYXMgYSBWNEwy
IHN1Yi1kZXZpY2UuDQo+ID4gPiA+ID4gSVZTQyBkb2Vzbid0IHJlYWxseSBkbyBhbnl0aGluZyB0
byB0aGUgZGF0YSAoYXMgbG9uZyBhcyBpdA0KPiA+ID4gPiA+IGRpcmVjdHMgaXQgdG93YXJkcyB0
aGUgQ1NJLTIgcmVjZWl2ZXIgaW4gdGhlIFNvQyksIGJ1dCBpdCBpcw0KPiA+ID4gPiA+IGRlZmlu
aXRlbHkgcGFydCBvZiB0aGUgaW1hZ2UgcGlwZWxpbmUuDQo+ID4gPiA+DQo+ID4gPiA+IFllcyBJ
IGhhcHBlbmVkIHRvIGRpc2N1c3MgdGhpcyBleGFjdCBzYW1lIHRoaW5nIHdpdGggTGF1cmVudCBh
dA0KPiA+ID4gPiBGT1NERU0gYW5kIHdlIGFsc28gY2FtZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0
IHRoZSBJVlNDIGNoaXANCj4gPiA+ID4gc2hvdWxkIGJlIG1vZGVsZWQgYXMgYSBWNEwyIHN1Yi1k
ZXZpY2UuDQo+ID4gPg0KPiA+ID4gQWdyZWVkLg0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHF1
aWNrIHJldmlldyBhbmQgY29uY2x1c2lvbiwgSSdtIGZyZXNoIHRvIG1lZGlhDQo+ID4gc3ViLXN5
c3RlbSwgaXMgdGhlcmUgYW55IGNvbnZlbnRpb24gdGhhdCBJIHNob3VsZCBmb2xsb3cgdG8gdXBz
dHJlYW0NCj4gPiB0aGlzIGtpbmQgb2YgdjRsMiBzdWItZGV2aWNlIGRyaXZlciBzbyB0aGF0IG5v
dCB0b28gbXVjaCBiYWNrIGFuZA0KPiA+IGZvcnRoPw0KPiANCj4gVGhpcyBpcyBhIHRlbnRhdGl2
ZSBwcm9wb3NhbCwgYXMgSSdtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggdGhlIGhhcmR3YXJlDQo+
IGFyY2hpdGVjdHVyZToNCj4gDQo+IC0gVGhlIHN1YmRldiBzaG91bGQgaGF2ZSB0d28gcGFkcywg
YSBzaW5rIHBhZCBjb25uZWN0ZWQgdG8gdGhlIGNhbWVyYQ0KPiAgIHNlbnNvciwgYW5kIGEgc291
cmNlIHBhZCBjb25uZWN0ZWQgdG8gdGhlIENTSS0yIHJlY2VpdmVyIGluIHRoZSBJUFUuDQo+IA0K
PiAtIEFzIGZvciBhbnkgbmV3IGRyaXZlciwgdGhlIHN1YmRldiBkcml2ZXIgc2hvdWxkIHVzZSB0
aGUgYWN0aXZlIHN0YXRlDQo+ICAgbWFuYWdlZCBieSB0aGUgdjRsMi1zdWJkZXYgY29yZS4gVGhp
cyByZXF1aXJlcyBjYWxsaW5nDQo+ICAgdjRsMl9zdWJkZXZfaW5pdF9maW5hbGl6ZSgpIGF0IHBy
b2JlIHRpbWUuIFNlZQ0KPiAgIGh0dHBzOi8vZ2l0LmxpbnV4dHYub3JnL21lZGlhX3RyZWUuZ2l0
L2NvbW1pdC8/aWQ9YTI1MTRiOWE2MzRhIGZvciBhbg0KPiAgIGV4YW1wbGUgb2YgYSBzdWJkZXYg
ZHJpdmVyIGNvbnZlcnRlZCB0byB0aGlzIG1lY2hhbmlzbS4NCj4gDQo+IC0gQXMgd2UncmUgdGFs
a2luZyBhYm91dCBDU0ktMiwgdGhlIHN1YmRldiBkcml2ZXIgc2hvdWxkIHVzZSB0aGUgc3RyZWFt
cw0KPiAgIEFQSSB0aGF0IHdhcyByZWNlbnRseSBtZXJnZWQsIGFuZCBpbiBwYXJ0aWN1bGFyIHN1
cHBvcnQgdGhlDQo+ICAgLmdldF9mcmFtZV9kZXNjKCksIC5zZXRfcm91dGluZygpLCAuZW5hYmxl
X3N0cmVhbXMoKSBhbmQNCj4gICAuZGlzYWJsZV9zdHJlYW1zKCkgb3BlcmF0aW9ucy4NCj4gDQo+
IC0gSSBkb24ndCBzZWUgYSBuZWVkIHRvIHN1cHBvcnQgVjRMMiBjb250cm9scyBpbiB0aGUgc3Vi
ZGV2IGRyaXZlciwgYnV0DQo+ICAgSSBtYXkgYmUgbWlzc2luZyBzb21ldGhpbmcuDQo+IA0KPiAt
IFRoZSBkcml2ZXIgc2hvdWxkIGJlIHZhbGlkYXRlZCB3aXRoIHY0bDItY29tcGxpYW5jZSwgcGFy
dCBvZg0KPiAgIHY0bC11dGlscy4NCg0KVGhhbmtzLCBvbmUgbW9yZSBxdWVzdGlvbiwgYmVjYXVz
ZSBpdnNjIGp1c3Qgcm91dGVzIHRoZSByZWNlaXZlZCBkYXRhIGZyb20NCnNlbnNvciBhbmQgbm8g
Zm9ybWF0IGNvbnZlcnQsIGhvdyB3ZSBoYW5kbGUgdGhlIGdldF9mbXQgYW5kIHNldF9mbXQgY2Fs
bGJhY2sNCmZvciBpdnNjPw0KDQpUaGFua3MNCldlbnRvbmcNCg0KPiANCj4gPiA+ID4gPiBJIHN1
cHBvc2UgdGhlIGludGVuZGVkIHVzZSBjYXNlcyBhc3N1bWUgYSBzaW5nbGUgaW5zdGFuY2Ugb2YN
Cj4gPiA+ID4gPiBJVlNDIChhcyB3ZWxsIGFzIE1FSSkgYnV0IHRoZXJlIGNhbiwgYW5kIG9mdGVu
IGFyZSwgYmUgbXVsdGlwbGUNCj4gPiA+ID4gPiBjYW1lcmEgc2Vuc29ycyBpbiB0aGUgc3lzdGVt
LiBUaGUgZGVjaXNpb24gd2hldGhlciB0byByZXF1ZXN0DQo+ID4gPiA+ID4gcGFzcy10aHJvdWdo
IGZyb20gSVZDUyBjYW4ndCBiZSBkb25lIGluIHRoZSBjYW1lcmEgc2Vuc29yDQo+ID4gPiA+ID4g
ZHJpdmVyLCBhbmQgc2hvdWxkIG5vdCBiZSB2aXNpYmxlIHRvIHRoZSBjYW1lcmEgc2Vuc29yIGRy
aXZlci4NCj4gPiA+ID4gPiBFeHBvc2luZyBJVlNDIGFzIGEgVjRMMiBzdWItZGV2aWNlIG1ha2Vz
IHRoaXMgdHJpdmlhbCB0bw0KPiA+ID4gPiA+IGFkZHJlc3MsIGFzIHRoZSBJVlNDIGRyaXZlcidz
IFY0TDIgc3ViLWRldmljZSB2aWRlbyBzX3N0cmVhbSgpIG9wZXJhdGlvbg0KPiBnZXRzIGNhbGxl
ZCBiZWZvcmUgc3RyZWFtaW5nIGlzIHN0YXJ0ZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUg
aW5mb3JtYXRpb24gd2hldGhlciBJVlNDIGlzIGZvdW5kIGJldHdlZW4gdGhlIGNhbWVyYSBzZW5z
b3INCj4gPiA+ID4gPiBhbmQgdGhlIGhvc3QncyBDU0ktMiByZWNlaXZlciAoSVBVIGluIHRoaXMg
Y2FzZSkgc2hvdWxkIGNvbWUNCj4gPiA+ID4gPiBmcm9tIHN5c3RlbSBmaXJtd2FyZSBhbmQgYWNj
ZXNzZWQgbW9zdCBwcm9iYWJseSBieSB3aGF0IGlzDQo+ID4gPiA+ID4gY2FsbGVkIGNpbzItYnJp
ZGdlIGF0IHRoZSBtb21lbnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgcHJpdmFjeSBzdGF0
dXMgY2FuIGJlIGEgVjRMMiBjb250cm9sLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxzbyBjYyBI
YW5zLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4+IFNpZ25lZC1vZmYtYnk6IFdlbnRvbmcgV3UgPHdl
bnRvbmcud3VAaW50ZWwuY29tPg0KPiA+ID4gPiA+PiAtLS0NCj4gPiA+ID4gPj4gIGRyaXZlcnMv
bWVkaWEvcGNpL2ludGVsL2l2c2MvTWFrZWZpbGUgfCAgMSArDQo+ID4gPiA+ID4+ICBkcml2ZXJz
L21lZGlhL3BjaS9pbnRlbC9pdnNjL2l2c2MuYyAgIHwgODQNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiA+ID4+ICBpbmNsdWRlL2xpbnV4L2l2c2MuaCAgICAgICAgICAgICAg
ICAgIHwgNTUgKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4+ICAzIGZpbGVzIGNoYW5nZWQs
IDE0MCBpbnNlcnRpb25zKCspICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gPj4gZHJpdmVy
cy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9pdnNjLmMNCj4gDQo+IFtzbmlwXQ0KPiANCj4gLS0NCj4g
UmVnYXJkcywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg==
