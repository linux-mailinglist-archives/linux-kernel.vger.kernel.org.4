Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EE660276
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjAFOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjAFOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:45:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45280AC2;
        Fri,  6 Jan 2023 06:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673016326; x=1704552326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8YqDKoTh0qNgNHwHx/S0XJ2K0WyLYmJ5YMxOgyL+520=;
  b=ccTQryvamzJqhLRqW6AApTncW46ArjczFepymD4V4dQeGiW2iM8VSobx
   aN3GKjjrtfo8oO5SrtjpZoixCHqyIfygBcJ33SIeDmx0TN9FW2sz9/xwG
   3oBJ9K0SRz7u20DPf/UQaWZqg0YKmWqceK4xnPr83bQ7UlWSlNgGikz2S
   MkFHewd2E8gLMjvbrM13ZO2EJgGHMyu1nzhG1nicEdzrcBX+CvhTYPuH6
   kAVkEgmKg6nIpAaoLpNVUBnU9AmKtcKIvYccwJs1dvC5Xw/1CB6BG/TVA
   /L3KTXLS8yLSYFA56NlSoCyyA3zOwXfYsMr0bl5Yqj6RQvVHhdVJlqNYM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="302185432"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="302185432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 06:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="686481144"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="686481144"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2023 06:45:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 06:45:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 06:45:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 06:45:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVfL6DkSokAthleQXkDihhpclFghT2FQjtw2iORkZK/8CRN/TbT03pAJv8QQ8o6gLTptjiKANxM9SpvAUAO85M+xQzErRIm1O6b3u7HuKWzPvelwtfpoEOwwsFXihR49xPtviRf5sYrw6t3u8RoqOucNwk/UlxvLytJ+7AXP5cP1DJbJpiDAtY5Eh9IaKFYtXgSxIcYFrh1GCGiQKnSnZZcWV4LYy1vVfn4+QeilYBkFR/D4mlH457+NucjwMn+6VPtNM/Io7v5wnLMboGfL5hEJrtfhyfi5uhIhgWlqquBSm38RUDixGOlZiSCNCUOCc6IPQ7VyPaxoPg2j6WpaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YqDKoTh0qNgNHwHx/S0XJ2K0WyLYmJ5YMxOgyL+520=;
 b=H4fhiZpFiLemlDqkMPy3Zvc7iGglhnIg7BUJP3Grsau0aYFVZDUA0oi6qE7V3iFFepFUVNqWuKfoS7uagPTdIWgF8ruXkUdRmNnRpB/vnPrXo6b8UvkPnNHqSlFqeFCNZXqbDsVl4bSySr9e2DLS3iOyC6zuZUsNcNCz0/qLX2LvWoRGsMvPYTXzZ97NCkX/7Gnj76PEB8b4idfG26+fMqeSbzO4tdTUQ/9RWOxPFPb4Y0R/T1nYWCwKZyV+bN4EMWwHf8VmPRBUHbKlqvc5aozOegjhdS7Fn/YOKCrNWn+zx3McG9ENyGxqzDgat/h1OY/cWmR+nY1jOheWrG2uVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 14:45:22 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 14:45:22 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Topic: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Index: AQHZIF1bxwQ7XEIB0EO18Lgdi7O9X66PZGKAgAAyjYCAAVIkAIAATGEAgAAE0wCAAARbAIAABeyAgAA1tgA=
Date:   Fri, 6 Jan 2023 14:45:22 +0000
Message-ID: <967b0ccdb8342d3405b415df7814ddcf49c28a17.camel@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
         <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
         <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
         <Y7aejeHDpLlwwYbr@zn.tnic>
         <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
         <Y7f6RhF8FuK9R399@zn.tnic> <Y7f+UqN5qqfJUeoy@gmail.com>
         <Y7gB+uVpSJAQ6p+9@zn.tnic> <Y7gG8R8ZRWTXYSGq@gmail.com>
