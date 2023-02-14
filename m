Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB931695939
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBNGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBNGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:34:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B190246A2;
        Mon, 13 Feb 2023 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676356492; x=1707892492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rtp2uz/JKb9mAkg5BBdOQmjAC5Ud7bCVvsrebMdTtzw=;
  b=atxeydgDIDIBnAY81mdCgaF0CMrCrrNlBeKPZWwpauLw8SE9q0rUKlJ6
   c3MaUHMk0n7e2yoepxfDdmT0/DrkRM2e28tLlbWKffQPOizrnhSVMoxL/
   ThHkF9ntCxQAIqmfB2TwGgbVA0rBvo+3DBWfC7OIfHydOW7T0n0I3y7dn
   Wt0J2RmXYOR3p/Pi1Wmq1i1cUHotzgC/RRo+0anLTgvvtYSB4LlpGyMb/
   F6t0DAANiRBR4WSwYOe+/hPaAvYUBAa3Q8qikyeOW6qJZKzTmuf3uI3Yd
   ywbJ+9x4fYPU+7amUpB1kpPu2XAWsWqe/CCKWn0trz48svo9c4DLo0eQp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310724180"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310724180"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:34:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757875972"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="757875972"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2023 22:34:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:34:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 22:34:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 22:34:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqjqT/X+ussb3fczAkeha3v8XwgmFCalQXZzEJ2yqbIDGnMjz8bEQS6ExLzjsqOEP3TjnpYajsY6aEwSFWKRTFoSLjsDIMpmc/D4qDBqjWH0aFOwjKhU1D885a3YpbixZyMkmIOyZmwAD2i4QgxfA9CcbyTnwfytsfv/Lfl/e2G5LlyZBiIl3gOWgwrH1GR9SGPXbwvWUKYhXuhvOnGklPBwECY6bcK1cODeIuaGqCPCdlcpclufj3+9NVK8Zvim51/6kzZGd3kPdk2gPQvfUd6P/UtncCcdNbPZGPhYJhgF5AtUlsr0bYw7ywdQFeU4BFipJlM0/WXOrzdm+o9sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtp2uz/JKb9mAkg5BBdOQmjAC5Ud7bCVvsrebMdTtzw=;
 b=FgrV3h2nOx0z6Hq0ieMNNiMn6TtxpZGXT06DCeG/FXX6hSf2uTuGQ2Lb1sg6HK6d2mAzjKFXBUukvla9nfENoEuUC3bBVqJ3ZOgEDa6ix0Ldi+KkUc7fVLDA73/l2Cd/EUbfxGG0YcZ9EZf9tArv9a2x6ckmMSP1ODzuGkPq+JMn6Atcz2vVqBbSxMg6qgTjRX3qU7G6lAEEQMpP6IyqEHcUoccVnF4E9hfI44uo/6ZrpKXt47PgTaHGROEYVje40l7XsGYAPjthbfgNceUanF4rTNJJfcGl/bzN+ZujHwSJAYxlAlqdSUGqUqqQ90XCoUDoDAG/My3Xw19p5LNzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:34:33 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::4166:eaf4:4a68:ee3c]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::4166:eaf4:4a68:ee3c%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:34:33 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
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
Subject: RE: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7MNbMAgAHGBHA=
Date:   Tue, 14 Feb 2023 06:34:33 +0000
Message-ID: <DM6PR11MB4316A2B56077577746C9E0C78DA29@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <b6555f44430286416c66e2ecd7ff4f4b2bd3642e.camel@intel.com>
In-Reply-To: <b6555f44430286416c66e2ecd7ff4f4b2bd3642e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|CY8PR11MB7687:EE_
x-ms-office365-filtering-correlation-id: 937b70e7-1a64-4e54-b93b-08db0e5588f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWdn/aIIB8mbdAyGLilGvJ7UfGAnPHQy/GcFx9m8D+PGMdBP33LOowmAfShJU6gTAOdcFOnERKAjbinvIU+b3tLq3fvHi1VUsHOrgxJehXwk+Hkx9aD+D8hSPE9MBzec5wJYIr/RWyTFFcu7FFJo10FV3/M+UNgblyMOs1ke/FF5qTxzF+Ik75Dn2Z+cFqwo4Ad4RptHX+SBEm1zCx9Mu+tJi6f2G8oWR7xTJfmi2OwmA4e/hiQpbS3DooREr/6RLJxRdMEmbbPsuXla60iiBmOZqpDwljTISakvwagAStKMwPPTglFjvkt1Wbf6bTxpHXMWDmms81A7isk6H95MKwgmzYXZE8tokkWX0SDkvoOuhglQtN83jubItPyHNHsjD0X13U9mlpvJSyj515fDtIMqC1lA4kVXq3UVWLyJqh1elwHk8uWJQsOJYjhSacMz/LvhfmX/Z2TqVHY1vQdV44Ef9Oqx7iyLT5MWhnrpDwecqPfvHYMlDUatdL0N9fZB5xzgPZD3UCc3xscP659rk9cpukAUya4UKJc7hgeUZOleE0rDZl3qjhzD9NpjIxh3yziYKeg03ctFQML3TJcCL50Rdy9nP9EeQqSO0W90oAPvxwBbJnPXEutwdDnF3sBLrXJFjOyPweTKMVSvIXjIURGzdJGGIINnF6S7XyCBHLmjx4fXK2GHOBc3kASSS3JT75yrAeiZGv1331n9VVJdAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(38070700005)(33656002)(82960400001)(86362001)(66556008)(66946007)(54906003)(66446008)(4326008)(76116006)(64756008)(66476007)(316002)(478600001)(8676002)(71200400001)(110136005)(7696005)(52536014)(41300700001)(8936002)(5660300002)(2906002)(38100700002)(122000001)(83380400001)(55016003)(186003)(26005)(9686003)(6506007)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THh6MEFrYzRsTEJkNzBaQ0RrdFlqdmhqWUxYaTBIOXlHSG13UkE3d1d4Z1JY?=
 =?utf-8?B?dSswVVg1d1VUckJFd0FITWN1L3FHUjJCd2NHRHZJV3puYzArZjRLVFA0M3BC?=
 =?utf-8?B?UnRCcldHeGsrS25YREt3UkpsV2JnWWJIblVEZ21WUUQ3MEw3dTA1c2lWTFNB?=
 =?utf-8?B?M1UzTDFzNDNrMkF5Q21HQng0aitOZkRLNVdDUkhGWm1GVDFrdFRXTTlrSVlu?=
 =?utf-8?B?Yjhrc0lkTVJQemllRnNkWEJkVUtwWUhiRXk1MWFjMWdlTy9HTVJISlV2LzRE?=
 =?utf-8?B?a3puYVhTT0Zxb2tUVE1XU2RZNjJIN3I3dnJDL2swWkFsOHZMejFUK2tkdUps?=
 =?utf-8?B?SVJkeHFUUDF0c2Fpek5NK211azUwamV1eFRqTXArWnA2dUltSjhUZi9qU1ZD?=
 =?utf-8?B?cVEyOGc3RUNVY3V6cFFENHc0ejRaQXVIYkZqM3ZjSjJtK2xPSjZkWHdZZTdH?=
 =?utf-8?B?Y08xaG9ESEkvMUlOVWN1eW9kSEpZSFRWYk52N3BrWGloamVYZWQzREVsS2xy?=
 =?utf-8?B?Y0huQ1JCWUZRTmwvZUk3N0JrUmY0V1krOHN6U0NHYkNRalpNcTVudStaTVRy?=
 =?utf-8?B?eDVKRXFWWEg5RE5XYTFlYUUvQkdTU2RzaFdXdjZPVm8yQm5SdmszOXpKU01l?=
 =?utf-8?B?dEgzRXNtcDVVYVUzWG9LWnljT0ltejc0alh0RlJaOW1rc2xTUDE0cHdaUUpu?=
 =?utf-8?B?alAyamw3SU9DVmtkdW9XZmpYVzQ0OFZnUTNoNzBGNVdHQzN4MVNBUSthQSto?=
 =?utf-8?B?RDY0TndzcVdkN3c2VThBelppZWh4QWVMMUl5NjNSMXdHRXQxbktTZXJYZ09V?=
 =?utf-8?B?dkYxTWxiTGplOEpUQVdUeXQwN1JaRWJPTEJZTmU2cUMzZDliVXk1Q280d0Vl?=
 =?utf-8?B?VGlsa0d6UVlWSW1lQ0NJVW9nNUphZThsMTg5MWR5YkgzbHFvT3JvUk1oZTVN?=
 =?utf-8?B?aDQxbkUxamlMVk4vdFVRUnJ5SUtPZGJnb1FweHRWdDVjUG4vVk4rdzQ3M1Yr?=
 =?utf-8?B?S2pWQWJyNjVsd3gyQzVhaWhlUDdhZ2t1NitEemw0Wmd3L3hGRmNnVExRcit4?=
 =?utf-8?B?bngzTDduaVdkVVV3aTFTelYydnRFMFJJS3A3eDVzOE16aTZWU0RNblBDT1N2?=
 =?utf-8?B?VVRXcUhHVTBIajJpWFluaDJRbnBiRjZwRzdBaENacmNKSHZaazVqTDl3SUl0?=
 =?utf-8?B?dGxvczNyUmJlc3k3TTVZdFc5dWlGc0IzaFh4SWw3ZG5FamlPTnVQRjBJUXh5?=
 =?utf-8?B?SDgybHRuT25sZzEyTDRSNFhNc2pjRWFjdGRhY3lYRmZQalQ0djB3TEh0RVFF?=
 =?utf-8?B?NFA0K3N5TE1qL0k4VzdVVU5wT1lycm1ESXh4TG5Lc1p5aVQ4L1pJRUhCSkhN?=
 =?utf-8?B?c0NnSUl1K2VKOFp3RlBrbXl0MFNqMHFTWFNWQ3d3R2V0YnE3OURiY1BZbFM4?=
 =?utf-8?B?Y2o1NFcvU0FVM3pVRG4vT0dvTUpPNW93OXRHZm1Peng2QTVveWF6K29iZXlQ?=
 =?utf-8?B?eDJFLzJxUXFjMFFJSEYzcmptVFhWR3FjZ2trajBpMkdXRUtyc0YycURJTTA3?=
 =?utf-8?B?d2hYS1Y0VnZFVEExVlh0a0JLamNZZUUxMVNma0xidTE1ODFtVDl1MUxBMDFo?=
 =?utf-8?B?VE5udHJBSDI3aDNQa0QrOHNra3BGS0tvb2xab3U4TlByeXBWOTEvOGZTUHYy?=
 =?utf-8?B?TjVEVHRKU3ZGejEzR0FEQjA2ek9BMlNoSUdaVGJ5VzFERnJuV3p6RFA5RHNH?=
 =?utf-8?B?RUt3dUlnRlJ0cEhiNlBhR2ZwMTcrQVV5KzJja1ZCNlRaRnhyT0dJSFFPSFBJ?=
 =?utf-8?B?MTY1U0lnZ0tPWWJxT1JSR1ZmbkJVd0t0akpwUWR3WkRtNjVkbmN0TXYxS0xz?=
 =?utf-8?B?ekErRTg1LzFSRlcyN0E0aDAycmxLN3htdEFvS3lrbzVVQWVkakh2VUpuc25j?=
 =?utf-8?B?K215UUErd1BlWnRRWWlTOUVWRUJMUElkemVLRW5sRGVGYUlJMXkrYmU3ODZ6?=
 =?utf-8?B?RGxVa0F4aFppMnhtdmJaaXdCTmZMUjRVWGF6U2I1NnRNZ2ZzcjJPdXpKTFdv?=
 =?utf-8?B?NGI5R3FoaXpSQ0xwMkx5UGs5dDdOc09wdGkrZzVJdnNCVEM2c0o0R1FBU1RK?=
 =?utf-8?Q?oJ7GTczbH98xTd79ue2v7eNGg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937b70e7-1a64-4e54-b93b-08db0e5588f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:34:33.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1jjwP9I11yfmpkjq8jf1yvg1I/uFe24YUcYEV9pbaqI2ExahiHIk412yrN5HEFlAFKKoFmQv1GuCmUxd72APg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3Jpbml2YXMsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW5kcnV2YWRhLCBTcmluaXZhcyA8c3Jpbml2YXMucGFu
