Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1616D1B45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjCaJF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjCaJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:05:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE61E709
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:04:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br6so27980647lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/OtqxTnNq7CqzCkiTooH/rPt2g41wH7cPk9c0SghjQ=;
        b=l3D/Kf7+XbfD+n3e6AGmQUFuB7+BNV9XXr6ywh3aSuqGL95gINH8K55U/BdIr1Bmv7
         XPqnsfQ8Vs2D47naTMounw1fiT9KAAGQY24nPXknTaHoOhvNe/9vAztuKWoE2I8Ga9TP
         TD9LZ7pHDUuagJKKuGzpuWW39hIW+wFuZePmEZkf0dmBooRcNtK1SDueqV5k8HgxHRv9
         ojUHqJ4rZaAFDyhDWKYmHmSyDqb3uSHF8tRZfL3Vvs7BmWui1iEz/jUKYgQvOxe1qTBe
         nTRq9tN0iootRYNfgt2xnbRvXuBETWeWgPxJjFhBWpH7FVjQNtzWgymLuHwC4uxqV/Dj
         e2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/OtqxTnNq7CqzCkiTooH/rPt2g41wH7cPk9c0SghjQ=;
        b=ODqm8hlemNt6qIz+iFC50pq5cW2XL40Ah/cD36JHLSfZRfFSaRNEBfSULDY7C4w+Ab
         MZ+jUHSrhXGi+Ja65Fjo4QoQyAdfdQctcsBap65Tafjyw4+KAfhRhjTFiN7AetF5MNBz
         G3CP218OF6h/7hGmSZ6KfYTXora/nNxMeelMik6pOWc3LFlajdvfV0zv5gnqv0xk81nf
         bYDeU7BimMIXvcr2gOxhyeGSaXgN5L3WtvYbgmHqCt9c7xMLsQ3QBv6G8lrs3ifZSyJr
         xCbncdO8DPkVzaxRGb+hTiNfHCtVWnltXYhj74re7nCqSnqkvtm4uQt15L8zIrzswbMq
         QDjw==
X-Gm-Message-State: AAQBX9dKH45PNzv7QtRFM2+WUC9AS9qCDjssxvabQQCdRw/xB2d+NgXp
        eNYHLqGi+Qoo4cW8at/xII3Aig==
X-Google-Smtp-Source: AKy350bdEbVr8Cjexjw++gtzG0tNjH+qBS6QfktmdF0sjXjaRLe4JrB6MQ7A74GxfHrQlswPE2seDw==
X-Received: by 2002:ac2:5dd7:0:b0:4e8:3f35:6844 with SMTP id x23-20020ac25dd7000000b004e83f356844mr8412347lfq.19.1680253495402;
        Fri, 31 Mar 2023 02:04:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l10-20020ac24a8a000000b004db3e445f1fsm299243lfp.97.2023.03.31.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:04:55 -0700 (PDT)
Message-ID: <66e42255-29f0-5f8d-bc84-8c54e38001bd@linaro.org>
Date:   Fri, 31 Mar 2023 11:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/4] dts: arm64: qcom: sdm845-shift-axolotl: enable
 SLPI
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230330165322.118279-1-me@dylanvanassche.be>
 <20230330165322.118279-5-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330165322.118279-5-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 18:53, Dylan Van Assche wrote:
> Enable the SLPI DSP on the SHIFTPHONES SHIFT6mq phone with a
> Qualcomm SDM845 SoC.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

