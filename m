Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2534E6EE7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjDYTBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjDYTBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:01:35 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D849D8;
        Tue, 25 Apr 2023 12:01:33 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-187949fdb1cso4699951fac.0;
        Tue, 25 Apr 2023 12:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449293; x=1685041293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1u0cCbUXzH7qiPF1I+5foUb5gsXy+f80Q5byZwNLdM=;
        b=ZeyQJtEOd5gHCjWkCg0AtaCESlnUwe5CFGZu/YBXKOlsXp7MuKAdrXbkUpISKAfHFM
         7JhDfubAopXNOQ2+CyZfJEdBTnk0ELXSSdm8FoTqOMpjgDnfWrvGEPexU2Ugam47gVlN
         e05GOiH3zR14h6yFYoAgDYRVrI6NI1tP9iO8nffjy5ppbvRqI5MNEE3eoE6X2C8OYk9b
         PbRwnkiJDbFfVY4pvg2Y7+8FK+m8w3ZKRs/eD2u9H62qz6BUh2796a1YO/MaYMwqggbA
         Sxv4bgdmOeX9vMa+Q2oEVox1COei5C86YXM8GIAA9X0OJ49lZ9RK36XOtzCEZo+cImkg
         4Akg==
X-Gm-Message-State: AC+VfDzRnn55qjj/GCoP0GXL5UYLKAorLCJ6QQC8eKz9QpdHDltNdmSw
        2IPXej3b9fuLN0pgatTvsVYhXfz7+Q==
X-Google-Smtp-Source: ACHHUZ4Jn7kJ8s+qBM41oRwhYY5dL6y6or+OXTP5pm4bL15yF9Z0NMGQPtNx3cb9M6GBpM91Lv7yXg==
X-Received: by 2002:a05:6870:e0cc:b0:18e:e33b:ec00 with SMTP id a12-20020a056870e0cc00b0018ee33bec00mr940168oab.52.1682449293096;
        Tue, 25 Apr 2023 12:01:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s21-20020a4a2d55000000b0054157801d51sm6233680oof.38.2023.04.25.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 12:01:32 -0700 (PDT)
Received: (nullmailer pid 2089441 invoked by uid 1000);
        Tue, 25 Apr 2023 19:01:31 -0000
Date:   Tue, 25 Apr 2023 14:01:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_kathirav@quicinc.com, andersson@kernel.org, agross@kernel.org,
        mturquette@baylibre.com, quic_srichara@quicinc.com,
        sboyd@kernel.org, quic_sjaganat@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, quic_arajkuma@quicinc.com,
        robh+dt@kernel.org, linux-clk@vger.kernel.org,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 2/6] dt-bindings: clock: qcom,ipq9574-gcc: Add
 maintainer
Message-ID: <168244929071.2089337.16182607246447553484.robh@kernel.org>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
 <20230425084010.15581-3-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425084010.15581-3-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Apr 2023 14:10:06 +0530, Devi Priya wrote:
> Add Bjorn andersson to the maintainer's list.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
> 	- "Drop bias_pll_ubi_nc_clk input": Reverted the changes as
> 	  <0> entry is added in place of bias_pll_ubi_nc_clk in the DT.
> 
>  Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

