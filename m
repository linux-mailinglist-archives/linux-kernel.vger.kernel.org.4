Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B660B88F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiJXTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiJXTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:49:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE9D18F2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:15:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z14so3956957wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RW2pp7l1psTsUxgsl5DU14u9WogVsd5B7cwThMcENI0=;
        b=B8osC42jYilLF0gdShuwE/kOQesHhMkrTHpY/au1SEQLIjB762rLXmxX52DkTycYM8
         WO8QQxqRQh75BhKexvVV6dImpxSbvTTqIGnqc9SuUPUxppRNNRa0Zp7/yDtLfdHsjgRb
         hNsW4Wjx14ptmwDVm+w9nJZe1sEPpS6gLWBs0mpT49HzZs5ZnTw64fDQuQxFlFMqW5Eu
         2XWCF9whnOZ5T9KiTZ3iiYiFD7CypPz841o8dBfp7wGx6IrO+9hFbcatF1WChzuS5FoD
         nJ4rlNpf6KPqEJru6eW5HdIDBTq4eBb5CxIk/dp667XlVw9gCzFl2dhyTdaeNgebjLaB
         i+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW2pp7l1psTsUxgsl5DU14u9WogVsd5B7cwThMcENI0=;
        b=ZSDOi4pCM4YqZLzaBsyN4PxovNM6iCEA3gkYi+R8MqIMIgEtHmyJM0pvj3acAWYqCX
         vCs1SeL4QAwINZTbLeQvkpJNitxzy5jBd92jkxBDjJsSEoaU/xlr63imo+oYJa6y4C0U
         blCpC2VxAOkFk/BUMtZQ2xtKdjcZOWKmjcbMy3cMLPuGHsoYQY76EDvDB+nFzdmVduQK
         eyseNe0tT11L9KxyeqzLJrBZianwU0NTFyB+iecmlXcqqw9rUz4io7jY1FNhx13+5gVe
         4vRpWF2APEKyKa2pW6ou2bYJJraqc6vcWggyMXjCerklEZjUsWa5iPTRTYQdI/7LSfQW
         RIMg==
X-Gm-Message-State: ACrzQf1Ag2gm1KEfJl2JaYFQcyHsYKVFXco/+OJ6Wp8p7+lFgiGwaRBy
        HXVUUjvrPkEwXQojYaw0kfJl3T2Jgg==
X-Google-Smtp-Source: AMsMyM6yWGe4g8xA2FM05FTMzkJ+XnGVNYHibrpgfULuFaAZHdPiqtzk245sF94ZS2caqvGWB4fw6w==
X-Received: by 2002:a5d:43c5:0:b0:236:6ff9:9167 with SMTP id v5-20020a5d43c5000000b002366ff99167mr4627860wrr.160.1666635272449;
        Mon, 24 Oct 2022 11:14:32 -0700 (PDT)
Received: from p183 ([46.53.250.110])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d524f000000b00236722ebe66sm266034wrc.75.2022.10.24.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:14:31 -0700 (PDT)
Date:   Mon, 24 Oct 2022 21:14:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y1bWBedax9lP2E3K@p183>
References: <Y1ay8k75fegxTcuG@x99>
 <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 07:05:18PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 06:44:50PM +0300, Alexey Dobriyan wrote:
> > > include/linux/array_size.h | 13 +++++++++++++
> > 
> > All of this is pessimisation unless you're removing
> > 
> > 	+#include <linux/array_size.h>
> > 
> > from kernel.h which you aren't doing.
> > 
> > container_of.h is just as silly.
> > 
> > kernel.h might need _some_ cleanup (like panic and tainted stuff) which
> > is rarely used but ARRAY_SIZE()?
> 
> Are you suggesting to slow down compilation with inclusion of tons of unneeded
> stuff in the zillions of drivers?
> 
> Or you are talking that we need to abandon most of the headers and combine
> everything into kernel.h? I think this is what is silly.

It hard to escape kernel.h so you will be including it anyway.
Unless you delete, say, kstrtox.h from kernel.h, it is pointless busywork.
