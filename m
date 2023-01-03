Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3362D65BB8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjACIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjACIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:00:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4931D9F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62773611E4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CCFC433EF;
        Tue,  3 Jan 2023 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672732821;
        bh=k+5wi5z9frX8sOYIkPjKZiglFoyuOXXDW+MWwVdUbPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5FKI09JvGgOigo3vzIz9sHQOHNRub6zl08HPrxrK4Mk6wZRiBo3oWrBdWy8KRAW/
         q+/I8JGXse7e7bZu3gLM25doB8xjp3VIHoSU0fAln4SW/fprJ69Cp2b2SpwnHeh6e0
         J8gRPt5ADquRhLVuRUNUPXoeyuwYy1QrwGJUTRZ+VCI9prDo3CrbLhBIh3fw3lVGqG
         9Egvd0N9upyg0FPnoc58c1KsajFHiV3ELH8L38mu97CFM/LvPF97hrTG0jNozm3k5O
         sa7PT+f9NB6K/0Rxfj5Njc41r5IlYiucbQS4ufFiL/4VoHf0wttmfNTNhCLgvsDpiZ
         roD1MSB6g1BTg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCcDr-0005fU-JS; Tue, 03 Jan 2023 09:00:35 +0100
Date:   Tue, 3 Jan 2023 09:00:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
Message-ID: <Y7PgoyhKLKCLvgR8@hovoldconsulting.com>
References: <20221231142721.338643-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231142721.338643-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:27:20PM +0200, Abel Vesa wrote:
> The actual name is R133NW4K-R0.
> 
> Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
