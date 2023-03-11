Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641226B57EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCKDBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCKDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:01:31 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F71151F7;
        Fri, 10 Mar 2023 19:01:30 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1755e639b65so8050844fac.3;
        Fri, 10 Mar 2023 19:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678503689;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gU48w4BkL35qUGYQMDtLAo6zqXNIWKSjZ0txcGbB0lA=;
        b=LrSoj0SWiWDchLT296fHBtU6gVV/I9AOhPWHfqn4O9iT2qFvharrdtFt/hH3ILQaHc
         gmuQxiJCLn9RSYRB4J6hsmcqangyigBXBjBPsbMGyojv6JRFnEsTc5QfmZiifvsq/gDB
         covsrSHcT/y8VLbQXxkh7YYK28bZfwPl2es5OgEUOnV1AYfbH3sludwz++NUj2qcTHO5
         NLwFgKiXKuwTx/D8CXK8dosl+TNMscEmNrLjqVZKPu2/MxRWpfPs1Kdt/YLm0Ye3CBkN
         eq2z2179b9sUcKktxHRi2u50Bp2JUdjWwzPYwUqqLR6GXX21BSurpA4lLUUxt/CQ970K
         ikLg==
X-Gm-Message-State: AO0yUKWTnUSvgg3dbpxIjL5v9+vk6DmsEmnh5ARVsaW9tMRI25tp2N95
        R0L/jQci25iLlshP1wfiaVrpStPSYQ==
X-Google-Smtp-Source: AK7set/cI+Eb97yyPps2W9b1GQ4PDnq8XbG2/ZD9c3srZRFWb6wnhcuYJen8/EjWfNsdNt/L8dZKgA==
X-Received: by 2002:a05:6871:607:b0:176:1df2:4ed2 with SMTP id w7-20020a056871060700b001761df24ed2mr18870123oan.58.1678503689223;
        Fri, 10 Mar 2023 19:01:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870c34300b0017280f7d653sm730261oak.35.2023.03.10.19.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 19:01:28 -0800 (PST)
Received: (nullmailer pid 3263022 invoked by uid 1000);
        Sat, 11 Mar 2023 03:01:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     ahalaney@redhat.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, quic_ppratap@quicinc.com,
        quic_shazhuss@quicinc.com, Andy Gross <agross@kernel.org>,
        quic_wcheng@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_harshq@quicinc.com, linux-arm-msm@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_jackp@quicinc.com, quic_pkondeti@quicinc.com
In-Reply-To: <20230310163420.7582-2-quic_kriskura@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-2-quic_kriskura@quicinc.com>
Message-Id: <167850338309.3256287.16131101568389793313.robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Date:   Fri, 10 Mar 2023 21:01:27 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2023 22:04:13 +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Snps Dwc3 controller.
> 
> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/snps,dwc3.yaml:90:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230310163420.7582-2-quic_kriskura@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

