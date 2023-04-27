Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12F6F05CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbjD0M36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbjD0M3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:29:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7AC213A;
        Thu, 27 Apr 2023 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682598594; x=1714134594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aINkv73aCBdIBmSsgsey6Ll22sGFWTjYXX6PkeNySSE=;
  b=cOm8Y84u75f2xwUUjkuF0O9wJMYUOCPTMlRGTCg4yEwXTbJ+7LTklNZv
   B4ycfXckEp/At+7s6swlqjsCkVC7T3hJZ6NoqbES57IC/eY6QcXydVW2y
   fi50LHD6zr7NlfkGDCE8HJGzM45Ag0ztd5N/VADClF21s3MNRyRCzNTUI
   XgFPliuHtunBcQrH4Dixsyc/fEWg2CwyjlCebCyW1+ouMWNZJDtnHXHn2
   yBJdcgvPiczeSYVhs0ambQr5Wg/cI2yzk4XdX1IM/xa5dO6x0qbD+MsCG
   ilp5yib2q/YkiD0VsnXAyg7C+gr0cT4grmECIq0nw7pNmofuwfYfLgIXe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="346183526"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="346183526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 05:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="818507215"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="818507215"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2023 05:29:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 05:29:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 05:29:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 05:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z34XzDC1DVE+SBmk1G9g2hKWc88GxNDwHVqguZv4nBV0jCDDTRnU6B7biaSyCzzfqYBipIy9mJmRJHNgXjdpm4bcyrxCUiksZvXgYMFa6Ss2CDu9eJRjVj7HfIsTpN6QHma4nqBz1egDq+MRSlinZ2uakW8gOVqUiRFSZX0bur22euwCIZzAdFhc00V2lI2RNZ4EgnmkHweTKCN3thQdVbSbqa8VAyfaNGdSNcX10ltSniI4DdoQJHbTAdIemMyUajPuyUSCDxkrXuwgcYhnZpRp9oYbDekbzwuRat8XcyOEp+FU/wHahSqspuMtEMt+1KlfoSoubtyeYZ7tl8ZSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aINkv73aCBdIBmSsgsey6Ll22sGFWTjYXX6PkeNySSE=;
 b=NDNlOdLpMF+LvxfiXRvEXADdHRG2zVm4eSkj0QZK+rYjesvuEP27NYYXgeRxQaZgMn7G/jWr/bHzXi8UOwaHYwe8inldimRZgQxfVKlzu2+ihp7p30KEADm90kCr2NTxNezgRtQ7oKm2e26ZKO07bnXxQvTEb7S8oeTsQk/9N+9w0Ts7wDJfSBj5YebsK6w/YL17nDgpoj8BFlfEaGnqSwnRAiFsRoLEzgmpFHAAQBaFdkBBNxNhdtg2q3vZywjeWHBsRSxfKtTd2uLObdTwcIytUwRJ/+Un3/iENHgLRnUUQvhzNM6uljjxWQwm8sGHTq+50wxL9nAjrnvZ22j+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 12:29:50 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e%2]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 12:29:50 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Subject: RE: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Topic: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Index: AQHZYLcIL5h5EiW/WUeIdC3dxCgzQa88TIUAgAFu+xCAACTfgIAADDGAgAA6f4CAAAkpAIAABgcAgAAVswCAAPhLMA==
Date:   Thu, 27 Apr 2023 12:29:49 +0000
Message-ID: <DM8PR11MB57502652613A19C1A65D10BDE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com> <ZEmBULXp24oMxaUH@google.com>
 <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com> <ZEmYR0fWl05lGW0d@google.com>
