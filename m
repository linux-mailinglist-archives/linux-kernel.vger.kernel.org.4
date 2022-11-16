Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA662CC79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiKPVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKPVRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:17:32 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49814C258;
        Wed, 16 Nov 2022 13:17:31 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13bd19c3b68so21632693fac.7;
        Wed, 16 Nov 2022 13:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFbeydjmafazamckda29Ec7TpL8TX/UzHz/OV+Cb/pI=;
        b=SIVJ++0a+Va9WZoE9ciytetP6hx6BRPHG8cXNCW7+VxSaVc1+y3QtRLkWVfWfjrR70
         2yoXeoTqVaQ3FDmdg1YjxCVfhVm3nH2E8dk1Wg+43nKyer9AZd3xI0Eww1Z6N8hmibvH
         hTk94Rx1FE/BIoz2QQXRJXpTFfJ6slpSYrReAyqjlGt3hz45QSQa1FMZD0rqDolrWFCU
         PJfKHP8JhGpHJ0GYib33fIWbjURd3tD5ns0zQEavsL4zK09eAwywpXQFrfBsDnhNliwa
         4gQvHo0acJsZ1z7EEhkXGCB0D6792ftot32L5RmwvRdLLqZyp5QiSc7o1BPyxV/eDim2
         NnkQ==
X-Gm-Message-State: ANoB5pnb+aui3QL1VC3//Wnwa3+ciHoSCy2+FPSu4Wq0XH7y82ANv4UQ
        iG/ffCOtVBqgM6NuDB3/qg==
X-Google-Smtp-Source: AA0mqf7Fvq4+4BfEj8VjAgTJEjpVpR/1J2CXpxAJH21NTCNakxajv6nOhX03c79a2hoNrx3oOyW8Dw==
X-Received: by 2002:a05:6870:4625:b0:132:93d1:5f5 with SMTP id z37-20020a056870462500b0013293d105f5mr2778151oao.133.1668633450919;
        Wed, 16 Nov 2022 13:17:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 72-20020a9d034e000000b0066c45517c8fsm6996737otv.52.2022.11.16.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:17:30 -0800 (PST)
Received: (nullmailer pid 957190 invoked by uid 1000);
        Wed, 16 Nov 2022 21:17:32 -0000
Date:   Wed, 16 Nov 2022 15:17:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        jh80.chung@samsung.com, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        ulf.hansson@linaro.org, mturquette@baylibre.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCHv9 1/6] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Message-ID: <166863345158.957115.1717628011449402421.robh@kernel.org>
References: <20221114230217.202634-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114230217.202634-1-dinguyen@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Nov 2022 17:02:12 -0600, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v9: remove required for "altr,sysmgr-syscon"
> v8: remove "" around synopsys-dw-mshc-common.yaml#
> v7: and "not" for the required "altr,sysmgr-syscon" binding
> v6: make "altr,sysmgr-syscon" optional
> v5: document reg shift
> v4: add else statement
> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>     "altr,socfpga-dw-mshc"
> v2: document "altr,sysmgr-syscon" in the MMC section
> ---
>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 32 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
