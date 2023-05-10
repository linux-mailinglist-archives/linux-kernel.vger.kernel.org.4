Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB26FD914
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjEJIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEJIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:21:14 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C694
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:21:12 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 1972023FB4;
        Wed, 10 May 2023 04:21:09 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pwf4O-XGY-00; Wed, 10 May 2023 10:21:08 +0200
Date:   Wed, 10 May 2023 10:21:08 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz,
        tiwai@suse.com, axboe@kernel.dk, 42.hyeyoo@gmail.com,
        surenb@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
Message-ID: <ZFtT9J0DQI9uSd1x@ugly>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz,
        tiwai@suse.com, axboe@kernel.dk, 42.hyeyoo@gmail.com,
        surenb@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
 <2023051052-recoil-headache-1594@gregkh>
 <f1a912ea-884b-fdcd-1c05-87089f1e97b7@gmail.com>
 <87a5yc626f.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87a5yc626f.wl-tiwai@suse.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:06:16AM +0200, Takashi Iwai wrote:
>Also, if it's only about white space fix or some indent level issues,
>that could be rather more noise and disturbs the git change history,
>e.g. it makes difficult to find out the real code changes via git
>blame, especially it touches a huge amount of lines like this.
>
>That said, I'm not going to take such "coding style cleanup" patch
>blindly.  If it's associated with other real fix or enhancement, I'll
>happily take it.  Otherwise, I'd rather leave it.
>
a maybe less confusing way to put it would be "do whitespace cleanups 
only on the lines that contain "real" changes, and maybe in their 
immediate proximity for consistency". that means that whitespace-only 
patches are by definition not acceptable.

regards
