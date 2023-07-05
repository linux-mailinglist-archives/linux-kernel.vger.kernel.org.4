Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8693774888E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjGEPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGEPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:55:04 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788219AE;
        Wed,  5 Jul 2023 08:54:58 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-346129c9512so2091325ab.1;
        Wed, 05 Jul 2023 08:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572498; x=1691164498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61vjg5vClJfWKOg0akD9TkXQTskYlEHDQOiKBhEMQZU=;
        b=SygYA0V/05IE/wICazcY39RhPUDGkWl7tWYdIeaQFTqmLzK55uRGoGm1NOWTA84ldW
         g8kdJUNNGopEJPeNI6JoC47JNYzN1cYVQ0FEOS4AALy46KUv7DEXSEXsMn4IOTKD5jqO
         /hLa2756PjIbnI+xSBzVhzqtSKu+wQWbYBY4M3cD6pBEKx7wXBmQPCX0Fnx9uv9h+G/S
         1JAqKV1VHfzfqNOyK0oR4UUX3TPalnTLGKtLTrUIsBxAGpgUT9qgWWfShOrUbZAyGzUq
         Y/EAna21rNEs3myQVvMDYhPrAL2pfDWLkME7eMgJWUZcoDFQgkaj/10xzX25aYX4gtXJ
         ys5A==
X-Gm-Message-State: ABy/qLbmZwOrBIQamvsv3doQAt1Rnw+FGMmtGkfPSu/A9BykPmcIFxTY
        WTRcQ9DD0avYtWBR/frOdg==
X-Google-Smtp-Source: APBJJlHb4SxkmqpC5MlEKwVAtvI3JEUfIw2zer5j5qYgnljcn0zi1vGEGTeH+tEdkChHrevD2oQ6Ag==
X-Received: by 2002:a92:c5c1:0:b0:346:bf9:76fb with SMTP id s1-20020a92c5c1000000b003460bf976fbmr1619864ilt.6.1688572497689;
        Wed, 05 Jul 2023 08:54:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ed18-20020a056638291200b0042b030023besm4520602jab.112.2023.07.05.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:54:56 -0700 (PDT)
Received: (nullmailer pid 693400 invoked by uid 1000);
        Wed, 05 Jul 2023 15:54:55 -0000
Date:   Wed, 5 Jul 2023 09:54:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        quic_lsrao@quicinc.com
Subject: Re: [PATCH] dt-bindings: soc: qcom: stats: Update maintainer email
Message-ID: <168857249402.693314.16210792699715082768.robh@kernel.org>
References: <20230703092026.4923-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703092026.4923-1-quic_mkshah@quicinc.com>
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


On Mon, 03 Jul 2023 14:50:26 +0530, Maulik Shah wrote:
> Replace my email.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom-stats.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

