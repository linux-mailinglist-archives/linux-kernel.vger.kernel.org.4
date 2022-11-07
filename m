Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418E461FAFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiKGRQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiKGRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:16:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A601CB38;
        Mon,  7 Nov 2022 09:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3222A611C2;
        Mon,  7 Nov 2022 17:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890AFC433C1;
        Mon,  7 Nov 2022 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667841385;
        bh=+SZNBt/tceWBlgtWwudC1qol0WuubiqHqZfUbfY7KoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtwLVz4SlE6idrow1A/o/Tm025pOzhUGJm+c/aylk2iGYG3iEEbWDrYSLYl3YXvVd
         aJ0mZAZMx0WsXAK6lZDZ6GZs8LbLSikrVx+/sGlQjkWgWFvRGO/abxXJZK2sbzEPo8
         OwrdwhRWHep3mpjC8XjGu55OOr7R3idTIeu8xoKJNCJ47OxHHXORH/xh+LLoKMPqx3
         jJzTSg+z/Q6YYvXmoWOXJ19IGORtvOI5vCkjKwqMc5hH+oKoi7xaHckBenQvTxxj/X
         VBucdIQvl6BYKWWGUrMC2nYX8HuKgU9NwoWF3Wqw+UPUE/KyaednZ3yXc1PcYCoF5l
         Xbt8RxSIZ61yg==
Date:   Mon, 7 Nov 2022 11:16:22 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dt-bindings: qcom,pdc: Introduce pdc bindings for
 QDU1000 and QRU1000
Message-ID: <20221107171622.nh62m4bf635rl2ae@builder.lan>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-6-quic_molvera@quicinc.com>
 <20221027182240.E9FA0C433D6@smtp.kernel.org>
 <eeb3e06d-316a-1ff8-b4b8-c257fa03a206@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb3e06d-316a-1ff8-b4b8-c257fa03a206@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:31:08PM -0700, Melody Olvera wrote:
> 
> 
> On 10/27/2022 11:22 AM, Stephen Boyd wrote:
> > Quoting Melody Olvera (2022-10-26 12:04:41)
> >> Add compatible fields for QDU1000 and QRU1000 pdcs.
> >>
> >> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >> ---
> > Is there a reason why this patch continues to be included in what is
> > otherwise a clk driver patch series? Can this patch be sent separately
> > from the clk patches (and not Cced to clk maintainers/list) in the
> > future?
> Sure thing. On reflection, this belongs with the misc support patches.
> 

Even better, the "misc" series goes through my tree but this patch is
unrelated. So if you send it on it's own it could just be picked up by
the PDC maintainer (or Rob).

Regards,
Bjorn
