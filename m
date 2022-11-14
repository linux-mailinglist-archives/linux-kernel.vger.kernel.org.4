Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF8628236
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiKNOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiKNOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:19:14 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4434E264A5;
        Mon, 14 Nov 2022 06:19:13 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D7E07C000E;
        Mon, 14 Nov 2022 14:19:09 +0000 (UTC)
Message-ID: <9e77ba98322873ba8790d4fb7904c844db2d085d.camel@hadess.net>
Subject: Re: [PATCH 1/1] HID: Send SwID in GetProtocolVersion
From:   Bastien Nocera <hadess@hadess.net>
To:     Andreas Bergmeier <abergmeier@gmx.net>, lains@riseup.net,
        jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Nov 2022 15:19:09 +0100
In-Reply-To: <20221111194526.1375601-1-abergmeier@gmx.net>
References: <20221111194526.1375601-1-abergmeier@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.0 (3.46.0-2.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTExIGF0IDIwOjQ1ICswMTAwLCBBbmRyZWFzIEJlcmdtZWllciB3cm90
ZToKPiBBY2NvcmRpbmcgdG8gZG9jcyBhIFN3SUQgc2hvdWxkIGJlIHNlbnQgZm9yIEdldFByb3Rv
Y29sVmVyc2lvbi4KPiA+IDB4MTAuRGV2aWNlSW5kZXguMHgwMC4weDFuCj4gd2hlcmUgbiBpcyBT
d0lECgpJIHdvdWxkIG1lbnRpb24gdGhlIHZhbHVlIG9mIENNRF9ST09UX0dFVF9QUk9UT0NPTF9W
RVJTSU9OICgweDEwKSBpbgp0aGUgY29tbWl0IG1lc3NhZ2UsIGJ1dCBvdGhlcndpc2UgbG9va3Mg
Z29vZCB0byBtZS4KClJldmlld2VkLWJ5OiBCYXN0aWVuIE5vY2VyYSA8aGFkZXNzQGhhZGVzcy5u
ZXQ+Cgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgQmVyZ21laWVyIDxhYmVyZ21laWVyQGdt
eC5uZXQ+Cj4gLS0tCj4gwqBkcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYyB8IDIgKy0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYyBiL2RyaXZlcnMvaGlk
L2hpZC0KPiBsb2dpdGVjaC1oaWRwcC5jCj4gaW5kZXggYTBjMTQ4YThkZjZjLi45NjRhNTIzYzNk
ZTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9oaWQvaGlkLWxvZ2l0ZWNoLWhpZHBwLmMKPiArKysg
Yi9kcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAuYwo+IEBAIC04OTYsNyArODk2LDcgQEAg
c3RhdGljIGludCBoaWRwcF9yb290X2dldF9wcm90b2NvbF92ZXJzaW9uKHN0cnVjdAo+IGhpZHBw
X2RldmljZSAqaGlkcHApCj4gCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IGhpZHBwX3NlbmRfcmFw
X2NvbW1hbmRfc3luYyhoaWRwcCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBISURQUF9QQUdFX1JPT1RfSURYLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQ01EX1JPT1RfR0VUX1BST1RPQ09MX1ZFUlNJT04s
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBDTURfUk9P
VF9HRVRfUFJPVE9DT0xfVkVSU0lPTiB8Cj4gTElOVVhfS0VSTkVMX1NXX0lELAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmdfZGF0YSwgc2l6ZW9m
KHBpbmdfZGF0YSksICZyZXNwb25zZSk7Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgPT0g
SElEUFBfRVJST1JfSU5WQUxJRF9TVUJJRCkgewo+IC0tCj4gMi4zNC4xCj4gCgo=

