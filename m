Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB066E411
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjAQQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAQQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:50:31 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A779EF2;
        Tue, 17 Jan 2023 08:50:30 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id cc13-20020a05683061cd00b00684b8cf2f4dso9954474otb.12;
        Tue, 17 Jan 2023 08:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvuc6TjM15pVEhxNJlvL+6pzxQbFucyexQNcCZt/Obk=;
        b=rQO0yBRQL5IzvAXRDYD0NagQ0qxsED/a19oVCb/nWMCjfkmekNgUluiONqIxFLOYF1
         Z+5NF6Ny/GCXoQArz6lyKlCQJHdxKNwBuI+BZ70MlKq/1hjMYdEyFooCoYKnKBK/w4cM
         mNCQeF8qMIHkIvWCmCpzpIw9rkr/miLRTJvxpQEt3OJUYcPH6DP2Szm0O7oahgSW1cvf
         qH2BCSb4D8ndHmaKENMBtIx0WjpXL3WBM/GdbFhoSBqGoI59H7REQyTU2bkXBWvQREnk
         h3ke56R0zsYVDMtWWZ8g3r9VTd3SFyfN3nFIUQu7T3L2/NiDsIvwbRP0iVQM7b/uqnZq
         HfPQ==
X-Gm-Message-State: AFqh2kpbCGZN5o01qyI9pwoMs+9UerdfsYQTZZVW5H4AC8fO51jF1Y+7
        rK6KYBS6D+999Yg3y629NQ==
X-Google-Smtp-Source: AMrXdXtpRB/FOy6cBnSBXmhohKcCcDRGTsqlFyeZQjY+LjpTHV89nHl1JhdrJ+trknfsrI4O7z/HjA==
X-Received: by 2002:a05:6830:1498:b0:67a:1598:de18 with SMTP id s24-20020a056830149800b0067a1598de18mr1901579otq.6.1673974229623;
        Tue, 17 Jan 2023 08:50:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g2-20020a9d6b02000000b006864b75be16sm987912otp.19.2023.01.17.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:50:29 -0800 (PST)
Received: (nullmailer pid 3224869 invoked by uid 1000);
        Tue, 17 Jan 2023 16:50:28 -0000
Date:   Tue, 17 Jan 2023 10:50:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: clock: qcom,videocc: correct clocks per
 variant
Message-ID: <167397422754.3224805.16727826269476784233.robh@kernel.org>
References: <20221224154152.43272-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224154152.43272-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 24 Dec 2022 16:41:52 +0100, Krzysztof Kozlowski wrote:
> Different SoCs come with a bit different clock inputs:
> 
>   sm8250-mtp.dtb: clock-controller@abf0000: clock-names:0: 'bi_tcxo' was expected
>   sm8250-mtp.dtb: clock-controller@abf0000: clock-names: ['iface', 'bi_tcxo', 'bi_tcxo_ao'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/clock/qcom,videocc.yaml          | 59 +++++++++++++++++--
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 

Applied, thanks!
