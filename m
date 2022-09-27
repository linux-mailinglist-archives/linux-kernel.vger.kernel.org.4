Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D905EBEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiI0Jg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiI0JgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:36:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E3AF0D3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:36:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n10so14023411wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/PlTLjGPSzswYlkSsTRBa4iX8iTXJTu7JK2WCLTfMVI=;
        b=zwOCiH829H9W0MajrUip+/i4V00nILbmKLrgsGXRXIs/H3acOnp1T8Retrgw/XuQnk
         WGAUlUaNiAHW0q1vdy31YzcqavfVoEH4yRocF2uitfJcL3lHXsl6m5keoyqFr3wFIYKb
         4quqBuNZGY8cNnRoPJLx9VgOXPvXosnH/zEQSyQpsXODFOaqfIKqOZRdKXqbZBmyEG4R
         PqeXHMNqDpdjlWJN9tKSDwfcpXT1A9b4mzMpHEdDyTVoVAGBHlc0ILCKTdSQ9yapXD2f
         mTdkn6fVZZcWCWX1hhr0I6Xz6EaaADoMqimQJNW+VoZvzJ0xZyBtnNKYnpeAddTHF2ct
         jplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/PlTLjGPSzswYlkSsTRBa4iX8iTXJTu7JK2WCLTfMVI=;
        b=ota4RYASAsmnx7mhWIxkqQaDXFJW8d+cYKEC8jn2Nr370ivEsXd8B0Uf+Jyhv66m6t
         WeLHTJ0Omtd5dC+wlad0E8+DlqMsAEcQw/MZ/XugHwd0YVpY9SKq45EUbD/HIRrmlMr3
         7tK45WFave4x8YWE/+vd9tHhA71/74p0LST0s8rRi9WfgUzf8d53aaaqh4EEx3FDcNGM
         jWHBLPy/zn9wDbPytjP+tJb6lDDOp0z4s2HCqfYw7CfF7k0y9hXLQ4dhCSxz47DPp+Yx
         bWEyj/JXxuzFx96HTa+MA/Ip15vNwFdrddicm/8ravhww2X+cLBNXseRXOnQ8tQ4W1uI
         Dg3Q==
X-Gm-Message-State: ACrzQf2foj8WNBZqyI+BWPXxpLXUH2zqrpujUAuabrsI7UlWKIipDzfA
        RwUPmb7DyPJrsxq0NsQQCi7eMg==
X-Google-Smtp-Source: AMsMyM7Sbp3KGS9RYk/ygpLZfdjsNmCuCMpLpfCLcKHXR7Gpm06yHTH40B2WCmC9hs7behpb1hhprA==
X-Received: by 2002:adf:de11:0:b0:22c:b5f0:272e with SMTP id b17-20020adfde11000000b0022cb5f0272emr2003308wrm.224.1664271377909;
        Tue, 27 Sep 2022 02:36:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c028e00b003b3307fb98fsm1180132wmk.24.2022.09.27.02.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:36:17 -0700 (PDT)
Message-ID: <29cc25fb-0196-d80d-e3c7-b6aa22d32b1b@linaro.org>
Date:   Tue, 27 Sep 2022 11:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] thermal/intel/int340x: Initialized ret in error
 path in int340x_thermal_zone_add()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
References: <20220923152009.1721739-1-nathan@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220923152009.1721739-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 17:20, Nathan Chancellor wrote:
> Clang warns:
> 
>    drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:222:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>            if (!int34x_thermal_zone->ops)
>                ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:279:17: note: uninitialized use occurs here
>            return ERR_PTR(ret);
>                          ^~~
>    drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:222:2: note: remove the 'if' if its condition is always false
>            if (!int34x_thermal_zone->ops)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:211:9: note: initialize the variable 'ret' to silence this warning
>            int ret;
>                  ^
>                    = 0
>    1 error generated.
> 
> If kmemdup() fails, -ENOMEM should be returned.
> 
> Fixes: f6f6f9a01374 ("thermal/intel/int340x: Replace parameter to simplify")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1717
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

I've folded this patch with the changes introducing the issue

Thanks for the fix


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
