Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E965663BA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiK2HIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiK2HIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:08:43 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0D391F7;
        Mon, 28 Nov 2022 23:08:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOwMHkrBOyqq80Y9cUfrA6WZNceUz/S+lh3BOWTF7FjWFyjUlvwxvBiIpUje0yWAnK3l+lcbu+n7vhylxMVpCoUDhdxk93Yl428MpDNr3J+htMKJljeqfrVg8CXvMRIxc54QS8nzB0xgDJrRdrjXC/J6ZwXNGBmiTyVB0Gu+1mZB5XiEfmttxEuBWCEGjtPpKvT7uwLK58hgi+fHu9dOunboaWkplkY3nAAFLn+juwvAWKHxEsTEj4KxmOv4zDj3nOnKIJPLQMKW4bFbUqNeG0FoQ7okpjAjye4tQxLgQelNPRT9hGAM5d4P1Dx2RKr4ZXxV+FLgGIVO4xt0/DlUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2JhMmyk2jk1Ry/QlLcFx0185FBA2eSgb2CYDwo7fks=;
 b=bMUy+Z+WJsfYeDsDrEOKWYzMWRYGbhtGNQzjqeoVyqSvfCMilen3f5ycWK/AtwUBGsODfWEaAkvCNUJswqS0dwzEcH5My5+pzqmXwPDUdoy9mnjvkcup4GLBn7sA6uIUCM8sV4GBvPMSyNI627N2RvxGZd6F0s4ojET0UmZvTgky8jCJ+2u8f6B43bJ1oFxeRKd5uLKkbFDnfVYoYANKhzmSiYDBZJOLEDG5gDb6dkCENy19dG50pBupwRG8xg8J2oAFafsY8bkh3EIwTZCga7CjsGpjvaAtn3FtvDX/oxxwqgWXlb9xpe7r0xGmIp7KqxuDEGwWK139X4zNYhBjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2JhMmyk2jk1Ry/QlLcFx0185FBA2eSgb2CYDwo7fks=;
 b=KNDgaAFoglm9B0RLXTWyeXea/4jUZTP/jiSFMAysue2IiIkgxY0a7qERv8ROUH7D9M4QAopeojRlXiUCwpcjxzPD3gf6fcygxn1QRdKOZgTQqpV/JC3QdrNAbSgm8vNqspnymHFnhARG26CZ2muMuoqTIIilVCZcugUR2RxBwEjOHyljNy91wl1Q4nlt8Dd0VY68U0tYZenQzR7bEHy1alo9ECK8Yaurhfzut+YqQTuSkGpJRy665n1KKSkeSbZ5nV8SKpQVuicbeRQA7Ec6Ev6Cs4ZgpGJ8xWM1fd3phEazfxXbQxrvhcdWwWm+Xl0wna4/vlFSI9AUqLxEl0sOzg==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYZPR06MB5052.apcprd06.prod.outlook.com (2603:1096:400:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 07:08:36 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Tue, 29 Nov 2022
 07:08:36 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>
Subject: Re: [v4 5/5] hwmon: Add Aspeed ast2600 TACH support
Thread-Topic: [v4 5/5] hwmon: Add Aspeed ast2600 TACH support
Thread-Index: AQHY/wMRN7iyCHUoQkSgfTFaYF2aA65MpwwAgAlj1YA=
Date:   Tue, 29 Nov 2022 07:08:36 +0000
Message-ID: <D5F454FE-9C4B-4B7E-8817-637D5FCC047A@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-6-billy_tsai@aspeedtech.com>
 <bf851fa1-af62-5cdc-8cb4-bcf29b73731a@roeck-us.net>
In-Reply-To: <bf851fa1-af62-5cdc-8cb4-bcf29b73731a@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.67.22111300
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYZPR06MB5052:EE_
x-ms-office365-filtering-correlation-id: a28d2602-69e3-4998-e6eb-08dad1d888b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9s2vQoRLF2H9d+an850kX1WJ4zWzp2qCh3hgOcibpdbkyPg4/+Mwa5vTnuHVFJ6llwnhwM0y2t2/QBYpUGREtG2hoQ0XVqc9FOpKQMajN2ouCllHvzSErKzP5RXemw80lpSBBbrj9DdQTUymvaBfcoDR13osTT3sj564tZ7AZRclI1FOo+V7PyWL+YD4OqfGi/4MMqn4+g9RgN3lyTAzRuZ9UoVy7HacOhH/5BwHOZB6TBonkklWMMmfjAHnE+uxkSL900jaipn/ZGsWHocv25J/ZyElEjyBLZCbyo68NV5E4EP78TY8TAD5LmCu/rc6My1gbEUpO+RysLfkLBWufk4WE9ACCw4g3tU9vKBVyaN3eUXAFYGY6gKN+FjVaK4+82nVQZ9Utmzx/xzFImz9zcFU9STL1Gljy0znjV+F1RVyjtdKD18DyugUrtdnyBcB61/UlYdMo0+DimxxYuFMDW0LqkEUed9hFAqOWkE3u10Z1ZW1UWeP90coxA6cMwRF4X1UHv2x5RuR0PGY6Hzxye4bQvcziGA7twaasow5+yyxXkTOqMWpQEtqBAWkcs+BLcacQ9gbDXTfgn25VVa21fYqLm0eGPufZqtYlbv1ibGlePZDeTimUU+6sCg/N5snq9QXEFvLgNbqch9Rdr0nF2pRz2mMg/OuACjmOy3W/URMXc4RnmInD5dMTVpnd1Id7xe7wiXGKxznYzAJAmmLJhDazqyzP39uJl79pvn/z/6YsZG4KGkl5txjn4lAy4X1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39840400004)(136003)(396003)(451199015)(186003)(41300700001)(2616005)(122000001)(38100700002)(36756003)(5660300002)(7416002)(921005)(38070700005)(8936002)(83380400001)(2906002)(71200400001)(478600001)(6486002)(110136005)(6512007)(316002)(26005)(91956017)(8676002)(4326008)(66446008)(64756008)(76116006)(66476007)(66946007)(66556008)(86362001)(33656002)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1N4Wk5NVFowcmk0NTlzM0NZWCtoWlcxd3N4bE0rYjVCMXpkaFFpOFlmOGh6?=
 =?utf-8?B?c1BkOE5ieHFtbVZCRjFwYndKQUYvc25wUjNDeFVUR2JRQkNHSTJ0Q0RXVnN0?=
 =?utf-8?B?aG9rcDZpWml1cFBUWVhzaFZxbTZtS0FDMkJ4biszQk5OU0dOL3pTNnVwZHpZ?=
 =?utf-8?B?VE41VldaVG12dGxVcWlSYzUvQ2wwUDE0VTFIUG1ERG5WZXNncU5sbExmaDl2?=
 =?utf-8?B?dkFGV1JURjc4NjlVVEd4MzVnN3ExUFhOOXRVaEowSlpSR1piRFVDbWJPdFky?=
 =?utf-8?B?Vk1lWTA3YWVkaWZtOVNabXNsQ21GTXh0TXQ1aWQxRW1Ud1hEbCtlaHMzcG9P?=
 =?utf-8?B?TVdpUGFNb0JPWlo5cWt2UG10ZXlTdzF3djNEQkswMWRUT1B1WXp3cHhXeVRt?=
 =?utf-8?B?d3VPS2hKR2FJaDdDWGZLK2ZvRkdSRmRRR3J4RHFwMCtZOW1PbWRyQWF4aTVx?=
 =?utf-8?B?WHNLYnB5OTd0aGhabEpnYkg3TGNEbzIvVjhEelVXODhlUE9mSW9ZTzcwUW04?=
 =?utf-8?B?ZmU5Q0YzNlJIbUZ0TkMra1N5aFhKck5nc3BkVmdXcldYNmlvZ3pMTzUwdkVh?=
 =?utf-8?B?NU53ODducHMwM0Y0ODRhNWVnK3ZSaUtMeGVXR3hMTGxMM3JtbGlxMlFRNHUx?=
 =?utf-8?B?SmNsZjlNZWV3bFdZcElGZVV1Q3FNNjNETTYrZkhmTVNWZkNDVTNYUWZzd2d6?=
 =?utf-8?B?NnZPdUJ3eUpYNnpyOXRvTmt2UjBGWjQvZkFoRVBoUTl5RTRqdTBEaHR1U1JT?=
 =?utf-8?B?cHRLVmNTVXpWOEpybUpZOTFoMWtoSjh1ZlpZbkJINGxtaXlRb1lVZGpVdjkr?=
 =?utf-8?B?NjZhd1B4amp5Tlg1MFRjdFRwOU9mNFFnbEJ6VlFxd1lUMXRXVGJINm9MN0FK?=
 =?utf-8?B?VVJ6RWR1enNreDZrakpqVkNESnpEbXpoN1pRVEE4UE94bkxpS3VFNlZ6cFFk?=
 =?utf-8?B?a3hVeGxVVldMcCs1RTJOOHhVQ0RmV2lPQlpjQVAzVTlsVm8rMHRHMmNLdEEw?=
 =?utf-8?B?ZHRrQmJiZnBKV2pWQVI3eC84TytXbkJ2dzc1QmlTNGtkSnJ4ZHJ2RDB0UHBS?=
 =?utf-8?B?SndMcnQvZ0xxMUVCeFFJc3FrS1FHdnBHQ2IvcEVMVDNWa2JMZ3ZIakt5Rngw?=
 =?utf-8?B?TjRFa3NrdUNVOFRTS0FtcWp6TkJLYjh2cGRiL3QweWZqVENCOG1OcWxmUkor?=
 =?utf-8?B?TlBMbUIrSHg3WVdkUmZSN2ZqT3JyaU9XV3VNekdjZHdTZFJKSVNxSC90bXl4?=
 =?utf-8?B?VGIxMk1NcUdmRDNZdXp1VGc0akZQSm9uZ3ZRcGlmTitncEpaTmErenAwNjlv?=
 =?utf-8?B?dmdVSHBZTjVWSnMrdXdOcUM0c2QxeTRjOHVTR2hjRkdGTDIwYnB2ZUJOZEpX?=
 =?utf-8?B?MS9EdHF4YVFTRkpyeS9hMFgyTDBid2thT1JtZDRRcEJFZStGU0dBOU1nL0xW?=
 =?utf-8?B?azRydDlNcnVxZ1oyYWdlRTJzc2VBWjd2NWhwc01ZTVoxS3hzakwxQnF4Y1Nt?=
 =?utf-8?B?SEp2cStOdFdiOE5xNkVOWDA2WDJVVWQwa0RTMjZndWw5SnlDc3pHYW5rTHpG?=
 =?utf-8?B?UjcrQncvL2N3VGdxUStBTVZuZzJpb25pdXU5M2VqYkVhVGQ5cE1BYW1tRkF2?=
 =?utf-8?B?MnFiUU1CZlBiWjBKR1NPNTlYWWlHeXNkeG5GdUs4bm1VNE5CTUxyR2Zqa2lJ?=
 =?utf-8?B?SEhDdEtockhSQU45QkNYclBmWW5BS0l2VElLY0dyNHFCNVRkZmdoOHREYXpu?=
 =?utf-8?B?SDNqaHJFTFRXM2h5WHU5ZFRaZzF0MnF0VElpa1Y5T2hzbU9RZFNra1MvYURn?=
 =?utf-8?B?aEZRazhkRHhlT0RzSUFsQkhXaVR4T29TYW40QXRMb3U3OVZ2K01ocUZxMk9D?=
 =?utf-8?B?YUtkY0F2Uk5HL0dWbVJ6UFEwRG1JdDN3Vk1xNi9acXBueXkvZHEwZGJUUHJa?=
 =?utf-8?B?QjJ4NVJmV1NzbW9Rcm5aVUJDUlJpMURwN2c1NElPRVZSMlFwVm84bjcxRSth?=
 =?utf-8?B?N3BwTE54T045aGxqb2F2RThJNjFyaCtLMFBBVW1zQXFxaVlzTnNhcElReUNn?=
 =?utf-8?B?YUdJOE50YVV6bWEweDN2TzRNVGd4eFhKSlREb0hHVFBCQTRQTlg0RUdJTTA2?=
 =?utf-8?B?UjhCVlozelVlRGkxRkwrbGczbm0zenRsZDNMNFNub29Kb0wrSWRKcFJUTnlO?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6EF46B92517DB47970ADB4E2E1B1778@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28d2602-69e3-4998-e6eb-08dad1d888b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 07:08:36.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPXDHdOb0gT4gfpM9Fveprr9QGl4clPcrVRvI+IDac953NJbDOsVYKpkLg6vSOD/VvsIPcredly83YSiBxpAIsDOoHXMnz0Ozwyjh+6oalc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8yMywgMTE6NDUgUE0sICJHdWVudGVyIFJvZWNrIiA8Z3JvZWNrN0BnbWFpbC5j
