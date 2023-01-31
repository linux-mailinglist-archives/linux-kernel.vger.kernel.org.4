Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76577683A61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjAaXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjAaXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:22:32 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC75649D;
        Tue, 31 Jan 2023 15:22:31 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id s124so14292671oif.1;
        Tue, 31 Jan 2023 15:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urnNCd4URXg4rozsY6uRpjkFdQjTtg7Q0jsgYorUKeI=;
        b=Jjk2knwGnUUOY/4q6nIeQr5MFSDvTA3jURYHDyscoQtQ6zsyV7fFxxivfDEOsksZ3H
         A/txXFZv2XLCZTfME/h/hNZHPf5LGt7xFPykCvDvb//Cnhh2yKLUNbyI1hYDmPIqC3RJ
         Cp5m3GaRtuDknPr66jDoDe2G0v4Kl8ci3HCfI5b45aoSmq/XsOdlh1ZuwP0O7YBATQUZ
         MJd9FSvyZCH4lbSeQRNGB2kqDvFI9NDYXcVB4rRq4UK36D1Wqvf4Ft5I6Xt2iZmWDEIn
         uizEDRioYSFoF76rqK5p8HsObgdizZPCnNc0Z9KUIB//YL4FbSd0p1wrRLAELglEZ9UX
         GBAw==
X-Gm-Message-State: AO0yUKVvIA/sLbOTSvHDFhzS3HaNGruUF5xdldhDDomlz8MnxnB58Rfk
        FG0KvNGc167gueupFp8WIw==
X-Google-Smtp-Source: AK7set8VKbE+giXOgvwEkFnFPJqhvTpwEZvJuIW+z00jUVJQBwGz+tj6WYdFvE2Wi9xW42BxNwV9yg==
X-Received: by 2002:a05:6808:124f:b0:378:53b:f56d with SMTP id o15-20020a056808124f00b00378053bf56dmr247614oiv.37.1675207351042;
        Tue, 31 Jan 2023 15:22:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m7-20020aca6507000000b003631fe1810dsm3597890oim.47.2023.01.31.15.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:22:30 -0800 (PST)
Received: (nullmailer pid 2138586 invoked by uid 1000);
        Tue, 31 Jan 2023 23:22:29 -0000
Date:   Tue, 31 Jan 2023 17:22:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-sa8775p compatible
Message-ID: <20230131232229.GA2136940-robh@kernel.org>
References: <20230130130756.144160-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130130756.144160-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:07:56PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the sa8775p platform's KPSS watchdog.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Krzysztof: I'm now adding any link here as the v1 of the sa8775p DTS patch
> did not use this compatible and v2 is still WiP.
> 
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

I don't see the watchdog maintainers copied as they would normally apply 
this.

Rob
