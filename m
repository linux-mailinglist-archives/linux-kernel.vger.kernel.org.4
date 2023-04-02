Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299C6D36D0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjDBKCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:02:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FD6194;
        Sun,  2 Apr 2023 03:02:47 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1piuXr-0000Yj-JJ; Sun, 02 Apr 2023 12:02:43 +0200
Message-ID: <f711592e-fb38-64c8-d3be-302de71226e6@leemhuis.info>
Date:   Sun, 2 Apr 2023 12:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: mainline build failure due to 02852c01f654 ("media: i2c: imx290:
 Initialize runtime PM before subdev")
Content-Language: en-US, de-DE
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-media@vger.kernel.org
References: <ZCdgzm2NOSQc5qAL@debian>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZCdgzm2NOSQc5qAL@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680429767;a1f61dcb;
X-HE-SMSGID: 1piuXr-0000Yj-JJ
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.23 00:38, Sudip Mukherjee wrote:
> 
> The mainline kernel branch had been failing last few weeks for alpha,
> csky and s390 allmodconfig with the error:
> 
> drivers/media/i2c/imx290.c:1093:12: error: 'imx290_runtime_suspend' defined but not used [-Werror=unused-function]
>  1093 | static int imx290_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/media/i2c/imx290.c:1085:12: error: 'imx290_runtime_resume' defined but not used [-Werror=unused-function]
>  1085 | static int imx290_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> 
> git bisect pointed to 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
> 
> I will be happy to test any patch or provide any extra log if needed.

I'd assume this was fixed last night by 7b50567bdcad ("media: i2c:
imx290: fix conditional function defintions")

https://git.kernel.org/torvalds/c/7b50567bdcad8925ca1e075feb7171c12015afd1

Ciao, Thorsten
