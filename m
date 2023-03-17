Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95BD6BE581
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCQJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCQJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:25:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD279B6D04
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:25:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so17906722edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679045112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlLEXPAyc6Yf23gKGJxdN1O2nSWmWz8A1QbLTo26vFc=;
        b=sGRD3ZniFxujJcvbDRiM5xD17dwCf5vPaQdVPdd6LO7bDHprGJNzcRVFnVkcldquo1
         wM90wjTCGqOjB6OCDALvnJdV4ytKBTSqP8EwMW6AWmsJuekh3p5tS+MkzVMzNsTquTAP
         3W5kvd3H3hNtlsSz2vHMqJL7LDHVNZFhuTf+V+e8dC9755giWHu+/lCmcnkvX/5GeJ7p
         A9YI8XxJmGMeicuiekoG3QB1HXOfs3x7wp62+b9y9l+1+oQJ+5rM8QN+y/Q2WFk+mMzm
         /EzPc9McE8m1j5jfVMvCHEIkrm420OwfkfN5WxvPQ3BlhilDgMxa3nzJ6M2NFf+NO/4S
         pnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlLEXPAyc6Yf23gKGJxdN1O2nSWmWz8A1QbLTo26vFc=;
        b=NdPXboUoSYFGM8pkavkqqDOdGzvqr/fu61uMEGuZwvQonN5UJnMmcpdB6oUbHImfiJ
         MOvBqe0Ren8K7kL253LEN5/bGMkf6h0kXQGfX1yLLFyNB7iX5OnJDSYG3+aLc7A2JhKh
         mZYm5OiYWwvmglbOF5+EGsZCjvEY2+5kS36Trnr7uTRmmcHRcYLr4i8uYgKX5uy+yMni
         1e9Whmn/iSFTmWDD9La1weiKyhOjTiNzitG1belinSB9WrOyZyGXXKWlshUjJ5viwDLg
         iXK+v7Z4MkrV7nNHyq+EIHlRATijyE/L8YFMHC35raa6mGC6V0ai8k1oubeHCgQOmBjL
         j7Dg==
X-Gm-Message-State: AO0yUKUKfHRTXbepnUOf7MsU1A29LytO233H+hqIHcl4Hd2sv/D9YgbJ
        adgXG0Kl3en1GAILLLY48iB6rA==
X-Google-Smtp-Source: AK7set+/11HaRj2WG12Q+vtk7E+WmOqsUPkGKCKykvzvbAhuh30lRW80FOyVwzc/xzcYheaQqTMrdQ==
X-Received: by 2002:a17:906:3d7:b0:930:be70:320d with SMTP id c23-20020a17090603d700b00930be70320dmr4190876eja.13.1679045112343;
        Fri, 17 Mar 2023 02:25:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906838900b00922e3221c88sm744588ejx.117.2023.03.17.02.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:25:12 -0700 (PDT)
Message-ID: <2840fe92-0c15-d476-d0ab-ec87884fcf31@linaro.org>
Date:   Fri, 17 Mar 2023 10:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vijaya Anand <sunrockers8@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230315231055.3067-1-sunrockers8@gmail.com>
 <167897628543.92626.6326219364017588458.b4-ty@kernel.org>
 <a3f7b1bf-b37a-1e42-1e43-02b82fbd895b@linaro.org>
 <1cfd50ed-f7fc-46c0-9e6b-5a35b1a9572d@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1cfd50ed-f7fc-46c0-9e6b-5a35b1a9572d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 20:45, Mark Brown wrote:
> On Thu, Mar 16, 2023 at 08:16:29PM +0100, Krzysztof Kozlowski wrote:
> 
>> There was a warning from Rob's bot. Can you drop the patch or you expect
>> follow-up?
> 
> A followup would be easiest.

Sent one.

Best regards,
Krzysztof

