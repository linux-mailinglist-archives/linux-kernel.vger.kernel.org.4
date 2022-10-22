Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E335608BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJVKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiJVKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:36:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949C9939C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:53:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 67so4802729pfz.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8XCmu4eeANl3gUPR6NIj7yvs9tk1YzIUAXdrodS0x50=;
        b=CaTK8xgEp6jm46Ypv+4caVLKIUmW/lKmjKL1d8LQ+94iH+djTdChMUbSwP8PIDMeSI
         kIdHxTUsOJDJ7QT4Wl8G7ePG2e7Yi38NLdofrzg3tUCY8PBYvWrIf/yv412H1OhygW9j
         rjkBLDCiuvprqde3dlSuAsNbSh/gDJkohuuTsvKzg0wJbCjT/OtL2+lfLLcwchv1BItz
         bM8EJpfuvzaEiu6cRI/w3iNRmH4FXwIOvl2U0DEs6+jcDvCIbi1+1YiP5NICkoa469de
         VzJ3289elNfglQ6TUDOF9EaPC8xTqlC/l3PUS1geeLBT9JYVgx0ZTONTzGdZKf2lSvyQ
         Dfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XCmu4eeANl3gUPR6NIj7yvs9tk1YzIUAXdrodS0x50=;
        b=5OloOoszlncyKxOEO+8Vv75UCJHVRNBWjpbeT+okEU4AOk8sD+wt4MlJe018GoPyCj
         7fQ9P0MON1IEwosb6Gxhjl2Fd8g5RbYJRaDPYJBatnnzSUoL2QGgY4KKSWNba84GYmMa
         fi4DI8xc3cMyensCDnNqwfVGqwLil39HLE0X/EaKWNdCcA2dxZ+v7YzQKNXO+zqpA+q0
         7AsDeQCixGBrStPQ5DFDKRk5XBHJNtAdlKkQb5pQmkPoRnzG8pYvIJ2IERFEfJI1YFqm
         8h8V6jLt206SxhOogdPlOjX86E5YuPLrBqRcDH+Ij2Q4FH30GBU7r0JrZO35YUgxNz9j
         x7qQ==
X-Gm-Message-State: ACrzQf3G0ziKmd1+XTJEQK3f5VZrkllcD5PzB9UjoM7wKQC3TvJ/s5as
        0JVbTgg3yUaycd5bQtKo0fo8EDBX0V/Jpy4uwMuGQJpOtoT0YvzPasQ=
X-Google-Smtp-Source: AMsMyM5D48G0cVp9t1wgqQ7DcnqcSdpMM104wFSVoxci7F80s/Dj3bVv3dKqC07wjHpTSY0eYahbAHeojcH34+PnL/Q=
X-Received: by 2002:a05:6214:d69:b0:4b4:525e:c987 with SMTP id
 9-20020a0562140d6900b004b4525ec987mr19999969qvs.82.1666426885758; Sat, 22 Oct
 2022 01:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJEyKVi=Bw1=-cH8dbJratKw3Lk3ubh_9bcBB=iKPm5H7P1Yw@mail.gmail.com>
 <alpine.DEB.2.22.394.2210221013071.2700@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210221013071.2700@hadrien>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:20:38 +0100
Message-ID: <CAHJEyKXxB0O+r3G5rEsWJJLPY4Ar5Fw9HSgZgyiH12oijV5yvw@mail.gmail.com>
Subject: Re: request for assistance
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
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

On Sat, Oct 22, 2022 at 9:13 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Sat, 22 Oct 2022, Tanju Brunostar wrote:
>
> > There is a portion of the Outreachy first patch wiki I would like to
> > edit. How do I go about doing this?
> > - Should I just go on and edit it? or
> > - Do I have to make a proposition addressed to someone or somewhere,
> > stating what it is I want to change and why?
> > I would appreciate your help.
>
> It would be good to post your proposed changes to the mailing list, if it
> is something more substantial than fixing a spelling mistake.
>
> julia

Ok Thanks
