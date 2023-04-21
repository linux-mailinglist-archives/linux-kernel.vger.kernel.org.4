Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1046EB219
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjDUTHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjDUTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:07:19 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927CBE6A;
        Fri, 21 Apr 2023 12:07:13 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-18777914805so12645899fac.1;
        Fri, 21 Apr 2023 12:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104033; x=1684696033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSB3Wm55juQO1zRSscn35Tw26e/tg+JlZE9j23M2tOc=;
        b=HfZeQDE1Mdm52YPdCJRYqu1OM+JoTIW6SXC2LudaiTeNhK89IahbXOETpkcYABy956
         eHQmrIPf/i4ap57VDFoeU3BFPZHofuhDUocMHnfgSQXFkzZxS+f4meaDg91eRF0H6uKi
         lluj8r30pmutYE9y5tLo44jtniVpdTnP0jZ6YXQpZ0m2M/L1OIJkIddfGnMQUDOBKRwa
         wsbt/OsnmTZp9l0eYjN4qR8ZzT3+rkOXcJYaRuQXncFHJNg27C3eExJ/9WO3/KlbQOKE
         /rE8jNC3hNvgteRJLL4cEwAPOX2uPaOL+ifybCasxwIayauIMe0e1TPT1T1CK2MCy0jd
         R3og==
X-Gm-Message-State: AAQBX9f4kk0sABWwJ/XRqQP9y/9+HI7S69hahN8m354WaHQY0wpTBh4p
        GC5J09jYj1H9HmBXuHEbHA==
X-Google-Smtp-Source: AKy350a668NMazDil6/xlsaEhPdB8QbxGab/JTh5+29mo1XAPLT5RamzWo2BFsxfccba7Lfaz1ZJvQ==
X-Received: by 2002:a05:6871:68d:b0:17a:f617:e26c with SMTP id l13-20020a056871068d00b0017af617e26cmr4857130oao.11.1682104032775;
        Fri, 21 Apr 2023 12:07:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dk10-20020a0568303b0a00b006a60606de62sm2006458otb.52.2023.04.21.12.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:07:12 -0700 (PDT)
Received: (nullmailer pid 1629669 invoked by uid 1000);
        Fri, 21 Apr 2023 19:07:11 -0000
Date:   Fri, 21 Apr 2023 14:07:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Anjelique Melendez <quic_amelende@quicinc.com>,
        David Collins <quic_collinsd@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom-pon: Only allow
 reboot-mode pre-pmk8350
Message-ID: <168210403110.1629611.9828460888076350953.robh@kernel.org>
References: <20230419-topic-pmic_pon_bindings-v1-1-ea233dae0117@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419-topic-pmic_pon_bindings-v1-1-ea233dae0117@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2023 12:41:06 +0200, Konrad Dybcio wrote:
> As pointed out by Shazad [1], PMICs using a separate HLOS+PBS scheme
> (so PMK8350 and newer) are expected to pass reboot mode data through SDAM,
> as the reboot mode registers are absent in the HLOS reg space.
> 
> Limit the reboot-mode.yaml inclusion to PMICs without a separate PBS
> region.
> 
> [1] https://lore.kernel.org/linux-arm-msm/12f13183-c381-25f7-459e-62e0c2b19498@quicinc.com/
> 
> Fixes: 03fccdc76dce ("dt-bindings: power: reset: qcom-pon: Add new compatible "qcom,pmk8350-pon"")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

