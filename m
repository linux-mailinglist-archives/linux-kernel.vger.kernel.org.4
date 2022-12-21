Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAFD6534F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLURSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiLURSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:18:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F56E25C42
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:17:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o6so19590215lfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKrXA3voEyFjOSrPuBw4po5+0nfjKm1BQpiqywMAE3I=;
        b=NlBiJ/E2Yt54PywlbOIicO7rwtW4PNGs+g7ySrU2NYEZwf1bSGkOmtZM0sOXo7JGhk
         KMZoxHAFWaeSFdSflnFBxul8GRG/nxMQd6syUDZzpeN5nx/N+15TKDVFQuX13ggGGO02
         AUR+994xKO/SA3vki124lTk27purDRB3hFGlh43QJsdQB9J3yUIZfLKEZgQFjhzekYXh
         xPj2KhYI3duexmodZHXqr7FX0j4AcMR4ck4nN6a1QBG26Pau+b+5+V38ABlmwmQsC/Rn
         aZO6dtCC4/4tP3fnA7LkgNz7DsCsafFvM6knQjJPaD5VgNuiBuxOYARgWOWElDuQeYQp
         1Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKrXA3voEyFjOSrPuBw4po5+0nfjKm1BQpiqywMAE3I=;
        b=8Rus+IzcHfSg5LnMbjJxW8eIAScMitidaGJpkuI0ERS6072gUW1ayQ6Xx5p51HF9du
         v86vvpCAk+5lr45LLlLJssIvJ4ho4eSW8HUa/LIsPbUw9HaI5kLY9lBGiLi6zlTOt6zo
         zwe8P780409UFlLu94eAkFWtbkfSqQMQ+l/DpNFxVn7NizPpe9FC2UsdmDGa04IW1/0Y
         dxrXDfwr8Fzapp19RpcEwHv570BIX8YKXDTKNBMWtxOvk4uz2CY6LchzBDHVCXRGFYGm
         NIRs0HqsNPfHgCNvM/tunp9mzt/b8CmvJ2dr5gT4hQLKRaB6zzKqrYwU8fNZwHF8InXq
         cplg==
X-Gm-Message-State: AFqh2kreW+4SbUVactzwcBIGp7w3cpFGFITpnR7+K3iq5PUPPyIEyys2
        7D06a5oQBJUSo/Dd6ruzAN45Gg==
X-Google-Smtp-Source: AMrXdXv0h1y45BNYGw8hhIOuFkrv1kqp6WAk9k2Cmkc5TZSFOwNFKAj7Xt+aeHOHZ0hRo23tSSFRUw==
X-Received: by 2002:a05:6512:b25:b0:4b4:b8fc:4ac5 with SMTP id w37-20020a0565120b2500b004b4b8fc4ac5mr908022lfu.3.1671643052449;
        Wed, 21 Dec 2022 09:17:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q27-20020ac25a1b000000b004b4b5da5f80sm1895027lfn.219.2022.12.21.09.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:17:31 -0800 (PST)
Message-ID: <621910a0-d851-409b-99e8-7bdf95dc539d@linaro.org>
Date:   Wed, 21 Dec 2022 18:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] Documentation: dt-bindings: k3-r5f-rproc: Add new
 compatible for AM62 SoC family
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hnagalla@ti.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, j-luthra@ti.com
References: <20221130134052.7513-1-devarsht@ti.com>
 <20221130134052.7513-2-devarsht@ti.com>
 <b4b608bf-e347-5500-eb94-bec3611f6a56@linaro.org>
 <645aca4d-b19c-390d-b899-fd40a924a096@ti.com>
 <12010f8f-d1d2-be18-8d4e-e1d282cb1670@linaro.org>
 <2c058ebf-c39c-9cb5-4a6f-afe88940104a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c058ebf-c39c-9cb5-4a6f-afe88940104a@ti.com>
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

On 21/12/2022 17:29, Devarsh Thakkar wrote:
>>
>> Just look at your patch - it is clearly incorrect. You said in the patch
>> that for compatibles other than ti,am64-r5fss cluster mode is BOTH [0,
>> 1] AND false.
> 
> cluster-mode is BOTH [0,1] and false only in case of AM62x as per below snippet

Yes, for that variant you have conflicting approach.

, but since it's under allOf the impact of latter will supersede, schema
validation will fail even if cluster-mode set to 0 or 1 for am62x due to
below snippet as shared in obesrvation log above [2].

Yeah, but the code is confusing. So again - you are saying with allOf
that both conditions are applicable. Your intentions of superseding do
not matter here - you said that allOf conditions must be taken into
account. These conditions can be reversed any time, don't you think?


> 
> "  - if:
>       properties:
>         compatible:
>           enum:
>             - ti,am62-r5fss
>     then:
>       properties:
>         ti,cluster-mode: false"
> 
> Sorry for the back and forth, I just thought to describe more clearly what I was up-to as I thought above should be functionally fine and it also saves us from having separate if blocks for each compatible, but I am open to adding separate if blocks as you earlier suggested if that seems more cleaner solution.

You need to fix your email client to properly wrap messages.

Best regards,
Krzysztof

