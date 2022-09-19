Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF85BD522
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISTTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:19:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A17D92
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:19:31 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y82so220661yby.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FXLyqGxgl949dQXd9+Y93zHcrMCOz6aSMQMInAwIeao=;
        b=Y1sysjOv33mISn1q70tz/ornMY+WsYjj8pwwOMNYoeEDrjz+CcDRAJILfFHrNzc1bo
         OkXD8KfGtJfYX+50rR+zUndJrqlLUHSBxc0Ij1HQ9PgWqZasdCMZTY5Ek86VBNsAupth
         /tPka1tNtGB4U2wibDQ7JqF2Bkj6lFVNNf7M2U+/Tzn7dg0ZB/SB12D6hLC6C6LQ1IfV
         CgflZeDxFIY2EE93V75DfNcueAvSnLNCOpu6Rtc6eBKqxLyFwMFU/hgrMJjoyC2vf7x0
         nmk41hm6TyRgk+c7Cqe73DJUU11K9zoP7mJfH5tZHo0YrNLlmN5EqerDHdEE9krQcnkL
         VDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FXLyqGxgl949dQXd9+Y93zHcrMCOz6aSMQMInAwIeao=;
        b=yGEuClFvPdl9FQ7QzucvUcdKsiUwf2OAAl7rk8tldrM+nJI3VzH3tZJ0Fkbzjbqfou
         D9kEdHN9o7asVMp1/Iu+sjMPx1BWWFpRzHbJpFmRKhTnOJ343yuJs7QSjl1NfmxtzMq9
         Osvzr+NSnzsXoYHtpAIstfuLyLHw+qhIE82qQpaaXsOv6uwCw2rsUHCFBh0Cs75+hUBA
         tkEEVQ4YwsXOMuNrgSn9zgs57uga0ne1D1E51jc4gL94BtUkVaRQihPobWd6MSj1WxrL
         DnLIiYWeYVNj63fWuy2ulAqhv4/0JLg1MksH3v0yCCDty/zEdRh92eXi3dKIpxF+2/j/
         9QHg==
X-Gm-Message-State: ACrzQf3AtkjmLpcAmF17yIN+Ut2Bn+WwRcey/9UqcbSlqyBLRcMlQMXn
        zCBAdvKBuQstysKzKhKLa0zdvwyFXgOB07ajJ6GxhSTo6zRQcw==
X-Google-Smtp-Source: AMsMyM6cxcp910uQasBXZ2uu/YUuglapy5eHTqQW940vXB6HdiRB9HtxI0nM9Ze56dVuw/x6p5SifH40jDS62HqtpD8=
X-Received: by 2002:a25:389:0:b0:6a9:20da:fe68 with SMTP id
 131-20020a250389000000b006a920dafe68mr15145597ybd.49.1663615170238; Mon, 19
 Sep 2022 12:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220919135812.8307-1-aruna.hewapathirane@gmail.com> <590b49c9-5940-c7e6-0a23-9a82cd06fe62@gmail.com>
In-Reply-To: <590b49c9-5940-c7e6-0a23-9a82cd06fe62@gmail.com>
From:   Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
Date:   Mon, 19 Sep 2022 15:19:19 -0400
Message-ID: <CAFSeFg-awEMyZjePcvO_Mo3k_pFX-Kq85Uvbub6bmA7XkQ7zZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: rtl8192e: removes blank line
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, f3sch.git@outlook.com,
        guozihua@huawei.com, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Sep 19, 2022 at 2:41 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/19/22 15:58, Aruna Hewapathirane wrote:
> > This patch fixes a checkpatch CHECK issue
> > CHECK: Please don't use multiple blank lines
> >
> > Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
> > ---
> >   drivers/staging/rtl8192e/rtllib_tx.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> > index d5275319a486..f651947f6b44 100644
> > --- a/drivers/staging/rtl8192e/rtllib_tx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> > @@ -920,7 +920,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
> >                                       tcb_desc->bTxDisableRateFallBack = 1;
> >                               }
> >
> > -
> >                               tcb_desc->RATRIndex = 7;
> >                               tcb_desc->bTxUseDriverAssingedRate = 1;
> >                               tcb_desc->bdhcp = 1;
>
> Please avoid the 2/2 in the subject. This is only for patch series.

I will do so in future I did not know this. My apologies.

> Create a version 2 of this patch with change history.

I have no idea how to create a version2 with a change history but I am
going to Google and see what I can find.

> Removing blank lines is OK but do this for the entire document.

Ah.. of course makes  sense. Once again my apologies.

> Add the file name to the subject to make it more unique.

I will do so. Thank you Philipp.

>
>
> Bye Philipp


On Mon, Sep 19, 2022 at 2:41 PM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/19/22 15:58, Aruna Hewapathirane wrote:
> > This patch fixes a checkpatch CHECK issue
> > CHECK: Please don't use multiple blank lines
> >
> > Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
> > ---
> >   drivers/staging/rtl8192e/rtllib_tx.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> > index d5275319a486..f651947f6b44 100644
> > --- a/drivers/staging/rtl8192e/rtllib_tx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> > @@ -920,7 +920,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
> >                                       tcb_desc->bTxDisableRateFallBack = 1;
> >                               }
> >
> > -
> >                               tcb_desc->RATRIndex = 7;
> >                               tcb_desc->bTxUseDriverAssingedRate = 1;
> >                               tcb_desc->bdhcp = 1;
>
> Please avoid the 2/2 in the subject. This is only for patch series.
> Create a version 2 of this patch with change history.
> Removing blank lines is OK but do this for the entire document.
> Add the file name to the subject to make it more unique.
>
> Bye Philipp
