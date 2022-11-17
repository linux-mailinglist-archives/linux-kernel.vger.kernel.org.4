Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF9E62E3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiKQSHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbiKQSHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:07:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA533748EA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:07:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j16so4073552lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vc61MC15ng5hg9XN/HE09Tk5Va/o8Qyfi0Jm/l2XQGg=;
        b=WDoE+Z5NrWgh34tzb9p90gt4St3P4LpmKJu8/fU6ZRY4KBUVGb+uayCquoyTVU59RN
         7qMz1NRJFHMWQTbsw2D2RBC4Zwm+jOmyLGJdi8HSk83NmiH2oOjeq8xmXVk6MwfueC2n
         FKjZSF0wha8Znv97evAMyy+m590PTGSAljm6uB+xnNN5Xijdssqx+JBMh1uGYmdDyOPX
         zPqSPhT7QvR3MCryd67f/cDnXmIPbuw3SfQo4fXJfW64ikTRa8aHDM4wjCM2x3fBE5gk
         YIgSx/l+76u9sVunpDu6uarwICT+ytlp7AHU0Z6UZpu9LFJLezVzOYbsXeepvriTyeJu
         iTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vc61MC15ng5hg9XN/HE09Tk5Va/o8Qyfi0Jm/l2XQGg=;
        b=M60Skc2ZVA+TkFPmAa4WhBYoQHe9nd2YnobWZIV9Rj1sxIrgswXVOAKmJ6NTkdnvSs
         InB8PmjCAYSlEGLdlCZ6ZqoQntiexdUc9yw25w/NwHhzX96jY8nzUT88Jv4IcDx8npn4
         LbWmVpZiSTIjyrIEH2vRDy9/j+8JIwmD6D4a4CnCrLKoEHR7y3Atxijl1x3oq7WNlBt+
         3udzx4cocM5prt5PGIa4qPA01Sj91eKQJQD7MCSCL5yCZ7A7IBBtjwNEvFjqgGqNVKEu
         LGRsIzf8MJmYbDMavJ2+6V9RcB87jKeRQPs67rvbo1Oc1f8MHnPnnPveGicmDR7f9J8R
         jr7A==
X-Gm-Message-State: ANoB5pmjZCjzwATQLy1blon4eClNCeXq2OoKzC4D8ZLRCipbVzRVur/G
        pYfoUriD+a8jT+rxbZ2wZg0Nqw==
X-Google-Smtp-Source: AA0mqf4wziC0JjtpCHYSk2OlbVd5tdl6jKrb5WVCJQfcRVbDRpEvoGt7ai3GWxFhDkSFfDWMzcsShQ==
X-Received: by 2002:a05:6512:3fb:b0:4a2:2eb2:c88 with SMTP id n27-20020a05651203fb00b004a22eb20c88mr1286232lfq.496.1668708453903;
        Thu, 17 Nov 2022 10:07:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b004b4a0482a53sm255275lfr.231.2022.11.17.10.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 10:07:33 -0800 (PST)
Message-ID: <dd2fcddd-13ee-34f5-575d-0de751b2042a@linaro.org>
Date:   Thu, 17 Nov 2022 19:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/8] dt-bindings: display: renesas,du: Provide bindings
 for r8a779g0
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-2-tomi.valkeinen@ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117122547.809644-2-tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 13:25, Tomi Valkeinen wrote:
> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> 
> Extend the Renesas DU display bindings to support the r8a779g0 V4H.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> ---
>  Documentation/devicetree/bindings/display/renesas,du.yaml | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

