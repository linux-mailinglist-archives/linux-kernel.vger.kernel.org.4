Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0876A1A87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBXKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBXKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:44:28 -0500
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DB5BBA8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1677235437;
        bh=mOMOVF2iJgJR2obOieRkRdSF9pKgncWHGSHN+UgxW64=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FsiEuNmKyogza/4nI1R66rJ75uhZZirj2+zK24xqUVLyyUWYAC8yxY7/Pu1kdqu4F
         cqylnQ7R4Pldh5LQqqPB3H8sYiVFAyTTV37TuHNgRdh10qCUXs7zuJF32a7TeM2jwu
         BV3DG42vKLqGwDpGROT4gUL3BhMTOl+m+6/+ExX4=
Received: from [IPv6:2408:8471:1116:556a:af80:d15d:41f2:3e09] (unknown [IPv6:2408:8471:1116:556a:af80:d15d:41f2:3e09])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 6AA6765DC8;
        Fri, 24 Feb 2023 05:43:49 -0500 (EST)
Message-ID: <cc9fe98d7e157c3e4bdf82d92e9ea368b894ce00.camel@xry111.site>
Subject: Re: [PATCH 6/6] LoongArch: Clean up la_abs macro
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Feb 2023 18:43:33 +0800
In-Reply-To: <20230224101013.26971-7-hejinyang@loongson.cn>
References: <20230224101013.26971-1-hejinyang@loongson.cn>
         <20230224101013.26971-7-hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTI0IGF0IDE4OjEwICswODAwLCBKaW55YW5nIEhlIHdyb3RlOgoKLyog
