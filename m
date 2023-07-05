Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E41748044
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGEI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjGEI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:58:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76E1721;
        Wed,  5 Jul 2023 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688547499; x=1720083499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tW9SeVEU/w2QCATPY7tzHyJL7XwQEka++fJWnYaJ68I=;
  b=Eaf+8rGZGD/NZTNKAwVq2ggIuIvB5WUaNX8SF/NkeE5+VngwE8Dutusd
   PCrsMwmKjH6buldxIjj7Gq6WMIx5f2pVRkKxQ0fiSux4p8yDm7xum/s+p
   +oLmD8hdOv/WOiTiXAHSB0lr7cSoHC+O8Np0QAd62PL02uipjustBx49T
   PiZYGaE5o+IDeuS02BCSjtODrZSwA0hHPjvmvIG+ZrdTG6r+0bGj0NRnB
   4swEq3N3YG9sUo8vQhSxI6QqWRChFWF5LDGZN+H/VGtX1rYTQOs2l0GUE
   eu11BT+eLUQdofu2PrEbAjLwGYwoqZQjzNeYsMCoQIQQvBA8w0Jd0ivH7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="343620198"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="343620198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 01:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="696382186"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="696382186"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2023 01:58:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 01:58:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 01:58:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 01:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXT0gH28Zjkpjmkz2dEr0oVOkC4JNcUXM83S5wDE2pbIUS8wxPEGabdDejSZV8zE0MILDN1RrZ6u7zn/uU3t50hbnoTc7TI2yq71yjD2XScYPkiuoUR9G6cULkH3CD/nJmGe1DgIWwESXZQL7uW78tvAGTHkEM4Aq/lANTf88YwPptvBxTO4rmpSGKWPFjeIursg0ha61+yrQx5MTXVg9aOot+R8KrSObgo/9z/zd7AaldgQWkPPm+bJAipdMNRijX9+/v0oxfxD5vGsomEkQFXhNZ0HRT3etaJoNNwgw8CSwvAiqvQvhYzTUR30c0O/5p49N6emUv8uJWE8GNjtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW9SeVEU/w2QCATPY7tzHyJL7XwQEka++fJWnYaJ68I=;
 b=WyL5HEA5rd8nJNZnH0DLo1Eoa9vy4F4bwzyPi+fxzxPg5ju0skk7DSoPXPCfqBJDhoa7ZatqQbBP+z5CTygQSXoEG6UThoE7RoEnBCvRCavsAPBrB7q2UC7RoCTL16ig3nKDvhIFWanJi6o1GpvOQUgC7ep/etMgjpyZ1IOTVMLg2JhjdkPyi8vTt3QIBwtnUoPB3LjU+RXruQIOK56sWSMBQCmNSLifXEBQJeli4cGlLYMOJJ1pDbtA7+6Y8W/IjfQHBeZ49PRm3CzPgEeZN/wRa4y2mHTh5labO644We7lqaIoIC1rgN03SovcLhcmEhOu+YUnCqRizKS/ztd8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 08:58:14 +0000
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::b46a:9f6b:4413:7dd1]) by SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::b46a:9f6b:4413:7dd1%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 08:58:14 +0000
From:   Kumari Pallavi <kumari.pallavi@intel.com>
To:     "rcsekar@samsung.com" <rcsekar@samsung.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC:     "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Nikula, Jarkko" <jarkko.nikula@intel.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: RE: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to avoid
 communication stall
Thread-Topic: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to avoid
 communication stall
