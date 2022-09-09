Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3735B3462
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiIIJpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiIIJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:45:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D5BA6ACC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:45:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u18so1747701lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z11oNrAMyfwkdQgEo2IKDmAHGDHQObgXCjX2GBbA6qE=;
        b=ppz5LPOoVAmzg0sY6VW3WjXkDjCmiLqRG4ZXdoHSQScqin1sZ66GIM7yEOo3Yi+ajy
         pJMNWLlhfNVC1OTp7I9rBSqjXhJ771dnb5vPngiTeRnh1meLCjP7tkA8W60I+zYIKAys
         7q3iVNd5eZlplPO1WAF9NyYMs2VO/rL4SBUKq9swl6Sp7rkWN1tbjj9F+C4Y9uvTjDxl
         PO3+Vr+6WV0wRTLFXAVD9nYGTU8LU+7iM/RJHRh9HuBFjlW25CJEBIFIQqTaOg/bERXZ
         ZQbOglmRs3GlVVWYUzrwiVKjzx2ki+O4FAt28otMTF3yuVIMKJrob71db5VbT02U+Jlv
         k7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z11oNrAMyfwkdQgEo2IKDmAHGDHQObgXCjX2GBbA6qE=;
        b=itcPeO0qQaUZFO3jZU4qEbaReTaBmoQpR6IBBq6J1Tk4KFLL2GU1zGMop2FejM0XuH
         UN5ocbyUohU8ZUBLgiuWAT3aVSKa02GtMWA9GUe29rveaylmnscktV8b6nS5ZEDqm0XT
         a6nlnWMJka3fudQq2FLpxGQPVHG188jCItezgbEz8ibX6zAN4iW4KjHAp5p6AjLUeUUF
         FChkeX2zXJEl5054t1EAwZLeBTOhQQY6KeSbqfe7gdrWpNj4YBAcA9BhVlO+4/5Tv5bU
         KToQhg/tHqYajpwqtWuRm/nBV7wzDBBBJyC7CAGd3xFADwVVt5e7Sw9ZKhBHHipSAYoH
         lHiQ==
X-Gm-Message-State: ACgBeo0/7bGcmO2vpQFRiwV1xf6d/jEE6/WSff3nOaL6HMe83SBDTLKU
        G9Z60KTprS0+vsSVOkaMQTBSYQ==
X-Google-Smtp-Source: AA6agR5Xl4LdiqD9+wRA2Q5p3CphYbxz7NQLx99BzCBC4UOdxyvS0cZ7IXkQkv96RqFN8oLfORv27w==
X-Received: by 2002:a05:6512:3502:b0:496:272:6258 with SMTP id h2-20020a056512350200b0049602726258mr3789933lfs.429.1662716744900;
        Fri, 09 Sep 2022 02:45:44 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f28-20020a2eb5bc000000b00264b292232asm7757ljn.63.2022.09.09.02.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:45:44 -0700 (PDT)
Message-ID: <1e502a39-6ba4-079c-576f-10fff260d131@linaro.org>
Date:   Fri, 9 Sep 2022 12:45:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 09/16] phy: qcom-qmp-usb: disable runtime PM on unbind
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> Make sure to disable runtime PM also on driver unbind.
> 
> Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM").
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Nit from the patch 01 applies too.

-- 
With best wishes
Dmitry

