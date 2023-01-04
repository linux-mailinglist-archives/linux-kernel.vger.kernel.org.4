Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC80265CE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjADI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjADI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:27:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC131A200
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67A7AB81338
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B42CC433D2;
        Wed,  4 Jan 2023 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672820814;
        bh=cRL/J+UmJxcetWKCEQQkr5S6t1RbcbYYk2mexW6OtCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0S+TV4NTmBLFtZBpj+BCxaUNDJ53dfTdRG8LGlfhkmceYUNXRIJy5EkaWTrWl50TU
         1Ul8Y6Kky1L5eO4hd4j1vHfSRHNu+fr0YVPGDRlj1dqMMa351PhSQ562cjlplntPvE
         P3cm6rACgKvfOc7lixLy7SeFnz+Lq5eABi/ae2Y0=
Date:   Wed, 4 Jan 2023 09:26:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        inuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/misc/ocxl/context.c : eliminate unnecessary type
 conversions
Message-ID: <Y7U4S+SDvmy/h8xk@kroah.com>
References: <20221226025145.4363-1-chuanjian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226025145.4363-1-chuanjian@nfschina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 10:51:45AM +0800, Dong Chuanjian wrote:
> remove unnecessary void* type casting.

That says what you did, but not why you did it.  Please read the
documentation for how to write good changelog texts.

thanks,

greg k-h
