Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF47D6F8EE5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 07:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjEFF4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 01:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEFF4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 01:56:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF37ECA;
        Fri,  5 May 2023 22:56:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 74B7B5C0088;
        Sat,  6 May 2023 01:56:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 May 2023 01:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683352570; x=1683438970; bh=EG
        S5hZyAL9I43PGeKYKJIudiB349boLUw0HVlFIo3AQ=; b=tVyeQUA+MP9z3eOiSJ
        CbCDeX/CmDAJLaBykdXzTvPnjxnVzH3lYWd0uTPKAs0HVu6gIVlgjRrpty5ypJWb
        lzV2PCwX5egBJM/2X4qSNnF8l3oM/tzbisuZ/h+OqjI/FUEQtpvfRUH/3FJ/GhgO
        rbcq3y5VDdKWBjtyWEWRYBRZnQrEXS+z/2BOfp+CusjSwSoTtKfoZnWO4Mio/Shw
        p5R38mgA0AgfPvFLVxdRc45n2zfV4Xwphc2yVhX7jAtjdIIXRf10vWxsX1gl0VcH
        oImHFNOjEfOLvQuIKZwT+UEycWU6TWQL9mnZPsBr8K/msgBfofCbJezUSXTygL3k
        j0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683352570; x=1683438970; bh=EGS5hZyAL9I43
        PGeKYKJIudiB349boLUw0HVlFIo3AQ=; b=fCk8zsDaqA/oZLRtVBG1pcijz8cOw
        LfZRwDUUBra1euNIhrb9FtiH9eF3c7+GqVB/6cYH650FWmnbNdWrkVnkVOO9UxQy
        /Pb/qs8XSIOYr2wnhkEd0d5NuvBqflUdkGE4n/2J1ohjI/LVTAulHfWuVkxWVrqR
        M/wY6x6CoMS1sXEHfCnfJW6MvN2SPIFaNocXjVMngCi3MlgG9/VXtBL7701TSJnK
        HazjBVDqF+UQ2GQrHo/bDhniCdP865TZSa8F4tQ5ib99COw8TpL0J76yIyE4CDIY
        LsD9irx4/0C5NYDoFNJpOmYEvLdRUi0P5VfQXeGIg0pMQRjLqPHQ5DDkw==
X-ME-Sender: <xms:-utVZLYpKk0c1uXdWbPclUY4ZcemhsLirLwvP632Fp3F_yM-MZCEjw>
    <xme:-utVZKZiK0zPoz3JxEaJhMhjetrpyZNe3UehfFB1fFLpGD8aq6XebR8q9oi3V6Ma3
    ob6WSwB8RROSw>
X-ME-Received: <xmr:-utVZN98gkUJSJp5i3_Wt2-PwsqH7CnHzgn99SYP4uF57JmUa5_yU43zOfNCtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:-utVZBrxNpm4DBNCWgzB0Ih2ZiKPqW70OhYgLrELqKpLM287VdC3Gg>
    <xmx:-utVZGrIPaVi09bP7UmAtrfFcsuqvkS_0KhMf7LAhJFB2qQvhUDkug>
    <xmx:-utVZHQt_AuizuH-P38OjyNpRd7epwVW5RabTNd_0oj6NbJCBOx9Eg>
    <xmx:-utVZPZW9PJNqmvsvZb-hYYmwBIuI6IRh8XfORQJsrd7abfimEtCyQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 May 2023 01:56:08 -0400 (EDT)
Date:   Sat, 6 May 2023 11:09:57 +0900
From:   Greg KH <greg@kroah.com>
To:     yixuanjiang <yixuanjiang@google.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
Message-ID: <2023050644-dwarf-shabby-d44d@gregkh>
References: <20230504092142.4190069-1-yixuanjiang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504092142.4190069-1-yixuanjiang@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> The existing locking for DPCM has several issues
> a) a confusing mix of card->mutex and card->pcm_mutex.
> b) a dpcm_lock spinlock added inconsistently and on paths that could
> be recursively taken. The use of irqsave/irqrestore was also overkill.
> 
> The suggested model is:
> 
> 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> pcm_mutex is applied always on either the top PCM callbacks or the
> external call from DAPM, not taken in the internal functions.
> 
> 2) the FE stream lock is taken in higher levels before invoking
> dpcm_be_dai_trigger()
> 
> 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> lock are taken.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [clarification of commit message by plbossart]
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
> Cc: stable@vger.kernel.org # 5.15.x
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
