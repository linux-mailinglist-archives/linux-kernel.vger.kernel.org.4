Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A409C627988
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiKNJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiKNJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:51:21 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600F1EC62
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:51:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d3so12442871ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENdx4ikDTtvgrE72aC9rMF0BTtdGQ2p9Wbp/pvRmjUg=;
        b=LOEyncvIYubzjOZjJxeW6sHe1cCjavlEag+RY1hqFVHfkfWJADbSi8mfBcloR/hNJj
         L7OwmX7h0GmcYdzs0VMUf2VtVtcLMf4F6NQwxmP2bR3qU0KdUIIy/shLIpKEQLeFonVm
         ZewnAxA04KoriGpSrTG7nT5HNZ7KdqYT0rrdcE1cOWH17jmZ9ATB0m/gIWUnDUXkTJOd
         RPSDSy4DWV3/V/oFom30qsFgU4ZO/eRUnATrOrq0CqB4hEI4FVLTGxyC2d6WeGUueZPI
         XD6u/VscTpbkWGKVNj1zzmx8amfhqP2RUPuAD1ZTZLH5pvL8m6aDBND/FlVPEqVPU3KA
         8VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENdx4ikDTtvgrE72aC9rMF0BTtdGQ2p9Wbp/pvRmjUg=;
        b=dBRZ2RjhrjBDEINOhKqnQlLmJy/7nFyEPcj81LzfcX/G025XRY2tLw3Z4dMTcRwAy6
         dCicXnTv2nmxjqarZBBIz7lyIs5sfVCFL91PT7jyXaKsqzUzMmP8qi/4idjNT10+c9Gt
         Wbl+Z4TpyqK3qdEBeGeU7w7anTubpvEXYqFKErmL42tJushTO7XXOLCfEdE6LIpk8+cV
         lZXzjWGd0Uj5pCa6fbrL5EYz0nvfEEbCHfvGip6GHyLcCHj3x8NQmp8ZuZKYEAsV35cH
         3jt6EVAMo6bHaEzwBwUDp+uv+YjZ509R+fH8uP0sCxvk1rXtox6c6bIwcq8+mZ0QWmzu
         Xh/g==
X-Gm-Message-State: ANoB5pndN/IGFoiSr+KR3JzP6a3ot577VjYSPqKBtASI9zUrZGOggVR1
        ugYJ6rKXlfocoH11cxZ9pVoAJA==
X-Google-Smtp-Source: AA0mqf6OVhGZnv2UG/ItOW3l1o9aVcLwXZaLwpjRJllEiNpT2YovMinDawSgVP9lvxlkqTvVF9EMAg==
X-Received: by 2002:a2e:5d8:0:b0:26e:85d5:7e8 with SMTP id 207-20020a2e05d8000000b0026e85d507e8mr3673057ljf.449.1668419478756;
        Mon, 14 Nov 2022 01:51:18 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b004a45ed1ae21sm1751889lfa.224.2022.11.14.01.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:51:18 -0800 (PST)
Message-ID: <8ebf0be7-7467-ee59-6502-a50e1739fda8@linaro.org>
Date:   Mon, 14 Nov 2022 12:51:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/3] phy: qcom-qmp-usb: drop redundant clock allocation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111094239.11547-1-johan+linaro@kernel.org>
 <20221111094239.11547-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111094239.11547-3-johan+linaro@kernel.org>
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

On 11/11/2022 12:42, Johan Hovold wrote:
> Since the QMP driver split, there is no reason to allocate the
> fixed-rate pipe clock structure separately from the driver data.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

