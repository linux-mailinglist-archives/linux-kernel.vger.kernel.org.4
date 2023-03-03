Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF28F6A99AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCCOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCCOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:39:07 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F82CC63
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:39:06 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1720433ba75so3127018fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677854345;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc/2NQRQk16ve/0Vl/Q/keTIxoyosmZ4FXbANNDHG5k=;
        b=av9wqLcFrNCMay7pR3EbCYJxNYFmfUOy5L8fZhZlaboYH7eTL/AgT/a8x/uyUaF/Gx
         nbSj1sQC/xHxBe9LD93skaewz8ZofPmbwaz/6NnOyJdX8v+MtrJEtJx6CJOHCApV1mRX
         H23mT5CRYNZcr3y2MyO5Wumrh1MJtCbqzNilHaiAEXbwGk7un/v7EDdsskKji3NzI5J2
         rcvKBoS8+4r/eI1tKld/LUn/gDKg2Ccr/Hg7SkjdcpqL0+PDPUrtS2ge/6EqhzsaTkOk
         b572BBbFQIrUyBz58DXrZnpP6aBYw9+O3A3lTvZwVrhOnnvVV8wPgwZMjhZXhnCf/iU+
         tgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677854345;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc/2NQRQk16ve/0Vl/Q/keTIxoyosmZ4FXbANNDHG5k=;
        b=xfnE7MzdLRr2z2BqWpXeXn0Eygpf/HTuAWr5CkfMzUyaJ25XBKXSuTTNhxglxrEGiE
         c08yGQ9i4/pBacEKx906Nj5XQEZCNkMUbrT5/VsfXw1UFs4PojZIJL+TU1dOSRLJ/KYV
         iZA8L0Xup9brCobC3mVQpsYzVDAlb5y4qEQ5OMvh2gdDvlQNg0pvZZFBYzy3nXcDEOmr
         IQrbMSk88YuDOKwXVYKYgPrcW5BgjA+0YDapzn3NCRV01WVCvPaA6gd+B4yoordCrehM
         Bwqv7lg2KT9l4RDIySQyBq18JacVSAbvAqylgPojxnZWwzJ6w1UbZCu4Dbeeh3d30Z9w
         ZFLg==
X-Gm-Message-State: AO0yUKVZX6laksyHhx7+JoqAGVe6zqsVix62KXzkgkiO14UFGO31LM6K
        mapmjR8ftpHLueua2N6P0rdcIWECiPmSEqwLJzLVZ9xdb8Q=
X-Google-Smtp-Source: AK7set8EYFbJy7/yP8ngOril92M3hPeIvooXXR7YwvgBpm/bO44L7ZWQh81YCl7PJIsMsL26jnm3xkXLjK7ez2bafQI=
X-Received: by 2002:a05:6870:5b13:b0:176:3cf8:e684 with SMTP id
 ds19-20020a0568705b1300b001763cf8e684mr652003oab.2.1677854345555; Fri, 03 Mar
 2023 06:39:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:3b87:0:0:0:0:0 with HTTP; Fri, 3 Mar 2023 06:39:05 -0800 (PST)
