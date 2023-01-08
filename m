Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B46661A08
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjAHVcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjAHVcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:32:03 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6153B11155;
        Sun,  8 Jan 2023 13:31:50 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id bp44so6655737qtb.0;
        Sun, 08 Jan 2023 13:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCQ1OtoS4z3jfBA4wAje4rn3v9IX8GGdLLkOWAh306E=;
        b=MGv4mTovFp4q7cyI4rYRZCXuFIO9DuS/2J+Vl7yaPPMhYs4E7Kum3MUZeh2QVnqx1H
         janKY7uvk+M35/dClwq6SPrlI8nZBD9tsh04SSJlFQTnpo06Tzixdm6BlvmtaQzedaEY
         Xg8X7Njvh9TgrUYht0Zxplk6vK31eqn7tLlmMT6DyBD4cHUQPFcCY7GSnG3AI5IpRHLX
         wFURp94eLjBLhtXKjpWibNXYwzJGWDbg9H3WtCAdhAhb4OI/a5AtDPR5G0fQDluopTrS
         kpwgQtNFcAhqt3YFtaa3E/nI4lmDDmJ+gOa+JefNQPhVXUwN4Yoo7JOj5PXUPyxQBa+v
         PVjA==
X-Gm-Message-State: AFqh2krBaIEjuYUv4qt67xRtJaNd96cmWQduPEEHxGdZ8fMIwfh8mNti
        Pr0KAKc/zA8xqBjwiTGU9A==
X-Google-Smtp-Source: AMrXdXu80XQEDWfzEYl7aNf0W1MBvZLerS5pwVX1UnY/YlkH1BLU9E/9E+gzpCk1i1eKxGsNd5Fxwg==
X-Received: by 2002:a05:622a:4a10:b0:3a7:fc39:6cd with SMTP id fv16-20020a05622a4a1000b003a7fc3906cdmr95343719qtb.10.1673213509486;
        Sun, 08 Jan 2023 13:31:49 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id m19-20020ac84453000000b003a6847d6386sm3650333qtn.68.2023.01.08.13.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:31:49 -0800 (PST)
Received: (nullmailer pid 306876 invoked by uid 1000);
        Sun, 08 Jan 2023 21:31:45 -0000
Date:   Sun, 8 Jan 2023 15:31:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source'
 property
Message-ID: <167321350537.306824.10296594475975416202.robh@kernel.org>
References: <20230104095612.6756-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104095612.6756-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 10:56:12 +0100, Johan Hovold wrote:
> The RTC can be used as a wakeup source on at least some platforms so
> allow it to be described as such.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Since commit 30d70ec8f7fd ("arm64: dts: qcom: sa8295p-adp: Add RTC
> node") this triggers a warning on DT validation so it would be nice to
> get this into 6.2:
> 
>   arch/arm64/boot/dts/qcom/sa8295p-adp.dtb: rtc@6000: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Johan
> 
> 
>  Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
