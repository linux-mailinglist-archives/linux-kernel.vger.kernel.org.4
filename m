Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9979B61E9D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKGDnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKGDns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:43:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C62670;
        Sun,  6 Nov 2022 19:43:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BD660EAE;
        Mon,  7 Nov 2022 03:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C2C433C1;
        Mon,  7 Nov 2022 03:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667792626;
        bh=vJMXMhjRRH2tAhkB+zZFrEC95x2s5+eyVMSNAanNWaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emduUXpgAlRw70W/ylbLGfsPUZACpE/fZpJCQKVSGFOxHeX3em1cArMbRvdeAtgth
         pzV4fRYyox7qyAgMPxSpL0/EVjCxyzPDaQh6Tc96wstY3G35dqEDbuZvGpFdL5jfiZ
         RsVqXu9KI8bN1msv/7HuGhvj12Ex+pbWOE9yleYmSyGqrX0WNTd4royflPPeGXxtQi
         e0NNyB7eNUAoovOP3SDKGvRToRZlMRe2GoUzWw9xHfZ5btmpbQ/sFs/Z4BA18ZWkQG
         Pka8yThO0dcQLUYK4A76Kz+SjT0u97r9gs97LEBjzqhHsfl7DEDLAnDMTjXp+zOY8t
         Uuj6kijSL9oxw==
Date:   Sun, 6 Nov 2022 21:43:43 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: Re: [PATCH v7 6/9] crypto: qce: core: Add new compatibles for qce
 crypto driver
Message-ID: <20221107034343.iyknmiztjuxcuqqs@builder.lan>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
 <20220920114051.1116441-7-bhupesh.sharma@linaro.org>
 <b4016460-f43a-13f8-432e-47c27237e005@linaro.org>
 <9b111583-519b-95a6-15b5-243e88dc8d39@linaro.org>
 <37b509ff-4fc2-73f1-b135-c0930075ec29@linaro.org>
 <94ff2006-0051-19be-5eee-a5f71a07e26b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ff2006-0051-19be-5eee-a5f71a07e26b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 12:22:03PM +0530, Bhupesh Sharma wrote:
