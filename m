Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A4727AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjFHJHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjFHJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4719BB;
        Thu,  8 Jun 2023 02:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32CBA619E8;
        Thu,  8 Jun 2023 09:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B7C433EF;
        Thu,  8 Jun 2023 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686215225;
        bh=US0l4PB2drDkjK4e3OiOByMhePUj+X9j35s5ybK7zP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYJ3ciVBvOfuoJzxOlxKiFvszdU0hFOkzjnHUtVVtvo7Gczd+zhY5KskgCi0jRbq4
         Llm1T0d42oOESnqFqQQpIQ2taW9paBbyh5AMF78gd2xwBmUwhPjnYauei8MBbIYXWL
         9MNnqf5qL8VprC2nmI8aGQRVkp5V02sQL75uXCaA=
Date:   Thu, 8 Jun 2023 11:07:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.4-rc6
Message-ID: <2023060845-sharply-friday-f1e2@gregkh>
References: <ZICci0PIId0FlVuV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZICci0PIId0FlVuV@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:04:43PM +0200, Johan Hovold wrote:
> The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:
> 
>   Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.4-rc6

Pulled and pushed out, thanks.

greg k-h
