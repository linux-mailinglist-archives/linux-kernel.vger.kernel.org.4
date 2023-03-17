Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36A6BEEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCQQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCQQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:41:12 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97505D8B9;
        Fri, 17 Mar 2023 09:41:06 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id h7so3051665ila.5;
        Fri, 17 Mar 2023 09:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JsD8feDbQZLtjXXEjZG2Ph7500rlDWruAYhK5c5wrE=;
        b=cUOceuMicetJH5wwrL/5Mga2pJIC4uCRBCbyz13orKewncNSLhVI0w0OSuR7mYq3jU
         jic8fldiArrjYlZsZkmE1vTOxgzklSPWNBUvPvpTkoLyEW2MeuOqNNXHNfhs85jf1ftz
         pqbwZeIXPxRt4psQfgOzTopIVFtUVX5qa/g6/UEQJ8L5ErMsh+5W75KfBX/okNW81LUV
         C6yCzOzBfhEaEFiiJsc7R+HuZnDe6ImBVqVxjaBSeqijWeZwgVML/R9r1WFNxzj8NNeF
         s0WMtwNMwvRe/+pbK/Rj2WlVMj7wv1HJVb/008kYfSCI9UqRKpW+9Ci2WlsQ0EAqUwbF
         Igbw==
X-Gm-Message-State: AO0yUKXOFfSk9Zy01Ppo0j1JSkWpEotBNHbM7Bq4eLVpwS9exFpV8yPG
        OUiudXHriNqKnXZzctP45w==
X-Google-Smtp-Source: AK7set+MXeUFUtWOYXoESItpHOi86+6ZLYrQddJXCu1lZhgin68dfwt9vEBhHA/wYZyRhB34XRDOdg==
X-Received: by 2002:a92:c9cb:0:b0:316:b0b2:beff with SMTP id k11-20020a92c9cb000000b00316b0b2beffmr90722ilq.4.1679071266001;
        Fri, 17 Mar 2023 09:41:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id i17-20020a056e020ed100b00322f4c434e8sm719716ilk.44.2023.03.17.09.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:41:05 -0700 (PDT)
Received: (nullmailer pid 2443655 invoked by uid 1000);
        Fri, 17 Mar 2023 16:41:04 -0000
Date:   Fri, 17 Mar 2023 11:41:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@quicinc.com>
Subject: Re: [PATCH v2 8/9] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add
 SM8550 WSA macro
Message-ID: <167907126181.2443521.14287104885709088314.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075445.17160-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 08:54:44 +0100, Krzysztof Kozlowski wrote:
> Add the WSA macro codec on Qualcomm SM8550, which comes without NPL clock
> exposed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

