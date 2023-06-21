Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED1F737BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFUGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjFUGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2FE199C;
        Tue, 20 Jun 2023 23:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50FE46149D;
        Wed, 21 Jun 2023 06:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D10BC433C8;
        Wed, 21 Jun 2023 06:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687330334;
        bh=EwqKQ1nwum2bfJwwQKl3k0V2eCGACGa57qfG+/yXvak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olTwWmhdGxPC+rgbQ+rHhQpbB2lyELiJZabUbSj3QLdmhZIghHr9lpwARyBdVJHTE
         LyceFTv2U7Jd14qZCHTaKdqMxe3GE/L00syR1O9h+Uf2P8Kc0I9Jqkxz+iH3F6lbDG
         F73z0CweO52sbLowqrfIa1URIGjWqUC8fx85odgarQH5qDLfbYycz3eyGNjVcqf8wh
         5qL4ytU+kfs7Rg+tEDEsV8+Ba79+QvmR4TAt6qff+ireIJzW8ey0JhjZXry6WSw3j/
         AhnvcIeJbod1PciEAXNQeYckL2l0xWwldS8Fr1q790w5d7bkvA/g2CyTAc+CjJlX8R
         GztPbZmNDy1Zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBrhQ-0003uF-TX; Wed, 21 Jun 2023 08:52:16 +0200
Date:   Wed, 21 Jun 2023 08:52:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-crd: Fix naming of
 regulators
Message-ID: <ZJKeIHPa5CxdE83j@hovoldconsulting.com>
References: <20230620203915.141337-1-quic_bjorande@quicinc.com>
 <20230620203915.141337-2-quic_bjorande@quicinc.com>
 <8b8c35ba-e495-6363-e8fd-65e60bc6e879@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b8c35ba-e495-6363-e8fd-65e60bc6e879@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:42:12PM +0200, Konrad Dybcio wrote:
> On 20.06.2023 22:39, Bjorn Andersson wrote:
> > The external regulators in the CRD seems to have inherited their names
> > from the X13s DeviceTree, correct them.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> Please also update the node names to match.

I don't think that's necessary in this case. The labels and node names
currently used are either close enough or more descriptive.

Johan
