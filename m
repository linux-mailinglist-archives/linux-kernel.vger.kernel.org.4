Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B174349A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjF3Fzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjF3FzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:55:25 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCB1FE8;
        Thu, 29 Jun 2023 22:55:23 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b5d7e60015so1242115a34.0;
        Thu, 29 Jun 2023 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688104523; x=1690696523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSBES6sO0S+ucqilKRRgFBUV0LjEF9eAIEf/oosxqIY=;
        b=b0pUhDBA3um+86U8PMrx4K7f8bppC1N0d3y+rFjs4R+VPLZ8YOjK1KQZiXYrPf1GRa
         Unqff7WbSGrlMFqAUMXAvZygexK5/CrDqlesqi5bo3cmCpNe0ZkYdqu0gvv+lFyJhkE/
         BqQV87A/9PsUr9GoBEXfByeTHq7AimxwwQKpPePMXJj4jwwLktOFkpOEM/olRIoFFT5i
         /r0hbkLe6DvnmaFs9CyvwypoBvoZdm2vv7MmoliAxeY4+oS96uwzaKnpVKZjvmbOkNg5
         wmfMlxygyDIFcoo63JmqeGcMobiikjgQ40sxVn86VJmGqHQyQHdog3n3qytoPt5AdB/K
         Xglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688104523; x=1690696523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSBES6sO0S+ucqilKRRgFBUV0LjEF9eAIEf/oosxqIY=;
        b=O6J2kdM/gleslHImcu85LiN7uKUgBp1h29AhDdG7UMz9oPH7p12FVRjDJMUh7KK1h1
         kGiox8ZZp5eFZ1vAh7vt4ypsWgCPUHN7BIqBOFOa4DxsmDp9aK/3/FS3AR4CH9Vtn+JM
         n5FQiZS7aQxFe6xtQsnR3nGU5ZupFFqUhdJhSuDa1XDFaq+72IsEDd1CHB7hBQdvIB5r
         rOeRrE6Zogb39e/O1UwXaufj9Ov61uWiE+4p5w7Ly+eKVZMzylZ1WQiv4hAj01odKi6U
         2/Ok4TCYqP0qMxGCLwLfoEDo65jDGSg/gGrMN3E58utHWK20Nn9NhQoxQYYOVYpJ3sKZ
         XDOg==
X-Gm-Message-State: AC+VfDwPMOZzlVD8o4+kxq6Yz3HRNPWYe5a0vE2EvVfUKTUEM/toBkYS
        3Yg/6HnZNsIp1MrCCaEPVRqXN56BFwy6kunAF8E=
X-Google-Smtp-Source: ACHHUZ6MGlFcc4BSao10wMY/aeDrw4Ttrm9C+qRs9GGoDIvp8DsVfjBqa+jsURtKymgoNPmZVyMnH6vsAzPmDfvD1iw=
X-Received: by 2002:a05:6830:1059:b0:6b5:c745:7797 with SMTP id
 b25-20020a056830105900b006b5c7457797mr2169875otp.30.1688104523153; Thu, 29
 Jun 2023 22:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230630032653.26426-1-qiang.zhang1211@gmail.com> <CANn89i+Yw_3FEjo_dYSknhmyfoOCD-1S0OSRR_GoyMjQPjcu6w@mail.gmail.com>
In-Reply-To: <CANn89i+Yw_3FEjo_dYSknhmyfoOCD-1S0OSRR_GoyMjQPjcu6w@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 30 Jun 2023 13:55:11 +0800
Message-ID: <CALm+0cXo-Bra_5M53c024+tnO-VTZJvO=4MhhVf-KUTb0ZGmfA@mail.gmail.com>
Subject: Re: [PATCH] net: Destroy previously created kthreads after failing to
 set napi threaded mode
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 1:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jun 30, 2023 at 5:27=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com=
> wrote:
> >
> > When setting 1 to enable napi threaded mode, will traverse dev->napi_li=
st
> > and create kthread for napi->thread, if creation fails, the dev->thread=
ed
> > will be set to false and we will clear NAPI_STATE_THREADED bit for all
> > napi->state in dev->napi_list, even if some napi that has successfully
> > created the kthread before. as a result, for successfully created napi
> > kthread, they will never be used.
> >
> > This commit therefore destroy previously created napi->thread if settin=
g
> > napi threaded mode fails.
> >
>
> I am not sure we need this, because these kthreads are not leaked at
> present time.
>
> pktgen also creates unused kthreads (one per cpu), even if in most
> cases only one of them is used.
>
> Leaving kthreads makes it possible to eventually succeed to enable
> napi threaded mode
> after several tries, for devices with 64 or more queues...
>

Thanks for the reply,   I understand the approach in this way.
But for successfully created napi kthreads, should NAPI_STATE_THREADED
bits not be cleared ?

Thanks
Zqiang

>
> This would target net-next.
>
> If you claim to fix a bug (thus targeting net tree), we would need a Fixe=
s: tag.
>
>
> Thanks.