Thread-Index: AQHZpbEJFNWZ6ahAAkGbf9aW8zW0xq+q8LqQ
Date:   Wed, 5 Jul 2023 08:58:13 +0000
Message-ID: <SJ1PR11MB60840829B69A0FBBCF40B465872FA@SJ1PR11MB6084.namprd11.prod.outlook.com>
References: <20230623085920.12904-1-kumari.pallavi@intel.com>
In-Reply-To: <20230623085920.12904-1-kumari.pallavi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6084:EE_|DM8PR11MB5573:EE_
x-ms-office365-filtering-correlation-id: 8b428d98-1fad-48c1-554f-08db7d35f75e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0mpIBrqAivBH4YeGh2ZDES02EMz5lDsyUJZcJX7b+PpgCvXrOK5SSbSUMAv3t58/Zx5m8h6W1XxNdG7pVpjen1K0quJSH3b1IOyxNTTM+f3QLhStelDHF7Xmp1gyDcPHQDHmY0xrHIvXz/qO0HlKMjtbI54/0Emx/docuhcmIWC4CHOmFLTaPKzmoE5oIZ2d3TrKNND8rSE8CDS/lTwaIcofCH02liVNSq+Uc0M7bSdcrRIEGwhqU/VPyJ+0frNdCgxJW89T/zg2zTOy7q3AVvWWcH0Kbh/gBJZ3Icpsre83pONztenGW3ghWwhV0YD9Cknfa/W8IUx1FoNyNhBgALnz0Kv4BmNlnrmeMgaHIHeeL0M0c+JwOIlbz4a1YQiGXl9CxWlfwN257nuHQeXZamFQECatQ0prDSTWZtXsY6jWhseuDywF8fD7SDSmzwaX/G0JrJyMPOwtZgL9i9YE5+uwyejsDRmBqE4PbNF8M1uCsOZrWixNTZjJHjspc1S69xWeN1UmbzyUCg5vxebCPI/wxgykAKP5Q7NDhkJrxPpApQNRh5P346rKh1YfNhgZSwYKFdDKbAxfbgdvkiyqmjUVgH7EcKVKIach4tHz7t2SuHOmIs9x+qFXdoP5Jdl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6084.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(38070700005)(41300700001)(2906002)(52536014)(8936002)(5660300002)(7416002)(8676002)(44832011)(33656002)(55016003)(86362001)(478600001)(26005)(6506007)(71200400001)(186003)(9686003)(82960400001)(7696005)(76116006)(122000001)(316002)(66446008)(66556008)(4326008)(64756008)(66476007)(66946007)(54906003)(107886003)(38100700002)(83380400001)(53546011)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFBJSFpsZXZVY2RZaW14akwvMHlsN3lqRnA1RHJsajQzcnZFdUoyZ2VBSEdD?=
 =?utf-8?B?b0ZoNEhpTnFyTUdncmpnUkRTbGx2NlgyazN4U1J1OWNhY21TYk41ODRVamdC?=
 =?utf-8?B?Qnk3SDlKSUVlYWplMEJyMzJtOTlCbUcvcWlURWN6WDZJYmpXbHdpeXB5emk0?=
 =?utf-8?B?aG0wdkpIMVhqdUN6ZlVwQkxiN014VVBGcmtnQ2tOTllkNGwxbmFud0xHSy9L?=
 =?utf-8?B?OWFyazZvN3B4eDZBSWJGSG0yOHppTmMvamt2a2E1clRyVkNDUTY0UG5VTXpr?=
 =?utf-8?B?SjM2Nzd6TkhxT2ZZUStPcE4zZ2xNaDNaNHBlTGRPMTd5a0lnWXoxQ0FJaitG?=
 =?utf-8?B?NmF3blM0V3pKT2czK0VNVTB2RFcwRTVlaVo5OGpBSVRWZjY4a0d4K1BMbUQx?=
 =?utf-8?B?Z2g3WVZtdTYxS1RwZXhlQ1JjRXFDeHllaXdiSU1UU053UzVJWW42S1k3a2Zu?=
 =?utf-8?B?LzgzVXpvZGtFbG04TUtOS2NTZUZKeVQ0cEh2WitHZ1VFOXh0ekRrN09pVXcw?=
 =?utf-8?B?MXJVcTJnOHdkSnFjQ28wb1pXdFlpbzEycHA5cEVUVTdQY21MTUZxWE12Z3BG?=
 =?utf-8?B?WlNFZTYxOTFtZlJjaXJJdVJ0Zm0yaTl5dDZTTm5ScFo3SStoQzNpL2pKNHZG?=
 =?utf-8?B?UEY1ZUZ2MkVqUU5VOWY5SEQwUEowUk9FRzRzRUVkUk55d2h6eEdxSWFjdUxs?=
 =?utf-8?B?Qm5GdkxnajlFZllBQzNtYTVBa1NJNEVnV2krYW40OTI2MmVxVnJtT0p1aEpy?=
 =?utf-8?B?MGVNZVVoUVhPd250L2ZKNEtSMjF3ekJqK1c2WUpIVk1rdlozREFOY0lBOWxN?=
 =?utf-8?B?eWxHcVRuWkM1Z2Q4cXJpWktVL2ZUTTV5MVBad2QxNEM5cFI0aEV1RDVCamFj?=
 =?utf-8?B?QnhOM3owdlF4QnZUbWZhWG5PU0tWaHlrUEJ6cm12SitJdXNOcENMSDgvenc1?=
 =?utf-8?B?SDZHQlNQV3VabG1IOVNUNEN0RzlCcmpsY1ZKajlYbyttVTJydE8rVzRURmJv?=
 =?utf-8?B?N250UWRESVV0bWQ2bTF0UXVHQ25RdzBtVzFiQVVCejI4NDlzWVdMUzVJR2c3?=
 =?utf-8?B?STVraFZjSHN1SStQQThHYVEyMVQ0T3VjWnJ1a0h1LytLb2F3SGE3bE9qUllM?=
 =?utf-8?B?OXJ5OVBKNXJMdXhmYXZ5bFlINllOdmowdkRvZ3Y1OWx1Rkh6cGRUZmM2TUha?=
 =?utf-8?B?MFdpSzI1YVAzcU1LQXV6djFadE51M3duTG9lVUtRWStDZ0IzS2VjbVFhdFhp?=
 =?utf-8?B?QXBHckt1Um4yOEFrZEVOcHhrY1FUNS9JWm9hb2x1cGhGcVhiTUpUS09YYkhH?=
 =?utf-8?B?R1dLMGVMQjQ5bUp6cG1XNlJ2a3JsNllMSjQ2TDJ6UTVIK1Y5UmswcUVzNUhi?=
 =?utf-8?B?TlE1QTlaR2dxRkZ6SnNhU3FSNnY2QitPRXJJTFpBQ2U3Uy91NS9PTmpJRFZy?=
 =?utf-8?B?OXJQMDUybEEyQ3lWRmsxWFd6YWJDbVBMd1BzR09HWFBNSDEvUnU4TGY1UGJy?=
 =?utf-8?B?QXJaakN5dlFHS2F5L1A4eDBqNWtIQlNiYW9oNGV3WTVvajR5VEJMb0IwN2Zi?=
 =?utf-8?B?UlQrTFpaL1Q4b1pVRTFFYnlHdVlXMUFaUWJLdEVJVUNVUUFiUzB6Mks1c0hj?=
 =?utf-8?B?dS9uSG9heEFNS0U4b2VFLzNxWmdkV3MrOXgyOUpMai82QlN3QWVHQ3c4MDhj?=
 =?utf-8?B?bnRvNE5XOEF3QXRPVW9KaXAzSXI0Q0dwNjhYUjg0VDRzSmY0MzkwSm9tczIv?=
 =?utf-8?B?ajVxWnBhS0NCaVpGcDFWSE0zaldBalV1YzIxTjA0UXNvSDBXU05qQ2ZaQWh4?=
 =?utf-8?B?R3FMcXFvTHVPb2VneitNOGNXM0hsdHFlWUFleEpSWlVXeHRxUjNEUktKcU5H?=
 =?utf-8?B?K1I4YWg2T0lmVEFBUHV5UVg0eHFNSVI2cTZBNjNrU1BpMjRUczMrdmxHZ1lt?=
 =?utf-8?B?VGExQzQ3SEMxQ0IrWE5nbThnSlRDdHQ5YW1yNVpRN0draGd1bXhVQlpwUkJV?=
 =?utf-8?B?aGFaVW14SFpZNTZFakUvRzJXY3BvRWtvSGxWcUNtbWRkM0daMmQzVjJwb3FX?=
 =?utf-8?B?MlBKVVN1WTJDNjFUanhBMUJ1Tm52SjdNcEpDM1h5U0pNWVFEVkFRK01xZjQ2?=
 =?utf-8?Q?S03TuoJieBWRnH/hnds38M94i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6084.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b428d98-1fad-48c1-554f-08db7d35f75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 08:58:13.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMmUztscHHuvur95I5q/8k7mmgPfosZmo2djGcbQeladsDg7sYTZUqaAj2muN53TVmc4cxs8u2flKpZzDq5E3RLf7ZYqvBjW2Xrt2KVF0z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VtYXJpIFBhbGxh
