Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1778D623E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKJJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:23:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958985FC5;
        Thu, 10 Nov 2022 01:23:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a29so2017011lfj.9;
        Thu, 10 Nov 2022 01:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkgl5633jN0vhHzUICom2lzjyjcsXAHICnHIlWbliwQ=;
        b=o/yiHtpe9LJC2yq6ZSeeryMiqbF1InpMgc5BQJ8TpUAZx+RyDqOiXvAsNdDGNCZu/t
         HhJ1DDDOUkmyBTErr/CRnABWTF00Q4JBgyVVPqvRP+C6p0BOZx1gYiDZqCErlXSkw/FJ
         1v+L4oYRtfojsioCQltiKR5HiLQ/wEKA0PLtUdUJFElhQEWHUlMlZVaZEsD+2kmYbH32
         d8pSMe/qZ+dIu30SI6T8vUTl9EGhong1Hx6P6BiAahn+U6GuXsXo7u4nbypPYCuwLMGU
         I7GCBO9j7NaEaDMg8Ue1lcPudJRkq+6v/B9gbpIMhyxdZVWYnpTq4VhkWtvt3xD8hhzq
         gqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkgl5633jN0vhHzUICom2lzjyjcsXAHICnHIlWbliwQ=;
        b=2CVshDbHQUgGKROfdKVgyduhXtYQd98UxVuA+SNlRLo7yZhQMlNmw4HNufvu3Bvm4l
         aZs3zS47uWYvo7Sfs5Mp7m0FoXbLOLFvib0movNn+m683KGDFkNHbVa+8rh96OnHa/ZA
         i5JS2FqL44hSInqFNaWNg1vqDwNIJzC37zNljazAX43L01KaF+e92bQkJNBqFM7BHcIO
         iZWE7ub2/bm4b7hcHE095dKwnhAB5K4q7YtnFHeWWheIoicPvpQ5mQHiJR1S0ll4ZvH4
         Bt0BJ88PbXCuZPt2lSLndGdu1nJ7WDJ3BOFQWHRJ3CcYlZkRRGS/zQrTIB+DB6bXadGS
         X2MQ==
X-Gm-Message-State: ACrzQf0wPKtlnfN3AEUB7IJjC2DQG4yWYvJPZ+a5TAKp6mWN9k9eQCZR
        3/LAx7Sz5Z/s0ihx7123/6Kp10k6av+289Qw27M=
X-Google-Smtp-Source: AMsMyM7Ev84vi8L0RmFzew3Y34Pl5/dqxP1bY04tSJrIC7ca0LgF5NpkXJBwejEG2EPm2jO4DgsGyRjSBgn1ZbL8kXY=
X-Received: by 2002:ac2:42cc:0:b0:4a2:500e:2bfa with SMTP id
 n12-20020ac242cc000000b004a2500e2bfamr1182491lfl.629.1668072224767; Thu, 10
 Nov 2022 01:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20221105041741.288094-1-me@lirui.org>
