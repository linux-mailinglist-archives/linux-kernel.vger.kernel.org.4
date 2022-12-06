Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6964482B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiLFPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiLFPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:40:10 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E9639F;
        Tue,  6 Dec 2022 07:40:09 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3704852322fso155845457b3.8;
        Tue, 06 Dec 2022 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ThPSGliMj5FPf9Xlzh2ID2mJISM67fNXi8L9naNkpQ=;
        b=ocIEVhLuDpE6UrWQf/lROjffPcfMDB0BSRXZwk2c/UXVzOuSY5MeO51ToLnVRO9hSY
         Au2jJ0zXHS7x2rjoPlR5+WH6b19m33Te6UqZmjgf1kdPdCGRVmPsnJUpoPZNX9pmDJrS
         hvyLxxckphZFRdUZg8SO67zNS2I+Ib1SkTMREbQMsFBPST7n6qFwd/PlVwzA2pXGDPtm
         rqYvFFdd0/hNGe3b8OHYnjKnUTLH5cHG19sk+7Dx3gm1IT6rOLR9rdUnWh2GIpfxTBNb
         +zB+RmC5dPV/ma/zIMYx15uMZ22NdbhYmZQlkyjOq3qOn8TzahHcJs5UGU1Gw0i9sDDK
         QCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ThPSGliMj5FPf9Xlzh2ID2mJISM67fNXi8L9naNkpQ=;
        b=LRJam4fLOCb7vZFLuFIXakfH2421MZp5Da6K1UdyeAwqObiK2SFvlm2KJzp9eumTTR
         9k3OUmqK04nxH47J/fxrkRwqziMtannfCQFZ2BJKZo+VwHO3ck20IpdFtdyE/+Z4d9pe
         RZTTnwb8H7P4rgWBOdrAWfje/vhZS0ogI5oJm7tApxeXCni4DIcUCTplPz1MV3i1cwT1
         PNXfsxzHZlkU2UpzgYSMkDyLeMkYLH+fIYcaiQ+oIxefH6g3MCJ4u2LQDN3DIB7ZAhIS
         7KpcbH6GPNRPHADvVUFa1lEHU7ULEOVzf3iKloJ8zzIxAMDjM28IkIJUk0WnK6fsoQkO
         qwIQ==
X-Gm-Message-State: ANoB5pne54/tCHSHyUaUUd5orIFlQEH2+Qmr8s7v7TcEPMBUOkKiNrH+
        vemlD3LKA3DgWJJva334XRZLdR7Do7L1RV/fxWrh+qeDxTUh5w==
X-Google-Smtp-Source: AA0mqf7hz5YkLETJYzgyEGHN4God22Lr8Sw3xTxkTUtCsmX82IorWw2CktG3RaNB4F/9rkGDafaGPyIxd/upY0xm69w=
X-Received: by 2002:a0d:e6c4:0:b0:3bc:7270:cb70 with SMTP id
 p187-20020a0de6c4000000b003bc7270cb70mr49390172ywe.83.1670341208893; Tue, 06
 Dec 2022 07:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com> <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
 <CANiq72=ud1EB+jcKE=iudFSgKNcqd=8Xe-M0YgxikmUuQ+TjGA@mail.gmail.com> <e3523f33-847b-81da-7b20-83ee54597d9f@gmail.com>
In-Reply-To: <e3523f33-847b-81da-7b20-83ee54597d9f@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 6 Dec 2022 16:39:57 +0100
Message-ID: <CANiq72nTaA=w9BuXxityy6nqQ5OiwuSkhxZCENC580n-7C+Axw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org
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

On Tue, Dec 6, 2022 at 2:32 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Why is RUSTDOC invoked when there is no change in rustdoc?

I think we can give proper dependencies to `rustdoc`, so if that is
the main concern, then it should be OK.

But note that `htmldocs` also calls Sphinx every run. It does a subset
of the work, but perhaps we can save some time there if we could
detect whether anything changed.

> I think you can add a new target in the top-devel Makefile which
> runs both rustdoc and htmldocs for CIs. Something like 'htmldocsboth'
> or 'htmldocsall'???
>
> htmldocs and other *docs targets are the most primitive ones for
> running Sphinx, so my gut feeling tells me _not_ to contaminate
> htmldocs with rustdoc or vice versa.

That is reasonable, but others wanted it in `htmldocs` (and the goal
is to eventually do so, so if we can do it already, even better).

Cheers,
Miguel
