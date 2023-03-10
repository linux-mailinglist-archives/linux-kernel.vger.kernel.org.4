Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92E6B5173
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjCJUIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCJUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:08:09 -0500
X-Greylist: delayed 197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 12:07:49 PST
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06FF126F17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:07:49 -0800 (PST)
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 32AK3utg3412285
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 21:03:56 +0100
Date:   Fri, 10 Mar 2023 21:03:56 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, tiwai@suse.de,
        broonie@kernel.org
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Message-ID: <20230310210356.561dbe63@kant>
In-Reply-To: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 06 Takashi Sakamoto wrote:
> In the last few years, I have reviewed patches for FireWire subsystem and
> requested sound subsystem maintainer to sent them to mainline, since
> FireWire subsystem maintainer has been long absent. This situation is not
> preferable since we have some user of sound hardware in IEEE 1394 bus.
> 
> I will stand for the maintainer, and work for FireWire core functions and
> 1394 OHCI driver, as well as sound drivers. This commit replaces the
> corresponding entry.
> 
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

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
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
Stefan Richter
-======--=== --== -=-=-
http://arcgraph.de/sr/
