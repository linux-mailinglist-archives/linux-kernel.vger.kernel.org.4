Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A695FFAB9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJOPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJOPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:06:32 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E07E474C2;
        Sat, 15 Oct 2022 08:06:31 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id y129so3534757vkg.8;
        Sat, 15 Oct 2022 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lGK0rxV8loJw/Gfc0fSDI/prajgoiTvVa4MW8RA1igY=;
        b=XLHdP+hMaI3mADbeheuWlTBr+vVuhTvn61c6wgwk4gd/h2XG0/JynLHwxrVVqmTBb8
         nJQjw+nJ9eD7rxODGLN0/pTQgL9QeqJ9M4oHxmKFUIPNpqf2FijBG9A030fBphVeStP7
         /WqGUS70tNsWHA0aY41MwLRQRbiPriYHFKyo3RtAbaQZylmLPDatAinY5akQZOgJfyS0
         YDNw1WaRU/bUzTn+7QaeTne1Qvmmg6VFcXRwwwpLfDtML3qB3yMUXW+S5gQsIuOPwNyb
         bwuEIATA3DraI61gyJiqzgw/0QFIdADKm0q/urMwVt9gWgcGCQdVQWyTZ2skkTNRN1QN
         JvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGK0rxV8loJw/Gfc0fSDI/prajgoiTvVa4MW8RA1igY=;
        b=FCygAzRyroo8yaieyuZaIVrwW+KvNFaEfHt0ODfvYdv2n/qv7omN6k+Dtfr3U6yH4x
         P1vaVEYa/NPyAXDdW6xQf6iif72d0dGYwXJcSfBRJnPOqX+BMkuOQEb1wGnvBDWJM7tD
         YkIIEziEZeEZO325nOm2tGLKBRvoQESKGJH0RimV/An/xokOo3bXW2DsAF161smL5Pj6
         987WAIJehFXTX96wtuoT0dAYJFnM2eWI6uK1v3s7OUCrx+xw+0gWwv5yQgxi2Or9V1wm
         KtQ/rj9Dd9OhJZEoLcD+j7I0A9I0GgbONhRotyXvu/YlIOl+nc22pqxtb11FBMQ2ziEn
         HwKQ==
X-Gm-Message-State: ACrzQf3rR9dygA9FlT17WQSuXA36aONrFkpnx+6DkCHQeySHVW4uEgyV
        cGTLNY3zXCSwl++7uQNwcZlFAkdV9lgs6tfamXw=
X-Google-Smtp-Source: AMsMyM6Qv4QwYdMpwvHCgD/jLPwOSQGs2Rpij78AqTWanOfKk4f7bxAXCBceUGNBj/XsuSLjnHM9kwiNE7cQpTp4rSY=
X-Received: by 2002:a1f:17d4:0:b0:3ab:36e3:c22f with SMTP id
 203-20020a1f17d4000000b003ab36e3c22fmr1114928vkx.38.1665846390292; Sat, 15
 Oct 2022 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221015195701.4bdbe46d@canb.auug.org.au>
In-Reply-To: <20221015195701.4bdbe46d@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 15 Oct 2022 10:06:17 -0500
Message-ID: <CAH2r5muXw_2-t1Ph85FEmffw_UAP3+9a+uNoe4ZqR1V2vQTchg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed

On Sat, Oct 15, 2022 at 3:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   ddf95e7d5a81 ("cifs: fix double-fault crash during ntlmssp")
>
> Fixes tag
>
>   Fixes: d867d4ae29c7 ("cifs: replace kfree() with kfree_sensitive() for sensitive data")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: a4e430c8c8ba ("cifs: replace kfree() with kfree_sensitive() for sensitive data")
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
