Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B6D65B404
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjABPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjABPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:18:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F326ED;
        Mon,  2 Jan 2023 07:18:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E45860FF2;
        Mon,  2 Jan 2023 15:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3E4C433EF;
        Mon,  2 Jan 2023 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672672707;
        bh=ax9NewVtatoLRzT5jQ0+d08UilidfARqHJVQab43GdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBiyJ817R9N1g6ADw1MYhFl6rZQaD3m8OFKTNnnezTd4kJk9BhOjPR5Lplw03M7eJ
         XXrQZ4tgQR/wiMs5JJPAtEcY3Xj5eP3+i9AAhoCKBcf9eqUxYD8/XCh3bVe/VHRE3K
         6/fkSQJHh/yri0Squzxn7mY45uqmm0qkLtY3uXpVoOXTGoh8J7N/GEHQOhLakIRsWz
         Nw0DBevNx9JPrA7LDN4FddhloFdmoJfG2Wc5UK7MsRJQA0VOR7c1XSyPDyMgDzjtas
         Z8Fe0TMHXvfDsWT3q4MQBcQ9Mxusfr/fCdeXShTttSgd0M9TdYpAXfBTUQCdXycLlI
         p5QGPnz8keCRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMaL-0007w0-3q; Mon, 02 Jan 2023 16:18:45 +0100
Date:   Mon, 2 Jan 2023 16:18:45 +0100
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
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Message-ID: <Y7L11WymK7BChUPc@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
 <c2a32bd3-90cf-6d1b-1ca7-76071232c81b@linaro.org>
 <791c0e37-f825-c324-7a99-163b0566c758@linaro.org>
 <Y7Ly1wlft4Y6VfIG@hovoldconsulting.com>
 <e57164f6-7dcf-5139-1b4f-6b63f9fd7786@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57164f6-7dcf-5139-1b4f-6b63f9fd7786@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:09:59PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 16:05, Johan Hovold wrote:
> > On Mon, Jan 02, 2023 at 01:24:34PM +0100, Krzysztof Kozlowski wrote:
> >> On 02/01/2023 13:23, Krzysztof Kozlowski wrote:
> >>> On 02/01/2023 11:50, Johan Hovold wrote:
> >>>> The wcd938x codec is not a memory-mapped device and does not belong
> >>>> under the soc node.
> >>>>
> >>>> Move the node to the root node to avoid DT validation failures.
> >>>>
> >>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
> >>>>  1 file changed, 25 insertions(+), 27 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >>>> index 4de3e1f1c39c..217b2c654745 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >>>> @@ -17,6 +17,31 @@ aliases {
> >>>>  		serial0 = &uart7;
> >>>>  	};
> >>>>  
> >>>> +	wcd938x: codec {
> >>>
> >>> Let's call it audio-codec and put it somewhere ordered alphabetically.
> >>> This avoids useless reshuffles immediately. Moving things back and forth
> >>> does not make sense.
> >>
> >> Eh, on the other hand SM8250-MTP uses name codec so maybe the rename in
> >> SC8280xp should be dropped.
> > 
> > Nah, let's go with audio-codec. Your MTP change hasn't been merged yet
> > so we can still drop or respin that one.
> 
> It was, ~5 days ago, so please rebase.

Again, not in the qcom tree yet AFAICS.

Johan
