Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9AA74B01F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGGLpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGGLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCF128;
        Fri,  7 Jul 2023 04:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71219618EE;
        Fri,  7 Jul 2023 11:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BF5C433C8;
        Fri,  7 Jul 2023 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688730307;
        bh=hYR2v6vBRoKSEbMKL5joI8ALWET1hUcjOO4qG93jcKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsZvxJgmvhgRKzram15wtfTjOx0BhHxv/7P6mPVe9jOwW+X5rCqE2Oz1Czz+brTJL
         3ErR1td/Jo/BdvLOeCTFhC+E5lJfbo2qAI41S4G5xGGV/m1tN33ccTiOd9uz5B6/7b
         82AIR+NkIalWstvOVKQdaskaPjVKOF/7igDXclcVSkc3O/CuXDMmuAGjJ2ON0hb5yM
         N2HVIpTitSkC5ycFPdcO9RInOUB7QkML7tTznRCkFsfPp5wvREJfYUVkx77Iocd1gn
         X3X9IvJglNI8RSRBfb7IL+I7IWqwlIjtfL/B4gGSN8whtaXkBE0+RIGHiMo8J6NvQ6
         2JwHmH2X4IG9g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHju1-0007TH-1n;
        Fri, 07 Jul 2023 13:45:34 +0200
Date:   Fri, 7 Jul 2023 13:45:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com,
        mka@chromium.org
Subject: Re: [PATCH v9] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZKf63XOPsImef2y2@hovoldconsulting.com>
References: <20230707113645.10673-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707113645.10673-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:36:45PM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---

There is still no changelog here as I explicitly asked you to add.

You also did not CC all people who have been reviewing your previous
attempts.

If you don't listen to feedback you will never get your patches merged.

Johan
