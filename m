Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BDC61E344
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKFPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKFPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:53:34 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C2CFACD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667749984; bh=dmKfIeO1VeBT4R+Kq0XhzSljt+SmVaKK6PEqQdi6PAA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=LmoUC3G34R1DwCWQ+F1NNFrRF2PorUAQehSztPMaLCENSzQYuwI+Pmd+oWDbGEujg
         IUU+5pQt7e1bReIBuJtgduu9nWmyF8lIjK5hsPvhEeyHtWwyidJeb1Rl40KIwa5x0v
         oMTkcxjFdpfmLwSFMp0pJWbpAEmhw7dLI+Lgp9vA=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  6 Nov 2022 16:53:04 +0100 (CET)
X-EA-Auth: 9t6s0BerjpqO1VYQo8v6OMTRabzSBetVRZqnZqWKLooLO7w9iv/byaeqo9eiQoRh15bx9tbDz930YaQtsUqfGmA0p3kX7sdT
Date:   Sun, 6 Nov 2022 21:22:55 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: clean up error handling in
 rtw_start_drv_threads()
Message-ID: <Y2fYVzU6JDxocTdC@qemulion>
References: <20221106133443.8872-1-straube.linux@gmail.com>
 <Y2fGGsV5ZwxmkTNB@qemulion>
 <5fa89086-c81d-0a3d-8d0d-0bb293052c5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa89086-c81d-0a3d-8d0d-0bb293052c5c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 04:34:57PM +0100, Michael Straube wrote:
> On 11/6/22 15:35, Deepak R Varma wrote:
> > On Sun, Nov 06, 2022 at 02:34:43PM +0100, Michael Straube wrote:
> > > Convert the error handling in the function rtw_start_drv_threads() to
> > > the common logic used in the kernel. Another step to get rid of _FAIL
> > > and _SUCCESS which uses inverted logic.
> >
> > Hello Michael,
> > Can you please tell how did you find this opportunity for improvement? Are you
> > using some tool or is it a manual code review/analysis?
> >
>
> Hi Deepak,
>
> I just used git grep to search for _FAIL or _SUCCESS and then looked at
> the code manually.
>
> Regards,
> Michael
>

Okay. That is very helpful. Thank you Michael.

./drv


