Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC35E8A04
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiIXITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiIXISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:18:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D07E220FC;
        Sat, 24 Sep 2022 01:17:12 -0700 (PDT)
Received: from [192.168.0.74] ([84.175.93.28]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIbzB-1oWj0Z08jl-00EcnP; Sat, 24 Sep 2022 10:16:34 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     mathias.nyman@intel.com
Subject: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96
 controller
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 24 Sep 2022 08:16:34 +0000
Message-Id: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------=_MB532E2D77-72CD-4502-83A0-2E7D4BF8CAEA"
X-Antivirus: Avast (VPS 220923-4, 23.9.2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:j/CgaF6gU18/AcFhUknKikKnBu+yAZ48N2wNrAkx2SvBu4RXOPC
 irE21aSuxaAISjZ40nLpitJ7UXFcep/vcuPKm/CkPNP4WmC4v6sdcLMeB8w+Br/StOE/rFW
 FS6MR71Fakfj8ww0yhh871FGILgkSbSd+VUIZK1e2T//z4sO0Koqmm9VrodM5B11+1x308l
 0evbaHvgLLV5WuKTt4nsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kDHwy07K4eU=:bDS06RWxE4m6Bwlz5sA+v8
 9OOEu6bOOxz928GOog/RN1LDgd0aIsHIZyiaVgaAeM2/cSusyBX06pDu7vpxkqxIZZsnugDx+
 otZmqDeX7kTcHuo5ojUJOiuRB7FYEZRUICGOieG34IjdC3b3ByNXUTD9W9BJ4zFs+DJ8XuXL4
 HkpJMsSwPIoP5ipWItzBCzGdwMfenbfp5f+00hmPQx/CmAXepLVm76Oo4g9GM1VlOqG4WAlqH
 ov+UoRl0ogpL/GYs+A42S74zH2MVb3iJI1gofzdpy1loEofN1WNQg3m/BmoVNyECmhDlx487t
 bNIcvjdYQZcpR8CY16hTiojeDrTbjbFnt59+jqO1CwMtsXF0IXc/X5oOmC/28hOomYg4Pm3pl
 gv30U6FMUU83eIG/PBXO2BVGl0WrWGYyId1XQOIHRg04IkyUH7UwiF70cHZ9iY7xeszCMiks5
 292YCN79GpZ83nPlvyk3ry0KG7r0gRV5A0PbAskmKKbSQxUaf8y7zBFHlHuEKo/u25VBQahR/
 ru3m0jI6p/ptETvafDbfTqk67ajHDKZCSbmGg2FNoFRExQZlNEp8atLZWnZF7gziJIR7tIQYO
 S6NZviNXjO3pPVxuQBClBcTpg3k+8MC4toLmgbfOTN+iN4Ur/AEd0vj3htT2jqcmd9Oec3Alf
 1TlT8kJ42f2P03zJ2l74afVLG1OLIHTJXPtMkqgNK/mFfKLzPUi9L3rq/nP/WR3zzRmKKcBlK
 U8JULpJT2xbTGUVgMnadPVLs67T8eY7VZS0l+46n5k8/qmzLdsZT0zqZlwkm70lKLL9EEfTee
 bnenRJ9uCYBpxA6ZCx1xNU3VWDslw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------=_MB532E2D77-72CD-4502-83A0-2E7D4BF8CAEA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi there,

second try at a patch which was an actual pain with my Lenovo T500 notebook=
, augmented with an USB3 PCMCIA card that has an ASM1042 chip. Inspired by=
 this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3

ASM1042 identifies as a 0x96 XHCI host, brings spurious transfer event erro=
rs with a r8152 (Realtek 8153a) USB3 enthernet adapter. Additionally settin=
g quirk XHCI_SPURIOUS_SUCCESS seems to resolve this issue in this case.

with best regards

Jens Glathe

---

v1->v2

intensive use of scripts/checkpatch.pl, reformatted the code
reformatted the commit text for line wraps
--------=_MB532E2D77-72CD-4502-83A0-2E7D4BF8CAEA
Content-Type: text/plain;
 name=0001-fix-add-XHCI_SPURIOUS_SUCCESS-to-ASM1042-despite-bei.patch;
 charset=iso-8859-1
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-fix-add-XHCI_SPURIOUS_SUCCESS-to-ASM1042-despite-bei.patch

RnJvbSBmZmIzYTcwYTQ4YjkxYjc5OTQzYTAxMzFkZGQ0NzBlNWYwOWMwZjQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEdsYXRoZSA8amVucy5nbGF0aGVAb2xkc2Nob29sc29s
dXRpb25zLmJpej4KRGF0ZTogU3VuLCAyOCBBdWcgMjAyMiAxNjoyMzo0MSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGZpeDogYWRkIFhIQ0lfU1BVUklPVVNfU1VDQ0VTUyB0byBBU00xMDQyIGRlc3Bp
dGUgYmVpbmcgYQogVjAuOTYgY29udHJvbGxlcgoKb25seSBpZiBpdCByZXBvcnRzIGFzIGEgVjAu
OTYgWEhDSSBjb250cm9sbGVyLiBBcHBlYXJzIHRvIGZpeCB0aGUgZXJyb3JzCiJ4aGNpX2hjZCA8
YWRkcmVzcz47IEVSUk9SIFRyYW5zZmVyIGV2ZW50IFRSQiBETUEgcHRyIG5vdCBwYXJ0IG9mCmN1
cnJlbnQgVEQgZXBfaW5kZXggMiBjb21wX2NvZGUgMTMiIHRoYXQgYXBwZWFyIHNwdXJpb3VzbHkg
KG9yIHByZXR0eQpvZnRlbikgd2hlbiB1c2luZyBhIHI4MTUyIFVTQjMgZXRoZXJuZXQgYWRhcHRl
ciB3aXRoIGludGVncmF0ZWQgaHViLgoKU2lnbmVkLW9mZi1ieTogSmVucyBHbGF0aGUgPGplbnMu
Z2xhdGhlQG9sZHNjaG9vbHNvbHV0aW9ucy5iaXo+Ci0tLQogZHJpdmVycy91c2IvaG9zdC94aGNp
LXBjaS5jIHwgMTAgKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMg
Yi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMKaW5kZXggZGNlNmMwZWM4ZDM0Li5mOGIzYjM0
ZDI1N2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYworKysgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMKQEAgLTMwNSw5ICszMDUsMTMgQEAgc3RhdGljIHZvaWQg
eGhjaV9wY2lfcXVpcmtzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHhoY2lfaGNkICp4aGNp
KQogCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9FUF9DVFhfQlJPS0VOX0RDUzsKIAl9CiAKLQlpZiAo
cGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfQVNNRURJQSAmJgotCQlwZGV2LT5kZXZpY2Ug
PT0gUENJX0RFVklDRV9JRF9BU01FRElBXzEwNDJfWEhDSSkKLQkJeGhjaS0+cXVpcmtzIHw9IFhI
Q0lfQlJPS0VOX1NUUkVBTVM7CisgIGlmIChwZGV2LT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9B
U01FRElBICYmCisgICAgICBwZGV2LT5kZXZpY2UgPT0gUENJX0RFVklDRV9JRF9BU01FRElBXzEw
NDJfWEhDSSkgeworICAgIC8qIHRyeSB0byB0YW1lIHRoZSBBU01lZGlhIDEwNDIgY29udHJvbGxl
ciB3aGljaCBpcyAwLjk2ICovCisgICAgaWYgKHhoY2ktPmhjaV92ZXJzaW9uID09IDB4OTYpCisg
ICAgICB4aGNpLT5xdWlya3MgfD0gWEhDSV9TUFVSSU9VU19TVUNDRVNTOworICAgIHhoY2ktPnF1
aXJrcyB8PSBYSENJX0JST0tFTl9TVFJFQU1TOworICB9CiAJaWYgKHBkZXYtPnZlbmRvciA9PSBQ
Q0lfVkVORE9SX0lEX0FTTUVESUEgJiYKIAkJcGRldi0+ZGV2aWNlID09IFBDSV9ERVZJQ0VfSURf
QVNNRURJQV8xMDQyQV9YSENJKSB7CiAJCXhoY2ktPnF1aXJrcyB8PSBYSENJX1RSVVNUX1RYX0xF
TkdUSDsKLS0gCjIuMjUuMQoK
--------=_MB532E2D77-72CD-4502-83A0-2E7D4BF8CAEA--

