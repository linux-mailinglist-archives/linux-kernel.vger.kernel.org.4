Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09066181B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjAHS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAHS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:27:00 -0500
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F4B1D8;
        Sun,  8 Jan 2023 10:26:59 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id m15so3860109ilq.2;
        Sun, 08 Jan 2023 10:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djoiJoKnxnBB932N12ythq1aAuOIIqboizxnwi72DtE=;
        b=ik6biH7zXB/Xxdzl7ah+7K9W+CGX8A/BsqmJQv8H1Jd2aCDHlz3DyuqTCKttZKo3/i
         Mrbbkj8qxYwCsRVo80vyu60gC1GCwky9f5jFRws73fMlm+FctjjywSH+haYJxxXGZ8Hy
         ukJLIngmrsa2/Sl/k1xpA94KeZTLpZ/gcaFI01M6rQsuoY8QZp4hZn/WJpSIPZShtT1d
         4zSOlCxT+TSSNCJradVlpIlAHF7rn2Geq2/lMPox2Uger0ppX2YqA8k1ICAI8efD64vS
         Fvn4BuQZJGjVgB2zSxWjPhMBtKTDnXTuIQbay/riUqFXNYrXpA1/wqS+ZS+FwZXpOheB
         JuXA==
X-Gm-Message-State: AFqh2koeu6TE+lur3HDwlEW3Xe7h+vNFlUISXnFWOkstKo+QBitHlBgz
        qRPkddNp5j30ulNXqcaAmQ==
X-Google-Smtp-Source: AMrXdXv65x2tssr4rgtR1Sy+YR2GBFe9EzZmy/NROHF+/5HwG2B2m7hRkY1UPVgcp4UuTD+doIQE8A==
X-Received: by 2002:a05:6e02:1d88:b0:30d:7cf4:5d5c with SMTP id h8-20020a056e021d8800b0030d7cf45d5cmr15259423ila.31.1673202418507;
        Sun, 08 Jan 2023 10:26:58 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id o12-20020a02220c000000b0039e5fa071a2sm1990405jao.173.2023.01.08.10.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:26:58 -0800 (PST)
Received: (nullmailer pid 172901 invoked by uid 1000);
        Sun, 08 Jan 2023 18:26:55 -0000
Date:   Sun, 8 Jan 2023 12:26:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 8/8] media: dt-bindings: qcom,venus: document
 firmware-name
Message-ID: <167320241527.172819.2869900832032049475.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:41:02 +0100, Krzysztof Kozlowski wrote:
> Venus Linux driver loads firmware based on firmware-name property and
> some DTS already have it:
> 
>   msm8996-oneplus3.dtb: video-codec@c00000: Unevaluated properties are not allowed ('firmware-name', 'interconnect-names', 'interconnects' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,venus-common.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
