Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BC70B92B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjEVJhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjEVJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:37:42 -0400
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F8E51A5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:37:13 -0700 (PDT)
Received: from sunying$nj.iscas.ac.cn ( [180.111.102.60] ) by
 ajax-webmail-APP-09 (Coremail) ; Mon, 22 May 2023 17:36:50 +0800
 (GMT+08:00)
X-Originating-IP: [180.111.102.60]
Date:   Mon, 22 May 2023 17:36:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   sunying@nj.iscas.ac.cn
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: kernel/locking/lockdep.c:2877-2887: dead code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7beb0d2d.12bea.18842d18f9d.Coremail.sunying@nj.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowAD3__OyN2tkcJscAA--.58145W
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/1tbiBwQTAWRrEaCQ6QABsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5hbHl6aW5nIHRoZSBwcmVwcm9jZXNzZWQgc3RhdGVtZW50ICNpZmRlZiBpbiB0aGUga2VybmVs
L2xvY2tpbmcvbG9ja2RlcC5jIHNob3dzIHRoYXQgCnRoZSBmdW5jdGlvbnMg4oCcY2hlY2tfaXJx
X3VzYWdl4oCdIGFuZCDigJx1c2FnZV9za2lw4oCdIGF0IGxpbmVzIDI4NzctMjg4NyBhcmUgZGVm
aW5lZCB2YWxpZCBvbmx5CnVuZGVyIHRoZSDigJxDT05GSUdfUFJPVkVfTE9DS0lORyAmYW1wOyZh
bXA7ICEoQ09ORklHX1RSQUNFX0lSUUZMQUdTKeKAnSBpcyB0cnVlLgoKSG93ZXZlciwgYWNjb3Jk
aW5nIHRvIHRoZSBjb25maWd1cmF0aW9uIGl0ZW0gIkNPTkZJR19QUk9WRV9MT0NLSU5HIiBkZWZp
bmVkIGluIGxpYi9LY29uZmlnLmRlYnVnLCB3ZSBjYW4gc2VlOgpjb25maWcgUFJPVkVfTE9DS0lO
RwogICAgICAgIGJvb2wgIkxvY2sgZGVidWdnaW5nOiBwcm92ZSBsb2NraW5nIGNvcnJlY3RuZXNz
IgogICAgICAgIGRlcGVuZHMgb24gREVCVUdfS0VSTkVMICZhbXA7JmFtcDsgTE9DS19ERUJVR0dJ
TkdfU1VQUE9SVAogICAgICAgIHNlbGVjdCBMT0NLREVQCiAgICAgICAgc2VsZWN0IERFQlVHX1NQ
SU5MT0NLCiAgICAgICAgc2VsZWN0IERFQlVHX01VVEVYRVMgaWYgIVBSRUVNUFRfUlQKICAgICAg
ICBzZWxlY3QgREVCVUdfUlRfTVVURVhFUyBpZiBSVF9NVVRFWEVTCiAgICAgICAgc2VsZWN0IERF
QlVHX1JXU0VNUwogICAgICAgIHNlbGVjdCBERUJVR19XV19NVVRFWF9TTE9XUEFUSAogICAgICAg
IHNlbGVjdCBERUJVR19MT0NLX0FMTE9DCiAgICAgICAgc2VsZWN0IFBSRUVNUFRfQ09VTlQgaWYg
IUFSQ0hfTk9fUFJFRU1QVAogICAgICAgIHNlbGVjdCBUUkFDRV9JUlFGTEFHUwogICAgICAgIGRl
ZmF1bHQgbgoKSWYgIkNPTkZJR19QUk9WRV9MT0NLSU5HOiBpcyBlbmFibGVkLCAiQ09ORklHX1RS
QUNFX0lSUUZMQUdTIiBpcyBhdXRvbWF0aWNhbGx5IGVuYWJsZWQuClRoZSBhYm92ZSBjb25kaXRp
b24gIkNPTkZJR19QUk9WRV9MT0NLSU5HICZhbXA7JmFtcDsgIShDT05GSUdfVFJBQ0VfSVJRRkxB
R1MpIiB3aWxsIG5ldmVyIGJlIHRydWUsCnNvIGxpbmVzIDI4NzctMjg4NyB3aWxsIG5ldmVyIGJl
IGV4ZWN1dGVkLgoKU2hvdWxkIHRoZSBkZWFkIGNvZGUgb2YgbGluZSAyODc3LTI4ODcgYmUgZGVs
ZXRlZD8KCgpCZXN0IFJlZ2FyZHMKWWFuamllIFJlbgpZaW5nIFN1bgoK
