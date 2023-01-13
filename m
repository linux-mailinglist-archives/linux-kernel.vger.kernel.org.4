Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91980668FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbjAMH7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjAMH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:59:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C14FD63
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k8so5769009wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvba+bm1uvcwXeIUk9rep+TyHVoE8xZjiX2B8KGVNBM=;
        b=deIrp13k8iDkx1qZbiM6GPK3IRY04a4xEvRyyFdD9MVwpjQIgJB58GWW2vRordZK3u
         duXgFfargj67sG5g/U0wrpxMqfcy8w9wVsGHBQ9/T5wM0Z5nbPscPkiBHK9sJENgU4UE
         LQQKUJm3jhzHA9jS1cIJi/CzUvuBaaY2V+i29V/ddFgzs8QB1JIy8/nctO1eQVzldTub
         Nh80b0UfGkpn7eKTGqUUd8nCcsHPLQrbOGAmZvL60TzXVaHdlCIL/FtrMcr6Bv8unL6T
         bpv8GkzEFISE3UTQ9B+q0+NFL0ML+PtWVSqW9LDLExi8p14N8ULgMIph5lO5OAL7a1v8
         s8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jvba+bm1uvcwXeIUk9rep+TyHVoE8xZjiX2B8KGVNBM=;
        b=01rzdd6XcIb0BIAwypd37CSe2+S01x6d9Y9wOpI5fRam0arZXKIAaz0sqjhHjSen04
         A3i6fUkyM+Uwof4hfrD/T1kZwqu9suce5R0YWgUecdUuGpty/1sYcHstIL4qqTypnZLx
         B+nZZEV/rujG3MI6ZP/EDFJTSXrccNyqBg5WocVpbBinIDfRYdPzSQCz7R9jwNgHBXX4
         5uWpWHR04jSuMUMlpmOuZ+2R3EzmOavaqr6Ky29aIBus22rK3SVnb0LphqtMk8Yvb8n8
         7PTIUEZKA7DZpGvt+uNw5oNkM7XSJ13616sNMsYe/RrmTr88GX9vaAJoIzEC5WbZvVOf
         5xrA==
X-Gm-Message-State: AFqh2kqRdw64Q3x1IgAobcBofNzZRul9iN1uqsFGl4oKIVOYcsFGsgaC
        nQZ2pIKDJCmyrtTUcyKmNYIVAw==
X-Google-Smtp-Source: AMrXdXvXAdlx4wpgTMkmqS1ZHmdpFmO62gdl7i9fhzy4r7bJEHwMPD5PmjYgpTh3RyvUkCjE5jCOjQ==
X-Received: by 2002:adf:e448:0:b0:2b4:790e:32f3 with SMTP id t8-20020adfe448000000b002b4790e32f3mr19181873wrm.68.1673596751842;
        Thu, 12 Jan 2023 23:59:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id bo30-20020a056000069e00b0027a57c1a6fbsm18507611wrb.22.2023.01.12.23.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:59:11 -0800 (PST)
Message-ID: <a96ca0c8-bd33-038e-2166-f487da09b007@linaro.org>
Date:   Fri, 13 Jan 2023 08:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/6] arm64: dts: meson-gx: Fix Ethernet MAC address
 unit name
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Vyacheslav Bocharov <adeep@lexina.in>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-5-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Unit names should use hyphens instead of underscores to not cause
> warnings.
> 
> Fixes: bfe59f92d306 ("ARM64: dts: amlogic: gxbb: Enable NVMEM")
> Suggested-by: Vyacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - new patch
> 
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index e3c12e0be99d..f8b115cd6775 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -233,7 +233,7 @@ sn: sn@14 {
>   			reg = <0x14 0x10>;
>   		};
>   
> -		eth_mac: eth_mac@34 {
> +		eth_mac: eth-mac@34 {
>   			reg = <0x34 0x10>;
>   		};
>   

