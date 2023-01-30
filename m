Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2286C681988
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjA3Slz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjA3Slk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:41:40 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BDFD;
        Mon, 30 Jan 2023 10:41:40 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso4775864oti.10;
        Mon, 30 Jan 2023 10:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU2+lFL8KXnb9RT45XBhXq8ZrCERZRKmVeI/JNeDdKQ=;
        b=XNBiVuMbHGwlyWwHPSGnA9OdaOW6ovcYwWYuqaZbDPNtsc7nKeV5ZA9874fkNtBRyy
         boTJtkuj5W4wDZTeIJdkGfqkECHYK5dMKxxy52teFgUEpk5lecj/N1XFzlboAjxmkbCI
         wweZF/tegHGvFfjwna/zmsyobR6/pIx2ALjccO8/sQdgnKUiPr8HdukyGGtetFLnJJRA
         48YJZGQhFG2Mqd/42VYOra6DB99e3rJNy4hVeAmeh5RGtOI8zWz6oGq+XEnlmV5dchbF
         zxpiQfENh/5ELvjCC/mJxRdmNcR0U0WvKQXDd9YKO/TKRftAaB4X8KTbLGrRtBnL3KyN
         g07g==
X-Gm-Message-State: AO0yUKVX6Z+BDlXQWQfeuwnlNaPw6WbmBn94VKFDF7KX5FnrwBP2shG8
        t6hFMjUSzOziKI1FgG1x2kvphMqGrg==
X-Google-Smtp-Source: AK7set/uLbNflW1cFghxIZz5MH8dz6piD9fmGR1Yw/at6BG3CTVUtPBg5w/AMqTWqSqeuODiozv89A==
X-Received: by 2002:a9d:6f17:0:b0:68b:df3e:c40f with SMTP id n23-20020a9d6f17000000b0068bdf3ec40fmr185279otq.23.1675104099536;
        Mon, 30 Jan 2023 10:41:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j1-20020a9d7d81000000b00684c9c77754sm5670709otn.69.2023.01.30.10.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:41:38 -0800 (PST)
Received: (nullmailer pid 3094271 invoked by uid 1000);
        Mon, 30 Jan 2023 18:41:38 -0000
Date:   Mon, 30 Jan 2023 12:41:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 3/8] dt-bindings: phy: qcom,qmp-usb: Document SM8550
 compatible
Message-ID: <167510409756.3094208.17002699446729168546.robh@kernel.org>
References: <20230126131415.1453741-1-abel.vesa@linaro.org>
 <20230126131415.1453741-4-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126131415.1453741-4-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 15:14:10 +0200, Abel Vesa wrote:
> Add the SM8550 compatible to the list.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> The v2 version of this patch was here:
> https://lore.kernel.org/all/20230126124651.1362533-4-abel.vesa@linaro.org/
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * moved to sc8280xp bindings
> 
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
