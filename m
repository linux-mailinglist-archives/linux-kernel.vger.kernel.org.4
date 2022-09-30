Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65B5F075A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiI3JPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiI3JOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:14:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC3252BA;
        Fri, 30 Sep 2022 02:14:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x29so4148235ljq.2;
        Fri, 30 Sep 2022 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=6ZdXt0+WRO/3Bc95XBFjbeowmeJu6ey2N0/xAaEy33I=;
        b=G2Hv+Z16JQHNrPK9LqoHSXTVHEQqL20EDCJabisewhwaVUPRu8K+/Puhn2k5zY++y6
         XcTopeQjMqsxsKpKIt43BSkbGihcISu9ZAp0lV+VA2VEGZByyWXBN/Vf9Qn1EUdvNYI7
         Zqw5PGD7ydLiVcA/NT+la3sGbB0ZCEIVaGaRW6ZcN+eYDfF9bQSo3U2kqO4OsoQokrXl
         Ql89SbdHWW7bQG95Qsaul0/yPZAGQAA4mxOd/ywyvXHukYffyQVQxNePzNuTRu2zVlLb
         on87Cer/BG+jdgVOO9sltOHLNs+r+zzhEl3dtvry/SA+CKVfrvMg1t4vq4SQUKqWu3/f
         eDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6ZdXt0+WRO/3Bc95XBFjbeowmeJu6ey2N0/xAaEy33I=;
        b=zbUjki6JvLntWuO5hVyin3nCNGQjDGTLlOteB73VLvYGZQaeAgxhwm5+tdVzq68A+H
         fw/TLHupP8HBaC/W2cAIoA8pD1Oxq9h/LjVqEovcCB6bjJ63tWSTUtY75teEUbV3gO7K
         0r+XzlXrJRnK5AisJ3/xk4mK0AEhAKtlLsgLqugQc2PEFHoAOiFskf0aMOVrHTb4gzc8
         IkuHP1IEbE5ozMPpwtiXrQiotJnHc7Q/7KhUgPrfSQ/l0VTy0rvqZgMdkzDTJx7pXZBD
         5+uDKf6UMSGW1DdOy2kebLmgojTKXZzZooh2aJa+0cKtjZIQpEnYTU1J6A8wpNL3QV8b
         0ghw==
X-Gm-Message-State: ACrzQf0DWGnyPv8AGXpqUFu6oMdZcvW+Q+SdclsOpQX0P52ZCz3sp3H4
        cFWg6W32dW6Gb4vbZONniv4U02CqDhvAaSu6KrnEuSjC2EdD8lv+i4M=
X-Google-Smtp-Source: AMsMyM4IoGXD+xVg0TXo82e3pXent3u0FJxeZ4DvmB4dNFPs7pU5s9agQ0HaMJr3Tstl9TpX2//lw2HR72L4dKfwyDs=
X-Received: by 2002:a2e:bd0e:0:b0:268:c03b:cf56 with SMTP id
 n14-20020a2ebd0e000000b00268c03bcf56mr2685920ljq.393.1664529285753; Fri, 30
 Sep 2022 02:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220930021936.26238-1-akiyks@gmail.com>
