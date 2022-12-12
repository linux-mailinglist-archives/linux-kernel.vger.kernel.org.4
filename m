Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D564A2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiLLN5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiLLN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:57:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC4CC7;
        Mon, 12 Dec 2022 05:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF2D60FF4;
        Mon, 12 Dec 2022 13:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B939C433D2;
        Mon, 12 Dec 2022 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670853438;
        bh=mgb8zhVHcuWeR2Z4DGXOLQzTDYWFEAir/vKAyK/Bo/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zR1SV6GfLhX+Tln/A3D6W/vlY8rS6OOyOgSoxgvu55xkfp0+fd2xHualnP1GUIEWB
         5/f3qGuoIv20iYvJAz/S8Rgen9x5Mepo/A1Zc/TwAT9jL/SzWcV8BoYZ8/zTD2sSds
         3JkuukCAUnP8z00APo4zQNUGwClw+f/8Uj3aXHlk=
Date:   Mon, 12 Dec 2022 14:39:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/2] earlycon: Let users set the clock frequency
Message-ID: <Y5cu9xyxYe7Lkn/l@kroah.com>
References: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org>
 <20221123-serial-clk-v3-1-49c516980ae0@chromium.org>
 <CANiDSCs-CdhdvZF1PsDWivWiTB-=66DK4XOrv5hzbgbC9Z=+Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCs-CdhdvZF1PsDWivWiTB-=66DK4XOrv5hzbgbC9Z=+Rg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 06:24:19PM +0100, Ricardo Ribalda wrote:
> Hi Jiri
> 
> is there something else that I am missing here?

Sorry, been busy with other reviews.  I will queue this up after 6.2-rc1
is out, thanks.

greg k-h
