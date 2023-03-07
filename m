Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8056AD902
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCGIRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCGIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:17:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA34FF04;
        Tue,  7 Mar 2023 00:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678177031; x=1709713031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TaegNd8ObaTrhDw5baHL1/pp9TQnUzRhKtlcgOsDWbI=;
  b=mj+WmKDBei12S5quYPlUa01qwePWXIr4DafqlYxPsa1Vh9M5FEbaKBgn
   JdDDuQCTXYwPG539BD0U9KAoOm4XIxn+n7SoxICHXX3+647qt9v2BQI5p
   4MwCG7k6mcLeWvg1o7qLwuEX87XCu50fyBR0OnjVPjpTlcvGbLbtC3tew
   N8N/acQyufG9CYb8Gh0jh8q1a6kWjjjWSOemTljaU6vVbWmW5ZUIJOyW8
   Fv05EhQDFmc/nst9cvzrlu+i+/qb90W7fQVB5cDgxpKSpJNZCivLhSw1w
   YaQBHiiTvX9eBhFY0PtXPkPpcNx2dUrPQqekgqTd0SdfIucp+eGAsdIlV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363415278"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="363415278"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669784210"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="669784210"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2023 00:17:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 00:17:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 00:17:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 00:17:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFBBaKwjZblaxDUuxme9agflot902g9raib7VHeJuL+Am3566TaNtCfb3ecfccUv16aKOxDC1KJw2oTyjmr1UQkm7A+ga9qyIsSQfc6g40VrNBwCRuC/BS46QTd4eLk76m2U6Pz7w3YRMitvJO9THhJcGkomnuicUGEXewx7nYWVWGLJegyvn/XF553mLuk4CnEy6z15RJcxpXV5iO614JAILFI5fqpwpdN43iPDERJAe5AF5Q2q3Y4Fyh/P+g02BACGtlf8F/kjY8Yz8u0+OC9hCbqEilh84Rq/Ygh5wj+FaK53IRWXRyEVaR2D0tJ1bcFF6qZamtHCsb+g0xttZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaegNd8ObaTrhDw5baHL1/pp9TQnUzRhKtlcgOsDWbI=;
 b=oTj7M7ol6rXtcW7Txncm45BSVYKEHbLdQo6pMBfuHZE/cZEj4fu1/i/36LxZg+Eq1bg13rOwC+hyWon6tKcASachFweluvZ72emJfURcw2mVYJbQC5UMIFVdC/gb43MQ/g7Pizqt0wcpPQz+atAIe0h+IpFYm28DNa7s/CVSqGx8q2wsutrBV5e6WpXZ7Y9hq1da6LlEqE85kaGFk5Kt1c037v0NudFSMh/vIEZI1hJ1Mgm1ZvfbFtV3Vdvupe8uTJwGVCAC0uZAOn86+W4EQ84g9by4K8ClMw/rk/ebwz4SgPqG4mucVSUIPsrz81/aIamQ5AyI/Uz6Xvtk8bc+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 08:17:05 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 08:17:04 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7l1BmAgAACFoCACULV0A==
Date:   Tue, 7 Mar 2023 08:17:04 +0000
Message-ID: <DM6PR11MB4316F4B72F98ADBF577412378DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
 <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
