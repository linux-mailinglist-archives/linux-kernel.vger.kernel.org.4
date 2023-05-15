Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF5703FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbjEOVha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEOVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:37:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA35B80
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684186647; x=1715722647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=Z4ysCkmsMQ8/UQQK6plTlWxmhVINUrKzNMXoSXuGyC8=;
  b=DQ15HInmfuhdDtudY5UPxEUmM0KavdB1FsY2wOLQFAqcHIEDCH38I/KT
   7h27onlOnK5TR1B2lCmdaO8bdcLorzItMZMBWIqyGa/lz4CAp6QySJ7+y
   jY8ZZVnpmero3FymmAcCkeXpR09sBWExiTYFwXA+RE0kGX8VZzhnKumR8
   1FBy+4R2qAKDY1LlWgOS8hjcv/wUJP9gUZJUbfaif/HpO3aVmvluEb3U+
   ayet/EqisEb+P1715uOaEX/pYkAr+SZKr+Ku22m6cK7+SaC2u0h8IyUXi
   AR0jyQfpOEUBanwPh2DgBHpwloLoifoYaXF5FyC21ijNK7/zpLY1KFEn/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="351350662"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="351350662"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="695183582"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="695183582"
Received: from satwikja-mobl.amr.corp.intel.com (HELO [10.212.213.112]) ([10.212.213.112])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:37:27 -0700
Content-Type: multipart/mixed; boundary="------------BePvJyiy0wMXwplpIRovCDid"
Message-ID: <bfa65f6c-8d6f-3111-caf8-6c02cf78877c@intel.com>
Date:   Mon, 15 May 2023 14:37:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/shstk for 6.4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
 <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
 <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
 <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com>
 <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
 <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BePvJyiy0wMXwplpIRovCDid
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/23 14:36, Dave Hansen wrote:
> Is this worth pursuing?

