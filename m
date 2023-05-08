Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E96FA0BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjEHHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:13:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A301D96E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcOZZG4QL/ay96t7woa9Qajv3OQhqsxwHrXvjwneohglQXjAyYDeHpdghLm8PzSIVrEyi6xpZvUlFd98ZIQnfpz5mWRun6tgaHNXNIGnfdu3UozliEjrz8KfEwTKsonETnj7l+qCnNBtQgvD9oKyVsMrKRzwQZhZlGmCXRJ/zMhGgXfv87O6cJkjgriaIKqv+pzLfH6pHvweJ2X5DD55pduLkYPQc9YKVA+SsikpIM3YZHEsLS7f97RWf6zC4t8uuCb10HiTJVeA8srWDte95XhI1u/LEGu0dKxYC2HSK7GLGM1gq9rXTnMt6C5bZkUugzpyO7fRUssHtDz2OJ38Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OcYPGSrsDoyDL4bZ6LZMu5SlsN1auQUyqPztR1BHjs=;
 b=P1gK5iR+m5Y2LwI7KSHiub85r6z1M0t+TNheA7V2GAMQPKHjDkVrFMAgpcWK7e8OX927PgSki5wLpbPnhEtaABNkufVWbbKSnOCkHTShiRg2a59YiK+vFvWAQ9IqG33mLa29O7tC8wVqzq0GT4gXQrFXkymOmNDLXYEasgginyO7AJRboEFk+aQoebxU+q1ydaMz6sjLnjtn5sS8qGMdGkX/YfyrIm4AAbADIAvYddqOH9J1ndNzIpd9roXsxj1smQzZFSMlwCGRWVsN0AlNrgGDTEpfYL+XDz9JLR8cvIfN6QtpkBtvqwNRoX2j73iyNxUYCbcsWbweGTuZHM+/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5498.apcprd06.prod.outlook.com (2603:1096:301:101::14)
 by PSAPR06MB4391.apcprd06.prod.outlook.com (2603:1096:301:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:12:51 +0000
Received: from PUZPR06MB5498.apcprd06.prod.outlook.com
 ([fe80::32b1:f7d1:824e:640a]) by PUZPR06MB5498.apcprd06.prod.outlook.com
 ([fe80::32b1:f7d1:824e:640a%3]) with mapi id 15.20.6363.031; Mon, 8 May 2023
 07:12:51 +0000
From:   Xinglong Yang <xinglong.yang@cixtech.com>
To:     "wangyouwan@126.com" <wangyouwan@126.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBjcHVmcmVxOiBjcmVhdGUgY29vbGluZyBkZXZpY2Ug?=
 =?gb2312?Q?based_on_ACPI?=
Thread-Topic: [PATCH] cpufreq: create cooling device based on ACPI
Thread-Index: AQHZeaHIdDEewE1pwU+d/+zgGxEu4q9QBQ2w
Date:   Mon, 8 May 2023 07:12:51 +0000
Message-ID: <PUZPR06MB5498319D81B4BC7F18412FC0F0719@PUZPR06MB5498.apcprd06.prod.outlook.com>
References: <20230428070314.225560-1-wangyouwan@126.com>
In-Reply-To: <20230428070314.225560-1-wangyouwan@126.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5498:EE_|PSAPR06MB4391:EE_
x-ms-office365-filtering-correlation-id: 4bf7fb48-23d7-4510-02c4-08db4f93a2f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kMheyjLMZ9//mpVt3Z5sLNybdHgCRTQkORyvyJeB9rXS8WQZqVCJpXKGv8X+sOKvY8gFuiXc3X9we4x5rMwm0L8JDjP/WqNMQ8VqLpJ1sGFg6MPb9dw62XXsU5p3M91jt2Ctl4ncKeH2kxtBYy11tgU8YB5Zrx2kNShLH4I/nUJWUiSh3j4kEdcxI96KkpWmiJS27xtS4PGoDE/NE29GgekYZd9zDx4Rt0/HZ99n3DaSlZmVakaYMdtrAAzjVInFJlGSsY5O5dQJd3x1cI023YDDFwJiEbZI0/WRlY5tzPOj3UiUhIv76QvAWx0E2+6RVA2AXkqZQ/IjYeoqc/Brc7bYpknMU4QoIUZO8QDQdt8b1sp/OWTKQRlY81R2UxnXnafNN0MTSNPEax3UfSlU+1+6oZmAZkF4YNnZ6ETvbOe5goEgb1ko+Z09sY1nx+yCE0li4b3KZn34B0HSACy9w/xLiCu/ZtoyHIUkUDRTSx41sIoLyOWyWMZiEPmr8YvfiwJ6H6LQUxniJrAgCpIww/b0gVJWebI83m85GtXIx43VxrpBuiagKVsDcS1gt8Ww2Z/pv6x4ntEPs3vPXil4OKHR4tysIifGmbGhW1BGwSd1wVV4P5a1NdRX/dxKnS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5498.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(376002)(136003)(346002)(396003)(366004)(451199021)(2906002)(52536014)(41300700001)(8936002)(316002)(44832011)(71200400001)(4326008)(6916009)(5660300002)(66556008)(64756008)(66476007)(66446008)(66946007)(76116006)(478600001)(7696005)(6506007)(9686003)(26005)(186003)(55016003)(66574015)(83380400001)(224303003)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SHVHbUgzMVVSbGJhSjlYaFhWWGJaZ0QzV0lpVysySDVSbFF1NGxIc0hFeDNu?=
 =?gb2312?B?Z0JBN2ZTcFZEOER3RTE1a1o1a3BJbHo2TnU2ZGxLcGZqbm9LeHlXWlBHd25z?=
 =?gb2312?B?cDR5d1o4MjVVdW03NklnWm1aRFppVXREQm5PSVJDNkp0Q3dHMm04c1JobFUw?=
 =?gb2312?B?dVZPazR4UW0zd0pZYXlDWGl0ZHQ1Zy9JYW9kWEFpTWlRUnJJRm9hMTJRSXRE?=
 =?gb2312?B?TUgva2RtdHd2Qk0rOWZ3MTgxQSs3TGhDQm8zbWNDVXlmaGRCME1yMzRBNlY3?=
 =?gb2312?B?bW5xRno4L1BHbldlSEpBQkljSjY2VHB6TDhMRE9nSGx4OFZvdlB0blpyRkI2?=
 =?gb2312?B?MmF0aXJlWW9aUEJwYnlhazErQ0c5a0hZTHdtRWFKYlBsSnFWUmpuZGxxbTVT?=
 =?gb2312?B?dzlmdEMvSVVFc2JrbUh6RE1ucXk4WlgzakFtZExFVzVmdW9sZlJQQnh1dW5W?=
 =?gb2312?B?SENBM1F4VzhVdkQ4Y0JCSzhqNDdxQTJQcXc3WjYwQnpVamxXZk9IdGpPTUxM?=
 =?gb2312?B?STFVcVcxcENpN085TFd6Y1VxYlhTajdpS01IRDhYQnczUzMzMVpORXNXTUdJ?=
 =?gb2312?B?czlSSmNVQ01YSEhGTCt0d0lBcThVT1pyVmY2UzJOTmNVZFJUR1pZUnpGOElv?=
 =?gb2312?B?K2tNWUQzOUc2SnJFa0lvMGI5dWVqUnU0Y0xzMTI2b00zaC9pNFM2WHBvc1RM?=
 =?gb2312?B?dlNwTmdOZlJjY1lUdERRN0F5UEQ0K2JYLzFVOUlWUWVzZU5oRXVtdlQ1TVZK?=
 =?gb2312?B?MUpKQVo1YWlST0w2UmpDbEpYTWJ5UEVQaUVlYll0czZRSDhJNzRxNHE5dzZI?=
 =?gb2312?B?OXFta1FaVHBNVkZyQlJVT1RPeWRvWDlQTEtaUk5tZUU4K3UvNjNzTjg0Nytq?=
 =?gb2312?B?aEppVGR2RHN2RGxxelZwU3l5NVJqQWxoME9Fc05MV0tOaXRGeVMwMC8wSU5w?=
 =?gb2312?B?WGJkUXoxTzhiS3htQ1ROY3M2MU5jOWlWbG5ma0psWWlUL2pEVVpjVVE5SXRp?=
 =?gb2312?B?a3RNangra1RkZndXTHNESERNRU5ZVldSOGNGT3lOcGVHTXBITG1waE13NDRz?=
 =?gb2312?B?UG1tV0VJQVVBcWxzWG82THYzcEl6MUZJUTlVdXpvOFlMYWhPc2tEV1dGMDFa?=
 =?gb2312?B?Uy9OZEYyYy9RYlE4VC80d0l1QmlTaVp4K05TNWY4RnhiQU51OXd5d0VIcHJs?=
 =?gb2312?B?OEJtRHBva3VEUStxdGtIbE5lanNwdmhxNThIbStyUEJtU3FrZ3U5dWxSWnpQ?=
 =?gb2312?B?cjNDcVl1UDcxeG5ubUhjc2kwKzJ0R0ozUElzclh6S1RycWdyN0gvak5qUy9G?=
 =?gb2312?B?RS8rbHNkOUxaZEZ1ZGV0TGhUTWM1SDgrb1dLdmozWTZMVWdRdkx4eVhteTFp?=
 =?gb2312?B?MExqZFFiYlRMRDFFR2tPcGxqZWc0dFJuRzJXWDhRaFRQUCtyK1p0L1dhczZB?=
 =?gb2312?B?clAvZXp0bkE1OFY4MFp2K0pwOVQ4ZHM4SW9EVVFwNnVicTAzU1padE0vb05D?=
 =?gb2312?B?STBzdzJHZDkvWUw1c2M3b3AzSk9PeitMWG9VQng3aHBTOUFiS2RXK290Qm9X?=
 =?gb2312?B?MU53aFc1OHdacUpUKzVKZWp3Y2UxeWh4Q1A0aFFBZ0MvRVlZSDVpRzg4NXYx?=
 =?gb2312?B?MER3YmJESGs2M2lOZ0VEZ1FGTnBrckFuWG5URHVOOVhkbGxQRExEVU9MeXJR?=
 =?gb2312?B?Nzd0czlKZ1liQXRJRXEwQUo4Uyt1enlQNFJWVU9UTkZIcXQ2cVNobjlUUzJI?=
 =?gb2312?B?ODUvcnBHaFJSemNtUzllY2wrWGtVMlZlUi9kSEZ5L2xFNEdndW1aL3VOK0lR?=
 =?gb2312?B?VG1hUlNXM2RWZU5CbVNSaVNSdGtpaHpmcG1oYVdZTWR0L1UxU2kvclRSUU80?=
 =?gb2312?B?dWhxeUhiRGZ2aE9HL0x4WjluRE81RDRHWlk5TUdSNjIzQ2FkN01ZSjQyalBu?=
 =?gb2312?B?bmZHUTRNdk5QU2orR3J3Ti9maFArVlBwZHBVeHB4bXZyQ0N5N0c2ZEdTVFc5?=
 =?gb2312?B?NklPa1hRQlNCU2NxQ20zSUdsbGpmaWRhSTZwSjhLQjJ2S21kNDMvZEFqWFFB?=
 =?gb2312?B?MUdwNDIvSENPamJ2S2Fya1lhTjhZSEgvMThBZEJ6a3hCN1Q1WVpONzNlY1pE?=
 =?gb2312?Q?SGybWOct01rxWjsqWO8YkUB2w?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5498.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf7fb48-23d7-4510-02c4-08db4f93a2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 07:12:51.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2uUFoUgfnzswblhvQRsmGGk/OKb51uXdggD4sF4udzwT8MANCy+VzmKs43EVQUo+zv3n8zQMpTY+qUIfXlf4IwPkc5ssjgmFgp5YRTok5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4391
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9lcyB0aGlzIHBhdGNoIG5lZWQgdG8gYmUgcGFja2FnZWQgd2l0aCBvdGhlciBwYXRjaGVzPw0K
V2hldGhlciB0aGUgZnVuY3Rpb24gY3B1ZnJlcV9jb29saW5nX3JlZ2lzdGVyIGlzIGRlY2xhcmVk
IGluIGNwdWZyZXEuYz8NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IHdhbmd5b3V3YW5A
MTI2LmNvbSA8d2FuZ3lvdXdhbkAxMjYuY29tPg0Kt6LLzcqxvOQ6IDIwMjPE6jTUwjI4yNUgMTU6
MDMNCsrVvP7IyzogcmFmYWVsQGtlcm5lbC5vcmc7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQqz
rcvNOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IHlvdXdhbiBXYW5nIDx3YW5neW91d2FuQDEyNi5jb20+DQrW98ziOiBbUEFUQ0hdIGNwdWZy
ZXE6IGNyZWF0ZSBjb29saW5nIGRldmljZSBiYXNlZCBvbiBBQ1BJDQoNCkVYVEVSTkFMIEVNQUlM
DQoNCkZyb206IHlvdXdhbiBXYW5nIDx3YW5neW91d2FuQDEyNi5jb20+DQoNCldoZW4gdXNpbmcg
dGhlICJzY3BpX2NwdWZyZXEiIGRyaXZlciwgYW4gZXJyb3INCm9jY3VyczpjcHVmcmVxX2Nvb2xp
bmc6IE9GIG5vZGUgbm90IGF2YWlsYWJsZSBmb3IgY3B1Ki4NClRoZSBjdXJyZW50IGNvbXB1dGVy
IG1vdGhlcmJvYXJkIGlzIHVzaW5nIEFDUEkgZmlybXdhcmUuDQpHbyB0byBzZWUgdGhhdCB0aGUg
ZXJyb3IgaXMgY2F1c2VkIGJ5IGNhbGxpbmcgdGhlICJvZl9jcHVmcmVxX2Nvb2xpbmdfcmVnaXN0
ZXIiIGludGVyZmFjZS4NCmNvbW1lbnQ6Y3JlYXRlIGNwdWZyZXEgY29vbGluZyBkZXZpY2UgYmFz
ZWQgb24gRFQuDQoNClNpZ25lZC1vZmYtYnk6IHlvdXdhbiBXYW5nIDx3YW5neW91d2FuQDEyNi5j
b20+DQotLS0NCiBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIHwgNyArKysrKystDQogMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgaW5k
ZXggNmI1MmViZTVhODkwLi4zNDE4YzY4OTU5ZDUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NwdWZy
ZXEvY3B1ZnJlcS5jDQorKysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jDQpAQCAtMTUyOCw4
ICsxNTI4LDEzIEBAIHN0YXRpYyBpbnQgY3B1ZnJlcV9vbmxpbmUodW5zaWduZWQgaW50IGNwdSkN
CiAgICAgICAgaWYgKGNwdWZyZXFfZHJpdmVyLT5yZWFkeSkNCiAgICAgICAgICAgICAgICBjcHVm
cmVxX2RyaXZlci0+cmVhZHkocG9saWN5KTsNCg0KLSAgICAgICBpZiAoY3B1ZnJlcV90aGVybWFs
X2NvbnRyb2xfZW5hYmxlZChjcHVmcmVxX2RyaXZlcikpDQorICAgICAgIGlmIChjcHVmcmVxX3Ro
ZXJtYWxfY29udHJvbF9lbmFibGVkKGNwdWZyZXFfZHJpdmVyKSkgeyAjaWZkZWYNCitDT05GSUdf
QUNQSQ0KKyAgICAgICAgICAgICAgIHBvbGljeS0+Y2RldiA9IGNwdWZyZXFfY29vbGluZ19yZWdp
c3Rlcihwb2xpY3kpOyAjZWxzZQ0KICAgICAgICAgICAgICAgIHBvbGljeS0+Y2RldiA9IG9mX2Nw
dWZyZXFfY29vbGluZ19yZWdpc3Rlcihwb2xpY3kpOw0KKyNlbmRpZg0KKyAgICAgICB9DQoNCiAg
ICAgICAgcHJfZGVidWcoImluaXRpYWxpemF0aW9uIGNvbXBsZXRlXG4iKTsNCg0KLS0NCjIuMjUu
MQ0KDQoNCg0KVGhpcyBlbWFpbCAoaW5jbHVkaW5nIGl0cyBhdHRhY2htZW50cykgaXMgaW50ZW5k
ZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2Vk
IGFuZCBtYXkgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIHByaXZpbGVnZWQsIGNvbmZpZGVu
dGlhbCBvciBvdGhlcndpc2UgcHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gVW5hdXRob3JpemVk
IHVzZSwgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhpcyBlbWFp
bCBvciB0aGUgaW5mb3JtYXRpb24gaGVyZWluIG9yIHRha2luZyBhbnkgYWN0aW9uIGluIHJlbGlh
bmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJl
aW4sIGJ5IGFueW9uZSBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIG9yIGFuIGVt
cGxveWVlIG9yIGFnZW50IHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyaW5nIHRoZSBtZXNzYWdlIHRv
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBkbyBub3QgcmVhZCwgY29weSwg
dXNlIG9yIGRpc2Nsb3NlIGFueSBwYXJ0IG9mIHRoaXMgZS1tYWlsIHRvIG90aGVycy4gUGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBwZXJtYW5lbnRseSBkZWxldGUgdGhp
cyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBpZiB5b3UgcmVjZWl2ZWQgaXQgaW4gZXJyb3Iu
IEludGVybmV0IGNvbW11bmljYXRpb25zIGNhbm5vdCBiZSBndWFyYW50ZWVkIHRvIGJlIHRpbWVs
eSwgc2VjdXJlLCBlcnJvci1mcmVlIG9yIHZpcnVzLWZyZWUuIFRoZSBzZW5kZXIgZG9lcyBub3Qg
YWNjZXB0IGxpYWJpbGl0eSBmb3IgYW55IGVycm9ycyBvciBvbWlzc2lvbnMuDQo=
