Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723C370C591
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjEVSy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjEVSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C5BCA;
        Mon, 22 May 2023 11:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640EA62277;
        Mon, 22 May 2023 18:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EDCC433D2;
        Mon, 22 May 2023 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684781692;
        bh=QCjh96gVPr/tii1CJMfT/7zPJoBBtKS5qEYN5VbG2D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yaJMNFt2Y5NwQT8w84yJ/Ix7yMVU1PfjnwrQW7Or387NduX1g7HQD3NJsYg2EoUQW
         A8M4Y7+/Gs4j7W06WZn17ksnJxeLAtBuBFyt1brD56HoBVwYrNeG7xHtbaVALBtfDo
         nDpgrOkkQYV04TVcfOUhTsuEnzPelnQdsY33facA=
Date:   Mon, 22 May 2023 19:54:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     jason.gerecke@wacom.com, jkosina@suse.cz, killertofu@gmail.com,
        pinglinux@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "HID: wacom: Force pen out of prox if no events have been
 received in a while" has been added to the 4.14-stable tree
Message-ID: <2023052240-primp-usher-81a9@gregkh>
References: <2023052214-chance-guts-1400@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052214-chance-guts-1400@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:45:14PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     HID: wacom: Force pen out of prox if no events have been received in a while
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      hid-wacom-force-pen-out-of-prox-if-no-events-have-been-received-in-a-while.patch
> and it can be found in the queue-4.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Oops, nope, it broke the build, now dropped.
