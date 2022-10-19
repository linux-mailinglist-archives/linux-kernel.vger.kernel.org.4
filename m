Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76FF6046C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJSNUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiJSNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:19:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553A737186
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:05:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g7so22914400lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UnIKdS/ogwwde9hLUwkHWUhiP5dC2TYUzEPI9H3VXY=;
        b=MmT1SYTDdT1XQmRyk+pUP/6sTlU5r5MH5UcNupoZdUOqE7yg8UdieoecejuV20/p7p
         VQIh6n4hg9EGQRFMIxCR3qvjtSeLsbttkSZ7gPGX+3+ERpzF5dFBCWvS9zDKv730/fTV
         6XGzJIAu7nOC3GgmBIqpH94cSghtmJUtmNB08dKCJi/QeAwM7e4qqbd4CtGQjyPsY0qA
         kCDtrwitAE2/ayba8KlBCyxQ++T2+VgqowyEKvg0wRirTRUj4q9NRPPWgXca1Dy/v0li
         8H4xRP7LLk40DzERSXYLqe2Muv1b7TQWdxdThHssIQrTHnvN/VLSBQz5jV1bv1sahXgI
         /PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UnIKdS/ogwwde9hLUwkHWUhiP5dC2TYUzEPI9H3VXY=;
        b=fuwV5PipkUjWBbTwEMiUcuJgMS/lbnPDDu9tU49SfqquQn0YoIiyKviri6fWn11feg
         3gODhYh78+vFhLe9lBQx5b9yli5aV6M/fjjW/X4I8y7wxsbUWCHfRPnXT43Lg+M91hMl
         oyKZ8a2V3KTJNfhJ1SQBnEC3/UfQvCRuUJgV7mjHgqCvTvkirfCid9wTYDfGdz2dLl91
         y3jkCwNnLwrVcsJuQyUyzwvepdn7MNrt/XiRT7XLRel4r7SRO7HxT9WIZ6Q0zvpK/Tvn
         mD58eWU9TvY1m2GClGM5F+fWvV06yaAirYcEhM1YcIRuDg69SUkH0pirizWvnTMZFdgV
         0UNg==
X-Gm-Message-State: ACrzQf03EuqWWrOT+bXm28dAPDkZx9i1e6S3/jA3j63gLbNvSNKOtPNg
        /RxP1wnExA3aKUNgNRxiTZt9Vg==
X-Google-Smtp-Source: AMsMyM7nB9iWbVD0xqwF57VOzWjTruUqUVGa9pMdYMYF7NUjUNJW8H1LBlZsJ59iaS0NAtu9Zp7S8A==
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id bq14-20020a056512150e00b00492d9fd9bdfmr2686029lfb.583.1666184738585;
        Wed, 19 Oct 2022 06:05:38 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id e6-20020a05651236c600b00492e5d31201sm2298249lfs.7.2022.10.19.06.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:05:38 -0700 (PDT)
Message-ID: <42ac56bf-ad46-1e49-1e65-fb406d8836a8@linaro.org>
Date:   Wed, 19 Oct 2022 16:05:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 05/15] phy: qcom-qmp-pcie: clean up probe
 initialisation
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
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 14:35, Johan Hovold wrote:
> Stop abusing the driver data pointer and instead pass the driver state
> structure directly to the initialisation helpers during probe.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 49 +++++++++++-------------
>   1 file changed, 23 insertions(+), 26 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

