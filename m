Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464D36B397E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCJJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:01:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5E6F2F8C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:56:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so17637095edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678438585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTc8WfUJS5pE+gJh6hkTmvwpoZgYTgQwLH01UiXhOZg=;
        b=ViN+S4WXuglyR2uBtr+EvRXEI4vCdxTY/d41nwNFME843reyuLNTFuMZIg25I8vuss
         2ICKGF2ls/FrxbadwSh6U3CntGAGTKlBr69PXXsKsHOErXkyX2DAfGcbYohKvGMefCj4
         DpHgT3pGrHiEaNz/cdWfD2DhKVnTurrzJTUhEWty3kLtbWAC5nG3juAH1kUXR0+iq0MO
         Fuij61l9E2zJRK/3AQBh/i41ghpBmuMFs5igmHiij6ZP8VA50sfIqeivDUkiOi9bAeN3
         V/EPm5gktCSIxNbbfKeRATxF7vWzy/nQoOhY8JaayR14VSuXnroe6u0cByFMBLM4CK6P
         UQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTc8WfUJS5pE+gJh6hkTmvwpoZgYTgQwLH01UiXhOZg=;
        b=6RLs6lzDnvrjVstyxSjfBMFD42Od0IKVDHNkeWvLGvsswS7W7BMQ00vbsTCVbnE6ZX
         pi+8wYp120sqAkHqo+Xwp/kYUvR01HCgt8qLIamxgXXuBr9bLgCbtVc04TUraMrk0ZR2
         IfTXKKi4aJT5+oqwtGSkq3/0dhNYbc97eHXMr6VVKv/FPhPRUyMZKV/gtEz8PXMqbqIt
         eiQgQ6xjoKgTyyHwETcuLjD2isWct7R0U2UJ30FONTbvm96K6o7RRH+FA+UAjoRhXkup
         90E6OY8u8p/YFykE2/kGFJm5I71SBhrWRM2R2QAgAKmHcmm2Wu1GrhGLX2lPj4E3fPHL
         l7JQ==
X-Gm-Message-State: AO0yUKXyU/hQVcxsTKFeei+joirRtcDs6AQoXSC6W54posXM4Y1GrwbA
        tySomX4UQDFBcHGDvGVRger8rw==
X-Google-Smtp-Source: AK7set8oQbEa7aHmhTfe/KFEnNmpgd8Cm09atyHmqtwJySaJhkBT/4gR8InAUbnJ3CyZitaM9+lRkw==
X-Received: by 2002:a17:906:cccf:b0:8ae:f73e:233f with SMTP id ot15-20020a170906cccf00b008aef73e233fmr25072593ejb.32.1678438584872;
        Fri, 10 Mar 2023 00:56:24 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id bh11-20020a170906a0cb00b008d02b6f3f41sm685790ejb.211.2023.03.10.00.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:56:24 -0800 (PST)
Message-ID: <87f20b22-6305-7590-1dbf-014b5898b15c@linaro.org>
Date:   Fri, 10 Mar 2023 09:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 21/28] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-22-quic_wcheng@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308235751.495-22-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 00:57, Wesley Cheng wrote:
> Add an example on enabling of USB offload for the Q6DSP.  The routing can
> be done by the mixer, which can pass the multimedia stream to the USB
> backend.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

You still miss binding change to APR/GPR. Where is the USB DAI going to sit?



Best regards,
Krzysztof

