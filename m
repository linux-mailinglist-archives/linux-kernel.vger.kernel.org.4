Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689A6161D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKBLhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E524BF9;
        Wed,  2 Nov 2022 04:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1989961910;
        Wed,  2 Nov 2022 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEA9C433C1;
        Wed,  2 Nov 2022 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667389068;
        bh=xIxMAiXF+JLgxByB3rSWOKdiFANqw7ABTjZNkKTK0GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STR5j3Syvq3KxkvdTPJ9msz/mG2Cf12VmYPzf6HSUrBrVN4T2PArCH913G5i0noJB
         Ht/u99IWzgdDp+8MDfDi7c0WTT0nTb616vfFVRVtx5MJBA8UOnM3E/P491Ar+jRyrB
         bo3JeG6mYAurrXvCyafudLPc8qkcMCxRErUtApoyN6iG6C/HoyEhj5BP2XqxNg82Me
         BOAsN4nk1sbOaa+pEGyE/zb5mDWGIojSsSbiMLnIU8wlLL0OuVERbCrcKYjt/BBSDu
         p5F5TviRu+MyiARR9VOeWR2xbd0dMQFWeq1DuH8Rp468nfb8gqjx8T7ddKLxX1P6ej
         Vzcxr8TqakodQ==
Date:   Wed, 2 Nov 2022 11:37:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: Expect specific type for
 monitored-battery
Message-ID: <Y2JWhTcEvNxIwSB6@google.com>
References: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
 <Y1+MNL+fCfreAqMh@google.com>
 <20221031192658.GA3286587-robh@kernel.org>
 <Y2D0As4ezi/031lL@google.com>
 <CAL_JsqJUx2FtpYWSkx3cOFcywSux7P2sPpvbVmaryMdo1+xA_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJUx2FtpYWSkx3cOFcywSux7P2sPpvbVmaryMdo1+xA_Q@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Nov 2022, Rob Herring wrote:

> On Tue, Nov 1, 2022 at 5:25 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 31 Oct 2022, Rob Herring wrote:
> >
> > > On Mon, Oct 31, 2022 at 08:49:56AM +0000, Lee Jones wrote:
> > > > On Fri, 28 Oct 2022, Krzysztof Kozlowski wrote:
> > > >
> > > > > Core schema does not define type of monitored-battery, so the schemas
> > > > > are expected to reference proper type.
> > > > >
> > > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/mfd/ene-kb930.yaml      | 4 +++-
> > > > >  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 1 +
> > > > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > Applied, thanks.
> > >
> > > NAK. Please drop or revert.
> >
> > Dropping is not a problem.
> >
> > Would you mind providing some context?
> 
> I did elsewhere in the series, but simply we don't want to define a
> type for a property multiple times. It should be defined once
> somewhere common.

ACK, thanks.

Dropped.

-- 
Lee Jones [李琼斯]
