Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365C25B6240
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiILUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiILUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:33:49 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C248C89;
        Mon, 12 Sep 2022 13:33:48 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-127f5411b9cso26552941fac.4;
        Mon, 12 Sep 2022 13:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QzvioCx3pLAguVi0ZLWrO4wcdB1yZS3Mx/if1O+3frE=;
        b=bQg4NTa1hNeRqyR9MdOur9OE5jd0AsTrZJP9oB5GlDXoSdnmdt2pLXT+xwVCc+i3cy
         EEnnmOWfDPzfP6XkxfLTk0iJtyQCC4S8jni9mFuyuEYduz4ZIfCuY18sifNEUmaCmkf6
         xJWNZ4YgRi0A/9p4Cvxv4lbDo70NvL0FOSHFS8X9a5lZGjQtuQXxU7r7bUPKl3+DV6BX
         +vjo2V2sUX1/wf6m5x7ZYKjcqbXTVEkH4/Bphs8sK1v5tspWqgHN07GezyO0juzF8RUG
         L43ctMDqB5XmSjHiuj7uqfPrMr5vpiLSzs40f0xaknF6kGwPtWM+QC4MXy30SIzpPBCC
         TSSw==
X-Gm-Message-State: ACgBeo2KtIyCHVRQQlLbsq7mUTrxmGPxVVNj1U06iYf80uPh6OsId/+s
        s+eY05LEswwoIq+NI9cX2sFeVxtIsQ==
X-Google-Smtp-Source: AA6agR5va7fgDMXGffYETk8MN0jdPMHs/3QBA3psdYnoldEV1LaBtvSAp7mioNGvKJ2lrvrlkyaU3Q==
X-Received: by 2002:a05:6808:d4d:b0:344:863a:36fb with SMTP id w13-20020a0568080d4d00b00344863a36fbmr57875oik.235.1663014827276;
        Mon, 12 Sep 2022 13:33:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05687005a300b00118281a1227sm6087244oap.39.2022.09.12.13.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 13:33:46 -0700 (PDT)
Received: (nullmailer pid 1787166 invoked by uid 1000);
        Mon, 12 Sep 2022 20:33:46 -0000
Date:   Mon, 12 Sep 2022 15:33:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM
 devicetree bindings documentation
Message-ID: <20220912203346.GA1787128-robh@kernel.org>
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <20220907131241.31941-2-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907131241.31941-2-romain.perier@gmail.com>
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

On Wed, 07 Sep 2022 15:12:37 +0200, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e PWM driver, it includes MSC313e SoCs and SSD20xd.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/pwm/mstar,msc313e-pwm.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
