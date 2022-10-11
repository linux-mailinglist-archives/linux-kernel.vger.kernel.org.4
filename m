Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF45FB3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKNxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJKNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:53:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379A8558D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:53:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu25so21235468lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2w//JeN9ksVnoRiYZS+B5DKe1JdNV5KL08E1cq0GkAs=;
        b=z0piOT9P5PQy7mycA3m9/Bg5bcFARHYsgiUY2xAgYBBg/8aauS+I73+aewJRerqX7X
         7XeFfd8Y376IDHi/8y0ZSbcu3YM9cPreL4qEOtSni7QyyoSUPunWeE8Z1poCKZ2ltsi5
         uCtCFZESIg35e3NoseNF5CCjHE4EfyquMIviOG5Q3nRkWzZXTyqGCyqJyRpfP7bWp5Kd
         LSs7vFDfiuSUYwJqh/IiLWtZKNv3Pgm0XINKpGNaOb3wTkwHm3ieY6MznrUguPW/j54U
         Ai5P4fAUUQIPqiOYBlH5CJFkDJtBRNmZwskQER/kmbmzXLskltrZ0TdmfQLDgM7X/ZYZ
         mJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2w//JeN9ksVnoRiYZS+B5DKe1JdNV5KL08E1cq0GkAs=;
        b=Ou2KQWAYa4reKxS+JMOTNSQd+bh9f2AxmB08c4/C+6HVE/has+8c7WXyNPbOqpYWCK
         oEk/grS2fUJnp1FN6EZcz6+WfGSgKZhzpEpk6oAsnCp6SIs+pP8gqtBB6UqjkXE6q/JN
         nKOMk4PKVLiU37GjNv0XfQVqKHMd9KlrAHrYnH0RzzLJLWx0Hjhnk4J4UwIse9qfRQDf
         pjIaV15aTWOXij6TsgGKcWsptYCNjcwLgsJlXxDhEbCihe/GjKj+g5C+eZE7WLN2pW0k
         3CuIgVLUGb61ZMkQBkBULJAgXR4JgqibRl+kbkidUJYUE5yQLMbTZgYFONSGyFSqcQyA
         3MMg==
X-Gm-Message-State: ACrzQf3KLL1yMwj5wTwFUMZpJq9Wol9OpX6x0SEMBysg/R0r2WRqst+s
        Uw3eDllTX9FKBlXF8TfBNKX9MQ==
X-Google-Smtp-Source: AMsMyM7QtY/NxgO3HC8o1YObrEQGODYLZjONBZnHtl8VcxjnFGmaMbkJAqaXoKkAntXTIKA6WkH0hg==
X-Received: by 2002:a19:7419:0:b0:4a2:2b47:6ca3 with SMTP id v25-20020a197419000000b004a22b476ca3mr8197051lfe.330.1665496393701;
        Tue, 11 Oct 2022 06:53:13 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b00497aa190523sm1863316lfl.248.2022.10.11.06.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:53:13 -0700 (PDT)
Message-ID: <726346ad-88a2-14a1-bca6-2e69e22623de@linaro.org>
Date:   Tue, 11 Oct 2022 16:53:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 06/13] phy: qcom-qmp-ufs: drop unused in-layout
 configuration
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-7-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> The QMP UFS PHY driver does not use the "in-layout" configuration macro
> to configure registers that are typically accessed using "regs_layout"
> arrays (e.g. QPHY_START_CTRL) so drop this unused feature.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 42 ++++++-------------------
>   1 file changed, 10 insertions(+), 32 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

