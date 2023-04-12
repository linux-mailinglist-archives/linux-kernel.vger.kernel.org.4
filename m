Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC86DE899
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLA7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDLA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:59:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF44E73;
        Tue, 11 Apr 2023 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681261147; x=1712797147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KaWpxIagBFSpEogFvxJ0w498g8rK2bJ6L0qRtqzQdRI=;
  b=eGrwLme5fFIKFsn55xrdpC3u03jptdfypRztZXQ61u0AsLVgTGOU0Oxx
   0ixctoVSt7E4bVk+DlIGKy5sQAj7KCmH9HU2Dc2OLu4iVRZd+CNvfOs2P
   4x67gtPEfU2gAyI7KrJXFf2QOoMLwMSTnDWAejmYFQhzHe1NhKLraQoBt
   gKEk7BwkdBh81yUieZX4P6lfBEzOk9xpbVkttjiMK5w1loUgmsJn9cjmM
   a+AqPzMXxgCn/JrHNpJO//evdVv4ZlEkFyC1QkV2RRmDUcNmwha1j1v7f
   vYC8p5cw9luZJUYjq9WiLDK4QFxkRAj/aVqLe/xnulCo128g+cc2zA8Xl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327874925"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327874925"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 17:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="691354834"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="691354834"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2023 17:58:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 17:58:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 17:58:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 11 Apr 2023 17:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb06GR37kBSEP6jsyOqrOy96hBXfkK+AK/CMvwz+SRRybFd83AaXRqQLeRQEhlB2W4VPGDd7/9gU3tLEoQw0FlQB8ejvlpXdDSjzvuaZWi1IR8S27kmdqvSvoJHrCb2Z5j9Mtocbw94gAMcvEXD1hxB/HDA/TrohWB5T9UktFBVC1qO2eDOLya97i5Rusm256+tX25smupTI5ZF2P1u31zQDKpNs4p81wxSjkf9GSRNgqZfSSHJ3I5c8H7F1BE7lXYCLuHtfHA/hCkEEuz8GyElpiHVc9kdLi/DZ10t1f+oUI1TqOOLOL6LrxxLD9Bd+MZ+2rdVw/Hcf31+FywMatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaWpxIagBFSpEogFvxJ0w498g8rK2bJ6L0qRtqzQdRI=;
 b=NFlKrUSd4B4Kg3VefdJgAWP0gkrCC+YsMkwf332I25HLnWNU5d2NbX8qgbRRxv1Adq0ZGHmpV4tleLbmfFylLjM1tZtx1u06ClieqZ+NE+hcgQ9P/7heRIN4N+sxVjm5omQPumbmVb9w+9hCP6rIuE+bS9uWSQx9xFJiBp25q6VF53pAi7LA4emT0ogX8lFJZPdxQZ2nMziNpdaivuyaIKXeqYyM2Ih2hZnQDp8wShK9ou/XI+Dfq0o2Jp4a2Q5NVMbwrDkjIcJFqesDloZF2JxOnLdVzlDo3M8RfDZ1Xv0ZDtgDfk9tTRlIKAhV16FpYPk8npV3u1jjuA6KNQJaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by DM4PR11MB7400.namprd11.prod.outlook.com (2603:10b6:8:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 00:58:53 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 00:58:53 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>
Subject: Re: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Thread-Topic: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Thread-Index: AQHZbLsZO5OZXnK1X0OHY+MSWOEBu68mo4eAgAAB/wCAADTpAA==
Date:   Wed, 12 Apr 2023 00:58:53 +0000
Message-ID: <279c5b5c9fca4bd933aa1b98796ac7219f91c389.camel@intel.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
         <20230411211719.4549-2-mario.limonciello@amd.com>
         <2a6a377b-4c39-6c2a-c0ee-733120270424@redhat.com>
         <MN0PR12MB6101BDD7A3DB5AD251B63495E29A9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101BDD7A3DB5AD251B63495E29A9@MN0PR12MB6101.namprd12.prod.outlook.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|DM4PR11MB7400:EE_
x-ms-office365-filtering-correlation-id: ad871859-58d1-45aa-363c-08db3af115eb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPnsVuq7qRmt7pN1b1Un97NSzv/+gije0r13FDV/IsVUfePtYVlii626dcodwdxd1YyqM0ShDyxWhBpQWwRr2YIm2N32LqoNkYgGLDs27E54ytIG8WqObWH6hSzamMw9f1/XbGtVIb2TE2piVX379v7ginR5PxiYovkJxsuDLVfsViEdNVkHJWF7vmVMj6bj+uiAIvsefvphvEhdNtovLzcq3A2KsCxKJVxGyKTcGo03sDx6/E/N4dVvs12URj+TxIDjVGZsbsOmscIn8rXKdt00Gf1+4cHIEY5WKjcJpbBgVdukUJiExjm4epKbzAExJUy/CmJ++3sDoJpG2S4Ew04s5YI/4t+uwGn4gUmdaX+dcMyKL5zo+B0sWpsk9GKXdO0MgA5G//dvWFeH8PPXQVsMllq6QdjCxmqxE3hMo5YAnz0+V41Qi7CUzZqiPCYVUPITHnuJdPTOjn5cFTt3VOTvDod8C7j+3n/Ct1icBOo/DcOM6xGVLiR4xC5PnVpm5sFnzSG+Av276F2dgWFGdv4G1G+exNNbazRcPRR4azJW0S6NKhGfv+F4AGQkrjx91DlTN/PL5ffgrFwpIknEYWDsTRqm3dynBSxwoPy2ymLobj/BEqZ/BBbdU/ERllm9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(478600001)(71200400001)(6506007)(6512007)(110136005)(26005)(54906003)(6486002)(66556008)(186003)(6636002)(5660300002)(53546011)(91956017)(316002)(2906002)(3450700001)(66946007)(4326008)(76116006)(64756008)(41300700001)(7416002)(66446008)(8676002)(8936002)(66476007)(38100700002)(122000001)(36756003)(83380400001)(82960400001)(38070700005)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9vR0FpWGRhWTBSTnVGRzhMZnh2TkI1SWFSaktTdkg3NVdNWGhDeDBqeVdX?=
 =?utf-8?B?RU1JMmlkSjZ3RUx0ZkdIUWhZcGpNU2FyS29BblBmdXJWNWRYQ2xlNHIxc1Ir?=
 =?utf-8?B?SHk4Mk5pZnBNUGVIYjJqcCszTUEwT01qUEdjWVd6dmwzZHJhckxEalNFemhT?=
 =?utf-8?B?L2ZleFQ0RG11ZEo0MEw4b1dHSmFrZjRiMDRaL05RdzRNK1YyMnBGdjZmL1Iv?=
 =?utf-8?B?RXYyTnpOQUZlT3VwSEpINkc3WDF0S1plZTZ1dEI2MHZxWC8xa09sODFpY1Nv?=
 =?utf-8?B?Z0NSTFJiNHBmMEF5NVlaUlN3aHBJSUZ4dlBCR2ZsVFhtdUFkTWovaFc4SnJN?=
 =?utf-8?B?VWM4UUhTRCtLN2NpdzBqOFFyc0hyb2lSZCswbUloeG5STUQzdXl3blV5TGRq?=
 =?utf-8?B?WUdRTEF2aXpZU3EzU21EQ3l5Y0t0UjVQenVjL3VpZU4xeXgzcEp6UDRnUGFy?=
 =?utf-8?B?Y2gzWGM5M2IrYTk2bzJZQUxHSU0zTU83ZmlJc2ZTMCsvdmh3Zm54RFpBZWhT?=
 =?utf-8?B?U1ZCdmE0Si9nM1J3Q3Zmcjl3UVFrQVplVTBWRFhWVGdIMGRmUlluVC8yWmdW?=
 =?utf-8?B?aEJXQjZTRlRFZnNuYkY0K0YyVXNkOGdPTVJLdDRxUUVRVzQ0MmxMQkl4V1JG?=
 =?utf-8?B?MDNTNEg4Q2xtSzF1YmcrWDFsMExtT04vd2RwNTZkWk9ETjdrQXFmNkJZVHhK?=
 =?utf-8?B?MldDVHZXUTlZSEJWTlREdEVwZ0lsOTVrV05TeWNFSXdQREV4L3BYUlhTbUlp?=
 =?utf-8?B?VWFkNjJ4WkJYaC9CRThiSklrSlpHNTNwNkFuT0hzeGxWWFpEZGJRZlZlN3lW?=
 =?utf-8?B?S3g2dXJIbmxST3ZDS1N4NVNNVUw4d1BjMlB1UVYwMWN1N0Nob0FaMWxnR3VZ?=
 =?utf-8?B?UERMR0NIS1ZXcERkTGlBa3Fqd2ZTU0Z6RUI2U0RtQ3E0K0sxN1QwNkQ4V0VI?=
 =?utf-8?B?R2pNcUJrQ1A1OTlObmJuWXIzcXJJQTF2YnY5dldpODFOdmt6NW90V3lxRG8v?=
 =?utf-8?B?U3c5UldRUHpLZWdSaXlQWTh1bk5lT1Y1SDlnQkppdHVKK3Q5YXo1dWhZUUV5?=
 =?utf-8?B?bkUreXE5bi9rMHE4NDhpY3ZWcDliYnlITFpkTEkzOTFQKzkrSjhPamNtTEhI?=
 =?utf-8?B?ek1TSXpUSENlVm1TMlp3WXVWQk0wTGpyQ2c3QlJTV0p4ZndYNm44Sk1HZHhR?=
 =?utf-8?B?SWpzYllMcmdPQUtTQ2ZVNGpPTGxYczJUVCtTMmQxVGtvaEIwcmNGSnFHWkZj?=
 =?utf-8?B?WnNDc3ljUnRmQlU5ODA2RWxIbjE5Qng5RVhwdXl1elVHZEFHWXZlRFZZZmtz?=
 =?utf-8?B?M2tKSHB5TTdBVS9UMVNTdThjWnR1YTN5UGk1T0M2UjZLcUlHbGM0K2NwaEVX?=
 =?utf-8?B?TzVXMDdKR0xVVE9LVTVZMVZQZklzTW4yS3pvaUpIZ012S3NsZVVnVXpoL3h6?=
 =?utf-8?B?U2ViS0pVWWhuMGlzd1Fvd0UySjF4ZERtR1FsM0RldUdtamduWE5sa0xoeFNa?=
 =?utf-8?B?NVlCbjJWc2VPUGoyUXoxQzRMOTVrVjRxMTRvRmFBb001VVBhSGJzMkhWRTlU?=
 =?utf-8?B?Y0lTZ0JFZmUwSHJzNzU0R3FiUDRSa2ZlalA2MzZ6cVl4WGV1NnhTWGxFU2xN?=
 =?utf-8?B?TjNacTVxUi95VXhmRjhQclRqNGltZVlPTmhHa2lraTZ1TnRlTFF1UFliQ3A3?=
 =?utf-8?B?N2hlM3VyNGZsdE5RV1lWNXBHUEF6YkU0SzVKbVFQRVUvaEFoWTFLZWtGRUM4?=
 =?utf-8?B?TFJncmkvemM3SkxldTl4NTFXV3lLall4OXBUbExBOEZ3Y1VlOUo4Wld2bzFt?=
 =?utf-8?B?QTR4U1BWSVdTbFdZL2NYdzA4aWtQZG1nM0s5RkFwU1BFQWw1Vkh6cEo4aGhG?=
 =?utf-8?B?aklKQkVhck9uWFB2QnhUT3VaK0tDeG44NHR4MGhuRlBNTDFxaHgzdlJlamc5?=
 =?utf-8?B?TXZEQXM3Z0xMWDVDWnpiZGU2a2xnUE9lWVV6eGRncmpHSThGRFh0QWpxUW4w?=
 =?utf-8?B?V3puMGVCeFZIcGxFWG5Bd2tqOTlyZGxabHFrKytmc0hJbm9qaGtyQTgyajBP?=
 =?utf-8?B?KzhPbUVuM1A4WW5zdnBWbC9qdWpCRkhWdEVBSGpOTy9kUTVXRkFCK0dsUktz?=
 =?utf-8?B?TThoMytmM2owMTRPUm9MNEdZT3RxZkpGMXpFZlZGcWFEWjBVM1pCSVFSZjM2?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5F2098AB3C73A45BCEF9DE1AD99929D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad871859-58d1-45aa-363c-08db3af115eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 00:58:53.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlAg6iKnEI3MgC9zdvZAJGqAGx6gEm1DMkIfXd4gbIpHfbAT7PRI9UF3hyP4dSbZYfvn3BwdSBtFcmGFBmIV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFR1ZSwgMjAyMy0wNC0xMSBhdCAyMTo0OSArMDAwMCwgTGltb25jaWVsbG8sIE1h
cmlvIHdyb3RlOg0KPiBbUHVibGljXQ0KPiANCj4gPiANCj4gPiBPbiA0LzExLzIzIDIzOjE3LCBN
YXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiA+IFVzZXJzcGFjZSBjYW4ndCBlYXNpbHkgZGlz
Y292ZXIgaG93IG11Y2ggb2YgYSBzbGVlcCBjeWNsZSB3YXMgc3BlbnQgaW4gYQ0KPiA+ID4gaGFy
ZHdhcmUgc2xlZXAgc3RhdGUgd2l0aG91dCB1c2luZyBrZXJuZWwgdHJhY2luZyBhbmQgdmVuZG9y
IHNwZWNpZmljDQo+ID4gPiBzeXNmcw0KPiA+ID4gb3IgZGVidWdmcyBmaWxlcy4NCj4gPiA+IA0K
PiA+ID4gVG8gbWFrZSB0aGlzIGluZm9ybWF0aW9uIG1vcmUgZGlzY292ZXJhYmxlLCBpbnRyb2R1
Y2UgdHdvIG5ldyBzeXNmcyBmaWxlczoNCj4gPiA+IDEpIFRoZSB0aW1lIHNwZW50IGluIGEgaHcg
c2xlZXAgc3RhdGUgZm9yIGxhc3QgY3ljbGUuDQo+ID4gPiAyKSBUaGUgdGltZSBzcGVudCBpbiBh
IGh3IHNsZWVwIHN0YXRlIHNpbmNlIHRoZSBrZXJuZWwgYm9vdGVkDQo+ID4gPiBCb3RoIG9mIHRo
ZXNlIGZpbGVzIHdpbGwgYmUgcHJlc2VudCBvbmx5IGlmIHRoZSBzeXN0ZW0gc3VwcG9ydHMgczJp
ZGxlLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFy
aW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjYtPnY3Og0KPiA+ID4g
wqAqIFJlbmFtZSB0byBtYXhfaHdfc2xlZXAgKERhdmlkIEUgQm94KQ0KPiA+ID4gwqAqIERyb3Ag
b3ZlcmZsb3cgY2hlY2tzIChEYXZpZCBFIEJveCkNCj4gPiA+IHY1LT52NjoNCj4gPiA+IMKgKiBB
ZGQgdG90YWwgYXR0cmlidXRlIGFzIHdlbGwNCj4gPiA+IMKgKiBDaGFuZ2UgdGV4dCBmb3IgZG9j
dW1lbnRhdGlvbg0KPiA+ID4gwqAqIEFkanVzdCBmbG93IG9mIGlzX3Zpc2libGUgY2FsbGJhY2su
DQo+ID4gPiDCoCogSWYgb3ZlcmZsb3cgd2FzIGRldGVjdGVkIGluIHRvdGFsIGF0dHJpYnV0ZSBy
ZXR1cm4gLUVPVkVSRkxPVw0KPiA+ID4gwqAqIFJlbmFtZSBzeW1ib2wNCj4gPiA+IMKgKiBBZGQg
c3R1YiBmb3Igc3ltYm9sIGZvciBidWlsZHMgd2l0aG91dCBDT05GSUdfUE1fU0xFRVANCj4gPiA+
IHY0LT52NToNCj4gPiA+IMKgKiBQcm92aWRlIHRpbWUgaW4gbWljcm9zZWNvbmRzIGluc3RlYWQg
b2YgcGVyY2VudC4gVXNlcnNwYWNlIGNhbiBjb252ZXJ0DQo+ID4gPiDCoMKgIHRoaXMgaWYgZGVz
aXJhYmxlLg0KPiA+ID4gLS0tDQo+ID4gPiDCoERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtcG93ZXIgfCAyNCArKysrKysrKysrKysrKysrDQo+ID4gPiDCoGluY2x1ZGUvbGludXgvc3Vz
cGVuZC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysrDQo+ID4gPiDCoGtl
cm5lbC9wb3dlci9tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
MCArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCA2
OSBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L0FCSS90ZXN0aW5nL3N5c2ZzLXBvd2VyDQo+ID4gYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLXBvd2VyDQo+ID4gPiBpbmRleCBmOTlkNDMzZmYzMTEuLjA3MjNiNGRhZGZiZSAxMDA2
NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcG93ZXINCj4g
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcG93ZXINCj4gPiA+IEBA
IC00MTMsNiArNDEzLDMwIEBAIERlc2NyaXB0aW9uOg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBUaGUgL3N5cy9wb3dlci9zdXNwZW5kX3N0YXRzL2xhc3RfZmFpbGVkX3N0
ZXAgZmlsZQ0KPiA+ID4gY29udGFpbnMNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgdGhlIGxhc3QgZmFpbGVkIHN0ZXAgaW4gdGhlIHN1c3BlbmQvcmVzdW1lIHBhdGguDQo+
ID4gPiANCj4gPiA+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9wb3dlci9zdXNwZW5k
X3N0YXRzL2xhc3RfaHdfc2xlZXANCj4gPiA+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgSnVu
ZSAyMDIzDQo+ID4gPiArQ29udGFjdDrCoMKgwqDCoMKgwqDCoE1hcmlvIExpbW9uY2llbGxvIDxt
YXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+ID4gK0Rlc2NyaXB0aW9uOg0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFRoZSAvc3lzL3Bvd2VyL3N1c3BlbmRfc3RhdHMv
bGFzdF9od19zbGVlcCBmaWxlDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29udGFpbnMgdGhlIGR1cmF0aW9uIG9mIHRpbWUgc3BlbnQgaW4gYSBoYXJkd2FyZSBzbGVlcA0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXRlIGluIHRoZSBtb3N0IHJl
Y2VudCBzeXN0ZW0gc3VzcGVuZC1yZXN1bWUgY3ljbGUuDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgVGhpcyBudW1iZXIgaXMgbWVhc3VyZWQgaW4gbWljcm9zZWNvbmRzLg0K
PiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE5PVEU6IExpbWl0
YXRpb25zIGluIHRoZSBzaXplIG9mIHRoZSBoYXJkd2FyZSBjb3VudGVycyBtYXkNCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXVzZSB0aGlzIHZhbHVlIHRvIGJlIGluYWNj
dXJhdGUgaW4gbG9uZ2VyIHNsZWVwIGN5Y2xlcy4NCj4gPiANCj4gPiBIbW0gSSB0aG91Z2h0IHRo
YXQgdGhlIHBsYW4gd2FzIHRvIGFkZCBhIHNlcGFyYXRlIHN5c2ZzIGF0dHIgd2l0aA0KPiA+IHRo
ZSBtYXggdGltZSB0aGF0IHRoZSBodyBjb3VsZCByZXByZXNlbnQgaGVyZSwgc28gdGhhdCB1c2Vy
c3BhY2UNCj4gPiBhY3R1YWxseSBrbm93IHdoYXQgY29uc3RpdHV0ZXMgYSAibG9uZ2VyIHNsZWVw
IGN5Y2xlIiA/DQo+ID4gDQo+ID4gVGhhdCB3b3VsZCBzZWVtIGJldHRlciB0aGVuIHN1Y2ggYSBo
YW5kd2F2eSBjb21tZW50IGluIHRoZSBBQkkgZG9jcz8NCj4gDQo+IEkgb2J2aW91c2x5IG1pc3Vu
ZGVyc3Rvb2Qgd2hhdCB5b3Ugd2VyZSBzdWdnZXN0aW5nLg0KPiBJIGRvbid0IGJlbGlldmUgd2Ug
aGF2ZSBhIHdheSB0byBwcm9ncmFtbWF0aWNhbGx5IGRldGVybWluZSB3aGF0IHRoZSBoYXJkd2Fy
ZQ0KPiBJbnRlcm5hbGx5IHVzZXMgZm9yIGl0J3MgY291bnRlciB0byBrbm93IHRoaXMuDQo+IA0K
PiBTbyBpdCB3b3VsZCBuZWVkIHRvIGJlIGEgdGFibGUgb2Ygc29tZSBzb3J0cyB0aGF0IGEgZ2l2
ZW4gc3lzdGVtIGNhbiBzdXBwb3J0DQo+IHN1Y2ggdmFsdWUuwqAgSWYgd2UgZG8gdGhhdCwgd2Ug
Y2FuIGFjdHVhbGx5IGtub3cgd2hldGhlciB0byByZXR1cm4gYW4gZXJyb3INCj4gY29kZQ0KPiBs
aWtlIC1FT1ZFUkZMT1cgb3IgLUVJTlZBTCB0b28gaWYgdGhlIHN1c3BlbmQgd2FzIHRvbyBsb25n
Lg0KPiANCj4gSSB3b3VsZCBuZWVkIEludGVsIGd1eXMgdG8gc2hhcmUgdGhpcyBpbmZvcm1hdGlv
biB0aG91Z2ggd2hpY2ggc3lzdGVtcyBoYXZlDQo+IHdoaWNoIHNpemUgb2YgY291bnRlcnMgdG8g
bWFrZSB0aGlzIGhhcHBlbi4NCg0KRm9yIEludGVsIGFsbCB0aGUgczBpeCBjb3VudGVycyBhcmUg
MzIgYml0LiBJZiB0aGUgbWF4aW11bSBzbGVlcCB0aW1lIGlzDQpyZXBvcnRlZCBpbiBtaWNyb3Nl
Y29uZHMgaXQncyBqdXN0DQoNCiAgICAgICAgKCgxVUwgPDwgMzIpIC0gMSkgKiBzbHBfczBfcmVz
X2NvdW50ZXJfc3RlcCwNCg0Kd2hlcmUgc2xwX3MwX3Jlc19jb3VudGVyX3N0ZXAgaXMgdGhlIHBs
YXRmb3JtIHNwZWNpZmljIGNvdW50ZXIgZ3JhbnVsYXJpdHkgaW4NCm1pY3Jvc2Vjb25kcy7CoFRo
ZXJlIGFyZSBzb21lIHBsYXRmb3JtIHNwZWNpZmljIHR3ZWFrcyAob2YgY291cnNlKS4gSWYgeW91
DQpwcm92aWRlIGEgZnVuY3Rpb24gdG8gY2FsbCwgSSBjYW4gd3JpdGUgdGhlIHBhdGNoIGZvciBp
bnRlbF9wbWNfY29yZS4NCg0KPiANCj4gPiANCj4gPiA+ICsNCj4gPiA+ICtXaGF0OsKgwqDCoMKg
wqDCoMKgwqDCoMKgL3N5cy9wb3dlci9zdXNwZW5kX3N0YXRzL21heF9od19zbGVlcA0KPiA+ID4g
K0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBKdW5lIDIwMjMNCj4gPiA+ICtDb250YWN0OsKgwqDC
oMKgwqDCoMKgTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+
ID4gPiArRGVzY3JpcHRpb246DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
VGhlIC9zeXMvcG93ZXIvc3VzcGVuZF9zdGF0cy9tYXhfaHdfc2xlZXAgZmlsZQ0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRhaW5zIHRoZSBhZ2dyZWdhdGUgb2YgdGlt
ZSBzcGVudCBpbiBhIGhhcmR3YXJlIHNsZWVwDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3RhdGUgc2luY2UgdGhlIGtlcm5lbCB3YXMgYm9vdGVkLiBUaGlzIG51bWJlcg0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlzIG1lYXN1cmVkIGluIG1pY3Jv
c2Vjb25kcy4NCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBO
T1RFOiBMaW1pdGF0aW9ucyBpbiB0aGUgc2l6ZSBvZiB0aGUgaGFyZHdhcmUgY291bnRlcnMgbWF5
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2F1c2UgdGhpcyB2YWx1ZSB0
byBiZSBpbmFjY3VyYXRlIGluIGxvbmdlciBzbGVlcCBjeWNsZXMuDQo+ID4gDQo+ID4gTWF5YmUg
InRvdGFsX2h3X3NsZWVwIiBpbnN0ZWFkIG9mICJtYXhfaHdfc2xlZXAiID8gQWxzbyBzaW5jZSBt
YXggdG8NCj4gPiBtZSBzb3VuZHMgbGlrZSB0aGUgbGltaXQgb2YgdGhlIGxvbmdlc3Qgc2xlZXAg
dGhlIGh3IGNvdW50ZXJzIGNhbg0KPiA+IHJlZ2lzdGVyLCBzbyB0aGF0IGlzIGJpdCBjb25mdXNp
bmcgd2l0aCB0aGUgZGlzY3Vzc2lvbiBhYm91dCB0aG9zZQ0KPiA+IGxpbWl0cy4NCj4gDQo+IHRv
dGFsX2h3X3NsZWVwIGlzIGFjdHVhbGx5IHdoYXQgd2FzIGluIHY2IGFuZCBtYXhfaHdfc2xlZXAg
aXMgd2hhdCBzdWdnZXN0ZWQuDQo+IFRoYXQncyB3aHkgSSBnb3QgY29uZnVzZWQgYWJvdXQgd2hh
dCB5b3UgZ3V5cyBtZWFudC4NCg0KU29ycnksIEkgbWVhbnQgbWF4X2h3X3NsZWVwIGZvciB0aGUg
YWRkaXRpb25hbCBhdHRyaWJ1dGUgYXMgSGFucyBtZW50aW9uZWQuDQoNCkRhdmlkDQoNCj4gDQo+
ID4gDQo+ID4gUmVnYXJkcywNCj4gPiANCj4gPiBIYW5zDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4g
PiArDQo+ID4gPiDCoFdoYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL3Bvd2VyL3N5bmNfb25f
c3VzcGVuZA0KPiA+ID4gwqBEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgT2N0b2JlciAyMDE5DQo+
ID4gPiDCoENvbnRhY3Q6wqDCoMKgwqDCoMKgwqBKb25hcyBNZXVyZXIgPGpvbmFzQGZyZWVzb3Vy
Y2VzLm9yZz4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1c3BlbmQuaCBiL2lu
Y2x1ZGUvbGludXgvc3VzcGVuZC5oDQo+ID4gPiBpbmRleCBjZmUxOWEwMjg5MTguLjgxOWU5Njc3
ZmQxMCAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VzcGVuZC5oDQo+ID4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L3N1c3BlbmQuaA0KPiA+ID4gQEAgLTY4LDYgKzY4LDggQEAgc3Ry
dWN0IHN1c3BlbmRfc3RhdHMgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGludMKgwqDCoMKgwqBs
YXN0X2ZhaWxlZF9lcnJubzsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnTCoMKgwqDCoMKgZXJy
bm9bUkVDX0ZBSUxFRF9OVU1dOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGludMKgwqDCoMKgwqBs
YXN0X2ZhaWxlZF9zdGVwOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTY0wqDCoMKgwqDCoGxhc3Rf
aHdfc2xlZXA7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqB1NjTCoMKgwqDCoMKgbWF4X2h3X3NsZWVw
Ow0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGVudW0gc3VzcGVuZF9zdGF0X3N0ZXDCoMKgZmFpbGVk
X3N0ZXBzW1JFQ19GQUlMRURfTlVNXTsNCj4gPiA+IMKgfTsNCj4gPiA+IA0KPiA+ID4gQEAgLTQ4
OSw2ICs0OTEsNyBAQCB2b2lkIHJlc3RvcmVfcHJvY2Vzc29yX3N0YXRlKHZvaWQpOw0KPiA+ID4g
wqBleHRlcm4gaW50IHJlZ2lzdGVyX3BtX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAq
bmIpOw0KPiA+ID4gwqBleHRlcm4gaW50IHVucmVnaXN0ZXJfcG1fbm90aWZpZXIoc3RydWN0IG5v
dGlmaWVyX2Jsb2NrICpuYik7DQo+ID4gPiDCoGV4dGVybiB2b2lkIGtzeXNfc3luY19oZWxwZXIo
dm9pZCk7DQo+ID4gPiArZXh0ZXJuIHZvaWQgcG1fcmVwb3J0X2h3X3NsZWVwX3RpbWUodTY0IHQp
Ow0KPiA+ID4gDQo+ID4gPiDCoCNkZWZpbmUgcG1fbm90aWZpZXIoZm4sIHByaSkge8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoHN0YXRpYyBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgZm4jI19uYiA9wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiA+ID4gQEAgLTUyNiw2ICs1MjksOCBAQCBz
dGF0aWMgaW5saW5lIGludCB1bnJlZ2lzdGVyX3BtX25vdGlmaWVyKHN0cnVjdA0KPiA+IG5vdGlm
aWVyX2Jsb2NrICpuYikNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gPiA+IMKg
fQ0KPiA+ID4gDQo+ID4gPiArc3RhdGljIGlubGluZSB2b2lkIHBtX3JlcG9ydF9od19zbGVlcF90
aW1lKHU2NCB0KSB7fTsNCj4gPiA+ICsNCj4gPiA+IMKgc3RhdGljIGlubGluZSB2b2lkIGtzeXNf
c3luY19oZWxwZXIodm9pZCkge30NCj4gPiA+IA0KPiA+ID4gwqAjZGVmaW5lIHBtX25vdGlmaWVy
KGZuLCBwcmkpwqDCoMKgZG8geyAodm9pZCkoZm4pOyB9IHdoaWxlICgwKQ0KPiA+ID4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9wb3dlci9tYWluLmMgYi9rZXJuZWwvcG93ZXIvbWFpbi5jDQo+ID4gPiBp
bmRleCAzMWVjNGE5YjlkNzAuLmE1NTQ2YjkxZWNjOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5l
bC9wb3dlci9tYWluLmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9wb3dlci9tYWluLmMNCj4gPiA+IEBA
IC02LDYgKzYsNyBAQA0KPiA+ID4gwqAgKiBDb3B5cmlnaHQgKGMpIDIwMDMgT3BlbiBTb3VyY2Ug
RGV2ZWxvcG1lbnQgTGFiDQo+ID4gPiDCoCAqLw0KPiA+ID4gDQo+ID4gPiArI2luY2x1ZGUgPGxp
bnV4L2FjcGkuaD4NCj4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiA+ID4gwqAj
aW5jbHVkZSA8bGludXgva29iamVjdC5oPg0KPiA+ID4gwqAjaW5jbHVkZSA8bGludXgvc3RyaW5n
Lmg+DQo+ID4gPiBAQCAtODMsNiArODQsMTMgQEAgaW50IHVucmVnaXN0ZXJfcG1fbm90aWZpZXIo
c3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYikNCj4gPiA+IMKgfQ0KPiA+ID4gwqBFWFBPUlRfU1lN
Qk9MX0dQTCh1bnJlZ2lzdGVyX3BtX25vdGlmaWVyKTsNCj4gPiA+IA0KPiA+ID4gK3ZvaWQgcG1f
cmVwb3J0X2h3X3NsZWVwX3RpbWUodTY0IHQpDQo+ID4gPiArew0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgc3VzcGVuZF9zdGF0cy5sYXN0X2h3X3NsZWVwID0gdDsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oHN1c3BlbmRfc3RhdHMubWF4X2h3X3NsZWVwICs9IHQ7DQo+ID4gPiArfQ0KPiA+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKHBtX3JlcG9ydF9od19zbGVlcF90aW1lKTsNCj4gPiA+ICsNCj4gPiA+IMKg
aW50IHBtX25vdGlmaWVyX2NhbGxfY2hhaW5fcm9idXN0KHVuc2lnbmVkIGxvbmcgdmFsX3VwLCB1
bnNpZ25lZCBsb25nDQo+ID4gdmFsX2Rvd24pDQo+ID4gPiDCoHsNCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqBpbnQgcmV0Ow0KPiA+ID4gQEAgLTM3Nyw2ICszODUsMjIgQEAgc3RhdGljIHNzaXplX3Qg
bGFzdF9mYWlsZWRfc3RlcF9zaG93KHN0cnVjdCBrb2JqZWN0DQo+ID4gKmtvYmosDQo+ID4gPiDC
oH0NCj4gPiA+IMKgc3RhdGljIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSBsYXN0X2ZhaWxlZF9zdGVw
ID0NCj4gPiBfX0FUVFJfUk8obGFzdF9mYWlsZWRfc3RlcCk7DQo+ID4gPiANCj4gPiA+ICtzdGF0
aWMgc3NpemVfdCBsYXN0X2h3X3NsZWVwX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosDQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGtvYmpfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpDQo+ID4gPiArew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHN5
c2ZzX2VtaXQoYnVmLCAiJWxsdVxuIiwgc3VzcGVuZF9zdGF0cy5sYXN0X2h3X3NsZWVwKTsNCj4g
PiA+ICt9DQo+ID4gPiArc3RhdGljIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSBsYXN0X2h3X3NsZWVw
ID0gX19BVFRSX1JPKGxhc3RfaHdfc2xlZXApOw0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBzc2l6
ZV90IG1heF9od19zbGVlcF9zaG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYXR0ciwgY2hh
ciAqYnVmKQ0KPiA+ID4gK3sNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChzdXNwZW5kX3N0YXRz
Lm1heF9od19zbGVlcCA9PSAtRU9WRVJGTE9XKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBzdXNwZW5kX3N0YXRzLm1heF9od19zbGVlcDsNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVsbHVcbiIsIHN1c3BlbmRfc3RhdHMu
bWF4X2h3X3NsZWVwKTsNCj4gPiA+ICt9DQo+ID4gPiArc3RhdGljIHN0cnVjdCBrb2JqX2F0dHJp
YnV0ZSBtYXhfaHdfc2xlZXAgPQ0KPiA+IF9fQVRUUl9STyhtYXhfaHdfc2xlZXApOw0KPiA+ID4g
Kw0KPiA+ID4gwqBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqc3VzcGVuZF9hdHRyc1tdID0gew0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoCZzdWNjZXNzLmF0dHIsDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgJmZhaWwuYXR0ciwNCj4gPiA+IEBAIC0zOTEsMTIgKzQxNSwyOCBAQCBzdGF0aWMgc3RydWN0
IGF0dHJpYnV0ZSAqc3VzcGVuZF9hdHRyc1tdID0gew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCZs
YXN0X2ZhaWxlZF9kZXYuYXR0ciwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAmbGFzdF9mYWlsZWRf
ZXJybm8uYXR0ciwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAmbGFzdF9mYWlsZWRfc3RlcC5hdHRy
LA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgJmxhc3RfaHdfc2xlZXAuYXR0ciwNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoCZtYXhfaHdfc2xlZXAuYXR0ciwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBOVUxM
LA0KPiA+ID4gwqB9Ow0KPiA+ID4gDQo+ID4gPiArc3RhdGljIHVtb2RlX3Qgc3VzcGVuZF9hdHRy
X2lzX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdA0KPiA+IGF0dHJpYnV0ZSAq
YXR0ciwgaW50IGlkeCkNCj4gPiA+ICt7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoYXR0ciAh
PSAmbGFzdF9od19zbGVlcC5hdHRyICYmDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0
ciAhPSAmbWF4X2h3X3NsZWVwLmF0dHIpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIDA0NDQ7DQo+ID4gPiArDQo+ID4gPiArI2lmZGVmIENPTkZJR19BQ1BJDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoYWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElfRkFEVF9M
T1dfUE9XRVJfUzApDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDA0NDQ7DQo+ID4gPiArI2VuZGlmDQo+ID4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4g
PiA+ICt9DQo+ID4gPiArDQo+ID4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dy
b3VwIHN1c3BlbmRfYXR0cl9ncm91cCA9IHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9
ICJzdXNwZW5kX3N0YXRzIiwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAuYXR0cnMgPSBzdXNwZW5k
X2F0dHJzLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgLmlzX3Zpc2libGUgPSBzdXNwZW5kX2F0dHJf
aXNfdmlzaWJsZSwNCj4gPiA+IMKgfTsNCj4gPiA+IA0KPiA+ID4gwqAjaWZkZWYgQ09ORklHX0RF
QlVHX0ZTDQoNCg==
