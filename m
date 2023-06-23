Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43C73C0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjFWUoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjFWUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:44:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A352114;
        Fri, 23 Jun 2023 13:43:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-78336da9b40so13172039f.1;
        Fri, 23 Jun 2023 13:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552905; x=1690144905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVwIruNM27XzOclde1ez2sYDl8Db/9ES8i/lIk7F8q8=;
        b=H9vA6dPhJm2TKhAaIQrHZllHXdCIQnrn4HFyPElLlc8aFP3SeFQw4/c/DovcSjjjNN
         qsaS6J9poDhbwB8HAOpbdIfwPBXiuzsj9cK8yjspEUDXYeNQA8sgqnO/rGnHnHT4/XI2
         PNsYllK0VhQv4Q+g0e8wzNPhIl8/VlsapV4UemAtHHz6TAJMfHl0yAQ156yQRm4xtd4I
         b7X8Zdkgw9JUIP7DoDSQ2hLE19QkuqpC02gjJvq/bPFmCDXKdFgJvL4NgoZSCpAl6wtM
         XRsyWhSSJsJxCbmG8dsbRlZQPDic6zE5BFQnj8d8gGqfJ8GfGcdavhuec6j2ZuXofBkj
         bppg==
X-Gm-Message-State: AC+VfDxa6+fsyX/Azlp2Ee6sX27+PWxEmMZDWQM+sOLtu4Na30Jh1a4A
        n05vJteTJ6CXhjhla0QjTQ==
X-Google-Smtp-Source: ACHHUZ5qydroL5WvfYXA6b3iHRDviES8vdnm1IRv0G1kn2uF+632UINuFwXA3DFOyWNQirLohamf5w==
X-Received: by 2002:a6b:c306:0:b0:780:c023:c071 with SMTP id t6-20020a6bc306000000b00780c023c071mr5691888iof.8.1687552905274;
        Fri, 23 Jun 2023 13:41:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c11-20020a6bfd0b000000b0077e24ace3edsm36879ioi.52.2023.06.23.13.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:41:44 -0700 (PDT)
Received: (nullmailer pid 1085584 invoked by uid 1000);
        Fri, 23 Jun 2023 20:41:42 -0000
Date:   Fri, 23 Jun 2023 14:41:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        quic_pkondeti@quicinc.com, Johan Hovold <johan@kernel.org>,
        quic_shazhuss@quicinc.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, ahalaney@redhat.com,
        linux-usb@vger.kernel.org, Andy Gross <agross@kernel.org>,
        quic_jackp@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, quic_harshq@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v9 02/10] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <168755290184.1084879.7352265342083179543.robh@kernel.org>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2023 10:06:20 +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Snps Dwc3 controller.
> 
> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

