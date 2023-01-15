Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07166B1CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAOPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjAOPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:03:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31183D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:03:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id az20so43596077ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8Y0CWmx9pYLYLFHVHz0kb3QWfE3QG43dwg2EVd0xlo=;
        b=B5YxFiRJIsTEWzPd0ZTbV2pXmodWqiMIQ9KGvEH9RI17fOY3c/sA7+pRdyiKlqInWQ
         1ObUB+eBe/lGyRlDoxzP32sFGqoRY9xz+xMMjs3pW4PyIi4pRH97BCpLX3aT8MxNrfvx
         vSLgWoL+FUNxAUyBtbc79kyA17vSw/Upe0w7DjtHQkSpKGYOE29svc7ZoChQU57XJO4A
         rLJQ98vIzuz2Pj6xkP/JQIXCG9HBvAImKP3MBAD+OWgHPlUSgV3h6lcz85udUKhpgyrZ
         D7P8jZQQPpDebiF90i2ah61VnT1UZcdDkJOZH/jC7ZA59kXqWe+wxPiRqm3ijeXRlbTt
         bmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Y0CWmx9pYLYLFHVHz0kb3QWfE3QG43dwg2EVd0xlo=;
        b=ucRJNfaiySJ4yYCJZMUjRhaYWCu7XXK5ccbE59d+abVBteUAxIUmEBhE53lJRAWEkS
         JjxkcJ9iah2rWXBQesyNJpJ0C041zY6Ut7Va2loakYQLLT+KBDB68hop39QG1qiGfLzF
         gB1EoJaB4EawEKbnZxayIo4yz6UFfgzKOD3fbeSDPQVRmufcvN25Mq5Y40UEw9zJ+Tfv
         0X9CnFu3OqK6DJnwpNtXSl3uLTrY2oEPXwi4RzzpTi8n2j3kqdMW6Y4LHtmYHdB1EKhJ
         0Qupzbbl07qy0TPJUqmOTNYzoenBANqlIHFcEtZUBqjRH13NDSEF0l0OWCAMTwe7ZGZG
         5s6Q==
X-Gm-Message-State: AFqh2kpJkdOyVjFfPd+Nf+8kFTVgsdsbKiYRAU04SbxPXTEUudbmtV3I
        4MV1CG624SK6OuHF4VHDCtkSdA==
X-Google-Smtp-Source: AMrXdXur5srQnbH6d5PiLlzh3ia+za/Byv1Rojs4GeErYa2lh8pfGuIpTVhphf0I3nAyRehxjhIgbA==
X-Received: by 2002:a17:907:c58c:b0:82c:3642:79b5 with SMTP id tr12-20020a170907c58c00b0082c364279b5mr75676376ejc.58.1673795007740;
        Sun, 15 Jan 2023 07:03:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709062a4b00b0073022b796a7sm10926754eje.93.2023.01.15.07.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 07:03:27 -0800 (PST)
Message-ID: <e5cd9794-d8ce-7285-5da2-7f3b6bf8dc2a@linaro.org>
Date:   Sun, 15 Jan 2023 16:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/5] ASoC: samsung: i2s: add support for FSD I2S
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
 <CGME20230113121821epcas5p4ebd116d75f12dafeb09391eb6f7a2646@epcas5p4.samsung.com>
 <20230113121749.4657-3-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113121749.4657-3-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 13:17, Padmanabhan Rajanbabu wrote:
> Add support for enabling I2S controller on FSD platform.
> 
> FSD I2S controller is based on Exynos7 I2S controller, supporting
> 2CH playback/capture in I2S mode and 7.1CH playback/capture in TDM
> mode.
> 
> Reported-by: kernel test robot <lkp@intel.com>

Drop. It's for the bugs. Just be sure that the code compiles without W=1
warnings.


> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  sound/soc/samsung/i2s-regs.h |  1 +
>  sound/soc/samsung/i2s.c      | 53 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
Best regards,
Krzysztof

