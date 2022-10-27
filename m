Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2442560FA59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiJ0OZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiJ0OZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:25:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF65A2E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:25:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d13so1003370qko.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuDQalOlhKFsf9Yqc1jpknnU37kxT+pjhyntYc+6FYY=;
        b=MCHvetBoSau9DLlXXXOAwcfa59qdAXBdT4lmQDyRlJvfDA+P7lT/NjZHnWwHhJWlGs
         t5SOZ4uPguaiZEtUF0XIdeurImkX+E8TwjlRkt2uvMGIygfQvYWoJmTrypyQRboEMN3h
         37wjvX4bqyijupAFgNdQAuMRsJlKBh4AeYDRPkQkCU/Lqpa3QHYtfVv5daOOTZ6sPwgC
         jwS9HAnTUARzS6F5FQ30PJSNJJEGqL7tK0V1B5jp+1HlgB6Y0vlWRol30u6fTITuHCZI
         2vLtM1iFpD7tNyxU31fKDtjmGphDcAvCB0NBDRPQi2OKYZtlUek+rBY0sRgCucYK0sia
         nM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuDQalOlhKFsf9Yqc1jpknnU37kxT+pjhyntYc+6FYY=;
        b=UQrZ1eIiJb6DZSsNOlYeIY3sbf5vRiMU1DhW0vGVxSueKrRQFPPL/difdEFui5Z9JO
         QyRvxlV958IXxyX6dnCLuxR6Ks5Xvona6XWu3Ya/ihtXvYDkj0QQBO4WLCfYj14MBK1J
         c9Zxij1dGht6AmzMapBFjTFhsnFqDf6iSR53qYRDdJkFpPkB+RbMAs7Bn8BxET7h2yfY
         lZjgksY7gfVbTgNBk5iAXy+gUscN6wjdq/1AZ8+w+/0AvSA8hrMDuwoF6OzDs2YFb38x
         g3b9q+7PU4Y64SYNgfxBDhE8cNzDGcAsYRZUbrZJTr102WYXqBHgjnOcg/gHpqQVgjaC
         a6uA==
X-Gm-Message-State: ACrzQf2PUfgwgXWwV0y4277n3oX6R86TT/QaqJqtoU5CaARXlwPrbdJY
        5et1J35aPvd9NGIb+6fX42wbRCKEAuf2IyC6Du8=
X-Google-Smtp-Source: AMsMyM5boG+qxOLp3PS/qK6jfb6JYFkNefj+69tRO6f3D+CFULxPe92Oy4MjD3ez3m0bn5FPi+y/23tRf3IVHewXpWQ=
X-Received: by 2002:a05:620a:2686:b0:6f5:723e:6316 with SMTP id
 c6-20020a05620a268600b006f5723e6316mr15104081qkp.103.1666880719656; Thu, 27
 Oct 2022 07:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
 <Y1pNJMvl89jgq9qz@kroah.com>
In-Reply-To: <Y1pNJMvl89jgq9qz@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 27 Oct 2022 14:09:52 +0100
Message-ID: <CAHJEyKVpK=BSkuM_RmJ+eUYApYJig8wfqDP4nM=cou_0mThHuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] staging: vt6655: refactor code in s_uGetRTSCTSDuration
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 27, 2022 at 08:59:04AM +0000, Tanjuate Brunostar wrote:
> > refactor long lines of code in the function: s_uGetRTSCTSDuration
>
> Please write full sentences.
>
> Also please read the in-kernel documentation for how to write good
> changelog text.  Specifically look at the section entitled "The
> canonical patch format" in the kernel file,
> Documentation/SubmittingPatches for a description of how to do this
> properly.
>
> Do this for all of the patches in this series.
>
> thanks,
>
> greg k-h

Hello Greg
the file does not exist in Documentations

Also, I had to make the sentences shorter because you said changelog
text was too long. Can you please give an example of a good changelog
text? I feel like I have not understood you.

thanks

Tanju
