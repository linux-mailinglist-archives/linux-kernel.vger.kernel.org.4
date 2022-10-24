Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C8D60AE91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJXPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiJXPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:07:36 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917ED88
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:44:23 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id x2so4160463edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+qylRBb+786Bz6Lsf44iUr8vCugFrzyG1XuwwRkv70=;
        b=ex6Admfwk08htep+kUJAdnWdkI5euGZhrzT1ekLxemWWEWsH62HE6MUgzbnQGy1377
         KD6EJkf2yWkO81S2nRzJvhEMbhiPVzJcRuu1KCqP6y9zskCP3MaYU10G8WpG/bcP2mEX
         VBJWdZlTZEHxJTbi5MYz53b+q3W1fcxPBTw83DpGpLyiAEwLcLJSD773cx4GKwopSaZN
         3r9YNIGuDD8m+t6KjY+Pa8ID/2cH0xKvXJn12c6Ebbeok4/E+1eGP1uoG9kZX1PzcVij
         U8u0wF59K1Dn8pfkaD3a/je8ge+NsWt72luAVNYYtpoukoazx0zC8NyimphUUjDrMLbg
         oa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+qylRBb+786Bz6Lsf44iUr8vCugFrzyG1XuwwRkv70=;
        b=HQCe8Lv8TFOJooY0in7kpoOS5//+X/upoV54kzrnxwaB9debXbchToAGrs0rZPmMvE
         MAe8UjblXgdegfnkM5+ey2FARYNuQQzrrZTvl4oPT4EYHT/OQpekgGQDoD39bBzZEX3I
         +4ucUhhzuRIyJdkUYeGAb2XKWI15HUr1ywgjCEL8s3n4P5b0st64efKVIDOcbtirzmxE
         GUSk/1yZRL8RwgSYa9zGf7WgXyrBjG8OTN+EQQK+4Mz703a/l7YnqCuu5borHwUfQYqQ
         0OCL5gxOshd59uJEvGcUjp7rjc0LXmU7pBqEYtHKrcB/Zr6wsxtflH8ht1G/cvh0OKOt
         d8dA==
X-Gm-Message-State: ACrzQf26z19MGalDc3S5Vu48KPT+q2RBHFu4H8Ws55AQXtYT+8GUMseG
        gZ0RVisr8hLpXaHnJAsgMrCyiQUHT+ds2HJo
X-Google-Smtp-Source: AMsMyM6UGKnU0sZ8INReNWkER2ORq1CKTMEL/WaIMd3224QU8/TiWVXWNUzhb0IUKZhjeoDSzddTRg==
X-Received: by 2002:a2e:bd86:0:b0:277:b58:7d1a with SMTP id o6-20020a2ebd86000000b002770b587d1amr1745894ljq.229.1666618171166;
        Mon, 24 Oct 2022 06:29:31 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512048c00b004aac3944314sm759217lfq.249.2022.10.24.06.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:29:30 -0700 (PDT)
Message-ID: <7dfc5001-9899-5778-f445-5508019608e3@linaro.org>
Date:   Mon, 24 Oct 2022 16:29:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 01/10] phy: qcom-qmp-ufs: move device-id table
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024090041.19574-1-johan+linaro@kernel.org>
 <20221024090041.19574-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024090041.19574-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 12:00, Johan Hovold wrote:
> Move the device-id table below probe() and next to the driver structure
> to keep the driver callback functions grouped together.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 78 ++++++++++++-------------
>   1 file changed, 39 insertions(+), 39 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

