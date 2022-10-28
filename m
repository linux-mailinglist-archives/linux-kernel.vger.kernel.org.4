Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2161079F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiJ1CGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiJ1CGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:06:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616259729
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:06:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l28so2734378qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1LMLjq5zpfIikLtv+miyJRP8UZATL8cTTo41bIU76g=;
        b=lH2F9fMGOBO7pc9d2vdcuEK19wvkTVdrsrj78FtX8hzwFEzXpDpJ5jzGrSOJFLMIHk
         Met1S0879lRdxrRo76LzKGeYmxvH+VOOLokQ0pxNqgDaw3u/j/aRGLboIxbf2KAzedkk
         th7y6QGpuKBKe3Hku5QoTBIemJorNktf1HTscs7lfyFWnsktePPxS8SSmHBHQuUo8m4t
         2xGERDBg0OMY5RbW410viCwicg4/GB+mG06R+8gixowT5bfwFh10dxAoLjc3CtCpjYTW
         v1t1j7zBlkAgXACVj9P8NcKKLzZQzmYFSYjxnW7MLXiwe2CMOBHcOGcYQ2ALfWGTQ8kG
         v/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1LMLjq5zpfIikLtv+miyJRP8UZATL8cTTo41bIU76g=;
        b=MJuk2qkxGz4eO+DNEwQZafe2OYMiVDkUrzFGg1015rvuWVE+4W77G1BZm4C1eiXSmm
         q8/qGjUjzErOe2hNaum4yvYpzuPloRChJ4fLkkAZWHwE+1ySVJampYGTcPSw+LCPdRAy
         udxy3fmXB3xOZf2srk68Mb6qcla+vJH52zFrCeKfUzu/XvBuoEXGXFiB29NPf7J9GgxD
         ceIiAS0AVKOEhBvXmdI8P1sC7xM4wqca1y9SQT3gis6jrKhW+0LPn2/PtkDRau1JZYFp
         dOLUAcL3Aocrk/4oZ9xvu7EjkkM8ikeZM47YcES+9BIXv0GuPX8OegtHzfdo/b0feJxV
         YtFw==
X-Gm-Message-State: ACrzQf0CurEawrb3U2nbDYcGExoV7INUn8p0DYdF0iYv98pK2JitCBrg
        LSwTtopH6/kDPABxfLUVgdATLQ==
X-Google-Smtp-Source: AMsMyM4+JeXMGKJpNzhYtik1KMxwYxLCVnhkikb9ZUBnzm5aaGM9Cn7gp+7FSY+I73K5aQwb6iIguw==
X-Received: by 2002:ac8:7c46:0:b0:39c:fa92:a27a with SMTP id o6-20020ac87c46000000b0039cfa92a27amr42324109qtv.61.1666922776986;
        Thu, 27 Oct 2022 19:06:16 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g23-20020ac84b77000000b003a4efd59754sm1741747qts.12.2022.10.27.19.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 19:06:16 -0700 (PDT)
Message-ID: <2c3ac59f-fc9e-a1eb-3778-a553ee833de2@linaro.org>
Date:   Thu, 27 Oct 2022 22:06:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 00/33] crypto: rockchip: permit to pass self-tests
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Corentin LABBE <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     ardb@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20220927075511.3147847-1-clabbe@baylibre.com>
 <Y1jkqiYjXT30/hk5@Red> <Y1kGdWyYPtcgQPtd@gondor.apana.org.au>
 <6031281.lOV4Wx5bFT@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6031281.lOV4Wx5bFT@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 06:25, Heiko Stübner wrote:
> Hi Herbert,
> 
> Am Mittwoch, 26. Oktober 2022, 12:05:41 CEST schrieb Herbert Xu:
>> On Wed, Oct 26, 2022 at 09:41:30AM +0200, Corentin LABBE wrote:
>>>
>>> Herbert any thought ?
>>
>> Please let me know exactly which patches you want me to apply.
> 
> it would be great if you could apply:
> - patches 01 - 25
> - patches 29 - 33
> 
> They all start with either
> 	"crypto: rockchip: ..."
> or
> 	"dt-bindings: crypto: ..."

The series probably should be split in such case (with links to lore),
otherwise it creates impression of some dependencies. Bindings are in
the middle, DTS as well (which is usually sign of ABI break).

The clk change at the end also does not help.

Best regards,
Krzysztof

