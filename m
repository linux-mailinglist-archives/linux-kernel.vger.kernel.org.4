Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B185729F07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbjFIPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbjFIPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:47:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FFC3592;
        Fri,  9 Jun 2023 08:47:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so15032855e9.2;
        Fri, 09 Jun 2023 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686325651; x=1688917651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvsyDZog8UdXtFUstcFIwZYCdsCI4s94QKgguTKAncA=;
        b=eIcjxVB40pDpb2ZoElA7E17xvrkCTeRFA8ELuy9edub1v+ubg2q9ePY1op4fw9IrQ4
         ppnJFdR3KH60otHzfr9PD5x6aRJf8x6iGU/cRzxWxiEiVSlBdqEoD0Rr8CK2dvRxMOl3
         NEV6sUTQeXXFlPUBWifOKIIEwpeA88esNnT9PQzrExFasaumjrurfVZBI2DVJaJshIjI
         lE46dl5WuZ09gKytGymFbKeVRVQx9hYw6JFaUo43r7UOnoDisdCaA1eauoxfXWZj+pZx
         xg0hzGd+oIEwjcRDv5c8Q2FOhJsJ5jZro0HaZwwsFtiLYVsi8jBIaDJyVyhKQT86c+ja
         oWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325651; x=1688917651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvsyDZog8UdXtFUstcFIwZYCdsCI4s94QKgguTKAncA=;
        b=iNUV5Ft32mFafmWS6Vsi9s6jkHkT4CRnDcLyYhbAD9E6CeS1iny7qDa/B/s1VNd6fw
         Edde8rdHIu6dNs8CQZ2fpxPnJB+p951+EynuSZ2Q+kPS1nFB8Ibqmf6de25r+9H4cCW+
         3YYALeAYIWNDxqEH0E4nfyyFUMI9YVKoH82yxSkBRnDG0+O3jJQiTPyfMmBBoWNfzxGg
         80KoIAD63yKoM1O4Pt0LFt1wewwFcN/5hlXwVNgg7IPdNz41E64uDkmgM9S1vTy7oFC5
         4Ewb9X0MiY3wx/geX1yGyq5fdogNn9dkOai4lIKdI8QeyzLAEzanHh+kOAVipNaq99nC
         pgMA==
X-Gm-Message-State: AC+VfDwRYimCqLtudGaeR8nPMGKjKMG7rzdWt6HmirOpCdvzmf4SsDDi
        cwIpJO4j7bWptGart2ENEQI=
X-Google-Smtp-Source: ACHHUZ6NKzMSG82OjKfcqbR9aMOl16JFpqq9kds8NwAFxDhxN/rN4QLrerSiDwefEu+hgWldWWbyjw==
X-Received: by 2002:adf:efc3:0:b0:307:9f8:4f30 with SMTP id i3-20020adfefc3000000b0030709f84f30mr917251wrp.70.1686325650665;
        Fri, 09 Jun 2023 08:47:30 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6286000000b0030903371ef9sm4771838wru.22.2023.06.09.08.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:47:29 -0700 (PDT)
Message-ID: <3b32ce8b-266d-e47f-f0e6-9ea83cb6d80f@gmail.com>
Date:   Fri, 9 Jun 2023 17:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/9] regulator: dt-bindings: mt6358: Drop *_sshub
 regulators
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-3-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230609083009.2822259-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 10:29, Chen-Yu Tsai wrote:
> The *_sshub regulators are actually alternate configuration interfaces
> for their non *_sshub counterparts. They are not separate regulator
> outputs. These registers are intended for the companion processor to
> use to configure the power rails while the main processor is sleeping.
> They are not intended for the main operating system to use.
> 
> Since they are not real outputs they shouldn't be modeled separately.
> Remove them. Luckily no device tree actually uses them.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/regulator/mt6358-regulator.txt   | 22 +++++--------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> index b22b956d1cbe..b6384306db5c 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> @@ -8,14 +8,14 @@ Documentation/devicetree/bindings/regulator/regulator.txt.
>   
>   The valid names for regulators are::
>   BUCK:
> -  buck_vdram1, buck_vcore, buck_vcore_sshub, buck_vpa, buck_vproc11,
> -  buck_vproc12, buck_vgpu, buck_vs2, buck_vmodem, buck_vs1
> +  buck_vdram1, buck_vcore, buck_vpa, buck_vproc11, buck_vproc12, buck_vgpu,
> +  buck_vs2, buck_vmodem, buck_vs1
>   LDO:
>     ldo_vdram2, ldo_vsim1, ldo_vibr, ldo_vrf12, ldo_vio18, ldo_vusb, ldo_vcamio,
>     ldo_vcamd, ldo_vcn18, ldo_vfe28, ldo_vsram_proc11, ldo_vcn28, ldo_vsram_others,
> -  ldo_vsram_others_sshub, ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18,
> -  ldo_vmch, ldo_vbif28, ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12,
> -  ldo_vrf18, ldo_vcn33, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28, ldo_vsim2
> +  ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18, ldo_vmch, ldo_vbif28,
> +  ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12, ldo_vrf18,
> +  ldo_vcn33, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28, ldo_vsim2
>   
>   Example:
>   
> @@ -346,17 +346,5 @@ Example:
>   				regulator-max-microvolt = <3100000>;
>   				regulator-enable-ramp-delay = <540>;
>   			};
> -
> -			mt6358_vcore_sshub_reg: buck_vcore_sshub {
> -				regulator-name = "vcore_sshub";
> -				regulator-min-microvolt = <500000>;
> -				regulator-max-microvolt = <1293750>;
> -			};
> -
> -			mt6358_vsram_others_sshub_reg: ldo_vsram_others_sshub {
> -				regulator-name = "vsram_others_sshub";
> -				regulator-min-microvolt = <500000>;
> -				regulator-max-microvolt = <1293750>;
> -			};
>   		};
>   	};
