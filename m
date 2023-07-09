Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953274C429
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGIMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 08:38:54 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 05:38:52 PDT
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23EBFA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 05:38:52 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B7B672074D;
        Sun,  9 Jul 2023 08:32:03 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qITa7-3h0-00; Sun, 09 Jul 2023 14:32:03 +0200
Date:   Sun, 9 Jul 2023 14:32:03 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, perex@perex.cz
Subject: on (not) breaking user space
Message-ID: <ZKqow+jPg4HGyV6R@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi linus,

the alsa maintainers seem to be applying a reading of "we don't break 
user space" that i find counter-productive. so i would appreciate you 
clarifying your position on that matter (once more ...)

to be clear, we're not arguing over changing any abi, but simply 
exercising one somewhat more than before. the claim is that this would 
likely have unacceptable consequences. i disagree.

context:
> Due to hardware constraints, changing the clock multiplier (CM) 
> changes the available audio ports and the number of available 
> channels. [...] Therefore, we do dynamic reconfiguration (DR) of the 
> mixer in response to changing the CM.

arguments:
> DR is somewhat controversial, as it has the potential to crash poorly 
> programmed applications.
> But that in itself isn't a very convincing argument against it, as by 
> that logic we'd have to ban all hot-plugging. (1)
> Such crashes would also not really qualify as regressions, as the 
> D.A.S. mode is a new opt-in feature, and therefore no previously 
> stable setups would be impacted. (2)

the full text is at 
https://lore.kernel.org/all/20230630144542.664190-7-oswald.buddenhagen@gmx.de/

the preceding discussion is at 
https://lore.kernel.org/all/87v8fren1k.wl-tiwai@suse.de/T/#u

regards,
ossi
