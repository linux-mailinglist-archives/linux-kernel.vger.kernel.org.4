Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BA675F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjATVKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjATVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:10:19 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988C18B74F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674249017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tw5xmQasCzXfVSuTW5wmeo3RMLCjvQmE9LJ27lT+/0Q=;
  b=XdTh2wxOpuRfj/mxtfnIy/Fbj8P9kmh0zes5abD7pbjlKrKZjL9KyPgN
   fD3Hi4LtafR48WMfXQ9oQawC9Cb7jX1U9hWFhvOUhdlFQxBYEEBF60O42
   j1J/VR7Qqlka+L3jJiv0tqYsJ9v9R9rKYY4b6jD4Ggx+Vu1MCXwHo19UM
   M=;
X-IronPort-RemoteIP: 104.47.55.176
X-IronPort-MID: 93545486
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:LisfRa3UFDPu4QxhWfbD5WBwkn2cJEfYwER7XKvMYLTBsI5bpzJVn
 zRLCm+AbKuOYzSheoh1bITi9xwHupHcz9IyGgBopC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS93uDgNyo4GlD5gVkPagQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfHjtxr
 cZHDx4xVgmmmMWu6e25Rec1v5F2RCXrFNt3VnBI6xj8VKxja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvi6Kk1IZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXKgBd5PSO3mnhJsqHKp+HY8DEBPb1/48PX6jkngAsBdG
 XVBr0LCqoB3riRHVOLVXwWxiGyVohkGHdFXFoUS5AiTx+zU6gCCC24sTzhdZdhgv8gzLRQ61
 1nS2dfoLT1prLCRD3ma89+8sTy2KQARLGkfeTUDSwoVpdXuyKk2jxTASf55HaK1h8GzEjb1q
 xiAtAA3g7Qei55N26jT1UjKnz+2tLDISAAv7wnaV27j6Rl2DKapbpKlr1jS6+1NKq6dT1+cr
 D4FndST6KYFCpTlvDzdHs0OEauv6vLDNyfT6XZrHp8853Gu9mSlcIR4/j5zPgFqP9wCdDuvZ
 1Xc0T69/7dWNXquKKVxM4S4Dp1wybC6TIu7EPfJctBJf559Mhed+z1jblKR2Garl1UwlaY4O
 tGQdsPE4WsmNJmLBQGeH481uYLHDAhkrY8PbfgXFyia7Ic=
IronPort-HdrOrdr: A9a23:hutrNa4F6WpctnVELAPXwDLXdLJyesId70hD6qkQc3FomwKj9/
 xG/c5rsSMc7Qx6ZJhOo7+90cW7L080lqQFhLX5X43SPzUO0VHARO1fBOPZqAEIcBeOlNK1u5
 0AT0B/YueAcGSTj6zBkXWF+wBL+qj5zEiq792usUuEVWtRGsZdB58SMHfhLqVxLjM2Y6YRJd
 6nyedsgSGvQngTZtTTPAh+YwCSz+e77a4PeHQ9dmYa1DU=
