Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFADE5B76F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIMQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiIMQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:58:47 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB38A1C1;
        Tue, 13 Sep 2022 08:50:39 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-127f5411b9cso33244650fac.4;
        Tue, 13 Sep 2022 08:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=foJlUv46n5lMMNs0Q7Ku0d9gdElPGgCZVFMlT7KuK+0=;
        b=2B3TYjVJCxIT5W0NLaDGvH+2bQpFac7xiZBtbke2N01LvjpVRszgCEE20rvCSFF4B8
         UoIGZOy+rjMh+DZRu6Ko5o+tsI144qtJ/BYmDBQOjDNB0PzOjQJPrf4rcKFbk3Q2anhY
         vdgARETnPFvWu91aBcFFjkVvljEXUe8Gxit38eN7zbmseSXmYRbUrvGG8VKXMKUlXXBr
         t9WoRRWodvzUXojc+jbHbgEU58bwtklbII8gKmaONF03EmSipbDMByzlexxCY3/pwesZ
         6vXh0T6XwF1WPVzFCZrJydS8dgiVm4c3wk235MTgWNm6BZsUx2JhsrHBWtRoRB7tLT/M
         +vRA==
X-Gm-Message-State: ACgBeo3f22PFgQcT5u+B0ahcE8YteZRopTovUCcWvl9vS8GOsyeWUIJx
        fTzwhuuHmZgJUOH4thhz8Q==
X-Google-Smtp-Source: AA6agR5LcWq3PN8/sz4CVvMmxOD9DMkwOlFV5vk5dDsbNSIRxxJomOiY9hpH3d6NqB/OpbsyDe6VBw==
X-Received: by 2002:a05:6870:1601:b0:101:5e61:d8ee with SMTP id b1-20020a056870160100b001015e61d8eemr2121147oae.244.1663084190070;
        Tue, 13 Sep 2022 08:49:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w8-20020a9d5388000000b00616e2d2204csm6069481otg.21.2022.09.13.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:49:49 -0700 (PDT)
Received: (nullmailer pid 3799539 invoked by uid 1000);
        Tue, 13 Sep 2022 15:49:48 -0000
Date:   Tue, 13 Sep 2022 10:49:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, dianders@chromium.org,
        lkundrak@v3.sk, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>, tzimmermann@suse.de,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: Re: [PATCH v1 1/2] Revert "dt-bindings: Add byteswap order to
 chrontel ch7033"
Message-ID: <20220913154948.GA3793808-robh@kernel.org>
References: <20220912113856.817188-1-robert.foss@linaro.org>
 <20220912113856.817188-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912113856.817188-2-robert.foss@linaro.org>
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

On Mon, Sep 12, 2022 at 01:38:57PM +0200, Robert Foss wrote:
> As reported by Laurent in response to this commit[1], this functionality should
> not be implemented using the devicetree, because of this let's revert this series
> for now.
> 
> This reverts commit a4be71430c76eca43679e8485085c230afa84460.
> 
> [1] https://lore.kernel.org/all/20220902153906.31000-2-macroalpha82@gmail.com/
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  .../bindings/display/bridge/chrontel,ch7033.yaml    | 13 -------------
>  1 file changed, 13 deletions(-)

In the future, can you wait for a DT maintainer review.

For the revert:

Acked-by: Rob Herring <robh@kernel.org>

Rob
