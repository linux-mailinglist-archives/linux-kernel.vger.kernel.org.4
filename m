Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26694643837
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiLEWfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiLEWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:35:32 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151D1C11C;
        Mon,  5 Dec 2022 14:35:32 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1443a16b71cso11721274fac.13;
        Mon, 05 Dec 2022 14:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLOFUf+I6lQnDKya0o8ibkJt2tMm73yakMAr3T4ah3Y=;
        b=ak6v6luasWWke20CwXbQXvVzeld7Jh5rlVcwAS7+/WKR63uy+emYUK1x8ml8GWoVXZ
         A8gWD2xRmbvgBUqkqGnEBsppEdBd08Jaf2ngxCsrLXgFINJ/RDpIjbtzGJcOJlbmyaf5
         fILCeBZDvQ8EX2efMC63k0ThJWtoHfm1IqmPhkcB1X2ANzySyMM8M7k6/dvuCiXTto+y
         /lR+k0ovVISvcOWHWsLxmwMDlL0IMmoU5lLCiqE9QWB18PRjM/MLIoOhu/mOxgRp7u94
         fGejFKdQGdaWXtBnJzeSzgBlbewZaU9atzv8vzPHYa9HxRxpcp3XMmHbSRjF+LQKjurp
         cD+w==
X-Gm-Message-State: ANoB5plL4iJFGHHAz4Dm9cr0o5ZdyU+n886han73nMF2mmcpFtsevSo7
        hO597foAdV1m+uEMOQrv7HO2yhhM2g==
X-Google-Smtp-Source: AA0mqf5VxoBLeKk9DHLzZDbkXoLnvz1Fbyccy98GekPJ1J9klF/k93DUmzwqjpT8nkMB97LDGOYkSg==
X-Received: by 2002:a05:6870:ab86:b0:13c:5763:9411 with SMTP id gs6-20020a056870ab8600b0013c57639411mr45970586oab.288.1670279731544;
        Mon, 05 Dec 2022 14:35:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id by13-20020a056830608d00b0066e873e4c2csm5325558otb.45.2022.12.05.14.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:35:31 -0800 (PST)
Received: (nullmailer pid 2812012 invoked by uid 1000);
        Mon, 05 Dec 2022 22:35:30 -0000
Date:   Mon, 5 Dec 2022 16:35:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Avri Altman <avri.altman@wdc.com>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <167027972984.2811976.4583881100765006038.robh@kernel.org>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205100837.29212-2-johan+linaro@kernel.org>
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


On Mon, 05 Dec 2022 11:08:36 +0100, Johan Hovold wrote:
> UFS controllers may be cache coherent and must be marked as such in the
> devicetree to avoid data corruption.
> 
> This is specifically needed on recent Qualcomm platforms like SC8280XP.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
