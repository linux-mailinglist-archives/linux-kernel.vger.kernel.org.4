Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A28B745D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGCNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGCNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004FCE64
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6047E60F25
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B5AC433CA;
        Mon,  3 Jul 2023 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688390526;
        bh=Trywcfsa/uvFjkf2ACNVhmLo5o37CppGNgULzJQ5fAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hkwt3U142/R+UocLGP4ZwlxWLh8dvbpo1a8UBHQJ3uY+uFCGA5CYCQMK6Ubl40sqy
         sDRbISx2jp3LHFWqBhlBowxb2VXvuUfXUgUQU8KqwOWJYGHDiltwoQpABp3juE6ogW
         5D+JxrXMt6sAihnoJrfWNooNRJQKhuceuICXoa4Y=
Date:   Mon, 3 Jul 2023 15:22:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8192e: Rename function IsHTHalfNmodeAPs
 to is_ht_half_nmode_aps
Message-ID: <2023070321-unsubtle-customs-16f9@gregkh>
References: <ZJp8cug8OwyvcLbD@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJp8cug8OwyvcLbD@tacos.darkphysics>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:06:42PM -0700, Tree Davies wrote:
> Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_aps in order to
> fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> v2: Rename is_ht_half_nmode_a_ps -> is_ht_half_nmode_aps
> ---

As per the documentation, the "v2..." stuff goes below the --- line so
it will not end up in the change log text.

And you don't say why you changed the name here, why?

thanks,

greg k-h
