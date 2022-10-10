Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52D5F9D21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiJJKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiJJKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:54:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0244E41
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:54:41 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x25so2775466qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXXYDLeVdr+oeSI3cVKv2RSRyFOoMDL4kVkyRGqfMsE=;
        b=HbSPlcRkvUARSNgWzE/kaRZEiL6bRpHcWUtODxc0yRQnJ4kg2S2wLpE4EyZIQLSxl9
         HHij2wUkpj9Cw/ktkXzWoefg0NHEG2A98eRRJIDwV9jAv4cO6dW9ZQ4/d9hLKrYnrTH+
         amXnMDac+9ffziz+SEzF9I2fHwuTG1b9T94uWYPAZlwA0EjyI+pjEhqFkIICyW+zchjc
         ZufWkL0Xjkxx1CQ7BWGqyrfbhAm/94Q66KCGefr0tC6hSfalmSnkqR9gS6cZ+2jqRL5T
         ui9Cbe7KWdOmKglg5j4+SgKqRWdMvDDBubaHyuMuVZxkKaQKiG363AiirV9j1Z2mmvdI
         d+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXXYDLeVdr+oeSI3cVKv2RSRyFOoMDL4kVkyRGqfMsE=;
        b=dXDdO1bdhDumMOhY47Ga9olBhLy6rVLhV+F5ow3XCU34XhxiT8VGnVQkzNgLg8x6Wh
         UThPkIFBw5AZgXUGWVXr7V0dBS3OxY5FYRM27PoowmGXrqk47cT2x9zsMB8Qv2XtJTIG
         qFIwT4H9N2Ujd+F+sFrh+Xu/9GAGpxe0ey5792bHshs3ZpfQaTtG0vK1BEofDZLuM9G8
         B1V01KF2+GMyOFLsDQI5hrduU3b7m+u84/G+KDGJGN2zxVaiJcdh6TTBKPFOoyD1O3F0
         4VD1gKjNwiq8JX+MZH3ixI9cj1x7yuHlvPC+tTxEsTMbKWsb50oxZlc2ssi4bsI1d2zT
         PEQA==
X-Gm-Message-State: ACrzQf0J3vzHIsKOwMrmkmhMlUZB8XTWSY3fFGbGHzP1eG+hOSDmXlMa
        8yGTKu/6SdvkhCtxTzGRPdUMWw==
X-Google-Smtp-Source: AMsMyM6HgL7CmREkM9Ir3/Yzattwf4yjiAvs4gDfZZCee4JCXTl0C5mU8Hv2c6Yx2OkfiBPSITS6Ig==
X-Received: by 2002:a37:64cd:0:b0:6ec:545f:9095 with SMTP id y196-20020a3764cd000000b006ec545f9095mr4519053qkb.133.1665399280515;
        Mon, 10 Oct 2022 03:54:40 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id v4-20020a05622a014400b00343057845f7sm1414470qtw.20.2022.10.10.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:54:39 -0700 (PDT)
Message-ID: <56e8fc84-aad0-b153-e415-8c1bd1647c2b@linaro.org>
Date:   Mon, 10 Oct 2022 06:52:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL
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
References: <20221008174658.336470-1-sireeshkodali1@gmail.com>
 <20221008174658.336470-2-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221008174658.336470-2-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2022 13:46, Sireesh Kodali wrote:
> Add support for the Audio DSP PIL found on the Qualcomm MSM8953
> platform. The same configuration is used on all SoCs based on the
> MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6afd0941e552..70b3a37c4814 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -950,6 +950,7 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
> +	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},

This one also in alphanumeric order, by compatible.


Best regards,
Krzysztof

