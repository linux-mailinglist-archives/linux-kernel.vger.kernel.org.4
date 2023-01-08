Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18366182B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjAHSb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbjAHSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:31:14 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF7BC14;
        Sun,  8 Jan 2023 10:31:13 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id a9so3229451ilp.6;
        Sun, 08 Jan 2023 10:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXBbO2P+g4sf54JRtHUcYoNVdaz5jhylNXMvr/njs6o=;
        b=VfiJWhWFWAEMKi5MJbyMiRMA5XAF4YKghKA7g99hqznLtNFiv3HHZ1CkzmZOHy/70w
         E5GOF8AG/rYtUROzHrfJe687fJBXpn10CCfsfbxEbtloKjmPs5NCftibJUcyEQflb8De
         iRj25nNZb9L4aZBtINt66FAWcd+lDF/fPTiLA4cZnDxKxePW5w/WgRwEYMImS2l0fazB
         F8b9DMngr4jlMLHJEuF1o+djjibDmPlvtPJFzO6E2ElmKgivncYCgStsy2bjGnYCvHbo
         0c1AfBms4mXutSPyqFWoAGCQCx536Q/bpJx7DlWzjBdyt8qKiTgLfYIXjG3vQcygXHYZ
         R3fg==
X-Gm-Message-State: AFqh2kpibjrNWDV0dbJAHAcb8eDRFpcJPxHssldgB4FuuT2YKtnDzZ0w
        qelr1Bkp0RjW5Cy5b2v6tA==
X-Google-Smtp-Source: AMrXdXugH3E0ejS19Wkv/PJBMkYM23FfNcI74V9Fr5FWS9x0/SUgUUs+79aDicB6uQD5q0iMLDMMbA==
X-Received: by 2002:a92:ce48:0:b0:30c:6616:6fb with SMTP id a8-20020a92ce48000000b0030c661606fbmr13768343ilr.2.1673202672349;
        Sun, 08 Jan 2023 10:31:12 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id 3-20020a056e020ca300b00304ae88ebebsm2104584ilg.88.2023.01.08.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:31:11 -0800 (PST)
Received: (nullmailer pid 177585 invoked by uid 1000);
        Sun, 08 Jan 2023 18:31:09 -0000
Date:   Sun, 8 Jan 2023 12:31:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Rohit kumar <rohitkr@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: qcom,lpass-cpu: Correct and
 constrain clocks, interrupts, reg
Message-ID: <167320266826.177510.14546851275083337747.robh@kernel.org>
References: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
 <20221227163135.102559-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227163135.102559-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 17:31:35 +0100, Krzysztof Kozlowski wrote:
> The binding allowed multiple variations and number of
> reg/interrupts/clocks properties for SC7180 and SC7280.  Maybe this was
> done for different use-cases of LPASS CPU audio node, but DTS is
> supposed to be a complete picture of the hardware.  The upstreamed
> SC7180 and SC7280 DTSes contain the widest set of these
> reg/interrupts/clocks, sometimes being even sum of these different
> variations.
> 
> Correct and narrow the reg, interrupts and clocks to match existing DTS:
> 
>   sc7280-herobrine-evoker-lte.dtb: audio@3987000: clock-names: 'oneOf' conditional failed, one must be fixed:
>     ['aon_cc_audio_hm_h', 'audio_cc_ext_mclk0', 'core_cc_sysnoc_mport_core', 'core_cc_ext_if0_ibit', 'core_cc_ext_if1_ibit',
>      'audio_cc_codec_mem', 'audio_cc_codec_mem0', 'audio_cc_codec_mem1', 'audio_cc_codec_mem2', 'aon_cc_va_mem0'] is too long
>     'core_cc_sysnoc_mport_core' was expected
>     'audio_cc_codec_mem' was expected
>     'audio_cc_codec_mem0' was expected
>     'audio_cc_codec_mem1' was expected
>     'audio_cc_codec_mem2' was expected
>     'aon_cc_va_mem0' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-cpu.yaml        | 131 +++++++++---------
>  1 file changed, 62 insertions(+), 69 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
