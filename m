Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8C6AF7BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCGVfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCGVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:35:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C05943F;
        Tue,  7 Mar 2023 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678224918; x=1709760918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4elv+gvVeWWcJ7WJmdjLRu86h5q421ZQa7kTQHBYc90=;
  b=RrHPkM2sayiNh+ZysrO/PWFpwd0ngPsUMaWVDSDXZgmWcMqK3p+9Ebiw
   dIaxrDt1dc2nzJZWsSP5YULM1ZC6RwZ5aB3a4nSOY2j9H2BWAiV4n0YKw
   1RqRsO3PKBxMLPbsb+1zbPHNBCddigle+jfhW5JV0h1mNBD6IW8zBk3rk
   EnYyJwD2x8trs4Ogm//uAOyuvstYkjPNnXw7oPiO9vofBRegUuykIYmuN
   S6SGeSAoY1oLa3vqIRS+ryncZSwjiba+POL04OS5G1aTeBwQlUuMQBXQy
   71bF/OlHfH+lRPLL1u8H1DsQ+IQc4v9e0FVVBaN5GWi4WCQbKOV5dkml3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334694814"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="334694814"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819924858"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="819924858"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 13:35:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 13:35:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 13:35:16 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 13:35:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2GZVuOICArmQ7Dce51XuNoEjbNO81uHpLAHUcTJxlr8ar8YNrpLcl23OU0WyT74y1a1ct0+ZwuwtQakmNsGZQyFZGihqNwVeOHT1xw8r/WN3ksafQazgHjNdfS02yGJyG4HL6D+72j7O3XrO62fOLcleNwjkKp21ZoPMEO4J/NSCbxDYBvtGOe93UUv72zkNppDHEfqrWwtWuwy9kj3aHZN/OPa/7zs+FxNiG4v4n8JeFvRP5DZNlDiEIHohrMCDD9Uu3b5thwdD48VPXofFO2niFI8QvAJuCicTMFsfQSKRe/NbNqNmv3/ULPJz7lLKB3VrLYksHuUO/txKFwxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4elv+gvVeWWcJ7WJmdjLRu86h5q421ZQa7kTQHBYc90=;
 b=gWLiqdNfIDmPGTC1hpXS4kf/GTsKi0It44OQLuDe92hkeLVC14sE05lltMR8maFmJj34GxTL88POOLCBFS0o9t+RlJWialpFcK9+SyTMNK4lak6I7/xbRj2JFE12USSh8Rh3aNk2sARvV7nddVLmvvtKm4SPkV3bsfI4KpRjSUu7DS6sAml7tjV1vEmxKV3aPEUbN92Hni5X+7ZhNe89hfyD8pM5UxpnTtTOyX4+aM1bdZE0Dz7IpG99Aaj2mTANc9sbJWE3FlI2Zf6QXuF9fFd395RItIs3yKkvtl2SEhO/Tk4gyxtouAAu836rV62aBy/mGQ45sHAdEDZzwWNAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 21:35:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6156.019; Tue, 7 Mar 2023
 21:35:13 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>
CC:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Topic: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Index: AQHZTiWcwVo9jaQOt0u1ztY/yRpe/a7tql4AgADNkgCAAL2tgIAAd3MAgAAhmACAAAL3gIAAA3SAgAAHhrA=
Date:   Tue, 7 Mar 2023 21:35:12 +0000
Message-ID: <SJ1PR11MB60835681E8FE389EC0A1825DFCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230303231133.1486085-1-eranian@google.com>
 <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com>
