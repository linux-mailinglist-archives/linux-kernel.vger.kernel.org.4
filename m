Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A35F342D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJCRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJCRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:08:02 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB282C107;
        Mon,  3 Oct 2022 10:08:02 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-131ea99262dso11399917fac.9;
        Mon, 03 Oct 2022 10:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/ocSkOjIvslSGSMzwQS7IARV7Jn+LcTl1IKtR9M6ewc=;
        b=k3SHRF75JS70BpWciWzXsCLHugeiRY3FmeldcLbAkYQY8DxlrzDV2MDqjv+3OFSv88
         axA1p23ZfVaJQDo+Z8itUSzMgXxJFwNKO12ZyLqD8qBV+zPXuBZstsiPdDNsz9dzkyrk
         NbGy5Vs/pPH8BUIfL95X8YyTYBdjgwsIpcCjcscW8VxysKE1AW+gpj5Fb/ELkHNVSlj3
         Oae74oE3cm9AEwXCmMJmplypFwcg7wY+6PqSvyVQijTkK6G7G6YkyT+AOchEa8I2jzAo
         CB+oWAkFnradigzirSMm3knXW89Ngq82FwFPligwEjBLRXwyVklOLm6Q6PPM31TVxraD
         GKxw==
X-Gm-Message-State: ACrzQf1Ag+zxUe8fCcXMHhCtVWx9QWSzc1yJ8Rr3/ZNwk3Rj4LUgHwWB
        8/tIXvY0TdSCn6jSUfiZfKh0wDAaSQ==
X-Google-Smtp-Source: AMsMyM5pv5WQlEbrR2N4Kar/5UncNwai4QQjl7E5gB/AR3wGk/pwyhENwS+PKtsolWkqu+OSarTuzw==
X-Received: by 2002:a05:6870:6325:b0:12d:3605:dd85 with SMTP id s37-20020a056870632500b0012d3605dd85mr6045142oao.227.1664816881505;
        Mon, 03 Oct 2022 10:08:01 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bu27-20020a0568300d1b00b006339b36127dsm2492997otb.3.2022.10.03.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:08:01 -0700 (PDT)
Received: (nullmailer pid 2456596 invoked by uid 1000);
        Mon, 03 Oct 2022 17:08:00 -0000
Date:   Mon, 3 Oct 2022 12:08:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 12/16] dt-bindings: pinctrl: qcom,sm8250: drop checks
 used in common TLMM
Message-ID: <166481687992.2456542.5477808647809948960.robh@kernel.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-13-krzysztof.kozlowski@linaro.org>
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

On Fri, 30 Sep 2022 21:29:50 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema brings already
> requirement of function for gpio pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
