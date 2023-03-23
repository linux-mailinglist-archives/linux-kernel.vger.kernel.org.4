Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AC6C6C33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjCWPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCWPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:23:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76BA193F8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:23:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so88186827edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679585000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=scQuxxJfm4ub8gU7bTw0rxXChvmi6APTEZr+zioVIhk=;
        b=MI8ikvr8TzjjuijX7Y4Xo6gHXLlP3Esg4/kjR1Thtk+nykXUGES7CK8Vc5p6FaC+Kf
         fBqVUYgvBzafiL6/VLzbNEfqKgF6Kt0tHeHMYUdvWLxG5bRauOjbX4JEN473sFYuCBZM
         K936dQb68Wusisg3Fk65XMXF1kxPyla/wAJxNS8VVZ4LgiTI07vs6bVFH+woAzTXidT9
         esX4Ot+xArGLJWQmh1RHLkR181S7eoNLh2xVIHoC50W0GwOPCWIuTwe8gRjilLb51Dp4
         wRtbom2PW+2/ROs2wmKcNmQ5pqt/CtLckm9GClrVqbdJcB/zNwwE0dLYmzWy5HhOznM4
         CS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679585000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scQuxxJfm4ub8gU7bTw0rxXChvmi6APTEZr+zioVIhk=;
        b=G2kN8VcGxp7DPGV+GlEzw65WSBWmUMrpE3F3+WAlFQDZIgqH0s40jfRt9PIX/yRb0P
         7x5YhAXGwFnkvas2dS9E5fOPP8mwBuXd6JQF1bs8IvfHjHY5EtyrksZIR9frVM2ksAAb
         RwDCMaVmPoT9FL+SxXOxpdU0l18pHobRaHUU+6egmiq0deoBe5VJvYc3a3qrQ7FgcoOW
         dynbYABrMTo0Oz7Ienz7sEuoFrO02DEcWuR+Z370LdKXnEar2K0th9G2DD5qaFm2kemm
         XsJVa0fPqyI8dvTKHHNIo6i9//stAiA0BJHNNFH0w5MhyfYREsRTmRoxcxzgkZg0+j8t
         8+mw==
X-Gm-Message-State: AO0yUKX2jl6budKQpYjBo9g4rVSUui1bm0GrMW+FcTsWq0uJZZnShgil
        NIrcOIlkixYSzs4WjOx2DAI4mH/OefcK+uvi
X-Google-Smtp-Source: AK7set/DZ2v39lQmt267GFQmOnLCocICmotj5GVBuvWvP0/VI55IsZsHWB3m/fSzpGX8sWvFmM5EcQ==
X-Received: by 2002:a17:906:aad6:b0:930:2e3c:c6aa with SMTP id kt22-20020a170906aad600b009302e3cc6aamr9362522ejb.49.1679584999806;
        Thu, 23 Mar 2023 08:23:19 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709064f0700b008cda6560404sm8768790eju.193.2023.03.23.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:23:19 -0700 (PDT)
Date:   Thu, 23 Mar 2023 20:23:17 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
Message-ID: <ZBxu5RBG9kCRlwRB@khadija-virtual-machine>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com>
 <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
 <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
 <090ee842-46d0-4f35-bf00-68a3e1393b72@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090ee842-46d0-4f35-bf00-68a3e1393b72@kili.mountain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:34:43PM +0300, Dan Carpenter wrote:
> On Thu, Mar 23, 2023 at 02:08:58PM +0100, Julia Lawall wrote:
> > 
> > 
> > On Thu, 23 Mar 2023, Julia Lawall wrote:
> > 
> > >
> > >
> > > On Thu, 23 Mar 2023, Khadija Kamran wrote:
> > >
> > > > Fix several cleanup issues reported by checkpatch.pl in module
> > > > staging/rtl8192e in file rtllib_rx.c
> > >
> > > Why is it resent?
> > 
> > OK, I see, sorry for the noise.
> 
> I'm still confused...  :P
>

Hey Dan!

Sorry about the confusion. I sent the last patch with the wrong email
mistakenly. It was causing following warning as reported by Philipp,
Checkpatch:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Khadija
Kamran <kkamran.bese16seecs@seecs.edu.pk>' != 'Signed-off-by: Khadija
Kamran <kamrankhadijadj@gmail.com>

I resent this patch with the correct email address. I hope I did not do
this wrong.

Regards,
Khadija

> regards,
> dan carpenter
> 
