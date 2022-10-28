Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153E6114F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJ1OpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ1OpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:45:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364083845C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:45:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id t16so4168344qvm.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1AAUO9ec7glCHA2X40Y51NdXitGuWrBUJxsXEZcPDg=;
        b=utZ0gwr8MQ8XQ1920c1ke8xyRoRuOxOqhtdR55hmc3TZ3v97wNT7QLAYlpIfIB2/Py
         T+czkuKijb4LhDjiZQou8r07l493FQLVuWvRCWeQejHlrExMZX9wUVjaTCMp8ijVxh/T
         dONuUYl90Y9681jAVkdj9bUWCJy9WmbFzpdcHq69S+NyfWSMF95oPuVQwri23ZeZwDkn
         WXKAr7pgyWvbb7woWAIuCOpYmIx8dQpjdZozEGtSR3kOT6KwNQtqaMg4pD395sQQJw6/
         I9xZ04N2Np0omaaae3GIGk1Ms/RpgpgX0uB6Qo31iZeygpX/+zLCasjy46j6c0cJ6Pm/
         nqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1AAUO9ec7glCHA2X40Y51NdXitGuWrBUJxsXEZcPDg=;
        b=C4M4LijcNcAzieoDjF2rw4p9pCQP6QgMj4sPuTC2tKZYVxveivAhA8IgkVHTPgrf2k
         jnxdb318wnaiYLdFL74rIp76VXxuakk8LCnmZeQdP8LofY0hQFalMIdUSfaOWfTbVgMU
         xuKbVd4gEgGRV7t/5z4QYbjMyevK5pvseCJsckZHVkwWa8gQbRdLbTPWCfCPCe5+BnZB
         oQN3hYjAq0VXqqnKUheUcNKZ2b+QxjRsf9vjvLkcTVZYsZkAVNNCB8Cz+kj9vdY3NGn0
         9jamXq+s7jaTma6qqUvocBEnmFo+BZgsgiL0IGIRDW7BWNb8X91rXqZYz0jFJ2glhk04
         gIvA==
X-Gm-Message-State: ACrzQf1i3CImS2oAsXxRetie4VUdCxJVBN7mj1obyQmu2perVFxCajbd
        SeD+VaKcUflbda+ccUapmmuG5w==
X-Google-Smtp-Source: AMsMyM7691EK067NDqs2Y3DWbH9DROsxcfs8nrIZcEFGEx9P9sJrrbzyZcL7UqR/7b5B7ECC0z6V3Q==
X-Received: by 2002:ad4:5962:0:b0:4bb:6b78:c599 with SMTP id eq2-20020ad45962000000b004bb6b78c599mr23744305qvb.35.1666968313257;
        Fri, 28 Oct 2022 07:45:13 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006b953a7929csm3111764qkn.73.2022.10.28.07.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:45:12 -0700 (PDT)
Message-ID: <f86fcbf2-76c4-e530-8ad5-f31de403ad42@linaro.org>
Date:   Fri, 28 Oct 2022 10:45:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] dt-bindings:iio:accel: Add docs for ADXL359
Content-Language: en-US
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028134454.669509-1-ramona.bolboaca@analog.com>
 <20221028134454.669509-2-ramona.bolboaca@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028134454.669509-2-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 09:44, Ramona Bolboaca wrote:
> Update ADXL355 existing documentation with documentation
> for ADXL359 dedvice.

Missing spaces in subject. Look at Git how subject should be formatted.

> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl355.yaml        | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

With subject fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