In-Reply-To: <ZEmYR0fWl05lGW0d@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CH3PR11MB8156:EE_
x-ms-office365-filtering-correlation-id: 25120f1a-aa5a-4930-7c18-08db471b182e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luIwivFhMXE6RoOKNXrYzlX0190+95B7xqbe8tYfY5n4KEA0oo49QlYi5eNNE3FPytTwRQfqM6lr2BgEvYbIO6rqRXA+GMrHM/gnUu5ElhnfWJjPyXMzWAkWD+w3Yn06P52hrwfQfV+rbUAFYwy9EyPx2kuxC+YS4ZY0hb9S7N8ivQyYBVaFjJc2wdNMxj1024HM1zdTd0bQDX7w21/o4UXeRIUudvh3x3FBMImYazMaEDscQpT+ea0xgh31HWWlTL/RHUjMh749AH93CdNH/1WVMLf08TLyIwKLTj2misVRwWJ8srtKIlyvxAmIah7mWxhgRew86gYpcatE9u0mqHXcAz31TEVWnb/VUan+LQE6H9oVSa4NYBBb0SqoW5ou2ewOct5dPzoInf+hF3RVvd6vtvogzQFU/Wb1bo72XqWQr3DnGTgZJBkPPoxR/D3ufDYXlk20gN3X7dOPMji7HCiAQfUJqO84O1DYO+CkV1YGgGWXPl5n6Iy09Z7kRk8z1owSmmA3d2pV+SS//3mM8RLW2BMP7Z44Tn+BuraJRsbnBFXHTFGhD/QD+geoded8x+AQj1fVcjpa7NcUsvv/sGvMbnVQxMHmP081pmJ3Ia1VV1s0ms0SxTF+F5rxSOAq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(66446008)(66556008)(66946007)(316002)(66476007)(4326008)(110136005)(54906003)(76116006)(7416002)(7406005)(5660300002)(55016003)(15650500001)(82960400001)(52536014)(38070700005)(41300700001)(64756008)(8936002)(8676002)(2906002)(122000001)(38100700002)(186003)(53546011)(26005)(9686003)(6506007)(83380400001)(33656002)(86362001)(478600001)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1JGZVQybzJNUlFlM0RIaHhBWDdmeVdhMDFWZ1g1SU5URHQrTkREeDNqckZ4?=
 =?utf-8?B?TEZkeC8rSmYvemdLRTdYdTJSODBjM3piUWwrVC9jWlpIeUVBVWZESDA4czhM?=
 =?utf-8?B?OHNMVVdrcU8ybCtVNGdBcE1KZUdGN3c1RE43YitESERIa0hINndYN1g1cWpC?=
 =?utf-8?B?QWJWUEh3MkFnaTN0akFudjM3VGl4NElyT2hFWVdiajErdFNEVlorK2N6aGQz?=
 =?utf-8?B?Y2RUK0Nkb1B4OTRiOTRhSDNhZmZ0Y0VxSU4xNDZMRWphcFRnczVvM3NUTEVZ?=
 =?utf-8?B?Z2lzUnVaR3JyK2sva0V4eHNQanBWYXZ2Q2thT2dtdFdNSEhmZVpnZm1nMS9H?=
 =?utf-8?B?TmNETVB2UHRmMUtlQTJNTVhrNDFTeEJpVXBkZzRhVHd5bmkvSldubWlQSFBY?=
 =?utf-8?B?b2JiNVpkNFM0aUJZRDJDeFAvNERXVUdMV21qYXhGTk9wLzhmV0Yzby9CVG1v?=
 =?utf-8?B?MmhKUFYxUVpRQ3NIMmJGbys1azRZejZTODh0N1BrSGVPeGVSbmxPOFM3Z3k0?=
 =?utf-8?B?RnpjRStTM1ByczNWNTJYSDloN2FCWlF5ZTgwVGtRaW1uSUhWZmFiWG1yM240?=
 =?utf-8?B?RWw3R0tZZE9PT0FzWmJsZGZ6c0laTm9KVE1EWXNvRUhlVXlLaW1TTFhheXE4?=
 =?utf-8?B?dkFwNGxpTmpPM1QrNHBWSDk3VkpxSkxHVXgrT1BReHlZK0MxVnc3ZStmWDhu?=
 =?utf-8?B?RElOTHhyOENSdldJVzRuNkp0aDF6STVwUnJnb0ZCNmhCN0IwVnQ0WFJtWm5s?=
 =?utf-8?B?ZE81eWFsYnBXK05xaHJYWllFREQ0UXRCNXhBbFBoekkwM001dml0RFdCU3hw?=
 =?utf-8?B?OGFEVlMycS8vUXd3cFp6eVVibE5wOE5QR2NqRjNSbmZYRmR3aEE0d25GWUk5?=
 =?utf-8?B?NnVRQVFaelZ2bkNMQlZNT2FKSjZoTnVudlJHTzRDR1RLV0VjNEtuVW1QVWgr?=
 =?utf-8?B?Z09jYjk2VkJYTWJNV3NraXZ1Y0xnSWo5Tng4YXZoVS9rSzNETGd3eGFiSUtL?=
 =?utf-8?B?UWFwNm9wZnczVUdBL1RKaG81dDIreWkvYkliWlR0dWsyQ1FiWUk1ZDBuZWpJ?=
 =?utf-8?B?VEhJb2hub0dTdWdxT1hxWnJNb3huRkNYVXRRby90SEhTcjFkVE5tb3orZ2xn?=
 =?utf-8?B?a3cxWTBzak1YSlRaSlBCVE9SdloyWGJybDNKUDF5MzFNQngwYUoyd0x1K3cz?=
 =?utf-8?B?RWZ0YWRQdk1KbzJGYnZQSmVWcUNYVExzcnN0cXZQNmo3U09oWk5qeFNDNGZa?=
 =?utf-8?B?c0FoMlB5MjdXUEl0US84YkZLNHQrbEpFMktxL3V1R3ExaThqam5JUHJUNU4w?=
 =?utf-8?B?a2J2ZE1Fd2RVSDdObTJ4Zjd3UU1XbVl2OVZiVjlYN09ndG8xZ0R5MWdNd1Nq?=
 =?utf-8?B?SldkTnBlNlBTZGJCcHM2N3BKUHFvZ0RVbEFRbStNVUh2K3p5VVNYazJ5VHVR?=
 =?utf-8?B?YXpPUE43aGh6VDg2VnRNODgwSndIb2FYQXd3MEJhbDlWVlRGNWZ1Qi9ITGJt?=
 =?utf-8?B?WmhwU2d5NDY5azBweDh6TkJsTlNHbzRxTzRDcnd6OHNRSUFXV05pSmFERDhN?=
 =?utf-8?B?MGpuODdoaTRoenRVUHFvcGZCMlYrZisxT3FHeGJHM2kxVWNtQW1CT1R4VDJh?=
 =?utf-8?B?M3FHa3JSYkVSUklmb04wVnFFVWorVUdReURxUDluT1FpSTNsSnUySitxOVVE?=
 =?utf-8?B?MHorZXlzcUphaGdzZm1FNmVxZFZFQ0N3d2gzWjBCR1ZiWVQzdjQybDI0UGF6?=
 =?utf-8?B?SXpRTjNmRTRsblI2UjI3bkZtTGVKYnAvbE03QjJMT1o0TkdjMGwyNnk3cTB4?=
 =?utf-8?B?T0xjZnAwa3VNVDVHNFF3MGQxVlY3T2dRVjRkQ29hQ0g5RzNzVWNKei9TZHk3?=
 =?utf-8?B?MTFnK1ZoTCtvOE9JY0RSMkdxYzZneHNJRkNBeUR0eW5GYUY4dm04TWl1dVF6?=
 =?utf-8?B?OTgvOHlubWdWS1dKSVpLSzdEK1Vqb3hsWGY2Zy83RytLZWV1UlNoZEpWSXF3?=
 =?utf-8?B?MVZ2R3RnOWcyNDRzaDB0OUVURTgvTEgwa0JiMndnZVk1WnllcHVoKzZidjBC?=
 =?utf-8?B?MFZ6aGh6a09PM1ovWTZrUXFhNnE4bm44NzhoT2FTUjFZZE9ENDZkZGxrSHJZ?=
 =?utf-8?Q?6X10OS/Fo3NI+9xwUJCZ4kgJU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25120f1a-aa5a-4930-7c18-08db471b182e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 12:29:49.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmTOxNGUCtNPaNJ+3GxUysjUIFoQipQry+gtD35W170pcQUTFWHVLrbPz8tz1BjWUX5j8iU2M7gqelcFTTUVD0LDYCaISnQFyBUt/Ew+3uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEFwciAyNiwgMjAyMywgQ2FybG9zIEJpbGJhbyB3cm90ZToNCj4gPiBPbiA0LzI2
