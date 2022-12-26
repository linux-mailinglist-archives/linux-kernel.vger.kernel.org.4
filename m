Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C25656580
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLZWhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiLZWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:22 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2805F9E;
        Mon, 26 Dec 2022 14:36:17 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso7284714ott.10;
        Mon, 26 Dec 2022 14:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4s4+/NGubPFhzsd7XtoobGhWqUUe1+gypHRvceHmmM=;
        b=srueWP36il2MaS25JViLeIjDqCbbgIJxrxbYogz+fWkzAWfkH87icZcz4F5C4Yhj7P
         S4mw6wACv2hXA5tZQDJEJuqhnLe1n0iRMBkOZXHAjMLV8dJwnJ7EutG6rlrqPaMxh55a
         cq+lhna0vyK4L6M5Fg30pRx1YkrwTn6HEla2jYUXFNzTGIJCEvcSAre/lRcui+tEpTmg
         JHV1ej6bQWzRb5DOZ1lhdUlDlacHrDa3p0qIG2NScaS5ZfaSxM1vyeGjT6SDFPnuy8MC
         8l1PEjI486Z4KvmEujK6FxCI7XGBsaYDQ8Hfi9HEPL6alybngTqj6rLSUV9ttxbnvF6d
         2oMg==
X-Gm-Message-State: AFqh2kp3NZMfrJ2QSl6DfdR1bPJ8jSGpLm/vIU+uhRuzqfXGmokW6QnT
        czXsd1w21GcL/v+rNdOrVg==
X-Google-Smtp-Source: AMrXdXteY2POYEe6IkXXvZpaoe22a821KoXOt+bj+IJzvYn5Ych70TfBfuIKmylmp8zVO4/VHtRS0A==
X-Received: by 2002:a05:6830:3886:b0:670:5e99:4528 with SMTP id bq6-20020a056830388600b006705e994528mr11789584otb.4.1672094176576;
        Mon, 26 Dec 2022 14:36:16 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id u20-20020a9d4d94000000b0066871c3adb3sm5882141otk.28.2022.12.26.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:36:16 -0800 (PST)
Received: (nullmailer pid 52110 invoked by uid 1000);
        Mon, 26 Dec 2022 19:01:11 -0000
Date:   Mon, 26 Dec 2022 13:01:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,spmi-clkdiv: convert to DT
 schema
Message-ID: <167208127075.52057.8007089147765275120.robh@kernel.org>
References: <20221223111835.37610-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223111835.37610-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 12:18:35 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm SPMI PMIC clock divider bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,spmi-clkdiv.txt       | 59 ---------------
>  .../bindings/clock/qcom,spmi-clkdiv.yaml      | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,spmi-clkdiv.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,spmi-clkdiv.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
