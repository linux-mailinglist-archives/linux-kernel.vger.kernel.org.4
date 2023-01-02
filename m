Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B238565B430
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjABP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:28:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B92B5D;
        Mon,  2 Jan 2023 07:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E3861007;
        Mon,  2 Jan 2023 15:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E9AC433EF;
        Mon,  2 Jan 2023 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672673295;
        bh=JWrYBngKqO5VkF5TfrzZXzt8uQugHbYQYPAKZnDEjGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwFdzTp5BMzlq5KJw9CD+LfN56D9DN8nbZktDJ6ckSWiPsDl76FZTv6Yfja51OHqi
         Ep5AwR6vGNc63eRVjat/wM9Y03G+HaZKZBHvSlG4YHk9WZyS4Ogrx3zjMiuRYYn1kI
         jTUpa53kaoDMLBG+FP5ZuLte/vckXSCdMgadFCDJ+S4CMsEqCg35VK5lwm9HsrLA3L
         fvz8RwBCRQq8wVOAfL8eU8TcEzQZRarL0XkD8yMcCpKksAq6ufHdsHZPusY1mgpLkg
         NMHQSzQTflb4MIs4H10hhT4aUJcdc2iXVWnfZpgR7Fc0v5bvQBlxc1E9lNchzw0jP+
         WzVuz6lqQY3CA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMjo-00084g-P1; Mon, 02 Jan 2023 16:28:32 +0100
Date:   Mon, 2 Jan 2023 16:28:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
Message-ID: <Y7L4IHpWM/J6KTvc@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-6-johan+linaro@kernel.org>
 <1a8226ef-b16c-e713-94bd-807ca356ef8b@linaro.org>
 <Y7LyQZ6FotC5Rpmg@hovoldconsulting.com>
 <ae0499ce-f4a2-22a8-840a-6d7640079b93@linaro.org>
 <Y7L1r7ehoo68ZxJQ@hovoldconsulting.com>
 <97ba0421-530e-587b-fef5-16ffefddc0cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ba0421-530e-587b-fef5-16ffefddc0cd@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:22:30PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 16:18, Johan Hovold wrote:
> > On Mon, Jan 02, 2023 at 04:09:14PM +0100, Krzysztof Kozlowski wrote:
> >> On 02/01/2023 16:03, Johan Hovold wrote:
> >>> On Mon, Jan 02, 2023 at 01:20:03PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 02/01/2023 11:50, Johan Hovold wrote:
> >>>>> The wcd938x codec is not a memory-mapped device and does not belong
> >>>>> under the soc node.
> >>>>>
> >>>>> Move the node to the root node to avoid DT validation failures.
> >>>>>
> >>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
> >>>>>  1 file changed, 19 insertions(+), 21 deletions(-)
> >>>>
> >>>> Don't you base on some older tree? It was alreadt moved. Maybe other
> >>>> changes were also implemented...
> >>>
> >>> If you've moved this node is hasn't made it into linux-next (or the qcom
> >>> tree) yet.
> >>
> >> So you need to update your tree/rebase as this is already in Qualcomm
> >> tree. There was no linux-next release since a week, so that's not a
> >> solution.
> > 
> > As I wrote above, it's not in the qcom tree either.
> 
> Really?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=e5b8c08245307a82cdf180cd5d385a34ba1cfd9d

Sorry, most have looked at on old branch or something.

Johan
