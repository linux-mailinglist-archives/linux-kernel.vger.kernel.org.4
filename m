Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767855EF7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiI2Oil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiI2Oig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:38:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1311C054B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:38:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s10so1777359ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=j0oWhXN2ZUd4COh7520YadSBs3lWzKCaGNiRYIIVCPU=;
        b=mcyHw/JXKkRWeKdTRipuWpdhKIdeRs7z/+yLr6sInNo7TR0aH42e14aN1KVAcXwe07
         wT12VHvxJ0Nu68qak+4LfFZfC7jnigLtkosYoecDks+Os5/GwK7NTtPYA8G6C+3Nx5Hg
         xLkbm7oKmZC/wvq1Qg0BS00R91Z/ni6dBtUbVEQw3mHcyG/+U0cfTpGxBmwGUsWSLVEN
         CgxTyV5zipdVqylGNH/vlOeZbqaWqu7oScxfaCnVpb2QYsTWu12rzLC5h1jEelDihZ//
         dgos0d5J+C2AzkcUHk7etK7vgJvNEf2F2Q9VxNsQFoj7O/dSKw1YLLznQB/rDPIn2oFQ
         bWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j0oWhXN2ZUd4COh7520YadSBs3lWzKCaGNiRYIIVCPU=;
        b=soYDX2PlqTTPH2jJu/wmXBVajNfLEJjGdzXUY81NbWpYafYgIFgbeieQamMGzXSTiy
         qWDYwkP1xBdJhJWgpjnc5fY3inYh87El4fj1w5BstpkUASl6ABrSlRbXNA8Ag2GhMDen
         GE2kPow1YN8+sypDHVz4uToX86u0cSeG/axeD1mxoWjJFExi159oDhhv0w6jMnBHCgdF
         Q+fj+OkSCV9k/3J93NXWIT2Y8zFs3iu4SgbvCpBvCpZCG4WPsVM58UW2zUAu+lUSVHzw
         D8nnIqxDMxP6FlH0hY11KXRMPoxVBnvgv0t1vsFgkYyCpOwxFZyL06wHG1iBmYUMDDh1
         L6eg==
X-Gm-Message-State: ACrzQf1PmM/4jSVQqcQPUgU/A0rxpDNP+c+8+ELXn0597wBGSZICziET
        Brk4gGH2JPxltOENGEnvI7UlLA==
X-Google-Smtp-Source: AMsMyM6DfRuuk5kpoptytoVkIDXi2xRmhOg3yGtMP6fD6LB0TNCoWSpxXSG34U4iX5ZBnhCmC8HEPg==
X-Received: by 2002:a2e:b744:0:b0:26c:40bf:eaba with SMTP id k4-20020a2eb744000000b0026c40bfeabamr1430188ljo.367.1664462312649;
        Thu, 29 Sep 2022 07:38:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512074600b004948b667d95sm800772lfs.265.2022.09.29.07.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:38:32 -0700 (PDT)
Message-ID: <bd024e66-25bb-0463-b346-b110c1b46681@linaro.org>
Date:   Thu, 29 Sep 2022 16:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
 <20cbd2a2-752e-8537-4cbd-6665ef9afd69@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20cbd2a2-752e-8537-4cbd-6665ef9afd69@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 16:20, Dinh Nguyen wrote:
>>
>> So this change will not be backwards compatible with existing DTBs. I
>> noticed that patch2 updates the DTS files for the arm64 platforms, but
>> there seems to be some arm32 platforms too. Isn't this going to be a
>> problem?
>>
> 
> The arm32 platforms makes the clk-phase adjustment through the clock 
> driver. There was a discussion when I originally submitted the support 
> for the arm32 platforms, and we landed on going through the clock driver 
> instead of using the MMC driver. The updates to the arm32 platforms can 
> be done after this patch series.

How the update "can be done after"? Didn't you break all boards in- and
out-of-tree?

Best regards,
Krzysztof

