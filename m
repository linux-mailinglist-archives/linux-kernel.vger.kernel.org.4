Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B4696203
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBNLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjBNLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:09:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16A26864
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:08:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so15227510wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btXThSxDFxZK9yFheQHZKpa+pCpJcFcWX1GnJ4GQw+k=;
        b=JKyWYWzBJL9pQeyyRqgPthcu2rIWKxUZ9ZXnDLc2B/pB+jL620ziki+w5ko01loJ8f
         q2eyEVTfFY0AjXAJSBX6d7y+p6D4Zy6E72Pg9WzJMlSgiWfshFlwo3skNCp3XtsDSRks
         Zth0TRKglfsuo6R0sBpIVu1KeWwZFQk0avAkggs1Blx3vs1VD9qLutghzarZDiohe69R
         dJavde3UqqsVkM6jI4f/Gk+UTCXAerU8kvfpmhnxhjKBQHbJB391X4NlUZjlTcW+m1JY
         VIpCb0kHgIrUx18lVsUN+31+F3zHndbSQtgtw59LBOQnUaCi4jBQB27hJ0FlKA1O1l91
         FGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btXThSxDFxZK9yFheQHZKpa+pCpJcFcWX1GnJ4GQw+k=;
        b=c5abaDvI+TBXErLql4rbopSBIJoAbpmTF1f6fT2vl035BOl7l9ICv8Qt+6o+pI3gA/
         5cYhczXyZV96Ir4xuXL0GKSVXOp0pYd+TGWktwQt4dhyKaMWn3AJTygTSZjo4xyVVwsn
         Y5IMW0droNemh72oowd/v5Z1MZyCe3PQNK5CWjC97YmlQUvhfON/UXa2/kUIorWBJtJw
         GjTEcZjMcWbtypyK/HRibXviQliBAf+5gy/fN0N44poz96cgV3waW7HgYnqsDQLBXJ0b
         NlWtUDeTm92lWnbsvX+/GGMvADT0yTBvDwEJafMeTxpXgYRc7kZ/GaRW5OsVpouh4nLc
         vuWg==
X-Gm-Message-State: AO0yUKU6/IjZb45/5Cvq7djyNZzVEgcmbl68tl6jKNV6hy4cieATrQgA
        CBDaqRHNtGN8I0WNGrIDIobptQ==
X-Google-Smtp-Source: AK7set9Flrtt+XFps8pHOQt7IAszrGHKBKA/eyzXv+xEkmn51U8fwjreLJtis/4+r9SCriQGjYHn6w==
X-Received: by 2002:a5d:5386:0:b0:2c5:5eab:8a8d with SMTP id d6-20020a5d5386000000b002c55eab8a8dmr1735421wrv.8.1676372865366;
        Tue, 14 Feb 2023 03:07:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d6984000000b002c552c6c8c2sm7212868wru.87.2023.02.14.03.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:07:44 -0800 (PST)
Message-ID: <44be1b40-400a-0e4f-fd68-0acd43b50618@linaro.org>
Date:   Tue, 14 Feb 2023 12:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 12/16] dt-bindings: clock: apple,nco: Add t8112-nco
 compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-12-22926a283d92@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v2-12-22926a283d92@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:03, Janne Grunau wrote:
> The block found on Apple's M2 SoC is compatible with the existing driver
> so add its per-SoC compatible.
> 
> Acked-by: Martin Povišer <povik+lin@cutebit.org>
> Signed-off-by: Janne Grunau <j@jannau.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

