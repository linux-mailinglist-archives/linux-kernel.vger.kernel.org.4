Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F9700A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbjELOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbjELOaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:30:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA40132A2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:30:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965a68abfd4so1896546366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1683901810; x=1686493810;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0OGsKjyATKDb9jYmWbTNqZ4sLTa+V+9kzUcaHu+Bg4=;
        b=NjrV3H/c9DiHGBEjjvqb8Ko94Brk1Dtf/oCUqkm+fROH8lHlSrr1UArdUvMSuEBrTZ
         LG/tVEizSEHlJUQ6SllSMvjU3iTr8RuxOD5O+u1z9ny+O9O+qn5+rpUf8zaxad3xcWxy
         JQN0iIZdGmRwGWUqSgV4B5rNFQVCc5GNL+f0uxFlOSL46MjDUc6RjinVG3auLy59Lnse
         w+2tlm0HEpP81jVq5AOcpkkFZUZRCPRUR1AnN8yEihy7UhOoYS4+Iv+34hKuTifuEGJg
         W2HF0KkXX8wGXC+UhlM6vOA8Bqs+Tku0ObCpDvdnf8n6wG3OfKQH8PW0B1e6Ic2kqOJo
         bkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683901810; x=1686493810;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0OGsKjyATKDb9jYmWbTNqZ4sLTa+V+9kzUcaHu+Bg4=;
        b=E215UXY96IFOdAeR2tjff+AUPVbVBHUoMvIfPlpZlQFjIld+Q375jmEYrj6qEXEW2k
         yRKfj3mT5YGEPUJObi9+Q7++JwV9jKBJpdDqNFmcGgieuZoDYliB5mGrJPlDFppMO/jY
         cLNkvQJsozpk3VLj5u8StAR6O3I23P7/dACsNJmvFdVPT2sJQwDoWlIU8Lj0QKlwLySC
         xGB+GFTyoGO6Q9fPIdrn8tlPKhu5oGm7+GZUWIJdBJmmI04tdW2Bpw1ajkQUNR9mSTdZ
         AJb7XTeruv1s5bgBCLHEVx7tY7/dII48OvNGzMiO0iW63XvGMlE4gPzhrmHEVmxk+u34
         EvFw==
X-Gm-Message-State: AC+VfDwtdJd0PhxXKQCsw8/jR6Kz0CPz75KaOHvHXTplfo1+c8JQlvqa
        9oq8T5dzK5tOQscFvA2Y7WCKwQ==
X-Google-Smtp-Source: ACHHUZ7wfROlWoHHVhBbZ9cSWpXy+k/in7usHaTGZqbXMeEoLhu2Kl4Yjqa2+xah0carSqkZXnUH/g==
X-Received: by 2002:a17:907:a41e:b0:965:e556:8f6d with SMTP id sg30-20020a170907a41e00b00965e5568f6dmr23781673ejc.63.1683901810620;
        Fri, 12 May 2023 07:30:10 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm3518504ejc.209.2023.05.12.07.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:30:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 16:30:08 +0200
Message-Id: <CSKDDFPXC6FD.1TAU3XXOSGA0K@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Balakrishna Godavarthi" <bgodavar@codeaurora.org>,
        "Rocky Liao" <rjliao@codeaurora.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] arm64: dts: qcom: sm6350: add uart1 node
X-Mailer: aerc 0.15.1
References: <20230421-fp4-bluetooth-v1-0-0430e3a7e0a2@fairphone.com>
 <20230421-fp4-bluetooth-v1-3-0430e3a7e0a2@fairphone.com>
 <8f312ded-8456-eced-85cc-0ae32a0c8bba@linaro.org>
In-Reply-To: <8f312ded-8456-eced-85cc-0ae32a0c8bba@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Apr 23, 2023 at 12:51 PM CEST, Krzysztof Kozlowski wrote:
> On 21/04/2023 16:11, Luca Weiss wrote:
> > Add the node describing uart1 incl. opp table and pinctrl.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 63 ++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 63 insertions(+)
>
> Please do not send DTS patches for net-next. DTS must go via Qualcomm
> SoC. Split the series and mention where is the bindings change in DTS
> patchset.

Sorry, just saw now after already sending v2.

Is this a special rule for linux-bluetooth@ / netdev@? Isn't it easier
to keep it together so the status of series can be assessed easier? I've
always submitted patches by topic, like input patches + dts patches and
it was never mentioned.

Regards
Luca

>
>
> Best regards,
> Krzysztof

