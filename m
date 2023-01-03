Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1465BBAC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjACINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjACINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:13:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B1AE64
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2F9AB80E27
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B67EC433D2;
        Tue,  3 Jan 2023 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672733616;
        bh=sLn9Vawha9eeWYWakB4rqMAL1SntsgdKCm3hJXFVaYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0vlRB6oMyuI9i58WGrpDb1D7p4UfDmmuYeCqyalKmLeuqtQeIuWLrPUiX8XFa9UZ
         Bqhxe1KM7cg0TT4FGjwbg0kZuqJ3kUGIVBZutS+1Mgw7jOhkS03vNkziaBpXvOHfJa
         GnLOTPrmfjlfgc1FpN40X0TGKb/fhDXpwWR90B0aaG4xWtgmNy8FeTe3QdE81V4nNT
         jhKtZdmVUYsG1FoA+LhZZO02bCnBKH4PE/QUvaGTTCWi8CHiZYEb01Eax1VVhnjlDk
         cYQcaaA6OTkcbcJxrvZWU9car6HG5ShjM0i2kcJ1ASlZRFWDoxkVYJySNMzV9ICS3H
         eFsblgRuHrJcA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCcQl-0005q4-QA; Tue, 03 Jan 2023 09:13:55 +0100
Date:   Tue, 3 Jan 2023 09:13:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel-edp: add IVO M133NW4J panel entry
Message-ID: <Y7Pjwxo34MJDr01+@hovoldconsulting.com>
References: <20221231142721.338643-1-abel.vesa@linaro.org>
 <20221231142721.338643-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231142721.338643-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:27:21PM +0200, Abel Vesa wrote:
> Add an eDP panel entry for IVO M133NW4J.
> 
> Due to lack of documentation, use the delay_200_500_p2e100 timings like
> some other IVO entries for now.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
