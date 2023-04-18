Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1946E6E13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjDRVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjDRVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:25:01 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC43A5FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681853093; bh=gdU7qqet/Ydr3tXK9bfNbFkuWA+0NWpwqLXc4xK5Tow=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VndfbIWGjeTGZv/9fny8Qspxcnl89QCJ1tVeVzp+5pZGGNqZ7B8fGyrpsT0XarhkHFHCez8L55sbf9uLoQHtn+WgeyqzypoSpGNMOdcLEJh57gI7IEFc5JSvolnPtbZI45xbz9/3IoJtn6L7gvLrPe/U29H7B5IpDd+xbl1pz6oFnhgVd+8lgYpUXjvln0ryTV6TEjJQMPUo/Op1RK7a4DQpcjtKINm5c9I2lHzm6L8ufiod2lLg7mc5LTv6hfgTo/JPcfLJgpsReiLnDn2FxmlsILuqihD9bnoKpBur6edwDcWpfD96tuuQIqix/kJdNTybV4hviia6NTlmtudUfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681853093; bh=gYQxMuH/eHVu0WTkSRf2eXxd22ZMm6D+vJVurJ6Oobs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WsQyUsh9qviSwoEP73Bw7L3rpE1oPDqqchnRU7CYexWeFbZrGcHeFJlr3Hv9DfJRMcohL4gCrNuWzrvKedAiQShRQOvznT989E8Zx3PPR6U/C53z2OwuW2nW8ro8/87boIv4AYjEJwzfbel3xSQlS3DUabydYAVvRYLIOkMqMNOmAbDFNc/GTTimPhbwiScjpqpwgdWThY8hHFSxS18aLrUudlTzUdKk+zWXokeeG3nH3F1YZ7/y5tLJtzNTgvfBcJAiXvGvKI0vHx8RrjpnzKb9iXt9on/abHeweD0bihkb8JJPUZ37gz/cH23+LUROhqkWC2G0YFeQIvvEO3HC1w==
X-YMail-OSG: AAOw1xUVM1kBgtadGQ1pt5_ztt8tI9OXA96HYvxTh5lYgGD6oOgv6rknNpLFZek
 bIwbiy442xM10Hsb4ZxuTtz7N0mycF1u9WMN0t9lR0vNO9ZxXJly8htydY2NH5bOrjfDkEEz_Ci2
 hH6e2i.mT7xyAlpibz4ome6crIM_6cqKp1yr6mchi3PEDHwT8YDwLBRWU91Kz645As0vY7LevkpN
 YWEuTcTJUiNhakjVlfnmEQNDb8Pj7poguWC632jKMxzz6P5ecJoRqc7Ujc10WBwVhUGWohwEkJ4V
 umsVa9qKsH9h5CNSgjTm.cc4sQn2yW6VyNgfH4amwfuqcJrakQkrmCQ8lqKj2MpGFX99u8ndvRan
 V.pbAHnEgQxo__RPGP9bSzWw2s5renDAnLtNSlRQ4a5I4JdAlBwtKOMPXESz8leydO5z8yOlS2Nf
 MzKhgg0pWP6EHE4u_Jl9pyKdoIbZMYr94TK5t8NGwgy.SmmaJyVm8pC4jLrvz5StG7uf29WgF2mP
 odK44TAB8YhxsxNfGyEsPn76Ck4ZF6j0JEmb46gkj3m.y8t0zRy1Phxq6mBF.PuvKk9vGRyhCYuG
 BTdsOz7l_vpbVQWLe5s9XXXf.qCvHKAIQrlZFEFzCawYY994neNYy95e7ly3bPoDq4JYaymDqfZd
 arfW458Q48X5KnpnnZiuCZ8XxIUVQ0q.OXY1lMNtzTwPfQnp88LgQGc8a.UOFEvEoZ6xZ6UW9USE
 FC46bv4qhu9eLvYKQdQQzICogbyxPS1tdBWyWwln2PpgomOyuqdV6NHZd1ImBVGUwsDvDwBweEzd
 BuQw2iBz0nKB8DTS6NO8.AFpbOz_xoFmXbtFdkWX.GCbd8sxtp.nJM76SsYLC.1uklJuEJHpDThe
 wLWRstSrmrdlUVLsjj5wh6Sybbf0ulaS1fI86npAqF8CFltUUFt0TdRkEjFMX65HrBgWDdhzYZq.
 trzPrJB3hBqsKeP.97_0nuHvmb1woPYOA_sp12OGYulndTFUo4lNt7klDn_2UUcJC2YPzXfIbqCt
 FCVa5LowS0eCYALlQuQafU1AzT0dMITwgtjfAOdVpyvQeDRdqD1WEz2mD4TVhy9nL6H5K5WdLz8A
 M9_urPpHzV9enNkajSLZ1ueBszgFxHEKLoqQSv5Ziasv6hAWFseP3g.xkTndoNnBaxMXCp.MeJCz
 nZvnFz4_hywbQZSbmgaf8vIZkhbFxeip42xPIr.GfZYVCy5EVny40efjnRdJoQXCh.tyzJCmKxVe
 5.1KxXSr0bWkcTj0eZ88PHcLA2Hu6CIT3D5y.7epkz0vE3vA.5.UasuK_htf7tOQJQgANXC5S1YY
 miVBikkU7M7tpwjDI.WwQK5ucmPPiDVjzTfWD_bejH5zmInh_bWZw_EP9WRh6PkqkHKlirrhibVH
 IEUWHAOUtLtKpV7uq1FGuLHfztiJHmDFWO5rVf28.t1ixAsczMyRf0tgCZ5ZKdmJE4LvKjmxLw1I
 tIufarPiSHGPmaFnkbUaXJ2yBPY6LIchBZ0aO6YsX4BMCeatT8HZP8enMn9rMEsDcTDVF0atsnvp
 9unC4D0ZeFWP31gsBDAIneQBt6LVMsEGjWmH4vFS1ZX5xWxa9xMrLG7tAcc3r1mScTUyeDc41FGH
 5IGU7o8T.xFkOqQB13zgUAsL6BeNfvMHP4ApAuGWfwHRcB4RdpGw0ZLpPNyguETbfVYxGIGnEz21
 .QAT4PIMNH6Dx7H8oPRgW8n3PUOVYpOl4Mwo01E.fmp.e07EtkwYjRXpvn3J67bsn_XYT_hRyBx9
 xNdxqL3yiIYaz7eAD4vyXY352FBnDlIFtoMaqfyms0lwl3ZEsmIyd8WvMYT14u.cWC5jVrXVztHa
 RlScZqMzTE7.X_8RExy7vleVLRNLziJgqzuJpAEJekW16K403QxVi70SvnP2dJ_zlY2DIVmiolot
 JgfENXf5Cmio6pLsZu8..GZIXvbTMmLx8tZicYuclDOcreLbjW4gC.lNsQYwgdL.5w637XSp3hdN
 MIKRVt9ik06_oqR6ShSnfkVx931xD1N7RySdYVLDXKU5a.gmi3D_SceKS3SOeungnNEcW6mYcJIK
 RbmlW9rzeUxbdyElRFqD8F.lldxS9uuv6HakIGFvV9U2GoMlKb6CScmkGLT5Mj4K62Kf2VkUoTUZ
 IZwZSG0tGdGLUWpFnSGaG_.thSpZU7Z2WCxVlYVONEcnQlgKRFAKrI3EodGO.Gq3dBH7bsZFpHHi
 xnITIbFeCsxjPMBrKHXlK0JpYKJwgiKQcjyD3xnjbvhwcrDY1mj.ZU50qKBxu1kRp6YOHuuji7aU
 A6PQ5KcuOpFf0gSGnKj45CC9OZngCZFPq
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 96fd7f1b-8654-4342-bdf4-fbff36d6f360
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 18 Apr 2023 21:24:53 +0000
Received: by hermes--production-ir2-74cd8fc864-j696l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 00cb710563690d82660d89732d517195;
          Tue, 18 Apr 2023 21:24:52 +0000 (UTC)
Message-ID: <e6cc8658-fe93-c2c0-603e-093cdafb3cca@rocketmail.com>
Date:   Tue, 18 Apr 2023 23:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/9] regulator: rt5033: Change regulator names to
 lowercase
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <d4218947e354aee45589acb1060ce41727a26750.1681646904.git.jahau@rocketmail.com>
 <19ceb0f6-1225-c8cb-1469-3d657e66d171@linaro.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <19ceb0f6-1225-c8cb-1469-3d657e66d171@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 16.04.23 20:32, Krzysztof Kozlowski wrote:
> On 16/04/2023 14:44, Jakob Hauser wrote:
>> Lowercase is preferred for node names.
> 
> This will break all existing users. In-tree and out-of-tree. Where is
> the binding update?

In my reply to Rob's comments in v1 I was pointing out that this will 
affect an existing driver. There was no reaction.

As far as I can see, there is no in-tree usage yet. Though I can't tell 
about out-of-tree usage. Although if there is, adding the rt5033-charger 
driver might already causes the need for changes.

Well, to stay on the safe side, I'll drop this patch in v3 and will 
change the bindings (patch 9) back to uppercase.

Kind regards,
Jakob
