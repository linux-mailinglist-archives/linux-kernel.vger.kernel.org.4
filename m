Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7A6C02AE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCSPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCSPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:19:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC991CBD7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:19:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so37862714edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679239184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Q6ClqIgVOHNCTBlkJq9gBU6UBpDkGzT/c4HHOyonXE=;
        b=UhN7bYBnd/YU3Knem+rzukKTpmxlSYIQOOlkOCx6eTVtLQjaWVUshCXSA6fkmc7psv
         ciOydeCX1OIHbpTjZ4tPu97FNdwh+EufTY3EZWgv7JD7JZ9bGbRnuoMxup14PhRHoX2Q
         rDjpGg+YjZ8EoQZna6y8kOHGvLsOuO0khl6mUWgseQQcRcr3FuXr3+vl+bRd29yvYfMw
         XEPhmBfOwlxecQZyLuXAw3NBkrT54RKD3+aigV+X9avwGKlmU/I1nejSOsH9Ocvn+FNj
         GQrbV4mzOkknwJytCW4WfFaU7hYlv9O/yxADaP2OaZSRSBvIAk8xPtGf7RR9WsxMKr0H
         d0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q6ClqIgVOHNCTBlkJq9gBU6UBpDkGzT/c4HHOyonXE=;
        b=JTLUMNq4SrPFB4ROlhBuQxv258Vm/VChTDz6+y5WgbtQbXxcxTAgEFB0MWj2S2lTDu
         0N72m3LWOk4WQQqpESmdcam8sJjF/TqmfEzSqEWPdptA162nThyv7D+jT6JxNIwr78vp
         zy4ebkNe0mxqYXDSk6WKEUWtkjP4dFt7EPh+Ff0SSh4OdNmK023DKeQdqCp3MQDj0GZY
         rfigneVVH41aJQE5hHOHxtGrA2dNbhGK13UWVWO48nlTRAERelOmzGoysvGKElGFXSD2
         OgIMfM5nAYBi78FhRYslytrDryOM6pxr6U864qLzsPrDORTRyBXyL1s0GRgmNc49LuZp
         st4g==
X-Gm-Message-State: AO0yUKXsPffLs5l7QW2v/wLeC8c2oaMmaezpgor8IScSYKbLlaw3q6Z/
        i7bBFidvkeXHk66ofK+6v3berg==
X-Google-Smtp-Source: AK7set/lweaMTIWXmtx9ReSmmvXJnZok55jpk05ti02JFR2ABXcYN5l8llKddo9aAPFTIRZhERW1qA==
X-Received: by 2002:a17:906:4552:b0:884:3174:119d with SMTP id s18-20020a170906455200b008843174119dmr6227816ejq.14.1679239184152;
        Sun, 19 Mar 2023 08:19:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id qh7-20020a170906eca700b0092bea699124sm3340424ejb.106.2023.03.19.08.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 08:19:43 -0700 (PDT)
Message-ID: <5069856f-46c1-39ee-cae1-5bb941864bda@linaro.org>
Date:   Sun, 19 Mar 2023 16:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v2 3/9] memory: tegra: add mc clients for Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-4-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220140559.28289-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 15:05, Sumit Gupta wrote:
> Add few Isochronous (ISO) and Non-ISO MC clients.
> ISO clients have guaranteed bandwidth requirement.
> PCIE clients added to the mc_clients table represent
> each controller in Tegra234.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 420 ++++++++++++++++++++++++++++++++
>  1 file changed, 420 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

