Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779586C9ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjC0JEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjC0JDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:03:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AE423A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:01:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bi9so10345039lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679907697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZF8lnTdgBo76J61R0eU74GHsCNaFYFA/VikNNvRUeY=;
        b=kcheOvDYJ2HR8hXD96KUoD/iP+Qa6Fg8vuUImjl2l5D40VcSqI7YHjJ7CCKGk82PLX
         kRpYtpzgpkPT2wOMj7pUT8SRG59I8bsU/zT5rhHlfI3fUNN9S//kPV6VjSM+DtPhEGB4
         3BgxnvVO0+Pqdj3RyKeizj3VIQs74HDJRNN4qTiRQRv8dYYn4QYXNvEKe2qekRQ0DySE
         H9fLFb2cL+ukXrl4LYM6Pou5EPYEdPkO3SKdQfFKeDMQpN/Sj5Pd3U7qbyW5hPCAWYWE
         P/F/hhfD3Tz0T12SleC9CW6//ofl/HOsrWS2qfPZb+JTcX0I53cKhrz8UMtiOhxUq8LL
         sKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZF8lnTdgBo76J61R0eU74GHsCNaFYFA/VikNNvRUeY=;
        b=jfYS40qSWxkNAhRnNzG23TJ/E6+uDK1dI35oxJV9aiEfUKm1TLfkcKuzR8UeM32qyg
         JhIpQqb2jcRqQhwRQx8ZgLRpvqokF/p1UBJxgl4e3g+tn323+72bGlL6GHmAQWpOHpfQ
         T5NiOMUpf+gEYCrG/Dx//cXTSEbATvLW7VTHk2+i1gqkYFiEkQA8hnu65xr6WsRl/r/Y
         fV006oMEt5n8XIwIKslr3mSBQNIVLH2t774M44Lc+x5ZUUrUIkyc9m8A7dTwqIgakpxI
         JPOoPrRQuLu3sw8B/3ar0vCuVnpL3RHJ9Mz/SLk4tEHk2/gnRrf6q0yvlMaRXtqSV/3L
         z9Kg==
X-Gm-Message-State: AAQBX9dN95F1DBGzuestOFwYZouZhkXQD/EpUkr3PLjAE7FhyEXDzlxT
        F9ZsTUQ1l0UMZgsI91HATjmDVQ==
X-Google-Smtp-Source: AKy350ZTclvQkj8ph6vELe+Md+QnJjIPl1t0NzSuNYltD7cNUWB4kNAbBhoPsYJsNDCYhZ1FEjA8YQ==
X-Received: by 2002:ac2:5ec6:0:b0:4eb:20e:6aec with SMTP id d6-20020ac25ec6000000b004eb020e6aecmr3096588lfq.40.1679907696899;
        Mon, 27 Mar 2023 02:01:36 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id j12-20020a19f50c000000b004b40c1f1c70sm4594985lfb.212.2023.03.27.02.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:01:36 -0700 (PDT)
Message-ID: <cc7392c1-0ea1-29b3-fab6-19c843413724@linaro.org>
Date:   Mon, 27 Mar 2023 11:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] usb: dwc3: qcom: Allow runtime PM
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
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



On 25.03.2023 17:52, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series allows the dwc3-qcom driver to do runtime PM itself without
> userspace intervention. Still, userspace is required to enable runtime PM
> for dwc3 glue and xhci drivers as we cannot enable runtime PM for them.
> But this series avoids one more additional step.
What sort of 'userspace intervention' are we talking about?
echo mem > /sys/power/state?

Konrad
> 
> While enabling runtime PM, I noticed that the xhci driver suspends before
> catching the xhci interrupts during resume. This ended up deferring the
> device enumeration for some time. So I included a patch adding autosuspend
> delay of 200ms to the xhci driver. With this delay, usb enumeration happens
> properly.
> 
> This series has been tested on SC8280XP-CRD and RB5 devices.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (5):
>   arm64: dts: qcom: sc8280xp: Add missing dwc3 quirks
>   xhci: host: Use 200ms autosuspend delay for runtime suspend
>   usb: dwc3: qcom: Fix null ptr access during runtime_suspend()
>   usb: dwc3: qcom: Clear pending interrupt before enabling wake
>     interrupt
>   usb: dwc3: qcom: Allow runtime PM
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
>  drivers/usb/dwc3/dwc3-qcom.c           | 13 +++++++++----
>  drivers/usb/host/xhci-plat.c           |  2 ++
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
