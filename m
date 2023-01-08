Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA3566181E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAHS2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:28:40 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0460DF;
        Sun,  8 Jan 2023 10:28:39 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id p9so3458827iod.13;
        Sun, 08 Jan 2023 10:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDTfuGXRrRs45CKYiBK7pYopbB+jZOfhP8Ir8+UtX+s=;
        b=OgvB4yEMBdObA6JrFABiBuK78TKBU7RzP+oS7izVNW98ImgUvMH7qg7y3IjLRRFZV0
         SiPLwsn3NkoVrMNOrnj53/Kc55HrbICImE+D+keRUo5CK0EQVKYJTKmJgFIz8LyHZ0Sk
         bt1SEsMCBk3b5WDhB2r+FS6DoRKyoEZfc2pryrSv55HOeuMnoQvHvet3woOHW9a+tyih
         YioV97aKQgONPyeJ44iZ9a89G8w7AfrYm7c/+v07bp/xGWR4jKE6Y0La33z8gGGC7l3O
         ZeVvQ9Ak2tEyTbwRKmkBowiabTNA2Kys9CrvVbLtpwOK1x+Aw5jAPfeMm9agXo5QssUf
         Ofog==
X-Gm-Message-State: AFqh2krJTv26eXMKsvhyEdic3cKoKpi5q95SqeuDVxGWxJpPTo3O9p3I
        R7QiFqq1N7oFGAFIlwuU1w==
X-Google-Smtp-Source: AMrXdXvTNr0zvIMMDNWfmE8Eibz0/mh4lS8pJSYzM6aFWdBK1gmLZFdKN9xM7rNtD+B4CSYPoFbagw==
X-Received: by 2002:a5e:9e0d:0:b0:6df:dc79:a1f2 with SMTP id i13-20020a5e9e0d000000b006dfdc79a1f2mr39431061ioq.11.1673202518597;
        Sun, 08 Jan 2023 10:28:38 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id l4-20020a6b7504000000b006e2f2369d3csm2429398ioh.50.2023.01.08.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:28:38 -0800 (PST)
Received: (nullmailer pid 174714 invoked by uid 1000);
        Sun, 08 Jan 2023 18:28:35 -0000
Date:   Sun, 8 Jan 2023 12:28:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Banajit Goswami <bgoswami@quicinc.com>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: qcom,lpass-cpu: Document
 required-opps
Message-ID: <167320251438.174645.13068817278012260437.robh@kernel.org>
References: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 17:31:33 +0100, Krzysztof Kozlowski wrote:
> SC7280 LPASS CPU device node comes with required-opps:
> 
>   sc7280-herobrine-crd.dtb: audio@3987000: Unevaluated properties are not allowed ('required-opps' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
