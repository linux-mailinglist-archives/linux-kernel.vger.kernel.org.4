Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE06C32D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCUN1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7FB4ECFC;
        Tue, 21 Mar 2023 06:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974F161B39;
        Tue, 21 Mar 2023 13:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40AFC433D2;
        Tue, 21 Mar 2023 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679405209;
        bh=RdLMBzpfBNrelmEeiBemFOsH1oKoVkPmog529Dj3zBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIabjpMbtyrxevd6qJJQjlRXtjjR4eNSSDcb8utaFK/nJO9S6utOonqNNV9DCGUDt
         LA8Umbm/Cpon95G+Er4i46hjf1k9bW98wVd/cCqZfPpl3O+HWSXUYM42F0ruahIdtS
         bEaijBCOOwtPmY16c5DkU1rRMAtsGLUbjFnEgmKCIyZRb4uC+AY7SrAm9cBWEehBY0
         pd4i7Rze6xijcS8PW2RYBF3FeoGJjTQ5b/Atv7o42p+coz7YiiNboPMVW2pCU+UkXC
         5IczlMehJ8EVuMkp+nm2IJksi+zB/MZVDkvUUyPHfZ7weaOeAndWtfDPaV/qfRNy7b
         jp3fMjS0s4SWA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pec28-0006Kx-60; Tue, 21 Mar 2023 14:28:12 +0100
Date:   Tue, 21 Mar 2023 14:28:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
Message-ID: <ZBmw7HF6sPJPo4LK@hovoldconsulting.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
 <167940239018.531701.12929244936825953214.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167940239018.531701.12929244936825953214.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:17:45AM -0500, Rob Herring wrote:
> 
> On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> > Add an 'nvram' pattern property and a reference to the corresponding
> > SDAM DT schema.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.

All of these warnings appear to be due to existing issues unrelated to
this patch.

Johan
