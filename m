Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34043614359
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKAClu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKACls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:41:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C2E1789B;
        Mon, 31 Oct 2022 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667270508; x=1698806508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VAXcZxjVNHA/YNj8/aGDnklwai0v4JL4oxtQlslvVZs=;
  b=JVM/w/G27ZYnfglVc/AncWYzTPmMem/ilIIGdt/9TdF98CiFJI+WyH5n
   m0FJdBtPfks566jWccAcycG6VXO9KtrabfxM6AMjK/NfHaGJmbCa5VGVN
   +qnKXuf/cyj2DBdL0kitdecoxsVdA0AahKnCasDNlN5ITq/eXSqSccZjY
   83obD5geM+SxFimI9n1836/pbbSQRyDsldIoSAD3L7DVZwhFIzO8nQIo5
   Dc1pTJkNIF3Io0bcbZWnnw/xcjD/rNXEcAL6ue2HXB4OUIr71AJpbrFHt
   bH67bx7SBQ7CbD5mpIOmplJcWnNuTIuZFDleHDu9M7V/uo5dSSESr7ziw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="371130880"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="371130880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="667049269"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="667049269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2022 19:41:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 19:41:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 19:41:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 19:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sah5Lp/cx9ApInKupzRALQa4Sd4G4+TowdT0LU6k0ybFQjizWdPI1HKv49HA2+O+O8Lc27WMS8pBBkH7sC1jlhfG93/I/UKlczW97J8y5xxX2pSzLtRRsuPu2b1CUFozN+svBmwOfj+Jjv8ApDhfQ/rsewNBG+lZliFaTf6Fp8VgbAyhfe6a/VKm2/76maaKaLshLn/re4XlY2d+IbIaiSFvnyj9RaNfroJqW6PVRIBLcM+9uiGCHNWx5Oy36k09hObiEpvQEAz/wNXLYcKq8niu8c6L/6JktygHptzGxFZn37v8IX/aYb3xrHUaf09cuvYu9TIAljcKTQbZ2wzSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAXcZxjVNHA/YNj8/aGDnklwai0v4JL4oxtQlslvVZs=;
 b=m+Np7k+/Jl1jwR0nCyCKqTdbS03qaLncivimRD2q8/OJFLvWuUrLVVQ6h41r+Brt6voxa6Ze8b6G+IvCuwF0gnjIvdYYDp7JlaFLvFQ+wLtNCGsrIh0WhDnFO/6c7KNTrD7LDqa1m5yBsg8QppP+dEf4ohOCq6QNZZ5u2PiY+qJZatgOcQY/VTjiOxpLE1Pt2omX811CUjb2woveCEKJS61fc3slMGu4W5Z4TZnhVut6+jAoG1mE1Ko6BuBzFk6jtcoQ6OmXFMtGCZ5bV/e+uYUZj55h74jdCfmOX/2labi4xf8u0r9zJfMPhvgQrZFRLlqificnw8sK6hd+ZM7U6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 02:41:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 02:41:39 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 3/3] x86/sgx: Add xa_store_range() return value
 check in sgx_setup_epc_section()
Thread-Topic: [RESEND PATCH 3/3] x86/sgx: Add xa_store_range() return value
 check in sgx_setup_epc_section()
Thread-Index: AQHY13Pfg2WQsgd00UuSgGOh0H9u1K3+0GKAgAAF4ICAKrHEAA==
Date:   Tue, 1 Nov 2022 02:41:39 +0000
Message-ID: <0b22047833ec63106b7b2c97ca0dcda0bd16470b.camel@intel.com>
References: <cover.1664834225.git.kai.huang@intel.com>
         <c02b60d3b92469a2ccfc0780e974d29da578be73.1664834225.git.kai.huang@intel.com>
         <Yzyx5333eIuX0zaT@kernel.org>
         <57b607fa66a84996174fd16be415ec65dbffe8d4.camel@intel.com>
