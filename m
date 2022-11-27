Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD40639C7A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0TE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK0TEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:04:55 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E0B4B5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:04:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so14332393lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSIeRqCbzyf/y2fQun/f85Q7BpRlPK6IXHSeI6orCH0=;
        b=Vm3yjCyHreD/68qF5D5PUpTSsktB5HZmGwApX+tuHnnfMA2T869r11E8aJuP9haU8h
         qr6NSrdxBW5KEa3/V/hWk83XPT0Wt8q2MuAdSYh3dXdI3qq4XDOtOw0gVPj3ujQCjrEZ
         drKAWB4jdxr+uwfsFPyuvJAtgJ4YjNF4RSzRvNTUtBNpZpVML/vpamcPJY1RbMAFEC+N
         toqv/vVr2NBXA/ksmW4J8k4gDbV3vfuUgwwYk+f7kv6Me7XoYYZEf5S1U5KfriRXKBYM
         e4TcNQl16FOW0vzOjlkmx1Jy5GbS6lICszkGBGOKG/05T+XZSjuWi4a/4KhsJizeWn+L
         aBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSIeRqCbzyf/y2fQun/f85Q7BpRlPK6IXHSeI6orCH0=;
        b=Nynn2gQrLYH6GeHft90p3Pige3gq7j/Gol+yXMfclhDAVz2muFcNCnk7u69wYSvsok
         HGNY/o3vu1Q+Nf4KCOSF1OGmaFXcPb/Cvhe/s1UXfQ4/8LP1orXrlg0/SbMgcrQCEt5O
         KbMTtpWcLs5Ll3tSytxqoXzmyxx+gLSl/9i5mvokcyyZxLYJhbWjAz58u0THCiEHMFUi
         YJTtW6ZazuzXdAQwWvDKr8fR6JrvbYGggEgnWQ6aLk+RM/RCqPkzHDEe5KmJWmeDK1c9
         L5vbwGDAJ/41izMpw/D6gzZHt2Xf//ZBlVpHxLKvV5AFxntlimMQn/VleuqUgBx8LXDj
         l5Zw==
X-Gm-Message-State: ANoB5plVCrnIlAmbMgcGteUBVzeOpObTUZJCKMgjiU9vSrxaiP79l7Zy
        SVV9sfnbyjkkTaacpVlcbXXi1Q==
X-Google-Smtp-Source: AA0mqf5Qo0z6DWqG8/3SC5wSUGVwRmwyWss7qG8WAGkblLMK6haRQRLwh2LhjArCieLThPOfedV9FA==
X-Received: by 2002:ac2:54a8:0:b0:494:7541:9dee with SMTP id w8-20020ac254a8000000b0049475419deemr14954331lfk.680.1669575892377;
        Sun, 27 Nov 2022 11:04:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u25-20020ac25199000000b00494a8fecacesm1365866lfi.192.2022.11.27.11.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 11:04:52 -0800 (PST)
Message-ID: <84eccdb4-f415-15f4-991c-f4c7f2d77388@linaro.org>
Date:   Sun, 27 Nov 2022 20:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8250-lenovo-j716f: Enable
 ADSP/CDSP/SLPI
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221127170858.440040-1-davidwronek@gmail.com>
 <20221127170858.440040-4-davidwronek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127170858.440040-4-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 18:08, David Wronek wrote:
> Enabled the ADSP, CDSP and SLPI remoteprocs with a simple "okay".

s/Enabled/Enable/

> Firmware needs to be provided by the Linux distribution, as it's signed
> and needs to come from stock Android.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---

You just added the DTS, so this should be squashed with previous patch.
Why adding incomplete DTS just to fix it up/extend immediately?

Best regards,
Krzysztof

