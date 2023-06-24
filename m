Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0473CB2B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjFXNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFXNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:55:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B3E62
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:55:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so764561fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687614914; x=1690206914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7n7f2j+EMyC8PXYiwMfyicqeP+FHCYf8oKKlFwAX47I=;
        b=s8dCH/+vA65xIAvBWTEn7oHmjky3lDSK3zvLdKsZBg7qelWicIXVf2xeTm2s2K0Qov
         QWYSQC03cg94UYUdzaUyO0/yRpISfHh76qnyBfZpscsK/pjFfpSxPVPtDlZKxi7T06H5
         maIXl4OqZ/vD2FmqE9bKpsT5PsuTaFSOy5LvbrRCRXVVFOWshFZigneQ+C2B88yFIP4r
         bc1sf7IQRUUHD5nmB8Tq9JLh/GafW7qiG3KUFr7/u6fEJiB4T/ilZJtiJkzZhdWDI1EN
         MRK9yB2l81tjePbamPN3vgUqA7pJyi6/ZCM+KpiedOyNsZjQdH6O/8HMpn9kERoL8kQl
         c1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687614914; x=1690206914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7n7f2j+EMyC8PXYiwMfyicqeP+FHCYf8oKKlFwAX47I=;
        b=cOcgfwYc9BIDFyMZ3dokpKpBcOlFNGhxGooNoWJnnsfLSmaj5FtyntjG1b74uH3QXG
         vlnjOtv38aL3bt0UmaEvhwypeuw8xc+X5ybDq2c1i7+ewrSriw4ELkBTU7rkFc8gR8P4
         W6DrIr2fQK8CqNv3Rc2KRjD5VY/5zvlIui3UnNS+sdVicENlRisCnOIDbhJPrs+9PXTX
         hIGxFrg5IPdLB9nUOpBP4um8S+HbKR8TC2hKjtr0m4yN8sJBfLm4RTDz4f6eA77GJbeO
         mxFqJ9IGIDAMr4NzwiAnt1EcEsN5nR+CRI5UleVVtg8gqjY4LA7g99Um/iOOVIJGigD6
         k2YQ==
X-Gm-Message-State: AC+VfDzYawxWVl3dAb4zeiUP8ymmTWsYZzxve5hRRIfJLmlqt2ZF4ezM
        /l87slkUbqMROhdecw+iH7Lp3Q==
X-Google-Smtp-Source: ACHHUZ426/E1B9Uqk2kE5mpc4XbeW6s8koRCJX4KWBE+b4BBK3aSr8h57d/zCuTzAzlZ7miJeuBtww==
X-Received: by 2002:a05:6512:3f19:b0:4fa:6d62:9219 with SMTP id y25-20020a0565123f1900b004fa6d629219mr302709lfa.62.1687614914483;
        Sat, 24 Jun 2023 06:55:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a11-20020a19f80b000000b004eff1163c37sm277334lff.308.2023.06.24.06.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 06:55:13 -0700 (PDT)
Message-ID: <804447cc-2d94-2eb2-7e7d-e0dbc9348c67@linaro.org>
Date:   Sat, 24 Jun 2023 16:55:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5 2/5] clk: qcom: clk-alpha-pll: Add support for lucid
 ole pll configure
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230623164619.11464-1-quic_jkona@quicinc.com>
 <20230623164619.11464-3-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230623164619.11464-3-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 19:46, Jagadeesh Kona wrote:
> Lucid ole pll has as extra RINGOSC_CAL_L field in L register in
> addition to the fields that are part of lucid evo pll, hence add
> support for lucid ole pll configure function to configure the ole plls.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since v4:
>   - Newly added in v5

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

