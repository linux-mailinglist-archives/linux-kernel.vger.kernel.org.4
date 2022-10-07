Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E45F7457
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJGGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJGGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:47:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD101176E2;
        Thu,  6 Oct 2022 23:46:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m15so5679592edb.13;
        Thu, 06 Oct 2022 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+Lu1a2GZvFhlAH8Wr/6nPLSa8zejWhrHmJvH/+vEds=;
        b=ofQYWTx3WtIku6/xfWUuT8SMfdW/9J7/ybhdMbJybyqBzf1/cdgyrvjAsn5QRwvyjs
         LVFaxQhRQW82nF5Ob9dAPuFFZ+zM/UKwnek+Etz5idzu3IvIHmX8PoGmR4cMWIA/AEyS
         M4nZBuFCxHD2JdO+ydt36jHkXohwWlH2v/AmQrpVdaDxQf3heYgL/qIovjlNWJX5uC7/
         miBw/fUk0ctPMOR3Sxcgee+pzVh3uC1oLbB6epDlt8FkyyOWCQsUWGRmq5S/+ZayG1pu
         NW82lxMPAzTnLSdrDwkTXgskJ1JupnbJ/K2kj0v9kRiu3dyrtVW/jXAMoC+IkUwwBesz
         520Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+Lu1a2GZvFhlAH8Wr/6nPLSa8zejWhrHmJvH/+vEds=;
        b=keQuYoen0Q3I8bxvQO/EPQdrIvIAyCHsDLQCkaMG7LHchhWrWI6bLZ25TxAThRCJQN
         6LhT38Ok/s9zgi7/dj4BdOeWSOvaaT7LhBcTdRI5q0jI7F82CiClvti8dnPfmJnO6EhK
         9SmiYmhB2LTNmkmHrovc0S2B477rsoIrIymzsH0av1lgHNJahlFqKvNCrTTm8ezrjfFp
         aBcpP553fD7L2SE923IBN+rNCSf4yjUmu4VMDrj2MeXF5uuTaljJcVhpz/F6/5BHKoPX
         vD/Foxg5I+wyytv4mWlbU1DGA+rK+sJELjaGDk685cVdeuhJ0C0a22ntYbqgaLgahDkW
         ow3A==
X-Gm-Message-State: ACrzQf1zIOAEpOlXLZhpmXmrVVdcLbS0Mne3WqSrIA+dUuE3zE3FE6l7
        G74DN8JSWMn0Ftw8E0CRHBMxinERyFqjyDTJJNA=
X-Google-Smtp-Source: AMsMyM7rGC7/Cd/zF9SwuxRDXxZFtTxOMZ4Y9+N2m8frnFQAOSvzAIuWSRvKTWs7uM9H+LoPDY3pae+brMFLaRbSV3Q=
X-Received: by 2002:a05:6402:2989:b0:44e:90d0:b9ff with SMTP id
 eq9-20020a056402298900b0044e90d0b9ffmr3172425edb.110.1665125217771; Thu, 06
 Oct 2022 23:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com> <Yz/G0jQxc4c2gzhl@kroah.com>
In-Reply-To: <Yz/G0jQxc4c2gzhl@kroah.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Thu, 6 Oct 2022 23:46:45 -0700
Message-ID: <CAJx26kUTzBeNkV_=gEeUYaatBwugT1uFH_b_ggq-fXaJDRBMqQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, linux-phy@lists.infradead.org,
        f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
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

On Thu, Oct 6, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 06, 2022 at 04:21:09PM -0700, justinpopo6@gmail.com wrote:
> > From: Justin Chen <justinpopo6@gmail.com>
> >
> > Al Cooper is no longer the downstream maintainer for broadcom USB.
> > I will be taking his place as downstream and as an additional
> > upstream maintainer.
>
> What do you mean by "downstream" here?
>
Downstream as in internal to Broadcom. Apologies for the confusion.

Thanks,
Justin
> > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
>
> I need Al's ack as well.
>
> thanks,
>
> greg k-h
