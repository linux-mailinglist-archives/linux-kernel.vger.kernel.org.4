Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C004261896D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKCULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKCULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:11:47 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62720369
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:11:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id mi9so1907381qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrimzIzPPp8bVBxanaG5ga3MP/bHph4X0kRJkSrYGJc=;
        b=N8Cx5l1oJCmtXUgDvJzA+5DBhwJX0WYyN6pyDK2XT3XLafugSjYynbiiRZ/oDk+THK
         Or4XEAnDoEu/AwbpYuyuARki9pJA9EJRZ3AmPbMG6tQVA/lIGsJz6Q1L54lgx21q0nBi
         RqP8nnSVvxLrCChM+ARWz0XrqiBJAtFHafg/IyhMaEo7+AtjgEe171bHPWIanZNXxIcC
         peUFkLK/NbskjEMfbPjcP3Mad4FvMQN8P+AJarl7gVL1xuPq1ul8olN8ccYkCmG30DbZ
         vOD81Qtwe6XcMlAvo/3cpZrOgrj1+7Lz99HL0wGzVYt8Hqz99fgKnzAN1wJd5yuGlNgP
         863Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrimzIzPPp8bVBxanaG5ga3MP/bHph4X0kRJkSrYGJc=;
        b=bKsRHVRKYDi8aHJ4CkUeIle7LFWFm0jOjJngwpKqNiLRhhMKp0WTjW9dprtXSpmy31
         OZBHadZJjlNJlwAD2pTi2VE0H1wWEinWpgx0JYy9gYBPlqriRIEAhvAMCxX5ZJ+kvb/m
         R6Jz0xqbTTY0PLaL20bHGot26+PDtpf++IPlXBoKmgy+SyzVF8ci2qMZLFKiDsL7aYxz
         dvfYs4D5VRhOl0wFWjysVgBXyeFSobxwzVxmSW3stLfJLyraq/YXRbFgCQEi/UoirTPs
         yKKEVwlgJjUY4RAIEtgSxc+hY0CaIMd4dnP3xqFCIESBUCCcXKy7PocDnsBvPCQKtmR+
         aNcA==
X-Gm-Message-State: ACrzQf1dDobKWz6YyqqT78PYvOX1EmtGh8WP+qlFQrW8HmKlzrEeYWVC
        pZ8DoKtijEXQOGST6Xvu5eKrpw==
X-Google-Smtp-Source: AMsMyM5H62kxeV7yp7AnAcnsjXUa4XSGNBIeAuiCZPj9D8LmIKBTqDX2L0UvDLi+oSYenytveGQZEA==
X-Received: by 2002:a0c:cb01:0:b0:4be:e9f3:6d0 with SMTP id o1-20020a0ccb01000000b004bee9f306d0mr3714969qvk.3.1667506304876;
        Thu, 03 Nov 2022 13:11:44 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84902000000b0039cb5c9dbacsm1087850qtq.22.2022.11.03.13.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 13:10:58 -0700 (PDT)
Message-ID: <530b1295-1b8f-fcc7-924c-6f20e0b604e1@linaro.org>
Date:   Thu, 3 Nov 2022 16:10:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] ASoC: codecs: wsa-macro: parse clock-output-names
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
 <20221103195341.174972-3-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195341.174972-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 15:53, Krzysztof Kozlowski wrote:
> If we have several instances of WSA macro, each one of them should
> register clock with unique name, so parse clock-output-names for this.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

This one patch is a duplicate, please skip. Apologies for the mess.

Best regards,
Krzysztof

