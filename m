Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F05B6104
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiILSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiILSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:34:24 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014364331A;
        Mon, 12 Sep 2022 11:31:14 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-127f5411b9cso25683635fac.4;
        Mon, 12 Sep 2022 11:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qOuXJYWFlhMBv+hJob6UqyVwr1Eq15fJbMnFTSXIcyw=;
        b=3hOnwY1QYm8WnDn+upE1oHWTxLU1QtBxNuLT/sENnRm1CXu1XTAGSVCSRfbL786KAy
         SQZ/U92gFBVBg7fD89LDyft0HV9iL0tlxdAxiEsvoBTgB6K7zHDeCMyBrWctV0T7QO8G
         IKCSefZHrQPH/cY/IILyH6Dvt17kdv8lcscj7IqtN3H/t/sBMDmkEaVVZAvFIbOjxNqX
         I0cSGHPytigihP5McU83/+0o04+wsG18xdLrpfN+92Pi412mdmtAWQcav2mGYTFwUEsU
         21effksCgG0HTR02tHfCQb5Sot+WDrAiRCWZosZCobDSEAtCMKy9aNd/e78NRUf/kP5j
         R81g==
X-Gm-Message-State: ACgBeo1gHFqKJt5fVS0ndKqRRpdPVyPEGqwKdjc0TswvrNi0AaPixHIH
        KGaPfhCTJHQmLqqTabso8g==
X-Google-Smtp-Source: AA6agR6sMx7mHoUriHC8Kh+qkq1RuDkElTwvjx7a2+2WT/6UEwW/82ho+p19Lacr5xK7BwDhHvQUvA==
X-Received: by 2002:a05:6808:9b2:b0:34f:61af:fea7 with SMTP id e18-20020a05680809b200b0034f61affea7mr6381201oig.133.1663007382484;
        Mon, 12 Sep 2022 11:29:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a056830056b00b00636eeba9209sm4996703otc.52.2022.09.12.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:29:42 -0700 (PDT)
Received: (nullmailer pid 1600984 invoked by uid 1000);
        Mon, 12 Sep 2022 18:29:41 -0000
Date:   Mon, 12 Sep 2022 13:29:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, Yu Chen <chenyu56@huawei.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] mfd/phy/remoteproc: dt-bindings: syscon: be specific
Message-ID: <20220912182941.GA1596070-robh@kernel.org>
References: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 17 Aug 2022 17:22:42 +0300, Krzysztof Kozlowski wrote:
> Hi,
> 
> The last MFD/syscon patch depends on the previous ones to avoid
> dt_binding_check warnings.
> 
> I propose to take entire set via Rob's DT tree.

This may have been in the window where PW server moved and stopped 
getting patches, so I missed it until patch 4 got applied and broke 
linux-next...

> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (4):
>   dt-bindings: phy: hisilicon,hi3660-usb3: simplify example
>   dt-bindings: phy: hisilicon,hi3670-usb3: simplify example
>   dt-bindings: remoteproc: qcom,pil-info: add missing imem compatible
>   dt-bindings: mfd: syscon: require specific compatible also for
>     simple-mfd

I applied patches 1-3, thanks!

Rob
