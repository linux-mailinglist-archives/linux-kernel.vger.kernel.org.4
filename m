Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3568176F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbjA3RSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjA3RS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:18:29 -0500
X-Greylist: delayed 6875 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 09:18:28 PST
Received: from mx0b-00209e01.pphosted.com (mx0b-00209e01.pphosted.com [148.163.152.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135D34C03;
        Mon, 30 Jan 2023 09:18:28 -0800 (PST)
Received: from pps.filterd (m0094031.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U9dRs9014798;
        Mon, 30 Jan 2023 08:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pod1119;
 bh=SJdQtWOgpzD1UnVUQrK0yyOsWwoJ7etytn394rZk4MA=;
 b=PGSyjVQ0ELF//j92cs6K+MWDWmQCHKQnqj2ORN2w3IhbrHHf+QELdu+FPGPBRYfOKr2n
 ACLIktwu5ZAeq69c8a9/BtsrOHdmkLioIvLco+yuryhLhX6fCAJeOCvfwq6K0b91dnDt
 4LpRa0p/2D9ODpCLstI0VTYgTgSEM0gIXCinckMg3xdVWKDCIXDhYSMRTipLT4Y9EQlb
 uuq9Yc8br5KQp8mhQT7cE9we0XlVQkaVfdet/BVg8k+90/B5kPP/5oFmUckXMwUKc1n5
 IlWLv9IlppQP4G50Bt5ZdWVGSBwWn3ZL1BCoixZ7LCeskQolKim77a2Zr3K7K7sRB5Vr 5w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3nd1eys81t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 08:20:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUHUrwd2jG8qjxB3Gm9ZB9bGfZc0yLFtTuwD26uT0OqW6+rzt6Hnd0zbUV1BAr7v5ZspPRuYZBGD3SCFn6H74SE8uDMeHDZ4x4K9tCZpu4Y8HYhiZ3LJw0WD7DmYGiQ73AqOUo3Hc12MrL4ta0ufpTRFEdaKMIabL9LB6FYj+q4DLkBhPpg7u7AGQAXHGZMVGMx4Ma+25e9ZRnYNAywHKb47Gu3p8bucDdreu3EbpGM0OpHI/nDqhSa0b3k9BeHOlmwqCNmAxtCjb1Lgv+hYf6evxSW+zGy7dQgRt+GXeSSKD6n9wty3pBQ5t7iWsSYebnYDuwxH5LofDGbOgycFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJdQtWOgpzD1UnVUQrK0yyOsWwoJ7etytn394rZk4MA=;
 b=XFET7rpQotk4nVllJw86MZ7KMGl1O7RIPKH9cjK9PmsazVXlrW5ZYjKQYpRHcXnCzFckmDWp32htre3fNMcbWi0INs+Vc9gm3ncUhEY3Hqy0MIFWkLuYMIVJYF3M4WdVcIOjLlM36mYBfXxAe5cwEev4HggWidGcDYJBhKAxcM0s1A1of0ORBxLUVf+KgU+ziAtlsF7QXEvdclw5jtgnEwHgLWMivg8rPOvE/x06SsR5G2ouWtZmXsRxxBFDr67w0tzHV3t2FdddWnuvogF9OWtSW3Fg5p2YexfkRXB5jvmw3+c1j07W/7yr7N6nidnrLlg4pJh4fDtnHD8NfXgpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by DS0PR15MB5966.namprd15.prod.outlook.com (2603:10b6:8:15b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:20:55 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6%3]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:20:55 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Leonard, Niall" <Niall.Leonard@ncr.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Thread-Topic: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Thread-Index: AQHZMW99YCz74HQkk0+hHBCSYD4Bfa6woJsAgAF0QhCAA32uAIABZfOA
Date:   Mon, 30 Jan 2023 13:20:55 +0000
Message-ID: <c95cea18-5b92-e16c-f4f6-cde93ca22ca1@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
 <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
 <MW5PR15MB52184F83BA524D9600B820F5FDCC9@MW5PR15MB5218.namprd15.prod.outlook.com>
 <ed16faa2-eb04-772d-8762-0c3f90fddbcb@linaro.org>
In-Reply-To: <ed16faa2-eb04-772d-8762-0c3f90fddbcb@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|DS0PR15MB5966:EE_
x-ms-office365-filtering-correlation-id: f7643c65-f2b0-40de-6487-08db02c4d18c
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0dcmozLNZmgPg0So/nfLmRfOxctjwjjkOiznQshQIKL3N6vxI+eYGmVcRAcaQvyNJtGRU94D+PtfrGRo8F+aLH3FtMwcRR+sCjDT2nDb0PNyK3JKlpTdU+9bI68JM92Jsuc5s1ezF/e11cTAezZ1trNSheWRdYcwTqJjw82lNumuUvgPha7jppiws+gtUzRwA5mtt2RK5hpQ51VaezLj2Kk3qy3RpR7og2pBTzuxg67Rwf/XLIzbuAZuH7pRSmKD+9fW2ILXNhVkd6zYZYVIkZDvbUztsICkJmHPMPIC/TMahXM5qCLI9UnxilBK+WLUQxvfnT48LiVWhtzsug20O2kfn9GAyIyiHs6ZeXCgka6sMO02ZqP8rI8hd8M6tSLfN/Wdp3kUDiHrFfeaTcNzlWRCbz8QXtNksemexbu8OcLhnUu0T/NP+adcLD1mJQNcEsD+FkMXwrs2P8LbTVyHDpgfEluB+Lb/V3vqJfSYGs7Fq2xZujhyrtcsP5PVMsghkzfB1kSM+219Hrh9rk9pZrYpnyoydR/BMI7tkeO9Kr8FGgwgYZchdmXsdPX7rtDt4/gp8pYjtIlSOYb+XyipImzHHF9V+9P4/Wsz1r8TfEyFIkVVkp60DKbgadutUFMO7+t9jNCrHi/hZnzts/z3cNCk+zUCwXn8zaw/oUvbkmzQtpVGMnroFkkwsjHUqjl6axftCmTz9TqI37lYeNfslCHB9lcM4sNLObW9iD2em63oda5RGFyt/D3u5Z26SPOX1uWwMZB5PebErUN7xifIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199018)(6512007)(26005)(186003)(53546011)(6506007)(83380400001)(38070700005)(86362001)(31696002)(38100700002)(36756003)(122000001)(82960400001)(2616005)(31686004)(8936002)(41300700001)(2906002)(5660300002)(6486002)(478600001)(71200400001)(91956017)(54906003)(76116006)(316002)(4326008)(66476007)(66946007)(110136005)(66556008)(64756008)(66446008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdTd1h6YTNDdEIydDFmZnBRYUhham1kRWdKUGRMb0ZKQ2lFMVhLSzJkWDB6?=
 =?utf-8?B?enRmTFB3S0dQeUZwWmpvSVJUN1RiWGNraVMrZ1Ircmk4TnM0R2RBamFZMWxt?=
 =?utf-8?B?Q29GWGtSd0Y2RU1aNU8xTHJyUmhjZGtWM1ZaS1RLenFWKzloMlVvcXhtUGk5?=
 =?utf-8?B?YlJzUlY0N0ozY2w3N3VPQlNJSFA2Y0w5NVY1cHYvcjNzdURmNVh3SzhQaXVy?=
 =?utf-8?B?a3kzaFFMSFRsVitUT0lUcUI1aTI5WFVxTjZwcnN0d1hBWVhMbm1oVzVBNG1j?=
 =?utf-8?B?Y2FKek5RYmFGTGRMQTNGS0Uvbjg2bjM0QzNEN2ZIeTI4YzJRNXBDNGhjMVlu?=
 =?utf-8?B?cjZLcDAwZHFCVStQamxKVCtBZWVaTHU1LzkvenZhUC9ZVU5vKzZNYnVnUXlT?=
 =?utf-8?B?VDdvaGVWNzc1aFNDVHlTODE5SFN6MDh6cmF3b0t0blFRdWt0cTdIMWVlOXVM?=
 =?utf-8?B?a0RjV0tRUmhvdDlrYnRyR0M0b0JoNGx1VTlzSXVGYytSUGp3Mmp4dVc5VVVR?=
 =?utf-8?B?UUlWVzNWYkVqRnh5MUhmWVd4di9SY2grT2VzSlQwVFNvYThkTWpNQmk4TEJC?=
 =?utf-8?B?c0JuR0syYWQ2cFBhZlFPRGQ1alJ2R09TbkpIekl5eHMzNzNRN0ZEOWdpNi9Q?=
 =?utf-8?B?MXJCeWdXTUpsNE5rL2dEOHNBdE0yMUhmNzZsN1VFb05FYWJ5V1BRVXJaNVRo?=
 =?utf-8?B?aTRPMkRuT2x1QjBzaVR2Q0VmS2ZsWGhDeFRwQ0h2Zk4wTFpTUkxZYUFVdDhS?=
 =?utf-8?B?aTA1d1NZVTZOc0cyMmxQUWJVWEI4aldvL29paHZjcWQ0RTZlcHFUWkxBc0l1?=
 =?utf-8?B?S2JubHJVcHdrOWhreGhDbGp4Y3ZlaTRCa1RYTmtyNW1MTGhkV2duNW5lYUV6?=
 =?utf-8?B?Qk5PRjhGUk9EY20vZ1h4Y0h5czF6VzYrS2xpWUdxLzBKVkhZa2J6a3FlYXVX?=
 =?utf-8?B?STR3TW8yT01KdEFobzlDV0VkV0FpS1A4ZWk3bGI0aDZ1ZUhmSjd6dXdsR3lh?=
 =?utf-8?B?Q0lYS2hFNERQZHdmb1ZCU0VmVnFXOURxZGNGL1UzSkdBbEhxMWlkK0Q1Yko5?=
 =?utf-8?B?dkZ0QUQycWVhN1hId0FOQmNzeFhjQ29zNnVaK3VJSm1IQWlOZnU1Y0IyTkVa?=
 =?utf-8?B?VHdTOG9ERnlzSkR4QXM4NnZ2VXNNY2VpeE9qWmZteWFMU0VoT1V1K3NURGI1?=
 =?utf-8?B?Q0R5V09LNmh3NGRXMFFweU9TL2NkSngwZm1lNWZLWWVDbS9uVlNRVjlkb29l?=
 =?utf-8?B?QzZvOUllSkdWdjV4WTlLNGtORTRBd3p4eHFSdG43UlR0OXBqazcvdDVqampr?=
 =?utf-8?B?dnp0VHFTTngxaVVFanJ1TFNLSmVyTFk3MnJZaDRkZWZEenFuWjl3SXdLS1Vq?=
 =?utf-8?B?M1p1cEw5UmM5enB3c1dkU2syM0RLTkt3dGx6T3BIZzBjYkVhcDdzT3U5UlpQ?=
 =?utf-8?B?ZVMrZ3J1RVJ6Q0RvTXBESDFWZVV3ZHVQdWdaNVorU1BzQWF2bzN0ZjJ6SExJ?=
 =?utf-8?B?dFZ3Ty9CNmlPazc0Mkl6QTM3S0NoODQ1WllOVk9wMVJhVEtPNFZnVVlZVWEw?=
 =?utf-8?B?ZEZWbTJKUVdlYzFsQ2Z4TkN1SFJyWE1iNGVJYlJWZnZRb3VpRjJQelh3ZDdj?=
 =?utf-8?B?Q2Y0ZWcxd2p3Z3BpaHhtL0o2d3MwdnZIamYyR0o0Q3hqZWhBR1o2VENwMVFu?=
 =?utf-8?B?Y3pFaWxuS05oUW1EaWJUWkpHUVYyRmowQW9oblM4aUhRTDBQUmlWYmVVbDRN?=
 =?utf-8?B?eGErYU5CM0ZzRHZpbjdyaktOTkUxUjNLc3dzK1JZZkgxSG50NnJncHZ3Q2Jk?=
 =?utf-8?B?RE15Y2NmcGNjSCtiTE1YamFZY2o4Skx0UGxuTnZYWUsyN2Q3ZnJzZTZKZ3A2?=
 =?utf-8?B?N3RDa1QwZnJHYW9obkE4eXIyYml5Mk1EYmhGZ3J6dW1zQ3dEU1poczRqL1M4?=
 =?utf-8?B?SWQ1enFxaWhpZC9QRXJ1WEZVZDloaUJUMXlQQ0NPaWxDS2kyMUxET2pieldC?=
 =?utf-8?B?QkRZSjR5bnlhcS82OFRlUmQyeEVHUm1xaHNLVnhuWFJ0cFpZQkFHcHM5bEd0?=
 =?utf-8?B?TERLcU15V0RKdmZvWWE0U1IzUWVaYktTNHljQUE3M1gwNThkSXVBWXM2RzJ1?=
 =?utf-8?Q?vbNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E6A7D7401FA3844B608797BD8C4EC3E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zGw2pCDlTE7LEVZ44je5D1cppJeQ+2EExn4OjDJfXNiIFK8GiWHhinuNjoSZyFOhYpkBSbN8p809Cj9oggHqI2Mnpf1H9+d1upDOinTbUMxeGJJkxa8P0zyLgtIRssvi3zq89IKvh4KlPT4J/fxWVFswc5WibkupPDtz4LrQg+X7/eP24cjzp/CkTvaQ7DI8APhXpugL7Fjqp7LWB+CwOdWgCt3K2Pw2FmaJxWDontPZ7jDnpc0Bk091MJP/A4k4KSMITsxdvDTamR//759EFytWLUmuqQwgzELdNiOuueOr+x1XYJivjRcgvQ9H3ydNuzMzwCNwVVtfJSaAbqPHG7/ljUxAErW8mZixi0b6+7LPiLIHDyKqJzolyCrCEwR0qSXfkjjFigwd60PoUy0Ywru7tPHd7HpqEZbiqDMh4GkRUppg1UfPRZq8blQDdTSU08FNAYfiYJfelwcqHU7fm0EDbFixCLyqjlgnyk/YD6QA1AHexXQky4aSj6SHNIBEoqU9dDcOdu/l1SS0I8mJQ+kue5HHhUumYaUPYuroWTZCIeQQsIVLEgmhEWUYbvzQdXvCPm9Du96p/nBFrfCV2EH5QSQwJ68UDVKeiFGQsX0Fi/5gbXEtBqNEyOeeXrlcL/2Zaxxa+tLmSA2Mc0sgw/Rz+r0jFfbBe8OxrGnVqQAtfXbpNE0+ncua75jZxdeJDEdOWH3vrrjxBAd1JxI9n+AUeXdPIflmPOdWzP5SRODoOB5hOQA6ktH6AsrrLvYV7oVNH3FZ7wLgQ7DEv2PbgZgDLylkkfkuRDGgVOcElSNypY6w/P9YttndTDP2nks/L1vnAZkZizzbdqOl7N3Bqk84TvuEYamtJPutW88pWH8=
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7643c65-f2b0-40de-6487-08db02c4d18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 13:20:55.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mM8BkmvqX6R6zqT0uhSDKdMw1cBW+kIlgKmZwX3Uc3oSmKgxJkbTM+vl4F/xmvCrvdI6fbQRLnC+SaeBbIA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5966
X-Proofpoint-GUID: ee9_8z6tu-3irRWwAPf7z1GWqnjV1vBU
X-Proofpoint-ORIG-GUID: ee9_8z6tu-3irRWwAPf7z1GWqnjV1vBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDEvMjAyMyAxNTo1OSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gKkV4dGVy
bmFsIE1lc3NhZ2UqIC0gVXNlIGNhdXRpb24gYmVmb3JlIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IE9uIDI3LzAxLzIwMjMgMTI6MzksIExlb25hcmQsIE5pYWxsIHdyb3RlOg0K
Pj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+Pj4gU2VudDog
MjYgSmFudWFyeSAyMDIzIDEyOjI5DQo+Pj4gVG86IExlb25hcmQsIE5pYWxsIDxOaWFsbC5MZW9u
YXJkQG5jci5jb20+OyBMaW51cyBXYWxsZWlqDQo+Pj4gPGxpbnVzLndhbGxlaWpAbGluYXJvLm9y
Zz47IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJyZ2xAYmdkZXYucGw+OyBSb2INCj4+PiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+Pj4gPGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4+PiBDYzogbGludXgtZ3Bpb0B2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4+PiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGdwaW86IGR0LWJpbmRp
bmdzOiBhZGQgbmV3IHByb3BlcnR5IHRvIHdkLG1ibC1ncGlvDQo+Pj4gYmluZGluZ3MNCj4+Pg0K
Pj4+ICpFeHRlcm5hbCBNZXNzYWdlKiAtIFVzZSBjYXV0aW9uIGJlZm9yZSBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+Pj4NCj4+PiBPbiAyNi8wMS8yMDIzIDExOjE3LCBOaWFsbCBMZW9u
YXJkIHZpYSBCNCBTdWJtaXNzaW9uIEVuZHBvaW50IHdyb3RlOg0KPj4+PiBGcm9tOiBOaWFsbCBM
ZW9uYXJkIDxubDI1MDA2MEBuY3IuY29tPg0KPj4+DQo+Pj4gU3ViamVjdDogbWlzc2luZyAid2Qs
bWJsLWdwaW86IiBwcmVmaXguDQo+Pj4NCj4+PiBTdWJqZWN0OiBkcm9wIHNlY29uZC9sYXN0LCBy
ZWR1bmRhbnQgImJpbmRpbmdzIi4gVGhlICJkdC1iaW5kaW5ncyINCj4+PiBwcmVmaXggaXMgYWxy
ZWFkeSBzdGF0aW5nIHRoYXQgdGhlc2UgYXJlIGJpbmRpbmdzLg0KPj4+DQo+Pj4+DQo+Pj4+IEFk
ZGVkIG9wdGlvbmFsICJuby1pbnB1dCIgcHJvcGVydHkNCj4+Pg0KPj4+IE1pc3NpbmcgZnVsbCBz
dG9wLg0KPj4+DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE5pYWxsIExlb25hcmQgPG5sMjUw
MDYwQG5jci5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9ncGlvL3dkLG1ibC1ncGlvLnR4dCB8IDEgKw0KPj4+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJsLWdwaW8udHh0DQo+Pj4+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJsLWdwaW8udHh0DQo+Pj4+IGluZGV4
IDAzOGMzYTZhMWY0ZC4uOTQwNWY5ZGFkNTIyIDEwMDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby93ZCxtYmwtZ3Bpby50eHQNCj4+Pj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJsLWdwaW8udHh0DQo+
Pj4+IEBAIC0xOCw2ICsxOCw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+Pj4+DQo+Pj4+ICAg
T3B0aW9uYWwgcHJvcGVydGllczoNCj4+Pj4gICAJLSBuby1vdXRwdXQ6IEdQSU9zIGFyZSByZWFk
LW9ubHkuDQo+Pj4+ICsJLSBuby1pbnB1dDogR1BJT3MgYXJlIHdyaXRlLW9ubHkuIFJlYWQgaXMg
dmlhIGEgc2hhZG93IHJlZ2lzdGVyLg0KPj4+DQo+Pj4gV2h5IHRoaXMgcHJvcGVydHkgaXMgbmVl
ZGVkPyBXaHkgZHJpdmVyIGNhbm5vdCBhbHdheXMgdXNlIHNoYWRvdw0KPj4+IHJlZ2lzdGVyPw0K
Pj4+DQo+PiBUaGUgc2hhZG93IHJlZ2lzdGVyIGlzIGN1cnJlbnRseSBvbmx5IHVzZWQgZHVyaW5n
IHRoZSB3cml0ZSBvcGVyYXRpb24uIEl0IGlzIG5vdCBhdmFpbGFibGUgZHVyaW5nIHRoZSByZWFk
IG9wZXJhdGlvbi4NCj4gDQo+IFlvdSBqdXN0IHdyb3RlIGFib3ZlIHRoYXQgcmVhZGluZyBpcyB2
aWEgc2hhZG93IHJlZ2lzdGVyLCBzbyBob3cgY2FuIGl0DQo+IG5vdCBiZSBhdmFpbGFibGUgZm9y
IHJlYWRzPyBBZ2Fpbiwgd2h5IHlvdSBjYW5ub3QgYWx3YXlzIHJlYWQgdmlhIHNoYWRvdw0KPiBy
ZWdpc3RlciBhbmQgbmVlZCB0byBtYWtlIGEgcHJvcGVydHk/IFlvdSBtZWFuIHRoYXQgZm9yIG90
aGVyIEdQSU9zDQo+IHRoZXJlIGlzIG5vIHNoYWRvdyByZWdpc3RlciBhdCBhbGw/DQo+IA0KVGhl
IGV4aXN0aW5nIHJlYWQgbWV0aG9kIGRvZXMgbm90IHVzZSB0aGUgc2hhZG93IHJlZ2lzdGVyLg0K
DQpzdGF0aWMgaW50IGJncGlvX2dldChzdHJ1Y3QgZ3Bpb19jaGlwICpnYywgdW5zaWduZWQgaW50
IGdwaW8pDQp7DQoJcmV0dXJuICEhKGdjLT5yZWFkX3JlZyhnYy0+cmVnX2RhdCkgJiBiZ3Bpb19s
aW5lMm1hc2soZ2MsIGdwaW8pKTsNCn0NCg0KPiBXaGF0IGNoYW5nZXMgYmV0d2VlbiBvbmUgYm9h
cmQgYW5kIGFub3RoZXIgdGhhdCBqdXN0aWZpZXMgdGhpcyBwcm9wZXJ0eT8NCg0KSSBoYXZlIGEg
Y291cGxlIG9mIGJvYXJkcyB3aGVyZSB0aGUgZWxlY3Ryb25pY3MgZW5naW5lZXIgZGVjaWRlZCB0
byBvbmx5IA0KdXNlIHRoZSBjaGlwIHNlbGVjdCBsaW5lLCBzbyBubyByZWFkL3dyaXRlIHNpZ25h
bCBpcyBjb25uZWN0ZWQuIFRoaXMgDQptZWFucyB0aGF0IHJlYWRpbmcgdGhlIGFkZHJlc3MgYWN0
aXZhdGVzIHRoZSBjaGlwIHNlbGVjdCBhbmQgZHJpdmVzIHRoZSANCmNvbnRlbnRzIG9mIHRoZSBk
YXRhIGJ1cyB0byB0aGUgcG9ydC4gRm9yIGV4YW1wbGUgaXMgc29tZW9uZSByZWFkcyB0aGUgDQpm
aWxlIC9zeXMva2VybmVsL2RlYnVnL2dwaW8gdGhpcyBjb3JydXB0cyB0aGUgcG9ydC4gU28gSSBo
YXZlIGhhZCB0byBhZGQgDQp0aGlzIHByb3BlcnR5IHRvIGF2b2lkIHRoYXQgc2l0dWF0aW9uLg0K
DQpJZiB5b3UgYXJlIHN0cm9uZ2x5IGFnYWluc3QgdGhpcyB0aGVuIGp1c3QgcmVqZWN0IGl0IGFu
ZCBJIHdpbGwgbG9vayANCmFmdGVyIGl0IG15c2VsZi4gSSB0aG91Z2h0IHRoZXJlIG1heSBiZSBv
dGhlcnMgd2hvIHdvdWxkIGZpbmQgdGhpcyANCmNoYW5nZSB1c2VmdWwuDQoNCj4gDQo+PiBUaGF0
IGlzIGVzc2VudGlhbGx5IHRoZSBjaGFuZ2UgSSBoYXZlDQo+PiBzdWJtaXR0ZWQuDQo+IA0KPiBU
aGlzIGRvZXMgbm90IGFuc3dlciBtZS4gSSBhbSBhc2tpbmcgd2h5IHRoaXMgY2hhbmdlIGlzIGp1
c3RpZmllZCBpbg0KPiB0ZXJtcyBvZiBEZXZpY2V0cmVlLg0KPiANCkhvdyBlbHNlIHdvdWxkIHlv
dSBzdWdnZXN0IGl0IHdhcyBkb25lID8gSSBmb2xsb3dlZCB0aGUgZXhpc3RpbmcgcGF0dGVybiAN
CnVzZWQgcHJldmlvdXNseSBmb3IgdGhlICJuby1vdXRwdXQiIHByb3BlcnR5Lg0KDQoNCj4+IEFu
IGFsdGVybmF0aXZlIGFwcHJvYWNoIHdvdWxkIGhhdmUgYmVlbiB0byBkZXZlbG9wIGFuIGVudGly
ZSBuZXcgZ3BpbyBkcml2ZXIgc2ltaWxhciB0byB0aGUgNzR4eCBkcml2ZXIsIGJ1dCBJIGZlbHQg
dGhpcyBhcHByb2FjaCB3YXMgYmV0dGVyLg0KPj4NCj4+PiBBbnl3YXksIHBsZWFzZSBjb252ZXJ0
IHRoZSBiaW5kaW5ncyB0byBEVCBzY2hlbWEgZmlyc3QgKHNlZSB3cml0aW5nLXNjaGVtYQ0KPj4+
IGFuZCBleGFtcGxlLXNjaGVtYSkuDQo+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3dyaXRpbmctc2NoZW1hLnJzdA0KPj4+DQo+PiBUaGUgYmluZGluZ3MgZm9yIHRoaXMgZHJp
dmVyIGFyZSBkdXBsaWNhdGVkIGluIGEgZmV3IGZpbGVzIGV2ZW4gdGhvdWdoIHRoZXkgdXNlIHRo
ZSBzYW1lIGRyaXZlci4NCj4+IGkuZS4gd2QsbWJsLWdwaW8udHh0LCBuaSwxNjk0NDUtbmFuZC1n
cGlvLnR4dCwgYnJjbSxiY202MzQ1LWdwaW8ueWFtbA0KPiANCj4gU28geW91ciBjaGFuZ2VzIGhl
cmUgYWZmZWN0IHNldmVyYWwgYmluZGluZ3MgYnV0IHlvdSBhZGp1c3Qgb25seSBvbmU/DQo+IFRo
aXMgd29uJ3Qgd29yay4NCj4gDQo+PiBJIGRvbid0IGtub3cgd2h5IHRoZXNlIG11bHRpcGxlIGJp
bmRpbmdzIGV4aXN0LiBJdCB3b3VsZCBwZXJoYXBzIG1ha2Ugc2Vuc2UgdG8gcmVtb3ZlIHRoZXNl
IGR1cGxpY2F0ZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZmlsZXMgYW5kIHJlcGxhY2Ugd2l0aCBh
IHNpbmdsZSBvbmUgZm9yICJiYXNpYy1tbWlvLWdwaW8iLiBJIGhhcHBlbmVkIHRvIHBpY2sgIi4g
d2QsbWJsLWdwaW8udHh0IiwgYnV0IEkgY291bGQgaGF2ZSBqdXN0IGFzIGVhc2lseSBjaG9zZW4g
b25lIG9mIHRoZSBvdGhlciAyLg0KPiANCj4gV2UgdXN1YWxseSBrZWVwIHNhbWUgaGFyZHdhcmUg
aW4gdGhlIHNhbWUgYmluZGluZ3MuIFRoaXMgbWlnaHQgb3IgbWlnaHQNCj4gbm90IG1hcCB0byBz
YW1lIExpbnV4IGRyaXZlciAoZHJpdmVycyBhcmUgaW5kZXBlbmRlbnQpLiBBbGwgdGhpcw0KPiBo
YXJkd2FyZSBsb29rcyBsaWtlIGhhdmluZyB0aGUgc2FtZSBpbnRlcmZhY2UgYW5kIHNhbWUgcHJv
cGVydGllcywgc28NCj4gaGF2aW5nIG9uZSBiaW5kaW5nIG1ha2VzIHNlbnNlLg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
