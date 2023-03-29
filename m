Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529166CD405
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjC2IHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjC2IHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:07:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDCD46A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:06:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g19so5934856lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1B67J8gc4+AuTWTqETyIHhrBOAuRe35VhFxvqLjDEU=;
        b=fLPOUJWhzzC2KI/yC/5VsJ0MXKjS0kzYppqsyEY8/shH84cZy9qI1yOWHiciGwe0za
         7sAGTNIf+qU/AaCE/HEKdX0Oi6LLNJ5GWKWgcQcUZFc1V4ncLMtYI34ERpc7l5So4+g4
         AoWSt4bpVn82JOt2fZDBYlPpVCgmR/YvEj3pQ5vY+2btnHifoTsGKhfo7VWkSLhwFa37
         z3XLYWBbOWv5rRzRJoMRwBrSeSyQmwdJ4VabK/ogYs+i2RvHqhtPTPByNd5j62TdBvza
         nXEshmXzM8fi2C74KI+8xTzcHES84FIjLq14PBzsGsKaxvVKPIpPM4N9n3oihOzUZ3v+
         pgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1B67J8gc4+AuTWTqETyIHhrBOAuRe35VhFxvqLjDEU=;
        b=jAUpy4Irqvetr7ooriEgg1DAmiZ1xGj/owGxySS/ex+OiOZk4l+ax6a/6UeLs8twR+
         FEtbPLtIYcOgJD7xu/VHe+vCrD7Y/2VmSnx5SGSXIgSiQ6hOzdDltyfrw5y1dxZNB+xk
         ftt26KKNxOYL+duux3fJk81qWgWLRWGoMhOVAR9Z+WkM25dgmn7O7o9nXO5b62pCEzMJ
         UwhWkq9HFj2ZKSqLENwk2wkBQQNHapDpDcThaBjvylbR10i1K3wKiTrxTZqo+KjiYN4t
         9Kg3RsmlbY7x6XDik375t2ihEoKpLfJbMVHbw407cZcVa5IDqcP2J5W4uIEWTYEd2T1G
         rdgQ==
X-Gm-Message-State: AAQBX9fEZs3gKDB5m5GQqzYPDgJNBGHhpupD2MuVEweCN0HjilhzmQLH
        R8S4BMwFwRyIwMRm5G5XRBzxBg==
X-Google-Smtp-Source: AKy350aUrqG6jCXqhdKHl6Tm6UNGJQGaAWiRJBE3fc5dr3mS3Um+pf752ukWqJWIV+t2UaqmS4qVpA==
X-Received: by 2002:ac2:4a71:0:b0:4dd:a02c:9c0f with SMTP id q17-20020ac24a71000000b004dda02c9c0fmr5290737lfp.10.1680077215583;
        Wed, 29 Mar 2023 01:06:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b004d7d13387b5sm5302901lfn.116.2023.03.29.01.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:06:55 -0700 (PDT)
Message-ID: <def2ccc8-abb2-2786-fc67-fb71f1c8e3b0@linaro.org>
Date:   Wed, 29 Mar 2023 10:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328112210.23089-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328112210.23089-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 13:22, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/spi/loongson,ls-spi.yaml         | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++

You decided not to use Rob's advice, thus this patch cannot be applied
now. Wait for the merge window to finish (so dependency is in mainline)
and send the patch then. Not earlier.

Best regards,
Krzysztof

