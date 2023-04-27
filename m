Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A06F0734
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbjD0OX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbjD0OXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:23:16 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CB4EC4;
        Thu, 27 Apr 2023 07:22:53 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-18f16a2c329so4628652fac.0;
        Thu, 27 Apr 2023 07:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605350; x=1685197350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhNP5q/FtBZ2oxbUFxRPwXXGpasJHmCl/lNnylGgGkY=;
        b=QeycmL7Tccf2kNC378Jo3M+6XGRvc53Xu5BiJ18fzOP2JzQfsL+Ku2wG5LZH96Y9VL
         Hy+CkncNfQeYM1lOhTgh3zFXkUh4ld992Qq0Yiogsbj2c7E60s+Uzo7JAhz8390s7emd
         6m3KAfi2MO9TZKujNMhfiHrzG1EbCJzgxZ/BVmA6JZZp6YV/kNG2AhchQ2c+Chr5vvLb
         oOYn5zgFNERX6zlZu6GetC3e7Letjbw+AImC1gdjNUQJdhBR7gIAXRgRRVx3cOy/tvK4
         KziiJoiWpKM4SoVaX2xWLy46BkHpz7NM11QHlXB+ahrJv9Rm+tuPFL5daX1BMMYszh7m
         nlxg==
X-Gm-Message-State: AC+VfDxNflNgnRs1aoYLixBWQQm9+GKsOdA+tthRnmRRjquP+nsu8afo
        CwQJv/ac6r0l4hETnMzTPw==
X-Google-Smtp-Source: ACHHUZ5SRwtVVOSGEhz2ky680l6Is1tQjpsPPMmy2jy6lZSkZKy3sp1BN0ILIPvaem19w5gSbvMAFQ==
X-Received: by 2002:aca:2b07:0:b0:389:888a:73b9 with SMTP id i7-20020aca2b07000000b00389888a73b9mr878133oik.28.1682605350618;
        Thu, 27 Apr 2023 07:22:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p205-20020acaf1d6000000b00386eff32f58sm7773940oih.13.2023.04.27.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:22:30 -0700 (PDT)
Received: (nullmailer pid 2990340 invoked by uid 1000);
        Thu, 27 Apr 2023 14:22:29 -0000
Date:   Thu, 27 Apr 2023 09:22:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     andersson@kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add
 SA8775P USB PHY binding
Message-ID: <168260534832.2990278.842904223739682126.robh@kernel.org>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <20230421133922.8520-4-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421133922.8520-4-quic_shazhuss@quicinc.com>
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


On Fri, 21 Apr 2023 19:09:18 +0530, Shazad Hussain wrote:
> Add compatible string for Qualcomm QMP Super Speed (SS) UNI PHY found
> in SA8775P.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

