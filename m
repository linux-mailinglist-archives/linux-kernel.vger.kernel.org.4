Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB37355AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjFSLYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFSLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:24:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB72102;
        Mon, 19 Jun 2023 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687173839; x=1718709839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tZogVolwKV8yOEPwplu6iOUiCg8/oEa0KMFJ9+IdEZg=;
  b=DQl9p4/eWJRb5yEyQHTIPpNtgBbjY9C1RI4KAbzfE1XYGkMGl48BefIb
   XYkw2bysgAe7sdW11Mn368lW6qqHd35W19Jb3VnPPeUIjEZFPH2A6yzbG
   blGzG4Z5iZKF3IeF1RQ/Bq+LJliKsyCl+YltZh89Wp2//8QvkEUMDhOmU
   1MQA/Hlitj4+qONS/R8i0mtLDb6zAELSuVy1kCbIKaI54LmPW3cKFYfBL
   bmR+l0kP1GT8Au+nWuXHtDj9oqaUiLSlC2ALSXckI9vLTDmrzHPUQGUxV
   KjcJiUQwkBEcZvJPO1wRtFjpcp0rgYhtBd9sx/K4EeLsp2viBHbKHXtw3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="362144214"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="362144214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 04:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="783674346"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="783674346"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2023 04:23:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 04:23:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 04:23:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 04:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShYJh7We8YXJzy7x+2P8hBUN2DHw8ND4aZW+tBERROLqsFLyNpAtfQoPxH350ha/aZzYaW6xOIBrkgk35aGDlAqlOpyJ3xWUCGYgUuIjaekUZ24cuXdOZ7Xf348kD9qPNLq7vTG+3suQhDzBIc4aoEajKzVHvtp5IFHss9u93sZ6Udwllb0C9ad27eyTX4oOE5q8Q8ouN9irXAE/QSiILjKUgpsXVdDlNKKYwd+lf4qCMAYT/LIIewTShxA6W4TsDd7Ky/on64nNyVb8AiTM92wV/yFiSd4iGOaiby9lWsiVmiyAPawDMjqCewA6ekgUu4RqS+VXnFtzjDgjxVF5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZogVolwKV8yOEPwplu6iOUiCg8/oEa0KMFJ9+IdEZg=;
 b=mZBPppR7ryGmqr1DN8pFConkG6ikWYY3tfbQsP5KHZ40MOs+X900nqH8zNQxOIMa/ABDvgDRt2rn3un0xfDupMPu8mMMurzl/VuHpACqmO5e/QmQjIa+RhXFmConv3S9qd4VrWK3zSmIk12xZhiZ6y6QBtcthdEV9R9d/BJxjWsILzz1x70P/nJpk626lQNGZNeJCLUHnaw5Fu0sjBjiXMXTGXnmu8prxLS/U4bjF9Q8dtEiy9gWDiD4fK1JSLpvoGocVEulbPpOTmkDZ3SH2ImgBJ/TgWpuUJeS/ZBpQjxCHhzan13hgzA7XVKVx5VPa/i40XNlRMDZV14dX+8LPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH0PR11MB4823.namprd11.prod.outlook.com (2603:10b6:510:43::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 11:23:53 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::da07:d06e:a4ca:6d24]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::da07:d06e:a4ca:6d24%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 11:23:53 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Dmytro Maluka <dmy@semihalf.com>,
        "Christopherson,, Sean" <seanjc@google.com>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        Larry Dewey <larry.dewey@amd.com>,
        "android-kvm@google.com" <android-kvm@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Allen Webb <allenwebb@google.com>,
        "Tomasz Nowicki" <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
Subject: RE: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Thread-Topic: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Thread-Index: AQHZnU2j++oR5Nh9vEmr05LOPnMSQ6+I9zcAgADlQLCAAH5eAIADCPGAgAAWQ4CAABq3AIAAK5YAgAGLfYCAArbI8A==
Date:   Mon, 19 Jun 2023 11:23:53 +0000
Message-ID: <DM8PR11MB5750F226997913CC1A0E54A4E75FA@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com>
 <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZInLlkXsgnej9ZpT@google.com>
 <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
 <ZIxqAXhy1tCVpzz7@google.com>
 <22438996-cea6-fcdc-530b-bf3f2477a81c@semihalf.com>
 <ZIyk+qIBRD6ezlPo@google.com>
 <10b6045e-e5e4-e1f6-f93a-34f1ad61fdfe@semihalf.com>
