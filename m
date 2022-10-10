Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3262B5FA37B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJJSkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJJSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:40:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C61276D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m6so2080128qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09B2lIfMW5FCv/PYhSBROv85IU3XYzHTU0Y/zt/18Vc=;
        b=xJIKm4xbDTHtlD/6nmZeJ0m4F0qWhqvcIK/AcJdYzLFhm/yTP3goZYKQo89gG7WSfM
         9Gh+carIFB8Ex+vfQQhoXMU0k697vtnSSvhsiPNEEZAmCzzoQb3d86fORJwNzNJksxa+
         zVNM8JQEskJyAu4PxM8IGg4dXuGUk+YNT98pbiW0Wl04KulYxTip5GMxI1AfEfhiuAZ4
         Lf8zGCIHuxmpP0If3aKNwVJmDOrUYd2Z4NZ4XKn3LnUaBsVrQesZcsdf9jE/5rCCk9Uc
         1ulHp7U06Hi8MIjR8ymYMV0ibx5nga+dhG3v78L92KWJCQuype/VDn9WaeiK7xfFVByE
         xblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09B2lIfMW5FCv/PYhSBROv85IU3XYzHTU0Y/zt/18Vc=;
        b=VY6GKdUiVDVIS0wAAD/Lp2DiIGIPLxgDIqQOgctWJPdIhVHZ9puZH6KMyEnrKrRTvs
         sW5kELFApBJJSKZJJxyTLObQL8/lFPoDdWU+VUQYNbyuxBrxti8y2cvADscMDmf6UDt0
         ZjfTs4YDUPlBK4/nyp3oPoXh+WxePHoEg1xYHQhSr3IpTQNvejPfbYk5sI/FWu4NnBa5
         wWZLiZgebPUF6aA+4Dd+wgdLhxMEQ9WHHcSMEoC0bdnIZAo1PwxZSqXzRSNo4nvX41GR
         OselvbYtFttAjm3XUJzRWji+qH5F5RQSd97VlxfS+sI+sr39O+DOdwdqowmlczKiFSuZ
         fZfQ==
X-Gm-Message-State: ACrzQf2nwNLmwJBxoVZj7Qbm2ECZjh1llP/78ltufHh1ZDRmQRzfyiG3
        2Ili159MOew5I2xCf415nSJjxg==
X-Google-Smtp-Source: AMsMyM50RUj/Zs5jIlJ1Ia0KMBQ2dFhE/Svrs294KEyNiV4K5xJk+7tGEEKmPzUEBZXHKqaQbVPPrQ==
X-Received: by 2002:a05:620a:2808:b0:6bc:5d4a:a01a with SMTP id f8-20020a05620a280800b006bc5d4aa01amr13704079qkp.371.1665427231283;
        Mon, 10 Oct 2022 11:40:31 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b0035ba48c032asm8849457qto.25.2022.10.10.11.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:40:29 -0700 (PDT)
Message-ID: <af4655e9-d1a0-fbd2-0724-ab358366532d@linaro.org>
Date:   Mon, 10 Oct 2022 14:40:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2] arm64: dts: qcom: starqltechn: add initial device tree
 for starqltechn
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220617110130.2300438-1-dsankouski@gmail.com>
 <9bf584a1-bab9-33f3-02b6-6b10a7cfb043@linaro.org>
 <CABTCjFBneTPT=PoCh=c8hyxfgvCr=14pJYA+11sQ0ooyf6Ri1g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABTCjFBneTPT=PoCh=c8hyxfgvCr=14pJYA+11sQ0ooyf6Ri1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 12:43, Dzmitry Sankouski wrote:
> (...)
>>
>> Why do you have DTSI for one DTS?
> Samsung has several devices on sdm845 SoC (at least 3 phones:
> starqltechn, starq2ltechn, crownltechn). I don't have plans to
> introduce support for any new Samsung sdm845 device except
> starqltechn, but I guess we should extract common dtsi now to make
> future contributions easier. I think I should rename common dtsi file
> to '$soc-$vendor-common.dtsi', like others device trees doing now

File can be easily renamed later, but if additional devices are not
mainlined we will always need to deal with almost empty DTS.

Best regards,
Krzysztof

