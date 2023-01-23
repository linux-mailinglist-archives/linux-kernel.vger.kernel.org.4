Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD567839E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjAWRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:50:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A19F7ED7;
        Mon, 23 Jan 2023 09:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC5BBB80E1A;
        Mon, 23 Jan 2023 17:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16635C433EF;
        Mon, 23 Jan 2023 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674496244;
        bh=tyHf10drQO0OC929FqqeiYnnsDPHKJ/2AHK+MbGhFG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDyetirEr/aj1JNa4OShwIAz4J9uX8gSMj4FRKi8mbGYieeYFGCFgcBTPyp/c89Zj
         TzpCKu2tj2YGeoggACWsLB7IAnaAU1pVdGXUTdKIDa3oN6L/aR/axmzcTi1WgOUuHO
         2a/apmCNEFoDIl2qeTpyxIE1K9HtjgjsCqgbt6M0=
Date:   Mon, 23 Jan 2023 18:50:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: fix recently introduced problems in tty-next
Message-ID: <Y87I8TQ/MBiaXpWH@kroah.com>
References: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:38:55PM +0200, Ilpo Järvinen wrote:
> One build fail due to tty-linus -> tty-next merge and one problem
> smatch found.
> 
> Ilpo Järvinen (2):
>   serial: qcom_geni: Fix variable naming
>   serial: liteuart: Use proper error rollback
> 
>  drivers/tty/serial/liteuart.c         |  2 +-
>  drivers/tty/serial/qcom_geni_serial.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.30.2
> 

Oh nice, you beat me too it!

thanks for these, I'll go queue them up right now.

greg k-h
