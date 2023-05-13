Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E27018E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjEMR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjEMR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E264226;
        Sat, 13 May 2023 10:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5660361B86;
        Sat, 13 May 2023 17:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0BFC433D2;
        Sat, 13 May 2023 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000675;
        bh=yiWw1cz3q6ZUD/FVzJiR0s3AzJNV3D9m8nqotW2uD4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KEUSICdi1MIcg+LgtT3rPA423onqMa8Yz0ooJf9mT/PlnHGthoKqxc5mSPAJ/RQBp
         f68ose3W0wAcGHEhpjrGiS+uaLKzY4E9js7fQkUowqjqmPNRShyyT4Veksw/QyARC+
         9z8g8HsaOJUYXRqU76CdNE6wcPXuQMvs5zTqwgiPTF+quCke8ZZxwazbvQgyPjcEFF
         hvzJCb41S+nbAQ6GvCQB+bbOzxUQx/fskDXwgopwz0jZHIAVsq19FtioGsNF1Qb3jU
         WZXoBzASAfIF8egFpyFS7nZSRR7Rv/98ZsmHnUPtMLhOInuP+WxwuafdTDhjBsDeZK
         wVK74zZEkMxXw==
Date:   Sat, 13 May 2023 19:13:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: st,lsm6dsx: reference common
 schema for mount-matrix
Message-ID: <20230513191355.28cdbb23@jic23-huawei>
In-Reply-To: <20230507-brutishly-underhand-48c2949eb46c@spud>
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
        <20230507-brutishly-underhand-48c2949eb46c@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023 22:06:56 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, May 07, 2023 at 07:39:21PM +0200, Krzysztof Kozlowski wrote:
> > Reference iio.yaml schema from dtschema to allow already used
> > mount-matrix property:
> > 
> >   msm8953-xiaomi-daisy.dtb: imu@6a: Unevaluated properties are not allowed ('mount-matrix' was unexpected)
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.

Krzysztof,

These look fine to me, but I guess I should wait for the
dt-schema patch to land before taking them?

Jonathan
