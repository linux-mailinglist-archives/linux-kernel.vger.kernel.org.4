Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178A9702C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjEOMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbjEOMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:05:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A31FEC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:04:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so23550182a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684152247; x=1686744247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/nlan8NsKQaqVLCr51QfC/hNbeFSNTXRRDAB3FVPas=;
        b=ByoRjCzbZlDhT1T9pjQEYxr54YRw44V8aNUv9jfd5JCNP8tHSMuToNR/AON5XhQOmw
         N40Kl/3OLlocsZ4d9J6Kn7vUs9/ZVehfyNn5RyuY8fBOdTbsM6OSE/tm9Oh9hYZtBT1A
         rbxBFvkvqcGnMKja3ynsVt20EiEKi2YE3+SrV5OGR6t4lHveWTtmgAksr7JO7ceasrTJ
         7F0woxS2bnN2EVU8rslQE62j9dDrwpLpurk01imY+qvNvqiVHXgGrSyPClPx0u1yOMoF
         NfSX/hzAgDXlfsmrgFfUiFNX7jDD7okvDYvv7hfnpJlVhIhrQmhb8hVm3+ifeZLht279
         fJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152247; x=1686744247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/nlan8NsKQaqVLCr51QfC/hNbeFSNTXRRDAB3FVPas=;
        b=dwghiWMeAR/1iu137V5Urz3Gn0U/3Wq+BuXN+w+SpOjcskGULt+rkgCP2xGK5CZeAM
         vXeihwvZcD4+ySCbXIf0j9m+DhJ2EUyz/nZL5hHzZXSPiz3fpZK2oj67IKrRMIrXzc59
         V/6fe3sd7m8ncsxHfSSHs9il1ZVM8gGh2YPh0WMIpzDyvFSAFl78t7v5pkDwZK0wE9il
         D0e6oIG4SuEh2kDggNQ2cI8FC+8h6HSn6t5PujCkHlmCahaambRKnD4g+XOk4zcRRPg3
         VeaynQg1bQpAIMdgxpxKuxv1Rne9wxY4bQEz/oBKSgXPPgPybesL27xNrX9bzxxwBtkb
         nUHQ==
X-Gm-Message-State: AC+VfDzTGeTXQ5IK8DEv6MmG4/0b41PHbizAMiNTvE1B4clZOEM/SpnX
        Kd+ZCn9WpA5Qh/cYtRC529P6fw==
X-Google-Smtp-Source: ACHHUZ4whC+e3qGJCrdvneIaAmKdoHpgCsOxbqCTyf91AW/nF0/VvKIN+NibbQBny50EjV05s6mA/g==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr34190677ejy.15.1684152247320;
        Mon, 15 May 2023 05:04:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id k10-20020a1709067aca00b0096a1ba4e0d1sm7811245ejo.32.2023.05.15.05.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 05:04:02 -0700 (PDT)
Message-ID: <e8d7e008-db27-9ac5-6728-d3f7a19c10c9@linaro.org>
Date:   Mon, 15 May 2023 14:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: Add ESS ES9218P codec
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
 <20230515074021.31257-3-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515074021.31257-3-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 09:40, Aidan MacDonald wrote:
> Device tree bindings for the ESS ES9218P codec, which uses an
> I2C control interface.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> 
> Notes:
>     v1->v2


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