In-Reply-To: <Y7gG8R8ZRWTXYSGq@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB8063:EE_
x-ms-office365-filtering-correlation-id: eea0324c-b30c-4e7c-8188-08daeff4a3b4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uKmU/Zzru9aE5BGsjOpz6IIKke/LMyssW3bMFokEs2PgwFn2KL613+mVpuAqHq4rWdeTfucXwO7y2tfuhYoOUddBOmi4c/Vv7U9lChOZcsqX8HoyP4W8/Orh5V99MebnJevYiXev5iLLyPHrIhekg1jHTz3aSJPTfyPRr0KaoPZT0ke8Jh6cdDbNATZYKhm1JC93WPZlNNTB+y1IrCwkv2IYrlAtREBmX4jsjJF7X4eO65pyvW1G/zxM4HpmhTwckVOhoB0MuOs7/WdfHHL/gczeFoSFFmlimGebEI4cDxXPH8Jt134BgUGZ11U6zSmn2SPDu/kSTo9fywMRR6shueHa4ga2qZ+T1j2qlb0jlrvb0WteG/5XYuUCWhJ+lrkCzcH5JXAzbLVV+LdDpSzMsq+SmFyv+U3sshUR+Pd7Ra4FvVuzhCQWQVhsYIG1w0JEr4TncueQ3uOv1wmUr7x/cyDAiz0A+6S3mX+/fvhUC0tg2v02dUmpSQiyA5iDaa5aWF3lakYBdyNf4vfKjmhuDqufMzVWbJ671CrzRYCQHQygyGHVPABGQenTJ/kTCCeTdJ8/uk455eQg80G7aWqOXlEyblDqLpSsC0N1Le49bdcpTdsc8JxKvCSVEbyP8znRdbn2sKPB3lZKnkM3xtEu+YBqGyYRQ2yjqTl9FRQyRj3wsGOdhrvFhHdzWKzGDGKTwwhDb+lgJA0g5M2kZxbdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(91956017)(66556008)(8676002)(66946007)(4326008)(66446008)(8936002)(64756008)(66476007)(7416002)(5660300002)(2906002)(41300700001)(54906003)(110136005)(316002)(76116006)(6506007)(6486002)(478600001)(71200400001)(186003)(26005)(6512007)(2616005)(36756003)(38100700002)(122000001)(82960400001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ujg4TStXN2tFZWtnMER0QW13bG1sRGRMNTA2bzk0NTExcUExNk1kWURDZEtk?=
 =?utf-8?B?cmk2dVJWRXlOdFhKWGhkZGRCNW5SZzBldlUyMHdCV1lNdkpPUlg0VklndUlt?=
 =?utf-8?B?bk96WUR6YitNSnJxaDdmZXJHdTdSV28ralBFRUFpTU9OMzFRa3loMmNVS1dT?=
 =?utf-8?B?MlFoaC9lbmJ1a1BqN096U0tUVFE5UFJwakF6dlRhY21JTjdibmJrT3hCUjgx?=
 =?utf-8?B?MWZaRDlxYjFtS3lNdHNOOFVTSkxFWDVuMGduWk9ueTVja09BL2tFWnU3c0N4?=
 =?utf-8?B?N1dBdmF5R05ob3lqWUFVZWNCRVdmOWVCMTJFS3ZWbU5qNGJ2M2hsMTFFTTVi?=
 =?utf-8?B?Zy9zWFB0a2pDTEZLdTNLVEFjbi9pcXdUd3VxNk9iRXJXL0U5S1FyUUlxbGZD?=
 =?utf-8?B?TlhiSGFvNWplYSs2cTBNL3pjcFBMVXU2U2lxaUo0TTRpUEFDcitYazF4dlRx?=
 =?utf-8?B?MklaajdSUEkwcXhzclpaOUZ1eWhkTnFpYTl3OFVKOWFEaDNWczM2M2gzejNh?=
 =?utf-8?B?V251VGFsZnRVUWpnMXFLaDJJd1UrOEd2ZmhhT2JtMTVBU0NIWkZnRUkzVnZz?=
 =?utf-8?B?UHVZdXp1di80UDljbVo1c1dBeFRQMGdMZ0VNNmFYSjc5SE56RWF2SERiZk5D?=
 =?utf-8?B?TFpiOURCd09Jd1laa0dHMUF4Uzc4dlc0ZlpNNnJDWWhwWDZseWVjVlIwdW9n?=
 =?utf-8?B?T2VYbXdXUG52Z0xtYURYbExpMzNKYWZVOEJISkcwdXRvOGJoV0ZBd3VoNk5J?=
 =?utf-8?B?Ulk2TG5zcVdCS2FPQTIxSDJhdDJ3YzFUeGE2TWNoU2VhK0poZnduOHJZVlY0?=
 =?utf-8?B?NTFZaTBGeHp5aTQxUWZ3dUxlT1JEYm9VcUFhbndySTQzd0Qvd3lvblduSDhK?=
 =?utf-8?B?UHJlbGtQSVhBWmNuOG9nREpjVjYvekh2bSt0dUQ1cjhDMHlEUDQ0YjdvQ1Ft?=
 =?utf-8?B?S3hqc25MKzg4ajM2RWRjSSs2aEFpTmRpMTRDekYyZkFkVll6RGNYT2dYUG8z?=
 =?utf-8?B?ZGdWaHlLbjl4c1UxMzZ0VU1QNjRUWGU0L1lxdTIzaFQwOUFoQW9qVjYrd0Yv?=
 =?utf-8?B?ZWVpdktmdCtJL3pYZU44aHZ3SlhCZ25sQWI4Ym5SNEV6dy81S2E3TzRIWmQv?=
 =?utf-8?B?R0FsdnkxaUNwazh0UGRYN2RXOGNkWlpCS0tRVUErKzlneURVdlRKYTUyRk4z?=
 =?utf-8?B?VUptUG01RjVqVTB5RlZ4K0JSZS92aDlZZFU2T1VkQ1drZStHMDI2U1g2Njhi?=
 =?utf-8?B?YjY5b0lDbUYydjFvVnNRT1lFVE5NMGtaVlFCS2Z6STY0czkrTzR5UTJ0UlhL?=
 =?utf-8?B?QkJacTF6MTk1OGlXRjdtaGdVN0k4dUN1c2xqWGJ5UEdscFVwQWN2L2RyOFB0?=
 =?utf-8?B?QjVPakNvUFAvUEFON1BNRzBjSDdsRVYwaENwaG9NNVpNaE84M0JNYmpyaEJB?=
 =?utf-8?B?UHFVVXhpWXZ4K3ZkU3RtSzYrNC94UDl0QVFqbFhHQWJsWG9IUW9UcGxNeUNm?=
 =?utf-8?B?YSt0bjcwRjBwYlE0N1BSV3g2V1ZsVU5MRjRHcmo0RFh0Wm95Mk5Mb01IeUhx?=
 =?utf-8?B?eWd1dVdYQk53Ni9waksrdVcvZWEwaTBZVkVuempDZEdnTG02c0x3WjNHUjQ5?=
 =?utf-8?B?SmppSkZBamJWc2tlYXRwSGVPeDdHOWNEVkNubCtRSHgxZkFxWjlBNFVuT1h4?=
 =?utf-8?B?U2tmWE5NMStqV21VRlUydnRDekJ5OGpiRzkyZ29qWDc0a1EyT0F2MWM1Y3l3?=
 =?utf-8?B?cmpBc2tYd00rUE5JYnNrTUJTZ2dEZGQwR2trOTNyV2FSSkpKTnc3czJNNTFT?=
 =?utf-8?B?UE9zaHp6YXV0eXFkR3pBbTl4Wmp0aHMvcmJmaWsxc1o1U2MyTUlLUWQ1MHBO?=
 =?utf-8?B?N0JJMTlNRFhpNWdJT3FIc0NkMTRHUnQ0Vkg3Wm1kUUFiSW9rUTcwZ2hkbU5y?=
 =?utf-8?B?K24zRXo1OWVYWEhyd3JhQ1ZsOE9uL051emxFRElqMUpEUXlkK2J3d3Q0NSs0?=
 =?utf-8?B?YXNKc0djdFpnazIwWXJDY0xURit4WWI4bjJjYnRmakZiaG5JZ1N5bVRmbVFv?=
 =?utf-8?B?STZTeGRmN3FkMTg5TmJhRjM4ZUUwckk2VmhQNHB0UU4yN3RaYy9pUnI0dk1L?=
 =?utf-8?B?bWlHUkdBVXpSWW9rbnpraEVrakd5N3BZZ3lWbFZqekJqZE4xOW1JTkVSc1la?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10C9CD5DFD8AA74DA3D5DC31FB762207@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0324c-b30c-4e7c-8188-08daeff4a3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 14:45:22.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OxYhA3Ap5UuXKquXNxNLkg/4qPQ10DMHK9eEPEwXdo0iZG5W4gR4WeDnT6soSJQc2SFZ/AmUm00NnNIzk/L9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDEyOjMzICswMTAwLCBJbmdvIE1vbG5hciB3cm90ZToNCj4g
KiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3JvdGU6DQo+IA0KPiA+IE9uIEZyaSwg
SmFuIDA2LCAyMDIzIGF0IDExOjU2OjE4QU0gKzAxMDAsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiA+
ID4gSXQncyBhIHRyYWRlLW9mZiBpbiBhbnkgY2FzZTogdGhlcmUncyBhIHBvaW50IHdoZXJlIHF1
aXJrIGZsYWdzDQo+ID4gPiBvciBldmVuIA0KPiA+ID4gZmVhdHVyZSBmbGFncyBiZWNvbWUgaGFy
ZGVyIHRvIHJlYWQgYW5kIGhhcmRlciB0byBtYWludGFpbiB0aGFuDQo+ID4gPiBjbGVhbmx5IA0K
PiA+ID4gc2VwYXJhdGVkIHBlciBtb2RlbCBkcml2ZXIgZnVuY3Rpb25zLg0KPiA+IA0KPiA+IFll
YWgsIG5vLCBzaW5ndWxhcjogYSBzeW50aGV0aWMgZmVhdHVyZSAqZmxhZyo6IFg4Nl9GRUFUVVJF
X1JBUEwuDQo+ID4gDQo+ID4gY3B1L2ludGVsLmMgY2FuIHNldCBpdCBhbmQgZHJpdmVyIGNhbiB0
ZXN0IGl0Lg0KPiA+IA0KPiA+IEV2ZXJ5dGhpbmcgZWxzZSBpbnNpZGUgdGhlIGRyaXZlci4NCj4g
PiANCj4gPiBVbnRpbCBJbnRlbCBjYW4gZ2V0IHRoZWlyIGFjdCB0b2dldGhlciBhbmQgYWN0dWFs
bHkgZG8gYSBDUFVJRCBiaXQNCj4gPiBsaWtlIEFNRC4gOi1QDQo+ID4gDQo+ID4gQnV0IHdoZW4g
eW91IHRoaW5rIGFib3V0IGl0LCB3aGV0aGVyIHRoZSBtb2RlbCBtYXRjaGluZyBoYXBwZW5zIGlu
DQo+ID4gdGhlIGRyaXZlciBvcg0KPiA+IGluIGNwdS9pbnRlbC5jIGRvZXNuJ3QgbWF0dGVyIGEg
d2hvbGUgbG90Lg0KPiA+IA0KPiA+IEFsbCB0aGF0IG1hdHRlcnMgaXMsIHRoZXkgc2hvdWxkIGZp
bmFsbHkgZ2l2ZSBpdCBhIENQVUlEIGJpdC4NCj4gDQo+IFRoZSBvdGhlciB0aGluZyB0aGF0IG1h
dHRlcnMgaGVyZSBhcmUgdGhlIFJBUEwgKmluY29tcGF0aWJpbGl0aWVzKg0KPiBiZXR3ZWVuIA0K
PiBtb2RlbCB2YXJpYW50cywgd2hpY2ggYXJlIHNpZ25pZmljYW50IEFGQUlDUy4NCj4gDQo+IFdp
dGggYSBDUFVJRCB3ZSBnZXQgYSBraW5kIG9mIHNlbWktY29tcGF0aWJsZSBoYXJkd2FyZSBpbnRl
cmZhY2Ugd2l0aA0KPiB3ZWxsIA0KPiBkZWZpbmVkIHNlbWFudGljcyAmIGV4cGFuc2lvbi4NCg0K
QWdyZWVkLg0KPiANCj4gV2l0aCAnbm9uLWFyY2hpdGVjdHVyYWwnLCBwZXItbW9kZWwgUkFQTCBm
ZWF0dXJlcyB3ZSBnZXQgdmVyeSBsaXR0bGUNCj4gb2YgDQo+IHRoYXQuLi4NCg0KRXhhY3RseS4N
Cg0KVGhlIG1haW4gcHVycG9zZSBvZiB0aGUgbW9kZWwgbGlzdCBpbiBSQVBMIFBNVSBjb2RlIGFu
ZCB0aGUgaW50ZWxfcmFwbA0KZHJpdmVyIGlzIHRvIGRpZmZlcmVudGlhdGUgdGhlIG1vZGVsLXNw
ZWNpZmljIGJlaGF2aW9yLCBzYXksDQpzb21lIG1vZGVscyB1c2Ugc3RhbmRhcmQgZW5lcmd5IHVu
aXQgcmV0cmlldmVkIGZyb20gTVNSDQpzb21lIG1vZGVscyB1c2UgYSBmaXhlZCBlbmVyZ3kgdW5p
dCBmb3IgRHJhbSBEb21haW4NCmFuZA0Kc29tZSBtb2RlbHMgdXNlIGEgZml4ZWQgZW5lcmd5IHVu
aXQgZm9yIFBzeXMgRG9tYWluDQpldGMuDQoNCj4gDQo+IFdoaWNoIGlzIHdoeSBpdCdzIGEgdHJh
ZGUtb2ZmIHRoYXQgaXMgaGFyZCB0byBqdWRnZSBpbiBhZHZhbmNlOiBtYXliZQ0KPiB3ZSANCj4g
Y2FuIHNpbXBsaWZ5IHRoZSBjb2RlIHZpYSBhIHN5bnRoZXRoaWMgQ1BVSURbc10sIG1heWJlIGl0
IHdpbGwganVzdA0KPiBiZSANCj4gYW5vdGhlciB6b28gb2YgcGVyLW1vZGVsIGZlYXR1cmUgZmxh
Z3MuLi4NCg0KQWdyZWVkLg0KDQo+IExpa2VseSB3b24ndCBiZSBhYmxlIHRvIHRlbGwgZm9yIHN1
cmUgdW50aWwgd2Ugc2VlIHBhdGNoZXMuDQo+IA0KWWVhaCwgbGV0IG1lIGNvb2sgdXAgYSBSRkMg
c2VyaWVzIGxhdGVyIGFuZCB3ZSBjYW4gY29udGludWUgd2l0aCB0aGF0Lg0KDQp0aGFua3MsDQpy
dWkNCg==
