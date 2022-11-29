Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C450763BE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiK2Kt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiK2KtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:49:14 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82D2B1A0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669718953;
  x=1701254953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kyb0/RhRN0WnWp1LU+68YdZTBMN6viWD06Fr9+ueBNU=;
  b=MbvgSJoQGAuVlduUMxhkjlBglT713WxkJzDz1VproBhyz7piVUNU8Y3P
   qTk12qnAgtrRETZYU/fbP/r1I+CVt8g93sMunr9DuCuSn3f1pQ8yJNOSL
   mQoWbuIu2f/GlaZudHQp8+ju367UCAc1fLp3peA9SCcUgNte5R3+ohF/z
   8ePUJ+kKmzlTMp0XwzE6PWlxdetK5EvUrNeKMTHjm7pTHWlXkOEv2Fs/W
   wJi4j70ML53Iw31YbhOEtHEFz7eVaZDmPLkJjll10Ac9ROLAALKjBMRT8
   lUcHSJmrgniYyxF54E8pKOvFReCPMc7D1wC2tVmsACejONYhwha4IluK8
   Q==;
From:   =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>
To:     =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "etienne.carriere@linaro.org" <etienne.carriere@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Thread-Topic: [PATCH] firmware: arm_scmi: Resolve dependency with TEE
 subsystem
Thread-Index: AQHY9bNyMyeFeP3G1keVYelAsguUwK45ujoAgAQvFACAAEG+AIAAEZoAgAAmcICADNXugIAKiz0A
Date:   Tue, 29 Nov 2022 10:49:10 +0000
Message-ID: <0b24b15bfee6d97d23caf0225d264c14e0ed48f1.camel@axis.com>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
         <20221111143800.k7xje6g23ujefnye@bogus>
         <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
         <20221114102650.qwkaxtnstujaiu6u@bogus>
         <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
         <b0bc03f9f2a5afbe3a77b81648a765348073cc36.camel@axis.com>
         <Y30LXW5Elcur5mlI@e120937-lin>