Reply-To: MarkDossou@consultant.com
From:   "MR. MARK DOSSOU" <officelawman40@gmail.com>
Date:   Fri, 3 Mar 2023 15:39:05 +0100
Message-ID: <CAEKRo_xTBMJTw1L5qb6HYDfQyVSMRu1M934mBNm2Zku-gk3Ymg@mail.gmail.com>
Subject: =?UTF-8?B?ccSrbifDoGkgZGUgUMOpbmd5x5J1LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,MIXED_ES,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TUFSSyBET1NTT1UmIExBV0ZJUk0mIEFzc29jaWF0ZXMNCmrDuiAwMSBCUCA3NTk0DQprxJMgdHXF
jSBux5QgMDIyOSBiw6hpIG7DrW5nIGfDsm5naMOpZ3XDsw0KDQpxxKtuJ8OgaSBkZSBQw6luZ3nH
knUsDQoNCm3Em2lox45vIGRlIHnEq3RpxIFuLCBux5AgaMeObyBtYT8gV8eSIHjEq3fDoG5nIGjE
m24gaMeOby4gSMSbbiBiw6BvcWnDoG4gemjDoG55w7JuZw0KbsOtbiBkZSBzaMOtamnEgW4geceQ
asOtIHTEgSBrxJtuw6luZyBodcOsIHLDoG5nIG7DrW4gc2jFjXUgZMOgbyB3x5IgZGUgeGnEgW94
xKsgw6lyDQpnx45uZMOgbyBqxKtuZ3nDoCwgemjDqCBqdcOpZHXDrCBzaMOsIHfHkiBjaMO6bGUg
emjDqCB6aMeSbmcgZsSBbmdmx44gemjEqyB3w6BpIG3DqWl5x5J1DQpyw6huaMOpIHHDrXTEgSBm
xIFuZ2bHjiBrxJt5x5AgamnEm2p1w6kgZGUgd8OobnTDrSwgZMOgbiB3x5IgaHXDrCB3w6hpIG7D
rW4gdMOtZ8WNbmcgZ8OobmcNCmR1xY0gc3XHkiB4xasgZGUgeMOsbnjEqywgc3XHknnHknUgd8eS
IHjFq3nDoG8gZGUgc2jDrCBuw61uIHpow61kw6kgeMOsbmzDoGkgZGUgaMOpenXDsiwNCnnHkCBx
dcOoYseObyB3x5IgYseOb2jDuSB5x5AgZ8O5IGvDqGjDuSBkZSB6aMOgbmdow7kgamnDoHpow60u
DQoNClfHkiBzaMOsIHnHkCBnw7kgZ8WNbmdjaMOpbmdzaMSrIGRlIEhvbiBCYXJyaXN0ZXIgTWFy
ayBEb3Nzb3Ugc8SrcsOpbiBsx5xzaMSrLg0KQWxleCAwMDAwMCwod8eSIHnHkCBnw7kgZGUga8Oo
aMO5KSBzaMOsIHnEqyBtw61uZyBodcOgeHXDqSBnxY1uZ2Now6luZ3NoxKssIHTEgSB6w6BpDQoy
MDEzIG5pw6FuIHnHlCBqacSBcsOpbiB5xKtxx5Agc8eQIHnDuiBjaMSTaHXDsi4gVMSBIHrDoGkg
eMSrZsSTaSBjw7NuZ3Now6wgeceUIHl1w6FuecOzdQ0KeGnEgW5nZ3XEgW4gZGUgecOod8O5LCBk
w6BuIHpow7kgesOgaSB3x5IgZGUgZ3XDs2ppxIEsIHfHkiBjaMeUbMeQIHTEgSBkZSBzdceSeceS
dQ0KZseObMecIHnDqHfDuS4NCg0KWcOzdXnDuiBsacOhbmjDqSB5w61uaMOhbmcgZMeSbmdzaMOs
aHXDrCB6w6BpIHTEgSBxw7lzaMOsIGjDsnUgemjHkHNow6wgd8eSIHjDum56aMeObw0KdMSBbWVu
IHnHkCBnw7kga8OoaMO5IGRlIGTDoCBxxKtuc2jHlCwgdMSBIGppxIFuZyB6dcOyd8OpaSB0xIEg
emjDoG5naMO5IGppw6B6aMOtIDEwLjcNCk3Em2l5dcOhbiBkZSBzaMOydXnDrCByw6luLCB5xKtu
Y8eQIHfHkiBxx5BuZ3Fpw7ogbsOtbiBkZSBow6l6dcOyIHnHkCBzaMWNdWh1w60gdMSBIGRlDQp6
xKtqxKtuIGLHjmkgd8OgbiBtxJtpeXXDoW4uIFLDumd1x5Igd8eSIGLDuW7DqW5nIGrHkG5rdcOg
aSB6aMeQZMOsbmcgcsOobmjDqSBzaMOydXnDrA0KcsOpbiwgZ8SBaSB6aMOgbmdow7kgamnEgW5n
IGLDqGkgbcOyc2jFjXUgd8OpaSB3w7ogcsOpbiByw6hubMeQbmcgZGUgesSrasSrbiwgecSrbnfD
qGkNCnTEgSB5x5BqxKtuZyB4acWrbWnDoW5sZSBqacSBbmdqw6xuIDEwIG5pw6FuLiBZxKtuY8eQ
LCB3x5IgeMSrd8OgbmcgbsOtbiBkZSBow6l6dcOyDQp0xY1uZ2d1w7IgaMOpZseOIHpox5Bkw6xu
ZyBuw61uIHp1w7J3w6lpIHNow7J1ecOsIHLDqW4gbMOhaSBxdcOoYseObyBqxKtqxKtuIGRlIMSB
bnF1w6FuLA0KecSrbnfDqGkgd8eSIGRlIGvDqGjDuSBxw7lzaMOsIHNow60gd8OoaSBsacO6IHhp
w6AgecOtemjHlCAodMSBIGRlIMOpcnppIGTDoCB3w6hpIHNow6wNCmrDrG5xxKtuKS4gV8eSIGpp
xIFuZyB3w6hpIG7DrW4gdMOtZ8WNbmcgc2jHkCBjx5AgamnEgW95w6wgaMOpZseOIGLDrG5nIHNo
xJNucceQbmcNCnrEq2rEq24gc2jDrGbDoG5nIHN1x5IgeMWrIGRlIHN1x5J5x5J1IHhpxIFuZ2d1
xIFuIHjDrG54xKsuDQoNCkbEgXPDsm5nIGfEm2kgd8eSIHhpw6BtacOgbiBkZSB4acOhbmd4w6wg
eMOsbnjEqywNCg0KbsOtbiBkZSBxdcOhbiBtw61uZzogLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQpM
acOhbnjDrCBkw6x6aMeQOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KTmnDoW5sw61u
ZzogLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQpTaMeSdWrEqyBow6BvbceOOiAu
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQpaaMOtecOoOiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4NCg0KR8eObnhpw6ggbsOtbiBodcSBIHNow61qacSBbiB5dcOoZMO6LCBy
w7pndceSIG7DrW4gbsOpbmcgY2jHlGzHkCBox45vLCB3x5IgamnEgW5nDQpkxJtuZ2TDoGkgbsOt
biBkZSBodcOtZsO5LiBaaMO5ecOsOiBRx5BuZyB0xY1uZ2d1w7Igd8eSIGRlIGRpw6BueseQIHnD
s3VqacOgbiBkw6x6aMeQDQooTWFya0Rvc3NvdUBjb25zdWx0YW50LkNvbSkgeGnDoG5nIHfHkiB0
w61nxY1uZyBzaMOgbmdzaMO5IHjDrG54xKssIHnHkCBodcOycceUDQpnw6huZyBkdcWNIHhpw6Fu
Z3jDrCB4w6xueMSrIGjDqSBsx5BqacSbLg0KDQpDx5B6aMOsLA0KbceOa8OowrdkdcWNIHN1x5Ig
eGnEgW5zaMSTbmcNCnDDrW5nZMSbbmcgeceUIGfFjW5ncMOtbmcgbMecc2jEqyBzaMOsd8O5IHN1
x5INCg==
