Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042BE6AB82E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCFIZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCFIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:24:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3993E4;
        Mon,  6 Mar 2023 00:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678091095; x=1709627095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZhJdKNNmd5cW07xowwKYORD+kEzn0T20Ma/CP1nj1S8=;
  b=AZwZhr4V0BnnoqukEplY9Sri08Jzy18j69mO6T6ebTnGLFkG7JD/TDUO
   Z4C/tqwUlDEMdvMHtSXg0y7S2+JEb5SDH1kT6cuSziSHryFAMwcUYiBHj
   wISeJNnCBbUvMWUbzu5xpxnDi+5NohCLuSzGHFjS+lTLAnJ2y7FUgK6xk
   r1AegKPLZHbjBQOeNMYJsH6BuZPj7+9l0h03pdnGhgHSsP8X0MrykV4G2
   LdiHnjy1wctOqweIMf6UGhOLw6VDNCKMXDDPSWNnSqkVmXWfM+Xlse62r
   bNBkaejXAbr4WtTAeOpfVCbbLMUqEFqwzwED+B3b269PA/UCFS2HoNvuv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337015566"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337015566"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 00:24:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="669357035"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="669357035"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 00:24:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 00:24:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 00:24:54 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 00:24:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CklH25QvyhmSsZ9lrWlFFojoj4Cv0X54Rl4Ho6f1h5Mz1PH1XClGZw95VUmDsizDvw848kICoBJPVEoegBAMAACb2tFzv/YliemvfUMQl3/dnTbKBKuxkMMxIoDKMpmwmwypzgoDhCPAqD470DejmY6fJoHqWTvXWIb/qGB9UKZOCVTmf77Uc2b3yirqdX9kBvVTvK0kuGihcseqpVBh2MKFKmcIjGLtEQ9zp2vKMRgsGqGMd6nQETfg2tBHjimZBPXFV2NkFo78ourp2lsQI1EdJ/EH1U71KliHTy2JJoCr5k06nnQWMQBANqkt45Fcz4+p+GuNnCPGjahPhrMZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhJdKNNmd5cW07xowwKYORD+kEzn0T20Ma/CP1nj1S8=;
 b=jC9tbc1NXsflVMZ/6J1EyIkFfzYUGscHcE0gmghQuWMQ3Eqfwv5q4AH0YmYsYBJ9MUEC6g9Tb+27shnLpnpxSEVYGIcq+Ds0tDU7wuX91OnhhqMVN/rCqNEVGHR5GgIoJJpsJ6U37mN4a7yDNANEsbf2ozcQqFUNLvkwLLMikduVfZu0LY48CpMqfV7PK1iLiNmh4UWJiSEpYCM+2vZRsLgZ9tgxsWyBaSJpPgApKFJC0S/eOjgcrdLnDP8UgSTguypihWYIogDgJNOBRbMV2QUXSCHs4u1wXG+CQGIBtotKQ2tfXmWrsliZAoNvGoGev4WUhLiE6q+0R2C97Wh9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 08:24:51 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%8]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 08:24:44 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: RE: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Topic: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Index: AQHZThiYp3MlrzfqvEWnd0vYLxlOHa7pzeSAgAOQlXA=
