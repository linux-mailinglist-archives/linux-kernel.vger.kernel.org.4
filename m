Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0267F659A64
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiL3QIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiL3QIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:08:42 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187BB1BEA2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:08:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s25so22472354lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+XZHGIpulnrk6UeuGmkBAGm9SCc/MFKF9J8rbks3c0=;
        b=Mb0X+5bT7/GlQRuARbA0pIFikUpU0mww4rMiNW8FwhwkKR3fpmttSq6/ZRyUpTaGWT
         fTRupk09o5RCZ8d5EZAUTwBeUuP8Zj5zi3DCiv/qsUygWvnhUVwJH/esQAhktQOgkhWY
         vWAXfse8jBqJUkx/bFejr/ALNSZrZDNnn/1kgZOxgy2/hscqA57xLsLQar2kOxgHNwx9
         bNydihKhYeTozUeWOWzx0YCxWcbZD2aX1W8OpXH/jXPv78AdPxr6zCnCJG2wRxVKhKA4
         jrNkUB66LqHH155XKKKSsmcDbKLojsMRmVkexeuKz2sMtpL8fupBQWNHp/+susyU5qBU
         VgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+XZHGIpulnrk6UeuGmkBAGm9SCc/MFKF9J8rbks3c0=;
        b=znyJhT5R1wOD5gDiZ5M+umVfeP64jW9JbZS05qnymXyqFW9SJL4SGBquOgPDcfpChi
         wYqt/qkB2Lugp7SmgSuE+t3sQZePSXoKpJDNNlkhZHgCoy6P/QwpwBnEKSySJyEpgAG6
         5/jEHwtAsDve12G9RUes66tZ6Qx5ijZX1xC/2FsdF20GWjSWBdgAIAFE5DJXiI7wKlVp
         aINHBnTOhBPaAv4OVSofLbKvqI04kPJeHoqgmXsNvHTF6OKKzaZgl6Ok/xNeDzbDD9VQ
         iM4QOGIk6NWgx2WkGlWmwEfvq+ZxsJiTSIVHM7DsWVGkeEbQ3qo3GU/QpujmQgJPQG4H
         7lZw==
X-Gm-Message-State: AFqh2ko8gFkmvpgWhA9MfjRMo8fjW6LpqcWfh3AJlFGlvVqR/bTGdObO
        XFWOngSKyzYo8Vz3VzfR6/PEPw==
X-Google-Smtp-Source: AMrXdXvRn3sUfEbSzeRam9/Uw6UtQMtyJKA0wCqO4TX07lj+cfIknvXkCdmVIVG/fZcE6LEmnhFktg==
X-Received: by 2002:a2e:a4a4:0:b0:27f:e162:15c3 with SMTP id g4-20020a2ea4a4000000b0027fe16215c3mr690799ljm.48.1672416519325;
        Fri, 30 Dec 2022 08:08:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p5-20020a2eb105000000b0027f77c96339sm2706881ljl.0.2022.12.30.08.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 08:08:38 -0800 (PST)
Message-ID: <4d847dbf-c417-eb82-9ae7-53c52844270d@linaro.org>
Date:   Fri, 30 Dec 2022 17:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8250: Touch up audio hw nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221230135044.287874-1-konrad.dybcio@linaro.org>
 <20221230135044.287874-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230135044.287874-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 14:50, Konrad Dybcio wrote:
> - Expand long clock-names into vertical lists
> - Shuffle properties around:
>   - Make sure compatible goes first and status goes last
>   - Make property order consistent between similar nodes
> - Fix up indentation
> - Remove stray newlines
> - Remove a redundant comment about swr2 being associated with TX macro
>   (it's obvious by looking at the label property 10 lines below)
> - Change unnecessary interrupts-extended to interrupts
> - Disable SWR0 and WSA macro by default and enable them on SM8250 MTP and
>   RB5, which were the only users
> - Remove stray #address/size-cells from txmacro, as it's not even
>   supposed to have children

You duplicate here some work:
https://lore.kernel.org/all/20221225115844.55126-4-krzysztof.kozlowski@linaro.org/

and maybe:
https://lore.kernel.org/all/167233461775.1099840.3444272939352778399.b4-ty@kernel.org/

If you wish to avoid trivial cleanup conflicts, feel free to poke to my
pending branch:
https://github.com/krzk/linux/commits/pending/dt-bindings-qcom-new-and-fixes-for-warnings-linux-next

Also, this is a mixture of non-functional changes (re-ordering,
whitespace) with something close to functional (interrupts-extended ->
interrupts, disabling nodes in DTSI). These should be split.



Best regards,
Krzysztof

