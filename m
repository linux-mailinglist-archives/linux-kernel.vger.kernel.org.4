Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3A7018A8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjEMR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEMR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67FF273E;
        Sat, 13 May 2023 10:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C4BF61B69;
        Sat, 13 May 2023 17:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794B0C433D2;
        Sat, 13 May 2023 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000567;
        bh=MSu/TpEdJdrnvtF76x6+fGy5u/mDG7b7IqCRROoSvpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g+Nvniih7rR995XaDdfR/rs5qQYiEl2r7g+WLBLE6QiVNKOuPdKfOpfukh7+KmBB8
         UYtsr9R0d8vtUqnPZmJXsLD+1KZs2BVWng+N+3wKssNeD8CahQz+iEBzrvX//y3+JA
         DghTWewi003oifGvq2UGDE8PIhWppEUU5Aw4un4Ka/irb1PAQ8onIzFMFEfX3rOwnq
         zdzkpil+fI9hQShlEJIrOHW2zvlPSYUC3A1ONGulPkP2hYIHm1Q6Fe7VtFDCdpuJlV
         Z1vheF9VRc4oKvhVpZwr3SQERpeOMdUL0DHKPeSnRHg/DluOj8mZ0GTMb1nZmiR8ps
         I2dhIZbL/pHKw==
Date:   Sat, 13 May 2023 19:12:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [dt-schema PATCH] schemas: iio: add label
Message-ID: <20230513191208.10ec3cf2@jic23-huawei>
In-Reply-To: <20230507171219.232216-1-krzk@kernel.org>
References: <20230507171219.232216-1-krzk@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 May 2023 19:12:19 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Linux IIO core code parses label property which is already used in
> several IIO devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  dtschema/schemas/iio/iio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/dtschema/schemas/iio/iio.yaml b/dtschema/schemas/iio/iio.yaml
> index 5ce5e147aef1..727ca0f9afec 100644
> --- a/dtschema/schemas/iio/iio.yaml
> +++ b/dtschema/schemas/iio/iio.yaml
> @@ -30,6 +30,10 @@ properties:
>        with a single IIO output and 1 for nodes with multiple IIO outputs.
>        A few unusual devices have a 2 level mapping.
>  
> +  label:
> +    description:
> +      Unique name to identify which IIO channel or device this is.

Ah. I thought this as covered by the entry in dt-core.yaml

If not fair enough, though is this flexible enough to cover that it can
exist at device level and in a channel node?

If so lgtm

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> +
>    mount-matrix:
>      $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>      minItems: 9

