Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6F6876F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjBBIFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:05:29 -0500
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF43CA35
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:05:27 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id D1D26104943A;
        Thu,  2 Feb 2023 11:05:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru D1D26104943A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1675325123; bh=9Oqp75BixNkux9SygXqMuKmFPr/E9t9JHbS1PuBL4dE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fpuHBxITVC5M8u0gXZoDpplTHD3R5r325hGiLRI19fY81CGOdDC8imIWGeRPWtPfC
         lhfviGJuC6AlNy0gIWkMZXa8ZkaoUZgAQo8SP6T0FNoglNH3XLjhL/DJFr/C0xB7TI
         NJitehrYTk8tloMnbSOSQrGyopKtaYlmv/i7re1g=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
        by mx0.infotecs-nt (Postfix) with ESMTP id CD90B30A8127;
        Thu,  2 Feb 2023 11:05:22 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <joro@8bytes.org>
CC:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Wan Zongshun <Vincent.Wan@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] iommu/amd: @Add a length limitation for the ivrs_acpihid
 command-line parameter
Thread-Topic: [PATCH] iommu/amd: @Add a length limitation for the ivrs_acpihid
 command-line parameter
Thread-Index: AQHZNt0ZVMqor8E7oU2uXGP1Yfs9UA==
Date:   Thu, 2 Feb 2023 08:05:22 +0000
Message-ID: <54fe84de-5144-3ec0-1329-2e9dca41ab17@infotecs.ru>
References: <20230130083843.802106-1-Ilia.Gavrilov@infotecs.ru>
 <39506e9f-9bbb-fcf6-b488-542fd3657eae@amd.com>
