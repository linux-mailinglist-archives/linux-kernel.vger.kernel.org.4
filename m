Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F36AD14E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCFWSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCFWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:17:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC544A7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=b7qcF0x4SX4MV2RBRzenSFiYbYEE6QBBbo1StKCcj44=; b=AqfKkXOPffK33lCr+uXF4Nbjy4
        x2NTrGMEKTy+MyN0lPIuNyMGbI0l43oZTKFgfy3Y3Yr0etOsBbce3mK91aaNBZEvzJKhEEvVrtTiL
        B/mWbVRwtmqOz/mrcH8qHyF0RnQXWU2WeDEkgeVJdA7AJYZ6rY9VsbkCD4NRFyS8Pk9hhmdlkUpYc
        61J+C/u5ySYJz3HBRZ7ZXG/ECE69g82mV+UTO7sIEs35mMpZEbyS2sFDXNELEIJ3zwDJO+P3cT6iN
        qkx861k0dvfgO3+iceNkBF3rHYvMJiJy7NJy0TqFxKp6abA+EyVYVmoIbFp73SQQipb263yioXbq6
        Zknb5lJA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZJ9T-00FEJ6-6l; Mon, 06 Mar 2023 22:17:51 +0000
Message-ID: <12ed59e9-3e54-30c1-0013-2c13e0ee2039@infradead.org>
Date:   Mon, 6 Mar 2023 14:17:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Content-Language: en-US
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, stefanr@s5r6.in-berlin.de
Cc:     tiwai@suse.de, broonie@kernel.org
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/5/23 19:58, Takashi Sakamoto wrote:
> In the last few years, I have reviewed patches for FireWire subsystem and
> requested sound subsystem maintainer to sent them to mainline, since
> FireWire subsystem maintainer has been long absent. This situation is not
> preferable since we have some user of sound hardware in IEEE 1394 bus.
> 
> I will stand for the maintainer, and work for FireWire core functions and
> 1394 OHCI driver, as well as sound drivers. This commit replaces the
> corresponding entry.

I agree that some change needs to be made. Thank you for offering.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> As you know, IEEE 1394 is enough legacy. I would like to schedule the end
> of my work in the subsystem. My effort will last next 6 years. In 2026, I
> will start strong announcement for users to migrate their work load from
> IEEE 1394 bus (e.g. by purchasing alternative devices in USB and hardening
> system for them), then in 2029 let me resign the maintainer and close
> Linux 1394 project.
> 
> My current work focuses on real time data (sampling data) transmission
> protocol in packet-oriented communication, thus I would provide less help
> to implementations for the other type of protocol; i.e. IPv4/IPv6 over
> IEEE 1394 bus (firewire-net), SCSI transport protocol over IEEE 1394 bus
> (firewire-sbp2) and iSCSI target (sbp-target).
> 
> If receiving few objections from developers, I will start my work to send
> fixes for v6.3 prepatch, and PR for future v6.4 or later. I'm pleased if
> getting any help until the end.
> 
> Reference: commit b32744751e75 ("firewire: add to MAINTAINERS")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f..e137c1b2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7954,10 +7954,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/lio-core-2.6.git master
>  F:	drivers/target/sbp/
>  
>  FIREWIRE SUBSYSTEM
> -M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
> +M:	Takashi Sakamoto <o-takashi@sakamocchi.jp>
> +M:	Takashi Sakamoto <takaswie@kernel.org>
>  L:	linux1394-devel@lists.sourceforge.net
>  S:	Maintained
> -W:	http://ieee1394.wiki.kernel.org/
> +W:	http://ieee1394.docs.kernel.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
>  F:	drivers/firewire/
>  F:	include/linux/firewire.h

-- 
~Randy
