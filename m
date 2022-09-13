Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9655B7669
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiIMQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiIMQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:25:05 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC42785A4;
        Tue, 13 Sep 2022 08:19:59 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1280590722dso33037343fac.1;
        Tue, 13 Sep 2022 08:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z89mWPQgEj+bFNuUETzl09lbcJ8fK7lana9aY32OiWo=;
        b=biCUkyDOmy6UXlrS6Iz7G2h2K1Ff/006BHz7qMpikBYriYrJrxed2BxQB7z6QFKOLV
         1UeF/akAeXhXG3E1Pd/aaonh3rktIwh2vgf9f9hbXMSeXjRoWGFxxBNthWpTR+gUMQER
         FohJcd1VX8JJPoYjeW+twM6qOi8TOW/0xDhdENRVdMSktNRUeA6VQaIlXNMR9kMtWx7p
         8NnIl8u8uBXVqWzo+aMRFwO1SdQfjmHa4VXgO1strzQg/v4zgu1iL8HkoRdaGc28+wPJ
         ufMyo1XLgjKbSc36SZm04EZXw3aovhE4fI57JMD3t6bPhJU6MdH89UB4uunqkfumOFjU
         iAaQ==
X-Gm-Message-State: ACgBeo1nwdOZIeD5iJlXPRT/1w8IYUmj3aDSAmwBFD1MjNwRQops+zE3
        MmrQEKuHs3+SdcHS1NsNP5MDSLX1qQ==
X-Google-Smtp-Source: AA6agR4lCuSsGKiNTAcDxjBdfJDxVs9EbEzq5duM8hDJIeBN2hjp6me10yqkowlyMPn5YePH1TVpRQ==
X-Received: by 2002:aca:b705:0:b0:345:c46b:f8f9 with SMTP id h5-20020acab705000000b00345c46bf8f9mr1753980oif.105.1663082290170;
        Tue, 13 Sep 2022 08:18:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t24-20020a9d7758000000b00656278f0427sm981368otl.75.2022.09.13.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:18:09 -0700 (PDT)
Received: (nullmailer pid 3734691 invoked by uid 1000);
        Tue, 13 Sep 2022 15:18:09 -0000
Date:   Tue, 13 Sep 2022 10:18:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: qcom,rpmpd: drop non-working
 codeaurora.org emails
Message-ID: <20220913151809.GA3734524-robh@kernel.org>
References: <20220911112508.202995-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911112508.202995-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2022 13:25:08 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
