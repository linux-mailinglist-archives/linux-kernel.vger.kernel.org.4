Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B5B5EC869
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiI0PrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiI0Pqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:46:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE848D10D;
        Tue, 27 Sep 2022 08:44:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x92so601189ede.9;
        Tue, 27 Sep 2022 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=vMFv38ffgkFZd7IweF4yDPKh4UDW5jDFg9IxdHT8RJI=;
        b=qDeqUbfl9ibJ2llUrPzcD6/p7XV+JD2CPbn3wiR/+VtdgmECrsE+sYPTEL/ojFmNLr
         MUwFlwOao8qC9r6Gxb+12CXWMEACZ5QvuLEF90jXQD51FGHpM9n+1+N7RElbCdAvTMxf
         s4aiB5fI8/GyNwRAehnesOYMVh+J8Racp9OXcs09nn8k1YhUH22eM0v8LrwsiammHj4r
         qb1RJaPAaauMENeag9Ad496Xp3eNcQflpMFRABcca23VFV0HccSIFuFdNUsK/XzVzFhP
         AOAKxg1VNjrT1dCTqgoASAScLuSaW4weuq4wkWA+5urnWIbSBSHcmMLqJuOBBsr34Jc5
         9KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=vMFv38ffgkFZd7IweF4yDPKh4UDW5jDFg9IxdHT8RJI=;
        b=WJ/0xSgUW6jBpqkQ9xO2nbSChG1BSPR4ws6/mesFstOAhrF8SQAjtSz/UfFwLHYRL2
         LuYWBQMwmMzWIADN4JP7Jt4vXLS+SeY2oiPk1k1Hf6yKRgAKxjxHywNJzuN3bhTwGM31
         5yiupx9NwNgyx9NARIvIfdusd965YSb9RwNTXxDd7Ru4j5QRJ4su+rvA2DHZ6UjSsSz+
         pp4uG27w9j0SKQTDlr01jEeE9O6LhYBvYxmk5uZ7/+Y7FnaTJgVhtPbnDTCpkxw5aBAd
         GVkIMSTtsRo+CfK+J2OL7JUgU7K5PEM3btA77ut980IBPK0ELRGza9SLP1PQEMP0b8yh
         tKqA==
X-Gm-Message-State: ACrzQf2cUpCmecbTijEVkrYaAPqGrgdvuhI07rvR58GcqU0F8FJKMQQk
        V7oyY+Ydob6fs1cK68ApD0e1dLt+8i4grA==
X-Google-Smtp-Source: AMsMyM4YFB++siUju5jcH6r3/6IIz3JJQAtYY3QyRQhUDKxM3+nY9Lo+zgxQnejcr8dk891FWzDokA==
X-Received: by 2002:aa7:ce82:0:b0:457:3152:238b with SMTP id y2-20020aa7ce82000000b004573152238bmr12825891edv.407.1664293473357;
        Tue, 27 Sep 2022 08:44:33 -0700 (PDT)
Received: from [192.168.1.204] (host-82-61-191-175.retail.telecomitalia.it. [82.61.191.175])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906540900b0073d7b876621sm952550ejo.205.2022.09.27.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:44:32 -0700 (PDT)
Message-ID: <f10cd4f9bf2e804b69202b2e916c1b74e2af9b09.camel@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: add support for quiet thermal
 profile
From:   Elia Devito <eliadevito@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     Philippe Rouquier <bonfire-app@wanadoo.fr>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Sep 2022 17:44:30 +0200
In-Reply-To: <1cb582a3-c372-5f6b-b228-523ad45ed8e9@redhat.com>
References: <20220925204244.53506-1-eliadevito@gmail.com>
         <1cb582a3-c372-5f6b-b228-523ad45ed8e9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywKCklsIGdpb3JubyBtYXIsIDI3LzA5LzIwMjIgYWxsZSAxMi4yNCArMDIwMCwgSGFu
