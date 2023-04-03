Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC66D455E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDCNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjDCNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:11:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122A27820;
        Mon,  3 Apr 2023 06:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 926F5B81A13;
        Mon,  3 Apr 2023 13:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A7CC433D2;
        Mon,  3 Apr 2023 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680527459;
        bh=iKjPhaUvm8e0DQeVxhOygNRHt8W/m4pm4zaFQW3ZNZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBTuTfJPb0CevFxn/NzI7BhlWWaPb2YgrQ/SWz9vEnPfU0uE2H732/cOpURfxBL7o
         RJe2A2KUNv2RLuHZ3XUvPVK5jy+gQX+T8fdeyAS6DVR0TFSqruX8qe6YCDncSvQ9V6
         3uaxdyyWruGpGp/dMuhIiox/MMl3yhMwHacdRaTVYya+o5TXEPTyrmYUziainJYXf4
         gpPF+8VNvwaItIrZOGIfnvhpf3q1XZP/N2jxXLwF9iajlhbBR3pd+OkS6QRBfN5ejF
         t/pn/HoExFDd4BQBVTMua1VlH4FY6PNBdIK/FL3JfJv4+hk1nryyCZOKHZ1artdI6z
         EANn+C2UuzdPg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pjJxz-0004LN-Rw; Mon, 03 Apr 2023 15:11:23 +0200
Date:   Mon, 3 Apr 2023 15:11:23 +0200
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
Message-ID: <ZCrQe2ASeQXQJKS0@hovoldconsulting.com>
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
 <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
 <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
 <a04ca2bd-72f9-c89a-3fcb-36dd710b107f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04ca2bd-72f9-c89a-3fcb-36dd710b107f@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:46:41PM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2023 14:33, Krzysztof Kozlowski wrote:
> > On 03/04/2023 12:54, Johan Hovold wrote:

> >> The problem is that the driver was updated before the binding was so the
> >> above mentioned probe error has been there since this file was merged.
> > 
> > I grepped and that commit did not have such compatible. Are you saying
> > that the kernel which was released with this commit already had that
> > compatible in driver (through different merge/tree)?
> 
> So I double checked, the commit ccd3517faf18 (which is being "fixed")
> was introduced in v6.0-rc1. v6.0-rc1 did not have "qcom,pmk8350-pon"
> compatible, thus it could not be fixed that way. Therefore this cannot
> be logically fix for that commit from that release.

Now you're just making shit up. A fix is a fix for mainline, period. If
someone decides to backport a fix from mainline then that fix may need
to be adapted.

That said, sometimes some of us do take the state of previous versions
of the kernel into account when developing patches in order to
facilitate backports. That's a different thing and certainly not
something that is required to fix an issue in mainline.

Johan
