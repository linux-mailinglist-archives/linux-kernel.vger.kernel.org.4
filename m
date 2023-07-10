Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5790374CA15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGJCwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGJCwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:52:51 -0400
Received: from mx2.ucr.edu (unknown [138.23.62.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC1120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688957570; x=1720493570;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=81s/g0szo3YqoqeNAsHyknwaB3cC/IHDl8+zCGik79U=;
  b=ra44p53gVQjn97MOS4xt56ei5xvEdAWY8TvyCS6cHdsZm5Zi0uPLMW76
   7Lg2RO43G2wb7vqHTlFFNVNsAie5WjNXguCIaxXz7zeOvxHDwm9xpn13F
   PfPO8u89AgvCnuKvkRJ2+QaGwLfJOEyMwLubiocduDWKGzMHQo77GyAiY
   d7AjYdE6FQ/oD/WNSYoU+rg0rmF2SZIzugMRx9E3/ipB7iJcPvw6G5c8a
   4z1f7u5QYQP7lYDmWgzash2pIDq7iy2bC/HqW2jReLNXfayQwhJyY9qyi
   FkkAbhovO3ZRzlZ5hIb03c0JbC5oinfSWx+i6kKbkjH3Zkiksn6rjaOPZ
   A==;
Received: from mail-wr1-f71.google.com ([209.85.221.71])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2023 19:52:50 -0700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314394a798dso1830235f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688957567; x=1691549567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k9sNy74+QzQoMmro40H1gRC7AOP1wY8QwqFhYNQlm8=;
        b=wVFHQ7R+R6aQ9RStN/XTqOK9UecFL/n/YyciGqdtjR3SjjkewQaUJpAfE2HVKh7CL4
         DYLMrymgHk/1JmL2kWA107TXaoPmuiEyIg6EvFsdraMVt+x4KXpUTGg1zbmnQWQpP1uc
         0EUsbXovZyDqU7P+7tpnBz8lFSrQz+GKqduvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688957567; x=1691549567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k9sNy74+QzQoMmro40H1gRC7AOP1wY8QwqFhYNQlm8=;
        b=khRSnpnOo40W2VQP5ZmX/CMNor9ydo0ig5+fNRwKhGFZHAq3Qj7XKqSXkGrei7iWCo
         sHchljUyPyvChmGcAQmTRdf7pvDxf5/YoHijRTyy3ICIYvZaVoDllm1c6WYEmK0vIIMP
         KuqkxV6CWj5KwJ2Dznsu+5/b2ERbCsQ/YxYJuWRTOxhwxJpyc9Eyvvzp8vxbuwOYuqzB
         rdlQJR5Fhf0pnnz4nNPqyIhXUpoZR2RrnfvmxCVT1PmSxADjIXDO4gdtThVzxl6R90dw
         Fpi2bEhrr3pAsrwbtbTSqIaI/5e7WuvQEpW30ECmCEPYKkM8n/QK+TWzKPsnrdFpOxv7
         0XBw==
X-Gm-Message-State: ABy/qLYPii4BzCgrxHATuhFDDx8tudD4/vHjaDyw7LRbDTQlv8qO203G
        udJIRNPXr4xdRWGO+NpVey1bWLRPbhZ7MLRAyh0ZWbadTbAr+7JQphg0NEF4Q41jNalhay9eRXo
        JHhQfxCJCq4tKGlxBekgJIZlTVv6IEYobZp90GwdeXQ==
X-Received: by 2002:a5d:4ec6:0:b0:313:e391:e492 with SMTP id s6-20020a5d4ec6000000b00313e391e492mr10012799wrv.17.1688957567439;
        Sun, 09 Jul 2023 19:52:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHam+aDebvhumMMgkhgf6P6bFx86kMlMA6n+IUwkhnAapTFQYABBfRdkN4liHbnkyQANIDiKlxS14QAThsHSu8=
X-Received: by 2002:a5d:4ec6:0:b0:313:e391:e492 with SMTP id
 s6-20020a5d4ec6000000b00313e391e492mr10012792wrv.17.1688957567124; Sun, 09
 Jul 2023 19:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
 <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
In-Reply-To: <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Sun, 9 Jul 2023 19:52:36 -0700
Message-ID: <CA+UBctANALC+FdNf+0v+hFZS5RPry=44LF3HQWKMYCxibgb_vw@mail.gmail.com>
Subject: Re: [PATCH] net: wireless: cisco: Fix possible uninit bug
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure.

I found that the related code is from Linux-2.6.12-rc2.
In this situation, the 'Fixes' tag should be 'Fixes: 1da177e4c3f4
("Linux-2.6.12-rc2")'?

Yu Hao

On Thu, Jul 6, 2023 at 12:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-07-04 at 16:50 -0700, Yu Hao wrote:
> > The struct cap_rid should be initialized by function readCapabilityRid.
> > However, there is not return value check. Iit is possible that
> > the function readCapabilityRid returns error code and cap_rid.softCap
> > is not initialized. But there is a read later for this field.
> >
> > Signed-off-by: Yu Hao <yhao016@ucr.edu>
> > ---
> >  drivers/net/wireless/cisco/airo.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/cisco/airo.c
> > b/drivers/net/wireless/cisco/airo.c
> > index 7c4cc5f5e1eb..b3736d76a5d5 100644
> > --- a/drivers/net/wireless/cisco/airo.c
> > +++ b/drivers/net/wireless/cisco/airo.c
> > @@ -6950,8 +6950,11 @@ static int airo_get_range(struct net_device *dev=
,
> >     CapabilityRid cap_rid;      /* Card capability info */
> >     int     i;
> >     int     k;
> > +   int     status;
> >
> > -   readCapabilityRid(local, &cap_rid, 1);
> > +   status =3D readCapabilityRid(local, &cap_rid, 1);
> > +   if (status !=3D SUCCESS)
> > +       return ERROR;
>
> This value is returned directly to the network stack, you must use a
> standard error code instead (e.g. -EINVAL).
>
> Also, please add a suitable 'Fixes' tag, thanks!
>
> Paolo
>
