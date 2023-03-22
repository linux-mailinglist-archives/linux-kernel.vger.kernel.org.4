Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1106C45C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCVJJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCVJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:09:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A588AD13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB2461FD1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516BDC433D2;
        Wed, 22 Mar 2023 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679476140;
        bh=G5b3E38x/jL73QIWqA904ByX2RljZo34BWnDHuIWST4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1OisgQ3kA6KZO2NMncX4J+In0DzpHNsGCPNh8uInjTrCbM6+WJvPdxB+99AZCREW
         YnldyxxnzkOq8U0coa5vLdhtUOFv6Wugf3lKzUe5TGYzGKJXD7Dft247h52Q2Gx5hc
         5gpeAWuz84EQaecvfSVanCIiklw+ir/OEoXmZSmk=
Date:   Wed, 22 Mar 2023 10:08:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZBrFqtyY/HydnBdT@kroah.com>
References: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:26:26PM +0500, Khadija Kamran wrote:
> If condition and spin_unlock_...() call is split into two lines, merge
> them to form a single line.
> 
> Suggested-by: Deepak R Varma drv@mailo.com

You need to properly quote email addresses for our tools to handle them,
put a <> around them like you did here:

> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>

See?

Please fix up and resend.

thanks,

greg k-h
