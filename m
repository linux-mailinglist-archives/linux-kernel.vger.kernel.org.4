Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197AA7464CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGCVZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:25:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0EE59;
        Mon,  3 Jul 2023 14:25:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991da766865so585994266b.0;
        Mon, 03 Jul 2023 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688419533; x=1691011533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=27GIYsPSYheuZYjfnBgY9dY1AI+iDe9MGAyTUH7wAbw=;
        b=IOcvgpL4lDSPZB0wS+KnFPsWFWxGPNIxVy4LTPW2eni5uV7iodZ8DZOwjd1wd5xLxQ
         MRSmMJTnNP8IIlAafI8k0DHKDsDnT145qNImdENmUzLPwX1WGDhZVSdGf/Q6WSzcVztV
         qzq1QbK8dm2ZVh2dYiV7p4OPFE15989TIzHRAsahrOBQqJWoNCERfNAkpnnd4bzVYmJC
         l/EAgeNDZgmxB7rEgT9I4Zxwf5EnmYunyfBl6QuiQrXATQ1Aju8gzxktBwJZIXacdIyW
         6WsGe3T21oddbLJiaHpHPAKlw8KWtW2CWxKDzfdR1Ws1WVPeutqciT4tMOhNz5DjekUb
         otUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688419533; x=1691011533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27GIYsPSYheuZYjfnBgY9dY1AI+iDe9MGAyTUH7wAbw=;
        b=YFFTTripa6EwE8wQ7AjX+isH87filkQZVidcUV5VPJ/xXh+ISdu2lruB0U5LYqbsBC
         rTHDuwmOEy1xdAhbOBp7ohM8Xg/RP1sGQZ5oq4piGE6tkivlHG81la4IA086LP0X3Weg
         JvzmimlTMbGM6cTCBizeUeI+f7pnNwwshBe9FeZOqWHDyIgu0MoUXqEponsd1LMn5yXA
         nhynXyvcY7HHGtJAZK/qAQPiDwvWkylMTx38RHORpYAJwiYq0VPexKuxHu4mDVBL9ItB
         VKMVhOZ8hHTy8pbxCJriCPqUCd2eKkotZkxwvvleB6W4BiKKfS+6nz/1svA69XYToyw7
         fUWg==
X-Gm-Message-State: ABy/qLb/XwLSsyoNApcijKnqXRNvLekiw1h1iZD7bqAfJ2RKdBrH5d4/
        17YGwyKgKydxnkqJSLzQDddGGKhXogHU93y42Uc=
X-Google-Smtp-Source: APBJJlG1cVaF6+kUWAjUTaA3kEvvhDgugvFj0cMQX4W3OtKPYrzn1F/wkuTBHiiQU9lsS3CVTkPOsfDTpXMPEvtOLv4=
X-Received: by 2002:a17:906:5e4b:b0:991:cd1f:e67a with SMTP id
 b11-20020a1709065e4b00b00991cd1fe67amr7901290eju.29.1688419533205; Mon, 03
 Jul 2023 14:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
 <9ab8cc85d4d440bfa63dcade4e4f9ecf@realtek.com> <CAFBinCBsg8jPhpqSOr9w2JhwN5YjPeME1Uye7meSY8h=b_N4Qg@mail.gmail.com>
 <e87abbe35f4945cba3440232880424b1@realtek.com>
In-Reply-To: <e87abbe35f4945cba3440232880424b1@realtek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 Jul 2023 23:25:22 +0200
Message-ID: <CAFBinCB6Q67nG3Z33i=nDLcYGENCSHFKNq=ViJks0j9aXbcYpA@mail.gmail.com>
Subject: Re: wifi: rtw88: question about SDIO RX aggregation limiting
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000824ae805ff9bcecc"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000824ae805ff9bcecc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ping-Ke,

sorry again for the long waiting time. I'll be quicker next time.

On Tue, Jun 20, 2023 at 7:26=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
[...]
> > > The unit of BIT_RXDMA_AGG_PG_TH is 1k bytes, so I think you can
> > > set mmc_host->max_req_size/1024.
> > I tried this but I got a result that I don't understand.
> > I've been testing with three BIT_RXDMA_AGG_PG_TH values on a SoC that
> > can handle 255 * 1024 bytes. Each time I connected to the same AP and
> > downloaded a bigger file over http(s).
> > BIT_RXDMA_AGG_PG_TH: biggest observed rx_len in rtw_sdio_rxfifo_recv()
> > 255: 20968
> > 6: 5122
> > 1: 1602
>
> Please also print out number of packets you receive, and then we can see =
how
> many packets aggregate.
sure - here are the results:
BIT_RXDMA_AGG_PG_TH: biggest observed rx_len in rtw_sdio_rxfifo_recv()
/ number of (aggregated) packets
255: 20824 / 12
6: 5128 / 4
1: 3132 / 1 (these were a few exceptions and I'm not able to reliably
reproduce it, 1602 / 1 is what I can easily reproduce)