In-Reply-To: <Y30LXW5Elcur5mlI@e120937-lin>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <406527743B61AD419934F82094CA818B@exhub.se.axis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTIyIGF0IDE3OjQ4ICswMDAwLCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3Rl
Og0KPiBPbiBNb24sIE5vdiAxNCwgMjAyMiBhdCAwMTo0NzoyNVBNICswMDAwLCBMdWR2aWcgUMOk
cnNzb24gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIyLTExLTE0IGF0IDEyOjI5ICswMTAwLCBFdGll
bm5lIENhcnJpZXJlIHdyb3RlOg0KPiA+ID4gSGVsbG8gYWxsLA0KPiA+ID4gDQo+IA0KPiBIaSBM
dWR2aWcsDQo+IA0KPiBmb2xsb3dpbmcgdXAgb24gdGhlIGlzc3VlcyByYWlzZWQgYnkgdGhpcyB0
aHJlYWQgYW5kIGEgZmV3IHByb3Bvc2Fscw0KPiB0aGF0DQo+IHdlcmUgZmx5aW5nIGFyb3VuZCAo
b25saW5lIGFuZCBvZmZsaW5lKSwgaW4gdGhlIHBhc3QgZGF5cyBJIHRvb2sgdGhlDQo+IGNoYW5j
ZQ0KPiB0byBoYXZlIGEgZ28gYXQgYSBzdWJzdGFudGlhbCByZXdvcmsgb2YgdGhlIGluaXQvcHJv
YmUgc2VxdWVuY2VzIGluDQo+IHRoZSBTQ01JDQo+IGNvcmUgdG8gYWRkcmVzcyB0aGUgaXNzdWUg
eW91IGZhY2VkIHdpdGggU0NNSSBURUUgdHJhbnNwb3J0IHdoaWxlDQo+IHRyeWluZyB0bw0KPiB1
bnRhbmdsZSBhIGJpdCB0aGUgU0NNSSBjb3JlIHN0YXJ0dXAgc2VxdWVuY2VzICguLi4gd2hpbGUg
YWxzbw0KPiBwb3NzaWJseSBub3QNCj4gYnJlYWtpbmcgaXQgYWxsIDpQLi4uKQ0KPiANCj4gSW4g
YSBudXRzaGVsbCwgYnVpbGRpbmcgb24gYW4gaWRlYSBmcm9tIGFuIG9mZmxpbmUgY2hhdCB3aXRo
IEV0aWVubmUNCj4gYWQNCj4gU3VkZWVwLCBub3cgdGhlIFNDTUkgYnVzIGluaXRpYWxpemF0aW9u
IGlzIHNwbGl0IG9uIGl0cyBvd24gYW5kDQo+IGluaXRpYWxpemVkIGF0DQo+IHN1YnN5c19pbml0
Y2FsbCBsZXZlbCwgd2hpbGUgdGhlIFNDTUkgY29yZSBzdGFjaywgaW5jbHVkaW5nIHRoZSB0aGUN
Cj4gU0NNSSBURUUNCj4gdHJhbnNwb3J0IGxheWVyLCBpcyBtb3ZlZCBhdCBtb2R1bGVfaW5pdCBs
YXllciB0b2dldGhlciB3aXRoIHRoZSBTQ01JDQo+IGRyaXZlciB1c2Vycy4NCj4gDQo+IFRoaXMg
KnNob3VsZCogdGhlb3JldGljYWxseSBzb2x2ZSB5b3VyIGlzc3VlIC4uLiAoYW5kIGl0IHNlZW1z
IGxpa2UNCj4gYWxsIHRoZQ0KPiByZXN0IGl0J3Mgc3RpbGwgd29ya2luZyA6UCkgLi4uIHNvIEkg
d2FzIHdvbmRlcmluZyBpZiB5b3UgY2FuIGdpdmUgYQ0KPiBnbw0KPiBhdCB0aGUgZm9sbG93aW5n
IHBhY2hzZXQgb24geW91ciBzZXR1cDoNCj4gDQo+IGh0dHBzOi8vZ2l0bGFiLmFybS5jb20vbGlu
dXgtYXJtL2xpbnV4LWNtLy0vY29tbWl0cy9zY21pX3Jld29ya19zdGFja19pbml0X2RyYWZ0Lw0K
PiANCj4gLi4uIG5vdGUgdGhhdCB0aGlzIGlzIGp1c3QgYSBkcmFmdCBhdCB0aGUgbW9tZW50LCB3
aGljaCBoYXMgdW5kZXJnb25lDQo+IGENCj4gcmVhc29uYWJsZSBhbW91bnQgb2YgdGVzdGluZyBv
biBtYWlsYm94L3ZpcnRpbyB0cmFuc3BvcnRzIG9ubHkgaW4NCj4gYm90aCBhDQo+IFNDTUkgYnVp
bHRpbiBhbmQvb3IgbW9kdWxlcyBzY2VuYXJpbywgYnV0IGlzIG5vIHdoZXJlIHJlYWR5IGZvcg0K
PiByZXZpZXcuDQo+IA0KPiBUaGUgdG9wIHRocmVlIHBhdGNoZXMgYXJlIHJlYWxseSB3aGF0IHlv
dSBuZWVkIEJVVCB0aGVzZSBhcmUgcHJvYmFibHkNCj4gdGlnaHRseSBib3VuZCB0byB0aGF0IGJ1
bmNoIG9mIGVhcmx5IGZpeGVzIHlvdSBjYW4gc2VlIGluIHRoZQ0KPiBicmFuY2guLi5zbyBpbiBv
dGhlciB3b3JkcyBiZXR0ZXIgaWYgeW91IHBpY2sgdGhlIHdob2xlIGJyYW5jaCBmb3INCj4gdGVz
dGluZyA6RA0KPiANCj4gT25jZSB5b3UndmUgY29uZmlybWVkIG1lIHRoYXQgdGhpcyBzb2x2ZXMg
eW91ciBpc3N1ZXMgSSdsbCBzdGFydCB0aGUNCj4gZmluYWwgY2xlYW51cCBmb3IgcG9zdGluZyBp
biB0aGUgbmV4dCBjeWNsZS4NCj4gDQo+IFRoYW5rcywNCj4gQ3Jpc3RpYW4NCg0KSGkgQ3Jpc3Rp
YW4sDQoNCkkgdHJpZWQgbXkgYmVzdCB0byBnZXQgdGhlIHBhdGNoc2V0IHRvIHdvcmsgc29tZWhv
dyBvbiBteSB2ZXJzaW9uIG9mDQp0aGUga2VybmVsLCBhbmQgaXQgc2VlbXMgdG8gYmUgd29ya2lu
ZyBncmVhdC4gSSBwbGF5ZWQgYXJvdW5kIHdpdGggc29tZQ0KdGhpbmdzLCBmb3IgZXhhbXBsZSBj
aGFuZ2luZyBvcmRlciBvZiBzb21lIGRyaXZlcnMgdGhhdCB3ZXJlIG9uIHRoZQ0Kc2FtZSBpbml0
IGxldmVscywgYW5kIGl0IHN0aWxsIHdvcmtlZC4gT25seSB0ZXN0ZWQgd2l0aCB2b2x0YWdlIGRv
bWFpbg0KcHJvdG9jb2wgYW5kIG9wdGVlIHRyYW5zcG9ydC4NCg0KVGhhbmtzIGZvciB5b3VyIGdy
ZWF0IHdvcmshDQoNCkJSLA0KTHVkdmlnDQo=
