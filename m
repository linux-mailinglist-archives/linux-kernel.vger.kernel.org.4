Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5504682B33
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjAaLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAaLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:14:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF357303FA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:14:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10305928wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqoyOu7/doMbawBslte+XDlNAkCkcAPqaTX4lXOdCJ8=;
        b=l1jaAzLRIkj07Y3PD4oxyAymy82JNXoBDyGbEMVFlROz7SvEezIk97Tn6/Ur+faVuP
         EUyl4cgx3Ar+W9/abmYKajFJvUOwX+pYD+asjyJg6wKl4M/3BfGon304x9Te2ubM3jm3
         PqRsLzscYItyi38euczA9sTev7KzZ5HYKgG1eU3LedM6CZD1Kxar9pv7bdKdqT9HShCN
         hd/U4JrnqqDGIDroRFjiQhqaChnYuyvW07KbflmQw0OT5RZqI6zopk9UJHO82StV64W0
         h0+zcTPbdsZcllbYx6NMAHgqt3+Y5KuDc40MFZKHqhWuLafkBHCzMzF5jyCUxlkdzFZA
         7GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqoyOu7/doMbawBslte+XDlNAkCkcAPqaTX4lXOdCJ8=;
        b=jAfE5geoEYVnpqweMrcZ2qm/k9shqt9oR79AG2WfWZDGiIyAqWk+UHFjFx1wIWbiwa
         117Dj1w/osKEqvmZbvyYWKGLFne398O8Siu0QqXzMuSylFQKlXxCG8eRqNA/+v1OFq+J
         WfxxtyMd6EZJ6WXqj2jTSuCF+32JCmTtexgTjaVbwoyBriwCI19A9N02KAAMjrEDe4Bh
         oKE+KVZe/085f2QndxZQSfWvL/8ytYk4FxgBAzxgVoW15hnwMOGFF6UTqSBRvL2aSKlV
         qUeZ9WBkBnA29IHjMeGcdBRdxNnJT6r9waonVRu/GIw1qHmW7/Zlipj1FIiX2i2SYLEe
         V/4g==
X-Gm-Message-State: AFqh2kqFxlbs+FvOHjpj7VBN3dgXFa+ird/FBT6Xx4PNk/wll2TL7ZEr
        dWYLAgdgGz6UNrJK4FubtUZU9ECn2DU=
X-Google-Smtp-Source: AMrXdXsiss8SOWuIw5bzdHIyEFiuKHAR+r2eqZXtGWormMk4zSRfupW+b2bxCC871JoMn9YBYIEPSA==
X-Received: by 2002:a05:600c:6011:b0:3cf:85f7:bbc4 with SMTP id az17-20020a05600c601100b003cf85f7bbc4mr52071876wmb.2.1675163656498;
        Tue, 31 Jan 2023 03:14:16 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n6-20020adff086000000b002bdbead763csm14854668wro.95.2023.01.31.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:14:16 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:14:12 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9j4BI3/ybsaLCfw@kadam>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com>
 <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
 <Y9jwcdYcFQ9f8+mR@kroah.com>
 <Y9jy+f5JpD1NrbZn@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9jy+f5JpD1NrbZn@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:52:41AM +0100, Guru Mehar Rachaputi wrote:

> I would like to know, if it is mentioned in the TODO, why is it
> so?
> 

If it were as simple as just changing the type, they would have done
that instead of adding it to the TODO.  :P

But in fairness the TODO entry is sort of vague and useless.  It should
say that this configuration stuff needs to be moved to sysfs instead of
being done through an IOCTL.  The we would need to port the userspace
tools to use sysfs instead of the IOCTL.  Then we would delete the
IOCTL.

https://lore.kernel.org/all/20220118135902.GH1951@kadam/

If you want to send a patch to update the TODO then you can do that.

regards,
dan carpenter

