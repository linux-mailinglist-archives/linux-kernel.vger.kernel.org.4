Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95D60307D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJRQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJRQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F32634D;
        Tue, 18 Oct 2022 09:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C59AEB81FE7;
        Tue, 18 Oct 2022 16:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E71CC433D6;
        Tue, 18 Oct 2022 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666109066;
        bh=kwn/hWdH9/e8LfszuP6LsH+3JjR3b5A0pHJNAWEXDhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0jlz5PaPhZ0U97fvM3qBLMgwAkRhqwijbu1o98DbDPy+DabB6V/ayEcy5iWYgctC
         F+ihjARVSBGYqtd5prH/ipvWlYVUaZYueEMrmTKh7erHw4tmdZWfkvDXI2SoRkP56z
         icbeVBKP5rz9SPCwBJdvmKL+4ZxewBs8/7fqVqRGwlQr2ROsRXC7gRgTj/6Q733lgK
         bVHGoKFfX9SD+bR81VHCXpzhQnHxkgyBBm1WNdSfEUiqgrNDlgcGiQHcu+69Fu0dHl
         LkZji6Mywv4X36Et+CNR8MNcs+8VAO3XYACU2hLJ1uMK6O2wn5sVom3BkAnXOL2LGh
         JrGpLi6jvRrdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okp4g-0006F0-St; Tue, 18 Oct 2022 18:04:14 +0200
Date:   Tue, 18 Oct 2022 18:04:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
Message-ID: <Y07OfmfQgQWFzHZY@hovoldconsulting.com>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
 <Y05+E90tmlq2tNFa@hovoldconsulting.com>
 <CAA8EJprwhEvUfUr-zDir4zFh_NAyr0qPbrHi6Hf8=2HC1dAhaw@mail.gmail.com>
 <b0c1bdfb-4a31-9deb-1f0a-0ed813707464@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c1bdfb-4a31-9deb-1f0a-0ed813707464@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:32:07AM -0400, Krzysztof Kozlowski wrote:
> On 18/10/2022 07:37, Dmitry Baryshkov wrote:
> > 
> >>> And yes, I think we should also upgrade
> >>> older DTs, keeping drivers backwards compatible (for some time?).
> >>
> >> Possibly, but I'm not sure it's worth the dts churn. As I mentioned
> >> elsewhere, supporting both the old and new binding in the driver is
> >> mostly trivial, while encoding the deprecated bindings in DT schema
> >> sounds like it would be painful.
> > 
> > This is probably the time where Krzysztof can advise us. I'm still not
> > sure when it is expected to encode both old and new bindings in the
> > schema and when we can update both the schema and the DT.
> 
> I do not follow what exactly the proposal is. Are you asking whether to:
> 1. keep existing DTS compatible with old driver?
> or
> 2. update existing DTS so it is working only with new driver (and not
> compatible with old driver thus having ABI break)?
> 
> If so, it is less question to bindings but more to the usage of DTS in
> other projects (like bootloaders, firmware, BSD) and generic
> recommendation is: do not break other users, if possible. It is however
> up to the platform maintainer (Bjorn) to decide on this, not on me.

The question is whether to convert also the current bindings and DTS to
the new (sc8280xp) scheme (e.g. drop the child nodes and register
subregions).

The driver can support both binding schemes using the same compatible
strings for a transition period (or in theory forever) by checking for
the existence of a child node.

Converting the DTS to use the new bindings would obviously prevent using
them with an old kernel (i.e. 2 above), but I don't think that's a
problem (unlike backward compatibility during at least a transition
period).

My concern was how to describe the deprecation in DT schema if we were
convert them. By instead just keeping the old bindings as-is in a
separate file and continuing to support them in the driver we can have a
nice and clean description of the new bindings (sc8280xp) without the
legacy cruft.

If we were to start introducing conditionals on existence of child
nodes, and marking the old bindings as deprecated in one large schema,
then that sounds like it would be very messy and hard to read and
maintain. But perhaps there is some way to do this without such
downsides that I'm not aware of.

Johan
