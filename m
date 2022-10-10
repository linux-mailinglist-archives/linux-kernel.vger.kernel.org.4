Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633365F9CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiJJKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiJJKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:38:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4CB5D0D9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:38:03 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c23so2211037qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLRVHcDP2n3/T7u+DLZw38Iwf+Q2v9rJvcCuBMIDabA=;
        b=f9Qda9xTp4bHsuGvwL9zsZmqtYzvNGczwpochsMYKN3ONXezZwSJ3YBDB1VbOmjW2B
         aejJft8F7FPKDb/VxlIFFbkOuVyuzmLX330Vc8PC+H63qEFrJjJlgS7/6e8OKi5SQEni
         i8+4ffqImNiBniTGY/3rvcR5xM2qiwznx2iWsFBnglSfYJuQRJ8yx4tsfMC0RkPegeYm
         nf4KTKgkICkyouSEPp3x1Y2et13uPQxHGC4MkEryS2mvqFljHMKIvbOq+StNnK4Beu+D
         txstZNziYEBdJDhrRX4VB0oDpDzDvlidT3NgG2jFcXPgsOhCJP4x1JE3/DsZgIfRRH0d
         nv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLRVHcDP2n3/T7u+DLZw38Iwf+Q2v9rJvcCuBMIDabA=;
        b=SCQ4NmDH6+e1PnsXf+O26zpL6bpPCccEYBkpNcxM0jQSLdgynhL2/yqcHRffNH34SP
         MOyXG02fjQV8Nd4HFuRJUxOuTYOKrWPZEABMmoaQfxKxrIbsiYNix8nr12W/7FefvcDE
         uGZsprvxi6HZzkUDqQkjG1mPt9nPiisH+fi/GlbZ5CQkhB5W/1nrddIYLR/IIi6Ku3ji
         7HF+hGOOc8In+uCjkBfRIPutx0XeFCMbsW2DvgLncwV6w/lt6va0KSKy1CQd2aj6k8Pp
         nmiDlBu4yO7s4mn041qDT489Pc1+Fr0cKyTUXYd6BghSNvG+y/kJvet7c2zRLsEGo9EV
         +c9Q==
X-Gm-Message-State: ACrzQf3iMMcCDN8LSJrE0x8lLK5sTtd5zWU4R6pwIgqya+6oRABfWG3i
        UNKgS/I9YA5YDH8u4Lvzv4Ggmw==
X-Google-Smtp-Source: AMsMyM7qDRzB5OaEeCZNoAzPYyh1IDm+Q8NlP4KpMd6imNLo7nGADIy0b581X8htTnLSKFNiWf9GcA==
X-Received: by 2002:a05:622a:1a1b:b0:39a:f20d:b277 with SMTP id f27-20020a05622a1a1b00b0039af20db277mr1326519qtb.204.1665398282927;
        Mon, 10 Oct 2022 03:38:02 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006e2a1999263sm9777314qkp.62.2022.10.10.03.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:38:02 -0700 (PDT)
Message-ID: <756def2a-f1b0-2900-61e6-f2cfe4c69e85@linaro.org>
Date:   Mon, 10 Oct 2022 06:35:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-binding: mmc: fsl-imx-esdhc: update i.MX8DXL
 compatible
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20221010101138.295332-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010101138.295332-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 06:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8DXL is compatible with i.MX8QXP, so update binding doc.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

