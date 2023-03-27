Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CA6C9FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjC0JfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjC0JfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:35:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668346B0;
        Mon, 27 Mar 2023 02:34:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PlSMZ4SPvz9sbn;
        Mon, 27 Mar 2023 11:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679909690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoFQCh/dPfaIZPiSSIwBE226roc42AVfXcA4nolosx8=;
        b=whFNQFcmpl1GnO+tebINRnQ9PLGXuFmSkTonm94mnsEkEV8Ok5/+XIvXBSBjJIJnVedzsJ
        lpWtlFNPQGiKTefFTuw1r6Q+3326GR74grE1yUcoB5jLEfgekAL8E/AjUbbUad85MHUhhc
        c8si6ukD28lFcbg0t+x+rtZIsHkFYphuJ1H9oHyATvUmN2ZcMSSt+DjMXjithpMwvxgiKs
        ucWPt7rS8xk64I+lJy0Z9kTVlvoA80U+Ehia9NKbXxJDy3Ae/A8iLEZS9NWWtmgztIqW9Y
        GzzehXVsKa9jryqhO0MBuseCWk0ip9yC8Nr+G1xJ+LksaWRBF3c/X5GR3OaaDQ==
Message-ID: <91875b7f6f77d6bc846e2da6d009b44c89cbafab.camel@dylanvanassche.be>
Subject: Re: [PATCH 2/2] remoteproc: qcom: pas: add SDM845 SLPI resource
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Mon, 27 Mar 2023 11:34:47 +0200
In-Reply-To: <a27e7e67-a3e8-01ec-1f0d-717d705af117@linaro.org>
References: <20230325132117.19733-1-me@dylanvanassche.be>
         <20230325132117.19733-3-me@dylanvanassche.be>
         <a27e7e67-a3e8-01ec-1f0d-717d705af117@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4PlSMZ4SPvz9sbn
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS29ucmFkLAoKT24gTW9uLCAyMDIzLTAzLTI3IGF0IDEwOjQ0ICswMjAwLCBLb25yYWQgRHli
Y2lvIHdyb3RlOgo+IAo+IAo+IE9uIDI1LjAzLjIwMjMgMTQ6MjEsIER5bGFuIFZhbiBBc3NjaGUg
d3JvdGU6Cj4gPiBBZGQgU0xQSSByZXNvdXJjZXMgZm9yIHRoZSBTRE04NDUgUXVhbGNvbW0gU29D
IHRvIHRoZSBRdWFsY29tbQo+ID4gcmVtb3RlcHJvYyBxNnY1X3BhcyBkcml2ZXIgdG8gZGVmaW5l
IHRoZSBkZWZhdWx0IGZpcm13YXJlIG5hbWUKPiA+IGFuZCBHTGluayBlZGdlIG5hbWUuCj4gPiAK
PiA+IFNpZ25lZC1vZmYtYnk6IER5bGFuIFZhbiBBc3NjaGUgPG1lQGR5bGFudmFuYXNzY2hlLmJl
Pgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvcmVtb3RlcHJvYy9xY29tX3E2djVfcGFzLmMgfCAxNyAr
KysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQo+
ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL3Fjb21fcTZ2NV9wYXMuYwo+
ID4gYi9kcml2ZXJzL3JlbW90ZXByb2MvcWNvbV9xNnY1X3Bhcy5jCj4gPiBpbmRleCBjOTlhMjA1
NDI2ODUuLmQ4MmI2ZjRiY2VkNCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9x
Y29tX3E2djVfcGFzLmMKPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9xY29tX3E2djVfcGFz
LmMKPiA+IEBAIC0xMDI4LDYgKzEwMjgsMjIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZHNwX2Rh
dGEKPiA+IHNscGlfcmVzb3VyY2VfaW5pdCA9IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLnNzY3RsX2lkID0gMHgxNiwKPiA+IMKgfTsKPiA+IMKgCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBhZHNwX2RhdGEgc2RtODQ1X3NscGlfcmVzb3VyY2UgPSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmNyYXNoX3JlYXNvbl9zbWVtID0gNDI0LAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5maXJtd2FyZV9uYW1lID0gInNscGkubWR0IiwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucGFzX2lkID0gMTIsCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmF1dG9fYm9vdCA9IHRydWUsCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnByb3h5X3BkX25hbWVzID0gKGNoYXIqW10pewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAibGN4IiwKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgImxteCIsCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE5VTEwKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5sb2FkX3N0YXRlID0gInNscGkiLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5zc3JfbmFtZSA9ICJkc3BzIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAuc3lzbW9uX25hbWUgPSAic2xwaSIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLnNzY3RsX2lkID0gMHgxNiwKPiBJc24ndCB0aGlzIGlkZW50aWNhbCB0byBz
bTgxNTBfc2xwaV9yZXNvdXJjZT8KPiAKPiBLb25yYWQKClllcyBpdCBpcy4gSSBhZGRlZCBhIG5l
dyBlbnRyeSBiZWNhdXNlIGZvciBTTTgxNTAsIFNNODI1MCwgYW5kIFNNODM1MAp0aGV5IGFyZSBk
dXBsaWNhdGVkIGFzIHdlbGwuIFRoZSBTRE04NDUncyBzdHJ1Y3QgaXMgaW5kZW50aWNhbCB0bwpT
TTgxNTAvU004MjUwL1NNODM1MCdzIHN0cnVjdHMuCgpLaW5kIHJlZ2FyZHMsCkR5bGFuIFZhbiBB
c3NjaGUKCj4gPiArfTsKPiA+ICsKPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBhZHNwX2RhdGEg
c204MTUwX3NscGlfcmVzb3VyY2UgPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC5jcmFzaF9yZWFzb25fc21lbSA9IDQyNCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLmZpcm13YXJlX25hbWUgPSAic2xwaS5tZHQiLAo+ID4gQEAgLTEyMDEsNiArMTIx
Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkCj4gPiBhZHNwX29mX21hdGNo
W10gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgeyAuY29tcGF0aWJsZSA9ICJxY29tLHNkbTY2MC1h
ZHNwLXBhcyIsIC5kYXRhID0KPiA+ICZhZHNwX3Jlc291cmNlX2luaXR9LAo+ID4gwqDCoMKgwqDC
oMKgwqDCoHsgLmNvbXBhdGlibGUgPSAicWNvbSxzZG04NDUtYWRzcC1wYXMiLCAuZGF0YSA9Cj4g
PiAmc2RtODQ1X2Fkc3BfcmVzb3VyY2VfaW5pdH0sCj4gPiDCoMKgwqDCoMKgwqDCoMKgeyAuY29t
cGF0aWJsZSA9ICJxY29tLHNkbTg0NS1jZHNwLXBhcyIsIC5kYXRhID0KPiA+ICZzZG04NDVfY2Rz
cF9yZXNvdXJjZV9pbml0fSwKPiA+ICvCoMKgwqDCoMKgwqDCoHsgLmNvbXBhdGlibGUgPSAicWNv
bSxzZG04NDUtc2xwaS1wYXMiLCAuZGF0YSA9Cj4gPiAmc2RtODQ1X3NscGlfcmVzb3VyY2V9LAo+
ID4gwqDCoMKgwqDCoMKgwqDCoHsgLmNvbXBhdGlibGUgPSAicWNvbSxzZHg1NS1tcHNzLXBhcyIs
IC5kYXRhID0KPiA+ICZzZHg1NV9tcHNzX3Jlc291cmNlfSwKPiA+IMKgwqDCoMKgwqDCoMKgwqB7
IC5jb21wYXRpYmxlID0gInFjb20sc202MTE1LWFkc3AtcGFzIiwgLmRhdGEgPQo+ID4gJmFkc3Bf
cmVzb3VyY2VfaW5pdH0sCj4gPiDCoMKgwqDCoMKgwqDCoMKgeyAuY29tcGF0aWJsZSA9ICJxY29t
LHNtNjExNS1jZHNwLXBhcyIsIC5kYXRhID0KPiA+ICZjZHNwX3Jlc291cmNlX2luaXR9LAoK

