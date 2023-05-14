Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBE701E50
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjENQ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjENQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF1830C1;
        Sun, 14 May 2023 09:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33CE461046;
        Sun, 14 May 2023 16:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73859C433D2;
        Sun, 14 May 2023 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684083456;
        bh=azQcBBbPk2rv7omNrITXRAFMi9S9ISRSdQJmPoOQdMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D4J2g+thK9vGflODsaDzELIp517mbQm0fxZHbvwQ+2Rs1H4m/rD71BHKzDXoerC9l
         +f2JRuhrg2VuN2Z+qEDRA10mhsHs67iT3uRfTImH5ha41P0gHVLyLe+mJrcEZrJ1sA
         v4FzzkLdbP+WHuIju+D+5fuC6uOydhZWU+52cmTG9cRzQCeA+OYk8qayQRILRhO/xu
         OmupscVn6fcr+HaXN+MnMGH/IUNkLI6XoPInfHviZ6fuH3gjiu4Z94FLAz45e+NRFl
         rTP3xx9YRcZJmHpZ4BSuO9v2Rj2UhJGAzjPJgz/v2rplTAxDQq73t3CzoGZKWNkADh
         u0DuoOXhXKosg==
Date:   Sun, 14 May 2023 18:13:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
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
Message-ID: <20230514181337.5e0cacc0@jic23-huawei>
In-Reply-To: <b179185a-0aa8-e58c-4fe0-4b83396ef30e@linaro.org>
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
        <20230507-brutishly-underhand-48c2949eb46c@spud>
        <20230513191355.28cdbb23@jic23-huawei>
        <b179185a-0aa8-e58c-4fe0-4b83396ef30e@linaro.org>
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

On Sat, 13 May 2023 20:10:40 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/05/2023 20:13, Jonathan Cameron wrote:
> > On Sun, 7 May 2023 22:06:56 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> >> On Sun, May 07, 2023 at 07:39:21PM +0200, Krzysztof Kozlowski wrote:  
> >>> Reference iio.yaml schema from dtschema to allow already used
> >>> mount-matrix property:
> >>>
> >>>   msm8953-xiaomi-daisy.dtb: imu@6a: Unevaluated properties are not allowed ('mount-matrix' was unexpected)
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>    
> >>
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> Thanks,
> >> Conor.  
> > 
> > Krzysztof,
> > 
> > These look fine to me, but I guess I should wait for the
> > dt-schema patch to land before taking them?  
> 
> You can grab first patch independently. #2 and #3 should indeed wait a
> bit for Rob's ack. They do not have any conflicts but they will fix
> nothing without dtschema patch.
Applied patch 1.  Thanks,

J
> 
> Best regards,
> Krzysztof
> 

