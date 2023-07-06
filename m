Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A074A04D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjGFPCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjGFPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:02:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32F1AD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:02:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so1199656e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688655764; x=1691247764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShCZPS3QZP1WxvM+laqbA1ektriqvwCEsnAV0D6tNnQ=;
        b=CEUbBORUQE1GtxOv6tF7xdgOvVuagv6tfUfPINwGS3SnADxxyXVzzCxK0rHsZdWzFW
         rh7XPCUutTF+ZimsnEqCIRU9n5YXs0Hru20XPkMzwEAQZfy5G0iTxnACgbDNxhTUHusk
         PxHSZLaV8Axb0aUvGiq61/DTpPn5MjWQuJdHIzQ94f0YjCi3rvnPsKurrEWVRx1xpvjx
         wyL4O2wfXNFkoI6Dmi7tWKvJRBWFDnCyvzyPXDy4u+9Mf1tmQ3TmEiFjeRuwSnJduAhQ
         2RPzCoX118mWzPV27uQnBXB9oShgJdugzMiOonvr22mW2pKDXL/iKnJLWSsdKiTHeQW+
         yoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655764; x=1691247764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShCZPS3QZP1WxvM+laqbA1ektriqvwCEsnAV0D6tNnQ=;
        b=a+rw7qBGATewSaLbCnJPTdXWRQ0Zc3M4MIwMVSlRYUqlTOnkJAqJ39ew3fVtpQCgBt
         4v3ceK7Q+Hjeoaq+edmhZpqr69E7ALciEGOcrT/xlsmPNKv6znrYj5VN0QgLVa9S+uMN
         tsZq5YD+cJGrCCpliNfvYrIW/yr8zuOaulPddjlNPBXwD/xwtQtNG+IPleLaSRqX1j0b
         z6vkZg9P0DlBsn/QaezOspbKXpZiXA95dA+wsu5S4LQTRvYYMYOYcSW/PqNOEURQ9htE
         Qhu1tqzlMDxVi4mgUbvhDJupHikkqNMajkOoEwGt6jKbqtQEAR2H3fnDfWtH3YZzAEbX
         EjHQ==
X-Gm-Message-State: ABy/qLZPaoq3yPerV+jdWJic8LID5IDEEXVz+w6V5NyZWXja18E5Hf/D
        /Otiejf0N5ad/StKxyhoud2Mdrc4AeIgXzG24I0e0A==
X-Google-Smtp-Source: APBJJlF/7j+jxrI3O3E3kRdV543QE7A/trE8YDtzL8IPP5Y6+Ph6eudlb2HGwssr/ftyzXQRt2DNBQ==
X-Received: by 2002:ac2:58ce:0:b0:4fa:9817:c1da with SMTP id u14-20020ac258ce000000b004fa9817c1damr1630903lfo.21.1688655764004;
        Thu, 06 Jul 2023 08:02:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id m12-20020ac2428c000000b004fb7584b7absm298983lfh.5.2023.07.06.08.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:02:43 -0700 (PDT)
Message-ID: <42126323-7414-11f8-7580-391edd0b3b5b@linaro.org>
Date:   Thu, 6 Jul 2023 17:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] Add support for pinctrl in pmic chips.
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 15:30, Rohit Agarwal wrote:
> Hi,
The subject should definitely specify which PMIC chips (or what platform)
the changes are for, otherwise it's overly generic, so for example:

Add pinctrl support for SDX75 PMICs


It's not a big issue, but it helps when one needs to search through email
history for a specific thread.

Konrad
> 
> This series adds GPIO support for PM7550ba and PMX75 pmic.
> 
> Thanks,
> Rohit.
> 
> Rohit Agarwal (4):
>   dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
>   dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
>   pinctrl: qcom-pmic-gpio: Add support for pm7550ba
>   pinctrl: qcom-pmic-gpio: Add support for pmx75
> 
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 6 ++++++
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                      | 2 ++
>  2 files changed, 8 insertions(+)
> 
