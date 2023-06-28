Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20057415A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjF1Pu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:50:28 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:46478 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjF1PuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:50:24 -0400
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-78363cc070aso2275739f.1;
        Wed, 28 Jun 2023 08:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967423; x=1690559423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLQv79sJE7S4tWUBkkIAujP4Kn0djoVfryatFW5MJhI=;
        b=eoUl/V5Up32UJUomwpEzhjuCP0B67f/aJP34nCKktn8hZG6bsomO1pPUFX7CYUW9e+
         9Uwt1XvAI4CuWDqwkdvtyaEFXJ8tJ3g8DReJ59XvI4wI123PHTtJzGGucjaTQri6t2mF
         mRpctkatZPXbvZAzxCQam19p57SEdJGM7zNs6Wm/LPzBq22GqRJj/mWO2WBnWzc5yMdJ
         jC/npk301hGcSg35CHvGxBAmwHGNBms+vlo7y0Y7H2QG6l3RQzKt/R3TeiHHxUbhFu2D
         HHy1MMpCRLyje6gNpQeVAfHtoYMr2oLjLpftmCAd4jjm36PQZL85/s3BY/uSR5negPXS
         RhXA==
X-Gm-Message-State: AC+VfDyadaeaNoDCC0BMvfRr41gt6AyZ2s5RNgfSOsd46vnsDw0ZOZqv
        NAiMzs9xmQPbe/YTMDK+1UyXthqIuQ==
X-Google-Smtp-Source: ACHHUZ5RqzYAkoyGx9J9K9evNG0Il0MvfBax/rK0gOcUrtpBisU6MLQoliHUYiQ9BeL+y3KvCQM0Cw==
X-Received: by 2002:a5e:c018:0:b0:786:2706:ecf6 with SMTP id u24-20020a5ec018000000b007862706ecf6mr1003351iol.11.1687967423001;
        Wed, 28 Jun 2023 08:50:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c17-20020a02a611000000b0040bb600eb81sm3247408jam.149.2023.06.28.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:50:22 -0700 (PDT)
Received: (nullmailer pid 536791 invoked by uid 1000);
        Wed, 28 Jun 2023 15:50:20 -0000
Date:   Wed, 28 Jun 2023 09:50:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Imran Shaik <quic_imrashai@quicinc.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Update GCC clocks for QDU1000
 and QRU1000 SoCs
Message-ID: <168796741983.536728.7220713393187676699.robh@kernel.org>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
 <20230628092837.3090801-2-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092837.3090801-2-quic_imrashai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Jun 2023 14:58:33 +0530, Imran Shaik wrote:
> Update the qcom GCC clock bindings for QDU1000 and QRU1000 SoCs.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
> Chanes since v1:
>  - Removed the v2 variant compatible string changes
>  - Updated the maintainers list
> 
>  Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml | 3 ++-
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h                  | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

