Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3224968D162
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBGITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:19:35 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2791C315
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675757960; bh=3IiCGcrw4xj573+K8SFh+QMAVskXXAOLc02ZrGFVO3Q=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Yn1lglzpPCMVc+52/nPcQ1j7o21LJcn3E4OmrcP6hmlU9T50NM5gzv25hGB56VsiP
         AvQSJ0bxBiAdqE1Fn1qwDiF4M6SbKRCjCGUmIm6i5cTKKoE4AGnFW2wONvkOOd706r
         WnyvU+kMM5vZx5PWotpFESMdOIVnm5Fpholl1Wpc=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 09:19:19 +0100 (CET)
X-EA-Auth: zjPZTGBDpI1IITH79TEFYuxqQypz+N56QVndvDxk+bXMkOlFXwS/0w5mE/dX0D31VIFd/CmuNi238AMTlnE/UERr8P3rozoG
Date:   Tue, 7 Feb 2023 13:49:15 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
 <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
 <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:25:57AM +0100, Guru Mehar Rachaputi wrote:
> On Mon, Feb 06, 2023 at 10:43:56AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 06, 2023 at 12:39:08AM +0100, Guru Mehar Rachaputi wrote:
> > good luck!
> > 
> > greg k-h
> 
> Thanks for taking time.
> 
> If my understanding is correct, every version of the patch should
> include all the patches/patchfiles and it should explain what happened in each
> version(in decrement order) through a coverletter. Please correct me otherwise.

Hi Guru,
Other than the cover letter, each individual patch should also include the patch
version history in the descending order. If a specific patch(es) that is/are
part of a patch-set, did not have any change, we should still increment its
version and record "none" as the change in current version for such patches.

However, from the patch-set, any patches that are acked, do not need to be
resent along with other patches that are still under revision. But do mentioned
about such accepted/acked patches in the cover letter.

Hope this helps.

Thanks,
deepak.

> 
> I do refer "first patch submission" and above is my current
> understanding.
> 
> -- 
> Thanks & Regards,
> Guru
> 


