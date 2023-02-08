Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE05E68ED30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBHKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHKok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:44:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6410259
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675853076; x=1707389076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l+fQ2BQig0m6QtY8IZjWNxjYAJGVGMcbNLC1XEFKxPI=;
  b=ble/NB+STpghmMgB9bm+mQpcTtjTlFS7LC4qJ90OFvcxMG487u7h5ab3
   Utp2lXfl3hYBsBFyvA4sXFo9ezhMKm7OSbxJTTZfKp2+ewdKBgP0vi0M+
   vv0u7uMf8618djjAeKIF7/qixT6lXwwRgLjvoHN/dV0qX/o5xiFZKyW1Q
   JdQNJ4FhytjFfoFfgkgw3Lvlg4P1+VUC//UwXe9MDx0UqkVvLDUpRMWHH
   /0qXdbW3pA8gcJ8OCavqtdov9K58TWV6ija28ikdi+m7CI6cvFn2UPqRZ
   jndapZUJkxTNBSrQIy8svEHdl6+CGRV3qf9FlLfkfDscIGRRbrmNGBl3B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309415798"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="309415798"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 02:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912685780"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="912685780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 02:44:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 02:44:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 02:44:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 02:44:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCMXeIQgGgMMR2DP654AXZqxL0/7eugZ3GSsHgYH+KnbbhDIobkJ0572SYHgaPIgkVzql94vy/8T03JJgtdoPCWEu9Xu+Zs4Uu9tn1wFSzkOfUGMP9SKPwy3dpwU/DTpO+RZAhFzTxPMU7OHeTfTPLGaLIFEjVLcKA+hiXeIzivN0P18AFoRtKJmkW+pj0L6l0omokrtJNciXt3n/FH2UuwGbLi/ekbLJC0qTZT5qdBM67bSZ1EtpYdnXAQ3GWY1J9UWWlf0Rbe4v/hOR5eVnzu81BnblDaDyK3UY7z+qcwUTWMOdqqudV/u0TfgCJocw+JpWlKW2floU8yQU4Lu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+fQ2BQig0m6QtY8IZjWNxjYAJGVGMcbNLC1XEFKxPI=;
 b=i9MN9UbNDyzOE+IVJEm5BLs8/w2xqUN/ezOx+pWddZlI+dCi0pRyIID1wzYoixtlKbCcxt4kiiMyM6YmncBdSDvs+bdXXjQb62GV7ZTtk0KLs5JDgugYEaUJZfmUIoV+QoFdbH04L4lW+U6n7pP6M3dc0QCTl8exxV4OeE5//60Lp0pMzviMseBXgJHQ/UxrXmraDKLoWveen30O5CNo2vyTs8q9H3TYW/aiLxMKfIJabHn5vFnF/enigptzXslxfyuXOZ/iM3xFzfqAVWdKlRDyPyoaAp+QULGz9LhQxM7TVQk9Vpy7F2wLRIaS1jw4/1cDwDFEKJH9XuFbNdOudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Wed, 8 Feb
 2023 10:44:26 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::c6d9:ec39:9492:f6ac]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::c6d9:ec39:9492:f6ac%2]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 10:44:25 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwJ2YsAAAAu1hQAAHQE/AAAMhAwAABAI04AAAZrQsA==
Date:   Wed, 8 Feb 2023 10:44:25 +0000
Message-ID: <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com> <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com> <Y+MAPHZNLeBY13Pj@mit.edu>
 <20230208041913-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208041913-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SJ1PR11MB6179:EE_