b20gb24gYmVoYWxmIG9mIGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6DQoNCiAgICBPbiAxMS8y
Mi8yMiAyMjoxNiwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+ID4gK1RoZSBkcml2ZXIgcHJvdmlk
ZXMgdGhlIGZvbGxvd2luZyBzZW5zb3IgYWNjZXNzZXMgaW4gc3lzZnM6DQogICAgPiA+ICs9PT09
PT09PT09PT09PT0gPT09PT09PSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KICAgID4gPiArZmFuWF9pbnB1dAlybwlwcm92aWRlIGN1cnJlbnQg
ZmFuIHJvdGF0aW9uIHZhbHVlIGluIFJQTSBhcyByZXBvcnRlZA0KICAgID4gPiArCQkJYnkgdGhl
IGZhbiB0byB0aGUgZGV2aWNlLg0KICAgID4gPiArZmFuWF9kaXYJcncJRmFuIGRpdmlzb3I6IFN1
cHBvcnRlZCB2YWx1ZSBhcmUgcG93ZXIgb2YgNCAoMSwgNCwgMTYNCiAgICA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIDY0LCAuLi4gNDE5NDMwNCkNCg0KICAgID4gVGhlIGNvZGUgZG9lc24n
dCBzdXBwb3J0IDEuDQoNClRoZSBjb2RlIGNhbiBzdXBwb3J0IDEuDQoNCg0KICAgID4gVGhlIGV4
aXN0ZW5jZSBvZiBhIHN0YXR1cyByZWdpc3RlciBtYWtlcyBtZSB3b25kZXIgd2hhdCBpcyBpbiB0
aGVyZS4NCiAgICA+IERvZXMgdGhlIGNvbnRyb2xsZXIgcmVwb3J0IGFueSBlcnJvcnMgPyBJZiBz
bywgaXQgbWlnaHQgYmUgd29ydGh3aWxlDQogICAgPiBhZGRpbmcgYXR0cmlidXRlKHMpIGZvciBp
dC4NCg0KICAgID4gPiArCWlmIChyZXQpDQogICAgPiA+ICsJCXJldHVybiByZXQ7DQogICAgPiA+
ICsNCiAgICA+ID4gKwlpZiAoISh2YWwgJiBUQUNIX0FTUEVFRF9GVUxMX01FQVNVUkVNRU5UKSkN
CiAgICA+ID4gKwkJcmV0dXJuIDA7DQogICAgPiA+ICsJcnBtID0gYXNwZWVkX3RhY2hfdmFsX3Rv
X3JwbShwcml2LCBmYW5fdGFjaF9jaCwNCiAgICA+ID4gKwkJCQkgICAgIHZhbCAmIFRBQ0hfQVNQ
RUVEX1ZBTFVFX01BU0spOw0KICAgID4gPiArDQogICAgPiA+ICsJcmV0dXJuIHJwbTsNCg0KVGhl
IHN0YXR1cyByZWdpc3RlciBpcyB0aGUgVEFDSF9BU1BFRURfRlVMTF9NRUFTVVJFTUVOVCB3aGlj
aCBpcyB1c2VkIHRvIGluZGljYXRlIHRoYXQNCnRoZSBjb250cm9sbGVyIGRvZXNuJ3QgZGV0ZWN0
IHRoZSBjaGFuZ2UgaW4gdGFjaCBwaW4gZm9yIGEgbG9uZyB0aW1lLg0KDQogICAgPiA+ICtzdGF0
aWMgdm9pZCBhc3BlZWRfY3JlYXRlX2Zhbl90YWNoX2NoYW5uZWwoc3RydWN0IGFzcGVlZF90YWNo
X2RhdGEgKnByaXYsDQogICAgPiA+ICsJCQkJCSAgIHUzMiB0YWNoX2NoKQ0KICAgID4gPiArew0K
ICAgID4gPiArCXByaXYtPnRhY2hfcHJlc2VudFt0YWNoX2NoXSA9IHRydWU7DQogICAgPiA+ICsJ
cHJpdi0+dGFjaF9jaGFubmVsW3RhY2hfY2hdLmxpbWl0ZWRfaW52ZXJzZSA9IDA7DQogICAgPiA+
ICsJcmVnbWFwX3dyaXRlX2JpdHMocHJpdi0+cmVnbWFwLCBUQUNIX0FTUEVFRF9DVFJMKHRhY2hf
Y2gpLA0KICAgID4gPiArCQkJICBUQUNIX0FTUEVFRF9JTlZFUlNfTElNSVQsDQogICAgPiA+ICsJ
CQkgIHByaXYtPnRhY2hfY2hhbm5lbFt0YWNoX2NoXS5saW1pdGVkX2ludmVyc2UgPw0KICAgID4g
PiArCQkJCSAgVEFDSF9BU1BFRURfSU5WRVJTX0xJTUlUIDoNCiAgICA+ID4gKwkJCQkgIDApOw0K
ICAgID4gPiArDQogICAgPiBXaGF0IGlzIHRoZSBwdXJwb3NlIG9mIHRoZSBhYm92ZSBjb2RlID8g
bGltaXRlZF9pbnZlcnNlIGlzIGFsd2F5cyAwLg0KDQogICAgPiA+ICsJcHJpdi0+dGFjaF9jaGFu
bmVsW3RhY2hfY2hdLnRhY2hfZGVib3VuY2UgPSBERUJPVU5DRV8zX0NMSzsNCiAgICA+ID4gKwly
ZWdtYXBfd3JpdGVfYml0cyhwcml2LT5yZWdtYXAsIFRBQ0hfQVNQRUVEX0NUUkwodGFjaF9jaCks
DQogICAgPiA+ICsJCQkgIFRBQ0hfQVNQRUVEX0RFQk9VTkNFX01BU0ssDQogICAgPiA+ICsJCQkg
IHByaXYtPnRhY2hfY2hhbm5lbFt0YWNoX2NoXS50YWNoX2RlYm91bmNlDQogICAgPiA+ICsJCQkJ
ICA8PCBUQUNIX0FTUEVFRF9ERUJPVU5DRV9CSVQpOw0KICAgID4gPiArDQogICAgPiA+ICsJcHJp
di0+dGFjaF9jaGFubmVsW3RhY2hfY2hdLnRhY2hfZWRnZSA9IEYyRl9FREdFUzsNCiAgICA+ID4g
KwlyZWdtYXBfd3JpdGVfYml0cyhwcml2LT5yZWdtYXAsIFRBQ0hfQVNQRUVEX0NUUkwodGFjaF9j
aCksDQogICAgPiA+ICsJCQkgIFRBQ0hfQVNQRUVEX0lPX0VER0VfTUFTSywNCiAgICA+ID4gKwkJ
CSAgcHJpdi0+dGFjaF9jaGFubmVsW3RhY2hfY2hdLnRhY2hfZWRnZQ0KICAgID4gPiArCQkJCSAg
PDwgVEFDSF9BU1BFRURfSU9fRURHRV9CSVQpOw0KICAgID4gPiArDQoNCiAgICA+IGxpbWl0ZWRf
aW52ZXJzZSwgdGFjaF9kZWJvdW5jZSwgYW5kIHRhY2hfZWRnZSBhcmUgY29uc3RhbnRzLg0KICAg
ID4gVGhlcmUgaXMgbm8gbmVlZCB0byBrZWVwIGNvbnN0YW50cyBhcyBwZXItY2hhbm5lbCB2YXJp
YWJsZXMuDQoNCiAgICA+ID4gKwlwcml2LT50YWNoX2NoYW5uZWxbdGFjaF9jaF0uZGl2aXNvciA9
IERFRkFVTFRfVEFDSF9ESVY7DQogICAgPiA+ICsJcmVnbWFwX3dyaXRlX2JpdHMocHJpdi0+cmVn
bWFwLCBUQUNIX0FTUEVFRF9DVFJMKHRhY2hfY2gpLA0KICAgID4gPiArCQkJICBUQUNIX0FTUEVF
RF9DTEtfRElWX1RfTUFTSywNCiAgICA+ID4gKwkJCSAgRElWX1RPX1JFRyhwcml2LT50YWNoX2No
YW5uZWxbdGFjaF9jaF0uZGl2aXNvcikNCiAgICA+ID4gKwkJCQkgIDw8IFRBQ0hfQVNQRUVEX0NM
S19ESVZfQklUKTsNCiAgICA+ID4gKw0KICAgID4gPiArCXByaXYtPnRhY2hfY2hhbm5lbFt0YWNo
X2NoXS50aHJlc2hvbGQgPSAwOw0KICAgID4gPiArCXJlZ21hcF93cml0ZV9iaXRzKHByaXYtPnJl
Z21hcCwgVEFDSF9BU1BFRURfQ1RSTCh0YWNoX2NoKSwNCiAgICA+ID4gKwkJCSAgVEFDSF9BU1BF
RURfVEhSRVNIT0xEX01BU0ssDQogICAgPiA+ICsJCQkgIHByaXYtPnRhY2hfY2hhbm5lbFt0YWNo
X2NoXS50aHJlc2hvbGQpOw0KICAgID4gPiArDQoNCiAgICA+IFRoZSBhYm92ZSBhcHBsaWVzIHRv
IHRocmVzaG9sZCBhcyB3ZWxsLg0KDQpUaGUgYWJvdmUgY29kZSBpcyB1c2VkIHRvIHJldGFpbiB0
aGUgYWRqdXN0YWJsZSBmZWF0dXJlIG9mIHRoZSBjb250cm9sbGVyLg0KSSB3aWxsIHJlbW92ZSB0
aGVtIHVudGlsIEkgYWRkIHRoZSBkdHMgcHJvcGVydHkgdG8gc3VwcG9ydCB0aGVtLg0KDQogICAg
PiA+ICsJfQ0KICAgID4gPiArDQogICAgPiA+ICsJaHdtb24gPSBkZXZtX2h3bW9uX2RldmljZV9y
ZWdpc3Rlcl93aXRoX2luZm8oZGV2LCAiYXNwZWVkX3RhY2giLCBwcml2LA0KICAgID4gPiArCQkJ
CQkJICAgICAmYXNwZWVkX3RhY2hfY2hpcF9pbmZvLCBOVUxMKTsNCiAgICA+ID4gKwlyZXQgPSBQ
VFJfRVJSX09SX1pFUk8oaHdtb24pOw0KICAgID4gPiArCWlmIChyZXQpDQogICAgPiA+ICsJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KICAgID4gPiArCQkJCSAgICAgIkZhaWxlZCB0
byByZWdpc3RlciBod21vbiBkZXZpY2VcbiIpOw0KICAgID4gPiArCXJldHVybiAwOw0KDQogICAg
PiBXaHkgbm90IHJldHVybiB0aGUgZXJyb3IgPyBFaXRoZXIgaXQgaXMgYW4gZXJyb3Igb3IgaXQg
aXNuJ3QuIElmIGl0IGlzDQogICAgPiBub3QgYW4gZXJyb3IsIGRldl9lcnJfcHJvYmUoKSBpcyBu
b3QgYXBwcm9wcmlhdGUuIElmIGl0IGlzLCB0aGUgZXJyb3INCiAgICA+IHNob3VsZCBiZSByZXR1
cm5lZC4gRWl0aGVyIGNhc2UsIGlmIHRoaXMgaXMgb24gcHVycG9zZSwgaXQgbmVlZHMgYW4NCiAg
ICA+IGV4cGxhbmF0aW9uLg0KDQpJIGhhdmUgcmV0dXJuIHRoZSByZXR1cm4gdmFsdWUgb2YgdGhl
IGRldl9lcnJfcHJvYmUuIERpZCBJIG1pc3Mgc29tZXRpbmc/DQoNClRoYW5rcw0KDQpCZXN0IFJl
Z2FyZHMsDQpCaWxseSBUc2FpDQoNCg==
