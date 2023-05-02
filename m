Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF856F4784
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjEBPmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEBPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:42:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B521A6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683042170; x=1714578170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=s53ckWSCPCD27YqdcQdt7WZr3VrH45zL/WyjwkVkJsY=;
  b=ZzTEapToq4Xf83IU6V++A/408o2XaF2DxQP5Sdy5pHs/NCjxvlCwa3Vk
   ibggqqq/XsCTNxfyBIMkNYWlSM4CrNr02ATIHcH6510O1XxDaMcjpAs9E
   C3GhYUHOnlRetGOvXIB2S9Is3oW3E9FvRVj2oCx1mYJX6Zoo6ejFBk1UI
   bI933bHOy6/dtFDvGzY8v1R7Y4PH+wYctbU+XgM63eJeh4/JSnhrBjiyk
   Tl/l9WfVMIynjkoLY7kxO4Wni5JdOXnWXoG3kQV8fSx82LlZuWdNb/QU0
   GGHVDgHKJEvhk0rZI0v6bNsQgF1UtB5PmsjypWV/w8Ukx9RPwRP6YIkWz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="413891000"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="413891000"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 08:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="673700928"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="673700928"
Received: from vsanka-mobl.amr.corp.intel.com (HELO [10.212.168.155]) ([10.212.168.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 08:42:49 -0700
Content-Type: multipart/mixed; boundary="------------Ze0LFxpBo0szqDF8dkE4MQ9Q"
Message-ID: <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
Date:   Tue, 2 May 2023 08:42:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/mm for 6.4
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230429003822.n3mglslg666j3npp@box.shutemov.name>
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Ze0LFxpBo0szqDF8dkE4MQ9Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/23 17:38, Kirill A. Shutemov wrote:
> BTW, I think the static check can be relaxed. Checking size against
> PAGE_SIZE is rather conservative: there's 8 TB (or 4 PB for 5-level
> paging) guard hole at the begging of kernel address space.

Whatever we relax it to, let's make sure we get a note in
Documentation/x86/x86_64/mm.rst.  But that's totally minor and we can
fix it up later.

Have anyone seen any actual code generation difference between:

	return (long)ptr >= 0;

and

        return !((unsigned long)ptr & (1UL<<(BITS_PER_LONG-1)));

?  I'm seeing gcc generate the same code for both the <=PAGE_SIZE side
and the 'sum' side.

It's longer, but I'd rather read the explicit "check bit 63" than the
positive/negative address space thing.  I certainly grok both, but have
to think through the "(long)ptr >= 0" check every time.

I guess it also wouldn't matter as much either if we hid it in a helper
like the attached patch and I didn't have to read it twice. ;)
--------------Ze0LFxpBo0szqDF8dkE4MQ9Q
Content-Type: text/x-patch; charset=UTF-8; name="ptr_in_user_half.patch"
Content-Disposition: attachment; filename="ptr_in_user_half.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaAppbmRleCAxMjMxMzVkNjBmNzIuLjdiYjExZDVhN2Y4
ZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtNzcsMTUgKzc3LDI4IEBAIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfX3VudGFnZ2VkX2FkZHJfcmVtb3RlKHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tLAogCiAjaWZkZWYgQ09ORklHX1g4Nl82NAogLyoKLSAqIE9uIHg4Ni02
NCwgd2UgbWF5IGhhdmUgdGFnIGJpdHMgaW4gdGhlIHVzZXIgcG9pbnRlci4gUmF0aGVyIHRo
YW4KLSAqIG1hc2sgdGhlbSBvZmYsIGp1c3QgY2hhbmdlIHRoZSBydWxlcyBmb3IgX19hY2Nl
c3Nfb2soKS4KKyAqIFRoZSB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2Ugc3BhY2UgaXMgbG9naWNh
bGx5IGRpdmlkZWQgaW50byBhIGtlcm5lbAorICogaGFsZiBhbmQgYSB1c2VyIGhhbGYuICBX
aGVuIGNhc3QgdG8gYSBzaWduZWQgdHlwZSwgdXNlciBwb2ludGVycworICogYXJlIHBvc2l0
aXZlIGFuZCBrZXJuZWwgcG9pbnRlcnMgYXJlIG5lZ2F0aXZlLgorICovCitzdGF0aWMgaW5s
aW5lIGJvb2wgcHRyX2luX3VzZXJfaGFsZih2b2lkICpwdHIpCit7CisJcmV0dXJuIChsb25n
KXB0ciA+PSAwOworfQorCisvKgorICogVXNlciBwb2ludGVycyBjYW4gaGF2ZSB0YWcgYml0
cyBvbiB4ODYtNjQuICBUaGlzIHNjaGVtZSB0b2xlcmF0ZXMKKyAqIGFyYml0cmFyeSB2YWx1
ZXMgaW4gdGhvc2UgYml0cyByYXRoZXIgbWFza2luZyB0aGVtIG9mZi4KKyAqCisgKiBFbmZv
cmNlIHR3byBydWxlczoKKyAqIDEuICdwdHInIG11c3QgYmUgaW4gdGhlIHVzZXIgaGFsZiBv
ZiB0aGUgYWRkcmVzcyBzcGFjZQorICogMi4gJ3B0citzaXplJyBtdXN0IG5vdCBvdmVyZmxv
dyAoYmFjayBpbnRvIHRoZSBrZXJuZWwgaGFsZikKICAqCi0gKiBNYWtlIHRoZSBydWxlIGJl
IHRoYXQgJ3B0citzaXplJyBtdXN0IG5vdCBvdmVyZmxvdywgYW5kIG11c3Qgbm90Ci0gKiBo
YXZlIHRoZSBoaWdoIGJpdCBzZXQuIENvbXBpbGVycyBnZW5lcmFsbHkgdW5kZXJzdGFuZCBh
Ym91dAotICogdW5zaWduZWQgb3ZlcmZsb3cgYW5kIHRoZSBDRiBiaXQgYW5kIGdlbmVyYXRl
IHJlYXNvbmFibGUgY29kZSBmb3IKLSAqIHRoaXMuIEFsdGhvdWdoIGl0IGxvb2tzIGxpa2Ug
dGhlIGNvbWJpbmF0aW9uIGNvbmZ1c2VzIGF0IGxlYXN0Ci0gKiBjbGFuZyAoYW5kIGluc3Rl
YWQgb2YganVzdCBkb2luZyBhbiAiYWRkIiBmb2xsb3dlZCBieSBhIHRlc3Qgb2YKLSAqIFNG
IGFuZCBDRiwgeW91J2xsIHNlZSB0aGF0IHVubmVjZXNzYXJ5IGNvbXBhcmlzb24pLgorICog
Q29tcGlsZXJzIGdlbmVyYWxseSB1bmRlcnN0YW5kIGFib3V0ICB1bnNpZ25lZCBvdmVyZmxv
dyBhbmQgdGhlIENGCisgKiBiaXQgYW5kIGdlbmVyYXRlIHJlYXNvbmFibGUgY29kZSBmb3Ig
dGhpcy4gQWx0aG91Z2ggaXQgbG9va3MgbGlrZQorICogdGhlIGNvbWJpbmF0aW9uIGNvbmZ1
c2VzIGF0IGxlYXN0IGNsYW5nIChhbmQgaW5zdGVhZCBvZiBqdXN0IGRvaW5nCisgKiBhbiAi
YWRkIiBmb2xsb3dlZCBieSBhIHRlc3Qgb2YgU0YgYW5kIENGLCB5b3UnbGwgc2VlIHRoYXQK
KyAqIHVubmVjZXNzYXJ5IGNvbXBhcmlzb24pLgogICoKICAqIEZvciB0aGUgY29tbW9uIGNh
c2Ugb2Ygc21hbGwgc2l6ZXMgdGhhdCBjYW4gYmUgY2hlY2tlZCBhdCBjb21waWxlCiAgKiB0
aW1lLCBkb24ndCBldmVuIGJvdGhlciB3aXRoIHRoZSBhZGRpdGlvbiwgYW5kIGp1c3QgY2hl
Y2sgdGhhdCB0aGUKQEAgLTkzLDExICsxMDYsMTYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIF9fdW50YWdnZWRfYWRkcl9yZW1vdGUoc3RydWN0IG1tX3N0cnVjdCAqbW0sCiAg
Ki8KIHN0YXRpYyBpbmxpbmUgYm9vbCBfX2FjY2Vzc19vayhjb25zdCB2b2lkIF9fdXNlciAq
cHRyLCB1bnNpZ25lZCBsb25nIHNpemUpCiB7CisJLyoKKwkgKiBDaGVjayBvbmx5IHRoZSBw
b2ludGVyIChub3QgcHRyK3NpemUpIGZvciBzbWFsbCBhY2Nlc3Nlcy4KKwkgKiBUaGlzIGlz
IE9LIGJlY2F1c2UgdGhlIGtlcm5lbCBhZGRyZXNzIHNwYWNlIGJlZ2lucyB3aXRoIGEKKwkg
KiA+PVBBR0VfU0laRSBndWFyZCBob2xlLgorCSAqLwogCWlmIChfX2J1aWx0aW5fY29uc3Rh
bnRfcChzaXplIDw9IFBBR0VfU0laRSkgJiYgc2l6ZSA8PSBQQUdFX1NJWkUpIHsKLQkJcmV0
dXJuIChsb25nKXB0ciA+PSAwOworCQlyZXR1cm4gcHRyX2luX3VzZXJfaGFsZihwdHIpOwog
CX0gZWxzZSB7CiAJCXVuc2lnbmVkIGxvbmcgc3VtID0gc2l6ZSArICh1bnNpZ25lZCBsb25n
KXB0cjsKLQkJcmV0dXJuIChsb25nKSBzdW0gPj0gMCAmJiBzdW0gPj0gKHVuc2lnbmVkIGxv
bmcpcHRyOworCQlyZXR1cm4gcHRyX2luX3VzZXJfaGFsZihwdHIpICYmIHN1bSA+PSAodW5z
aWduZWQgbG9uZylwdHI7CiAJfQogfQogI2RlZmluZSBfX2FjY2Vzc19vayBfX2FjY2Vzc19v
awo=

--------------Ze0LFxpBo0szqDF8dkE4MQ9Q--
