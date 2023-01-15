Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539EB66B1E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjAOPLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjAOPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:11:47 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161ECDFB;
        Sun, 15 Jan 2023 07:11:46 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso14870384oto.11;
        Sun, 15 Jan 2023 07:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SvPkdrRqclnIiQLKFR8JacZ9XIaTQnycEJaLqb6Sc4=;
        b=qnuHVtPiwMQQiC8xy38c1DnYwaOeAewRelfYXiiwBHePwg25+ubx7xHAmwn2K1wQpW
         I/x69nnRycUif3oEtuje59YCbjXArQWnK6Cdk3VGwKxTbila+BiVpmZN1HF5BpStjBki
         wtrl0S+ckROQ58OlCaLlBjtck/BIUM7y+Qs2CbncGQymrjlgMy04eQvAo12JVLNTVKu/
         T9SjRe65Pa0qM7FiCYcDpA4nF3J9bsxIlOWBG0+ofDAqMrxnEgSJMwD5KF7CGNmD+NIX
         2t5AxzjmmBoo2l9F1BttLf3OsjwJgLohM9TFyXzKh5Oxb8wBQw813e6LPF82PXavrun2
         8CPA==
X-Gm-Message-State: AFqh2kpkiPSsfTSbHBnD3tE16/p3ac+jWWN6p5ltaULQ1Ap5Vfuu+T82
        3yYdFxPrQcwB2VFhqiwl1Q==
X-Google-Smtp-Source: AMrXdXsh6dWqsMlGqRqeH89BB+VTpx1Pk6bCOFikeZ/Yr6Ctmk10iCTGB8c1G6BR+K7Vku/zamfzHQ==
X-Received: by 2002:a9d:6353:0:b0:684:eca3:fa4a with SMTP id y19-20020a9d6353000000b00684eca3fa4amr774789otk.31.1673795505175;
        Sun, 15 Jan 2023 07:11:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm10-20020a056830374a00b0066e868dbc2esm13603695otb.46.2023.01.15.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 07:11:44 -0800 (PST)
Received: (nullmailer pid 2300324 invoked by uid 1000);
        Sun, 15 Jan 2023 15:11:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_pkondeti@quicinc.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20230115114146.12628-2-quic_kriskura@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-2-quic_kriskura@quicinc.com>
Message-Id: <167379535756.2296593.3352224696296396152.robh@kernel.org>
Subject: Re: [RFC v4 1/5] dt-bindings: usb: Add bindings to support multiport
 properties
Date:   Sun, 15 Jan 2023 09:11:43 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Jan 2023 17:11:42 +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Snps Dwc3 controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 53 ++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:90:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230115114146.12628-2-quic_kriskura@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

