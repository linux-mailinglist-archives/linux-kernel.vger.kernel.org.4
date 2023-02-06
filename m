Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08AD68BCC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFMag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjBFMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:30:34 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09D912062
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:30:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:5f4c:1e23:9c34:1a39])
        by albert.telenet-ops.be with bizsmtp
        id HoWX2900i3XDBUl06oWXxn; Mon, 06 Feb 2023 13:30:32 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pP0dj-008DI7-Tf
        for linux-kernel@vger.kernel.org;
        Mon, 06 Feb 2023 13:30:31 +0100
Date:   Mon, 6 Feb 2023 13:30:31 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.2-rc7
In-Reply-To: <20230206122557.3512171-1-geert@linux-m68k.org>
Message-ID: <dcee3fae-b666-d351-d58f-298ae1938ab3@linux-m68k.org>
References: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com> <20230206122557.3512171-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.2-rc7[1] compared to v6.1[2].

Actually this is v6.2-rc7-2-gd2d11f342b179f18, as kisskb didn't build
plain v6.2-rc7.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
