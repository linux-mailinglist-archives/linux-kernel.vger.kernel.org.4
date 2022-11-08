Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444F0620B00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiKHIPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHIP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:15:29 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189B23EAC;
        Tue,  8 Nov 2022 00:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBzzkhK5xST7minsro2Ab4M4N60WAoloP5fj0gB8GrJhHztWcvz/ZOxrgBTjAwymQtEmKhpwi6ZwPQvebPKirPtIbZshNJzDRgLTfGxWY+JHH4M84a1xVrzJwh5uirtfCaBSamt2plmQu7JStCf6uKA7yMiBF0sLLEZMvPkkfjN2oKQRjjeKhscuAeVCjCnlLxH/e4dRsu/hDMCwfQI/y4FuQTCMeydWXHPrKND/jhlDER5o29kOOFmXOwOuFH05Joxpn3lH45hydwgZQKHuLJZb8vpMTn/KmnhXDjNYepwqytbNwpik9v6AVZ+0vL0aUBp55RQW7gQ6iD00I7Thhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Msu+61ZznNvMGxWW2cJpHdNArwOs9Twf8jcerQnd5bs=;
 b=BFXzKejFalMVWhgnZHbv9q9iqlvQUWSDLqw/DgDFw7S9wByocSHhLvIxJ+3haVNGOR1eilSvM9RrxTBd8uw0Txy4KXlap0lW3sDjLauV4PMigf6T0Kfunft0ij3GuKcV10PHM2382aZNZAwlhlpCT+jTSS3TXhljBc742INVKxKhE8nwcbGeMeDF45usTrnRf8QhaKmvcy1CtDx91XDFXB2q+hRMZjnGnt5monGERysLuh+ef9i88pzlh1rUZFs28St4QJgbvy92BGmD+YguNIXnHZakGwNJu23077Nh+5QmtHkxIKmKHMHOieX/hmr/D+LsEA0q/IzHROs8OEzmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Msu+61ZznNvMGxWW2cJpHdNArwOs9Twf8jcerQnd5bs=;
 b=GHxBxf8P80auZD+y8bBtUjsdBXn9CtwulbPy1yUvUUaplnO99xCuUTY3aT7jOGpENFswmx0KCdAYfft3vT22FJsXJJ3iepAJKpin9OHMliq9tralhEW4YBJx6EIsGqq9anFUv4+GKBRdXfofxMd8UdSGRrZ/QgNFa7jMSsnhCpD2ds5mfZ+COUEsCu/lqH06KMQXzpoLeSBCgPo/1DANlL/+l49zSxAS3HsJYO1IElwI8zjHLCCua+hCdZ727CY5QZMYImkaWcg+ff69g4DjQOjK0dlexb0wQXnkf073cYxF7dQyPHo/d4kwHOIfUU79qQALXiLkcRii4qroo+3+eA==
Received: from PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23e::20)
 by PAXPR10MB5408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 08:15:25 +0000
Received: from PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9a2:43d3:12c:f695]) by PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9a2:43d3:12c:f695%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 08:15:25 +0000
From:   "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
To:     "rogerq@kernel.org" <rogerq@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: Coverity: gpmc_is_valid_waitpin(): Control flow issues
Thread-Topic: Coverity: gpmc_is_valid_waitpin(): Control flow issues
Thread-Index: AQHY8IRB9ZtHrJ3BMEisffpY/LZZHq4zK+IAgAAAvQCAAYMsgIAAA60A
Date:   Tue, 8 Nov 2022 08:15:25 +0000
Message-ID: <57664014384bae015d593a7c6c6b7715fda3e89d.camel@siemens.com>
References: <202211041233.4D45359E7@keescook>
         <7cdf3d14-3f1b-7cd4-e8b9-e94b5359bf82@kernel.org>
         <e4e4c4f0-782b-9f89-d7a2-859c7759ca66@kernel.org>
         <b18cddde778ada5030f6a80308854cf9c0dc4d23.camel@siemens.com>
