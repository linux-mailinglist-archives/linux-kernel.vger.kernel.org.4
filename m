Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC16F4B38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjEBUSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEBUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:18:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E01BD1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:18:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so4980025a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683058697; x=1685650697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4ISCmcuhHX2z9pKZYH8LMC9+EtTqQuyVN7umKeFQRU=;
        b=RDDcaMz71Ic4o6C9/+g5n2+iU1aySV9KvLyQYNJ3rHH+KoztkkgfVLCFp+vvPpbeQr
         NGR3nAVs0vseESJJvgHeESiS46wf8j1cyWK6+NI5eYeaiyrHR1DHpaBdhhnhWztA44bR
         ltGx2xT55LofCdwtxRxVlxEBhuj8q8oyj3kpyMHvy/mDCSBKppIXdkhTJSD9t8gtRmLk
         xvEzXp506Ocae6xXAOZLRRlVSCUJlSFDwgaMaFim1OAlPqwVyCEeKd6HaWY4/pLqkmBH
         lQ91r0IPOgTqFuEDI+xTfWrYWFHu4HW8EMBoTTNjZhz+FGNrTokFiFiPn4Rs+N2dQYTa
         LlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058697; x=1685650697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4ISCmcuhHX2z9pKZYH8LMC9+EtTqQuyVN7umKeFQRU=;
        b=j7jtPYE1MGVBi5pjSy0U//0Y3ROAD/tLM0LCaQXMUgYGhHjrOOPP4VFEPD0GJ3QBiS
         gd0Rt+7ZueuGa8G6XPbCZzF7F/M5ptBQTlfnCKYZpz0Jt5YeJdl8mrrOZV2Oit9qV44y
         1skhd8KfbODYSXgsSDrmQC4uSlIt3VcDjtLYJ8XmiQWCOowtjmetaDAf1EBuERc/2cf+
         9cHTDseW6bnv2XnZOAX+6pIRAEMCWJyhjDrAZfy8uE5IviLmJ5U0yBxx7wad1EwmsNRo
         djWi2xNah0rMkEi38oQh4Sw+LrwW+4ImU1yQA5IWLxo1rKeBIR6I7841/TmTDIjrV3uy
         475Q==
X-Gm-Message-State: AC+VfDySApuOzhN7qBPud/HgFLNJvSW9fQ7ezHCMVI/S5svzvMEpksD2
        DUJPc0Pi3lpb/2vZSUOjJ9WqBQ==
X-Google-Smtp-Source: ACHHUZ5tnRUUGfvcUyPfMwzGDJX74OiM8fW4eHIVoypekU08ImzAYAJwT5SdiObPjytpgvKErkwn3Q==
X-Received: by 2002:a50:fc17:0:b0:506:c1a6:2771 with SMTP id i23-20020a50fc17000000b00506c1a62771mr11156753edr.39.1683058697300;
        Tue, 02 May 2023 13:18:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b004aef147add6sm13405675edt.47.2023.05.02.13.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:18:16 -0700 (PDT)
Message-ID: <931c8c6a-eae3-0258-1da6-29e04ff66eb3@linaro.org>
Date:   Tue, 2 May 2023 22:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: dma: xilinx: Add power-domains
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <a593bbb71df9818cebb4295a1d9ce61e76d48d15.1683035191.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a593bbb71df9818cebb4295a1d9ce61e76d48d15.1683035191.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 15:46, Michal Simek wrote:
> Describe optional power-domain property to fix dts_check warnings. The
> similar change was done by commit 0aec3958c88f ("dt-bindings: gpio: zynq:
> Add power-domains").
> 

Similar comment as for QSPI. Whether GPIO controller belongs to power
domain is not really related to DMA controller.

Best regards,
Krzysztof

