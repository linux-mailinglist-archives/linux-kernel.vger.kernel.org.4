Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F75FE344
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJMU00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJMU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:26:03 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912710FDF;
        Thu, 13 Oct 2022 13:25:43 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id w196so2981557oiw.8;
        Thu, 13 Oct 2022 13:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M5uvedmA5W80q1n3Qh4Ko8R0Hthj3fyGideqRSsxp0=;
        b=ZaI4ztnMp6zyIHsQaR4vxnwj/HnxW0Stuq16HucIWzqKzQA7nvzpPjwScCLAig/fBc
         MJbE8C121F7xoRl8n7DTwtGcaMENRee9lhdWBXHgq+7uTBh4v7KkwmwLkwNeqmSNyCTf
         C/JB9DnoWUQzQTCkVz9NpfYAXzVNHhg4HrMs35niboG6IrjSrw+4+SHmWc4IbV3TTqW8
         ZZNVR7jj9r821YKtMGmva6cZ3lcTi32GNTmMO+FMS6wFRO8YowfpUdDZqDkvIto/oucT
         ZbUz8SLYCqTSX/ZvjRobnBqxfvsvlM2ZCRB1ycBPhBVxjPVJrCLeiZ3ME8ieW2tEpZEL
         V7hg==
X-Gm-Message-State: ACrzQf0uFefkNSHS9EdkcqYmgkMkLnRiOHw22t6JdBU0XXf8/G6ptBCe
        RuAFXjjf57T/hs7rZrG3Aw==
X-Google-Smtp-Source: AMsMyM7lvjdSsmNnJgKgpglZrglRbQswbKXCwWscIjWxrgvy1FGoz/WfAuR0Owqa+AyPIw+W7MSYgw==
X-Received: by 2002:aca:dac2:0:b0:354:a921:a87e with SMTP id r185-20020acadac2000000b00354a921a87emr5643569oig.292.1665692742269;
        Thu, 13 Oct 2022 13:25:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a056808114600b00342e8bd2299sm331045oiu.6.2022.10.13.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:25:41 -0700 (PDT)
Received: (nullmailer pid 175164 invoked by uid 1000);
        Thu, 13 Oct 2022 20:25:42 -0000
Date:   Thu, 13 Oct 2022 15:25:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Job Noorman <job@noorman.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v2 1/3] dt-bindings: touchscreen: add Himax hx83112b
 bindings
Message-ID: <166569274210.175113.9615851655183284739.robh@kernel.org>
References: <20221012202341.295351-1-job@noorman.info>
 <20221012202341.295351-2-job@noorman.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012202341.295351-2-job@noorman.info>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 20:24:06 +0000, Job Noorman wrote:
> This patch adds device tree bindings for Himax 83112b touchscreen
> devices.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> ---
>  .../input/touchscreen/himax,hx83112b.yaml     | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
