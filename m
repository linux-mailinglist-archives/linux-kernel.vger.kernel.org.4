Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A51D689526
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjBCKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjBCKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:17:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F57A07E5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:17:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so4157301wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/WNjPQ18JRVRhyOrTsC5R8S4qdzTnKfuVYcyxolytU=;
        b=Xq2KYOfaW9x9GMrGHICotdHA+FksZKs3pQpRnwtOakPyg+wS67mMubbfAy8SL8pY+w
         IH9i/xAxGjFcjfniH1CvgTQ16VlvoFH8blqO9maFhRFysHVs4f52Jfe3BjH/IengRzy9
         q6i5/YQVF0ySyqw1lpZMVRuFzkxoin/ie+JEd98QOt0pSzBYUxmVGqy7UpK0+7HebgXC
         bUvUwWK8Fjt1Yp79pcizNnj6rZdssJWSoAvwyJ8LPrnMLgfm4DFrc57nbLabE3ktLsRc
         XaqJSjRgiQLn79HXVmAYKB4MJtvf5V1Xd335w84krCvIdWNOlbD8DfHj/7CEyWdIqCEm
         4Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/WNjPQ18JRVRhyOrTsC5R8S4qdzTnKfuVYcyxolytU=;
        b=mQN4ABlS2wIt/ocMcvjyFANW2MNa9wXIdGD80T8LspfKSrHA+YiIntRzclSVxibRcy
         X5yFnLXamKX+tP7RH8FcZCEXd/V86y/dpGq799whdnm3FGpiV+Gvzw+qmHJiCzJXy3bS
         /bWF9lr5+cAvaSnwGw25yipUWnQrAiIjOC2so+Xc6D1B2TBlMGowgQjBEK4YnBOQnhTj
         0IMAqw8ve73Q8OJi6qex3JlGPgpnMXEjIknPIuLI815h3C4GDUzZM67V+VlLBIySa1a8
         gdQu3uk6awxUTWLzsUh+PQ+aV7S1yvHv1qm68Ff+F3YJtR+vtYRdahjr0TXs5qh/tAOK
         OxlQ==
X-Gm-Message-State: AO0yUKUU7X0XwFE2M7fOfZYyUyBkscgC7Ze3lh7V1gp7RWjiuTZMRybs
        Ihn16OkLVAVN6NZPSaTrP1vTAw==
X-Google-Smtp-Source: AK7set8mPBxEY7bgE4SAboc3eVYbmvKHZm+if6cSAOlPEVguCHGCvPSCuS/A/oPxmUwblCrlwppX7g==
X-Received: by 2002:a05:6000:16c4:b0:2bf:f024:de79 with SMTP id h4-20020a05600016c400b002bff024de79mr11676673wrf.37.1675419438905;
        Fri, 03 Feb 2023 02:17:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b002bddd75a83fsm1773632wri.8.2023.02.03.02.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 02:17:18 -0800 (PST)
Message-ID: <2195773d-12b4-0b32-26b0-488d78844e5f@linaro.org>
Date:   Fri, 3 Feb 2023 11:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/9] ASoC: dt-bindings: meson: convert axg pdm to schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-6-jbrunet@baylibre.com>
 <512edf50-a74d-815d-1278-39fdeb1c2d35@linaro.org>
 <1jtu03m6ia.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jtu03m6ia.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 10:37, Jerome Brunet wrote:
> 
> On Fri 03 Feb 2023 at 09:01, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 02/02/2023 19:36, Jerome Brunet wrote:
> 
> [...]
> 
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - "#sound-dai-cells"
>>> +  - clocks
>>> +  - clock-names
>>> +
>>> +if:
>>
>> Keep in allOf here (need to move ref from top to here)
>>
> 
> I'm not sure I get it. As it is, it seems to have the effect I had in
> mind while trying with dt_bindings_check.
> 
> What does it do when putting the conditional under the AllOf section ?

It avoids any future re-indents if you need to add one more if clause.

Best regards,
Krzysztof

