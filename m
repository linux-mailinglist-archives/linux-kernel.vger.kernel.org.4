Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB6653ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiLVCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLVCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:38:52 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1F1022
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:38:49 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-43ea87d0797so10630977b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2rqtpBM4U7YFCg1EJL4EERx3WMFIEkUoD3hzdRnCKzE=;
        b=hxQnwu+IPergHL/GDm/YOvOtzhjMwNWg0W6Dbpq0MN6FI8L6esY6zzP4xm61kKJMPb
         Y3pfmqPzSXsH2sMQ9MAXMZsqOVsUIYE7+90XMrJ/nbKcW9da8uQDUOjkJc7F9ci1U/IA
         ji5AshW0wsQNFo4il+CsFgvvqzNdhmI40ZXFAHJidNxwHmOHkqwePthxeY0XQrdav5qI
         rW0znGU8cFooskSLnMERRCuh+tEMzCv/BvC2MWJ09PmeTt4IxZpOauAnTsHaioTbUszO
         wJko2o15RblIyicUv/hT7Anv+AO7kIalKdrhEF27NNFTjOI55CyrcLH+gYZpBHMbHP74
         tNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rqtpBM4U7YFCg1EJL4EERx3WMFIEkUoD3hzdRnCKzE=;
        b=RHpUSzyhflEUjGxcphvI7OGxsRMBu4Hmcvg5Em2r4fnzmxBkoDtc95HiIizl62X5MK
         62QhIbnPfG+8UlvRkkbrX+9c1YAxZp/hH3jR0bwXsCSdurYf++A5RKf/gBbRxUOgyoPq
         Ub56dtD5YSq4mNp8xUtMhoQW+MNTFG5M843cAadAMSnMWIUPObCunhRs+ISMM0wdWnUx
         Ol4jfPQd+kqzSUA9LY8s2zKWITEwcsNx87h0sRKRnDe6JiU1F1AgskiBrrLwKdtqu4uQ
         7kFaJoGl5TP68emS+ID1B3SMR7lB6i6c3IK6LRw1KlDenNt4I/D+upYE5PA8Y5tTxqF6
         Gn9w==
X-Gm-Message-State: AFqh2krCnaJo+tRUbsz/9phOac1WL0SbLHh7h9xqWJC9szV2KYI7/CPM
        qUG+r6nBGLX5Yvf/zU7+TEOGvuKDu8kxhBKdKhHe/g==
X-Google-Smtp-Source: AMrXdXvKJzCFk493wJHzhQkQyWBaWT6jDS8d8BEzv3PgUXqGOVeKLTro06nccHyNJ7D90SZQ7kvJmVdr7qGU0NYIYp4=
X-Received: by 2002:a0d:cb84:0:b0:3c4:df92:a3d2 with SMTP id
 n126-20020a0dcb84000000b003c4df92a3d2mr401485ywd.487.1671676728848; Wed, 21
 Dec 2022 18:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com> <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
 <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com> <CALprXBZkhWitJBeenKHxzyQvkf=Q2FDAHKD511oCWC8-SJBK+A@mail.gmail.com>
 <07538266-ea40-389e-9e68-054822121e0b@linux.intel.com>
In-Reply-To: <07538266-ea40-389e-9e68-054822121e0b@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Thu, 22 Dec 2022 10:38:37 +0800
Message-ID: <CALprXBaJx82yCRjc91HLu7jAiEEtBNGM+wcjw0uzu5WaQ3vhXw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Libin Yang <libin.yang@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre

On Thu, Dec 22, 2022 at 8:27 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> That would be more consistent indeed, no objections from me.

Thank you , I will send the v3 patch with modified string "adl_nau8318_8825".
