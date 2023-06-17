Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED027343D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjFQUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFQUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:52:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E8D10C4;
        Sat, 17 Jun 2023 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687035112; x=1687639912; i=julian.ribbeck@gmx.de;
 bh=S3Ilb1TkK+1FcyQ64VL0VlaIV0tFcGo+aAS7iQzc+F0=;
 h=X-UI-Sender-Class:Date:Cc:Subject:From:To:References:In-Reply-To;
 b=gg85Ahd8mQ//NRJs3Jc846t+fbk164Hx0l92LoHWZvs1PhKPgbxC3U1UM/6DDrQkYnUYLrU
 r/c1SPP7K/oDyvbKWt41GXFygNbPu1DKqDurEENI63zgM7EwBDwTuUTw54ZTj8awxio1J6fPw
 4omtXtbGrr5iH082gwM4udpQbpSlLCHAEQuaHbEzDsYHIFk3nBMsg7gvrx3UvFa8vgTcdlogX
 Dc23qMy3mtLTy8kbbFCTJ5XHWcxnhAEdQcWm3i5BI3O+WDdQoOWd6ghhW9i5g/zIdWOoorggk
 GvwA14VAae6nQYuRJsN3MgaLBOe/k6BFxitkAscbTHEWZX2OLVWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([93.242.194.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1q0gsp1WlD-011mZM; Sat, 17
 Jun 2023 22:51:52 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 17 Jun 2023 22:51:51 +0200
Message-Id: <CTF81B4NWOND.1Z5JXP3Z00JFO@x1-yoga-arch>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun7i: Add Iteaduino Plus A20
From:   "Julian Ribbeck" <julian.ribbeck@gmx.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>
X-Mailer: aerc 0.15.1
References: <20230617172735.1098591-1-julian.ribbeck@gmx.de>
 <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
In-Reply-To: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
X-Provags-ID: V03:K1:FIt0V04ge8aa4HkQMv8Dtr/TrSHJVcvoozZxUc1dUDzjshrP7Uw
 A5hxItWmqrgd91x+3VNvUrkVWFYxI8IEgZCuZduLwjOT89qCmxxO612dZK871W36DttcN3f
 GDOqUokrdNErFGwFrSngRvP3o1yE7hv8xUf5/Rrw6USfidJiw1PfW5sQziP7O+xDZtM0pOs
 Ba7K03ZJfWRSeznSsrr+A==
UI-OutboundReport: notjunk:1;M01:P0:NcFkgwN/sAs=;1uGJcKikgarLUIEn/nrnz1F1iup
 biX3sTrVkqpSY2ExyTWVD1T1dTFhOljVmx7OrJKewlpgnwm1RHnxpLV34Ng6GXJ1LzcDUaQqu
 O4fdhb3t0KvRMBAxOZw+xiHExPzbFgtVK9/KfMjD9+0dpsXt2ZG1HZJ/DmN0jKMEoSwn0W40U
 YhdDN4iS+nbfYftiHYbDjAd3Zu8Euf093WRmkOB8MWeR/Yu1SkKQhOW1zGIP343Rfu8/EaBby
 qb+2ekesHSh2O1FIg6+ggNEx8AT4meBFAzPcgHvubwYBzIj4Gn4s1Hs6ygDoJMY4eMDd9wASV
 vnc+zc7LmrjwT7YQ62u79fQMaJdZOtspALh2SBBB0RCsZX+sGqQdFjHZ7PZ1Zw4B63Y4K85lY
 oLZWcO0/00mWJzzqvjykxZV1oFs/3rB5oj6GGZkC4TGn1Sdpn/NPpgyzTNva+g1ul6LWGnh95
 Nhyp+m513rWBzi0N+iBApPqIXRBU23/dxxJMI83DFL/UZPmsG5NFPzK+vosJg+LFL6txUlzMh
 Ck85A4Imn880d6Le3V9g7wu0WOr90yreoR0QhU/3zIFF5Y5t1DaZ8z5JtEPXPXsoxsDO3jQZE
 udOuqEHgWqkHTKom0q7lq/RBcf/nzsvVSFG0uYUrQ7BpS4YEyVRlagwQlrgVPQ4wVarwPiwKm
 Act49of3pbxEKXzPs15KAxaVHM+5tKbLXb1GYbUcjSDgSdrvJU496WGc/FGEKTDhpDu/F23Jr
 gdPEEtOxGzzzguCvVcGfG8x9jW3AjewJN9Q5jIDli+UR3F2Gwkm1CJNYj4eqbIkn4hdYiLCoO
 D4DUYjUEEaW3dR+iMs2tu0xD3327BF3MQWPiinpllbSwB00CrjeivyJuuAjdH4pJpNv03ulYv
 98TTpMxc32P94z3hmwxircXK33BRHO3S9suBCCvhPkts1OguvXahpxrGlgZZ1UzJqgD1Yv+B6
 8yIP+g==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Missing bindings.
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).
Thanks, did not know about this, will send a v2
