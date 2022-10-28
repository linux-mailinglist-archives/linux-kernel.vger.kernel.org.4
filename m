Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C461199C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJ1RuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJ1RuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:50:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8FA2A959
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:50:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c23so3931057qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5995YsiozHO3d7Ra8M15mX4cI7UUZfmTpt42Yt3/Fis=;
        b=V1MoU4DmdN47hMDefnhOoABZXkZR6Ln20yflwb9sNky8OWV+OyRkGWAJuobtBcSKQJ
         wrsWQFLa9zHaJfAwy91VQj+IOfv7C8RJ1BXS2octwwIYJNU/1DJXeudznOv9srMJZEgr
         657mU/IUkT7jhTn7UD52uM3vKNZF6VudMGQ9oF8IBxb9BTySNPgRc7vZRPKRC6ad5/LS
         rzwsR5MJY5kQPh1iPFWINIl/7Ng0H+eW/m72GSt7qLMH/wXFyva3Goe2UUlYEn4waVLq
         XSG/FnUcrfDVm90Z6uLXwci1KT0K0eOFd9p6t1ex7RG17HgS40Zy3SE4XegY8X3dOov3
         MlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5995YsiozHO3d7Ra8M15mX4cI7UUZfmTpt42Yt3/Fis=;
        b=8EBLF1J9rFyy51UTe52cmholvCzoS4IhuLLGBo78XRMG0Y/tKdzHjgE4fKhzgxk0OP
         Zyi3gtNP1jPrUC7nnHeQv7JAmV4/DeySBoGG1efSQRXSHKoaiHdl3QBv9SWPfXMWTvEi
         XJSxiy6u6vVUw+32RW9MJLRK4oCpFMYJe3X0TLalraTyRieCKDuStigg/q5bsz6UJnyz
         9DCrKALtxeM/G6Nvd6qWegrYob2cAxrIcOTHHw6M0d2gE+WXUtQk+Rz3IxVeNHyz8/Np
         fbIRZCknOKZpPqoDaV6Mduxbdc8sFGbmbCnmJlVUoieCb7CDO7xmxR8xhCaRVMjCj4Oj
         egaA==
X-Gm-Message-State: ACrzQf1HpUy5wCMC4RrzDr05Xmo3WTRNshL+jHpGDKjrGC3MkZyYOntB
        3eiQWwmvYxs84iLBgyC6PXVCCw==
X-Google-Smtp-Source: AMsMyM6mU91dQsrH37KkI5nhWAGKJtWgY9oGQxPnduYRQ9yst/9L4mtPemFmedx4TC5JRORzLTFm2A==
X-Received: by 2002:a05:622a:1391:b0:39c:eee6:123e with SMTP id o17-20020a05622a139100b0039ceee6123emr564108qtk.271.1666979401236;
        Fri, 28 Oct 2022 10:50:01 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006b953a7929csm3423237qkn.73.2022.10.28.10.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:50:00 -0700 (PDT)
Message-ID: <7e41d67f-c79b-215d-8a58-b5a0db30c324@linaro.org>
Date:   Fri, 28 Oct 2022 13:49:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ARM: s3c64xx: include header defining input event codes
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y1wHwEm15/K87tdq@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1wHwEm15/K87tdq@google.com>
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

On 28/10/2022 12:48, Dmitry Torokhov wrote:
> The board file for Wolfson Cragganmore 6410 uses various KEY_* defines,
> but does not include the relevant header directly and instead relies on
> other headers to include it indirectly. With the upcoming cleanup of
> matrix_keypad.h this indirection is now broken and we should include the
> relevant header directly.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> If possible I'd like to get this through input tree so I can take
> another stab at landing matrix_keypad.h patch.
> 

Should be fine, although there is a risk of potential conflict with
Arnd's patches if he changes something more in v2. v1 was
non-conflicting, at first glance.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

