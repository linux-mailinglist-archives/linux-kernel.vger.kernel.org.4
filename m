Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8B6BEE97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCQQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCQQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:12 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A47D16ACA;
        Fri, 17 Mar 2023 09:40:10 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id s7so3032861ilv.12;
        Fri, 17 Mar 2023 09:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v33jTujTH/OFC+DJVoBM0tNLHgECUl0wsEd9HZhpYyc=;
        b=n0cLhgO1skPfDL29WqYrRdvSWhegjS7oe0dNPWqPuFnehycmglmJhhstwP4Ms3jPn1
         ucTbmkWu3esXJR1cA7adgFnLRNePqWNez99F4NpETbNK6VTAwOqkDaZUCPZQtDUigQHJ
         7DGjfZxkye+Qj3knc2utmjHD6NK1hfzPVCpsYxJmul8hwWDR1OvD+OtARt22r13heZ0C
         5ymQiUlAY8voGKLiSGk9xaRpjDoscLOeaEl252P+CXGdK7/13FxBToXVkKPmOeqdQT8L
         ibKssNWugjXX8gxph86bQxOZsByg4msZRNOzuiOw/zoktUybYM29PbVVWp1s5NQK0l8f
         e75w==
X-Gm-Message-State: AO0yUKXsqs+TWyty/Eyx32eZEFdzwZ+T1BP5ri6OAlXNHHRjJkXvKlgS
        6YmVl814D9ckOf4N14Gyr6pMet5YfA==
X-Google-Smtp-Source: AK7set95yeMjd43ZHB4zet+gvJIkbO0gPEKt9Jexe55AqlrQLHHNTXz4/AEJcZr+bcE0kI7TXg9mgw==
X-Received: by 2002:a05:6e02:4c7:b0:315:498b:415a with SMTP id f7-20020a056e0204c700b00315498b415amr31499ils.18.1679071209632;
        Fri, 17 Mar 2023 09:40:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r23-20020a02b117000000b00406328003a4sm815346jah.65.2023.03.17.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:40:09 -0700 (PDT)
Received: (nullmailer pid 2442436 invoked by uid 1000);
        Fri, 17 Mar 2023 16:40:07 -0000
Date:   Fri, 17 Mar 2023 11:40:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2 7/9] ASoC: dt-bindings: qcom,lpass-va-macro: Add
 SM8550 VA macro
Message-ID: <167907118259.2441907.2410899318611218643.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075445.17160-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 08:54:43 +0100, Krzysztof Kozlowski wrote:
> Add the VA macro codec on Qualcomm SM8550, which comes without NPL clock
> exposed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on:
> https://lore.kernel.org/r/20221118071849.25506-2-srinivas.kandagatla@linaro.org
> ---
>  .../bindings/sound/qcom,lpass-va-macro.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

