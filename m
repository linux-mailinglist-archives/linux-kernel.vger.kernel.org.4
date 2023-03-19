Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C16C02A9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCSPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCSPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:19:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5FCBDC9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:19:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o12so37747091edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679239173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiXOBbFB11Ip0nTIkggAfEvbZiGBEphpMg7tUKwDv8Q=;
        b=bAZDUQYki7wbeRanSmh1+yCFPmXSZwkqqGPdsRHdCVXC03JyOxd/Y/vKKL6tDt0jh9
         peEJUFK2/gYsoZAmerpiPJwZKpvbNp/99WxXsC/f1NobG99PlsgQVFMQn1Qf3eoXh9+q
         8bcuBj8FrRC3Fc4+nbMmcdPm3MrhPFmJnQ9MscLdwELrfACrj7LwL9K4mtLXZyHggZ14
         VLeHDsdF7oBtL2M5sz9sOTMsxHS7vBr8KEaqpBKqu7zu7dACUr+RhwnYgTklcFLvC2dx
         IVmL7pzPNLKUAbhjBrdREvYc5vm3GwNW9/oGnebln3gS2usBcuSWDAbvX+ehTgJexXXF
         yVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiXOBbFB11Ip0nTIkggAfEvbZiGBEphpMg7tUKwDv8Q=;
        b=QY8j0P/l9qsYtvS03QltR0vbR54V7qRkc6UcYitxnPlotQt6dkHTGSuxut3oPMoqR+
         oGDJBcY/9DGL4g5PBrdWDMFyzGZm+J+29R+hOX6AxYwvqDua9hERu8hUpVnecKOkC3p6
         IEaz0jLwN4AYPq86YVPkvKs+EQ+8T4C8GIkbkIsm3cEsJO1Cwx0gwqBOD3K47gVleYXb
         Gmgg47+B4n7jDRy9V1J3aEq2CKPJ/R/kqmeCZwrahVRLjcGftE/Jm+KYdb396SJOtb69
         Wx2W2uGVxk/orp5/3hIqTScE/YONZeIvzau1nN97YFQ0tPeTPE7VTL6BubD4mDDqJYGJ
         Afdg==
X-Gm-Message-State: AO0yUKXEdX6hP5Fv6EgG4Tt9gqu85e7OEkcPA2Utf2aa6Bpnjnk9bU8t
        BCdABcrSWoK2v8K3LdDzu2Nn5w==
X-Google-Smtp-Source: AK7set+6EyPI1D5fB1UGRkWHuzffRXBguOqPVwrOUmlBfKF0ISupIco1O4Z+5HC+N3PLJzPHc1Z8qw==
X-Received: by 2002:a17:906:95ce:b0:8b2:8876:2a11 with SMTP id n14-20020a17090695ce00b008b288762a11mr5510823ejy.28.1679239173483;
        Sun, 19 Mar 2023 08:19:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id rv17-20020a17090710d100b00932fa67b48fsm2137433ejb.183.2023.03.19.08.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 08:19:33 -0700 (PDT)
Message-ID: <8782c1a1-6600-31b8-bd62-8ea5cb0ff081@linaro.org>
Date:   Sun, 19 Mar 2023 16:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v2 2/9] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
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
 <20230220140559.28289-3-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220140559.28289-3-sumitg@nvidia.com>
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
> Add Interconnect framework support to dynamically set the DRAM
> bandwidth from different clients. Both the MC and EMC drivers are
> added as ICC providers. The path for any request is:
>  MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
> 
> MC client's request for bandwidth will go to the MC driver which
> passes the client request info like BPMP Client ID, Client type
> and the Bandwidth to the BPMP-FW. The final DRAM freq to achieve
> the requested bandwidth is set by the BPMP-FW based on the passed
> parameters.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