In-Reply-To: <57b607fa66a84996174fd16be415ec65dbffe8d4.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5165:EE_
x-ms-office365-filtering-correlation-id: 5d6d686d-0482-48c7-965e-08dabbb29a7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWzxgDNurYetTqclYXrUr1kuWhRcYonfdEQgHxGsGXBPGnZxdTa4SzkueC4erbi7rJxifa1bBZ7a/SaZXJK8z2fDou8BXaRME1ALKD3nK6HBEFXcKMKcfioMySziXLM7XiRAC+W5ORBpKe7XdON5MTLM2v/F1sLU2P0c9v5ArJuGK9eyNjOuBhPcFzb1ZCKa19iLyHm6otKivlQV816iv2WXgdTkZ8qnm82I7xv/7aM0UYhXW4u2iebhv1tVRBJmHmddgOAEOP0h+1dAnZGMU583wztJKj0IyNXQdnpytagG9A6ol1mw+jT1gMPOQ9W4tKzRjPv8hEdsgZpEcO+h6tHOXwVHmF4Z/J5idTWxNh0mFVHAdN6wfNtoY9Peyk+oL8gVii0ZF+cl1rte+UwXf3td2EAvS0Y+wNynUEhmBXqE+QlxrLcWeeeGMXUq6FyYDECOXaTB9rQSXJObCpwMEpOGNwsfQoSe0xrpelQFZ07ft1akYQF/nBMNkjSD2KUd4F8iWZh1ye9cnKtaPqj/5ANVWbwAd4DlYRkz5lRA1z5LTQ8MdELLovDlJHDEwbiSOorhSMmCi2gUZ5FFTOZmYE9oWGmOVyDgWktf/4VPq3pNjXF9p4QJ8F8FHAsxicopsVhNorwB10ifdaBcYJsHTFrz+nt1v/tdYi3VwTdREQz2doezv+syfJuJ06WIQ+TYmL6miB2gbVFQ8ma/rpyaO/kWZcnEH+gM/tBc1U/r4GQdrB9WXFXIRI6+YZdtS3scts0auRP4qQrNZF5UE6d5Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(54906003)(110136005)(5660300002)(6512007)(8936002)(2616005)(66476007)(26005)(76116006)(66946007)(186003)(91956017)(2906002)(41300700001)(4326008)(66556008)(316002)(6506007)(36756003)(64756008)(66446008)(8676002)(86362001)(38100700002)(83380400001)(478600001)(71200400001)(6486002)(82960400001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUlyeENmdmh2MmppWlBRU0FHYVBBdGdyb0UxZ3RFYUZ2SENsMVY1YXBZczZQ?=
 =?utf-8?B?Z0tra212NnZxcmdaVFBGQVM1eU9wMktmV3VHaHFLcndabklXZ2hybEFMK3FJ?=
 =?utf-8?B?L0Z6UmxaMkZLV3V1eExwa3FxRHlvVUI3cC9rVk9BS3o2eWZCcTZZazlNYVI2?=
 =?utf-8?B?WUQ1SzVOTDl1TUhjMDIraVY5Q0E3UEVpVXFWUFp0UDlQSnBXeUI3NVlwOWl0?=
 =?utf-8?B?YXFBT3VhQlgwOWtKZ2dEbjNXSWExUE5oTnZ4TGZZOWs1RDk4OWVuNmRybXkx?=
 =?utf-8?B?aG1oT0Iwb01vRWpPSTdmSXNKWUxlajlMWHJncWlYTHkyc3p5RFZJUTdoa2hj?=
 =?utf-8?B?VlF4UnlaSDdBbVBkVDNubFlUOXBXY2p3NTB6SkhqNnk3ZkJHQ2U0TzVFWGFQ?=
 =?utf-8?B?ZHpuNXhhcVJYamVaSy85SDNZd3dLdXg3T1NHMkNSeGRYcjhVamNuZ3JXMWhW?=
 =?utf-8?B?aUJIWmNuMFVMMXBUNkZTazU2bTBYWlJNWWRCR3RyNjNFQnlpeWp6NWwxQjBU?=
 =?utf-8?B?S0p3VC9PU09NYlEzSHlJTlhOWEVldnZnaU1iYVplSXVrSy9tTWNXTG5DN0dw?=
 =?utf-8?B?Yi9tNjFNcCtZZXdrREdrTTZXVVBOOUphandvTlpXQkpxNXdKUUxLUUQrbFpL?=
 =?utf-8?B?N1VSVFZXS0FiRW1wSmZSZWpvaHBvczBOdW15ekZKSGxPV3hYM2t1ZHd3eTh3?=
 =?utf-8?B?SC9KL0R6NnpzeE5xOUh3TEFvdDE1elA3d3VBV0lNVmF0K1gzeHdLVTZ4d0xw?=
 =?utf-8?B?WXg3SHl5Y29zdCtLZHVMT2FqUU5zZjl5bzFVbjlKY3dDRlNPVG9zQnhuTDVX?=
 =?utf-8?B?UHprK1d6TStsWFVPWXdMclp2MEhZTk5uYUlWZHdwYW10SFFMQXRQM1l2R0c2?=
 =?utf-8?B?cC9UamFsNXFtQ2cyV21sNkVaQzZRNmdFS0ZzZTkrbUZwY3RmeEpkVFhZRkps?=
 =?utf-8?B?aTRISXBvYmhkY2NZeUhCVEFyMGxYK1lVTmt0eEZUblZHYkxyQnlSYUowMFdP?=
 =?utf-8?B?cTdQYk9kYTBGZmltWkhIeE9OMXZqTnpoSDM2QjFXZG90WTZPY09GYUo2VHpQ?=
 =?utf-8?B?VXM4ZER5QWJaR3dsTW1FWEF3bTZiVHh3UWRUdGJBbTJtai9KNWpoRzJRcHl2?=
 =?utf-8?B?dlpDL3RtczVRNGlGRGtNR2syQytQTjEyaFRZVk0wZjFHR2hZTUJHWWRtTXVx?=
 =?utf-8?B?MXZPaEZlb2pCWHdKMGRWQ1QvQkV6RTlQNHBqUXhhNVhPeEVNcm93RGZwOW5x?=
 =?utf-8?B?aHNxZE42bU9NYWViYWpoM3oxUE90L1JhcXhtb2IvYjBIODVxR2pGU2Q0QUFi?=
 =?utf-8?B?TVpwekMxdFpaYWhOMERBeVRLQU0zbnBuQll1dkxIOUVsbUM1S3VMcWRmZmxw?=
 =?utf-8?B?NmNnNk9JWDFjeGNydGllRGpVQWhabWdOMlBYY280WDFPaldPMjRtYjMremhW?=
 =?utf-8?B?NGdCWkFQbUJDaFNTY1ZNTFJlZzdNMDdyaEJDQndUYzR3ZWZ3MkIwOVBON3hw?=
 =?utf-8?B?OVpBS2pNM1V6NDRUcXZsajF1a3NSbnV3ckhWQmt2UUtTcE9vRWxYTkFWQmtm?=
 =?utf-8?B?TnBTV0tVdmhrTXhzKzIxaXYrb2xHcUZ5NllvQ3BzMGk1bjF1VER4b2tJMFBW?=
 =?utf-8?B?QUFPMGFJZ3RSTjdiaHNYeDVTamQ1SUVRUS9iRUZsUTEzbGljemVrSGswYzdh?=
 =?utf-8?B?WmdtNDI3a20zOGJCcmRtK1UzZ09vMFZIc1RKLzVacTBMdFdHcnZyWHpBNWE5?=
 =?utf-8?B?bEU2QnA2bjczZ1RLMExNTFBrak1ONTdadkJnbURFUy81L1ZXdk9XUHZpSFY2?=
 =?utf-8?B?d1dZNTdYS1MwbVJhTDllSHowUmdISzlyWW5JY3JrUDU3ZFBQbGpqa0R5NHBK?=
 =?utf-8?B?Ulh0akJQTnJIc2JaUzF1dEdVRXIwM0cyVlpMMnFhZGhkR2JDelpjWWlSTGt4?=
 =?utf-8?B?N05hbjBQd1lrTGFjS2NhMkIrTXYxbkN6a1J6eDBZU2lDYXVKcHA0a3g1d2E5?=
 =?utf-8?B?RWgzUVM1MWYvSkhiT0x6V0xOeVIxamdOQ3M4WE5ndnMycTFON2hqWnZkVGFN?=
 =?utf-8?B?R0pVYy9DdEtaa2ZoMDY5UG45NVl5QWdBRXNkZUdrblFWYTVFYzZGQk40Nnps?=
 =?utf-8?B?T0ovUDJVWm8xTWJVdzkxWUVqTnNBcVl4SmlpVVVBT29ya3F6QmR5Rjh5N25Z?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1F8985B5D05254E935C6F45A1C8FECC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6d686d-0482-48c7-965e-08dabbb29a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 02:41:39.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60I6dzixuLENpBb+XcKprc4MmE8VOZ5GvXver15rzU2qwDP5KaDA+HrK9oiNBSMZ7kBqBukqMbEuKbYg7+HKHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDIyOjQyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjItMTAtMDUgYXQgMDE6MjEgKzAzMDAsIEphcmtrbyBTYWtraW5lbiB3cm90ZToN
Cj4gPiBPbiBUdWUsIE9jdCAwNCwgMjAyMiBhdCAxMTowNDoyOUFNICsxMzAwLCBLYWkgSHVhbmcg
d3JvdGU6DQo+ID4gPiBJbiBzZ3hfc2V0dXBfZXBjX3NlY3Rpb24oKSwgeGFfc3RvcmVfcmFuZ2Uo
KSBpcyBjYWxsZWQgdG8gc3RvcmUgRVBDDQo+ID4gPiBwYWdlcycgb3duZXIgc2VjdGlvbiB0byBh
biBYYXJyYXkgdXNpbmcgcGh5c2ljYWwgYWRkcmVzc2VzIG9mIHRob3NlIEVQQw0KPiA+ID4gcGFn
ZXMgYXMgaW5kZXguICBDdXJyZW50bHksIHRoZSByZXR1cm4gdmFsdWUgb2YgeGFfc3RvcmVfcmFu
Z2UoKSBpcyBub3QNCj4gPiA+IGNoZWNrZWQsIGJ1dCBhY3R1YWxseSBpdCBjYW4gZmFpbCAoaS5l
LiBkdWUgdG8gLUVOT01FTSkuDQo+ID4gPiANCj4gPiA+IE5vdCBjaGVja2luZyB0aGUgcmV0dXJu
IHZhbHVlIG9mIHhhX3N0b3JlX3JhbmdlKCkgd291bGQgcmVzdWx0IGluIHRoZQ0KPiA+ID4gRVBD
IHNlY3Rpb24gYmVpbmcgdXNlZCBieSBTR1ggZHJpdmVyIChhbmQgS1ZNIFNHWCBndWVzdHMpLCBi
dXQgcGFydCBvcg0KPiA+ID4gYWxsIG9mIGl0cyBFUEMgcGFnZXMgbm90IGJlaW5nIGhhbmRsZWQg
YnkgdGhlIG1lbW9yeSBmYWlsdXJlIGhhbmRsaW5nIG9mDQo+ID4gPiBFUEMgcGFnZS4gIFN1Y2gg
aW5jb25zaXN0ZW5jeSBzaG91bGQgYmUgYXZvaWRlZCwgZXZlbiBhdCB0aGUgY29zdCB0aGF0DQo+
ID4gPiB0aGlzIHNlY3Rpb24gd29uJ3QgYmUgdXNlZCBieSB0aGUga2VybmVsLg0KPiA+ID4gDQo+
ID4gPiBBZGQgdGhlIG1pc3NpbmcgY2hlY2sgb2YgdGhlIHJldHVybiB2YWx1ZSBvZiB4YV9zdG9y
ZV9yYW5nZSgpLCBhbmQgd2hlbg0KPiA+ID4gaXQgZmFpbHMsIGNsZWFuIHVwIGFuZCBmYWlsIHRv
IGluaXRpYWxpemUgdGhlIEVQQyBzZWN0aW9uLg0KPiA+ID4gDQo+ID4gPiBGaXhlczogNDBlMGU3
ODQzZTIzICgieDg2L3NneDogQWRkIGluZnJhc3RydWN0dXJlIHRvIGlkZW50aWZ5IFNHWCBFUEMg
cGFnZXMiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwu
Y29tPg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJu
ZWwub3JnPg0KPiA+IA0KPiA+IFRoaXMgbmVlZHM6DQo+ID4gDQo+ID4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcgIyB2NS4xNysNCj4gPiANCj4gPiBEYXZlLCBjYW4geW91IHBpY2sgdGhpcyBp
bmRlcGVuZGVudGx5IG9mIHJlc3Qgb2YgdGhlIHBhdGNoIHNldA0KPiA+ICh1bmxlc3Mgb2ZjIHlv
dSBoYXZlIGNoYW5nZSBzdWdnZXN0aW9ucyk/DQo+ID4gDQo+ID4gQlIsIEphcmtrbw0KPiANCj4g
VGhhbmtzIEphcmtrby4gIEkgd2lsbCBhZGQgdGhlICJDYyBzdGFibGUiIHBhcnQgaWYgSSBuZWVk
IHRvIHNlbmQgb3V0IGEgbmV3DQo+IHZlcnNpb24uDQo+ICANCj4gLS0gDQo+IFRoYW5rcywNCj4g
LUthaQ0KPiANCg0KSGkgRGF2ZSwNCg0KSXMgdGhpcyBwYXRjaCB3b3J0aCB0byBkbz8gIEZvciBu
b3cgdGhpcyBzaG91bGQgYmUgbW9yZSBsaWtlIGEgdGhlb3JldGljYWwgaXNzdWUNCnRoYXQgSSBq
dXN0IHNhdyB3aGVuIHNjYW5uaW5nIHRoZSBjb2RlLiAgSWYgaXQgaXMgd29ydGggdG8gZG8gSSds
bCBzZW5kIG91dCBhDQpuZXcgb25lIHdpdGggSmFya2tvJ3MgcmV2aWV3ZWQtYnkgYW5kIENDIHN0
YWJsZSB0YWcuDQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
