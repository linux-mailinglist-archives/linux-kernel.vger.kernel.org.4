Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763456A3B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB0Gfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Gfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:35:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3AEDBF0;
        Sun, 26 Feb 2023 22:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677479742; x=1709015742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NRqSnAbm4RhlJOK9s7g2ivDXvIOQyaz5NaXKHRJvw1U=;
  b=leaDTuN48zfhb/PWjhq33UpmXlShA2yI7tM0CylFnRYUfWnUKunLS9M+
   rSUnkDs/4B+cvWmrkvNhiJ6ALZM8rGOyMumlipdfnSTmXmD0tKU33goMJ
   qn21pMuWmuPbC6+BFUAU5x5n1ZDN6Xa5WxnF7Zbwws4LEY5Ar+gIuFLda
   2hVJWWfwwo6C59vELJnw1qNYwbLYoiK/x2/zE0Ni0gXp2kbSBcD1LR6SB
   uVdS2SrdGkU+J+w0tBJoiE30Cgi8SAbvFjxfIz6jMVbXpga4lh/yypWNv
   crY12VVYfDwyBgppKccCSoAzjOE0iUO8UORFmfFtE0Fsob5vEM6gVsYvO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="420054808"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="420054808"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 22:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="623445105"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="623445105"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2023 22:35:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 26 Feb 2023 22:35:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 26 Feb 2023 22:35:35 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 26 Feb 2023 22:35:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRTfLSQUcNcjgwoLxU3RQbXaXiWrKP3giZ6kFSxS/x2GYo834qjwJr9rkN92CJyWOy3C0JzH0tLYDf8ZVVAU0cPVQ6hloKJ4Dj5QaVQUmZdWSKFCg9gcljigwGtycje/Gn+zEIOdJZicYe/MN2kf/E9UWnMCE/5sbfC5pLXbJcBH/ADCmwSkDAEIx5H4rbnh2RhJNP9oe+4et6VQaRXzG0islebnom/n64gcT03Oh9114awfq0P1ZbbgYk0Zbb4IaE6KsuU0yCmnsdbM5ObQPczdbccylcmFKCxm0A46WQpWhqmje3weu2ofKCiYBFj8LmwchaIxLFf+EC5J9Dhyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRqSnAbm4RhlJOK9s7g2ivDXvIOQyaz5NaXKHRJvw1U=;
 b=F7s0W7dclLuqe/6jQ/+fqN1yXFDtfHcpwI0TGs4kgCLq5YGe7Am4GbfiadoWifvsqtSIlhL0bCGL6+rLqg2u2lS5QgQdKcy9kmK1mhyehGqGBSMW2c6ga/u23OcjKcbklkKPdwGvwY6jUogYZtZvFWwJTlr7I0GVNRYKxgPURtCJny7UIuGCIe7P5Toc7NMxuIIKEjk8o5/uKm0oZ0KexBUc+wnWG5gyM6wxOxzW0WzZHUsL7nNcSFnYQA39drxENxNSplrNGCBVxqbdXGE/SkkK02Hk9gA+BIJt8JwmavQjS3wJ1qGzjXWAA0ZKs9Boip0wLEkKYIoK1PsCF+sWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 06:35:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6134.028; Mon, 27 Feb 2023
 06:35:32 +0000
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
To:     "shakeelb@google.com" <shakeelb@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     lkp <lkp@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>
Subject: Re: [linus:master] [mm] f1a7941243: unixbench.score -19.2% regression
Thread-Topic: [linus:master] [mm] f1a7941243: unixbench.score -19.2%
 regression
Thread-Index: AQHZNaGiUwf449h850awKs6Cgs0uTa7igHEA
Date:   Mon, 27 Feb 2023 06:35:31 +0000
Message-ID: <d5d0bcf75cbaa2792a3ad0e7b15a84fd67e54454.camel@intel.com>
References: <202301301057.e55dad5b-oliver.sang@intel.com>
         <Y9dETROtv9Bld9TI@casper.infradead.org>
         <20230131052352.5qnqegzwmt7akk7t@google.com>
         <Y9iq8fRT4sDgIwQN@casper.infradead.org>
         <20230131055743.tsilxx5vfl6gx4dj@google.com>
         <CALvZod7TuaJ7pCc2nJKehwGkcuvsvjdL+4hs6qC3bZsOmGzXzg@mail.gmail.com>
