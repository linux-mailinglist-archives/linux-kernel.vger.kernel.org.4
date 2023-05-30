Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865D7168FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjE3QPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjE3QPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:15:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EBCE51;
        Tue, 30 May 2023 09:15:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so49269395e9.3;
        Tue, 30 May 2023 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463308; x=1688055308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffdFQm0jEJ4or3XpCNPB9yNMvJlJc4OS1xrmBXhf0Fw=;
        b=ZQexd8UwflGNwIinD31NZqZnhMKvmMc5XUKploBD51I7p02EGwJOJnHNI8iAi3Gr3l
         bdU+ckpddFsI/qDtMbJ195iiNmSf0mx9GiB+fh26/rBjSFN7AtwPG5D70tuATzLSv3dc
         XWtwgxlGNzayNN+yyZgvijWl8u/5+4VtvkgVE97TEr9zxB95LXqzfD12i9V3CUmcGZBg
         peWBM4bEpqfvC7DHeQoX646wB+OU0Uvxjke2pJLoiSwpewfcUFwxAJvHy9SgCaMZSMzI
         r9fwnlCz/j72bVHBgp8w5ijHOH0JiCmMnuoGW8cOzpZOooaZcTE3FvpRteEyryY76NBA
         JEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463308; x=1688055308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffdFQm0jEJ4or3XpCNPB9yNMvJlJc4OS1xrmBXhf0Fw=;
        b=DPy0EddW9609mWaaxElX3wYsy15PdtbXFLWcH+kcn1tzLSm6jOM0BkpQbDt39Qrt1e
         5zbDs3gjQh30BMIQPB18zlBCPDzmcdxZcsEqrBZbtL1cRRtK5vlUIfACxCtoeRgYoRvK
         z+9ROD57WaF5Sy8pwrI3B66YO4hvVG1noqPztiz/XMnZ4e/n5cv+bUOERVSXEqbhfx8y
         8E5wVuGXDt0MuOXKfJbFcI2l4YAfNNSsRKhb/cZntgwx0JEkQi/TrbljeZ/HOG1V1x5J
         Nn/YHWWH6MtgV3h2XxkXOX6oBABpiSNNiFt3zppD6DyM34DEKCudE5tfLoBT99YR9vU5
         LLTQ==
X-Gm-Message-State: AC+VfDyHAVXekPVBYoDlBGc0ER2XEHr2eGGD6X9k76nnQDn/Ksw85EjN
        3QXfGhi2Oh5OPqc1cGqMotUOR4DEMwI=
X-Google-Smtp-Source: ACHHUZ4z+qYheNjCy0sKUpud1fv7rW9aP2mby2DtvuFBDHFLHjqYcAMAUvp/whhz8QhlVeQ96tpRqw==
X-Received: by 2002:a05:600c:2284:b0:3f6:1bb:1dce with SMTP id 4-20020a05600c228400b003f601bb1dcemr2090599wmf.13.1685463308199;
        Tue, 30 May 2023 09:15:08 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5aa90.dip0.t-ipconnect.de. [217.229.170.144])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c7413000000b003f60e143d38sm17877299wmc.11.2023.05.30.09.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:15:07 -0700 (PDT)
Message-ID: <3255010d-82d5-e8e8-2e11-7de25d538d72@gmail.com>
Date:   Tue, 30 May 2023 18:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/4] lib/ucs2_string: Add UCS-2 strlcpy function
To:     Kees Cook <keescook@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-2-luzmaximilian@gmail.com>
 <202305300820.9B2154B@keescook>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <202305300820.9B2154B@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 17:25, Kees Cook wrote:
> On Mon, May 29, 2023 at 01:03:48AM +0200, Maximilian Luz wrote:
>> Add a ucs2_strlcpy() function for UCS-2 strings. The behavior is
>> equivalent to the standard strlcpy() function, just for 16-bit character
>> UCS-2 strings.
> 
> Eek, no. strlcpy() is dangerous in multiple ways[1]. Please implement
> strscpy() (i.e. use strnlen(), negative error on truncation, etc).

Right, make sense, thanks. Somehow I missed that the kernel has a better
function than the C stdlib for that...

> Additionally, it'd be nice of the ucs2 helpers here also implemented the
> rest of the CONFIG_FORTIFY_SOURCE mitigations (i.e. checking for source
> and destination buffer size overflows at compile-time and run-time with
> __builtin_object_size() and __builtin_dynamoc_object_size() respectively).

I can certainly try that, but I think this might be better suited for a
follow-up series, given that we then should also add those to the other
helpers.

Regards,
Max
