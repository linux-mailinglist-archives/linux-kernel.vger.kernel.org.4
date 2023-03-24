Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E096C7A25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCXIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:45:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6312A26CCC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:45:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so4776744edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679647503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=830hBtIPsZaeejiwnNIQvsLJ3vvq2qEon6P9AOEFn4I=;
        b=AOKInVUun5QYR497uTcPeRp/ixm/Sle7Ro29uAQcy/xVnVjA5fV7YjGpBCZttauwS3
         ScJJCP82cv86GIzKoCjV5PwvROWV3SyUZUYOqbZhTls4bsexYOjDoonEFEb+5ab3vINX
         qJRmuC4mbXaLzqv1SyWESzweDiDQqk3aNigYiO3PWSkD9d+rXtey6HThFBnXImPWaWZK
         iUH+/qroTI5n8od+9xVZPXWF/ZksTQQc31r2LgN2IuEOnUwY5b+WJhrBryfrcJ2JkWYH
         JI9s4COidClnimE4fa3GdzgVCRsboVSY0luyY0vpX9V4Zg7qE9sy+52UxLo0qj3vjUHG
         VZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679647503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=830hBtIPsZaeejiwnNIQvsLJ3vvq2qEon6P9AOEFn4I=;
        b=2VI0MkGoQl+SaSOGpQAeSblBSVPZBI/As//KrsSrzHaeaHIEXbJsfEBKEiK71cuqMi
         Btf3SXLPSiS4tgYb+RwDaPhpLKrRBF+FCuglLihwD3Av0JNEGLEns6Asn73zHRDoXk3g
         JxbRYcN7RGgmkSZepFwBbuYrXbltTlgdC0PA2dcP6WkN02noz+15M3UbrH258lRqmO5f
         +5eXhlqLAnMMCNEZrpXFCEgbUvV3e1mhXvToeTRPzbUzkMLVCcu0KYmY0ylbVkCPshBc
         t+LPv02RNxP4IDhRuTlxkFKaHHzJiFV6ghoVuUuvwHbeuqdwEVeiUCnHWYc0UnWUk7dJ
         91YQ==
X-Gm-Message-State: AAQBX9fCBucGPDFLVKPGjoAMbU14chQurOUbrPc/0j3y7dpg427YbDNY
        AgiR0+Wd9cyh39lwJmiazZVApg==
X-Google-Smtp-Source: AK7set8QCHutUqCqZsOaNxZVbY+CicV98oBDz1isauF4xge+n0hMx4x94dRl81FLOENFriPFUeLMFA==
X-Received: by 2002:a17:906:dc94:b0:930:ba36:2211 with SMTP id cs20-20020a170906dc9400b00930ba362211mr2590037ejc.0.1679647502848;
        Fri, 24 Mar 2023 01:45:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ce50:243f:54cc:5373? ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id k10-20020a1709067aca00b009294524ac21sm9906814ejo.60.2023.03.24.01.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 01:45:02 -0700 (PDT)
Message-ID: <323401ed-3549-f45d-f9c7-c8f9f2d5c381@linaro.org>
Date:   Fri, 24 Mar 2023 09:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: alc5632: Convert to dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Saalim Quadri <danascape@gmail.com>, alsa-devel@alsa-project.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <1a2e0f7a-771f-5590-fc54-b9dbf059a925@linaro.org>
 <20230323171111.17393-1-danascape@gmail.com>
 <5e0ca610-70b2-90fd-45b8-6b0da089eb4c@linaro.org>
 <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
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

On 23/03/2023 20:17, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 08:08:33PM +0100, Krzysztof Kozlowski wrote:
>> On 23/03/2023 18:11, Saalim Quadri wrote:
> 
>>> I have a doubt, for the maintainers list, is it required to include all the names of the subsystem maintainer
>>> in the yaml too? As for this codec, there are 4, shall I include the names of all of them or the one to whom the
> 
>> Depends, choose one or two names, maybe the most active.
> 
> Note that the binding should have maintainers for the specific binding,
> not the kernel subsystem.

Yes. That's what I also said in the beginning, but for some reason
Saalim cut this part... and re-added subsystem maintainers.

Best regards,
Krzysztof

