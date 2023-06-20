Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA3737287
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFTRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFTRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:17:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04E1733
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:17:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b455855fb2so68458041fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687281438; x=1689873438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XabCVCnKN/+LbuMDododZmkqW6HATgL+WSAC/bjcDk=;
        b=NJqn42QJSscKRFEldVznl4jsn9FWxMZtL7Ma5dT9YIOSe63Nr1VhEfwVfkN4MaNrtw
         FRMZEIh6RDVvfy/jvZQJwxXdsn/3BWZEmQuALvm8VVJ/kU6D6J0h4YMNokKxL/8DYCR7
         DMU/TWF0CEoynWmHIPgzcHrH1RsGwJ9slDo1YDW40VbjXZ+UUztdOsraaPseyu86RakZ
         psl7jkeu/T58P92Gm4iS3V2Bl3Dcd4Ijc5dsIl9olj84wbaRpKfgzeOQRJX+HitDg3/3
         sRuaST+ntMyhI8P/darxU94uG+c8fTWUEShA3xmOC9F525FoQqZi52wE0C5dfEQwXno9
         uXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281438; x=1689873438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XabCVCnKN/+LbuMDododZmkqW6HATgL+WSAC/bjcDk=;
        b=enUlnkLaEpEM0kZaI7BnFsczYv6dZv6DUrzvO9qaTKCwss7lds1v4mt9E+Z2a0aSat
         Xnda/7Whca2KgKw2Oh8tQZYbze0Z7Usv3D7S1Tls8msWd1bzC51IlPQJYEwgAIqw0zYz
         BFURGbkmxV/6OlrA/TKAefPK4a5HwMcfpcOaM9lVIIyldBc/EP/VMzywNWKbYRmb0rN8
         TmODw4f/idSHPtqcbQq0hJ/tV2wxe3IX8+Hw2OhoKP5rPybXgK1b90fMxMNAoHAkhQtQ
         DyPF9go9uq0DKDVRvfOgbE0pL7QNHZq09ag5Ud6sxBtwUk+DGaZFUvq9G55zPrJKEJkg
         /iag==
X-Gm-Message-State: AC+VfDy99/8042GqcK1jIHokOUWaipn4c17IrFd0tF042sW6tid4cL8a
        w2kLiEB2CA6T56zx7WtzP0XtMQ==
X-Google-Smtp-Source: ACHHUZ7HmOZ5iUHATH17EiFwU86g/fw8G/0/mk89VyaIIpiZGcHhgt6Azbs6QiCq7zflkCAlb4U2XA==
X-Received: by 2002:a2e:a413:0:b0:2b4:6c47:6253 with SMTP id p19-20020a2ea413000000b002b46c476253mr5577460ljn.38.1687281438388;
        Tue, 20 Jun 2023 10:17:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id by19-20020a170906a2d300b00982bf866f9esm1712568ejb.66.2023.06.20.10.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 10:17:17 -0700 (PDT)
Message-ID: <ff9045bd-1030-b3c6-9692-e223846b0ee5@linaro.org>
Date:   Tue, 20 Jun 2023 19:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv3 2/2] arm64: dts: rockchip: add dts for Firefly Station
 P2 aka rk3568-roc-pc
Content-Language: en-US
To:     Furkan Kardame <f.kardame@manjaro.org>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <c020531e-c56e-7606-1846-5ca7332de96f@linaro.org>
 <1687280004029.3690769854.982412891@manjaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1687280004029.3690769854.982412891@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 19:05, Furkan Kardame wrote:
>>
>>> +	};
>>> +
>>> +	hdmi-con {
>>> +		compatible = "hdmi-connector";
>>> +		type = "a";
>>> +
>>> +		port {
>>> +			hdmi_con_in: endpoint {
>>> +			remote-endpoint = <&hdmi_out_con>;
>>
>> Missing indentation.
> 
> I am not able to see any missing indentation in the patch. 
> I did run checkpatch and did not find any such warning.
> Please advice in detail ?


remote-endpoint is a property within a node, so it cannot have same
indentation as the node.

Best regards,
Krzysztof

