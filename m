Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB96FDA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbjEJJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjEJJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:03:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D92E4A;
        Wed, 10 May 2023 02:03:03 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pwfir-0000w9-Vv; Wed, 10 May 2023 11:02:58 +0200
Message-ID: <742856c0-ab93-1a6c-4fc8-9451c0908930@leemhuis.info>
Date:   Wed, 10 May 2023 11:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
 <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
 <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
 <20230510090527.25e26127@sal.lan>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230510090527.25e26127@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683709383;f0523dc6;
X-HE-SMSGID: 1pwfir-0000w9-Vv
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.23 10:05, Mauro Carvalho Chehab wrote:
> Em Mon, 8 May 2023 09:27:28 -0700
> Linus Torvalds <torvalds@linux-foundation.org> escreveu:
>> On Mon, May 8, 2023 at 3:55 AM Linux regression tracking #adding
>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> Thanks for the report. The fixes (see the mail from Laurent) apparently
>>> are still not mainlined (or am I missing something?), so let me add this
>>> report to the tracking to ensure this is not forgotten:  
>>
>> Gaah. I was intending to apply the patch directly before rc1, but then
>> I forgot about this issue.
>>
>> Mauro: I'm currently really *really* fed up with the media tree. This
>> exact same thing happened last merge window, where the media tree
>> caused pointless build errors, and it took way too long to get the
>> fixes the proper ways.
> [...]
>
> In the specific case of this fixup patch, I didn't identify it as a build
> issue, so it followed the usual workflow. We have a huge number of patches
> for media, and it usually takes some time to handle all of them. This one
> just followed the normal flow, as it didn't break Jenkins builds nor the
> subject mentioned anything about build breakage.

Makes me wonder again if we should start adding

 CC: regressions@lists.linux.dev

to any patches that fix regressions, that way maintainers and reviewers
would have something to filter for -- and I would become aware of all
regression fixes in the work, too.

Ciao, Thorsten

P.S.: BTW, let me tell regzbot that Linus merged the fix for the build
failure.

#regzbot fix: ba0ad6ed89f

FWIW, the one for the gcc warnings[1] Laurent mentioned elsewhere in
this thread is not merged yet afaics.

[1] https://lore.kernel.org/all/20230418092007.2902984-1-arnd@kernel.org/
