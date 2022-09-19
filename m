Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078CF5BC4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiISIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiISIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:52:48 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2113.outbound.protection.outlook.com [40.107.135.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736DF08;
        Mon, 19 Sep 2022 01:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXdqpN1M5FvDXTDtStzkXuPuGnREE5ilEszPNQ2MywCc+oVdj5O7aQXzltpVv0+ALBR4HhhryPy4qZ6dTJa6R4sV8ODT/DjQWArWV3QWvzkdmNOs2jsvkbZztZfgX3kQ4kAKZrrhF1xeEYjW9JvPRZBgjPFddiKaO0ObXe6mEzMp/fWhCfIk3qkeb34B2b87ZPNVoYk8mwJUWuYhVqDbHFNDJZHi2xdC+zNgRP5o6VERCLerubjx98VN0i+7i1zdD6A/w5l6wsghx4kvQfylsIpcSrx/3GXdcdySUHOT8XG/fZAvjPbspc8D2SEKgDYT3XWXjddbn66/0vNJmqLrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG+6PZ5V86Fe3L2buhinAJcZkgXb8gKSOn1RVQnWbkQ=;
 b=dBBlCX2XC+YP7MmaRlN2XIxYwBZ+4DUwKx4pn5xczGS3NIC8asnTeAWIAA5PfHCNRqM3QoTHn4Fk2CVh6311CJBc2yvoqNXiC0VOKxO3C1ZhwaNoF/2lF3gFOhe/ko9FkgAzr8K7qqbVMZVegLfcbu7R+oSpakJ/ZRJ85LrZCWrynQvv1BFegzb9A89VdtKf4hVwmpUzLOv/I3U4OYsjxL35C5SGnTexm2QnwVGAkpl6NB1NPNNK6mze+avLEyrF019smAZ9kSu8uGmZ8VnBYW+iLuslY558G1aXD3p8u9Uy/Z+PU40CpOTTpC9WIbaIxPEfdMdeZ45ZcRYIEaHufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG+6PZ5V86Fe3L2buhinAJcZkgXb8gKSOn1RVQnWbkQ=;
 b=ktpA1YtPlpmjkQWr6sB9oLXXi3/7OJaFOcw+GGMyJ29WDH8bUb8OQ/6ztjN5sjewZ886YEYE53K8i1dIfpEe7sk1wQjCXHblq5MGuye7bgf8iBznibcldtV2tjQxwaMhp6ORqTP1jO46hdxZN74iOIBwU8uxNfR4kXYA+FpW6Zs=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB2933.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 19 Sep
 2022 08:52:38 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2%8]) with mapi id 15.20.5654.014; Mon, 19 Sep 2022
 08:52:38 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Thread-Topic: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Thread-Index: AQHYzAUrLaBLRu9mX0OEcWs5gsAP0w==
Date:   Mon, 19 Sep 2022 08:52:38 +0000
Message-ID: <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-15-alexandru.ardelean@analog.com>
 <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
