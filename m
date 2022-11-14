Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CF96285FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiKNQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiKNQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3F3F06A;
        Mon, 14 Nov 2022 08:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B054BB8109E;
        Mon, 14 Nov 2022 16:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2CCC433D6;
        Mon, 14 Nov 2022 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668444552;
        bh=LuJxQ9ZanWwnw6gRktwMAxkqB/xkzJBmxo3YkByYA9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceHRkkVHhXHdYIA5qM3TOM53J0yknkuAm0/hqLxZTaEEg7wILiap84KIy08zO+IqN
         WRpfRlwc23A7NxuimodBlrgbL58XAk/YjRN269HxMKl0Ekg7iXs1efW1GSd7qZXYSd
         5jdg6nthpl+hAAyykmMdUAaPzE/mOI5KV8wKLXwW4MeBWo1F2MD3kjM+dik+l5df2F
         bFQ/EmKVmd/rTDSXTAUenNoOGaq4TiOPFVs4/7UAjw7n4HPfu2ZyGqsAO9agkvAESY
         PNp1nW1iVj3mHemhWa3sMLmQtoAQNQs3r+2QpOMxh2A1+z002TmPI+MlUc/Q740YZ3
         FgEOVC0+2fPfQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oucdT-0005EO-Oy; Mon, 14 Nov 2022 17:48:40 +0100
Date:   Mon, 14 Nov 2022 17:48:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Message-ID: <Y3JxZ+yFMLZkwNBi@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
 <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
 <efd412d0-7411-8b0b-4700-9e183a592048@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd412d0-7411-8b0b-4700-9e183a592048@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:39:26PM +0100, Krzysztof Kozlowski wrote:
> On 14/11/2022 17:32, Johan Hovold wrote:

> > Fair enough, I'll drop it. But there doesn't seem to be a good way to
> > describe the indexes currently and most bindings simply ignore to do so.
> > 
> > So what is the preference then? Just leave things undocumented, listing
> > indexes in a free-text 'description', or adding a free-text reference to
> > a binding header file and using those define names in a free-text
> > 'description'?
> 
> Either 2 or 3. Several bindings for small number of constants choose
> option 2.

Ok, we have three now, but USB4 will bump this to ten or so.
 
> > And if going with the last option, does this mean that every SoC and PHY
> > type needs its own header for those three clocks or so to avoid having
> > a common dumping ground header file where indexes will not necessarily
> > be 0-based and consecutive.
> 
> phy-qcom-qmp-combo.c has one qcom_qmp_dp_clks_hw_get(), so why would you
> have many of header files?

We don't know what kind of clock outputs later revisions of these PHYs
will have. The only way to guarantee 0-based consecutive indexes appears
to be to use per-SoC defines (e.g. as for the GCC bindings).

Johan