In-Reply-To: <10b6045e-e5e4-e1f6-f93a-34f1ad61fdfe@semihalf.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH0PR11MB4823:EE_
x-ms-office365-filtering-correlation-id: a6a27a79-4af0-44eb-d2a6-08db70b7a9ac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57IefKH5w5S69WSZaxwlhRK5nH6cTGKIm/PRpL7UhmQvUjb/exj5thWDV+606UO3GsR2VKYbf7DB78Fmhaz4fsB3I5Zbpba9HT/73IoVra2WNi2KLKpRwpqMx6F8oIb2bG0czEIVroFKd2t0wGMnt7SJWbmvwYpaAWfZMJ1Zo+NzfMm0vcIn5DtLHriEFU9KtUHmPtnoKMFZT4dM7QAEuiepuo8X1cKreGW5kpFLD7JdF/2E+/6r7I7bW2+/hrZLOMVO5Hq4yu6LIdI9IiZxYiIpugs63lwhDCQcpt62aijQgnzPGen7giKfKiJn98ZHcPyZEGgFw9opNOAnvkFoaUtfZgtr1vTZ958ydrTtqo7zP6BH7C0o+pRY4QXfPFgBURJAzQTJ1mtY00Bi5GJVToJlqrtkSmITVXVvvsP+qNLfoe6GJmUVqqJxbKllKTrc8z+vh06TS31KRQXzMKCRlY5ARKnV/nnSAZ43xrs+15l+3G/5ky24F+Nt37E/dVI9dZAAgY0e+WTIJDDg8IYF91b4JVXQn1vmKiVtZ5NYd6ajM9l/28eVHnTpovqpAo4D8hDj/1z41acHBjDcZ059i1UV0BtmDQqUxhA4KC3YdHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(53546011)(7416002)(66946007)(7406005)(8936002)(8676002)(66556008)(64756008)(76116006)(66446008)(66476007)(38070700005)(26005)(186003)(6506007)(9686003)(82960400001)(83380400001)(41300700001)(38100700002)(5660300002)(4326008)(316002)(52536014)(54906003)(966005)(7696005)(55016003)(478600001)(2906002)(33656002)(122000001)(71200400001)(86362001)(110136005)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXhxa29lUGlkTTVmc2lpdTMvMkhFakg4blViWCt5WXVwemlOeXF0aERyZzEv?=
 =?utf-8?B?a3h6SExsUG9XNjQ0ODdpM0ZYSjJuRmRIdG9ZUS9wMTB2bDVZb1RwRG5FbmJD?=
 =?utf-8?B?cmN2cDZhTkFBQ2NscEhyb24vbmJMdVEyTzJ2b2FjcVBkODVMM1lwS1dXMXV6?=
 =?utf-8?B?QUFjQmRoMStkZkZ2WDRzcURCS1RGRFRGRnJQdXRrV3VCclQrNDdNemZjbnM4?=
 =?utf-8?B?OGFhbmhmN2Y5Qm5nYkFKZk8wN0JxYWJ1Qm5SamVCVTFnendMUHRMcVozc3l0?=
 =?utf-8?B?Ymc4ZVpYelRzZkJrQmhmK3JtUGdoc0VzYkdvK1NVV0NFdVdOcS8yM3h3ajc5?=
 =?utf-8?B?YnRtR0J2TUp2RlRFeUk1ZEE1b1VpNThTUU1pUWtYZWtISituRDFzeVhVK0FN?=
 =?utf-8?B?RlBqYkJ3Q3ViVERXRGw4bStTaDRaMEwybHk4eWh4OVBEcStham9xcTI1Y054?=
 =?utf-8?B?NkowaHdISmtMZUt5cHBrVGFaeVA0NENJRWIrTWllOVcranJMMmduRkNpL0VJ?=
 =?utf-8?B?VGI0cWV3YTNoUlMxQVhLVkhHbnltQS85K1M3c3NFNGFLU011VWN6anJudG1l?=
 =?utf-8?B?QW90L0prcUx4YTJnaTF4c0ZIaTdiaWtxS09yaFBHSHVBQ3dvUVJNYkMyRDNm?=
 =?utf-8?B?UkdWeXRabURlMTdOeGozRm5jRERUQmNaTm43akkvbXNNZURRaGQzMzZLV2FV?=
 =?utf-8?B?aXZCOW9OTndzL0xVRnhMUnpRajRRblNhdm02MEdGT2hGaFVyWHVoQzhaUjly?=
 =?utf-8?B?TTJMY0Y3ZTdkbktvNWZUby9iLzhqam9xZGJ5bjlTYS8wVFkzZGlUMnM1VCs1?=
 =?utf-8?B?TGRITFlpK1dCbjQ5d0NZanNTNm5oM29Kb0x3am9qZFZWdXFQcEhUVHpMUTRq?=
 =?utf-8?B?QXlRaWY3cmVsUjZLeGxoQnFobG1VcFlJbnVvU25Sc0UwbGxRQmNlTnl3dmFr?=
 =?utf-8?B?aHFyWnlnSjNSWWIyOEVieWVibVU1WUVkY2JBQlZFcXZTSjdIdDlZMlRBbFlY?=
 =?utf-8?B?b214RjRIdE9NWXpmKzZURFl5YlBGZFhCREEvS3d5OFIraFdudXoxUXlUdTVX?=
 =?utf-8?B?bjhkaW1HRFhtWmYvckdURzZQaFlQem5lS0RmYmlxU2x4ZDBOUUpFZGEva2hE?=
 =?utf-8?B?SVpHWVA4VzlmQmVQajhFQ2lndURVdXdUZ3JhVmtuM1RDaVo0dnZqVTlMYnFh?=
 =?utf-8?B?ZXM3R3dnTWJ3TUJ2cXE4aTZsa1Q5YjUyZllTS3lPMkljdFlQb1FOSUh1U0xN?=
 =?utf-8?B?S1k3aFlxSWJPTFpvL2FWUU1JL2Q0TjZkNC96dHZzc0dySlB1SE1QdWs1cDRn?=
 =?utf-8?B?VEFLQks4WmVoS1VaWXZFSzN6UGkyNG5yKy8vQ0hVOUJiM05rWEdJb1BDdElR?=
 =?utf-8?B?d25ZNVhEV3h4TFBMRlFOZlZrUHA2Ym1VZlF5Z3FUdnNBYkgxQzJ1OXVSL3hw?=
 =?utf-8?B?YWJ1eGxUeEUxTFJWU3d0cXhRUzFmeGNhWEZhbTFDVW45VFYrY21QaTdaZjJv?=
 =?utf-8?B?c0pQeWhMTjBJc2VCUVVBcDNTbXlEejlRcVlkYU1JUWRLQkJQOURaTjg4b3N4?=
 =?utf-8?B?QW5USWs5YVBvVGFFSS9sa3BpVUNvdnVOSkRBU2tmMjNiTlY4c3ZkcGp6bGZS?=
 =?utf-8?B?b3ZEWE9hNmJWdWY0NHNKMk5RQlUvaVZSQkhXRElJUUJkLzlXaU9YOXRBekdS?=
 =?utf-8?B?aXhOWmdvejBTemJKV0dUOC9relhxdkV0KzZvZ3gycFhmRTJOOWpOZ2NyTGFT?=
 =?utf-8?B?ZkFQQmNBNG9xVzZWK0s1c3RwUjMySTVhZUpha2FJdnlZYUJIOUQvYkdXR3VD?=
 =?utf-8?B?K1BPemRjbmc5bFF2VVBhOU9Fbzl5UUoybkcyWkhzbUlMTmJIUXlzZWV1ZjBP?=
 =?utf-8?B?bnhyR3hhOUZ6YzZEQTN5RVA5aTZ0VGJ2RGlQbTQ3KzFKRFh0ZDRFQm1JL05m?=
 =?utf-8?B?dEFtd2k2OUhyRzlETUN4WFpEQmkyMmtsT1hmR0lDTjlicjVGbjJYOVlPVjln?=
 =?utf-8?B?cXEvMnA1VlBBNThXK3Qwc3Y0VWZ0cGJpRlEwUCt2MG5XUlJaT2NYQk92Mnhx?=
 =?utf-8?B?VkRiZVJMN25WUGMrbUlEVVE2ODBzOUlIOTVJLzlsMWxEUWFKd2ZWak9Jalo4?=
 =?utf-8?Q?YC6CuHraw6S6Dm12t7eEaVkAl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a27a79-4af0-44eb-d2a6-08db70b7a9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 11:23:53.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1/vtp8aVFf9PmU7r6pQ0az9t88q6QLys4MCY5vxY84QY6f8hmmuqir2BAoJISBPU+P3m+mhkgzCb+LaxBeO0SLR6w7cjhB4g5CgTzEhLlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA2LzE2LzIzIDIwOjA3LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPiA+IE9uIEZy
