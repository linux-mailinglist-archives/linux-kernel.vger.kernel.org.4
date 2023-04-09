Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9E6DC128
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDITOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDITOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 15:14:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0545A2697;
        Sun,  9 Apr 2023 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681067642; x=1712603642;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YcpRs/KMFz3be9ekSnZ5uk9TkNmUN3CnKlDfOrHzXhk=;
  b=l+F/5nckWmddi1n1RNDHQuuKYTUyIvIjZko17K4HNZRGjVKdY6OQMIw1
   I2nJCQHKAfADsMKe4SjZN+AB7OkFdqR/vKy/xGTzQnTOtxkszRmojRsx6
   o/Ckxv3P76vts+83m3EE7UGIBKCjIToZLv8Y3kzdD8Wrr+y0tKLZprkhg
   3aOL+JMKWDt9ADupadi63myNJjCx2p1CUkkbUmqnpMZj4wpdaHZmyPNIz
   72dnG1PYzaA+OAUCwsPpEwYrD2vr5df/H6nezFDlG+brHYK9SvTycKacr
   5CBVOcvLxb0OetrDJkMT1HsMXHqz0VervHLloA/ektan9VHyPo2VCeQMb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="342006133"
X-IronPort-AV: E=Sophos;i="5.98,331,1673942400"; 
   d="scan'208";a="342006133"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 12:14:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="777353668"
X-IronPort-AV: E=Sophos;i="5.98,331,1673942400"; 
   d="scan'208";a="777353668"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Apr 2023 12:14:01 -0700
Received: from kinllee-mobl1.amr.corp.intel.com (unknown [10.251.5.84])
        by linux.intel.com (Postfix) with ESMTP id BB255580BF6;
        Sun,  9 Apr 2023 12:14:00 -0700 (PDT)
Message-ID: <55d2d2d2b20df6e086748cf7404e17e2f4307994.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in
 D3
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        srinivas.pandruvada@linux.intel.com, irenic.rajneesh@gmail.com,
        markgross@kernel.org, rjw@rjwysocki.net
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Apr 2023 12:14:00 -0700
In-Reply-To: <f7a20a10-3871-8b2d-251f-35b0136d684d@redhat.com>
References: <20230408022629.727721-1-david.e.box@linux.intel.com>
         <f7a20a10-3871-8b2d-251f-35b0136d684d@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTA4IGF0IDEwOjU3ICswMjAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+
