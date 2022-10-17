Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398566016C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJQS7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJQS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:59:03 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425A753BE;
        Mon, 17 Oct 2022 11:59:03 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id g130so13144415oia.13;
        Mon, 17 Oct 2022 11:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vV32roC8QGzARBYQiz3s/fUjLlQrlAPOTqGTgJcRG4=;
        b=d1+yBoxs/xuM+ZIIbuSKyliYF8meQFOcpMd7axTtcV4+zfzUalszC9xSOA+tsieeaE
         PgTFXdtX1AU6/Zq7lNgajV/TT8BMTEnm6YvJa5e/b5hlOOrj6SJC1Y4S/R4A0kZSSp+2
         Y1sXpSXQhIov8DDQqS8GoxUs0APPxnS+dLHoQ9HbpD/FGTK/2Y76vKVv0Ps0ymoumsfT
         WiGVur5jNvkUvyLpi/g5C/dtxOE1wQCRLFuG+/C2F+VSHm46qQmXnWY/MDE7vEgADacN
         1p2d3YQpvfHuQMzo/zhr5rG9E93epfK9wTL9ZNLc9kPscxeYNP9aqnV6OKwd9acmd6sA
         u/1A==
X-Gm-Message-State: ACrzQf2jkQACdj2zc5AeiS+fj7LCvzh4OscCWUeyVn9DT01PnNXtwbBG
        kabBHLt3MRgQCuo0OrphTA==
X-Google-Smtp-Source: AMsMyM6m6CDm9Jv8erVCI2tz7eaLMcp3RE9hGAbUtR1C5H5Cl07JUE9GjF1ijTBqyJVp9cwZ6N0spA==
X-Received: by 2002:a05:6808:11c7:b0:345:7251:7276 with SMTP id p7-20020a05680811c700b0034572517276mr5615625oiv.5.1666033142273;
        Mon, 17 Oct 2022 11:59:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d6e12000000b00661b46cc26bsm5028071otr.9.2022.10.17.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:59:01 -0700 (PDT)
Received: (nullmailer pid 2281284 invoked by uid 1000);
        Mon, 17 Oct 2022 18:59:02 -0000
Date:   Mon, 17 Oct 2022 13:59:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-rtc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 05/11] dt-bindings: mfd: qcom-pm8xxx: document
 qcom,pm8921 as fallback of qcom,pm8018
Message-ID: <166603314201.2281230.8294091560079145147.robh@kernel.org>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v3-5-531da552c354@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-5-531da552c354@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 11:45:30 +0200, Neil Armstrong wrote:
> The PM8018 is used as compatible with PM8921 on the MDM9615, document this situation,
> and an example section to validate this change.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       | 33 ++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
