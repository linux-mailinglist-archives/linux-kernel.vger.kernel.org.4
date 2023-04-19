Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E146E7E76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjDSPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjDSPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3227EF7;
        Wed, 19 Apr 2023 08:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D0163FC4;
        Wed, 19 Apr 2023 15:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC738C433D2;
        Wed, 19 Apr 2023 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681918674;
        bh=U9geXgq4ygeKbujO9rJvRGQ8zOI7jRlhYWniDQFwO5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNeRX4FF7Nyh1PUa+d5JAg/Bn7U1VisN4i/Vq6/4aucy5SI87mNE5RwDR01kw7i6q
         YEKDWFiLte5XT1IqiyxDsBxOkmXm4gsHWYj6kjFJTV3vxKi/RV/4PWgvqmQV0VdMop
         wnc3l8Vur2JWWmTZ4rMzZ5TH+DswMWHdjElXS1ldSp624kC5qLlVi8nnNcBhIkeMu7
         GDYcxOkFHe5lvMds5JJ0UG2/6rg15sS+t4xqr5vZgVSmvz/y6x9XjR2R5RwIIv+1gp
         nQnTPXHGA+jnc0r/B+jdk4YFPjW8G4ZFP6SFWmqqkkrdjbviTkrAq0vh+mt0re36dc
         ApCth/3BTcHMQ==
Date:   Wed, 19 Apr 2023 16:37:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add
 nuvoton,ma35d1-sys compatible
Message-ID: <20230419153746.GA9904@google.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-6-ychuang570808@gmail.com>
 <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
 <69b0aa3a-f5d2-8310-81ae-61d379db0d3b@gmail.com>
 <20230414070326.GA1036697@google.com>
 <a7217c06-1037-9245-1241-33a7b1398907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7217c06-1037-9245-1241-33a7b1398907@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023, Jacky Huang wrote:

> 
> 
> On 2023/4/14 下午 03:03, Lee Jones wrote:
> > On Fri, 14 Apr 2023, Jacky Huang wrote:
> > 
> > > Dear Krzysztof,
> > > 
> > > 
> > > On 2023/4/14 上午 12:47, Krzysztof Kozlowski wrote:
> > > > On 12/04/2023 07:38, Jacky Huang wrote:
> > > > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > > > 
> > > > > Add Nuvoton ma35d1 system registers compatible.
> > > > > 
> > > > > Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> > > > What about the tag? Why did you ignore it?
> > > > 
> > > > Also, wasn't this applied? Why do you resend (incorrect version)?
> > > > 
> > > > Best regards,
> > > > Krzysztof
> > > > 
> > > When I was making this patchset, this patch was still not merged.
> > > So I'm not sure if I should remove it.
> > > This is just a resend with no updates. And I will remove this patch
> > > in the next version as it was applied.
> > > If possible, please add the following tags for this patch.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > I added this.
> > 
> > > Reviewed-by: Lee Jones <lee@kernel.org>
> > When did I provide this?
> > 
> > --
> > Lee Jones [李琼斯]
> 
> Dear Lee,
> 
> Thank you for your help. And, I'm sorry, I thought 'applied' meant
> 'reviewed', and this patch
> didn't actually get your review tag. If this offends you, please remove it.
> Of course, if you are
> willing to provide a review tag, I would greatly appreciate it.

If I replied with "applied" then it's applied and you do not have to
submit it again.

-- 
Lee Jones [李琼斯]
