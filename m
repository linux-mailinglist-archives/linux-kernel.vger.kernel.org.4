Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CA654540
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLVQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:39:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAFE286C7;
        Thu, 22 Dec 2022 08:39:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93402B81CFB;
        Thu, 22 Dec 2022 16:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B7FC433D2;
        Thu, 22 Dec 2022 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671727165;
        bh=egoBgDJa6cP4OcBqEvU1JwAhvMnDYhljcvNAPvTmGOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVsAaR3/PYuF4uefDRfG6KYtQ6kn5M9SvaAgseL3FsMxKUZLoQUbhfJ9s25goBFrr
         CYsQaziLynj0Nxw5LK8YdkwStTnCcNQXHZUwonRwC6x5Sq+J2ztAG35d+CNH3bHUM3
         sMJB1Kva+8U0JiUKuzBXOacf9PSlTvyZ7XvMF5/Q=
Date:   Thu, 22 Dec 2022 17:39:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc:     alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
Subject: Re: [RFC PATCH v2 0/7] Introduce STM32 system bus
Message-ID: <Y6SIOpsxNdezKCTc@kroah.com>
References: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:04:57AM +0100, Gatien Chevallier wrote:
> Document STM32 System Bus. This bus is intended to control firewall
> access for the peripherals connected to it.

Why is this an "RFC"?  That usually means "I have more work to do on it,
but I'll send it out now anyway".  What work is left?

And for most code, I know I don't review "RFC" changes as there are too
many "real" patches being submitted where people think their code is
ready to be merged.  Other reviewers might think otherwise, but be aware
of this...

thanks,

greg k-h
