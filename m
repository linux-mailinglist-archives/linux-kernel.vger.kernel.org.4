Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA47738939
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjFUPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjFUPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:32:01 -0400
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBDD19B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:31:43 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Bzo4qqTmVBn0GBzo4qL3PU; Wed, 21 Jun 2023 17:31:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1687361500; bh=Kr9uQUwuYYRfz/jvnZbpKuJ6zBBw4mD5BU/o+Z6TmUg=;
        h=Content-Type:Date:MIME-Version:Subject:To:From;
        b=ebP5sXGMQVyUtR9A7ncleYpn++S9IfHI1A/MgcPqW8hBf5ZGPsK4aJEoUuWNh789h
         m1hRd5XJuNwuPR9ii2U6RrjEP9cGECGjz/D+F3mjwK5Ll/MuFnV+wehBLNPbiFljlR
         onaeZiG5fcWSL2VlOhbcG06qwDk/H2JIKqKyRmJMmKNZlfR2m/GreZ06YSryvsHP79
         dy3F6y952MWtViwYsk/LWgAe7FxG3j1RVi/PUpNrqS6mcZFT+dFcFz0pOGSsPRq6V9
         CsJmryjLuf6nVpnS/htZdhSx7k+QbSOja53DmDaedvPAs2kKoNkxPMPrq5gYJblAMX
         xmGvs468LCSeg==
Content-Type: multipart/mixed; boundary="------------K8FqYMzZ0uMINnuLmani0Jzv"
Message-ID: <c770492b-dfee-c38e-f15a-aad382caec25@enneenne.com>
Date:   Wed, 21 Jun 2023 17:31:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
Content-Language: en-US
To:     Charlie Johnston <charlie.johnston@ni.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
 <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
 <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
 <38f38f66-0fd5-4e6c-4839-8272cef77046@ni.com>
 <5aff32cf-74ea-b632-9d4d-a01ca0d31821@enneenne.com>
 <41affdf0-edba-6202-4e76-fd969da6497b@ni.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <41affdf0-edba-6202-4e76-fd969da6497b@ni.com>
X-CMAE-Envelope: MS4xfH/Xdblr6XkoFrvyzCTEp7+KWc0O+QFMNl8GIcEI6WGEkmekZrqJ2ESbiTamGSS/zEaz44ugxz5n8+t2JPj2UwzF5sesn6zRPpwEdD17C5D1zWWteW3f
 FZZQKd20j10tmkldTh54K2WeAQAEIcX2ZQ/6AdWQ+AucBVJ88jak6RsGtJT2Debu7T9hl5ySSiLzP5DbpnQlcAmTYXbeWdFIWx/5qmHTLZFDrdV7bMod6dlp
 hgHoPmFrN47U1Y5o40t8fMfljmNH943u8gGhhGVH6i8=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------K8FqYMzZ0uMINnuLmani0Jzv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/23 22:42, Charlie Johnston wrote:
> I've resubmitted the patch with just PPS_MAX_SOURCES = MINORMASK. The system which hits the limit and causes the problem is currently available for testing.
> 
> Is there anything you'd like me to try running? Or just confirm the limit change works?

Sorry for the delay (i was very busy in these days)! Please, test the attached 
two patches.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--------------K8FqYMzZ0uMINnuLmani0Jzv
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-include-uapi-pps.h-increase-PPS_MAX_SOURCES-value.patch"
Content-Disposition: attachment;
 filename*0="0001-include-uapi-pps.h-increase-PPS_MAX_SOURCES-value.patch"
Content-Transfer-Encoding: base64

