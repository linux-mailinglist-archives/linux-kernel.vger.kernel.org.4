Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45365671FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAROie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjAROhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:37:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A666FAD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:28:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt14so24756810ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGsNaYd8lzrEJBZWh/jXK77/CF4jiaEZbxlPMQt1yUA=;
        b=yGgv4bRS23TPtTiAaUpfhM7ARvm/Md/VxtiJeL6mzD/ShTWfpUCOmR2JYuBXb9nwV8
         Hnjx4/fhXVb75lGNMSC6kR+eOmOGg/nsAmix226J9z1IltroWTgraHT67mb9C0NSlgdN
         2FYm9ogR/3dvC6TGl4uV+C8JvUBo2QsX32nYkjO7uxAY88e5q0qLkoORP56kXrt7Jarm
         ojfbGc/I9iN1zTbo6RyJVjKsvbObTFE+NL8H98j6OKruudOMBLu/d7fqP7bVkTcd9kAT
         4q2GB6mH24pr3FviUt7tBrEoXfy18t2g/bPCy6tmkaGbCg1s9txiRVGS64UFnxK6Uhzz
         YCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGsNaYd8lzrEJBZWh/jXK77/CF4jiaEZbxlPMQt1yUA=;
        b=dXR53qVNhb46RctQrW9SAOEzo37xpowMKdcpj7aw5jX/OmHCItizoRJUC/Btca351g
         0xsKnrbMKBn+vEBliX2hoNFcSTqIV60Qcga9/j/NmKOlTmJsTfA6C+kk0dEDIlxiyo2b
         nvuswTIigoqp0Rtps2LJLUVuh7kZfXhE/PTl/y8RPgrOOetbeiJK86VNlV88T5WzyLSi
         84UYVkRzpzV5KUaUpfN22CgFz2hWERbGy0qlVBWdauDoVMZZoSZOtb4xJ0hoYkVaGMFY
         i2wiwpk13rgjXIXtmQzzY4cpJnAJbIwvoohm2y/DPDeT9iv4zRsGt8jySmbp1xjQuEkv
         srew==
X-Gm-Message-State: AFqh2kr3ieEgJ9HWW8jWhGEe3sqj2oqPk8RWBs1X1Ieq+lKkdVU9Swq8
        kqQkxKUFHqDLPnOQTADAMrg+lQ==
X-Google-Smtp-Source: AMrXdXtaZoCq1axVrnXR3NO7JWhyRBJo7prw3mrcpWnr7PBsifQfh/PbqAmQtCohleDsgwL+x5LqLQ==
X-Received: by 2002:a17:906:5906:b0:870:2f70:c624 with SMTP id h6-20020a170906590600b008702f70c624mr7429241ejq.3.1674052078711;
        Wed, 18 Jan 2023 06:27:58 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id um41-20020a170907cb2900b0086c4fbb8507sm6114730ejc.225.2023.01.18.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:27:58 -0800 (PST)
Message-ID: <e47e3ec7-4c89-0472-cc87-9c9cc6db8519@linaro.org>
Date:   Wed, 18 Jan 2023 15:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] clk: qcom: add the GCC driver for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Shazad Hussain <quic_shazhuss@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230117180429.305266-1-brgl@bgdev.pl>
 <20230117180429.305266-3-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230117180429.305266-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
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



On 17.01.2023 19:04, Bartosz Golaszewski wrote:
> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Add support for the Global Clock Controller found in the QTI SA8775P
> platforms.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> [Bartosz: made the driver ready for upstream]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

[...]

> +
> +static int __init gcc_sa8775p_init(void)
> +{
> +	return platform_driver_register(&gcc_sa8775p_driver);
> +}
> +subsys_initcall(gcc_sa8775p_init);
core_initcall, otherwise you'll be waiting for years :P

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +
> +static void __exit gcc_sa8775p_exit(void)
> +{
> +	platform_driver_unregister(&gcc_sa8775p_driver);
> +}
> +module_exit(gcc_sa8775p_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm SA8775P GCC driver");
> +MODULE_LICENSE("GPL");
