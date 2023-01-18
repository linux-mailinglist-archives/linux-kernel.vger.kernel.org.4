Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3F672441
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjARQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjARQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:55:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194A16AE9;
        Wed, 18 Jan 2023 08:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BDD9618CD;
        Wed, 18 Jan 2023 16:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B7C433D2;
        Wed, 18 Jan 2023 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674060943;
        bh=KXVguWBBzZqFsfQ1lc00wLiy/2dhJ2rfbOtKjRQ+7Fc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=I2i8rJpVWQewx83DF+4qKd3/0jlZUbp82IlICMCEhkUAxdW5Z/4zcU5F4tyIpNcdQ
         WeZusJn5IK47rPyB7QjRElaoM1qd8obxUgoCpwQkXIfMrrpkITyQaRRFjOgdIKc6KD
         8ZMBPfEeyteKjyvcFDzQgpEMn6yJ2k1UTFooe73GhPrgiUrVrJjM0VC2Kt+wt8VHJJ
         GYJuqRO0YhlCimtYWviRn4iYqk4G4RuODGkhmcDON1FYe93ikRFWZBtd8tV1KvFRJX
         VVVfEsdpLTETjDb8KwMuVNd+W2kx2bARCVbvoPrvkT2z+SiGGO9cB5dVsQN50w+aH4
         jJlDu64EYJlEg==
Date:   Wed, 18 Jan 2023 22:25:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "phy: qualcomm: usb28nm: Add MDM9607 init
 sequence"
Message-ID: <Y8gka33KTscXK3HK@matsya>
References: <20221214223733.648167-1-marijn.suijten@somainline.org>
 <Y8GY51Cfkj7o1MJs@matsya>
 <20230116203549.5jzd2olxua662n6w@SoMainline.org>
 <Y8YzzCEqGi3m9fWM@matsya>
 <20230117091912.pzogxqvgf6kivi74@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117091912.pzogxqvgf6kivi74@SoMainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-23, 10:19, Marijn Suijten wrote:
> On 2023-01-17 11:06:12, Vinod Koul wrote:
> <snip>
> > > Thanks, it wasn't clear to me whether to suffix the title when already
> > > included in the Revert: "phy: qualcomm: ..." title :)
> > 
> > A revert patch is a patch as well so the patch rules apply there as well,
> > so should say "subsystem tag: other tags: Revert foo..."
> 
> Ack, but then /keep/ "subsystem tag: other tags:" /within/ the Revert
> string, so "phy: qualcomm: Revert "phy: qualcomm: ...""?

Ideally yes!

-- 
~Vinod
