Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA675B3168
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiIIIMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiIIIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:12:45 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2135.outbound.protection.outlook.com [40.107.135.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE31FA684;
        Fri,  9 Sep 2022 01:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcQ1S/o5wc9w5Ru1HrJldUWu7xaxRBcwce3Z57tQsaw/ZC60XRXR5vWArZ0yBznj61PCSg8qKZYlt8akzxDPRX75i+9Dt4qYUqFi2aAt1X2sc3QCIkeSHxtYu/TEmcUWDLJpRH8flgds3LAZnbiUSvGBAWDUwidyCcK2oJxWqKUQAosgUKF5UsojYc5DWB83wCEhu8Pibl9CRqRW26VJE82QoLZkF89bHibiwGAGXsXfumJnKpd17H6KZ5/wQc4xdI5DK+ozYBurh7TzZddq/EEADzC4TEqBV2ovBRqbFhNCdlxoCV+K2VR0E4+5Nb2RZMd/3A1aT7wAjuohdOp6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdXFfvVZ7DuZMd8CzTMVPEMK4KJfShFdhsEG2BpUOtQ=;
 b=ZXkz415vurs5IrrFibSBwdRr7qcqg165YAiJA72KZzv3LAPKQADQgyo/Pwjp2TViuQ1/5xqxEVPDvPIFKQ6xu9nFjuMHSB1IIn+J3HxStRenExG/wH5qNB+sWxArRp7BvKPVviBTgYcq/E7v+aB3CZAa7oJ1KjpAAB91SvLO7jVfoUM0KBxTBBLN/DUQCpUDy9C52/1/mNHG4rRcJCtbtmujdbCc7fkhBKu29lGyYF/NOurNLkXRTFiyD2iySEiDWmzHTX7yLbljNiK6aaDcYffhInJZTHudOEQxKFAlXyrX1sLfi/jmglGjXOqUcxBTuSN9usBLnIs74f/EsGBYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdXFfvVZ7DuZMd8CzTMVPEMK4KJfShFdhsEG2BpUOtQ=;
 b=pYfrUv1h584BpeTmOuY5GPMhmDrMLYBgx7Upie59fsqkblSmcEikxHZMRYG/SxyehcicW+M0eo5sE+2yOx6KdY7ZDF4Gezy7OfrKIo1JPcjMcelHpiFE2xx9S+yRaktG6DEBoveGv/fG3jnVi68OaKl49DH/OHrOFRNu4+eAqnw=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB2587.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6; Fri, 9 Sep
 2022 08:12:37 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2%7]) with mapi id 15.20.5632.006; Fri, 9 Sep 2022
 08:12:37 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 14/24] iio: buffer: wrap all buffer attributes into
 iio_dev_attr
Thread-Topic: [PATCH v6 14/24] iio: buffer: wrap all buffer attributes into
 iio_dev_attr