In-Reply-To: <b18cddde778ada5030f6a80308854cf9c0dc4d23.camel@siemens.com>
Reply-To: "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5520:EE_|PAXPR10MB5408:EE_
x-ms-office365-filtering-correlation-id: df85a2f5-b491-4dbe-5283-08dac161639e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzupCivO6n4SsQIsvfmwtSbWqW6ElpW1rssyRGoNjDbw88/Zp7yOTPlEMrf7Mu3MYTu+LzNTM588xNyMdo8uk1DObvAta+oCuyHXXJK/euHiQDY2XRyBjk1gtPfYlrO9D5KDPZIkOcE4xd5p399IynlVKX8EiI8AKf0YOCLSTXyLrogca76lU0jfkqV302amwR5JXsvUL29nb/FG7XV7tVUsSelZc5LBhkp+xYcSmzKsRTCNxF4SGpNMuJhc8gKsuzpX9bQg1z1AYWu3AFPEDkCyVPdQxslsuTDRRohh4j1fY56gyUbU7G3hVz4Z8qBNgeVAHn4Y0NnHG9nKlUifbF4teF0OvOqhH+yw7Dp+rY4pUzA9stxoko3q+uy4Wnd0yPycmkBDTUG3YC8QryDtT7gpSpMM2JH2sa2b+qxbnQzLdMZeGhJSCwfjztpIDRYuS/NjGHFrs8Bnn/PKFXK3hGaYDpeawIusQtvmP679VL9Y/csvl8yzjzfOolgGX3tcizsCWFlbufLb17DzG3E1gkU2mwz9CS4aH3nYGHAfXIPSoDNBtmeON4kI3O8nIWj4AbRKPxcAbbgW3dlFpmlyCNfJfsRNy3NOGoYFYTuNL/sVdHApX8TSGHlT+eMB0X8+CaDtT9wJdotOU1WBxqMFxg3NOI2/xVhmkVgsI11orj/A07E6KgikcM1YDrSP3gP7kuWXVnOPRpO+7hv6FXdhpcDi/3Bkcwy4bKQhMIzBmG/pOCVkNrrdjg5lwqn0egE/xuCKhqVHKjo3kbAo9J8yZ4vvUEu0bqc2C42EjycGzvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(5660300002)(8936002)(82960400001)(41300700001)(38100700002)(64756008)(8676002)(91956017)(66476007)(66446008)(66556008)(66946007)(4326008)(2906002)(83380400001)(36756003)(45080400002)(3450700001)(316002)(54906003)(86362001)(110136005)(76116006)(966005)(6486002)(478600001)(71200400001)(6512007)(38070700005)(53546011)(6506007)(122000001)(186003)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVEyckdnOC9RNmNOeHN2TkZwYm04bElpOUg1dXJwRHV4NEd5ejQwcDhnWW9L?=
 =?utf-8?B?K3RzaC96N0JGVTVsem5tajUxMzA0bTZJZlBXZzR2alh4WjFENzNkNGpqWGt5?=
 =?utf-8?B?ZGQzZmtZOWhCZER1V3M0aFd3aWxEN1ZSVjkvM3RQZ25vdFh1WlBJM3UxRWt2?=
 =?utf-8?B?NFVoSGsyODVUY2d5YWtqR0QyR1JFRWRIRVh4WFROUFBYS2ovRzBJZk5GZW02?=
 =?utf-8?B?UUdKOHJDQ05Ja2Jram9RdTBNaU0xN2NlTTlhUGZGMkN6eHZGNWNpQ2xQd3JE?=
 =?utf-8?B?Rko0akQ0Y0x3RGlxZEluenhpeUhwWm1tUXZGSnB5TU5iN29rRDdwdFhKMnBY?=
 =?utf-8?B?THN1Nk9saitqa041eHUvVEk1dmFaTkFqei91VVFzbVE1dWYzMnoxSzZPZ2h4?=
 =?utf-8?B?c29YOXpKQnc0emlXRjNYNXFtU0wxZXdCdW0xdHNaWTJUTGxlZmxLcnBtRFN5?=
 =?utf-8?B?WnlNL0t2ZExRd3dsUFZld2dYK2xGendEQzVLYzV5bGJ0TmtoaU5UUTJWd3o2?=
 =?utf-8?B?RTVsL25yb1B5V25waUNXVUp5RkEvYzV1WlJPRWJBQjVOcGFPK2N4U21vbmVG?=
 =?utf-8?B?aU1sUVVpb1lWU1R3YVpMZWlkTjMwNVp4RERmRDVYb1ZoaHFXdzl3NURRZmh1?=
 =?utf-8?B?YkdBOTZka2R4YTV3Q0dlMitMaVZNSDJ3TTFReUFQN2ZJWmtmbmpNNU5kdW43?=
 =?utf-8?B?Z0Yzd1g1SmZJZzdjOHlxT3N2SVJuZFJ0QlFTMU9GTC9rd1QraTNvTXl4TEdF?=
 =?utf-8?B?cm9wd09qVkpVWmdDMXY1ZnE0Z1pqYisxK3Nsd0VJMlVDQk9uSDZzSWdzMU1J?=
 =?utf-8?B?cW94VW5wUGVIR2t3bC9zSXBkbGh3VVFNdjNON3NGTVpkeVpjNTN2VWdOdEFB?=
 =?utf-8?B?VFF3bG9HcDhtaDg5Nmw3V3dpWi8wZDZWSnVDWFM0UkZXblZ0bmIwSW02SDg4?=
 =?utf-8?B?cFFBdkMramErOFVSbEhyTzlFQ0IvcUxTS0d3eGlsNGRZMEY0UTgxWVFRNG5O?=
 =?utf-8?B?NzVsTEVFODYyeWpqQzJJenJyQWRWbjNFOWZnb2VSVTc3TldkQTdiQWNFVGlj?=
 =?utf-8?B?cy9LWFVJY2Zpb1M3VEthVm1aQVA4RC90eHVjM2RyRTd3WUVOM2RNMWNTSkVK?=
 =?utf-8?B?Tnlqdkw3TThWV0NqUXhlZW5SZ3RINFVOUnpMQnF5L0ZaREpnUzJocDRMNVJ3?=
 =?utf-8?B?R3c2NkZMajJEdlN0N2QxNWVrUDY1cGN2M0NRUlhLT0lhcmdjeThFYVVDc3g1?=
 =?utf-8?B?aHZDYVFHRk5CNnJxbUx3ZDNyN2dQemt3TE9wNFY0M04yR3o2clJVZGRpMVFI?=
 =?utf-8?B?VXhyM1BFQzM5MU10c1ZuTndHRFd6MlkwVHU2QVRoVThxeWtDcWhoOXFLa1Ja?=
 =?utf-8?B?Wmkrdm43N3pWZnhyTTdENy9zK2ZaMk92VHFoN0ZVM2VpRlhaZUo0WWFGeEVF?=
 =?utf-8?B?NmNCQXcwcTNiNlhMY243NjRTSUxWOHc3WndURi9ldHBiRHpXNDlpNDBqL1Nt?=
 =?utf-8?B?LytwWEZqRjhldGJmeW8vbm5jclRYdWErUTJEaWNCRzVjYzA5bzFaSlMvcDdj?=
 =?utf-8?B?UVRsS1FVNUt5UFZmUm10NGRZMjJHSk1TU0xFSCtISzJPTVQ5eEFvNHoyMnZP?=
 =?utf-8?B?b3lOOEFMczE2ZUJFVHJqaU5hVDdyVUpHNkF5U0hQOG1iODhKRGJvK2FyUUtQ?=
 =?utf-8?B?dWRoVDZUdGxmR01HalVzKzllTnlPYnRGbS9tcm5NaWMwV2thaUh3akZzSHRh?=
 =?utf-8?B?ejRhNTl3clBsb2ZLYUQ1a0o4Ris5YVAxMkxiT29kYk5MNGFYOU1aQVllYmdk?=
 =?utf-8?B?bDlaVldueXM1SXNQTi9iZEZTUEJldDc0aW01SVlqS3FOZ0ZLazlxWmkwZFlw?=
 =?utf-8?B?SUljRW10a3F6Q0RJWFoxaS90RWNvZVpLTGEyNzEyeEFFTFg3dWs4ZmR2cVdZ?=
 =?utf-8?B?YVlFazlmMEVJNHhuTmF2bStsb2MxbEx4WFZwTmlGMDFneHVkQ1lQSkN4bE5F?=
 =?utf-8?B?Snk2QzVTMGxENnJocGV2UFloMkY4eGZtcFRCOTdWSm44TGF2UjhTVk9ibTFW?=
 =?utf-8?B?THJ2Sm14TFBKc3lNNGtwMFZBOWZZRUl0N0NPQmp4YWJkc3kzcVNmaU0wWEVS?=
 =?utf-8?B?OW5oS0VFbHhYRDBrVjlXRU5qY0h0dWtTb3MrMGE2ZlFCeTVQK294WlRWRUdS?=
 =?utf-8?B?c3M3eWsyN2l6eGJDMnVyNHU5OGZJVG5hYXo3d0NHUEhOVEhIRURsNWZiNEtK?=
 =?utf-8?Q?HxL7IzIQoaJ1zBAx6uXTnrqdiDzavZCiDR+l4/QZaI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63E2511E524A942AFCB68C7ABECA676@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: df85a2f5-b491-4dbe-5283-08dac161639e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 08:15:25.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdzwEENMLWDKLUbRz7J72YF72fOn4mFB/6E9+ZG/lpnzetPD11NzSOotlYBQa65pSgeLBrIjUgzYfmQhEfzzg+84n+phYgP/rXYAlEIKrg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDA5OjAyICswMTAwLCBCZW5lZGlrdCBOaWVkZXJtYXlyIHdy
