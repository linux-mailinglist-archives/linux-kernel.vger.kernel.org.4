Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B324F66E0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjAQOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjAQO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:29:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D743D0BD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:28:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 18so45291665edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaZ0IlVdh+q7MBEpI5jBa+K8Ee5vJI/lj2dgRFdnnfc=;
        b=TunKgBrKl0nB1l1mnTlj9qfcrW7V7u2hmKrKebfgF7hNWS5OAtUPFGLW6NE4aRMG61
         KgR6XPx76BJWkR/4/jxt6g1jNHayqp8cq6f3DZW6fpbsMuSKvQH4K6uLjaFGtAQQADbK
         Rn/JMzaSFZM4eGJ6yvQIkFy4IkZzGkyxTIjuLMVudMn5N6BS8rD7sKbbH+c8YpAC0lel
         hSxs7RUJ6yM+1TK/SUy/T9Flz5edcthPI/TsDvZKbb7Uipg7zJ4S2LaAaWns6zRDFZ1g
         ODA7NJLDAteg/y2gsw77M6T8yRqynFSIH+fSD7cdCifYADENymasX9n25ZqLkSJ8uwKb
         F4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NaZ0IlVdh+q7MBEpI5jBa+K8Ee5vJI/lj2dgRFdnnfc=;
        b=sdDYnuZPWwVry2cHNNkhvEbxplFMFy+D2hpOF6Y9ik6+oyeuCvSO5ixdet+nBKKUv0
         dkV1GgiXyRL3Zo2Zala2me6Ak3LFcRCIFQambUqSPkCceUyVCISpVj34egaE4ziCn9qv
         6hoC0V9iLEG4Faa0wquPTLsftVLucMCOqkVORR0l+uQg8UlOelrruNdT23f4FNl6l25a
         Tj3iHsNZdhHGcfbl2SnGeOgVrtvKQrOFb8LE1IhyAH3DSxsj/sPxmmAyBpOLwW5ocYaa
         9Y5qvcx9PAcxPVGPUoqtrP6DPpODuc3gVh23MUc3u96BrwwXEfALnKhGaz2RqujGFiJe
         /trw==
X-Gm-Message-State: AFqh2kpSMZFsmjjrLrj9O0D1+7hfw+39W1z097gwrc5wPzS6biua90JY
        sa9ZSA0GDhL3c4LeUWhSv5ZqNQ==
X-Google-Smtp-Source: AMrXdXsYfQvUo/LDJi+qTb01CAhI9LdxAJJZGKIxi9fU1dJzQV7GO0zUblV27hUr3bg/El7pIE+qeQ==
X-Received: by 2002:a05:6402:1944:b0:49c:1fe4:9f17 with SMTP id f4-20020a056402194400b0049c1fe49f17mr13597246edz.37.1673965730355;
        Tue, 17 Jan 2023 06:28:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id gh9-20020a170906e08900b0086f4b8f9e42sm3384284ejb.65.2023.01.17.06.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 06:28:50 -0800 (PST)
Message-ID: <5d15d855-c239-7d4c-34eb-726577d53546@linaro.org>
Date:   Tue, 17 Jan 2023 16:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/6] phy: qcom-qmp: qserdes-com: Add v6 register
 offsets
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
 <20230117142015.509675-3-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230117142015.509675-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/01/2023 16:20, Abel Vesa wrote:
> The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
> UFS and PCIE g3x2. Add the new qserdes com offsets in a dedicated
> header file.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    | 82 +++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 +
>   2 files changed, 84 insertions(+)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