ZHJ1dmFkYUBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMTMsIDIwMjMgMTE6
MjEgQU0NCj4gDQo+IE9uIE1vbiwgMjAyMy0wMi0xMyBhdCAxMDoyMyArMDgwMCwgV2VudG9uZyBX
dSB3cm90ZToNCj4gPg0KPiANCj4gdjIgd2l0aG91dCBjaGFuZ2UgbG9nLCB3aHk/DQoNClRoaXMg
YWRkcmVzc2VkICdtZWlfY3NpLmM6KC50ZXh0KzB4MWE2KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBfX3VkaXZkaTMnIGlzc3VlIG9uIGkzODYgYXJjaC4gSSB3aWxsIGFkZCBjaGFuZ2UgbG9nIG9u
IGZvbGxvd2luZyB2ZXJzaW9uLg0KDQo+IA0KPiA+IEludGVsIFZpc3VhbCBTZW5zaW5nIENvbnRy
b2xsZXIgKElWU0MpLCBjb2RlbmFtZWQgIkNsb3ZlciBGYWxscyIsIGlzIGENCj4gPiBjb21wYW5p
b24gY2hpcCBkZXNpZ25lZCB0byBwcm92aWRlIHNlY3VyZSBhbmQgbG93IHBvd2VyIHZpc2lvbg0K
PiA+IGNhcGFiaWxpdHkgdG8gSUEgcGxhdGZvcm1zLiBJVlNDIGlzIGF2YWlsYWJsZSBpbiBleGlz
dGluZyBjb21tZXJjaWFsDQo+ID4gcGxhdGZvcm1zIGZyb20gbXVsdGlwbGUgT0VNcy4NCj4gPg0K
PiA+IFRoZSBwcmltYXJ5IHVzZSBjYXNlIG9mIElWU0MgaXMgdG8gYnJpbmcgaW4gY29udGV4dCBh
d2FyZW5lc3MuIElWU0MNCj4gPiBpbnRlcmZhY2VzIGRpcmVjdGx5IHdpdGggdGhlIHBsYXRmb3Jt
IG1haW4gY2FtZXJhIHNlbnNvciB2aWEgYSBDU0ktMg0KPiA+IGxpbmsgYW5kIHByb2Nlc3NlcyB0
aGUgaW1hZ2UgZGF0YSB3aXRoIHRoZSBlbWJlZGRlZCBBSSBlbmdpbmUuIFRoZQ0KPiA+IGRldGVj
dGVkIGV2ZW50cyBhcmUgc2VudCBvdmVyIEkyQyB0byBJU0ggKEludGVsIFNlbnNvciBIdWIpIGZv
cg0KPiA+IGFkZGl0aW9uYWwgZGF0YSBmdXNpb24gZnJvbSBtdWx0aXBsZSBzZW5zb3JzLiBUaGUg
ZnVzaW9uIHJlc3VsdHMgYXJlDQo+ID4gdXNlZCB0byBpbXBsZW1lbnQgYWR2YW5jZWQgdXNlIGNh
c2VzIGxpa2U6DQo+ID4gwqAtIEZhY2UgZGV0ZWN0aW9uIHRvIHVubG9jayBzY3JlZW4NCj4gPiDC
oC0gRGV0ZWN0IHVzZXIgcHJlc2VuY2UgdG8gbWFuYWdlIGJhY2tsaWdodCBzZXR0aW5nIG9yIHdh
a2luZyB1cA0KPiA+IHN5c3RlbQ0KPiA+DQo+ID4gU2luY2UgdGhlIEltYWdlIFByb2Nlc3Npbmcg
VW5pdChJUFUpIHVzZWQgb24gdGhlIGhvc3QgcHJvY2Vzc29yIG5lZWRzDQo+ID4gdG8gY29uZmln
dXJlIHRoZSBDU0ktMiBsaW5rIGluIG5vcm1hbCBjYW1lcmEgdXNhZ2VzLCB0aGUgQ1NJLTIgbGlu
aw0KPiA+IGFuZCBjYW1lcmEgc2Vuc29yIGNhbiBvbmx5IGJlIHVzZWQgaW4gbXV0dWFsbHktZXhj
bHVzaXZlIHdheXMgYnkgaG9zdA0KPiA+IElQVSBhbmQgSVZTQy4gQnkgZGVmYXVsdCB0aGUgSVZT
QyBvd25zIHRoZSBDU0ktMiBsaW5rIGFuZCBjYW1lcmENCj4gPiBzZW5zb3IuIFRoZSBJUFUgZHJp
dmVyIGNhbiB0YWtlIG93bmVyc2hpcCBvZiB0aGUgQ1NJLTIgbGluayBhbmQgY2FtZXJhDQo+ID4g
c2Vuc29yIHVzaW5nIGludGVyZmFjZXMgcHJvdmlkZWQgYnkgdGhpcyBJVlNDIGRyaXZlci4NCj4g
Pg0KPiA+IFN3aXRjaGluZyBvd25lcnNoaXAgcmVxdWlyZXMgYW4gaW50ZXJmYWNlIHdpdGggdHdv
IGRpZmZlcmVudCBoYXJkd2FyZQ0KPiA+IG1vZHVsZXMgaW5zaWRlIElWU0MuIFRoZSBzb2Z0d2Fy
ZSBpbnRlcmZhY2UgdG8gdGhlc2UgbW9kdWxlcyBpcyB2aWENCj4gPiBJbnRlbCBNRUkgKFRoZSBJ
bnRlbCBNYW5hZ2VtZW50IEVuZ2luZSkgY29tbWFuZHMuIFRoZXNlIHR3byBoYXJkd2FyZQ0KPiA+
IG1vZHVsZXMgaGF2ZSB0d28gZGlmZmVyZW50IE1FSSBVVUlEcyB0byBlbnVtZXJhdGUuIFRoZXNl
IGhhcmR3YXJlDQo+ID4gbW9kdWxlcw0KPiA+IGFyZToNCj4gPiDCoC0gQUNFIChBbGdvcml0aG0g
Q29udGV4dCBFbmdpbmUpOiBUaGlzIG1vZHVsZSBpcyBmb3IgYWxnb3JpdGhtDQo+ID4gY29tcHV0
aW5nIHdoZW4gSVZTQyBvd25zIGNhbWVyYSBzZW5zb3IuIEFsc28gQUNFIG1vZHVsZSBjb250cm9s
cw0KPiA+IGNhbWVyYSBzZW5zb3IncyBvd25lcnNoaXAuIFRoaXMgaGFyZHdhcmUgbW9kdWxlIGlz
IHVzZWQgdG8gc2V0DQo+ID4gb3duZXJzaGlwIG9mIGNhbWVyYSBzZW5zb3IuDQo+ID4gwqAtIENT
SSAoQ2FtZXJhIFNlcmlhbCBJbnRlcmZhY2UpOiBUaGlzIG1vZHVsZSBpcyB1c2VkIHRvIHJvdXRl
IGNhbWVyYQ0KPiA+IHNlbnNvciBkYXRhIGVpdGhlciB0byBJVlNDIG9yIHRvIGhvc3QgZm9yIElQ
VSBkcml2ZXIgYW5kIGFwcGxpY2F0aW9uLg0KPiA+DQo+ID4gSVZTQyBhbHNvIHByb3ZpZGVzIGEg
cHJpdmFjeSBtb2RlLiBXaGVuIHByaXZhY3kgbW9kZSBpcyB0dXJuZWQgb24sDQo+ID4gY2FtZXJh
IHNlbnNvciBjYW4ndCBiZSB1c2VkLiBUaGlzIG1lYW5zIHRoYXQgYm90aCBBQ0UgYW5kIGhvc3Qg
SVBVDQo+ID4gY2FuJ3QgZ2V0IGltYWdlIGRhdGEuIEFuZCB3aGVuIHRoaXMgbW9kZSBpcyB0dXJu
ZWQgb24sIGhvc3QgSVBVIGRyaXZlcg0KPiA+IGlzIGluZm9ybWVkIHZpYSBhIHJlZ2lzdGVyZWQg
Y2FsbGJhY2ssIHNvIHRoYXQgdXNlciBjYW4gYmUgbm90aWZpZWQuDQo+ID4NCj4gPiBJbiBzdW1t
YXJ5LCB0byBhY3F1aXJlIG93bmVyc2hpcCBvZiBjYW1lcmEgYnkgSVBVIGRyaXZlciwgZmlyc3Qg
QUNFDQo+ID4gbW9kdWxlIG5lZWRzIHRvIGJlIGluZm9ybWVkIG9mIG93bmVyc2hpcCBhbmQgdGhl
biB0byBzZXR1cCBNSVBJIENTSS0yDQo+ID4gbGluayBmb3IgdGhlIGNhbWVyYSBzZW5zb3IgYW5k
IElQVS4NCj4gPg0KPiA+IEltcGxlbWVudGF0aW9uOg0KPiA+IFRoZXJlIGFyZSB0d28gZGlmZmVy
ZW50IGRyaXZlcnMgdG8gaGFuZGxlIEFDRSBhbmQgQ1NJIGhhcmR3YXJlIG1vZHVsZXMNCj4gPiBp
bnNpZGUgSVZTQy4NCj4gPiDCoC0gbWVpX2NzaTogTUVJIGNsaWVudCBkcml2ZXIgdG8gc2VuZCBj
b21tYW5kcyBhbmQgcmVjZWl2ZQ0KPiA+IG5vdGlmaWNhdGlvbnMgZnJvbSBDU0kgbW9kdWxlLg0K
PiA+IMKgLSBtZWlfYWNlOiBNRUkgY2xpZW50IGRyaXZlciB0byBzZW5kIGNvbW1hbmRzIGFuZCBn
ZXQgc3RhdHVzIGZyb20gQUNFDQo+ID4gbW9kdWxlLg0KPiA+IEludGVyZmFjZSBpcyBleHBvc2Vk
IHZpYSBpdnNjLmggdG8gYWNxdWlyZSBhbmQgcmVsZWFzZSBjYW1lcmEgc2Vuc29yDQo+ID4gYW5k
DQo+ID4gQ1NJLTIgbGluay4NCj4gPg0KPiA+IEJlbG93IGRpYWdyYW0gc2hvd3MgY29ubmVjdGlv
bnMgb2YgSVZTQy9JU0gvSVBVL0NhbWVyYSBzZW5zb3IuDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
LS0tLS0tLS0NCj4gPiA+IEhvc3QNCj4gPiA+IFByb2Nlc3Nvcg0KPiA+ID4gwqAgfA0KPiA+ID4N
Cj4gPiA+IMKgwqDCoMKgwqDCoCB8DQo+ID4gPiDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0tLS0t
wqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0tLS0twqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0N
Cj4gPiA+IC0twqDCoMKgwqAgfA0KPiA+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqDCoMKgwqAgfA0KPiA+ID4gfCBJMkMgfA0KPiA+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDC
oCBJUFXCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAgSVNIwqDCoMKgwqDCoCB8
wqDCoMKgwqDCoMKgIHxjYW1lcmENCj4gPiA+IGRyaXZlcnwtLXzCoCB8DQo+ID4gPiDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgfMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoCB8DQo+ID4gPiB8wqAgfMKgIHwNCj4g
PiA+IMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0tLS0tLS3CoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0t
LS0tLS3CoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0tLQ0KPiA+ID4gLS3CoCB8wqAgfA0KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwNCj4gPiA+IHzCoMKgwqDCoMKgwqDCoMKgIHzCoCB8DQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0t
LQ0KPiA+ID4gLS3CoCB8wqAgfA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwNCj4gPiA+IHzCoCB8wqAgfA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgSVZTQyBkcml2ZXINCj4gPiA+IHzCoCB8
wqAgfA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwNCj4gPiA+IHzCoCB8wqAgfA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0NCj4gPiA+IC0twqAgfMKgIHwNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8DQo+ID4gPiB8wqDCoMKgwqDCoMKgwqDCoCB8wqAgfA0KPiA+IC0tLS0t
LS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LXwtLS0tLQ0KPiA+IC0tLS18LS0tDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgQ1NJwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgSTJDDQo+ID4gfFNQ
ScKgwqDCoMKgwqAgfA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPiA+IHzCoMKgwqDCoMKg
wqDCoMKgIHwNCj4gPiAtLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0t
LS0tLS0tLS0tLS0tLS0NCj4gPiB8wqDCoMKgwqDCoMKgwqDCoCB8DQo+ID4gPiBJVlNDwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4gPiA+IHzCoMKgwqDCoMKgwqDC
oMKgIHwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwNCj4gPiA+IHzCoMKgwqDCoMKgwqDCoMKgIHwNCj4gPiA+IMKgwqDCoMKgwqAgLS0tLS0t
LS0tLS0tLS0tLS3CoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0tLS0tLS3CoMKgwqDCoMKgwqAgfA0K
PiA+ID4gfMKgwqDCoMKgwqDCoMKgwqAgfA0KPiA+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqAgfA0KPiA+ID4gfMKgwqDCoMKgwqDCoMKgwqAgfA0KPiA+ID4gwqDC
oMKgwqDCoCB8wqDCoMKgwqDCoCBDU0nCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgfMKgwqDCoMKg
wqAgQUNFwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIHwtLS0tLS0NCj4gPiA+IHzCoMKgwqDCoMKg
wqDCoMKgIHwNCj4gPiA+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+ID4gPiB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4gPiA+IMKgwqDCoMKgwqAgLS0tLS0tLS0t
LS0tLS0tLS3CoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IHzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgSTJDDQo+ID4g
PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4gPiAtLS0tLS0tLS0tLS0tLS0t
fC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0NCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IENTSQ0KPiA+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwNCj4gPiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IEkyQw0KPiA+IHwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgIGNhbWVyYSBzZW5zb3LCoMKgwqDCoMKgwqDCoCB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+IC0tLS18DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+DQo+
ID4gV2VudG9uZyBXdSAoMyk6DQo+ID4gwqAgbWVkaWE6IHBjaTogaW50ZWw6IGl2c2M6IEFkZCBD
U0kgc3VibW9kdWxlDQo+ID4gwqAgbWVkaWE6IHBjaTogaW50ZWw6IGl2c2M6IEFkZCBBQ0Ugc3Vi
bW9kdWxlDQo+ID4gwqAgbWVkaWE6IHBjaTogaW50ZWw6IGl2c2M6IEFkZCBhY3F1aXJlL3JlbGVh
c2UgQVBJIGZvciBpdnNjDQo+ID4NCj4gPiDCoGRyaXZlcnMvbWVkaWEvcGNpL0tjb25maWfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gPiDCoGRyaXZlcnMvbWVkaWEvcGNp
L2ludGVsL01ha2VmaWxlwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPiA+IMKgZHJpdmVycy9tZWRp
YS9wY2kvaW50ZWwvaXZzYy9LY29uZmlnwqDCoCB8wqAgMTIgKw0KPiA+IMKgZHJpdmVycy9tZWRp
YS9wY2kvaW50ZWwvaXZzYy9NYWtlZmlsZcKgIHzCoMKgIDcgKw0KPiA+IMKgZHJpdmVycy9tZWRp
YS9wY2kvaW50ZWwvaXZzYy9pdnNjLmPCoMKgwqAgfMKgIDg0ICsrKysrDQo+ID4gwqBkcml2ZXJz
L21lZGlhL3BjaS9pbnRlbC9pdnNjL21laV9hY2UuYyB8IDQ3Mg0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiDCoGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvbWVpX2FjZS5o
IHzCoCAzNiArKw0KPiA+IMKgZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9tZWlfY3NpLmMg
fCAzNDIgKysrKysrKysrKysrKysrKysrDQo+ID4gwqBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9p
dnNjL21laV9jc2kuaCB8wqAgNjAgKysrKw0KPiA+IMKgaW5jbHVkZS9saW51eC9pdnNjLmjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDc0ICsrKysNCj4gPiDCoDEwIGZp
bGVzIGNoYW5nZWQsIDEwOTAgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvS2NvbmZpZw0KPiA+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvTWFrZWZpbGUNCj4gPiDCoGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL2l2c2MuYw0KPiA+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvbWVpX2FjZS5j
DQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9t
ZWlfYWNlLmgNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BjaS9pbnRl
bC9pdnNjL21laV9jc2kuYw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEv
cGNpL2ludGVsL2l2c2MvbWVpX2NzaS5oDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9saW51eC9pdnNjLmgNCj4gPg0KDQo=
