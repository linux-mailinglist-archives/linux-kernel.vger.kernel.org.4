Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92E57029DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjEOKBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbjEOKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000C1BE9;
        Mon, 15 May 2023 03:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0548161195;
        Mon, 15 May 2023 10:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FC1C433EF;
        Mon, 15 May 2023 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684144863;
        bh=fMhblgCX0MmlqsV6DKGBf8/4TTWFE8GRs/BIGufIOwE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bKYTew/pzJ3IeA051ltdl8Z7lwsBHUwI3WXkGXCnKwcB6qqzI70rpHK3CRoGUz/AO
         KUuDfTbc1kC465S2hgmqviWLzpkn29dWTojB0qKXbBNWwYLLr1+QKhnO5P68U//Emg
         reqeCPiArZcbW6mRXe3u1d/Bv/uMF1h6Zu5I4IWT2e3/XeQencNLZWF/9+kkxDVGm+
         Z6cLgiVyYQP/aSLSMTYV+2PlZoxYwZ1rhporspRlLWKM9RgkpQuauS1fNpYRLci4/9
         YvBBguevoUUXmf/dSBuksSlG+l1wAmdd6aYa49VqnKX/z9pFBTXCqPRG/k3pa7pLQv
         5p+prnFrMmoeg==
Message-ID: <d12b3e4d-2edf-8451-2f2c-9cd171a830f2@kernel.org>
Date:   Mon, 15 May 2023 12:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
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
 <55d5ec29-f30f-4596-a3b9-7e5b8adf0582@kernel.org>
 <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
 <20230515102525.65150633@sal.lan>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230515102525.65150633@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 11:25, Mauro Carvalho Chehab wrote:
> Em Mon, 15 May 2023 09:46:41 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> 
>> Hi Krzysztof,
>>
>> On Sun, May 14, 2023 at 1:01 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On 10/05/2023 10:05, Mauro Carvalho Chehab wrote:  
>>>> And another CI job testing bisect breakages as I receive pull requests,
>>>> applying patch per patch and using both allyesconfig and allmodconfig,
>>>> also on x86_64 arch with W=1:
>>>>
>>>>       https://builder.linuxtv.org/job/patchwork/
>>>>
>>>> The rule is to not merge stuff on media tree if any of those jobs
>>>> fail. I also fast-forward merging patches whose subject states that
>>>> the build has failed.
>>>>
>>>> In order to help with that, on normal situation, I usually take one week
>>>> to merge stuff from media_stage into media_tree, doing rebases at
>>>> media_stage if needed to avoid git bisect build breakages at media_tree
>>>> (which is from where I send my update PRs to you).
>>>>
>>>> Unfortunately, currently we don't have resources to do multiple randconfig  
>>>
>>> Is you media staging tree included in LKP (kernel test robot)? You would
>>> get huge build coverage after every push to your staging repo.  
> 
> No idea, as I don't know where LKP settings are stored, nor what frequency
> it is doing builds from git://linuxtv.org/media_stage.git, if any. Do you know
> where we can check such configuration?

AFAIR, it checks all kernel.org repos, but anything outside should be
manually added. See:
https://github.com/intel/lkp-tests/pull/271

I actually proposed a talk around this for LPC, so it seems it might be
useful.

> 
> In the end, patches there will end going to linux-next, so at least some
> sort of coverage is there, but I'm not sure if LKP will always reply to
> linux-media if the patch causing build regressions is there.
> 
> While being helpful, one problem with LKP is that it is hard to filter out 
> reports per git tree. The only way to check if the report is applicable to
> media trees seems to be looking inside the e-mail's body.

If you setup specific repo entry in LKP, you will get a quite specific
email, e.g. with subject:

[krzk:for-next] BUILD SUCCESS 5b248db78d1aa679009efa4763794890572e63fb
[krzk-github:n/of-device-id-of-match-ptr-rebase] BUILD SUCCESS ce0964f4

(where krzk/krzk-github are the names of repos in LKP)


Best regards,
Krzysztof

