Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB05ED1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiI1AZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiI1AYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:24:44 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DC1EE772;
        Tue, 27 Sep 2022 17:24:17 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1319573379eso2569085fac.0;
        Tue, 27 Sep 2022 17:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=emvP3YSyBpP+FskRt08StkDM9pRDZiCrhQHQG+rB6FE=;
        b=EhHggIDLqL80WrsFZKlV/oOO60fajlo8901b9RQ1j/t94fDaFmqudzPLRcGTNjqgaE
         2hVNQ+oMGnHdyupjS1ehvuSVy7ammRVfbdO3N8dRdv+X6hAWMIfcAxDFw/CD8vQQ4Xdb
         9+OJ0dZGUh6nrrOxiJxDPweS2lbnr1XZDNRM2L796AWDYQSvlp+thh2F2zuZvyqarrWN
         4rwvt2Pj4/c/5hGc7R2MHIQWc3FquexOkO0Z+USUlp3oP4DjfRmQzoPhJt+wNWU7jcAd
         wxFZSymDBH3ugblLckG04JNxCMrpoLwyAL6UixOALzS7OML1j3qM9/X38umjJKb24siz
         mE2g==
X-Gm-Message-State: ACrzQf1UYBAGYlDyT8fB0YCnA69AKeqZCVx/ab9FTE3gNo/9YT4Jxxhm
        MBqOtS56oQKp0/0M2ZxPsVSI9MMl0w==
X-Google-Smtp-Source: AMsMyM7eOVxfo8/++Dna9DjiLq5ihgEzlcXt3mZaOCPGIdA8MtwTkb0E0zydywZ0B8nz+65TCQ0hBA==
X-Received: by 2002:a05:6870:4184:b0:131:55a3:2fef with SMTP id y4-20020a056870418400b0013155a32fefmr3751387oac.223.1664324652219;
        Tue, 27 Sep 2022 17:24:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i42-20020a056870892a00b00127a6357bd5sm1690605oao.49.2022.09.27.17.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:24:11 -0700 (PDT)
Received: (nullmailer pid 2708319 invoked by uid 1000);
        Wed, 28 Sep 2022 00:24:11 -0000
Date:   Tue, 27 Sep 2022 19:24:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 34/34] dt-bindings: pinctrl: qcom,sc8280xp: fix
 indentation in example (remaining piece)
Message-ID: <20220928002411.GA2708263-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-35-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-35-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:37:02 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.  Previous adjustment
> missefd one spot.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
