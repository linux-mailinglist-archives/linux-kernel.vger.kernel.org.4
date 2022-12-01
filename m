Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2019E63F87C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiLATkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLATk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:40:29 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914A98023;
        Thu,  1 Dec 2022 11:40:28 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id h132so3154184oif.2;
        Thu, 01 Dec 2022 11:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boNQPL0i0ILb4HhKeMVQSoaXUT08m5V8+ybujR0N0TI=;
        b=AJUBE2ZeaJEKmqH/l3qPIVoL+bw6jQuKlALZrh/nFfQnX+OLXn2RC7WGSmQMGLqA08
         FmEKYOPTiu8xPwa0tkTZ3xyEXBMNiVfriFIq1eKlep6dHGqSQj/C9gpEbiFmQ+1FkLCv
         W7dToC3YhRopc2DE7qKJZV/PLDdCZRM4FcdrtG8kciFYoHrrzRImBZOAWb6YWBPobt0u
         hqQhqHplqcgPfSvUFiPyq45UQQMfGu7hXrxZhwvmOYNge1TEYLUGwsBw4AWZ4mybU4C6
         dZuxvmYdVNZpx4q6AS7eBnA0IHTX8n85I4hF2qDTMOcEpolLaiP5rpS6eG1thz66SpB2
         tObg==
X-Gm-Message-State: ANoB5pmDZUJxkv5Gq7fpbPkCG9kNHpYi6uJy8PiK+dTMmOHWe8qXlXnH
        SVVKaI5zGsz3eJz3TpjP6B5iAasYDA==
X-Google-Smtp-Source: AA0mqf7EHzfleKI7CO0oX8lnmi1IYx3XscnTMOaiB0J2r2agG3qDO8nklTcidrANIVj1NAux24DAbA==
X-Received: by 2002:a05:6808:152c:b0:354:da02:c05f with SMTP id u44-20020a056808152c00b00354da02c05fmr22940884oiw.290.1669923627983;
        Thu, 01 Dec 2022 11:40:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o6-20020acad706000000b003549db40f38sm2128071oig.46.2022.12.01.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:40:27 -0800 (PST)
Received: (nullmailer pid 1216496 invoked by uid 1000);
        Thu, 01 Dec 2022 19:40:26 -0000
Date:   Thu, 1 Dec 2022 13:40:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 02/12] dt-bindings: thermal: tsens: Add SM6115
 compatible
Message-ID: <166992359520.1215696.1988935137698769756.robh@kernel.org>
References: <20221130200950.144618-1-a39.skl@gmail.com>
 <20221130200950.144618-3-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130200950.144618-3-a39.skl@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 21:09:40 +0100, Adam Skladowski wrote:
> Document compatible for tsens on Qualcomm SM6115 platform
> according to downstream dts it ship v2.4 of IP
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Since Daniel is out, applied, thanks!