cyBkZSBHb2VkZSBoYSBzY3JpdHRvOgo+IEhpIEVsaWEsCj4gCj4gT24gOS8yNS8yMiAyMjo0Miwg
RWxpYSBEZXZpdG8gd3JvdGU6Cj4gPiBUaGUgcXVpZXQgcHJvZmlsZSBpcyBhdmFpbGFibGUgb25s
eSBvbiBtb2RlbHMgd2l0aG91dCBkR1BVLAo+ID4gc28gd2UgZW5hYmxlIGl0IHdoZW4gdGhlIGRl
dmljZSBoYXMgb25seSBvbmUgR1BVIG9uYm9hcmQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEVs
aWEgRGV2aXRvIDxlbGlhZGV2aXRvQGdtYWlsLmNvbT4KPiA+IFRlc3RlZC1ieTogUGhpbGlwcGUg
Um91cXVpZXIgPGJvbmZpcmUtYXBwQHdhbmFkb28uZnI+Cj4gCj4gVGhhbmsgeW91IGZvciB5b3Vy
IHBhdGNoLgo+IAo+IEkgaGF2ZSBqdXN0IGxhbmRlZCBhIHZlcnkgc2ltaWxhciBwYXRjaCBmb3Jt
IEpvcmdlIGZyb20gSFA6Cj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvcGR4ODYvcGxhdGZvcm0tZHJpdmVycy14ODYuZ2l0L2NvbW1pdC8/aD1mb3ItbmV4
dCZpZD0wMGIxODI5Mjk0YjdjODhlY2JhOTJjNjYxZmJlNmZlMzQ3YjM2NGQyCj4gCgpTb3JyeSBm
b3IgdGhlIGR1cGxpY2F0ZSBJIGhhZG7igJl0IHNlZW4gSm9yZ2XigJlzIHBhdGNoLgoKPiBUaGUg
Zmlyc3QgMyBodW5rcyBvZiB0aGUgcGF0Y2ggYXJlIHRoZSBzYW1lLCBvbmx5IHRoZSBjb25kaXRp
b25zCj4gdW5kZXIgd2hpY2ggdGhlOgo+IAo+IMKgwqDCoMKgwqDCoMKgwqBzZXRfYml0KFBMQVRG
T1JNX1BST0ZJTEVfUVVJRVQsCj4gcGxhdGZvcm1fcHJvZmlsZV9oYW5kbGVyLmNob2ljZXMpOwo+
IAo+IGNhbGwgaXMgbWFkZSBhcmUgZGlmZmVyZW50LCBKb3JnZSdzIHBhdGNoIGRvZXMgdGhpcyBl
c3NlbnRpYWxseSBsaWtlCj4gdGhpczoKPiDCoMKgwqDCoMKgwqDCoMKgCj4gwqDCoMKgwqDCoMKg
wqDCoGlmICghaXNfb21lbl90aGVybWFsX3Byb2ZpbGUoKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHNldF9iaXQoUExBVEZPUk1fUFJPRklMRV9RVUlFVCwKPiBwbGF0Zm9ybV9w
cm9maWxlX2hhbmRsZXIuY2hvaWNlcyk7Cj4gCj4gd2hpY2ggc2VlbXMgYSBiaXQgY2xlYW5lciB0
byBtZSBhbmQgaG9wZWZ1bGx5IHdvcmtzIGp1c3QgYXMgd2VsbAo+IG9yIG1heWJlIGV2ZW4gYmV0
dGVyLgo+IAo+IFJlZ2FyZHMsCj4gCj4gSGFucwo+IAoKVGhlIG9ubHkgdGhpbmcgSSB3YW50IHRv
IHBvaW50IG91dCBpcyB0aGF0IGluIHRoaXMgd2F5IHRoZSBwYXRjaAplbmFibGVzIGEgcXVpZXQg
cHJvZmlsZSBvbiBteSBub24tb21lbiBub3RlYm9vayAoSFAgU3BlY3RyZSB4MzYwIDE1LQpkZjAw
MDZubCkgdGhhdCBkb2Vzbid0IHN1cHBvcnQgaXQgb3IgYXQgbGVhc3QgdGhlIEhQIENvbW1hbmQg
Q2VudGVyIGFwcApvbiB3aW5kb3dzIGRvZXNuJ3Qgb2ZmZXIgaXQgYXMgY2hvaWNlLgoKTWF5YmUg
dGhpcyBpcyBhIGJ1ZyBpbiB3aW5kb3dzIGltcGxlbWVudGF0aW9uLCBpZiBKb3JnZSBjYW4ga2lu
ZGx5IGdpdmUKYSBmZWVkYmFjayBvbiB0aGlzLgoKUmVnYXJkcywKRWxpYQo+IAo+IAo+ID4gLS0t
Cj4gPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2hwLXdtaS5jIHwgMjEgKysrKysrKysrKysrKysr
KysrKystCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9ocC13bWkuYwo+
ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9ocC13bWkuYwo+ID4gaW5kZXggYmM3MDIwZTlkZjll
Li4zZTBlNjdiZTgwMDEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9ocC13
bWkuYwo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaHAtd21pLmMKPiA+IEBAIC0xNzcs
NyArMTc3LDggQEAgZW51bSBocF90aGVybWFsX3Byb2ZpbGVfb21lbl92MSB7Cj4gPiDCoGVudW0g
aHBfdGhlcm1hbF9wcm9maWxlIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBIUF9USEVSTUFMX1BST0ZJ
TEVfUEVSRk9STUFOQ0XCoMKgPSAweDAwLAo+ID4gwqDCoMKgwqDCoMKgwqDCoEhQX1RIRVJNQUxf
UFJPRklMRV9ERUZBVUxUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gMHgwMSwKPiA+IC3C
oMKgwqDCoMKgwqDCoEhQX1RIRVJNQUxfUFJPRklMRV9DT09MwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoD0gMHgwMgo+ID4gK8KgwqDCoMKgwqDCoMKgSFBfVEhFUk1BTF9QUk9GSUxF
X0NPT0zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSAweDAyLAo+ID4gK8KgwqDC
oMKgwqDCoMKgSFBfVEhFUk1BTF9QUk9GSUxFX1FVSUVUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSAweDAzLAo+ID4gwqB9Owo+ID4gwqAKPiA+IMKgI2Rl
ZmluZSBJU19IV0JMT0NLRUQoeCkgKCh4ICYgSFBXTUlfUE9XRVJfRldfT1JfSFcpICE9Cj4gPiBI
UFdNSV9QT1dFUl9GV19PUl9IVykKPiA+IEBAIC0xMTk0LDYgKzExOTUsOSBAQCBzdGF0aWMgaW50
IGhwX3dtaV9wbGF0Zm9ybV9wcm9maWxlX2dldChzdHJ1Y3QKPiA+IHBsYXRmb3JtX3Byb2ZpbGVf
aGFuZGxlciAqcHByb2YsCj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBIUF9USEVSTUFMX1BST0ZJ
TEVfQ09PTDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnByb2ZpbGUgPcKg
IFBMQVRGT1JNX1BST0ZJTEVfQ09PTDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIEhQX1RIRVJNQUxfUFJPRklMRV9RVUlF
VDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqcHJvZmlsZSA9wqAgUExBVEZP
Uk1fUFJPRklMRV9RVUlFVDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVh
azsKPiA+IMKgwqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiBAQCAt
MTIxNiw2ICsxMjIwLDkgQEAgc3RhdGljIGludCBocF93bWlfcGxhdGZvcm1fcHJvZmlsZV9zZXQo
c3RydWN0Cj4gPiBwbGF0Zm9ybV9wcm9maWxlX2hhbmRsZXIgKnBwcm9mLAo+ID4gwqDCoMKgwqDC
oMKgwqDCoGNhc2UgUExBVEZPUk1fUFJPRklMRV9DT09MOgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB0cCA9wqAgSFBfVEhFUk1BTF9QUk9GSUxFX0NPT0w7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBQ
TEFURk9STV9QUk9GSUxFX1FVSUVUOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHRwID3CoCBIUF9USEVSTUFMX1BST0ZJTEVfUVVJRVQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoH0KPiA+IEBAIC0xMjMwLDYgKzEyMzcsOCBAQCBzdGF0aWMgaW50IGhwX3dtaV9w
bGF0Zm9ybV9wcm9maWxlX3NldChzdHJ1Y3QKPiA+IHBsYXRmb3JtX3Byb2ZpbGVfaGFuZGxlciAq
cHByb2YsCj4gPiDCoHN0YXRpYyBpbnQgdGhlcm1hbF9wcm9maWxlX3NldHVwKHZvaWQpCj4gPiDC
oHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgZXJyLCB0cDsKPiA+ICvCoMKgwqDCoMKgwqDCoHVu
c2lnbmVkIGludCBuX2dwdSA9IDA7Cj4gPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgZG1p
X2RldmljZSAqZGV2ID0gTlVMTDsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGlzX29t
ZW5fdGhlcm1hbF9wcm9maWxlKCkpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdHAgPSBvbWVuX3RoZXJtYWxfcHJvZmlsZV9nZXQoKTsKPiA+IEBAIC0xMjYzLDYgKzEyNzIs
MTYgQEAgc3RhdGljIGludCB0aGVybWFsX3Byb2ZpbGVfc2V0dXAodm9pZCkKPiA+IMKgCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBsYXRmb3JtX3Byb2ZpbGVfaGFuZGxlci5w
cm9maWxlX2dldCA9Cj4gPiBocF93bWlfcGxhdGZvcm1fcHJvZmlsZV9nZXQ7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBsYXRmb3JtX3Byb2ZpbGVfaGFuZGxlci5wcm9maWxl
X3NldCA9Cj4gPiBocF93bWlfcGxhdGZvcm1fcHJvZmlsZV9zZXQ7Cj4gPiArCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiBUaGUgcXVpZXQgcHJvZmlsZSBpcyBhdmFpbGFibGUgb25seSBvbiBtb2RlbHMKPiA+
IHdpdGhvdXQgZEdQVSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBzbyB3
ZSBlbmFibGUgaXQgd2hlbiB0aGUgZGV2aWNlIGhhcyBvbmx5IG9uZSBHUFUKPiA+IG9uYm9hcmQu
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgd2hpbGUgKChkZXYgPSBkbWlfZmluZF9kZXZpY2UoRE1JX0RFVl9U
WVBFX1ZJREVPLAo+ID4gTlVMTCwgZGV2KSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5fZ3B1Kys7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKG5fZ3B1ID09IDEpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNldF9iaXQoUExBVEZPUk1fUFJPRklMRV9RVUlFVCwK
PiA+IHBsYXRmb3JtX3Byb2ZpbGVfaGFuZGxlci5jaG9pY2VzKTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqB9Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoHNldF9iaXQoUExBVEZPUk1fUFJPRklMRV9D
T09MLAo+ID4gcGxhdGZvcm1fcHJvZmlsZV9oYW5kbGVyLmNob2ljZXMpOwo+IAoK

