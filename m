Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C909705435
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEPQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEPQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:42:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FAD07F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:41:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so21094462a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255294; x=1686847294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwGIJwctsKEQ0OMbefG7QM/4SqoNCHnvRGiJA4BkDGc=;
        b=qLBJDsG/MLNnFgim21/79ssJnuY77CXCyD9AZeu2dGPTaylw/hLoc3fAHIexiUxTIg
         /yKuvkjlA8S84MgBc6OIrLOU7IIODcd/vdC9xgWjh24rrIx6jO1P+QjJf6pnUKUJOm4r
         QgixJJAzLo1/zVfvK4I33RZiprmyY3Qs782Eay8VvMwl/ZeBnOTV7KBBlxfPglrnb2FL
         HDTEOe/nqPIJ7CmMzKHGjkC/mpQvcjYkUghyMEm5SrUYjiPu7JTAU6/nfCenZl76U+UF
         EbbC6ZcRX0K6cKEROV5Amo0IduQ3XgNNFdt2Rqu0k2155U8CxMtAa6L3Qt4eqZMiHRY5
         bo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255294; x=1686847294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwGIJwctsKEQ0OMbefG7QM/4SqoNCHnvRGiJA4BkDGc=;
        b=Pt0aB9/SczthhoFjp4mpV8vg/TBTcImKTG0c8rj5gKz/nPbSjt7+uT0OCDBnIsTQlU
         zkE2dacyWaBBksfk1bfOFdwrg+qKBpjPORRczDd4WO+57e/jlFb2aaRpsT3/XrScD9RM
         QAfCNcU1/QBpylWhL0KX0vBgDGIMq75wEKzLyU0Q7Sa0sasg+fx/tBusgNqq9KNCbxMG
         d/f2yqkFjHM2QnrBtRaB6Ee1zpAEQWThUAWg/BH9kYURqX9sffgJn2aIjI4QOcD/zDyL
         OOFXBPvQLKQPaSUWmNfglqHY/Xkf2YbfD3GOE63h9FXp4EqpataiFnNVD1GKyfAT9NO2
         PtTg==
X-Gm-Message-State: AC+VfDz4IQ5G6AoZ1Biu8UAwusHWoIxD/efBLJ95u3dqTtk3wuNUWlW8
        eLxkJcjqoc3pxt6gfMZS5cvYFg==
X-Google-Smtp-Source: ACHHUZ4oOZegaoLXI59ZydBH2/bXY82LDcXZ3XmrYSg0x4k2YP4bqfDVsIGq2ikWN1qyRJRFwQC6rQ==
X-Received: by 2002:a17:906:dc93:b0:965:d7c7:24cc with SMTP id cs19-20020a170906dc9300b00965d7c724ccmr38154415ejc.23.1684255294435;
        Tue, 16 May 2023 09:41:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id hx16-20020a170906847000b0094e4eabb402sm11115129ejc.128.2023.05.16.09.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:41:34 -0700 (PDT)
Message-ID: <542444b8-757e-75f0-0306-d810c7f065a5@linaro.org>
Date:   Tue, 16 May 2023 18:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8550-qrd: add display and
 panel
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
 <20230516154539.238655-3-krzysztof.kozlowski@linaro.org>
 <CAA8EJpoTd4avVHK4kjJTpq91UvNLS1tdA_s4=nX_gtkWAY_Jvw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpoTd4avVHK4kjJTpq91UvNLS1tdA_s4=nX_gtkWAY_Jvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 18:35, Dmitry Baryshkov wrote:
> On Tue, 16 May 2023 at 18:46, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
>> MTP8550).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

...

>>
>> +       sde_dsi_active: sde-dsi-active-state {
>> +               pins = "gpio133";
>> +               function = "gpio";
>> +               drive-strength = <8>;
>> +               bias-disable;
>> +       };
>> +
>> +       sde_dsi_suspend: sde-dsi-suspend-state {
>> +               pins = "gpio133";
>> +               function = "gpio";
>> +               drive-strength = <2>;
>> +               bias-pull-down;
>> +       };
>> +
>> +       sde_te_active: sde-te-active-state {
>> +               pins = "gpio86";
>> +               function = "mdp_vsync";
>> +               drive-strength = <2>;
>> +               bias-pull-down;
>> +       };
>> +
>> +       sde_te_suspend: sde-te-suspend-state {
>> +               pins = "gpio86";
>> +               function = "mdp_vsync";
>> +               drive-strength = <2>;
>> +               bias-pull-down;
>> +       };
> 
> Do we really need the suspend states for reset and TE pins? Especially
> for the TE pin, where the only difference is the drive strength.

I don't know. For DSI there is some different, for TE looks redundant. I
admit, I copy-pasted it from MTP. :) I can fix it also there, if that's
consensus.

Best regards,
Krzysztof

