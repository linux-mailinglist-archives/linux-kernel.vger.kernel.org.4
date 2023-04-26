Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBD6EF56E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbjDZNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbjDZNW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:22:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C627326AC;
        Wed, 26 Apr 2023 06:22:26 -0700 (PDT)
Received: from [192.168.1.43] ([77.7.2.190]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRmwM-1phG3x42lW-00TCmJ; Wed, 26 Apr 2023 15:22:16 +0200
Message-ID: <aae753d6-6874-4f91-e7ba-bd6c77f07b62@metux.net>
Date:   Wed, 26 Apr 2023 15:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: tl
To:     Theodore Ts'o <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Deborah Brouwer <deborah.brouwer@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <ZDSRSWhWsN34MghQ@xps>
 <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
 <20230412025834.GA301301@mit.edu>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <20230412025834.GA301301@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kIMNCDZI5v4YRr19YFds+qt6rpIVxWdz6rvCUbXtO3hAoAE2syC
 HRnwIZNv3EBLo2axwKVsZQZ+Dte1IA5sjDlDuXU+8g6DRuWAWediP1gES8cKTknragjvEB2
 xMR7ty6+Gis+GOMi694pmCiyQs9DI5IK7DGak/kSLp+aEo17Y+5B/RVpah0y5qCbb7okRNS
 VyAo1fEERqiTrjPGYCZTg==
UI-OutboundReport: notjunk:1;M01:P0:AgO0IiJk3dE=;kbSbdgIKOshJNSuRFL3KjokFj68
 Zail325umikc21OOrqUplV/57gmpq6YbI3E6+0YNmQyVuQjgxvLdqv3KAt525fNqanriSXceL
 3Eer5zmtZUXsJa6e2qC2xvl/DpaI0qLrngaN108vQBlzfr0ihJcClpBaDeBPKMxsvxt3jSB9q
 UqKHOiptvudXACfz9J5/JehaXjmvzfc0pQBxYbud8Ib7d3dPKt261JeqCKXjGwdQR/me65hrG
 ZOAEGNK3nD5SBRJClM0tbc4Q3U5N1Oz8poGBYjWHNXOsuHYKjojRVNGH/E2vgzcZiqnI37Ypq
 dW6YnR6aDNXxFD10hN/JSdIDPo/1OeBhjgHX0obPbdl4msOvRHMrW7dj/jTcbi0GRQJOQ4r7u
 +s3rEkX1sifmmJYcH5jz10O5AUfrzMFEkq/t3lf+ATzDOB5Mbi2KeThzY0C4BAqDWGf7qO8uX
 dad1O2OzSzxUVqZ3XFHFk+07KzEjlWNJjan7vjRBiLYQ+BXENgORn9yzigtam9byci7VGLgFK
 VFmXhqSuxaQ/ktV4/q1AsQXxPLrTwbN0+OtZ9dLYOi5parmEe6MC4EyPXI4mjG+W7E6RrHj8j
 zm/RaRFOSuf4y64mtjSt20iUUx+Iyi3ki87eYgQ20d9JyANIQFLgqI5ocvn8KI3R1f4z6sA62
 SiDkFr9ytoUESe3Bweah9fEeQLKtlfe8hifCuyuIGg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 04:58, Theodore Ts'o wrote:

> Something that would perhaps be useful is to document (a) what
> versions of Rust is available for various distributions, or pointers
> to how to get that information for various distributions.  For
> example, you can get that information from Debian using [1].  It
> appears that Fedora isn't distributing rustc at *all*, at least
> according to [2], so apparently for Fedora people will need to install
> it from source.

As already said in my other mail, one major problem IMHO is (recent 
enough) toolchain availability for the major distros and package build
systems - including the embedded ones (ptxdist, buildroot, bitbake,
...).

IMHO, those who want Rust in the kernel, should take care of this first.
(and no: asking to download some precompiled binary from somewhere is
not any acceptable solution)

> If the goal is accelerate adoption of Rustc, and calm people's fears
> vis-a-vis using Rust, it's not enough to say, "why don't you use the
> distribution-provided version or Rust"?  It would be helpful if those
> Rust pioneers can share what versions of Rust they have tested
> against, especially for those commonly used distributions, such as
> Debian, and give us a report whether we should expect things to work,
> so we can ignore the scary warning from the build system that we're
> using an unsupported version of Rust, and if it breaks, we get to keep
> both pieces.

ACK. Maybe those folks could set up some CIs for at least building and
deploying the Rust patches on as many distros as possible - hopefully
before they're sent to lkml.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
