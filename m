Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215A667C9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjAZL3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjAZL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:29:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C36279F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674732568; x=1706268568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HSwrakHPEupTpHcXWsRaB9wJX/geQghsAtOKLtUTYUI=;
  b=S4Pxzr7JvbuY74fxW7OL5aODYcDKCzQ4gYlqpoIxdDuCdLGNkvdloPrp
   yBpm0zGlfhMBqGp1tUJCBunzRvVcURNqtjDAZnkZ3KCfTcagb/TuzzFn9
   Otpscq+zK6iTMmMooDKoOyFOrM7J3fGci9KPZ6m9xVz1iHWxRypVq5SGL
   LnjPp8RIMYWxTtplco5w/pt6LOgPJULodgci0hP0FsBzlI7y2iLU3rYEg
   bG7jG109a0jOzgEpYX7TWhyqp1yMDVcTuGMfutVLWA7HFyUnWfWFG1XIW
   wBrj3QjNebxB68fXRKYT4hIEpI04cxWAIoVHyJlDJLN06pXoMObhnOY7E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306449948"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="306449948"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 03:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="726248999"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="726248999"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2023 03:29:26 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 03:29:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 03:29:26 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 03:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmpuHxhOZK1dO1H30/PCy3+hZe2Fzmwt3fBD+qnEJsU2/WqfM3zqA3lgfOnJOXaCzYGWOFmL4hZthkU1gN4YdnOe48PiAETLC5rQ8I42ql4VmjYnt9R33UCjnLAKwPdthp586JX1EFI0+QUtG5bxPtMPJw27zhDdZH3LKdFw6u0P+Rl6tQA5K4WFaSYPVN6Et5IYtQXLOKgDEdDb4uqTfFmThx2ogE56IAy1GzXJLH3s8en562WzUVMQNpGG06cjM/Y3KnydB9s1Xz+iqwfMVrRc87aCZoCcuGmMTF2UzR280DafaTxZZGlPzC7Z0JSLm5fd+4RLQa2dBnqGDeziig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSwrakHPEupTpHcXWsRaB9wJX/geQghsAtOKLtUTYUI=;
 b=bI4OuKf6MzcY7ZABNIGNNd0WBNZhkNotcUFQsGIiQNotOIxf4FyQ6wh03zI5i4akNVO1kTAh4yW4TKAwLMRUQ6RHcswawAQQS+w2TsQ331dmDMOIOkzXycCCZPvQM1UP53aA/7pVkKxqYA8Zhvlor7lAoaJYZILnUa70t+UWc8KFkEHcCJpNwR7T6jtMWvEPjX7yPNdIfuoaqq6zL+q1LdED0nNXV1+qsouLa5ulxQj7mso/a1RqoyXnZEWXDdoCjSuBEXc4D0g1GDGJzFTrz9Jaerddz1b26Ql41K3+LJXthaIQAFYMHNsXD7B8Hr06hsOnYX807bLBrEY5a8uy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 11:29:20 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 11:29:20 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEw
