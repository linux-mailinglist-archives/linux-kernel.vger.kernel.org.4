Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79D664ECDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiLPO1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:27:39 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509F50D77;
        Fri, 16 Dec 2022 06:27:37 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 826E610000C;
        Fri, 16 Dec 2022 14:27:34 +0000 (UTC)
Message-ID: <b787798328560ef3627ba3f8634114d78d3f249a.camel@hadess.net>
Subject: Re: [PATCH] hid: Support for Litra Glow
From:   Bastien Nocera <hadess@hadess.net>
To:     Andreas Bergmeier <abergmeier@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Dec 2022 15:27:33 +0100
In-Reply-To: <8f00ae9463b07fbd789af3840cd59a9e99caff34.camel@hadess.net>
References: <9fca69c7-cc24-63d0-98f6-80c28fc69a5@9300>
         <8f00ae9463b07fbd789af3840cd59a9e99caff34.camel@hadess.net>
Content-Type: multipart/mixed; boundary="=-OvH/z0DPZjhe91+lGS7D"
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-OvH/z0DPZjhe91+lGS7D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-12-16 at 10:53 +0100, Bastien Nocera wrote:
> On Thu, 2022-12-15 at 22:09 +0100, Andreas Bergmeier wrote:
> > Tries to implement as general support for Illumination Light as
> > possible. Note that it is singular, which means by Logitech spec we
> > are
> > fine off with just handling one capability/device.
>=20
> Your email client absolutely trashed the patch's indentation, it's
> unreadable as-is.
>=20
> > Implementation currently only exposes Brightness and On/Off
> > controls.
> > Does currently not expose Color Temperature because LEDs does not
> > support it.
> >=20
> > Introduces HIDPP_QUIRK_CLASS_SIMPLE_START to prevent reconnect on
> > startup. Could not get Glow to work with that.
>=20
> I'd really rather we didn't introduce a new quirk, but instead fixed
> the fact that we need to restart the HID transport to support 3 (!)
> devices.
>=20
> Would something like the attached patch work? I haven't tested it
> yet,
> but if it works for you, I'll test it on the devices I have here.

A tested version attached. I'll need to test it against a T650 before
sending it for review.

--=-OvH/z0DPZjhe91+lGS7D
Content-Disposition: attachment;
	filename*0=0001-HID-logitech-hidpp-Don-t-restart-communication-if-no.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-HID-logitech-hidpp-Don-t-restart-communication-if-no.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBiZWFlMmRlMDg2NTQ2ZjZhMzE4N2EzMWYyZjQwNmIxZTNmZTIxZjVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYXN0aWVuIE5vY2VyYSA8aGFkZXNzQGhhZGVzcy5uZXQ+CkRh
