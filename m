Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914D68397F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAaWnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAaWnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2353EC4D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675205011; x=1706741011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+I6uksLUaCYgbGv0nu+NfZRQ0gwja68UIAAYeCk2Stc=;
  b=EUnp/LR1eImCPMcwpjMXUo7gYLxa3VNffNjCP1UvgR8ATxPKKBN/og5t
   xb3cZGAGISTyH/lIbyJWbgmrpaUqDJxIQEnGmeFOJ8vLbZXZGVLfJYHS5
   KwAz0U97mJT8HF4f/46LRqUoy9HJKjYwJWgUBF2sH5A1EKbkkFOOMTQM3
   GbJS4T76U/ZZvvP+iUrogJ/x/PPFtqJZ+BisnJ8m2O4+HRvJWV2K5roeU
   grBlgDcTyl3uSFMpussWjuvsYeRzmL1bXR0l9MZnJjLDuwyz43WyZd5cg
   hKpE/dsev5GkUl+Eh1XosVtXljW4j1/ai3gqJHg+/RR6HO8eWhZFL1ioi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="307637616"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="307637616"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910076971"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="910076971"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 14:43:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:43:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 14:43:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 14:43:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpidAK+HX1/JgQKDaehAPJrkptSBPABJhaw7/jrjlNnRo1HZPEszBsUg6bWmIOzMJ2kMwxY+QZV7mR0LhDbXtAnUgLVaeuziN2CezzLjUBEjxzmagDeVj6jeq4hz8e3xgnRkHgUYOhh1iINH2vuWFS02jPwdmD5gXJK0SMg8/AKf1vanogIwu7M1c/Ap8I0DBFyN9aHw77JBV6XgCH5y5T75FzoacCN7/hD/Q23F+8Fq6L4Hc8Jucf2ZI08+TZDx6yQFHPbNtDh+a550ZmzAX84WJ4Brdm3GmkLceaYspdFpOKhIa6WwrPgkQbeXw8gZqmBXLzhfuqES/qyUQlzZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I6uksLUaCYgbGv0nu+NfZRQ0gwja68UIAAYeCk2Stc=;
 b=mmz6TAaxopPNDFT3sgFYVeaHk10x7Z1tWQSNGr1WyD9EVG7UlPt2jsjs+pBnIXguw3iqct5ya1l5PfaPzHsTC/dA74BwUj6uDFtzshwRbwkRos/ZZhbn1YjjPzP6soYhiz/bRc6a9svAmGWeH0qK3rcR9WMLwT/oy+igAIiE17bX3K7TCErQG1pymuDfJyxBMHEPLKfxL5pTWwCJ2ASqOphm8/BYQpOEsSD7QdILcH/WxJRe6SPksVw6YPIuOFLHHj+bL1VmE3kU6vqhFOl7sP4ABgMLZtAUyEfjJ1YH9ONy9G98agCsJEJHLpvjqke7/EEFMx9hmGLl9W/ExqkYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 22:43:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 22:43:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Stefan Talpalaru" <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: RE: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Thread-Topic: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Thread-Index: AQHZNPN2NI5TxkYoK0abVR9vY8eccK64vecAgAALhpCAADU7AIAAAMCggAAHHQCAABhvwA==
Date:   Tue, 31 Jan 2023 22:43:23 +0000
Message-ID: <SJ1PR11MB608384F3B075E0D2F25683D3FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com> <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
 <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9mDYMASXCFaFkNU@zn.tnic>
