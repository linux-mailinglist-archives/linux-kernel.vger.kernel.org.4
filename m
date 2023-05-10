Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD16FD722
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbjEJGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEJGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399C3A93;
        Tue,  9 May 2023 23:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2541761459;
        Wed, 10 May 2023 06:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A76C433EF;
        Wed, 10 May 2023 06:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683700567;
        bh=D4IBRl5aAm39h4BhXIU4KsHuuBi8BUCKSd1V2QNVxZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sky7Al0T5i0pSgQ7tsFKGO0U9Kj8CkQGBTfcBfTPmpSVLj/jgb6U64SIYvpJ2EQT2
         Zpd5Iva80bSOJsbZp8zEjivjB220fViFpZZMGjPydDVtD3GgJWvypU2hTqbEDfbHQx
         gvap9yCKgibKzFxPwX76UMHCKtdm8Q2gY5yhX1/A=
Date:   Wed, 10 May 2023 08:35:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v2 0/2] serial: core: fix broken console after suspend
Message-ID: <2023051012-steadfast-confront-94d2@gregkh>
References: <20230405111559.110220-1-lma@semihalf.com>
 <CAFJ_xbqNu3=_jq0HADad9zj+F=TPa4zCoi_8y6Fp3FjymQLkrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFJ_xbqNu3=_jq0HADad9zj+F=TPa4zCoi_8y6Fp3FjymQLkrA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 08:10:28AM +0200, Lukasz Majczak wrote:
> Hi,
> 
> Is there anything more I should do regarding these changes ?

What changes?

The merge window just was finished, so I now have a bunch of patches to
review.  Hopefully someone else can help review this one in the
meantime, which would help out a lot in verifying that this change
really is correct or not.

thanks,

greg k-h
