Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB96BE4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCQI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCQI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:59:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C33E359A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:58:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so17649262edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFTOCKd9YghODhm9k4BYSdRMAj9VqWPQ6/g4To8HAmg=;
        b=PEQUTBW00Q+bfC5naqVxYnm+fRau4EKZs5B29/rEwMT2+J1de1jINVzNreHp85gOEG
         R41z9yfWpnHDzIovAUSV3pnRNIZCUQITaEEakZ4QyZgQG4XdlxTCRhyz61PFTw4N0XFX
         pp6xfDgTtB63NomYOgd7JV6pBX9jG7CLVBYW/ashqpRF2NYj0fiZOtmrovCaGLugl2OH
         yu94pfHHrGFXU2D4DCDWPof/kg88ylBRWpg3apnHvuwAnYS5+yZvDxtwC2YZHidPmPIA
         sEwLHRZTFbCozxQ+bmpLGg+9exr0TbXgv4vRlzePypYWtRSv7PEz4ecmaT2GOd2cvuCr
         TMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFTOCKd9YghODhm9k4BYSdRMAj9VqWPQ6/g4To8HAmg=;
        b=UiZeyVKPuINVCVq4bcDEnOsJ1IOWENo/XeLIjwX8e+w+hlZ17GYhGSLBL+CGPrQen3
         BwC5hlVPlJ7BB31pWDTSdtkLN41i185xf8kYsSJfMEujnBALRo9y3xkL0EQSWIVYwbWS
         b4O8bv4mkpphwpPDdrj5VKdwrZmZj+K99ql3niaXEg8aMweYfrpo7hsSZx65ccvsENLT
         bgkpPzXkyanW8obGNdHVlRfz8Y328u74yEpLri0fKgfec9Ea8rgXt9Fl97plsAN3JNYA
         p0i6KhHFPy5cPysYtgvnd5eg4ZXKjf/e2qODBi1yhvmM56B+5NTOWHO0413CIoXYKlQ+
         Sfeg==
X-Gm-Message-State: AO0yUKWduBT1BilNopcCkkb91gkTIzzVb0BDy15LhLi5f+vDA1lxbvyv
        G+1M9HdTDt+yvl0+2AlYkkCmtA==
X-Google-Smtp-Source: AK7set/0+buflC78R3Q4lgaLGPP2/vw/ORXPdBawsURaWStTeYkFM3YQY1x8gev1bA7uz74wqq20gw==
X-Received: by 2002:a17:907:7fab:b0:931:d350:9aef with SMTP id qk43-20020a1709077fab00b00931d3509aefmr2036086ejc.25.1679043495242;
        Fri, 17 Mar 2023 01:58:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id lg10-20020a170906f88a00b008cc920469b5sm738745ejb.18.2023.03.17.01.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:58:14 -0700 (PDT)
Message-ID: <1d1069ab-cf02-3e1b-a8c1-b0fb8170addd@linaro.org>
Date:   Fri, 17 Mar 2023 09:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 7/7] MAINTAINERS: Add the Lantiq PEF2256 ASoC codec
 entry
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-8-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316122741.577663-8-herve.codina@bootlin.com>
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

On 16/03/2023 13:27, Herve Codina wrote:
> After contributing the codec, add myself as the maintainer for the
> Lantiq PEF2256 codec.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b258498aa8ac..81c17580b402 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11651,6 +11651,13 @@ S:	Maintained
>  F:	arch/mips/lantiq
>  F:	drivers/soc/lantiq
>  
> +LANTIQ PEF2256 ASoC CODEC
> +M:	Herve Codina <herve.codina@bootlin.com>
> +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> +F:	sound/soc/codecs/pef2256-codec.c

I don't think there is need for two entries at all. For all such more
complex devices we keep one entry, this should not be special. Look at
Maxim PMICs/MFD for example.

Best regards,
Krzysztof