Date:   Mon, 6 Mar 2023 08:24:44 +0000
Message-ID: <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: joel@joelfernandes.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SN7PR11MB6773:EE_
x-ms-office365-filtering-correlation-id: 7ce209c0-180b-46e4-0c96-08db1e1c3dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNA/Z6l165txyi+mOflpsZSIdRb9xSd1/Suiaah2HzZEmOvznnt2/dCZeBIvVwKPe36czXZYDTN/SRI4Unqpt1JwGLPO+vapgCu7Wd5KZ8+46ssZvNSQDeH+mgud+7QvgEIWfp/4iMx8m7l/TCsQ/nleEKv0pftaHGW5H+XIYdvRKgLRXNVncOHl22Zd7wUuuvJ5rbGEQa6T387t+24s8TWS5/lQxbkOAwfmTFJmUGQmvzXWtXGS5WzZtlcVprvDBOhvQVTJwGkRABQsYrEOCgwvsnCbnDHtteUDsz+kBXnDNSJhx+mKeRmV1JBjSFySkOk+XjVgihr7FRcOKNRSgKF9/KreLZlEV+3GRSYKFlaHNrVNEzLy5IAub3YIrk1pkMyERLOY69YJjdggq0PiexIfWJRZgUFPRM8cPXQFs+KBNhFfR3FiLko9hJdsRcCMe5OpxVdWS5n+YRgwcGtfgXTF1cokmuFnb00+ARMdI0dvXXq9Uzvq832O9Il1ctArzxs4seFeG8o2Z9C9ijVdwz8UYuxxAVy2Sds1enlXuzScbVFDVvoiQfVei5tjE8NR9nC6yDcGCUSsDvfNyiAoFhBTxDL6MP5Jsg0REpqvGLcww8U/kYvZzhFSLiPsHypfJQNxUURXfwPP2MbtsFhNnqM4qCFjszUBxwQWcTL6QfISrz8JcOwZYr3wmveMljztZ2LI0xriMec8UWwKsAsRAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(110136005)(54906003)(316002)(83380400001)(55016003)(33656002)(86362001)(9686003)(186003)(2906002)(76116006)(5660300002)(66556008)(66446008)(8936002)(8676002)(66946007)(41300700001)(66476007)(4326008)(478600001)(26005)(6506007)(64756008)(71200400001)(82960400001)(7696005)(122000001)(52536014)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OExRV01yTWx2aTZFdmF1SitNNDh0RWpMMGtWeGVuTEh3blUwaTNIYjhIY1Rr?=
 =?utf-8?B?OE1KRFNJU25MOXRoQmkzU2QxSjR6aVNGTEVPUTM2Ti84Q2tlYU9LQ04wOVdy?=
 =?utf-8?B?SUNlOHQ3ZEtmMWRSejMxQXpkSFlUTVNsQ2xCYW9UaFVkL2E1QVQ2TU9tV3Jk?=
 =?utf-8?B?ZnBmRzY2R00xbHUxcWxIYnZDVmR1eG53akxxY3Y2OEJNK1NMYnBIMUF0R1A0?=
 =?utf-8?B?V0psc0RKTFdsUU16ZkJOdzYva1B1RHRFampiQ0tSNUFkeEJkMUFicSs0YThw?=
 =?utf-8?B?aW9WOWZ2cTJaR0hVTkVkekZtUzVqZW03WCtqQnNoTHo3NzIxa1hLL00zQm8v?=
 =?utf-8?B?bVl6MkxVY3RIT200aG9BZkFwZmh1R0M1OXhqRDBzN3ROMlIyR282NGtZY3dD?=
 =?utf-8?B?R2FTT1V6QmpCcSs2Y1djdHJsZFZGYjdiU2FrNktFMEFCL3VjMXRuTmFZemxp?=
 =?utf-8?B?UnFDUWZXdTYwU1pYSkZmdTNXRitwTmM3Z1JtZnNDYW04T0pBRkoybW8wVnNt?=
 =?utf-8?B?RUhaZW9vamJnZllTdkpDT3dNRFBZRHRwbklJb3BZeUF5NUZwMnVFTnV6amgx?=
 =?utf-8?B?MzlZc25WLyszVTNpZUFxT0xaZlc3U2dsWENkb2hrYzhJUnBMcVlkSkw2ZThI?=
 =?utf-8?B?Ty91ajBVUTZWUENDcVR0M1RoN3EvaXBKR2d2ZXh1THkvRjRNQ0VTN0RBTGNo?=
 =?utf-8?B?R2gzUmp6VnFkd011SEsvVmFKTjZrRzlTSG85RDFRRk1DTmxzakZqaUhiSlkz?=
 =?utf-8?B?d2ZUNCtUa1A1WWR3V0doVy91eEoxaDlqb1RWUk9LV0tpNmg2SkxTTC9WL1NW?=
 =?utf-8?B?ZEpvQURmblhEUzVJam15dHI1a29pbzJ5cUx1eElwam5HTUxIRDNyczRqTXZJ?=
 =?utf-8?B?YjBCdW5WS1RMZUlFdmFvNHF2cG9aS2NMYXI3bk5RVUl4bWtFQkJ4eUd5MnJU?=
 =?utf-8?B?TjNjQUNzbExSZ2lVR2dEVnV2Q0NHd01ETHU2SzdWZVJ4TVdNejZodnNicmQ2?=
 =?utf-8?B?cDA2clJ6aGhadE9Kb0F3NWlld1BJS2FoTXZHVGJIdXBCZlFRL2NQRGhwUUlv?=
 =?utf-8?B?eWo4dkZOVzR2RGlEN1BIaWVmeHhSbFdZcFQ5ZVVlNXJQTTV4R1VRSEhsb2Vu?=
 =?utf-8?B?UDB1Zm9PNFhvalVLREJaRTZwanF3eWFWQlRTVU95WVNvSUxvWnRmc2FrdGM5?=
 =?utf-8?B?N3FLUHR5ZHBUVzdEenVNSFdvWXFtZldyM3VsRnlSVCtzTTdLTENYai9UbGxv?=
 =?utf-8?B?L053UCtzVkxwc3ZuRldpNEEwV2JycjhiN293N2FkcXozK0RCcFd2azZyRTlK?=
 =?utf-8?B?ZEIzRWpsRUtVNjNucHpmemEyeE5qT1I3UC9KUlJYNGRuVjh0NkI2YVljNjQv?=
 =?utf-8?B?KzhtZlRFTmRuajFLTUM1R1dWRGRMdkE0eXFBdUpwbUUzNmQybGhHRHhIR25X?=
 =?utf-8?B?ckdzWkIzYmlxYjVSV3p0NzAybHhtSFBMVXhnV0RRNDlkY29QQkNJYlltZURM?=
 =?utf-8?B?NEl3SGN5T0N5c21ZbHdNUnZRaUZDMEc2Mk52SlRFd2x0WHordW1aNzUxNVRD?=
 =?utf-8?B?WGJPdWlGSkNMVmRKeE1jdDhPclBtVHIwSUpkVnpvblp4QjNwTTVzTXRPczha?=
 =?utf-8?B?ck4vN2dUQ3llVnB5WU1DQjZPc1BmakR0OHA2R3Bodlk1ck1KTjRIUnJJQkNa?=
 =?utf-8?B?aXBYei9NNHhCaXMrWEZlVVpVUm1peGxZTkFYN1VFQTlpNjhMeXJ0Z285NDNz?=
 =?utf-8?B?Y2pkcElrYlpxRFlNbUUvSWpqVkhCZitsMExaNW1ZWFEyelJGWFRuZGw2YUZJ?=
 =?utf-8?B?QWpncnl3UkRIVm8rb0UyZzdxNGIwUG5GMlozcitHN2NzTHJEOEZPYzV6dWNx?=
 =?utf-8?B?WGN0a1lYanBzbVVqNVdLVkpPT09LSWpEUWlzdGZMNU5OanhLcDB1RmwyUVVn?=
 =?utf-8?B?TVNrZ3p2dlh3ZTRycHBLTlpkRnhGY0NlL3lISjBFQjJjN1lmNktYT2VGVU00?=
 =?utf-8?B?OExTTG1qcVk3YW5hNUlCclpkb0VCSDJRN0tmZ0JyaS9NMVFwTG5udmIvOE5O?=
 =?utf-8?B?L1FMUGJ4KzYxMXVTVE85dmp3aWVpMG95SHRNazlvTWZJVXZIZ3RiWUllU1Zz?=
 =?utf-8?Q?l90DOfSp4QROcGiz+zB2ERZX8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce209c0-180b-46e4-0c96-08db1e1c3dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 08:24:44.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSItKeu7GDym7OtlPthN40ilXuFTT27X8Uw4/B/K5medjNxK7WRMBXikt/mhFbQ/+BTCaEKzd6EiXIjJqxTNbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IFsuLi5dDQo+
