Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724EB6B8FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCNKU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCNKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:20:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8631CAEA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:20:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-n0HSWIblNNm6kDcCCrU-UQ-1; Tue, 14 Mar 2023 10:13:30 +0000
X-MC-Unique: n0HSWIblNNm6kDcCCrU-UQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Tue, 14 Mar
 2023 10:11:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Tue, 14 Mar 2023 10:11:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hans Verkuil' <hverkuil-cisco@xs4all.nl>,
        'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ming.qian@nxp.com" <ming.qian@nxp.com>,
        "shijie.qin@nxp.com" <shijie.qin@nxp.com>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "bin.liu@mediatek.com" <bin.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "tiffany.lin@mediatek.com" <tiffany.lin@mediatek.com>,
        "andrew-ct.chen@mediatek.com" <andrew-ct.chen@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        "stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
        "quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Thread-Topic: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Thread-Index: AQHZVddlMXgQQm2s8UOyg8hXE6z+xq75Vx6AgACikACAABQ/MA==
Date:   Tue, 14 Mar 2023 10:11:07 +0000
Message-ID: <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-3-benjamin.gaignard@collabora.com>
 <20230313181155.GC22646@pendragon.ideasonboard.com>
 <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
 <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
In-Reply-To: <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGFucyBWZXJrdWlsDQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjMgMDg6NTUNCi4uLg0KPiBX
aHkgbm90IHN0YXJ0IHdpdGggYSBkeW5hbWljYWxseSBhbGxvY2F0ZWQgYXJyYXkgb2YgMzIgdmIy
X2J1ZmZlciBwb2ludGVycz8NCj4gQW5kIGtlZXAgZG91YmxpbmcgdGhlIHNpemUgKHJlYWxsb2Np
bmcpIHdoZW5ldmVyIG1vcmUgYnVmZmVycyBhcmUgbmVlZGVkLA0KPiB1cCB0byBzb21lIG1heGlt
dW0gKDEwMjQgd291bGQgYmUgYSBnb29kIGluaXRpYWwgdmFsdWUgZm9yIHRoYXQsIEkgdGhpbmsp
Lg0KPiBUaGlzIG1heCBjb3VsZCBiZSBldmVuIGEgbW9kdWxlIG9wdGlvbi4NCg0KSSBkb24ndCBr
bm93IHRoZSB0eXBpY2FsIHVzZXMgKG9yIHRoZSBjb2RlIGF0IGFsbCkuDQpCdXQgaXQgbWlnaHQg
YmUgd29ydGggaGF2aW5nIGEgc21hbGwgYXJyYXkgaW4gdGhlIHN0cnVjdHVyZSBpdHNlbGYuDQpV
c2VmdWwgaWYgdGhlcmUgYXJlIHR5cGljYWxseSBhbHdheXMgKHNheSkgbGVzcyB0aGFuIDggYnVm
ZmVycy4NCkZvciBsYXJnZXIgc2l6ZXMgdXNlIHRoZSAoSUlSQykga21hbGxvY19zaXplKCkgdG8g
ZmluZCB0aGUgYWN0dWFsDQpzaXplIG9mIHRoZSBzdHJ1Y3R1cmUgdGhhdCB3aWxsIGJlIGFsbG9j
YXRlIGFuZCBzZXQgdGhlIGFycmF5DQpzaXplIGFwcHJvcHJpYXRlbHkuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

