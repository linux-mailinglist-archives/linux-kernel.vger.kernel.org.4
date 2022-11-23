Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB16352FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiKWInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiKWInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:43:11 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD012AC6;
        Wed, 23 Nov 2022 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1669192968; bh=uLOM26+lwaPIrO6Zs6MC8yEG8/8f16KuIEX/L4wDxdQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=BTd3FVmaD7VTxwWhGCH4EW+2+l611V8Q1obsMwlZGHZRPG+4StQJptKKcBy9xrCEf
         MIULu4p9sz1U5IuczCszswf6ZAZbzjMj+dJzZCMyQr9O7+MGqOt7efcqfsUxpfz9RI
         Gs3fMHTpzNcv18iS10Q3w5AuDMt/isFkGwuSlPGI=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 23 Nov 2022 09:42:48 +0100 (CET)
X-EA-Auth: ubbihbPvU6XcKue8aJjQx5vs2BZy9A3laF1mVnxiysme4ADLzOM27zwftZNTmbYwiIW2HNw1qffhbet3cGihWIeb/jrQrRZh
Date:   Wed, 23 Nov 2022 14:12:41 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx: remove code for non-existing config
 IMX_GPT_ICAP
Message-ID: <Y33dAR7ukPU/5JGT@qemulion>
References: <20221122132330.30408-1-lukas.bulwahn@gmail.com>
 <20221122160937.GB39395@tom-ThinkPad-T14s-Gen-2i>
 <CAKXUXMxk-YoG4TdB8Em+cEMF8NA7rdMAboQz8nmhfVmVQ8oATA@mail.gmail.com>
 <20221123082148.GC39395@tom-ThinkPad-T14s-Gen-2i>
 <CAKXUXMx81Mvo_H4KzkHXgPbYq07SbEuTcs9LBae5D5GRTK_T0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMx81Mvo_H4KzkHXgPbYq07SbEuTcs9LBae5D5GRTK_T0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:24:42AM +0100, Lukas Bulwahn wrote:
> On Wed, Nov 23, 2022 at 9:21 AM Tommaso Merciai
> <tommaso.merciai@amarulasolutions.com> wrote:
> >
>
> I see. I usually just run checkpatch.pl on the patch, but do not apply
> the patch and run checkpatch on the file. That explains the difference
> of observations. Good to know.

There is a section "Git post-commit hooks" on this [1] web-link that is useful
to configure auto-checkpatch verification at the time of commit.

Hope this is useful.


[1] https://kernelnewbies.org/Outreachyfirstpatch

./drv

>
> Lukas


