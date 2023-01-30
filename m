Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA806681E57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjA3Wq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3WqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:46:25 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEA512F3B;
        Mon, 30 Jan 2023 14:46:24 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15f97c478a8so17113972fac.13;
        Mon, 30 Jan 2023 14:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEtQmTt9bM8H1V7Y2EV7hXdEVHD1SEcbjnr5kuo9pLA=;
        b=1LgBz1Dc3VIBRsuXjMHPnrEEqOu0Vx6YP/CklfAfZ7zs5Bie/p36Ju7/nYmO6FAAYu
         Q2bg6+gAXPQvNgcyORZUv7iYXLySI6gOo9CNCIUSgt3hlMPfrtTmNq8g23VIm1ZP6Z5Z
         iE8teacIj3aVu4uPd1z5XYAU933JQtuKC8DlWmyVzK02DefC5ymzjZb8UKAF065GaoDA
         1AvQCfvGnQ02zd5pEIPw7Mc8g2raW3sFlZENoIAltfpPmmY0/Pukz6sbeh4QcTbI+w6g
         26Xw0Brv4S1D4Jv2XmlwV6NhhupVvBoGBkSPooOPHSGftn1lZ4rpJTBwN57WaZ+9jO3F
         zvzw==
X-Gm-Message-State: AO0yUKVPuT5+PgWDfQCjwAf1lascwrENvh4CHnLXtsZrn/dObTkLlx8E
        20U2ySVllV0Jy1sA61BvBNcunglmmw==
X-Google-Smtp-Source: AK7set/9jEAmE2/BNbo4U7WMTkO0Qm5wqjjHhie2NzjEOMt6O+hvp3BMzLH+htECYKfEF6PnXVvvxw==
X-Received: by 2002:a05:6870:4390:b0:14c:6a72:499a with SMTP id r16-20020a056870439000b0014c6a72499amr5372882oah.39.1675118783653;
        Mon, 30 Jan 2023 14:46:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a4aa98c000000b004a0ad937ccdsm5471167oom.1.2023.01.30.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:46:23 -0800 (PST)
Received: (nullmailer pid 3664772 invoked by uid 1000);
        Mon, 30 Jan 2023 22:46:22 -0000
Date:   Mon, 30 Jan 2023 16:46:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM8450 compatible
Message-ID: <167511878204.3664715.1713936885782546679.robh@kernel.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v1-2-0b0acfad301e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v1-2-0b0acfad301e@linaro.org>
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


On Mon, 30 Jan 2023 10:54:33 +0100, Neil Armstrong wrote:
> Document the SM8450 compatible used to describe the pmic glink
> on this platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