dGU6IEZyaSwgMTYgRGVjIDIwMjIgMTA6NDE6MTYgKzAxMDAKU3ViamVjdDogW1BBVENIXSBISUQ6
IGxvZ2l0ZWNoLWhpZHBwOiBEb24ndCByZXN0YXJ0IGNvbW11bmljYXRpb24gaWYgbm90CiBuZWNl
c3NhcnkKCkRvbid0IHN0b3AgYW5kIHJlc3RhcnQgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBkZXZp
Y2UgdW5sZXNzIHdlIG5lZWQgdG8KbW9kaWZ5IHRoZSBjb25uZWN0IGZsYWdzIHVzZWQgYmVjYXVz
ZSBvZiBhIGRldmljZSBxdWlyay4KLS0tCiBkcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAu
YyB8IDMxICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hp
ZC9oaWQtbG9naXRlY2gtaGlkcHAuYyBiL2RyaXZlcnMvaGlkL2hpZC1sb2dpdGVjaC1oaWRwcC5j
CmluZGV4IDdmOTE4NzIwMTkxMy4uYjRlNGE4Yzc5Yzc1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2hp
ZC9oaWQtbG9naXRlY2gtaGlkcHAuYworKysgYi9kcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlk
cHAuYwpAQCAtNDMxMCw2ICs0MzEwLDcgQEAgc3RhdGljIGludCBoaWRwcF9wcm9iZShzdHJ1Y3Qg
aGlkX2RldmljZSAqaGRldiwgY29uc3Qgc3RydWN0IGhpZF9kZXZpY2VfaWQgKmlkKQogCWJvb2wg
Y29ubmVjdGVkOwogCXVuc2lnbmVkIGludCBjb25uZWN0X21hc2sgPSBISURfQ09OTkVDVF9ERUZB
VUxUOwogCXN0cnVjdCBoaWRwcF9mZl9wcml2YXRlX2RhdGEgZGF0YTsKKwlib29sIHdpbGxfcmVz
dGFydCA9IGZhbHNlOwogCiAJLyogcmVwb3J0X2ZpeHVwIG5lZWRzIGRydmRhdGEgdG8gYmUgc2V0
IGJlZm9yZSB3ZSBjYWxsIGhpZF9wYXJzZSAqLwogCWhpZHBwID0gZGV2bV9remFsbG9jKCZoZGV2
LT5kZXYsIHNpemVvZigqaGlkcHApLCBHRlBfS0VSTkVMKTsKQEAgLTQzNjAsNiArNDM2MSw5IEBA
IHN0YXRpYyBpbnQgaGlkcHBfcHJvYmUoc3RydWN0IGhpZF9kZXZpY2UgKmhkZXYsIGNvbnN0IHN0
cnVjdCBoaWRfZGV2aWNlX2lkICppZCkKIAkJCXJldHVybiByZXQ7CiAJfQogCisJaWYgKGhpZHBw
LT5xdWlya3MgJiBISURQUF9RVUlSS19ERUxBWUVEX0lOSVQpCisJCXdpbGxfcmVzdGFydCA9IHRy
dWU7CisKIAlJTklUX1dPUksoJmhpZHBwLT53b3JrLCBkZWxheWVkX3dvcmtfY2IpOwogCW11dGV4
X2luaXQoJmhpZHBwLT5zZW5kX211dGV4KTsKIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZoaWRwcC0+
d2FpdCk7CkBAIC00Mzc0LDcgKzQzNzgsNyBAQCBzdGF0aWMgaW50IGhpZHBwX3Byb2JlKHN0cnVj
dCBoaWRfZGV2aWNlICpoZGV2LCBjb25zdCBzdHJ1Y3QgaGlkX2RldmljZV9pZCAqaWQpCiAJICog
UGxhaW4gVVNCIGNvbm5lY3Rpb25zIG5lZWQgdG8gYWN0dWFsbHkgY2FsbCBzdGFydCBhbmQgb3Bl
bgogCSAqIG9uIHRoZSB0cmFuc3BvcnQgZHJpdmVyIHRvIGFsbG93IGluY29taW5nIGRhdGEuCiAJ
ICovCi0JcmV0ID0gaGlkX2h3X3N0YXJ0KGhkZXYsIDApOworCXJldCA9IGhpZF9od19zdGFydCho
ZGV2LCB3aWxsX3Jlc3RhcnQgPyAwIDogY29ubmVjdF9tYXNrKTsKIAlpZiAocmV0KSB7CiAJCWhp
ZF9lcnIoaGRldiwgImh3IHN0YXJ0IGZhaWxlZFxuIik7CiAJCWdvdG8gaGlkX2h3X3N0YXJ0X2Zh
aWw7CkBAIC00NDExLDYgKzQ0MTUsNyBAQCBzdGF0aWMgaW50IGhpZHBwX3Byb2JlKHN0cnVjdCBo
aWRfZGV2aWNlICpoZGV2LCBjb25zdCBzdHJ1Y3QgaGlkX2RldmljZV9pZCAqaWQpCiAJCQloaWRw
cC0+d2lyZWxlc3NfZmVhdHVyZV9pbmRleCA9IDA7CiAJCWVsc2UgaWYgKHJldCkKIAkJCWdvdG8g
aGlkX2h3X2luaXRfZmFpbDsKKwkJcmV0ID0gMDsKIAl9CiAKIAlpZiAoY29ubmVjdGVkICYmICho
aWRwcC0+cXVpcmtzICYgSElEUFBfUVVJUktfQ0xBU1NfV1RQKSkgewpAQCAtNDQyNSwxOSArNDQz
MCwyMSBAQCBzdGF0aWMgaW50IGhpZHBwX3Byb2JlKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCBj
b25zdCBzdHJ1Y3QgaGlkX2RldmljZV9pZCAqaWQpCiAKIAloaWRwcF9jb25uZWN0X2V2ZW50KGhp
ZHBwKTsKIAotCS8qIFJlc2V0IHRoZSBISUQgbm9kZSBzdGF0ZSAqLwotCWhpZF9kZXZpY2VfaW9f
c3RvcChoZGV2KTsKLQloaWRfaHdfY2xvc2UoaGRldik7Ci0JaGlkX2h3X3N0b3AoaGRldik7CisJ
aWYgKHdpbGxfcmVzdGFydCkgeworCQkvKiBSZXNldCB0aGUgSElEIG5vZGUgc3RhdGUgKi8KKwkJ
aGlkX2RldmljZV9pb19zdG9wKGhkZXYpOworCQloaWRfaHdfY2xvc2UoaGRldik7CisJCWhpZF9o
d19zdG9wKGhkZXYpOwogCi0JaWYgKGhpZHBwLT5xdWlya3MgJiBISURQUF9RVUlSS19OT19ISURJ
TlBVVCkKLQkJY29ubmVjdF9tYXNrICY9IH5ISURfQ09OTkVDVF9ISURJTlBVVDsKKwkJaWYgKGhp
ZHBwLT5xdWlya3MgJiBISURQUF9RVUlSS19OT19ISURJTlBVVCkKKwkJCWNvbm5lY3RfbWFzayAm
PSB+SElEX0NPTk5FQ1RfSElESU5QVVQ7CiAKLQkvKiBOb3cgZXhwb3J0IHRoZSBhY3R1YWwgaW5w
dXRzIGFuZCBoaWRyYXcgbm9kZXMgdG8gdGhlIHdvcmxkICovCi0JcmV0ID0gaGlkX2h3X3N0YXJ0
KGhkZXYsIGNvbm5lY3RfbWFzayk7Ci0JaWYgKHJldCkgewotCQloaWRfZXJyKGhkZXYsICIlczpo
aWRfaHdfc3RhcnQgcmV0dXJuZWQgZXJyb3JcbiIsIF9fZnVuY19fKTsKLQkJZ290byBoaWRfaHdf
c3RhcnRfZmFpbDsKKwkJLyogTm93IGV4cG9ydCB0aGUgYWN0dWFsIGlucHV0cyBhbmQgaGlkcmF3
IG5vZGVzIHRvIHRoZSB3b3JsZCAqLworCQlyZXQgPSBoaWRfaHdfc3RhcnQoaGRldiwgY29ubmVj
dF9tYXNrKTsKKwkJaWYgKHJldCkgeworCQkJaGlkX2VycihoZGV2LCAiJXM6aGlkX2h3X3N0YXJ0
IHJldHVybmVkIGVycm9yXG4iLCBfX2Z1bmNfXyk7CisJCQlnb3RvIGhpZF9od19zdGFydF9mYWls
OworCQl9CiAJfQogCiAJaWYgKGhpZHBwLT5xdWlya3MgJiBISURQUF9RVUlSS19DTEFTU19HOTIw
KSB7Ci0tIAoyLjM4LjEKCg==


--=-OvH/z0DPZjhe91+lGS7D--