ID4gUWl1eHUgYWxzbyBub3RlZCBpbXByZXNzaXZlIGJvb3QtdGltZSBpbXByb3ZlbWVudHMgd2l0
aCBlYXJsaWVyDQo+ID4gdmVyc2lvbiBvZiBwYXRjaC4gQW4gZXhjZXJwdCBmcm9tIHRoZSBkYXRh
IGhlIHNoYXJlZDoNCj4gPg0KPiA+IDEpIFRlc3RpbmcgZW52aXJvbm1lbnQ6DQo+ID4gICAgIE9T
ICAgICAgICAgICAgOiBDZW50T1MgU3RyZWFtIDggKG5vbi1SVCBPUykNCj4gPiAgICAgS2VybmVs
ICAgICA6IHY2LjINCj4gPiAgICAgTWFjaGluZSA6IEludGVsIENhc2NhZGUgTGFrZSBzZXJ2ZXIg
KDIgc29ja2V0cywgZWFjaCB3aXRoIDQ0IGxvZ2ljYWwNCj4gdGhyZWFkcykNCj4gPiAgICAgUWVt
dSAgYXJncyAgOiAtY3B1IGhvc3QgLWVuYWJsZS1rdm0sIC1zbXAgODgsdGhyZWFkcz0yLHNvY2tl
dHM9MiwNCj4gPiDigKYNCj4gPg0KPiA+IDIpIE9TIGJvb3QgdGltZSBkZWZpbml0aW9uOg0KPiA+
ICAgICBUaGUgdGltZSBmcm9tIHRoZSBzdGFydCBvZiB0aGUga2VybmVsIGJvb3QgdG8gdGhlIHNo
ZWxsIGNvbW1hbmQgbGluZQ0KPiA+ICAgICBwcm9tcHQgaXMgc2hvd24gZnJvbSB0aGUgY29uc29s
ZS4gWyBEaWZmZXJlbnQgcGVvcGxlIG1heSBoYXZlDQo+ID4gICAgIGRpZmZlcmVudCBPUyBib290
IHRpbWUgZGVmaW5pdGlvbnMuIF0NCj4gPg0KPiA+IDMpIE1lYXN1cmVtZW50IG1ldGhvZCAodmVy
eSByb3VnaCBtZXRob2QpOg0KPiA+ICAgICBBIHRpbWVyIGluIHRoZSBrZXJuZWwgcGVyaW9kaWNh
bGx5IHByaW50cyB0aGUgYm9vdCB0aW1lIGV2ZXJ5IDEwMG1zLg0KPiA+ICAgICBBcyBzb29uIGFz
IHRoZSBzaGVsbCBjb21tYW5kIGxpbmUgcHJvbXB0IGlzIHNob3duIGZyb20gdGhlIGNvbnNvbGUs
DQo+ID4gICAgIHdlIHJlY29yZCB0aGUgYm9vdCB0aW1lIHByaW50ZWQgYnkgdGhlIHRpbWVyLCB0
aGVuIHRoZSBwcmludGVkIGJvb3QNCj4gPiAgICAgdGltZSBpcyB0aGUgT1MgYm9vdCB0aW1lLg0K
PiA+DQo+ID4gNCkgTWVhc3VyZWQgT1MgYm9vdCB0aW1lIChpbiBzZWNvbmRzKQ0KPiA+ICAgIGEp
IE1lYXN1cmVkIDEwIHRpbWVzIHcvbyB0aGlzIHBhdGNoOg0KPiA+ICAgICAgICAgOC43cywgOC40
cywgOC42cywgOC4ycywgOS4wcywgOC43cywgOC44cywgOS4zcywgOC44cywgOC4zcw0KPiA+ICAg
ICAgICAgVGhlIGF2ZXJhZ2UgT1MgYm9vdCB0aW1lIHdhczogfjguN3MNCj4gPg0KPiA+ICAgIGIp
IE1lYXN1cmUgMTAgdGltZXMgdy8gdGhpcyBwYXRjaDoNCj4gPiAgICAgICAgIDguNXMsIDguMnMs
IDcuNnMsIDguMnMsIDguN3MsIDguMnMsIDcuOHMsIDguMnMsIDkuM3MsIDguNHMNCj4gPiAgICAg
ICAgIFRoZSBhdmVyYWdlIE9TIGJvb3QgdGltZSB3YXM6IH44LjNzLg0KPiANCj4gVW5mb3J0dW5h
dGVseSwgZ2l2ZW4gdGhhdCBhJ3MgYXZlcmFnZSBpcyB3aXRoaW4gb25lIHN0YW5kYXJkIGRldmlh
dGlvbiBvZiBiJ3MNCj4gYXZlcmFnZSwgdGhpcyBpcyBtb3N0IGRlZmluaXRlbHkgbm90IHN0YXRp
c3RpY2FsbHkgc2lnbmlmaWNhbnQuDQo+IEVzcGVjaWFsbHkgZ2l2ZW4gb25seSB0ZW4gbWVhc3Vy
ZW1lbnRzIGZvciBlYWNoIGNhc2UgLS0geW91IG5lZWQgKmF0Kg0KPiAqbGVhc3QqIDI0LCBwcmVm
ZXJhYmx5IG1vcmUuICBFc3BlY2lhbGx5IGluIHRoaXMgY2FzZSwgd2hlcmUgeW91IGRvbid0IHJl
YWxseQ0KPiBrbm93IHdoYXQgdGhlIHVuZGVybHlpbmcgZGlzdHJpYnV0aW9uIGlzLg0KDQpUaGFu
ayB5b3Ugc28gbXVjaCBQYXVsIGZvciB0aGUgZGV0YWlsZWQgY29tbWVudHMgb24gdGhlIG1lYXN1
cmVkIGRhdGEuDQoNCkknbSBjdXJpb3VzIGhvdyBkaWQgeW91IGZpZ3VyZSBvdXQgdGhlIG51bWJl
ciAyNCB0aGF0IHdlIGF0ICpsZWFzdCogbmVlZC4NClRoaXMgY2FuIGd1aWRlIG1lIG9uIHdoZXRo
ZXIgdGhlIG51bWJlciBvZiBzYW1wbGVzIGlzIGVub3VnaCBmb3IgDQpmdXR1cmUgdGVzdGluZyA7
LSkuDQoNCkkgZGlkIGFub3RoZXIgNDggbWVhc3VyZW1lbnRzICgyeCBvZiAyNCkgZm9yIGVhY2gg
Y2FzZSANCih3L28gYW5kIHcvIEpvZWwncyB2MiBwYXRjaCkgYXMgYmVsb3cuIA0KQWxsIHRoZSB0
ZXN0aW5nIGNvbmZpZ3VyYXRpb25zIGZvciB0aGUgbmV3IHRlc3RpbmcNCmFyZSB0aGUgc2FtZSBh
cyBiZWZvcmUuDQoNCmEpIE1lYXN1cmVkIDQ4IHRpbWVzIHcvbyB2MiBwYXRjaCAoaW4gc2Vjb25k
cyk6DQogICAgOC40LCA4LjgsIDkuMiwgOS4wLCA4LjMsIDkuNiwgOC44LCA5LjQsDQogICAgOC43
LCA5LjIsIDguMywgOS40LCA4LjQsIDkuNiwgOC41LCA4LjgsDQogICAgOC44LCA4LjksIDkuMywg
OS4yLCA4LjYsIDkuNywgOS4yLCA4LjgsDQogICAgOC43LCA5LjAsIDkuMSwgOS41LCA4LjYsIDgu
OSwgOS4xLCA4LjYsDQogICAgOC4yLCA5LjEsIDguOCwgOS4yLCA5LjEsIDguOSwgOC40LCA5LjAs
DQogICAgOS44LCA5LjgsIDguNywgOC44LCA5LjEsIDkuNSwgOS41LCA4LjcNCiAgICBUaGUgYXZl
cmFnZSBPUyBib290IHRpbWUgd2FzOiB+OS4wcw0KDQpiKSBNZWFzdXJlIDQ4IHRpbWVzIHcvIHYy
IHBhdGNoIChpbiBzZWNvbmRzKToNCiAgICA3LjcsIDguNiwgOC4xLCA3LjgsIDguMiwgOC4yLCA4
LjgsIDguMiwNCiAgICA5LjgsIDguMCwgOS4yLCA4LjgsIDkuMiwgOC41LCA4LjQsIDkuMiwNCiAg
ICA4LjUsIDguMywgOC4xLCA4LjMsIDguNiwgNy45LCA4LjMsIDguMywNCiAgICA4LjYsIDguOSwg
OC4wLCA4LjUsIDguNCwgOC42LCA4LjcsIDguMCwNCiAgICA4LjgsIDguOCwgOS4xLCA3LjksIDku
NywgNy45LCA4LjIsIDcuOCwNCiAgICA4LjEsIDguNSwgOC42LCA4LjQsIDkuMiwgOC42LCA5LjYs
IDguMywNCiAgICBUaGUgYXZlcmFnZSBPUyBib290IHRpbWUgd2FzOiB+OC41cw0KDQpASm9lbCBG
ZXJuYW5kZXMgKEdvb2dsZSksIHlvdSBtYXkgcmVwbGFjZSBteSBvbGQgZGF0YSB3aXRoIHRoZSBh
Ym92ZSANCm5ldyBkYXRhIGluIHlvdXIgY29tbWl0IG1lc3NhZ2UuDQoNCj4gQnV0IHdlIGNhbiBh
cHBseSB0aGUgYmlub21pYWwgZGlzdHJpYnV0aW9uIGluc3RlYWQgb2YgdGhlIHVzdWFsIG5vcm1h
bA0KPiBkaXN0cmlidXRpb24uICBGaXJzdCwgbGV0J3Mgc29ydCBhbmQgdGFrZSB0aGUgbWVkaWFu
czoNCj4gDQo+IGE6IDguMiA4LjMgOC40IDguNiA4LjcgOC43IDguOCA4LjggOS4wIDkuMyAgTWVk
aWFuOiA4LjcNCj4gYjogNy42IDcuOCA4LjIgOC4yIDguMiA4LjIgOC40IDguNSA4LjcgOS4zICBN
ZWRpYW46IDguMg0KPiANCj4gOC8xMCBvZiBhJ3MgZGF0YSBwb2ludHMgYXJlIGdyZWF0ZXIgdGhh
biAwLjEgbW9yZSB0aGFuIGIncyBtZWRpYW4gYW5kIDgvMTANCj4gb2YgYidzIGRhdGEgcG9pbnRz
IGFyZSBsZXNzIHRoYW4gMC4xIGxlc3MgdGhhbiBhJ3MgbWVkaWFuLg0KPiBXaGF0IGFyZSB0aGUg
b2RkcyB0aGF0IHRoaXMgaGFwcGVucyBieSByYW5kb20gY2hhbmNlPw0KPiANCj4gVGhpcyBpcyBn
aXZlbiBieSBzdW1fMF4yICgwLjVeMTAgKiBiaW5vbWlhbCgxMCxpKSksIHdoaWNoIGlzIGFib3V0
IDAuMDU1Lg0KDQpXaGF0J3MgdGhlIG1lYW5pbmcgb2YgMC41IGhlcmU/IFdhcyBpdCB0aGUgcHJv
YmFiaWxpdHkgKHdlIGFzc3VtZT8pIHRoYXQgDQplYWNoIHRpbWUgYidzIGRhdGEgcG9pbnQgZmFp
bGVkIChvciBkaWRuJ3Qgc2F0aXNmeSkgImxlc3MgdGhhbiAwLjEgbGVzcyB0aGFuIA0KYSdzIG1l
ZGlhbiI/DQoNCj4gVGhpcyBpcyBub3QgcXVpdGUgOTUlIGNvbmZpZGVuY2UsIHNvIG5vdCBodWdl
bHkgY29udmluY2luZywgYnV0IGl0IGlzIGF0IGxlYXN0DQo+IGNsb3NlLiAgTm90IHRoYXQgdGhp
cyBpcyB0aGUgY29uZmlkZW5jZSB0aGF0IChiKSBpcyAxMDBtcyBmYXN0ZXIgdGhhbiAoYSksIG5v
dA0KPiBqdXN0IHRoYXQgKGIpIGlzIGZhc3RlciB0aGFuIChhKS4NCj4gDQo+IE5vdCBzdXJlIHRo
YXQgdGhpcyByZWFsbHkgY2FycmllcyBpdHMgd2VpZ2h0LCBidXQgaW4gY29udHJhc3QgdG8gdGhl
IHVzdWFsDQo+IHN0YXRpc3RpY3MgYmFzZWQgb24gdGhlIG5vcm1hbCBkaXN0cmlidXRpb24sIGl0
IGRvZXMgc3VnZ2VzdCBhdCBsZWFzdCBhIGxpdHRsZQ0KPiBpbXByb3ZlbWVudC4gIE9uIHRoZSBv
dGhlciBoYW5kLCBhbnlvbmUgd2hvIGhhcyBjYXJlZnVsbHkgc3R1ZGllZA0KPiBub25wYXJhbWV0
cmljIHN0YXRpc3RpY3MgcHJvYmFibHkganVtcGVkIG91dCBvZiB0aGUgYm9hdCBzZXZlcmFsIHBh
cmFncmFwaHMNCj4gYWdvLiAgOy0pDQo+IA0KPiBBIGZldyBtb3JlIHF1ZXN0aW9ucyBpbnRlcnNw
ZXJzZWQgYmVsb3cuDQo+IA0KPiAJCQkJCQkJVGhhbngsIFBhdWwNCj4gDQo+ID4gVGVzdGVkLWJ5
OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
b2VsIEZlcm5hbmRlcyAoR29vZ2xlKSA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCg0K
