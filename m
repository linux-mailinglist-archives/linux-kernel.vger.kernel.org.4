Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C879D6658E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjAKKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjAKKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:21:39 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AEDAC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673432489;
        bh=64hj+cdFZ1tPcCZ3jBM10E5LzuPo94VvhO1ZD6XEGaI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=SAt8WrBtReaEpCRwEj681zNkzFqdQfraXV7IKZforKZL8AHihB7vyygIU0LUyMvUY
         SkOcyiBecamFBXOxXrN+ciGqGGYNzZZlViuILWc6f2SjJ58VrEqzbILsLUTd+FNskD
         V+pRirxk3pMuiQAjD9kWlA2qJqQ2J5VYhE7JLmbA=
Received: from DESKTOPZMX ([111.60.247.106])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 5590BE03; Wed, 11 Jan 2023 18:21:25 +0800
X-QQ-mid: xmsmtpt1673432485t7n5hxfk8
Message-ID: <tencent_F0BF70A75A0E742E6000F7617EE53999E807@qq.com>
X-QQ-XMAILINFO: MK5U7QanZrCwJp2QaHPoANhMg+Fpm0cUh1+1M7TytG8Vfe+1XZpKNZZ1Mnz7Pf
         /fwIfpAqMV8lNGWS3DYOKAjqswpf0EHO7hbA6WUidgkpNkiZwVEFBv//AfJfK0XYY4Uk71tteKev
         7ZJTpIWVc6bdMkZCQW7lCKvPBDltOqATbjQj28aA8/wDc0KK8PlmlANDDZUb9ba/u0asFWsxF2VZ
         OoxsjyJF8nck98fvGtQpa6w2F51vDH74BuEZSzNlQgn6zerkWQio0LhEcAGwoyTPhqf9eQ48ObxE
         utq1uM8ytMjOUcfUA5ehvhSbe/aKXfRcETTAHlpgD3IaMkM3dL1vslOXp8BMeCEoajHd+lFqEH4b
         EUK1/SJpIDW3ZGwUw6Cria+slByhwVszn8tpVlgymIk1uj7nswootTqVx9YqNco8cbzgTk1QDAOT
         hPWc8XabKmt+hFYzQ6BAOr7HFIBD0zCdyqfxHhPrEXwZ2C4Gm4kvb+WGvWHj01p9C8uNUUvu5ltI
         bD9ehUv3FXM9KZD20NZhpUX6rO+AQfz9YHA4YcY0log6Ci/4X/yJqJk8Pc+SnvdgfL4TLAdxjKoi
         Yr9TLsHPNQK1t72aTnA6tFiTtrjpzWgiq9a2/WuvXotk0jFVnw04Bcd/ERvp3/sLiadtvqOMzNKm
         k+7mjmor+mVUZ9jy9h9o2323PRV109DF98tC9XpR5mg5NlIcOjTYjNMS0qPmV0kgRlkGvhCxinPu
         NIf5DB/KmyzJAhlDzd5M9phyMFJTbpyQNhs6QCOFAbVJu9dD4jVOjIbLMNo7MPJCpk6Qqf+0hVB7
         p7rlzJj/znQocjXFL4/2gP8VjzF6CBL32evU2t0XqwL+qZlXtLLRXKTyjO7Fz+Jl2xljvnCUvWU9
         QiguxCmagh/ofkxxkERICKR+3+eOdWEup5WUvo5KipE+0+aAa7PNIdZHcjKOlcOrRmRkdNgQYyXK
         XItHA9sOotS6rQdBLUj7j6l/ahwjGC
From:   <forbidden405@foxmail.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Jaime Breva'" <jbreva@nayarsystems.com>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        "'Nikita Travkin'" <nikita@trvn.ru>
References: <20230110155014.31664-1-forbidden405@foxmail.com> <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com> <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org> <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com> <f909c1b0-97db-cc33-fa27-c5e901f11956@linaro.org> <tencent_235CAC16001D1C38CE7D86BF7B0E365A2105@qq.com> <0453b098-91db-1918-38ae-a7db0408460c@linaro.org> <tencent_2068AC70F1DA5AF46F600C7718FEB1B98307@qq.com> <3fb51f6a-84b7-c35b-d4b0-332671988594@linaro.org>
In-Reply-To: <3fb51f6a-84b7-c35b-d4b0-332671988594@linaro.org>
Subject: RE: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Date:   Wed, 11 Jan 2023 18:21:03 +0800
X-OQ-MSGID: <000401d925a6$77298970$657c9c50$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEO7BERPzOKD8mdDN9nK2Zc/pFyZgG3SCqUAZiImfcCstHu6AF93epXAffz5noBRJuEcQD3Xbi/AZKgzz8DEhceeQ==
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 09:32, krzysztof.kozlowski@linaro.org wrote:

> This does not solve my concerns. If you cannot point specific =
manufacturer=20
> and
> model (if there is no manufacturer, there can be no official model,=20
> right?), how
> anyone can be sure that their device is compatible with yours?

1. the best way is to take the device apart and compare the board design =

with others;
2. the label on board, though format unknown, seems to be different =
between=20
different models and identical for one model;
3. read board-id from stock Android firmware. It's not reliable because =
a=20
board-id might be shared by multiple models. Note this board-id has no =
other usage because the manufacturer reused a board-id defined by qcom.

We extract some special fields from the label(i.e. ufi001c or uf896) to =
be=20
the model name for a device, currently it's enough to distinguish =
between=20
different boards.=20
For example, the label on ufi001c is 'UFI001C_MB_V01', we extract the =
first field to be the model name.

