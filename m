Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2565CB04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbjADAmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjADAmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:42:00 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E4140D3;
        Tue,  3 Jan 2023 16:41:54 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id d10so18881149ilc.12;
        Tue, 03 Jan 2023 16:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i5QCkn5f7/8bQHHWhpZfw+Hrwcm09g6oLcGGwmqm4Y=;
        b=tnwWDMwWgDjqvkLQKMpl5kelgrYH1KMlpaOLG+bKTfwgopRJXe1v4HPAdxACJVuIlV
         2qfLbcbZCh1GlUhQm43NfFWwMiDl7uU2xBPH5hCvJb1aPMs5+noi1DR1XkI7Q7UYeR7o
         TFNc9nueLHK0iLufsKFLzn3jfnbPepjWwIkYpxovX/+6TqZhOtjyzmcS741hW+oNliTF
         hKTOVzGpSZ1wFo+/ELissROAI0UjlKhkzPZHlxrYF6xGYHm0YTtWdS9hFF5ftKGL/Xok
         7lb1DtfJAPd3TseamelXfohpFJlrdsMUivlGTSQUUmTx4xHNF/OE5iv0LQVxWtr4CaFS
         C9bg==
X-Gm-Message-State: AFqh2krFZW3wciDBt+e3vjhsOKygIwHLLN8f/p/DccmO+cv/ALiXZ3/K
        ejKSkZkJBiC9TzWUE4404WICGeVk1A==
X-Google-Smtp-Source: AMrXdXt8R8M3J07HjvnrwFZepzmoP7CIx516i0FzByPM6GyFR9cjiBdwLlH3aoq3iU0UQkzD0+SzOg==
X-Received: by 2002:a05:6e02:218d:b0:30c:2266:cfca with SMTP id j13-20020a056e02218d00b0030c2266cfcamr20059297ila.9.1672792913990;
        Tue, 03 Jan 2023 16:41:53 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y17-20020a926411000000b00305e6279bf2sm10160256ilb.74.2023.01.03.16.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:41:53 -0800 (PST)
Received: (nullmailer pid 160851 invoked by uid 1000);
        Wed, 04 Jan 2023 00:41:52 -0000
Date:   Tue, 3 Jan 2023 18:41:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: soundwire: qcom,soundwire: correct sizes
 related to number of ports
Message-ID: <167279291060.160766.17238671980369497938.robh@kernel.org>
References: <20221223132159.81211-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223132159.81211-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 14:21:59 +0100, Krzysztof Kozlowski wrote:
> There are several properties depending on number of ports.  Some of them
> had maximum limit of 5 and some of 8.  SM8450 AudioReach comes with 8
> ports, so fix the limits:
> 
>   sm8450-sony-xperia-nagara-pdx224.dtb: soundwire-controller@3250000: qcom,ports-word-length: 'oneOf' conditional failed, one must be fixed:
>     [[255, 255, 255, 255, 255, 255, 255, 255]] is too short
>     [255, 255, 255, 255, 255, 255, 255, 255] is too long
> 
> Fixes: febc50b82bc9 ("dt-bindings: soundwire: Convert text bindings to DT Schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/soundwire/qcom,soundwire.yaml  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!