LzIzIDI6NTMgUE0sIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEFw
ciAyNiwgMjAyMywgQ2FybG9zIEJpbGJhbyB3cm90ZToNCj4gPiA+PiBPbiA0LzI2LzIzIDEwOjUx
IEFNLCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPiA+ID4+PiBUaGlzIGRvY3VtZW50IGlz
IG5hbWVkIGNvbmZpZGVudGlhbC1jb21wdXRpbmcucnN0LCBub3QgdGR4LWFuZC1zbnAucnN0Lg0K
PiBOb3QNCj4gPiA+Pj4gZXhwbGljaXRseSBtZW50aW9uaW5nIFNFViBkb2Vzbid0IG1hZ2ljYWxs
eSB3YXJwIHJlYWxpdHkgdG8gbWFrZQ0KPiBkZXNjcmlwdGlvbnMgbGlrZQ0KPiA+ID4+PiB0aGlz
IG9uZSBmcm9tIHNlY3VyaXR5L3NlY3JldHMvY29jby5yc3QgZGlzYXBwZWFyOg0KPiA+ID4+Pg0K
PiA+ID4+PiAgIEludHJvZHVjdGlvbg0KPiA+ID4+PiAgID09PT09PT09PT09PQ0KPiA+ID4+Pg0K
PiA+ID4+PiAgIENvbmZpZGVudGlhbCBDb21wdXRpbmcgKGNvY28pIGhhcmR3YXJlIHN1Y2ggYXMg
QU1EIFNFViAoU2VjdXJlDQo+IEVuY3J5cHRlZA0KPiA+ID4+PiAgIFZpcnR1YWxpemF0aW9uKSBh
bGxvd3MgZ3Vlc3Qgb3duZXJzIHRvIGluamVjdCBzZWNyZXRzIGludG8gdGhlIFZNcw0KPiA+ID4+
PiAgIG1lbW9yeSB3aXRob3V0IHRoZSBob3N0L2h5cGVydmlzb3IgYmVpbmcgYWJsZSB0byByZWFk
IHRoZW0uDQo+ID4gPj4+DQo+ID4gPj4+IE15IGNvbXBsYWludCBhYm91dCB0aGlzIGRvY3VtZW50
IGJlaW5nIHRvbyBJbnRlbC9BTUQgY2VudHJpYyBpc24ndCB0aGF0IGl0DQo+IGRvZXNuJ3QNCj4g
PiA+Pj4gbWVudGlvbiBvdGhlciBpbXBsZW1lbnRhdGlvbnMsIGl0J3MgdGhhdCB0aGUgZG9jIGRl
c2NyaWJlcyBDb0NvIHB1cmVseQ0KPiBmcm9tIHRoZQ0KPiA+ID4+PiBuYXJyb3cgdmlld3BvaW50
IG9mIEludGVsIFREWCBhbmQgQU1EIFNOUCwgYW5kIHRvIGJlIGJsdW50LCByZWFkcyBsaWtlIGEN
Cj4gcHJlc3MNCj4gPiA+Pj4gcmVsZWFzZSBhbmQgbm90IGFuIG9iamVjdGl2ZSBvdmVydmlldyBv
ZiBDb0NvLg0KPiA+ID4+DQo+ID4gPj4gQmUgc3BlY2lmaWMgYWJvdXQgdGhlIHBhcnRzIG9mIHRo
ZSBkb2N1bWVudCB0aGF0IHlvdSBmZWVsIGFyZSB0b28NCj4gPiA+PiBBTUQvSW50ZWwgY2VudHJp
YywgYW5kIHdlIHdpbGwgY29ycmVjdCB0aGVtLg0KPiA+ID4NCj4gPiA+IFRoZSB3aG9sZSB0aGlu
Zz8gIFRoZXJlIGFyZW4ndCBzcGVjaWZpYyBwYXJ0cyB0aGF0IGFyZSB0b28gU05QL1REWCBjZW50
cmljLCB0aGUNCj4gPiA+IGVudGlyZSB0b25lIGFuZCBhcHByb2FjaCBvZiB0aGUgZG9jdW1lbnQg
aXMgd3JvbmcuICBBcyBJIHJlc3BvbmRlZCB0byBEYXZlLA0KPiBJDQo+ID4gPiB3b3VsZCBmZWVs
IGRpZmZlcmVudGx5IGlmIHRoZSBkb2N1bWVudCB3ZXJlIG5hbWVkIHRkeC1hbmQtc25wLXRocmVh
dC0NCj4gbW9kZWwucnN0LA0KPiA+ID4gYnV0IHRoaXMgcGF0Y2ggcHJvcG9zZXMgYSBnZW5lcmlj
IGNvbmZpZGVudGlhbC1jb21wdXRpbmcucnN0IGFuZCBwcmVzZW50cyB0aGUNCj4gPiA+IFNOUCtU
RFggY29uZmlkZW50aWFsIFZNIHVzZSBjYXNlIGFzIGlmIGl0J3MgdGhlICpvbmx5KiBjb25maWRl
bnRpYWwgY29tcHV0aW5nDQo+IHVzZQ0KPiA+ID4gY2FzZS4NCj4gPg0KPiA+IFdoYXQgcGFydCBv
ZiB1cyBkZXNjcmliaW5nIHRoZSBjdXJyZW50IExpbnV4IGtlcm5lbCB0aHJlYXQgbW9kZWwgb3IN
Cj4gPiBkZWZpbmluZyBiYXNpYyBjb25jZXB0cyBvZiBjb25maWRlbnRpYWwgY29tcHV0aW5nIGlz
IFNOUC9URFggY2VudHJpYz8NCj4gPg0KPiA+IElNSE8sIHNpbXBseSBzdGF0aW5nIHRoYXQgInRo
ZSB3aG9sZSB0aGluZyIgaXMgd3JvbmcgYW5kIHRoYXQgeW91IGRvbid0DQo+ID4gbGlrZSB0aGUg
InRvbmUiLCBpcyBub3QgbWFraW5nIGEgZ29vZCBlbm91Z2ggY2FzZSBmb3IgdXMgdG8gY2hhbmdl
DQo+ID4gYW55dGhpbmcsIGluY2x1ZGluZyB0aGUgbmFtZSBvZiB0aGUgZG9jdW1lbnQuDQo+IA0K
PiBJIGhvbmVzdGx5IGRvbid0IGtub3cgaG93IHRvIHJlc3BvbmQgc2luY2UgeW91IGFyZSBlaXRo
ZXIgdW5hYmxlIG9yIHVud2lsbGluZyB0bw0KPiBzZWUgdGhlIHByb2JsZW1zIHdpdGggbmFtaW5n
IGEgZG9jdW1lbnQgImNvbmZpZGVudGlhbCBjb21wdXRpbmciIGFuZCB0aGVuDQo+IHRhbGtpbmcN
Cj4gb25seSBhYm91dCBvbmUgdmVyeSwgdmVyeSBzcGVjaWZpYyBmbGF2b3Igb2YgY29uZmlkZW50
aWFsIGNvbXB1dGluZyBhcyBpZiB0aGF0IGlzDQo+IHRoZSBvbmx5IGZsYXZvciBvZiBjb25maWRl
bnRpYWwgY29tcHV0aW5nLg0KDQpUaGlzIGlzIHNpbXBseSBhbiB1bmZhaXIgc3RhdGVtZW50LiBJ
IHJlcGxpZWQgeWVzdGVyZGF5IG9uIHRoaXMgcGFydGljdWxhciBhbmdsZSwgaS5lLg0KbGV0J3Mg
dGhpbmsgb24gaG93IHRvIG5hbWUgdGhpcyBwcm9wZXJseTogZXhwbGFpbmVkIG91ciB0aGlua2lu
ZyBiZWhpbmQgdXNpbmcgdGhlIA0KIkNvbmZpZGVudGlhbCBDbG91ZCBDb21wdXRpbmciIHRlcm0g
KHdpdGggcmVmZXJlbmNlcyB0byBhY2FkZW1pYSB1c2luZyBpdCkgYW5kIGFza2VkDQp3aGF0IHRo
ZSBiZXR0ZXIgbmFtZSBzaG91bGQgYmUuIEkgZGlkbuKAmXQgZ2V0IGEgcmVwbHkgdG8gdGhhdCwg
YnV0IGhlcmUgeW91IHNheSB3ZQ0KYXJlIG5vdCB3aWxsaW5nIHRvIGNvb3BlcmF0ZS4uLg0KDQpT
byBJIGRvbuKAmXQgdGhpbmsgaXQgaXMgZmFpciB0byBzYXkgdGhhdCB3ZSBkb27igJl0IHRha2Ug
ZmVlZGJhY2shIA0KDQpJIGFncmVlIHdpdGggRGF2ZSB0aGF0IEkgdGhpbmsgdGhlIGdvYWwgb2Yg
dGhpcyBkb2N1bWVudCBpcyBub3QgdG8gY29tZSB1cCB3aXRoIGENCmZhbmN5IG5hbWUgKEkgYW0g
ZmluZSB3aXRoIGNhbGwgaXQgYW55dGhpbmcpLCBidXQgdG8gaW50cm9kdWNlIGtlcm5lbCBkZXZl
bG9wZXJzIHRvIHRoZSANCm5ldyBMaW51eCB0aHJlYXQgbW9kZWwgYW5nbGUgZm9yIHRoaXMtcGFy
dGljdWxhci11c2UtY2FzZS1vZi1jb25maWRlbnRpYWwtY29tcHV0aW5nLg0KU28gdGhhdCB3aGVu
IHdlIHN1Ym1pdCB0aGUgaGFyZGVuaW5nIG1lY2hhbmlzbXMgaW4gdGhlIGZ1dHVyZSBwZW9wbGUg
YXJlIA0KYWxyZWFkeSBmYW1pbGlhciB3aXRoIHdoeSB3ZSBuZWVkIHRvIGRvIHRoaXMgYW5kIHdl
IGRvbuKAmXQgaGF2ZSB0byByZXBlYXQgdGhpcyBzdG9yeSANCmFnYWluIGFuZCBhZ2Fpbi4gDQoN
CkJlc3QgUmVnYXJkcywNCkVsZW5hLiANCg==
