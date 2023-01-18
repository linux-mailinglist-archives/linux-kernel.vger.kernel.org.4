Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430316722AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjARQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjARQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:09:35 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8003B3E1;
        Wed, 18 Jan 2023 08:05:43 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id v17so7664086oie.5;
        Wed, 18 Jan 2023 08:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tuGFAfqRCVW7qUbmXv4aoqXHqjRDkD2HH7zwkEHfLk=;
        b=1RtIivoZyqzEmlHIQssJxZ2X08m5H4NEnVx9YVnGTU/Z7UVOOvZlIaoSdqkA93ibYB
         tgvnWGWGa2YziYgWyBe4Whmw6Dfchx8q5Iyxd5Kpe+VhYMYnOAX6Db6afRnWitOpdWTk
         rTp5i+mWfb4G9CB3L6hqfhEXMrIFpYWbZbSQ7W+JEOnzTv1dImBWuTa49Z+57gp4dmjT
         cZt0UJ9Ig0zrmT5Ywbg5EwB9LtjxKlfY8mEpfCBn3iW0ThR40FoFp01deKUN02xOTj1K
         teV3CTbfpdLP9wFztL4M00L6ODRMEzLGxzQKep+/hgENF7WQWhdCus6J+biJQWtoeNl7
         FQ5Q==
X-Gm-Message-State: AFqh2kpvFMAUycRLNLhiVwURHS3QOSNp6hxUxBRVmCKbODvJIAru+T38
        TQAh/svE3WVNdaBVBT1qfKxa7k0tMA==
X-Google-Smtp-Source: AMrXdXu75jJ57NWli2T25cgyRN8wEQAFExKDfERE3ly1W13hMhKaZ/tacFIMiyHP6aLAYiEKhNhoHQ==
X-Received: by 2002:a05:6808:120d:b0:364:9e70:2d77 with SMTP id a13-20020a056808120d00b003649e702d77mr12791684oil.20.1674057942566;
        Wed, 18 Jan 2023 08:05:42 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id bs1-20020a056830398100b00660e833baddsm18527592otb.29.2023.01.18.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:05:42 -0800 (PST)
Received: (nullmailer pid 90065 invoked by uid 1000);
        Wed, 18 Jan 2023 16:05:41 -0000
Date:   Wed, 18 Jan 2023 10:05:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 2/7] dt-bindings: arm: msm: Convert and split kpss-acc
 driver Documentation to yaml
Message-ID: <167405794085.89999.14844192427406164237.robh@kernel.org>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
 <20230116204751.23045-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116204751.23045-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2023 21:47:46 +0100, Christian Marangi wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, split the Documentation
> to 2 different schema, v1 as clock-controller and v2 for
> power-manager as per msm-3.10 specification, the exposed regs handle
> power manager.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -------------
>  .../bindings/clock/qcom,kpss-acc-v1.yaml      | 72 +++++++++++++++++++
>  .../bindings/power/qcom,kpss-acc-v2.yaml      | 42 +++++++++++
>  3 files changed, 114 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
