Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BB263BB38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiK2IGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiK2IGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:06:11 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E1D55AB1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:06:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so21306094lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GSugCUNGHr6tmYLKdbLwAdeRDBnPgBPpR26Z91iKD8=;
        b=sDY9f10gtattqz1560Cicxf+5Vis827cD5ohKsbuC9GZlIq2MqhZenQgEqu6NWQo1V
         9uZcuJQccFiMwzKg+291wztSUA9pVZskrJcNPQ0HPQhAcpgcKlygWj2jz5EuCqvVNs1i
         RnK5bBdyxrDJiXDAC/wK8kGUEzRH+fy5K4TCyvCzTvTKVMnOP/x0fGY6bA4AiOf2LArM
         QJOaqX/COg+oj2ZjJXSIxPEvMv7l40SgHzGvXc3ARR9JUCfl91mHoKhc95UlZt08DNew
         4guWj+/qVFtFXErzm2chFMdS6xrfKaYB9q6xzW0NLkFby48nrd/sJgZg0fqlDdeYLxht
         C2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GSugCUNGHr6tmYLKdbLwAdeRDBnPgBPpR26Z91iKD8=;
        b=eGj0k4EV4gybIMVy7VcjtuDat8Vk+e0U1G3d/TpcMcOVIQikxXzlxQGPuF6TJu2KsU
         +/GkrFFIk9K475zdjwmXkW/Fk+ICMgcBlnAiz5WKKeTAoPHrIPpTHAzaNzbe8/9gOwJd
         jHyekTdAOKFB7iJksPOJiABnhJV8A4N4p8dwLRhC3Wh4jV9Xkoh4g/Jz4Zl8VjZQXt3r
         uc52t2qKjouhvXo3YWq2beVcIRr9o3CbyRhQJhPBPcU7E2Eb8jlkYNIcsbIdyBfUP6Z7
         XHCJGeX74I++Reob5yqCraSo07HGU8c2sPaBK2bpKEiSToDojDTJ7VbOiHEVhoyOrogZ
         siVQ==
X-Gm-Message-State: ANoB5pnvgxd9SneSNk5KQd7TCqTrzVBZUrICp5fNxUPx7fjyh319IKvp
        Ekt/JHZra3NrkERiQUleeHrLVA==
X-Google-Smtp-Source: AA0mqf554aukKzm3YGdL1YAt6FHEeI5egYWDP5LF/4PEHprTx4xFrZjxZGhffCfauJJw0D/V8qgSvg==
X-Received: by 2002:ac2:5f65:0:b0:4aa:1754:9ae3 with SMTP id c5-20020ac25f65000000b004aa17549ae3mr12123084lfc.344.1669709168411;
        Tue, 29 Nov 2022 00:06:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g16-20020a2eb5d0000000b0025ebaef9570sm1445213ljn.40.2022.11.29.00.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:06:08 -0800 (PST)
Message-ID: <657e7d50-7352-1a4f-6977-cf1d9c6e6c8e@linaro.org>
Date:   Tue, 29 Nov 2022 09:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in
 example (missing reg property)
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
 <20221128214928.3531463-3-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128214928.3531463-3-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 22:49, Jonathan Neuschäfer wrote:
> I forgot to add a "reg = <0>;" property to the flash@0 node while
> writing the example. Fix this.

Don't be personal in commit messages. Instead:
   Add missing "reg = <0>;" property to the flash@0 node in the example.

which has the same amount of information and is even shorter.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> 
> Fixes: dd71cd4dd6c9b ("spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU) bindings")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>


Best regards,
Krzysztof

