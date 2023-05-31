Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C767186A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjEaPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjEaPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:47:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB9D9D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:46:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fb4ee9ba1so1289902a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685548017; x=1688140017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKEHFoxOsCgLmI1DdeQCEy3HhPJ+1U7vLLVsHpPTjis=;
        b=hiUzdZ1tyrEXaC0nct0J68xAxXlmIwvH5bCBbGQvn5IY1FnWsWmKlh6V7cr064tkWt
         LYWh6Hp3LWnvKArJDVWEjPmyRKuNKYrE/ReZUviOEmAISXC0azSDFccB3QmaHB23pVkf
         fqGGQUz7Ngh+MycaZTrDbomcarlrOHK7xklYtLg4+lO+UYgNFfCu9a3umi3gObWB5K5H
         ijPceWtn9q9eKLbYndY6PVf0qRv7JO7wtfNxkl1dKAqXPAQutf554FgeS9nE3JQd/hyJ
         XFeDxL+XLCm02Vq9mBhxJrCmHuRSWH65GF72tJCsVVVabMUd/iLx/wPut+wNM15nWk5k
         kmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548017; x=1688140017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKEHFoxOsCgLmI1DdeQCEy3HhPJ+1U7vLLVsHpPTjis=;
        b=BRpx+sbKlZHxEhKLl95MCau5O+Q+yzXibKNzA2MNIfgYCe5UfXugCuDk1r5jp0tgJF
         Tx9oo9I9ekJ2BzuTOEfMNiC9Sd8sikSOODHGZ83LFRSVzmo2mipDco7SDWt9MvSfQ9VK
         cr5OCuW2DgHC2TlOflGp0IVaCY7wLlvwSno8bM2J5sNdzv5TX97+3YGSeUGpN/a4M28s
         lsZA21zI7/fxU5pZsKi2cGjomE9a8XMedxGv91dYV1KXZth/bHrebSZraKcoiCiitNQe
         3//NeLM6oh4vCd0qgVkqLho5J7WqXOUb6ugiBbtxWoLaqUdyFgp1o0kEDEH5N5TNa3+F
         f2GA==
X-Gm-Message-State: AC+VfDyZUtKdtyneLKt/MVR55pmU7ewbxP2IujqeEYfyhgUEzRektl4z
        ljGePYncX7BUG5CkiLo8CSk=
X-Google-Smtp-Source: ACHHUZ6BSeCNJ75UsylpGcAlcsVksIZ2BPf+XfdUXmpI4qAqOnYjZITeupnVmD5pT9Qxo7I1/HYXyQ==
X-Received: by 2002:a05:6a20:8e1f:b0:10b:e88f:597c with SMTP id y31-20020a056a208e1f00b0010be88f597cmr5099836pzj.44.1685548017222;
        Wed, 31 May 2023 08:46:57 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id o9-20020a63e349000000b0051afa49e07asm1455725pgj.50.2023.05.31.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:46:56 -0700 (PDT)
Date:   Wed, 31 May 2023 21:16:53 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: rtl8192e: Rename variable SetWirelessMode
Message-ID: <20230531154653.GB87044@yogi-Zephyrus>
References: <cover.1685284727.git.yogi.kernel@gmail.com>
 <5a1ee0e9ef53ebe6085c14dba08c438862ec992e.1685284727.git.yogi.kernel@gmail.com>
 <2023052837-half-pretended-e024@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052837-half-pretended-e024@gregkh>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 05:01:45PM +0100, Greg Kroah-Hartman wrote:
> On Sun, May 28, 2023 at 08:21:33PM +0530, Yogesh Hegde wrote:
> > Rename variable SetWirelessMode to set_wireless_mode to avoid
> > CamelCase which is not accepted by checkpatch.
> > 
> > Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
> >  drivers/staging/rtl8192e/rtllib.h            |  2 +-
> >  drivers/staging/rtl8192e/rtllib_softmac.c    | 12 ++++++------
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> > index 17b70dde7eeb..699c4accf2db 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> > @@ -716,7 +716,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
> >  	priv->rtllib->check_nic_enough_desc	= _rtl92e_check_nic_enough_desc;
> >  	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
> >  	priv->rtllib->handle_beacon		= _rtl92e_handle_beacon;
> > -	priv->rtllib->SetWirelessMode		= rtl92e_set_wireless_mode;
> > +	priv->rtllib->set_wireless_mode		= rtl92e_set_wireless_mode;
> 
> As this is only set in one place, why is it needed at all?  Why not just
> call the real function instead?
You are right. I don't understand why the code was originally written this way.

> Same for the other patches in this series, why not turn this into a set
> of cleanup patches removing the unnecessary indirection and removing the
> CamelCase variables entirely?
Yes you are right. I will work on transforming this series into a set of 
cleanup patches to eliminate the unnecessary indirection and remove the 
CamelCase variables entirely.

Thanks for your feedback. 

Regards 
Yogesh

