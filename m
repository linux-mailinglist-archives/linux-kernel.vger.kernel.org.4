Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8563FC8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiLBAJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLBAJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:09:00 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627E2CCEC9;
        Thu,  1 Dec 2022 16:09:00 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so2027572otb.1;
        Thu, 01 Dec 2022 16:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HssPrVTZjEipCI/4aT7NF6m5CrrPoRuTr+9Y8kxknAQ=;
        b=OwlicpdE+tXMhKtRL8uU8NwtPlox4Urj1aschnc5AOGp+WhHsIoqnRSQ+pT2UHfdhS
         6qXp7cXSSvLZz+nWDzKOGymbrRIbpPQfUh813+tcri48VGWcYb73aAmLQZ/73P5Qb3Bz
         wFtz9UZaqQM0GAlbNui4D9MTAFSrnO54nQpjB6Lijx79E8+UCdzdtsrx8U++DLOj/r7W
         EiZonRX+OaZaDG4ecG3LRaTYiJXF+atstD65NFpQ1Glw3yT9li4598MJjozik9A2zILw
         L7hF3IbRauv4GgRNe+gJ++6LoKx6xc/kONxceBi/ZHmcTz7bkOZsL2datQbtE/w28TTe
         tL1g==
X-Gm-Message-State: ANoB5pmDeV9QPpiA/Ep/Mg/b0FVpajoSEyF6BcgXsQ0ZK5/OWWRalw3M
        YRHd5q+6ouFPVjCTA8OFfA==
X-Google-Smtp-Source: AA0mqf7JTgDeAUY2oj6yLJ9N14fNuDURF1Wef3u+zBRSmtYdSLKwErQ+faMF3oy/Z8bgVMDLkEfqAw==
X-Received: by 2002:a9d:2c42:0:b0:66c:754e:869b with SMTP id f60-20020a9d2c42000000b0066c754e869bmr34046461otb.198.1669939739632;
        Thu, 01 Dec 2022 16:08:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f14-20020a4ad80e000000b0049fb39100a5sm2299024oov.37.2022.12.01.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:08:59 -0800 (PST)
Received: (nullmailer pid 1737713 invoked by uid 1000);
        Fri, 02 Dec 2022 00:08:58 -0000
Date:   Thu, 1 Dec 2022 18:08:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Message-ID: <20221202000858.GA1737135-robh@kernel.org>
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
>  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
>  3 files changed, 61 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

Or should I apply it?
