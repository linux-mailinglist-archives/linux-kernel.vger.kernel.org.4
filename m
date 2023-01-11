Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB49665B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAKML5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjAKMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:11:37 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE7F218B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:11:36 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4c9b9185d18so121151657b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUzF6lCgQp1o/2q+i0d8WNfiUX6YauMmBM07mYYsz+8=;
        b=C9cnI762pLG141ok2YPMk9grobHR2SRWbOx6Cu8AkaVyWSSPXRneG2gXkqPWXbHRDY
         ZjnpMVG8VuglbhbX20cfLILPt9bbbn65qpN4r2YTDIjy7JmB9vhIf4ds1kHPWxFr7E/B
         E1mMIpd4+O55RON360qn0NnY7NVmRMf4SQR4avMQFfRdMwW7GSCPIWGHzGOVpW7MTwFV
         qAUOQ/GIhnyX6ZGTbW0Jxs1rNxmdwdJu0ZJ1qntBvmO6l5Ibu4aeWsiYcY9qAT3uiTCO
         sHk46ShDefZxf5QT+QRZZ1xFFh73nHX1qL7o0jgScpC/jZu+VGEma2QR91dZ1cfW0F9a
         LxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUzF6lCgQp1o/2q+i0d8WNfiUX6YauMmBM07mYYsz+8=;
        b=n7jcoSfnkVBLGpRFkQm64KM6lH0OXFQFOq51JS5uLumLZdpM7IeVh/j8l8WhcwilZd
         /+8NQwhJGY1dru5Zih9j1Z9WuZ3Tzd7d2i+bJxBCvO7MzTWygw1X57BNmGuOhi+d120k
         tkASTXetzBGonmEILTahK0/ZuSEoRJAzoJrDMgdaeTVEuVwGAq1cRt0nGzDYGTU8OBVG
         c2ftd9YTkgfp0fgkcaBAYkgkuJk4kU/ckO+l4rCuNd1KC0XnUWqoyEmP63qnu/kQ7AGf
         0kzU2TP4/6NRacnXq5VRW4kYTBznUeVrIaaxtheeXxPGK/SQz2YCwxfdfUINLpSfMlcY
         OMgQ==
X-Gm-Message-State: AFqh2koje4423QrMMn4Dw5KFpsMlfUIf422G6igx4+YNRnJ0gH0HFKIa
        mxFdzEooK87uf9FBPLkwlTm4OQ68tGj8zjWCWZ+cRg==
X-Google-Smtp-Source: AMrXdXsBezIy12jb9dB6vhG664r5MR15R3YnEJOWcAFL3Nbg9ez+Wq1tPt0DzTD5RWYTCpvs4/4SWgAVcIDBRYy2oZ8=
X-Received: by 2002:a81:a513:0:b0:4b5:55fb:6cbc with SMTP id
 u19-20020a81a513000000b004b555fb6cbcmr2804118ywg.10.1673439095845; Wed, 11
 Jan 2023 04:11:35 -0800 (PST)
MIME-Version: 1.0
References: <202301020356.dFruA4I5-lkp@intel.com> <aa722a69-8493-b449-c80c-a7cc1cf8a1b6@suse.cz>
In-Reply-To: <aa722a69-8493-b449-c80c-a7cc1cf8a1b6@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Jan 2023 13:10:59 +0100
Message-ID: <CAG_fn=XmHKvpev4Gxv=SFOf2Kz0AwiuudXPqPjVJJo2gN=yOcg@mail.gmail.com>
Subject: Re: mm/kmsan/instrumentation.c:41:26: warning: no previous prototype
 for function '__msan_metadata_ptr_for_load_n'
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 11:01 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> +CC kmsan folks.
>
> I think it's another side-effect where CONFIG_SLUB_TINY excludes KASAN which
> in turn allows KMSAN to be enabled and uncover a pre-existing issue.

 Thanks for bringing this up, I'll fix this as Marco proposes.

Would it also make sense to exclude KMSAN with CONFIG_SLUB_TINY?
