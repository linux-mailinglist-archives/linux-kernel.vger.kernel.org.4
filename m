Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918425EC35B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiI0MzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiI0MzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:55:19 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A11684DE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664283309;
        bh=42xfWSmhmYjq+twL20Yxs1MCHTnMRhNYnQ9ldZwy/Rs=;
        h=From:To:Cc:Subject:Date;
        b=xMO2xKkAHQKFEvZzbi+vWLWtiDB7TcPE4jc9eWNLetHKk5mBMnFh8sqxm6MorknHt
         v2cl65Bfrk920xLR1lBxEM4nonhx48r16kzvFtVaK2ZI8IFIuGbX1ymDJq58T7nXae
         k+L1JQPy2aRCYUdH0x9t1bCFQiCT4bwodJwut3kg=
X-QQ-FEAT: oHWrrGTW1dDJ34LybywUcSCPpAkOV9c4
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMAILINFO: OZiGlmjmGvyhz+Fl1v8DirpiVJ32lMdcI4u69eni3+5I4OSUoCGndESeQL4cH9
         xcB47NT2lW6qO8+x/ooIhmqFNE2WDENG9Jdg/kqJ6DWe01nKutKgw25lqQvxFqG7sjxQTZMUoG3KT
         oj9q3YmbX2i5/8dItlAcKgWteQZTPFbUNQ49YavH1OAMIHGT74x4NsmkEyP5sgjROU4VXUx1CsnWQ
         FypB4bAVRtEY5kP6LMcwp31z82tawu309+UvmmpSw4tpINSVbOla2n1dCVeG8Ra8ccz82EDTvm10g
         AaXRqAZF6WqVX+PRTHzC7QVN85FWrIN8gU4VWoqYKG9krSsMMzenyt15q4zTjqwKmQLmWwvTbKkCl
         g00rVAL3ZZlzzArC/kPHhyCCY8lscAsilzb6vUkWcQA3aQ6FbkrsDtfRFVVF5CTvnPMFKDNe6wtxd
         JNXj1LZ7hckvB/kK+09I7eudYQBNrPJuQOt7arKKzniYWRP8KOhTMN/2OYjc71TWQyYEWwFuVHEj3
         rBbh7Yrp6GCsgAnS/M9IqgbxgrOt83XoJj/kGGKF9j8VGeML4tp448/NqP9cRc88rhbZfDcUljcCv
         8KgiDvH9FARtPZxWEC7jo78QxjjH9t6MQeOJ8k0AMy54I143rQsVVyKKG0td3bquGJBPJW10AT06i
         TGcDQ56zvdiQ2wOp0TyiUimanrNOKrcnBgrYeXhtEidaKR2pSWz9OkYQM9Xr75gUjp/7KBKdQlsY1
         SQhi3aPmJa3I0MujBjNI0MQUkyXevvH+uknqvq56e3HHtyQBLXbuMcfc1gV0vfJ54Evfr1RnMDmpf
         YS0BOVaoUtBQfEWAXxn/bt7BeNcklG+7hsbC92U8+hZqgfnxKXTf9sWoybUp/AZQZ8sIHBBbxWVu8
         uqzRA/WPiOBCq7HhqzqdPk0T4TjHwg0jQynq1KSR12qA908dM/obgydk2ESkjgAumKXMK0Be+1EqF
         4hndg/xGI44w3/4MMt
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
X-QQ-STYLE: 
X-QQ-mid: webmail740t1664283308t8147702
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?RGFuIENhcnBlbnRlcg==?=" <dan.carpenter@oracle.com>
Cc:     "=?ISO-8859-1?B?TGFycnkuRmluZ2Vy?=" <Larry.Finger@lwfinger.net>,
        "=?ISO-8859-1?B?Zmxvcmlhbi5jLnNjaGlsaGFiZWw=?=" 
        <florian.c.schilhabel@googlemail.com>,
        "=?ISO-8859-1?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>,
        "=?ISO-8859-1?B?bGludXgtc3RhZ2luZw==?=" 
        <linux-staging@lists.linux.dev>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] staging: rtl8712: fix potential memory leak in _r8712_init_xmit_priv()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Tue, 27 Sep 2022 20:55:08 +0800
