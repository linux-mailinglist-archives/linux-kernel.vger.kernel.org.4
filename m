Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F79733AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjFPUfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344607AbjFPUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:35:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECB3A91
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:34:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a2661614cso1472769a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686947698; x=1689539698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPciauT2QE+r+9lPV/ArLvmRHIsbGYI6J36uwE1SK3s=;
        b=tzI76SnwGN2grvcKVqSpepKEWgKrUW1SNuotlWK9BAKuyMZ1PDa9TDwfZE2u2xxtfs
         QNg+KpErfRBMOKpDZYKTSigvSSkYad2TYtWPmTS+n17vRFIvMxxsbxKkwEefNhduBNON
         K96UOTkHsOmAN4NRScKsE8XgbMQ+USkp1wO2mbA+bGnmlThdaCxNn/KpUvAD6NArals1
         j9uPW7R8uu0roT71oeAO9vL3tUJL4dyS+Un5f9aW/Zhjc4PoJTil9NBp50dpZu/na7f+
         hRACYzqvGuPbKyWk9sDXDBWsgVe6G7a2YWGg5FE7jrbqfJtFSnHlT/Cq/pzi1ozcNbN4
         uY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686947698; x=1689539698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPciauT2QE+r+9lPV/ArLvmRHIsbGYI6J36uwE1SK3s=;
        b=AaVGl+O/QT813eYk10SndQoL9dz5zKKHOhRE4LTzPyP9cAJQOmyzwaEiXFaMO5KPdu
         aaUnv/m7gztqf05DFVrB1O1w0cuGhdaRqefRdK1Cnikgi4SpCw2A2E636nj2do4MJ6c8
         To1QGJ2eYLcKTnb08cgb0B5ZwtL6bPTvM8WoZ9jkROmkCRGa0He4+FVc8p23ArDlxE/9
         02PZ2Wq/X6eB3CNy8r8E0FdZmVwWkR1+WbL8jNS0SvPu+A28EdzQPG7Ly2qdJLAW2B5d
         EbVmp227rcMCq9b40K+QMx4vgcZn0AI5h5z5EVUYpR5ybZzZvCPgd7ICZjrMqtQaZt0V
         b5Pw==
X-Gm-Message-State: AC+VfDw/IjPVL0HyPMAiDaS0GOqCPf1or+lhGLuYoHnEq+XYHtqltC2V
        woJWExFEUr6EPi193qpFbovTJg==
X-Google-Smtp-Source: ACHHUZ6MFwaKuaowdB54DzIZdqpHn6rF59OVRLvCKB0x0gHdXUT+84yk9XF1cDFHDrxhczAJSa0gcw==
X-Received: by 2002:aa7:d459:0:b0:510:8ee2:2b05 with SMTP id q25-20020aa7d459000000b005108ee22b05mr2280600edr.38.1686947697808;
        Fri, 16 Jun 2023 13:34:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k5-20020aa7c045000000b005184a51c03fsm5758571edo.2.2023.06.16.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 13:34:57 -0700 (PDT)
Message-ID: <661800ab-c363-49f2-4889-c458a7b298c4@linaro.org>
Date:   Fri, 16 Jun 2023 22:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
Content-Language: en-US
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
 <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
 <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org>
 <CAJe_ZhfeYmxjR7Hcht0F9rc97VG2JCFEEFB+S5kUhSCmsut3Cg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJe_ZhfeYmxjR7Hcht0F9rc97VG2JCFEEFB+S5kUhSCmsut3Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 22:06, Jassi Brar wrote:
> On Fri, 16 Jun 2023 at 11:47, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/06/2023 18:23, Jassi Brar wrote:
>>> On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
>>>>> From: Jassi Brar <jaswinder.singh@linaro.org>
>>>>>
>>>>> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
>>>>> Specify bindings for the platform and boards based on that.
>>>>
>>>> A nit, subject: drop second/last, redundant "bindings". The
>>>> "dt-bindings" prefix is already stating that these are bindings.
>>>>
>>> I can remove it, but I see many mentions like "Fix bindings for"  "Add
>>> binding for" etc in the subject line.
>>
>> Can we fix them as well?
>>
> ??

What else I can say to such argument?

> 
> 
>>>
>>>>
>>>> Binding without it's user is usually useless. Where is the user?
>>>>
>>> It is required for SystemReady-2.0 certification.
>>
>> For what? If there is no user, it is not required for SR. We don't
>> document compatibles for something which does not exist in the projects.
>>
> The dts/dtsi for synquacer will be added later.
> I am sure you are aware that there are countless bindings without
> actual use in any dts/dtsi.

Bindings without user (so no DTSI and no driver)? Just few, not countless.

> When exactly did it become mandatory to
> have dts/dtsi for the bindings to be merged upstream?

It was always. We do not want/need to document downstream stuff or
anything  just because it is somewhere there.

Best regards,
Krzysztof

