Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE166D67E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjAQGoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjAQGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:44:03 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 22:44:01 PST
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E11F494
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 22:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1673937842; x=1705473842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IVr4EMOh0nSwVXeUynaxIfDqxbjvDUa6v4WuBLbJEg4=;
  b=f2qK3M2dRhheRjmXKPYTGvUAbRS97Q3ZUC7bBKiOYrzeky1+XSmWkqsD
   bKmTKNKCi6DKGS39CVkEx5oWf4QVRS/fcpbOU9jCTUvL6+/q3+aT+SfNw
   PZYBu/RnRt1D3zWcBnXfDbkMw4LBdqDknc4ndDzXhsRX2Z3mYQ+eU0GhZ
   tUUxDJyU5K+4dO9Ip7kDzkPa+bIyCCS9/2nUdvD3kTHYuBfQ4Ej4RplKh
   axMvC0ijXPTbtm6sTqhMwbd+WljPoi8DICeiyWb3Ux+Hid78YEfj30SOY
   CQdUeROkLW0gVYxuFZj5Q73B+OUvSGcI2atyjXOOcK8SJ0XzsW/+4XsgW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="74693872"
X-IronPort-AV: E=Sophos;i="5.97,222,1669042800"; 
   d="scan'208";a="74693872"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 15:40:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP2YHXzC6sTdYPei25vGagL9Lgpo7ZBXomHBEGOe+DQwkRAs/CrneaMNbWaqWhi8NeFY6ncA5Y1U/75cTYKpZClKUExeRzujmQjB2k0+S+bqk5h4bk5A++jySuz7+F1n9OKsHpc2TYd9KLtMId+yhlJshmJwVjLvc1Oic6HkfSw/hxP7e3uyi1XGe7iwXYOc5c0/GDuGf10qVGTt3Zhw6iAquE7085+bbz3B4RDCgFtrhNrFhXXf0b9IFkQ5mnLtlRQli672qe/d/5mIoR6h/RtHRPRKMKYrzcKAsTwoHdjQF5rxnJCSra2Dxo2qZd3PyCDCqScVTuvo3sk9amEHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVr4EMOh0nSwVXeUynaxIfDqxbjvDUa6v4WuBLbJEg4=;
 b=fJ7GTh4uv8EvJYxLdDg2yB8ezVmcspi3VYCc2Bh4iuPbbb2eIuZRSIsUvtQW/8oI6ah0neo3n2Udg6bFvTW/71363a4/R6zNGp6QtYGTHhkxJYwIz2nfvF/pVrnX9WUzKNRRUvcnpz6uVS248vJ7XEhkUZlEOV5hKOYyVs3e2lGjnRSMaEFkHfdVtAhX7Lla3MPiKZZsSGMvOF0sqcNbJargVswyWinylD2/OGO/uWlEzvL/X2eyovaTPeLzydC2T2wW5ygZEVZA+nxjEC64CBwD2ZMK3iYnD9TB+PI6+2Cz7LhTC/vIOQfZqs+9Z6gLGDWgebfeBOcb2GX/wwhiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9269.jpnprd01.prod.outlook.com (2603:1096:604:1c7::8)
 by OS3PR01MB8288.jpnprd01.prod.outlook.com (2603:1096:604:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 06:40:47 +0000
Received: from OS3PR01MB9269.jpnprd01.prod.outlook.com
 ([fe80::5706:2260:7e38:c637]) by OS3PR01MB9269.jpnprd01.prod.outlook.com
 ([fe80::5706:2260:7e38:c637%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 06:40:47 +0000
From:   "Masahiko Yamada (Fujitsu)" <yamada.masahiko@fujitsu.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/1] perf: fix reset interface potential failure
Thread-Topic: [PATCH 0/1] perf: fix reset interface potential failure
Thread-Index: AQHY+vJyjO9qsHnX5UKkyuivNjC9Wq6igBeA
Date:   Tue, 17 Jan 2023 06:40:46 +0000
Message-ID: <OS3PR01MB9269B2010B90029682F9E78BF3C69@OS3PR01MB9269.jpnprd01.prod.outlook.com>
References: <20221118020016.1571100-1-yamada.masahiko@fujitsu.com>
In-Reply-To: <20221118020016.1571100-1-yamada.masahiko@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9ZjZkY2E0ZWItZDIyZi00MjE4LThkM2MtZDcw?=
 =?iso-2022-jp?B?NjhjODMwNTg3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMDEtMTdUMDY6MTQ6NDRaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-shieldmailcheckermailid: 596dd29e71934096941b84376f41b844
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9269:EE_|OS3PR01MB8288:EE_
x-ms-office365-filtering-correlation-id: 55933cf9-9b12-45fb-7735-08daf855c3f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BdYkzGQ1j5gPn9fxPfb0P8bL0+VRuKVeBVBCoXejz62/hIrodpYWciDY33LGf70QS7QdCXHyX/suVyOKngP8cbyBNBxuS2sESHgugrkgVxUfjRpiYqzcD0D4xtYJMPfqT+WR5MkQaHHZYm3TY5rMouQDdjZNnHXbYGbS2TEr7q8mLXJ1rk4p62CiS7tYG9p6h3A0gWVZc2koD+x5a3oGo7yk0prLojqm6xO3xG4wSSoEimTwAP5GU1qRbKg08tZV3UDb7UgnFTfWC2AxZDAG/W3P0cKX6PbOemj5Noj4ELsYloX2UbEMG/6zRO4xomtW9GKPtjyHW5nbJP/9Ah7Iy7ymcIM4BCjHOR7hPQPYErESwcmkAKAeEZpde465JlEqN22Nvuya5AZIq6uEvhYXiAVHeF2RzbTMo3m4bnMsaI3WdQWlh7K3ZoH+vWJxWl/TLq11Nw6W57GwGYQRTY8RMflUL1SdlhBeT68KqnHrYHHrGHG3MwOQu+sGQqH2xL/wvJKLEBAZhe6GAxrTJcGkbjL/purLX1bZPkZzlPmkTJSZ5pW4v45oe5Q6defoVkXjPUA1rdw3l6vbeGOAxJnwHhQmCg1faQLVOE0qOetvhRa0pbotkJyMjHFr3DbJPN0HYQgI/Q37/3TBBzZ3YGuF2J29QMZHPnWgiyrFwxOndKVFJOc1kZ+ilgesjvuutuOpdnL/Ryr/epJ3oBgqKSQAug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(1590799012)(451199015)(8676002)(66556008)(41300700001)(186003)(122000001)(66946007)(5660300002)(52536014)(76116006)(66476007)(4326008)(66446008)(64756008)(54906003)(82960400001)(38070700005)(1580799009)(110136005)(8936002)(316002)(2906002)(86362001)(38100700002)(71200400001)(85182001)(7696005)(478600001)(9686003)(55016003)(26005)(6506007)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?U2pBV25vUzBBaHZNWDNnelhEWFNPSlBqQlQxbVNpVDBBMjJYYmxtU3Vp?=
 =?iso-2022-jp?B?c3BPczhsOS9rYSt3UlNFVy94V0t1RloxSEVjblBqclhGcXFWUEpEMWZx?=
 =?iso-2022-jp?B?SENRUVhBSUZmaEo3WU1IWmJpVVNwSVN1Z21pVXBJcnk0UE1SNTBmcGFG?=
 =?iso-2022-jp?B?anp5V2kveGs1SjRLOTgwK1R3ODNrQ0hZc05xTUtrczBlOWYxak1LeWpu?=
 =?iso-2022-jp?B?cGxobEpQUytiZmZmSWtFb2x0TFZreGhDVHhHa1JGU0hRU25EMTl4c0pl?=
 =?iso-2022-jp?B?a25XYzJvTWlsamJjOHVOeFhaQ1JJU01ESnkvbjR3cFdTQ1l2Z0x1cUJo?=
 =?iso-2022-jp?B?NURQRml3aEVMeVQxR1VhY0JqZ3cwVkdGZmlUdG4zVDVKRC9Ra2c4MVlx?=
 =?iso-2022-jp?B?RUpPV0g3NWNOaCtJQjNSYVRqWklMUVdKNnZ6Mnpwa2tyMlBLczNyZGRH?=
 =?iso-2022-jp?B?RFByVVBuSGRJb1kvRWhYdWpGY3d1R2tNQTNQU0pGQTVrZk0zSmdCWDQ5?=
 =?iso-2022-jp?B?aUNqT1VSY05HRFdkakJWdHIxcXVhYlZxYUdCOEtQbWE3Zzh0a3F1SVYv?=
 =?iso-2022-jp?B?aDlKMGhhcWV5RWV4VXNNcW93aDNXUXVPQVBZU0JrTWF3cG9YSjNwdC9M?=
 =?iso-2022-jp?B?NXhocUtITDZVeW03am9idzg5clQ3QWVkVTQ1OFAzZ3hUaFlTQmJ0OEV6?=
 =?iso-2022-jp?B?c1pEd2Z5ZTBGQkh0bllrWUYzTE0vQ3VNOE9paFN0UHNQbkYwRmJESExy?=
 =?iso-2022-jp?B?YTFGcEZNSnJNZzUvNHhUWkpyMENGZTRjbDZJY1o0bm1yYy9vVGF6RGNI?=
 =?iso-2022-jp?B?aHd4WVI2MTJVSzE2VEhkRVcrSHFIQi9ySzN6aWI5cWtrNG0zK3VCT3hZ?=
 =?iso-2022-jp?B?RDl6YlJJUmxiZGt2RzhOelRLZEZPY1N4SjFMa1Q5bUdUdTV1NnJaNEU5?=
 =?iso-2022-jp?B?eXdKNmtKbUFCb3hNR2FsVjEzU01LYVp2ZU1VcTBhbnBtNkljd05qcEVo?=
 =?iso-2022-jp?B?NWFYMlZWQnVESm1zQVhzMS9hY09aZ1ZvRDhCcWdVTmlJK050YkprWUxp?=
 =?iso-2022-jp?B?bS9HdHlEZUVHU1pacmJlRDlLRHdlYXV3TDg5OVh6bHh5R3BOTU5mblNy?=
 =?iso-2022-jp?B?NG5rQ2hQbmg0TjZ5bGtlSitydk4yY3lTSGlPUkozYmhlam03WXhIZGtE?=
 =?iso-2022-jp?B?Um5KL3dDMlY4ZHBpMSt2cEpONjkybEVsYUVJc3dzSjZYTWxkMncyMHRK?=
 =?iso-2022-jp?B?U0pldUlVVU4vRWEzVi9GUHBtTnNnLzFrelpLM1MvTGNGOGpGZFVGSk9u?=
 =?iso-2022-jp?B?V1JwRXY1T3FsaWkyL0hVYzhyb2UxTGo4RTJNU1l1UVcxRGNwNTk0QUt6?=
 =?iso-2022-jp?B?QS9JZFlWYTRaNTdydlhzSFBFTUpBczF4ZGJDaG5XeEVYWm03L3lOdVpr?=
 =?iso-2022-jp?B?bmU3NnhIY0xFdmlOOU9DOHR6VkdzbkpQaTlWYUhVc1BmcmJ4RitDeDI5?=
 =?iso-2022-jp?B?ODFEVTlpRlJaMjdyVjkwaGk0blVEQkZYMHh6dE1GYloveDA4T3grTnVT?=
 =?iso-2022-jp?B?WUJDT1BMUTkrOVRXaUpXRk5MWmw4UjlXS2pUcmJQUVFPWWhqQnZlRkxl?=
 =?iso-2022-jp?B?TGFkOFhkTlJtMkhoNHNvRGJVVXp0VzNSMjdXaEJMUmY1cENPN1ZtOS8v?=
 =?iso-2022-jp?B?dGVvUWlDZTZYbStMTUwzZm9UYVNOM3VlL1J6TDdYUTFQODZsYlMvMzRn?=
 =?iso-2022-jp?B?ZUpIUG9WTjhRQnJoQkQ0Wlk0TkNXUHpqVytRTmlTME5qdWhGL0Ewa203?=
 =?iso-2022-jp?B?WDF3OWNNWnA1d0lzdkdKZnBGZmVJT3psUm1UYmVWR3pOMjlxWVJKOU9a?=
 =?iso-2022-jp?B?NEptdGxQM1RNQ0dNVnMwRUVoSjd3czRlc3FjOG1DR0NkeEpYdGdBLzdl?=
 =?iso-2022-jp?B?aHNUTkpWMTB5ai8rZHY0eVNqMGNwdGZacHErZGdib0R6QlBqQmh4WFRy?=
 =?iso-2022-jp?B?QlJiNHozcG5aQ3AwSXZRMlNCWDZKZEpyUmM2VUdBZDlDVTlCQXlHclBF?=
 =?iso-2022-jp?B?bi9EdDgrUDN0VjN4d1JmKys5V3NnZ2VwMStQRUs0c083NFZLZDlLWktE?=
 =?iso-2022-jp?B?NG8xdG0xR0tGOENLQVB6bzhLY1pVSjF4ZjlYRHNJNnZpazk5Z2ExTEVo?=
 =?iso-2022-jp?B?Tks5YXFGQ2RjYzQvMitzMjA4WFIyaWdoOXJFQ2twcUptZVQyZVZySEVj?=
 =?iso-2022-jp?B?RE1URzVFbmh0M1lOODNZMmZZYWFUSEJFZjJRMDl2dDZRTDg0VFR2Uzhi?=
 =?iso-2022-jp?B?NFB0R1FWZHNDZDJ3OXNTcUN3UDRqbm03WUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?ZjN3WkVHaUUvTjVCc1I5a1oyb0Rra3RVVEpDdVZJVVo5ZlJjNEdSeHRB?=
 =?iso-2022-jp?B?MnFXRFVzdU9uazlzdmhrMG8wUm5PZE9BRldsVHJrK2o2K3NQZDZ3ejMw?=
 =?iso-2022-jp?B?Wm1ocy8vWElnS0I1QWNkSzh3Y1RKbkJhLzVLZWVLNi9seUVnOGZuYmxn?=
 =?iso-2022-jp?B?QzlBSWZlRTcrSTdBaW5QbkQxK0kwNjlkSEJMeUFmcnQ5N3FBMVZkRHda?=
 =?iso-2022-jp?B?ZTJPZk5vS2lYZXplVUVkTytadXpXNGlkRVdxNGdZY2pFbXoxMUtRY0V2?=
 =?iso-2022-jp?B?czZ3QlBZdnVNTE94NFo0LzFpTWRMWmk3Z1EvTzUwU25TOHRLeUQrQUNF?=
 =?iso-2022-jp?B?OGFaTWJaYVdWbVhYd3NCQi9rczIyR09WU2FjWDRDNmdEQkpHcXJEUXlm?=
 =?iso-2022-jp?B?eG5rNVFETStCODVxOGhLeW53YjZsakR1RXpJTnBGb0EvRSt1VDhBSk9X?=
 =?iso-2022-jp?B?UlpJMFZJdmRBVEJza3lYSlRXZzRsTlM1SjgzcXhiMitZZlJUZjV3a0E2?=
 =?iso-2022-jp?B?emNrb0V3TG4vTXczTkQ1R0xYY0tSYlFPcURycGRvYlplNlM4dUs4VnYz?=
 =?iso-2022-jp?B?am55R0FyRFY5NFhZNjRJZitJWXRqN0l3ZmFPN2NiVTV6V0cxbys4QVE3?=
 =?iso-2022-jp?B?SmpNSTRpZjhEbXpMb2pjNUJSNEJNM3V0bERuemVudXpNZzViTFpPYUg0?=
 =?iso-2022-jp?B?RFEraHVYaTV0MmY5YjNiR3JPUWw5R1BBSjlRV2lWUm1ZNm4rc2hBR0VQ?=
 =?iso-2022-jp?B?amY3eCs5MnJ3NTVYN1ZnR0h0cFd4d2xlNDBzcE1zYWhidmwrSmdmY0NC?=
 =?iso-2022-jp?B?YkIzMW9WNC9ZMXRqMmtibXJtNWxpamVYUnl6bnpsS0dpLzFlUmtvc2ZN?=
 =?iso-2022-jp?B?TVRwT2d6UjlJUEdXbGJTRGRCaE1rbkJHNDhJMVBnSDRtaW9sNXg3Rkt2?=
 =?iso-2022-jp?B?WVJwR3BBUkxXVWhCd3I4a25tUkpGVThzdkxKYW1LN3RFSlYybmprWSs5?=
 =?iso-2022-jp?B?NnFWeVprODFiSXNuS3pUbFZsc0FoSVNkSzhzdUpNZVYzdVFpVDIvY0dz?=
 =?iso-2022-jp?B?S3pjc0VITnhVZ09rLzJ2Z2kyR1BRT3ZVV2djV2pWdm1BWHFqNnJ2eWNO?=
 =?iso-2022-jp?B?WFpHRjBzbFRienZPWVUwRHRSQ1Y0RzlCUG9qWmIwTnZXSDQ1Z3EyRnBy?=
 =?iso-2022-jp?B?bkdRZFlmcndKTlowdVdENmZvY2ZUM0d3ZTc2RTVHSzhuYXVOZXpXNngx?=
 =?iso-2022-jp?B?K1hTMkxCYmZERnFTdjRSWjVuMWZqUDErT0RKRk0vWHpIL21HdDkxVkZy?=
 =?iso-2022-jp?B?b3ZNOUxNVE80bk81RW5KYkFFUlNSaklPMENvSkdwQjlwNHRl?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55933cf9-9b12-45fb-7735-08daf855c3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 06:40:46.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8e7K6OW3Jr57Vab93poMYAVKc4YzmbFXMAddho/WRKMZwFT7HXwf4SbfpqFNkS6hyNahhKjkLML0BE/NNrq1CXJUNUemHOASyMG+hHCIUy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8288
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

> There is a potential bug where PERF_EVENT_IOC_RESET
> does not work when accessing PMU registers directly
> from userspace in the perf_event interface.
>=20
> In the x86 environment, the kernel(perf_event reset handling) has a
> potential failure, but it works with the papi library side workaround.
> The PMU register direct access feature from user space was implemented in
> the perf_event facility from linux-5.18 version in the arm64 environment,
> but it does not work with the workaround on the papi library side in the
> arm64 environment.
> The workaround worked in the x86 environment and not in the arm64
> environment because in the arm64 environment, only CPU_CYCLES was
> a 64 bit counter and the rest were 32 bit counters, so the workaround
> cleared the upper 32 bits of the value measured by CPU_CYCLES.
>=20
> For this reason, we have created a patch on the kernel
> that fixes a potential perf_event reset failure.

I have not received any comments or objections to this patch so far,=20
but could you give me any comments on this patch?

Best regards,
Masahiko Yamada