... and with the actual patch this time
--------------BePvJyiy0wMXwplpIRovCDid
Content-Type: text/x-patch; charset=UTF-8; name="get_task_mm-locking.patch"
Content-Disposition: attachment; filename="get_task_mm-locking.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaCB8ICAgIDYgKysKIGIv
aW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAgICAgIHwgICAgMSAKIGIva2VybmVsL2Zvcmsu
YyAgICAgICAgICAgICAgICAgIHwgICA4MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtcHVOIGtlcm5lbC9mb3JrLmN+Z2V0X3Rhc2tfbW0tbG9ja2luZyBr
ZXJuZWwvZm9yay5jCi0tLSBhL2tlcm5lbC9mb3JrLmN+Z2V0X3Rhc2tfbW0tbG9ja2luZwky
MDIzLTA1LTE1IDA4OjU1OjU5LjE2ODkxODk3MSAtMDcwMAorKysgYi9rZXJuZWwvZm9yay5j
CTIwMjMtMDUtMTUgMTQ6MTc6MzQuNDM0NTQ3MjMxIC0wNzAwCkBAIC02NjEsNiArNjYxLDEy
IEBAIHN0YXRpYyBfX2xhdGVudF9lbnRyb3B5IGludCBkdXBfbW1hcChzdHIKIAkJcmV0dmFs
ID0gLUVJTlRSOwogCQlnb3RvIGZhaWxfdXByb2JlX2VuZDsKIAl9CisKKwlpZiAoKGF0b21p
Y19yZWFkKCZvbGRtbS0+bW1fdXNlcnMpID09IDEpICYmCisJICAgIChhdG9taWNfcmVhZCgm
b2xkbW0tPm1tX2NvdW50KSA9PSAxKSkKKwkJY3VycmVudC0+dGFza19kb2luZ19mYXN0X2Zv
cmsgPSAxOworCisKIAlmbHVzaF9jYWNoZV9kdXBfbW0ob2xkbW0pOwogCXVwcm9iZV9kdXBf
bW1hcChvbGRtbSwgbW0pOwogCS8qCkBAIC03NzQsNiArNzgwLDcgQEAgbG9vcF9vdXQ6CiBv
dXQ6CiAJbW1hcF93cml0ZV91bmxvY2sobW0pOwogCWZsdXNoX3RsYl9tbShvbGRtbSk7CisJ
Y3VycmVudC0+dGFza19kb2luZ19mYXN0X2ZvcmsgPSAwOwogCW1tYXBfd3JpdGVfdW5sb2Nr
KG9sZG1tKTsKIAlkdXBfdXNlcmZhdWx0ZmRfY29tcGxldGUoJnVmKTsKIGZhaWxfdXByb2Jl
X2VuZDoKQEAgLTE1MjcsNiArMTUzNCw0NiBAQCBzdHJ1Y3QgZmlsZSAqZ2V0X3Rhc2tfZXhl
X2ZpbGUoc3RydWN0IHRhCiAJcmV0dXJuIGV4ZV9maWxlOwogfQogCisvKgorICogQSAiZmFz
dCBmb3JrKCkiIHRhc2sgbWlnaHQgYmUgdGFraW5nIHNob3J0Y3V0cyB0aGF0IG1ha2UKKyAq
IHRoZSBtbSdzIGFkZHJlc3Mgc3BhY2UgdW5zdGFibGUgZm9yIG11bHRpdGhyZWFkZWQgYWNj
ZXNzLgorICogVGhlIG1tIGNhbid0IGJlIGNvbnNpZGVyZWQgc3RhYmxlIHVudGlsIGhvbGRp
bmcKKyAqIG1tYXBfd3JpdGVfbG9jaygpIHRvIGVuc3VyZSB0aGF0IHRoZSBmb3JrKCkgaXMg
ZmluaXNoZWQuCisgKgorICogVGhpcyBmdW5jdGlvbiBpcyBhICJtYXliZSIgYmVjYXVzZSBp
dCBjYW4gInJldHVybiB0cnVlIgorICogZm9yIG1hbnkgcmVhc29ucyBvdGhlciB0aGFuIGFu
IG1tIHRoYXQgaXMgZG9pbmcgYSBmYXN0CisgKiBmb3JrLiAgQnV0IGl0IHNob3VsZCBiZSBy
aWdodCBlbm91Z2ggb2YgdGhlIHRpbWUgdG8ga2VlcAorICogY2FsbGVycyB1c2luZyB0aGVp
ciBmYXN0IHBhdGhzIHRoZSBtYWpvcml0eSBvZiB0aGUgdGltZS4KKyAqLworc3RhdGljIGJv
b2wgbW1fbWF5YmVfZmFzdF9mb3JrKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQoreworCS8qIEZh
c3QgZm9yaygpIHdvbid0IHN0YXJ0IGlmIC0+bW1fdXNlcnMgaXMgZWxldmF0ZWQgKi8KKwlp
ZiAoYXRvbWljX3JlYWQoJm1tLT5tbV91c2VycykgIT0gMSkKKwkJcmV0dXJuIGZhbHNlOwor
CisJLyoKKwkgKiBTb21lIHVzZXJzLCBsaWtlIHByb2NfbWVtX29wZXJhdGlvbnMgd2FudCB0
byBhdm9pZCBwaW5uaW5nCisJICogdGhlIGFkZHJlc3Mgc3BhY2Ugd2l0aCAtPm1tX3VzZXJz
LiAgVGhleSBpbnN0ZWFkIGVsZXZhdGUKKwkgKiAtPm1tX2NvdW50IGFuZCB0aGVuICh0ZW1w
b3JhcmlseSkgInVwZ3JhZGUiIHRoYXQgLT5tbV9jb3VudAorCSAqIHJlZiB0byBhbiAtPm1t
X3VzZXJzIHJlZiB3aXRoIG1tZ2V0X25vdF96ZXJvKCkuCisJICoKKwkgKiBDaGVjayBmb3Ig
LT5tbV9jb3VudD09MS4gIFRoaXMgZW5zdXJlcyB0aGF0IG5vIG9uZSB3aWxsCisJICogbGF0
ZXIgdXBncmFkZSB0aGF0IHJlZiB3aXRoIG1tZ2V0X25vdF96ZXJvKCkgYW5kIGFjY2Vzcwor
CSAqIHRoZSBwYWdlIHRhYmxlcyB3aXRob3V0IHRoZSAic2xvdyIgbW1hcF9sb2NrIHBhdGgu
CisJICovCisJaWYgKGF0b21pY19yZWFkKCZtbS0+bW1fY291bnQpICE9IDEpCisJCXJldHVy
biBmYWxzZTsKKworCS8qCisJICogQSB0YXNrIGNhbiBub3Qgbm90IGJlIGRvaW5nIGEgZm9y
aygpIGlmIHRoZSBsb2NrCisJICogaXMgbm90IGhlbGQuCisJICovCisJaWYgKCFyd3NlbV9p
c19sb2NrZWQoJm1tLT5tbWFwX2xvY2spKQorCQlyZXR1cm4gZmFsc2U7CisKKwlyZXR1cm4g
dHJ1ZTsKK30KKwogLyoqCiAgKiBnZXRfdGFza19tbSAtIGFjcXVpcmUgYSByZWZlcmVuY2Ug
dG8gdGhlIHRhc2sncyBtbQogICoKQEAgLTE1NDMsNiArMTU5MCw4IEBAIHN0cnVjdCBtbV9z
dHJ1Y3QgKmdldF90YXNrX21tKHN0cnVjdCB0YXMKIAl0YXNrX2xvY2sodGFzayk7CiAJbW0g
PSB0YXNrLT5tbTsKIAlpZiAobW0pIHsKKwkJaWYgKG1tX21heWJlX2Zhc3RfZm9yayhtbSkp
CisJCQlnb3RvIHNsb3c7CiAJCWlmICh0YXNrLT5mbGFncyAmIFBGX0tUSFJFQUQpCiAJCQlt
bSA9IE5VTEw7CiAJCWVsc2UKQEAgLTE1NTAsNiArMTU5OSwzMSBAQCBzdHJ1Y3QgbW1fc3Ry
dWN0ICpnZXRfdGFza19tbShzdHJ1Y3QgdGFzCiAJfQogCXRhc2tfdW5sb2NrKHRhc2spOwog
CXJldHVybiBtbTsKK3Nsb3c6IHsKKwlzdHJ1Y3QgbW1fc3RydWN0ICpyZXRfbW0gPSBtbTsK
KworCW1tZ3JhYihtbSk7CisJdGFza191bmxvY2sodGFzayk7CisKKwkvKgorCSAqIFRoYW5r
cyB0byB0aGUgbW1ncmFiKCksICdtbScgaXRzZWxmIGlzIG5vdyBzdGFibGUuCisJICogJ3Rh
c2snIG1pZ2h0IGV4aXQgYnV0IGNhbiBub3QgZnJlZSB0aGUgbW0uCisJICovCisKKwkvKiBJ
ZiBhIGZvcmsoKSB3YXMgaGFwcGVuaW5nLCB3YWl0IGZvciBpdCB0byBjb21wbGV0ZTogKi8K
KwltbWFwX3dyaXRlX2xvY2sobW0pOworCWlmICghbW1nZXRfbm90X3plcm8obW0pKSB7CisJ
CS8qCisJCSAqIFRoZSBtbSdzIGFkZHJlc3Mgc3BhY2UgaGFzIGdvbmUgYXdheS4gIFRlbGwK
KwkJICogdGhlIGNhbGxlciB0aGF0IHRoZSB0YXNrJ3MgbW0gd2FzIHVuYXZhaWxhYmxlOgor
CQkgKi8KKwkJcmV0X21tID0gTlVMTDsKKwl9CisJbW1hcF93cml0ZV91bmxvY2sobW0pOwor
CW1tZHJvcChtbSk7CisKKwlyZXR1cm4gcmV0X21tOworICAgICAgfQogfQogRVhQT1JUX1NZ
TUJPTF9HUEwoZ2V0X3Rhc2tfbW0pOwogCkBAIC0zNTYxLDMgKzM2MzUsMTAgQEAgaW50IHN5
c2N0bF9tYXhfdGhyZWFkcyhzdHJ1Y3QgY3RsX3RhYmxlCiAKIAlyZXR1cm4gMDsKIH0KKwor
Ym9vbCBjdXJyZW50X2RvaW5nX2Zhc3RfZm9yayh2b2lkKQoreworCVdBUk5fT04oY3VycmVu
dC0+dGFza19kb2luZ19mYXN0X2ZvcmsgJiYgKGF0b21pY19yZWFkKCZjdXJyZW50LT5tbS0+
bW1fdXNlcnMpID4gMSkpOworCXJldHVybiBjdXJyZW50LT50YXNrX2RvaW5nX2Zhc3RfZm9y
azsKK30KKwpkaWZmIC1wdU4gaW5jbHVkZS9saW51eC9zY2hlZC5ofmdldF90YXNrX21tLWxv
Y2tpbmcgaW5jbHVkZS9saW51eC9zY2hlZC5oCi0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQu
aH5nZXRfdGFza19tbS1sb2NraW5nCTIwMjMtMDUtMTUgMDk6MzI6NTcuMzkzNzIxOTYyIC0w
NzAwCisrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQuaAkyMDIzLTA1LTE1IDA5OjMzOjMxLjI0
MDU5OTQ5OSAtMDcwMApAQCAtNzYyLDYgKzc2Miw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCB7
CiAJLyogUGVyIHRhc2sgZmxhZ3MgKFBGXyopLCBkZWZpbmVkIGZ1cnRoZXIgYmVsb3c6ICov
CiAJdW5zaWduZWQgaW50CQkJZmxhZ3M7CiAJdW5zaWduZWQgaW50CQkJcHRyYWNlOworCWJv
b2wgdGFza19kb2luZ19mYXN0X2Zvcms7CiAKICNpZmRlZiBDT05GSUdfU01QCiAJaW50CQkJ
CW9uX2NwdTsKZGlmZiAtcHVOIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaH5nZXRf
dGFza19tbS1sb2NraW5nIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaAotLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmh+Z2V0X3Rhc2tfbW0tbG9ja2luZwkyMDIz
LTA1LTE1IDA5OjM2OjEzLjAzMDM2MTMxNiAtMDcwMAorKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wZ3RhYmxlLmgJMjAyMy0wNS0xNSAxMDoyNzo0NS4xMTI2NTI5NDAgLTA3MDAKQEAg
LTEwOTQsNyArMTA5NCwxMSBAQCBzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZXBfZ2V0X2FuZF9j
bGVhcl9mCiBzdGF0aWMgaW5saW5lIHZvaWQgcHRlcF9zZXRfd3Jwcm90ZWN0KHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tLAogCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgYWRkciwgcHRlX3QgKnB0
ZXApCiB7Ci0JY2xlYXJfYml0KF9QQUdFX0JJVF9SVywgKHVuc2lnbmVkIGxvbmcgKikmcHRl
cC0+cHRlKTsKKwlleHRlcm4gYm9vbCBjdXJyZW50X2RvaW5nX2Zhc3RfZm9yayh2b2lkKTsK
KwlpZiAoY3VycmVudF9kb2luZ19mYXN0X2ZvcmsoKSkKKwkJX19jbGVhcl9iaXQoX1BBR0Vf
QklUX1JXLCAodW5zaWduZWQgbG9uZyAqKSZwdGVwLT5wdGUpOworCWVsc2UKKwkJY2xlYXJf
Yml0KF9QQUdFX0JJVF9SVywgKHVuc2lnbmVkIGxvbmcgKikmcHRlcC0+cHRlKTsKIH0KIAog
I2RlZmluZSBmbHVzaF90bGJfZml4X3NwdXJpb3VzX2ZhdWx0KHZtYSwgYWRkcmVzcywgcHRl
cCkgZG8geyB9IHdoaWxlICgwKQpfCg==

--------------BePvJyiy0wMXwplpIRovCDid--
