Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAA6B0AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCHORf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCHORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:17:32 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636446AE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:17:30 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1pZube-0008Q3-Q9; Wed, 08 Mar 2023 15:17:26 +0100
Date:   Wed, 8 Mar 2023 15:17:26 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: delete driver
Message-ID: <20230308141726.elehxwjli64oeyru@viti.kaiser.cx>
References: <20230308131934.380395-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308131934.380395-1-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):

> Now that the same hardware that the r8188eu driver supported is
> supported by the real wireless driver rtl8xxxu, the r8188eu driver can
> be deleted.

> Also the rtl8xxxu driver supports way more devices, and is a fraction of
> the overall size, making this a much better overall solution.

> Thanks to the r8188eu developers and maintainers and reviewers over the
> years, your work allowed Linux users to use their hardware before the
> real driver was implemented properly.

> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Martin Kaiser <martin@kaiser.cx>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks for your time and patience reviewing all the cleanups we
submitted.

Acked-by: Martin Kaiser <martin@kaiser.cx>

Best regards,

   Martin
