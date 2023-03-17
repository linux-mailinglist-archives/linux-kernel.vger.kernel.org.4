Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654B36BEE90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCQQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:39:30 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB8B12F29;
        Fri, 17 Mar 2023 09:39:29 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id r4so3050097ila.2;
        Fri, 17 Mar 2023 09:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rQ9+73jAySThgRPKY/ryRE52NlmKjzcQhegQNs/GA8=;
        b=OH+CeoyymNGw/B+svOPKNS+I5IVCVhb5ceauor+5Ven2EFgV0hDbLg0J6/dEZEaOAZ
         +v1Kgoq71BMA5YJgUDAAbMQinsSx6O5vfQtr5YKDeUjsBXFm5wbr5m7KcLWtVmEB4oT/
         4YdtM8zj143r1EZwus7z2w6olf5T5OImz2m0INQ1kLMdP9pEvbIdJIKju2sFSrFu6IDq
         xpnBU3/KaiiM71EOoi741OuBfm7/ww0K/eUPEi5Ri2AfCc6ITi8YISiHN8KnhsJgGFIe
         NtnYM99MNvA7akkMX9+a+s+92CasebSrEnYeQxyRXLyYmcOAZK3C4V7u11ViIE+y976P
         MUwg==
X-Gm-Message-State: AO0yUKW3DJWFIK7I7WRtPaj9phF8ErnsvJQCNHB0/5kyhfhd9Z8DqxVO
        FKrHPuXaFLQVY//j9ZATIQ==
X-Google-Smtp-Source: AK7set8tqb3CenL36/9i8/AcgfphQMdCeKnYV5PWRNq2NDqSod0zyh8pu4zKWA8sbkkpDnYFYB0EwQ==
X-Received: by 2002:a92:ce46:0:b0:317:9c05:e8e8 with SMTP id a6-20020a92ce46000000b003179c05e8e8mr52337ilr.10.1679071168365;
        Fri, 17 Mar 2023 09:39:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t16-20020a02b190000000b003acfdc75a53sm825242jah.48.2023.03.17.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:39:28 -0700 (PDT)
Received: (nullmailer pid 2441539 invoked by uid 1000);
        Fri, 17 Mar 2023 16:39:26 -0000
Date:   Fri, 17 Mar 2023 11:39:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 5/9] ASoC: dt-bindings: qcom,lpass-tx-macro: Add
 SM8550 TX macro
Message-ID: <167907116579.2441463.2409932591661486938.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075445.17160-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 08:54:41 +0100, Krzysztof Kozlowski wrote:
> Add the TX macro codec on Qualcomm SM8550, which comes without NPL clock
> exposed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-tx-macro.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

