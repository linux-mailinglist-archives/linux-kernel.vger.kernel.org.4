Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBD5F2B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJCIQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJCIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:15:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C91C74E32;
        Mon,  3 Oct 2022 00:50:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w10so514171edd.4;
        Mon, 03 Oct 2022 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=hdKudSePDxWLBXYpgpsmYiPPEBTmuwXmjH9VQ2JVEKQ=;
        b=mgaFRN3e9nI62i6lIBK7pOvT7M89RCjvaLYY0pTecskwiSnexQez+HtTc0rsr4WceC
         +2pOk4Eyyr0L+MsFWWm9CEAMXXwIT6lAw6PzOEfCd9YaGGLASAR9ItihMWsmq+9bZo7x
         HHMzGPe5lGzjMvjsPK1hwEEdUO9OZgzwHA873Tm6GFp8NYS2qWbj6DUWTv91+2NBiBcd
         prlCo6Vn92AIEos1/X1amWtcnn7LTfc6ZmPXZkt3SkbJCJ0oh36QpycKQUdrr02ivtQC
         8zKdghDcWwvi9BKupCs6qB+flcMLUOwS0O8PfgGVoK0yIW2PZkZcs3IV15+gvQBs8GQo
         G6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hdKudSePDxWLBXYpgpsmYiPPEBTmuwXmjH9VQ2JVEKQ=;
        b=CLy8tjbfFuSEvkvVXA0C1chwEACjxAnyNDTqTWJQ5GjKXPrK1KlBfOVVmwYfh5vM2P
         GbUqLJ0lx+ABOC6GiafLipyS2Wj47v8taxAMgUFW0TmjKKsv71lW921eE3WDZL37zOYU
         fXf2pWwdxIoFFJiWXhhVSJgzxlqFIIl5JNReXb4XEeQnBpz2NoD6peKhHX3vHJrJMTdo
         o58kR1ua253ATnJvL07+ZyoFIeMZwAjmDGJuDnUWtvHEux7KGOeDRsRDaQ0FiQJBcSGI
         gqeV2wB/HVz2QfiVcJ9AcT2IhoQdzQ83Cf3jbEae3nOpEzm3jxe89t/Bgh0eaPXTYOno
         J39A==
X-Gm-Message-State: ACrzQf2rr9M3SyPqbRlDaBTIa9Z5v6WihUhzwWC5ozFtElPmQtJTZv/l
        0f0p1R4zSf3++HgEVy3JYTE=
X-Google-Smtp-Source: AMsMyM6kCoEAxHJq2sN3aA4M/LNxj7SGtz26zQgE7juVgcBy7TVziLcy7qwpdnUNc8MMCNO2d5hdTw==
X-Received: by 2002:a05:6402:3550:b0:451:473a:5ca3 with SMTP id f16-20020a056402355000b00451473a5ca3mr17697587edd.48.1664783368882;
        Mon, 03 Oct 2022 00:49:28 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709063cb100b007305d408b3dsm5002579ejh.78.2022.10.03.00.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 00:49:28 -0700 (PDT)
Message-ID: <ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com>
Date:   Mon, 3 Oct 2022 09:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts
 property
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, wxt@rock-chips.com,
        kever.yang@rock-chips.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <94bcb278-7bb9-d173-497c-fe12682c4a17@gmail.com>
Content-Language: en-US
In-Reply-To: <94bcb278-7bb9-d173-497c-fe12682c4a17@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 16:04, Johan Jonker wrote:
> The Rockchip SoCs have 4 or more built-in PWM channels.
> 
> Configurable to operate in capture mode.
> Measures the high/low polarity effective cycles of this input waveform
> Generates a single interrupt at the transition of input waveform polarity
> 
> Configurable to operate in continuous mode or one-shot mode.
> One-shot operation will produce N + 1 periods of the waveform,
> where N is the repeat counter value, and generates a single interrupt at
> the end of operation.
> Continuous mode generates the waveform continuously and
> do not generates any interrupts.
> 

> Older SoCs have an interrupt for each node.
> Newer models share an interrupt.

As mentioned by Robin the common interrupt status registers are located outside the PWM node reg range.
The Rockchip PWM driver is only focused on continuous mode, while these interrupts only for "Capture mode" and "One-shot mode" and need a different handling.
Interrupts without reg resources is not going to work well,
so I think this patch can go in the garbage bin.
 
> 
> Add interrupts property to the pwm-rockchip.yaml file.
> DT describes hardware. Rockchip PWM driver support for
> interrupts might not available.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> index f2d1dc7e7..f7634069d 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> @@ -37,6 +37,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  interrupts:
> +    maxItems: 1
> +
>    clocks:
>      minItems: 1
>      maxItems: 2
