Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80D6C5FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCWGfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWGfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:35:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E37120
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:35:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so82100070edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679553340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8FMzTY6q5btYc/0V6wZVAFqAPO/lou94Wj6pSxpohs=;
        b=fiVYKJ8WFPkbZOS+OaFNF1g8SVtUVsKtYnO8lwtKtBtM/KRGN6mp75f5ff4QMjfDZ8
         3QOZlVoMTIXgyJaDorsrLt7DXPKp4v5vl1/+dzbGgX8arqCozP9krwMMIIWpHyLIsn6N
         xX3d4fEvrv7/cPPqQF2pLs0hgnWV/dASourLzBUg3plt6GZyKZzqtAnhAaidJx+IAliS
         9TI1RRIrfInMo4njmTcxINcJ+eLpSv4gfUJqjlkFfoxBiZLyRqe8gw+yZ8gh2Hnggx7r
         GsdBtD+Jpw/gJxyNvwpRBZEL4DglpNKw2q79kQ+Vkm3oadIEcp5eArI6lsk8ZxO14wJk
         TtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679553340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8FMzTY6q5btYc/0V6wZVAFqAPO/lou94Wj6pSxpohs=;
        b=OV/7UEgato+pXGcC6oRLgjF7YugCLbWjCKrqyKywAtpWiShfd5FD6UVqxBOAkqDwme
         lcGJ833+Xb0gPAoX85aTpZOqoxKUgrwfDEpxbJAUhQ3GT08bjdltXDyetPW4IZUdd3gA
         hA3FJw1PE6NfbtmkSY1z0ACagDvT+iRlDCuZhuuYrDXXcseGienNWg3q6GOiu33doSpy
         Vr/LXLUix7jRI6VXeYgQxP5RutSWDBhMwsiGfF/CFgxk9mY4sdaggA+XedX8XlFirjjX
         TKrzNmy1JVym4Tw5zaukKEaV22Lpk9Pqc7i6SCL6waAEwYww+kceZzqO8PZVz5z6uxRL
         jFQQ==
X-Gm-Message-State: AO0yUKVeZxbM6Z43WIkgp1YPs879ov/DgqKOwc+6UfV6XzEx39BvttMW
        X2e+BPpLctfePyF4fHx/nanl1w==
X-Google-Smtp-Source: AK7set8eEzWYxNr66Ew154eC20TxMTLywUYnk7e9yySgeanJd+Y6A7RWRyMlYBh41WTjvuXrI+uFLA==
X-Received: by 2002:a17:906:f8db:b0:8b1:7ae8:ba6f with SMTP id lh27-20020a170906f8db00b008b17ae8ba6fmr9570962ejb.16.1679553340695;
        Wed, 22 Mar 2023 23:35:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709066b0200b0092be0d267besm8344890ejr.142.2023.03.22.23.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 23:35:40 -0700 (PDT)
Message-ID: <fc444dbc-2ac2-91b3-42eb-f16e7c1a2ec2@linaro.org>
Date:   Thu, 23 Mar 2023 07:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: ak5558: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <d1559192-8f6d-26e0-ef19-d14ac7987a74@linaro.org>
 <20230322200949.8986-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322200949.8986-1-danascape@gmail.com>
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

On 22/03/2023 21:09, Saalim Quadri wrote:
> Convert the AK5558 ADC audio codec bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

