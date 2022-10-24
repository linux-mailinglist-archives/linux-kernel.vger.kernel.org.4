Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1528560AC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiJXOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiJXOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A8C09A8;
        Mon, 24 Oct 2022 05:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 340A1612DD;
        Mon, 24 Oct 2022 12:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2F1C433B5;
        Mon, 24 Oct 2022 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666615668;
        bh=v5qe3uxJO58rT7qyMYbn1rAOhlOqSyCHdyiQEytIs1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pbf+h2HD2OPvi/J4NIiAXtIkWkGhgWB1KexNyN4aDwuzzc7mDGcdkiyBDaTdk8J4P
         E6v9Sejx/uYJWNG9CQNrmsFbZEgLfN95kMODeBeeBs/3Z6HF90oCkGhlIHKbdDXKIv
         oJDmPlKjH7WYSwXbND74E4/4eDbA2lt4LDjFd/JzzXT+GlXPpJV7oIJtee6d8lTg5B
         HVx5k6Bl1Gmyj1jYgm5wU5qwG+C2S1Cm8I3CyfHcKtYHQLCl2x0q0KAd/6LLMfopaU
         P+O64rDkMda35VUnieG+PjuoUKm4+kUXl9mBd9kZRswt/N30gU8Dw9LWiobl2RS133
         YSmPaWPuZpMoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1omwrb-0003wv-SH; Mon, 24 Oct 2022 14:47:31 +0200
Date:   Mon, 24 Oct 2022 14:47:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: add sc8280xp binding
Message-ID: <Y1aJY9CJLYD2thah@hovoldconsulting.com>
References: <20221007121110.5432-1-johan+linaro@kernel.org>
 <Y1aIeeazaDVPfDSc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1aIeeazaDVPfDSc@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:43:37PM +0100, Lee Jones wrote:
> On Fri, 07 Oct 2022, Johan Hovold wrote:
> 
> > Add a binding for the SC8280XP TCSR.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Applied, thanks.
> 
> NB: Didn't apply cleanly, so ensure you review my fix-up.

I noticed that when rebasing and sent a v2 here:

	https://lore.kernel.org/lkml/20221019122253.19669-1-johan+linaro@kernel.org/

Your fix-up looks equivalent. Thanks!

Johan