In-Reply-To: <20221105041741.288094-1-me@lirui.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 10 Nov 2022 17:23:08 +0800
Message-ID: <CAJy-Am=QiK-YuntZvbVyhVatY4t3b0CFkmi2c7PTX-gomS7MYw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/futex2 Chinese translation
To:     Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBOb3YgNSwgMjAyMiBhdCAxMjoxOCBQTSBSdWkgTGkgPG1lQGxpcnVpLm9yZz4gd3Jv
dGU6DQo+DQo+IFRyYW5zbGF0ZSB0aGUgZm9sbG93aW5nIGRvY3VtZW50cyBpbnRvIENoaW5lc2U6
DQo+DQo+IC0gdXNlcnNwYWNlLWFwaS9mdXRleDIucnN0DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFJ1
aSBMaSA8bWVAbGlydWkub3JnPg0KPiAtLS0NCj4gIC4uLi96aF9DTi91c2Vyc3BhY2UtYXBpL2Z1
dGV4Mi5yc3QgICAgICAgICAgICB8IDgwICsrKysrKysrKysrKysrKysrKysNCj4gIC4uLi96aF9D
Ti91c2Vyc3BhY2UtYXBpL2luZGV4LnJzdCAgICAgICAgICAgICB8ICAyICstDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi91c2Vyc3BhY2UtYXBpL2Z1
dGV4Mi5yc3QNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL3VzZXJzcGFjZS1hcGkvZnV0ZXgyLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL3VzZXJzcGFjZS1hcGkvZnV0ZXgyLnJzdA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA0ZjlkNjJkYjFmNw0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3VzZXJzcGFjZS1hcGkvZnV0ZXgy
LnJzdA0KPiBAQCAtMCwwICsxLDgwIEBADQo+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMA0KPiArLi4gaW5jbHVkZTo6IC4uL2Rpc2NsYWltZXItemhfQ04ucnN0DQo+ICsNCj4g
KzpPcmlnaW5hbDogRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2Z1dGV4Mi5yc3QNCj4gKw0K
PiArOue/u+ivkToNCj4gKw0KPiArIOadjuedvyBSdWkgTGkgPG1lQGxpcnVpLm9yZz4NCj4gKw0K
PiArPT09PT09DQo+ICtmdXRleDINCj4gKz09PT09PQ0KPiArDQo+ICs65L2c6ICFOiBBbmRyw6kg
QWxtZWlkYSA8YW5kcmVhbG1laWRAY29sbGFib3JhLmNvbT4NCj4gKw0KPiArZnV0ZXjvvIzmiJbo
gIXnp7DkuLrlv6vpgJ/nlKjmiLfkupLmlqXplIHvvIhmYXN0IHVzZXIgbXV0ZXjvvInvvIzmmK/k
uIDnu4TlhYHorrjnlKjmiLfnqbrpl7TliJvlu7rpq5jmgKfog73lkIzmraUNCj4gK+acuuWItuea
hOezu+e7n+iwg+eUqO+8jOavlOWmgueUqOaIt+epuumXtOS4reeahOS6kuaWpemUge+8jOS/oeWP
t+mHj+WSjOadoeS7tuWPmOmHj+OAgkPmoIflh4blupPvvIzlpoJnbGliY++8jOS9v+eUqOWug+S9
nA0KPiAr5Li65a6e546w5pu05aSa6auY57qn5o6l5Y+j55qE5pa55byP77yM5aaCcHRocmVhZHPj
gIINCj4gKw0KPiArZnV0ZXgy5piv5Yid5LujZnV0ZXjns7vnu5/osIPnlKjnmoTlkI7nu63niYjm
nKzvvIzml6jlnKjlhYvmnI3ljp/mnInmjqXlj6PnmoTpmZDliLbjgIINCj4gKw0KPiAr55So5oi3
QVBJDQo+ICs9PT09PT09DQo+ICsNCj4gK2BgZnV0ZXhfd2FpdHYoKWBgDQo+ICstLS0tLS0tLS0t
LS0tLS0tLQ0KPiArDQo+ICvnrYnlvoXkuIDkuKpmdXRleOaVsOe7hO+8jOWPr+eUseWFtuS4reS7
u+aEj+S4gOS4quWUpOmGkjo6DQo+ICsNCj4gKyAgZnV0ZXhfd2FpdHYoc3RydWN0IGZ1dGV4X3dh
aXR2ICp3YWl0ZXJzLCB1bnNpZ25lZCBpbnQgbnJfZnV0ZXhlcywNCj4gKyAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IGZsYWdzLCBzdHJ1Y3QgdGltZXNwZWMgKnRpbWVvdXQsIGNsb2NraWRfdCBj
bG9ja2lkKQ0KPiArDQo+ICsgIHN0cnVjdCBmdXRleF93YWl0diB7DQo+ICsgICAgICAgIF9fdTY0
IHZhbDsNCj4gKyAgICAgICAgX191NjQgdWFkZHI7DQo+ICsgICAgICAgIF9fdTMyIGZsYWdzOw0K
PiArICAgICAgICBfX3UzMiBfX3Jlc2VydmVkOw0KPiArICB9Ow0KPiArDQo+ICvnlKjmiLfnqbrp
l7Torr7nva7kuIDkuKpzdHJ1Y3QgZnV0ZXhfd2FpdHbmlbDnu4TvvIjmnIDlpJoxMjjpobnvvInv
vIzorr7nva4gYGB1YWRkcmBgIOS4uuetieW+heeahA0KPiAr5Zyw5Z2A77yMIGBgdmFsYGAg5Li6
5pyf5pyb5YC877yMIGBgZmxhZ3NgYCDkuLrmjIflrprnmoTnsbvlnovvvIjlpoJwcml2YXRl77yJ
5ZKMZnV0ZXjnmoTlpKflsI/jgIINCj4gK2BgX19yZXNlcnZlZGBgIOmcgOimgee9ruS4ujDvvIzk
vYbmmK/lroPlj6/nlKjkvZzmnKrmnaXmianlsZXjgILmjIflkJHmlbDnu4TnrKzkuIDkuKrlhYPn
tKDnmoTmjIfpkojkvZzkuLoNCj4gK2Bgd2FpdGVyc2BgIOS8oOmAkuOAguWmguaenCBgYHdhaXRl
cnNgYCDmiJbku7vkvZXnmoQgIGBgdWFkZHJgYCDlnLDlnYDml6DmlYjvvIzlsIbov5Tlm54gYGAt
RUZBVUxUYGAg44CCDQo+ICsNCj4gK+WmguaenOeUqOaIt+epuumXtOaLpeaciTMy5L2N55qE5oyH
6ZKI77yM6YKj5LmI6ZyA6KaB5YGa5pi+5byP6L2s5o2i5p2l5L+d6K+B6auY5L2N5riF6Zu244CC
IGBgdWludHB0cl90YGAg6K6+6K6hDQo+ICvlvpflvojnsr7lt6fvvIzlnKgzMi82NOS9jeeahOaM
h+mSiOS4iumDveato+W4uOW3peS9nOOAgg0KPiArDQo+ICtgYG5yX2Z1dGV4ZXNgYCDmjIflrprk
uobmlbDnu4TnmoTlpKflsI/jgILkuI3lnKhbMSwxMjhd5Yy66Ze05YaF55qE5YC85Lya5L2/57O7
57uf6LCD55So6L+U5ZueIGBgLUVJTlZBTGBgIOOAgg0KPiArDQo+ICvns7vnu5/osIPnlKjnmoQg
YGBmbGFnc2BgIOWPguaVsOmcgOimgee9rjDvvIzkvYblj6/nlKjkvZzmnKrmnaXmianlsZXjgIIN
Cj4gKw0KPiAr5a+55LqO5q+P5LiqIGBgd2FpdGVyc2BgIOaVsOe7hOS4reeahOmhue+8jOWcqCBg
YHVhZGRyYGAg55qE5b2T5YmN5YC85Lya5ZKMIGBgdmFsYGAg5q+U6L6D44CC5aaC5p6cDQo+ICvk
uI3kuIDoh7TvvIzns7vnu5/osIPnlKjkvJrmkqTplIDmiKroh7Pnm67liY3lrozmiJDnmoTmiYDm
nInlt6XkvZzvvIzlubbov5Tlm54gYGAtRUFHQUlOYGAg44CC5aaC5p6c5omA5pyJ5rWL6K+VDQo+
ICvlkozpqozor4Hpg73pgJrov4fvvIzns7vnu5/osIPnlKjkvJrnrYnlvoXnm7TliLDku6XkuIvm
g4XlhrXkuYvkuIDlj5HnlJ/vvJoNCj4gKw0KPiArLSDmjIflrprnmoR0aW1lb3V06LaF5pe277yM
6L+U5ZueIGBgLUVUSU1FT1VUYGAg44CCDQo+ICstIOS4gOS4quS/oeWPt+iiq+S8oOmAkue7meed
oeecoOS4reeahOS7u+WKoe+8jOi/lOWbniBgYC1FUkVTVEFSVFNZU2BgIOOAgg0KPiArLSDmn5Dk
uKrliJfooajkuK3nmoRmdXRleOiiq+WUpOmGku+8jOi/lOWbnumCo+S4quiiq+WUpOmGkueahGZ1
dGV455qE57Si5byV44CCDQo+ICsNCj4gK+WFs+S6juWmguS9leS9v+eUqOaOpeWPo+eahOS+i+Wt
kOWPr+S7peWcqCBgYHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvZnV0
ZXhfd2FpdHYuY2BgDQo+ICvkuK3mib7liLDjgIINCj4gKw0KPiAr6LaF5pe2DQo+ICstLS0tDQo+
ICsNCj4gK2Bgc3RydWN0IHRpbWVzcGVjICp0aW1lb3V0YGAg5piv5LiA5Liq5oyH5ZCR57ud5a+5
6LaF5pe25pe26Ze055qE5Y+v6YCJ5Y+C5pWw44CC5L2g6ZyA6KaB5ZyoIGBgY2xvY2tpZGBgDQo+
ICvlj4LmlbDkuK3mjIflrpropoHkvb/nlKjnmoTml7bpkp/nsbvlnovjgILmlK/mjIEgYGBDTE9D
S19NT05PVE9OSUNgYCDlkowgYGBDTE9DS19SRUFMVElNRWBgIOOAgui/meS4qg0KPiAr57O757uf
6LCD55So5Y+q5o6l5Y+XNjTkvY3nmoR0aW1lc3BlY+e7k+aehOS9k+OAgg0KPiArDQo+ICtmdXRl
eOeahOexu+Weiw0KPiArLS0tLS0tLS0tLS0NCj4gKw0KPiArZnV0ZXjml6Llj6/ku6XmmK/np4Hm
nInnmoTkuZ/lj6/ku6XmmK/lhbHkuqvnmoTjgILnp4HmnInnlKjkuo7lpJrkuKrov5vnqIvlhbHk
uqvlkIzmoLfnmoTlhoXlrZjnqbrpl7TvvIzlubbkuJRmdXRleOeahOiZmuaLnw0KPiAr5Zyw5Z2A
5a+55omA5pyJ6L+b56iL6YO95piv5LiA5qC355qE44CC6L+Z5YWB6K645Zyo5YaF5qC45Lit6L+b
6KGM5LyY5YyW44CC6KaB5L2/55So56eB5pyJZnV0ZXjvvIzpnIDopoHlnKhmdXRleOagh+W/l+S4
reaMh+Wumg0KPiArYGBGVVRFWF9QUklWQVRFX0ZMQUdgYCDjgILlr7nkuo7pgqPkupvkuI3lnKjl
kIzkuIDlhoXlrZjnqbrpl7TlhbHkuqvnmoTov5vnqIvvvIzlj6/ku6XorqnlkIzkuIDkuKpmdXRl
eOaLpeacieS4jeWQjA0KPiAr55qE6Jma5ouf5Zyw5Z2A77yI5L6L5aaC5L2/55So5Z+65LqO5paH
5Lu255qE5YWx5Lqr5YaF5a2Y77yJ77yM6L+Z6ZyA6KaB5LiN5ZCM55qE5YaF6YOo5py65Yi25p2l
5L2/5b6X5q2j56Gu6L+b5YWl6Zif5YiX44CC6L+Z5piv6buY6K6kDQo+ICvnmoTooYzkuLrvvIzo
gIzkuJTlr7nnp4HmnIlmdXRleOWSjOWFseS6q2Z1dGV46YO96YCC55So44CCDQoNCkdvb2Qgam9i
LiBKdXN0ICLov5npnIDopoHkuI3lkIznmoTlhoXpg6jmnLrliLbmnaXkvb/lvpfmraPnoa7ov5vl
haXpmJ/liJciIGlzIGEgYml0IG9kZC4gY291bGQgeW91IHJlcG9saXNoIGl0Pw0KDQpUbyBvdGhl
cnM6DQpSZXZpZXdlZC1ieTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQoNClRoYW5rcw0K
DQo+ICsNCj4gK2Z1dGV45Y+v5Lul5piv5LiN5ZCM55qE5aSn5bCP77yaOO+8jDE277yMMzLmiJY2
NOS9jeOAguebruWJjeWPquaUr+aMgTMy5L2N5aSn5bCP55qEZnV0ZXjvvIzlubbkuJTpnIDopoHp
gJrov4cgYGBGVVRFWF8zMmBgDQo+ICvmoIflv5fmjIflrprjgIINCj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3VzZXJzcGFjZS1hcGkvaW5kZXgucnN0IGIv
RG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vdXNlcnNwYWNlLWFwaS9pbmRleC5yc3QN
Cj4gaW5kZXggZGFkNWJhN2NhZTZkLi42OGI2OWIxNGIxNDMgMTAwNjQ0DQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3VzZXJzcGFjZS1hcGkvaW5kZXgucnN0DQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3VzZXJzcGFjZS1hcGkvaW5kZXgu
cnN0DQo+IEBAIC0yOCw2ICsyOCw3IEBAIExpbnV4IOWGheaguOeUqOaIt+epuumXtEFQSeaMh+WN
lw0KPiAgICAgc2VjY29tcF9maWx0ZXINCj4gICAgIGVicGYvaW5kZXgNCj4gICAgIHN5c2ZzLXBs
YXRmb3JtX3Byb2ZpbGUNCj4gKyAgIGZ1dGV4Mg0KPg0KPiAgVE9ET0xpc3Q6DQo+DQo+IEBAIC00
MCw3ICs0MSw2IEBAIFRPRE9MaXN0Og0KPiAgKiBtZWRpYS9pbmRleA0KPiAgKiBuZXRsaW5rL2lu
ZGV4DQo+ICAqIHZkdXNlDQo+IC0qIGZ1dGV4Mg0KPg0KPiAgLi4gb25seTo6ICBzdWJwcm9qZWN0
IGFuZCBodG1sDQo+DQo+IC0tDQo+IDIuMzAuMg0KPg0K
