Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9937501F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGLIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLInu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:43:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBCBE;
        Wed, 12 Jul 2023 01:43:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso107261361fa.2;
        Wed, 12 Jul 2023 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689151425; x=1691743425;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVexWb2xIiXfUmTRUoCRaVuTZQZYZCzaepAYfAfny6A=;
        b=S8H1DZo6S6oQzSMdoqsaJsn2wsCdkpAS6Wr+I3Kjxr3lDPbQ85eUpKWcgRsiITqLdQ
         wJzAQW7baTZr9RBhSDA+HatQjx591NVZ0LVv2rZ3d+oVGHVGJU1ESDjlbDeLUZbMG9PC
         5cIppAmouxuH+LNS/TDrZDNHY7QtcYT3i098pf+E9c6S6108x7oGjCdNgbdCqYOkPpcI
         sq1NLvXLSvzbFoDXtp50/1gCHTZ2qksUvh2apFoqTCB+NzJEJLUvXTPgI541YmkVjDgl
         Kl1X26JqNjAJ276rAWr/sPACtx47sZ0k9EKq8H3qM805xZjIrCbqWDmzJaTgq+X6ct8P
         NlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151425; x=1691743425;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVexWb2xIiXfUmTRUoCRaVuTZQZYZCzaepAYfAfny6A=;
        b=T2sBb8cCixc0yhHesMMZysRPX+yawoUXWyYprgZpvzPLKos8xJCxK21qoXErozz8sp
         37kyNc44FUehJmTHbgRVwYZmfv3ku6YTiNNFA1m7UaWE9fvnhfUCD0O14aiHABGc7Q08
         Zru+LUsvuq81KMK3NoKnIx90KYQWVypgkdaIJs2WTUsT9JMn+zjqZ08yKx4VSfKKZJY2
         DGWH2ZH7dLh8kP93eV9t5igDUoqT2qPP0884fe/xh7fFbfogTNimN0U39mE/sjxyJJfy
         IXakryvOqsneEeJ4XZ7/USfDvjaO/3fXmi9px6ylfVLz2aIu4ckyRjhbpIoyc4vZybc6
         2Ceg==
X-Gm-Message-State: ABy/qLbCvISypUt3u9RXI/dsdCpnyQN+pKTncmu1yuPKmxJ9YJZxrLUG
        Z5x2KygC4btUiv64tClHejD+2YRdsNE=
X-Google-Smtp-Source: APBJJlHYyuAaAq9x1E+AS9xHlZdQSOvaU3bH2T8KCkjCt4c+/0MdGf1zMrqalHo9Eu8nEvUrqhQTIA==
X-Received: by 2002:a2e:a16e:0:b0:2b6:cf6f:159e with SMTP id u14-20020a2ea16e000000b002b6cf6f159emr15173716ljl.44.1689151425348;
        Wed, 12 Jul 2023 01:43:45 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.82.245])
        by smtp.gmail.com with ESMTPSA id l24-20020a2e8698000000b00295a96a0f6csm826389lji.102.2023.07.12.01.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:43:44 -0700 (PDT)
Subject: Re: [PATCH v1] riscv: dts: renesas: clean up dtbs_check W=1 warning
 due to empty phy node
To:     Conor Dooley <conor.dooley@microchip.com>, geert+renesas@glider.be
Cc:     conor@kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230712-squealer-walmart-9587342ddec1@wendy>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <18871eff-f2be-9eed-ee4c-99eba87686d8@gmail.com>
Date:   Wed, 12 Jul 2023 11:43:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230712-squealer-walmart-9587342ddec1@wendy>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/12/23 11:14 AM, Conor Dooley wrote:

> dtbs_check w/ W=1 complains:
> Warning (unit_address_vs_reg): /soc/ethernet@11c20000/ethernet-phy@7: node has a unit name, but no reg or ranges property
> Warning (avoid_unnecessary_addr_size): /soc/ethernet@11c20000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> The ethernet@11c20000 node is guarded by an `#if (!SW_ET0_EN_N)` in
> rzg2ul-smarc-som.dtsi, where the phy child node is added. In
> rzfive-smarc-som.dtsi, the ethernet node is marked disabled & the
> interrupt properties are deleted from the phy child node. As a result,
> the produced dts looks like:
> 	ethernet@11c20000 {
> 		compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
> 		/* snip */
> 		#address-cells = <0x01>;
> 		#size-cells = <0x00>;
> 		status = "disabled";
> 
> 		ethernet-phy@7 {
> 		};
> 	};
> 
> Adding a corresponding `#if (!SW_ET0_EN_N)` around the node in
> rzfive-smarc-som.dtsi avoids the complaint, as the empty child node is
> not added:
> 	ethernet@11c20000 {
> 		compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
> 		/* snip */
> 		#address-cells = <0x01>;
> 		#size-cells = <0x00>;
> 		status = "disabled";
> 	};
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
[...]

> diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> index d6f18754eb5d..c62debc7ca7e 100644
> --- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> @@ -22,6 +22,7 @@ &dmac {
>  	status = "disabled";
>  };
>  
> +#if (!SW_ET0_EN_N)

   Are the parens really needed here?

>  &eth0 {
>  	status = "disabled";
>  
[...]

MBR, Sergey
