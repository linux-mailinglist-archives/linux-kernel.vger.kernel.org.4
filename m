Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3E6B3B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCJJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjCJJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:56:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645B105F06
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:56:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f11so4473358wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678442159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oruwvj/mBDYr5UWgHXOMrzfKoPLgCKMNkZFtoya1z2o=;
        b=E6bcdo3ewfxpnIOKdaSyS76O6MpqnbgTtpiavmYV4LD2sTxZ09ldwTif08wNfDtcnl
         pw8f3ZgcVU0PG8DddrQRp/WxPEHUAsLTqKJnlVrz0i2wnrSZtQPAeqmhzSgem9jK7RFr
         8iHskqtMpvQd9J4QX/wTvoHsNkbSKjVQpGg9wRWVDg+bA0X6e74f65p83TrT4JJe5Qvm
         qYZdRqHe8sYCjKabL38mecYsQOqSIO/53+j0IlLcltNROvKbu/qrLpVKTn9Ez9lqH6cN
         ash4fs17gJN0xUoUG4MHrxe5gf7B42jOwMPnnFpo2logGnMkgwir+MRmHktmL9g1QdCc
         nPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678442159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oruwvj/mBDYr5UWgHXOMrzfKoPLgCKMNkZFtoya1z2o=;
        b=QZzXCd5elMlzu1KpNAlsojbdT1asu7ScIYUsW4uPEWowgELeAD2n12yxlwP0WKwVUn
         qpmPIotZfBAL9xgWX0fhUG77MduMYuc8lEkB1b5aGORdb2f0V+pMQizwpAN9Rzvb/4G3
         0M2l8fmO2RBa62CMqrVe6Jw9OreC/mBA3fveAK6VK/UBekBhOeg3HJ9nFnwkP3TBqdtH
         NEHhu9U+VVECoUtElrN0fmiqWIDlJaKBxnrsWWeeesnUU+zFa0Ftcux8ZgRL6tTNV6KN
         29UO4VRuOck0gHprAVFaqh63rTw22DgXkzeoqINQgq5xpvs9hEv4/9yuFQEPAhox2O9M
         /LPg==
X-Gm-Message-State: AO0yUKXezZDhjosAdJEBEobldnikh/Bk2p/hImw/DFOHFtFvCspwXVTF
        qoqePpXMDXa13FrRsheiw4i16w==
X-Google-Smtp-Source: AK7set8+inB0KmpJiJwQp1fHKmeXokkT4//TmiShJpxnHOjuCfxLVzKUOKNxKW8HwKDRzDfHSk+zUw==
X-Received: by 2002:a5d:4892:0:b0:2c9:640f:635b with SMTP id g18-20020a5d4892000000b002c9640f635bmr14291679wrq.56.1678442159387;
        Fri, 10 Mar 2023 01:55:59 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id s8-20020a5d4ec8000000b002c573778432sm1748795wrv.102.2023.03.10.01.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:55:58 -0800 (PST)
Message-ID: <0cdeaaaa-c415-52c3-3099-612113bcb074@linaro.org>
Date:   Fri, 10 Mar 2023 09:55:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 08/21] dt-bindings: nvmem: Fix spelling mistake
 "platforn" -> "platform"
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-9-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230307165359.225361-9-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2023 16:53, Miquel Raynal wrote:
> From: Colin Ian King <colin.i.king@gmail.com>
> 
> There is a spelling mistake in platforn-name. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Applied thanks,

--srini
>   .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> index 5a0e7671aa3f..714a6538cc7c 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> @@ -61,7 +61,7 @@ properties:
>       type: object
>       additionalProperties: false
>   
> -  platforn-name:
> +  platform-name:
>       type: object
>       additionalProperties: false
>   
