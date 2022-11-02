Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA0616F08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiKBUpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiKBUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:45:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D66559
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:45:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z6so87446qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsgBnhD+StlYkJHjbJPv8coG9/eowe5XzdG3zACEu0g=;
        b=kZz4fGbechWDCheoNWKozSE4TKIO6InaTFx5I3D7nkDm7xbo8Xxb4OZa3Vlx3J4InU
         fViWih5UD5YOsQ/6scKHEmEIVaS1V9Y4jWTbxjQjlbNJ9vTneotv/lJR6aQeeIDuPHnB
         C9K48XnJPc4djN3YSxV25lfojGVpTf+NCDD4JCFWcDQ+tIJNgJZDocyf3jtvpd4V3kex
         W6F0oVczqneXLm15AL4wtH8R9nHZyw1/Q/r7FpAdHXRIEH+hoVVvCtfJ7SvSgJL+dhuO
         qruSq8I3QLdwiyYIJ6MgJHjxTkDyYNQMs5SlWjOm4r1hRKJ1CxLNeEz3quPMN0uFapwM
         PNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsgBnhD+StlYkJHjbJPv8coG9/eowe5XzdG3zACEu0g=;
        b=G/aq/A2+dx9pLPxIlgcz1HMLoCYXfuaw/yi/bidHPMJbT5x/+Xqg4EYeojN7E4mrXU
         9VCj2aeQs5MdIQvPe07pgRmho9lyIkFVukkprnZO8Rc0jtVLsN+hLvGoQchjIQZQZCgy
         C4aLN5VWhylMiA5d+mJqqVyZUgcgg56Uo1XjnPt+in71AGE/zI1V41a+obeKP1E+frjk
         OiSpRjkpXFeBWoQwtrQ9lN/PiIHofzGDAlk9d/5PcC9kOXGl9yyucidgX8wlrQzpF41a
         O2cPXq6NTd2w7MwM5U0o0BnSJ9ViJAC9UgGS2AlZYeED4fWnhDQxq41G5IaIUbJ9BMfB
         Sd3A==
X-Gm-Message-State: ACrzQf2Eb+GH4nUS5CXu3wJrwJMlcVC2WY1fcuW2UAncqrrb2YZLvIAY
        XO1pc7z/5El/FhD/12wy/79hBQ==
X-Google-Smtp-Source: AMsMyM5QI/mHGZBEb3PXe/1szUOQbbEBHCmLJnY1CHrW+2T+GlHfVm0lp/6P7wb4CDfKpSOUvPf+Ww==
X-Received: by 2002:ac8:5bc9:0:b0:3a5:71c:61ac with SMTP id b9-20020ac85bc9000000b003a5071c61acmr21649224qtb.680.1667421930347;
        Wed, 02 Nov 2022 13:45:30 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id he40-20020a05622a602800b0039a55f78792sm7102776qtb.89.2022.11.02.13.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:45:30 -0700 (PDT)
Message-ID: <2bde4bd8-44d3-7049-95c3-3f3f658ca304@linaro.org>
Date:   Wed, 2 Nov 2022 16:45:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/10] arm64: dts: qcom: sm6350: Add pinctrl for SDHCI 2
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
 <20221030073232.22726-3-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221030073232.22726-3-marijn.suijten@somainline.org>
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

On 30/10/2022 03:32, Marijn Suijten wrote:
> Use the generic pin functions specifically for sdc2.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 44 ++++++++++++++++++++++++++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

