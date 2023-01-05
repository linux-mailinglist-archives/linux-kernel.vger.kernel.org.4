Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC81565E9DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjAEL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjAEL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:27:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8B58FB4;
        Thu,  5 Jan 2023 03:26:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02BB619E1;
        Thu,  5 Jan 2023 11:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84619C433EF;
        Thu,  5 Jan 2023 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672918004;
        bh=O5GmPEzr+xFYw/w0H4Xxa05p2bpbCoIWBEtThkWuw7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztsAuA2tx6y/3blx8TwG2zSfpWKrObrd/twX7YaQi+2k+w8lIl9Fsf0NV3Rv6Uel+
         8E2t+k0ORucpZDAeKEXUQhxycrqpyfIZfPpZhetVX1HbC4Q12oCGwpcsHMUSJ7X0VB
         Q9ZdPSMKVJ4ijfCC3SOCEsmrnHVI/tUHbCbyZ+AU=
Date:   Thu, 5 Jan 2023 12:26:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lizhe <sensor1010@163.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH v4] serial: linflexuart: remove redundant uart
 type assignment
Message-ID: <Y7az8STWuaS5wsZx@kroah.com>
References: <20230104152444.3407-1-sensor1010@163.com>
 <Y7WdpQkqJA03z8w0@kroah.com>
 <41a69271.666a.1857d7827c3.Coremail.sensor1010@163.com>
 <Y7Wgk0W1vpiZMi52@kroah.com>
 <42d1b3d4.6710.1857dac01d8.Coremail.sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d1b3d4.6710.1857dac01d8.Coremail.sensor1010@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 12:45:02AM +0800, lizhe wrote:
> HI : 
>     thanks. Modified to LIZHE

Why?  Again, why not just use the proper Chinese characters that you use
to sign your name with in documents in your country?

And again, please do not top-post.  Nor send html-formatted emails...

thanks,

greg k-h
