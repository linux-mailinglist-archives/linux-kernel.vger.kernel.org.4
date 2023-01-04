Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD165D519
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbjADOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjADOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:07:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189739F87;
        Wed,  4 Jan 2023 06:06:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 806EBCE17BF;
        Wed,  4 Jan 2023 14:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F304C433D2;
        Wed,  4 Jan 2023 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672841195;
        bh=uarrwmHwSPbPDsDQUPiYN+x+cFA9g4HEYn3pRnZPD+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0Zk036Ho8UtTWfkc2MSjzM1PFi6td2zURO+S+n0PxECOtyshYdYocKvgCNjUkio/
         hHZ6sqzLD9MahWJCYojPMsnOwkgMmeAN37XVfWKtnuIQnGe6FyWUaRm2RxcnmVMhTk
         8TVfeahXXBRTr8zcksDhNjTRDTpf/yBA4aBtUxqc=
Date:   Wed, 4 Jan 2023 15:05:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y7WHjD4psjgAAyPd@kroah.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104133414.39305-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:34:13PM +0100, Martin Zaťovič wrote:
> +struct boardinfo {
> +	struct list_head list;
> +	struct wiegand_board_info board_info;
> +};
> +
> +static LIST_HEAD(board_list);
> +static LIST_HEAD(wiegand_controller_list);

Why are all of these needed at all?  Shouldn't the driver core handle
the bus list logic for you?  Why do you need a separate static list as
well?

thanks,

greg k-h