In-Reply-To: <CALvZod7TuaJ7pCc2nJKehwGkcuvsvjdL+4hs6qC3bZsOmGzXzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4820:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: f10d318b-f89c-4e5b-a18c-08db188cd31f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6g9yANPu5ebHOxcmZZ1lHDLP8hOiHLYFpVLxVXS0BjZEiHGTc3svDPZtaJDeyn10BIXsnbwWqFVRMhde023c3y6rdKd+rjAK3vVqzsTGUTc9uVaE9iOT3ghDiu+wek6Cusw71+BdUG40kmOGEpGnEnaImUmRhtftYseIszqhmD2/miIrVGyaSoDB0hriomrEDRvrE6bQCzUB/fJYdqKYzBbIVpLhuxP6uW/aUMc3EGWZDip2eNvGftt8t4pwFueTGATJVqwPwVXFwP6zoIxNeErjH24/whVcttLvRnjpfTDPqXo92r+ChQpUBTVxJThO73GnisrfeBXpLOtemouDJnEv2OCUmSM8TEhFrjQ+mjUzLe/mRMxCDQu88apmr1WIgaAhMf0sCFTxfur1MAOoBqaMTfvj+/prmDLkzitNSgeOj7NGvzB2n803qWYhAd9WhqDv5fZpIh2Lp5uq8B6pCVSstjPpuGK6LOKPmgRbAqPo1cxEadBkHo8flB1aSDYeH1xCyAJZImnKmhG9uHKptMhUXD6llCL2XgnIIxaeLvXe7jzq8Suj/j7gqhYGB4ODBF5LFvA+A6QMfVu99xFXsAAdFPyB4OctMVgMJQ10rt7HUvTfzy+H2ye9rcXGaQ9jZTCIh7FxeC+1SqOGWNsys9bAOjIhxxDU0mIbw9df1BXxhN4Qvt2ZiSUsi+nLPy6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(186003)(53546011)(26005)(316002)(38070700005)(41300700001)(71200400001)(66446008)(66946007)(91956017)(66476007)(66556008)(76116006)(64756008)(54906003)(6486002)(4326008)(8676002)(6512007)(110136005)(38100700002)(478600001)(966005)(6506007)(36756003)(2906002)(83380400001)(8936002)(2616005)(86362001)(122000001)(7416002)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkd0RGNYbEI3ZHoxdlBQT3ZDNUVlNm80WHBIZGdRZFZ5MlU3YmVHWnFUK283?=
 =?utf-8?B?cEpXN0duOWoxV2Q0b0FiSnhGWUxNTkZWZG5QTFN0T2hiSzFGM2VBZHc3MWZL?=
 =?utf-8?B?WUFWQzY2anJ5OFFVTFllSW9kTG5UeVloYlRGR2NuVENlNUQwU2JlYjMybjBm?=
 =?utf-8?B?bC9BNFFMQ2V4cHNYYVJ4K09uTmRGMGp5cDZGcTlIaWc5U2lCclQxRXVsalI5?=
 =?utf-8?B?cklFd094bFZUaXdYQ3ZQaEJwYWpXMlBuNGpqcThkdGZ5QW1LalcwQlBNUnhB?=
 =?utf-8?B?dE1WK0RaeVlmcVNhR0Y2Y2VIeldrM3F5c1lxUDExTlBQeldlYVhhai92K2JH?=
 =?utf-8?B?TXBrQy8zRUtSbG1UeG1OckN2K0xpMmtYYnRRNEVadUxMbng0bEd2UERSRFc0?=
 =?utf-8?B?OVNFaGpWL3RwQnBBeVZTcnRqVy9EczYyN1JpMThiWjErT1doT1lVdVBMYUFw?=
 =?utf-8?B?S0R5QVpZTDhnZjQxbC92c08rTjZ3ZU56aWlBZkRmSjBoSm0vWkJxYUlUVTFq?=
 =?utf-8?B?Zzh6dVJqYjJMOTc1OGZzb3R5WExvNTBXS1FUZDh5dzFyaUpPMFY5ZWF5YTVk?=
 =?utf-8?B?aVdMaFMvTElnWXRadnlkY3FvNENkSGR1dmJjUHlUUUtxeGg0Nm8rdjIwcm56?=
 =?utf-8?B?dFZ2a0NpanF5blJLSVZMTkhxeVRNNW5tWXh4NklidWo1S1lXa0gvNWJNb1Fi?=
 =?utf-8?B?eXp1U1BVQmJvVk1ldFhHTE8vaTFHS0grTzV2L1p5RzJjU3d4NnNtdWRrSWR2?=
 =?utf-8?B?VEhtMVZsdkZxWisyQ1VDbXVySm9yZDNFdDU1V1NrMUNKWEFtWEZpUU9RVU5p?=
 =?utf-8?B?S21CQjdaMGdzV1JpVmphTzkyZEIyRFE4TjY4Qm9wOUxVaUp4aWhvU2JKZi9I?=
 =?utf-8?B?dEEyWWZleHNRY1ZxazhNQk8vS3JHWkpMbmNWQ3hUUG1VbDVUYmtzL3p1Um43?=
 =?utf-8?B?N3A2WFljSnBOMDdCeFFXaGVoYXI2dFczNlVGcWJhc3ZXYlVORVBqQzZsbW5G?=
 =?utf-8?B?ak42Tk4yV0dqbXpDUFZwLzB3NWNsZkxLSTFkMUN2QW5CRU01cXJhc2h2U1ds?=
 =?utf-8?B?T1JRR2NXcDBLRVJoLzVPeDRyRnhaeThXeHhHcEQyTDhVVngyV3lHKy8raHNn?=
 =?utf-8?B?VkhqOFVwMXFUbS9MS2JaKzlka2VMMWJwak9VaEhZb0RxSFh0Tk9DeGhyVVRi?=
 =?utf-8?B?TlhhSlpvOFc2bFljaEdIZzN2R3Z3VStuc05hOXNudGU3S1lxS0hrVlZTcXFT?=
 =?utf-8?B?VFg2cmFtZDlNM05xWWFlWDBzRXlhZUtrQ3JRK05JTGY4b2hUemhzUnAzQVZK?=
 =?utf-8?B?U3k2T1lNajVBVHdWQmFGNFhZbHJlTE84MXBzTVNuajRMN3JndXJTU09OVVZu?=
 =?utf-8?B?aks1V282aFFEVG5ld1dYK3RnT09tQXRKRnZia1JvcnJZMDUrekg1OUxwQmZB?=
 =?utf-8?B?VkNEZm5EMTBRVkFmUXFCU2ZxRktmR2dvY3kveTY1bFZrRHhHYzNrZ1VRaU9Z?=
 =?utf-8?B?ZnRleHhtMjFaSnl2MDNPT1FJMVdVbVo2VzVsaTZYNTlTV2o5ZEdEYVFZanQ1?=
 =?utf-8?B?YzkxQ1RaOVlDZFJaTjdCYzh6Ym8rT0NPZ3c0K3RqRjdidzNURmRQdGJwbGhs?=
 =?utf-8?B?aEtXQXI5azhPaTN2cGhFMmQ5aEZvQmx1dFdSZFFHZzIvN29Walp3VENIdVll?=
 =?utf-8?B?Y1FCb2lRZlR0YnE2YmJWclRvSUl1aENJZ3Iyd1o4RGdISUNWaXVWRXNZaUFr?=
 =?utf-8?B?VzdJK2d6ZTRScjFJbHZjdkRCQWNzaE1GMHVFU2xsWkpIclV5UzJucTNXK0dZ?=
 =?utf-8?B?V2RGM2o5dEY3SWdlaTVYOG5la3d5QStia3BYQ3lxM2RPenFnaTVNVkhHdnV0?=
 =?utf-8?B?MEY1R3Z6TS9FQzl5bUc2RFJEWW9aVzl3TVVIRGZFaURZK3BySncvaUg2NUlG?=
 =?utf-8?B?N2FWcENRajgwQTRheENTMkVuWGtqenUrNE5YTEo1KzhuRzVXMGZTS2dDN1d5?=
 =?utf-8?B?L0VGS2Q1a1gvWHZjeGo5ZUZjRUo3WVdneXNHN2FaSWQzT1Izb1ZCTU5qbVJB?=
 =?utf-8?B?WkYvRVBqY1JxL1E0WXBPS0JUb2NIa1ZyV2dVNlgrUXIwaUVFYkdxTGdlWHI4?=
 =?utf-8?B?WDFmSTdaeExhaHdKN1pBSVRLL3VTaEZWNEFxZlhuZmFxVHZ5ZmIzeHhoekZJ?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <373E1695EF3F6F489E480DE6E091E9CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10d318b-f89c-4e5b-a18c-08db188cd31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 06:35:31.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGqOJZjQx96AlxB7HRKod1IZ89spwYCMoVLMhaLbs3qzIw6roB46ORZZ9gFBbZyRoyvaG3zUoSvKqUIrfM9uXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LCBTaGFrZWVsLA0KDQpPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTA6MjYgLTA4MDAs
