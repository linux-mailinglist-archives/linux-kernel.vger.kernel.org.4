Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839B9736443
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFTHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFTHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D0E7;
        Tue, 20 Jun 2023 00:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA4261028;
        Tue, 20 Jun 2023 07:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB17C433C8;
        Tue, 20 Jun 2023 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687245454;
        bh=XvknyRL+7tT3OlhxFVOJOUpD0An+XG2R483V/GaZ6C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlpT3oH+S0kOwvRFPRiVwgwbdb+lJx9mEAs4Wz8QFbpOp49OXSjMJSGnd6hGqPzPm
         VpkrUEJmj6yw52Ps4l72Uj6vr8DGed9dbTVSFgkhNYRO+iRAYHeLANRxpJHkiW7yST
         8IRvSTBzzBrdKKrpKlAU7i/qiN9mfM312R5z8Pl0KM8zxLPvEba0k3ggc00JtV0muB
         vlAbjAGA/Y3ipLywmgyvjjBcadw/ZgmW1q2d/CpfWWKG5xzcZoNYjY8G7tHlSUDVkh
         VbmtLU8UCvNIX/8n7EHNpZ4fggK80f7nh4eaZDPuNxEyAJg58WHfOCuvxUWsu3Vdwp
         U4bDkYEN13EJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBVcM-0006sf-Bc; Tue, 20 Jun 2023 09:17:34 +0200
Date:   Tue, 20 Jun 2023 09:17:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Message-ID: <ZJFSjrf41PHe400c@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 08:43:09AM +0200, Wolfram Sang wrote:
> Tested with a Renesas KingFisher board. The chip correctly disappears
> from the I2C bus when the 'gnss0' device is not opened.

What do you mean by "disappears from the I2C bus"?

Does this device support both I2C and UART?

Johan
