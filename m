Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A095BDDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiITHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiITHJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:09:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434665F21E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:09:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h3so1910677lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Wo8uP5ffgZyZWYK9afaO+p/W/5Kwf864osF/ckvXkRg=;
        b=grzro9B7+WgfVf2xBiNjkxTYALekfROadRmRfJuBoGy5IpiijPZGNUGpa2HgNc+O52
         gtc0da8IZopEEne89hAZlYzfr9DGVMejFi1IJejkP23YUHixyjYVebTZDFQo8nQhHwvY
         U1UnDmZbIGF/4WgyGLcWn/7vwina3T/z4WzHdVWwdL1T8AaIiS3kx8NSnqq8P4nkdVp+
         KkxzpFx3UUa91XTE0ZHVaevoiZtw3FkGLvHJBr4qv9jK16plWRc0jy+tfyul0TuMMqRa
         X3jz1lCo0/Hl8QGGXedKkpK7GCjKz5VX1Cfpc4Y0jB3phALjZWKNg/ucfpHL+H6jrVkZ
         6ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Wo8uP5ffgZyZWYK9afaO+p/W/5Kwf864osF/ckvXkRg=;
        b=LEiQz4gTPsQNqn0qQMWhPrOM73WtvSI6IBV7LsP5f5kHjjhhGwD9/5MlAZBoeNPlX0
         jmssWO+3aTogvgm0iN7ADL/EMxW94Yo2+3zkKk69OzdGrcReCm1SaPbPLIqx779MJobF
         5UgN4lL/wUsjb6sgJabnhOcuGV9xo+yAgr3Kt2j12HtK/b2N1EW4H0TzHMmXjPk1yFE0
         ePUF11SuloppeLlcisPYK0P6OO16/fdf/0PLJ1xtGf6QE8Fd2A2Uf6MyPUYSDJTRMuAM
         eG7csrKL2kg1dGIn+aI4+NYroRIDQzivZAS93zftQP7SjF8Jm6zOU+KODjoDh2aeHPNz
         X+jQ==
X-Gm-Message-State: ACrzQf2iDDSNuw3Y94JZ5JFQHgA8OQzv+UM6/I9W/boFSZhPaeCbzDxu
        3kF8H+kc7SrCV5pzMmCIWfr/dw==
X-Google-Smtp-Source: AMsMyM5k368tciyRffIEz9KEI7TXQB6utOD+AnJuFSrX4KDaWv/fY/Ol3hSX1jO8ZUTskHXRihVDqg==
X-Received: by 2002:a05:651c:50b:b0:26c:2962:bf1e with SMTP id o11-20020a05651c050b00b0026c2962bf1emr6119083ljp.343.1663657754595;
        Tue, 20 Sep 2022 00:09:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i189-20020a2e22c6000000b0026c1b85d8b3sm113960lji.34.2022.09.20.00.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 00:09:13 -0700 (PDT)
Message-ID: <6b242b44-b657-c7a6-63ca-465c7031376f@linaro.org>
Date:   Tue, 20 Sep 2022 09:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220916200028.25009-1-quic_bjorande@quicinc.com>
 <20220916200028.25009-2-quic_bjorande@quicinc.com>
 <1641e41c-08c7-859b-644a-28d966fb00f3@linaro.org>
 <20220919211832.6b3buqxrnfp6yjjg@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919211832.6b3buqxrnfp6yjjg@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 23:18, Bjorn Andersson wrote:
> On Sat, Sep 17, 2022 at 06:03:27PM +0100, Krzysztof Kozlowski wrote:
>> On 16/09/2022 21:00, Bjorn Andersson wrote:
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
>>> Qualcomm SDM845 and SC8280XP platforms.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>
>> No need for quicinc SoB (unless you also take ownership).
>>
> 
> It's my understanding that both needs to be there. Bjorn @ Linaro
> authored the patch and the author must certify its origin, but as the
> submitter I must certify its origin.

It's the same person. There are no two Bjorns (unless there are :) ), so
you certify with old email. SoB chain is coming from people, not email
addresses.

And it is not only my understanding of SoB chain.
https://lore.kernel.org/all/YuKcBO5JatwRYQJ3@kroah.com/

> 
> I'm not entirely sure what you mean about taking ownership, 

I meant you to be the author of the commit.

> I am going
> to pursue getting these patches landed. But it wouldn't be correct for
> new me to claim I authored them.

Yeah, that's true.


Best regards,
Krzysztof
