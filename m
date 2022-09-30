Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100735F0D34
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiI3OPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiI3OOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5353343C;
        Fri, 30 Sep 2022 07:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D293C62345;
        Fri, 30 Sep 2022 14:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBDAC43142;
        Fri, 30 Sep 2022 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664547285;
        bh=7UnwSXOB6shKfCQHM7L0KOwifPttNCBnzJ2w0rnlzK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EKgvh2WZQOLQHVQIJMdTU8+8dMdHbNnxgBm2yxJJF21w2sXsPGKzJqrbrz1iEI+TP
         kKU45+mkYZWfm4i9TrM+lH5B9Z3YJfGPKp+LXwFIdUR4lpN3s7y5Xceu8eyp1fBayX
         qqXvlzGcxE2VW8Ejau/TQAFjzypKn8fZiM5P3B4B4pEdsfBrccSMz3GY5IY26lSZJq
         x+GvtVlfcrmC9c2UKuxtKbRs6lsX5hBfniQqdDb32wzRz1InTjv/8SSoLl0yBbCGlU
         XE7gVW881cFrgaZVwo6TJXSGRZPL3G98dVY65QqgcUKZ96SSi0oUlpwteRhITKxhJC
         geig+OOOWZpWw==
Received: by mail-ua1-f44.google.com with SMTP id b7so1760058uas.2;
        Fri, 30 Sep 2022 07:14:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf2Flnof7ShIvtsgO5R8LRU6IHGtdiTrJJq98oYS22NU+O7XQQcF
        8qftXU4uzuc0t864mQA9pW5ZzqlJ7Br5I5XTxQ==
X-Google-Smtp-Source: AMsMyM6tmbeGs8WAbsagouNnCGeikv0UgHuHEpeJ7scOJRA6OHmQzWBNHAz3+EbsX5QLTinYFxLw9PZO5FxxSogzzL8=
X-Received: by 2002:a9f:29a3:0:b0:3d6:4c6f:9d92 with SMTP id
 s32-20020a9f29a3000000b003d64c6f9d92mr1117022uas.43.1664547284059; Fri, 30
 Sep 2022 07:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220930132842.23421-1-r-ravikumar@ti.com> <20220930132842.23421-2-r-ravikumar@ti.com>
In-Reply-To: <20220930132842.23421-2-r-ravikumar@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 09:14:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJVhAJ6TFNtndDtUX1FukuQorvm_o0eKK_CE6ANsPob1g@mail.gmail.com>
Message-ID: <CAL_JsqJVhAJ6TFNtndDtUX1FukuQorvm_o0eKK_CE6ANsPob1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dp-connector: Fix the property name for
 dp pwr
To:     Rahul T R <r-ravikumar@ti.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, tomi.valkeinen@ideasonboard.com,
        dri-devel@lists.freedesktop.org, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 8:29 AM Rahul T R <r-ravikumar@ti.com> wrote:
>
> Property name for DisplayPort regulator is not matching in
> the binding and the driver implementation. Fix the same
> in the binding
>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> ---
>  .../devicetree/bindings/display/connector/dp-connector.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. The binding is correct.

Are you confused that the regulator framework appends '-supply' for you?

Rob
