Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B569E3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjBUPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjBUPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:43:34 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6097AB4;
        Tue, 21 Feb 2023 07:43:33 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1720ea61e29so5570885fac.12;
        Tue, 21 Feb 2023 07:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+9xiI3UVlHjuS+MWpZRmcoMLLLOXy9JHT1NR0U/EA8=;
        b=JI210hJ1Em2BFNs/Z32ePnjaQx29Fr+oFu6J52J5FoB97PWh9MqpHrcIg/pXlPlY7h
         q5c0JDg+KVf4sf82P7uwg042yeIUuozfXi8iajtF6eYly2v68ik8t+qamVtc/142ls5T
         gRHRabi/a8iGJ+gbuERTP7Ui//FVGuwryq0Xv3OhcLyO5zqS0CQd+KaDSL0GdCaD/5AH
         I00C2rX76DhBmwMRoy9FJhCYivE7MrRUAx2O1Xj4jCQyf/cUfNbvPwYbrjAjzmVWgjAC
         2QlTmq25tn2RhQWJLIZfvVCXm8Nor0fmAfryfp9zak+smOQzkJoIscurIqoW74xHdVO8
         BtUQ==
X-Gm-Message-State: AO0yUKWkkcTYIRCoVc753BI5u5VXogLC9LH68vpajlcdjmV7tHj1sufI
        LIaAwiNpuTSGu9MW1sskDg==
X-Google-Smtp-Source: AK7set/LnRQPKKczNGO0zyZKysK6CC7kRbjgoTB9aYV1CEanHCh9l+x0tND5tFhKDd5DdzhFHHSegw==
X-Received: by 2002:a05:6870:b620:b0:163:58e8:77e5 with SMTP id cm32-20020a056870b62000b0016358e877e5mr8734321oab.52.1676994213173;
        Tue, 21 Feb 2023 07:43:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a05687042c600b0014866eb34cesm5304619oah.48.2023.02.21.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:43:32 -0800 (PST)
Received: (nullmailer pid 2589941 invoked by uid 1000);
        Tue, 21 Feb 2023 15:43:31 -0000
Date:   Tue, 21 Feb 2023 09:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,wcd934x: Reference dai-common
Message-ID: <167699421150.2589878.754040795776366251.robh@kernel.org>
References: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 20 Feb 2023 10:56:42 +0100, Krzysztof Kozlowski wrote:
> Reference common DAI properties to get sound-dai-cells description and
> allow name-prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

