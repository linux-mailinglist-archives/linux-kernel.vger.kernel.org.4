Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DE7223E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFEKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjFEKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:54:26 -0400
X-Greylist: delayed 96 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 03:54:24 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332EFEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:54:23 -0700 (PDT)
X-QQ-GoodBg: 0
X-QQ-SSF: 0020000000000050
X-QQ-FEAT: q2IHZsLIAbj5AxpmXnqEnoSbEBnmly2KsHAeliX8VLdm3GtVo5aMJjCropIRt
        Uj8kiW2B2j2S7Ak6F65pg3Ln6HatLuNglBbsZnv2ASPnDWto3hvBDP+P6a7aUtAmdAo5Vor
        6lfNeUJxABOjNZ3PHli+8KzIgKjrEORgFzWO3tNs/+hkmzB+0urpeBWSZcSyopZl7fv0ItL
        YNDXP3vrBYeR2rGBLr6xPkh+5ST9s3nfgjPXZiKornR4IdxajS42BHpSLkP00lb7RSndDFn
        FJlyzer3++fWsd/vkVG3Ek9wx42XZV3VF1iwJLvrOmeQbSqLe0KrmYxeBXYylENpao2Mz6B
        wRYxkxiNyhae4YlHvHIin+1JGRA3Q==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 221.226.231.35
X-QQ-STYLE: 
X-QQ-mid: logic304t1685962334t5322315
From:   "=?utf-8?B?U29uZyBTaHVhaQ==?=" <songshuaishuai@tinylab.org>
To:     "=?utf-8?B?YWxleGdoaXRp?=" <alexghiti@rivosinc.com>,
        "=?utf-8?B?cm9iaA==?=" <robh@kernel.org>,
        "=?utf-8?B?YWpvbmVz?=" <ajones@ventanamicro.com>,
        "=?utf-8?B?YW51cA==?=" <anup@brainfault.org>,
        "=?utf-8?B?cGFsbWVy?=" <palmer@rivosinc.com>,
        "=?utf-8?B?amVlaGVuZy5zaWE=?=" <jeeheng.sia@starfivetech.com>,
        "=?utf-8?B?bGV5Zm9vbi50YW4=?=" <leyfoon.tan@starfivetech.com>,
        "=?utf-8?B?bWFzb24uaHVv?=" <mason.huo@starfivetech.com>,
        "=?utf-8?B?cGF1bC53YWxtc2xleQ==?=" <paul.walmsley@sifive.com>,
        "=?utf-8?B?Y29ub3IuZG9vbGV5?=" <conor.dooley@microchip.com>,
        "=?utf-8?B?Z3VvcmVu?=" <guoren@kernel.org>
