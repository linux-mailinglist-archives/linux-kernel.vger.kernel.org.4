Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E82739019
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFUTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFUTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:32:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4A1726;
        Wed, 21 Jun 2023 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687375937; x=1718911937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aFgBbr976jg3ba16J+KLdCQrnUdUdNncmerb7vlUw1w=;
  b=EBLOidfTrNZdZt0ayeHIRNok/Ya7nPo+JmFstvlqoR3/PKsEByHRYQWp
   KZCkxNGh2ZcdcxOR7lIbixqAScVpVi9Zsc1M+pjSsZ3m6K8jqVdkg6Fwy
   QgLqUTeBns/v/Hhe1/wl6+1P8OU6lYHvMnWOPqShhsZMsGREQxgAt+MDi
   6epZNUBpuSKsk0reAUqB6ho67y9rRCGG7yZ6xOiG/qBgZ1x2DcFHfXt2c
   JmWRZZzV4qNVGwjyyfF1+Hqhpb6bUV3Rh0SAs9I24C6ykQJoF7nkmKfhT
   mwSncJnl80p7ZfNtpwuw17bh7h0BREb7QYikrFe8Zn/nSdn0VxB2piIci
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357779676"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357779676"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="838735261"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="838735261"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2023 12:32:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:32:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 12:32:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 12:32:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl0Mu0mAAJHISPJFtdpUKJQfB+ZbZ7WJhR6wKUH2tHhaz6tYqR50LiejvlMzPYojSUM1gDAwzTYQiILHXXBEFXsh7W3mWTtJ5m8WJkiT7HoUXfPgElQGrJ4l9K2vEqNAGa/eE+j5//kb3OGqW6sWhbUjoYYdxISHERCtwGNIPIEnLVxniWt9s5+kcG9s2ufwEge4GQGAN2jixcl+3mSXkVSSwCgwLjmMtU0B4aS5P2f+aXfo4juvRfr6xHal+zI+rSh9X/fCGrSi8qolSIeKQCtTX2XMaz0fF1Fwyl20RQ4T4kBHA6QBWfGptVVkHF6qwr5StRFnoS77NsdWPD66wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFgBbr976jg3ba16J+KLdCQrnUdUdNncmerb7vlUw1w=;
 b=GYiiaOdK2+hCegKHB9i+vW6uUhXC3FaoonvrjD69SNSFjj8YvgwHEm3L/jFDkL51O3upwr9+SqYYMvaG7K/SZ5TMpRv8efunc5ofh2/lFssrpQgIasR386rymwNtl3a8ipNEBFh7PREEOaJcKqEFsrypVHGr4O1UDbk0/K/7nupj48QnUkAdM3pueVVltkJy21zy6YJnnLin38vUSvFfFvyWHrNIWo1IXqKkqEuAyt9/TYOXkw9f/tVIWZQSEfg9tU77+EwGPNnWqQ3l2xEEbaovnCD0nx5o5NuGBmSTDSwKWhsnfd3ev8NZKvtKu9plwe9io2JyZmX05w+i5+YmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 19:32:12 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803%6]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:32:12 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
Thread-Topic: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
Thread-Index: AQHZn9TsOpWeJ/Ab30CMUWg0Vw9NZq+NDTIAgAihSAA=
Date:   Wed, 21 Jun 2023 19:32:12 +0000
Message-ID: <b61a9efdff30fbff9477369ded05d133e0de7335.camel@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
         <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