RnJvbSAwMjliYjI4NzcyYjQ3NTFjZDA3YmViNWYzNjYwNjZlOTMzM2VhNTAyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFybGllIEpvaG5zdG9uIDxjaGFybGllLmpvaG5z
dG9uQG5pLmNvbT4KRGF0ZTogTW9uLCAxMiBKdW4gMjAyMyAxNDowODoyOCAtMDUwMApTdWJq
ZWN0OiBbUEFUQ0ggMS8yXSBpbmNsdWRlL3VhcGkgcHBzLmg6IGluY3JlYXNlIFBQU19NQVhf
U09VUkNFUyB2YWx1ZQoKRm9yIGNvbnNpc3RlbmN5IHdpdGggd2hhdCBvdGhlcnMgdXNlIGZv
ciBtaW5vcnMsIHRoaXMgY2hhbmdlIHNldHMKUFBTX01BWF9TT1VSQ0VTIHRvIE1JTk9STUFT
Sy4KClRoZSBQUFNfTUFYX1NPVVJDRVMgdmFsdWUgaXMgY3VycmVudGx5IHNldCB0byAxNi4g
SW4gc29tZSBjYXNlcyB0aGlzCndhcyBub3Qgc3VmZmljaWVudCBmb3IgYSBzeXN0ZW0uIEZv
ciBleGFtcGxlLCBhIHN5c3RlbSB3aXRoIG11bHRpcGxlCig0KykgUENJZSBjYXJkcyBlYWNo
IHdpdGggNCBQVFAtY2FwYWJsZSBldGhlcm5ldCBpbnRlcmZhY2VzIGNvdWxkIHJ1bgpvdXQg
b2YgdGhlIGF2YWlsYWJsZSBQUFMgbWFqb3I6bWlub3JzIGlmIGVhY2ggaW50ZXJmYWNlIHJl
Z2lzdGVycyBhClBQUyBzb3VyY2UuCgpTaWduZWQtb2ZmLWJ5OiBDaGFybGllIEpvaG5zdG9u
IDxjaGFybGllLmpvaG5zdG9uQG5pLmNvbT4KQWNrZWQtYnk6IFJvZG9sZm8gR2lvbWV0dGkg
PGdpb21ldHRpQGVubmVlbm5lLmNvbT4KLS0tCiBpbmNsdWRlL3VhcGkvbGludXgvcHBzLmgg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvcHBzLmggYi9pbmNsdWRlL3VhcGkv
bGludXgvcHBzLmgKaW5kZXggMDA5ZWJjZDhjZWQ1Li45MGYyZTg2MDIwYmEgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvdWFwaS9saW51eC9wcHMuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
cHBzLmgKQEAgLTI2LDcgKzI2LDcgQEAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogCiAj
ZGVmaW5lIFBQU19WRVJTSU9OCQkiNS4zLjYiCi0jZGVmaW5lIFBQU19NQVhfU09VUkNFUwkJ
MTYJCS8qIHNob3VsZCBiZSBlbm91Z2guLi4gKi8KKyNkZWZpbmUgUFBTX01BWF9TT1VSQ0VT
CQlNSU5PUk1BU0sKIAogLyogSW1wbGVtZW50YXRpb24gbm90ZTogdGhlIGxvZ2ljYWwgc3Rh
dGVzIGBgYXNzZXJ0JycgYW5kIGBgY2xlYXInJwogICogYXJlIGltcGxlbWVudGVkIGluIHRl
cm1zIG9mIHRoZSBjaGlwIHJlZ2lzdGVyLCBpLmUuIGBgYXNzZXJ0JycKLS0gCjIuMzQuMQoK

--------------K8FqYMzZ0uMINnuLmani0Jzv
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-include-uapi-pps.h-drop-not-needed-PPS_MAX_SOURCES-d.patch"
Content-Disposition: attachment;
 filename*0="0002-include-uapi-pps.h-drop-not-needed-PPS_MAX_SOURCES-d.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNDdmNGIzYmNmY2Y5NTAzOWI1M2NhMGY2NjU4NmY1NDdlOWE5MjI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSb2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBlbm5l
