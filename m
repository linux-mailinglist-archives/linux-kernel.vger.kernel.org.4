Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915167179D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjARJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjARJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E0475738;
        Wed, 18 Jan 2023 00:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33C6761711;
        Wed, 18 Jan 2023 08:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE5DC433F0;
        Wed, 18 Jan 2023 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674031304;
        bh=JE6oTJJg8zFAswHFzhsBSx8vEF1SwFX6/4C5ABy+iY0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SXiCadhBShJUM4bmF7D7uYdxd18+idPeX426h+8/2OoSg8BH7luvDzHApwhpt0GQT
         IQ/QqI4S5P7ABpQWVyO57qVJOg0NK7V1ug6ArMVmXJvAXDk60KRqZWJZTSAvBXZPv3
         zrcs4ZZqDdwvl55tEObZSRpj/0JX30tJzNVcPDGAFNXtx72+Z7QYEX8x0jRgagALTN
         Z6PBATJNH899vMzKeaHHbE3lHncUCOWRhQTZYK8OTMjghMbSmudRLP5Du5R0Xnip8s
         FfhoMSC1X/rjjsFNfDHV8Qhbf50QGaV8UESRswYVw8UNVavcQknwQFLb/icxb6dCFv
         CZ4/yMJ3GrLbw==
Date:   Wed, 18 Jan 2023 09:41:45 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: i2c-hid: use standard debugging APIs
In-Reply-To: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
Message-ID: <nycvar.YFH.7.76.2301180941320.1734@cbobk.fhfr.pm>
References: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022, Thomas Weißschuh wrote:

> When trying to debug i2c-hid I was not able to use the builtin debug
> mechanism because the "debug" module parameter is not writable.
> 
> We can change i2c-hid to use the standard kernel debugging APIs which are
> more discoverable and have more features.
> 
> There is a bit of a stilistic conflict between consistently using
> i2c_hid_dbg() and consistently using dev_<level>().
> 
> The second patch aligns debugging on i2c_hid_dbg().
> If this is unneeded, feel free to drop it.
> 
> It would also be easy to just use dev_dbg() everywhere for consistency.
> 
> To: Jiri Kosina <jikos@kernel.org>
> To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> Thomas Weißschuh (2):
>       HID: i2c-hid: switch to standard debugging APIs
>       HID: i2c-hid: use uniform debugging APIs
> 
>  drivers/hid/i2c-hid/i2c-hid-core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Applied to for-6.3/i2c-hid branch, thanks Thomas.

-- 
Jiri Kosina
SUSE Labs

