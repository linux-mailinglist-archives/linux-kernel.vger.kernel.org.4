Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C57614414
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKAFIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAFIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4711A0F;
        Mon, 31 Oct 2022 22:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E75161425;
        Tue,  1 Nov 2022 05:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E4C433C1;
        Tue,  1 Nov 2022 05:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667279320;
        bh=Zvs1Q5QGnQosf9exvUn2ccNJoy/ZRzLKnTyWkgHqi/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tf6yz+r7o/9YOeFhF0HkoXzCYIMaEcYiBtZMUtft81zdi2XJstwDrhXObqr+Hyb97
         MRtYKGp8Q7G5likSFx1/ARCjcSgH1Wpr2/o1/UYF+F3uBjzPJ80JzFuCWnkSHmRZIe
         57uTtFkFD7H8lHVTdLzbEsx/sBwjzB8Pb8aNke5w=
Date:   Tue, 1 Nov 2022 06:09:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Leng <3090101217@zju.edu.cn>
Cc:     jleng@ambarella.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pawell@cadence.com
Subject: Re: [PATCH v2] usb: cdnsp: Fix wrong transmission direction of EP0
Message-ID: <Y2CqCXAQcWxKTmBa@kroah.com>
References: <20220926075902.7390-1-3090101217@zju.edu.cn>
 <20221101044433.5627-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101044433.5627-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:44:33PM +0800, Jing Leng wrote:
> EP0 transfer is bi-directional, but in the cdnsp gadget, the
> transmission direction of EP0 is not changed after it is
> initialized to IN, so the OUT data from EP0 received by the host
> is invalid.
> 
> The value of ep0_expect_in will change according to the value of
> bRequestType in the SETUP transaction of control transfer, so we
> can use it as the transmission direction of EP0.
> 
> Signed-off-by: Jing Leng <3090101217@zju.edu.cn>
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
> ChangeLog v1->v2:
> - Rebase the patch.
> - Make email addresses ('From' and 'Signed-off-by') consistent.

That didn't happen.  You list yourself twice, and the last one does not
match the From: line on the patch.

Also the verification did not even work showing that this is an invalid
email from 3090101217@zju.edu.cn, so I can't trust it at all.

Please fix up your email system to properly send email from
ambarella.com with the correct verification.

thanks,

greg k-h