Date:   Thu, 26 Jan 2023 11:29:20 +0000
Message-ID: <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
In-Reply-To: <Y9Jh2x9XJE1KEUg6@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|MW3PR11MB4555:EE_
x-ms-office365-filtering-correlation-id: 8af4d5ed-5bf4-452c-f3f3-08daff909115
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkuVgtWu2gqqovTRBJ7rumIaLfIpdK8gW037rQPciMcV2xBWRyaLNm5mhcqVQYh9M4avHdMaKCOgCkoJqwLGXBMUSsW0cUcD0mErTWNEfog/T4jhmz0miw9x7fbGPzY7iGRTIiowcNcXyunvEZf6zWVaxH6RkhCMWq9hpipNJc8Jg0Mr9XTwxYKHZpQqTCr59pV2NhV9VN3lsIBmmQeo/AfAvf44LiWTFcWPRzvN8K4wtvpqrU2omqhd0aNIdD8hS+wZBvC2Mwyyo5O2sjAWA79YjtheGvLTRRG3nkKHox8NL3FBqVfvATmHxSqG4/Cdc5ljpiF4yZIffPlR0gHQC/Izad4cbJ2d6w8cZPYaqPJC4tTrpUtDDQDdw4nppVh6w+Na32WdimDMFtTGTVNTjQ1ZhFvl35ruZ1rXRAjP/jABC9JWPj0tmLfJoLNYTPOPpGkTs/ln1BHONdHdnj1IvDxssDZT4WG2iixLatyv9jOYpZzDkQ32iaXuhK01KdUZm1PKgYd4tUO6p9wnVf2EabZn09qD8AobFfxbjY8E27w5J1J76sJJ7nZMlkwG1tB/0Y5uKS9iIJBGPJ46vl3qwoQqeQZcfzBhHBkbR0h2xzMU+UHwXnzl95VJeVxTPBrLBNYBX309972GlpTpU+In+b6068c1AYv2/UzATUIJDGHOTDbBPCQZggbJ9EZ9t2Ew1i8yesdNkAQSDGnXnRAj5X2X1M3aqy0RYyx0xZhVwSzTrKRv3GAS2ogwK8wQ71UAxvES5ieaR6K2T4UZFguBqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199018)(8676002)(71200400001)(33656002)(7696005)(54906003)(55016003)(86362001)(38100700002)(122000001)(82960400001)(38070700005)(83380400001)(9686003)(186003)(26005)(478600001)(7416002)(5660300002)(316002)(6506007)(52536014)(64756008)(66946007)(66556008)(66476007)(41300700001)(966005)(8936002)(6916009)(2906002)(66446008)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9iWkdKTUoraG04aXBlZFBoRHBGdURjSCt2Z1VURE1Kd1pDd3ZlMUhGNDRL?=
 =?utf-8?B?b1d6ZjNEODZBOCt6WHAxRzFWNHFHV085SE1MenVxMHBuR3BsWVQrNm80cml0?=
 =?utf-8?B?TnpPQ1Y5ejNqeEpNa2hqSCtNeDhHUjFuU1VVeGg5MGNzU0MxeHVxR0VHMVZY?=
 =?utf-8?B?UTlsSlQrM0h5bWF5azFUQkJ5QmF2MGVkYUF0QU5WNFRGSStUVVpNMzUvVi96?=
 =?utf-8?B?SEJncGdNWkg5bUtyN0dUQVdIY0RrVGZGaXVjK2Q5T28vU1VOSjZNUXhYQmJG?=
 =?utf-8?B?dDZmRGZwSlRTdXJ2ekFwYWlnajZuZEczSWRzWCs1Z2RRTW9zY0xzeFlGeW5z?=
 =?utf-8?B?a3JnMmptVkJJVmxnM00va2ZndnpTUU9WOURCMERWc0NQWjBiSVJ5Q21PWDdj?=
 =?utf-8?B?WmNaQzd0eThaTloxZzFBd1NhdHhwaWh6TmE1VENKQVN5SjZoQ3BxZnQvSG1C?=
 =?utf-8?B?SGhhQktxQ1Jtb3FZY3QwL0J1Z05GVHcvdzZ6SXQ3R2d4RmhOZytMQWcrazFt?=
 =?utf-8?B?bTdLVXNjOFpoYlZVNDUxRnVaVHhEUDkzcENDcUVzbjRwRmZUei9JU2ZDRitv?=
 =?utf-8?B?TDZjdHIrSXZqaEZLSmRjMFBUTGk3NFZwQmp3djBQV0wvbk4zdmM1T3dPOEFF?=
 =?utf-8?B?T3dKK3NxY2dDdjJsaW5jaWNqa3lMZjlrbDZkUE92dnlNTnNQaElVbG5DQ05w?=
 =?utf-8?B?NU0xdUIvV3FUSDBBWVNOV0ZSem0vTG8yVE8zRjV1RUhjSGxIOGVZOC94YzRX?=
 =?utf-8?B?akdmV0pCK3VxWEZGbmVCS3hxZzZFaGloL3VJSzRpeS84bFNoak4rNDBDS1JX?=
 =?utf-8?B?TlVUa2NkWFk0cU5PYS9HN1BqdnhEVnd6dEtaNUw4YmZHMzBtS0pXYnVteVZP?=
 =?utf-8?B?Y2F2Vkl5N1FWVng4bWtCNmd2L0JnMWk4S2lPRFliNVd0N1FFc0JkKzRwRkRs?=
 =?utf-8?B?MHliNGNBZmxzU2xYbWRVVHQ1ZHBKaE51M2FuSWgrdEltT0FTWEFOSmRURnA5?=
 =?utf-8?B?UjFjUnRRbkg4bkE1aWRyZmcwaVpnbVFGTTYyZ1ZzVm5zZ1V0Y2RIY1ZGVUNM?=
 =?utf-8?B?YTIyY3dsWEh4aHJnQnc3QnpFbitKU2RDQ0luQzFTaDNSd2oyUjYrNW1NaHh6?=
 =?utf-8?B?VXFpZTE1MHBzc2l1bEFQc2tSK3dtZlJsUXhrR2Z4M3ZsdkgrMTlDSDZ3dXVi?=
 =?utf-8?B?M05nMVRuOEZYNHlodHF5RFgzTElnWExQM1dBUFNCU3FSOEZ5UVoxTFdoMGIy?=
 =?utf-8?B?VDQyWDlnZ1BEZWtJb0tmQWpWeDQzU2FwZXZyOUQ0NTdNcjVaWjN2aTFtdnpw?=
 =?utf-8?B?Uk5xdWF5WWxIL0plMEY1RHlrbGpPdlRmVEljV2doampxMHBUVVVYSFZGY05w?=
 =?utf-8?B?RWtZSjVNYTJTUkZmVm1FeU1QZHFyZDg5MmJSd3ROcFM1Zk12eTJUazZKNERM?=
 =?utf-8?B?dUd5VzJRdjJVR2NmVG9qVDM0RW1iNTFJRXk2UWlLM3lST2ZJeHR6dTVSQk82?=
 =?utf-8?B?aytNaVJZWkZaTTlhRmlpK1hpRk1EOS9Kb1c2cEIxZ3dYakpqQUNnOFlRUjFV?=
 =?utf-8?B?elFPSmwxOTJmbjQrMVN0dUNmL3BsSkYvTEl6dTJ2aDFiYjBCODk2Sm8zYVZR?=
 =?utf-8?B?aU5wcmIxTlJaLzc0S3dUNjVacEovK0haQlB3WnJqaFo1Um5ZS2NJNUdncEgw?=
 =?utf-8?B?M1VOa2MrVFJzQnBMQnArbXI3QVpDTXpMdXg2ZytTdWFtZUlKZDh2REVhRHpW?=
 =?utf-8?B?dFdmTUN2Vmg4NCttZFpYWUxuMTRxUjJ2NnNZL3gwUVZVaHc5eXFzMjhkMnFx?=
 =?utf-8?B?UzJIU1lORkZ4bFBKemlONVdsS1FvK29IOWhSOVRUZTZzUElnVXl0RVRwN1ZR?=
 =?utf-8?B?dWRqY2V1Q0cxc3grbE9nN280b3BWSEF2SEIrYzV2bUwveWRkV0hJRENXaHFo?=
 =?utf-8?B?YjZ1M2NWZ0dUWGZxeUVCSGQvWnBpTXVIK200Qk9FdjRGNE13VmVJRjlBaTZ3?=
 =?utf-8?B?ZmM5RlB4YmEzeGsvT2tGY2dUZ3pISXVvTGtXRDVWSk5WZFE5ZXpTTXFqSHg1?=
 =?utf-8?B?TXM2cFg0aHB5Rzc4K0F1cXc4MzNrbXRXRWUxT3UzMFFPVXB2UThNcEZEUC9N?=
 =?utf-8?Q?UJO8Le6y0zexVEhUStX8f658J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af4d5ed-5bf4-452c-f3f3-08daff909115
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 11:29:20.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /I8en14qRolk/cQY/AWgjhtACfihE9WDqRjgofL26wMkr3zyFfm/Z3+yCOZ9+bR8BhPWanpUIEJ8//E0ocY49zaZVJTK+DnfBu+V2PGoozA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEphbiAyNSwgMjAyMyBhdCAwMzoyOTowN1BNICswMDAwLCBSZXNoZXRvdmEsIEVs
ZW5hIHdyb3RlOg0KPiA+IFJlcGx5aW5nIG9ubHkgdG8gdGhlIG5vdC1zby1mYXIgYWRkcmVzc2Vk
IHBvaW50cy4NCj4gPg0KPiA+ID4gT24gV2VkLCBKYW4gMjUsIDIwMjMgYXQgMTI6Mjg6MTNQTSAr
MDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3cm90ZToNCj4gPiA+ID4gSGkgR3JlZywNCj4gDQo+IDwu
Li4+DQo+IA0KPiA+ID4gPiAzKSBBbGwgdGhlIHRvb2xzIGFyZSBvcGVuLXNvdXJjZSBhbmQgZXZl
cnlvbmUgY2FuIHN0YXJ0IHVzaW5nIHRoZW0gcmlnaHQNCj4gYXdheQ0KPiA+ID4gZXZlbg0KPiA+
ID4gPiB3aXRob3V0IGFueSBzcGVjaWFsIEhXIChyZWFkbWUgaGFzIGRlc2NyaXB0aW9uIG9mIHdo
YXQgaXMgbmVlZGVkKS4NCj4gPiA+ID4gVG9vbHMgYW5kIGRvY3VtZW50YXRpb24gaXMgaGVyZToN
Cj4gPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2NjYy1saW51eC1ndWVzdC1oYXJkZW5p
bmcNCj4gPiA+DQo+ID4gPiBBZ2FpbiwgYXMgb3VyIGRvY3VtZW50YXRpb24gc3RhdGVzLCB3aGVu
IHlvdSBzdWJtaXQgcGF0Y2hlcyBiYXNlZCBvbg0KPiA+ID4gdGhlc2UgdG9vbHMsIHlvdSBIQVZF
IFRPIGRvY3VtZW50IHRoYXQuICBPdGhlcndpc2Ugd2UgdGhpbmsgeW91IGFsbCBhcmUNCj4gPiA+
IGNyYXp5IGFuZCB3aWxsIGdldCB5b3VyIHBhdGNoZXMgcmVqZWN0ZWQuICBZb3UgYWxsIGtub3cg
dGhpcywgd2h5IGlnbm9yZQ0KPiA+ID4gaXQ/DQo+ID4NCj4gPiBTb3JyeSwgSSBkaWRu4oCZdCBr
bm93IHRoYXQgZm9yIGV2ZXJ5IGJ1ZyB0aGF0IGlzIGZvdW5kIGluIGxpbnV4IGtlcm5lbCB3aGVu
DQo+ID4gd2UgYXJlIHN1Ym1pdHRpbmcgYSBmaXggdGhhdCB3ZSBoYXZlIHRvIGxpc3QgdGhlIHdh
eSBob3cgaXQgaGFzIGJlZW4gZm91bmQuDQo+ID4gV2Ugd2lsbCBmaXggdGhpcyBpbiB0aGUgZnV0
dXJlIHN1Ym1pc3Npb25zLCBidXQgc29tZSBidWdzIHdlIGhhdmUgYXJlIGZvdW5kIGJ5DQo+ID4g
cGxhaW4gY29kZSBhdWRpdCwgc28gJ2h1bWFuJyBpcyB0aGUgdG9vbC4NCj4gDQo+IE15IHByb2Js
ZW0gd2l0aCB0aGF0IHN0YXRlbWVudCBpcyB0aGF0IGJ5IGFwcGx5aW5nIGRpZmZlcmVudCB0aHJl
YXQNCj4gbW9kZWwgeW91ICJpbnZlbnQiIGJ1Z3Mgd2hpY2ggZGlkbid0IGV4aXN0IGluIGEgZmly
c3QgcGxhY2UuDQo+IA0KPiBGb3IgZXhhbXBsZSwgaW4gdGhpcyBbMV0gbGF0ZXN0IHN1Ym1pc3Np
b24sIGF1dGhvcnMgbGFiZWxlZCBjb3JyZWN0DQo+IGJlaGF2aW91ciBhcyAiYnVnIi4NCj4gDQo+
IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAxMTkxNzA2MzMuNDA5NDQtMS0N
Cj4gYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbS8NCg0KSG0uLiBEb2VzIGV2ZXJ5
b25lIHRoaW5rIHRoYXQgd2hlbiBrZXJuZWwgZGllcyB3aXRoIHVuaGFuZGxlZCBwYWdlIGZhdWx0
IA0KKHN1Y2ggYXMgaW4gdGhhdCBjYXNlKSBvciBkZXRlY3Rpb24gb2YgYSBLQVNBTiBvdXQgb2Yg
Ym91bmRzIHZpb2xhdGlvbiAoYXMgaXQgaXMgaW4gc29tZQ0Kb3RoZXIgY2FzZXMgd2UgYWxyZWFk
eSBoYXZlIGZpeGVzIG9yIGludmVzdGlnYXRpbmcpIGl0IHJlcHJlc2VudHMgYSBjb3JyZWN0IGJl
aGF2aW9yIGV2ZW4gaWYNCnlvdSBleHBlY3QgdGhhdCBhbGwgeW91ciBwY2kgSFcgZGV2aWNlcyBh
cmUgdHJ1c3RlZD8gV2hhdCBhYm91dCBhbiBlcnJvciBpbiB0d28gDQpjb25zZXF1ZW50IHBjaSBy
ZWFkcz8gV2hhdCBhYm91dCBqdXN0IHNvbWUgZmFpbHVyZSB0aGF0IHJlc3VsdHMgaW4gZXJyb25l
b3VzIGlucHV0PyANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNCg==
