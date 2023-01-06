Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6E6600B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjAFM5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjAFM5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:57:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3696B5AC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:57:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1015993wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufSJYBQhGfsDMvO377pVzeNLv8JrRQG7OTGAmU+wVLc=;
        b=fxX01V6YJweelJSsPJ23+Sd4GGhzhcAyUEl/fWgeu4/XTzaRBmtx4aEm/Xt/Ivn9/v
         RAMsRQaKTuCBGYL6RDnpL19FuM3TReJueikpED2KEDeFcF+yLjc9uJV8RkKDyJVHKW96
         t55ZFZLMtqa3d68/WxdiZbg7ubyR+cN1DnjwTopiMP0llK1lR96vo1AcVHVkhkDXmyX5
         cBVN0hESBqpDAvrAAlXvw4VFFklib5OhO4CVI3p9MxZqd8unbNWpoXaVScGuGXtXIQSZ
         +v+V7YDAHgkFPEWpZic8GAxeNsWwYsgcYWaW25x98N42X3Oy5EumCInpV2/E/bBshpiV
         5w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufSJYBQhGfsDMvO377pVzeNLv8JrRQG7OTGAmU+wVLc=;
        b=YB5aLRRhNF4uQVRm/QfzEklkOCNGKZQM/Kjao/UxUoVZXw0/4boVaLUa2QngPFG3Xe
         q8AsInIPJ7K6IIPuqw93gRgfbTBNoWRqMoXiElln+3Nhjd8/KDFea46IbuRCTXqSyJLO
         ey6TOg9hbqKTJDJ63TopPmMx24c54IF+wc/X+9eoIGJIlhCYF7pqeRKiU5MYgEQsazh2
         oLpYSDeLk7lScNVrKLPKlCHD1AtihigSbFwfaBrujLYV6nc5qaitTyEbKuZBvuTO3n0w
         GGIS7bPNrk0mQzry2Mcah2/oQqB8fB4C69Rrb96/07bFFkJ7lK3BPXAkYSZDzOhnN/Si
         zcCg==
X-Gm-Message-State: AFqh2kolN2pfrTotFmK+aI3cIQ8/rXh2RXXzaiMMQ6fECTsTUfilB8su
        gGN1eNQUeTfITDeBZXO9pAhMnw==
X-Google-Smtp-Source: AMrXdXuw22TUaCDDMxorSHYV+C20RsO6yhRjaldmpu2vZvzk3tJ4OgDv2uKJ1EyszQmURFXeFZOplA==
X-Received: by 2002:a7b:cb56:0:b0:3d2:3be4:2d9a with SMTP id v22-20020a7bcb56000000b003d23be42d9amr39230310wmj.20.1673009848004;
        Fri, 06 Jan 2023 04:57:28 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c434a00b003d1e34bcbb2sm1502665wme.13.2023.01.06.04.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:57:27 -0800 (PST)
Message-ID: <16817b38-6638-ea2d-d170-02e8af276f0f@linaro.org>
Date:   Fri, 6 Jan 2023 13:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: zynq: Use recommended dma-controller name instead of
 dmac
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <5637d7e3464fbc1b2b269a7df35e24edc2c8d4ac.1672908080.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5637d7e3464fbc1b2b269a7df35e24edc2c8d4ac.1672908080.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 09:41, Michal Simek wrote:
> Use standard name for dma controller. Issue is reported by dtbs_check as
> dmac@f8003000: $nodename:0: 'dmac@f8003000' does not match
> '^dma-controller(@.*)?$'
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