c25pcCAqLwoKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gva2VybmVsL2VudHJ5LlMKPiBi
L2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9lbnRyeS5TCj4gaW5kZXggY2E0NjUxZjkxZTczLi40ZGU2
YjMxZGMzYmYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9sb29uZ2FyY2gva2VybmVsL2VudHJ5LlMKPiAr
KysgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvZW50cnkuUwoKLyogc25pcCAqLwoKPiBAQCAtNjUs
NyArNjUsNyBAQCBTWU1fRlVOQ19TVEFSVChoYW5kbGVfc3lzKQo+IMKgwqDCoMKgwqDCoMKgwqBh
bmTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRwLCB0cCwgc3AKPiDCoAo+IMKgwqDCoMKgwqDC
oMKgwqBtb3ZlwqDCoMKgwqBhMCwgc3AKPiAtwqDCoMKgwqDCoMKgwqBsYV9hYnPCoMKgcmEsIGRv
X3N5c2NhbGwKPiArwqDCoMKgwqDCoMKgwqBsYS5wY3JlbMKgwqDCoMKgwqDCoMKgwqByYSwgZG9f
c3lzY2FsbAo+IMKgwqDCoMKgwqDCoMKgwqBqaXJswqDCoMKgwqByYSwgcmEsIDAKCmJsCWRvX3N5
c2NhbGwKCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgUkVTVE9SRV9BTExfQU5EX1JFVAo+IGRpZmYg
LS1naXQgYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvZ2VuZXguUwo+IGIvYXJjaC9sb29uZ2FyY2gv
a2VybmVsL2dlbmV4LlMKPiBpbmRleCA4NzA1YTc2NjFjZTkuLmI2YTc0MjQ2ZDFjNCAxMDA2NDQK
PiAtLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvZ2VuZXguUwo+ICsrKyBiL2FyY2gvbG9vbmdh
cmNoL2tlcm5lbC9nZW5leC5TCgovKiBzbmlwICovCgo+IEBAIC00NSw3ICs0NSw3IEBAIFNZTV9G
VU5DX1NUQVJUKGhhbmRsZV92aW50XGlkeCkKPiDCoMKgwqDCoMKgwqDCoMKgTE9OR19TwqDCoHQw
LCBzcCwgUFRfRVJBCj4gwqAxOsKgwqDCoMKgwqBtb3ZlwqDCoMKgwqBhMCwgc3AKPiDCoMKgwqDC
oMKgwqDCoMKgbW92ZcKgwqDCoMKgYTEsIHNwCj4gLcKgwqDCoMKgwqDCoMKgbGFfYWJzwqDCoHQw
LCBkb192aW50Cj4gK8KgwqDCoMKgwqDCoMKgbGEucGNyZWzCoMKgwqDCoMKgwqDCoMKgdDAsIGRv
X3ZpbnQKPiDCoMKgwqDCoMKgwqDCoMKgamlybMKgwqDCoMKgcmEsIHQwLCAwCgpibAlkb192aW50
Cgo+IMKgwqDCoMKgwqDCoMKgwqBSRVNUT1JFX0FMTF9BTkRfUkVUCj4gwqBTWU1fRlVOQ19FTkQo
aGFuZGxlX3ZpbnRcaWR4KQo+IEBAIC03Niw3ICs3Niw3IEBAIFNZTV9GVU5DX1NUQVJUKGhhbmRs
ZV9cZXhjZXB0aW9uKQo+IMKgwqDCoMKgwqDCoMKgwqBTQVZFX0FMTAo+IMKgwqDCoMKgwqDCoMKg
wqBidWlsZF9wcmVwX1xwcmVwCj4gwqDCoMKgwqDCoMKgwqDCoG1vdmXCoMKgwqDCoGEwLCBzcAo+
IC3CoMKgwqDCoMKgwqDCoGxhX2Fic8KgwqB0MCwgZG9fXGhhbmRsZXIKPiArwqDCoMKgwqDCoMKg
wqBsYS5wY3JlbMKgwqDCoMKgwqDCoMKgwqB0MCwgZG9fXGhhbmRsZXIKPiDCoMKgwqDCoMKgwqDC
oMKgamlybMKgwqDCoMKgcmEsIHQwLCAwCgpibAlkb19caGFuZGxlcgoKLyogc25pcCAqLwoKPiBk
aWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvbW0vdGxiZXguUyBiL2FyY2gvbG9vbmdhcmNoL21t
L3RsYmV4LlMKPiBpbmRleCA1MzMyMWQzNDQ3YTIuLjE5NmQ5YmM4NzBjNSAxMDA2NDQKPiAtLS0g
YS9hcmNoL2xvb25nYXJjaC9tbS90bGJleC5TCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvbW0vdGxi
ZXguUwo+IEBAIC00MSw3ICs0MSw3IEBAIFNZTV9GVU5DX1NUQVJUKGhhbmRsZV90bGJfcHJvdGVj
dFxpZHgpCj4gwqDCoMKgwqDCoMKgwqDCoG1vdmXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhMSwg
emVybwo+IMKgwqDCoMKgwqDCoMKgwqBjc3JyZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhMiwgTE9P
TkdBUkNIX0NTUl9CQURWCj4gwqDCoMKgwqDCoMKgwqDCoFJFR19TwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGEyLCBzcCwgUFRfQlZBRERSCj4gLcKgwqDCoMKgwqDCoMKgbGFfYWJzwqDCoMKgwqDCoMKg
wqDCoMKgwqB0MCwgZG9fcGFnZV9mYXVsdAo+ICvCoMKgwqDCoMKgwqDCoGxhLnBjcmVswqDCoMKg
wqDCoMKgwqDCoHQwLCBkb19wYWdlX2ZhdWx0Cj4gwqDCoMKgwqDCoMKgwqDCoGppcmzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByYSwgdDAsIDAKCmJsCWRvX3BhZ2VfZmF1bHQKCi8qIHNuaXAgKi8K
Cj4gQEAgLTE5MCw3ICsxOTAsNyBAQCBTWU1fRlVOQ19TVEFSVChoYW5kbGVfdGxiX2xvYWRcaWR4
KQo+IMKgNTogLyogbm9wYWdlX3RsYl9sb2FkOiAqLwo+IMKgwqDCoMKgwqDCoMKgwqBkYmFywqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgMAo+IMKgwqDCoMKgwqDCoMKgwqBjc3JyZMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByYSwgRVhDRVBUSU9OX0tTMgo+IC3CoMKgwqDCoMKgwqDCoGxhX2Fic8KgwqDC
oMKgwqDCoMKgwqDCoMKgdDAsIHRsYl9kb19wYWdlX2ZhdWx0XzAKPiArwqDCoMKgwqDCoMKgwqBs
YS5wY3JlbMKgwqDCoMKgwqDCoMKgwqB0MCwgdGxiX2RvX3BhZ2VfZmF1bHRfMAo+IMKgwqDCoMKg
wqDCoMKgwqBqcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0MAoKYgl0bGJfZG9fcGFnZV9m
YXVsdF8wCgovKiBzbmlwICovCgo+IEBAIC0zNDEsNyArMzQxLDcgQEAgdGxiX2h1Z2VfdXBkYXRl
X3N0b3JlOgo+IMKgbm9wYWdlX3RsYl9zdG9yZToKPiDCoMKgwqDCoMKgwqDCoMKgZGJhcsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDAKPiDCoMKgwqDCoMKgwqDCoMKgY3NycmTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmEsIEVYQ0VQVElPTl9LUzIKPiAtwqDCoMKgwqDCoMKgwqBsYV9hYnPCoMKgwqDC
oMKgwqDCoMKgwqDCoHQwLCB0bGJfZG9fcGFnZV9mYXVsdF8xCj4gK8KgwqDCoMKgwqDCoMKgbGEu
cGNyZWzCoMKgwqDCoMKgwqDCoMKgdDAsIHRsYl9kb19wYWdlX2ZhdWx0XzEKPiDCoMKgwqDCoMKg
wqDCoMKganLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdDAKCmIJdGxiX2RvX3BhZ2VfZmF1
bHRfMQoKLyogc25pcCAqLwoKPiBAQCAtNDkwLDcgKzQ5MCw3IEBAIHRsYl9odWdlX3VwZGF0ZV9t
b2RpZnk6Cj4gwqBub3BhZ2VfdGxiX21vZGlmeToKPiDCoMKgwqDCoMKgwqDCoMKgZGJhcsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDAKPiDCoMKgwqDCoMKgwqDCoMKgY3NycmTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmEsIEVYQ0VQVElPTl9LUzIKPiAtwqDCoMKgwqDCoMKgwqBsYV9hYnPCoMKgwqDC
oMKgwqDCoMKgwqDCoHQwLCB0bGJfZG9fcGFnZV9mYXVsdF8xCj4gK8KgwqDCoMKgwqDCoMKgbGEu
cGNyZWzCoMKgwqDCoMKgwqDCoMKgdDAsIHRsYl9kb19wYWdlX2ZhdWx0XzEKPiDCoMKgwqDCoMKg
wqDCoMKganLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdDAKCmIJdGxiX2RvX3BhZ2VfZmF1
bHRfMQoKPiDCoFNZTV9GVU5DX0VORChoYW5kbGVfdGxiX21vZGlmeSkKPiDCoMKgwqDCoMKgwqDC
oMKgLmVuZG0KCi0tIApYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFl
cm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQo=

