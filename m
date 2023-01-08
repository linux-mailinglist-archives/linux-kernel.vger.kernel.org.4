Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80391661822
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjAHS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjAHS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:29:13 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8A60DF;
        Sun,  8 Jan 2023 10:29:13 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id bp26so3860613ilb.3;
        Sun, 08 Jan 2023 10:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMhFbySGrPohTwiXX3TAkbMAqqH438aTvo1KuJo04VQ=;
        b=VIC16Hd/k75CSTXP6E4cnA0VIgRYtDCpVl+cYns4MwxAij6EOZ5XZgwxeS+V8XMPf3
         m2YwfC8GmKQ3FIqZS3z1nxMKloSk9xVtlJr5QOIwCfCDt/mgIdZHaTcs6g1eDYk8Tq5H
         l6yeg+zRjNw2FqbSl8BZ7E8NYSfG7apVH3rm9RAq99EFlpxH/bSGezVO6Y4nPlCi0lsF
         vjYx4CDXH/kVDQ85LlesOxJGpu1PN6PAAcq6P68qVLNvGo/7P6S3mzU7+OyWaYtqLIa8
         W0W8owZAGbSXYcY3BrZLhEe9WoItXISw1mAURtZqWg4d2jeKEBK3i/TdxiOWfa02f59A
         JlFg==
X-Gm-Message-State: AFqh2kqoJrwka2qddgFGstra/eoCZ4RPR6bhtVzclapIS6ghOYvMZgCM
        uA731o0DXtEJsyGFGDrLrA==
X-Google-Smtp-Source: AMrXdXscl7NVSbdD6hIptcgu+AoJe4I5lmFCyA4jcxP2LE8xaf+gZBUiRRe8sFV5vHIJW9StFOiDCw==
X-Received: by 2002:a92:8747:0:b0:30d:6d40:aaa0 with SMTP id d7-20020a928747000000b0030d6d40aaa0mr15019018ilm.5.1673202552270;
        Sun, 08 Jan 2023 10:29:12 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id p18-20020a056638217200b0039e80b510e1sm579616jak.157.2023.01.08.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:29:11 -0800 (PST)
Received: (nullmailer pid 175231 invoked by uid 1000);
        Sun, 08 Jan 2023 18:28:57 -0000
Date:   Sun, 8 Jan 2023 12:28:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: qcom,lpass-cpu: Fix DAI children
 pattern
Message-ID: <167320253755.175169.16665151163621062615.robh@kernel.org>
References: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
 <20221227163135.102559-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227163135.102559-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 17:31:34 +0100, Krzysztof Kozlowski wrote:
> DAI children (as subnodes) can come with two-digit unit addresses:
> 
>   sc7280-herobrine-crd.dtb: audio@3987000: Unevaluated properties are not allowed ('dai-link@19', 'dai-link@25' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
