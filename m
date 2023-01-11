Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144E665CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbjAKNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbjAKNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:58 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4F1AD9C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:32:06 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 5467C586A6705; Wed, 11 Jan 2023 14:32:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 50F1F616497A1;
        Wed, 11 Jan 2023 14:32:04 +0100 (CET)
Date:   Wed, 11 Jan 2023 14:32:04 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
In-Reply-To: <Y7tjnhs77o4TL5ey@mit.edu>
Message-ID: <614os9n2-2sq1-2qnr-56q6-1qq628271175@vanv.qr>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu> <Y7pzbnlXgv+asekg@amd.ucw.cz> <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com> <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz> <Y7tjnhs77o4TL5ey@mit.edu>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 2023-01-09 01:45, Theodore Ts'o wrote:
>On Sun, Jan 08, 2023 at 07:47:07PM +0100, Pavel Machek wrote:
>> > However, as this is not Linux-specific, how hard can it be to convince
>> > your distro to include https://github.com/qris/dhrystone-deb.git?
>> > Usually, when I have a full userspace available, I just clone the above,
>> > and debuild it myself.
>> 
>> Dunno. I'd not solve it if package was in Debian, but it is not.
>
>I would suspect the better long-term solution would be to get the
>package into Debian, since that will be easier for people to use.  I
>suspect the reason why most distros don't include it is because it
>really is a **terrible** benchmark for most use cases.

(All of) you could install boinc-client and just exercise
--run_cpu_benchmarks without (I think) attaching to any particular
computing project. The package should be in distros and you get
both Dhrystone and Whetstone.