Cc:     "=?utf-8?B?bGludXgtcmlzY3Y=?=" <linux-riscv@lists.infradead.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Bug report: kernel paniced while booting  
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 5 Jun 2023 10:52:14 +0000
X-Priority: 3
Message-ID: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 9876853723717290176
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Mon, 05 Jun 2023 18:52:16 +0800 (CST)
Feedback-ID: logic:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVzY3JpcHRpb24gb2YgcHJvYmxlbToNCg0KQm9vdGluZyBMaW51eCBXaXRoIFJpc2NWVmly
dFFlbXUgZWRrMiBmaXJtd2FyZSwgYSBTdG9yZS9BTU8gcGFnZSBmYXVsdCB3YXMgdHJhcHBl
ZCB0byB0cmlnZ2VyIGEga2VybmVsIHBhbmljLg0KVGhlIGVudGlyZSBsb2cgaGFzIGJlZW4g
cG9zdGVkIGF0IHRoaXMgbGluayA6IGh0dHBzOi8vdGVybWJpbi5jb20vbmdhNC4NCg0KWW91
IGNhbiByZXByb2R1Y2UgaXQgd2l0aCB0aGUgZm9sbG93aW5nIHN0ZXAgOg0KDQoxLiBwcmVw
YXJlIHRoZSBlbnZpcm9ubWVudCB3aXRoIA0KICAgLSBRZW11LXZpcnQ6ICB2OC4wLjAgKHdp
dGggT3BlblNiaSB2MS4yKQ0KICAgLSBlZGsyIDogYXQgY29tbWl0ICgyYmM4NTQ1ODgzICJV
ZWZpQ3B1UGtnL0NwdVBhZ2VUYWJsZUxpYjogUmVkdWNlIHRoZSBudW1iZXIgb2YgcmFuZG9t
IHRlc3RzIikNCiAgIC0gTGludXggOiB2Ni40LXJjMSBhbmQgbGF0ZXIgdmVyc2lvbiANCg0K
Mi4gc3RhcnQgdGhlIFFlbXUgdmlydCBib2FyZCAgDQogICANCmBgYHNoDQokIGNhdCB+Lzhf
cmlzY3Yvc3RhcnRfbGF0ZXN0LnNoDQojIS9iaW4vYmFzaA0KL2hvbWUvc29uZy84X3Jpc2N2
LzNfYWNwaS9xZW11L29vby91c3IvbG9jYWwvYmluL3FlbXUtc3lzdGVtLXJpc2N2NjQgXA0K
ICAgICAgICAtcyAtbm9ncmFwaGljIC1kcml2ZSBmaWxlPS9ob21lL3NvbmcvOF9yaXNjdi8z
X2FjcGkvQnVpbGRfdmlydC9SaXNjVlZpcnRRZW11L1JFTEVBU0VfR0NDNS9GVi9SSVNDVl9W
SVJULmZkLGlmPXBmbGFzaCxmb3JtYXQ9cmF3LHVuaXQ9MSBcICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAg
ICAgICAgLW1hY2hpbmUgdmlydCxhY3BpPW9mZiAtc21wIDIgLW0gMkcgXA0KICAgICAgICAt
a2VybmVsIC9ob21lL3NvbmcvOV9saW51eC9saW51eC8wMF9ydl9kZWYvYXJjaC9yaXNjdi9i
b290L0ltYWdlIFwNCiAgICAgICAgLWluaXRyZCAvaG9tZS9zb25nLzhfcmlzY3YvM19hY3Bp
L2J1aWxkcm9vdC9vdXRwdXQvaW1hZ2VzL3Jvb3Rmcy5leHQyIFwNCiAgICAgICAgLWFwcGVu
ZCAicm9vdD0vZGV2L3JhbSBybyBjb25zb2xlPXR0eVMwIGVhcmx5Y29uPXVhcnQ4MjUwLG1t
aW8sMHgxMDAwMDAwMCBlZmk9ZGVidWcgbG9nbGV2ZWw9OCBtZW1ibG9jaz1kZWJ1ZyIgIyMg
YWxzbyBwYW5pYyBieSBtZW10ZXN0DQpgYGANCjMuIFRoZW4geW91IHdpbGwgZW5jb3VudGVy
IHRoZSBrZXJuZWwgcGFuaWMgbG9nZ2VkIGluIHRoZSBhYm92ZSBsaW5rDQoNCk90aGVyIElu
Zm9ybWF0aW9uOg0KDQoxLiAtLS0tLS0tDQoNClRoaXMgcmVwb3J0IGlzIG5vdCBpZGVudGlj
YWwgdG8gbXkgcHJpb3IgcmVwb3J0IC0tICJrZXJuZWwgcGFuaWNlZCB3aGVuIHN5c3RlbSBo
aWJlcm5hdGVzIiBbMV0sIGJ1dCBib3RoIG9mIHRoZW0gDQphcmUgY2xvc2VseSByZWxhdGVk
IHdpdGggdGhlIGNvbW1pdCAoMzMzNTA2OGY4NzIxICJyaXNjdjogVXNlIFBVRC9QNEQvUEdE
IHBhZ2VzIGZvciB0aGUgbGluZWFyIG1hcHBpbmciKS4NCg0KV2l0aCB0aGlzIGNvbW1pdCwg
aGliZXJuYXRpb24gaXMgdHJhcHBlZCB3aXRoICJhY2Nlc3MgZmF1bHQiIHdoaWxlIGFjY2Vz
c2luZyB0aGUgUE1QLXByb3RlY3RlZCByZWdpb25zIChtbW9kZV9yZXN2MEA4MDAwMDAwMCkg
DQpmcm9tIE9wZW5TYmkgKEJUVywgaGliZXJuYXRpb24gaXMgbWFya2VkIGFzIG5vbnBvcnRh
YmxlIGJ5IENvbm9yWzJdKS4NCg0KSW4gdGhpcyByZXBvcnQsIGVmaV9pbml0IGhhbmRvZmZz
IHRoZSBtZW1vcnkgbWFwcGluZyBmcm9tIEJvb3QgU2VydmljZXMgdG8gbWVtYmxvY2sgd2hl
cmUgcmVzZXJ2ZXMgbW1vZGVfcmVzdjBAODAwMDAwMDAsIA0Kc28gdGhlcmUgaXMgbm8gImFj
Y2VzcyBmYXVsdCIgYnV0ICJwYWdlIGZhdWx0Ii4NCg0KQW5kIHJldmVydGluZyBjb21taXQg
MzMzNTA2OGY4NzIxIGluZGVlZCBmaXhlZCB0aGlzIHBhbmljLg0KDQoyLiAtLS0tLS0tDQog
ICANCkFzIHRoZSBnZGItcHQtZHVtcCBbM10gdG9vbCBzaG93cywgdGhlIFBURSB3aGljaCBj
b3ZlcmVkIHRoZSBmYXVsdCB2aXJ0dWFsIGFkZHJlc3MgaGFkIHRoZSBhcHByb3ByaWF0ZSBw
ZXJtaXNzaW9uIHRvIHN0b3JlLiANCklzIHRoZXJlIGFub3RoZXIgd2F5IHRvIHRyaWdnZXIg
dGhlICJTdG9yZS9BTU8gcGFnZSBmYXVsdCI/IE9yIHRoZSBjcmVhdGlvbiBvZiBsaW5lYXIg
bWFwcGluZyBpbiBjb21taXQgMzMzNTA2OGY4NzIxIGRpZCBzb21ldGhpbmcgd3Jvbmc/DQoN
CmBgYA0KKGdkYikgcC94ICRzYXRwDQokMSA9IDB4YTAwMDAwMDAwMDA4MTcwOA0KKGdkYikg
cHQgLXNhdHAgMHhhMDAwMDAwMDAwMDgxNzA4DQogICAgICAgICAgICAgQWRkcmVzcyA6ICAg
ICBMZW5ndGggICBQZXJtaXNzaW9ucyAgICANCiAgMHhmZjFiZmZmZmZlYTM5MDAwIDogICAg
IDB4MTAwMCB8IFc6MSBYOjAgUjoxIFM6MQ0KICAweGZmMWJmZmZmZmViZjkwMDAgOiAgICAg
MHgxMDAwIHwgVzoxIFg6MCBSOjEgUzoxDQogIDB4ZmYxYmZmZmZmZWMwMDAwMCA6ICAgMHg0
MDAwMDAgfCBXOjEgWDowIFI6MSBTOjENCiAgMHhmZjYwMDAwMDAwMDAwMDAwIDogICAweDFj
MDAwMCB8IFc6MSBYOjAgUjoxIFM6MQ0KICAweGZmNjAwMDAwMDAyMDAwMDAgOiAgIDB4YTAw
MDAwIHwgVzowIFg6MCBSOjEgUzoxDQogIDB4ZmY2MDAwMDAwMGMwMDAwMCA6IDB4N2YwMDAw
MDAgfCBXOjEgWDowIFI6MSBTOjEgIC8vIGJhZGFkZHI6IGZmNjAwMDAwN2ZkYjEwMDANCiAg
MHhmZjYwMDAwMDdmZGMwMDAwIDogICAgMHgzZDAwMCB8IFc6MSBYOjAgUjoxIFM6MQ0KICAw
eGZmNjAwMDAwN2ZmYmYwMDAgOiAgICAgMHgxMDAwIHwgVzoxIFg6MCBSOjEgUzoxDQogIDB4
ZmZmZmZmZmY4MDAwMDAwMCA6ICAgMHhjMDAwMDAgfCBXOjAgWDoxIFI6MSBTOjENCiAgMHhm
ZmZmZmZmZjgwYzAwMDAwIDogICAweGEwMDAwMCB8IFc6MSBYOjAgUjoxIFM6MQ0KDQpgYGAN
Cg0KMy4gLS0tLS0tDQogICANCllvdSBjYW4gYWxzbyByZXByb2R1Y2Ugc2ltaWxhciBwYW5p
YyBieSBhcHBlbmRpbmcgIm1lbXRlc3QiIGluIGtlcm5lbCBjbWRsaW5lLg0KSSBoYXZlIHBv
c3RlZCB0aGUgbWVtdGVzdCBib290IGxvZyBhdCB0aGlzIGxpbms6IGh0dHBzOi8vdGVybWJp
bi5jb20vMXR3bC4NCg0KUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KDQpbMV06
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2L0NBQVlzMj1nUXZraFRlaW9N
bXFSRFZHamR0TkZfdmhCK3ZtXzFkSEp4UE5pNzVZRFFfUUBtYWlsLmdtYWlsLmNvbS8NClsy
XTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMzA1MjYtYXN0cmlk
ZS1kZXRvbmF0b3ItOWFlMTIwMDUxMTU5QHdlbmR5Lw0KWzNdOiBodHRwczovL2dpdGh1Yi5j
b20vbWFydGlucmFkZXYvZ2RiLXB0LWR1bXA=