In-Reply-To: <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|CH0PR11MB5299:EE_
x-ms-office365-filtering-correlation-id: 512adb76-8943-4dc4-6a6d-08db1ee45605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sn6gIeGJ/uIObdq1Jfc+AcGX82MN12mhMgjJsVMEYhDLuk7fwgb5Vf7tvtXMYzZ/BKn5TbKd/CvazO3TtM0AsPH88w9NXKpv1YfZWrO7dnAsWAMe9SMKPalvGyT+8u7feGRiXfvvmt112Ul37SDAOSphmn/cd5hvqxcr+B1uQt9gKaLP2sCoU5NxxNAQtnsK/8Q1ufn8GKj+1j0jgPAIaV5mT5m+FY+G2dWRjWmVMZXsYFuvxJiGWlPReZw96TM5AnRrEBkVxqNZsJzYzlm9fIHyjJtwKSi6i4ibcUv7UvAvf2y93+RKtm48R92h92dReL948InSx5o4uGt2rV39ABjJ98V2mAbic6cCrefPee3iw1l7YDDC+koIW/1rTKj9lsp5xRFgktry3vjAULWDj/0XKXYTav/+1i7ZkiV7ojAiD/EggeJwfG0JMEHDXiruuOJ340ntTA0u/ChbCbKweqd9JhT4/BkIwNHb06Va3as1FPTYDC5kSXAXGR47yiO1hgiVDy/BUlVCPUjvWHppy+WSeUU9hgj7eeoTxfrPg/C77FzLxuQMibL2LBl3QltYg/WdsliHlowf7AE8sxuwjwKqa/hUZABeXqMGUsSJmu5j8Bcq9rZxArM8zCSGIi9juO4V2I72oE/olKh0uY0pRmMJ1wUf4pu4LBn6c9L/AqirxOOjSGwyqoJ/NdSWFQfsnBBFbjmB0VbH71JYz7GPAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199018)(66899018)(316002)(54906003)(110136005)(33656002)(55016003)(38070700005)(6506007)(38100700002)(86362001)(82960400001)(122000001)(53546011)(83380400001)(186003)(26005)(9686003)(71200400001)(7696005)(52536014)(8936002)(5660300002)(478600001)(4326008)(41300700001)(2906002)(66946007)(66446008)(8676002)(76116006)(64756008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjRwd3FLVXZySTR5UDFDOGlyY2NFdFBCMnlGNkJvR1FDS3BNU2o2YmZZZWRz?=
 =?utf-8?B?M2w4QW1JTEdVV09vWjdNV2d6R0pQREczYUthY01zZHBvdmZjZ0tSaEpnc205?=
 =?utf-8?B?VTlQeTF3YkhQcUNIbWpvYVMzTXEvQmQ3V2pUYW1BVlI5SERkMzVuUW9BalY3?=
 =?utf-8?B?ZGswV2tydUpIT3UzeC96dFdzTjY3NXZYUm9qa01XelgvYjlMSG5ETVdWd01H?=
 =?utf-8?B?R3hLK3FqVS9lTEU4aEkxbTE1em5SMzdZSVVubmh6MW9xZFJ2MGhiTzl5L0dO?=
 =?utf-8?B?K25vZytLTG5CVjVvTW5Xdm95QkI4OWI4SXg2T1lwN01PVWNLY2h0NHYzRHZh?=
 =?utf-8?B?TnphSDdJM0t3ajdXVjlKaXpyYUFMcnpFZ3B4Y2pmK2x5THNTbUxQSjViMzlj?=
 =?utf-8?B?Mk9hYnlNOUQ4L1pCRnZvNWlnbHpGcE90NWlXNWhsZE1uNHBWTU5idlNneWg4?=
 =?utf-8?B?Rk9LMlYrSWNCMGpkRVRkMHg5dmVXWTlXZTZDMVlSbmJXeUxwendCeHl6MTNS?=
 =?utf-8?B?QnY2RkJib2d5ZzJaMXl3K0oxYm1ZUXNTdURETEZIbFpNRSt2TnZqd3cvTWtX?=
 =?utf-8?B?eVNwYTFPQzRWTTMzc1JZY1U5aExhc2Y5WVljemJUMXFoQ1BwQWZQY0dHMmhQ?=
 =?utf-8?B?M3pFYnlNbERTQmg1aFhwMldtbVB2R2JJWDJ3RnZ1TEsxdllBdHNncDYyM284?=
 =?utf-8?B?LzJWSGVmcWlqS1JDVDgybjJrSVBxOGw3dFgyQm5RMFJFVUpHbmluL1dvWkRX?=
 =?utf-8?B?QXh3MTJkOWNVU0ZVRnlMaXZGdSszYUI0ODZxUGZpOWxqOGVJRlVIbm9kMVQ1?=
 =?utf-8?B?QlZLSGQ2NUJoRVZRSkF5bnplYmV5UFQ5NDF3SDE4WEU5eUt0UTdjVm9SUWJy?=
 =?utf-8?B?YnNHVHNtbTJQeWwzUXFQMEI1ZVhsdXRucjJrVy9GdFdjRjNzbnFHZjRGODdC?=
 =?utf-8?B?RWcyazFsZFc1THQ5QzhCdkh4dUVhV05GQXc0UG1XYmxPNXJkZmFwZy9IQXli?=
 =?utf-8?B?cXNjaW94aHhhUWJLaW9OTzFYbFNqbk9PNHJBb2RGbVprYlZ0N1ZXd2JtUE80?=
 =?utf-8?B?cjh0RkloQjVxL2N3RG9xeU40aEVVOFJyZEx1eWZYbkIvRjJXOWlaS0IrYjRC?=
 =?utf-8?B?UlhKREdsVkVrUm9nWEVOSmVBWmxNWXBjQzVsQzZ2MC9QYWZmZWZtTlh4N21x?=
 =?utf-8?B?UEcrbzRYcFEvMTAyYlNpa08zWEd0VHBPdGJ5Y0I0Nk02MzEzbFA2RnZUTDU3?=
 =?utf-8?B?MTg1bFN4RGhWN1BLcy9lQWZmU3dDdFNxeStSMlBBR1E4YTdwNDdjc1NSTkRH?=
 =?utf-8?B?MTc5UWVRTlJ6d3hYRHBSbFQrb25oRHVkRFN3aFNLbnJyRmsxRjd6Y0Z2MWla?=
 =?utf-8?B?cStXc1hVd2k2N2J1Tk1QM2VyRkZqbU51S2VFZnpaU2tGUlVla2FmalBDZXht?=
 =?utf-8?B?WWZlTk9pS1JHcXBtS2FXUmd0TlhpRmo1QXpOVFRvUmVRTUpaTXgzckhJSXlD?=
 =?utf-8?B?b0dOS0xhdG5udFBxVlZMcDFYMkFsM0t1NXBHQ3FoY0FxS0JhZy9USVcyRm9H?=
 =?utf-8?B?MHh5VlBjM0ZzV0dzQUZDVHFkQnBleit3Q3gyRlkwTVo1bkVsNEkrNnJnRk0v?=
 =?utf-8?B?M2UrUzEvNzIwRGJIaXovL0ZLa1BoeU1heWdpa0ozQk95b05IcWc5Smw3MkNU?=
 =?utf-8?B?Y0FJVU9GZFJ6RWtIeWhxQTJic2o1dXEyL1poaFJ3MWJoUUhRL2xDdi9hZ08y?=
 =?utf-8?B?Z2d3czV6TnJtR1hteHZ5M2FNTkM2WWZNdjVvNWhEeFYvMy9nb3R6djJKOFht?=
 =?utf-8?B?RlVObDVNRnI3bEthcitMSytrWGpQdWxYbDRjVUJ0ekQ2QXVHZWlSZjRpdjI3?=
 =?utf-8?B?RVdCODBIMEg4UGpLaE1BVW85YnhuTmVPdyttUGw1VWMvV3R4SGZ2aDJzSVpu?=
 =?utf-8?B?OFVJblB5VzZ5UHFWZVF6MSttVWUranZnWStvT1JBUHVzaEZKck83OE1NRTR4?=
 =?utf-8?B?M2djK3Y5RTFhSU1jZmRkanNQYTlHZEwyMHhGR2VSNjMxNVlISXpKa01GKzJX?=
 =?utf-8?B?UStnS3dxaFI3aVVWNjhleUtiZHVUZko0aXpVUmxoaWdMUWUrbXhwWXJkeGVh?=
 =?utf-8?Q?tISOpFtuXkQwpBcEyo7dR74hN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512adb76-8943-4dc4-6a6d-08db1ee45605
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:17:04.7004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFfL4A9UfBrWlbXs7tshbqosyVsGKWYyD2IVpQqn2FX4Rs1f1ZeK+VJ3tKT++BDIOw3JTNsb5uvGGwFFp7LpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxLCAyMDIzIDY6
NDIgUE0NCj4gDQo+IEhpLA0KPiANCj4gT24gMy8xLzIzIDExOjM0LCBTYWthcmkgQWlsdXMgd3Jv
dGU6DQo+ID4gSGkgV2VudG9uZywNCj4gPg0KPiA+IE9uIE1vbiwgRmViIDEzLCAyMDIzIGF0IDEw
OjIzOjQ0QU0gKzA4MDAsIFdlbnRvbmcgV3Ugd3JvdGU6DQo+ID4+IEludGVsIFZpc3VhbCBTZW5z
aW5nIENvbnRyb2xsZXIgKElWU0MpLCBjb2RlbmFtZWQgIkNsb3ZlciBGYWxscyIsIGlzDQo+ID4+
IGEgY29tcGFuaW9uIGNoaXAgZGVzaWduZWQgdG8gcHJvdmlkZSBzZWN1cmUgYW5kIGxvdyBwb3dl
ciB2aXNpb24NCj4gPj4gY2FwYWJpbGl0eSB0byBJQSBwbGF0Zm9ybXMuIElWU0MgaXMgYXZhaWxh
YmxlIGluIGV4aXN0aW5nIGNvbW1lcmNpYWwNCj4gPj4gcGxhdGZvcm1zIGZyb20gbXVsdGlwbGUg
T0VNcy4NCj4gPj4NCj4gPj4gVGhlIHByaW1hcnkgdXNlIGNhc2Ugb2YgSVZTQyBpcyB0byBicmlu
ZyBpbiBjb250ZXh0IGF3YXJlbmVzcy4gSVZTQw0KPiA+PiBpbnRlcmZhY2VzIGRpcmVjdGx5IHdp
dGggdGhlIHBsYXRmb3JtIG1haW4gY2FtZXJhIHNlbnNvciB2aWEgYSBDU0ktMg0KPiA+PiBsaW5r
IGFuZCBwcm9jZXNzZXMgdGhlIGltYWdlIGRhdGEgd2l0aCB0aGUgZW1iZWRkZWQgQUkgZW5naW5l
LiBUaGUNCj4gPj4gZGV0ZWN0ZWQgZXZlbnRzIGFyZSBzZW50IG92ZXIgSTJDIHRvIElTSCAoSW50
ZWwgU2Vuc29yIEh1YikgZm9yDQo+ID4+IGFkZGl0aW9uYWwgZGF0YSBmdXNpb24gZnJvbSBtdWx0
aXBsZSBzZW5zb3JzLiBUaGUgZnVzaW9uIHJlc3VsdHMgYXJlDQo+ID4+IHVzZWQgdG8gaW1wbGVt
ZW50IGFkdmFuY2VkIHVzZSBjYXNlcyBsaWtlOg0KPiA+PiAgLSBGYWNlIGRldGVjdGlvbiB0byB1
bmxvY2sgc2NyZWVuDQo+ID4+ICAtIERldGVjdCB1c2VyIHByZXNlbmNlIHRvIG1hbmFnZSBiYWNr
bGlnaHQgc2V0dGluZyBvciB3YWtpbmcgdXANCj4gPj4gc3lzdGVtDQo+ID4+DQo+ID4+IFNpbmNl
IHRoZSBJbWFnZSBQcm9jZXNzaW5nIFVuaXQoSVBVKSB1c2VkIG9uIHRoZSBob3N0IHByb2Nlc3Nv
ciBuZWVkcw0KPiA+PiB0byBjb25maWd1cmUgdGhlIENTSS0yIGxpbmsgaW4gbm9ybWFsIGNhbWVy
YSB1c2FnZXMsIHRoZSBDU0ktMiBsaW5rDQo+ID4+IGFuZCBjYW1lcmEgc2Vuc29yIGNhbiBvbmx5
IGJlIHVzZWQgaW4gbXV0dWFsbHktZXhjbHVzaXZlIHdheXMgYnkgaG9zdA0KPiA+PiBJUFUgYW5k
IElWU0MuIEJ5IGRlZmF1bHQgdGhlIElWU0Mgb3ducyB0aGUgQ1NJLTIgbGluayBhbmQgY2FtZXJh
DQo+ID4+IHNlbnNvci4gVGhlIElQVSBkcml2ZXIgY2FuIHRha2Ugb3duZXJzaGlwIG9mIHRoZSBD
U0ktMiBsaW5rIGFuZA0KPiA+PiBjYW1lcmEgc2Vuc29yIHVzaW5nIGludGVyZmFjZXMgcHJvdmlk
ZWQgYnkgdGhpcyBJVlNDIGRyaXZlci4NCj4gPj4NCj4gPj4gU3dpdGNoaW5nIG93bmVyc2hpcCBy
ZXF1aXJlcyBhbiBpbnRlcmZhY2Ugd2l0aCB0d28gZGlmZmVyZW50IGhhcmR3YXJlDQo+ID4+IG1v
ZHVsZXMgaW5zaWRlIElWU0MuIFRoZSBzb2Z0d2FyZSBpbnRlcmZhY2UgdG8gdGhlc2UgbW9kdWxl
cyBpcyB2aWENCj4gPj4gSW50ZWwgTUVJIChUaGUgSW50ZWwgTWFuYWdlbWVudCBFbmdpbmUpIGNv
bW1hbmRzLiBUaGVzZSB0d28gaGFyZHdhcmUNCj4gPj4gbW9kdWxlcyBoYXZlIHR3byBkaWZmZXJl
bnQgTUVJIFVVSURzIHRvIGVudW1lcmF0ZS4gVGhlc2UgaGFyZHdhcmUNCj4gbW9kdWxlcyBhcmU6
DQo+ID4+ICAtIEFDRSAoQWxnb3JpdGhtIENvbnRleHQgRW5naW5lKTogVGhpcyBtb2R1bGUgaXMg
Zm9yIGFsZ29yaXRobQ0KPiA+PiBjb21wdXRpbmcgd2hlbiBJVlNDIG93bnMgY2FtZXJhIHNlbnNv
ci4gQWxzbyBBQ0UgbW9kdWxlIGNvbnRyb2xzDQo+ID4+IGNhbWVyYSBzZW5zb3IncyBvd25lcnNo
aXAuIFRoaXMgaGFyZHdhcmUgbW9kdWxlIGlzIHVzZWQgdG8gc2V0IG93bmVyc2hpcA0KPiBvZiBj
YW1lcmEgc2Vuc29yLg0KPiA+PiAgLSBDU0kgKENhbWVyYSBTZXJpYWwgSW50ZXJmYWNlKTogVGhp
cyBtb2R1bGUgaXMgdXNlZCB0byByb3V0ZSBjYW1lcmENCj4gPj4gc2Vuc29yIGRhdGEgZWl0aGVy
IHRvIElWU0Mgb3IgdG8gaG9zdCBmb3IgSVBVIGRyaXZlciBhbmQgYXBwbGljYXRpb24uDQo+ID4+
DQo+ID4+IElWU0MgYWxzbyBwcm92aWRlcyBhIHByaXZhY3kgbW9kZS4gV2hlbiBwcml2YWN5IG1v
ZGUgaXMgdHVybmVkIG9uLA0KPiA+PiBjYW1lcmEgc2Vuc29yIGNhbid0IGJlIHVzZWQuIFRoaXMg
bWVhbnMgdGhhdCBib3RoIEFDRSBhbmQgaG9zdCBJUFUNCj4gPj4gY2FuJ3QgZ2V0IGltYWdlIGRh
dGEuIEFuZCB3aGVuIHRoaXMgbW9kZSBpcyB0dXJuZWQgb24sIGhvc3QgSVBVDQo+ID4+IGRyaXZl
ciBpcyBpbmZvcm1lZCB2aWEgYSByZWdpc3RlcmVkIGNhbGxiYWNrLCBzbyB0aGF0IHVzZXIgY2Fu
IGJlIG5vdGlmaWVkLg0KPiA+Pg0KPiA+PiBJbiBzdW1tYXJ5LCB0byBhY3F1aXJlIG93bmVyc2hp
cCBvZiBjYW1lcmEgYnkgSVBVIGRyaXZlciwgZmlyc3QgQUNFDQo+ID4+IG1vZHVsZSBuZWVkcyB0
byBiZSBpbmZvcm1lZCBvZiBvd25lcnNoaXAgYW5kIHRoZW4gdG8gc2V0dXAgTUlQSSBDU0ktMg0K
PiA+PiBsaW5rIGZvciB0aGUgY2FtZXJhIHNlbnNvciBhbmQgSVBVLg0KPiA+DQo+ID4gSSB0aG91
Z2h0IHRoaXMgZm9yIGEgd2hpbGUgYW5kIGRpZCBzb21lIHJlc2VhcmNoLCBhbmQgSSBjYW4gc3Vn
Z2VzdA0KPiA+IHRoZQ0KPiA+IGZvbGxvd2luZzoNCj4gPg0KPiA+IC0gVGhlIElWU0Mgc3ViLWRl
dmljZSBpbXBsZW1lbnRzIGEgY29udHJvbCBmb3IgcHJpdmFjeSAoVjRMMl9DSURfUFJJVkFDWQ0K
PiA+ICAgaXMgYSBnb29kIGZpdCkuDQo+ID4NCj4gPiAtIENhbWVyYSBzZW5zb3IgYWNjZXNzIG5l
ZWRzIHRvIGJlIHJlcXVlc3RlZCBmcm9tIElWU0MgYmVmb3JlIGFjY2Vzc2luZyB0aGUNCj4gPiAg
IHNlbnNvciB2aWEgScKyQy4gVGhlIElWU0Mgb3duZXJzaGlwIGNvbnRyb2wgbmVlZHMgdG8gYmUg
aW4gdGhlIHJpZ2h0DQo+ID4gICBzZXR0aW5nIGZvciB0aGlzIHRvIHdvcmssIGFuZCBkZXZpY2Ug
bGlua3MgY2FuIGJlIHVzZWQgZm9yIHRoYXQgcHVycG9zZQ0KPiA+ICAgKHNlZSBkZXZpY2VfbGlu
a19hZGQoKSkuIFdpdGggRExfRkxBR19QTV9SVU5USU1FIGFuZA0KPiBETF9GTEFHX1JQTV9BQ1RJ
VkUsDQo+ID4gICB0aGUgc3VwcGxpZXIgZGV2aWNlcyB3aWxsIGJlIFBNIHJ1bnRpbWUgcmVzdW1l
ZCBiZWZvcmUgdGhlIGNvbnN1bWVyDQo+ID4gICAoY2FtZXJhIHNlbnNvcikuIEFzIHRoZXNlIGRl
dmljZXMgYXJlIHB1cmVseSB2aXJ0dWFsIG9uIGhvc3Qgc2lkZSBhbmQgaGFzDQo+ID4gICBubyBw
b3dlciBzdGF0ZSBhcyBzdWNoLCB5b3UgY2FuIHVzZSBydW50aW1lIFBNIGNhbGxiYWNrcyB0byB0
cmFuc2ZlciB0aGUNCj4gPiAgIG93bmVyc2hpcC4NCj4gDQo+IEludGVyZXN0aW5nIHByb3Bvc2Fs
IHRvIHVzZSBkZXZpY2UtbGlua3MgKyBydW50aW1lLXBtIGZvciB0aGlzIGluc3RlYWQgb2YNCj4g
bW9kZWxsaW5nIHRoaXMgYXMgYW4gaTJjLW11eC4gRldJVyBJJ20gZmluZSB3aXRoIGdvaW5nIHRo
aXMgcm91dGUgaW5zdGVhZCBvZg0KPiB1c2luZyBhbiBpMmMtbXV4IGFwcHJvYWNoLg0KPiANCj4g
SSBoYXZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgdGhlIGkyYy1tdXggYXBwcm9hY2ggYSBiaXQgYW5k
IHRoZSBwcm9ibGVtIGlzIHRoYXQNCj4gd2UgYXJlIG5vdCByZWFsbHkgbXV4aW5nIGJ1dCB3YW50
IHRvIHR1cm4gb24vb2ZmIGNvbnRyb2wgYW5kIEFGQUlLIHRoZSBpMmMtbXV4DQo+IGZyYW1ld29y
ayBzaW1wbHkgbGVhdmVzIHRoZSBtdXggbXV4ZWQgdG8gdGhlIGxhc3QgdXNlZCBpMmMtY2hhaW4s
IHNvIGNvbnRyb2wNCj4gd2lsbCBuZXZlciBiZSByZWxlYXNlZCB3aGVuIHRoZSBpMmMgdHJhbnNm
ZXJzIGFyZSBkb25lLg0KPiANCj4gQW5kIGlmIHdlcmUgdG8gc29tZWhvdyBtb2RpZnkgdGhpbmdz
IChvciBtYXliZSB0aGVyZSBhbHJlYWR5IGlzIHNvbWUgcmVsZWFzZQ0KPiBjYWxsYmFjaykgdGhl
biB0aGUgZG93bnNpZGUgYmVjb21lcyB0aGF0IHRoZSBpMmMtbXV4IGNvcmUgY29kZSBvcGVyYXRl
cyBhdA0KPiB0aGUgaTJjIHRyYW5zZmVyIGxldmVsLiBTbyBlYWNoIGkyYyByZWFkL3dyaXRlIHdv
dWxkIHRoZW4gZW5hYmxlICsgZGlzYXZsZSBjb250cm9sLg0KPiANCj4gTW9kZWxsaW5nIHRoaXMg
dXNpbmcgc29tZXRoaW5nIGxpa2UgcnVudGltZSBwbSBhcyBzdWNoIGlzIGEgbXVjaCBiZXR0ZXIg
Zml0DQo+IGJlY2F1c2UgdGhlbiB3ZSByZXF1ZXN0IGNvbnRyb2wgb25jZSBvbiBwcm9iZSAvIHN0
cmVhbS1vbiBhbmQgcmVsZWFzZSBpdCBvbmNlDQo+IHdlIGFyZSBmdWxseSBkb25lLCByYXRoZXIg
dGhlbiByZXF1ZXN0aW5nICsgcmVsZWFzaW5nIGNvbnRyb2wgb25jZSBwZXIgaTJjLQ0KPiB0cmFu
c2Zlci4NCg0KU2VlbXMgcnVudGltZSBwbSBjYW4ndCBmaXggdGhlIHByb2JsZW0gb2YgaW5pdGlh
bCBpMmMgdHJhbnNmZXIgZHVyaW5nIHNlbnNvciBkcml2ZXIgcHJvYmUsDQpwcm9iYWJseSB3ZSBo
YXZlIHRvIHN3aXRjaCB0byBpMmMtbXV4IG1vZGVsaW5nIHdheS4NCg0KVGhhbmtzDQpXZW50b25n
DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo+IA0KPiANCj4gDQo+ID4NCj4gPiAtIFRo
ZSBDU0ktMiBjb25maWd1cmF0aW9uIHNob3VsZCB0YWtlIHBsYWNlIHdoZW4gc3RyZWFtaW5nIHN0
YXJ0cyBvbiB0aGUNCj4gPiAgIHNlbnNvciAoYXMgd2VsbCBhcyBJVlNDKS4NCj4gPg0KPiA+IC0g
RGV2aWNlIGxpbmtzIG5lZWQgdG8gYmUgc2V0IHVwIHZpYSBJUFUgYnJpZGdlIHdoaWNoIG5vdyBp
cyBjYWxsZWQgIENJTzINCj4gPiAgIGJyaWRnZSAoY2lvMi1icmlkZ2UuYykuDQo+ID4NCj4gPiBB
bnkgcXVlc3Rpb25zLCBjb21tZW50cz8NCj4gPg0KDQo=
