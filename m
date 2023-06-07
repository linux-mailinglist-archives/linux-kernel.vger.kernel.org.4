Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DC726720
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFGRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFGRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:21:36 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86131725;
        Wed,  7 Jun 2023 10:21:35 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-777ac4344f9so129627939f.0;
        Wed, 07 Jun 2023 10:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158495; x=1688750495;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMqgVdX9Zz/X8ixIFydMOZK3AqgJ4bp/xohKlAbcPao=;
        b=Ip7VRYWw1pgoNd4hnOyYeBI9WcXQnrFbegNzK0mWYnX9oLJvswMsCJ3uNPLxJfnnvP
         /BXaberyyfxQfWDpMS0/Y2myZgKFz+bgU2ENh5k93QLWNZLjhD5j0Dhgtz6cRzOUYEDb
         00GrvNN6coIV9CK9mF0oEMsYdyhR0vGAlc+8hab7aobOPJd6ryFhZOwn4XXFpPUlXxqs
         sBqNFKvEU0hsPq/0K+oIit+ikNOOXi4nhFz+kI7l6RYSaHtduJmUSiYq0+Rv9JeUk6Fj
         S7G9F1DVy/4R8YpvRYC3am2xTloPpPJWpxXOy+b8KKmmGXvQdDrpLGv4BMNhwbXxTrwy
         Rhqw==
X-Gm-Message-State: AC+VfDzTk09WeJR54LxhgJDyezjZlAjm41nsJoInaf32rmXSLM2ydpWq
        apZP8rqnZboMSIb79q4Uiw==
X-Google-Smtp-Source: ACHHUZ6XIddSBEqrxRfMhoQYmpM9/x70i9xG4ujpQEXjTtUsUvfCGMHBT3QLAIuDVGgwjUARpXTnBg==
X-Received: by 2002:a05:6602:218c:b0:777:b4b7:f6ac with SMTP id b12-20020a056602218c00b00777b4b7f6acmr6950873iob.10.1686158494747;
        Wed, 07 Jun 2023 10:21:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l9-20020a056638220900b004168295d33esm3670915jas.47.2023.06.07.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:21:34 -0700 (PDT)
Received: (nullmailer pid 3589542 invoked by uid 1000);
        Wed, 07 Jun 2023 17:21:28 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, fastrpc.upstream@qti.qualcomm.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
In-Reply-To: <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
Message-Id: <168615848839.3589502.17296725428809710882.robh@kernel.org>
Subject: Re: [RESEND PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc
 group IDs property
Date:   Wed, 07 Jun 2023 11:21:28 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 22:00:06 +0530, Ekansh Gupta wrote:
> Add "qcom,fastrpc-gids" property to the list of optional properties.
> This property contains the list of privileged group IDs which is
> used to offload process to remote subsystem with increased privileges.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dts:36.17-18 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/misc/qcom,fastrpc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

