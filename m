Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97456C2885
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCUDUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:20:41 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 20:20:38 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C931E3A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 20:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679368840; x=1710904840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eSL6fCzmFqIdKFZm4vsxehj7fZ/XAvf17Y7TaU/lK5U=;
  b=XabncJawRjVLh0YqMVQY1TWd6o8jOboJDcAj2b8NWMgbYFURo9t3R7bQ
   Va06ka0FKHjiqictbjWw03DZ4Vv2kaZi5LR08rlo75aaGQvM9smbkS8E+
   Ucy2XHBmsKIiQkynnSSJIipMfMqIRrPiLzwCWqppYWCm+q7GcyWnKshl3
   kCptjqQkVIRZHWcPxtAHHacT8KJNcc4XWhC+2L70bweInFjneAKDnOFQj
   NyHPbGh8ldwn8TmBKUG3/UmRQlMPhR9AmPTnxxXYIZAp/ROkbHg8LqXnO
   ueTqVZchORS5FBiRMUv1CCzIdnxq5Rm/PTjtmzQLa787wAVNUUvXhDjrq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="79806074"
X-IronPort-AV: E=Sophos;i="5.98,277,1673881200"; 
   d="scan'208";a="79806074"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 12:19:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gelIL5VD2w5GpKnu/7zcyEHvaKsz1zcO2GvLAgwv1Yrtcz9zNxS4/yO4z/QxHAOCgUGpsXhlJ5YZAWZy+rL44l4qXbtal1EuVGaUqRcOdLr0D+Qh5seURNXmL6Zx6eBkoOPPQ8fCU821yC/pJ2xS/A1Tzg4HpAabab7M66FS9srjw398SreYnBMUNR0fYvZy7kwYFOEP0g/3zpWkYS9NZf5RAbbf3Ewd0RYw3kE2enjA1n5uHKemTNIVPkWk1YcaJEK6w9qWu4i5cU6nk/MF9v31mSchDHiDgOt/m3QMIqhK1AIkI6E9eNdELipKBJRdcw+jw1x/QVlXgsBmxCW09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSL6fCzmFqIdKFZm4vsxehj7fZ/XAvf17Y7TaU/lK5U=;
 b=HYWwtINtpgY3Ue3cbgkc/sute+Pl4TGlf3kx3jvJC/LyQaCZpN33QBzkwjIhKXWCjR6IKPrH6Dchmdf3NbgNAJsRrWRT4r4m/YZY4x8p8jU+eVnad90DwrncQhd8Nq3hi0MwWNqX2TqmWgD/VvB1E/zPgFjBFJrS2+m4Ofy4K/A4tagh7pprJlEemPxERjjmwcfZDEVM3MR4GKKwRH0itO4/UeGcXQrCuY/8UTJh7zBo3fToAI4iNhDaOmImoqYz+/VOljJ6R+gGLDEfKof5z6p3mG8esZZcciG4odxIzfK+NTmagwozk3KxhKHzthPk8L7vgHtZTFUNixfY27W21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS3PR01MB9978.jpnprd01.prod.outlook.com
 (2603:1096:604:1e7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 03:19:27 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::777c:ddcc:cdd0:7ec2]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::777c:ddcc:cdd0:7ec2%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 03:19:27 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Topic: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Thread-Index: AQHZV+LVN1DLpX/+y0yTP+b0+z/XPa79j4OAgACkEICAAEgHgIAEddSAgAECAACAAJNlgIAABdQAgAALdAA=
Date:   Tue, 21 Mar 2023 03:19:27 +0000
Message-ID: <f6f97630-5a45-3e75-bb34-b0bdb66c1bee@fujitsu.com>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
 <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <eae85bab-cdb6-b8b3-8014-2e7f3916bfe2@fujitsu.com>
 <6418981ac577c_1dee2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <cfa1a053-b99b-c22e-b80c-4b92f5f4e225@fujitsu.com>
 <641918a2cf2d3_26992942@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <641918a2cf2d3_26992942@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS3PR01MB9978:EE_
