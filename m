Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F00621EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKHV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKHV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:56:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F463CCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667944607; x=1699480607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hhaiiR+GedxSCo1I8cpA50JiQj/CroHx3393C03eaok=;
  b=LPdnIv5hUjiViOc+vWBpjhvIn4hVORMwl9kX6zLIelY+dH24X0tBfio9
   bhUAVY600Sru6ECD3SXwzWyu7vVi6QE18FaLx9ZBD+8lZXAGIAVks1sVa
   MLWXwvAIVQb+YiwLQ8tI2K8H0iM1nvabw9SwqXBYUZ7cAzNOsXIxUDFK3
   HnzNZac8xUwZ/sMsvEmHKYOzJe2lFRdmK8rdv4rlfjEoIjfx16hmuIaQR
   q53rR8PyKN5lk65DbR8Bv8mNU0hTlrnIRb2uzjnP8uAvaqEjjb9KzVo2c
   gk+TYhZ396B15guwAhldHDQq5ibGILWAsbqIzF6+A8BOOO13fKeNy85IM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="372963088"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="372963088"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 13:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614431914"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="614431914"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 13:56:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 13:56:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 13:56:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 13:56:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzfuxlueAZZiEWcv3KmQf5Ln/iaes3Do97JtBGAHNsg0kIatmYU0qW8hVZuG+Cw4mth2cWu0zlMgj2G+mLd+MbiMcUx5EdEP1ddL+u11uFogjybMyYLowKVa+ZCEM/C/nw4Rnf80LOFY/LgAQU8AaIoR9CbG4Qhy0ua74LuyBZVK9XpfShXaJGR+GxI3IKVv4+gl2wjj68cAWrdAFLWxKwk/Sx0o6JITYv9bleOnqmJ4l3dj4Plqoep05STZ9i+QlBa9LgI0E8hWLEO8nlKQjiok4DQJldImr9E5epHRHKbZu+prolkp4mTtMqMFac4hHYwF+sjcDvPjhMJEVRPAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhaiiR+GedxSCo1I8cpA50JiQj/CroHx3393C03eaok=;
 b=ZUpzJt1x/BwkLA9xfCjaQYRQsrN+zUu5+SAWiShmVUbxgnz/1jEHbLKyqdhOdonwJ9oVCA+yygdTTBRkQPbAMtqcqQOMzALO7H8FQvfYUHXTNfnr1+eduKHx03XyNdIa07IOaKXWWvPurKtdSsn7au3qqf0ZF/vU+xYtHrw/V3AHppp02m7SPSTGBGT8O4wy1BtY/IiRZkMlB6ad5KnlAQfUfpCOKD8Oj05NEGnYnYpSBS/cYiTkSbREesNuAZvSyUE25pArTB/9NYIWTzsB0xy+77tQPI6+y18KpoNcyqupNNnWFwGdMXTntYUslXEUspK0yJgoTEbStCHaveLObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 21:56:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 21:56:43 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
Subject: RE: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Topic: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Index: AQHY2mKYK8CW+/1gwkudAvXiDjWW/64DEraAgAU6igOAAldkAIAAXYEAgAdrxwCAA2LlAIADjHKAgBQ7LYCACCTjgIAABhaA
Date:   Tue, 8 Nov 2022 21:56:43 +0000
Message-ID: <SJ1PR11MB6083CEB7E30E44F31EC3CA6EFC3F9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
 <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
