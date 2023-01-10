Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF10663B92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbjAJIp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbjAJIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:45:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F01A065
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:45:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id co23so10938136wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nhalakForWLq/BpHz4s5xQNDs64Epq6wJvSqVishPM=;
        b=uALzNialZgr8wwwci5b4iFEDY3qvdfFZaiMcOqwbtJlbsZAbvKl73tT0WSmmrnpCYw
         2VmlXimyUZMpg5LSlN5CadKHjNCSrYUvuipdJS/M6QQHEsYHDFAVwBFwDIwNMTnekv2O
         L8FHDJBtHzOSk2o96VGTpYroLdFENaYwZ94M9KHisZkLlZU7iowpbF9Ex4crJFtt+7KB
         CN9niLyTHQhXgObh0khQdnnb+QUOwdyvA0EUBjb/091q8T9qcc6EbR8hKpMTpdTZNqq2
         ra1+musbKmt2DQxT3iRP7gVyW3tUPdfxlFuu11eLXkDGHyAxh3W76CIkZ+CNsf49thy7
         TOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nhalakForWLq/BpHz4s5xQNDs64Epq6wJvSqVishPM=;
        b=pZFEW75vS77JupEf89PTx9Sp0Q28qfJJ9CRIB/aFxPS6tymW4HCWFbPsWSLFavsqfp
         3esTVtS0XFZlpGU3xbJ0zAc8DgKn6rRKuHPCKv+LrE1kXBdyFDz0ZA/YxvkeRoSFltqt
         IcMJn8T5qa3RvD8EUVDeuFaoruwNR8LpnxpYa1oqMFYPg9PUvghpcNvW53LCm2P8BEQI
         pepmCHOgRO/CLJgpqw6y4vGZzgLAC3QWLgFEAQsYf6rDAMU22e8A3T7NExJDsJWfHFGd
         nCPuSRcKq0/SM3jPcJVKO6aS0N8jrF8B2xXDoohz2ASnzXetgwbnR7ukIwWQK0R1u8Ac
         BZlw==
X-Gm-Message-State: AFqh2kooXXwkY1+LpK/zWopV8W4td+b6wGvcjLai93LU+PAU577/pC1o
        XeRcp4X1CQKBJoULOPVzHDptJw==
X-Google-Smtp-Source: AMrXdXulnkGqYk+DJ+tLAOVP3aPTbM+3YrOEXeaSdxC8EXrMCyDK3H0xlqDMHPCf0sA7EDuEPNGceg==
X-Received: by 2002:a5d:56c1:0:b0:288:d139:3690 with SMTP id m1-20020a5d56c1000000b00288d1393690mr28887704wrw.67.1673340304041;
        Tue, 10 Jan 2023 00:45:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b002b065272da2sm10478381wrr.13.2023.01.10.00.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 00:45:03 -0800 (PST)
Message-ID: <cf65926c-d2c1-f1bc-6e27-f07611a5cce8@linaro.org>
Date:   Tue, 10 Jan 2023 09:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Content-Language: en-US
To:     Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com
References: <20230105160346.29018-1-faiz.abbas@arm.com>
 <20230108163741.GA30997-robh@kernel.org>
 <f0ad7a4e-a8af-77d4-09e4-3717041677e7@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f0ad7a4e-a8af-77d4-09e4-3717041677e7@arm.com>
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

On 10/01/2023 09:23, Mohammad Faiz Abbas Rizvi wrote:
> Hi Rob,

(...)

> 
> Thanks,
> 
> Faiz
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Please fix your mail setup. We cannot work in upstream/LKML with
confidential emails. Since I was not a intended recipient (I don't know
who is), then I should start removing your emails?

Best regards,
Krzysztof

