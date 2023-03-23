Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB146C70C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCWTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCWTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:09:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F676F75F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:08:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so91103429edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679598515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlaSHC/GZ40AJ+I7acfZOLrawxc/It03kMRHOBlNclw=;
        b=XnCm8WzKPM6Z6XZq/Mgt1Yud70FHTvqpahg/keuOmzj7l3gAcX86bv6wdM7oRtuu5b
         UxVqK299RuSTq4ZftJODgjJWyZz2h6apTDq5DCiZ3Dvv/TZvl8tkWuPGryeLbWsaxjsM
         Xux7xyjvi870jVpfe6rInnmT8JaZ6Fab7hHDxk7ms7pvvkqCYclVYsFz/iPovhjGrBaH
         dCYorRYY3iyTJnSiX7KJHn1+mrrlj6t8kP1DPOLfuTes/eRqL5FRZ7ll0DPYj+3q0Xuj
         fyouncGtyozVprZgwYuRsi4ew3DTwXkjyfPh19uASDBp/KT7OykCk+RaXIfgl9YnGFk4
         7irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlaSHC/GZ40AJ+I7acfZOLrawxc/It03kMRHOBlNclw=;
        b=G66NrQvZMraEH3BveR1evSMC+s74HEqX+Owu+3Emn/eZMY3e39HMGnkaUBj5iVHtlG
         XtSByCmkDXV//fGBbCxHDoBEBV3RNDbWTyK/kZm8JkTNHMaZQSp3y7jq6Cz2MUDskG/n
         wqP7bvgTrAumA+zxtxbV6/yGmtIWFeHDTf3MrsaJgkfv7tJPLOx+OMVtVYWXHdw6pOGQ
         J8QoCjAiolJ4PAy1VgRqVNKz5cg+G4gH3FeApwOra1YFCM5q4EQ631/2Pq1oFrMmpPwq
         BON1aKXjNQkM0ulQ/u1Nsz6pfkvUZSLt1Llte4OSVoGNnpichGtiqQZg3RdLST9thKqP
         /Jyg==
X-Gm-Message-State: AAQBX9eITV9OyIgTPcul5Kkcfop39Bxhxfx4XOqm39Lm2mdD7OFV2ozs
        2XmaM0IPxwsurwbkG+Tv6IamxA==
X-Google-Smtp-Source: AKy350ZkZxvsbKP4lr6Lm1syHYK4RwLTk/Fdc2KC/QE9jWsDL8boYFCHwOoH+RD52hzOd1U6dNPluA==
X-Received: by 2002:a17:906:8486:b0:92b:2389:46bd with SMTP id m6-20020a170906848600b0092b238946bdmr115800ejx.21.1679598514822;
        Thu, 23 Mar 2023 12:08:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d350:23b1:cb94:f39d? ([2a02:810d:15c0:828:d350:23b1:cb94:f39d])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b009255b14e91dsm9044614ejc.46.2023.03.23.12.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:08:34 -0700 (PDT)
Message-ID: <5e0ca610-70b2-90fd-45b8-6b0da089eb4c@linaro.org>
Date:   Thu, 23 Mar 2023 20:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: alc5632: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <1a2e0f7a-771f-5590-fc54-b9dbf059a925@linaro.org>
 <20230323171111.17393-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323171111.17393-1-danascape@gmail.com>
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

On 23/03/2023 18:11, Saalim Quadri wrote:
> Hello,
> 
> This is my first time using the Linux Kernel Mailing List. I apologise if I commit any mistakes.
> 
>> This should not be subsystem maintainer but someone related to the
>> device. It's maintainer or interested contributor. Unless that's the
>> case here?
> 
> yes it is wrong, he is not the subsystem maintainer. I will send the updated patch.
> 
> I have a doubt, for the maintainers list, is it required to include all the names of the subsystem maintainer
> in the yaml too? As for this codec, there are 4, shall I include the names of all of them or the one to whom the
> module is authored to?

Depends, choose one or two names, maybe the most active.

Best regards,
Krzysztof

