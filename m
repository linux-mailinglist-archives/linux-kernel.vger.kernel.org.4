Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537326BEE78
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCQQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCQQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:37:15 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D0C833B;
        Fri, 17 Mar 2023 09:37:06 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id h5so3021733ile.13;
        Fri, 17 Mar 2023 09:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcritOrlAL7LuDSySaaHoz9IYB1WBIYVDspOFtztN2k=;
        b=i0i/zAzfPGKTbr+GsV3M+VqUpi9odyQHDC0BefOGIitwO9oBxhDb8u7gTTFXUD76TA
         HkKxaw714/rvIGXQwqQEKRRIdvZ6sknjlYjgAQk9+y6C5gUqb/OGRLVV6q5GBjnOXjIJ
         aa1qC3ZUj9UKc1frqUc6pu9rRT/phneDZr1M8V46TWHfmpK1ZLlWPoRClwc6DdifQ+yb
         2j3Bu5917f+NomWysg7tt6WcojmBy0j7mAWrurxHCxrAJsOi/HHK970am3S0tYRKQ/4D
         +aH9nLFrBUPUSvkT/woM7WbFd/+uywpZpbiL0xwRCRyNV4Sa2Bs3GtX451Xs/t6OZ43B
         XsVg==
X-Gm-Message-State: AO0yUKWCplfvogaAzNWoUD9VDu0ndjQa1RVkGPBIJWOtJHfyOMvMxAQK
        GOBYbt6Pw7lJxIW4YB+nJQ==
X-Google-Smtp-Source: AK7set+RA5nev2MuiGtvMOrTL9xbsjPWnCjv0S5EA55HGbZQWvOKZPDt9AH3ni/HX9m4JeT1ZbJD9g==
X-Received: by 2002:a92:d091:0:b0:317:3f4:c5c7 with SMTP id h17-20020a92d091000000b0031703f4c5c7mr67132ilh.3.1679071024928;
        Fri, 17 Mar 2023 09:37:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id o1-20020a056e0214c100b003139668e844sm727471ilk.13.2023.03.17.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:37:04 -0700 (PDT)
Received: (nullmailer pid 2438515 invoked by uid 1000);
        Fri, 17 Mar 2023 16:37:03 -0000
Date:   Fri, 17 Mar 2023 11:37:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/9] ASoC: dt-bindings: qcom,lpass-rx-macro: Add
 SM8550 RX macro
Message-ID: <167907102243.2438451.4014850401965311641.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075445.17160-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 08:54:38 +0100, Krzysztof Kozlowski wrote:
> Add the RX macro codec on Qualcomm SM8550, which comes without NPL clock
> exposed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-rx-macro.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

