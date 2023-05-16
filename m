Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24970538F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEPQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEPQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:21:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E58A4C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:20:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (p7097156-ipoefx.ipoe.ocn.ne.jp [153.231.19.155])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97CBABC1;
        Tue, 16 May 2023 18:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1684254024;
        bh=jXn4RnJHNOlbLap62Ods3phZxLIgzVUTBXPC+15CWRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2fFwtQIXrteS8Lww0YTiNCUl7LnRP6e9/4XRi1S+8Gc7tZuJvEM9X64i3hOJswzY
         p8ksPzbVfuW535VwIfkow3coo+1ML5f7+5npTONgC8Cs2urZoK04tgWF9hSCQT9bg3
         T/ZogmnWy9Tl9vvRLo41WTC5EN9wud5XiwVcbpdo=
Date:   Tue, 16 May 2023 19:20:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove Hyun and Anurag from maintainer list
Message-ID: <20230516162033.GD30231@pendragon.ideasonboard.com>
References: <18700dda117076510baf87a090acbb29cb3ba3ba.1684244832.git.michal.simek@amd.com>
 <20230516144516.GC30231@pendragon.ideasonboard.com>
 <c2ca465c-6fa1-7852-26f0-6489fde52226@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2ca465c-6fa1-7852-26f0-6489fde52226@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, May 16, 2023 at 05:07:04PM +0200, Michal Simek wrote:
> On 5/16/23 16:45, Laurent Pinchart wrote:
> > On Tue, May 16, 2023 at 03:47:15PM +0200, Michal Simek wrote:
> >> There is no activity from them for these drivers. All of them have Laurent
> >> as active maintainer and their emails no longer works that's why remove
> >> them from the list.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Will you merge this yourself ?
> 
> That wasn't my intention. Feel free to take it via your tree.

The commit touch four different subsystems. If you can merge it through
your tree it could go as-is, if I have to include it in pull requests it
may need to be split.

-- 
Regards,

Laurent Pinchart