X-IronPort-AV: E=Sophos;i="5.97,233,1669093200"; 
   d="scan'208";a="93545486"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2023 16:10:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/dtPaxtE/+gb3AN6PngArd4gvJy+4JAOiKiJD0NqCoVrg1HioMxk5qBDf5o1y0V0iaTl2hcGVctTSyvkQq9KQysFPMQmHdqrzyHTUddnnmJy7kG8NvhE2PmkPXDVE6JAaaru9Ji73IcEtGLFMKEZ/tkR6o2C1fIB7oJlHVt/zKq2vXAXmuCW5I0L7GxxFWWsGyg5agbAL01IlJ+MNQQH2lNXtOTzWnWHUAuTQCdpNG2PrgnBBwyoYZRrjqhiRof3dX8I6uL4tFWhn31c2j9uQJOLe3URhkn0NsGmMhc78KcYwSksRgWm9b1EwTEEHOtp3XYRAodeWUj4SdMHvQq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw5xmQasCzXfVSuTW5wmeo3RMLCjvQmE9LJ27lT+/0Q=;
 b=BGPf6gyTFwpqX7j0+OwkJyzuCaL5mmvgsdbosxUBOCeOKOcvO52xkWoAeP/Mr9+w6l8vRjB5BvMYY40jNziMxpZKpbR5xLe5MZV3e0bPeXCmm9VbbbWqO5v0IyRKO34wuYveCMOil8+r0MQNHwVOwCB9GN1GcnkwL0mHv/9T+AdrVrmvWi0ELiPugEYMAVVn9A8BbZp3SPdi5ZkT9Y2fsCisCBJKppXdypJ7MUnHa7Opav3NTPIhlA2UbfOCBEA56XDh7QLH6twvzx0CI0nnhNefw0zCcplWTUS5Xc19l7dz3AHio4Nzl84dgbCHJYPCp5HzFpFfXwKvMlfxK66hZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw5xmQasCzXfVSuTW5wmeo3RMLCjvQmE9LJ27lT+/0Q=;
 b=k1ulLuVJtNkwOqmWOUbk++ajvksWBwpC9olVbntEp1WTa06WkSqP0qsR/n11EhKwsnZvJDiS/90eR56R/XzXMu3rL1XJtrRsF9Dho/JnSyQZV1WOAnwbQ1ph07MjQEl1eZ/gTlPQcHUZPNPzA0YxtxRmKYibwRgW5DrEK4fzB6E=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MN2PR03MB5343.namprd03.prod.outlook.com (2603:10b6:208:1e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 21:10:09 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 21:10:09 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Topic: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Index: AQHZLQBIyVP56rEBrUalKcRbIW7nK66nx8KAgAAFYwA=
Date:   Fri, 20 Jan 2023 21:10:09 +0000
Message-ID: <bf1ef4eb-4cc1-c862-287f-25e9144e1291@citrix.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <eb81f7f2-d266-d999-b41a-e6eae086e731@citrix.com>
 <A87231FB-5B5D-46B7-9888-5770039B7EA1@zytor.com>
In-Reply-To: <A87231FB-5B5D-46B7-9888-5770039B7EA1@zytor.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MN2PR03MB5343:EE_
x-ms-office365-filtering-correlation-id: 819e07ce-7457-403d-eaea-08dafb2ab64a
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqB1aRmiPhi92LOL1P754I1oURBRMqzBTVG7FLNH+YmnAfCOjIVq7gIMKJJn98gITGJ+9VqReoGj2PQMVt+5jrw3Dk+Swld8G7yXOUCPkkZRkky1a0sMMGP99BvrhQZfdq7C9cb6mI3B3hzIPioh8z6GxyMgA2i1YHJy78QwQ4xs+8K/rgPCGVo15A8W6OZ+IDmLv9nHHzoVBW8etEKbQvKVnGAX26MD8oc9wy56pgsRk/CDxfYVi2B+pSmE/K6vxqUXzWKIw1V0ptl/6rP19u1R1ryIkyL9c9RRFpkHYUc0ls7PXTfFoFLxsXN7hCNgnlLIss/8TkAaw4cJuMpnhv+hE2dJYZaI/DD4ze1TGZ+ZT5+OgztC/G3b9WxwAaHCBEYBJDrGrK44h5Qv64jahAqBlMq1msbhOlm2eoOS9RhyiuWyAU72D4Yzl/maOQOLaQLFqDeJpYNF4uONyc3PHn6EcgF4rr5GC1xFHkKC+UxQZqPTBMwo+3xGaqlw86UwjFOAPGFRggPBIhmiHHilbBzJ2gX0eqcw9ifH3S8Er1Y8x+usYZjJ5SDnSDsVPth0zwiCTicrSN5mG2572tf8AhIs5qXp20dALCfxVGV+JxTt+UGKt7hXzGmPWgDO3vBth433icdtCCKG0ptZJKbGGH+WrmuHuw/7YIj3Dft0AcNPFPLsJuc/904C+52Fzo7lHCOY7dCC+sYFXGPakuCpZL2h8qC0RcaD7z7itXA2mv4IwywtB9YFIGAFomuyEIUoPoks6j8chplXcv7OD+Qirmema7NsmWs0DeLTkXo4MDA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(5660300002)(31686004)(8936002)(4326008)(7416002)(66476007)(66556008)(66446008)(8676002)(66946007)(64756008)(91956017)(76116006)(71200400001)(36756003)(31696002)(53546011)(122000001)(38100700002)(6506007)(186003)(2906002)(26005)(6512007)(110136005)(54906003)(6486002)(478600001)(2616005)(316002)(41300700001)(38070700005)(921005)(86362001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWxJVUxMV2dTVEFTdXJNT1h4NG9nSVpLZjcvK2R3QVZpNGpZR3NWVmowQ3Fr?=
 =?utf-8?B?VFkzZm80VUErNVhteHVJQ1crV1lseDhVenZIME95OGZsT0VDenpNbXpudGVa?=
 =?utf-8?B?aEEyYTYrTzNOSUYxQTM1aEp0UWZoSHM2bmxCM1NDcDZQcWhCWi94dEppQzQ0?=
 =?utf-8?B?UEQwdHoxYm9aOUdzODBESVRScDNHOEZVcG5HZUcvUTNCRU1pdlBjVGhqamNC?=
 =?utf-8?B?d1Z5UGlJUFJIZDhJa2RpRTBRd1BjKzlDcUZhYjZzWnZ4SlJrZWZnVnRHQ3cw?=
 =?utf-8?B?RnJScFlkcm1ieUE3OVBtUFRUY21qb3ViaklEM2Rwb213MWRtdUR5QnJJUkl5?=
 =?utf-8?B?THlRaTd4YXI2OFZRTTMyQ25SeUJRc0d3Q3ppalZqY3dBSW96VGxWWEIxbXpt?=
 =?utf-8?B?dzhXa3ArdkdDdlMrT0J3L1BSZXhOclFHNnVBSFVYRkIzSERkZEp3OWJmbkwx?=
 =?utf-8?B?eFpoNVl3RG16S2JHSDlsdmoyeVRCYnUrbzY1TUxMclhRQ2xCMlNwdHBuTmFP?=
 =?utf-8?B?VVJUODFHRG5qRXhPTUZTZkpmSGNGekRjT3lncmcrRGF4WlpFeXJYZW1MdTVP?=
 =?utf-8?B?TnZpUUdQRjhSaXVWMHdST1MyU0N3Zlk3bHNUU1J0dE81d1ZGTFF2OHhCOHlt?=
 =?utf-8?B?L1FseCtiemFTWVFCUkRCZVlaNDRxTXFpbjkrbE9qQUZhYnJWUmtsM3puYXQ5?=
 =?utf-8?B?bVI1QjdDNGNNbWFWV3MrSXZMaERveGY1Z0gvNFZCWGIrUExyMlBCelB0akpD?=
 =?utf-8?B?RDYzR3FVV3pHbTBsaDh1ajR5cXIwUktlWVdFUkw4Tkx5b2hBYk5pVmRERGlt?=
 =?utf-8?B?Yzk1SGd4cFV5elcyRWhGK3FFazhtcVV3bU5OeFpPQXZ2d2xiVjJRWTJMcGVZ?=
 =?utf-8?B?MFJ6Vzd2NG92M2srOEZTRy9HR0c4UUVCOVF4TEttRjFLY2hadnRFa25RQjlG?=
 =?utf-8?B?L1h2UW5kSFlBa3MxOVozUFBLZ0lVS05FZzYrZjNlUkFySTgxQ0M1c0dndjl2?=
 =?utf-8?B?OWZnRHlBRWNMWmxnckg5elZ1dE94aUlNc3EzNnJvbEZycnpLOXBzai9nOGp3?=
 =?utf-8?B?SnU1VDlVNCtqNjk3ejlCWG1EamV6bjU2RHozZm9ESTB5MVJEUklVV2Z0eHYw?=
 =?utf-8?B?emZKMDdDYjlQY1VZZ1BCaC9kOFpYdTNmbzZxbWtLSW5sLzlBcmpkbENsOVNP?=
 =?utf-8?B?SmNjU2lIcEh0SFZZc2tQNWRhelVsUVZibTVIaWhUTkdMRVE2elhqVEVCVzRy?=
 =?utf-8?B?OWJsb2YwZEE1YlFKdWpLNnVmL1JDYmEwQWo2WWxJOTVjbHFJYWJpQTlXTUFJ?=
 =?utf-8?B?eG10cytScEF2TnFnNTh1TTFOc3pUNStPbkFYbnFLOEUrRzZ2UGZSWUJzaHJC?=
 =?utf-8?B?Q0FxK08zdWI2dzk2ZEVjdEVGbS8wUUtHV0N2RjNFRGJJNDg3YkwyOVBBTW5w?=
 =?utf-8?B?S1VKQWNaTHlXNUl5YVZ3YlBOZDIxNmhuQmwySzQ4WEFpWkZja0NrTWVxQTJ2?=
 =?utf-8?B?Y2tsZGRVZkNXZyt5aEpOc2FlZnl3SUNJUTBKQXlwaytjNUpLVXM4eG1oTnNn?=
 =?utf-8?B?ci92amRsdEZvOWJYSjVOZFRlVE9LeE5UTVFVNk9iYWdNOENMY2FPeUpzMDVq?=
 =?utf-8?B?K2NuZHo2ZzVCY1Yvc1NFcGpvZEVmbnMrQXo1b2NWYU9nbW04REV4YVRzczVm?=
 =?utf-8?B?Q2QzT2t0QnFmZVZ6eEU2MmhXQVFXQzhOV3VrVzhFK3lTNENHOXE1QTVhU3lJ?=
 =?utf-8?B?SFY1MlIzbDBGd0JMeU9pT0tITUJIeGo2SUNTUzdrdUxxQk5qUE5tbjl2dmQ1?=
 =?utf-8?B?dURBY0xRaUJuQlRlQ1pXM2QxanhLOUJLaHlkTVcvdWRkMzNCc1BNL2NtMFhE?=
 =?utf-8?B?ai9DV2xuVFZ0REVGSFpsRXhGdHdEWjA2emRCMno1YmREVWxyRmxEdi9MQndO?=
 =?utf-8?B?NTNqZHEyb0VNK0xwYkNLYzF2Z3dKekxEM3d4cWZ0T055c2V2M0txMnpWVjVm?=
 =?utf-8?B?NTROMHdXWDBKcGpoYjRGM25pMm1QclRqbGYrWUViMzdjNENZaDNVeU40NGR0?=
 =?utf-8?B?cjhKNk9iQXh4YU5Nd0QvdDhabTlScHd1RXZtY0JMQkpkaUFhdnQ5OWRIM3c3?=
 =?utf-8?B?dmRPaXBlM1V2K1B5QldwYTRvQnh0MVRDb3dzV2hybm1UZGxhRDJEemlGZDJ3?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E09E7C39AD4D4845B583BCBCCD14413F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2ZLdEhKclcyNGtZUlRTdkF1bURWVHJ0UzhMek1xNFJPYm1YSi9Bd0Nxa29K?=
 =?utf-8?B?T0dEYldNaHN0ZVRtS2tEblFxbW0wN2l4VnNVc0h5bUFrTEcrQVJhM2w0TTM2?=
 =?utf-8?B?bWtBa1ZMUEtlRStHYmhOVTlOY2o0U3dYU1hiNkVhdnd0MDhOS0NzTk12Qm13?=
 =?utf-8?B?SkVQQW5rd3E1NlNTbE1zT3NNdlFvNWNJUVFBN0JKL1RFdXpiSjNoSm4xNjI1?=
 =?utf-8?B?TlVTOE1OaytCaWlxdGVUWUFrVVR6Tk01czFkbnBCQURYTi9TcDM1c1F3Uity?=
 =?utf-8?B?dXA1RlVud1o1L0E2REgrd081dlhYUk1tVGVwYURJU3JRUm9weDI1TVJXREtD?=
 =?utf-8?B?c3BvbmI4YUtEWTdpZU94a0ZSMkx2NlVvUUVwR1FuV01pZllLZnlHTDZKRWU5?=
 =?utf-8?B?bVhPektNdWhnUGk0UXFFZlVZTWVTTGE3ckowcUt1eE9GWlJXM24zS2ViZ2Fo?=
 =?utf-8?B?b3hzK0pJaEljSm8rUW1PZVZ4aEhYeDZxc2tsVlIxWkIzRHJzckYzVzRMQ05h?=
 =?utf-8?B?eWRRbi9PSU1FWDZuRnV0cE51VXNvRGN4d1crSnlTZDUwNmxiZHNza1QvajF5?=
 =?utf-8?B?K1hHUVp0SHIxS0R1YjRMcWhwcUlKbldUeCtkNEtUYlNQdTJ1WHAwdzc0SGJB?=
 =?utf-8?B?TDRpQmZTTGdSMlp2Qm9nU1lGVTJnejJEek9lRmgybldubWtGY1NNVXQ3d3RG?=
 =?utf-8?B?K2NReEt6bW4ydzdEeWQ2YzUvendiOTNTTU5EejYvOXlIOVVtSjgzSFVVZFdx?=
 =?utf-8?B?ZkNDOTB5czVjYjVzd2NXMG9WbVFhQnd1ZTMrVElybUs1NXNXRVkrRE9XNnp4?=
 =?utf-8?B?bTZrOUFPTkxyNmZGWUtCM24raGM2Wk9iNGNYcGJBbkhJRTBlNTVYanFHL2R2?=
 =?utf-8?B?U1RxSWJkV3RzTnQ4U1FmTkxqVFRpQ3hudThoZzY0MnYyeEp0OG5QM1QveVB4?=
 =?utf-8?B?Vy8yRGNhNkhZNjFaNVU3bGdtN2Q2NzR2V1VDMm9pQzJXVlpiaHBOOE5IeTcw?=
 =?utf-8?B?OGtZSnhIeXczaVJKdzNHQWh3RHh3L25oaDRDQ0NqWm0yUnp2KzlzV2JNeFBB?=
 =?utf-8?B?NVJlTzRrc3AwaFFhbS9iYVpWOGM0K1EzZVdCdEdQU0t6eHdVR0dwRUJlZlNI?=
 =?utf-8?B?anNTcXRvSXExM3ppS2YxTjJXWHd4WW1PV3ZReU9FMjkwTStuaElkOUNPbjJD?=
 =?utf-8?B?MS93YnBaNUhIME16NE1xU2xSVkZQLzdzRndVMFpDd3EyYXFkR05GUmM5M3JE?=
 =?utf-8?B?SkdITkthTXJLdUpPdGdwVkFVQmFBcU5oZmNyUVE5ZStGMGlvc1F4VGhhL1FB?=
 =?utf-8?B?QThIbTBjYTQxOUZ2NzFieHB1UXMzcVdkUE5zUFJ4bTJ6aDNscFZYQWpZVlJk?=
 =?utf-8?B?bEhWM3o1QVRtK3c9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819e07ce-7457-403d-eaea-08dafb2ab64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 21:10:09.1439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqF1h1oksCzof4NlbUNRvQBXRefh9vTpivfQ5/1SjvoCRgA+KkTRqiEbr1iTLJBfFfgBJmGn7QZ+xyAPH7DPsOUrikA0vWX5p+pjHpVCpd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5343
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDEvMjAyMyA4OjUwIHBtLCBILiBQZXRlciBBbnZpbiB3cm90ZToNCj4gT24gSmFudWFy
eSAyMCwgMjAyMyAxMDo1MjowMiBBTSBQU1QsIEFuZHJldyBDb29wZXIgPEFuZHJldy5Db29wZXIz
QGNpdHJpeC5jb20+IHdyb3RlOg0KPj4gT24gMjAvMDEvMjAyMyA1OjQ1IHBtLCBEYXZlIEhhbnNl
biB3cm90ZToNCj4+PiBPbiAxLzE5LzIzIDIzOjQ5LCBMaSwgWGluMyB3cm90ZToNCj4+Pj4gVGhl
IHg4NiBzeXNyZXRfcmlwIHRlc3QgaGFzIHRoZSBmb2xsb3dpbmcgYXNzZXJ0aW9uOg0KPj4+Pg0K
Pj4+PiAgICAgICAgIC8qIFIxMSBhbmQgRUZMQUdTIHNob3VsZCBhbHJlYWR5IG1hdGNoLiAqLw0K
Pj4+PiAgICAgICAgIGFzc2VydChjdHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19FRkxdID09DQo+
Pj4+ICAgICAgICAgICAgICAgIGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1IxMV0pOw0KPj4+
Pg0KPj4+PiBUaGlzIGlzIGJlaW5nIHRlc3RlZCB0byBhdm9pZCBrZXJuZWwgc3RhdGUgbGVhayBk
dWUgdG8gc3lzcmV0IHZzIGlyZXQsDQo+Pj4+IGJ1dCB0aGF0IG9uIEZSRUQgcjExIGlzICphbHdh
eXMqIHByZXNlcnZlZCwgYW5kIHRoZSB0ZXN0IGp1c3QgZmFpbHMuDQo+Pj4gTGV0J3MgZmlndXJl
IG91dCB0aGUgcmVhc29uIHRoYXQgRlJFRCBhY3RzIGRpZmZlcmVudGx5LCBmaXJzdC4gIFJpZ2h0
DQo+Pj4gbm93LCB0aGUgU0RNIHNheXM6DQo+Pj4NCj4+PiAJU1lTQ0FMTCBhbHNvIHNhdmVzIFJG
TEFHUyBpbnRvIFIxMQ0KPj4+DQo+Pj4gc28gdGhhdCBiZWhhdmlvciBvZiBTWVNDQUxMIF9sb29r
c18gYXJjaGl0ZWN0dXJhbCB0byBtZS4gIFdhcyB0aGlzDQo+Pj4gY2hhbmdlIGluIFNZU0NBTEwg
YmVoYXZpb3Igd2l0aCBGUkVEIGludGVudGlvbmFsPw0KPj4gRlJFRCAzLjAgU2VjdGlvbiA3LjQg
c2F5cyB0aGUgb25seSBjaGFuZ2VzIGZvciB0aGUgU1lTQ0FMTCBhbmQgU1lTRU5URVINCj4+IGlu
c3RydWN0aW9ucyBhcmUgdGhlIGVuYWJsZW1lbnQgY29uZGl0aW9ucy7CoCBOb3doZXJlIGVsc2Ug
aXMgdGhlcmUNCj4+IG1lbnRpb24gb2YgYSBGUkVEIE9TIG5lZWRpbmcgdG8gZW11bGF0ZSBsZWdh
Y3kgc3lzY2FsbCBiZWhhdmlvdXIgYnkNCj4+IGFkanVzdGluZyAlcjExLyVyY3gNCj4+DQo+PiBI
b3dldmVyLCBFUkVUVSBkb2VzIGhhbmRsZSBmbGFncyBkaWZmZXJlbnQgdG8gU1lTUkVUIChpbiBw
YXJ0aWN1bGFyLCBJDQo+PiB0aGluayB5b3UgY2FuIGVzdGFibGlzaCBURiBvbiB0aGUgaW5zdHJ1
Y3Rpb24gYm91bmRhcnkgYWZ0ZXIgU1lTQ0FMTA0KPj4gbm93KS7CoCBXaGF0IGFyZSB0aGUgcmF3
IHZhbHVlcyBvZiBSRUdfRUZMIGFuZCBSRUdfUjExID8NCj4+DQo+PiB+QW5kcmV3DQo+Pg0KPiBK
dXN0IHRvIGF2b2lkIGFueSBjb25mdXNpb246DQo+DQo+IFN5c2NhbGwgYW5kIHN5c2VudGVyIGlu
IGEgRlJFRCBzeXN0ZW0gYXJlIHRyZWF0ZWQgZXF1aXZhbGVudGx5IHRvIHNvZnR3YXJlIGludGVy
cnVwdHMsIGUuZy4gSU5UIDB4ODAuIFRoZXkgZG8gbm90IG1vZGlmeSBhbnkgcmVnaXN0ZXJzLg0K
DQpJbiB3aGljaCBjYXNlIGNhbiBJbnRlbCBwbGVhc2UgcHVibGlzaCBhIHY0IHNwZWMgd2hpY2gg
YWN0dWFsbHkgc2F5cyB0aGlzPw0KDQpJIGNhbid0IHNlZSBhbnl0aGluZyBpbiB0aGUgdjMgc3Bl
YyB3aGljaCBtZW50aW9ucyBhIGNoYW5nZSBpbiByZWdpc3Rlcg0KYmVoYXZpb3VyIGZvciBTWVND
QUxMLg0KDQp+QW5kcmV3DQo=
