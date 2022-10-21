Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D946606CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJUBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJUBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:17:42 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E1202703;
        Thu, 20 Oct 2022 18:17:41 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id y67so1648449oiy.1;
        Thu, 20 Oct 2022 18:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL5LL6cJlbDnM8/KGXtrGewtLYRr0rcchjp16D0qqAA=;
        b=Q93dZiIbchBuf9TprAOdv0569gNWMsWvhSYav98s7A+efYxGMt/vHgFwjDnh1us9Ga
         gXbp2IJAgYJuwUqsgs4VTR6RSfcR9qQZrmyLHdNGs4Gp9r7uUq3FNqFz0rsvpSA7gny/
         X3HT7QNoq6hgyT84iKNwVsdS+YoAuwB4O9iv4ZF5k0S0D/C8yoiLYv5gjN9JOmgNXcsd
         fMo5cF5CbWrgzoTo4KhZ9YdA4FiEemrloKxZxlEutnBeRw3BH9hNpV47tyw8oOAGGPTW
         KaIAkzZAk6i8KKzlk1E4PMPJPN2vMxXh6U8dtd8DgN7C+i6wPPXKONYRPleWwZlhWmWu
         SGeg==
X-Gm-Message-State: ACrzQf2b+7XvOO37LUDlcod6y5sLT6jSOU9RkseK1ORGjp4s5l6kia8n
        NNQXIL1Dtdf9VAYdoP1wng==
X-Google-Smtp-Source: AMsMyM5ecbJHYvekS11E0d3xBySst2ruiv93TLitCQ6n6HkR12DhK1RqG7G3hZJ9CAWubjkvbgHL9g==
X-Received: by 2002:a05:6808:1985:b0:354:db4b:b946 with SMTP id bj5-20020a056808198500b00354db4bb946mr21683611oib.97.1666315060749;
        Thu, 20 Oct 2022 18:17:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v11-20020a9d604b000000b00661c3846b4csm546286otj.27.2022.10.20.18.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:17:40 -0700 (PDT)
Received: (nullmailer pid 2115153 invoked by uid 1000);
        Fri, 21 Oct 2022 01:17:41 -0000
Date:   Thu, 20 Oct 2022 20:17:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     rui.zhang@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        krzk@kernel.org, robh+dt@kernel.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lh.kuo@sunplus.com
Subject: Re: [PATCH v11 2/2] dt-bindings: thermal: Add Sunplus schema
Message-ID: <166631506083.2115099.11460226376275845041.robh@kernel.org>
References: <cover.1665990345.git.lhjeff911@gmail.com>
 <038211f33e4d5dd5129712aef2738a83577c7745.1665990345.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038211f33e4d5dd5129712aef2738a83577c7745.1665990345.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 15:32:52 +0800, Li-hao Kuo wrote:
> Add bindings for Sunplus thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v11:
>  - Remove the remove function of the platform_driver
>  - Fix error reported-by: kernel test robot.
> 
>  .../bindings/thermal/sunplus,sp7021-thermal.yaml   | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
