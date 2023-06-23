Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5273C0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjFWUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjFWUm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:42:57 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584B30D8;
        Fri, 23 Jun 2023 13:42:16 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-78333585d28so27860739f.1;
        Fri, 23 Jun 2023 13:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552873; x=1690144873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg94xVxU+KBk6JV80YmvR4uIRCIi8Yio8OJz8y0ssbk=;
        b=J1XjXY1MEHAwAXZnoWli13HnNOgJyV+YHTDPE1gmC/2XzFMYFe/jAkyK86jmu8WfkN
         wWOTXXj8F6f+1qsqFqAYVPLQBSIbB2bN5GI7mwZLtkjuz1RfwStmOHqLk9XnsplN/LHh
         em7JQbSjUQMhCGuwPUBHP8VGzyAuix94hQCLlZGV96a+TqjSbHUFK6H70IiGGXwYbpjd
         4cHSzpLJkhlJ04SGO+Wk9xLeBslzT/zo/4UUIT4oqA6FZEzkebV6zhwRgkUPLn1mkwaC
         wslITwOEMdZM4UY4lIesG8coF4JILNyrMHPL6Gh1/gvEmkmDMUGv5sRpo/w4Ki7jLpA9
         OjlA==
X-Gm-Message-State: AC+VfDwhkCVbBhb5Etxr66kGuvMcfpwxgeupCeqK5IEMzFeUh53PNFhJ
        MGY302EOHbiImG5jXpxIrg==
X-Google-Smtp-Source: ACHHUZ4LUHt4NfXfv/satE+F1gFdH3T1avoQDVlD2XXbG2ZJJT/R6HUWYFMBKKHGXAU0Cl+v8ZbCqg==
X-Received: by 2002:a05:6602:2995:b0:760:f795:ccdf with SMTP id o21-20020a056602299500b00760f795ccdfmr20481712ior.8.1687552873011;
        Fri, 23 Jun 2023 13:41:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a15-20020a056602208f00b0077e3acd5ea1sm38156ioa.53.2023.06.23.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:41:11 -0700 (PDT)
Received: (nullmailer pid 1083781 invoked by uid 1000);
        Fri, 23 Jun 2023 20:41:09 -0000
Date:   Fri, 23 Jun 2023 14:41:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>, ahalaney@redhat.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        quic_ppratap@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_harshq@quicinc.com, linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        quic_shazhuss@quicinc.com, Johan Hovold <johan@kernel.org>,
        quic_jackp@quicinc.com, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v9 01/10] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <168755286916.1083702.6661052967683571256.robh@kernel.org>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-2-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-2-quic_kriskura@quicinc.com>
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


On Wed, 21 Jun 2023 10:06:19 +0530, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event irq interrupts supported by this controller
> (one for each port of multiport). Added all the 4 as non-optional
> interrupts for SC8280XP-MP
> 
> Also each port of multiport has one DP and oen DM IRQ. Add all DP/DM
> IRQ's related to 4 ports of SC8280XP Teritiary controller.
> 
> Also added ss phy irq for both SS Ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

