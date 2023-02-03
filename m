Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530A68A4A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjBCVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCVZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:25:05 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D22A4291;
        Fri,  3 Feb 2023 13:25:04 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1636eae256cso8273451fac.0;
        Fri, 03 Feb 2023 13:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9q582Q7J+RZ7ICFLaBCZmRsM989hpbhHtNukDPvdVY=;
        b=ITIH2aIzJ0dWi5eS0MOnkBHsx6InnrG5i12Nuq0IQFHYopmn8Y1YNv6XNO8T5TYMAL
         VWgwRDfxqbqAruX0P93rGx6YxyjqUSvjjoiE6X/m6QYnq90LOL1fmMNAXeOmGzm/BIX0
         AICyoVmdqzvNCgcKX5XXA3AsutPncQwJvkNs/yod8Bp57pA1V987DG3N6YbhvkS0hJRp
         2o2H3sKm2rNF5yaVaUIlHuvIrgcGFaVk181Ko1DH7nn1U1kSWIbK6dyjQGq/mUYBzK/q
         S8orFVjIH8KF5X1cp/1zDhIY93hh/WHxWEVmzQPDtdsGrsGLRyi1DoN9RPYBnx5N5FPN
         eqHw==
X-Gm-Message-State: AO0yUKWrYmHDy1HHKvsPj5QwtJHw8rJhoXRBAbeWk99palYcfepZuPI8
        47f8OlxWfKdw5szKv9ZsRQ==
X-Google-Smtp-Source: AK7set9UydUr1VjD194OD/VDGNhlPvCkm1waL94AGZJZ3LXVm9gUIP/u+yFUzUSnMSg33M2jhdKaRw==
X-Received: by 2002:a05:6870:472a:b0:163:595e:3653 with SMTP id b42-20020a056870472a00b00163595e3653mr7354739oaq.16.1675459503665;
        Fri, 03 Feb 2023 13:25:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a056870618400b0014fc049fc0asm1210298oah.57.2023.02.03.13.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:25:03 -0800 (PST)
Received: (nullmailer pid 912424 invoked by uid 1000);
        Fri, 03 Feb 2023 21:25:01 -0000
Date:   Fri, 3 Feb 2023 15:25:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: qcom-spmi-adc-tm5: Use
 generic ADC node name
Message-ID: <20230203212501.GA908601-robh@kernel.org>
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
 <20230201204447.542385-3-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201204447.542385-3-marijn.suijten@somainline.org>
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

On Wed, Feb 01, 2023 at 09:44:46PM +0100, Marijn Suijten wrote:
> Update the example to reflect a future requirement for the generic
> adc-chan node name on ADC channel nodes, while conveying the board name
> of the channel in a label instead.

I don't think we've defined 'adc-chan' as THE generic name. Looks like 
we have:

adc-chan
adc-channel
channel

'channel' is the most common (except for QCom).

Rob
