Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF115B88F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiINNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiINNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:18:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93265F7C5;
        Wed, 14 Sep 2022 06:18:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dv25so34584572ejb.12;
        Wed, 14 Sep 2022 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=kfvXVqNudd9zQNwj3Mp5VEuCU5yPNKUN+snJhZsLeSQ=;
        b=j94l6scxrToyKCIM6uPXoTKDQ6I4H8d7FiqIj9zUF6jHLHhH0Ion/AzPU7Ey8zpfmn
         hEMxeqZlCOuXR7iKC5mTZgwYe4hscjC0QRP2fwhqH2qcUlWVqysSgSCNltZ2Ahtu2uqz
         ifxe6VGB0QN1jSZJNvOADRFNuGx4FcdRReEMSCgzAX9RNeyop70A8wkYWI5qdi8X/1ev
         A773F19gEAQUpENXY5ajU9g8BKBqywjwmlLXSVbzBc0Q5RykTJCn31gXZXixajCx60Iz
         /5veokORb4acRXBSoHXoH7mjKADms40V2R10OjPfk0b62wxmU8Qkzic/S7pGunderW5q
         xJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=kfvXVqNudd9zQNwj3Mp5VEuCU5yPNKUN+snJhZsLeSQ=;
        b=IX9YJjW7uWgpkvtSh/9ndrkWvcOq7NXH5RaOVN+qdV1VyuJgNQLauViopIJJ1xFC/A
         OWYypS3UlVTFxaQUuZTRoxVWMgCgD3Rt1k/MNnqwBqkezWL7wYUkmjVcYzI1xYOQtZfX
         TEN+fDrTLUVrYFT220qgSPcqJtfXuxxH+/QqgX11CKwI/h01zuwO4I89AOTikG7ejlB/
         FyFlFro8qBO0tQf/FYNBE22Wv4xj3557l7EPe16Mmm+T/DkDhnzAts2tiBNJ4J9XdhRg
         CgoH9gs/1QRkL7imS8PtC5vzDAXPxt5408wG9YKo6OzuCFDZRuol67nqJl7v3wMyOnAd
         r/KQ==
X-Gm-Message-State: ACgBeo2P5FJ7sx+gAo+wwahwga51XlLDiBSzXQ/IgOdLPI/cqlH1gaKt
        gphNQootWm/2fe8laRHi7U0=
X-Google-Smtp-Source: AA6agR4c2MGPtrs7DkzAaXLU4BBWOq7igq5HDD1YDWc7U8OxUkMZfpGVdNcZYVgQumw0KlYG5ZEzZQ==
X-Received: by 2002:a17:906:a219:b0:6e4:86a3:44ea with SMTP id r25-20020a170906a21900b006e486a344eamr26380836ejy.385.1663161487898;
        Wed, 14 Sep 2022 06:18:07 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b00774f2fbfcbbsm7718964ejo.38.2022.09.14.06.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:18:07 -0700 (PDT)
Message-ID: <6321d48f.170a0220.cae01.31e6@mx.google.com>
X-Google-Original-Message-ID: <YyHUjb80SRyFN3cY@Ansuel-xps.>
Date:   Wed, 14 Sep 2022 15:18:05 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: clock: add pcm reset for ipq806x lcc
References: <20220724182329.9891-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724182329.9891-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 08:23:26PM +0200, Christian Marangi wrote:
> Add pcm reset define for ipq806x lcc.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Any news for this? All the series have review tag. Can we make progress
on this?

> ---
> v3:
>  - Added review tag
>  - Added ack tag
> v2:
>  - Fix Sob tag
> 
>  include/dt-bindings/clock/qcom,lcc-ipq806x.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,lcc-ipq806x.h b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
> index 25b92bbf0ab4..e0fb4acf4ba8 100644
> --- a/include/dt-bindings/clock/qcom,lcc-ipq806x.h
> +++ b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
> @@ -19,4 +19,6 @@
>  #define SPDIF_CLK			10
>  #define AHBIX_CLK			11
>  
> +#define LCC_PCM_RESET			0
> +
>  #endif
> -- 
> 2.36.1
> 

-- 
	Ansuel
