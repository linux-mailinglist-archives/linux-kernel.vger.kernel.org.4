Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B659D70ACB2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEUGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 02:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEUGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 02:42:16 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C8FE;
        Sat, 20 May 2023 23:42:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 43B9A5C00A9;
        Sun, 21 May 2023 02:42:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 21 May 2023 02:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684651334; x=1684737734; bh=gPrys0vkcHlGP
        tYBYK6F1sl19b9RAU8HqVL8+AFxLlo=; b=VWqKkBivBtd2iP7BGLrKU5gLDxY98
        MGwWLvrkkjzbsf6HJPJa5e9DEShpcoDjUoAn0NW+k5shcZranVkXkKqxUUSqM2v3
        E/MPWeAiaqIxPmjSj0vFXLSXYzeEnJmseRZN9jzsbtfMsZjfdfJl9Xv+P4MP8uFZ
        vanWQzdRAeUMF/KB/2frT1EtQbf/sd0NGgmtH1FRDtGNfMlvbWaEvaDVaxUfa1qz
        1tM6ZiMSwkF39V6gAcqgXPHQpbSrxgGWBbAsvTKSe40Ky3g7WHd90zk2BU8EixFE
        0D/oMtiUE28Ga01+vzwx6XuD/iyUAvYSYFZPXPdn16SMdnelFoldMzTPA==
X-ME-Sender: <xms:Rb1pZKYGGdclzMledTRE2ZKjKDGKf1XutToTaNuRe7T5VXC0B1g4Ag>
    <xme:Rb1pZNYUn27RuTu_SePi0Jala468edcHmUjjLYlfYA2Vcy3nWr_8b_4HatImHBQz5
    JJDczjCDUDAJ0rRnLU>
X-ME-Received: <xmr:Rb1pZE97HMf1j233MP3c4Slg2u0AHmOghp9n2IWvBUNJ5ghReHxmImoYayDJru2aTFy_U9nchgwB3AckU1N4o0xVYdhmSBqjHbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepfeeiheejvdetgfeitddutefhkeeilefhveehgfdvtdekkedvkeehffdt
    keevvdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmhei
    kehkrdhorhhg
X-ME-Proxy: <xmx:Rb1pZMrmoNGy90TgBUIo9SDoB_p8E63nSCo0_9FyUkkSKvig-rMQsA>
    <xmx:Rb1pZFqEV_tCCp-MFItfATDr8SF3PwYRkjoIxknX1cc2YHv0C9oxyQ>
    <xmx:Rb1pZKTSCjXEFcmsc0xfWTimY90N5a5QuBLfHenglp7an5CQitHHDg>
    <xmx:Rr1pZOC9F4Hc-eJ6NrHLHl4eedJqkAO29d9ZAbSkfKoVhKhQBALNbg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 02:42:10 -0400 (EDT)
Date:   Sun, 21 May 2023 16:42:15 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Tejun Heo <tj@kernel.org>
cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RESEND 01/13] scsi: ncr53c8xx: Use default @max_active
 for hostdata->work_q
In-Reply-To: <ZGmGZxYmN0En7wAB@slm.duckdns.org>
Message-ID: <ea7df70c-01ab-2ad3-a775-542afc6f21d6@linux-m68k.org>
References: <20230509015032.3768622-1-tj@kernel.org> <20230509015032.3768622-2-tj@kernel.org> <ZGmGZxYmN0En7wAB@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023, Tejun Heo wrote:

> From: Tejun Heo <tj@kernel.org>
> Subject: scsi: ncr53c8xx: Use default @max_active for hostdata->work_q
> 

This driver is normally referred to as ncr5380 or NCR5380. (It doesn't 
support any other member of the 538x family.)

> hostdata->work_q only hosts a single work item, hostdata->main_task, and
> thus doesn't need explicit concurrency limit. Let's use the default
> @max_active. This doesn't cost anything and clearly expresses that
> @max_active doesn't matter.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Finn Thain <fthain@linux-m68k.org>

> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Hello,
> 
> Resending because I screwed up the cc list in the original posting. The
> whole series can be viewed at:
> 
>   http://lkml.kernel.org/r/20230509015032.3768622-1-tj@kernel.org
> 
> It's not a must but it'd be great if I can route this through the 
> workqueue tree so that it can go together with other related and 
> followup cleanups.
> 
> Thanks.
> 

No objection from me. I guess it's Martin's call?
