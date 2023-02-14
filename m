Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B0696C31
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjBNSCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjBNSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:01:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2322D175;
        Tue, 14 Feb 2023 10:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D277617EE;
        Tue, 14 Feb 2023 18:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8762C433EF;
        Tue, 14 Feb 2023 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397713;
        bh=fJ9opWwlrNRE3PSWElmM+meCZDF25dlk2Afd6BfAL2k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fdtz39CWX0U3i8MMtBbziZwqaRekEbPj5ymk2mj6D5AqNK7pMYTSlVLvNbxb7YMPU
         ytchlc+6EAsRuAuG5qQ89Xp8hoUtvEijMwMy0LB8wsAa2qtnR6O+8WT3OTaL5W4Gd8
         hY0cJj1o4Xw0Lg4JTExwTbqWdrgXLgqCpcglMi/VlzbakHzo7mBWC0E5tj6gs3HDoT
         FBvUavrcSsyIKymmbqZEc/8ISnN5xKu+byYtOSsloGkC6NjDwTYzH0ApsxtQ26ST+8
         dke74q3JkrlIwt6jNsD+Fhz6eT6xOWqFZBtWL3SzOGmwKUBXM3PU3CkDj51YLndEBe
         rUSsu+IsBHlrg==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <077ca39622c8870a3ea932298a9cec34f7a8295a.1676363976.git.christophe.jaillet@wanadoo.fr>
References: <077ca39622c8870a3ea932298a9cec34f7a8295a.1676363976.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regmap: Reorder fields in 'struct regmap_bus' to save
 some memory
Message-Id: <167639771249.3067854.8958372042708188891.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 18:01:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 09:40:14 +0100, Christophe JAILLET wrote:
> Group some bool variables to reduce hole and avoid padding.
> On x86_64, this shrinks the size from 136 to 128 bytes.
> 
> As an example:
> 
> $ size drivers/base/regmap/regmap-fsi.o (Before)
>    text	   data	    bss	    dec	    hex	filename
>    4837	    136	      0	   4973	   136d	drivers/base/regmap/regmap-fsi.o
> 
> [...]

Applied to

   broonie/regmap.git for-next

Thanks!

[1/1] regmap: Reorder fields in 'struct regmap_bus' to save some memory
      commit: 7464145862d606cf9835f24080341a397cbc0669

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

