Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D94615793
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKBC3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKBC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5025E0;
        Tue,  1 Nov 2022 19:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1696E617A9;
        Wed,  2 Nov 2022 02:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C04C433D7;
        Wed,  2 Nov 2022 02:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667356145;
        bh=UXO3O7EnCazPpUsrCRuwMDNGIofMdK8l9wkbNLmlvRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLbTjWwaf77hwR0gyp9frm5MpOS2rmvSqLx7X6lRDJFOv00DyhyrSfzap9F1CkHxf
         2KBdrmcuDHGktFpd6M7pQ0b05Jvv9a9SqzcB+BsIpH+3dzgKyZ8TYYbihujejMjhfn
         pv48k4G5FvzysnEwVYsSPTnViQjRcjEAxR1CblqE=
Date:   Wed, 2 Nov 2022 03:29:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Message-ID: <Y2HWJUuir8E33GkP@kroah.com>
References: <20221022182828.give.717-kees@kernel.org>
 <202211011915.02EDB6377@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211011915.02EDB6377@keescook>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 07:15:43PM -0700, Kees Cook wrote:
> On Sat, Oct 22, 2022 at 11:29:47AM -0700, Kees Cook wrote:
> > This is so very long over-due. We just need to do this and put an end
> > to this legacy operation.
> 
> thread ping. Should I carry this in my hardening tree instead?

I can take it in my tree, I have a bunch of tty/serial patches to go
through this week, give me a few more days please.

thanks,

greg k-h