> On 9/21/22 11:57 AM, Krzysztof Kozlowski wrote:
> > On 21/09/2022 08:16, Bhupesh Sharma wrote:
> > > 
> > > 
> > > On 9/20/22 8:42 PM, Krzysztof Kozlowski wrote:
> > > > On 20/09/2022 13:40, Bhupesh Sharma wrote:
> > > > > Since we decided to use soc specific compatibles for describing
> > > > > the qce crypto IP nodes in the device-trees, adapt the driver
> > > > > now to handle the same.
> > > > > 
> > > > > Keep the old deprecated compatible strings still in the driver,
> > > > > to ensure backward compatibility.
> > > > > 
> > > > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: herbert@gondor.apana.org.au
> > > > > Tested-by: Jordan Crouse <jorcrous@amazon.com>
> > > > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > > > ---
> > > > >    drivers/crypto/qce/core.c | 9 +++++++++
> > > > >    1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > > > > index 63be06df5519..99ed540611ab 100644
> > > > > --- a/drivers/crypto/qce/core.c
> > > > > +++ b/drivers/crypto/qce/core.c
> > > > > @@ -291,8 +291,17 @@ static int qce_crypto_remove(struct platform_device *pdev)
> > > > >    }
> > > > >    static const struct of_device_id qce_crypto_of_match[] = {
> > > > > +	/* Following two entries are deprecated (kept only for backward compatibility) */
> > > > >    	{ .compatible = "qcom,crypto-v5.1", },
> > > > >    	{ .compatible = "qcom,crypto-v5.4", },
> > > > 
> > > > This is okay, so there is no ABI break.
> > > 
> > > Great. Thanks for the confirmation.
> > > 
> > > > > +	/* Add compatible strings as per updated dt-bindings, here: */
> > > > > +	{ .compatible = "qcom,ipq4019-qce", },
> > > > > +	{ .compatible = "qcom,ipq6018-qce", },
> > > > > +	{ .compatible = "qcom,ipq8074-qce", },
> > > > > +	{ .compatible = "qcom,msm8996-qce", },
> > > > > +	{ .compatible = "qcom,sdm845-qce", },
> > > > > +	{ .compatible = "qcom,sm8150-qce", },
> > > > > +	{ .compatible = "qcom,sm8250-qce", },
> > > > 
> > > > This is a bit odd... you have 7 devices which are simply compatible or
> > > > even the same. This should be instead one compatible.
> > > > 
> > > > I don't really get why do you want to deprecate "qcom,crypto-v5.1".
> > > > Commit msg only says "we decided" but I do not know who is "we" and "why
> > > > we decided like this". If you want to deprecate it, perfectly fine by
> > > > me, but please say in commit msg why you are doing it.
> > > 
> > > I understand. This patchset has been in flight for some time and hence I
> > > might have missed sharing some detailed information about the review
> > > comments and rework done along the way (in the cover letter for this
> > > series).
> > > 
> > > Coming back to your concern, here is the relevant background:
> > > - Please see:
> > > https://lore.kernel.org/linux-arm-msm/20210316222825.GA3792517@robh.at.kernel.org/
> > > 
> > > - Rob shared some comments on the v1 series regarding the soc-specific
> > > compatibles. He mentioned in the above thread that 'you should stick
> > > with SoC specific compatibles as *everyone* else does (including most
> > > QCom bindings).'
> > > 
> > > - So, while I had proposed "qcom,crypto-v5.1" (for ipq6018) and
> > > "qcom,crypto-v5.4" (for sdm845, sm8150) etc. as the compatible(s) in the
> > > v1 series, I shifted to using the soc-specific compatibles from the v2
> > > series, onwards.
> > 
> > Then the reason could be - Reviewers preferred SoC-based compatible
> > instead of IP-block-version-based.
> > 
> > What is confusing is the difference between that link and here. That
> > link wanted to introduce 4 different compatibles... and here you have
> > even 7 compatibles being the same.
> 
> The link points to v1 version and we are on v7 currently. So there have been
> other comments and reworks along the way :)
> 
> All of these have been referred to in the cover letter logs.
> 
> Again please refer to Vladimir's comments on v5 version here, where he
> suggested adding soc compatibles for 'ipq8074' and 'msm8996' as well.
> 
> -
> https://lore.kernel.org/lkml/7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org/
> -
> https://lore.kernel.org/lkml/f5b7c89c-3bdd-1e1e-772e-721aa5e95bbf@linaro.org/
> -
> https://lore.kernel.org/lkml/7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org/
> 
> Also the 7 SoC compatibles do not point to the same crypto IP version. We
> have two IP versions currently supported upstream, "qcom,crypto-v5.1" and
> "qcom,crypto-v5.4" (with patches for support for newer versions under work
> and can be expected to land upstream in near future).
> 
> However, if you suggest, we can add some comments in the dt-binding doc
> to reflect which SoC supports which version.
> 
> > > - Basically, since we are going to have newer qce IP versions available
> > > in near future, e.g. "qcom,crypto-v5.5" etc, and we will have 2 or more
> > > SoCs also sharing 1 version, these compatibles would grow and become
> > > more confusing. IMO, having a soc-specific compatible in such cases is
> > > probably a much cleaner approach.
> > > 
> > > Hope this helps answer some of your concerns and provides some relevant
> > > background information.
> > 
> > Sure, but I still think you should have only one compatible in the
> > driver in such case. You don't have differences between them from the
> > driver point of view, so the devices seem to be compatible.
> > 
> > If not, what are the differences?
> 
> There can always be requirements for compatible specific handling done in
> the driver. See Bjorn's comment here for example:
> https://lore.kernel.org/lkml/YZKhqJuFlRVeQkCc@builder.lan/ , as an example
> of 'clk_get' calls conditional based on the compatible instead.
> 

How about providing a generic compatible without the version number
(i.e. qcom,crypto) and then in the DT binding require this and
qcom,<platform>-crypto, and if we have such quirky integration behavior
for a particular platform we can add the special handling in the driver
for the platform compatible.

(And we obviously keep the two existing version-based compatibles in the
driver, for backwards compatibility)

Regards,
Bjorn

> This series is to get some early comments and might need some further rework
> / rearrangement.
> 
> However, I would request Rob to share his views as well on the soc specific
> compatibles, since it was originally his suggestion. I can rework the
> patchset accordingly.
> 
> Thanks,
> Bhupesh
