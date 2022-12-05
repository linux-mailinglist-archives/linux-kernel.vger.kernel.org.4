Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93686434FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiLETyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiLETyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:54:07 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27B11824;
        Mon,  5 Dec 2022 11:52:50 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-142b72a728fso14717454fac.9;
        Mon, 05 Dec 2022 11:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo01O6TgptJ4IeOOZl+WQJ0nQza9R3zf8peG0OklCAw=;
        b=Jf3QmMA71UgawAwjn5mQ6t3FMtJk5RATMxqkWysiSEY3AZZRAyURu6iyqreV4WijVS
         lTwh9roMv8jp3CisRph4W8e91PLzatlBc6s/+pbPDAfhOHfpoPnwsQDNMujfrGsW+xSU
         Kv0SMFYYhI5ew8vYiFRdc9SEFX9xNXNaGwuJf4ErjtKefqcRj/1mbn09FTSheMOJr984
         CL73jesAwMMdFQiaZpVFF8P3Iu6NZzYCTirk6WVaAeISOG0CM/5fDpL0IbTW1AwHNeJQ
         zl2f6nssPImOenOGbyM58tpuiqk4BwcmmuEdi0yQn/hZJ7gsJ5uFhlxZrozEKax3qqoC
         AXhw==
X-Gm-Message-State: ANoB5pkN3HWg7ozYMYp9V9S6LQ0ry2idBB/9cimQIbNcFEdjGgMOkC7+
        6OPlTooMkoFEx05NHH/KchYYmLCE1w==
X-Google-Smtp-Source: AA0mqf53utropBpDw6512N6AizLKhha9wi3L4iDhAzUI1u5ShFXYpidpSINjPCmpnzeVEiNZcA9uPw==
X-Received: by 2002:a05:6870:d90e:b0:13c:ed73:847e with SMTP id gq14-20020a056870d90e00b0013ced73847emr48401778oab.63.1670269969277;
        Mon, 05 Dec 2022 11:52:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cz41-20020a05687064a900b0013297705e5dsm3575173oab.28.2022.12.05.11.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:52:48 -0800 (PST)
Received: (nullmailer pid 2486221 invoked by uid 1000);
        Mon, 05 Dec 2022 19:52:48 -0000
Date:   Mon, 5 Dec 2022 13:52:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 14/15] dt-bindings: remoteproc: qcom,sc7180-pas: split
 into separate file
Message-ID: <167026996792.2486182.16657735817906076219.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-15-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:32 +0100, Krzysztof Kozlowski wrote:
> Split SC7180 and SC7280remote processor Peripheral Authentication
> Service bindings into their own file to reduce complexity and make
> maintenance easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. New patch.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  54 --------
>  .../bindings/remoteproc/qcom,sc7180-pas.yaml  | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
