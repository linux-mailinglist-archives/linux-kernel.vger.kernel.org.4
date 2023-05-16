Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74CE70424E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbjEPAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbjEPAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:30:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287516E9D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:30:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f1fe1208a4so12543055e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684197020; x=1686789020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMLZvhZl8R40+PTJHjbAYABuk78m5EzXCQRws3AxxY0=;
        b=jGhApS3SfXW13d+BB0qGQux7Pi55dj0i3E0t4Zpaj7hZZk7PgZ5Tt3Qj68eun3Zjs+
         tlj35LDmQmj6sPc5VIIIZcB69GTazV48L78k/I974ohHlcyylF9/QIyYDGQlktV8VWci
         lCl7dbCG3M0jYlMYHDL8trM0WnIp8rfUxKzVceFqVmgGL2JMJZr/ghMoRIo+yZqdpQec
         T8+7AHo+gKYRAGO26TjRhnJC7ozbWwh1vTOCODQ24/phZqTzQLOwHQ66btfqwwH+qeIJ
         TL/t2fZYmiFaElHkooVdyjDAuYQrkWbqcD5QBSIuyjuiE+e1PwEesNg74gQnmjKLeRKs
         ZwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684197020; x=1686789020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMLZvhZl8R40+PTJHjbAYABuk78m5EzXCQRws3AxxY0=;
        b=kRjnRJDqtqQML6qM4xmZapcZvcWab9prlL1HZkMfU50PJ6L3x9mk6qg4SdoUjNQJbq
         fTi2HA4QIQnfyNzDhVszwR1hAg6C87cqkYdxdqm8ql7GE4akdYCimktVAnU37V8jnvWT
         Fvq88zorqmDrVwNefbbi7Q6NJ8UGnoH1k8xdbR43eg3TKucheoPEUbtnpzlArHlG2W/h
         xkSq8nJ3oXX26lmpZRa9g8futluhugDrIz2wpWXEPBq1rO6ZDZcIlk/ACVmam6cY2XVM
         fHmVU0H7k9Rc9Po052M3Z00dJInar6WtuoJQgfRmaLh7OtsLe0UaBj2JorKlqr2tcI8s
         dyuQ==
X-Gm-Message-State: AC+VfDx/Wfbmr65vq2pGfm+ZwU3Iboe96HBW5KurYYGP7WxveyXMFtrx
        JLZVNAzE1Xl5UzKSn68EhzDDmQ==
X-Google-Smtp-Source: ACHHUZ7alVvp8Qkv+AnzzYOiJhdWHEN9BD/GuLDds8xJ6n0yrgdESq0d5++rzQprBktZPbJy4rM0GQ==
X-Received: by 2002:ac2:4c8a:0:b0:4dd:af29:92c1 with SMTP id d10-20020ac24c8a000000b004ddaf2992c1mr6210602lfl.44.1684197020372;
        Mon, 15 May 2023 17:30:20 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id v7-20020a056512048700b004eb09820adbsm2774544lfq.105.2023.05.15.17.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:30:19 -0700 (PDT)
Message-ID: <38dc17a1-a39e-7c1f-3377-beca19a01df2@linaro.org>
Date:   Tue, 16 May 2023 02:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for
 misidentified sc7180-lite boards
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515171929.1.Ic8dee2cb79ce39ffc04eab2a344dde47b2f9459f@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230515171929.1.Ic8dee2cb79ce39ffc04eab2a344dde47b2f9459f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 02:19, Douglas Anderson wrote:
> In general, the three SKUs of sc7180 (lite, normal, and pro) are
> handled dynamically.
> 
> The cpufreq table in sc7180.dtsi includes the superset of all CPU
> frequencies. The "qcom-cpufreq-hw" driver in Linux shows that we can
> dynamically detect which frequencies are actually available on the
> currently running CPU and then we can just enable those ones.
> 
> The GPU is similarly dynamic. The nvmem has a fuse in it (see
> "gpu_speed_bin" in sc7180.dtsi) that the GPU driver can use to figure
> out which frequencies to enable.
> 
> There is one part, however, that is not so dynamic. The way SDRAM
> frequency works in sc7180 is that it's tied to cpufreq. At the busiest
> cpufreq operating points we'll pick the top supported SDRAM frequency.
> They ramp down together.
> 
> For the "pro" SKU of sc7180, we only enable one extra cpufreq step.
> That extra cpufreq step runs SDRAM at the same speed as the step
> below. Thus, for normal and pro things are OK. There is no sc7180-pro
> device tree snippet.
> 
> For the "lite" SKU if sc7180, however, things aren't so easy. The
> "lite" SKU drops 3 cpufreq entries but can still run SDRAM at max
> frequency. That messed things up with the whole scheme. This is why we
> added the "sc7180-lite" fragment in commit 8fd01e01fd6f ("arm64: dts:
> qcom: sc7180-lite: Tweak DDR/L3 scaling on SC7180-lite").
> 
> When the lite scheme came about, it was agreed that the WiFi SKUs of
> lazor would _always_ be "lite" and would, in fact, be the only "lite"
> devices. Unfortunately, this decision changed and folks didn't realize
> that it would be a problem. Specifically, some later lazor WiFi-only
> devices were built with "pro" CPUs.
> 
> Building WiFi-only lazor with "pro" CPUs isn't the end of the world.
> The SDRAM will ramp up a little sooner than it otherwise would, but
> aside from a small power hit things work OK. One problem, though, is
> that the SDRAM scaling becomes a bit quirky. Specifically, with the
> current tables we'll max out SDRAM frequency at 2.1GHz but then
> _lower_ it at 2.2GHz / 2.3GHz only to raise it back to max for 2.4GHz
> and 2.55GHz.
> 
> Let's at least fix this so that the SDRAM frequency doesn't go down in
> that quirky way. On true "lite" SKUs this change will be a no-op
> because the operating points we're touching are disabled. This change
> is only useful when a board that thinks it has a "lite" CPU actually
> has a "normal" or "pro" one stuffed.
> 
> Fixes: 8fd01e01fd6f ("arm64: dts: qcom: sc7180-lite: Tweak DDR/L3 scaling on SC7180-lite")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
I'd love it if you wrote a book detailing all the crazy stories like
this one, given it was probably not a one-off :P

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: <stable@vger.kernel.org>

Konrad
> 
>  arch/arm64/boot/dts/qcom/sc7180-lite.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
> index d8ed1d7b4ec7..4b306a59d9be 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
> @@ -16,3 +16,11 @@ &cpu6_opp11 {
>  &cpu6_opp12 {
>  	opp-peak-kBps = <8532000 23347200>;
>  };
> +
> +&cpu6_opp13 {
> +	opp-peak-kBps = <8532000 23347200>;
> +};
> +
> +&cpu6_opp14 {
> +	opp-peak-kBps = <8532000 23347200>;
> +};
