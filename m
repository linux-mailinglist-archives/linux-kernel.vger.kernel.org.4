Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816096EDB17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDYFPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYFPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0083CB;
        Mon, 24 Apr 2023 22:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99279622E7;
        Tue, 25 Apr 2023 05:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F9C433EF;
        Tue, 25 Apr 2023 05:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682399742;
        bh=rsBha+TxrWP7EfBGpjDX9i+tOjwFVeXBTrNnvpzrmsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmjx1jJVIP6+tVyr0+p1Uhggc6kkBzBl3ejTh5mFVZra4vmERsalUyhxzXIwYSLPd
         hb/HGdYgb7mRAScua9/RXT4p3Q6usyuDa3uw89uNcSvugICSgTQbmaJ0igNVG6xQf6
         55Yx/hj87t+5EU8cE2h7czFbVYL2z/Ryyv9X9mKA=
Date:   Tue, 25 Apr 2023 07:15:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ktestrobot@126.com, U201911841@hust.edu.cn
Cc:     lidaxian@hust.edu.cn, hust-os-kernel-patches@googlegroups.com,
        dzm91@hust.edu.cn, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org, s.shtylyov@omp.ru
Subject: Re: [PATCH v2] usb: phy: phy-tahvo: fix memory leak in
 tahvo_usb_probe()
Message-ID: <ZEdh-_Jv02qb6K4n@kroah.com>
References: <644741EB.013E97.00008@m126.mail.126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644741EB.013E97.00008@m126.mail.126.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 10:58:51AM +0800, ktestrobot@126.com wrote:
> Hi, Li Yang
> This email is automatically replied by KTestRobot(Beta). Please do not reply to this email.

But I will!

> If you have any questions or suggestions about KTestRobot, please contact ZhongYong <U201911841@hust.edu.cn>

First question, why are you responding from an email that is not allowed
to be responded to and forced to have us manually add an address?
That's not very nice or helpful for us who have to see these messages,
please fix that.

> --- Changed Paths ---
> drivers/usb/phy/phy-tahvo.c
> --- Log Message ---
> Smatch reports:
> drivers/usb/phy/phy-tahvo.c: tahvo_usb_probe()
> warn: missing unwind goto?
> 
> After geting irq, if ret < 0, it will return without error handling to
> free memory.
> Just add error handling to fix this problem.
> 
> --- Test Result ---
> *** CheckPatch	PASS ***
> *** CheckSmatch	PASS ***
> *** ApplyToLinuxNext	PASS ***

Why is only "does the patch apply" matter for this bot?  What is it
supposed to be doing here?  Is it going to run on every single patch to
this mailing list, and if so, how can we turn it off as "it applied!" is
a very very low bar to be testing something for, and we already have a
bot that does this.

thanks,

greg k-h