aSwgSnVuIDE2LCAyMDIzLCBEbXl0cm8gTWFsdWthIHdyb3RlOg0KPiA+PiBPbiA2LzE2LzIzIDE1
OjU2LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPiA+Pj4gT24gRnJpLCBKdW4gMTYsIDIw
MjMsIERteXRybyBNYWx1a2Egd3JvdGU6DQo+ID4+Pj4gQWdhaW4sIHBlZGFudGljIG1vZGUgb24s
IEkgZmluZCBpdCBkaWZmaWN1bHQgdG8gYWdyZWUgd2l0aCB0aGUgd29yZGluZw0KPiA+Pj4+IHRo
YXQgdGhlIGd1ZXN0IG93bnMgIm1vc3Qgb2YiIHRoZSBIVyByZXNvdXJjZXMgaXQgdXNlcy4gSXQg
Y29udHJvbHMgdGhlDQo+ID4+Pj4gZGF0YSBjb21tdW5pY2F0aW9uIHdpdGggaXRzIGhhcmR3YXJl
IGRldmljZSwgYnV0IG90aGVyIHJlc291cmNlcyAoZS5nLg0KPiA+Pj4+IENQVSB0aW1lLCBpbnRl
cnJ1cHRzLCB0aW1lcnMsIFBDSSBjb25maWcgc3BhY2UsIEFDUEkpIGFyZSBvd25lZCBieSB0aGUN
Cj4gPj4+PiBob3N0IGFuZCB2aXJ0dWFsaXplZCBieSBpdCBmb3IgdGhlIGd1ZXN0Lg0KPiA+Pj4N
Cj4gPj4+IEkgd2Fzbid0IHNheWluZyB0aGF0IHRoZSBndWVzdCBvd25zIG1vc3QgcmVzb3VyY2Vz
LCBJIHdhcyBzYXlpbmcgdGhhdCB0aGUNCj4gKnVudHJ1c3RlZCoNCj4gPj4+IGhvc3QgZG9lcyAq
bm90KiBvd24gbW9zdCByZXNvdXJjZXMgdGhhdCBhcmUgZXhwb3NlZCB0byB0aGUgZ3Vlc3QuICBN
eQ0KPiB1bmRlcnN0YW5kaW5nDQo+ID4+PiBpcyB0aGF0IGV2ZXJ5dGhpbmcgaW4geW91ciBsaXN0
IGlzIG93bmVkIGJ5IHRoZSB0cnVzdGVkIGh5cGVydmlzb3IgaW4gdGhlIHBLVk0NCj4gbW9kZWwu
DQo+ID4+DQo+ID4+IEhlaCwgbm8uIE1vc3Qgb2YgdGhlc2UgcmVzb3VyY2VzIGFyZSBvd25lZCBi
eSB0aGUgdW50cnVzdGVkIGhvc3QsIHRoYXQncw0KPiA+PiB0aGUgcG9pbnQuDQo+ID4NCj4gPiBB
aCwgSSB3YXMgb3ZlcmxvYWRpbmcgIm93bmVkIiwgcHJvYmFibHkgd3JvbmdseS4gIFdoYXQgSSdt
IHRyeWluZyB0byBjYWxsIG91dCBpcw0KPiA+IHRoYXQgaW4gcEtWTSwgd2hpbGUgdGhlIHVudHJ1
c3RlZCBob3N0IGNhbiB3aXRob2xkIHJlc291cmNlcywgaXQgY2FuJ3Qgc3VidmVydA0KPiA+IG1v
c3Qgb2YgdGhvc2UgcmVzb3VyY2VzLiAgVGFraW5nIHNjaGVkdWxpbmcgYXMgYW4gZXhhbXBsZSwg
YSBwS1ZNIHZDUFUgbWF5DQo+IGJlDQo+ID4gbWlncmF0ZWQgdG8gYSBkaWZmZXJlbnQgcENQVSBi
eSB0aGUgdW50cnVzdGVkIGhvc3QsIGJ1dCBwS1ZNIGVuc3VyZXMgdGhhdCBpdCBpcw0KPiA+IHNh
ZmUgdG8gcnVuIG9uIHRoZSBuZXcgcENQVSwgZS5nLiBvbiBJbnRlbCwgcEtWTSAocHJlc3VtYWJs
eSkgZG9lcyBhbnkNCj4gbmVjZXNzYXJ5DQo+ID4gVk1DTEVBUiwgSUJQQiwgSU5WRVBULCBldGMu
IHRvIGVuc3VyZSB0aGUgdkNQVSBkb2Vzbid0IGNvbnN1bWUgc3RhbGUgZGF0YS4NCj4gDQo+IFll
cCwgYWdyZWUuDQo+IA0KPiA+PiBCYXNpY2FsbHkgZm9yIHR3byByZWFzb25zOiAxLiB3ZSB3YW50
IHRvIGtlZXAgdGhlIHRydXN0ZWQgaHlwZXJ2aXNvciBhcw0KPiA+PiBzaW1wbGUgYXMgcG9zc2li
bGUuIDIuIHdlIGRvbid0IG5lZWQgYXZhaWxhYmlsaXR5IGd1YXJhbnRlZXMuDQo+ID4+DQo+ID4+
IFRoZSB0cnVzdGVkIGh5cGVydmlzb3Igb3ducyBvbmx5OiAybmQtc3RhZ2UgTU1VLCBJT01NVSwg
Vk1DUyAob3IgaXRzDQo+ID4+IGNvdW50ZXJwYXJ0cyBvbiBub24tSW50ZWwpLCBwaHlzaWNhbCBQ
Q0kgY29uZmlnIHNwYWNlIChtZXJlbHkgZm9yDQo+ID4+IGNvbnRyb2xsaW5nIGEgZmV3IGNyaXRp
Y2FsIHJlZ2lzdGVycyBsaWtlIEJBUnMgYW5kIE1TSSBhZGRyZXNzDQo+ID4+IHJlZ2lzdGVycyks
IHBlcmhhcHMgYSBmZXcgbW9yZSB0aGluZ3MgdGhhdCBkb24ndCBjb21lIHRvIG15IG1pbmQgbm93
Lg0KPiA+DQo+ID4gVGhlICJwaHlzaWNhbCBQQ0kgY29uZmlnIHNwYWNlIiBpcyBhIGtleSBkaWZm
ZXJlbmNlLCBhbmQgaXMgdmVyeSByZWxldmFudCB0byB0aGlzDQo+ID4gZG9jIChzZWUgbXkgcmVz
cG9uc2UgdG8gQWxsZW4pLg0KPiANCj4gWWVhaCwgdGhhbmtzIGZvciB0aGUgbGlua3MgYW5kIHRo
ZSBjb250ZXh0LCBCVFcuDQo+IA0KPiBCdXQgbGV0IG1lIGNsYXJpZnkgdGhhdCB3ZSBoYXZlIDIg
dGhpbmdzIGhlcmUgdGhhdCBzaG91bGQgbm90IGJlDQo+IGNvbmZ1c2VkIHdpdGggZWFjaCBvdGhl
ci4gV2UgaGF2ZSAyIGxldmVscyBvZiB2aXJ0dWFsaXphdGlvbiBvZiB0aGUgUENJDQo+IGNvbmZp
ZyBzcGFjZSBpbiBwS1ZNLiBUaGUgaHlwZXJ2aXNvciB0cmFwcyB0aGUgaG9zdCdzIGFjY2Vzc2Vz
IHRvIHRoZQ0KPiBjb25maWcgc3BhY2UsIGJ1dCBtb3N0bHkgaXQgc2ltcGx5IHBhc3NlcyB0aGVt
IHRocm91Z2ggdG8gaGFyZHdhcmUuIE1vc3QNCj4gaW1wb3J0YW50bHksIHdoZW4gdGhlIGhvc3Qg
cmVwcm9ncmFtcyBhIEJBUiwgdGhlIGh5cGVydmlzb3IgbWFrZXMgc3VyZQ0KPiB0byB1cGRhdGUg
dGhlIGNvcnJlc3BvbmRpbmcgTU1JTyBtYXBwaW5ncyBpbiB0aGUgaG9zdCdzIGFuZCB0aGUgZ3Vl
c3Qncw0KPiAybmQtbGV2ZWwgcGFnZSB0YWJsZXMgKHRoYXQgaXMgd2hhdCBtYWtlcyBwcm90ZWN0
aW9uIG9mIHRoZSBwcm90ZWN0ZWQNCj4gZ3Vlc3QncyBwYXNzdGhyb3VnaCBQQ0kgZGV2aWNlcyBw
b3NzaWJsZSBhdCBhbGwpLiBCdXQgZXNzZW50aWFsbHkgaXQncw0KPiB0aGUgaG9zdCB0aGF0IG1h
bmFnZXMgdGhlIHBoeXNpY2FsIGNvbmZpZyBzcGFjZS4gQW5kIHRoZSBob3N0LCBpbiB0dXJuLA0K
PiB2aXJ0dWFsaXplcyBpdCBmb3IgdGhlIGd1ZXN0LCB1c2luZyB2ZmlvLXBjaSwgbGlrZSBpdCBp
cyB0cmFkaXRpb25hbGx5DQo+IGRvbmUgZm9yIHBhc3N0aHJvdWdoIFBDSSBkZXZpY2VzLg0KPiAN
Cj4gVGhpcyBsYXR0ZXIsIGVtdWxhdGVkIGNvbmZpZyBzcGFjZSBpcyB0aGUgY29uY2Vybi4gTG9v
a2luZyBhdCB0aGUNCj4gcGF0Y2hlcyBbMV0gYW5kIHRoaW5raW5nIGlmIHRob3NlIE1TSS1YIG1p
c2NvbmZpZ3VyYXRpb24gYXR0YWNrcyBhcmUNCj4gcG9zc2libGUgaW4gcEtWTSwgSSBjb21lIHRv
IHRoZSBjb25jbHVzaW9uIHRoYXQgeWVzLCB0aGV5IGFyZS4NCj4gDQo+IERldmljZSBhdHRlc3Rh
dGlvbiBoZWxwcyB3aXRoIHRydXN0aW5nL3ZlcmlmeWluZyBzdGF0aWMgaW5mb3JtYXRpb24sIGJ1
dA0KPiB0aGUgZHluYW1pY2FsbHkgY2hhbmdpbmcgY29uZmlnIHNwYWNlIGlzIHNvbWV0aGluZyBk
aWZmZXJlbnQuDQo+IA0KPiBTbyBpdCBzZWVtcyB0aGF0IHN1Y2ggImVtdWxhdGVkIFBDSSBjb25m
aWcgbWlzY29uZmlndXJhdGlvbiBhdHRhY2tzIg0KPiBuZWVkIHRvIGJlIGluY2x1ZGVkIGluIHRo
ZSB0aHJlYXQgbW9kZWwgZm9yIHBLVk0gYXMgd2VsbCwgaS5lLiBuZWVkIHRvDQo+IGJlIGhhcmRl
bmVkIG9uIHRoZSBndWVzdCBzaWRlLiBVbmxlc3Mgd2UgcmV2aXNpdCBvdXIgY3VycmVudCBkZXNp
Z24NCj4gYXNzdW1wdGlvbnMgZm9yIGRldmljZSBhc3NpZ25tZW50IGluIHBLVk0gb24geDg2IGFu
ZCBtYW5hZ2UgdGhlIHBoeXNpY2FsDQo+IFBDSSBjb25maWcgaW4gdGhlIHRydXN0ZWQgaHlwZXJ2
aXNvciwgbm90IGluIHRoZSBob3N0ICh3aXRoIGFsbCB0aGUNCj4gaW5jcmVhc2luZyBjb21wbGV4
aXR5IHRoYXQgY29tZXMgd2l0aCB0aGF0LCByZWxhdGVkIHRvIHBvd2VyIG1hbmFnZW1lbnQNCj4g
YW5kIG90aGVyIHRoaW5ncykuDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIGNsYXJpZmljYXRp
b24gRG15dHJvIG9uIHRoaXMgYW5kIG1hbnkgb3RoZXIgDQpwb2ludHMgd2hlbiBpdCBjb21lcyB0
byBwS1ZNLiBJdCBkb2VzIGhlbHAgZ3JlYXRseSB0byBicmluZyB1cyBvbiB0aGUgc2FtZQ0KcGFn
ZS4gDQoNCj4gDQo+IEFsc28sIHRoaW5raW5nIG1vcmUgYWJvdXQgaXQ6IGlycmVzcGVjdGl2ZWx5
IG9mIHBhc3N0aHJvdWdoIGRldmljZXMsIEkNCj4gZ3Vlc3MgdGhhdCB0aGUgcHJvdGVjdGVkIHBL
Vk0gZ3Vlc3QgbWF5IHdlbGwgd2FudCB0byB1c2UgdmlydGlvIHdpdGggUENJDQo+IHRyYW5zcG9y
dCAobm90IGZvciB0aGluZ3MgbGlrZSBuZXR3b3JraW5nLCBidXQgdGhhdCdzIG5vdCB0aGUgcG9p
bnQpLA0KPiB0aHVzIGJlIHByb25lIHRvIHRoZSBzYW1lIGF0dGFja3MuDQo+IA0KPiA+PiBUaGUg
dW50cnVzdGVkIGhvc3Qgc2NoZWR1bGVzIGl0cyBndWVzdHMgb24gcGh5c2ljYWwgQ1BVcyAoaS5l
LiB0aGUNCj4gPj4gaG9zdCdzIEwxIHZDUFVzIGFyZSAxOjEgbWFwcGVkIG9udG8gcENQVXMpLCB3
aGlsZSB0aGUgdHJ1c3RlZCBoeXBlcnZpc29yDQo+ID4+IGhhcyBubyBzY2hlZHVsaW5nLCBpdCBv
bmx5IGhhbmRsZXMgdm1leGl0cyBmcm9tIHRoZSBob3N0IGFuZCBndWVzdHMuIFRoZQ0KPiA+PiB1
bnRydXN0ZWQgaG9zdCBmdWxseSBjb250cm9scyB0aGUgcGh5c2ljYWwgaW50ZXJydXB0IGNvbnRy
b2xsZXJzIChJDQo+ID4+IHRoaW5rIHdlIHJlYWxpemUgdGhhdCBpcyBub3QgcGVyZmVjdGx5IGZp
bmUsIGJ1dCBoZXJlIHdlIGFyZSksIGV0Yy4NCj4gPg0KPiA+IFllYWgsIElSUXMgYXJlIGEgdG91
Z2ggbnV0IHRvIGNyYWNrLg0KPiANCj4gQW5kIEJUVywgZG9lc24ndCBpdCBtZWFuIHRoYXQgaW50
ZXJydXB0cyBhbHNvIG5lZWQgdG8gYmUgaGFyZGVuZWQgaW4gdGhlDQo+IGd1ZXN0IChpZiB3ZSBk
b24ndCB3YW50IHRoZSBjb21wbGV4aXR5IG9mIGludGVycnVwdCBjb250cm9sbGVycyBpbiB0aGUN
Cj4gdHJ1c3RlZCBoeXBlcnZpc29yKT8gQXQgbGVhc3Qgc2Vuc2l0aXZlIG9uZXMgbGlrZSBJUElz
LCBidXQgSSBndWVzcyB3ZQ0KPiBzaG91bGQgYWxzbyBjb25zaWRlciBpbnRlcnJ1cHQtYmFzZWQg
dGltaW5ncyBhdHRhY2tzLCB3aGljaCBjb3VsZCB1c2UNCj4gYW55IHR5cGUgb2YgaW50ZXJydXB0
LiAoSSBoYXZlIG5vIGlkZWEgaG93IHRvIGhhcmRlbiBlaXRoZXIgb2YgdGhlIHR3bw0KPiBjYXNl
cywgYnV0IEknbSBubyBleHBlcnQuKQ0KDQpXZSBoYXZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgaXQg
YSBiaXQgYXQgbGVhc3Qgd2hlbiBpdCBjb21lcyB0byBvdXINClREWCBjYXNlLiBUd28gbWFpbiBp
c3N1ZXMgd2VyZSBpZGVudGlmaWVkOiBpbnRlcnJ1cHRzIGNvbnRyaWJ1dGluZw0KdG8gdGhlIHN0
YXRlIG9mIExpbnV4IFBSTkcgWzFdIGFuZCBwb3RlbnRpYWwgaW1wbGljYXRpb25zIG9mIG1pc3Np
bmcNCmludGVycnVwdHMgZm9yIHJlbGlhYmxlIHBhbmljIGFuZCBvdGhlciBrZXJuZWwgdXNlIGNh
c2VzIFsyXS4gDQoNClsxXSBodHRwczovL2ludGVsLmdpdGh1Yi5pby9jY2MtbGludXgtZ3Vlc3Qt
aGFyZGVuaW5nLWRvY3Mvc2VjdXJpdHktc3BlYy5odG1sI3JhbmRvbW5lc3MtaW5zaWRlLXRkeC1n
dWVzdA0KWzJdIGh0dHBzOi8vaW50ZWwuZ2l0aHViLmlvL2NjYy1saW51eC1ndWVzdC1oYXJkZW5p
bmctZG9jcy9zZWN1cml0eS1zcGVjLmh0bWwjcmVsaWFibGUtcGFuaWMNCg0KRm9yIHRoZSBmaXJz
dCBvbmUsIGluIGFkZGl0aW9uIHRvIHNpbXBseSBlbmZvcmNlIHVzYWdlIG9mIFJEU0VFRA0KZm9y
IFREWCBndWVzdHMsIHdlIHN0aWxsIHdhbnQgdG8gZG8gYSBwcm9wZXIgZXZhbHVhdGlvbiBvZiBz
ZWN1cml0eQ0Kb2YgTGludXggUFJORyB1bmRlciBvdXIgdGhyZWF0IG1vZGVsLiBUaGUgc2Vjb25k
IG9uZSBpcyANCmhhcmRlciB0byByZWxpYWJseSBhc3NlcyBpbW8sIGJ1dCBzbyBmYXIgd2Ugd2Vy
ZSBub3QgYWJsZSB0byBmaW5kIGFueQ0KY29uY3JldGUgYXR0YWNrIHZlY3RvcnMuIEJ1dCBpdCB3
b3VsZCBiZSBnb29kIGlmIHBlb3BsZSB3aG8gDQpoYXZlIGV4cGVydGlzZSBpbiB0aGlzLCBjb3Vs
ZCB0YWtlIGEgbG9vayBvbiB0aGUgYXNzZXNzbWVudCB3ZSBkaWQuIA0KVGhlIGxvZ2ljIHdhcyB0
byBnbyBvdmVyIGFsbCBrZXJuZWwgY29yZSBjYWxsZXJzIG9mIHZhcmlvdXMgDQpzbXBfY2FsbF9m
dW5jdGlvbiosIG9uX2VhY2hfY3B1KiBhbmQgY2hlY2sgdGhlIGltcGxpY2F0aW9ucw0KaWYgc3Vj
aCBhbiBJUEkgaXMgbmV2ZXIgZGVsaXZlcmVkLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuIA0K