IEhpIERhdmlkLAo+IAo+IE9uIDQvOC8yMyAwNDoyNiwgRGF2aWQgRS4gQm94IHdyb3RlOgo+ID4g
T24gTWV0ZW9yIExha2UsIHRoZSBHTkEsIElQVSwgYW5kIFZQVSBkZXZpY2VzIGFyZSBib290ZWQg
aW4gRDAgcG93ZXIgc3RhdGUKPiA+IGFuZCB3aWxsIGJsb2NrIHRoZSBTb0MgZnJvbSBnb2luZyBp
bnRvIHRoZSBkZWVwZXN0IFBhY2thZ2UgQy1zdGF0ZSBpZiBhCj4gPiBkcml2ZXIgaXMgbm90IHBy
ZXNlbnQuIFB1dCBlYWNoIGRldmljZSBpbiBEM2hvdCBpZiBubyBkcml2ZXIgaXMgZm91bmQuCj4g
PiAKPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50
ZWwuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9tdGwu
YyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDMxIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL3BtYy9tdGwuYwo+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMv
bXRsLmMKPiA+IGluZGV4IGVlYjNiZDhjMjUwMi4uMzNhYTk4YjU0MDQ5IDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL210bC5jCj4gPiArKysgYi9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvbXRsLmMKPiA+IEBAIC04LDYgKzgsNyBAQAo+ID4gwqAg
Kgo+ID4gwqAgKi8KPiA+IMKgCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+ID4gwqAjaW5j
bHVkZSAiY29yZS5oIgo+ID4gwqAKPiA+IMKgY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwIG10bF9y
ZWdfbWFwID0gewo+ID4gQEAgLTQ1LDggKzQ2LDM4IEBAIHZvaWQgbXRsX2NvcmVfY29uZmlndXJl
KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgcG1jX2NvcmVfc2Vu
ZF9sdHJfaWdub3JlKHBtY2RldiwgMyk7Cj4gPiDCoH0KPiA+IMKgCj4gPiArI2RlZmluZSBNVExf
R05BX1BDSV9ERVbCoMKgwqDCoMKgwqDCoMKgMHg3ZTRjCj4gPiArI2RlZmluZSBNVExfSVBVX1BD
SV9ERVbCoMKgwqDCoMKgwqDCoMKgMHg3ZDE5Cj4gPiArI2RlZmluZSBNVExfVlBVX1BDSV9ERVbC
oMKgwqDCoMKgwqDCoMKgMHg3ZDFkCj4gPiArdm9pZCBtdGxfc2V0X2RldmljZV9kMyh1bnNpZ25l
ZCBpbnQgZGV2aWNlKQo+IAo+IEFzIHBvaW50ZWQgb3V0IGJ5ICJrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4iIHRoaXMgbmVlZHMgdG8KPiBiZSBzdGF0aWMuIE90aGVyd2lzZSB0aGlz
IExHVE0uIFdpdGggdGhpcyBmaXhlZCBwbGVhc2UgYWRkIG15Ogo+IAo+IFJldmlld2VkLWJ5OiBI
YW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgo+IAo+IHRvIHZlcnNpb24gMiBvZiB0
aGUgcGF0Y2guCj4gCj4gUmVnYXJkcywKPiAKPiBIYW5zCgpUaGFua3MgSGFucwoKPiAKPiAKPiAK
PiAKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgcGNpZGV2ID0gcGNpX2dldF9kZXZpY2UoUENJX1ZFTkRPUl9J
RF9JTlRFTCwgZGV2aWNlLCBOVUxMKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChwY2lkZXYpIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWRldmljZV90cnlsb2NrKCZw
Y2lkZXYtPmRldikpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcGNpX2Rldl9wdXQocGNpZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXBjaWRl
di0+ZGV2LmRyaXZlcikgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXZfaW5mbygmcGNpZGV2LT5kZXYsICJTZXR0aW5nIHRvIEQzaG90XG4iKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNpX3Nl
dF9wb3dlcl9zdGF0ZShwY2lkZXYsIFBDSV9EM2hvdCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZV91
bmxvY2soJnBjaWRldi0+ZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBw
Y2lfZGV2X3B1dChwY2lkZXYpOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gK30KPiA+ICsKPiA+
IMKgdm9pZCBtdGxfY29yZV9pbml0KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpCj4gPiDCoHsKPiA+
IMKgwqDCoMKgwqDCoMKgwqBwbWNkZXYtPm1hcCA9ICZtdGxfcmVnX21hcDsKPiA+IMKgwqDCoMKg
wqDCoMKgwqBwbWNkZXYtPmNvcmVfY29uZmlndXJlID0gbXRsX2NvcmVfY29uZmlndXJlOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFNldCBwb3dlciBz
dGF0ZSBvZiBzZWxlY3QgZGV2aWNlcyB0aGF0IGRvIG5vdCBoYXZlIGRyaXZlcnMgdG8gRDMKPiA+
ICvCoMKgwqDCoMKgwqDCoCAqIHNvIHRoYXQgdGhleSBkbyBub3QgYmxvY2sgUGFja2FnZSBDIGVu
dHJ5Lgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqBtdGxfc2V0X2Rl
dmljZV9kMyhNVExfR05BX1BDSV9ERVYpOwo+ID4gK8KgwqDCoMKgwqDCoMKgbXRsX3NldF9kZXZp
Y2VfZDMoTVRMX0lQVV9QQ0lfREVWKTsKPiA+ICvCoMKgwqDCoMKgwqDCoG10bF9zZXRfZGV2aWNl
X2QzKE1UTF9WUFVfUENJX0RFVik7Cj4gPiDCoH0KPiA+IAo+ID4gYmFzZS1jb21taXQ6IDRmNTk2
MzBhNWVkMGE0ZTdkMjc1YmQ3ZTVkMjUzYThmNWE0MjVjNWEKPiAKCg==

