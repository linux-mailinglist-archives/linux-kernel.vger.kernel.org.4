Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE369E38D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjBUPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjBUPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:35:11 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56128848;
        Tue, 21 Feb 2023 07:35:09 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id t7-20020a9d5907000000b00690ecb95d46so1004153oth.2;
        Tue, 21 Feb 2023 07:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1ol6n8KiK81clbhIizUnjR9mgA3r+k3AJ/gUsCsOrU=;
        b=seHfsPJtBtkWGKkD4bclhm9B2qdpY3n/59gje3cTxr2+AwXSWsFnWvuLcsh20iR0b1
         UG1cKTkTQsZL3i5c/7kOtcU9stE+9qZI4SOOaIVeX9MDiWRhJm09u3ZLFSI5jrO729io
         jlZyrWb5etAYMvJCRi0RPJCVp4kKKtvzWHK0U6JM3wnPpQc8ddBPmvo6gI3t0SSviGMY
         2rhWxxOb7v4mmihamKG1ReltRsyL227My9gHdYPg7XHg9plH5i100siCFEeSo47T/P+A
         X/moFuU2mKoCg1eY7+EGURp1ARMqf9UBkjWG3FB5JrHnhtnG0QqJS3UgQQPLy2DZG7GE
         sMmg==
X-Gm-Message-State: AO0yUKW0epFs/+UeIIEgT8tuY830GEwKPIcpK6fwSetBowKYohiCZ5E7
        /29ExsGLgZTUhGIMreFXzi5HOiMDFg==
X-Google-Smtp-Source: AK7set+pBSRFlVEy/A1a21lw8ttuMeCVASSm8SLedmylfmZTZ2YQAv6uLda0VPwfPVhinMQ7Gai/CQ==
X-Received: by 2002:a05:6830:349a:b0:68b:e391:324d with SMTP id c26-20020a056830349a00b0068be391324dmr8290256otu.0.1676993708960;
        Tue, 21 Feb 2023 07:35:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t13-20020a9d728d000000b0067781a9292asm254944otj.2.2023.02.21.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:35:02 -0800 (PST)
Received: (nullmailer pid 2577237 invoked by uid 1000);
        Tue, 21 Feb 2023 15:35:00 -0000
Date:   Tue, 21 Feb 2023 09:35:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, elder@linaro.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: sram: qcom,imem: document sm8450
Message-ID: <167699369715.2577137.10776654438962526300.robh@kernel.org>
References: <1676986616-21378-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676986616-21378-1-git-send-email-quic_mojha@quicinc.com>
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


On Tue, 21 Feb 2023 19:06:55 +0530, Mukesh Ojha wrote:
> Add compatible for sm8450 IMEM.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v2:
>   - Added Acked-by .
> 
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

