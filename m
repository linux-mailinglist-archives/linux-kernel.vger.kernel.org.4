Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A16DD262
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjDKGI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDKGI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:08:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE5FE6A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:08:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id xi5so17534388ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681193304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7LX/86biFeuZ67y+mdjDqHPfY/k7PmtqCZCBZyXkP4=;
        b=EpPkoOUiBYyrFvk5M9L4sWXQr/haccxnxqbhUGSe6NzQfsvTWoEjMjEvig2r9XGd4d
         N3zFl8qWuo2a95Onoqvz436Z58A8hO8nMI/c6XpbWDLeDw5irsFDcsigeMvVhDJkjd3J
         RwzbFCT4rbwhQozijl8mEHzOelsgNw5jKxCDWI8VoAzDRx2AtGIV7GDDaSicflo4Ig3C
         vizu2SkXppErKkofE/Uib7bJynGLv9lL30DvLzyxaXkaHqKR5m9DblEovc62O/adAwm5
         HeJeZ6hK+lnuULvECJgS4UH9MlCvjHGj+GZ0pkoB9TfdNxN+LmitNxOEKEv680w3gcwO
         dmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7LX/86biFeuZ67y+mdjDqHPfY/k7PmtqCZCBZyXkP4=;
        b=EhHCX9FrIXHlEE/CD4VIQVnTQ4dxWCuD9PmnwaNOn9I+cR7uMGLxxFS5bw+9woA9js
         2k3kGlImLrlZ5tXqma6PST6APb2WByVwHudSzw/7pOsgxeUSakcqwc7XdIngWeeclhcU
         4aPZb2tg1H3tHj0sECPrcYwzDGjkEqDJSlLQWRU9I1ZGjmtqlpFI3LInAqMpI1eIRfjQ
         aBPxQ5PiI39yvncz2DhipjYyA2vFO9mg5c9K4TNtm2LoeCU8Nzht2P/vpmCdd4cRF9dy
         pXN1cqcPlxd3YMdZ6ICmUZqgVarknFUfjdSP3TwdvQWNkt4gX+UCxSEN5nS18Z3/Pe6b
         og4w==
X-Gm-Message-State: AAQBX9cOQDEp8TwormQp8hwuhv/DXiwCllwF0/mrYqP7jYv1KxevQgL6
        lDYWqIgomERl9hzW/2bXIbgqMg==
X-Google-Smtp-Source: AKy350bDR9ld1RyHS4rvrZY101w3YSgLDpFWb+Z/8w7wrQ2vThed+0dViCJMdG2YCJaOnDgpVEGhTA==
X-Received: by 2002:a17:906:f992:b0:934:2fe4:4921 with SMTP id li18-20020a170906f99200b009342fe44921mr1343036ejb.19.1681193304179;
        Mon, 10 Apr 2023 23:08:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b008cecb8f374asm5735259ejc.0.2023.04.10.23.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:08:23 -0700 (PDT)
Message-ID: <6e22615c-d9ab-358b-efa5-708c4362d8d0@linaro.org>
Date:   Tue, 11 Apr 2023 08:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 3/5] dt-bindings: thermal: Use generic ADC node name in
 examples
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
 <20230410202917.247666-4-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410202917.247666-4-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 22:29, Marijn Suijten wrote:
> Update the examples to reflect a future requirement for the generic
> `channel` node name on ADC channel nodes, while conveying the board name
> of the channel in a label instead.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

