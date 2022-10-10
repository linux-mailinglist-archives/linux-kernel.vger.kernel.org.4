Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0468A5FA1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJJQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:27:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C41C933;
        Mon, 10 Oct 2022 09:27:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q196so2563359iod.8;
        Mon, 10 Oct 2022 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/l0at35d5ZpUwnD1wrDKWJwkOqrdxisFrwwbw15s3A=;
        b=ZwrOrNjv+DPNhE5Jeg4JGXLwQ6WcmyorDalyibYOWbZNNUwMZS48FmdRTvZ6Qm+aTJ
         lSNo4uf75769dCJtXPcejkJH36PLk3nQmjzKUy/W+6Uw92fJSJWWgKD8OdFOabv0t1yW
         E2C5xAWcwfR+HdgrTuPt0vwUavv8DDFv1pwnDtBK7V1uF+85mPloR0zz8zct4aqjUnNx
         +/wWv2YJ68htDxnUCgvc/AgchrlD4IEOfLRfpEa8d7WUUua00QkO86OdCb54JU2Y8Shh
         kCsbB4mLCwe8z6dVZSCvifNz4QhrZHMu0Bz+89Kq1kYdrPAc9KpOaI8d4DKM2iJCioQt
         wQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/l0at35d5ZpUwnD1wrDKWJwkOqrdxisFrwwbw15s3A=;
        b=o4i1I9IvwOKscJkhDJ8X9W+OOARSwyY6iPECpbtHZMxV6eWwmvu/TAF95o5s4W2RKC
         IHQCRb8MocpPbG3vX1u68MId/FdgS43oCObotBL0XQHiuOstVDEB5vh4ZRC9EmCNyBDk
         8hpbkHGpF+Rs/EE/GPBFy+doLDuJZ2obi7ZZ1qgSIcZGSqLvdspMj5/zYywI1SOZ82VZ
         rUr1sBXd+tgLjxUmTFLwcZfieJw4yhbRw6NEwBHISzB0TObXGugwG+zfYfywPgi9j7yS
         6Wmt0wAiwFkq/4ZJWb+6hnSGcx93dFTMyHcUmbGQ37HDmhUmXoQJlr5Q8LqPujuzZEdm
         H55Q==
X-Gm-Message-State: ACrzQf0ifjy/1rSfTmas8mAPgUtQ6+TGknSt5IjmoffdLYAhQUiZXs3/
        yU8ci0cq9yVgdIV+oVq10GG/mkfahwb46r7cfgE=
X-Google-Smtp-Source: AMsMyM7bAhLwNuit40EhmKHM4albATagjiH95EZ2eAu5WNbTVC8+sEKsctBxCCsczwGXpY2l1kjFIXb/7YvCpqo27zM=
X-Received: by 2002:a05:6638:3c45:b0:363:afb2:3269 with SMTP id
 bg5-20020a0566383c4500b00363afb23269mr4242865jab.215.1665419226823; Mon, 10
 Oct 2022 09:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221008181655.2747857-1-lis8215@gmail.com> <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <CAKNVLfZhH3s=jBWAoSppXSotY9giRRJbub9MqxCtjdZKh4fprg@mail.gmail.com> <Y0Q//+onKu16VQKH@sirena.org.uk>
In-Reply-To: <Y0Q//+onKu16VQKH@sirena.org.uk>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 10 Oct 2022 19:26:55 +0300
Message-ID: <CAKNVLfZJuE-sPyHFQdo_PGHg5FZEUjbamJqAce+GyBCxc6xTbw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Various improvements and fixes
To:     Mark Brown <broonie@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 18:53, Mark Brown =
<broonie@kernel.org>:
> The issue is that if someone is relying on the current behaviour and the
> control starts doing something completely different they might be
> surprised, it at least needs a separate change.

At the moment there's only one consumer for the codec in the mainline kerne=
l
Its RetroMini RS-90 and it doesn't seem to have capture capabilities.
