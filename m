Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508872EAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjFMSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjFMSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:19:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BA1FC6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:19:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d55ac17bso1029823666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686680344; x=1689272344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Si+/shvcqkKwITehsz3jlcMUh+hjsQ3DO0PDy+Kywt8=;
        b=EersYtXU6f0gNYm8ge0XLuS++K+5LXpzYjQ8c1p/Am+DEGDIfsoGeXhM+HnG7Z+Q1a
         OLGkaRUuReTRokMWoSfQTm0+cuDbM0jK2wy58LvfMXf6415/CDVrc0FxHnjpL3VUJ9CJ
         pmo8L0AjhzACJ9aUKZSTX4nH9eZIPaDk07niXhg+879+9DglHPcibGAQCfIKiPJ+VLj7
         pQ7rHDdvG+a2/+YEVU8vIKnsj14Q+w3TcVs3MqWQsKtYoL4YeOCGRseAWTyRci658bsr
         1i2k0TzfB49uZ+PYQ3ITrfC3AEMFaPJ8fSh7Zd685KrIwPTTCmi5yC5PMk/JVb9mbQzJ
         X+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680344; x=1689272344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Si+/shvcqkKwITehsz3jlcMUh+hjsQ3DO0PDy+Kywt8=;
        b=Tp6CVbzqGyPjAYRn4jmhbtiPUZgqomtuKvIl9ZaxpMBr3snYNWWHgL2C+9FTXKFEZP
         LlFT5US9TuHrprIpg5kaiWet0JQJYuG3xAKCf9BPXsJXOHzRilQ+mAY/xsyNVKXiNtc/
         +5WPgf6ekw2p3IcrU5tPL7ahN31Wf8zakylAOMTPYaXcI+MDypyG0vSxzYn0wLR8fDqS
         yBRgQwiQhOITwQ6LoAn4C0kUZ8nf2bvjHckZxZdJSj37ksL0kcidhlBg5enbrHuHb1Ig
         U3OydI4Krwx3OBtjSl37chgShc1wOz/FqC/gKDiTmwGz2l+q3vosOooNL6ufXULSAg0g
         qZ0g==
X-Gm-Message-State: AC+VfDxAT7GHT8QLirEX1DC+d8BLWGUQnndyaxcI/A7P8cJ0JMIC5Mlo
        gvqZSzbOiDA/f21//4dVx+wdyuHXNk0ODhY13vY=
X-Google-Smtp-Source: ACHHUZ4kVz0Z2WClJ/sNF3p1W8w4qbF9ieyg0usT2Tb34YdPcuyYzGAMkhmYVkR6qKHAKM2296Y8vA==
X-Received: by 2002:a17:907:9449:b0:97d:ee82:920a with SMTP id dl9-20020a170907944900b0097dee82920amr10869194ejc.74.1686680343677;
        Tue, 13 Jun 2023 11:19:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jt5-20020a170906dfc500b0097462d8dc04sm6993158ejc.100.2023.06.13.11.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:19:03 -0700 (PDT)
Message-ID: <44b6cbbf-1fbf-cf2c-a035-5a7c6dd504de@linaro.org>
Date:   Tue, 13 Jun 2023 20:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 1/2] dt-bindings: display: ti,am65x-dss: Add am625 dss
 compatible
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230608163734.2578-1-a-bhatia1@ti.com>
 <20230608163734.2578-2-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608163734.2578-2-a-bhatia1@ti.com>
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

On 08/06/2023 18:37, Aradhya Bhatia wrote:
> The DSS controller on TI's AM625 SoC is an update from that on TI's
> AM65X SoC. The former has an additional OLDI TX on its first video port
> that helps output cloned video or WUXGA (1920x1200@60fps) resolution
> video output over a dual-link mode to reduce the required OLDI clock
> output.
> 
> The second video port is same from AM65x DSS and it outputs DPI video
> data. It can support 2K resolutions @ 60fps, independently.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

