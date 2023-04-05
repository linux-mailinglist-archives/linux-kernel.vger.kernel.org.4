Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959556D85DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjDESUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:19:58 -0400
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 11:19:55 PDT
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCF65BB;
        Wed,  5 Apr 2023 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680718425;
        bh=PrBEdRTWFt2+Tb4vOBv+FXYDihwroSUjl5utTBCfUhU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=yXhxsjdwvbXgvRLC0de/B1cIvr//vjm+Rvg3F+4K46WSqRLM2NLI9dqQMbV80k2gE
         DtG5zHhgrYsgQTebkuXHpeYE17oNFZHT6bSFYpwZJ2alpwUeChZxWqFIMvT7iuflFe
         wpRng1Tn2Qxp4oj1yjVjD9/kgGkPs9UliAjSt987sqDiJcMEbdF42TDS1V70mPDqPQ
         6io2V1xb5EnChlDjdn+3QENPYRmNj8DvzFGwT2PHAoxHzEt55aJRPxCpKGax9Kz2Hw
         UJaUC/RhDc/vv/aGugtJgngIAbt7vpGtPAcJ4rNDwMuD8yibXxh/qaktlhNyz4dctq
         qivN6C2T2XFYg==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: arm: fsl: Add Marantec maveo box as a
 DHCOR i.MX6ULL SoM based board
Thread-Topic: [PATCH 1/2] dt-bindings: arm: fsl: Add Marantec maveo box as a
 DHCOR i.MX6ULL SoM based board
Thread-Index: AQHZZ9hJZt5Edzs0pE264fqdRW1Q9q8cxYcAgAA/BQA=
Date:   Wed, 5 Apr 2023 18:13:35 +0000
Message-ID: <62fb8dfc3254415e945beec67df129fd@dh-electronics.com>
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <842f1d7f-29e5-d1c3-f949-322f3f954b68@denx.de>
In-Reply-To: <842f1d7f-29e5-d1c3-f949-322f3f954b68@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogV2VkbmVzZGF5
LCBBcHJpbCA1LCAyMDIzIDY6MjYgUE0NCj4gT24gNC81LzIzIDE4OjAyLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBBZGQgTWFyYW50ZWMgbWF2ZW8gYm94LiBUaGUgc3lzdGVtIGlz
IHVzZWQgdG8gZ2V0IGEgc21hcnQgY29ubnRlY3Rpb24NCj4+IHRvIGEgZG9vciBkcml2ZS4gVGhl
IGNvcmUgb2YgdGhpcyBzeXN0ZW0gaXMgYSBzb2xkZXJlZCBpLk1YNlVMTCBESENPUg0KPj4gU29N
IGZyb20gREggZWxlY3Ryb25pY3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIE5p
ZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KPj4gLS0tDQo+PiBD
YzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCj4+IENjOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+PiBDYzogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPj4gQ0M6IExpIFlhbmcgPGxlb3lhbmcubGlAbnhw
LmNvbT4NCj4+IENjOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4+IENjOiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBkZW54LmRlPg0KPj4gQ2M6IE5YUCBMaW51eCBUZWFtIDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4+IENjOiBrZXJuZWxAZGgtZWxlY3Ryb25pY3MuY29tDQo+PiBDYzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+PiBUbzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+PiAtLS0N
Cj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCB8IDYg
KysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4+IGluZGV4
IGIxNzVmMmIxYmQzMC4uYzk1MjU0YzU3NTcxIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPj4gQEAgLTcxNyw2ICs3MTcsMTIg
QEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgICAgIC0gY29uc3Q6IGRoLGlteDZ1bGwtZGhjb3It
c29tDQo+PiAgICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14NnVsbA0KPj4NCj4+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBpLk1YNlVMTCBESENPUiBTb00gYmFzZWQgQm9hcmRzDQo+PiArICAgICAg
ICBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogZGgsaW14NnVsbC1kaGNvci1tYXZlby1i
b3gNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIHVzaW5nIE1hcmFudGVjIHZlbmRvciBwcmVmaXgsIG5v
dCAiZGgsIiBwcmVmaXggSSB0aGluayA/DQo+IA0KPiBZb3Ugc2hvdWxkIGFkZCB0aGF0IHRvDQo+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCBm
aXJzdCwgYW5kIHRoZW4NCj4gdXNlIGl0IGhlcmUuDQoNCkkgd2lsbCBjaGFuZ2UgaXQgaW4gdmVy
c2lvbiAyLg0K
