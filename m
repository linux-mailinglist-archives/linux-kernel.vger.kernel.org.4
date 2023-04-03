Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4846D48FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjDCOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjDCOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65D17656;
        Mon,  3 Apr 2023 07:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A1161E42;
        Mon,  3 Apr 2023 14:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42787C4339C;
        Mon,  3 Apr 2023 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680532396;
        bh=kfn1EOIZo69ToCP+cFyo7QW+1x61rS6btJxVOG/V9Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jr4jAVQ0jwPkQu++/JISnCXSgnYz6H3f4v+xGXevlOQyL52kWnztxcRXnHJXHzr5b
         iYddsDYTXI1YxaNQSdjqho+z9rCVI2f5qXpD1qd184S/9RiloOJ1P9u6eIqW2BkrvE
         Dpd9ixUBzFzSiI3pqVz9C+hteeWwYI5VOv8TujkS8QuYtVQcqLed3nHrdETCnJTvsf
         DEjl++uNNhXMR6u0NHv+JyhTD9aZzoYuZn8TVRVRrJJcHK15itc5/S1Zn3DQdlGHfE
         ticz5L+A+/D9KADHyeCOWLssx4DqzlmlsLWmuMKjck1jcp5gUFRUVsTGICMR2qq+V7
         rsGLJxL0ZSpdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjLFb-00053s-VS; Mon, 03 Apr 2023 16:33:40 +0200
Date:   Mon, 3 Apr 2023 16:33:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and
 registers
Message-ID: <ZCrjw7SiUq0iNM0A@hovoldconsulting.com>
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
 <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
 <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
 <a04ca2bd-72f9-c89a-3fcb-36dd710b107f@linaro.org>
 <ZCrQe2ASeQXQJKS0@hovoldconsulting.com>
 <fac15b28-ef4a-dd7d-f0ac-51518d9dc1be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac15b28-ef4a-dd7d-f0ac-51518d9dc1be@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:47:28PM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2023 15:11, Johan Hovold wrote:
> > On Mon, Apr 03, 2023 at 02:46:41PM +0200, Krzysztof Kozlowski wrote:
> >> On 03/04/2023 14:33, Krzysztof Kozlowski wrote:
> >>> On 03/04/2023 12:54, Johan Hovold wrote:
> > 
> >>>> The problem is that the driver was updated before the binding was so the
> >>>> above mentioned probe error has been there since this file was merged.
> >>>
> >>> I grepped and that commit did not have such compatible. Are you saying
> >>> that the kernel which was released with this commit already had that
> >>> compatible in driver (through different merge/tree)?
> >>
> >> So I double checked, the commit ccd3517faf18 (which is being "fixed")
> >> was introduced in v6.0-rc1. v6.0-rc1 did not have "qcom,pmk8350-pon"
> >> compatible, thus it could not be fixed that way. Therefore this cannot
> >> be logically fix for that commit from that release.
> > 
> > Now you're just making shit up. A fix is a fix for mainline, period. If
> 
> Since this is your second mail in such tone and such phrases, I am not
> going to keep discussing this. Regardless of differences in opinion, you
> should keep the tone appropriate.

Yeah, sorry about that. But please do consider how your own choice of
words come across at times.

I agree that in the end it wasn't that clear cut as the state of the
binding and driver was inconsistent in 5.19 (and 6.0), and if this had
been an important fix that should be backported to trees where this
mattered then that may have had to be taken into account.

Johan
