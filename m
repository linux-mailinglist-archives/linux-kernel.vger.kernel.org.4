Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0554616AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiKBRhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKBRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:37:37 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F92E680;
        Wed,  2 Nov 2022 10:37:36 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l127so3540500oia.8;
        Wed, 02 Nov 2022 10:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftRx1K2cF82HFee+HCYYE4a4Ril4i3Y5BOpEwEJzCU8=;
        b=I6v1n35f5VTQJEYxD12R/HcbfStLxBu4TfWQOyEmVcxTU4knHTXs/Bj6rtSvi1t07D
         3EwJ0YkRvdLmSCb/FA5HAKRi3FHX0E9nX6b/jZg/OlfOdRYnLK6dbARWlapbp565p8vd
         Scd9bF8ZXMntbsTUN+AZ4nUhAmoFY7zHorajckiwVvVj/MixYjF31knxeSbBRyaFTYyL
         43l5lLBsj2Jd2g58lC0savw3QyZPsK5MiWsGIeOBrqq8nR5ywo1+4KsWWf09+sd6+snP
         fmWDeDCf3kqzizBZihGdoJYevIKCqOWE8wdYNClVmqP2h/aAjMftsfFZ/T1ZtooGoEO9
         q6BA==
X-Gm-Message-State: ACrzQf3EK18Fyw0QBypeQjAJvBbNv2iHBQ+O6t0/D7dPWhx0hyjC3Cin
        p+MiS7qKsU65Rkdk/U2gtw==
X-Google-Smtp-Source: AMsMyM5JTmQhxNjG7ItyUeS8hhJ5F6jd3b9R9T12OSXuAnqZpCUSLa0V8ha+VyS6aPK6IkJFFXy4ow==
X-Received: by 2002:a05:6808:14c3:b0:359:ac8d:41e2 with SMTP id f3-20020a05680814c300b00359ac8d41e2mr21297701oiw.92.1667410655628;
        Wed, 02 Nov 2022 10:37:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020a4aa88a000000b0049bdee12662sm2441426oom.6.2022.11.02.10.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:37:35 -0700 (PDT)
Received: (nullmailer pid 8357 invoked by uid 1000);
        Wed, 02 Nov 2022 17:37:36 -0000
Date:   Wed, 2 Nov 2022 12:37:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] dt-bindings: firmware: scm: add sdm670 compatible
Message-ID: <166741065625.8306.7344078584788460733.robh@kernel.org>
References: <20221101235722.53955-1-mailingradian@gmail.com>
 <20221101235722.53955-4-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101235722.53955-4-mailingradian@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 19:57:21 -0400, Richard Acayan wrote:
> The Snapdragon 670 uses SCM as for PSCI power management. Document the
> appropriate compatible string for it.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
