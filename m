Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18086637E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKXRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXRWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:22:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B69B7FB;
        Thu, 24 Nov 2022 09:22:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC4D620DD;
        Thu, 24 Nov 2022 17:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B9AC433C1;
        Thu, 24 Nov 2022 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669310537;
        bh=d/X53tK9KmT5R3bV+QTEQ0qCuivh4GtlmTT6z1+elAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyWNbeWOZeTwJQ+bKkEItbAEjx9DCGWL1+QpPl3kN4/WRbafs3ZC7zALms9yCUlti
         j7wz4dSFCjwGx9P7LWrFcLaBGoRVKDtV+doFvgpCOhUcYK5QKhTjDI4MHwtB9cRsXu
         VhiVJgbRE6qvvTw2Q2xxklyoqUkxNxyM/AeNf0ZB1pBobqTvvUQFmEneI98K5+J0sq
         BxR65B/ZbkP76Q1c+b5NWLGZH1gyDM7pNcaBLaIMn1hUgQLktSR4rzAe8R2C0+KJGa
         dWktG7yH4IT6XJFce3AeCk3VuxoBdYQhxKKLySr1iC3mRKowUk+/Wp0RhNC5blCnl3
         GswSyQTbWACWw==
Date:   Thu, 24 Nov 2022 22:52:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] phy: qcom-qmp-combo: fix sc8280xp binding (set
 3/3)
Message-ID: <Y3+oRZF868ZuoWTz@matsya>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-22, 09:50, Johan Hovold wrote:
> This series fixes the USB-DP PHY devicetree binding for SC8280XP and
> adds support for the new updated binding to the driver.
> 
> As the full series including the preparatory parts is over forty patches
> and I've been posting this in three parts of which this is the last one.
> In an effort to get all of these into 6.2, I've also submitted all three
> series before waiting for the previous ones to be applied. Parts one and
> two can be found here:
> 
>   https://lore.kernel.org/lkml/20221114081346.5116-1-johan+linaro@kernel.org/
>   https://lore.kernel.org/lkml/20221114110621.4639-1-johan+linaro@kernel.org/
> 
> This last series adds a new binding for SC8280XP that drops the legacy
> child node and the (incomplete) description of register subregions.
> 
> As the current bindings are both incomplete and incorrect it may be
> a good idea to update also the other platforms currently supported by
> this driver to the new binding scheme. The driver can support both
> schemes during a transition period before removing the corresponding
> code (dt parsing and clock-provider registration).

Applied 1-13, thanks

-- 
~Vinod
