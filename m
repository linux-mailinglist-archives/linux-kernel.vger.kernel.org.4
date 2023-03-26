Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC246C97B2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCZUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCZUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:04:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5534765A5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:04:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so27674578ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679861050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJ2zmqBiWF8xNxlF2DpfPiHluVhEuG/NqmcIKEjOERw=;
        b=aA1Pja6WvB4X3aGFSLK6pweg7xRHG//dRUY2v3rdNu5Y1ZhUUSYy/RgXn22Es92AQZ
         2q7dirvzy+f8ToVEzoojz08UmnKi4yFzH5wN14F6odYDjT+ETB3pBIcscVN7ZBkmhIdr
         dkNjOK/KYVWX+rcZAjjQ6p1Jz1g4DNSpvBsUStPqHPXhP6BtqrM79oCJ4aLpeFtnE5Rd
         79Xtglom4SxxEjG9X9nAsz5CvV8YfEbvZSzh2Z3sbC7qoxzojxjpHc7+wS4018IHgdL1
         9vtiLa7PMS87L+cTAlM3z1pd+pWSlOFiO7RFQAtOHx/krweFaONZ5xYFmmBA9LS1JiQi
         E4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679861050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ2zmqBiWF8xNxlF2DpfPiHluVhEuG/NqmcIKEjOERw=;
        b=GDec6NrzWhviFcY5Uti/0aZ2DiF/uId+Xo/d6NJgv4I2HCThuQgawGlKsjd9nEZuL1
         eXmHCuCJ0ywg1V9IFCV1w/Em5WTPVWge9DogmdOxkiDrbLsb6pr8o1f9DFe5LMxTktJj
         8HogcW7B+nLDlR2JL/aZCTYPezVtIlaAlU5FKO7SdBNKdQtqff4LERYUXngKvJagNBmu
         6FV5QCX3eZiGKbrl68F1c5a6YCc+bT4IQWUhVJcWNVhUjZaQsEy6UCisydBynYICANKF
         eMvZ+aal5CGrD+SCY+jUjepMKiezJZ8L8yHFdkPTkMovYXDCMwf29njqtByTZ20d5HH2
         uk7w==
X-Gm-Message-State: AAQBX9dlCwjqVB6tTfqaXGDZ6Nl37dx0s/7e0cmXlNJzg4MFW1wS0TzE
        csSvmZSip1U0zXE1HPgt2pZB4A==
X-Google-Smtp-Source: AKy350Zfn2lQrBVjODwHJamrQ0D0o0vR3gzPm6WK58ij2lWqCQGKKtUZrfYQZlXrfdUA9IXOarxj8A==
X-Received: by 2002:aa7:ce0f:0:b0:502:24a4:b0ad with SMTP id d15-20020aa7ce0f000000b0050224a4b0admr8629955edv.4.1679861049845;
        Sun, 26 Mar 2023 13:04:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6b51:4748:3f3f:ffcf? ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id u22-20020a50d516000000b004ad601533a3sm13970070edi.55.2023.03.26.13.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 13:04:09 -0700 (PDT)
Message-ID: <0711b320-6c36-6564-70d2-35fc76ac1ebc@linaro.org>
Date:   Sun, 26 Mar 2023 22:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: update rk3588 clock
 definitions
Content-Language: en-US
To:     Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326184040.33008-1-bigbeeshane@gmail.com>
 <20230326184040.33008-2-bigbeeshane@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326184040.33008-2-bigbeeshane@gmail.com>
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

On 26/03/2023 20:40, Shane Francis wrote:
> Some vendor uboot bootloaders use the target kernels DTB image to
> determine the target clock speeds for some PLLs, currently this can cause
> uboot to set the clock rate for gpll incorrectly on to cpll (breaking)
> RGMII.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> This change starts the PLL clock definitions from 1 to correct this
> miss-match
> 
> This could be handled by uboot bu updating mappings in that code base
> however not all devices will have a replaceable uboot (in cases such as
> when a secure boot chain is implemented)
> 
> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> ---
>  .../dt-bindings/clock/rockchip,rk3588-cru.h   | 1442 ++++++++---------
>  1 file changed, 721 insertions(+), 721 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> index b5616bca7b44..d63b07d054b7 100644
> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h

We did not finish discussion yet, so sending new version 50 minutes
after your last reply does not give me chance to respond.

Best regards,
Krzysztof

