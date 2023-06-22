Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56177394FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFVBzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFVBzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:55:47 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8FD1728;
        Wed, 21 Jun 2023 18:55:47 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-780c8df59caso23074739f.3;
        Wed, 21 Jun 2023 18:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398946; x=1689990946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj9exNxaidLj6LcNK8tVeAT6pbRlNgwUovbHIdRSfsI=;
        b=b67BAt1IFfirk+UNsMz0LH9RdcwxUC2ygHXZ1+QPGlDPP7ovGoBTkuXabpxnb4yZgm
         w/FEzkRGwsN9AWL+cY4544Zx0GVEER1Yb7/BmYlq6TwqqW+S6A/KlEw6euhpEEEQDC4n
         v38Mz6NrQBHAEUIjcrVAd2a0UShIm45+Gj65aYDSVot1PP/YX2+9lDAuDPheSUDcHM/Y
         3lIflHkiyY80FeknzLWAR/1trqN7G+vYBA7hv6bMa2bn/FEUkGkhtghDrUKAm4PYfmC4
         I6dszmbumdOPxiTj3zlwFzCaKHi3QkOSxafTpneerbN3itY0neE5a1gEiT9pJr73ciJI
         gs4Q==
X-Gm-Message-State: AC+VfDwN3XH0Zf2afp0CkrAH3dEf6KhxaoUO+/3QtwrHgizQz7KLV/Ws
        bH3fBictfQtrfL4LE44zAr97b24z6Q==
X-Google-Smtp-Source: ACHHUZ6w20XPuVngkj/XmETLkcCG1d7IpDJWIw84E9Aa0XnxTP2tqVb6Jf1PhWm4wc06Lutti4v4dw==
X-Received: by 2002:a92:dcd2:0:b0:342:8d31:73db with SMTP id b18-20020a92dcd2000000b003428d3173dbmr7061039ilr.16.1687398946508;
        Wed, 21 Jun 2023 18:55:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n14-20020a056e0208ee00b00342612c48f6sm1719040ilt.53.2023.06.21.18.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:55:45 -0700 (PDT)
Received: (nullmailer pid 48109 invoked by uid 1000);
        Thu, 22 Jun 2023 01:55:44 -0000
Date:   Wed, 21 Jun 2023 19:55:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,gcc-sc8280xp: Add missing
 GDSCs
Message-ID: <168739894369.48049.5336113390716480314.robh@kernel.org>
References: <20230620-topic-sc8280_gccgdsc-v1-0-0fd91a942bda@linaro.org>
 <20230620-topic-sc8280_gccgdsc-v1-2-0fd91a942bda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-topic-sc8280_gccgdsc-v1-2-0fd91a942bda@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 20:54:59 +0200, Konrad Dybcio wrote:
> There are 10 more GDSCs that we've not been caring about, and by extension
> (and perhaps even more importantly), not putting to sleep. Add them.
> 
> Fixes: a66a82f2a55e ("dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  include/dt-bindings/clock/qcom,gcc-sc8280xp.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