> > The biggest rx_len I have observed for BIT_RXDMA_AGG_PG_TH 1 looks susp=
icious:
> > My understanding is that I shouldn't be seeing rx_len larger than
> > BIT_RXDMA_AGG_PG_TH * 1024.
> > BIT_RXDMA_AGG_PG_TH =3D 6 is within this limit but BIT_RXDMA_AGG_PG_TH =
=3D
> > 1 isn't (I'm seeing 578 extra bytes in addition to the 1024 bytes that
> > I was expecting).
>
> Assume threshold is 1k, and single one packet is larger than 1k. Hardware
> will not split it into two. Also, please make sure 0x280[29] BIT_EN_PRE_C=
ALC
> is 1. Otherwise, it will possibly aggregate additional one packet to over
> the threshold.
From the numbers above it seems most likely that we're hitting the
"one packet is larger than 1k" case.

Also I'm seeing:
  wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default qlen 1000
My interface's MTU is 1500 bytes. Seeing 1602 bytes rx_len with one
packet is already odd (that would mean 102 bytes for overhead like RX
descriptor and other headers/metadata). But 3132 bytes rx_len is very
odd.

BIT_EN_PRE_CALC is set, see also the attached diff (it's not meant to
be applied anywhere - it's just so you understand what I've been
testing with).

> 0x280[15:8] is timeout time in unit of 1us for SDIO interface. When set
> threshold to 255, you can enlarge this to see if it can aggregate more as
> expected.
I did not experiment with this yet as I'd like to understand the above
findings first.


Best regards,
Martin

