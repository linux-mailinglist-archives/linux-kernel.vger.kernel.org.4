Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238925E8BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiIXLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIXLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A181DEBA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3563060D3F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463BCC433D6;
        Sat, 24 Sep 2022 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664017255;
        bh=9uaMglO4d8AhlUSfEKHkSM8sH4uU4CqKL/M0IckF7ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsR20HN0ZS9kQ7VbLdcvvas/ILHJOSyQZifsc6Ibaa2VXwiPHMv0kQbyHV1jPAthK
         fy8ha/YlrXgiNoTsADilFpX1mTIX9DoDP6n0CxrgIcnS93P3td+kX2PpPIkMXJVFyw
         bAmnWZnK9OzeSBElAIkXOZrn11zWAO+yxT4WpScQ=
Date:   Sat, 24 Sep 2022 13:00:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: fix CamelCase struct member
Message-ID: <Yy7jZZArCCTC2/c1@kroah.com>
References: <20220919211948.136659-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919211948.136659-1-vvidic@valentin-vidic.from.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:19:48PM +0200, Valentin Vidic wrote:
> Fix checkpatch warnings for struct member pFirmware.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
> v2: drop the 'p' prefix from the struct member and always
>     use priv->firmware for access.

Also does not apply to my tree.  Please rebase and resend.

thanks,

greg k-h
