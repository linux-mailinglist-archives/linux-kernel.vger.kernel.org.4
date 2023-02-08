Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77868F199
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBHPGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBHPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:06:53 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F035A254
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:06:50 -0800 (PST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-2hW5sY44M6GCz5W-EOpzbA-2; Wed, 08 Feb 2023 16:06:41 +0100
X-MC-Unique: 2hW5sY44M6GCz5W-EOpzbA-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0782.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.36; Wed, 8 Feb 2023 15:06:28 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ee37:449a:ef93:fada]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ee37:449a:ef93:fada%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 15:06:28 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: [REGRESSION] rtc: imx-sc: remove .read_alarm
Thread-Topic: [REGRESSION] rtc: imx-sc: remove .read_alarm
Thread-Index: AQHZO87r6JrHLUV5a0mkHf2nuLX1Pg==
Date:   Wed, 8 Feb 2023 15:06:28 +0000
Message-ID: <bbe470eaeeb17624444b37dbe35b0883193e475b.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0782:EE_
x-ms-office365-filtering-correlation-id: fc7a011d-62bd-4b14-4f0b-08db09e60dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: e/BTK+wAFJl7hyEIzWbQVaWuORSyYDkTVnqc1AgVwcnvHFEiCbcCQO+62JzcawR9Oulu82Tkg4xzJ0nndRLemLc7AaqWyER1D2Ueutql0t4pzstwG8pFLRVQnMx2h+n+Cc+eorWo52cQGFkFcrAORe5wOvDPdB64CveqCZKSmiW1WJFoVhexx1QdmvUO6H4jMjMFLxcwtKmKTq2RYIcLPzGvuBv8irBGVKwvHTa5JvqBAOzLnvmOJ4XzAtu1lUtWwtbKLXnOFBOqPEw1xwNg5uEJWtz8xuyL0HtrKFQW3UQVMnAdPM/lvO9kXVhiC7j9Yr5M5G3Gli+pimOZMSBjZROREY4+4Jewmqj9YAHU4qpoRWhm5TAj+MA/xWQysAWdxb28V/2IYEwIj1hqKsevrYysqimpnWBv8b3raB+1HNkPPOj/ltbf+CAlFcxF8/AkhGRrgB4gT/d2aX72ib+CSpR5ojbvSbWfj2QVOfmUogL+djxX9oaq7RytojapM6zjepBoQzQ8yXivoikmbVz0SWwsQMDv22GC+l563m0ca9VjA91JhA5FpOisORggylOPxZeDTe3VluEGbjsfrYgFYZglUtbto6TOPswXWuKPnv4hh3HYqEqn3OFWwXtS8YVGvPb9aLfxhxeRCo/RFhC96c4z0S5AXJaTJqLFfVsMHtR6MwvJTjVaLuG0o6gjqE9rdozSgIdDZ8TIsSAHX2I4vRfCjLb8CMQ3juCe+opQuRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39850400004)(451199018)(2906002)(38070700005)(4744005)(7416002)(44832011)(5660300002)(38100700002)(122000001)(66446008)(71200400001)(478600001)(36756003)(6486002)(2616005)(86362001)(6506007)(186003)(26005)(6512007)(6916009)(64756008)(8676002)(66476007)(66556008)(76116006)(66946007)(8936002)(41300700001)(4326008)(83380400001)(54906003)(316002)(142923001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2NQcldLMk1OU2RyNU9aSHNmVTYrWHNKL3B1d2FQQ3hDTllEcTFMa3M5M2JD?=
 =?utf-8?B?RXFiRmZzeCt0c0NGMy91Y0tJWDRXOTgvYkZBUTZWNDZhU3FDL0dkQUp3aytz?=
 =?utf-8?B?cHlaQ0pBdTFubUk5ZHN4NEdBSWF4U1FMaEJmWHBtMGU1VVpSQWxWdjEwczhJ?=
 =?utf-8?B?R1VZQVdVb1d1N3lKTDJGc09Lb3JlblpQUy9CTXZPaUptTU1Ib21LMmFJRDdu?=
 =?utf-8?B?RkhScWlNd1VLWHJCaXRFbDFtQmlTR2pPa3QyV1k3VXRiczJHZjBiTVJsWkhI?=
 =?utf-8?B?RTByeEpRdENBcVpINk5EVVUxUkJ5ZzVPcDFGcmxteXdJbFk3SWRyalRLNWpx?=
 =?utf-8?B?RHMrbVlyYzVwVG9sZDZwTlNHL1A0cVFXR2ZPUUZMd01YTUdub201WFMwN1Qy?=
 =?utf-8?B?ODJYNFI4M1h5ODUvYjk1d2dVTmNIdzVOcUpUdG83UEpXTzNYa0h6bnkraVVi?=
 =?utf-8?B?eUhBYVdyamhib2VGbkE1dUhYM3A0TWg2bTlqWlVFN3pNRUdwMUpMSEpvdWFG?=
 =?utf-8?B?MUU0YVMvaGt1dnRFdkJYTldHTmFaOWtFOWNDYitWaFZCM2NtY2VUUjdKbjkr?=
 =?utf-8?B?VTd2bjJoNTZrVlNPNzdqZkg5WVRITlZ5RWp3Y3B5S0hzL3hJZHAvZzBaLzNB?=
 =?utf-8?B?cWhudFFuNTFBaGp4K1dqVVpWT1NyMWJsUWVHSnBLUkx2bmU2LzNiQzdvaVN6?=
 =?utf-8?B?Um9vUXV3ZFFlNkpaQ0xpTW9FditqYnQ2VnI3S2FTbmFURXp2RUJ1Q0lYVm1k?=
 =?utf-8?B?M2Z0cVBidGxVZEFzeWZxT2tqZUovMXl2cW00YVNURFMrUFovN0hJZ2VwZURG?=
 =?utf-8?B?c2lNUy82ZkNPbEZYSVQ1QktyTGdpRk9RbS9qN2lmTzlTcWVVUkxUd1lkZFJr?=
 =?utf-8?B?MG90c2JPWFI2Q2UrZGF2VlRTd2hHN0JXTlZyOHdvcjFja1ZRbmdqb1VoTzkr?=
 =?utf-8?B?VDYrdVZlYTR0YUdNcGw4MUQ0blZnODFpOUozY3pSQUdLeFh3UkhRMVFQLy9y?=
 =?utf-8?B?Q3hZMExmMHY1bjFhY3hGNkxhb3pNNFlDVVk5VHR3NzVKVWFoYzNBYjl5WnU3?=
 =?utf-8?B?a0tYZWpweWh2cEppZ2NVeEtVNzlncFQzU3liTXNjZDZ5OWpCTFhSREpDck9o?=
 =?utf-8?B?eUlaRG9zVENhWFpMcENlYTNIRldHZnBqS2dsVExLYXdScVRLWVkxQjIxTXQ1?=
 =?utf-8?B?WWpBc2txVHlrQS9JajRaQVR6ZWZ6MXNxN2o0bzlaSTRxRlU1SHo1MUZ4djB3?=
 =?utf-8?B?OUthWTlrbjRXMm83Nko4YUREbzg3RVEvUkxuWUdnUFF0bmtLNWVmN1FmaEtM?=
 =?utf-8?B?Vm53eG9WZXovdXlmYmlTZEUyNFFldURzL1RCSEdCWWRqK05rME5ZKzhRWFhm?=
 =?utf-8?B?RjNJMVVKK0NETWhwWFZDYkFEdlNzWEI2amdsWjhTMEE4MTFGTytwOTJmZXVn?=
 =?utf-8?B?bG5jT0RhWVdFL2lKRGNUVmw5OXE0c1FHRE9Id01abFd4bVRoZGhBZkx2S0pF?=
 =?utf-8?B?Tk51aldzSkFIUkJVVHRvN29pelY2SDdkMXMyZjNYcEozUW00TDlJOHVzZWpU?=
 =?utf-8?B?MmVHcDFuNTd5dmQzZEVjbFJtUEZiY2NHellLcFJ0NGE2Q3ppLzN3RTlsWGdi?=
 =?utf-8?B?NEFGMGNxZ1lETDRWTnhDazVEYWUvVy8zMlFuNldybjVDUE1QeG14UHQ4TUY3?=
 =?utf-8?B?cElJZmdBOWEydkZNT0d2RE1MT0tRN0M0TWwwTkUwQ1g4VHIrTHBoNlRwM21S?=
 =?utf-8?B?cEx1SllqMXM5RWxibTdOb1Z6UFJoVEpoemFJQ3owYVQ0VDRUaVNLVlpxWFdM?=
 =?utf-8?B?a0xLYmdGWjlRdEozaWR2K1ZvL3diR3NvcjY5NnZITUV2K1IxMzV2TkI1Z2Rv?=
 =?utf-8?B?OC96M05EV3liVEpLVzNUMXNzR2pKSmpsd1BXZDJSa3libVR5K1U1bWp6YTRC?=
 =?utf-8?B?TzhWcnhwNUN2ZjFLZ25qbER5QXZsWVVSZW5KWEZwS1NlREFDUTNFYVFZVzRH?=
 =?utf-8?B?VWQxUFBVcE5TblE3Q1ZCMVNERDRjYkJIdXpsOE5pcjk1MFhLQVl1ZEhHaitP?=
 =?utf-8?B?UmNlaEU2ei8vUkhVSEJFWU1sbGR4NWlPZ3FydzROOXBIUXYxMllPamlnRDRs?=
 =?utf-8?B?bEJjc1hzellHMFJ1dU10Vk1XeVdFY0c2N3M0K0c5V05wZGl5YXoxaE5iUjBY?=
 =?utf-8?Q?xgh65X778pp+5Jc56q2qXpc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7a011d-62bd-4b14-4f0b-08db09e60dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 15:06:28.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yIjmopvLPsN1jYlCvZM5sTORTq1ajFHthj6cbA1eGGVf1p0AZRkqa7r2KD6Hlk1znYIbJBL5qesPF0hnt65U0Kc0iZXYn339tab5NZjWFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0782
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <C2FA59C21DB53E428E0EF67C231238D7@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlDQoNCldlcmUgeW91IGF3YXJlIHRoYXQgdGhpcyBicmVha3MgdGhlIHN5c2Zz
IHVzZSBjYXNlPyBFLmcuIGJlZm9yZSB3ZSB3ZXJlIGFibGUgdG8gc3VzcGVuZCBhbmQgcmVzdW1l
IDEwIHNlY29uZHMNCmxhdGVyIGFzIGZvbGxvd3M6DQoNCmVjaG8gKzEwID4gL3N5cy9jbGFzcy9y
dGMvcnRjMS93YWtlYWxhcm07IGVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZQ0KDQpTaW5jZSB0
aGUgcmVtb3ZhbCBvZiAucmVhZF9hbGFybSBpbiBjb21taXQgNzk0MjEyMWI4Y2EwICgicnRjOiBp
bXgtc2M6IHJlbW92ZSAucmVhZF9hbGFybSIpIHRoaXMgbm8gbG9uZ2VyDQpzZWVtcyB0byB3b3Jr
Lg0KDQpUaGlzIHNlZW1zIGxpa2UgYSByZWdyZXNzaW9uIG9yIGlzIHRoaXMgbm90IHN1cHBvc2Vk
IHRvIHdvcms/DQoNClRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