In-Reply-To: <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.3 (3.48.3-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH0PR11MB5160:EE_
x-ms-office365-filtering-correlation-id: e3738261-6204-4a43-57c9-08db728e360e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xE4rHnll64ABeaj0Z8eu9R3WYDPMMmH1h3L+5apViebna6P5Sb3V9Ekx/+MQUKSx9BK4PNlQpVyXyalBxMiSbsVnHMry2dCaJ2IJKdSx8f/aELsfj+/DDhxuCZqRCDTfaLfDUtHIpYlbkU/fqwyp6w30xCU7yy7Ve1f6AfHS8gBnuViWNqyfXahnee+vTK6B8bvw8I8bFjm7fe1+NQgMXbZxaBpHVVzS+P2E2xzIAuzRUuHEscy/0FxM6m9C4/90Vi/2f0s8AS3K2cYkydytpD5SYyp+iG1dQz5QoblBBnhMeQM+Le6Wt4vEAhjLFyUhTqUu8kybNZ2nOm/m5c0vBIPgRNoQLqosTi9nOEhe820umJ13wCv2Y5Ipj9de8R2VxjksVlOPsuZ2HPT+SjmSAbQIdxm7QNhB1ylIWbZfqkPmo4w0ZUbJBY8fHhmiYY3T0fKI1u1Q0mkDKYriYZsBVtk/HE8Mvw90bw/45p+XrvZsoqweuj34rna5BXmzm2VNHxWYkkgL2n5gCNVeu+lB4excm1+77JQbJGuZcc9XK+l6WADFDZqTmdi8g6+6jChR+wnVYOkKYmO7WV0na3op0KutEH7TYVQCi+aP3VS6tXA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(122000001)(38100700002)(82960400001)(53546011)(83380400001)(6506007)(186003)(2616005)(6486002)(26005)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(4326008)(38070700005)(71200400001)(36756003)(478600001)(76116006)(66446008)(66946007)(64756008)(66556008)(66476007)(54906003)(316002)(6512007)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak1OaUI0WkJXN05CYTdvR3FWQm1zZmtSem0rUkZ3UFJBeFN5YXl4bFdKNk9a?=
 =?utf-8?B?UEVmTlRqdFNEVTRMSjR4QmYzYTk4SGtnWlJJU0hUaUQxU0h2dXdvMk5QOHdq?=
 =?utf-8?B?N2NiR3FnRFYwdElBbEVHQ3Y3M05oWUFUdFRSRHNQeTBNSTE5OUpjdU05WG5F?=
 =?utf-8?B?aW5zZlBzVlNZam5CSDdlT1dhNkFpRkw0OUpjMG1EeFNQTk1lS08rNW13eFdk?=
 =?utf-8?B?QWVLYW5KUGFYbmRWVUVrQlNDaW9mdFFGWklDZ2o0d0Jjd2J5RE41ZEpLaTR4?=
 =?utf-8?B?NmpRZXo5RnUydlNyR3ViVVhqbzY0Z0pLSXY3T21VSFpaMkNXek81K3ZBMEZj?=
 =?utf-8?B?dWtlZWE5dEJyT0lXQkV2UjhEYXVTOTRPYmNUdjNYdXRxUnJSRlpZenFmbEJX?=
 =?utf-8?B?NWR1eG9ENFI5bXJCN0dCaWZycVkwNFZaRG5qVkw2b01mMTRNTktLODlFMlJt?=
 =?utf-8?B?dXo2QnFMTG9UMlQ5VE03TjAxKzBtNzhpSGoySUhzZitIR0hMZkhiSnJQSlJG?=
 =?utf-8?B?OW5ZQmhYeXB1VUhTbzJkWFVaenlzRWZNNDJyckgxYm1ldjFiTU4rN3RwODhz?=
 =?utf-8?B?bnVGRTRwZGpmekFrdTh0N3lkZEJmMVU3NjlIbnhVTFJmZEp5SXJYc1A2cWpa?=
 =?utf-8?B?dTRiZkJZZzhjL3duVFRkVXlMOWE2eUZuTWtwV1k2WE85ZWUxUjZOUlVobStt?=
 =?utf-8?B?M2duN25GK3UxeWkvSFdObWF3dGR2STZib09CN3FLRjNVRk5pQ0F5UGZSTDdC?=
 =?utf-8?B?bTRWZjliT1Q5b0pLcGE1bUpsZ3E5Qkk5UXY3RzgxSnR5L0ZoMDlRUHpldkxr?=
 =?utf-8?B?UFZ6TGlLdlQvVS8yWXJ0WE40L1RWdDhUZGNydWVzMDk5L0NtTEw5MGY3REJY?=
 =?utf-8?B?eW5YWEV6UGtJTmg4SGFkN0EzZk1lMTRmSEc4NjYyRkVjSnhzNTQyU2ZlbmVm?=
 =?utf-8?B?YUlhQnoyZndIZndweDZVSDNtdEZHSHZhVkZjOWZxcnBXejZSQjRZWm50VWhU?=
 =?utf-8?B?ZFErUC9GSWk2enNTNlRjdUFaRG9qcFNpUVYzZTBiQ3kyYXZNRHo5MzZwUDdu?=
 =?utf-8?B?WlBDSXdxNXhCSkYxSVUxYUM1amRVckJOVG05anNvU04xVjBuRnBWeGRKR25T?=
 =?utf-8?B?MnRoUHRGeXZTTTFkMzJlMitPWUpmME5LRmxMZXNXZjE3OVBMY0ZLK3Z0Yldz?=
 =?utf-8?B?NnNTbFdDNTNyZHVRc0tBMnJlcEtsblFSMjREeDdIakkwZ1VsbjZSV1VIdjRJ?=
 =?utf-8?B?MTZxNDdlRzVXRmtKNTlKU1lUejFnOTA2Rm9oUUlRS1kzZ2ljei8zbDgrNGhj?=
 =?utf-8?B?VXdybE1IT1NQSWJsTnN6Q1hlTVZKMVRSTms2SkpRR3dNYmFTcXZCMm9HSEpn?=
 =?utf-8?B?WnVYY1F3akJMSlRDcGVIZm03UGpOOHhEdUZNZ0JLTlF4L1J5WWVUcFlINUlv?=
 =?utf-8?B?Y2s0VGp1dnhvTFloeVRINU9vL0xjQ25XOGd1bFlWN2tRakxZUFVHcW42MGM2?=
 =?utf-8?B?Y2VVMXlQejNSZ1RmUnV0S0lrRm9mM1FBYWZNYVRKTUtNRGsrSEU1amw3Ty9k?=
 =?utf-8?B?SHNja0RER1ZRaFB0elJTVzVWVU1YWTc1VFlPM0lYSGZpOG5BU2czcjBoaklP?=
 =?utf-8?B?ZlljbEtpK0VJczZ3cnF2elhWK1d6MnlOaGkwUGVORDZZZjd2SEhTSnJyRTFh?=
 =?utf-8?B?UmlycTJTWm1vTHJMc25yTmNjd2FZYmdxZ3ZtRk91Vld0Z0puSlBWOTBNOTRH?=
 =?utf-8?B?NVk5NTdoOHlBT2s0c2JLTy92SHBnN1d0cXRlYlVxOUtSN0o1aEJUSFVtL25k?=
 =?utf-8?B?NWlnczlQNXVvbXF0cjU2RDhtQW9Jb2c0bjIvMDBYRnZYSWZHK3hldXJJQkN3?=
 =?utf-8?B?NTJKaWlrWDBvbmJNbG9hdTdjZVdSTXV0azVDYUJzS3cvVEF2RUhKSlpsTVVI?=
 =?utf-8?B?VzAzUW5TMTN6Uyt3QnVwQ0lLaU5QY0ZTNjVNVkNoc281dDFieTJFZll3ZXhQ?=
 =?utf-8?B?Mk5mNU4rWHc1NXUyZTl3V0xCak1uRk9zeTZOdVR1SnBKdXQ4dm1jVzlYczBU?=
 =?utf-8?B?dDlMeWNtZTZlTXBUMWNDdkRzTU9VMUR1VjJEaGlCVEFoMmVZQTg0TmI3NEdL?=
 =?utf-8?B?YW9pUENOS21WUUxXQ3hjemVIV2NzZmdkUVZid1ZXL3pDU3J2Ujg5MFZNWkdU?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BEB61AC2BA384CB2715C7912E7C192@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3738261-6204-4a43-57c9-08db728e360e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 19:32:12.0728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oHVcqcFgGQdO8uqQkDeLineP04oMIKcz1dsHQU9Ag44SC96yJe5nzKDzl+zd8r+aUtPCBiqxYMfGgWBzcMZWs3H3SZMdx+2HfIlqI5RWfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
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

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDA5OjQ0ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTYuMDYuMjMgMDA6MDAsIFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiBUaGUgZGF4
L2ttZW0gZHJpdmVyIGNhbiBwb3RlbnRpYWxseSBob3QtYWRkIGxhcmdlIGFtb3VudHMgb2YgbWVt
b3J5DQo+ID4gb3JpZ2luYXRpbmcgZnJvbSBDWEwgbWVtb3J5IGV4cGFuZGVycywgb3IgTlZESU1N
cywgb3Igb3RoZXIgJ2RldmljZQ0KPiA+IG1lbW9yaWVzJy4gVGhlcmUgaXMgYSBjaGFuY2UgdGhl
cmUgaXNuJ3QgZW5vdWdoIHJlZ3VsYXIgc3lzdGVtIG1lbW9yeQ0KPiA+IGF2YWlsYWJsZSB0byBm
aXQgeXRoZSBtZW1tYXAgZm9yIHRoaXMgbmV3IG1lbW9yeS4gSXQncyB0aGVyZWZvcmUNCj4gPiBk
ZXNpcmFibGUsIGlmIGFsbCBvdGhlciBjb25kaXRpb25zIGFyZSBtZXQsIGZvciB0aGUga21lbSBt
YW5hZ2VkIG1lbW9yeQ0KPiA+IHRvIHBsYWNlIGl0cyBtZW1tYXAgb24gdGhlIG5ld2x5IGFkZGVk
IG1lbW9yeSBpdHNlbGYuDQo+ID4gDQo+ID4gQXJyYW5nZSBmb3IgdGhpcyBieSBmaXJzdCBhbGxv
d2luZyBmb3IgYSBtb2R1bGUgcGFyYW1ldGVyIG92ZXJyaWRlIGZvcg0KPiA+IHRoZSBtaHBfc3Vw
cG9ydHNfbWVtbWFwX29uX21lbW9yeSgpIHRlc3QgdXNpbmcgYSBmbGFnLCBhZGp1c3RpbmcgdGhl
DQo+ID4gb25seSBvdGhlciBjYWxsZXIgb2YgdGhpcyBpbnRlcmZhY2UgaW4gZGlydmVycy9hY3Bp
L2FjcGlfbWVtb3J5aG90cGx1Zy5jLA0KPiA+IGV4cG9ydGluZyB0aGUgc3ltYm9sIHNvIGl0IGNh
biBiZSBjYWxsZWQgYnkga21lbS5jLCBhbmQgZmluYWxseSBjaGFuZ2luZw0KPiA+IHRoZSBrbWVt
IGRyaXZlciB0byBhZGRfbWVtb3J5KCkgaW4gY2h1bmtzIG9mIG1lbW9yeV9ibG9ja19zaXplX2J5
dGVzKCkuDQo+IA0KPiAxKSBXaHkgaXMgdGhlIG92ZXJyaWRlIGEgcmVxdWlyZW1lbnQgaGVyZT8g
SnVzdCBsZXQgdGhlIGFkbWluIGNvbmZpZ3VyZSANCj4gaXQgdGhlbiB0aGVuIGFkZCBjb25kaXRp
b25hbCBzdXBwb3J0IGZvciBrbWVtLg0KDQpDb25maWd1cmUgaXQgaW4gdGhlIGN1cnJlbnQgd2F5
IHVzaW5nIHRoZSBtb2R1bGUgcGFyYW1ldGVyIHRvDQptZW1vcnlfaG90cGx1Zz8gVGhlIHdob2xl
IG1vZHVsZSBwYXJhbSBjaGVjayBmZWVscyBhIGJpdCBhd2t3YXJkLA0KZXNwZWNpYWxseSBzaW5j
ZSBtZW1vcnlfaG90cGx1ZyBpcyBidWlsdGluLCB0aGUgb25seSB3YXkgdG8gc3VwcGx5IHRoZQ0K
cGFyYW0gaXMgb24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgYXMgb3Bwb3NlZCB0byBhIG1vZHBy
b2JlIGNvbmZpZy4NCg0KVGhlIGdvYWwgd2l0aCBleHRlbmRpbmcgbWhwX3N1cHBvcnRzX21lbW1h
cF9vbl9tZW1vcnkoKSB0byBjaGVjayBmb3INCnN1cHBvcnQgd2l0aCBvciB3aXRob3V0IGNvbnNp
ZGVyYXRpb24gZm9yIHRoZSBtb2R1bGUgcGFyYW0gaXMgdGhhdCBpdA0KbWFrZXMgaXQgYSBiaXQg
bW9yZSBmbGV4aWJsZSBmb3IgY2FsbGVycyBsaWtlIGttZW0uDQoNCj4gMikgSSByZWNhbGwgdGhh
dCB0aGVyZSBhcmUgY2FzZXMgd2hlcmUgd2UgZG9uJ3Qgd2FudCB0aGUgbWVtbWFwIHRvIGxhbmQg
DQo+IG9uIHNsb3cgbWVtb3J5ICh3aGljaCBvbmxpbmVfbW92YWJsZSB3b3VsZCBhY2hpZXZlKS4g
SnVzdCBpbWFnaW5lIHRoZQ0KPiBzbG93IFBNRU0gY2FzZS4gU28gdGhpcyBtaWdodCBuZWVkIGFu
b3RoZXIgY29uZmlndXJhdGlvbiBrbm9iIG9uIHRoZSANCj4ga21lbSBzaWRlLg0KPiANCj4gSSBy
ZWNhbGwgc29tZSBkaXNjdXNzaW9ucyBvbiBkb2luZyB0aGF0IGNodW5rIGhhbmRsaW5nIGludGVy
bmFsbHkgKHNvDQo+IGttZW0gY2FuIGp1c3QgcGVyZm9ybSBvbmUgYWRkX21lbW9yeSgpIGFuZCB3
ZSdkIHNwbGl0IHRoYXQgdXAgaW50ZXJuYWxseSkuDQo+IA0KQW5vdGhlciBjb25maWcga25vYiBp
c24ndCB1bnJlYXNvbmFibGUgLSB0aG91Z2ggdGhlIHRoaW5raW5nIGluIG1ha2luZw0KdGhpcyBi
ZWhhdmlvciB0aGUgbmV3IGRlZmF1bHQgcG9saWN5IHdhcyB0aGF0IHdpdGggQ1hMIGJhc2VkIG1l
bW9yeQ0KZXhwYW5kZXJzLCB0aGUgcGVyZm9ybWFuY2UgZGVsdGEgZnJvbSBtYWluIG1lbW9yeSB3
b3VsZG4ndCBiZSBhcyBiaWcgYXMNCnRoZSBwbWVtIC0gbWFpbiBtZW1vcnkgZGVsdGEuIFdpdGgg
cG1lbSBkZXZpY2VzIGJlaW5nIHBoYXNlZCBvdXQsIGl0J3MNCm5vdCBjbGVhciB3ZSdkIG5lZWQg
YSBrbm9iLCBhbmQgaXQgY2FuIGFsd2F5cyBiZSBhZGRlZCBpZiBpdCBlbmRzIHVwDQpiZWNvbWlu
ZyBuZWNlc3NhcnkuDQoNClRoZSBvdGhlciBjb21tZW50cyBhYm91dCBkb2luZyB0aGUgcGVyLW1l
bWJsb2NrIGxvb3AgaW50ZXJuYWxseSwgYW5kDQpmaXhpbmcgdXAgdGhlIHJlbW92YWwgcGF0aHMg
YWxsIHNvdW5kIGdvb2QsIGFuZCBJJ3ZlIHN0YXJ0ZWQgcmV3b3JraW5nDQp0aG9zZSAtIHRoYW5r
cyBmb3IgdGFraW5nIGEgbG9vayENCg==
