Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6C66CDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjAPRsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjAPRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:47:48 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA89B6A5C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673890063; bh=ZyzsRjTmVNU34HpfEFF3F1fi30gjsrT8NlXEoNiFzG4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=PskIGupYHsGySGydCWwj1g6yvoe89GrVo1J6lUcbEdAlmlpXsiwKynoXxu0xygDCN
         7ZDx0R5BUcYsPFq7324OzfOYBwUgo8G9w6lTeDrLzztQrao3EbplYErmkaCX0gDkMS
         DBiaJOY9aoHmlb4Bq+m91fkk5TGAlbx9iblybMGk=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 16 Jan 2023 18:27:43 +0100 (CET)
X-EA-Auth: IrlmOA9GkcWFjpgqVsRSCrnsr/BoN4diJ2pZJNgdxcByJCYAEs5/BOMSTUZ1YPxEeVEJcrhzwYjn3i/AIFr9btK1svqTmKBB
Date:   Mon, 16 Jan 2023 22:57:33 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: nvkm_devinit_func.disable() to be made void
Message-ID: <Y8WJBc/tOyGDxe8b@ubun2204.myguest.virtualbox.org>
References: <Y8K+61ZOag5fXu8M@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8K+61ZOag5fXu8M@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 08:10:43PM +0530, Deepak R Varma wrote:
> Hello,
> It appears that the callback function disable() of struct nvkm_devinit_func does
> not need return U64 and can be transformed to be a void. This will impact a few
> drivers that have currently implementation of this callback since those always
> return 0ULL. So,
> 
> Change from
> 	  8 struct nvkm_devinit_func {
> 		... ...
> 	15          u64  (*disable)(struct nvkm_devinit *);
> 	  1 };
> 
> Change to
> 	  8 struct nvkm_devinit_func {
> 		... ...
> 	15          void  (*disable)(struct nvkm_devinit *);
> 	  1 };
> 
> 
> I am unsure if this change will have any UAPI impact. Hence wanted to confirm
> with you if you think this transformation is useful. If yes, I will be happy to
> submit a patch for your consideration.

Hello,
May I request a response on my query? Shall I proceed with submitting a patch
proposal for consideration?

Thank you,
./drv

> 
> Please let me know.
> 
> Thank you,
> ./drv
> 
> 


