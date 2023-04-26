Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1786EF52E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbjDZNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbjDZNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:10:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45168420C;
        Wed, 26 Apr 2023 06:10:55 -0700 (PDT)
Received: from [192.168.1.43] ([77.7.2.190]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1x2P-1qFlNr1zrd-012G3Y; Wed, 26 Apr 2023 15:10:26 +0200
Message-ID: <0da49a77-14d8-cb9d-e36d-985699746b6b@metux.net>
Date:   Wed, 26 Apr 2023 15:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <ZDVXbw/097jvjKvK@1wt.eu>
 <CANiq72n8ZV_bs_xp5rNtar4vmfknJtZg4OHJW6vHuhVFmGs8mg@mail.gmail.com>
 <ZDWQXDRknzFhngyk@1wt.eu>
 <CANiq72n=s23naD4-UkmuLesekDTf4b5bsmWc+fYANYPq+X1R9w@mail.gmail.com>
 <ZDXCeKkbPoZi5k6t@1wt.eu>
 <CANiq72kceQ8aWk7mtB4MoepUr3hNzF34d=DfVzdeCLGRAZwE6g@mail.gmail.com>
Content-Language: tl
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
In-Reply-To: <CANiq72kceQ8aWk7mtB4MoepUr3hNzF34d=DfVzdeCLGRAZwE6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k1I93PH2PUWpwKhagL4rx9XvzvIexBdoYfikjsclZyVQuucR6wx
 i8wD8puOVehsjkjcg1qTAOwNJHxBuXUQlCV39ybTptJuHIgRjTuffOzkQLUbQwTZogo7nbT
 stEQXHuer89iS8rHiHhcY+UO26ZBos1+0I1yC6d4S5hVkAS8Ku/i+FyFIPnQXLnp/sed/rI
 nGRgKGmKdhmsQuAyh7avA==
UI-OutboundReport: notjunk:1;M01:P0:nVLRMWgcgFo=;DSdQltTDSvJfrn+jeB1nXeoVKzW
 rYbjCT9UurdF5820GSw36hJv9dmZms5tOLorgZzas7xk10VOlwVYztvpwgX6EqSzQtF2tHxNM
 WxV4GoVsYbmeXAjVg98CpelC2Dei6BfVrv3gBZigCYirVpHz/hHH3lcBLrjtffHG7LKvVIRh5
 jNvkK+auju7lxybRHxlEFwGDZPNwEmBsybK28Rlo2WOf6tSfBirpuC6vjhzgrvEmaZClsizY1
 jahWbdiTHYPdIfxjDh16i+r0G3cmOj+RUkReOzqLSy2giGmalJ/Nptx5Xdbl0mUDbjRaO0ruE
 f7qv3FeUphYaTRHbdNqmkf1r8PtSrT8W0PAGTeeFhNZrm3fmprWkct1ea4BMTEr3nu8dmK3Iw
 EgoFgnbN3umhIduCyrJSbbEkdl9FayCQQ1oQsIoEp0SzboBX6E/MyMb2JxDwwPXAI9DfydF2z
 oo8eta7smAVWgLDGleJhoQKdjTh9/THuTd/Y/DcsgnSai97zupypSwoGYUio35yGZ8rAv3Czm
 cSP5jZpQQs/UTLPbsz2eNHORkzSDVaUbkoU5u7aJi72Q11kUsN70t1JYCD4BEHnmsdUq7DyBp
 bS0tcLCeFSDdV233vJEVyRCNCHyT2NUtsPuFMXf+8QmUldeVD8Jk9JurvktWgysjoDlQ/J/mR
 rtrkbARgbFiUIx26sPJ2jFV/wQc0hxrNWgDqcULgpg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 00:14, Miguel Ojeda wrote:

> But, yes, if Rust grows to be really successful within the kernel,
> then at some point some basic understanding of Rust will be needed by
> most kernel developers. I think that is fine, as long as there is
> enough time to adjust.

The tricky question is: how much time will be needed ?

Personally, I'm too overloaded for diving deeper into Rust anytime soon.

I've recently managed giving up my reluctance against golang and doing
some fun project w/ it (freecity, a simcity2000 clone), just to get some
real hands-on experience (besides some smaller patches for other
projects i've done over the years).

Rust and golang share some common problems (when coming from traditional
C + friends):
* entirely different toolchain concept (workflows are very different
   from what one's used from GCC + friends)
* fast-moving target (one has to be careful to expect/use the right
   toolchain version)
* rarely understood by traditional kernel devs
* distro/build engine integration/support still pretty infant,
   especially in embedded world (very related to the toolchain update
   problem)

IMHO, before we can practically use Rust at greater scale in the kernel,
the problems above need to be resolved first. And that's something that
the Rust community (not the kernel community) should take care of.

And beware: demanding newer toolchains (thus newer distros), just for
building the kernel, can easily cause *huge* trouble many organisations,
especially in embedded field. Linux is used in lots of highly safety
critical environments that need special verification processes and so
cannot easily upgrade toolchains. If Linux some day suddenly requires
another language like Rust, those would be immediately cut-off from
newer releases.

Ergo: the whole process of adding Rust to the Kernel needs to be done
very, very carefully.

> To be clear, it is still up to each subsystem to decide whether to
> take Rust code. What I meant by "if they can" is that, if they are
> willing to, then ideally the code would go through their tree too. The
> exception are core APIs, where I asked for flexibility from all sides,
> so that those subsystems willing to try Rust do not get completely > blocked.

For the reasons above, the subsystems shouldn't take those decisions
lightly, even if they happen to be Rust experts - this could have a
dramatic effect on downstreams.

Maybe we should (for certain time) go a different path: move all new
Rust stuff (except for bugfixes) to a separate downstream tree, that's
rebased on mainline releases, but still let the patches fload through
the corresponding subsystems.


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