In-Reply-To: <39506e9f-9bbb-fcf6-b488-542fd3657eae@amd.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B0D37E79BA76A458153168438879B6D@infotecs.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 175194 [Feb 02 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6, {Tracking_msgid_8}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;infotecs.ru:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/02/02 07:35:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/02/02 02:42:00 #20830374
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yLzIzIDAzOjQ0LCBLaW0gUGhpbGxpcHMgd3JvdGU6DQo+IE5vdCBzdXJlIHdoYXQgdGhh
dCAnQCcgaXMgZG9pbmcgaW4gdGhlIHN1YmplY3QgbGluZS4uLg0KPiANCg0KU29ycnksIHRoaXMg
aXMgbXkgdHlwby4NCkknbGwgZml4IGl0IGluIFYyLg0KDQo+IE9uIDEvMzAvMjMgMjozOCBBTSwg
R2F2cmlsb3YgSWxpYSB3cm90ZToNCj4+IFRoZSAnYWNwaWlkJyBidWZmZXIgaW4gdGhlIHBhcnNl
X2l2cnNfYWNwaWhpZCBmdW5jdGlvbiBtYXkgb3ZlcmZsb3csDQo+PiBiZWNhdXNlIHRoZSBzdHJp
bmcgc3BlY2lmaWVyIGluIHRoZSBmb3JtYXQgc3RyaW5nIHNzY2FuZigpDQo+PiBoYXMgbm8gd2lk
dGggbGltaXRhdGlvbi4NCj4+DQo+PiBGb3VuZCBieSBJbmZvVGVDUyBvbiBiZWhhbGYgb2YgTGlu
dXggVmVyaWZpY2F0aW9uIENlbnRlcg0KPj4gKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0Uu
DQo+Pg0KPj4gRml4ZXM6IGNhM2JmNWQ0N2NlYyAoImlvbW11L2FtZDogSW50cm9kdWNlcyBpdnJz
X2FjcGloaWQga2VybmVsIA0KPj4gcGFyYW1ldGVyIikNCj4+IFNpZ25lZC1vZmYtYnk6IElsaWEu
R2F2cmlsb3YgPElsaWEuR2F2cmlsb3ZAaW5mb3RlY3MucnU+DQo+IA0KPiBjYzogc3RhYmxlPw0K
PiANCg0KSSdsbCBhZGQgaXQgdG8gVjIuDQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvaW9tbXUvYW1k
L2luaXQuYyB8IDE2ICsrKysrKysrKysrKysrKy0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYW1kL2luaXQuYyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYw0KPj4gaW5kZXggNDY3
YjE5NDk3NWIzLi4xOWE0NmI5ZjczNTcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2Ft
ZC9pbml0LmMNCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kL2luaXQuYw0KPj4gQEAgLTM0NzUs
MTUgKzM0NzUsMjYgQEAgc3RhdGljIGludCBfX2luaXQgcGFyc2VfaXZyc19ocGV0KGNoYXIgKnN0
cikNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIDE7DQo+PiDCoCB9DQo+PiArI2RlZmluZSBBQ1BJSURf
TEVOIChBQ1BJSElEX1VJRF9MRU4gKyBBQ1BJSElEX0hJRF9MRU4pDQo+PiArDQo+PiDCoCBzdGF0
aWMgaW50IF9faW5pdCBwYXJzZV9pdnJzX2FjcGloaWQoY2hhciAqc3RyKQ0KPj4gwqAgew0KPj4g
wqDCoMKgwqDCoCB1MzIgc2VnID0gMCwgYnVzLCBkZXYsIGZuOw0KPj4gwqDCoMKgwqDCoCBjaGFy
ICpoaWQsICp1aWQsICpwLCAqYWRkcjsNCj4+IC3CoMKgwqAgY2hhciBhY3BpaWRbQUNQSUhJRF9V
SURfTEVOICsgQUNQSUhJRF9ISURfTEVOXSA9IHswfTsNCj4+ICvCoMKgwqAgY2hhciBhY3BpaWRb
QUNQSUlEX0xFTl0gPSB7MH07DQo+PiDCoMKgwqDCoMKgIGludCBpOw0KPj4gwqDCoMKgwqDCoCBh
ZGRyID0gc3RyY2hyKHN0ciwgJ0AnKTsNCj4+IMKgwqDCoMKgwqAgaWYgKCFhZGRyKSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgYWRkciA9IHN0cmNocihzdHIsICc9Jyk7DQo+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCFhZGRyKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBub3RfZm91bmQ7
DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgKythZGRyOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChzdHJsZW4oYWRkcikgPiBBQ1BJSURfTEVOKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBub3RfZm91bmQ7DQo+PiArDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNz
Y2FuZihzdHIsICJbJXg6JXguJXhdPSVzIiwgJmJ1cywgJmRldiwgJmZuLCBhY3BpaWQpID09IA0K
Pj4gNCB8fA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3NjYW5mKHN0ciwgIlsleDol
eDoleC4leF09JXMiLCAmc2VnLCAmYnVzLCAmZGV2LCAmZm4sIA0KPj4gYWNwaWlkKSA9PSA1KSB7
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJpdnJzX2FjcGloaWQlcyBv
cHRpb24gZm9ybWF0IGRlcHJlY2F0ZWQ7IHVzZSANCj4+IGl2cnNfYWNwaWhpZD0lc0AlMDR4OiUw
Mng6JTAyeC4lZCBpbnN0ZWFkXG4iLA0KPj4gQEAgLTM0OTYsNiArMzUwNyw5IEBAIHN0YXRpYyBp
bnQgX19pbml0IHBhcnNlX2l2cnNfYWNwaWhpZChjaGFyICpzdHIpDQo+PiDCoMKgwqDCoMKgIC8q
IFdlIGhhdmUgdGhlICdAJywgbWFrZSBpdCB0aGUgdGVybWluYXRvciB0byBnZXQganVzdCB0aGUg
DQo+PiBhY3BpaWQgKi8NCj4+IMKgwqDCoMKgwqAgKmFkZHIrKyA9IDA7DQo+PiArwqDCoMKgIGlm
IChzdHJsZW4oc3RyKSA+IEFDUElJRF9MRU4gKyAxKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8g
bm90X2ZvdW5kOw0KPj4gKw0KPj4gwqDCoMKgwqDCoCBpZiAoc3NjYW5mKHN0ciwgIj0lcyIsIGFj
cGlpZCkgIT0gMSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG5vdF9mb3VuZDsNCj4gDQo+
IFRoYXQgd29ya3MsIG9yLCB0aGlzIGZpeCBtaWdodCBiZSBhYmxlIHRvIGJlIG1hZGUgbW9yZSBi
cmllZiBpZg0KPiB3ZSBjb3VsZCB0cmFuc2Zvcm0gYWxsIHRoZSBzc2NhbmYncyAnJXMncyB0bzoN
Cj4gDQo+ICIlIiBfX3N0cmluZ2lmeShBQ1BJSURfTEVOKSAicyINCj4gDQoNCkkgdHJpZWQgdG8g
dXNlIF9fc3RyaW5naWZ5LCBidXQgSSBkaWRuJ3QgZmluZCBhIGJyaWVmIHdheSB0byBkbyBpdCAN
CmNvcnJlY3RseSBmb3IgdGhlIGV4cHJlc3Npb24gKEFDUElISURfVUlEX0xBTiArIEFDUElISURf
SElEX0xBTikuIFRoZSANCnByZXByb2Nlc3NvciBkb2VzIG5vdCBldmFsdWF0ZXMgYSBjb25zdGFu
dCwgYnV0IHNpbXBseSBzdWJzdGl0dXRlcyAoMjU2KzkpLg0KDQo+IGJ1dCB0aGUgbGF0dGVyIG1p
Z2h0IG1ha2UgdGhlIGFscmVhZHkgbG9uZyBzc2NhbmYgbGluZSBsZW5ndGhzIGxvbmdlci4uLg0K
PiAgPiBFaXRoZXIgd2F5Og0KPiANCj4gUmV2aWV3ZWQtYnk6IEtpbSBQaGlsbGlwcyA8a2ltLnBo
aWxsaXBzQGFtZC5jb20+DQo+IA0KPiBLaW0NCg0KVGhhbmsgeW91IGZvciByZXZpZXcuDQoNCg==
