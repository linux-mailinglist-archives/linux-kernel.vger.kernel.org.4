Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5D704664
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjEPH3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPH27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:28:59 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639F92;
        Tue, 16 May 2023 00:28:56 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1105:0:640:2966:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id DF8B85EF91;
        Tue, 16 May 2023 10:28:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nSV3CSKWqCg0-DhUBSVE8;
        Tue, 16 May 2023 10:28:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684222131;
        bh=mzpiRSZ/fD821DfRNirdZySh3p7mxT8AYjDytGYaqGs=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=Gn+W4NLL18CiY1O70uUUIl8L0XBIDM3PXSV/jR77TnX/mZcJp7rEUCKZCm4L0d0Cy
         6jZHupbS8YV2h/UF3LxpN7rjx4gLLHB7RCazGUDQlxnf9W/ocGxLyYvn+sw3pQ82Xo
         2cVCrOLszjDUIRUHTD0Lw/0hT+eBSnwk171e6IuI=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <680f2d5d146a38083a28198f1a8a3694654bf8f8.camel@maquefel.me>
Subject: Re: [PATCH 1/2] perf tools riscv: Allow get_cpuid return empty
 MARCH and MIMP
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Inochi Amaoto <inochiama@outlook.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 16 May 2023 13:28:50 +0300
In-Reply-To: <IA1PR20MB4953E8FFED81D5733DDFDA2DBB799@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20230516023714.306240-1-inochiama@outlook.com>
         <IA1PR20MB4953E8FFED81D5733DDFDA2DBB799@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSW5vY2hpIEFtYW90byEKCk9uIFR1ZSwgMjAyMy0wNS0xNiBhdCAxMDozNyArMDgwMCwg
SW5vY2hpIEFtYW90byB3cm90ZToKPiBUaGUgVC1IRUFEIEM5eHggc2VyaWVzIENQVSBvbmx5IGhh
cyBNVkVORE9SIGRlZmluZWQsIGFuZCBsZWZ0IE1BUkNICj4gYW5kIE1JTVAgdW5pbXBsZW1lbnRl
ZC4KCkFjY29yZGluZyB0byB0aGUgZG9jcyB5b3UgY2FuIHN0aWxsIHJlYWQgdGhlbSwgYnV0IGl0
J3MgaGFyZHdpcmVkIHRvCjY0aDAuCgpIb3cgaXQncyBzdXBwb3NlZCB0byBkaXN0aW5ndWlzaCBj
OTA2IGFuZCBjOTEwIGZvciBleGFtcGxlID8KCj4gCj4gVG8gbWFrZSBwZXJmIHN1cHBvcnQgVC1I
RUFEIEM5eHggZXZlbnRzLiByZW1vdmUgdGhlIHJlc3RyaWN0aW9uIG9mCj4gdGhlIE1BUkNIIGFu
ZCBNSU1QLgo+IAo+IFNpZ25lZC1vZmYtYnk6IElub2NoaSBBbWFvdG8gPGlub2NoaWFtYUBvdXRs
b29rLmNvbT4KPiAtLS0KPiDCoHRvb2xzL3BlcmYvYXJjaC9yaXNjdi91dGlsL2hlYWRlci5jIHwg
NyArLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDYgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvYXJjaC9yaXNjdi91dGlsL2hlYWRlci5j
Cj4gYi90b29scy9wZXJmL2FyY2gvcmlzY3YvdXRpbC9oZWFkZXIuYwo+IGluZGV4IDRhNDE4NTY5
MzhhOC4uMDMxODk5YzYyN2Y2IDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3BlcmYvYXJjaC9yaXNjdi91
dGlsL2hlYWRlci5jCj4gKysrIGIvdG9vbHMvcGVyZi9hcmNoL3Jpc2N2L3V0aWwvaGVhZGVyLmMK
PiBAQCAtNTUsMTggKzU1LDEzIEBAIHN0YXRpYyBjaGFyICpfZ2V0X2NwdWlkKHZvaWQpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gZnJlZTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSBp
ZiAoIXN0cm5jbXAobGluZSwgQ1BVSU5GT19NQVJDSCwKPiBzdHJsZW4oQ1BVSU5GT19NQVJDSCkp
KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWFy
Y2hpZCA9IF9nZXRfZmllbGQobGluZSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1hcmNoaWQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmcmVlOwo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIGlmICghc3RybmNtcChsaW5lLCBDUFVJ
TkZPX01JTVAsCj4gc3RybGVuKENQVUlORk9fTUlNUCkpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWltcGlkID0gX2dldF9maWVsZChsaW5lKTsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghbWlt
cGlkKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdvdG8gZnJlZTsKPiAtCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoH0KCldoYXQgZG9lcyAvcHJvYy9jcHVpbmZvIHNob3dz
IG9uIGM5eHggPyBXaHkgY2FuJ3Qgd2UgdXNlIHplcm9lcyA/Cgo+IMKgCj4gLcKgwqDCoMKgwqDC
oMKgaWYgKCFtdmVuZG9yaWQgfHwgIW1hcmNoaWQgfHwgIW1pbXBpZCkKPiArwqDCoMKgwqDCoMKg
wqBpZiAoIW12ZW5kb3JpZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8g
ZnJlZTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoYXNwcmludGYoJmNwdWlkLCAiJXMtJXMt
JXMiLCBtdmVuZG9yaWQsIG1hcmNoaWQsIG1pbXBpZCkKPiA8IDApCgo=

