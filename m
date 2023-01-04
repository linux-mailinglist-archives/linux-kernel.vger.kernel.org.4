Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E165CCD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjADGK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjADGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:10:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C5FD20;
        Tue,  3 Jan 2023 22:10:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C1A9B810A3;
        Wed,  4 Jan 2023 06:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBA0C433EF;
        Wed,  4 Jan 2023 06:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672812650;
        bh=Kbcq+uYhLv3BKlIhOzG7lEXrgxIBAdAfwWFOGqxXWm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5S+O6YP0yDEIft+xKaW50DZCIo+jNahqTvXBdoYJ6g41XJ7cH7SU845rNE1EedGM
         ZbNTrWPn2aRGXwsiJFB8URB290GK3nCtoC2jA3lJWehfGYHgqu2gQ/ZmQjgD/D1QUM
         g7rCUwCj+EE08VHgq2+3FPk+b4ZSd18mgxyIJlo0=
Date:   Wed, 4 Jan 2023 07:10:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc:     alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
Subject: Re: [RFC PATCH v2 0/7] Introduce STM32 system bus
Message-ID: <Y7UYaDL82NqFu7vK@kroah.com>
References: <20221222100504.68247-1-gatien.chevallier@foss.st.com>
 <Y6SIOpsxNdezKCTc@kroah.com>
 <98aa92e9-9ac0-0fe4-a140-ac478e261f94@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98aa92e9-9ac0-0fe4-a140-ac478e261f94@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:45:15AM +0100, Gatien CHEVALLIER wrote:
> Hello Greg,
> 
> I've put the "RFC" tag on the the patch set as it is based on bindings that
> are currently under review. It has been submitted with the idea to support
> the bindings proposed by Oleksii. Apart from this and the comments made by
> Krzysztof, there is indeed no more "work" planned on this change.
> 
> Should the "RFC" tag be omitted for the next version?

If you feel it is ready to be merged, yes, then please remove it,
otherwise it's obviously not ready and will not be merged :)

thanks,

greg k-h