IFNoYWtlZWwgQnV0dCB3cm90ZToNCj4gK3Blci1jcHUgbWVtb3J5IG1haW50YWluZXJzIGZvciBG
WUkuDQo+IA0KPiBUaHJlYWQgc3RhcnRlZCBhdA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1tbS8yMDIzMDEzMDEwNTcuZTU1ZGFkNWItb2xpdmVyLnNhbmdAaW50ZWwuY29tLw0KPiAN
Cj4gT24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgOTo1NyBQTSBTaGFrZWVsIEJ1dHQgPHNoYWtlZWxi
QGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiBbLi4uXQ0KPiA+ID4gDQo+ID4gPiBXZSBj
b3VsZCBjdXQgZG93biB0aGUgbnVtYmVyIG9mIGNhbGxzIHRvIHBjcHVfYWxsb2MoKSBieSBhIGZh
Y3Rvcg0KPiA+ID4gb2YgNA0KPiA+ID4gYnkgaGF2aW5nIGEgcGNwdV9hbGxvY19idWxrKCkgdGhh
dCB3b3VsZCBhbGxvY2F0ZSBhbGwgZm91ciBSU1MNCj4gPiA+IGNvdW50ZXJzDQo+ID4gPiBhdCBv
bmNlLg0KPiA+ID4gDQo+ID4gPiBKdXN0IHRocm93aW5nIG91dCBpZGVhcyAuLi4NCj4gPiANCj4g
PiBUaGFua3MsIEkgd2lsbCB0YWtlIGEgc3RhYiBhdCBwY3B1X2FsbG9jX2J1bGsoKSBhbmQgd2ls
bCBzaGFyZSB0aGUNCj4gPiByZXN1bHQgdG9tb3Jyb3cuDQo+ID4gDQo+IA0KPiBPSywgbm90IGEg
b25lIGRheSBlZmZvcnQuDQo+IA0KPiBBbmRyZXcsIHdoaWNoIG9wdGlvbiBkbyB5b3UgcHJlZmVy
Pw0KPiANCj4gMS4gS2VlcCB0aGUgcGF0Y2hlcyBhcyB0aGUgdGVzdCB3b3JrbG9hZCAoZm9yayBw
aW5nIHBvbmcpIGlzIG5vdCBhDQo+IHJlcHJlc2VudGF0aXZlIG9mIHJlYWwgd29ybGQgd29ya2xv
YWQgYW5kIHdvcmsgb24gaW1wcm92aW5nDQo+IHBjcHVfYWxsb2MoKSBmb3IgNi40Ky4NCj4gDQo+
IDIuIFJldmVydCB0aGUgcGF0Y2hlcyBmb3Igbm93LCBpbXByb3ZlIHBjcHVfYWxsb2MoKSBhbmQg
cmUtaW50cm9kdWNlDQo+IHRoZSBwYXRjaGVzIG9uY2Ugd2UgY29uZmlybSB0aGF0IGZvcmstcGlu
Zy1wb25nIGlzIG5vdCByZWdyZXNzZWQNCj4gYW55bW9yZS4NClRoaXMgcGVyZm9ybWFuY2UgcmVn
cmVzc2lvbiBzdGlsbCBjYW4gYmUgcmVwcm9kdWNlZCBvbiBsYXRlc3QgbWFzdGVyDQpicmFuY2gu
IFNvIHdlIHRvb2sgb3B0aW9uMSBoZXJlLiBSaWdodD8gVGhhbmtzLg0KDQpSZWdhcmRzDQpZaW4s
IEZlbmd3ZWkNCg0KPiANCj4gdGhhbmtzLA0KPiBTaGFrZWVsDQoNCg==
