Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA06BE58E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCQJ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjCQJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:27:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2213BCBA7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:27:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so17740632edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679045242;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vpwcPBpvj9pishkPLLrcgxPr2/RjOuXIj7XCYaMKNA=;
        b=AL0npIf713GInE0x+HCfSfiAErIUh+5J2yvd3OPKKOZgFVAnd1Gabp2rdpKnSbVZj4
         B8Rd9dh1JliM8dS0j4N7GN5BjeYhtGkvrwAb0DP9boUMKUUBrDP/y1T2KhoiaGV2k972
         EtmcC4MUxNIGTq+iLftWKpI/5GTX4JMi7/EP+cJa3K5HnUq5B26q5VTxdvoVDd+QS/mD
         rM2O3O5I6yMDwMbhA9oQRA2aKuWdSdlh5dgMh9W19FjNQIs+COBTGbmY81TH+WU7mGRg
         wzrD1gxfOBCO+p/7zRt3Lo13eq+nRLmoOny5FLlHqhWzKn0gIgjZGqgvh1VxprP4t3aX
         C3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045242;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vpwcPBpvj9pishkPLLrcgxPr2/RjOuXIj7XCYaMKNA=;
        b=xhx3TbrVR9JBgmixLig7xbpLup+NCaBfJgIq+x2T8Y6eQjESUHOJV6T//ix3yzKukm
         8BgWuMonhBAT7SwZJLK1+Py+krFLonEeiS3L5bV7UXtBqZiksSK7wuHegzusfHzmX2FR
         qKVoSBDhiRJwSrNNWXXbA0ZMOd6g5qx1q81P9lgBvTPnwfyZpt7ui4/jsV2t6Tb3PUGk
         kakbw7mXDn1WOdG7ABMTjGGhUsHVHPEJLf3qTEiTjkxyQF7rRAODsBFwCl91Y6O7xJ+e
         WmZJa2CPpWox+D60bqUz2m+32WVpN+6kglCAq09CSDs1QBLWLjX7w1H7Wc2BsXF6aIfx
         iEsA==
X-Gm-Message-State: AO0yUKUhJnvtTKhEE4vNgKUx2ucuspy5BU2/AFrpTlVNhIA7xWrp35C7
        mBqs75x6kkQmHwObN7akYDUXDA==
X-Google-Smtp-Source: AK7set/nMbiF7GOlcn9PyjlA2lZijSx/2JZto82YrGSxJKdzBet8Ky/XFm0gwi0lrNol3+2x+TadhQ==
X-Received: by 2002:a17:906:b844:b0:931:ce20:db8e with SMTP id ga4-20020a170906b84400b00931ce20db8emr1719938ejb.51.1679045241043;
        Fri, 17 Mar 2023 02:27:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906199600b008b1797b77b2sm731814ejd.221.2023.03.17.02.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:27:20 -0700 (PDT)
Message-ID: <1f62677c-158d-967b-7ccb-99594e631ce8@linaro.org>
Date:   Fri, 17 Mar 2023 10:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: adi,adau17x1: fix indentaion and
 example
Content-Language: en-US
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316191918.266312-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316191918.266312-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 20:19, Krzysztof Kozlowski wrote:
> Fix errors in binding indentation and example:
> 
>   adi,adau17x1.yaml:8:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
>   adi,adau17x1.example.dts:29.3-30.1 syntax error

Typo in subject. I'll send a v2.



Best regards,
Krzysztof

