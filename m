Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA9661817
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjAHS0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:26:26 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0894FD9C;
        Sun,  8 Jan 2023 10:26:26 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id i83so3474172ioa.11;
        Sun, 08 Jan 2023 10:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhYco9q4BGT5Q7opcwSBKE6gyncAAuyL8FaiWNRvTGI=;
        b=G6OBpR5UzmPMah+gs+KKx4tw+jnyCgipL6o4Gp+XN7DuskztYstgSBopPrm4QUkn/k
         4nlS0Y8WVXopybqw7peZyQY4PvylAF9Zs2+RdVG/fpgni1TjPszBTBIQNNOAkfpkLCzZ
         Sqzl6Tjn6fYAXK2AFmoBAX+RqleQtTh2SSXvhNKtzyxiJhJ0amYXYCJh3f7rUe3aJMtb
         j5Z51pVACYmwxTGBsi8HKgMwoP7Yx+XGzGiuaVKjfnK5jC6RPa8AIJLL/Whu0BFBnfbz
         hKcq1QZlTq1uZTG/xpIdtrQ3CkakeidRytw0xm+uiXai+3PQf4MauH9HJosyhAeFlrUp
         MSXg==
X-Gm-Message-State: AFqh2kpB0RoLmC7YwfhF68lDG1cD98CN7maEF4Tzs3g1wNu7ccgb4djl
        7sM3serYE6OYQroeZc5Rew==
X-Google-Smtp-Source: AMrXdXsf1D4Yy3k6eDww5Upb+zEPwXDBmKywDJtACNuq9WuuMPdMkt3egdJE+IXIH3hhgeXR9SrisQ==
X-Received: by 2002:a5d:9d59:0:b0:6e2:ec15:fb69 with SMTP id k25-20020a5d9d59000000b006e2ec15fb69mr43810220iok.8.1673202385284;
        Sun, 08 Jan 2023 10:26:25 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id j21-20020a023215000000b003748d3552e1sm2132167jaa.154.2023.01.08.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:26:24 -0800 (PST)
Received: (nullmailer pid 172203 invoked by uid 1000);
        Sun, 08 Jan 2023 18:26:22 -0000
Date:   Sun, 8 Jan 2023 12:26:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 7/8] media: dt-bindings: qcom,sm8250-venus: document OPP
 table
Message-ID: <167320238100.172125.11073294753991528934.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:41:01 +0100, Krzysztof Kozlowski wrote:
> Venus on Qualcomm SM8250 uses Operating Performance Points (both in DTS
> and driver):
> 
>   sm8250-hdk.dtb: video-codec@aa00000: 'operating-points-v2', 'opp-table' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,sm8250-venus.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