In-Reply-To: <20220930021936.26238-1-akiyks@gmail.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 30 Sep 2022 17:14:09 +0800
Message-ID: <CAJy-Am=B1r=_xY+Fv4t4HkTK70SPP5bOjYVfwsPQ3nX2HtG-8Q@mail.gmail.com>
Subject: Re: [PATCH] docs/howto: Replace abundoned URL of gmane.org
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEdGTQ0KUmV2aWV3ZWQtYnk6IEFsZXggU2hpIDxhbGV4c0BrZXJuZWwub3JnPg0KDQpPbiBGcmks
IFNlcCAzMCwgMjAyMiBhdCAxMDoyMCBBTSBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNv
bT4gd3JvdGU6DQo+DQo+IFNvbWVob3csIHRoZXJlIHJlbWFpbnMgYSBsaW5rIHRvIGdtYW5lLm9y
Zywgd2hpY2ggc3RvcHBlZCB3b3JraW5nDQo+IGluIDIwMTYsIGluIGhvd3RvLnJzdC4gUmVwbGFj
ZSBpdCB3aXRoIHRoZSBvbmUgYXQgbG9yZS5rZXJuZWwub3JnLg0KPiBEbyB0aGUgc2FtZSBjaGFu
Z2VzIHVuZGVyIHRyYW5zbGF0aW9ucy8gYXMgd2VsbC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQWtp
cmEgWW9rb3Nhd2EgPGFraXlrc0BnbWFpbC5jb20+DQo+IENjOiBGZWRlcmljbyBWYWdhIDxmZWRl
cmljby52YWdhQHZhZ2EucHYuaXQ+DQo+IENjOiBBbGV4IFNoaSA8YWxleHNAa2VybmVsLm9yZz4N
Cj4gQ2M6IFlhbnRlbmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5jbj4NCj4gQ2M6IEh1IEhhb3dl
biA8c3JjLnJlc0BlbWFpbC5jbj4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvaG93
dG8ucnN0ICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gIERvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL2l0X0lUL3Byb2Nlc3MvaG93dG8ucnN0IHwgMiArLQ0KPiAgRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0ICAgICAgICAgfCAyICstDQo+ICBEb2N1bWVudGF0
aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9ob3d0by5yc3QgICAgICAgICB8IDIgKy0NCj4gIERvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvaG93dG8ucnN0IHwgMiArLQ0KPiAg
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfVFcvcHJvY2Vzcy9ob3d0by5yc3QgfCAyICst
DQo+ICA2IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9ob3d0by5yc3QgYi9Eb2N1bWVu
dGF0aW9uL3Byb2Nlc3MvaG93dG8ucnN0DQo+IGluZGV4IGNkNjk5N2E5ZDIwMy4uYmQxNWMzOTNi
YTNjIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvaG93dG8ucnN0DQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9ob3d0by5yc3QNCj4gQEAgLTM3OSw3ICszNzksNyBA
QCB0byBzdWJzY3JpYmUgYW5kIHVuc3Vic2NyaWJlIGZyb20gdGhlIGxpc3QgY2FuIGJlIGZvdW5k
IGF0Og0KPiAgVGhlcmUgYXJlIGFyY2hpdmVzIG9mIHRoZSBtYWlsaW5nIGxpc3Qgb24gdGhlIHdl
YiBpbiBtYW55IGRpZmZlcmVudA0KPiAgcGxhY2VzLiAgVXNlIGEgc2VhcmNoIGVuZ2luZSB0byBm
aW5kIHRoZXNlIGFyY2hpdmVzLiAgRm9yIGV4YW1wbGU6DQo+DQo+IC0gICAgICAgaHR0cDovL2Rp
ci5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsDQo+ICsgICAgICAgaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8NCj4NCj4gIEl0IGlzIGhpZ2hseSByZWNvbW1lbmRlZCB0aGF0IHlvdSBz
ZWFyY2ggdGhlIGFyY2hpdmVzIGFib3V0IHRoZSB0b3BpYw0KPiAgeW91IHdhbnQgdG8gYnJpbmcg
dXAsIGJlZm9yZSB5b3UgcG9zdCBpdCB0byB0aGUgbGlzdC4gQSBsb3Qgb2YgdGhpbmdzDQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL2hvd3Rv
LnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2l0X0lUL3Byb2Nlc3MvaG93dG8ucnN0
DQo+IGluZGV4IDE2YWQ1NjIyZDU0OS4uMTVjMDhhZWExZGZlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL2hvd3RvLnJzdA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9pdF9JVC9wcm9jZXNzL2hvd3RvLnJzdA0KPiBAQCAt
Mzk0LDcgKzM5NCw3IEBAIHRyb3ZhdGkgYWwgc2l0bzoNCj4gIENpIHNvbm8gZGl2ZXJzaSBhcmNo
aXZpIGRlbGxhIGxpc3RhIGRpIGRpc2N1c3Npb25lLiBVc2F0ZSB1biBxdWFsc2lhc2kgbW90b3Jl
DQo+ICBkaSByaWNlcmNhIHBlciB0cm92YXJsaS4gUGVyIGVzZW1waW86DQo+DQo+IC0gICAgICAg
aHR0cDovL2Rpci5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsDQo+ICsgICAgICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8NCj4NCj4gIMOJIGNhbGRhbWVudGUgY29uc2lnbGlhdGEg
dW5hIHJpY2VyY2EgaW4gcXVlc3RpIGFyY2hpdmkgc3VsIHRlbWEgY2hlIHZvbGV0ZQ0KPiAgc29s
bGV2YXJlLCBwcmltYSBkaSBwdWJibGljYXJsbyBzdWxsYSBsaXN0YS4gTW9sdGUgY29zZSBzb25v
IGdpw6Agc3RhdGUNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2ph
X0pQL2hvd3RvLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJz
dA0KPiBpbmRleCA2NDllMmZmMmE0MDcuLmI0N2E2ODJkOGRlZCAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0DQo+ICsrKyBiL0RvY3VtZW50
YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdA0KPiBAQCAtNDEwLDcgKzQxMCw3IEBA
IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZyDjgavooYzjgaPjgabjgY/jgaDjgZXjgYTjgILj
goLjgZfku4rlvozjga7jg5DjgrDjg6wNCj4gIOOBk+OBruODoeODvOODquODs+OCsOODquOCueOD
iOOBruOCouODvOOCq+OCpOODluOBryB3ZWIg5LiK44Gu5aSa5pWw44Gu5aC05omA44Gr5a2Y5Zyo
44GX44G+44GZ44CC44GTDQo+ICDjgozjgonjga7jgqLjg7zjgqvjgqTjg5bjgpLmjqLjgZnjgavj
ga/jgrXjg7zjg4Hjgqjjg7Pjgrjjg7PjgpLkvb/jgYTjgb7jgZfjgofjgYbjgILkvovjgYjjgbAt
DQo+DQo+IC0gICAgICAgaHR0cDovL2Rpci5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsDQo+
ICsgICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8NCj4NCj4gIOODquOCueODiOOB
q+aKleeov+OBmeOCi+WJjeOBq+OBmeOBp+OBq+OBneOBruipsemhjOOBjOOCouODvOOCq+OCpOOD
luOBq+WtmOWcqOOBmeOCi+OBi+OBqeOBhuOBi+OCkuaknOe0og0KPiAg44GZ44KL44GT44Go44KS
5piv6Z2e44KE44Gj44Gm44GP44Gg44GV44GE44CC5aSa5pWw44Gu5LqL44GM44GZ44Gn44Gr6Kmz
57Sw44Gr5rih44Gj44Gm6K2w6KuW44GV44KM44Gm44GKDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy9rb19LUi9ob3d0by5yc3QNCj4gaW5kZXggZTQzOTcwNTg0Y2E0Li5kZjUzZmFmZDFi
MTAgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2tvX0tSL2hvd3Rv
LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9ob3d0by5yc3QN
Cj4gQEAgLTM4Niw3ICszODYsNyBAQCBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcg66W8IOyy
tO2BrO2VmOqzoOyekCDtlaAg7IiY64+EIOyeiOuLpDsg7IaM7IiY7J2YIOy7pA0KPiAg7Ju57IOB
7J2YIOunjuydgCDri6Trpbgg6rOz7JeQ64+EIOuplOydvOungSDrpqzsiqTtirjsnZgg7JWE7Lm0
7J2067iM65Ok7J20IOyeiOuLpC4NCj4gIOydtOufrO2VnCDslYTsubTsnbTruIzrk6TsnYQg7LC+
7Jy866Ck66m0IOqygOyDiSDsl5Tsp4TsnYQg7IKs7Jqp7ZWY6528LiDsmIjrpbwg65Ok7Ja0Og0K
Pg0KPiAtICAgICAgaHR0cDovL2Rpci5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsDQo+ICsg
ICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLw0KPg0KPiAg7Jes65+s67aE7J20IOyD
iOuhnOyatCDrrLjsoJzsl5Ag6rSA7ZW0IOumrOyKpO2KuOyXkCDsmKzrpqzquLAg7KCE7JeQIOun
kO2VmOqzoCDsi7bsnYAg7KO87KCc7JeQIOq0gO2VnA0KPiAg6rKD7J2EIOyVhOy5tOydtOu4jOyX
kOyEnCDrqLzsoIAg7LC+7JWE67O06riw66W8IOqwleugpe2eiCDqtozsnqXtlZzri6QuIOydtOuv
uCDsg4HshLjtlZjqsowg7Yag66Gg65CcIOunjuydgA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL2hvd3RvLnJzdA0KPiBpbmRleCAxNDU1MTkwZGMw
ODcuLjViZjk1MzE0NjkyOSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vcHJvY2Vzcy9ob3d0by5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vcHJvY2Vzcy9ob3d0by5yc3QNCj4gQEAgLTMwNiw3ICszMDYsNyBAQCBidWd6
aWxsYS5rZXJuZWwub3Jn5pivTGludXjlhoXmoLjlvIDlj5HogIXku6znlKjmnaXot5/ouKrlhoXm
oLhCdWfnmoTnvZHnq5njgIINCj4gIOe9keS4iuW+iOWkmuWcsOaWuemDveaciei/meS4qumCruS7
tuWIl+ihqOeahOWtmOahoyhhcmNoaXZlKeOAguWPr+S7peS9v+eUqOaQnOe0ouW8leaTjuadpeaJ
vuWIsOi/meS6mw0KPiAg5a2Y5qGj44CC5q+U5aaC77yaDQo+DQo+IC0gICAgICAgaHR0cDovL2Rp
ci5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsDQo+ICsgICAgICAgaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8NCj4NCj4gIOWcqOWPkeS/oeS5i+WJje+8jOaIkeS7rOW8uueDiOW7uuiu
ruS9oOWFiOWcqOWtmOaho+S4reaQnOe0ouS9oOaDs+imgeiuqOiuuueahOmXrumimOOAguW+iOWk
muW3sue7j+iiq+ivpue7hg0KPiAg6K6o6K666L+H55qE6Zeu6aKY5Y+q5Zyo6YKu5Lu25YiX6KGo
55qE5a2Y5qGj5Lit5Y+v5Lul5om+5Yiw44CCDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9UVy9wcm9jZXNzL2hvd3RvLnJzdCBiL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX1RXL3Byb2Nlc3MvaG93dG8ucnN0DQo+IGluZGV4IDY4YWU0NDExMjg1Yi4u
ODZiMGQ0YzZkNmY5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9UVy9wcm9jZXNzL2hvd3RvLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9UVy9wcm9jZXNzL2hvd3RvLnJzdA0KPiBAQCAtMzA5LDcgKzMwOSw3IEBAIGJ1Z3ppbGxh
Lmtlcm5lbC5vcmfmmK9MaW51eOWFp+aguOmWi+eZvOiAheWAkeeUqOS+hui3n+i5pOWFp+aguEJ1
Z+eahOe2suermeOAgg0KPiAg57ay5LiK5b6I5aSa5Zyw5pa56YO95pyJ6YCZ5YCL6YO15Lu25YiX
6KGo55qE5a2Y5qqUKGFyY2hpdmUp44CC5Y+v5Lul5L2/55So5pCc5bCL5byV5pOO5L6G5om+5Yiw
6YCZ5LqbDQo+ICDlrZjmqpTjgILmr5TlpoLvvJoNCj4NCj4gLSAgICAgICBodHRwOi8vZGlyLmdt
YW5lLm9yZy9nbWFuZS5saW51eC5rZXJuZWwNCj4gKyAgICAgICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLw0KPg0KPiAg5Zyo55m85L+h5LmL5YmN77yM5oiR5YCR5by354OI5bu66K2w5L2g
5YWI5Zyo5a2Y5qqU5Lit5pCc57Si5L2g5oOz6KaB6KiO6KuW55qE5ZWP6aGM44CC5b6I5aSa5bey
57aT6KKr6Kmz57SwDQo+ICDoqI7oq5bpgY7nmoTllY/poYzlj6rlnKjpg7Xku7bliJfooajnmoTl
rZjmqpTkuK3lj6/ku6Xmib7liLDjgIINCj4NCj4gYmFzZS1jb21taXQ6IDA1ZmZmNmJhMDRlZWY4
Yjg4YmI5NDczNGI2NjczMWJlZjNkOGQzNGINCj4gLS0NCj4gMi4yNS4xDQo+DQo=
