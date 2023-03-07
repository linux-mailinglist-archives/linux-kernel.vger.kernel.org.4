Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D606AD7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCGGzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:54:58 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A5C3A866;
        Mon,  6 Mar 2023 22:54:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 849865C03BA;
        Tue,  7 Mar 2023 01:54:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Mar 2023 01:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678172097; x=1678258497; bh=re
        NvLjzqEA+eiT5cNsrh+5r2DA2DJkOzk6eysF6Udrg=; b=EOtvBAT0SZfFsZggHu
        ZyIqXnSex0lgAPlQo28oYx9SfLUYqk/sctvKPnwq9GCso/HUd+7cRHRiL+acYW+1
        XonH5zQRGm2/RBOw/w1xr1j5TnqXNM3zWG8QDImIBijSU5QQEX80VKHH/7p+zO8L
        NtTaiY2qq01OpeJYdSPRfBQtjtGnDdJGs6wxZK8JXNUHfeVW24C1qeeULU6ZVE/7
        1s1HdbHq2QopQxmLIZnGa1ZCFT4FPutrfTRgsaqR5h6fj7hgShz4RlP4YaCjFfHK
        u8xnNXoNOPnIC/bd76wgMMk2fAeXjE63Ag8FWG1PiHZJEG1TOSbWGhcAyIhJmgTS
        xxsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678172097; x=1678258497; bh=reNvLjzqEA+ei
        T5cNsrh+5r2DA2DJkOzk6eysF6Udrg=; b=Wmfx1SS6k+Cdw5+tJEpciawhc4ZdK
        srKuNaCfrUBbkEvFTsVrvu0oYLXZ9SptEY4jpCt0BxqzlVc8eb+2yo3cHougVpTU
        vBAApClqc/V4cDwBy49LvNb4EjXjF0Ao4KCwXxJ0nKrvakwoLONx6ILfRQxrybbK
        wQLfmrOhTSdS72ZkYta3YDGqYjEGLJojoxFt/vZkipaxtSZqVObuEuwCOcDWfsx2
        QlRjISB8Ae9x+DJ/GJCawUj9+L2oJN2dCSQN1VtCnIyxKjl2eJe8yGZNSnTijYuf
        XP7uEmDZO56+yOufoEuxco/Qi8T8Lzp3X1M9GyHFxTxNI6xA4UzPjf7zg==
X-ME-Sender: <xms:wd8GZA31D6n4ltHeSpGeIi08xsJL8WMf3p5-CJvxJDQ87B6Zj5NSsQ>
    <xme:wd8GZLEg58fqK1AiSfTaZq7y-smPvOoNSJw1kcusvFqOE2gDr8yAzQL1RwKFl-mwL
    RtW1AIT2SB8Qg>
X-ME-Received: <xmr:wd8GZI5JVF3odOZENO_4tBjK3A7OHwjzAXSdefuY0-ajm4Wp5NAOuJLnyVKZwd6jFQq9nWhghntJPaJHmPnROz_YdO3qjRKIvI24Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:wd8GZJ1RxK7KWMyB9rysSY9dXlQMPMdtkqP0lTZ00gjG_66tLMF5cg>
    <xmx:wd8GZDGS6WkqTsixf3i0PAAbMaXJNhblBRhxK3Y1cCNsqUN7r2FkXg>
    <xmx:wd8GZC_h3bU2N-k5NLT5iGXmaY8GJXk2AEFhj8fG_YXD3Kfwv3IDJA>
    <xmx:wd8GZHjj91f3RwQMWCXoZEv3MuoArPB4rySjbXYqYd4gHUS-RdugBA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Mar 2023 01:54:56 -0500 (EST)
Date:   Tue, 7 Mar 2023 07:54:55 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the driver-core tree
Message-ID: <ZAbfvyH5pSAVdX8K@kroah.com>
References: <20230307134313.1b2aa555@canb.auug.org.au>
 <ZAbaXeEKfUJY+hYx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAbaXeEKfUJY+hYx@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:31:57AM +0100, Greg KH wrote:
> On Tue, Mar 07, 2023 at 01:43:13PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the driver-core tree, today's linux-next qemu boot
> > (powerpc pseries_le_defconfig) produced this boot time warning:
> > 
> > HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
> > sysfs: cannot create duplicate filename '//block'
> 
> That is odd.  What type of userspace are you running this with?  And is
> there a pointer to the .config anywhere?  No one should be needing this
> old config option anymore, but maybe I messed something up in removing
> it...

Oh nevermind, this is my fault, the patch is buggy, let me fix it up,
sorry for the noise...

greg k-h
