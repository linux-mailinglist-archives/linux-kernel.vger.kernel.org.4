Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172016C1C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjCTQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjCTQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:42:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55893D30D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:36:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so49138230edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679330197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYulapKXJcRNM3aIWY+CATrCMO6Luzk86prrhy43Hig=;
        b=n538UNSKRmPvLy7Ou9k++tMYrnhxlAeHEOECR4SMk8PtyLTMF4Zl19OdJAoSaDElP0
         1n2+KNlP1Gqj1x3DdeJIuZOwUBE7pU4ffc3v8ecVbN1Ncv4y3u5PVY/0iKIcWrKoZeVl
         vImhNYWuc3KNne8cL7TlNi1hXyt0tO+kV2u7zA2RKlSSBWmgunQbQXUzyzQyFvUBbx7t
         g9MB/9I2a5uBEVJuHQeXJk8ymvpSefEBIctpBSuZfMp6ZS0VSJpIOTSo37BIE5DzyWA7
         RMukv5osQkf79pRAwKTGTzez83TjyYtDyFCbk8saujbY1HpBqg+iPxzjDshTJor1a/fR
         eYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYulapKXJcRNM3aIWY+CATrCMO6Luzk86prrhy43Hig=;
        b=Pv9+LXuvnDANGndQVMA6yhYBb56f9Rcb6dLbh5ERoR41nvV+N7T2jn5Z4Jy2vjWKFp
         HX8fpbdgV0QUe3n/+dx4Nw23/HRingPf2+lXrsZ/c55QY+SWa+wlEvuPgsrVfRSVxCYa
         +SFF3gSO6bx9EM0lIC8xNgJgNTDzl3u1qhbbiYIEC821VM5FxVFBsme5NXWD3HUWI2Q6
         Vlm4MH+SNut7v0l2CjEn35UuOJmzDls4iwp36en3jJ2NQCc9LblSoahVPVD9/KnvP0T1
         zZtnusu2Lypv2moK8HQMNU90Tpy8xNHnJ7l8oorQz/EcJD0UENBa0Vf1W/pZs/FJZELa
         V/Gg==
X-Gm-Message-State: AO0yUKUNBTthKsWfFQzFlqN+tdJDVi6ELyhdPA3WDseB20AENtFV5moe
        G6UeNzVS4pGtXBH0hnJ4k8rfCg==
X-Google-Smtp-Source: AK7set/O3GQ82ux1OEooC6qaPiTzTPK580FO+l2yiNgQvzSM/GSxrfib6ObUxT0SGjC1U8bsSL+0sQ==
X-Received: by 2002:a17:907:77d4:b0:930:45ea:4a28 with SMTP id kz20-20020a17090777d400b0093045ea4a28mr11748494ejc.35.1679330197565;
        Mon, 20 Mar 2023 09:36:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170907984400b009323f08827dsm4218103ejc.13.2023.03.20.09.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:36:36 -0700 (PDT)
Message-ID: <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
Date:   Mon, 20 Mar 2023 17:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 17:18, Sergio Paracuellos wrote:
> Adds device tree binding documentation for clocks and resets in the
> Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT3350,
> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Subject: drop second/last, redundant "device tree binding
documentation". The "dt-bindings" prefix is already stating that these
are bindings.
(BTW, that's the longest redundant component I ever saw)

> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
> new file mode 100644
> index 000000000000..c92969ce231d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml

Filename matching compatible, so vendor prefix and device name (or
family of names).

> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mtmips-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTMIPS SoCs Clock

One clock? Are you sure these describe exactly one clock?

> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description: |
> +  MediaTek MIPS and Ralink SoCs have an XTAL from where the cpu clock is
> +  provided as well as derived clocks for the bus and the peripherals.
> +
> +  Each clock is assigned an identifier and client nodes use this identifier
> +  to specify the clock which they consume.

Drop useless or obvious pieces of description. Describe the hardware.

> +
> +  The clocks are provided inside a system controller node.

???

> +
> +  This node is also a reset provider for all the peripherals.

??? Does it mean it is not only "Clock" but also reset controller?

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ralink,rt2880-sysc
> +          - ralink,rt3050-sysc
> +          - ralink,rt3052-sysc
> +          - ralink,rt3352-sysc
> +          - ralink,rt3883-sysc
> +          - ralink,rt5350-sysc
> +          - ralink,mt7620-sysc
> +          - ralink,mt7620a-sysc
> +          - ralink,mt7628-sysc
> +          - ralink,mt7688-sysc
> +          - ralink,rt2880-reset

That's odd. rt2880 is sysc and reset? One device with two compatibles?

Also, order these by name.


> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    description:
> +      The first cell indicates the clock number.
> +    const: 1
> +
> +  '#reset-cells':
> +    description:
> +      The first cell indicates the reset bit within the register.
> +    const: 1

Wait, only rt2880-reset is reset controller? This is confusing.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysc: sysc@0 {

Drop label.

Node names should be generic, clock-controller or reset-controller or
system-controller sometimes.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +      compatible = "ralink,rt5350-sysc", "syscon";
> +      reg = <0x0 0x100>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };

Best regards,
Krzysztof

