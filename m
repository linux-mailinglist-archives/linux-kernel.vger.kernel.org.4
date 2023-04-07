Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D046DB096
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDGQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDGQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2426B5;
        Fri,  7 Apr 2023 09:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AACC64ACF;
        Fri,  7 Apr 2023 16:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C768EC433EF;
        Fri,  7 Apr 2023 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680885112;
        bh=wq9bsk8ML93Zxf67UYy7/IDhV7suBYyyk0sawC6Ybjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gh0LtGCAAQ1zb5l1cUdTuceD+mUKO39AOIeJ235lMCZaI5Xj2YVjzxnG06MUr0Smy
         c594yBWqPFp0N4xv1zwYi4KwnnJWHbJY3DFwNqQt7yNlmLtTckxdSc+rIm3GPFyhVv
         1ITo5BLFJ9ASh6Wsz01JgbQhxMIEA5anWqimWwH68ZT/OufKkOTCLUIOhs2iuS1FYa
         j4h18FP5TnCun1thFqBk6VuDlBqhFZbqpnXucBmlEXsbOjCANQ+pDT5k/Zx2jtVn+V
         UJVL/crXcZ9Mks4l+Hz6ONnHxlAUWzTVMFJC+IcT6367MWBVejQl6D54aA8PstWEPW
         lPbSMAsXRdd0g==
Date:   Fri, 7 Apr 2023 09:34:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630: move DSI opp-table out of
 soc node
Message-ID: <20230407163442.ckbd4vxa5b2xu3eu@ripper>
References: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
 <20230327193938.42rvpttgo5p4kia6@ripper>
 <edb9fc8d-5d64-146f-fb82-6112c1d9455e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb9fc8d-5d64-146f-fb82-6112c1d9455e@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:39:00PM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 21:39, Bjorn Andersson wrote:
> > On Sun, Mar 26, 2023 at 11:16:05AM +0200, Krzysztof Kozlowski wrote:
> >> The soc node is supposed to have only device nodes with MMIO addresses,
> >> so move the DSI OPP out of it (it is used also by second DSI1 on
> >> SDM660):
> >>
> > 
> > This node has been moved into the dsi node, so if we still want this,
> > could you please update the commit message.
> 
> The OPP table has been moved *out of* DSI node. The v1 was moving
> inside, but this was not good approach, thus v2 moves it out.
> 
> I don't understand what shall be updated here.
> 

The commit message doesn't reflect what's in linux-next today and the
patch doesn't apply.

Regards,
Bjorn
