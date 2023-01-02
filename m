Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393065B82B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjABX1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjABX1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:27:41 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F36268;
        Mon,  2 Jan 2023 15:27:41 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AD9376D6;
        Mon,  2 Jan 2023 23:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AD9376D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672702060; bh=BvdvsD4VN/tr0Xn28MxQoR+7Eq/YiA+SbV0ZqrWxwso=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mZXeWapvkdL782TcKb9+4+66IrUXjBJvK8BQQ8hp/Jvvzbq63NtZhSFGPw+KYDzA7
         SZX8lWH1ZuLK52hw+suzD0dYZmDjW7vLr1Y3CzjwpimuGOgGRRSVLhWcnX2S/Yr56d
         XFVxSXnVkvvTtCI5ukusaL3BCZhJiw+0NJR9xU1wWFpVcWiNuWrfWRsvHb04jY3C9o
         2S3EPj2EEK2WVXnLzZ1TFFK9BaMLEAkxK3/buUT64ePqq0b5vS30wiJVA9q3Uq5bln
         SlqJezA8gmmy7btTQOmu3ImAk7bXDXxx8cRWf+TFuTc/ZlQ5LxMH12DktvwyVgeKN4
         YyZFrN5xDqiVQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Yong <yongw.kernel@gmail.com>, alexs@kernel.org,
        siyanteng@loongson.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Yong <yongw.kernel@gmail.com>
Subject: Re: [PATCH] docs/zh_CN: fix a typo in howto
In-Reply-To: <20221208083353.160152-1-yongw.kernel@gmail.com>
References: <20221208083353.160152-1-yongw.kernel@gmail.com>
Date:   Mon, 02 Jan 2023 16:27:40 -0700
Message-ID: <87mt70h5zn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2FuZyBZb25nIDx5b25ndy5rZXJuZWxAZ21haWwuY29tPiB3cml0ZXM6DQoNCj4gRml4IGEgdHlw
byBpbiBDaGluZXNlIHRyYW5zbGF0aW9uIG9mIGhvd3RvLnJzdA0KPg0KPiBGaXhlczogNDBkOTNl
NDk2MTgwICgiZG9jcy96aF9DTjogdXBkYXRlIGhvd3RvLnJzdCB0byBsYXRlc3QgdmVyc2lvbiIp
DQo+IFNpZ25lZC1vZmYtYnk6IFdhbmcgWW9uZyA8eW9uZ3cua2VybmVsQGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzL2hvd3RvLnJz
dCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJv
Y2Vzcy9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNz
L2hvd3RvLnJzdA0KPiBpbmRleCA4ODg5NzhhNjJkYjMuLjEwMjU0NzUxZGY2YSAxMDA2NDQNCj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9ob3d0by5yc3QN
Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9ob3d0by5y
c3QNCj4gQEAgLTI1NCw3ICsyNTQsNyBAQCBMaW51eC1uZXh0IOmbhuaIkOa1i+ivleagkQ0KPiAg
ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnLz9wPWxpbnV4L2tlcm5lbC9naXQvbmV4dC9s
aW51eC1uZXh0LmdpdA0KPiAgDQo+ICDpgJrov4fov5nnp43mlrnlvI/vvIxMaW51eC1uZXh0IOWv
ueS4i+S4gOS4quWQiOW5tumYtuauteWwhui/m+WFpeS4u+e6v+WGheaguOeahOWGheWuuee7meWH
uuS6huS4gOS4quamguimgQ0KPiAt5bGV5pyb44CC6Z2e5bi45qyi5YaS6Zmp55qE5rWL6K+V6ICF
6L+Q6KGM5rWL6K+VTGludXgtbmV4dOOAgg0KPiAr5bGV5pyb44CC6Z2e5bi45qyi6L+O5YaS6Zmp
55qE5rWL6K+V6ICF6L+Q6KGM5rWL6K+VTGludXgtbmV4dOOAgg0KDQpBcHBsaWVkLCB0aGFua3Mu
DQoNCmpvbg0K
