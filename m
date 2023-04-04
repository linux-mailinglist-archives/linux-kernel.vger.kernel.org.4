Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF36D5DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjDDKmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjDDKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:42:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471E1989
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:42:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q19so29214088wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680604920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMMkkwa1DeBjuIxqtolsFfNBw/JbCSfKSLU5AIzSffM=;
        b=TQwvDVU3vO5kpLXTSCPdY1bue1XUsBgljwBUxgP1u61LURfmaxlwu8FGMRiCcOX2ei
         T2ZtRYyq7mvITHzni6P7Og77oa92as3SdzsoN1//oQALYYNrNvHPMuqY2ROOEMRH/UAV
         f8pWztspMH7NDFIBRCz+sncxvYKO/04iwxhunvALSTMfDwv3M5adgku52j3Jvm2OZ6ee
         4/hNiZMkWtZkr1Gk/DCE4sPqbHeBnxEnFQVuU9ZQ+W1/Xcp3oiTXUAUI4IM8/0fpM2jL
         Zkpu7dbmvCdDH+93QmlaW+KJL2x3eqcCgUPLxgY/9WhCC9Il5ecbz1f7IMKFo79E3vfq
         N6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMMkkwa1DeBjuIxqtolsFfNBw/JbCSfKSLU5AIzSffM=;
        b=COSimWE1it9liNTzdDyC9ATC2Hlr5i0ZwBS7jNh1T2h0ajlfqTWZ0Cc2/p3eUw8LSz
         QR6zrO5rjI0IGmcHQgJl/XMqPtUiog87zFpGNeqSDfQ3Qmt599WTO+wVDIaiH11XIglI
         dyeNWSfITMNerhfMZtJPLct4nnNSNSx7QdjqrOffI32onP0Xz2ee939SbpA2LgqsSGKv
         90hdaNHqagnod7STFUhJig5L3tSyIpwwNhn3TsdpzEtVBaufKY+kv6TCglPrdL44OwHc
         FDwzdBmWTL9i4CKRpZlaR9HBpvp+YtkvhB99rR9nX2VGaVAvXVHgeRlwNK0MhkoZ+mez
         BKaA==
X-Gm-Message-State: AAQBX9cixZpYOOQ5woEvLFfiimiH7S/AGA7eMZjC+UNibDmA52HAKtB7
        KJAWeGBcsC2wtjTQf10VbtekmA==
X-Google-Smtp-Source: AKy350andMQlc/NSkoD1itFkTq9FAROBUT7E0DWG3ebDLDs5tZZH76/uH88kkbI44lS/ZaGqyyrRpA==
X-Received: by 2002:a5d:6e42:0:b0:2d6:a357:f133 with SMTP id j2-20020a5d6e42000000b002d6a357f133mr1132544wrz.44.1680604919960;
        Tue, 04 Apr 2023 03:41:59 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b003ef71d7d64asm22334917wmo.6.2023.04.04.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:41:59 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:41:57 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v5 2/6] dt-bindings: ufs: qcom: Add ICE phandle
Message-ID: <ZCv+9WjlkA4n9Dwg@linaro.org>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-3-abel.vesa@linaro.org>
 <9fc90c8b-9234-84fa-7dab-fee9de2b9813@linaro.org>
 <ZCvm3fzSh8owVDdc@linaro.org>
 <c816d432-26b8-2655-adf1-4b72b8645215@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c816d432-26b8-2655-adf1-4b72b8645215@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-04 12:12:06, Krzysztof Kozlowski wrote:
> On 04/04/2023 10:59, Abel Vesa wrote:
> > On 23-04-04 07:41:55, Krzysztof Kozlowski wrote:
> >> On 03/04/2023 22:05, Abel Vesa wrote:
> >>> Starting with SM8550, the ICE will have its own devicetree node
> >>> so add the qcom,ice property to reference it.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>>
> >>> The v4 is here:
> >>> https://lore.kernel.org/all/20230327134734.3256974-4-abel.vesa@linaro.org/
> >>>
> >>> Changes since v4:
> >>>  * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
> >>>    it while making sure none of the other platforms are allowed to use it
> >>
> >> Why?
> > 
> > SM8550 will be the first platform to use the new DT bindings w.r.t ICE.
> 
> This I understand, but why other platforms cannot use it?

The platforms that do not have ICE support yet will be added in the same
subschema along with SM8550 when the ICE DT node will be added in their
dtsi.

> 
> > 
> >>
> >> Also, this does not solve my previous question still.
> > 
> > Well, the clocks are not added for the a few platforms (which include
> > SM8550). Same for 'ice' reg range.. So the only thing left is to
> > enforce the qcom,ice property availability only for SM8550. I believe
> > it solves the mutual exclusiveness of the "ice" reg range along with the
> > clocks versus the qcom,ice property, by enforcing at compatible level.
> 
> Ah, I think I understand. That would work except I don't understand why
> enforcing qcom,qce only for specific, new SoCs. Assuming it is a correct
> hardware representation, we want it for everyone, don't we?

Yes, but they will be added to the subschema (qcom,ice one) when their
their ICE support (ICE DT) will be added. This way, we keep the bindings
check without failures (for now).

> 
> Best regards,
> Krzysztof
> 