In-Reply-To: <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5193:EE_
x-ms-office365-filtering-correlation-id: 5613f66c-b057-47c3-a6c2-08dac1d41feb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FV1xPrbNkSLpU5LPgSyPcB5TPEx/gNjxkNaMb1XKGpp/83UlGwS30oBIAg3xI4dk2fhdlddm+ZJCLyHwtFEUJJQFYmphxl1Gb1Z/bFq5uVP7ZteA1HnbIrOLeeTwTYVvj2f5e953+Ej0emElRdiOjkzpeQ5JS7JLxO+kESimiM+QDTpRzxWkhKHOHTjAkjXTcicbLcpLMu1BzO3kA/obxH78BNe6BmXaTsNrp3A3SzwVNcjoDrNJqGIXwkkwMtc10TQkGlwxf4ksCWeXyxrO0DJAD8ZyqNmEXJsKGGA3SnNrqGClhtAkuPhMef7yRtqmZwULORSZf6u7zEOkXvLwOlY/swmvZhV2/xIv0/0JeeKqYqK+/xmRsMyBJQlsgZnEqqAfDAB9CvVXfdVouLyFVa5yYAcspx23IgzHVQlHQtxqzqoFWYqwj/KmKtzHR3gBf6fGIVacrrAHCaDZICrhAPY3F6MeWaQKBRKwynmCfuXjP4JGZNaQqQr9xfZQJsA9Bc7ikWS4Kvyauyllbmtw8Y8Q/9SjI7wvQ0lwlwpjEauyqi1o5dBSKH8Mhihz8DMiiwslMax2fPkerCgoeGsYa7sh8xUYDqiB1PIFemPr9eiSohBbdgatgpYgGy3snsBxBvbJwDotfETwvyDnA19QqfR5KeP/xWpAO3vV3B0voMJOEyBHl95Ybskdns+92xFrtVfwlDyNvPAk+ehOEYmkshAhMpl66wE6MpWMY3KIZ+5R6nfWFy9o+lxWEamwxmSH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(83380400001)(122000001)(86362001)(33656002)(82960400001)(38100700002)(38070700005)(478600001)(55016003)(71200400001)(8936002)(5660300002)(52536014)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(110136005)(316002)(54906003)(186003)(9686003)(26005)(2906002)(4744005)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZmSXc5NUw1N1AxTUtxZHNMQXRieDMwT0FYVjkrQXpwYm04OG9yN3dXdGhG?=
 =?utf-8?B?bEtYVHZCMm94SHBHd1AwMlVXUm4rOVVnUmUza1ZiK2RMOWo3QUxvVVhXbDVF?=
 =?utf-8?B?NDA4QnlyU1JSMElCZk4yMmR5UTRkUjc2aTBQeXdoTEhUZ2pVUTE1Y1lDSjNo?=
 =?utf-8?B?b2ozZHdWSXROSDlaenlSQjBDcE1ITitpYlo2NENib3U0YUhYd1RPZW9QcjYw?=
 =?utf-8?B?WTJKQitIZjVVaStETm1kK3ZRQTFndzMrUVZoMzdkalhZMXRWUzBqZ2VQREQ2?=
 =?utf-8?B?VENSSU1SNFp1VkVRZGFZUzJ3YzJ2cUNnSmFSNDI0TlJoUmExbXpvQkNHSURR?=
 =?utf-8?B?aDB6RXIzNTFZak1WM3dqb1hRUUhsZ1VhVVMvTnBTeE93bk5vS2NEMTFSQkJY?=
 =?utf-8?B?T21QbUJzc0FQVjI0clg3elM4a1ArZDl3Z2dGTmNhSlhCemoveDR2ZnBQUENJ?=
 =?utf-8?B?T1JQZ21oLzlaZ0FMZE1aMWNjWGp4enNZQkV4MnJoSEYwdGtIRVBVQi8za28v?=
 =?utf-8?B?WHVYTjd2LzU4R2tnTS9xcXdhM2lOL3pXSm1uZTcwYmVkd0x5RkpTM1hnam4w?=
 =?utf-8?B?REFMeldqTVBvTjlTL0s1VjhZaG5IWW55WnVQNThQcDRLMkM4MHhadnlMaGkx?=
 =?utf-8?B?dVZ2TkJwOFE1SVpFdHhkSWR1VlRWUWpoa016b2VJNHhRbkNXSEFvWUFnNlFw?=
 =?utf-8?B?ZGdGM3BoOWZ0dzBEZGtSZlJOVkZxc2lZdFFaVnZ6NFBWRVJabEJqRWhFVzRD?=
 =?utf-8?B?YmdYd0lubUprUktTS1dvN3NObVhJMS9vaGkrSlJmVm5EUTFoenF4OEdONzlB?=
 =?utf-8?B?dVY3YTV6VTMrbE4wTW5CUW94VmFwOWN2UmYxeDZoMFZySndNc1Q2N3hlcUow?=
 =?utf-8?B?K3lENUVkM1ZKTW5odGpKdVVmTk9ld0I3Yi9BbmtFS1RnME9VRkRjS05COTFT?=
 =?utf-8?B?WWhBSVIrVmIyMmJReFBXVmRiTWF6NFIrdVlWRDVmcjlwRGk5WEExOFN0OEI2?=
 =?utf-8?B?SlNuelNCYlhaTkRFclBZS2w2eHI3QUZheXRjamFpVTUycWRROGtFUm1mZENE?=
 =?utf-8?B?ekQ4TnFmSnJ6alVmUTdnY3MydlR5ZGd5azVyR010NmM2dW5hdzBOTW1wQldP?=
 =?utf-8?B?eURzQ1RBRURXb0RwWTZlM1NodllXcmI1ZUVIbDNtMFpVM09YUVVlU1h6c2dy?=
 =?utf-8?B?Q2UralpVZitQSHRqbHliYnRjUm5EQUhhLzB3NVB2QzFjRXNmM05ha0pzWXNT?=
 =?utf-8?B?Ym5hcm4yTnlSNEc5Rlp2azhSSW9VOUpiNUNmdjZJNGVxQzdTYnZaUXZocEFT?=
 =?utf-8?B?UjNVY2FVc3ZRKzJRZDZKOEJibTliOWQ5cnU2YmloZFFCaElWQTJIcGFaZmZq?=
 =?utf-8?B?ZVZ0RnFoL3JJRXpMc0hIME1jZUpvZ0RFVFRCdlE3NjY2TThNMGlhVGRBdTRz?=
 =?utf-8?B?SHJWUnc3a0dYZk1aMlZtczZwZ1dHQU1RejBQT3lhUVJxbjlXSFBiWUFXNXBT?=
 =?utf-8?B?T0p3Z1ZVSWpCN0lJMlVVNjZTVGRRRmswY2RjMmMreDJnUjRlbUUwbFg5WkJo?=
 =?utf-8?B?SG1nRFNidkNJdDlvTCtKM29neUpwd1lhWmpjaUErdkdLQWZYZy9jT25NdDdK?=
 =?utf-8?B?RVV3YjBSNU81cE84OU1uWUdKM1hTK2RveUx0MmJvTVpJNEwyc01yOTRzcHE5?=
 =?utf-8?B?V2lGMEZwRVBLTXlmRCtQQUxwRXBYVWxnS3d6UFQySHR1dTIyZERyUmpnMEFE?=
 =?utf-8?B?dUQ5S3NDaTVGcE9EeGRFQXJEQkJaYjBZVk9PNGpkQ0xTTzJDTWhCMjEzMVhn?=
 =?utf-8?B?OEZkZzZpMHhsdWN2NEk3bkc2SGJLbll5cC9XN2U5clFyYzg3cmJHV21Ld3hj?=
 =?utf-8?B?ZjZIUWRCU2ZhMTJvelhiR2JKdFJYMGhtRzZhbFhzd24xYnFlNmdDb0Zxdk9a?=
 =?utf-8?B?T0xOY3dnZlA1UFlMajRlWFY0TjZ0TWZEYXk5cmtDMGxRWFhPa3BwaFJZOXZE?=
 =?utf-8?B?YVpGbHFMbDRoQWhkbTdRTkxLMlBwZFkzRmVMZXNoUHJKOGw3azg2ZDFpUnQ1?=
 =?utf-8?B?c3drTUtBK0J1QWE0a25xVE1veUdsYm51U3UwL3hOaTJLVXU1bFRLeGw3NWVw?=
 =?utf-8?Q?9pcfv/FLw9nRyJtBOshrzrg2c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5613f66c-b057-47c3-a6c2-08dac1d41feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 21:56:43.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRZN5ypjHaGJEZh3UtwOG6RGkvxy6m0JOB0LgWl7OYj76lvMsGWqMyNXCBl8Ly/eqgEXoJB0K59x3HP7GWYwGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMb29raW5nIGF0IHNvbWUgaGlzdG9yeSB0aGVyZSBldmVuIHNlZW1zIHRvIGhhdmUgYmVlbiBz
