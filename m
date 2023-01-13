Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8C66891D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbjAMB0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjAMB0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:26:37 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F63B8F;
        Thu, 12 Jan 2023 17:26:36 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id n8so16724728oih.0;
        Thu, 12 Jan 2023 17:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X916kqGWTPzYk5DodxfdMXKYZLihd/FGn4oR+iGMTaU=;
        b=NAqKjckmNVKYwlA5XYa/JFJ89JF6QBeXwZXoq7xaBbaI8ym48UPOq7VeExAiszWNoc
         UI3DueiyuOBmV4rd8tKL0a0fXKejFhaAKrI7KS/stu+5vuK6eNdXq2Xbpnf5q8Pde0eI
         zqy6KSVSxiqSELGhIAnhzqPaq7Nnhn17x8UXgKcW4t6iBdZ2po52T5613mExOX67pLTk
         vbRy/m/tZohK0hJJ3i1PsbLCwC+Mj7dKS55n22Z+kPoIBewUf4tZK73vNCOByAHGdVXZ
         OMmz+Ls0XIoUxE0mZv6g7gIFHTrbDaJOx7foaUJQVonh4qoLMk+8E9uUFYN+KLmsMAp5
         OtMA==
X-Gm-Message-State: AFqh2kqZtIaFcyvDUGmzc5t4T/db24NgS36nH8MXjXjaGZdbTXZK/hAx
        kTmuh5oiHnWeGynFoQnRUQ==
X-Google-Smtp-Source: AMrXdXtEwEeLNhNCPjIHxMHcJLspGX05B114+OCgNFUcjPo+w2Oxt1WKk48zYBuv7vQ4dWZpC26gfA==
X-Received: by 2002:a05:6808:2186:b0:364:8de0:9352 with SMTP id be6-20020a056808218600b003648de09352mr3275803oib.13.1673573195692;
        Thu, 12 Jan 2023 17:26:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q14-20020a9d4b0e000000b0066c49ce8b77sm9788920otf.77.2023.01.12.17.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 17:26:30 -0800 (PST)
Received: (nullmailer pid 585313 invoked by uid 1000);
        Fri, 13 Jan 2023 01:26:30 -0000
Date:   Thu, 12 Jan 2023 19:26:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, marijn.suijten@somainline.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Niklas Cassel <nks@flawful.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v8 2/5] dt-bindings: opp: v2-qcom-level: Let
 qcom,opp-fuse-level be a 2-long array
Message-ID: <167357318956.585260.15755540835678955331.robh@kernel.org>
References: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
 <20230110175605.1240188-3-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110175605.1240188-3-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2023 18:56:02 +0100, Konrad Dybcio wrote:
> In some instances (particularly with CPRh) we might want to specifiy
> more than one qcom,opp-fuse-level, as the same OPP subnodes may be
> used by different "CPR threads". We need to make sure that
> n = num_threads entries is legal and so far nobody seems to use more
> than two, so let's allow that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
