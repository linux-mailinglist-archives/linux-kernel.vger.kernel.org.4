Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F460B502
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiJXSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJXSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:11:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB322286
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:52:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s196so9156808pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3A6vDPMv3F3KIpxPBADrLLMFIt3FEE5xjPiL8dT7O4=;
        b=Bu699l2oLZROaWe8FoHoulDWewC5gwGkuq/GyWC+/N5wxDrPQdCJMJ9WIC0jFqNo2X
         wT9n8LMg4gci8RLiseB1ZWLUgzHkU4KQnlkCkRpS/8NZ9q74d2ckAlbnP/HbvL+SSPjB
         lvtYvkm+FPo/ZuvgTik/6CCsKq4Yl2ov6nYB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3A6vDPMv3F3KIpxPBADrLLMFIt3FEE5xjPiL8dT7O4=;
        b=VLcCkOA6/nXEGcrQ6w6RBkfRiGlu4Z/ibY2nT9n2KVnPTFY5rNRO3bbCYt/P7E2AVY
         0gRUSwRpsfqHw6NMLvtf8Q00G28jjaQ2+C1EDWphGaSZYhFKOCZ0UMDmJGpt/iOFvu47
         THtegQLW1PmoC+RnnCF1gc0ThBYfGPjH6dbClp8LErhG3ykhkAZEKFHzgXf4kZgVgOKs
         3O8KJZkgVmE8kcH7oLvWPRkC46k4llqybOpWCNgbWREX++DVAigQvefv742i+ceZGRVo
         kOUjGuJJzkzu9TkBXnfSpelQfROIfeF3C0qqjmX+RKozvu41cCFda3y54r7di9ujAzlV
         inBQ==
X-Gm-Message-State: ACrzQf2B3IAzIlLS4XJNGgKuB0hG+YXadA4r7UQ0H8Pq9pIIShrd3kZC
        VEyH8IOAUzIAeegDEtjPbO5Y5g==
X-Google-Smtp-Source: AMsMyM5nwQqpR6wcZ8pki56eSHOedD5H4An5+8xEyfpAdEiZVMUwUKUF/cq3ebCgspChZ9xNzujZjw==
X-Received: by 2002:a63:1e5a:0:b0:43c:b966:e2d6 with SMTP id p26-20020a631e5a000000b0043cb966e2d6mr28489091pgm.569.1666630201831;
        Mon, 24 Oct 2022 09:50:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9a0e:1111:32b6:fd69])
        by smtp.gmail.com with ESMTPSA id v8-20020a654608000000b0044046aec036sm17187768pgq.81.2022.10.24.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:50:01 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:49:58 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julius Werner <jwerner@chromium.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] MAINTAINERS: Add drivers/firmware/google/ entry
Message-ID: <Y1bCNs76nTGWcS3l@google.com>
References: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
 <Y1NlwY+RnKth++bW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1NlwY+RnKth++bW@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 11:38:41AM +0800, Tzung-Bi Shih wrote:
> On Fri, Oct 21, 2022 at 05:26:47PM -0700, Brian Norris wrote:
> > Per this conversation:
> > https://lore.kernel.org/lkml/af9c4bfd-d3fb-1c7a-fb38-0d8bbd507449@roeck-us.net/
> > Re: [PATCH] firmware: coreboot: Register bus in module init
> > 
> > I guess if this is fine with folks, Tzung-Bi might queue this up?
> 
> Ack, I can queue both if this is fine with folks.

I'll assume that might happen eventually.

> > +GOOGLE FIRMWARE DRIVERS
> > +M:	Tzung-Bi Shih <tzungbi@google.com>
> 
> Please use <tzungbi@kernel.org>.  I prefer to use it for Linux community.

OK! I was just imitating your existing entry for CHROMEOS EC CODEC
DRIVER, which lists google.com email. So you might want to fix that one
if you want people mailing @kernel.org.

I'll assume you will fix that when applying. I can send a v2 if someone
else plans to commit it.

Brian