b21lIHdvcmsgc3Vycm91bmRpbmcNCj4gInJvdGF0aW5nIiBvZiBSTUlEcyB0aGF0IHNlZW0gcmVs
YXRlZCB0byB3aGF0IHlvdSBtZW50aW9uIGFib3ZlOg0KPg0KPiBjb21taXQgYmZmNjcxZGJhNzk4
MTE5NWE2NDRhNWRjMjEwZDY1ZGU4YWUyZDI1MQ0KPiBBdXRob3I6IE1hdHQgRmxlbWluZyA8bWF0
dC5mbGVtaW5nQGludGVsLmNvbT4NCj4gRGF0ZTogICBGcmkgSmFuIDIzIDE4OjQ1OjQ3IDIwMTUg
KzAwMDANCj4NCj4gICAgIHBlcmYveDg2L2ludGVsOiBQZXJmb3JtIHJvdGF0aW9uIG9uIEludGVs
IENRTSBSTUlEcw0KPg0KPiAgICAgVGhlcmUgYXJlIG1hbnkgdXNlIGNhc2VzIHdoZXJlIHBlb3Bs
ZSB3aWxsIHdhbnQgdG8gbW9uaXRvciBtb3JlIHRhc2tzDQo+ICAgICB0aGFuIHRoZXJlIGV4aXN0
IFJNSURzIGluIHRoZSBoYXJkd2FyZSwgbWVhbmluZyB0aGF0IHdlIGhhdmUgdG8gcGVyZm9ybQ0K
PiAgICAgc29tZSBraW5kIG9mIG11bHRpcGxleGluZy4NCg0KVGhhdCB3b3VsZCB3b3JrIGZvciBt
b25pdG9yaW5nIG1lbW9yeSBiYW5kd2lkdGguIEJ1dCBub3QgZm9yIExMQyBvY2N1cGFuY3kNCmFz
IHRoZXJlJ3Mgbm8gd2F5IHRvIHNldCBhbiBvY2N1cGFuY3kgY291bnRlciB0byB0aGUgdmFsdWUg
b2Ygd2hhdCB0aGUgbmV3IHNldCBvZg0KcHJvY2Vzc2VzIGFyZSB1c2luZy4gU28geW91J2QgaGF2
ZSB0byBsaXZlIHdpdGggbm9uc2Vuc2UgdmFsdWVzIGZvciBhIHBvdGVudGlhbGx5DQpsb25nIHRp
bWUgdW50aWwgbmF0dXJhbCBMTEMgZXZpY3Rpb25zIGFuZCByZS1maWxscyBzb3J0ZWQgdGhpbmdz
IG91dC4gIEVpdGhlciB0aGF0IG9yDQpmbHVzaCB0aGUgZW50aXJlIExMQyB3aGVuIHJlYXNzaWdu
aW5nIGFuIFJNSUQgc28geW91IGNhbiBjb3VudCB1cCBmcm9tIHplcm8NCmFzIHRoZSBjYWNoZSBp
cyByZS1maWxsZWQuDQoNCi1Ub255DQo=
