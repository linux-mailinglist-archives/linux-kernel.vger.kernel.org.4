Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF86D2188
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjCaNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjCaNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:38:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CCB459;
        Fri, 31 Mar 2023 06:38:13 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1piExE-0000vt-HN; Fri, 31 Mar 2023 15:38:08 +0200
Message-ID: <fc75aceb-1973-b29f-f026-de9345afcad1@leemhuis.info>
Date:   Fri, 31 Mar 2023 15:38:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [REGRESSION] wrong coord from Thinkpad TrackPoint since 6.2
 kernel
Content-Language: en-US, de-DE
To:     Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     regressions@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <87h6u4otuc.wl-tiwai@suse.de>
 <3dec29bf-b772-d82d-fff9-6c8bcca5f464@redhat.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3dec29bf-b772-d82d-fff9-6c8bcca5f464@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680269893;d62d2798;
X-HE-SMSGID: 1piExE-0000vt-HN
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.23 11:22, Hans de Goede wrote:
> On 3/29/23 10:16, Takashi Iwai wrote:
>> we've received a bug report about Thinkpad TrackPoint (ALPS DualPoint
>> Stick) on 6.2 kernel:
>>   https://bugzilla.opensuse.org/show_bug.cgi?id=1209805
>
> [...]
> 
> I believe this is caused by the kernel now using -funsigned-char
> everywhere and this should be fixed by this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=754ff5060daf5a1cf4474eff9b4edeb6c17ef7ab
> 
> And there is a similar issue in the focaltech touchpad driver:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=8980f190947ba29f23110408e712444884b74251
> 
> Dmitry, since this is hitting 6.2 users, perhaps you can send
> a pull-req for your current for-linus branch to get the fix
> on its way to stable ?

Hmm, no reply from Dmitry here or any other mail from him on lore since
a week. No big deal, but nevertheless a bit unfortunate, as I totally
agree: it would be really good to get this regressions fixed rather
sooner than later.

Is there any in-official de-facto co-maintainer for input that could
help out? CCing Jonathan, who according to get_maintainer.pl regularly
contributes to the input subsystem.

Guess if nothing happens soon I'll ask Linus to merge those two changes
directly, maybe he'll take them.

Ciao, Thorsten
