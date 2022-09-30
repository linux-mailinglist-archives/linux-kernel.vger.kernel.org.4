Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7675F137C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiI3UTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiI3UTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:19:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947ABD111
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:19:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f21so1563981lfm.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2UOIDLCxXn8nlZS1RvhXbLtzKWNYWJRmQPCH/1+uI0k=;
        b=NqQSgJkKwJmtckcOveuSVN8bGw1W5YcduOLF3v9AjNf6y9e3duZIF/Mmx4CtNLYuW/
         X9adfRyjRILFCNQEsbY6vaRuY+N0i2RtD9AvfXOOPleem4LcsCObB7zNj9X5wmAq79/e
         vxpj7aoo+PGOib+uofCTcyzRVvgSQinCIaSjeQO1agdtSx62W0tLCtM2p/Sg2p5nXmiY
         bgI1/j9qDTBUO9AGnqfdH8gt4+XnEWEhx6moJySbI960MjjrNCvDs2MUZqoBaVDPKrJn
         upK6LHMlkqE299eP/SiQWSasCgUvhbDFPyXUJXNOjkulp41MaNSgpFl67KINHLQTggFh
         xTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2UOIDLCxXn8nlZS1RvhXbLtzKWNYWJRmQPCH/1+uI0k=;
        b=xQymhY2zhmyS2Fb43ERPZXYVdQbcVjDu541IF+qJlE9k597xbLf5Gh1/CD48geCqip
         bFUpHGloVheTk15eVsbCmSX/ci+W6V5NKYUIg+fwAAUTOt2eSa2updfgKUClcJT1WYcQ
         +l8u2fm05a6KhRqXnB3yx/VRExNtIlGaX9N+ecyB5/i/CCGkj1C52OMVsygN2NSN1IVt
         D069gQFdK3L5l92JpUQO61uEW4pC6dG/lEpQhXQPGRaCQVoiB822tc9w9wDx71gUrf2H
         lyNE2pWglbBwL7fGe6z8KB9xlIdCjYg2lQnMrtF3ukkl/R/R2WJkW2kxkze+dhVFLUtb
         yDTw==
X-Gm-Message-State: ACrzQf0rQdePR7dv9KEMFx+InykaMYroWAEsM2ICJDuYnHHDbxfXNk4K
        ak6AOI3alK/M/+Y5dBdLe7JrxA==
X-Google-Smtp-Source: AMsMyM63xnXokRNVmztsmZcTu4sVTUZQ8/ko274ldxVQjNkIjfRdtQAFMj6tW3iOR6S5Ia2xutU0Rw==
X-Received: by 2002:a05:6512:1152:b0:4a0:5555:15ee with SMTP id m18-20020a056512115200b004a0555515eemr4241751lfg.38.1664569147001;
        Fri, 30 Sep 2022 13:19:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b004972b0bb426sm407342lfu.257.2022.09.30.13.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:19:06 -0700 (PDT)
Message-ID: <1dfd2858-cc30-5cc0-0b2a-209a8bf8bace@linaro.org>
Date:   Fri, 30 Sep 2022 22:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-2-krzysztof.kozlowski@linaro.org>
 <2b1a536f-fd84-831a-8b0a-9c0cce5e6421@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2b1a536f-fd84-831a-8b0a-9c0cce5e6421@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 22:13, Konrad Dybcio wrote:
> 
> 
> On 30.09.2022 22:05, Krzysztof Kozlowski wrote:
>> DT schema expects TLMM pin configuration nodes to be named with
>> '-state' suffix and their optional children with '-pins' suffix.
>>
>> The sdm854.dtsi file defined several pin configuration nodes which are
> 845
> 
>> customized by the boards.  Therefore keep a additional "default-pins"
>> node inside so the boards can add more of configuration nodes.  Such
>> additional configuration nodes always need 'function' property now
>> (required by DT schema).
> Would it not make more sense to drop this and keep the properties in the
> root node while at it?
> 
> Konrad

Not possible, because the boards set different bias/config for the pins:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=v6.0-rc7#n2988

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845-mtp.dts?h=v6.0-rc7#n729

Best regards,
Krzysztof

