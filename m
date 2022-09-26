Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70A5EB006
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiIZSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIZSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:35:40 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3D1CFE0;
        Mon, 26 Sep 2022 11:35:37 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r125so9309861oia.8;
        Mon, 26 Sep 2022 11:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BtnhyvLybWCfecA3nqwouXdvXUpfliPbEywMwGR+ZEA=;
        b=hTjQGrs2QTsBUA85i/W/xw1otslItW2hkI0s7SW0eohkorrRDvqc5RpFrNfN4Wx7w0
         7x+HM+DzLjBM0R94I26dwZVFivTSZihuU3ml3pCP5NiisvXxb5/p1TF9PStJpw3zxXHu
         9dGY3pELY5bNFvhOcTt27ye0bfAsbWzhjPEO3GNgBkbg/NgeoUD6A0SG7vina8yoWIGM
         vWmGJXvoxhN5LeispHZ8WUBRe3UV1pO+t4jL8+mdQa28SPgoyxEcB7TmZvWgcuuufUuo
         gLFhIL17XAZei8aYpMSNZe1MfP5hwbKAL3zL/osLnHzTGZvvyOWDHieRwx7N1/gzy2Q+
         mX+w==
X-Gm-Message-State: ACrzQf0G+UvBP8+isQeXCMEgKhE2b17dOX6EPZkGj088eQivlVWqmnyt
        5lg/fZJ/d0bN4IStBDUG5A==
X-Google-Smtp-Source: AMsMyM7nG97GaN54V/QeBI0Mqu4e0/xB4FnV+xF7VPVZD1LB9+7GhBXXS/xvfsADaAnOH1aksClODA==
X-Received: by 2002:aca:1218:0:b0:350:fdf8:477f with SMTP id 24-20020aca1218000000b00350fdf8477fmr39649ois.159.1664217336794;
        Mon, 26 Sep 2022 11:35:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m9-20020a056870a40900b0011f390fdb0asm9280003oal.12.2022.09.26.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:35:35 -0700 (PDT)
Received: (nullmailer pid 2539757 invoked by uid 1000);
        Mon, 26 Sep 2022 18:35:35 -0000
Date:   Mon, 26 Sep 2022 13:35:35 -0500
From:   robh@kernel.org
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: timer: arm,arch_timer: Allow dual
 compatible string
Message-ID: <20220926183535.GA2539544-robh@kernel.org>
References: <20220922161149.371565-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922161149.371565-1-jean-philippe@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 17:11:50 +0100, Jean-Philippe Brucker wrote:
> Since the Armv7 and Armv8 architected timers are compatible, it is valid
> to expose a devicetree node with compatible string "arm,armv8-timer"
> followed by "arm,armv7-timer". For example a 32-bit guest running on a
> 64-bit machine may look for the v7 string even though the hardware is v8.
> VMMs such as QEMU and kvmtool have been using this compatible string for
> some time. Clean up the compatible list a little and add the dual
> option.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2: Reworked commit message, removed "obsolete" description
> v1: https://lore.kernel.org/all/20220916132959.1910374-1-jean-philippe@linaro.org/
> ---
>  .../devicetree/bindings/timer/arm,arch_timer.yaml     | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Applied, thanks!
