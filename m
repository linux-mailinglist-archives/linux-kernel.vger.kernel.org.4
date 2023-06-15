Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46B2731444
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbjFOJkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbjFOJkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06FC30E6;
        Thu, 15 Jun 2023 02:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A9F621E2;
        Thu, 15 Jun 2023 09:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AE3C433C9;
        Thu, 15 Jun 2023 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686821951;
        bh=r6Tojsa+J6QEpbUTFlxJtR4e9II0ZoBS4MhS04CM0c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENhHmjQYvwCXAItnRbPoVGU2HfxOUEX8DOwQwlizbljXLQdyYtvtCyfvdNSbFPNe6
         BlsvG0koqV90GuFdC1PBzI3BFQDPhP9frmFX3qKKw4ESS2F5FAZ59wFiOUIQDmefcL
         +eUTn0E5sIkLK8qwQ6zCSgtEMeMwyb74I9bQcAZY=
Date:   Thu, 15 Jun 2023 11:39:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     sebastian.reichel@collabora.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH v3] usb: typec: tcpm: add get max power support
Message-ID: <2023061551-gumminess-clasp-6285@gregkh>
References: <20230322093120.8686-1-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322093120.8686-1-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:31:20PM +0800, Frank Wang wrote:
> Traverse fixed pdos to calculate the maximum power that the charger
> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> property.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

What ever happened to this patch?

Frank, can you rebase it and resubmit?

thanks,

greg k-h
