Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F65614EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKAQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:01:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0260CCE07;
        Tue,  1 Nov 2022 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667318489; bh=wqEmykY8sq7ZS7zFRbw1eAhxJ6Z9ajXFcFiMuF7++7Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=a+fuhTaTKHTJPsX+48nmwJGwnYeLWUNuKECJ5TZPbTftoSf/r7oRFP6VwBeR+nRYA
         /hjF9NzDuwu02Im13NlDTNLCrUcn3ACTDl3lxqc1Vz1qTR/fftXlmqjTt7IRD4QcJI
         bToVG4LLSGI41+wp+LAYzHoRuMb5aT+7nqRGa8+F0Dn8TtVV/my1jgm4CPGNK1r4GE
         xqnSMIJPwGeTgfIeyTutFTQW3UN7aFveXrY3CRnhFtAWX+0PJJ2hGqoVfhG/vZM0tu
         OIRPU3CDYjIvAtPOvX5hQkphHnM/ZcG/lPwDmrj4zWrcyZAjh2S2O+YzPRM0GVsAVx
         HaY93pRPy9caw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1pIfx30rv6-00kLNT; Tue, 01
 Nov 2022 17:01:29 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide: hw_random: Make document title more generic and concise
Date:   Tue,  1 Nov 2022 17:01:18 +0100
Message-Id: <20221101160119.955997-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:BniFoQ8fY4g953kMOLmdVbJHsLH9tOMFkdJNSMpesAWwoYkSQQO
 YdA9rRclCh6xyd9/El8dXiyv9mJyfydG4R+R+c2oEjCWKRY8z+txssTftoWjBYAgWv61IVR
 eIlsaswD8EvpBb98LaFvMxLlRD7nihn8JPmQkF2vGb6t+AFb2W6TMIPCU/1gAkH9lzhwyVD
 cxX3kuLDk6km56ylrO1AA==
UI-OutboundReport: notjunk:1;M01:P0:V2IQ3ftWzZE=;sEjlYKeoJsw5hc0wJqcSSpOWC2b
 tPhg9IUSBXM6JHt2Kq1tnq06OS/n3GHZGbrLEyOZEl8u7HZAyRntkSdN7EJj36bn2eKj5umMY
 GHiNbDZmLz3ogYqRVDJidiv7fU/ok+T9nsV63O3gowCFwBXejfAL8WzfjRCLU0xZUcomeS6J7
 eaPT3ChmKMozKP1rgx7nj7r0ZwqUMf/AaHzjsALUcWoc5SUrMt8hUBcgNkGko0A6f4NngtTuV
 iqlL87xXx8be4l16j7e07VzL8L+WO8hRD+xFuxVE8N+/ZBzslALnWCwfpWlQH67qU93j+dqHj
 qaxFlwes3BL8VfHF5HS0aYmD83BpqseYRPKJ9J5W+kJ+KWl3qDK3uDGeIdX38C2JFx/w+n5Bz
 NA4g2+USiCSHWslMuvX3afzEGj+Hrwz78cP3gT5qke9iRoBpto6u0y38PBNOvqzfd00xzRA7V
 nqBXcYC3wEhpy9RldwyVUKx68lH+K2OZC6yfc4il2uEvOVtAosvtSm5Sj4KWnDxRCrNSIOxAg
 EWpNzn73XaAJBryG9nXog+gdcyBXELLxyYXVjJqXIqJAND5tLA8Pa1u61JsWRHbYbGa/O0XEl
 QM0PGoF/nek+J6tskuuVFq/MNufV+6xbu0dTRafEqNToNBrx9dEBCbuh7QlkD+Pt3MxOMwpnh
 92WVAIo6QWcXqRUBtka0D4eihKZG1p61ayqSlp+t04lig4SMY2QojRSEMA9PYUBeNAHJXsNVB
 bcS4UJ6UyXkYytJf3FIOxWBloaYU+GSxBHVzQ2RhhN81i0GaojbqxVbiCfrvaaE64IjDC8f8M
 i9DEYb1o8E4ruqSglX47CtRzH4WKclNIdVGwkgqnYQ0J+LvLoYo5D3jZa4e/dpFVhF25p7Yf3
 RvHrWT6JOyA3Gc0ob+Vtq4X7Mofv0nqH7T1tdrQuDUv/NZrgBWTBqTgg6Zt5FKi60lPlU2Vdx
 nfxcyw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGh3X3JhbmRvbSBzdWJzeXN0ZW0gbm8gbG9uZ2VyIHdvcmtzIG9ubHkgb24gc3BlY2lmaWMg
SW50ZWwgY2hpcHNldHM7DQptYWtlIHRoZSB0aXRsZSBvZiBod19yYW5kb20ucnN0IHJlZmxlY3Qg
dGhpcyBmYWN0Lg0KDQpXaGlsZSB3ZSdyZSBhdCBpdCwgYWxzbyByZW1vdmUgdGhlIHdvcmRzICJM
aW51eCBzdXBwb3J0IGZvciIsIHNpbmNlIGl0J3MNCmNsZWFyIGZyb20gY29udGV4dCB0aGF0IHRo
aXMgaXMgYSBkb2N1bWVudCBhYm91dCBMaW51eC4NCg0KU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
TmV1c2Now6RmZXIgPGoubmV1c2NoYWVmZXJAZ214Lm5ldD4NCi0tLQ0KIERvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUvaHdfcmFuZG9tLnJzdCB8IDYgKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUvaHdfcmFuZG9tLnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUv
aHdfcmFuZG9tLnJzdA0KaW5kZXggMTIxZGU5NmUzOTVlMi4uZDQ5NDYwMTcxN2YxZiAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHdfcmFuZG9tLnJzdA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9od19yYW5kb20ucnN0DQpAQCAtMSw2ICsxLDYgQEANCi09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQotTGludXggc3VwcG9ydCBmb3IgcmFuZG9tIG51bWJlciBnZW5lcmF0b3IgaW4gaTh4eCBjaGlw
c2V0cw0KLT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCitIYXJkd2FyZSBy
YW5kb20gbnVtYmVyIGdlbmVyYXRvcnMNCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCiANCiBJbnRyb2R1Y3Rpb24NCiA9PT09PT09PT09PT0NCi0tIA0KMi4zNS4xDQoNCg==
