Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4D68BE7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBFNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBFNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:41:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96E3584
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:41:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h3so2558736wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tnrt4Zg0tlIQVYINNkRz4s/fKnod8Ek43EfIyPJnxkA=;
        b=TB1Jqw5IMc+jS8irbHdcb5rRFvAI6F2bJgnvrm1yvoFOx+3o5NdBbciSTN0kpj2gVg
         IkPg/U2yhtqHKY9+JfjGPzoa2X9qnthy5/Q+Rn3PEQV1oXWDfyMOGbk1NGS/6PSgcXSA
         gbc9+GyLhsshWzv54Kym/jwOKewprn5oZPkZ60s50npbAvQKLUt43xbG+XdP3/K3y8V5
         vpyfNWJAofZHRo90/hTZDgWzIjuleep1CLC61gwGp5GIk4yqvuFnYM/rfeBw5E6eXcS2
         H6ASBTPncIAlqvlYRBthtfbh3FM8NzU1LSBaoPVuWwdOEvbO2YxWEs5RfGxDgVTiOyr0
         TECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tnrt4Zg0tlIQVYINNkRz4s/fKnod8Ek43EfIyPJnxkA=;
        b=d1NtY/EBqu5UzzX7slArHInBXcdF8VCpopYDBAVqEG6A4MONyRhUFb6C1rBq3XJJqJ
         1j7dmzeKfh4QJYTF5ZG4Bp3cCw1lxvesBWe1/oAx7wfu1/vlnG6iPnUm8oE7N0stwY4T
         8frySbwpd29vPkG1xkVAAl3U10OmujgoE8SsAdMoqKR/WfkC9vyIINrZaTxj+0XAgoBi
         pXwNzXJHsUuQy1zbxfO+xeemBswiIedlhGADYxnHHdmgVTkfwqxuPIEg7pn+ZUgmlnzU
         egnDMwREGRYyIQx/p7LNLuvTnLPWvQjWytJz0df7ZP/VFQBho8cBDK5+EscjsUKA5pET
         vCig==
X-Gm-Message-State: AO0yUKWSj6FvRyGCwpv3uUbVuy+lrLAOiVxZCTN6ZVA9Cc0D7NPQe+Uq
        2oORmu8RpqQ85x3X7UADonRvVA==
X-Google-Smtp-Source: AK7set/UKoisZmflloJVFNAQtY6VIu8OdVuXW1g1Fba2lAi0thkN1OsYsBZMrsvGq/Ek0sWgJ7PzDw==
X-Received: by 2002:a05:6000:15ce:b0:2bf:d17c:608a with SMTP id y14-20020a05600015ce00b002bfd17c608amr24584079wry.58.1675690907048;
        Mon, 06 Feb 2023 05:41:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b002bddd75a83fsm9472227wri.8.2023.02.06.05.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:41:46 -0800 (PST)
Message-ID: <8b164c2f-b7b9-c5df-3b9c-ea39bd3eb424@linaro.org>
Date:   Mon, 6 Feb 2023 14:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     li chen <lchen@ambarella.com>,
        michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        krzysztof kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        arnd bergmann <arnd@arndb.de>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
 <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
 <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty>
 <33c2038b-5e06-4eb2-82b8-007bb735bfb1@linaro.org>
 <186267bd495.c0d336602542450.72693939722996463@linux.beauty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <186267bd495.c0d336602542450.72693939722996463@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 12:28, Li Chen wrote:
> Hi Krzysztof ,
> 
>  ---- On Fri, 27 Jan 2023 23:08:09 +0800  Krzysztof Kozlowski  wrote --- 
>  > On 27/01/2023 15:48, Li Chen wrote:
>  > >  > 
>  > >  > but what you are saying is that there is no separate clock controller
>  > >  > device with its own IO address but these clocks are part of rct_syscon.
>  > >  > Then model it that way in DTS. The rct_syscon is then your clock
>  > >  > controller and all these fake gclk-core and gclk-ddr nodes should be gone.
>  > > 
>  > > Ok, I will remove these fake nodes, and model the hardware as:
>  > > 
>  > > rct_syscon node
>  > > | clock node(pll, div, mux, composite  clocks live in the same driver)
>  > > | other periphal nodes
>  > 
>  > You need clock node if it takes any resources. If it doesn't, you do not
>  > need it.
> 
> If the only hardware resource the clock node can take is its parent clock(clocks = <&osc>;),
> then can I have this clock node?

I am not sure if I understand. osc does not look like parent device, so
this part of comment confuses me.

Best regards,
Krzysztof