b3RlOg0KPiBPbiBNb24sIDIwMjItMTEtMDcgYXQgMTA6NTYgKzAyMDAsIFJvZ2VyIFF1YWRyb3Mg
d3JvdGU6DQo+ID4gT24gMDcvMTEvMjAyMiAxMDo1MywgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4g
PiA+IEhpIEJlbmVkaWt0LA0KPiA+ID4gDQo+ID4gPiBPbiAwNC8xMS8yMDIyIDIxOjMzLCBjb3Zl
cml0eS1ib3Qgd3JvdGU6DQo+ID4gPiA+IEhlbGxvIQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBp
cyBhbiBleHBlcmltZW50YWwgc2VtaS1hdXRvbWF0ZWQgcmVwb3J0IGFib3V0IGlzc3VlcyBkZXRl
Y3RlZCBieQ0KPiA+ID4gPiBDb3Zlcml0eSBmcm9tIGEgc2NhbiBvZiBuZXh0LTIwMjIxMTA0IGFz
IHBhcnQgb2YgdGhlIGxpbnV4LW5leHQgc2NhbiBwcm9qZWN0Og0KPiA+ID4gPiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZz
Y2FuLmNvdmVyaXR5LmNvbSUyRnByb2plY3RzJTJGbGludXgtbmV4dC13ZWVrbHktc2NhbiZhbXA7
ZGF0YT0wNSU3QzAxJTdDYmVuZWRpa3QubmllZGVybWF5ciU0MHNpZW1lbnMuY29tJTdDMWEyNWNj
ODcwNDUyNGYyNDIyNDEwOGRhYzA5ZGZhYjclN0MzOGFlM2JjZDk1Nzk0ZmQ0YWRkYWI0MmUxNDk1
ZDU1YSU3QzElN0MwJTdDNjM4MDM0MDgxOTk0MDg3NDYxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPVcxS2xCS2c5bndFRGZGQWJxVzZK
dzd2MWQ0NkhRTGo4Ulg4d2xaOVJIeWMlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+ID4gDQo+ID4g
PiA+IFlvdSdyZSBnZXR0aW5nIHRoaXMgZW1haWwgYmVjYXVzZSB5b3Ugd2VyZSBhc3NvY2lhdGVk
IHdpdGggdGhlIGlkZW50aWZpZWQNCj4gPiA+ID4gbGluZXMgb2YgY29kZSAobm90ZWQgYmVsb3cp
IHRoYXQgd2VyZSB0b3VjaGVkIGJ5IGNvbW1pdHM6DQo+ID4gPiA+IA0KPiA+ID4gPiAgIFdlZCBO
b3YgMiAxMDowMjozOSAyMDIyIC0wNDAwDQo+ID4gPiA+ICAgICA4OWFlZDNjZDVjYjkgKCJtZW1v
cnk6IG9tYXAtZ3BtYzogd2FpdCBwaW4gYWRkaXRpb25zIikNCj4gPiA+ID4gDQo+ID4gPiA+IENv
dmVyaXR5IHJlcG9ydGVkIHRoZSBmb2xsb3dpbmc6DQo+ID4gPiA+IA0KPiA+ID4gPiAqKiogQ0lE
IDE1MjcxMzk6ICBDb250cm9sIGZsb3cgaXNzdWVzICAoTk9fRUZGRUNUKQ0KPiA+ID4gPiBkcml2
ZXJzL21lbW9yeS9vbWFwLWdwbWMuYzoxMDQ4IGluIGdwbWNfaXNfdmFsaWRfd2FpdHBpbigpDQo+
ID4gPiA+IDEwNDIgICAgIAlzcGluX3VubG9jaygmZ3BtY19tZW1fbG9jayk7DQo+ID4gPiA+IDEw
NDMgICAgIH0NCj4gPiA+ID4gMTA0NCAgICAgRVhQT1JUX1NZTUJPTChncG1jX2NzX2ZyZWUpOw0K
PiA+ID4gPiAxMDQ1DQo+ID4gPiA+IDEwNDYgICAgIHN0YXRpYyBib29sIGdwbWNfaXNfdmFsaWRf
d2FpdHBpbih1MzIgd2FpdHBpbikNCj4gPiA+IA0KPiA+ID4gV2Ugd2lsbCBuZWVkIHRvIGNoYW5n
ZSB0aGlzIHdhaXRwaW4gYXJndW1lbnQgdG8gaW50Lg0KPiA+ID4gSW4gYWRkaXRpb24gd2Ugd2ls
bCBhbHNvIG5lZWQgdG8gY2hhbmdlDQo+ID4gPiBzdHJ1Y3QgZ3BtY193YWl0cGluLT5waW4gYW5k
IHN0cnVjdCBncG1jX3NldHRpbmctPndhaXRfcGluDQo+ID4gPiB0byBpbnQgYXMgaW4gdGhlIGNv
ZGUgd2UgYXJlIHJlbHlpbmcgb24gR1BNQ19XQUlUUElOX0lOVkFMSUQgbG9naWMgd2hpY2ggaXMg
LTEuDQo+ID4gDQo+ID4gQW5vdGhlciBhbHRlcm5hdGl2ZSB3aXRoIGxlc3MgY2h1cm4gaXMgdG8g
bGVhdmUgdGhlbSBhcyB1MzINCj4gPiBidXQgbWFrZSBHUE1DX1dBSVRQSU5fSU5WQUxJRCBzZXQg
dG8gYSBsYXJnZSBwb3NpdGl2ZSBudW1iZXIuDQo+IE9rLCBJIHdpbGwgZml4IHRoYXQuIA0KPiBE
byBJIG5lZWQgdG8gc2VuZCBhIG5ldyBmaXgtcGF0Y2ggb24gdG9wIHRoZSBjdXJyZW50IHBhdGNo
IHNlcmllcz8gDQo+IE9yIHNob3VsZCBJIGp1c3Qgc2VuZCBvbmx5IHRoZSBidWdmaXgtcGF0Y2gg
Zm9yIHRoZSBjb3Zlcml0eS1ib3Q/IA0KPiANClNvcnJ5LCBhbm90aGVyIFF1ZXN0aW9uOiANCklz
IGl0IHNvbWVob3cgcG9zc2libGUgdG8gY2hlY2sgbG9jYWxseSBpZiB0aGUgYnVnZml4IGFjdHVh
bGx5IGZpeGVkIHRoZSBidWcsIGJlZm9yZSBJIHN1Ym1pdCB0aGUgcGF0Y2g/DQoNCj4gDQo+ID4g
PiA+IDEwNDcgICAgIHsNCj4gPiA+ID4gdnZ2ICAgICBDSUQgMTUyNzEzOTogIENvbnRyb2wgZmxv
dyBpc3N1ZXMgIChOT19FRkZFQ1QpDQo+ID4gPiA+IHZ2diAgICAgVGhpcyBncmVhdGVyLXRoYW4t
b3ItZXF1YWwtdG8temVybyBjb21wYXJpc29uIG9mIGFuIHVuc2lnbmVkIHZhbHVlIGlzIGFsd2F5
cyB0cnVlLiAid2FpdHBpbiA+PSAwVSIuDQo+ID4gPiA+IDEwNDggICAgIAlyZXR1cm4gd2FpdHBp
biA+PSAwICYmIHdhaXRwaW4gPCBncG1jX25yX3dhaXRwaW5zOw0KPiA+ID4gPiAxMDQ5ICAgICB9
DQo+ID4gPiA+IDEwNTANCj4gPiA+ID4gMTA1MSAgICAgc3RhdGljIGludCBncG1jX2FsbG9jX3dh
aXRwaW4oc3RydWN0IGdwbWNfZGV2aWNlICpncG1jLA0KPiA+ID4gPiAxMDUyICAgICAJCQkgICAg
ICBzdHJ1Y3QgZ3BtY19zZXR0aW5ncyAqcCkNCj4gPiA+ID4gMTA1MyAgICAgew0KPiA+ID4gPiAN
Cj4gPiA+ID4gSWYgdGhpcyBpcyBhIGZhbHNlIHBvc2l0aXZlLCBwbGVhc2UgbGV0IHVzIGtub3cg
c28gd2UgY2FuIG1hcmsgaXQgYXMNCj4gPiA+ID4gc3VjaCwgb3IgdGVhY2ggdGhlIENvdmVyaXR5
IHJ1bGVzIHRvIGJlIHNtYXJ0ZXIuIElmIG5vdCwgcGxlYXNlIG1ha2UNCj4gPiA+ID4gc3VyZSBm
aXhlcyBnZXQgaW50byBsaW51eC1uZXh0LiA6KSBGb3IgcGF0Y2hlcyBmaXhpbmcgdGhpcywgcGxl
YXNlDQo+ID4gPiA+IGluY2x1ZGUgdGhlc2UgbGluZXMgKGJ1dCBkb3VibGUtY2hlY2sgdGhlICJG
aXhlcyIgZmlyc3QpOg0KPiA+ID4gPiANCj4gPiA+ID4gUmVwb3J0ZWQtYnk6IGNvdmVyaXR5LWJv
dCA8a2Vlc2Nvb2srY292ZXJpdHktYm90QGNocm9taXVtLm9yZz4NCj4gPiA+ID4gQWRkcmVzc2Vz
LUNvdmVyaXR5LUlEOiAxNTI3MTM5ICgiQ29udHJvbCBmbG93IGlzc3VlcyIpDQo+ID4gPiA+IEZp
eGVzOiA4OWFlZDNjZDVjYjkgKCJtZW1vcnk6IG9tYXAtZ3BtYzogd2FpdCBwaW4gYWRkaXRpb25z
IikNCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciBhdHRlbnRpb24hDQo+ID4gPiA+
IA0KPiA+IA0KPiA+IGNoZWVycywNCj4gPiAtcm9nZXINCj4gY2hlZXJzLA0KPiBiZW5lZGlrdA0K
PiANCg0K