In-Reply-To: <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB2933:EE_
x-ms-office365-filtering-correlation-id: 3380ae33-c70c-43f7-a064-08da9a1c4de2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxMM7gnjqcDI0lKwM/IY/bn5oL2x1CBspZ8FEEZ+I04EpXYJrv/yAfECAcaK3y+I2J4f7LjKO/EAtW2rpXCVBTK5UTuSRdIVIDXTzfQGl+tdB3MlWmZOmFAr8qMSyATynmNvQetJWQ3IKyX5qOhDVWpbm1FhVdWfrKQnzuqSl8UVHUgqFAICviefrtxaukMsWcYSJ3RJ2paOuPNUH1w56QSKw0oIE1fdDmf/5su06OYsGGbJFGxAvRLKspow3lIzcdfCWKZCxZAssc9gQywE3PKBk03DnRqmHHjPS8zWruU2mNr9yWkU5DiYvLnKB88dXLOHslTU1V/rgisM43rmJXxjwIJcFbfS8gpXEI1ovHUqDIuf6lp5pb4bYZUc46IiNkpdUvO/IZH5cv28Gpl/W2vRaoJBPJ4W/RArhdSc9ql6E+7sIf4KI5He/ZIq/xodGOWxMQogZPJCM6+lvTMMomBNJ/8qmDgONxWXJ5c1hIzFtdPi/DDmCtUvNDgi0OZTRQ5SzB0W1X4DHldrGv7AodLFZoIL+tIKj/DQBjGscqGKdmGf/S6UqkYywXD3CMAuePXqtn4zb37y8PHA+IY5XvoGEhauu/M6gZSHWRcbJjKuHbm/noCVonMbw8aICxcoys/v/sUUxCeqZz5xLRmx9+BEiFkb1Q1DCk5HVOAK6Xl/FfRrStsWzeFd4FeAAzxxrYl8PMoggAY9Gc7Ez2lMtP6OSyryizPDzFun9QHZh7lt+XB3twXIWax5MCLCDDhPat3JvHp+FSFiBTZKuklxur6QvwbslE8DHavONUyzYZycFuOTyimqecd5lXN8x6ArcWCRzaquN0sN3US4e1ux2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39840400004)(346002)(376002)(451199015)(76116006)(66946007)(66476007)(8676002)(4326008)(5660300002)(66556008)(66446008)(64756008)(7416002)(110136005)(54906003)(86362001)(8936002)(31696002)(316002)(91956017)(122000001)(38100700002)(83380400001)(41300700001)(6506007)(53546011)(6486002)(71200400001)(26005)(2616005)(478600001)(186003)(6512007)(38070700005)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emljN24xd0Vub1dDdVJteVdFZVErUHR5dlFYMkV4MzBneHR1dW40Q3dTK0Rz?=
 =?utf-8?B?dG1lTytaeXF3TTRkcURHZHRGeTIwelFQNisrWlhBV3ozdWhOczR2QXIwT0t5?=
 =?utf-8?B?T2kyWWFTK0VvVzFyWCtVRkd3NVZWRXQwVEdBUEdmd2k5Q3hHbG50Njk0NUh4?=
 =?utf-8?B?aS9wRVgrMXAxRmUyVDd2U1ZCRzNXVjkxRkVHNXZOWWJUaWIxWXlRdFlLa3Vo?=
 =?utf-8?B?aG5hekgzeHpiWXhRaDVFZno0K3lrZFViK2w2TFcxQU1LVTlGc1B5dCtwYVRz?=
 =?utf-8?B?TjdEYW5LZHJLQWdNRStGRHlTaG9yUlNLOFk2b2VpOXpwYW5YUGNxNWZhTndJ?=
 =?utf-8?B?aERlTVpWMFJtWkV6SnIxUUVLaGswR081c1hNOWdkRFZZMm0rNHNyMlpsTFR3?=
 =?utf-8?B?UXJPWkZuREZ6MUZLWlhiMGhBMTZMUWd6bW9Ba1dHTVN2d3l5SGtLdTlGU0Rm?=
 =?utf-8?B?YTZFbVhUdU80M2c0MzNLSmJaVi9Ecm9kNnVvVGVyQmIxR2F5ZzVJSFg0UkN5?=
 =?utf-8?B?Yml5aFRNZkQ5RTNHUWJabWQwd2IxVGl3VXloOHVEenE1L0cwSDZUbDZvS2x1?=
 =?utf-8?B?R21BQ3RnSENPUlNEZS9SQXVRcW9qMlpCektnek9SV0tyZUpEdGFjMU1Fc2Ry?=
 =?utf-8?B?dHk5MXZYMmF5elNSQjRUWlFMV3ZFZ2xvZDN2NW0zem9KTXhxL3E1R3BMZlN4?=
 =?utf-8?B?V2F1Y1piUlY1ZzdMWTBXWGlqc3BWWmJKU0Rsdm1LRDBWaTJTRzNBamlIbkJR?=
 =?utf-8?B?ZFQ3dGNRUGZ0QXovUG41Yml3WjR1VzExUS9Cd0VweWxwcUpONjUyM2dKNllo?=
 =?utf-8?B?MjRTdy94ZTZuR3M1Vk1BYm5DUllDTDE2NngwTEZJcFZDNUw2ak8xQmtMdHpK?=
 =?utf-8?B?ekZ1TUtTRExxOElxMXRoWW5zYnZsRUY1cU1yd24zdWxSNWdBSGJBQjhWN2Rz?=
 =?utf-8?B?T25jRHlwdjF2UkpOMUdNN2RzN0hsbWlETEhtNjRmdXZzdnVGNGhLTmVqZWh6?=
 =?utf-8?B?MElVcnlPWFF5akY3LzZ5WXhKUmk3QnVydmhBQ2dsdWFab0t4RzY2S2hMWXQv?=
 =?utf-8?B?T3NXamJnYXB2NUJINHEyKzUxWnlqbTRyYkREdlVIV0lBcjVrMWxEemx4bG14?=
 =?utf-8?B?YXBnYmdINDhJTC80SzI1SE4zUG93NUN3UklyelFlL3RycEl1OTR2eVpvNS9R?=
 =?utf-8?B?K0NkZHlobFE4dktUZll5RmFSZ0FGV1hhdEJFclQwVjVnTHdYNmlKQS9NSFRH?=
 =?utf-8?B?ZHIrcExCM3JXYSs5ME5BZkJKQlU4ME0zbnpreE9tc2o5cmcvRE82MGpmUEsy?=
 =?utf-8?B?alhzb0lOSHljaW01cVFqL09CVFpTNTZaNTdkMjRrN1RaUHJKWGw0WVl3RlFm?=
 =?utf-8?B?eXZIK2xjNDR4N25KMC9jakxMd29DcFFheG81ZlpFZDVRUVNGOVVtVUttTlVS?=
 =?utf-8?B?bFhlMnFGaVdqdU54bjExcHNVZlBHK1lkSERKVEVEdWNvU3ZCU1MrS3ZScTlv?=
 =?utf-8?B?VlFQdlh6TFc5WEowVzZXT1RhTUppeFdWNUZhZS9vdU1qWnNZSU5NT3A4MVUz?=
 =?utf-8?B?cmxkMlM5dzBidlVrT05ObzhiVjRzamltWmVkU2NtNCt3Y0FFM21LM3AxS01N?=
 =?utf-8?B?S0o0OFloQjFaU2d4ZXlQeVNLZGJuY052TUZ5MWRVSlVEWjNkQmQ0c3ZNVExz?=
 =?utf-8?B?eGNCVHhXZEhEQ05OUGpQbnpIUEt5OGZNdFYwL3dEQ3pUMnJLdmVWWm1sbTJh?=
 =?utf-8?B?aVBZS3JDRjJIYm1CZlM5TWY3YjVEbCtjalBmUTYvSjFIQUJ3MHZSSmdUMHl6?=
 =?utf-8?B?blhHclNNaTF4QmJKZmh4NjRlK0w3UVhLLzZDTkMyY1VkaUE0K3A5TmhGR3NW?=
 =?utf-8?B?bS9ycUdZS1locE1yaDNMTGF3UE4vaUh6djlFbTZ3MzRyRVdUbFVsa2lTRGl2?=
 =?utf-8?B?Z2VQVTlOcEZYaUZhNnNHeWxXcmlONmt3aGRkLytsdTRnZXhEekxxcy93V0h5?=
 =?utf-8?B?S3FGM3JyQU9RWWRDRjI3eSs4T2pKU2V0UHc2bHdKTTNOaVdYZzNFZXNGYWVN?=
 =?utf-8?B?ZmFRWVlMbW5vRnhXNDQ4MmdpNk1peklQbXVnRTlsUGdOa2JaeUpWWU00bzkr?=
 =?utf-8?B?TWNjaTF5aE5MWGd6cnFkNlZaNU5SdU8yQlBGNk1OL1VZSjZWMkd5RUJhSDlN?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3AEF6C214F7C14FAB173D9373023D9D@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2933
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS85LzIyIDExOjEyLCBWYWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiBIaSBkZWUgSG8gcGVl
cHMhDQo+IA0KPiBEaXNjbGFpbWVyIC0gSSBoYXZlIG5vIEhXIHRvIHRlc3QgdGhpcyB1c2luZyBy
ZWFsIGluLXRyZWUgZHJpdmVycy4gSWYNCj4gc29tZW9uZSBoYXMgYSBkZXZpY2Ugd2l0aCBhIHZh
cmlhbnQgb2YgYm1jMTUwIG9yIGFkeGwzNzIgb3IgIC0gaXQnZCBiZQ0KPiBuaWNlIHRvIHNlZSBp
ZiByZWFkaW5nIGh3Zmlmb193YXRlcm1hcmtfbWF4IG9yIGh3Zmlmb193YXRlcm1hcmtfbWluDQo+
IHdvcmtzIHdpdGggdGhlIHY2LjAtcmM0LiBNYXliZSBJIGFtIG1pc3JlYWRpbmcgY29kZSBhbmQg
aGF2ZSBteSBvd24NCj4gaXNzdWVzIC0gaW4gd2hpY2ggY2FzZSBJIGFwb2xvZ2l6ZSBhbHJlYWR5
IG5vdyBhbmQgZ28gdG8gdGhlIGNvcm5lcg0KPiB3aGlsZSBiZWluZyBkZWVwbHkgYXNoYW1lZCA6
KQ0KDQpJIHdvdWxkIGxpa2UgdG8gYWRkIGF0IGxlYXN0IHRoZSBhdDkxLXNhbWE1ZDJfYWRjIChj
b25kaXRvbmFsbHkgDQpyZWdpc3RlcnMgdGhlIElJT19DT05TVF9BVFRSIGZvciB0cmlnZ2VyZWQt
YnVmZmVyKSB0byB0aGUgbGlzdCBvZiANCmRldmljZXMgdGhhdCBjb3VsZCBiZSBwb3RlbnRpYWxs
eSB0ZXN0ZWQuIEkgaG9wZSBzb21lIG9mIHRoZXNlIGRldmljZXMgDQpoYWQgYSB1c2VyIHdobyBj
b3VsZCBlaXRoZXIgbWFrZSB1cyB3b3JyaWVkIGFuZCB2ZXJpZnkgbXkgYXNzdW1wdGlvbiAtIA0K
b3IgbWFrZSBtZSBhc2hhbWVkIGJ1dCByZXN0IG9mIHVzIHJlbGlldmVkIDopIEVnIC0gSSBzZWNv
bmQgbXkgcmVxdWVzdCANCmZvciB0ZXN0aW5nIHRoaXMgLSBhbmQgYWRkIHBvdGVudGlhbCBvd25l
cnMgb2YgYXQ5MS1zYW1hNWQyX2FkYyB0byB0aGUgbGlzdC4NCg0KPiBPbiAyLzE1LzIxIDEyOjQw
LCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+PiBUaGlzIGNoYW5nZSB3cmFwcyBhbGwgYnVm
ZmVyIGF0dHJpYnV0ZXMgaW50byBpaW9fZGV2X2F0dHIgb2JqZWN0cywgYW5kDQo+PiBhc3NpZ25z
IGEgcmVmZXJlbmNlIHRvIHRoZSBJSU8gYnVmZmVyIHRoZXkgYmVsb25nIHRvLg0KPj4NCj4+IFdp
dGggdGhlIGFkZGl0aW9uIG9mIG11bHRpcGxlIElJTyBidWZmZXJzIHBlciBvbmUgSUlPIGRldmlj
ZSwgd2UgbmVlZCBhIHdheQ0KPj4gdG8ga25vdyB3aGljaCBJSU8gYnVmZmVyIGlzIGJlaW5nIGVu
YWJsZWQvZGlzYWJsZWQvY29udHJvbGxlZC4NCj4+DQo+PiBXZSBrbm93IHRoYXQgYWxsIGJ1ZmZl
ciBhdHRyaWJ1dGVzIGFyZSBkZXZpY2VfYXR0cmlidXRlcy4NCj4gDQo+IEkgdGhpbmsgdGhpcyBh
c3N1bXB0aW9uIGlzIHNsaWdodGx5IHVuc2FmZS4gSSBzZWUgZmV3IGRyaXZlcnMgYWRkaW5nDQo+
IElJT19DT05TVF9BVFRScyBpbiBhdHRyaWJ1dGUgZ3JvdXBzLiBGb3IgZXhhbXBsZSB0aGUgYm1j
MTUwIGFuZCBhZHhsMzcyDQo+IGFkZCB0aGUgaHdmaWZvX3dhdGVybWFya19taW4gYW5kIGh3Zmlm
b193YXRlcm1hcmtfbWF4Lg0KPg0KDQphbmQgYXQ5MS1zYW1hNWQyX2FkYw0KDQovL3NuaXANCg0K
Pkkgbm90aWNlZCB0aGF0IHVzaW5nDQo+IElJT19DT05TVF9BVFRScyBmb3IgdHJpZ2dlcmVkIGJ1
ZmZlcnMgc2VlbSB0byBjYXVzZSBhY2Nlc3MgdG8gc29tZXdoZXJlDQo+IGl0IHNob3VsZG4ndC4u
LiBPb3BzLg0KPiANCj4gUmVhZGluZyB0aGUgY29kZSBhbGxvd3MgbWUgdG8gYXNzdW1lIHRoZSBw
cm9ibGVtIGlzIHdyYXBwaW5nIHRoZQ0KPiBhdHRyaWJ1dGVzIHRvIElJT19ERVZfQVRUUnMuDQo+
IA0KPiBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqaWlvX2J1ZmZlcl93cmFwX2F0dHIoc3RydWN0
IGlpb19idWZmZXIgKmJ1ZmZlciwNCj4gKwkJCQkJICAgICAgc3RydWN0IGF0dHJpYnV0ZSAqYXR0
cikNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGF0dHIgPSB0b19kZXZfYXR0
cihhdHRyKTsNCj4gKwlzdHJ1Y3QgaWlvX2Rldl9hdHRyICppaW9fYXR0cjsNCj4gKw0KPiArCWlp
b19hdHRyID0ga3phbGxvYyhzaXplb2YoKmlpb19hdHRyKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYg
KCFpaW9fYXR0cikNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsNCj4gKwlpaW9fYXR0ci0+YnVmZmVy
ID0gYnVmZmVyOw0KPiArCW1lbWNweSgmaWlvX2F0dHItPmRldl9hdHRyLCBkYXR0ciwgc2l6ZW9m
KGlpb19hdHRyLT5kZXZfYXR0cikpOw0KPiANCj4gVGhpcyBjb3B5IGRvZXMgYXNzdW1lIGFsbCBh
dHRyaWJ1dGVzIGFyZSBkZXZpY2VfYXR0cnMsIGFuZCBkb2VzIG5vdCB0YWtlDQo+IGludG8gYWNj
b3VudCB0aGF0IElJT19DT05TVF9BVFRSUyBoYXZlIHRoZSBzdHJpbmcgc3RvcmVkIGluIGEgc3Ry
dWN0DQo+IGlpb19jb25zdF9hdHRyIHdoaWNoIGlzIGNvbnRhaW5pbmcgdGhlIGRldl9hdHRyLiBF
ZywgY29weWluZyBpbiB0aGUNCj4gaWlvX2J1ZmZlcl93cmFwX2F0dHIoKSBkb2VzIG5vdCBjb3B5
IHRoZSBzdHJpbmcgLSBhbmQgbGF0ZXIgaW52b2tpbmcgdGhlDQo+ICdzaG93JyBjYWxsYmFjayBn
b2VzIHJlYWRpbmcgc29tZXRoaW5nIGVsc2UgdGhhbiB0aGUgbWVudGlvbmVkIHN0cmluZw0KPiBi
ZWNhdXNlIHRoZSBwb2ludGVyIGlzIG5vdCBjb3BpZWQuDQoNCllvdXJzLA0KCS0tIE1hdHRpDQoN
Ci0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2Vt
aWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdy
b25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQo=