dmkgPGt1bWFyaS5wYWxsYXZpQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDIzLCAy
MDIzIDI6MjkgUE0NCj4gVG86IHJjc2VrYXJAc2Ftc3VuZy5jb207IHdnQGdyYW5kZWdnZXIuY29t
OyBta2xAcGVuZ3V0cm9uaXguZGU7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb20NCj4gQ2M6IFNh
bmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGEgPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5uYXZhckBp
bnRlbC5jb20+Ow0KPiBOaWt1bGEsIEphcmtrbyA8amFya2tvLm5pa3VsYUBpbnRlbC5jb20+OyBs
aW51eC1jYW5Admdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBLdW1hcmkgUGFsbGF2aQ0KPiA8a3VtYXJpLnBhbGxh
dmlAaW50ZWwuY29tPjsgVGhva2FsYSwgU3Jpa2FudGggPHNyaWthbnRoLnRob2thbGFAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBbUkVTRU5EXSBbUEFUQ0ggMS8xXSBjYW46IG1fY2FuOiBDb250cm9s
IHR4IGFuZCByeCBmbG93IHRvIGF2b2lkDQo+IGNvbW11bmljYXRpb24gc3RhbGwNCj4gDQo+IElu
IGJpLWRpcmVjdGlvbmFsIENBTiB0cmFuc2ZlciB1c2luZyBNX0NBTiBJUCwgd2l0aCB0aGUgZnJh
bWUgZ2FwIGJlaW5nIHNldCB0bw0KPiAnMCcsIGl0IGxlYWRzIHRvIFByb3RvY29sIGVycm9yIGlu
IEFyYml0cmF0aW9uIHBoYXNlIHJlc3VsdGluZyBpbiBjb21tdW5pY2F0aW9uDQo+IHN0YWxsLg0K
PiBEaXNjdXNzZWQgd2l0aCBCb3NjaCBNX0NBTiBJUCB0ZWFtIGFuZCB0aGUgc3RhbGwgaXNzdWUg
Y2FuIG9ubHkgYmUgb3ZlcmNvbWUNCj4gYnkgY29udHJvbGxpbmcgdGhlIHR4IGFuZCByeCBwYWNr
ZXRzIGZsb3cgYXMgZG9uZSBieSB0aGUgcGF0Y2guDQo+IA0KPiBSeCBwYWNrZXRzIHdvdWxkIGFs
c28gYmUgc2VydmljZWQgd2hlbiB0aGVyZSBpcyBhIHR4IGludGVycnVwdC4gVGhlIHNvbHV0aW9u
IGhhcw0KPiBiZWVuIHRlc3RlZCBleHRlbnNpdmVseSBmb3IgbW9yZSB0aGFuIDEwIGRheXMsIGFu
ZCBubyBpc3N1ZXMgaGFzIGJlZW4gb2JzZXJ2ZWQuDQo+IA0KPiBTZXR1cCB0aGF0IGlzIHVzZWQg
dG8gcmVwcm9kdWNlIHRoZSBpc3N1ZToNCj4gDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0rCQkr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gfEludGVsIEVsa2hhcnRMYWtlICAgIHwJCXxJbnRl
bCBFbGtoYXJ0TGFrZSAgICAgfA0KPiB8CSstLS0tLS0tLSsgICAgfAkJfAkrLS0tLS0tLS0rICAg
ICB8DQo+IHwJfG1fY2FuIDAgfCAgICB8PD09PT09PT0+fAl8bV9jYW4gMCB8ICAgICB8DQo+IHwJ
Ky0tLS0tLS0tKyAgICB8CQl8CSstLS0tLS0tLSsgICAgIHwNCj4gKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsJCSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiANCj4gU3RlcHMgdG8gYmUgcnVuIG9u
IHRoZSB0d28gRWxraGFydGxha2UgSFc6DQo+IA0KPiAxLiBpcCBsaW5rIHNldCBjYW4wIHR5cGUg
Y2FuIGJpdHJhdGUgMTAwMDAwMCAyLiBpcCBsaW5rIHNldCBjYW4wIHR4cXVldWVsZW4gMjA0OCAz
Lg0KPiBpcCBsaW5rIHNldCBjYW4wIHVwIDQuIGNhbmdlbiAtZyAwIGNhbjAgNS4gY2FuZHVtcCBj
YW4wDQo+IA0KPiBjYW5nZW4gLWcgMCBjYW4wICYgY2FuZHVtcCBjYW4wIGNvbW1hbmRzIGFyZSB1
c2VkIGZvciB0cmFuc21pdCBhbmQgcmVjZWl2ZQ0KPiBvbiBib3RoIHRoZSBtX2NhbiBIVyBzaW11
bHRhbmVvdXNseSB3aGVyZSAtZyBpcyB0aGUgZnJhbWUgZ2FwIGJldHdlZW4gdHdvDQo+IGZyYW1l
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1bWFyaSBQYWxsYXZpIDxrdW1hcmkucGFsbGF2aUBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaWthbnRoIFRob2thbGEgPHNyaWthbnRoLnRo
b2thbGFAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5j
IHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYyBiL2Ry
aXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jDQo+IGluZGV4IGE1MDAzNDM1ODAyYi4uOTRhYTBi
YTg5MjAyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYw0KPiBAQCAtMTExOCw3ICsxMTE4LDcg
QEAgc3RhdGljIGlycXJldHVybl90IG1fY2FuX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+
ICAJCQkvKiBOZXcgVFggRklGTyBFbGVtZW50IGFycml2ZWQgKi8NCj4gIAkJCWlmIChtX2Nhbl9l
Y2hvX3R4X2V2ZW50KGRldikgIT0gMCkNCj4gIAkJCQlnb3RvIG91dF9mYWlsOw0KPiAtDQo+ICsJ
CQltX2Nhbl93cml0ZShjZGV2LCBNX0NBTl9JRSwgSVJfQUxMX0lOVCAmDQo+IH4oSVJfVEVGTikp
Ow0KPiAgCQkJaWYgKG5ldGlmX3F1ZXVlX3N0b3BwZWQoZGV2KSAmJg0KPiAgCQkJICAgICFtX2Nh
bl90eF9maWZvX2Z1bGwoY2RldikpDQo+ICAJCQkJbmV0aWZfd2FrZV9xdWV1ZShkZXYpOw0KPiBA
QCAtMTc4Nyw2ICsxNzg3LDcgQEAgc3RhdGljIG5ldGRldl90eF90IG1fY2FuX3N0YXJ0X3htaXQo
c3RydWN0IHNrX2J1ZmYNCj4gKnNrYiwNCj4gIAkJfQ0KPiAgCX0gZWxzZSB7DQo+ICAJCWNkZXYt
PnR4X3NrYiA9IHNrYjsNCj4gKwkJbV9jYW5fd3JpdGUoY2RldiwgTV9DQU5fSUUsIElSX0FMTF9J
TlQgJiAoSVJfVEVGTikpOw0KPiAgCQlyZXR1cm4gbV9jYW5fdHhfaGFuZGxlcihjZGV2KTsNCj4g
IAl9DQo+IA0KDQpLaW5kbHkgcmV2aWV3IHRoZSBwYXRjaCBhbmQgcGxlYXNlIGxldCB1cyBrbm93
IGlmIGFueSBjb21tZW50cyENCg0KVGhhbmtzLA0KUGFsbGF2aQ0KPiAtLQ0KPiAyLjE3LjENCg0K
