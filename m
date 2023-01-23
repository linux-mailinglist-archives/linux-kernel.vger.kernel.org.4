Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2412C678BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjAWXGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAWXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:06:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F8AA;
        Mon, 23 Jan 2023 15:06:47 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NMZe7D009120;
        Mon, 23 Jan 2023 23:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=5gYuE8veQ5aE3SA5IZpHewboiNWdTKhp8lMV3nZAZWg=;
 b=AUAZdgWNA5tqFLorKqkjqbvTtZsqIbWZvKj9PBQTQ4b7Mts27gnColxJFcbYGobJejkD
 YsTfqahdMTX0XVKyXhe98Di2A9oqkxA4FLzPXgWkpTij0r0HrlCzw+kcKy3Hb6SJBE50
 /jCX0bl3cEFsdB4er0/Y1pH+lrfYD2uX0ams+jfbw/JT55yS5+fBQfEku1sCuEVgpj5/
 pfCLL6zNvpNTsIkMWdPZoF0POsBxh1vvT+ihc5c9K97f1XZo+AEWaTE2sQD4ip4OtUPm
 FeK3z3c1v47ijnLSTlvxrSR3gwsTF181ABKj5Fa0jEo0EBGz/LK014UFIUXdgVO8iPJV SQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89fm40cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 23:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0cuUIPBYrb6FqO4lMj+MbpecbtokMAwNCb7s+tA4LpDGcqydLplKCJg7EnbvBY6vCKojK6OqVMTpeAtUjVWo4ol4CcjNvpCvrr++Uya4KTV7aRQiQ229Rp+RRSZ6w+7gaSZVR8BVFznpPLLovvWgiij9niqj5ZPW/3XO3nccNtqfaPYIa2d8PKo3CRfEX9yu1sS0QIui8WMPs3m7rsYSm1L+tFTHAQ8CJPzjoE/uli3PGCu0R76ho+vnjNMpinxU//U/BixhAYZMzhO2zwCJg2+ws0CoRowH25rdRPIRi0hm59zCbdz294iMDcjIE1/FZynHYjYeQl0CNQ99V7VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gYuE8veQ5aE3SA5IZpHewboiNWdTKhp8lMV3nZAZWg=;
 b=GiEK2Lzm7+XbHIKZJyqLemKHitGI78rAGkni/j6xxypXeXiyvvbO9sv4eMYf1iJe3yF3iRnA33Vf5kkbLAyJKRoOWXXMm73buD29pBx2lfSBB1QidyUnFyxIgknA2d4/2QVJCQNs2XGzYn04aiz3E3ckHnsbDz76ebYE+M5Rs5yUAp2MT5Kx6jRXuDtCtQMKzTQzQXbGe5E+rNR5Lb/MMPpR70vGmtzgVOI3Mvp5egZyCOqGOEEDSMTyeJ93y0blIZT8RkPiqmVJaz4vWd5ECij+sqp5gVWYxTbFqmdpknnjc8hOzPZA1nhG5XY06Kr//vwuhZJcpmIfeHp7Ym0iZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BY5PR02MB6754.namprd02.prod.outlook.com (2603:10b6:a03:213::18)
 by DS0PR02MB9620.namprd02.prod.outlook.com (2603:10b6:8:f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:05:57 +0000
Received: from BY5PR02MB6754.namprd02.prod.outlook.com
 ([fe80::cb70:20f6:e10b:7223]) by BY5PR02MB6754.namprd02.prod.outlook.com
 ([fe80::cb70:20f6:e10b:7223%7]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:05:57 +0000
From:   Trilok Soni <tsoni@quicinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        "tkjos@google.com" <tkjos@google.com>,
        "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>
Subject: RE: [RFC] docs: embargoed-hardware-issues: drop stale embargoed HW
 contact for Qualcomm
Thread-Topic: [RFC] docs: embargoed-hardware-issues: drop stale embargoed HW
 contact for Qualcomm
Thread-Index: AQHZL3uHWegWxNR5gku8NyjsfmrvyK6sn0Ag
Date:   Mon, 23 Jan 2023 23:05:57 +0000
Message-ID: <BY5PR02MB675447B5DB615762D339736BB0C89@BY5PR02MB6754.namprd02.prod.outlook.com>
References: <20230123222220.405622-1-mcgrof@kernel.org>
 <CAKwvOd=uah7DxBfkLMnhS1hYRZxHVnW5z++auRYhGWbKZ+C0Qg@mail.gmail.com>
In-Reply-To: <CAKwvOd=uah7DxBfkLMnhS1hYRZxHVnW5z++auRYhGWbKZ+C0Qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6754:EE_|DS0PR02MB9620:EE_
x-ms-office365-filtering-correlation-id: 1bd85b69-10f8-468b-33c8-08dafd966312
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7d6KFOKsnr7pj1Sm/KEnHCUvjhVv2lakmk8hdd8MkWvtzdq6SWvVNHlZGt3HiqxCWvn91H3TokEyhuENHIoFAB/k0gmtkRhN+oCj/sf9lp7VbZf3x98QYD027z+h2PfH35mjYNEwOn0W9Aqqaq8EWxansDM8Ka2/YAZeobHruUaywQVoCOvY7tKPGrO/5ha6YfNqvH5NM0QkvbmWcl3+l2/9VbBXDxzgKjeyVPn7uWf1gyUrkZl3BlwpThbmfX7oM8zQVtlfP9cFpMqme+N/fQu/a/h1ewJY3EIo0FaVOmuzZi5O7NW4zxafSBZ/B0tx9rxy9t2ZsHY91iPuWTDB12T+7dFVytj/kvGgo31RaqwnSe21lfqcUlZSvs/wkz0SkVIhDsHRBpNIvfjTFqAc5l5CIhJ/APUU0EhIoUE38ueZtONi51/5wkWD55gc6FNa5JJGMqp4Z86Uvoxz+B9Q8g8LxZZtfDNJr10V3bPuDgnjiV4/0DiHdqsNz1hSRKizwgyqIDp4uRPHgjlsG5wMcIah+/RbagC+Ai7x7H4n2l49NXmLM1/jV4iYB6CIiRpfb1tpiV3U9PO7SidBrftMqbPEVTN782SGTs4nnd4VyIrLk/8BkTvGZmHyQTGhq4iFTVFCqm/1fPbkFkBovXz33z7K+RoZsG6FJ+fZFQnuP46Qq91AXGjrujdBwQbYMFq+WtGtJr8w0W1y1+xtH4adg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6754.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(83380400001)(38100700002)(122000001)(33656002)(38070700005)(7416002)(41300700001)(86362001)(4744005)(2906002)(8936002)(52536014)(5660300002)(4326008)(55016003)(8676002)(26005)(53546011)(6506007)(9686003)(186003)(107886003)(66556008)(66476007)(316002)(76116006)(64756008)(66446008)(54906003)(66946007)(110136005)(478600001)(7696005)(71200400001)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJFR0RLeDZUWXBvTk1ZcmZ6NFE4OWpqUUIrcEZ5K3lDT0xyMG5TMnp6UWhz?=
 =?utf-8?B?bG9md0FWY1grNEpvdDRQUXNiMllwY29aR3dqTzdNOUNxMmNyV3hhZENtMU5Y?=
 =?utf-8?B?cWNTaWRkcXdPM0RnMlVOVEtZUE5uNUZBMWMraGlWUmhJSlIxZzV3d1ExZHJL?=
 =?utf-8?B?TnBiREdERUFPYUUrTC9kTlZqMVFLbUhOU1hYNUZNU29MdzhpS3dTaitZQkhQ?=
 =?utf-8?B?dmZkYXJoVHp6MDYyZFZXVHFSN1YvSlJtTWErRm9Xa3lEbXU4ZlpLeEJ1QUxh?=
 =?utf-8?B?WXU0RVp6bm5wSlBBUUdGTXNENTVqTXRyWnZSVm5FZ1NBTjZPUmpBb2tva1hy?=
 =?utf-8?B?Ymd2K0pIUmQ3bEZTY3VWcVlnU3VvY3VqYkNrRCtJd21xUURLMDdwaGQvWHFT?=
 =?utf-8?B?TTdqRS9RK24xV0x0NHpZaUMvU1JGL1lRbTZ3TzZEbXgvQkNTMEFXL0UvU2o3?=
 =?utf-8?B?a1hza3VQWjczSUNkY1FyUFVyTDUvbVVXUG5ZMXBjSzFnYkUrS1JqNUVycVB0?=
 =?utf-8?B?c0c5aFRUU2Jvekd6SjhDeEZLc1E4NmxRS2grd2pRaXpZZjFrZGNXQ0pjN3gr?=
 =?utf-8?B?K0tRS3hRaStCQnZWOUZuS24rZHBTRFpqdmlqc3FyRENuc0lmWW44d01ncWFX?=
 =?utf-8?B?UDdNLzRxT20yZlFpT29oc3NERlVvbGZ0QUZyKzB6bjFTR2sySmkxbHo0OWFn?=
 =?utf-8?B?V0I2bFU0WS8zOFEwSy84WVBueko4RjZTY0tKaU55RWdjTGZ0aTRENG5YQWZn?=
 =?utf-8?B?cHNFNU1vRTI5S0dRT2lkL1czYkxUUEsxR0sza200RnVKU092YVV5SHRjRmFh?=
 =?utf-8?B?WllJRCtoaVBLcHNTUTQxcXdTYS9nQm81bW1TdVd6QmZMTnY0bmFmWGRmVUZX?=
 =?utf-8?B?VFVObzZzTkJ0cWdFRm5mcUpQbUx2MVlFaytJQ0o0STlJR3owVGNEOWNoekpn?=
 =?utf-8?B?U2owZDI3RFBvS0JFdmRTdTluQmRYVmQ5cUtNSFROak5KdFZ1S0p2Z2VZb3Ur?=
 =?utf-8?B?QzJJMVZmZkJzNTdkYWU3dE80S2tTTGcvTEs0MW8rKzhMRjRVRWkyV04rMW04?=
 =?utf-8?B?dm5xU1kxTzhOVk9lM2l4QTNhSGpVYm1oL2FuMjNTcFlnU1JITFVzZVIvbUpn?=
 =?utf-8?B?c3RLUVFuOU5INlUwQW92OUVmdnMwOXBGSXBYK0Z6THFrRmh1aklPOU1sWGVW?=
 =?utf-8?B?alYyR24zcWU1SmN4VTQva012SGlrOXZlNi95NFd1em8wMlpQYVlVTUh0UmVx?=
 =?utf-8?B?cE03NDdFcU55aDlXZVdXdWFvdjBVaTRZK2hubVlISndJNVhFRTZyejE0Y1BE?=
 =?utf-8?B?TE9YM3lDNVZJSW95OVhsbXdSMUlIRThZZVNXR0VTWlcwbk0rRkRIZGkvMGUr?=
 =?utf-8?B?ZG9mdDdVQ29mYnFiUFpNeGIyUkNiQlF1a1ZiT0RPSzcwdEZuZEZYZm5SSk9O?=
 =?utf-8?B?WjNyaVE1VVFDd3pOdmRRQVNRdVdWazljS055MVQ5S01NT0pyU2kwYjhxQlBQ?=
 =?utf-8?B?elcrZU9VSUxiNlRSb0VBTmFLSUpYcm9iNlk4bUNISEZndUx5bVJiMFZtd0NE?=
 =?utf-8?B?Y3ZnNmUxSGVPRjFZL2JiSXZ1Wng0b2tmc1Fqbjg2WUI1UVBXMkw5ZG85QWw1?=
 =?utf-8?B?alBzeUlwMGNDbHJraDNvU0lFUHN2RGVyS3dGREx1WlBNVllDSnRZVkZ6R01o?=
 =?utf-8?B?WHdrb0VqRFhWQnQwWk5vS1lHZjNITTFyMVA0UjQzTVFyY09XU2VObWJ1Zmt2?=
 =?utf-8?B?Q25HcGYxSWZaOW5Yak9DUDQxRkQvSmVEcTFxckFYZjVKSElKUDdubmtoc0lo?=
 =?utf-8?B?N0k3ei9MWG5HUEVhUGpuc2VIbCs2WDMyeGwxblcwTW52dUNTWllGaGJuMEls?=
 =?utf-8?B?bGxzaTZpZkp3R25wN1JtMWhRaDJIUmM5UUVGQzB1ZjhpVVQwbnZoSUxhNG14?=
 =?utf-8?B?L2ZTdW0yNEVsMUdxQk5kMDU1djliQnhoZk80bDhwN1V6Nmxwd2MvVk5sakdp?=
 =?utf-8?B?c2tMZEp5Vlg2MEUvV2xkRFNBTXZXYkRMa0RmdEFlaE8vd0RaSy96RUpNTHBL?=
 =?utf-8?B?a3RqdFk2K1prRGhYU3ZqUlBlaU1UU29QZkJCTitOVmhldUhBZU52NWNESWRK?=
 =?utf-8?Q?WcHJO0lY66lv7pD6FiC5qQR2q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VlYzK2lXZnNFZUphU3p3djFub2ZEaXZNc0ErcW5QbWlrenZZYytZVUF1SFVT?=
 =?utf-8?B?aU91SlRCcHdqbFcza1FwZjVjV0JjcmtaR0E0NjBka0xuMzFqTHUyVnplWkJU?=
 =?utf-8?B?OUN2bUcwdWpkemlIMnM5WmFCSGxST3I5TCtGdHRUSENCdVNjTk5OS045dDdL?=
 =?utf-8?B?YUVyK2tvNWJ3S0NEa2dVdjVlL3RiRjZqVHlOL2RGN0h4c2dBZkJSUi9HUjlk?=
 =?utf-8?B?MThRMWhldWEzY28xOEYxWk4zV0IxQjVDcy9SNlhxTVp4Vm9NVldLaFVWb0NZ?=
 =?utf-8?B?ZWM5b0l0MVBFNGo4UlN3emJZUlNuaE0wRmJGNmNHeWFldzNCV01BcStEdUcz?=
 =?utf-8?B?bzd0bldDRXRZMFgxOExUSTM3R2JTRjJSV2F5NXJnQVdCQnliMlpValI5K1JQ?=
 =?utf-8?B?MkNtWkFKK1RhVkMyVTF0bXE0eXVxaU01akw1OUZ4WWh5WnpOWituMjExUk5H?=
 =?utf-8?B?bnhSQ0pjUjE1dlpNYlE5cVh1WnovTk9kQ1dpcjhQam1UTDdleUxmZkhtc2Jl?=
 =?utf-8?B?V1ZvQldzUkZCcTFZV3B4ZkFJN0Zkc0xBVEJHUXM3VTBPY3F3aHJERzRoZ2xC?=
 =?utf-8?B?Y3ExM2srZ25wd29HYWEwSXJVS3dQNjRCNkFibUg0SHR4QVBBb3JBRHRiS1NO?=
 =?utf-8?B?K0RNQTFFRnI0TzM5b3oxbXRQeGM2NmVKWTZ1UnI1L0xIV1BRYmgrRVQrZ1R4?=
 =?utf-8?B?c0RuTm84QkY0YXM2eW1tWk9tdUtOcUkxRThabTNOa3dPZklBazlKQ0luZUg3?=
 =?utf-8?B?bkpRMWdvZW9FT29aY0RySGdNRnlQMEhTellFL0czeU80Y05GTHl6eFdWb0Fx?=
 =?utf-8?B?YVdUbUJIckoyb3EvUStsMURWbDdvWDhnNkw4UlJsS3BSQVFLSmlYN3ZJZDJM?=
 =?utf-8?B?U1BlaHQ4Rnp0VytrUWxZN0ZlQjAwcnhnYjNsRVlFZzJ2OFkvMWYwSHAyeGV1?=
 =?utf-8?B?VmtXeHRHVWNiS1JOdm92ZExUR2I1U2pibnd2cStJOHo3VlBhZkQxTlJ2SnpD?=
 =?utf-8?B?WmthM01iSEZ2VTQrVEl5LzBLWlpNcXFGS2JwSHpHTmo5N3RidTcvR1A1Q3Zz?=
 =?utf-8?B?VTU3bE5GSEovSzFHMm1lWnNvYjV4VURPTDR1WjVmNDVRa3Q2bHlQSGlvMUsy?=
 =?utf-8?B?eUpXL0d6cHZZY2kxMXl5R3k5eERQekp1ODVjMDJKbTJOQWREb3NhQlB5d1BS?=
 =?utf-8?B?bERmY2RXbmh5cXVra1dlRDVpbUpyWVlUYkxld01hSTkrY25INlVVZnZ6KzZz?=
 =?utf-8?B?dkVzeXQvMkJ3NzZPbzYrbEFFTS82SjZrV3V5ckIxcUs3N2grSWNnR2hBcnRO?=
 =?utf-8?B?OHY3NjJCMTBJdTBGRkh4ZkU1VEloZHl1blNtbDZTSkpmLzc3bmhlZHJYRVYz?=
 =?utf-8?B?SFhYWHBXRmlpOWkydEZtTGhLbnc0SXZqL2Y5dUVaMVlQc1JIVkZYR09RYy9m?=
 =?utf-8?B?ZkVBMXE2Y3VWRmEvUVo1Q2phNHB2cDRUTjQ2SXFjZjNaeHNNRGROTm5OcXBL?=
 =?utf-8?Q?ishwAQ=3D?=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6754.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd85b69-10f8-468b-33c8-08dafd966312
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 23:05:57.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32uygsZAIjlTQNpYwLSDKOUMH2JEy/jL50cfK+QhxinsnHed2FPGvsXtMDtvDEQ8Q7OAq9Ue96A/YkZtmpiCsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9620
X-Proofpoint-ORIG-GUID: D-aO9-6ArwvP8443h0KqAPN71_-4NCbY
X-Proofpoint-GUID: D-aO9-6ArwvP8443h0KqAPN71_-4NCbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=562
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMjMsIDIwMjMgYXQgMjoyMiBQTSBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZA
a2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+IEVtYWlscyB0byB0c29uaUBjb2RlYXVyb3JhLm9yZyBi
b3VuY2UgZnJvbSBkaWZmZXJlbnQgc3lzdGVtcyBJJ3ZlIHVzZWQgDQo+IGFuZCBMaW5rZWRJbiB0
ZWxscyBtZSBoZSdzIG5vdyBhdCBMaW5hcm8gc2luY2UgMjAxOS4gVGhhdCdzIGEgNCB5ZWFyIA0K
PiBnYXAgd2hlcmUgZW1iYXJnbyBzdHVmZiBnb2VzIHRvIC9kZXYvbnVsbCBmb3IgUXVhbGNvbW0g
aWYgdGhlIGZpcnN0IA0KPiBib3VuY2UgaGFwcGVuZWQgaW4gMjAxOSwgYnV0IEkgaGF2ZSBubyB3
YXkgb2Yga25vd2luZyB3aGVuIHRoYXQgDQo+IGFjY291bnQgd2FzIGRpc2FjdGl2YXRlZCBmb3Ig
c3VyZS4NCg0KSSBjYW4gc3VibWl0IGEgcGF0Y2ggdG8gdXBkYXRlIGl0IHRvIHF1aWNfdHNvbmlA
cXVpY2luYy5jb20gLiBJIGFtIHN0aWxsIHcvIFF1YWxjb21tIPCfmIoNCg0KLS0tVHJpbG9rIFNv
bmkNCg0K
