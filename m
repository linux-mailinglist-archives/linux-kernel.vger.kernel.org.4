Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B96E35AC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDPHWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjDPHWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:22:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F01B9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:22:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u3so4291074ejj.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681629730; x=1684221730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrJuCakYyfV5iCG/jhcx42zwUS3Y7qdP1AOHSydzsDU=;
        b=wgnYeb3CMbuHs6JXpwgIezACl6gPPa7WysSjJEa4/uyObY7OChHZ4n8bUiR4sSFTcz
         CMtdmmPKDLkm4xFFDzby3qv0ADV0h82cxXFZ5t1QILrPy9h6OoPyrAuwEEAbed0ELmXl
         alsE5O5RUn8CBTSUl04zR5VSZ9Xi3xByqVe42+ftGp6JQcQClVzDwQHpuTVTi/82WaVp
         Y/aJa37lo4T41FZO38toU0E1+gE6z+yDV46YBI6Kx4aCIgnGnv+KxPI4gRyT4DYpNDzd
         89q3DV6oYJ3YRtDAxtUn3ck5i13qCWExX7/Hic64EYpbMZIQIaawzO9+2IobL0UIMbCS
         aXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629730; x=1684221730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrJuCakYyfV5iCG/jhcx42zwUS3Y7qdP1AOHSydzsDU=;
        b=eJVmrDp9ewgFweNhSEfJXdVi7RayQe3efa56u7xdsxF16FORx29wSHgIgoVJRTK0WL
         xMoKAXM+x67Fj7I//oZsYI1nCtu8RZuoJWBEEbxnQ5mbRafFyi8kZcZFdnQhLsgKI1eE
         lXsVx9w18vwEkV2OvrCi2wwz+ZOJYrFkWExiLDtc4QE55rLYlu+nnYSeElitIFiJ0e18
         UT3zwfxY+5iS0ygqbsLKvVdi1WnmQQ9XEiJZ/2qCZlt7XAvst+WHN8jhN/LvOTr1VWf5
         lF1zUkrR2gBPNcrrIUZ2t5FpaWQrkFpPRqUGFfYtn5rmIiLO7PuAPXBWZrKk+rF9WGTc
         utjQ==
X-Gm-Message-State: AAQBX9dYjd9fEZ6tNsAH/TAYgav1nBJA5dyARw3KuNYCuzc07c4fB0RM
        X0SfVqQ+rV+i9G3WvIXwRS2EAXNzElSu6tNwC48=
X-Google-Smtp-Source: AKy350bPcBcJ76oBB2ejRwHsu8kO9N7yc4y4FnZ+vG8e2Xy/bMtBRVwSYX4GmRi9Ctmx96Ksm10e0w==
X-Received: by 2002:a17:906:9813:b0:94e:ee18:1228 with SMTP id lm19-20020a170906981300b0094eee181228mr3577846ejb.35.1681629729841;
        Sun, 16 Apr 2023 00:22:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ji12-20020a170907980c00b0094e1272bd12sm4725455ejc.159.2023.04.16.00.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:22:09 -0700 (PDT)
Message-ID: <9e7ccb2c-265b-befb-ceaa-30fb4d0e379e@linaro.org>
Date:   Sun, 16 Apr 2023 09:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 12/15] w1: omap-hdq: allow compile testing
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
 <20230415104304.104134-13-krzysztof.kozlowski@linaro.org>
 <f5683efc-733e-a5ee-b3ba-6b35e04e23b4@infradead.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f5683efc-733e-a5ee-b3ba-6b35e04e23b4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 18:05, Randy Dunlap wrote:
> Hi,
> 
> On 4/15/23 03:43, Krzysztof Kozlowski wrote:
>> omap-hdq does not depend on anything from ARCH_OMAP for building.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> It appears that patches 4 and 12 are the same...

Yes, I messed with git format-patch a bit. #4 can be ignored.

Best regards,
Krzysztof

