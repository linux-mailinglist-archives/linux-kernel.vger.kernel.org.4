Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F26F6EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEDP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:26:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3BE44A6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683213985; x=1714749985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=7Q2Gf+jbc6SEfpvp/N5D7QV+hnjSBlmhXbGpWu4Bm3w=;
  b=TfASItqqgkdlVbnwQgeK5GF2YDJYuVt5OJ5sKeNVlT+K+0XzWxnN+igk
   sUCs7+jQDI4YYg4RPAmjj/Da1ajkZbSG06mABummFlxDHlEuaujD3tmVl
   FNOVDzHT8A6r/k8K1ELXsVink70jbn6siGlUlAAYb7Q1vOrbCyb6K7+nq
   pNGGgQEa2CLGY9GTKTOL4eY18YiDWxkVhK8cZ7gE0/qzfrn81gqu78N/y
   0+iFd0BXQuLERorXO9MN4ONJPz+s3E4xW1exsUG0SRVD3vQ6EzpTS8lb7
   p0mJCaH47YdIkrToq0xunzMY5F3bswcjtvPclzZxnHDvPzSZclzHVCNRe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414458500"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="414458500"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 08:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="761973393"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="761973393"
Received: from khaunx-mobl.ger.corp.intel.com (HELO [10.251.217.147]) ([10.251.217.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 08:26:02 -0700
Content-Type: multipart/mixed; boundary="------------xG0eQnVSzAK0EufcJrcff4O4"
Message-ID: <1ea18c96-162f-a606-f37b-aaa1bfb2443c@intel.com>
Date:   Thu, 4 May 2023 08:25:58 -0700
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
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
 <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
 <20230504062827.algltnmlddtzmfz5@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230504062827.algltnmlddtzmfz5@box.shutemov.name>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------xG0eQnVSzAK0EufcJrcff4O4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/23 23:28, Kirill A. Shutemov wrote:
>> Untagging a kernel address will "corrupt" it, but it will stay a
>> kernel address (well, it will stay a "high bit set" address), which is
>> all we care about anyway.
> The interesting case to consider is untagging kernel pointer when LAM_U48
> is enabled (not part of current LAM enabling). LAM_U48 would make the
> untagging mask wider -- ~GENMASK(62, 48). With 5-level paging and LAM_SUP
> enabled (also not supported yet) untagging kernel may transform it to
> other valid kernel pointer.
> 
> So we cannot rely on #GP as backstop here. The kernel has to exclude
> kernel pointer by other means. It can be fun to debug.

Yeah, I have the feeling that we're really going to need a pair of
untagging functions once we get to doing kernel LAM for a _bunch_ of
reasons.

Just as a practical matter, I think we should OR bits into the mask on
the kernel side, effectively:

unsigned long untag_kernel_addr(unsigned long addr)
{
	return addr | kernel_untag_mask;
}

and kernel_untag_mask should have bit 63 *clear*.

That way the pointers that have gone through untagging won't look silly.
 If you untag VMALLOC_END or something, it'll still look like the
addresses we have in mm.rst.

Also, it'll be impossible to have the mask turn a userspace address into
a kernel one.

Last, we can add some debugging in there, probably conditional on some
mm debugging options like:

	if (WARN_ON_ONCE(!valid_user_address(addr)))
		return 0;

It's kinda like "void __user *" versus "void *".  The __user ones can
*absolutely* point anywhere, user or kernel.  That's why we can't WARN()
in the untagged_addr() function that takes user pointers.

But "void *" can only point to the kernel.  It has totally different rules.

We should probably also do something like the attached patch sooner
rather than later.  'untag_mask' really is a misleading name for a mask
that gets applied only to user addresses.
--------------xG0eQnVSzAK0EufcJrcff4O4
Content-Type: text/x-patch; charset=UTF-8; name="lam.patch"
Content-Disposition: attachment; filename="lam.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21tdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vbW11LmgKaW5kZXggMGRhNWMyMjdmNDkwLi5hZGVlNzBlZTM5OGMgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21tdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL21tdS5oCkBAIC01MSw3ICs1MSw3IEBAIHR5cGVkZWYgc3RydWN0IHsKIAl1bnNp
Z25lZCBsb25nIGxhbV9jcjNfbWFzazsKIAogCS8qIFNpZ25pZmljYW50IGJpdHMgb2YgdGhl
IHZpcnR1YWwgYWRkcmVzcy4gRXhjbHVkZXMgdGFnIGJpdHMuICovCi0JdTY0IHVudGFnX21h
c2s7CisJdTY0IHVzZXJfdW50YWdfbWFzazsKICNlbmRpZgogCiAJc3RydWN0IG11dGV4IGxv
Y2s7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaAppbmRleCAxZDI5ZGM3OTFmNWEu
LmI0YmI0YjFhMzZlNCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2Nv
bnRleHQuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oCkBAIC05
NCwxOCArOTQsMTggQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG1tX2xhbV9jcjNf
bWFzayhzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIHN0YXRpYyBpbmxpbmUgdm9pZCBkdXBfbGFt
KHN0cnVjdCBtbV9zdHJ1Y3QgKm9sZG1tLCBzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIHsKIAlt
bS0+Y29udGV4dC5sYW1fY3IzX21hc2sgPSBvbGRtbS0+Y29udGV4dC5sYW1fY3IzX21hc2s7
Ci0JbW0tPmNvbnRleHQudW50YWdfbWFzayA9IG9sZG1tLT5jb250ZXh0LnVudGFnX21hc2s7
CisJbW0tPmNvbnRleHQudXNlcl91bnRhZ19tYXNrID0gb2xkbW0tPmNvbnRleHQudXNlcl91
bnRhZ19tYXNrOwogfQogCiAjZGVmaW5lIG1tX3VudGFnX21hc2sgbW1fdW50YWdfbWFzawog
c3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG1tX3VudGFnX21hc2soc3RydWN0IG1tX3N0
cnVjdCAqbW0pCiB7Ci0JcmV0dXJuIG1tLT5jb250ZXh0LnVudGFnX21hc2s7CisJcmV0dXJu
IG1tLT5jb250ZXh0LnVzZXJfdW50YWdfbWFzazsKIH0KIAogc3RhdGljIGlubGluZSB2b2lk
IG1tX3Jlc2V0X3VudGFnX21hc2soc3RydWN0IG1tX3N0cnVjdCAqbW0pCiB7Ci0JbW0tPmNv
bnRleHQudW50YWdfbWFzayA9IC0xVUw7CisJbW0tPmNvbnRleHQudXNlcl91bnRhZ19tYXNr
ID0gLTFVTDsKIH0KIAogI2RlZmluZSBhcmNoX3BndGFibGVfZG1hX2NvbXBhdCBhcmNoX3Bn
dGFibGVfZG1hX2NvbXBhdApkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxi
Zmx1c2guaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgKaW5kZXggNzViZmFh
NDIxMDMwLi45ZmM2YTJhYzUzMTggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3RsYmZsdXNoLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiZmx1c2guaApAQCAt
NTUsMTEgKzU1LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcjRfY2xlYXJfYml0cyh1bnNp
Z25lZCBsb25nIG1hc2spCiB9CiAKICNpZmRlZiBDT05GSUdfQUREUkVTU19NQVNLSU5HCi1E
RUNMQVJFX1BFUl9DUFUodTY0LCB0bGJzdGF0ZV91bnRhZ19tYXNrKTsKK0RFQ0xBUkVfUEVS
X0NQVSh1NjQsIHRsYnN0YXRlX3VzZXJfdW50YWdfbWFzayk7CiAKLXN0YXRpYyBpbmxpbmUg
dTY0IGN1cnJlbnRfdW50YWdfbWFzayh2b2lkKQorc3RhdGljIGlubGluZSB1NjQgY3VycmVu
dF91c2VyX3VudGFnX21hc2sodm9pZCkKIHsKLQlyZXR1cm4gdGhpc19jcHVfcmVhZCh0bGJz
dGF0ZV91bnRhZ19tYXNrKTsKKwlyZXR1cm4gdGhpc19jcHVfcmVhZCh0bGJzdGF0ZV91c2Vy
X3VudGFnX21hc2spOwogfQogI2VuZGlmCiAKQEAgLTM4OSw3ICszODksNyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgc2V0X3RsYnN0YXRlX2xhbV9tb2RlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1t
KQogewogCXRoaXNfY3B1X3dyaXRlKGNwdV90bGJzdGF0ZS5sYW0sCiAJCSAgICAgICBtbS0+
Y29udGV4dC5sYW1fY3IzX21hc2sgPj4gWDg2X0NSM19MQU1fVTU3X0JJVCk7Ci0JdGhpc19j
cHVfd3JpdGUodGxic3RhdGVfdW50YWdfbWFzaywgbW0tPmNvbnRleHQudW50YWdfbWFzayk7
CisJdGhpc19jcHVfd3JpdGUodGxic3RhdGVfdXNlcl91bnRhZ19tYXNrLCBtbS0+Y29udGV4
dC51c2VyX3VudGFnX21hc2spOwogfQogCiAjZWxzZQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vdWFjY2Vzcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5o
CmluZGV4IDEyMzEzNWQ2MGY3Mi4uMDQ0ZDgyZTk4YjI3IDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFj
Y2Vzcy5oCkBAIC0zNiwxNiArMzYsMTYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25n
IF9fdW50YWdnZWRfYWRkcih1bnNpZ25lZCBsb25nIGFkZHIpCiAJbG9uZyBzaWduOwogCiAJ
LyoKLQkgKiBSZWZlciB0bGJzdGF0ZV91bnRhZ19tYXNrIGRpcmVjdGx5IHRvIGF2b2lkIFJJ
UC1yZWxhdGl2ZSByZWxvY2F0aW9uCi0JICogaW4gYWx0ZXJuYXRpdmUgaW5zdHJ1Y3Rpb25z
LiBUaGUgcmVsb2NhdGlvbiBnZXRzIHdyb25nIHdoZW4gZ2V0cwotCSAqIGNvcGllZCB0byB0
aGUgdGFyZ2V0IHBsYWNlLgorCSAqIFJlZmVyIHRsYnN0YXRlX3VzZXJfdW50YWdfbWFzayBk
aXJlY3RseSB0byBhdm9pZCBSSVAtcmVsYXRpdmUKKwkgKiByZWxvY2F0aW9uIGluIGFsdGVy
bmF0aXZlIGluc3RydWN0aW9ucy4gVGhlIHJlbG9jYXRpb24gZ2V0cyB3cm9uZyB3aGVuCisJ
ICogZ2V0cyBjb3BpZWQgdG8gdGhlIHRhcmdldCBwbGFjZS4KIAkgKi8KIAlhc20gKEFMVEVS
TkFUSVZFKCIiLAogCQkJICJzYXIgJDYzLCAlW3NpZ25dXG5cdCIgLyogdXNlcl9wdHIgPyAw
IDogLTFVTCAqLwotCQkJICJvciAlJWdzOnRsYnN0YXRlX3VudGFnX21hc2ssICVbc2lnbl1c
blx0IgorCQkJICJvciAlJWdzOnRsYnN0YXRlX3VzZXJfdW50YWdfbWFzaywgJVtzaWduXVxu
XHQiCiAJCQkgImFuZCAlW3NpZ25dLCAlW2FkZHJdXG5cdCIsIFg4Nl9GRUFUVVJFX0xBTSkK
IAkgICAgIDogW2FkZHJdICIrciIgKGFkZHIpLCBbc2lnbl0gIj1yIiAoc2lnbikKLQkgICAg
IDogIm0iICh0bGJzdGF0ZV91bnRhZ19tYXNrKSwgIltzaWduXSIgKGFkZHIpKTsKKwkgICAg
IDogIm0iICh0bGJzdGF0ZV91c2VyX3VudGFnX21hc2spLCAiW3NpZ25dIiAoYWRkcikpOwog
CiAJcmV0dXJuIGFkZHI7CiB9CkBAIC01NSwyMCArNTUsMjAgQEAgc3RhdGljIGlubGluZSB1
bnNpZ25lZCBsb25nIF9fdW50YWdnZWRfYWRkcih1bnNpZ25lZCBsb25nIGFkZHIpCiAJKF9f
Zm9yY2UgX190eXBlb2ZfXyhhZGRyKSlfX3VudGFnZ2VkX2FkZHIoX19hZGRyKTsJCVwKIH0p
CiAKLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfX3VudGFnZ2VkX2FkZHJfcmVtb3Rl
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAotCQkJCQkJICAgdW5zaWduZWQgbG9uZyBhZGRyKQor
c3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIF9fdW50YWdfcmVtb3RlX3VzZXJfYWRkcihz
dHJ1Y3QgbW1fc3RydWN0ICptbSwKKwkJCQkJCSAgICAgdW5zaWduZWQgbG9uZyBhZGRyKQog
ewogCWxvbmcgc2lnbiA9IGFkZHIgPj4gNjM7CiAKIAltbWFwX2Fzc2VydF9sb2NrZWQobW0p
OwotCWFkZHIgJj0gKG1tKS0+Y29udGV4dC51bnRhZ19tYXNrIHwgc2lnbjsKKwlhZGRyICY9
IChtbSktPmNvbnRleHQudXNlcl91bnRhZ19tYXNrIHwgc2lnbjsKIAogCXJldHVybiBhZGRy
OwogfQogCi0jZGVmaW5lIHVudGFnZ2VkX2FkZHJfcmVtb3RlKG1tLCBhZGRyKQkoewkJCQlc
CisjZGVmaW5lIHVudGFnX3JlbW90ZV91c2VyX2FkZHIobW0sIGFkZHIpCSh7CQkJCVwKIAl1
bnNpZ25lZCBsb25nIF9fYWRkciA9IChfX2ZvcmNlIHVuc2lnbmVkIGxvbmcpKGFkZHIpOwkJ
XAotCShfX2ZvcmNlIF9fdHlwZW9mX18oYWRkcikpX191bnRhZ2dlZF9hZGRyX3JlbW90ZSht
bSwgX19hZGRyKTsJXAorCShfX2ZvcmNlIF9fdHlwZW9mX18oYWRkcikpX191bnRhZ19yZW1v
dGVfdXNlcl9hZGRyKG1tLCBfX2FkZHIpOwlcCiB9KQogCiAjZWxzZQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYyBiL2RyaXZlcnMvdmZpby92ZmlvX2lv
bW11X3R5cGUxLmMKaW5kZXggM2Q0ZGQ5NDIwYzMwLi45MjkxNTJiMjhiOGMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvdmZpby92ZmlvX2lvbW11X3R5cGUxLmMKKysrIGIvZHJpdmVycy92Zmlv
L3ZmaW9faW9tbXVfdHlwZTEuYwpAQCAtNTgwLDcgKzU4MCw3IEBAIHN0YXRpYyBpbnQgdmFk
ZHJfZ2V0X3BmbnMoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgdmFkZHIs
CiAJCWdvdG8gZG9uZTsKIAl9CiAKLQl2YWRkciA9IHVudGFnZ2VkX2FkZHJfcmVtb3RlKG1t
LCB2YWRkcik7CisJdmFkZHIgPSB1bnRhZ19yZW1vdGVfdXNlcl9hZGRyKG1tLCB2YWRkcik7
CiAKIHJldHJ5OgogCXZtYSA9IHZtYV9sb29rdXAobW0sIHZhZGRyKTsKZGlmZiAtLWdpdCBh
L2ZzL3Byb2MvdGFza19tbXUuYyBiL2ZzL3Byb2MvdGFza19tbXUuYwppbmRleCA0MjA1MTBm
NmE1NDUuLjdjY2QzZjM0MWFmNCAxMDA2NDQKLS0tIGEvZnMvcHJvYy90YXNrX21tdS5jCisr
KyBiL2ZzL3Byb2MvdGFza19tbXUuYwpAQCAtMTY5Miw3ICsxNjkyLDcgQEAgc3RhdGljIHNz
aXplX3QgcGFnZW1hcF9yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9fdXNlciAqYnVm
LAogCQlyZXQgPSBtbWFwX3JlYWRfbG9ja19raWxsYWJsZShtbSk7CiAJCWlmIChyZXQpCiAJ
CQlnb3RvIG91dF9mcmVlOwotCQlzdGFydF92YWRkciA9IHVudGFnZ2VkX2FkZHJfcmVtb3Rl
KG1tLCBzdnBmbiA8PCBQQUdFX1NISUZUKTsKKwkJc3RhcnRfdmFkZHIgPSB1bnRhZ19yZW1v
dGVfdXNlcl9hZGRyKG1tLCBzdnBmbiA8PCBQQUdFX1NISUZUKTsKIAkJbW1hcF9yZWFkX3Vu
bG9jayhtbSk7CiAJfQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaCBi
L2luY2x1ZGUvbGludXgvdWFjY2Vzcy5oCmluZGV4IDMwNjQzMTRmNDgzMi4uOGM5NTYxNzIy
NTJmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3VhY2Nlc3MuaApAQCAtMjUsOCArMjUsOCBAQAogI2RlZmluZSB1bnRhZ2dlZF9h
ZGRyKGFkZHIpIChhZGRyKQogI2VuZGlmCiAKLSNpZm5kZWYgdW50YWdnZWRfYWRkcl9yZW1v
dGUKLSNkZWZpbmUgdW50YWdnZWRfYWRkcl9yZW1vdGUobW0sIGFkZHIpCSh7CQlcCisjaWZu
ZGVmIHVudGFnX3JlbW90ZV91c2VyX2FkZHIKKyNkZWZpbmUgdW50YWdfcmVtb3RlX3VzZXJf
YWRkcihtbSwgYWRkcikJKHsJCVwKIAltbWFwX2Fzc2VydF9sb2NrZWQobW0pOwkJCQlcCiAJ
dW50YWdnZWRfYWRkcihhZGRyKTsJCQkJXAogfSkKZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIv
bW0vZ3VwLmMKaW5kZXggYmJlNDE2MjM2NTkzLi5kMjJiYWQ5MTQ3ZDcgMTAwNjQ0Ci0tLSBh
L21tL2d1cC5jCisrKyBiL21tL2d1cC5jCkBAIC0xMDg1LDcgKzEwODUsNyBAQCBzdGF0aWMg
bG9uZyBfX2dldF91c2VyX3BhZ2VzKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAogCWlmICghbnJf
cGFnZXMpCiAJCXJldHVybiAwOwogCi0Jc3RhcnQgPSB1bnRhZ2dlZF9hZGRyX3JlbW90ZSht
bSwgc3RhcnQpOworCXN0YXJ0ID0gdW50YWdfcmVtb3RlX3VzZXJfYWRkcihtbSwgc3RhcnQp
OwogCiAJVk1fQlVHX09OKCEhcGFnZXMgIT0gISEoZ3VwX2ZsYWdzICYgKEZPTExfR0VUIHwg
Rk9MTF9QSU4pKSk7CiAKQEAgLTEyNTksNyArMTI1OSw3IEBAIGludCBmaXh1cF91c2VyX2Zh
dWx0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAogCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
OwogCXZtX2ZhdWx0X3QgcmV0OwogCi0JYWRkcmVzcyA9IHVudGFnZ2VkX2FkZHJfcmVtb3Rl
KG1tLCBhZGRyZXNzKTsKKwlhZGRyZXNzID0gdW50YWdfcmVtb3RlX3VzZXJfYWRkcihtbSwg
YWRkcmVzcyk7CiAKIAlpZiAodW5sb2NrZWQpCiAJCWZhdWx0X2ZsYWdzIHw9IEZBVUxUX0ZM
QUdfQUxMT1dfUkVUUlkgfCBGQVVMVF9GTEFHX0tJTExBQkxFOwpkaWZmIC0tZ2l0IGEvbW0v
bWFkdmlzZS5jIGIvbW0vbWFkdmlzZS5jCmluZGV4IGI1ZmZiYWY2MTZmNS4uZmZiNWQ3NmE5
NDgxIDEwMDY0NAotLS0gYS9tbS9tYWR2aXNlLmMKKysrIGIvbW0vbWFkdmlzZS5jCkBAIC0x
NDIxLDcgKzE0MjEsNyBAQCBpbnQgZG9fbWFkdmlzZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
dW5zaWduZWQgbG9uZyBzdGFydCwgc2l6ZV90IGxlbl9pbiwgaW50IGJlaAogCQltbWFwX3Jl
YWRfbG9jayhtbSk7CiAJfQogCi0Jc3RhcnQgPSB1bnRhZ2dlZF9hZGRyX3JlbW90ZShtbSwg
c3RhcnQpOworCXN0YXJ0ID0gdW50YWdfcmVtb3RlX3VzZXJfYWRkcihtbSwgc3RhcnQpOwog
CWVuZCA9IHN0YXJ0ICsgbGVuOwogCiAJYmxrX3N0YXJ0X3BsdWcoJnBsdWcpOwpkaWZmIC0t
Z2l0IGEvbW0vbWlncmF0ZS5jIGIvbW0vbWlncmF0ZS5jCmluZGV4IDAxY2FjMjZhMzEyNy4u
NzY0N2MwYTZmZjMwIDEwMDY0NAotLS0gYS9tbS9taWdyYXRlLmMKKysrIGIvbW0vbWlncmF0
ZS5jCkBAIC0yMTA5LDcgKzIxMDksNyBAQCBzdGF0aWMgaW50IGFkZF9wYWdlX2Zvcl9taWdy
YXRpb24oc3RydWN0IG1tX3N0cnVjdCAqbW0sIGNvbnN0IHZvaWQgX191c2VyICpwLAogCWJv
b2wgaXNvbGF0ZWQ7CiAKIAltbWFwX3JlYWRfbG9jayhtbSk7Ci0JYWRkciA9ICh1bnNpZ25l
ZCBsb25nKXVudGFnZ2VkX2FkZHJfcmVtb3RlKG1tLCBwKTsKKwlhZGRyID0gKHVuc2lnbmVk
IGxvbmcpdW50YWdfcmVtb3RlX3VzZXJfYWRkcihtbSwgcCk7CiAKIAllcnIgPSAtRUZBVUxU
OwogCXZtYSA9IHZtYV9sb29rdXAobW0sIGFkZHIpOwo=

--------------xG0eQnVSzAK0EufcJrcff4O4--