--000000000000824ae805ff9bcecc
Content-Type: text/x-patch; charset="US-ASCII"; name="rtw88-rx-agg-test.diff"
Content-Disposition: attachment; filename="rtw88-rx-agg-test.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljncq4dc0>
X-Attachment-Id: f_ljncq4dc0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMKaW5kZXggMmMxZmIyZGFi
ZDQwLi4wYmI4NzJlZjEyOTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvc2Rpby5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
c2Rpby5jCkBAIC02NTQsMjMgKzY1NCwzNSBAQCBzdGF0aWMgdm9pZCBydHdfc2Rpb19pbml0KHN0
cnVjdCBydHdfZGV2ICpydHdkZXYpCiAKIHN0YXRpYyB2b2lkIHJ0d19zZGlvX2VuYWJsZV9yeF9h
Z2dyZWdhdGlvbihzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQogewotCXU4IHNpemUsIHRpbWVvdXQ7
CisJc3RydWN0IHJ0d19zZGlvICpydHdzZGlvID0gKHN0cnVjdCBydHdfc2RpbyAqKXJ0d2Rldi0+
cHJpdjsKKwlzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QgPSBydHdzZGlvLT5zZGlvX2Z1bmMtPmNhcmQt
Pmhvc3Q7CisJdW5zaWduZWQgaW50IGhvc3RfbWF4X3BhZ2VzOworCXU4IGNoaXBfbWF4X3BhZ2Vz
LCB0aW1lb3V0OwogCiAJaWYgKHJ0d19jaGlwX3djcHVfMTFuKHJ0d2RldikpIHsKLQkJc2l6ZSA9
IDB4NjsKKwkJY2hpcF9tYXhfcGFnZXMgPSAweDY7CiAJCXRpbWVvdXQgPSAweDY7CiAJfSBlbHNl
IHsKLQkJc2l6ZSA9IDB4ZmY7CisJCWNoaXBfbWF4X3BhZ2VzID0gMHhmZjsKIAkJdGltZW91dCA9
IDB4MTsKIAl9CiAKKwlob3N0X21heF9wYWdlcyA9IGhvc3QtPm1heF9yZXFfc2l6ZSAvIFNaXzFL
OworCisJcnR3X2VycihydHdkZXYsICJNYXggUlggcGFnZXMgLSBjaGlwIGFnZ3JlZ2F0aW9uIGxp
bWl0OiAldSwgaG9zdCBjb250cm9sbGVyIGxpbWl0OiAldVxuIiwgY2hpcF9tYXhfcGFnZXMsIGhv
c3RfbWF4X3BhZ2VzKTsvLyBIQUNLCisJcnR3X2RiZyhydHdkZXYsIFJUV19EQkdfU0RJTywKKwkJ
Ik1heCBSWCBwYWdlcyAtIGNoaXAgYWdncmVnYXRpb24gbGltaXQ6ICV1LCBob3N0IGNvbnRyb2xs
ZXIgbGltaXQ6ICV1XG4iLAorCQljaGlwX21heF9wYWdlcywgaG9zdF9tYXhfcGFnZXMpOworCiAJ
LyogTWFrZSB0aGUgZmlybXdhcmUgaG9ub3IgdGhlIHNpemUgbGltaXQgY29uZmlndXJlZCBiZWxv
dyAqLwogCXJ0d193cml0ZTMyX3NldChydHdkZXYsIFJFR19SWERNQV9BR0dfUEdfVEgsIEJJVF9F
Tl9QUkVfQ0FMQyk7CiAKIAlydHdfd3JpdGU4X3NldChydHdkZXYsIFJFR19UWERNQV9QUV9NQVAs
IEJJVF9SWERNQV9BR0dfRU4pOwogCiAJcnR3X3dyaXRlMTYocnR3ZGV2LCBSRUdfUlhETUFfQUdH
X1BHX1RILAotCQkgICAgRklFTERfUFJFUChCSVRfUlhETUFfQUdHX1BHX1RILCBzaXplKSB8CisJ
CSAgICBGSUVMRF9QUkVQKEJJVF9SWERNQV9BR0dfUEdfVEgsIG1pbl90KHVuc2lnbmVkIGludCwK
KwkJCQkJCQkgIGNoaXBfbWF4X3BhZ2VzLAorCQkJCQkJCSAgaG9zdF9tYXhfcGFnZXMpKSB8CiAJ
CSAgICBGSUVMRF9QUkVQKEJJVF9ETUFfQUdHX1RPX1YxLCB0aW1lb3V0KSk7CiAKIAlydHdfd3Jp
dGU4X3NldChydHdkZXYsIFJFR19SWERNQV9NT0RFLCBCSVRfRE1BX01PREUpOwpAQCAtOTM2LDYg
Kzk0OCw3IEBAIHN0YXRpYyB2b2lkIHJ0d19zZGlvX3J4Zmlmb19yZWN2KHN0cnVjdCBydHdfZGV2
ICpydHdkZXYsIHUzMiByeF9sZW4pCiB7CiAJc3RydWN0IHJ0d19zZGlvICpydHdzZGlvID0gKHN0
cnVjdCBydHdfc2RpbyAqKXJ0d2Rldi0+cHJpdjsKIAljb25zdCBzdHJ1Y3QgcnR3X2NoaXBfaW5m
byAqY2hpcCA9IHJ0d2Rldi0+Y2hpcDsKKwl1bnNpZ25lZCBpbnQgbnVtX3BrdCA9IDAsIG9yaWdf
cnhfbGVuID0gcnhfbGVuOwogCXUzMiBwa3RfZGVzY19zeiA9IGNoaXAtPnJ4X3BrdF9kZXNjX3N6
OwogCXN0cnVjdCBpZWVlODAyMTFfcnhfc3RhdHVzIHJ4X3N0YXR1czsKIAlzdHJ1Y3QgcnR3X3J4
X3BrdF9zdGF0IHBrdF9zdGF0OwpAQCAtOTc0LDYgKzk4Nyw3IEBAIHN0YXRpYyB2b2lkIHJ0d19z
ZGlvX3J4Zmlmb19yZWN2KHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiByeF9sZW4pCiAJCQkg
Ki8KIAkJCXJ0d19zZGlvX3J4X3NrYihydHdkZXYsIHNrYiwgcGt0X29mZnNldCwgJnBrdF9zdGF0
LAogCQkJCQkmcnhfc3RhdHVzKTsKKwkJCW51bV9wa3QrKzsKIAkJCWJyZWFrOwogCQl9CiAKQEAg
LTk4MSw2ICs5OTUsNyBAQCBzdGF0aWMgdm9pZCBydHdfc2Rpb19yeGZpZm9fcmVjdihzdHJ1Y3Qg
cnR3X2RldiAqcnR3ZGV2LCB1MzIgcnhfbGVuKQogCQlpZiAoIXNwbGl0X3NrYikgewogCQkJcnR3
X3NkaW9fcnhfc2tiKHJ0d2Rldiwgc2tiLCBwa3Rfb2Zmc2V0LCAmcGt0X3N0YXQsCiAJCQkJCSZy
eF9zdGF0dXMpOworCQkJbnVtX3BrdCsrOwogCQkJYnJlYWs7CiAJCX0KIApAQCAtOTg5LDExICsx
MDA0LDE0IEBAIHN0YXRpYyB2b2lkIHJ0d19zZGlvX3J4Zmlmb19yZWN2KHN0cnVjdCBydHdfZGV2
ICpydHdkZXYsIHUzMiByeF9sZW4pCiAKIAkJcnR3X3NkaW9fcnhfc2tiKHJ0d2Rldiwgc3BsaXRf
c2tiLCBwa3Rfb2Zmc2V0LCAmcGt0X3N0YXQsCiAJCQkJJnJ4X3N0YXR1cyk7CisJCW51bV9wa3Qr
KzsKIAogCQkvKiBNb3ZlIHRvIHRoZSBzdGFydCBvZiB0aGUgbmV4dCBSWCBkZXNjcmlwdG9yICov
CiAJCXNrYl9yZXNlcnZlKHNrYiwgY3Vycl9wa3RfbGVuKTsKIAkJcnhfbGVuIC09IGN1cnJfcGt0
X2xlbjsKIAl9CisKKwlwcl9lcnIoIiVzKCV1KSAtIG51bWJlciBvZiBwYWNrZXRzOiAldVxuIiwg
X19mdW5jX18sIG9yaWdfcnhfbGVuLCBudW1fcGt0KTsvLyBIQUNLCiB9CiAKIHN0YXRpYyB2b2lk
IHJ0d19zZGlvX3J4X2lzcihzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQo=
--000000000000824ae805ff9bcecc--
