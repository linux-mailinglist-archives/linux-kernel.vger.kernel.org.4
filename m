Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9238F5F6E59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiJFTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiJFTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:42:42 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1410ABD78;
        Thu,  6 Oct 2022 12:42:40 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-132af5e5543so3370677fac.8;
        Thu, 06 Oct 2022 12:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsFWLs3oj8F4sWg6UBmyv5DMTDH4cKYoE2SmcAjVX4s=;
        b=KFrulq+pHE6dUzpBsGxB+bSwYuuNo42A/urwCBAwF7p9V2FJnAxdwQZLdUu6hiFX3W
         izJoksktACxPVOW//0YMpRztc+C/wQA3DQUEX3sDw5qW4sM3nCiFjyxJP7ZYq5djWwJM
         9xQWkgSJI7oIF7ZUED6NLcaCNu75SpW4q2RutX8gVTZcOkKYzSgkxVlBh+UnQO23VWBh
         UiwfhN2dbF++YFahve7n1iQtvgxdMuYyxyAcqG9FfcQn2PwJW2R03BMUE21mVr4VrhWS
         MB3MOz5K1KZ1iVq0ow1OE3PuJ1Fa+GwYjnDFaaAa7t3nZ8J2I3pByd7oDAk/5lzzDUZ4
         cUbw==
X-Gm-Message-State: ACrzQf0iWCHPF7B/P0/C6g6emCzKOvmXU9ZKrHF5K/dm5SPCfrMJau6W
        hlPNH4Zd5CULhKmk9Mz+RXdHm8ZN8g==
X-Google-Smtp-Source: AMsMyM42oi6zLhFx0obOpqCDseqKBUGSLCnnYF467OVUN2yvjv/jBJeXV6+C15FmARRL0/8JLVPdzg==
X-Received: by 2002:a05:6870:15c8:b0:133:16e6:5af8 with SMTP id k8-20020a05687015c800b0013316e65af8mr2299873oad.80.1665085360263;
        Thu, 06 Oct 2022 12:42:40 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id j11-20020acab90b000000b003504f8f6ac5sm16962oif.38.2022.10.06.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:42:39 -0700 (PDT)
Received: (nullmailer pid 69132 invoked by uid 1000);
        Thu, 06 Oct 2022 19:42:37 -0000
Date:   Thu, 6 Oct 2022 14:42:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: convert
 qcom,mdm9615-pinctrl.txt to dt-schema
Message-ID: <20221006194237.GA66144-robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
 <166505882828.1602503.18185089088624527425.robh@kernel.org>
 <85c9c9ee-37c3-733c-2c67-ac22734844f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c9c9ee-37c3-733c-2c67-ac22734844f8@linaro.org>
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

On Thu, Oct 06, 2022 at 06:21:28PM +0200, Neil Armstrong wrote:
> On 06/10/2022 14:27, Rob Herring wrote:
> > On Thu, 06 Oct 2022 09:57:58 +0000, Neil Armstrong wrote:
> > > Convert the MDM9515 pinctrl bindings to dt-schema.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
> > >   .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 +++++++++++++
> > >   2 files changed, 101 insertions(+), 161 deletions(-)
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/
> > 
> > 
> > pinctrl@800000: 'gpioext1_pins', 'gsbi3_pins', 'gsbi4_pins', 'gsbi5_i2c_pins', 'gsbi5_uart_pins', 'reset_out_pins', 'sdc_cd_pins' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> > 	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb
> > 
> 
> Yes it's fixed in the next patch, should I move the fix before the bindings conversion ?

No, because I don't apply the dts patches. It's just informational and 
ignore if you already took care of it.

Rob