ZW5uZS5jb20+CkRhdGU6IFdlZCwgMjEgSnVuIDIwMjMgMTY6NDI6MzggKzAyMDAKU3ViamVj
dDogW1BBVENIIDIvMl0gaW5jbHVkZS91YXBpIHBwcy5oOiBkcm9wIG5vdCBuZWVkZWQgUFBT
X01BWF9TT1VSQ0VTCiBkZWZpbmUKClVzZXJzcGFjZSBQUFMgY2xpZW50cyBzaG91bGQgbm90
IGtub3duIGFib3V0IGhvdyBtYW55IFBQUyBzb3VyY2VzIGNhbgpiZSBkZWZpbmVkIHdpdGhp
biB0aGUgc3lzdGVtIChub3IgdGhlIHJmYzI3ODMgc2F5IHNvKSwgc28gd2UgY2FuCnNhZmVs
eSBkcm9wIHRoaXMgZGVmaW5lIHNpbmNlIGlzIG5vdCB1c2VkIGFueW1vcmUgaW4gdGhlIGtl
cm5lbCB0b28uCgpTaWduZWQtb2ZmLWJ5OiBSb2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBl
bm5lZW5uZS5jb20+Ci0tLQogZHJpdmVycy9wcHMvcHBzLmMgICAgICAgIHwgNiArKystLS0K
IGluY2x1ZGUvdWFwaS9saW51eC9wcHMuaCB8IDEgLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wcHMv
cHBzLmMgYi9kcml2ZXJzL3Bwcy9wcHMuYwppbmRleCA1ZDE5YmFhZTZhMzguLjFhNjEzMTYw
ODAzNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wcHMvcHBzLmMKKysrIGIvZHJpdmVycy9wcHMv
cHBzLmMKQEAgLTM1NCw3ICszNTQsNyBAQCBpbnQgcHBzX3JlZ2lzdGVyX2NkZXYoc3RydWN0
IHBwc19kZXZpY2UgKnBwcykKIAkgKiBHZXQgbmV3IElEIGZvciB0aGUgbmV3IFBQUyBzb3Vy
Y2UuICBBZnRlciBpZHJfYWxsb2MoKSBjYWxsaW5nCiAJICogdGhlIG5ldyBzb3VyY2Ugd2ls
bCBiZSBmcmVlbHkgYXZhaWxhYmxlIGludG8gdGhlIGtlcm5lbC4KIAkgKi8KLQllcnIgPSBp
ZHJfYWxsb2MoJnBwc19pZHIsIHBwcywgMCwgUFBTX01BWF9TT1VSQ0VTLCBHRlBfS0VSTkVM
KTsKKwllcnIgPSBpZHJfYWxsb2MoJnBwc19pZHIsIHBwcywgMCwgTUlOT1JNQVNLLCBHRlBf
S0VSTkVMKTsKIAlpZiAoZXJyIDwgMCkgewogCQlpZiAoZXJyID09IC1FTk9TUEMpIHsKIAkJ
CXByX2VycigiJXM6IHRvbyBtYW55IFBQUyBzb3VyY2VzIGluIHRoZSBzeXN0ZW1cbiIsCkBA
IC00NDksNyArNDQ5LDcgQEAgRVhQT1JUX1NZTUJPTChwcHNfbG9va3VwX2Rldik7CiBzdGF0
aWMgdm9pZCBfX2V4aXQgcHBzX2V4aXQodm9pZCkKIHsKIAljbGFzc19kZXN0cm95KHBwc19j
bGFzcyk7Ci0JdW5yZWdpc3Rlcl9jaHJkZXZfcmVnaW9uKHBwc19kZXZ0LCBQUFNfTUFYX1NP
VVJDRVMpOworCXVucmVnaXN0ZXJfY2hyZGV2X3JlZ2lvbihwcHNfZGV2dCwgTUlOT1JNQVNL
KTsKIH0KIAogc3RhdGljIGludCBfX2luaXQgcHBzX2luaXQodm9pZCkKQEAgLTQ2Myw3ICs0
NjMsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBwcHNfaW5pdCh2b2lkKQogCX0KIAlwcHNfY2xh
c3MtPmRldl9ncm91cHMgPSBwcHNfZ3JvdXBzOwogCi0JZXJyID0gYWxsb2NfY2hyZGV2X3Jl
Z2lvbigmcHBzX2RldnQsIDAsIFBQU19NQVhfU09VUkNFUywgInBwcyIpOworCWVyciA9IGFs
bG9jX2NocmRldl9yZWdpb24oJnBwc19kZXZ0LCAwLCBNSU5PUk1BU0ssICJwcHMiKTsKIAlp
ZiAoZXJyIDwgMCkgewogCQlwcl9lcnIoImZhaWxlZCB0byBhbGxvY2F0ZSBjaGFyIGRldmlj
ZSByZWdpb25cbiIpOwogCQlnb3RvIHJlbW92ZV9jbGFzczsKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdWFwaS9saW51eC9wcHMuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9wcHMuaAppbmRleCA5
MGYyZTg2MDIwYmEuLjhhNDA5NmYxOGFmMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L3Bwcy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9wcHMuaApAQCAtMjYsNyArMjYs
NiBAQAogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiAKICNkZWZpbmUgUFBTX1ZFUlNJT04J
CSI1LjMuNiIKLSNkZWZpbmUgUFBTX01BWF9TT1VSQ0VTCQlNSU5PUk1BU0sKIAogLyogSW1w
bGVtZW50YXRpb24gbm90ZTogdGhlIGxvZ2ljYWwgc3RhdGVzIGBgYXNzZXJ0JycgYW5kIGBg
Y2xlYXInJwogICogYXJlIGltcGxlbWVudGVkIGluIHRlcm1zIG9mIHRoZSBjaGlwIHJlZ2lz
dGVyLCBpLmUuIGBgYXNzZXJ0JycKLS0gCjIuMzQuMQoK

--------------K8FqYMzZ0uMINnuLmani0Jzv--
