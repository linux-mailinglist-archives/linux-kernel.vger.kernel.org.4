Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD56C3935
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCUSam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCUSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:30:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08348559DD;
        Tue, 21 Mar 2023 11:30:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so9557880plg.4;
        Tue, 21 Mar 2023 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679423430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkjWHBgUku8MSuRSZQ+S7pLaMQUx4hKAx9achzwRQ08=;
        b=AXOihnAH0B0O4pktC/PqBcmYDX5szxYRzghNl161/BIG9cu3cfq5pL2vR7gYwCvycK
         ya2Eb42AtqfvNT0Rnqki7KI140cDOtuSv7aK4Er2DgH9uyp5ncyd9fo1gxhN84PcK+Mb
         oZtEQwq2KbwtX2HA2yO2+hGyg8GB6yXvmudYWWXWhkG7um0VZ2mTTg2HcypGjKYhNrK9
         m2o/GfMiifYLQBXNqyf/GtONlkj/lesMLTgTBgnRTKQlTbk0UO2v4anALIhzz/0cA1mE
         PbBUHhvY5b0SFIgZcyYKVdWXFD1BUTTB8Spcr7dWKpSsMre5BcKUiJF16o2AskD0sG09
         hMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkjWHBgUku8MSuRSZQ+S7pLaMQUx4hKAx9achzwRQ08=;
        b=E72prPqE3OXJ67rkeweLLpTFmYG7BrHURDN7u4leFoB99eDdkkDreQEc4cTqYmDSmQ
         KtAEgjzwkQE7mTLlv4Cs+XpxZuQzsdrEKUWow83NGAbTDPmlht1ITLLOdVugkZBsjlwE
         TLd8+E0TFqAYkCqAfeCkl7D7zFFOgNrKodtBqbxdk1tPye96dncNkKhrVOIWqZYCG0T4
         QouBz417Bxiq27SBgjQt/UgDySBhEdWvGYAsW5Gnq20Ms31r6QAnXtAE7aKiBSruGgg9
         8VRprTElX3c2l5FsDr/xQhPIvzLWsm6ifobPsVaaVDSI6+uB1Ad3WbomFGf3LgFC6emn
         ge5A==
X-Gm-Message-State: AO0yUKVg2NclbO7zRo6z09d7cbGYib3wAYE/VckSDeI7Wn4dt5DVd0ol
        OOLoJsm7/d2XYG7Y0adIMo11wduq9IQ=
X-Google-Smtp-Source: AK7set/8TvvOjgCXUYMDgSNVuWVwb7G7MjD3roFihJpRn+nnL3hwsQcop75N18OV7FrB+B+FLXpUkg==
X-Received: by 2002:a05:6a20:3391:b0:d8:f312:b3b with SMTP id f17-20020a056a20339100b000d8f3120b3bmr2824221pzd.3.1679423430170;
        Tue, 21 Mar 2023 11:30:30 -0700 (PDT)
Received: from trent-reznor ([2601:641:4000:81:109e:9b0c:f18f:7fa1])
        by smtp.gmail.com with ESMTPSA id d2-20020a639742000000b00502e7115cbdsm5817599pgo.51.2023.03.21.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:30:29 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:30:26 -0700
From:   Daniel Watson <ozzloy@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: av7110: put spaces around operators
Message-ID: <ZBn3wmTkcZ0WC6iW@trent-reznor>
References: <ZBlShLl4PYlNIpGN@trent-reznor>
 <487b75ea-aecd-5fdc-c2a2-5f5080f8647e@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487b75ea-aecd-5fdc-c2a2-5f5080f8647e@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:08:30PM +0100, Hans Verkuil wrote:
> Hi Daniel,
> 
Hi!

> I'm not sure what the point it of these two fixes since this driver is
> full of such things.
these fixes were the only ones where checkpatch said "spaces required
around that ..." for this file.

> In any case, I'm rejecting this. Just leave this driver alone, it's not
> worth the effort.
ok.

> If you are doing this as part of some mentorship program, then skip the
i'm doing this on my own.  i read that newbies should do about 10 minor
patches to get familiar with the process before doing something more
substantial.

> drivers/staging/media directory, it's not suitable for that.
ok, i'll try other drivers in staging.  i'll also see about getting a
mentor.

thanks again!
