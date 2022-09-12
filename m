Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F024C5B524F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 02:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiILAxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 20:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILAxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 20:53:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591FD27DC3;
        Sun, 11 Sep 2022 17:53:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k9so12991148wri.0;
        Sun, 11 Sep 2022 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=971Ys11giqdQ7Pxgjb3QEhmcSxe6t7p1+SdsY+akN0k=;
        b=BBSDEKnmLqRLi/iLyUjwCZrzU6e5lTRXiYE/QFs7dU4CgNx6ZMurZL5CNdK4zDPeWL
         u09fQ5yfla5TDq063vmoDFBjrKjwPUWEkGABbPOtSc1JmJ88j/rpQ4VTGqgIqASpCXKL
         piLA+/KVh67f70nnfKeRLKviAQ9DezLsJVyBv5nzBUHcnVWp22cItbFEupPU4nrD58Jr
         iWOaQ5vl7/wM5NIlfF55KrF8Pem/bUR5BbkBnU52dLQFzrMBVM6jPpJb9Z5oOeHV8jaA
         2YIHcZu05jnZZzfcexAONZQu5qsv/JQNKTCt4A8E3BkJOWGXaThhWlQgEFSUCPDR72Ef
         91Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=971Ys11giqdQ7Pxgjb3QEhmcSxe6t7p1+SdsY+akN0k=;
        b=opcvMNouHLhZqIA1/Wf90KtJyOI2P+6PRaSuxohqhq0aePH5bJP0M9evM0+l8KrnCT
         GMS1x6yHSXGGYupyjJCUazhkq1mK0cQgakDEIhyNBDRpuOfZBgnmIavSMZWgdMDIlP66
         Try1+nqHIBNQ4QKGWraMJHAIdj4XOOCT0+GI3NLcDoia7yN7zlG7dl0frAPGwrs4qFhV
         Wz5tyDXtmdziZQq6turiFD8aNO7SeUE7Trbdup0dUc1hpUyqY8dE7sUBFzkp2ZQ9lcWk
         SKyXyv59+28bppt6UUvwMPMoKcrgCK8WlW+5vbmnla94qDeFwYtq5HKxqT/PYXTEfFFv
         Wexw==
X-Gm-Message-State: ACgBeo1gmrlzoxsAAf6fzwpZTwxBQH6UUWYQlVzHTIt0oVBqKMP43ZnL
        A+QfBcHx48Bsmi65baFRZgZATHKWZb8=
X-Google-Smtp-Source: AA6agR6ybRz+uVwRk8e3m2pRRzoSWMcu0azK2Vi1oBoha4jJDAdo3hHu/WH/Fh0E15o8Lsf4DXYFAA==
X-Received: by 2002:a5d:648c:0:b0:22a:2c04:97a5 with SMTP id o12-20020a5d648c000000b0022a2c0497a5mr11138308wri.326.1662943988842;
        Sun, 11 Sep 2022 17:53:08 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l31-20020a05600c1d1f00b003a601a1c2f7sm8390872wms.19.2022.09.11.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:53:08 -0700 (PDT)
Message-ID: <505a681fe6f18139c8cb0e966a706979f41b7d7e.camel@gmail.com>
Subject: Re: [PATCH v5 5/5] iio: pressure: bmp280: Add more tunable config
 parameters for BMP380
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Sep 2022 02:53:06 +0200
In-Reply-To: <CAHp75VeNctrQjW4RHwbsF-y--9bAzg3XTFTZzXk+6whRFJcFYg@mail.gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
         <680e7218234676ba78fc5eccd5f93e29c06c3983.1659872590.git.ang.iglesiasg@gmail.com>
         <CAHp75VeNctrQjW4RHwbsF-y--9bAzg3XTFTZzXk+6whRFJcFYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTA4IGF0IDExOjEzICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gU3VuLCBBdWcgNywgMjAyMiBhdCAyOjQ0IFBNIEFuZ2VsIElnbGVzaWFzIDxhbmcuaWds
ZXNpYXNnQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IEFsbG93cyBzYW1wbGluZyBmcmVxdWVu
Y3kgYW5kIElJUiBmaWx0ZXIgY29lZmZpY2llbnRzIGNvbmZpZ3VyYXRpb24KPiA+IHVzaW5nIHN5
c2ZzIEFCSS4KPiA+IAo+ID4gVGhlIElJUiBmaWx0ZXIgY29lZmZpY2llbnQgaXMgY29uZmlndXJh
YmxlIHVzaW5nIHRoZSBzeXNmcyBhdHRyaWJ1dGUKPiA+ICJmaWx0ZXJfbG93X3Bhc3NfM2RiX2Zy
ZXF1ZW5jeSIuCj4gCj4gLi4uCj4gCj4gPiArc3RhdGljIGNvbnN0IGludCBibXAzODBfb2RyX3Rh
YmxlW11bMl0gPSB7Cj4gCj4gczMyX2ZyYWN0ID8KCkkgbW9kZWxlZCB0aGlzIGJpdCBhbmQgb3Ro
ZXIgT0RSIHJlcHJlc2VudGF0aW9ucyBhZnRlciB0aGUgYWR4bDM1NSBkcml2ZXIuIEkgc2VlCnRo
YXQgczMyX2ZyYWN0IHdvdWxkIGJlIGEgYml0IGNsZWFuZXIgdGhhbiBoYXZpbmcgYXJyYXlzIGlu
c2lkZSBhcnJheXMsIGJ1dCBJJ20KZmFpbGluZyB0byBzZWUgd2hpY2ggYWRkaXRpb25hbCBhZHZh
bnRhZ2VzIHdvdWxkIHByb3ZpZGUuCkFsc28sIHRlY2huaWNhbGx5LCB0aGVzZSBhcmUgcHJlY29t
cHV0ZWQgZnJlcXVlbmNpZXMsIHRoZSBmaXJzdCBpbmRleCBpcyB0aGUKaW50ZWdlciBwYXJ0IGFu
ZCB0aGUgc2Vjb25kIGlzIHRoZSBmcmFjdGlvbmFsIHBhcnQuIFRoZSBmcmFjdGlvbnMgd291bGQg
YmUKMjAwLzEsIDIwMC8yLCAyMDAvNCAuLi4gMjAwLzEzMTA3MgoKPiA+ICvCoMKgwqDCoMKgwqAg
W0JNUDM4MF9PRFJfMjAwSFpdwqDCoMKgwqDCoCA9IHsyMDAsIDB9LAo+ID4gK8KgwqDCoMKgwqDC
oCBbQk1QMzgwX09EUl8xMDBIWl3CoMKgwqDCoMKgID0gezEwMCwgMH0sCj4gPiArwqDCoMKgwqDC
oMKgIFtCTVAzODBfT0RSXzUwSFpdwqDCoMKgwqDCoMKgID0gezUwLCAwfSwKPiA+ICvCoMKgwqDC
oMKgwqAgW0JNUDM4MF9PRFJfMjVIWl3CoMKgwqDCoMKgwqAgPSB7MjUsIDB9LAo+ID4gK8KgwqDC
oMKgwqDCoCBbQk1QMzgwX09EUl8xMl81SFpdwqDCoMKgwqAgPSB7MTIsIDUwMDAwMH0sCj4gPiAr
wqDCoMKgwqDCoMKgIFtCTVAzODBfT0RSXzZfMjVIWl3CoMKgwqDCoCA9IHs2LCAyNTAwMDB9LAo+
ID4gK8KgwqDCoMKgwqDCoCBbQk1QMzgwX09EUl8zXzEyNUhaXcKgwqDCoCA9IHszLCAxMjUwMDB9
LAo+ID4gK8KgwqDCoMKgwqDCoCBbQk1QMzgwX09EUl8xXzU2MjVIWl3CoMKgID0gezEsIDU2MjUw
MH0sCj4gPiArwqDCoMKgwqDCoMKgIFtCTVAzODBfT0RSXzBfNzhIWl3CoMKgwqDCoCA9IHswLCA3
ODEyNTB9LAo+ID4gK8KgwqDCoMKgwqDCoCBbQk1QMzgwX09EUl8wXzM5SFpdwqDCoMKgwqAgPSB7
MCwgMzkwNjI1fSwKPiA+ICvCoMKgwqDCoMKgwqAgW0JNUDM4MF9PRFJfMF8ySFpdwqDCoMKgwqDC
oCA9IHswLCAxOTUzMTN9LAo+ID4gK8KgwqDCoMKgwqDCoCBbQk1QMzgwX09EUl8wXzFIWl3CoMKg
wqDCoMKgID0gezAsIDk3NjU2fSwKPiA+ICvCoMKgwqDCoMKgwqAgW0JNUDM4MF9PRFJfMF8wNUha
XcKgwqDCoMKgID0gezAsIDQ4ODI4fSwKPiA+ICvCoMKgwqDCoMKgwqAgW0JNUDM4MF9PRFJfMF8w
MkhaXcKgwqDCoMKgID0gezAsIDI0NDE0fSwKPiA+ICvCoMKgwqDCoMKgwqAgW0JNUDM4MF9PRFJf
MF8wMUhaXcKgwqDCoMKgID0gezAsIDEyMjA3fSwKPiA+ICvCoMKgwqDCoMKgwqAgW0JNUDM4MF9P
RFJfMF8wMDZIWl3CoMKgwqAgPSB7MCwgNjEwNH0sCj4gPiArwqDCoMKgwqDCoMKgIFtCTVAzODBf
T0RSXzBfMDAzSFpdwqDCoMKgID0gezAsIDMwNTJ9LAo+ID4gK8KgwqDCoMKgwqDCoCBbQk1QMzgw
X09EUl8wXzAwMTVIWl3CoMKgID0gezAsIDE1MjZ9LAo+ID4gK307Cj4gCj4gLi4uCj4gCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSByZWdtYXBfd3JpdGVfYml0cyhkYXRh
LT5yZWdtYXAsCj4gPiBCTVAzODBfUkVHX1BPV0VSX0NPTlRST0wsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBCTVAzODBfTU9ERV9NQVNLLAo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRklF
TERfUFJFUChCTVAzODBfTU9ERV9NQVNLLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEJNUDM4MF9NT0RFX1NMRUVQKSk7Cj4gCj4gT25lIGxpbmU/Cj4gCj4g
Li4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSByZWdtYXBfd3Jp
dGVfYml0cyhkYXRhLT5yZWdtYXAsCj4gPiBCTVAzODBfUkVHX1BPV0VSX0NPTlRST0wsCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBCTVAzODBfTU9ERV9NQVNLLAo+IAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgRklFTERfUFJFUChCTVAzODBfTU9ERV9NQVNLLAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJNUDM4MF9NT0RFX05PUk1BTCkpOwo+IAo+IERp
dHRvLgo+IAo+IC4uLgo+IAo+ID4gK3N0YXRpYyBjb25zdCBpbnQgYm1wMzgwX2lpcl9maWx0ZXJf
Y29lZmZzX2F2YWlsW10gPSB7IDAsIDEsIDMsIDcsIDE1LCAzMSwKPiA+IDYzLCAxMjcgfTsKPiAK
PiBUaGlzIHNlZW1zIGxpa2UgYSBwb3dlciBvZiB0d28gLSAxLCBjYW4gaXQgYmUgcmVwbGFjZWQg
YnkgYSBmb3JtdWxhIGluIHRoZQo+IGNvZGU/Cj4gCgo=

