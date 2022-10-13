Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58205FDB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJMNlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiJMNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:41:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBFC7B29C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bb5so1040773qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOC055jHmqG+XdwtkHstI3mT0N/lTkxOBB78rFX7Q88=;
        b=ICZ09Euq0qqnRRCeix0hL4FG5rjoLV3lwNeiTZ6CSZEcYsHdokGJGGrqtLpmwRV8os
         VTYdb7KtyyCjLNTQUdU1hPcWYB3GFrzQw6tNojcilnzhZO7mL5HbrFwEgSCHmb7KDJm8
         nODHcprT/wxjJedQQj+sYrYXTyqDp6B2MmJKyafcwMy4MVNIBDtYidZEGUkodp+Ac3ei
         GeeffUqqD3aQAX3EKhY/Y9JLGF2wVYfOVcsdgV+7LsFjnJ/zkwk0BbBvQeytNTlaGfKx
         xDRq5W+5iJo8mZhM+Lg8/JHGOda5k89pxpBOrhFkVjPA2YexhgW6huJCKWtp+COAy6kq
         YQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOC055jHmqG+XdwtkHstI3mT0N/lTkxOBB78rFX7Q88=;
        b=buXnfNQan0UJPrSDJfBSBFGQDW/8IBnVo5CrHeAmPIzs1c447W5YF7kiQKT2D3O1PL
         a6V/9M7MjvIhF8V3U6PI/OsajEUswgefSp+EboZ0NcBRhR4z3CDmOqB+RiVHxObSc9F/
         ROfgsjNDUOhwd+GMLmh/3v9+ieLdDR84bob1QoKKrhPyUhm2M3jDfxP6ZNRoXN2q4w5B
         j2K0Iifo9M2UuW3iiY4IfOEphhMo44Bk5lQENA3Kagh0LFjEvAR0YJEfWRnmi06meE8z
         EmuKy6fDmezWRVkXkJp9UClTUSf9FnFQszY/5At7l0kO4/gMxBkZznuO21tVp2FGuRZh
         +1NA==
X-Gm-Message-State: ACrzQf3qyjJEDP5ttQOWMK+s6Ok29Lnw8yvMibFAjPd1bkeKznZCQX25
        7AkyQejaEgjKsM33+jgF7gTFvw==
X-Google-Smtp-Source: AMsMyM4v+gyfEZLy+zxwIZmTVkqUPL3QONgpsG+eLXD0+x70VbTkXq3OJjbL4ju9zsmHn7WWfHZ1FQ==
X-Received: by 2002:a05:620a:2414:b0:6ee:94fd:ac96 with SMTP id d20-20020a05620a241400b006ee94fdac96mr6048595qkn.270.1665668493718;
        Thu, 13 Oct 2022 06:41:33 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006ce441816e0sm18397073qki.15.2022.10.13.06.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:41:33 -0700 (PDT)
Message-ID: <52ded711-5559-5c6c-c1fc-57449496ba54@linaro.org>
Date:   Thu, 13 Oct 2022 09:39:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL
 support
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20221013042749.104668-1-sireeshkodali1@gmail.com>
 <20221013042749.104668-2-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013042749.104668-2-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 00:27, Sireesh Kodali wrote:
> Add support for the Audio DSP PIL found on the Qualcomm MSM8953
> platform. The same configuration is used on all SoCs based on the
> MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

