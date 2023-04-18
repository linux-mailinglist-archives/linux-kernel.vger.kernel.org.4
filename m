Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D66E5C77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDRIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjDRItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:49:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC9729D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:49:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 241251F8D6;
        Tue, 18 Apr 2023 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681807750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OdpDt1qkZG6MWw4pdMSS30gS0YhqisBt2YCmnRtJFd8=;
        b=OdlEYI99R5tMwN2hUOSjr69Dzueny6AoTtHDOf8zwFNFxi0y2cNBf4kcNe5zoCUr7Yv4yd
        eJzQQRO/BeUrFN5KHSH0iTBQCvZT1vDMCBx0BmmeZyZd7fqiAdZbmvsVch26EBojpYlgLH
        vK8M4mD9mSBYZrTjVZ09TR5/ZAcdI8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681807750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OdpDt1qkZG6MWw4pdMSS30gS0YhqisBt2YCmnRtJFd8=;
        b=Dc+Rnzzg0bqVRxn51oSwcGf5Tt1rAMAgUFTcts9o821kJ5EAOszam9cHWYocAqOqY6A/xF
        FsHz/vadqJykUEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C469139EC;
        Tue, 18 Apr 2023 08:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AmlGAoZZPmRDEgAAMHmgww
        (envelope-from <iivanov@suse.de>); Tue, 18 Apr 2023 08:49:10 +0000
Date:   Tue, 18 Apr 2023 11:49:09 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader
 public key
Message-ID: <pdwhmblhzpo6dkpxs2d3p3vbmew2xivqspycezfngwigpf4doe@vgphotcelnsl>
References: <20230413085206.149730-1-iivanov@suse.de>
 <20230413085206.149730-3-iivanov@suse.de>
 <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com>
 <duuhz5pju4q7lnvzwndcnruqwqzbwy4jhrfn42vov2rfct4i7c@qh55cifhoud7>
 <9de62851-73a6-0070-4e64-94b6614c11fd@i2se.com>
 <CAAvKZ64KyXJ2QPjRnj3i-8AKh7jGCUw=HNi76XG-a9K-+_JiYQ@mail.gmail.com>
 <02a4ebb4-7652-fb1f-ae56-920648470c67@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a4ebb4-7652-fb1f-ae56-920648470c67@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-16 15:11, Stefan Wahren wrote:
> > > > 
> > > > Or I can drop the new compatible string altogether? It looks like
> > > > only alias is strictly required?! Tim Gover is this correct?
> > > 
> > > i cannot speak for the firmware side, but i think we should try to keep
> > > it compatible with the vendor DTB here.
> > > 
> > 
> > The firmware doesn't look at the compatible string. It locates the
> > nodes to update using the 'blconfig' and 'blpubkey' aliases. Userspace
> > scripts (including the documentation example) should also use these
> > aliases.
> > Therefore, I don't think it matters if the compatible strings is
> > modified, but I won't pretend to know what the correct DT style is
> > here :)

Ok. Perhaps Stefan have a point and will be better if we keep things 
in sync between vendor DTS and upstream one.

> 
> okay, regardless of the compatible string the patch must be send to the DT
> maintainers and the devicetree mailing list otherwise they don't have any
> chance to review.
> 

Sure, my fault. I just used list of recipients from the initial patch.  

Regards,
Ivan

