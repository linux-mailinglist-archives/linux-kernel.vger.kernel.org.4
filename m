Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB27638F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiKYR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKYR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:57:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BC23BF1;
        Fri, 25 Nov 2022 09:57:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id cw8so1776584ejb.10;
        Fri, 25 Nov 2022 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbRnJZLZimHWsGzRHTMEcRloTQuJ50SlssIRdpmahOs=;
        b=WLSyqVO/wsM9eNLKGkI5R/6DTuNUeLXYT6SaaQZ4v4pPyKuGdbNe+rdqVzDLMziHYP
         SscsKUjrxJ4kCM0KTqeCbTGyC4d9gaUODE8Zo35ggje4LifKSo2it+1qg157950YxLBD
         S2rcVIk05h9JS1uljIZ+1QHf4S8SODen0qykk3B30AjJayPNd5dYYkbESOu9XdrACpk+
         +onN/3M6fFHgoU074a9mxMr+ouyGFVjvpiqnY6wRIHk0GMX1+VVQr2J78R3tmyOwOQJI
         baS+zPxOce7/8rGgDDaEGEro50GOYY8ZMqAFc+BnlmeB6eYEPomA3APvZEgnjlY/435h
         aRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbRnJZLZimHWsGzRHTMEcRloTQuJ50SlssIRdpmahOs=;
        b=nn6UefuKmUXDHYk88D3ZS65KNyEg5vlbBMfQc1hpZ7d51lZ5BdEUrK97qy5sV6qJXj
         AocPFjrwaxhfTKh/NoBl5az5sNqdb6UgmdzQpyxt0CBQT2Sf2DpF0OoRhq0lFNdfhB2r
         ogt9PqNAlZlXBAcIOwmEFpePzxeOjY7mlpjZIeAWzBeYKUOHH+MpJ4e0J+jKa3HFhatl
         ODa0vdJUf+HquqWX7LPbbPTLA3VDRTZpWVigKraxX/vT8wv+6Io4KAXAGuTKNgA0Ualh
         JCIPDVH+7TmwTAva8UQZDbkmY/ZoaQ2fRFX3iymeW9X26ZiUohYyfYEZOCRGNDxqkYv/
         n2Tw==
X-Gm-Message-State: ANoB5pnFNtyAG18J0TtUgkAXrtT/YUwfxQU0rFCfZz/OX07vCS2S9Gfp
        JuRAFKUbCQ84KcXruBBdNec=
X-Google-Smtp-Source: AA0mqf4hyqLTkqhO3vKi5JfsbhKQpcKYiIiI8Yu0KuqqvXAGFw/uV1xzLJV/0HIg3YYneVzw+NdmoQ==
X-Received: by 2002:a17:906:1844:b0:77a:4bfe:d6df with SMTP id w4-20020a170906184400b0077a4bfed6dfmr33873692eje.396.1669399044408;
        Fri, 25 Nov 2022 09:57:24 -0800 (PST)
Received: from [192.168.178.2] (dslb-092-072-004-196.092.072.pools.vodafone-ip.de. [92.72.4.196])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906495800b007bb32e2d6f5sm1791287ejt.207.2022.11.25.09.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 09:57:23 -0800 (PST)
Message-ID: <81722eba-3910-2117-8b07-bb030ab754dd@gmail.com>
Date:   Fri, 25 Nov 2022 18:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH 3/4] dt-bindings: display: panel: mipi-dbi-spi: Add missing
 property
Content-Language: en-US
References: <43ccb0fb-119b-1afe-758b-e413729dd704@gmail.com>
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Otto_Pfl=c3=bcger?= <affenull2345@gmail.com>
In-Reply-To: <43ccb0fb-119b-1afe-758b-e413729dd704@gmail.com>
X-Forwarded-Message-Id: <43ccb0fb-119b-1afe-758b-e413729dd704@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-supply property is currently only mentioned in the 
description, but not listed in the properties section as it should be. 
Add it there. Signed-off-by: Otto Pflüger --- 
.../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml | 3 +++ 1 
file changed, 3 insertions(+) diff --git 
a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml 
b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml 
index c2df8d28aaf5..d55bf12ecead 100644 --- 
a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml+++ 
b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml 
@@ -80,6 +80,9 @@ properties: Controller data/command selection (D/CX) 
in 4-line SPI mode. If not set, the controller is in 3-line SPI mode. + 
power-supply: + description: Power supply for the display module (Vdd). 
+ required: - compatible - reg -- 2.30.2