In-Reply-To: <Y9mDYMASXCFaFkNU@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB8119:EE_
x-ms-office365-filtering-correlation-id: 82941f96-e1ba-401d-f517-08db03dc8f87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6exl/DuHJsHuWcFiYmQQ4E/AVe+bJ8fX+GWstwzaoJCZBVWxGIPznEudla/dQUsfaul5rwHH1JS4OzkqFrJK1MqJaxikJBA/Xm4aSb6jbjXiNKu3MaPOZhatMxhRxjXRbmEDghC8K/JvToJD1WdnmYHSraTxrLTKnBf/JXbYQEiDSiP0QNC2Wf5UYL2gawq5pJIo+aNlW5NmCX4DsnEFw2nCNse7TnDro1d1TJ3PJScCf1TT69vTvwZ0AjDiTk4onKO8mpelyGAeBDJmjmmQin52wCukQkIOXldPRf5KF4QNXtuOSoWXuKCkL29WGbzs7Fx6pSCH+dzTbPclLgEQjnWSSCiktHSv8Yp3f4i0Pk1RsUR6kiDPXFdF5VFlemWVyLsnTQYreKm3CGt6xjOS8jCfpFMZh1xi0jt8HfNmHLWtfuZwbaXE0wyx1/2vpo3EXgflBPtj881R4vdoGtMLOLg2ILeQcPsK5Neww+x19ZbLp5BPy59lxTayWQLbq0vMapydGz1h5WmuuyDad4X88ECuhq9A9rbw8tZ5tAgdOnAQ0weYFn1CLhsgyiHyofCfPeqOGSNGJq57iSPjSxejlwV3AWV3Z2I3Lkc5UrPK7VSWWrcVuS8JnFDy9ZCY5Z9oPM3QgUuUoyWcjpp6oHfo1TWoS1uVkda4LwGFFW0aqJ82iLGY5/knRoFBaRub+imeBnvmTpNZjEH5wedqpYg6uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199018)(66946007)(4326008)(54906003)(316002)(66556008)(66476007)(76116006)(8676002)(64756008)(66446008)(6916009)(41300700001)(8936002)(5660300002)(82960400001)(38070700005)(38100700002)(33656002)(86362001)(122000001)(71200400001)(52536014)(186003)(6506007)(26005)(9686003)(66899018)(7416002)(4744005)(2906002)(55016003)(7696005)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDZ0cS8yWGhqSUFaMHNsdlBTNzVQcHdjS1hFNkdzRW1RcmFSVS9HeTNldGNC?=
 =?utf-8?B?YXREYWpCZ2RiRGpaUnNqcE9HSFQrYUFNR0pkQ2MwaGtFSXQ3L1dxcWpyTjF4?=
 =?utf-8?B?ellaZitKbnQ5T0xLNmttWlBQb1IxYWx4RjN2T0JlSCtUZG5sZ3hUR0VVVUI5?=
 =?utf-8?B?UEtsVE8zSERicUFldk1URGVGenVTNExJVFdmYUc2akZYYkIvVXVIRkJ0b0FY?=
 =?utf-8?B?UExKZGlIUzZaYVBwZWllRnJFTytubWk3VS8xTUNneWgzNFJzN1lqdUVaOWJm?=
 =?utf-8?B?UnZWWFc2TEM3bmt5K0Fvd1Q4YkFNZnhNb3orUW9HL3pDYUFGL1cyd1dxSlZm?=
 =?utf-8?B?M0hnYUg2SnBZVzF5MThHVnpmSEtIQ01WT1B0NmRGWkU0K1VubWVLNWVuYTIw?=
 =?utf-8?B?cHAvbGkwaHIxZUVlMlJvcjBwVHdhNzdSOS9HTlRGdGlYdVYwNE56NDJuVDJ4?=
 =?utf-8?B?REJWZkZwRk1TMytNUTJ4Qk5jSnJFbitxcU5kOHhleml1THRpcmlFMjlpaHRt?=
 =?utf-8?B?SFRSRlVnam5yM082Nzc2aWxiNlFlUTBhZlFFN3huNjhJMDFFMHJTVUlzR1lE?=
 =?utf-8?B?VG5DZFEvVllNeEYwdnFCWVZpZzZxVGtMb0FwUjZXSjhDY1ZPeDRzTnExY3Vk?=
 =?utf-8?B?Q0k1bWRsczJXWXNueVNDVzNPVXdxUENoQ0Z4ZmQzakhxSFN3TGY2endqK1Q2?=
 =?utf-8?B?SW9obXdyR1FxNlBZVU8rVVB6K1grVnJONEJjS2J2cW9ERmNTWk5rZUlOVjRs?=
 =?utf-8?B?NEV5UmpaeVJ1MG9HL3dJM1MwRE10eksrbnoySU16cktOai84ckMrUkFkcUZa?=
 =?utf-8?B?V3NXZkhmUmVZL00rSWQ0U2JSSFV4Y3YrYUQzU05oWmtVVEF0a2hpTmRaemdR?=
 =?utf-8?B?UStvWWgwSXQxYmNraUZPRysySUsxSHNlTW5RU2VjaEtodlV3WFUybzMrQUFr?=
 =?utf-8?B?clpnZm9tL1BxK2pWTTRYbTBLcXRaQmZwdWducnVLV2dwbUhtd0pIcUJ3bFpG?=
 =?utf-8?B?dW5hM003WFdPRU44ZDdXK1pUSU5uYTFuQ2RKcVErRndLNlRPYUl3cjNLbG1X?=
 =?utf-8?B?K2Z4UERZY1U2ZTdsRE9QMC9ZZU14WUdBenFnWEtKRjBsM2JwMGxISEd2ZnNI?=
 =?utf-8?B?LzNQTGdpdDd5TTluZDc0cXpjWkRmUitnT2VGK2Q3d3JhNzMyeTR6S0IyQ1I1?=
 =?utf-8?B?OXZpM3Y0Vzd1cTBIZDYxRndCRUVzQzFjKy9VM0kySE5nenFlTm1hK2w3Nk1S?=
 =?utf-8?B?T3c4NXc4ZDhrYzdRWmxZSkU4N2pZZUR3N1crUE1ZTnQrOGdLdXFYR3RlKzNY?=
 =?utf-8?B?cUozL0dHTjgyTzRRbFZYd2RDa2hRSW5qZnMrQ0tPc0lldDBDOWFmOUJlaW1h?=
 =?utf-8?B?TUpPSmpMdTlLNDVQMWNhNjludkQrbmthTlI3ZUFwQ3l4cGVYSXRpVFBhZ09m?=
 =?utf-8?B?NmdBQXVWWHBGQUJjUGM4bVI3MW43Z0E2S1kyUDVGQURjNVg4ZisweGUwMURS?=
 =?utf-8?B?aGVTMHRFcmMrc1FNR1JMcm80YlExQmhUQ2NieDB2RVhzaStHaTdYSGFic1M2?=
 =?utf-8?B?NUJZVmRFZEZvT1FSOFliV01iNkxKUTR5ZkMzbVRld2l2bllUZXhJeGxXcG5o?=
 =?utf-8?B?cjRHTjlBZEUyVlRxWlliQTNJSTVEL1ZmOHMxYUYxUE1BUGdzTDhKaHlxRnZw?=
 =?utf-8?B?K2dGTUNaR285MkdBNThDUUdCRFZpVnBRb3R6bG83RWExUjhDM0VpcTFmaVlp?=
 =?utf-8?B?WGxNNVlPYS9HMEg4KzdiQnJ2VzM0VnRpOGpJWXRJQm03NTBhWmpDVzVUMGJs?=
 =?utf-8?B?OFFVcnczYzRHQTJBRXlZRU41SXJ4RnhhVldod0ZQdGFSUGVta1JEVUl1Yjl3?=
 =?utf-8?B?Q1BIaGFZNW9xUklSYndzamdyRmcxai8xc2JIWkRIUHlURXJjNXhwbitYbElj?=
 =?utf-8?B?N2pzbEtuTVJQV0lqc0x3T0haWUh2My9MaTVaMVVBcVAxV2R4MWRobVh6V3Q1?=
 =?utf-8?B?Q2NDY2RXSUlRbktpZ1M2VkJqNnNhUXEwYWpGUFdyU3lHUWRlVXN3bHpDdXFj?=
 =?utf-8?B?OFkzRUxjaWpaTEs5eWVEVnl1NHhnNUVsRGNzQXF5YkNYUHR0UlBTa3FBcU1B?=
 =?utf-8?Q?RGhUxcfYyh80ybqqO0XD7Wlz7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82941f96-e1ba-401d-f517-08db03dc8f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 22:43:23.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R50t2IdGjLTMeRKU0fPfRqnqr/eK4fteBIlPPj0g/pHcenPCz1jPQrwqlzcpq1o9jJ6F6jg+um6RETtHpGJ5dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUMCBhcnJpdmVzLCBhbmQgZmFpbHMgdGhlIHVwZGF0ZS4gVGhhdCBpcyB0aGlzIHBpZWNlOg0K
