Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAA6FD2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEIWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEIWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:53:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6435FCD;
        Tue,  9 May 2023 15:53:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so10321619a12.2;
        Tue, 09 May 2023 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683672788; x=1686264788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK5ASXc7Qk5k53BZegLrLl/LXq90ba90dKCrcJloGco=;
        b=B6CGl1a7QJIoBWOzbZ1AK71oscdzTgkCseNZl2SM/l2v03d1z+uAqyyfcvFpne5IFF
         IKyV4J0UXmpTH1ABNNmXXAkwkro6AYCNgeF37HZHrDKRI7XbZk5tePVrDDpIj4a54Mh8
         zz3G4kyxzzm/l+8gfkUKvl3gnj/a/2qmAFNCAyHS78y5KY/c2OhHMs7mZgw2Utd0KJ3A
         oEDz6GilQtm3yhrA7OrACPbmyACYAJrg5Mtvpbks+CGq4/6WDFJ+RQqX3/3P6osN3Sn6
         fcvOmqV4rpPWeipKjYW0b8SYAwy/eErVyQ6P3jaMviq/aDOW7iBhIIjb/tuWfKPH04sM
         sdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683672788; x=1686264788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK5ASXc7Qk5k53BZegLrLl/LXq90ba90dKCrcJloGco=;
        b=NHcGq59r3CrsKN7Mvq2jcdolhRovSj7Becn8zicfw2xTecOSx142YCT8V5rv6GaFdR
         p99d36TasPzoybG+Wa8llhs7AGiXccVOUE4Nrx6x0mkSXs6yiSBpDyzUJC9b3OIDvw8+
         PtiC/wZY2aoSsVxv27xvjF41xgDBje6IAKeQzeLFAf7g3G4BbZbMBflaY8qb6/omgYMl
         eRxkEQwtTQsPva6oc3DxWIGhjOUn9UYFg05V+/Qwhba1dQf7NO+A+90PoxpqTA9N+ayt
         f0hc0h2CIQLv80apnChPFSu1+jQKXroEH8XXb+n67iNkChTOxG6Z9HH9ucaA1nXpT2zF
         pVIw==
X-Gm-Message-State: AC+VfDw1bYlC8UlserojwLfKDYE2vHWA4pvTQcOtzx2Qmif2h2IVsYfq
        57eMt6jPHHgMtTORL3nPsuct47IYPxSLU99saOM=
X-Google-Smtp-Source: ACHHUZ4BIByOTQ+nZnZj6wMwAWaIjxIQtjE6aNXjYPCQmOchF0FzZGy4iRz1xrpYTOQE6G38v049dtcQ6UDwQjkIrbg=
X-Received: by 2002:a17:906:4fcf:b0:94e:1764:b09b with SMTP id
 i15-20020a1709064fcf00b0094e1764b09bmr14500489ejw.45.1683672787994; Tue, 09
 May 2023 15:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230424231558.70911-1-quic_eberman@quicinc.com>
 <20230424231558.70911-7-quic_eberman@quicinc.com> <CABb+yY3ojsGNm1w+QSn2BnbOMdcQZAV+=UYiMiBrs=jujP=pSg@mail.gmail.com>
 <b4fa7ae9-da5e-7a94-3b82-00d9200aa67e@quicinc.com>
In-Reply-To: <b4fa7ae9-da5e-7a94-3b82-00d9200aa67e@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 9 May 2023 17:52:56 -0500
Message-ID: <CABb+yY2Pr30uhQzAdd=G2w=_pYYN926dMMAEgmJ436ZxVjziAQ@mail.gmail.com>
Subject: Re: [PATCH v12 06/25] mailbox: Add Gunyah message queue mailbox
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 3:52=E2=80=AFPM Elliot Berman <quic_eberman@quicinc.=
com> wrote:
>
> Hi Jassi,
>
> On 5/3/2023 11:21 PM, Jassi Brar wrote:
> > On Mon, Apr 24, 2023 at 6:16=E2=80=AFPM Elliot Berman <quic_eberman@qui=
cinc.com> wrote:
> >>
> >> Gunyah message queues are a unidirectional inter-VM pipe for messages =
up
> >> to 1024 bytes. This driver supports pairing a receiver message queue a=
nd
> >> a transmitter message queue to expose a single mailbox channel.
> >>
> >> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> >> ---
> >>   Documentation/virt/gunyah/message-queue.rst |   8 +
> >>   drivers/mailbox/Makefile                    |   2 +
> >>   drivers/mailbox/gunyah-msgq.c               | 210 ++++++++++++++++++=
++
> >>   include/linux/gunyah.h                      |  57 ++++++
> >>
> > include/linux/gunyah.h  and
> > Documentation/virt/gunyah/message-queue.rst would need to exist for
> > this patch to apply.
> > If you made this patch as the first in series, then I could apply.
> >
>
> The mailbox driver is dependent on patches 3-5. Could [1] be picked up
> in meantime?
>
[1] is already upstream.

> I'll talk with QC Landing team folks about strategies to
> merge once they finish review.
>
OK.

cheers.
