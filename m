Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0E63A538
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiK1Ji2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiK1Ji0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:38:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC55F91;
        Mon, 28 Nov 2022 01:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45337B80CA7;
        Mon, 28 Nov 2022 09:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C711BC433D6;
        Mon, 28 Nov 2022 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669628302;
        bh=ZBPEVgYyyYB8Vme1exPX3XGtJW1SprRxwX9uh0E+9fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFx76DbcOJuFN6UcwPqpfPMG/02pyeHLmQoHSqgP59yD8O/xEaiLhijcBngXZivzl
         bifFUqwXaMfddZBnWlRT5mtQ+7EXPLWbJaAN+ZtYDktgqR2t6TqXtBmfF0Bs+VvZtW
         iBqr65otaRBHQgJxO314MfgeTiUjqIkNYS9aoX7ehcnyJYO5rYudeB5xbrWQTJ+Cxx
         PX/ghHWmMF/OPu6kk6UU2fcao5sK5VeF5aRibiB0Xd9Ysx8sVysm79tZdfEQvxkUJX
         o0pgENw21k+cqQdMIPIKKZrJiPVK/mR1wbQlgQnegu0+V+avLoE8jL4oAActupMB4A
         tE7EkyOK4T5AA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ozaah-0002PP-11; Mon, 28 Nov 2022 10:38:19 +0100
Date:   Mon, 28 Nov 2022 10:38:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Bruno Thomsen <bth@kamstrup.com>
Subject: Re: [PATCH] USB: serial: cp210x: add Kamstrup RF sniffer PIDs
Message-ID: <Y4SBi84gPzazcPL3@hovoldconsulting.com>
References: <20221127170811.7141-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127170811.7141-1-bruno.thomsen@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 06:08:11PM +0100, Bruno Thomsen wrote:
> The RF sniffers are based on cp210x where the RF frontends
> are based on a different USB stack.
> 
> RF sniffers can analyze packets meta data including power level
> and perform packet injection.
> 
> Can be used to perform RF frontend self-test when connected to
> a concentrator, ex. arch/arm/boot/dts/imx7d-flex-concentrator.dts
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>

Applied for 6.2, thanks.

Johan
