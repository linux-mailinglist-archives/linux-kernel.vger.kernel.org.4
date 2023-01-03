Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0F65C2FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbjACP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjACP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:29:07 -0500
Received: from mail.holmansrus.com (unknown [143.59.183.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D493101CB;
        Tue,  3 Jan 2023 07:29:05 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id 39B71E1D81;
        Tue,  3 Jan 2023 09:29:05 -0600 (CST)
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Hf5n-WO8d_L1; Tue,  3 Jan 2023 09:29:04 -0600 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id AEDBBE1D82;
        Tue,  3 Jan 2023 09:29:04 -0600 (CST)
X-Virus-Scanned: amavisd-new at holmansrus.com
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RLjeNROsczJw; Tue,  3 Jan 2023 09:29:04 -0600 (CST)
Received: from mail.holmansrus.com (mail.holmansrus.com [10.90.0.246])
        by mail.holmansrus.com (Postfix) with ESMTP id 8202FE1D66;
        Tue,  3 Jan 2023 09:29:04 -0600 (CST)
Date:   Tue, 3 Jan 2023 09:29:04 -0600 (CST)
From:   Walt Holman <walt@holmansrus.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Message-ID: <1912021550.81.1672759744435.JavaMail.zimbra@holmansrus.com>
Subject: [PATCH] HID: hid-logitech-hidpp: Add support for Logitech G923
 wheel Xbox Edition
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_78_2130522169.1672759744431"
X-Originating-IP: [10.90.0.246]
X-Mailer: Zimbra 8.8.15_GA_4484 (ZimbraWebClient - GC108 (Linux)/8.8.15_GA_4481)
Thread-Index: vnyCnP3PqKYA9fopjSHV+dj1MkZaZQ==
Thread-Topic: hid-logitech-hidpp: Add support for Logitech G923 wheel Xbox Edition
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_78_2130522169.1672759744431
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, 

This patch adds support for the Logitech G923 Xbox edition steering wheel. This uses the hid-logitech-hidpp kernel module and from my testing, force feedback and all buttons work. This requires the usb_modeswitch application to setup the device in PC mode with a magic string that is the same as the Logitech 920 wheel. Originally I had massaged a patch I found for this wheel, however, much of it was unnecessary and I culled it back to just adding the ID's. Let me know if you need anything else or have any questions. Thanks, 

Signed-off-by: Walt Holman walt@holmansrus.com 


------=_Part_78_2130522169.1672759744431
Content-Type: text/x-patch; name=logitech-g923-hidpp-clean.patch
Content-Disposition: attachment; filename=logitech-g923-hidpp-clean.patch
Content-Transfer-Encoding: base64

ZGlmZiAtdTIgLXIgbGludXgtc291cmNlL2RyaXZlcnMvaGlkL2hpZC1pZHMuaCBsaW51eC10YXJn
ZXQvZHJpdmVycy9oaWQvaGlkLWlkcy5oCi0tLSBsaW51eC1zb3VyY2UvZHJpdmVycy9oaWQvaGlk
LWlkcy5oCTIwMjItMTItMjEgMTA6NDg6MTIuMDAwMDAwMDAwIC0wNjAwCisrKyBsaW51eC10YXJn
ZXQvZHJpdmVycy9oaWQvaGlkLWlkcy5oCTIwMjItMTItMjIgMTI6NTA6MTYuNDAzODgwMTM3IC0w
NjAwCkBAIC04MjAsNCArODIwLDUgQEAKICNkZWZpbmUgVVNCX0RFVklDRV9JRF9MT0dJVEVDSF9H
MjlfV0hFRUwJMHhjMjRmCiAjZGVmaW5lIFVTQl9ERVZJQ0VfSURfTE9HSVRFQ0hfRzkyMF9XSEVF
TAkweGMyNjIKKyNkZWZpbmUgVVNCX0RFVklDRV9JRF9MT0dJVEVDSF9HOTIzX1hCT1hfV0hFRUwJ
MHhjMjZlCiAjZGVmaW5lIFVTQl9ERVZJQ0VfSURfTE9HSVRFQ0hfV0lOR01BTl9GM0QJMHhjMjgz
CiAjZGVmaW5lIFVTQl9ERVZJQ0VfSURfTE9HSVRFQ0hfRk9SQ0UzRF9QUk8JMHhjMjg2CmRpZmYg
LXUyIC1yIGxpbnV4LXNvdXJjZS9kcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYyBsaW51
eC10YXJnZXQvZHJpdmVycy9oaWQvaGlkLWxvZ2l0ZWNoLWhpZHBwLmMKLS0tIGxpbnV4LXNvdXJj
ZS9kcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYwkyMDIyLTEyLTIxIDEwOjQ4OjEyLjAw
MDAwMDAwMCAtMDYwMAorKysgbGludXgtdGFyZ2V0L2RyaXZlcnMvaGlkL2hpZC1sb2dpdGVjaC1o
aWRwcC5jCTIwMjItMTItMjIgMTI6NTM6MzYuMzM1NzU1MTk5IC0wNjAwCkBAIC00MzQxLDQgKzQz
NDEsNyBAQAogCSAgSElEX1VTQl9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9MT0dJVEVDSCwgVVNCX0RF
VklDRV9JRF9MT0dJVEVDSF9HOTIwX1dIRUVMKSwKIAkJLmRyaXZlcl9kYXRhID0gSElEUFBfUVVJ
UktfQ0xBU1NfRzkyMCB8IEhJRFBQX1FVSVJLX0ZPUkNFX09VVFBVVF9SRVBPUlRTfSwKKwl7IC8q
IExvZ2l0ZWNoIEc5MjMgV2hlZWwgKFhib3ggdmVyc2lvbikgb3ZlciBVU0IgKi8KKwkgIEhJRF9V
U0JfREVWSUNFKFVTQl9WRU5ET1JfSURfTE9HSVRFQ0gsIFVTQl9ERVZJQ0VfSURfTE9HSVRFQ0hf
RzkyM19YQk9YX1dIRUVMKSwKKwkJLmRyaXZlcl9kYXRhID0gSElEUFBfUVVJUktfQ0xBU1NfRzky
MCB8IEhJRFBQX1FVSVJLX0ZPUkNFX09VVFBVVF9SRVBPUlRTIH0sCiAJeyAvKiBMb2dpdGVjaCBH
IFBybyBHYW1pbmcgTW91c2Ugb3ZlciBVU0IgKi8KIAkgIEhJRF9VU0JfREVWSUNFKFVTQl9WRU5E
T1JfSURfTE9HSVRFQ0gsIDB4QzA4OCkgfSwKCg==
------=_Part_78_2130522169.1672759744431--
