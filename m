Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40366D846
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjAQIeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbjAQIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:34:01 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 621AE14E94
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:34:00 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.11])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 58CF0110028E41;
        Tue, 17 Jan 2023 16:33:57 +0800 (CST)
Received: from ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) by
 ZJY02-ACTMBX-01.didichuxing.com (10.79.65.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Jan 2023 16:33:57 +0800
Received: from ZJY02-ACTMBX-02.didichuxing.com ([fe80::9d2c:14fe:d2f1:2a37])
 by ZJY02-ACTMBX-02.didichuxing.com ([fe80::9d2c:14fe:d2f1:2a37%4]) with mapi
 id 15.01.2375.034; Tue, 17 Jan 2023 16:33:57 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.11
From:   =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yuanhan Zhang <zyhtheonly@gmail.com>,
        "zwp10758@gmail.com" <zwp10758@gmail.com>,
        "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Thread-Topic: [PATCH] sched: print parent comm in sched_show_task()
Thread-Index: AQHZJz1mO9FzOB49PE+qeMvW7VhPHK6gRIOAgAIJ4gA=
Date:   Tue, 17 Jan 2023 08:33:56 +0000
Message-ID: <37FFCAF0-B0BA-48BD-B688-B1C5E7A10A1A@didiglobal.com>
In-Reply-To: <Y8UYKzBJeejHCpgO@chenyu5-mobl1>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.64.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F52D9D83634F7547902C8564E89B93D3@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlbiwNClRoYW5rcyBmb3IgeW91ciByZXBseSEgSSBpbXBsZW1lbnQgdGhpcyBhY2NvcmRp
bmcgdG8gUGV0cidzIHN1Z2dlc3Rpb24gaGVyZToNCg0KPiBBIHNvbHV0aW9uIHdvdWxkIGJlIHRv
IG1vdmUgdGhlIHBhcmVudCB2YWx1ZSB0byBhbm90aGVyIGxpbmUuDQo+IEl0IHdvdWxkIGV2ZW4g
YmV0dGVyIHNvbHZlIHRoZSBzaXR1YXRpb24gd2hlbiB0aGUgdGFzaw0KPiBpcyBub3QgYWxpdmUg
YW5kIHdlIGNvdWxkIG5vdCBnZXQgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHBhcmVudDoNCj4NCj4g
ICAgICAgIGlmIChwaWRfYWxpdmUocCkpIHsNCj4gICAgICAgICAgICAgICAgc3RydWN0IHBhcmVu
dCA9IHJjdV9kZXJlZmVyZW5jZShwLT5yZWFsX3BhcmVudCk7DQo+DQo+ICAgICAgICAgICAgICAg
IHByX2luZm8oInBhcmVudDolLTE1LjE1cyBwcGlkOiUtNmRcbiIsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgcGFyZW50LT5jb21tLCB0YXNrX3BpZF9ucihwYXJlbnQpKTsNCj4gICAgICAgIH0N
Cg0KSXQgc2VlbXMgZG8gYnJlYWsgdGhlIG9yaWdpbmFsIGZvcm1hdCwgYnV0IEkgZ3Vlc3MgcHJp
bnRpbmcgMCBhcyBwcGlkIHdoZW4gdGhlIHRhc2sgaXMgbm90IGFsaXZlDQp3b3VsZCBhbHNvIGNv
bmZ1c2UgcGVvcGxlIHNvbWV0aW1lcy4NCg0KRm9yIGV4YW1wbGUsIHdoZW4gcGVvcGxlIChhbmQg
YWxzbyBtb3N0IHN5c3RlbSBtb25pdG9yIHNvZnR3YXJlKSBzZWUgcHBpZCwgdGhleSByZWFkIHRo
ZSB2YWx1ZSBpbiAvcHJvYy9QSUQvc3RhdHVzLiBBY2NvcmRpbmcgdG8gdGFza190Z2lkX25yX25z
KCksIHdoZW4gdGhlIHRhc2sgaXMgaW4gYSBjb250YWluZXIgd2l0aCBpdHMgcGFyZW50IG91dHNp
ZGUgdGhlDQpuYW1lc3BhY2UsIHdlIHdpbGwgYWxzbyBzZWUgdGhhdCBwcGlkIGlzIDAgaW5zaWRl
IHRoZSBjb250YWluZXIuIEFuZCBpbiBvdXIgc2NoZWRfc2hvd190YXNrKCkgaGVyZSwgd2UgYXJl
IGNhbGxpbmcgdGFza19waWRfbnIoKSwgc28gdGhlIGluY29uc2lzdGVuY3kgbWF5YmUgd291bGQg
Y29uZnVzZSBwZW9wbGUgdW5kZXIgdGhpcyBzY2VuYXJpby4NCg0KU28gbWF5YmUgdGhpcyBuZXcg
bGluZSBzdHlsZSB3b3VsZCBiZSBhIGJldHRlciBjaG9pY2U/IE9yIHdlIGp1c3Qga2VlcCB0aGUg
b3JpZ2luYWwgZm9ybWF0IGFuZA0KbW92ZSB0aGUgcGFyZW50J3MgaW5mbyAoYW5kIHNob3VsZCB3
ZSBwcmludCB0aGUgcGFyZW50J3MgcGlkIGFnYWluIGhlcmUpIHRvIGEgbmV3IGxpbmUuwqAgIA0K
DQpUaGFua3MsDQpUaW8NCg0K77u/5ZyoIDIwMjMvMS8xNiDkuIvljYg1OjI277yM4oCcQ2hlbiBZ
deKAnTx5dS5jLmNoZW5AaW50ZWwuY29tIDxtYWlsdG86eXUuYy5jaGVuQGludGVsLmNvbT4+IOWG
meWFpToNCg0KDQpIaSBUaW8sDQpPbiAyMDIzLTAxLTEzIGF0IDE4OjU0OjEzICswODAwLCBUaW8g
Wmhhbmcgd3JvdGU6DQo+IEtub3dpbmcgd2hvIHRoZSBwYXJlbnQgaXMgbWlnaHQgYmUgdXNlZnVs
IGZvciBkZWJ1Z2dpbmcuDQo+IEZvciBleGFtcGxlLCB3ZSBjYW4gc29tZXRpbWVzIHJlc29sdmUg
a2VybmVsIGh1bmcgdGFza3MgYnkgc3RvcHBpbmcNCj4gdGhlIHBlcnNvbiB3aG8gYmVnaW5zIHRo
b3NlIGh1bmcgdGFza3MuDQo+IFdpdGggdGhlIHBhcmVudCdzIG5hbWUgcHJpbnRlZCBpbiBzY2hl
ZF9zaG93X3Rhc2soKSwNCj4gaXQgbWlnaHQgYmUgaGVscGZ1bCB0byBsZXQgcGVvcGxlIGtub3cg
d2hpY2ggInNlcnZpY2UiIHNob3VsZCBiZSBvcGVyYXRlZC4NCj4gQWxzbywgd2UgbW92ZSB0aGUg
cGFyZW50IGluZm8gdG8gYSBmb2xsb3dpbmcgbmV3IGxpbmUuDQo+IEl0IHdvdWxkIGJldHRlciBz
b2x2ZSB0aGUgc2l0dWF0aW9uIHdoZW4gdGhlIHRhc2sNCj4gaXMgbm90IGFsaXZlIGFuZCB3ZSBj
b3VsZCBub3QgZ2V0IGluZm9ybWF0aW9uIGFib3V0IHRoZSBwYXJlbnQuDQo+DQpNYXliZSBnZW5l
cmF0ZSB0aGUgcGF0Y2ggdmlhIGdpdCBmb3JtYXQtcGF0Y2ggLXYyIGJlY2F1c2UgaXQgaXMgYSBz
ZWNvbmQNCm9uZS4gQWxzbyBDY2VkIGNvcnJlc3BvbmRpbmcgc2NoZWQgbWFpbnRhaW5lcnMgYXMg
dGhleSB3aWxsIG1ha2UgdGhlIGRlY2lzaW9uLg0KPiBTaWduZWQtb2ZmLWJ5OiBUaW8gWmhhbmcg
PHRpb3poYW5nQGRpZGlnbG9iYWwuY29tIDxtYWlsdG86dGlvemhhbmdAZGlkaWdsb2JhbC5jb20+
Pg0KPiAtLS0NCj4ga2VybmVsL3NjaGVkL2NvcmUuYyB8IDE1ICsrKysrKysrLS0tLS0tLQ0KPiAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+IGlu
ZGV4IGNiMmFhMmI1NGM3YS4uNWJlM2Y0NzZlZTViIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvc2No
ZWQvY29yZS5jDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4gQEAgLTg4NTMsNyArODg1
Myw2IEBAIFNZU0NBTExfREVGSU5FMihzY2hlZF9ycl9nZXRfaW50ZXJ2YWxfdGltZTMyLCBwaWRf
dCwgcGlkLA0KPiB2b2lkIHNjaGVkX3Nob3dfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApDQo+
IHsNCj4gdW5zaWduZWQgbG9uZyBmcmVlID0gMDsNCj4gLSBpbnQgcHBpZDsNCj4gDQo+IGlmICgh
dHJ5X2dldF90YXNrX3N0YWNrKHApKQ0KPiByZXR1cm47DQo+IEBAIC04ODY1LDE0ICs4ODY0LDE2
IEBAIHZvaWQgc2NoZWRfc2hvd190YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkNCj4gI2lmZGVm
IENPTkZJR19ERUJVR19TVEFDS19VU0FHRQ0KPiBmcmVlID0gc3RhY2tfbm90X3VzZWQocCk7DQo+
ICNlbmRpZg0KPiAtIHBwaWQgPSAwOw0KPiArIHByX2NvbnQoIiBzdGFjazolLTVsdSBwaWQ6JS01
ZCBmbGFnczoweCUwOGx4XG4iLA0KPiArIGZyZWUsIHRhc2tfcGlkX25yKHApLCByZWFkX3Rhc2tf
dGhyZWFkX2ZsYWdzKHApKTsNCj4gKw0KPiByY3VfcmVhZF9sb2NrKCk7DQo+IC0gaWYgKHBpZF9h
bGl2ZShwKSkNCj4gLSBwcGlkID0gdGFza19waWRfbnIocmN1X2RlcmVmZXJlbmNlKHAtPnJlYWxf
cGFyZW50KSk7DQo+ICsgaWYgKHBpZF9hbGl2ZShwKSkgew0KPiArIHN0cnVjdCB0YXNrX3N0cnVj
dCAqcGFyZW50ID0gcmN1X2RlcmVmZXJlbmNlKHAtPnJlYWxfcGFyZW50KTsNCj4gKw0KPiArIHBy
X2luZm8oInBhcmVudDolLTE1LjE1cyBwcGlkOiUtNmQiLCBwYXJlbnQtPmNvbW0sIHRhc2tfcGlk
X25yKHBhcmVudCkpOw0KVGhpcyBtaWdodCBjaGFuZ2UgdGhlIG9yaWdpbmFsIHNjZW5hcmlvOiBp
ZiAhcGlkX2FsaXZlKHApLCB0aGUgc2NoZWRfc2hvd190YXNrKCkNCndpbGwgcHJpbnQgcHBpZCA9
IDAoaW5pdCB0YXNrPykuDQoNCg0KdGhhbmtzLA0KQ2hlbnl1DQoNCg0KDQo=
