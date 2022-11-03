Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1DC617CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiKCMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKCMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:35:50 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC82CE05;
        Thu,  3 Nov 2022 05:35:46 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso1898329fac.13;
        Thu, 03 Nov 2022 05:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQZ3pBlIi0rpM5a6PfKlKhrsDTBhVGlbxomkgGlrwXA=;
        b=0iYnD0eCqzz1iQ9xu2fEnIyODpwkK34BEYUrzoLSCBYvsVhkxCTNjLVaKC8ni1umTY
         HLRXuQvtGdkljOmvhPiDJUP6HKN35SjBaHEUQ8twcAshTbwCNXcc4i4yw2v7cJLrYEyC
         T8cIqlJtkmm7+8Gn+7lpOxT3nN2VFwK23ABXT8MEv8BmHWuP3UvdUJ135S7VdJUzH0mK
         TcPGwR8kf1cwapPKanSG9sPxxQZxsVxfvmbGMgZ0A1UEMRYa8VL0RqNy231sc4DKDixT
         wqHcqS7tYFwPm0Ut1fUamGXPWvXAitkZ1EZQIPKJAz8lgtBwcab8KFwYYSWMdQoxkFkE
         wkuQ==
X-Gm-Message-State: ACrzQf3Rdl3u6RDxzcX97x1ogRAD1e2im3O16PZrb16miZk3Piqj76uq
        gMgBxA4a8PlB3VPhD8pFRfxrykT0DQ==
X-Google-Smtp-Source: AMsMyM5WlQVuFfI3Hej6zl5+YtqKpPvfhlpNxJetQLlWzU3YMepE7Sxq8fKeSZ/kC1fuVSxpMI5JvQ==
X-Received: by 2002:a05:6870:8999:b0:133:15f9:82fd with SMTP id f25-20020a056870899900b0013315f982fdmr17446407oaq.276.1667478946042;
        Thu, 03 Nov 2022 05:35:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u11-20020a056871008b00b0013d7fffbc3csm261196oaa.58.2022.11.03.05.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:35:45 -0700 (PDT)
Received: (nullmailer pid 2140212 invoked by uid 1000);
        Thu, 03 Nov 2022 12:35:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Lee Jones <lee@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
In-Reply-To: <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
References: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
 <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
Message-Id: <166747792187.2121919.17636248726524785287.robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Thu, 03 Nov 2022 07:35:43 -0500
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


On Thu, 03 Nov 2022 09:05:44 +0100, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/maxim,max5970.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