X-Priority: 3
Message-ID: <tencent_FACCCAB91E1C6F141FE1CA4AC1FF2420DA08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMjcsIDIwMjIgMDM6NTcgUE0sIGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNv
bSB3cm90ZToKJmd0OyBPbiBNb24sIFNlcCAyNiwgMjAyMiBhdCAwMzowNjowNVBNICswODAw
LCB4a2VybmVsLndhbmdAZm94bWFpbC5jb20gd3JvdGU6CiZndDsmZ3Q7IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3N0YWdpbmcvcnRsODcxMi9ydGw4NzF4X3htaXQuYyBiL2RyaXZlcnMvc3Rh
Z2luZy9ydGw4NzEyL3J0bDg3MXhfeG1pdC5jCiZndDsmZ3Q7IGluZGV4IDA5MDM0NWIuLmRj
ZjNmNzYgMTAwNjQ0CiZndDsmZ3Q7IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3J0
bDg3MXhfeG1pdC5jCiZndDsmZ3Q7ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3J0
bDg3MXhfeG1pdC5jCiZndDsmZ3Q7IEBAIC0xMTcsMTEgKzExNyw4IEBAIGludCBfcjg3MTJf
aW5pdF94bWl0X3ByaXYoc3RydWN0IHhtaXRfcHJpdiAqcHhtaXRwcml2LAomZ3Q7Jmd0OyBf
aW5pdF9xdWV1ZSgmYW1wO3B4bWl0cHJpdi0mZ3Q7cGVuZGluZ194bWl0YnVmX3F1ZXVlKTsK
Jmd0OyZndDsgcHhtaXRwcml2LSZndDtwYWxsb2NhdGVkX3htaXRidWYgPQomZ3Q7Jmd0OyAg
a21hbGxvYyhOUl9YTUlUQlVGRiAqIHNpemVvZihzdHJ1Y3QgeG1pdF9idWYpICsgNCwgR0ZQ
X0FUT01JQyk7CiZndDsmZ3Q7IC0gaWYgKCFweG1pdHByaXYtJmd0O3BhbGxvY2F0ZWRfeG1p
dGJ1ZikgewomZ3Q7Jmd0OyAta2ZyZWUocHhtaXRwcml2LSZndDtwYWxsb2NhdGVkX2ZyYW1l
X2J1Zik7CiZndDsmZ3Q7IC1weG1pdHByaXYtJmd0O3BhbGxvY2F0ZWRfZnJhbWVfYnVmID0g
TlVMTDsKJmd0OyZndDsgLXJldHVybiAtRU5PTUVNOwomZ3Q7Jmd0OyAtIH0KJmd0OyZndDsg
KyBpZiAoIXB4bWl0cHJpdi0mZ3Q7cGFsbG9jYXRlZF94bWl0YnVmKQomZ3Q7Jmd0OyArZ290
byBmcmVlX2ZyYW1lX2J1ZjsKCk5vdGUgaGVyZTogbWF5IGhhdmUgdGhlIHNhbWUgY29uY2Vy
bi4KCiZndDsmZ3Q7IHB4bWl0cHJpdi0mZ3Q7cHhtaXRidWYgPSBweG1pdHByaXYtJmd0O3Bh
bGxvY2F0ZWRfeG1pdGJ1ZiArIDQgLQomZ3Q7Jmd0OyAgICAgICAoKGFkZHJfdCkocHhtaXRw
cml2LSZndDtwYWxsb2NhdGVkX3htaXRidWYpICZhbXA7IDMpOwomZ3Q7Jmd0OyBweG1pdGJ1
ZiA9IChzdHJ1Y3QgeG1pdF9idWYgKilweG1pdHByaXYtJmd0O3B4bWl0YnVmOwomZ3Q7Jmd0
OyBAQCAtMTMwLDEyICsxMjcsMTQgQEAgaW50IF9yODcxMl9pbml0X3htaXRfcHJpdihzdHJ1
Y3QgeG1pdF9wcml2ICpweG1pdHByaXYsCiZndDsmZ3Q7ICBweG1pdGJ1Zi0mZ3Q7cGFsbG9j
YXRlZF9idWYgPQomZ3Q7Jmd0OyBrbWFsbG9jKE1BWF9YTUlUQlVGX1NaICsgWE1JVEJVRl9B
TElHTl9TWiwgR0ZQX0FUT01JQyk7CiZndDsmZ3Q7ICBpZiAoIXB4bWl0YnVmLSZndDtwYWxs
b2NhdGVkX2J1ZikKJmd0OyZndDsgLSByZXR1cm4gLUVOT01FTTsKJmd0OyZndDsgKyBnb3Rv
IGZyZWVfeG1pdGJ1ZjsKJmd0OyZndDsgIHB4bWl0YnVmLSZndDtwYnVmID0gcHhtaXRidWYt
Jmd0O3BhbGxvY2F0ZWRfYnVmICsgWE1JVEJVRl9BTElHTl9TWiAtCiZndDsmZ3Q7ICgoYWRk
cl90KSAocHhtaXRidWYtJmd0O3BhbGxvY2F0ZWRfYnVmKSAmYW1wOwomZ3Q7Jmd0OyAoWE1J
VEJVRl9BTElHTl9TWiAtIDEpKTsKJmd0OyZndDsgLWlmIChyODcxMl94bWl0X3Jlc291cmNl
X2FsbG9jKHBhZGFwdGVyLCBweG1pdGJ1ZikpCiZndDsmZ3Q7IC0gcmV0dXJuIC1FTk9NRU07
CiZndDsmZ3Q7ICtpZiAocjg3MTJfeG1pdF9yZXNvdXJjZV9hbGxvYyhwYWRhcHRlciwgcHht
aXRidWYpKSB7CiZndDsmZ3Q7ICsga2ZyZWUocHhtaXRidWYtJmd0O3BhbGxvY2F0ZWRfYnVm
KTsKJmd0OyZndDsgKyBnb3RvIGZyZWVfeG1pdGJ1ZjsKJmd0OyZndDsgK30KJmd0OyZndDsg
IGxpc3RfYWRkX3RhaWwoJmFtcDtweG1pdGJ1Zi0mZ3Q7bGlzdCwKJmd0OyZndDsgJmFtcDso
cHhtaXRwcml2LSZndDtmcmVlX3htaXRidWZfcXVldWUucXVldWUpKTsKJmd0OwomZ3Q7CiZn
dDsgcHhtaXRidWYgcG9pbnRzIHRvIHNvbWV3aGVyZSBpbiB0aGUgbWlkZGxlIG9mIHB4bWl0
cHJpdi0mZ3Q7cGFsbG9jYXRlZF94bWl0YnVmLgomZ3Q7IFdlIGFkZCBpdCB0byB0aGUgbGlz
dCBoZXJlLgomZ3Q7CiZndDsmZ3Q7ICBweG1pdGJ1ZisrOwomZ3Q7Jmd0OyBAQCAtMTQ2LDYg
KzE0NSwxOCBAQCBpbnQgX3I4NzEyX2luaXRfeG1pdF9wcml2KHN0cnVjdCB4bWl0X3ByaXYg
KnB4bWl0cHJpdiwKJmd0OyZndDsgaW5pdF9od3htaXRzKHB4bWl0cHJpdi0mZ3Q7aHd4bWl0
cywgcHhtaXRwcml2LSZndDtod3htaXRfZW50cnkpOwomZ3Q7Jmd0OyB0YXNrbGV0X3NldHVw
KCZhbXA7cHhtaXRwcml2LSZndDt4bWl0X3Rhc2tsZXQsIHI4NzEyX3htaXRfYmgpOwomZ3Q7
Jmd0OyByZXR1cm4gMDsKJmd0OyZndDsgKwomZ3Q7Jmd0OyArZnJlZV94bWl0YnVmOgomZ3Q7
Jmd0OyArIHB4bWl0YnVmID0gKHN0cnVjdCB4bWl0X2J1ZiAqKXB4bWl0cHJpdi0mZ3Q7cHht
aXRidWY7CiZndDsmZ3Q7ICsgd2hpbGUgKGktLSkgewomZ3Q7Jmd0OyArcjg3MTJfeG1pdF9y
ZXNvdXJjZV9mcmVlKHBhZGFwdGVyLCBweG1pdGJ1Zik7CiZndDsmZ3Q7ICtrZnJlZShweG1p
dGJ1Zi0mZ3Q7cGFsbG9jYXRlZF9idWYpOwomZ3Q7Jmd0OyArcHhtaXRidWYrKzsKJmd0OyZn
dDsgKyB9CiZndDsmZ3Q7ICsga2ZyZWUocHhtaXRwcml2LSZndDtwYWxsb2NhdGVkX3htaXRi
dWYpOwomZ3Q7CiZndDsgQnV0IHRoZW4gd2UgZnJlZSBweG1pdHByaXYtJmd0O3BhbGxvY2F0
ZWRfeG1pdGJ1ZiBoZXJlIGJ1dCBpdCB0aGUgbWVtb3J5CiZndDsgaXMgc3RpbGwgb24gdGhl
IGxpc3QuICBTbyB0aGF0IG1lYW5zIHRoZXJlIHdpbGwgYmUgYSB1c2UgYWZ0ZXIgZnJlZQom
Z3Q7IGV2ZW50dWFsbHkuCgpZZXMsIHRoZSBtZW1vcnkgYWRkcmVzcyBpcyBzdGlsbCBvbiB0
aGUgbGlzdCwgYW5kIGF0IHRoZSBhYm92ZSBwb3NpdGlvbiBvZgpgTm90ZWAsIHRoZSBhZGRy
ZXNzIG9mIGBweG1pdHByaXYtJmd0O3BhbGxvY2F0ZWRfZnJhbWVfYnVmYCBpcyBhbHNvIGxl
ZnQgb24gYQpsaXN0IG5hbWVkIGBweG1pdHByaXYtJmd0O2ZyZWVfeG1pdF9xdWV1ZWAuCkhv
d2V2ZXIsIHRoZXNlIGxpc3RzIGFyZSBpbiBgcHhtaXRwcml2YCBhbmQgdGhpcyBmdW5jdGlv
biBpcyBmb3IKaW5pdGlhbGl6aW5nIGBweG1pdHByaXZgLiBXaGVuIHRoaXMgZnVuY3Rpb24g
ZmFpbHMsIHRoZSBwcm9iZSBmdW5jdGlvbiBvZgp0aGlzIGRyaXZlciB3aWxsIGZpbmFsbHkg
ZmFpbC4gU28gSSBndWVzcyB0aGUgbGlzdCBpbiBgcHhtaXRwcml2YCB3aWxsIG5vdApiZSBh
Y2Nlc3NlZC4KClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgaG9sZCBzdWNoIGNv
bmNlcm5zLCBJIGFtIGdsYWQgdG8gZmluZCBhCnRpbWUgKGluIDIgd2Vla3MgSSBndWVzcykg
dG8gYWRkIGBsaXN0X2RlbF9pbml0KClgIG9uIHRoZSBlcnJvciBwYXRocwp0byBjbGVhciBh
bGwgdGhlIGltcHJvcGVyIHBvaW50aW5nIHJlY29yZHMuCgpSZWdhcmRzLApYaWFva2UgV2Fu
Zw==
ÿÿÿÿI
