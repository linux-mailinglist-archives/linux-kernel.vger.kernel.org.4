Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F06F08BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjD0Pu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjD0Pux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:50:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0411B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:50:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f40b891420so8401520f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682610650; x=1685202650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0LVvSUlMhk0oorFb1lfoTKLtwX4+aMi4E0n5BABoD+k=;
        b=c+SKHywJEzds0l0pCyhmpRVHw64XbWWZYodFHkJRBH9RftRm1ltEbKtJ0Q1eniFQbm
         E5a9EdzdDvymLqawIOGGmnHOOkdqlyiTBzCFvhJEQTomPojd3SgbhNGBO7CadSusMYwE
         CYpevFGcVrzmX6yFlmgbOKjcxU0o+BrtRpEnITb+8SdYCGgPYVKe3sIolQRv2OUHcL04
         G4mzF20cNfZuI3Xi9syc9UAUzbF3qMD+lhKMKqhhpJRGSrDDEblFUuxufcCiOwO/f8B2
         OTmTFyXOrNAkYtKKx36L6RGpqQL1lNR00jd/JBPIMyJ7dlg3G4JVT07MOV8lFqxLS6Hm
         ASpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610650; x=1685202650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LVvSUlMhk0oorFb1lfoTKLtwX4+aMi4E0n5BABoD+k=;
        b=d9FSPFU17PY9J94bkW7+dZ7scMvlWPwQeMor1MTsaS4snp28wKbFwzUFjWMX8LrFo1
         SZ/1G9w6afUskP8t3/a7V7j8b9oIwgHVVMdPs8FTIfMRj0kfnU8IWpMeCp01Gu9uhXfW
         bEzGPr+/IJQGZ2W2fWKcejtmfG52YJXHa3eR6iNDm9c9xY2RjsZ6aEv5fx2P3coR2G8I
         DT1KMOcxhwZKiVCcmLTLqNPLFoZPGr+wvMRRbNeyGmalpNbe2QztHDzdk8bpXtA1KW/0
         MV0soqeGNdsr0MDcOJljkyyAUfnjqlbYzx0E3ErEa/cViGLAkqxteDwPae+r9wok2Dsu
         i2vQ==
X-Gm-Message-State: AC+VfDwUh+yjVttJ6iGBYxAKwzmRsm3BzyuRp1bQmdM7X9x6YPaumNjq
        gnuKzDn5QzZ0V8qnnswdMPj+hQ==
X-Google-Smtp-Source: ACHHUZ778s8yPgKXmPDAlt/RlHkYZz2JfzhRBBdyvaHRk/xkqvcasCGx57Aq2HdnbyJ5ICWeyf7gww==
X-Received: by 2002:a5d:470c:0:b0:2e6:3804:5be with SMTP id y12-20020a5d470c000000b002e6380405bemr1494910wrq.59.1682610650706;
        Thu, 27 Apr 2023 08:50:50 -0700 (PDT)
Received: from [172.23.2.142] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id z17-20020adfdf91000000b002d97529b3bbsm18808434wrl.96.2023.04.27.08.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:50:49 -0700 (PDT)
Message-ID: <563fd75f-5ca7-a441-3e21-542e78afa206@linaro.org>
Date:   Thu, 27 Apr 2023 17:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: display: simplify compatibles syntax
To:     neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Xin Ji <xji@analogixsemi.com>,
        Thierry Reding <treding@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230414104230.23165-1-krzysztof.kozlowski@linaro.org>
 <4a5ba8cf-5c24-2e76-4eb2-e05c7d8dfc72@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4a5ba8cf-5c24-2e76-4eb2-e05c7d8dfc72@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 13:50, Neil Armstrong wrote:
> On 14/04/2023 12:42, Krzysztof Kozlowski wrote:
>> Lists (items) with one item should be just const or enum because it is
>> shorter and simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Rebased on next-20230406. I hope it applies cleanly...
>> ---
>>   .../display/bridge/analogix,anx7625.yaml      |  3 +--
>>   .../display/panel/sharp,lq101r1sx01.yaml      |  4 ++--
>>   .../bindings/display/solomon,ssd1307fb.yaml   | 24 +++++++++----------
>>   3 files changed, 14 insertions(+), 17 deletions(-)
>>
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Should I apply those patches ? Until now Rob finished by applying them.

Thanks. This and the mediatek display one were applied already by Rob.


Best regards,
Krzysztof

