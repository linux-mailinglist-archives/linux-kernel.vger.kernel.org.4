Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1A73082A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjFNTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjFNTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:24:17 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47EA26AB;
        Wed, 14 Jun 2023 12:24:09 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33b1e83e204so30488785ab.1;
        Wed, 14 Jun 2023 12:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770649; x=1689362649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZTazYirMY9xGAVePk9FhtRz7wWuYlRcAUZCeAbC9vM=;
        b=V4Du2XlEXxqJXbqcxdDfZg7JKnmWO3HgTUggowAyxLOoeLuO2g5yt5srAi+iA0trRE
         RJ+25BDOQYqRJnWz54O++YbaIBqsaDtOEqUSZXWSO1clQVjORrhRvSamiQm5Ws1Ml5tw
         s3CfZf0TF2POyArtmCw4b3sL6hVSOOjedVR6slWHfdG8gARTer5cFnudvaZbha2LQiQU
         kpunzt8bhVDkfGHWMmiWXsudVF7QddakV36qLHVc3VF3mWdrseSbAjBsVl08fB1LU2Sa
         p/XshgPKGz1A/YbbG8ddYNOY7yl6j7Tt+qMs/5CzktHwRh/iZsKdky3mPTSuJxnAxmZ9
         Z4KQ==
X-Gm-Message-State: AC+VfDx9nPCs4ATI158RGZ8QFacQ/zwi5CclVIoL+EOM/8jIGlhMRuFi
        nIYL2iS0gGHwsijq8D+FeA==
X-Google-Smtp-Source: ACHHUZ5qOw6B5GUbYi7IAQDYex7KX0oMJM7SrRshnZTuUButMPrybEqPW52kwr6pvCOjJmrasMv72w==
X-Received: by 2002:a92:d692:0:b0:33b:16e9:bba5 with SMTP id p18-20020a92d692000000b0033b16e9bba5mr13950251iln.28.1686770649080;
        Wed, 14 Jun 2023 12:24:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h17-20020a92c091000000b00340a1e616e9sm1425065ile.16.2023.06.14.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:24:08 -0700 (PDT)
Received: (nullmailer pid 2595490 invoked by uid 1000);
        Wed, 14 Jun 2023 19:24:05 -0000
Date:   Wed, 14 Jun 2023 13:24:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: arm: Add support for Coresight dummy
 trace
Message-ID: <168677064517.2595428.2508485047061221881.robh@kernel.org>
References: <20230602084149.40031-1-quic_hazha@quicinc.com>
 <20230602084149.40031-3-quic_hazha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602084149.40031-3-quic_hazha@quicinc.com>
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


On Fri, 02 Jun 2023 16:41:48 +0800, Hao Zhang wrote:
> This patch add support for Coresight dummy source and dummy sink trace.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  .../arm/arm,coresight-dummy-sink.yaml         | 73 +++++++++++++++++++
>  .../arm/arm,coresight-dummy-source.yaml       | 71 ++++++++++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

