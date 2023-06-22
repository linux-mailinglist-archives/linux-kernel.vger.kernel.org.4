Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09FC7394D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFVBrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFVBrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:47:13 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66D135;
        Wed, 21 Jun 2023 18:47:12 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-340be77ff6fso31473885ab.3;
        Wed, 21 Jun 2023 18:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398432; x=1689990432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6oXlsyjwZNXhD064YtWO9fJrl7a9fCWh+s9W+ivi2k=;
        b=cyr4hJVKusoa9IrS9sQFkdd284wcOOonhTUobqsDDXl732EqZiZJvl1PLdjdlPe4X1
         U7z2bOkMcdCtMbW2zDEexugrld+I6USAFI9F1qXXp9Hd7JC8kLdh24sIRl62/18V6gXO
         eiUBOH+1RHv2euLYF6BY4mIv50L0OyKpEmNMSBvDw9bq7Ou6LIfkGIeG4jfZhT2KdQR7
         NdHj2qDlJNR8iuY+dP1qeL+t/bLqPK2jMFzqkDt8EGoCN5Y2sjl36iv3UxF/IydMZTxU
         8bzxRGLUFnO8D25/vvh+ALZltA/GzqIcOFebxDpg3FFuIf8SXU/aRvANutnLJhDrbjI6
         e/1Q==
X-Gm-Message-State: AC+VfDxYx8KReJoBaXoWirZhviXjFgqFje6gqAi2gZJxjQdRrftTGJ/Y
        XCYmyzz1lan66TpJn3cErQ==
X-Google-Smtp-Source: ACHHUZ77dMKLPW/EMoAUHg8w7kFq4ecA5UQGLKnGBns4JzgDgfJYkVEf3AIHtCYJvLU37QuwCIzDbw==
X-Received: by 2002:a92:dc03:0:b0:341:e2aa:354d with SMTP id t3-20020a92dc03000000b00341e2aa354dmr12893382iln.12.1687398431792;
        Wed, 21 Jun 2023 18:47:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q8-20020a92d408000000b0034233fd80d3sm1698078ilm.22.2023.06.21.18.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:47:11 -0700 (PDT)
Received: (nullmailer pid 35678 invoked by uid 1000);
        Thu, 22 Jun 2023 01:47:08 -0000
Date:   Wed, 21 Jun 2023 19:47:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>, andersson@kernel.org,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v6 02/13] dt-bindings: arm: Add support for DSB element
 size
Message-ID: <168739842848.35614.11767552033179026441.robh@kernel.org>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-3-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687246361-23607-3-git-send-email-quic_taozha@quicinc.com>
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


On Tue, 20 Jun 2023 15:32:30 +0800, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDM. The associated aggregator will read this
> size before it is enabled. DSB element size currently only
> supports 32-bit and 64-bit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

