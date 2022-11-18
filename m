Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4362EE09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiKRHAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKRHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:00:22 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 23:00:16 PST
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC11A3BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668754817; x=1700290817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IZb/y5XfkT1kEoJ3oS9kAoh0h/QnkMuTUCIv6CvaEEY=;
  b=rWf6gw57hAUipRwQtA6uVST7DUQp/Q/4PKr3MBNEyC+Ju41qbegC1YAQ
   e3YeKi7CQs8piDZXYteIQyryIoK51AV0iJzDdiEi/zH+ut8gXXiq3c2s0
   yy4tLgrXVnCOehUVqs38iSGJbBGrRUfQS6a9/TmJZPEsbbN09cDrtmD/d
   PKw2zGwv9eE5nb8XtqpJ34GKw8V700iYH1l/FY/NRy6ySSnFRitviutvT
   7hb+PNjR5YF+m6wi9fUwvcGM/m0w8HzPodVv8cFnJzbZUZIFuiWwhLSGc
   lpGCvt/hataoLK3frRFjUSNeeEPNob3nPNn2IJQw0QlMTeLSf/9akVaIt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="78177239"
X-IronPort-AV: E=Sophos;i="5.96,173,1665414000"; 
   d="scan'208";a="78177239"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 15:59:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzF0iXel7IAtSVwWL2En6lPg8dOI/fCTmpzLKgmJfyxFBZM1K7D6WVrD66eS4bT7dxgCEd3nrh8g4fOZLP4SGIIR/ylqEpukTTBO10EiO8EbsafCgDYCo1gwdzeakxbOTPl59RlrE+s9yzlLxcDaWN5/BgqpmI2htaW3I3EDsEwSzk1/yuI/bj0G8juZbcJwuFBE5O3BmsJ9YlkhtXhFF3JED41tRJxpXYInlsPnku9tk3kRK2/bACuSVgF8aB94ktIPyhyG8fZsOMNuT3kGlo5pOS5lG6weq61LrBq/DPAyY3W9n5u6+po4n5NpYIQD59mV1XtU6iTdygSeL7IJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3MOM5AXZkZ+NtDMBrnryIOnVn0DrjSXRXwMA0PpyNE=;
 b=BwX5ADN6NoWK9guOuOHcwrTJOVXlI0MOB09j9Mn22yxZFRKWz9KUSwpay2YpYDaEnNDlaXDOX4ZsalEKPXo6UlseLHpjpLu9L5dVjR7+sQeytd00v2yNIwbLEmjGIR8SEp0QDrm92RdumtSqMOz8eyC6GKOYUz684wfpCCc+5qB7CbrI1apQ956YV2pj5qpnfsSE4w0zqd5h/XtFwYltUi8MSC8FkYbVMrJWhA1/Hm8jZ6SeC0d5L26FGUaoYRXd4Ml6j8InlN2Z/VgE80jo9xWzs9Z9OZl0OOkIvVAdst3NBAih9VWk2/+0DHyD7UAG2iVrnrRy8/iQya0JpaY3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9269.jpnprd01.prod.outlook.com (2603:1096:604:1c7::8)
 by TYYPR01MB10464.jpnprd01.prod.outlook.com (2603:1096:400:2f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 06:59:06 +0000
Received: from OS3PR01MB9269.jpnprd01.prod.outlook.com
 ([fe80::39d9:6cfb:ba96:6dae]) by OS3PR01MB9269.jpnprd01.prod.outlook.com
 ([fe80::39d9:6cfb:ba96:6dae%9]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 06:59:06 +0000
From:   "Masahiko Yamada (Fujitsu)" <yamada.masahiko@fujitsu.com>
To:     "Itaru Kitayama (Fujitsu)" <itaru.kitayama@fujitsu.com>
CC:     "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH 1/1] perf: fix reset interface potential failure
Thread-Topic: [PATCH 1/1] perf: fix reset interface potential failure
Thread-Index: AQHY+vKUFw3DqBClrE6mGbcFQIYRv65EIqkAgAAdC3A=
Date:   Fri, 18 Nov 2022 06:59:06 +0000
Message-ID: <OS3PR01MB9269843612B7E4980721A830F3099@OS3PR01MB9269.jpnprd01.prod.outlook.com>
References: <20221118020016.1571100-2-yamada.masahiko@fujitsu.com>
 <20221118051156.961494-1-itaru.kitayama@fujitsu.com>
In-Reply-To: <20221118051156.961494-1-itaru.kitayama@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9NWUzMThiNGUtYjc5OS00OTg3LTk2NWYtNTkw?=
 =?iso-2022-jp?B?YWI4ZDUzNzAxO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMTEtMThUMDY6NTU6NTJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-shieldmailcheckermailid: fc6cde19441d4110a3d7edde66c5d4b4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9269:EE_|TYYPR01MB10464:EE_
x-ms-office365-filtering-correlation-id: 6d36c552-cb66-4a81-6ac9-08dac93262a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEe2EF+WTwjnJOaGT96fQ6AG7AZbSP8t6IWqN8sUPjy3TAdsdFr2bfE+eZLMpMNjwXL1DsVvzNhHaUxcegL9mm4ynXpDv1c6JjQ98xGTVVJ7HGFNRoFlC9WXdgVMKc5Mj5NMeGCh0s18C7RFQKuD/X/yEfXTnXks4StR04fQClE8J292L3ixOnkknJ2KLs6lQg69KKRlWslGc+/jGMS898SzSFHF701wF4BTif5OJ94oAmGoTJZikgvTUQqWmxcsPBKw3cvKn2FhvM3Vtwove73/UkcTA6akohLJVaUqGneDEgwOfcO126CKBwS4ZPjZh++uEPGNzevFoeVa4thO5EwQjviKcwFIM1efCqhkaAlpvWyxIY9XvFgd8NHcW/AIAQzpLQ4LL7c5oN4wOT5iZ3gdC76awimFPsDiCHl7khiz6/g59BjDeZJvFuS9J/N+d69hJapnDtQA4sx7IaocY1aE0g3iaZwQsIBhkc5i6vtzUHho6g7g0spAczUDfW4R6iM7gH3LwTdB4h1q0xDh+kkngP4geMFauNFdXHseue/dWSnE5YxRL6qrODr0WGYSiz6QdCKbP+GWqUCVU3ey0qmR9a6DEPzVh51MEDSMRLNHfH8VxhFOznIBx1lTzgiJURz7NULnXXWn9P5I9lB0jhHIKBtAU2idR7uJUu1JCLiqJ/44qJmfhQtR0wG+6b3dqQPobr9LNgG6KFpI7enM83MfBIUogjzzJopRO7ijIfE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(1590799012)(451199015)(52536014)(5660300002)(186003)(76116006)(2906002)(316002)(85182001)(66446008)(4326008)(64756008)(6862004)(66476007)(8936002)(41300700001)(66556008)(8676002)(9686003)(26005)(55016003)(38100700002)(122000001)(38070700005)(83380400001)(66946007)(33656002)(82960400001)(86362001)(478600001)(6506007)(1580799009)(54906003)(7696005)(53546011)(71200400001)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?L2JlM0hEVXEwQjBBZTR5Z2ZiM3VlTzhjS3JLQW9aMFR4NnpjNXZUMy9z?=
 =?iso-2022-jp?B?SGYwM1VlcXA0K3NpdjNPSXdkb2VVeUxJRWZQN3pVRFduSm5TS0NOUWhW?=
 =?iso-2022-jp?B?aFJQVlo3bWxUQlJDb1ZNTEdEVkt1WHhoV1VVcmF3Z05BWklSalNvRVVZ?=
 =?iso-2022-jp?B?bWZQMVhnbDhYb080WHJ0d0puYjZEN2FWRmZtRlNRMWVHUmlQZFpOTmtI?=
 =?iso-2022-jp?B?MnYvYU4xU3BzYWdUS3BOa0l5SWQxVVJ3a3BTVW1telVzUVEyZWhEd1ZQ?=
 =?iso-2022-jp?B?QktTdHEyMG9qUk00TDNnZm96dnVMZU9LVHRBQ010aGMzemhUaFNHSURL?=
 =?iso-2022-jp?B?MU8rQ0VIWjA4aUhxMzRXUmNRbzE2WTdnVVRDWDE3MldtcVc2anloNGow?=
 =?iso-2022-jp?B?dHN5RjVQNWxDbTVKa3pMcjRZTHNDekVPYzVVWUZxOWQ4L1hXSndtbFI1?=
 =?iso-2022-jp?B?Um11UnV5TnVKM1lDcFpiN3VlTksybUpDZk96dDhxci9udmgreWVqMlpY?=
 =?iso-2022-jp?B?bm8yUDBlclJtNjFPK2RlWFI5U3B1M0EyaFMvQ1psaGtEVmd6SXZ6MXBC?=
 =?iso-2022-jp?B?Y3RBclZ6ZEVxbGhhbFpYMGlFc3FmQ1FxYXhITUVETmNZRVdpR2VJeGNH?=
 =?iso-2022-jp?B?M2FPZUlzRVlWQlVnT05saGJZa3FQSFo0V3U3Zk1SSGJoM09GbndrUUZn?=
 =?iso-2022-jp?B?UnoxWHBBaXBnMGVFekhNQk55enlKcklFM1hraDVpSzZkeklWK2hIN1VB?=
 =?iso-2022-jp?B?WVhqZG14TVBYcmJJL0xsVFFZRW5LbXY1UFN4N2NDTjFSc2I2aEV1c3d4?=
 =?iso-2022-jp?B?MmFjS0JNd1daQ0ZSOWZPRDNrRDMzTklUYk1tbURUNEh5KzJXTysrYzh3?=
 =?iso-2022-jp?B?OUJuZzFyZTB0NEgrN2tjUDlyemxDZGk1M3B0ZS9DUnA4UXl1UGhHaWdV?=
 =?iso-2022-jp?B?NG5MY2hHamladTRuenE1b1h3aDZGUC8vR1FDQksyL2JPVGRhNGJLT1pG?=
 =?iso-2022-jp?B?OEI3eDhYQmFuRy94alZ0a3RBbjcrR2tIU2FtUmtZV2VFWHRyQThhR29D?=
 =?iso-2022-jp?B?ZGhLa0xOV2dnQ2NQM0d1ZkxGa1RDUkk0ckpHWnJwNlpWTUM3Q2NpRnB1?=
 =?iso-2022-jp?B?SGdXbG55RGhKZEU5VXZuRXo3RTRWMmlHa0VJY3dGczVabDZxUkZHMUVp?=
 =?iso-2022-jp?B?WElsSk0zQVljdUFRZmkzOXl2anFhbHF1ZE5ERVhGOUpoUEtyNkFXY3Iz?=
 =?iso-2022-jp?B?eXVURTU4TTBQY2xCdkxMZ3krMXltais2cmoxWkp0RXBoTFh6SCsyRUtK?=
 =?iso-2022-jp?B?ZnF0UWJmam9uSGlReGVVbVdKc0J4UWFKek9Fak1YalM0TWRmd3pkZWor?=
 =?iso-2022-jp?B?cEVNcndHb092WUIrREZzQjQ0dDBkS0U2WS9NdExGQ1Jxck5PdUJCeWZj?=
 =?iso-2022-jp?B?bzlYYjlzNzFhcTc4bXFxcHE0d096RDRCRjNJdm42T1J5VWJaU0Rzd0Rq?=
 =?iso-2022-jp?B?QUpTOVBBSjNYcmhiQWNoTGpZZXhrOXpFd3phSXVtSmZnVVhHeEpnZW1l?=
 =?iso-2022-jp?B?NFM4S2R6MnZ3bGVOL0VGU2JHdGxzOW1BcDZyaEFBNGRiTU1GTGE2aUc2?=
 =?iso-2022-jp?B?WkxSVXgxUmwwRHhNMDdCYk1TQnlHT0lxZmlYdlo0WnpFaGxJejNGWHBt?=
 =?iso-2022-jp?B?N1VNbFMrakZUYnpibTh2d2EvaWNHQ3pGQ1VOZTNoSDhMSFFkZHBKYmRP?=
 =?iso-2022-jp?B?NXUrT2l0MTNLellNSFBRQmN6LzZ3YjVqVUxrTDdtVDlSU3hRd1BVdFhZ?=
 =?iso-2022-jp?B?N2tBUktqTjlmZkpvNjVBT1RWTVNDNHVRQ0UxTUYvK0RBcUxsT1ArTGFI?=
 =?iso-2022-jp?B?R1pmbUN0QnRLd1VxdThuSEFqVWZ0ZlNrbjNUWVk1UmpVZ3J5bEpITzNm?=
 =?iso-2022-jp?B?MWZCVUhuRXV5OUttNnVLTWhIdmlEVU05ekZ2UWZMNzdwdmFXK0N6cEo3?=
 =?iso-2022-jp?B?UkMxd3JLaXNmUDE0L3lML0VWV0FGL3JxSFBKeXd5TlRKaVdLSk5STDJy?=
 =?iso-2022-jp?B?QlJiNytZWjhkSWdpMWNWWTQzK09sa1MrM014cS9sNWVHWUpSYXFOMlVj?=
 =?iso-2022-jp?B?a0NNejI4OVo4QjkxSmhEU3VLdzl4bVJsSXRSTDdHNVMxMisrMUg4VlR1?=
 =?iso-2022-jp?B?TEF0VlFQTDdNaXB2VlhvanB6WHU5dW83VXYydGwvci9Hd24rT094SXFz?=
 =?iso-2022-jp?B?KytReWo2RHlDMUZpSWRDay94Lzg5eGo0SHZtQXpENkRpSUhONnZrU0No?=
 =?iso-2022-jp?B?c2dhUXhKTXJEUUZDcWVqZjBvNWV3V2NRTEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?SUhPYXFJV1FzM01YSkdsUFFOdDBDT3VYZTJxMmc0SUFlRDFMbXhMUllv?=
 =?iso-2022-jp?B?Z1pqVUtIdy9pYzF4VVBsZWZmU3M1NTk5azlkRXdMaG9OdU54VTNhZEM3?=
 =?iso-2022-jp?B?QlUxRzRTUG9YTVE0eVovSExCeU80clZ2L3lQdjNuanZmNGxUcUZ4UGwr?=
 =?iso-2022-jp?B?ZTk5L0MvNVdLMmlzc2VXc2t1WGZxdndNV0ZjZkpqcm9ma3ZTalIvcFQv?=
 =?iso-2022-jp?B?ZStCaVhRcmVIOTJyRXJnTGRYQlNjWmZIVjN0QWtvTnpjb1JROUI1WGZR?=
 =?iso-2022-jp?B?bytXTTVpNWxPdlpRVVZIeFVTQ1c3N1dNSjJBWkVPbHRhMG11ZnZua0w5?=
 =?iso-2022-jp?B?Mk9teUNMOEY3VWhlUFZRb3ZpWU1VSWtuMDRNR1VucnFCUzNJaEgzZjdR?=
 =?iso-2022-jp?B?SnAzWUhGR3J6SGpKUjM4dUZ3cmxLMk4zUnNSKzdwMnlkUE41bVBHeUUy?=
 =?iso-2022-jp?B?L1o0MGlhTS9oZWk1WDhQZDBFUURHejBBSHpmNS9Od3FaT3pDQjgrRHVD?=
 =?iso-2022-jp?B?Q0FWRW94K3FPdlVJbWxlWUZWcjNma2kvM01VbGMrWlpUcVBxRFFvMG1a?=
 =?iso-2022-jp?B?c1FjVCs2dHcvYWVEanJFdVV3MlozOEhTUEhDbkdwU2Q1UEZvc004MXFo?=
 =?iso-2022-jp?B?dkRtekdQRkFEZXZuUHFGTEd1RGFTRVVSczd1VnZsRmNUS3BpaisvOTBl?=
 =?iso-2022-jp?B?aVM5UzY1NFRiNTlIS1hKZFkvUmZBMU1xeW56QW5xVy9kS2NETFpXSlZi?=
 =?iso-2022-jp?B?ZkR6Mzcwby9XbUlrS2Z5SnlTdVZVaWpXQVNDTkY1S3daak9FWEY1bW1x?=
 =?iso-2022-jp?B?ckNuYXdJUFJKUFYxWVRWY0JjU1VLQU8yUElKTHRDRHNEajFka2V6Vlhx?=
 =?iso-2022-jp?B?bVFNMFdPUDVEeUIvU1BrWTZTK3Q1Zm1BV0k0K1RScTdhc2N6TGtKQTZP?=
 =?iso-2022-jp?B?eW1EL0ViS0lpTTd4eWloRmkxVFA5NVgvS3R5MWNFOUFQVDlpYmFFdUdq?=
 =?iso-2022-jp?B?YmVncWNwT0VBb2huRGNlR0tLMm1hNnpac1gzK1c4RllMMFRRTllDZHgz?=
 =?iso-2022-jp?B?R2dvYUZUcU02b0NRNStSTHkwcXNCOEhVUVB4WGF1ZDE1SkZzZE1GZFNZ?=
 =?iso-2022-jp?B?QXd5eGNZNEkxME43a1MyTjRmNFhVU0pmNzVSRUdxaURjTTNhWWhkRTVk?=
 =?iso-2022-jp?B?bzJ5Z283THRxVlhtNVdWUm5FdjlsZGVaRDE1Tkczdm95aHZFYUpYdlRW?=
 =?iso-2022-jp?B?MFpiWkxBOEk2OWJGazlJK3ZLNU13VFdnZzgyRTVaYVoxZEJPckl6ZkdP?=
 =?iso-2022-jp?B?eGk2dEUzZGhzMVdTQS9IOTRab1dpdjJVUEVYa1MxQWpscEJGdlkzM1Na?=
 =?iso-2022-jp?B?WG5TUjY4TkREOGVidExlM2hsM0hjOUdXbkF1NGhjZU1BRDJYaWxRWHFh?=
 =?iso-2022-jp?B?T1U5MnVua1NkdG5iVkYxZzduU0FHR3J6bGlCMlZFcVp4ZHRjb2c9PQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d36c552-cb66-4a81-6ac9-08dac93262a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 06:59:06.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l08RXlGgZSuIxvXtpvw51hqVD1JYfvpO6lACDaHb1noV1iIJ0yq73YXP6OjJ5t3PUX7kUl9Dm+IMt578vACaMnE7C55BfP8Eup03hb4S8jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10464
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Itaru san

> -----Original Message-----
> From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Sent: Friday, November 18, 2022 2:12 PM
> To: Yamada, Masahiko/=1B$B;3ED=1B(B =1B$B2mI'=1B(B <yamada.masahiko@fujit=
su.com>
> Cc: acme@kernel.org; alexander.shishkin@linux.intel.com; jolsa@kernel.org=
;
> linux-kernel@vger.kernel.org; linux-perf-users@vger.kernel.org;
> mark.rutland@arm.com; mingo@redhat.com; namhyung@kernel.org;
> peterz@infradead.org
> Subject: [PATCH 1/1] perf: fix reset interface potential failure
>=20
> On Fri, Nov 18, 2022 at 11:00:16AM +0900, Masahiko wrote:
> > There is a potential bug where PERF_EVENT_IOC_RESET does not work
> when
> > accessing PMU registers directly from userspace in the perf_event
> > interface.
> > we have created a patch on the kernel
> > that fixes a potential perf_event reset failure.
> >
> > The motivation is to initialize pc->offset.
> > The perf_mmap__read_self function in tools/lib/perf/mmap.c is set by:.
> > cnt =3D READ_ONCE(pc->offset);
> > The pc->offset value is set in the following process in the
> > perf_event_update_userpage function:.
> > userpg->offset -=3D local64_read(&event->hw.prev_count);
> > hw->prev_count is set in the armpmu_event_set_period function
> > in drivers/perf/arm_pmu.c and in the x86_perf_event_set_period
> > function in arch/x86/events/core.c as follows:.
> > local64_set(&hwc->prev_count, (u64)-left);
> >
> > Therefore, this patch was created to initialize hwc->prev_count during
> > reset processing.
> >
> > Signed-off-by: Masahiko, Yamada <yamada.masahiko@fujitsu.com>
> > ---
> >  kernel/events/core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c index
> > 4ec3717003d5..296549755a9c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5468,8 +5468,13 @@ static __poll_t perf_poll(struct file *file,
> > poll_table *wait)
> >
> >  static void _perf_event_reset(struct perf_event *event)  {
> > +	struct hw_perf_event *hwc =3D &event->hw;
> > +	s64 left;
> > +
> >  	(void)perf_event_read(event, false);
> >  	local64_set(&event->count, 0);
> > +	left =3D local64_read(&hwc->period_left);
> > +	local64_set(&hwc->prev_count, (u64)-left);
> >  	perf_event_update_userpage(event);
> >  }
> >
> > --
> > 2.27.0
>=20
> Reviewed-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thank you for your review.

Masahiko Yamada