Thread-Index: AQHYxCPsas+Id2Xm/kKNaTS3hD62Dg==
Date:   Fri, 9 Sep 2022 08:12:37 +0000
Message-ID: <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-15-alexandru.ardelean@analog.com>
In-Reply-To: <20210215104043.91251-15-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB2587:EE_
x-ms-office365-filtering-correlation-id: 7f31a860-202d-478a-9605-08da923b0ed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UiXz6bKDSs1XQnw/FigCMRFm7zo8iuL83TN1ZHmrAddaxIwR/cP6sOKfnZeoSfYqrfmTXSVPGK8YrRhagoX0Yo2iF2mw7PjMzjZA7JK+6ChvkIWM8VvTSG2sBXRc6FTE3r3VlfKSyjz9kEzPCFAhwdMfb+azjMe+Qe+MyOznjZZa5xDNxPHICnbVc/12BwFbSMVuCbfGgfw35G1FqykvuYAyw143sxvb8p/zwaBwRq/YeDZ8b823m1CN7olmlyAQXhWsV9X1EJBA6lXYK827LC2jLiwfn4rTvRdttpysvaWBcEQm488jAJ26DGxkkgNoyTrplWikKcO8AbUgqeFYYa6vLhxeCDS0Ph032DaJCFyWarZg2GqjDCRGDEF+1k5J30fGHMLqBlqaYPURVgp5EFiF9Bjl8rFbDIZ7pORUHVkgukxVzDEQjol3AeohkzbZ8BTVycqoAyInsN1SMR1X65urZ86FKnSmY7D9prBioJmai4qcDfkCpTaNzEKPb2d6vgcQunmtFLUqJNvROjerhfwAEntcfuU5eTMhfejeSVU/7oN+3ljGnymmrYNR1XFxpDff3x4p33oJXDpHWmbKOJbko5YUzKa2szlk443Vg9XATA9ru/m+caw+msuYKGYyNjb3kYdx+BacHS/ZGRO662a7uexKN6tFGbwAS0nLNYusUMOQtVJvV/Isn0diPkF7lor0/CDoJkKFjQFRCMtphWIpnJOE+AJduvE1ji+l1riz8+L5nG0LRtLXiGdTdImyfDKIbXZY9pj/vgSAZqlDc04bNWVNj2AcVCAK/Dv5H6RfhwQCjEBDRpt+6wlpA5X4NBnZr8SO9vIYRhO1+iDFbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(346002)(136003)(39850400004)(38100700002)(76116006)(53546011)(91956017)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(6506007)(66946007)(38070700005)(54906003)(71200400001)(6486002)(110136005)(478600001)(41300700001)(86362001)(316002)(31696002)(2906002)(5660300002)(186003)(8936002)(83380400001)(31686004)(2616005)(122000001)(26005)(6512007)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhnWG5LVThIeTAxSkpqeXYyd0lNUzdqQ3pBcndmMUk2dE5JQXJGVEZRdkJz?=
 =?utf-8?B?WEw5Zkt1bUZNZzR1Qm9yQktyTklpVWtoem1wbkFGVmltb0RDcllreGVmdWhK?=
 =?utf-8?B?Q0J3OFVPVVUrNDIvYWhEdy9JcXk0SllqVDJFNlRKczNoMFR6cXJjOEZOSVRz?=
 =?utf-8?B?Nk1QclRyRzhoY2dXNHVGeE5sSXkwMWIwRkpuZWdxMXRSMHhKQVdDYXNvQlh0?=
 =?utf-8?B?a1BuekRxQzk1OGhNck5mMlEyWG1VQU1LQjIvS2Y0ZjNKbkcwT0k0TWZFMWdF?=
 =?utf-8?B?b2RoWG5EaCsrTUpMK1BWSGtZWXB2dDYyNmJZZzVJSDBaNHpMOGdnaDZBK2pw?=
 =?utf-8?B?MHFLYWY1S1FhT1RESDlha2E1OW1aNjVGT1pEc1RJNS8yZnJGWnhFMW9ZcTlq?=
 =?utf-8?B?dkVmQXJpVDJVNnVYS09Jd214OXRyelV0UFZXckhUY1NqK1hkVnBvaUZ5Q0lI?=
 =?utf-8?B?Y2lpZDU1R2dTUGxscHhQT3ZYUVl6amFzOHc0UG5qQ3ZFdG9LK1dBeG9HWCs5?=
 =?utf-8?B?RWFldGZjenp6aHlvbkNDc1dXVUZsT0U5d1o1TWFvVHRFU0NvdWdHNVhVQzd1?=
 =?utf-8?B?VG5TU3ZzR1I5ZTRBYjF2a2hmOEE3dS8zQWhNZm4xMDRNcjZZTWs0VVNwcWFl?=
 =?utf-8?B?NGpEV0pRVG16RGwzREhzem5mR05tSzByNnFlMVBWMHhTMzlMNEFNWWMza1ls?=
 =?utf-8?B?TlhLQUwwYjB1cTZBYmZtWjM5TjRUbUR6OXpiZHM3T1dxMjRXd05yNEhZSVNP?=
 =?utf-8?B?ejYrU1NqbXQwVitlNVFzRXJWcjFxWmFJRmN6K0dCcmZaMlEzbjBnUHFjMHY5?=
 =?utf-8?B?WWVWQm1aUUt5eWxFdjVDNXZmNmdFRnAvaDdxTC8xcXJ1RTJ1cW9vR0lQa2hW?=
 =?utf-8?B?UktJR2RtSzVBTlpYRmY5UFJDUzF3dW1CZmRCNkxJamdvYWlCanR3bWRERzlq?=
 =?utf-8?B?eDZlVHRDV2tyM2cyRlhTTEpVNE13NkE2bklXMWsxTVM0YkRJZEdpVldzdUti?=
 =?utf-8?B?RTRRWC95QU5RdzJ3RzdiQXF2Q0JRNmRZeEhiTGJVMEV4UGI0aHh4blNaU2pu?=
 =?utf-8?B?UjJpeUhFVE8rVmxiRFVVa3FwUW13Mndhc01Nc25JbmRlSERnWUNENzAzc281?=
 =?utf-8?B?bXVNcXlIQ1lxWjdUbFZLVWdZc2FTc1l2V01xZE0xM1Q1M1RvblRZYWU0bHI0?=
 =?utf-8?B?SUphSTArMVFPbGJmWHgyb3lFWXBYQnQ2OGxyKzV0dGM2MTVqSk93YnVxRXNm?=
 =?utf-8?B?aGV3TXJvVWdHWGwzbENsb0xDOU1kN3Z1QWsxaCtKMFc3aWRwSGJBTE53MXlL?=
 =?utf-8?B?WTNWOHo3RlNYMmZ3RENSWXhINkJiQXE0Z3YxbmVOOE85NWFSQjRQcWxqVHA3?=
 =?utf-8?B?ek5QcnBpTHlKZmlDa1ZjRS9lMUdsWEVJTzBPUkQ5MGFrdlhYK2JnTVpwTy9N?=
 =?utf-8?B?cVJyR1hXNm90c0pNbjBMb2lTalNZRTFvd0RwWEhkZ0NFSmRwZ3lQVGFhVkRK?=
 =?utf-8?B?RW1CUzlHZkRNZGFyNWUwVU1QUzNpUEFOcmFXVXQ0MWdKVnowRFhEa3Nyc1lj?=
 =?utf-8?B?WS9WOUFSNktGalgvVWlPcFJmbUlCYmNvait6NFpmS0JjdEpqdUVDTVgvRnIv?=
 =?utf-8?B?SnRXRHkvVWcwM0ZoNnEwT2Z1TVE3OHR3eU95emFiZ29rREpNTjFkQk5zZm9o?=
 =?utf-8?B?QXRrTXFZbkVQaERTRGR3RTVFUW1kSmxWYW5haWdSRGlXZW9MNHZ5N0tSZVN4?=
 =?utf-8?B?ak02V3BGNW9MVTlxb3R0THVXSkZUMFVNbjk5b3NVWkpNaXB1elNyTk45NEY4?=
 =?utf-8?B?cnRyNGV0VDNPUHpZY3FFRFoveHpURWRLMHV6RVE5YzA1bUx4QlFlbnB0OW9C?=
 =?utf-8?B?S2luQWxnLzI3SWdhc0E1bWVaSzlWejhpQUxpN3VoSzhhYmxIeC93UGMxNUh0?=
 =?utf-8?B?cE5CUVI2WmVKYkZIY25rZnpxa3cyYUdEZGhPUStQRElvaXNqSFRtM0FDUStv?=
 =?utf-8?B?dHJnZGltTGE4U2ZkMW1paG5zT2RwcEJXTTN6WXREVC9sc0phdDl1VS9jNldM?=
 =?utf-8?B?TjFhclNUYThIRmVDYlYxcVhuK1Z5WS9SYnFxTHRjMmc1MHdRa0s2MlZhMEI0?=
 =?utf-8?B?UmhaVzRNQ3ZUd3VTdlhIY0M2c251V3pjQ1lXUUpNVFNwaTQveC85aFRkWHcy?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A0BE3CB0E38E74E8920F3C80274E44B@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2587
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGVlIEhvIHBlZXBzIQ0KDQpEaXNjbGFpbWVyIC0gSSBoYXZlIG5vIEhXIHRvIHRlc3QgdGhp
cyB1c2luZyByZWFsIGluLXRyZWUgZHJpdmVycy4gSWYgDQpzb21lb25lIGhhcyBhIGRldmljZSB3
aXRoIGEgdmFyaWFudCBvZiBibWMxNTAgb3IgYWR4bDM3MiBvciAgLSBpdCdkIGJlIA0KbmljZSB0
byBzZWUgaWYgcmVhZGluZyBod2ZpZm9fd2F0ZXJtYXJrX21heCBvciBod2ZpZm9fd2F0ZXJtYXJr
X21pbiANCndvcmtzIHdpdGggdGhlIHY2LjAtcmM0LiBNYXliZSBJIGFtIG1pc3JlYWRpbmcgY29k
ZSBhbmQgaGF2ZSBteSBvd24gDQppc3N1ZXMgLSBpbiB3aGljaCBjYXNlIEkgYXBvbG9naXplIGFs
cmVhZHkgbm93IGFuZCBnbyB0byB0aGUgY29ybmVyIA0Kd2hpbGUgYmVpbmcgZGVlcGx5IGFzaGFt
ZWQgOikNCg0KT24gMi8xNS8yMSAxMjo0MCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiBU
aGlzIGNoYW5nZSB3cmFwcyBhbGwgYnVmZmVyIGF0dHJpYnV0ZXMgaW50byBpaW9fZGV2X2F0dHIg
b2JqZWN0cywgYW5kDQo+IGFzc2lnbnMgYSByZWZlcmVuY2UgdG8gdGhlIElJTyBidWZmZXIgdGhl
eSBiZWxvbmcgdG8uDQo+IA0KPiBXaXRoIHRoZSBhZGRpdGlvbiBvZiBtdWx0aXBsZSBJSU8gYnVm
ZmVycyBwZXIgb25lIElJTyBkZXZpY2UsIHdlIG5lZWQgYSB3YXkNCj4gdG8ga25vdyB3aGljaCBJ
SU8gYnVmZmVyIGlzIGJlaW5nIGVuYWJsZWQvZGlzYWJsZWQvY29udHJvbGxlZC4NCj4gDQo+IFdl
IGtub3cgdGhhdCBhbGwgYnVmZmVyIGF0dHJpYnV0ZXMgYXJlIGRldmljZV9hdHRyaWJ1dGVzLiAN
Cg0KSSB0aGluayB0aGlzIGFzc3VtcHRpb24gaXMgc2xpZ2h0bHkgdW5zYWZlLiBJIHNlZSBmZXcg
ZHJpdmVycyBhZGRpbmcgDQpJSU9fQ09OU1RfQVRUUnMgaW4gYXR0cmlidXRlIGdyb3Vwcy4gRm9y
IGV4YW1wbGUgdGhlIGJtYzE1MCBhbmQgYWR4bDM3MiANCmFkZCB0aGUgaHdmaWZvX3dhdGVybWFy
a19taW4gYW5kIGh3Zmlmb193YXRlcm1hcmtfbWF4Lg0KDQpMb25nIHN0b3J5IHNob3J0IChvciB0
aGUgb3RoZXIgd2F5IGFyb3VuZD8pDQoNCkkgd2FzIGRldmVsb3BpbmcgYSBkcml2ZXIgZm9yIFJP
SE0vS2lvbml4IEtYMDIyQSBhY2NlbGVyb21ldGVyLiBJIGRpZCBhIA0KcmFuZG9tIHBpY2sgYW5k
IGNob3NlIHRoZSBibWMxNTAtY29yZSBhcyBhIHJlZmVyZW5jZSBob3cgb3RoZXJzIGhhdmUgDQpp
bXBsZW1lbnRlZCB0aGUgYWNjZWwgZHJpdmVycy4gRHVyaW5nIHRoZSB0ZXN0aW5nIEkgbm90aWNl
ZCB0aGF0IHVzaW5nIA0KSUlPX0NPTlNUX0FUVFJzIGZvciB0cmlnZ2VyZWQgYnVmZmVycyBzZWVt
IHRvIGNhdXNlIGFjY2VzcyB0byBzb21ld2hlcmUgDQppdCBzaG91bGRuJ3QuLi4gT29wcy4NCg0K
UmVhZGluZyB0aGUgY29kZSBhbGxvd3MgbWUgdG8gYXNzdW1lIHRoZSBwcm9ibGVtIGlzIHdyYXBw
aW5nIHRoZSANCmF0dHJpYnV0ZXMgdG8gSUlPX0RFVl9BVFRScy4NCg0Kc3RhdGljIHN0cnVjdCBh
dHRyaWJ1dGUgKmlpb19idWZmZXJfd3JhcF9hdHRyKHN0cnVjdCBpaW9fYnVmZmVyICpidWZmZXIs
DQorCQkJCQkgICAgICBzdHJ1Y3QgYXR0cmlidXRlICphdHRyKQ0KK3sNCisJc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmRhdHRyID0gdG9fZGV2X2F0dHIoYXR0cik7DQorCXN0cnVjdCBpaW9fZGV2
X2F0dHIgKmlpb19hdHRyOw0KKw0KKwlpaW9fYXR0ciA9IGt6YWxsb2Moc2l6ZW9mKCppaW9fYXR0
ciksIEdGUF9LRVJORUwpOw0KKwlpZiAoIWlpb19hdHRyKQ0KKwkJcmV0dXJuIE5VTEw7DQorDQor
CWlpb19hdHRyLT5idWZmZXIgPSBidWZmZXI7DQorCW1lbWNweSgmaWlvX2F0dHItPmRldl9hdHRy
LCBkYXR0ciwgc2l6ZW9mKGlpb19hdHRyLT5kZXZfYXR0cikpOw0KDQpUaGlzIGNvcHkgZG9lcyBh
c3N1bWUgYWxsIGF0dHJpYnV0ZXMgYXJlIGRldmljZV9hdHRycywgYW5kIGRvZXMgbm90IHRha2Ug
DQppbnRvIGFjY291bnQgdGhhdCBJSU9fQ09OU1RfQVRUUlMgaGF2ZSB0aGUgc3RyaW5nIHN0b3Jl
ZCBpbiBhIHN0cnVjdCANCmlpb19jb25zdF9hdHRyIHdoaWNoIGlzIGNvbnRhaW5pbmcgdGhlIGRl
dl9hdHRyLiBFZywgY29weWluZyBpbiB0aGUgDQppaW9fYnVmZmVyX3dyYXBfYXR0cigpIGRvZXMg
bm90IGNvcHkgdGhlIHN0cmluZyAtIGFuZCBsYXRlciBpbnZva2luZyB0aGUgDQonc2hvdycgY2Fs
bGJhY2sgZ29lcyByZWFkaW5nIHNvbWV0aGluZyBlbHNlIHRoYW4gdGhlIG1lbnRpb25lZCBzdHJp
bmcgDQpiZWNhdXNlIHRoZSBwb2ludGVyIGlzIG5vdCBjb3BpZWQuDQoNCkkgYmVsaWV2ZSBwcm9i
bGVtIGhhcyBiZWVuIHRoZXJlIGZvciBhIHdoaWxlIG5vdyAtIGludHJvZHVjZWQgYnkgdGhpczoN
CjE1MDk3YzdhMWFkYyAoImlpbzogYnVmZmVyOiB3cmFwIGFsbCBidWZmZXIgYXR0cmlidXRlcyBp
bnRvIA0KaWlvX2Rldl9hdHRyIikgYXQgRmViIDIwMjEuDQoNCkkgZG9uJ3QgaGF2ZSBhIGZpeCBm
b3IgeW91IGFzIEkgYW0gbm90IHN1cmUgd2hhdCB3b3VsZCBiZSB0aGUgY29ycmVjdCANCmZpeC4g
V2UgX2NvdWxkXyBnbyB0aHJvdWdoIGFsbCB0aGUgSUlPIGRyaXZlcnMgYW5kIGVuc3VyZSBub25l
IHVzZWQgDQpJSU9fQ09OU1RfQVRUUnMgZm9yIHRyaWdnZXJlZCBidWZmZXJzLiBUaGlzIHdvdWxk
IElNSE8gYmUganVzdCBhIA0Kd29ya2Fyb3VuZCB0byB0aGUgcmVhbCBwcm9ibGVtIC0gd2hpY2gg
aXMgYXNzdW1wdGlvbiB0aGF0IGFsbCBhdHRyaWJ1dGVzIA0KaW4gdGhlIGF0dHJpYnV0ZSBncm91
cCBhcmUgZGV2X2F0dHJzLiBTdWNoIHNpbGVudCBhc3N1bXB0aW9ucyBhcmUgDQpmcmFnaWxlIGFz
IHdlIHNlZSA6KQ0KDQpJZiB3ZSBvcHQgdHJlYXRpbmcgYWxsIGF0dHJpYnV0ZXMgaW4gdGhlIGdy
b3VwIGFzIGRldmljZV9hdHRycyBhbHNvIGluIA0KdGhlIGZ1dHVyZSwgdGhlbiAoaW4gbXkgbm90
IGFsd2F5cyBzbyBodW1ibGUgb3BpbmlvbikgdGhlIEFQSXMgc2hvdWxkIA0KZm9yY2UgdGhpcyAt
IGJ1dCBJJ20gbm90IHN1cmUgaG93IHRvIGRvIHRoYXQuDQoNCkJlc3QgcmVnYXJkcw0KCS0tIE1h
dHRpDQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJP
SE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRl
cmx5IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQo=
