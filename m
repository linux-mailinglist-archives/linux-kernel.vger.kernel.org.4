Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268555F07D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiI3Jmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiI3Jm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:42:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043FC1131
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:42:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c7so4174854ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=zzO/BABXosBW26dQzbnEVuKM6qmCAqUZCHFz/+F2wbU=;
        b=vog+SdyMWmM8BsTAKPH5HaEUFfZVGn3pbQBKPMtytKUC9k+5IA0QqXJ1ZKm417DmSt
         lqxWMAxG5UeXGnLbqTxE80hkfsmLRB3gWxsl0witKG5XbkWB2BUv/uXpAMVVGZdjKT6y
         nDyv4uNEIe5H7/gPSzb0e+8wf45G0YEq+7uM/2qIKJ7vJns58a0AkCP7JJErgpdMgk4c
         GsNPCtg0Rpb+44u6/qi0L26NQhivFror84C5ohokPpTv7sIj44Hym2plPPIWsMGJPPTq
         TklMJMsc8CmTsDIbe+9eCQRkz8x8ukdkAzFfkquTi4+FcCAQ4p9aIg7oTWlGw4mYHu+7
         jVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zzO/BABXosBW26dQzbnEVuKM6qmCAqUZCHFz/+F2wbU=;
        b=SHIW4HHlP1zbDIdYbNnO1zlww2/R2xOp4vivDPM1GDj2GbVWBgmpEpboUiRqxgr2UE
         Z5OVBV5YPLOYB2ggzu/RewTMG493jTqKfA2EjwQ76Fbj4nZUeqhVLtC4jhd4l5ulH6E+
         DBxPWiIuPGNw85eXohtQAoqARaqAz4l8r4e+NCyNFh3qFneSbpxh2vuEE3usYRRdu5b2
         anXaU/OVOxRwbCygVrgIxpROQw83CS2YdJkhKr69uEPyM5tQY42jGKWwLRvq8XyEoj63
         Rt73xtSjbxrwXEAaDBfWfB245RuKnrrjDlE9FbS0lrI/7MfTocypSnAUD5DAp9c/E537
         EJeQ==
X-Gm-Message-State: ACrzQf374r5s0jEM0flxr+ZAQAEuQfSHWUF3WmEZwM6qCrnrKEKr+LL5
        Sry6+ajtbWqGesETPtWNHhtrzg==
X-Google-Smtp-Source: AMsMyM5F1t3B9dgH4g2gHekokkYTbTUDVoKD2+k7NhubEORICaGbBVq5Pi5IQuwRymtc5m1QgIRtTw==
X-Received: by 2002:a2e:3211:0:b0:261:c5c8:3403 with SMTP id y17-20020a2e3211000000b00261c5c83403mr2766450ljy.86.1664530946585;
        Fri, 30 Sep 2022 02:42:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u15-20020a05651206cf00b0048af9d2d119sm240785lff.130.2022.09.30.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:42:26 -0700 (PDT)
Message-ID: <c3aafcdf-9e24-9fbb-b022-d7d1cf04b7b9@linaro.org>
Date:   Fri, 30 Sep 2022 11:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] slimbus: stream: handle unsupported bitrates for
 presence rate
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
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

On 30/09/2022 11:20, Krzysztof Kozlowski wrote:
> Handle errors of getting presence rate for unsupported stream bitrate,
> instead of sending -EINVAL in change content message.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/slimbus/stream.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> index f8eade1e0132..28fbecb3907d 100644
> --- a/drivers/slimbus/stream.c
> +++ b/drivers/slimbus/stream.c
> @@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
>  {
>  	struct slim_controller *ctrl = rt->dev->ctrl;
>  	struct slim_port *port;
> -	int num_ports, i, port_id;
> +	int num_ports, i, port_id, prrate;
>  
>  	pr_err("%s:%d AAAA\n", __func__, __LINE__);

The context is from development tree. I'll rebase and send a v2.


Best regards,
Krzysztof

