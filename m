Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93B688103
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBBPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBBPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:03:56 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52359552A0;
        Thu,  2 Feb 2023 07:03:36 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso535976otp.1;
        Thu, 02 Feb 2023 07:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xhLIwzkmCznX0GHhQwC0/P1h3t8y8u+T1ODla0Zh5kk=;
        b=awOJcQ48EQRuf8Fzslq07euRx9quaeEzYPhV15Bb4tP1sRvDRA4WGE6dRLEeJn7Mt9
         y8jiURC7bnKk6tfH/gmy6QeiMBwchD/7/3sfIVs4lTHgdcN/K0E7xHfxn0TxxZhI6qp0
         +V2T/FJn+skXsHCrFnIfbeB/eD39rMvqSlLNDjUbwPj0vuorg09KCdtDTR0xYGANUZkU
         AADcVG3pCAzXsmh44SouWCZ3p1gPyPJEdZgstHzAn3ze067dpv7L+LQ/UTynhVcCA9zO
         UonQOFRoD6emtwfj8exKSUpKovCQICDq05DEJ9PM1QdrnxCh8PHgpI5TfCaMzHX12/Pg
         al7Q==
X-Gm-Message-State: AO0yUKV9zVSFJ62tASB4Go7wou6Yi6eFfSMbc1gbkta0i8/gsf/yg2Nt
        5J9azCh1C9uvhu+VxGB5JNY1p35EzQ==
X-Google-Smtp-Source: AK7set9CBOiY1Y27c21v6wju0XHcELQW66Yw+qKAXhK9DVt099gofzi2TiGaQ0sIsd4bfdHS1s2fTQ==
X-Received: by 2002:a05:6830:18f6:b0:68b:c2d2:8967 with SMTP id d22-20020a05683018f600b0068bc2d28967mr3312164otf.26.1675350215344;
        Thu, 02 Feb 2023 07:03:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p5-20020a056830318500b0068bce0cd4e1sm5411539ots.9.2023.02.02.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:03:34 -0800 (PST)
Received: (nullmailer pid 1858084 invoked by uid 1000);
        Thu, 02 Feb 2023 15:03:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-usb@vger.kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com>
References: <f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com>
Message-Id: <167535004008.1854256.11552006567095484269.robh@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: usb: rockchip,dwc3: update inno usb2
 phy binding name
Date:   Thu, 02 Feb 2023 09:03:31 -0600
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


On Thu, 02 Feb 2023 14:59:35 +0100, Johan Jonker wrote:
> The binding for the inno usb2 phy was given a name in more a common format,
> so update the reference in rockchip,dwc3.yaml as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml: Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

