Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13292602E17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJROOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJROOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:14:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410424BFD;
        Tue, 18 Oct 2022 07:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE376CE1DE4;
        Tue, 18 Oct 2022 14:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA89C433D6;
        Tue, 18 Oct 2022 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666102449;
        bh=R2fJ5DmOV9x1HfJqlfZC/8dktnSxhk/IVxJxuL/mLFA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SacDykjoX1uUaKe4ku9qTs+de5fB8UhGUkEa0hpCFmD3tVWlICm/HjbC7EBumrOmy
         TS9e6YXlyHMTrSQRQ7dKV1e3FklMrm5QuejPH2ohRWaXAQq0BnCsCI1k5oZ77izNR+
         Nu6wP4ckjMTwmqw0Tad+QNYplDLWKg39lNc+jgqEOLcK3EsM778kNuT262uw6DzEzr
         SdWFGYEsPQJWG1qLZqye9QTXxppxiaokcEq1c9p4P1H0V3EVtIcT1L4QnUcIGwTe71
         0RCVqfiHwv8+Mh2UWKAIqreJ3s5TaF3SkJEnHjrksVihlSJDckV2TiGClHfNirLSI/
         KdXRrnkUm8YzQ==
Date:   Tue, 18 Oct 2022 16:14:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] drivers/hid: use simple i2c probe
In-Reply-To: <20221012163300.3928075-1-steve@sk2.org>
Message-ID: <nycvar.YFH.7.76.2210181613540.29912@cbobk.fhfr.pm>
References: <20221012163300.3928075-1-steve@sk2.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022, Stephen Kitt wrote:

> All these drivers have an i2c probe function which doesn't use the
> "struct i2c_device_id *id" parameter, so they can trivially be
> converted to the "probe_new" style of probe with a single argument.
> 
> This is part of an ongoing transition to single-argument i2c probe
> functions. Old-style probe functions involve a call to i2c_match_id:
> in drivers/i2c/i2c-core-base.c,

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