x-ms-office365-filtering-correlation-id: 605a4047-81c6-4524-fb04-08db29bb140c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+wkbQrioiTj7WsgHQqqiV1lEeO/sYAO1QaT1u6jniZ+FNu9Ng0v/Vdk/waVz/JYZ0oqQKHuCXZ0dV7iBC4n4mq+SOB5ZqZCaLI8qVYrHWWsSgqvzbe5a6VAAlUsGGf5tTg+yU60id5DR/iRkTocil0aZTSsfXy2FgmmYoBiG2zyhlOfQMAt6RV0amczir0hxc5PS6niqt4WfaZmPjhx/HkWKsZ2otZlp9vSunXxmTrprZlDhoIDi+GV12XPxHelFtjY9KTi1okje9mohTYm5fAznHkDSby15vnslBMyR2JYfSOeuH7d+wnhofxvVT6bSeCg8aD4gt2T9NeDiQD3UgUMMf2fazgtJV3Fe+I2pPhcFZiTl6P7A8vTOYJSZAHCIQvaS8zGs3Bmc5KpDr/Yg7arlMxPz4TqZJE4jz24cHSUJxPPF/fF3aohRsvdmE6D7YtgaPHP91gPowwGe9QUASqVCuYC2EJWKpLz3UuKiJJ2tuHdMCk+InjNXR/94u2kDLtnO1h3A7kAq356HeO54hVsZUFgnm9Ah/tYhbl2ezJNRFBb2Oz0AEHGQWFxVN6ku1JOH3Hsz1vbe3bLZbXQ4hLDMAlQD9WnhWaXpW/IE1xdQF0/8bYbGOjEFdiznin5vq/yw5KE7E4w4WpyhTMc7R6a1EnRMwb8d2ecVvcvJVrwHNm3wHlQxmqbXRkTs38my4DZRQn9o67qR7LQW419Ft7DVoiqAE1HQYZvmyxyvJQp1gIhK7Y9Q8XpL8UYM8yq1I2LzwKPAukssbbmOimCk0mdvigoQ08cn8eExklX7C8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(1590799015)(38100700002)(31696002)(1580799012)(71200400001)(86362001)(110136005)(4744005)(316002)(66556008)(66946007)(85182001)(36756003)(64756008)(4326008)(66446008)(8676002)(5660300002)(41300700001)(8936002)(91956017)(76116006)(66476007)(2906002)(478600001)(122000001)(31686004)(2616005)(38070700005)(6512007)(186003)(6506007)(26005)(6486002)(53546011)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3JqMkcxWTY5UGZaKzMxcTU1clhSTXQ5a01FODgrUTNTUndQbWlUenJZTG1U?=
 =?utf-8?B?U2I2NzJ3U0NyT1FHUnRyTjloLzY5dnE5d1JlUUFwVjFnaW9PVE1vMU5hSTFq?=
 =?utf-8?B?b0xkejFOcytqTVljVU9UMjUxczljTmRXSVFCVU9nbG4xeGtiVy8xYUYyZ1cz?=
 =?utf-8?B?SituS0x2TFpCZ0ljNHFQaW90aHBsTXlKNGY0NGo3M3N0ZkJuMHpUbGhSVVh2?=
 =?utf-8?B?SUFZODBsN2JocElwa0s5YXplOC9jZnFMNjkzSlhQenBBcXlwZkNjV3EwTTd2?=
 =?utf-8?B?aEhBS2ZDRURMSWFaWGdiWkFRbDFVVkZpd093M0FUS0ZlOGZSQzlQN1pGQ1hk?=
 =?utf-8?B?c1U1dGZwRzR4cVFQckZRY3BEUWtZOFRzNU9lS0cvRjM1ZDQzS3A2RVhRbnEr?=
 =?utf-8?B?a1RZdUtrTmVaVzhlZ0Q5bG1rRTdxdlZTZmNVL2dreHRWTDdnR1FsaFJuMzFF?=
 =?utf-8?B?THljWjNjUnBSNGdNYlJ5TmdxOVRtNXhFUHF2QlZmNldPVXB4bENicUY3MHZq?=
 =?utf-8?B?UTd0SnRrUGw2ZkRsMHhERWE4K2l2N0JpK013Tm8rVzVTaVVwRkI1b2VsWEx5?=
 =?utf-8?B?Q2JKVkcyT1FNdVhiUzRPRFFjL0FUTmZGTGRMSE05WEZ1MDdtbEJBUzlJcE16?=
 =?utf-8?B?ZjgyZ0RFM0FZeVlxNU5yTUZYVHJGZ0F1TXIraHJQaFFQV0g4WTh1NjMwci9Q?=
 =?utf-8?B?dGNPNzljYTVhWW81M2ZXdWVzNnZHMFkwUVd0bG0zQk50V2QyWENadUp0SkFB?=
 =?utf-8?B?OXhuakdJU0FFRmZkWS96ZEZBbmxsQXJET2dHLytTTjdPZU1ZNC9MV05hMXpn?=
 =?utf-8?B?ejNjYWtNVGtpT2h6azBINk9SMGVmS3c1SFYwTGt4aW9CTitVYXk3RHMxNUV5?=
 =?utf-8?B?YnlWdkpXaldVbUsvdEJzSGErWTBYZDV1MVlLeCtKSGdZZ1B5M0RWcnFPZ3NE?=
 =?utf-8?B?NEY0N3U5NlR4MFl6NUQrYlBPOUlOSzVSY3I2TkgzcDZuSGdnNnZGQkZXclRD?=
 =?utf-8?B?ZkpZcFBJVmhRKzdqN2cyM2gzck14UlA0MG9pdnBFaVNFQ3lha3QrMlZRTE1W?=
 =?utf-8?B?YmJGcjlpVW4wZWwyTFJKR01ONldhalBqdy9teWVyVzhQUGE4ZW9ZUUJycCtm?=
 =?utf-8?B?b1NabE0zSEJIUWFxTzB2Q3BNMzVhbWg5bU83S2hpemZ2OHgrYVI2RTEyZjUv?=
 =?utf-8?B?TzZYNFpvU1lYZjM4cEJIdENiTXBqZDVydkx0R0J5WDE5YStGVWpoRkRkKzlS?=
 =?utf-8?B?a3ZpZzN2dmw0RzVRQkdnbWpSQngyL2VYU0FQcWNiTXhWTEV5bVdYN1V6dVpV?=
 =?utf-8?B?VEFRVEtKYkVLYmZIbjUwTHh2b0l4bmxHWFZsYk8wZzgwY2FZa3lpOXMrQk83?=
 =?utf-8?B?eGsyTkJtSVp4QUtEOG5MMHB1RUlpZ0NYQlg5L0JleDF1WjFxUW0zckZEWU4w?=
 =?utf-8?B?K0cyRjdUcmlScS9ubURGaHJjelZWbDNnbjJQeC9Vakk3dU5JdTlmWXQxZjNR?=
 =?utf-8?B?eUxiUHBxa0FuK0dmdnhyRFI4dFNaR3AyeVhqTThGTWhJc1g3YzRCQXFjdENv?=
 =?utf-8?B?OHFsMnc4T2JlS3Q2ekxlWmlQaDQ2alhvREM4SzMvRmVpc2llQjZxMWpWMDh5?=
 =?utf-8?B?M3dNQ1EvbmNWdm5RZXdlSEtpTHNEcVk0SlEzaU5hVldYQWhCcE5POFByUkRG?=
 =?utf-8?B?WE00T3ZHUFRCOXhTVW9ONWxUbmR4ZXEwM2xQd1o1OGVXWGFubWdSWHJBYjN2?=
 =?utf-8?B?bzVYbHJBc09GalFwbDNoL1U0UTNWTE5FeDE2bVR5bWVZZXh6UWhXNGtPTVhL?=
 =?utf-8?B?TTljMCtIVTBqOHhieEgyYVhjUXBRVThiUUJBOG8ybXpjNVlXa0VNTlhDck9r?=
 =?utf-8?B?SUJ1SU5RL1F1Qmh3Q0tpaldhVkNRaERvOWEvcXYrVWV2U2lZRXdIRllSSVVl?=
 =?utf-8?B?ZTJKa3lheGg4Wk1Lam9aUVlYS3FrMVBPTGhDMVl6ajJoOU0yRnZYM2NiVGds?=
 =?utf-8?B?TGZpTlMvdmRxWm43eTNrTk55OUdsWitYcDRKWWhtdXBpUm9jTURUMVhBRXgw?=
 =?utf-8?B?N2Z4V2owNzBreHRSMVNpdmZhM0N1UHpzVlhIbXVwOXlSY1lWUDZ2WFhoOXRz?=
 =?utf-8?B?ZzgwdlNJb2R5M0dCSWZ6ekVMNkhOZ21LOUhHVlJheXpTYkhXYkpKQ1ZFdmFD?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA91D37CF197454E93646B4C106B9492@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZLU6HfDjDB5IaGofbBYIA1gqU/xPpq1czv+018+Fg9lWtvLtLK0gYDYc9FjbNHxUGuNezBe/wWKr7Wf6QhqWIJ0gZtm7W97FCR4dms/0JHtJtqD3CsCCXKZH7l14xkqV/O8M2PS13XCYhQDnky+eX7l6zTyNHCNA2t8pJIHDr1lRT/bfTSKRQKYqYF2WJ/RxZtKhk8tZyeersTCOnTKh6T6HE2sfv6B7MocXwBqoFB8U11xS6H6dVB8DPkEKaLakaym50yMHQiyea7qPny52H6uHVzLZQDdIzfJhf8eiRoXkBhyoJs0ULK7wLH4uFD7jnesaVgSCc/f/9ZPb4LH8fkKBMmE6GBdtX9P1WWWiO4GBJYM1SZwywnXZ0OsI7yIz9a69Dnu9Ch91huzgwb220WGh0ytq1rhvXLN/floH+U605gPebR8yAgf8PG7FOL73sVmoCzOMX3rjJsl2C6jrlZhZV/rRsUSgZi6fFxUfxMMDEDVS7bjmAWlbH41EXwFgZf1urQJNk8Ym5F0c+pFGiCjls2mASp9AaCQhnaxUMY5Du87o4JViG0np2qf6RDA0fy0HMyZA7+kqYODlLRYFGJdT10hBrt2G4wA1zqwPmdsXVF+cqkD/4n7C+Xl+QHMSIww0R101zflBYPfk7D+Ss76toi1qUgTKoyl0FA9qLtooXaDOpSPqmfJi7n+iD4/WIGGdV8mA0Fbx2nGjEZP9NaCXlbaLKfCXPmzV86MZ09BuSXzBtJN5Qj6oJ+x6kXO5zQAOYrCzEyb3/Ipcl8Tz1M8HhM6YjnAHmXYy1w3VOi9zEgsA3NOESUiS6gVMRwhobtPslHFt3mWKJg5c5YSYGA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605a4047-81c6-4524-fb04-08db29bb140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 03:19:27.4606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: un2/57LaiZA/TKYyYc9+pYgNAgp7G1ZLVobtfWBBH3b7MUmcAu7ysplPnevFdDCrkh3rty9mC7KjRBd6gsYcrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9978
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLzAzLzIwMjMgMTA6MzgsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gbGl6aGlqaWFu
QGZ1aml0c3UuY29tIHdyb3RlOg0KPiBbLi5dDQo+Pj4gTm93IEkgZG8gdGhpbmsgaXQgd291bGQg
YmUgYSBnb29kIGlkZWEgdG8gZmFpbCBkZXZpY2VfYWRkKCkgaWYgdGhlIGJ1cw0KPj4+IGlzIG5v
dCByZWdpc3RlcmVkLA0KPj4NCj4+IEJUVywgYmVsb3cgbGluZSAzNjk6IGRldmljZV9hZGQoKSBk
aWRuJ3QgZmFpbCBpbiBwcmFjdGljYWwuDQo+Pg0KPiANCj4gSSB0aGluayB0aGF0J3Mgb2sgYmVj
YXVzZSB0aGUgZGV2aWNlIGdldHMgYWRkZWQsIGJ1dCBuZXZlciBwcm9iZWQgZHVlIHRvDQo+IHRo
aXMgcGFydCBvZiB0aGF0IGNvbW1pdCBJIHJlZmVyZW5jZWQ6DQoNClZlcnkgdGhhbmtzIGZvciB5
b3VyIGV4cGxhbmF0aW9uLg0KDQo+IA0KPiBAQCAtNTAzLDIwICs1MTcsMjEgQEAgaW50IGJ1c19h
ZGRfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAgKi8NCj4gICB2b2lkIGJ1c19wcm9i
ZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLSAgICAgICBzdHJ1Y3QgYnVz
X3R5cGUgKmJ1cyA9IGRldi0+YnVzOw0KPiArICAgICAgIHN0cnVjdCBzdWJzeXNfcHJpdmF0ZSAq
c3AgPSBidXNfdG9fc3Vic3lzKGRldi0+YnVzKTsNCj4gICAgICAgICAgc3RydWN0IHN1YnN5c19p
bnRlcmZhY2UgKnNpZjsNCj4gICANCj4gLSAgICAgICBpZiAoIWJ1cykNCj4gKyAgICAgICBpZiAo
IXNwKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gICANCj4gDQo+IC4uLnNvIGl0IGRv
ZXMgd2hhdCB5b3Ugd2FudCB3aGljaCBpcyBkaXNhYmxlIHRoZSBsaWJudmRpbW0gc3Vic3lzdGVt
DQo+IGZyb20gYmluZGluZyB0byBhbnkgZGV2aWNlcyB3aXRob3V0IGNyYXNoaW5nLg0KDQpZZXMs
IGl0J3MgZmluZSBlbm91Z2ggdG8gbWUuDQo=