Pg0KPiAgICAgICAgIC8qIHdyaXRlIG1pY3JvY29kZSB2aWEgTVNSIDB4NzkgKi8NCj4gICAgICAg
ICB3cm1zcmwoTVNSX0lBMzJfVUNPREVfV1JJVEUsICh1bnNpZ25lZCBsb25nKW1jLT5iaXRzKTsN
Cj4NCj4gICAgICAgICByZXYgPSBpbnRlbF9nZXRfbWljcm9jb2RlX3JldmlzaW9uKCk7DQo+IA0K
PiAgICAgICAgIGlmIChyZXYgIT0gbWMtPmhkci5yZXYpIHsNCj4gICAgICAgICAgICAgICAgIHBy
X2VycigiQ1BVJWQgdXBkYXRlIHRvIHJldmlzaW9uIDB4JXggZmFpbGVkXG4iLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIGNwdSwgbWMtPmhkci5yZXYpOw0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIFVDT0RFX0VSUk9SOw0KPiAgICAgICAgIH0NCj4NCj4gV2UgcmV0dXJuIGhlcmUgd2l0aG91
dCB1cGRhdGluZyBjcHVfc2lnLnJldiwgYXMgd2Ugc2hvdWxkLg0KPg0KPiBUMSBhcnJpdmVzLCB1
cGRhdGVzIHN1Y2Nlc3NmdWxseSBhbmQgdXBkYXRlcyBpdHMgY3B1X3NpZy5yZXYuDQoNCkluIGFu
IGlkZWFsIHdvcmxkIHllcy4gQnV0IHdoYXQgaWYgVDEgYXJyaXZlcyBoZXJlIGFuZCB0cmllcyB0
byBkbyB0aGUNCnVwZGF0ZSB3aGlsZSBUMCwgd2hpY2ggaGFzIHJldHVybmVkIG91dCBvZiB0aGUg
bWljcm9jb2RlIHVwZGF0ZQ0KY29kZSBhbmQgY291bGQgYmUgZG9pbmcgYW55dGhpbmcsIGhhcHBl
biB0byBiZSBkb2luZyBXUk1TUihzb21lIE1TUg0KdGhhdCB0aGUgdWNvZGUgdXBkYXRlIGlzIHRp
bmtlcmluZyB3aXRoKS4NCg0KTm93IFQwIGV4cGxvZGVzIChub3QgbGl0ZXJhbGx5LCBJIGhvcGUh
KSBidXQgZG9lcyBzb21ldGhpbmcgY3JhenkgYmVjYXVzZQ0KaXQgd2FzIGluIHRoZSBtaWRkbGUg
b2Ygc29tZSBtaWNyb2NvZGUgZmxvdyB0aGF0IGdvdCB1cGRhdGVkIGJldHdlZW4gdHdvDQpvcGVy
YXRpb25zLg0KDQotVG9ueQ0K