In-Reply-To: <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6568:EE_
x-ms-office365-filtering-correlation-id: d09f8fc5-1cf8-42d4-c0aa-08db1f53d59f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qy19Ch/wotzyQg6auaTpFwn6dO7ynv++lwUXMxZavE9jgNwUl9NkttwbRI/5PUKZbST7b+B3WDkVaapVdr+ML8wbmU3SYvWTlutx3eYWm7CZZjm52ynJNlUGUpvud3NOpNldbP31GlNnY46HqOG8VyeaVg/TmXd+0VXu78pJSj3XFvefNzFtHVAYB7HSMdUYLzWGHOvbGqqwpUo1gi86zkcx+4b5dfI55WzMY//vcU5l2C8jkNFWwRRum8Z1Wqw6wqOQNJB/mCv4wCTq9m45RdAAqyzDDe13wJUqEler60tpyHthTfNmGYbQu6XN7VHoRenLlNPP6T2thGT8tTBrH6+nBKnIwhf314msm/FSSwNLZuzPBvV7DbPfb+gnVE4jRjKyjFZvxjSgtOpilel2km1Qpu3CwGEr2dN8f9Vi2dbcwIzuRiumAS5llBw5r4QXi/teaVzzsakEls1V5aViNQP0jvmqQXMctHVw1cG3EGH8uvSqkLHFZgqeVeyHDbgK0pllNlc+kur9UsfkcVttmDmwjLJFhmP+LRuK+gIUV48cONl8YhroWefNSRiTcV4eAziGNJul0fUzBh7/0/QiCA8YdrO+r/GohyZgy54Ihc1U1gIZX6rVtoGKRYSPZSJrtY9AdT52rv3mMmAlIuFbemP2mF/0ylQrbCFSM9Dgv6Xpat5CUVNV3LDOMn+q7DAVfop8qiSey5Qu0PMgCSRJAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(52536014)(8936002)(7416002)(5660300002)(4744005)(41300700001)(66476007)(66446008)(66946007)(66556008)(76116006)(4326008)(64756008)(8676002)(2906002)(54906003)(110136005)(316002)(478600001)(71200400001)(7696005)(26005)(6506007)(186003)(55016003)(82960400001)(86362001)(33656002)(38070700005)(122000001)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnBzUkw2N3VCUzZ1SEtaNXVuakFpRVdlQ0dQVHFnK2xYRGN2SXp6UThmbmdl?=
 =?utf-8?B?Y3ZMc0JCNGpXczZrMUh2WWJWUnh6cVRieHA5M0VETVFtVTN6dzFKc0lwQXN1?=
 =?utf-8?B?WGlZcGVyVDkwMFFvalYxY0kvUFJLbzc3T3NpNWhtVERrWm4zZUlQUEZ2eGJN?=
 =?utf-8?B?cDhNdW04SUhsR3lEeW1tYzBROUtEd0QwTHppdFV1enlJYk9Rb2M4WTdJczh4?=
 =?utf-8?B?eENkbGlYMkxmcWJ0TXFYQUJqd3RjWXRtL29TclZtUHoyV3FlbmNxQk44VlMv?=
 =?utf-8?B?aVFEZVMrQVR4MTBubHd1RS9jUE1oTy9BeGYxczVtdmNKRmhKTXREZ1hybG9W?=
 =?utf-8?B?MnZVbEpQQ3VSRGlMQWVNeFRMVGJJYzlyU21OWnhiR0V1bXFYZEtDcmZpSEJC?=
 =?utf-8?B?VkVrby9IakdnRVVWcmRQOWovay9LVEdtY3VCVlBJN0c3Q0JnbkFmeWRSMlIy?=
 =?utf-8?B?dWJNZmtaYU9BR1J3ZnBvMkthWG9YNW9TbURuSXJidllFZzFjUlk5RGhKRTJP?=
 =?utf-8?B?ZlNKRnNCME1aZjBjZ1lCTnkyRmdpS1JQeU42OW4wNnJLLzFDaWliYmtHM2cv?=
 =?utf-8?B?TWJXR1V2a1VvWTNyMzMzS2JxU0U2d2VZWkpLUkpaOFRaK2RRaUxyRHh4TGMx?=
 =?utf-8?B?QVAzTUFPSFFCL3c0am9HaFdLMEhkMm0vdmZsL2JqckdKcXZTQlE0YkRSek45?=
 =?utf-8?B?OWVST0s4Lzl0eE55bDBPdCtsbmVZT2tRYkkxYXlrb3VUMUZOUXRxdi9hZlNR?=
 =?utf-8?B?bW0vMjBUS3B1Rld1MkhrZUxXZ01lTTY0SWpZdW11aVNDUFZkYTJEOThDb2hh?=
 =?utf-8?B?ZmdzdjUzbVpIR2x2dHVMWHc2NlZGbERBSzV1VWgzUkEwNy90ZHV1Y2t4Q1FP?=
 =?utf-8?B?NUNuZjJ1VzlWSWtBQnpXbGluSXhJcEdnQWV0dHk4Sk10YUt2akxWWEhWUmU4?=
 =?utf-8?B?eHBlZjUxWGdIamRLTnZraHRuWVlrRXpuc1pDTGhqZ2VleSt6eXFBU1hVak52?=
 =?utf-8?B?M0p1Mm9NOS9VZkxGVEFtVVRIWnRtMmhUSW84alVGS1JSRFpUMnlTQ2QxTzBo?=
 =?utf-8?B?ZUpXUmJNUzR2MzI0MjQvOVJ0WVVEZFpDc3JDRG9Nd1JGZTlpclB2cGtIdisz?=
 =?utf-8?B?QUdQR0gvWkVnNE5ITHRnbW9naTgwZW8zYUFMRWEydWZaM0JPOFBYV3RobG4z?=
 =?utf-8?B?S0s5V09QeUNTT1N2OU1sMnlFU1o2NXY3c0NFNUVyV0RyMHdROTE0RWcyN1RK?=
 =?utf-8?B?bCtzZXFmdXRxcFNEdzdCSWZ0WTIzQWJhY3NaaXZPNURiN1orZkN6M0x3QTlo?=
 =?utf-8?B?Q2kxYjcrUDZxKzF2aVAzUHZlS3VQMVZ5bitrYTZqUVdsQ1VCdHRJQ2dCTk95?=
 =?utf-8?B?ZmV6UUNwMWdPUDdONzY5NnNPV0luWWl5V0tDdDBRVHY4U2NlTXBPVFo2YWw1?=
 =?utf-8?B?aTlkZXQwMUVzbUxKclQ2WHg3eHBEYStxMHZTTUgxRng4TFZJeDlEMXVHdzB2?=
 =?utf-8?B?WjNnWlB1dFJLVkNselBSMHFlMkJHRlpmcjlBV2RKODBvWDhoMG1MYmU4UnVY?=
 =?utf-8?B?TjZjdjE0RWlSaDl2OVE3NkhsdHlzalVMa2ZCemF1Z05BbEEyT1ZrS2VsYzJo?=
 =?utf-8?B?TGM3ZjVUOUZSWG9FN1hqYmdyMWNKWTh4Zk1KTmo1Z1JROTVZSy91WDF6US96?=
 =?utf-8?B?bWtOTVZKWTBrcHZ6Z2Jtd1BNV1BuQmx3a1RsY1gxcDlPQ1JzdGhnL2E2bk9p?=
 =?utf-8?B?aW55c1JXQ3hxSGhUNnBCK2x4ZGxWZEFnS293REhhTlFJM3BDdnpIZzkvaXZo?=
 =?utf-8?B?NmZPamNralhJTkNNci9wQjRwWkdEMUk2UnhHY2pBUStheWxVS0pLb2RhQjZx?=
 =?utf-8?B?bVRCMTlUekMwQXdwdkFUdkp4ck5FZmlZU2dFOEY5alJFY2lDUXYwL3JqYS9h?=
 =?utf-8?B?QkdwSmY0YW9kejBlVUtFYjhsMzRBMk5jRldBa2gybEdGbVBaWVEwRXVoMkIr?=
 =?utf-8?B?QVIyT290RzNybHA2aDF4SmVrNEw0dHhJY3lZdmwrN0x5Nk5iYU1SRFEzYVhB?=
 =?utf-8?B?Y0dqamh1UzkwemliQVVVMVNtdHN2WkpjWHRnWVBMTGYzTzhrRXhEbzdCRW9n?=
 =?utf-8?Q?zLDVRwe0rZTXQdfDLQpc/rO7Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f8fc5-1cf8-42d4-c0aa-08db1f53d59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 21:35:12.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJvj/EuK7L4aWQ3BysoEUu4V30Tlo/N9seuzU8KuJs4xwdpQDdZHYg+gdpwIeCh9WlSOyjfg/FUrsP1EzKYY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPaywgc28gaGVyZSdzIGEgKnR0b2FsbHkqIHVudGVzdGVkIGFuZCBtaW5kbGVzcyBwYXRjaCB0
byBtYXliZSBmaXgNCj4gd2hhdCBJIGRpc2xpa2UgYWJvdXQgdGhhdCByZXNjdGwgY29kZS4NCj4N
Cj4gRG9lcyBpdCBmaXggdGhlIGNvZGUgZ2VuZXJhdGlvbiBpc3N1ZT8gSSBoYXZlIG5vIGlkZWEu
IEJ1dCB0aGlzIGlzDQo+IHdoYXQgSSB3b3VsZCBzdWdnZXN0IGlzIHRoZSByaWdodCBhbnN3ZXIs
IHdpdGhvdXQgYWN0dWFsbHkga25vd2luZyB0aGUNCj4gY29kZSBhbnkgYmV0dGVyLCBhbmQganVz
dCBnb2luZyBvbiBhIG1pbmRsZXNzIHJhbXBhZ2UuDQo+DQo+IEl0IHNlZW1zIHRvIGNvbXBpbGUg
Zm9yIG1lLCBmd2l3Lg0KDQpCZXlvbmQgY29tcGlsaW5nIGl0IGJvb3RzIGFuZCBwYXNzZXMgdGhl
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwgdGVzdCBzdWl0ZS4NCg0KVGVzdGVkLWJ5
OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQoNCi1Ub255DQo=