x-ms-office365-filtering-correlation-id: 5895c618-4135-42ca-ceca-08db09c17282
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmGYVgUchvfOkTJmmUcqI5S922f4nkzlB/7XRDsqe0Qh/WtUUT/ppfRf4z1deibh0jhzp9qhj0WrGDOWfvCXATFepjfW2FjSw0iEKIpxGP0FyR/2kJQiQeErfFHFLRSrCCrq37H5p1BF291T0SW7y701NVbxju/sVwEKWifGrQHPc6/X/PcOxDTGAcJm7XHxVaQniHs/jnE5DvYfvzihaAiiTFtQUTL19X3X203RlYuPj93BSlHkS23Qp8eJX8QFI4zzypfXaFjMtFQ/PuYXyrm+gzIYBebTzycLU5u3aCvTLbPOv8ARDxE+V025SByt0Djc8ywyYunDkcwuEKfMFn81XDZtZSZAcrCJTFx6l96elW917fqRbkpGSKsaELDK4mKpfbIIQcMxg98JQo4pieteYyle/tfUChEhPd4sNF0bVema5zXo9KyhR7QJ1Lv6QMX/W6ro/M0eLJu4yE8Ix4MDmLNGL54qfxbmx4/6sKm6TCSD/xGClIjeZyUH8Sn78mkyQiRLiHHq3WLKV5jjDeNajMoQ7bwyClzHXgA+L39GI3Jn7tHlvdNITOvXVGIzh10HRpDfoW5JrIRyE/gqu7SPWATs26lpQJShwtx3lXXAUKvwvZ4SlMAQtyuWpwYtjJmjQpZki1uFJYlphXf73BLaaIQ/2PFisp+KzQpLFI8K6XQ9YeZiF9sAfjtrn+KdiZhS3RoWggbebl1XBFsxZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(66476007)(4326008)(66946007)(76116006)(8676002)(38100700002)(316002)(122000001)(66556008)(83380400001)(54906003)(110136005)(86362001)(5660300002)(7416002)(52536014)(33656002)(478600001)(6506007)(38070700005)(9686003)(26005)(186003)(2906002)(71200400001)(64756008)(66446008)(41300700001)(82960400001)(8936002)(7696005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amdvSGRBSFBUOVBTczRhQmFMSk9ySmZENWVEMXY3Z2xoTmNnMUZCZnNSUkpR?=
 =?utf-8?B?ak45QURqQ3k4WHl2V0pqcmdaQ0dBcVJlUHU0VFE1d2JYemdQbFg2aDJqRHVl?=
 =?utf-8?B?VWRScnIrT1J5MEp2Q0pTcGFWa3g2MmZMSEd0K2hsNkVGMjM5cFVBOHZDQUVU?=
 =?utf-8?B?cTRtNWQwNlBzb1VMV0lYY3RrOFY5bHNXdXRid2RXL3IwTktSQWZ5bEZFTFcv?=
 =?utf-8?B?aU53WEVoY2VxaUV2MHpCdkh4SXRZWHRHaTRINmhqcHBnRmt5VzE2YmtFQjM0?=
 =?utf-8?B?ZmNCTkhRdlVzbzVIendUK3g1UDFrSDVncWNDODJuT3VGR0ptaTNMSzd6TmV4?=
 =?utf-8?B?OUJwK2hoUUJpNjBOVjhRRzNCK1AxN0xsUWFKbC9XTUdub0lnZUpESFN0VzE4?=
 =?utf-8?B?Y0F0UkhnR0FaNkx1YnEyV1A5bitXRFVpb1ZHd3Y5YmZZNDUrZ0t2Z0pzMU9y?=
 =?utf-8?B?SUlvTnJrNHlKOGlmakRHcGpva0JUaDB4U1J4Y3JKM0VxbWpld2s2S2YxdlRT?=
 =?utf-8?B?Y3ZKdFZ3OWRnRVBtT1dLWG9HaWIweFVRbVVFTU8vWkNONHByalpFbFg3bld4?=
 =?utf-8?B?TVRIQnNnWUZGOGdlVG03NnlnRE5adkFxSnhZTVdHVzNKcHlvZTU1MlUwZS9T?=
 =?utf-8?B?eXlkM0ZXUTNLTVNUeXU2VVRjTEZ5ZTQrL1RPb1poRlVSMEcrTU9aQ2dER29u?=
 =?utf-8?B?eDQvNkNTdGtHYXJoRXpUd2YyVDI2eDI5YTFNYWk3UkhkV3M4ZzhtdnNTaU5Q?=
 =?utf-8?B?NTcyWFFrOTIxRm9JMjdtalFNQitUWTZERG5UUVUxSmRoYm1RMHpFOTZhMjZm?=
 =?utf-8?B?TGdvQThaM09iVk9oYUZKWi9OY3JLT1pIeUVETzg3SkdiUk5vZUdaaGlzeTNB?=
 =?utf-8?B?b2JMWDlCVmlZT1RjaHBMengzcGJKV1JZRDEwVitxd1JBNWNrMnlSdUZ1U1lJ?=
 =?utf-8?B?d0RzU2NocUN4bFZwWi9QQ2pHYUNUbnU3MnNBRzBWeGVseEdLbWZmQTRmQmRW?=
 =?utf-8?B?SThndzRTTTVyUmFqYlZhUDQyODUwRWF2b1RXZGxjTjRLQWZMcitPRi9LRTFo?=
 =?utf-8?B?a25ZdzNNTzY2dXlCTmxIOU5kbFJKMldMRWwwczRDdE03V013bEhFTW9VaTF5?=
 =?utf-8?B?QXIwYVNuVzltSG95SG5XYWlvakVxMFBPemhqc1lyR2JRUm9ucmtENmlhUnhp?=
 =?utf-8?B?cE5YalZQd05NY05sQXlXZVJzcVdYa2VtSTRlc3ZNaitHNWpaS3QreC9vTjU3?=
 =?utf-8?B?MnpYWWdmSjBDTlpxdWdkTGpCRHlJWkY3UXd1SnBoQmFPZ1JRSVZKTzBBaTJp?=
 =?utf-8?B?RnAxOGllUnMrNnorR281SUlTNHc5L29oKzJaKzZGMzVQR3Q5OGR6VTRJS3RS?=
 =?utf-8?B?V0V1ZHpSZmNkK2hVSVVoNWRBVkxzSW9GdFBZR0hZcU1tRnVRQkJ1R1pNcHVE?=
 =?utf-8?B?dFFaT2FRYnpXaHhOWWZVTXVKYVBYY20xV0dDelJPaGhmVWlpK0pXSUxpeVUw?=
 =?utf-8?B?eDRQL0NaTXRaUmxkYWdabVhMUjNOTnc0RmpaK0FqVXBzd2tQZzNDNm5DVU1E?=
 =?utf-8?B?eHB2QnRxbUtyc203MTVLVUdEL3RSQUFZdy82TmtZMzVDSFNiZU5NRHNFMG1a?=
 =?utf-8?B?NWJKUE43UnY4YVFnUlRORkFrTUVaalJnRTNDQVhQN2ZrZG5TWkJEWmt4bjRH?=
 =?utf-8?B?Wk9pSEw3eUp5R2lWRXN3TGZ6aHEzMSt3MDBqVXhNTUdVenN6N2lXcUhzUXZp?=
 =?utf-8?B?a0txZUdvOWMxMWRreXhMMEUrQ2o5b2sxdkhULzJxdytXSkhlNkFNUTA5dDlI?=
 =?utf-8?B?NncvMUxZalNzK1JhcWJrR2tFK01Bd0diQy84TEVjZ3MxaUc3YkpUck52bGFv?=
 =?utf-8?B?WmtZSTRpNVpzT2k3b1pFckJwTUpuZW1YdTFBK3B0QUNvMXIrcnQrbExHWDAy?=
 =?utf-8?B?TjFBczk5SWU3YTJhSXlwY0R0dFFZdFlKcVREbHYyblhVZHB2SWMwMUtGUW5a?=
 =?utf-8?B?QXRGbWZXaDlRdHBoaUxrRWhjT3Q0bTFNRGVzdERnbkVnbS9NbTBjQ0VoVkRZ?=
 =?utf-8?B?b1Q4L1NpRjljTzRHSk0vTUw2cWRweURXalc3WUpRMzBBdXB3R2Nzbld3OEYv?=
 =?utf-8?Q?Wii4gU5BnlP8hGm5rA74Nz5x7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5895c618-4135-42ca-ceca-08db09c17282
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 10:44:25.7258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjlRkUS02/nDlQ/8+uf9mzB0CR/X1XgIuFvIJQ0f1vWv1f/NYhXYnFSpVnOR4h8rg/+6lBK0m+GQsbk8fbuTfbbV27sGDTxwY+eKouhwxYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gVHVlLCBGZWIgMDcsIDIwMjMgYXQgMDg6NTE6NTZQTSAtMDUwMCwgVGhlb2RvcmUg
VHMnbyB3cm90ZToNCj4gPiBXaHkgbm90IGp1c3Qgc2ltcGx5IGNvbXBpbGUgYSBzcGVjaWFsIENv
Q28ga2VybmVsIHRoYXQgZG9lc24ndCBoYXZlDQo+ID4gYW55IGRyaXZlcnMgdGhhdCB5b3UgZG9u
J3QgdHJ1c3QuDQoNCkFzaWRlIGZyb20gY29tcGxleGl0eSBhbmQgc2NhbGFiaWxpdHkgbWFuYWdl
bWVudCBvZiBzdWNoIGEgY29uZmlnIHRoYXQgaGFzDQp0byBjaGFuZ2Ugd2l0aCBldmVyeSBrZXJu
ZWwgcmVsZWFzZSwgd2hhdCBhYm91dCB0aGUgYnVpbGQtaW4gcGxhdGZvcm0gZHJpdmVycz8NCkkg
YW0gbm90IGEgZHJpdmVyIGV4cGVydCBoZXJlIGJ1dCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kIHRo
ZXkgY2Fubm90IGJlIGRpc2FibGVkDQp2aWEgY29uZmlnLiBQbGVhc2UgY29ycmVjdCBpZiB0aGlz
IHN0YXRlbWVudCBpcyB3cm9uZy4gDQoNCj4gSW4gb3JkZXIgdG8gbWFrZSAkJCQkJCwgeW91IG5l
ZWQgdG8gcHVzaCB0aGUgY29zdHMgb250byB2YXJpb3VzDQo+IGRpZmZlcmVudCBwbGF5ZXJzIGlu
IHRoZSBlY29zeXN0ZW0uICBUaGlzIGlzIGNsZXZlcmx5IGRpc2d1aXNlZCBhcw0KPiB0YWtpbmcg
Y3VycmVudCBwZXJmZWN0bHkgYWNjZXB0YWJsZSBkZXNpZ24gcGFyYWRpZ20gd2hlbiB0aGUgdHJ1
c3QNCj4gYm91bmRhcnkgaXMgaW4gdGhlIHRyYWRpdGlvbmFsIGxvY2F0aW9uLCBhbmQgY2F1c2lu
ZyBhbGwgb2YgdGhlDQo+IGFzc3VtcHRpb25zIHdoaWNoIHlvdSBoYXZlIGJyb2tlbiBhcyAiYnVn
cyIgdGhhdCBtdXN0IGJlIGZpeGVkIGJ5DQo+IHVwc3RyZWFtIGRldmVsb3BlcnMuDQoNClRoZSBD
QyB0aHJlYXQgbW9kZWwgZG9lcyBjaGFuZ2UgdGhlIHRyYWRpdGlvbmFsIGxpbnV4IHRydXN0IGJv
dW5kYXJ5IHJlZ2FyZGxlc3Mgb2YNCndoYXQgbWl0aWdhdGlvbnMgYXJlIHVzZWQgKGtlcm5lbCBj
b25maWcgdnMuIHJ1bnRpbWUgZmlsdGVyaW5nKS4gQmVjYXVzZSBmb3IgdGhlDQpkcml2ZXJzIHRo
YXQgQ29DbyBndWVzdCBoYXBwZW5zIHRvIG5lZWQsIHRoZXJlIGlzIG5vIHdheSB0byBmaXggdGhp
cyBwcm9ibGVtIGJ5IA0KZWl0aGVyIG9mIHRoZXNlIG1lY2hhbmlzbXMgKHdlIGNhbm5vdCBkaXNh
YmxlIHRoZSBjb2RlIHRoYXQgd2UgbmVlZCksIHVubGVzcyBzb21lYm9keQ0Kd3JpdGVzIGEgdG90
YWxseSBuZXcgc2V0IG9mIGNvY28gc3BlY2lmaWMgZHJpdmVycyAod2hvIG5lZWRzIGFub3RoZXIg
c2V0IG9mIA0KQ29DbyBzcGVjaWZpYyB2aXJ0aW8gZHJpdmVycyBpbiB0aGUga2VybmVsPykuIA0K
DQpTbywgaWYgdGhlIHBhdGggaXMgdG8gYmUgYWJsZSB0byB1c2UgZXhpc3RpbmcgZHJpdmVyIGtl
cm5lbCBjb2RlLCB0aGVuIHdlIG5lZWQ6DQoNCjEuIHRoZXNlIHNlbGVjdGl2ZSBDb0NvIGd1ZXN0
IHJlcXVpcmVkIGRyaXZlcnMgKHNtYWxsIHNldCkgbmVlZHMgdG8gYmUgaGFyZGVuZWQgDQogKG9y
IHdoYXRldmVyIHdvcmQgcGVvcGxlIHByZWZlciB0byB1c2UgaGVyZSksIHdoaWNoIG9ubHkgbWVh
bnMgdGhhdCBpbg0KdGhlIHByZXNlbmNlIG9mIG1hbGljaW91cyBob3N0L2h5cGVydmlzb3IgdGhh
dCBjYW4gbWFuaXB1bGF0ZSBwY2kgY29uZmlnIHNwYWNlLA0KcG9ydCBJTyBhbmQgTU1JTywgdGhl
c2UgZHJpdmVycyBzaG91bGQgbm90IGV4cG9zZSBDQyBndWVzdCBtZW1vcnkgDQpjb25maWRlbnRp
YWxpdHkgb3IgaW50ZWdyaXR5IChpbmNsdWRpbmcgdmlhIHByaXZpbGVnZSBlc2NhbGF0aW9uIGlu
dG8gQ0MgZ3Vlc3QpLiANClBsZWFzZSBub3RlIHRoYXQgdGhpcyBvbmx5IGFwcGxpZXMgdG8gYSBz
bWFsbCBzZXQgKGluIHRkeCB2aXJ0aW8gc2V0dXAgd2UgaGF2ZSBsZXNzDQp0aGFuIDEwIG9mIHRo
ZW0pIG9mIGRyaXZlcnMgYW5kIGRvZXMgbm90IHByZXNlbnQgaW52YXNpdmUgY2hhbmdlcyB0byB0
aGUga2VybmVsDQpjb2RlLiBUaGVyZSBpcyBhbHNvIGFuIGFkZGl0aW9uYWwgY29yZSBwY2kvbXNp
IGNvZGUgdGhhdCBpcyBpbnZvbHZlZCB3aXRoIGRpc2NvdmVyeQ0KYW5kIGNvbmZpZ3VyYXRpb24g
b2YgdGhlc2UgZHJpdmVycywgdGhpcyBjb2RlIGFsc28gZmFsbHMgaW50byB0aGUgY2F0ZWdvcnkg
d2UgbmVlZCB0bw0KbWFrZSByb2J1c3QuIA0KDQoyLiByZXN0IG9mIG5vbi1uZWVkZWQgZHJpdmVy
cyBtdXN0IGJlIGRpc2FibGVkLiBIZXJlIHdlIGNhbiBhcmd1ZSBhYm91dCB3aGF0IA0KaXMgdGhl
IGNvcnJlY3QgbWV0aG9kIG9mIGRvaW5nIHRoaXMgYW5kIHdobyBzaG91bGQgYmFyZSB0aGUgY29z
dHMgb2YgZW5mb3JjaW5nIGl0LiANCkJ1dCBmcm9tIHB1cmUgc2VjdXJpdHkgcG9pbnQgb2Ygdmll
dzogdGhlIG1ldGhvZCB0aGF0IGlzIHNpbXBsZSBhbmQgY2xlYXIsIHRoYXQNCnJlcXVpcmVzIGFz
IGxpdHRsZSBtYWludGVuYW5jZSBhcyBwb3NzaWJsZSB1c3VhbGx5IGhhcyB0aGUgYmlnZ2VzdCBj
aGFuY2Ugb2YNCmVuZm9yY2luZyBzZWN1cml0eS4gDQpBbmQgZ2l2ZW4gdGhhdCB3ZSBhbHJlYWR5
IGhhdmUgdGhlIGNvbmNlcHQgb2YgYXV0aG9yaXplZCBkZXZpY2VzIGluIExpbnV4LA0KZG9lcyB0
aGlzIG1ldGhvZCByZWFsbHkgYnJpbmdzIHNvIG11Y2ggYWRkaXRpb25hbCBjb21wbGV4aXR5IHRv
IHRoZSBrZXJuZWw/IA0KQnV0IGhhcmQgdG8gYXJndWUgaGVyZSB3aXRob3V0IHRoZSBjb2RlOiB3
ZSBuZWVkIHRvIHN1Ym1pdCB0aGUgZmlsdGVyIHByb3Bvc2FsIGZpcnN0DQoodW5kZXIgaW50ZXJu
YWwgcmV2aWV3IHN0aWxsKS4gIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCiANCg==
