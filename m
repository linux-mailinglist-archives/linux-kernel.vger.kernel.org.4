Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511F66A2EF6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBZJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 04:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 04:05:43 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577DFF21
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:05:42 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id nf5so2552152qvb.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3cOaTyOYeIZVxQ057l2U55rNaOc2s+33W9J2wioqy8=;
        b=qpp/YaFJ7zfa5FIJrwen7+2Gll3OqxVOyCqZKRqBSFAIv+fsmZ5vztwLw1zCds24C/
         AYjzuNe05F+AKibK20m+kZnRPmCADTaPIiMSXUnwbjXyDAkI8NKmoH5yWJI0QgLUC6KG
         5ZKAd2F8DX/2RJqlIqJUrArtx6J48Frmw9x8tm5pvU/4wR5QO/xZU/cg3O2+IURxJzhr
         BEoInN6BZCwzeSlwXiym3KNnYEZriY4zAFGGcuGx3NKdjcjHpieOlMjhJQ5OsrlcTxZo
         oCAlmhmcBcLW8yvV+vj+ZEHS5jL9KKvlpTVrwoXjONev59aUj6AtQQ56qNgibd0SbPen
         NtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3cOaTyOYeIZVxQ057l2U55rNaOc2s+33W9J2wioqy8=;
        b=Hfzh4J0Vm1qKqT+ELYyPebujwuiXXZ1tBt6Escgz25yW6IPPUgY/xE/YHblLJOGd1b
         H7OTWkEwz/bohph1qRxeDlOEMZ68prIcsQGxicvNbacOV57V5PjB++HSltgOugBcRmhL
         YTyhlkE1NjlRVCCzTQ0ZDM1Z4kSM6GQo2q0YkEf0WGEo9/LADZzDXa3Vy7Q4X9S5pBy/
         +ufTwvcbOYEeA2M8mY9cd+1W1RlcFJCMpcCl3OvAgnGCIisvW4l+m7Ks1cDolNP3UAW8
         UsEvfVZ6t+EG6pXQdmpy7Z2Ol3W5V6PANYccsxVVjZyhHvaZHN1mK6YBVpt7s1f4eXN3
         gHjw==
X-Gm-Message-State: AO0yUKWKtyeZ7gXcEOLy8YGXD8L5mXWyqkpl5feIW3vebC2qFTkkRevt
        R/ZtZQY7AKtoTPtQzWR/PQlWOzx/Va6nKNPgs6Q=
X-Google-Smtp-Source: AK7set+xyW7+GgEUj6EDSCwU+YR/F6qPgCCgaBhZ+kpYb9NYwxgUAZ5TBXZjObZ8jySGriFXGG4AGryVcTAvX1wAc7E=
X-Received: by 2002:ad4:4b63:0:b0:56e:fbc3:2b86 with SMTP id
 m3-20020ad44b63000000b0056efbc32b86mr3890537qvx.6.1677402341251; Sun, 26 Feb
 2023 01:05:41 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
 <9f682c4d-e7b7-5e23-84f5-cea4fdac2085@leemhuis.info> <CABXGCsNruNKfx3d1dpneRUvn3dCqv_bM93TdJsCLeRYiP3qYaA@mail.gmail.com>
 <6bfa6d67-27ce-04b3-a1f9-3768b8a0169f@leemhuis.info> <CABVgOSnCLbqHHA-gT6FwtJYKYAHt_9uwR_S2r6ZE8hm6eZaLBA@mail.gmail.com>
In-Reply-To: <CABVgOSnCLbqHHA-gT6FwtJYKYAHt_9uwR_S2r6ZE8hm6eZaLBA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 26 Feb 2023 14:05:30 +0500
Message-ID: <CABXGCsMW1N6-mHzDfnZGcVgmw0VMUnqCOcoDkzfDDhm+RtSyZQ@mail.gmail.com>
Subject: Re: [6.3][regression] after commit 7170b7ed6acbde523c5d362c8978c60df4c30f30
 my system stuck in initramfs forever
To:     David Gow <davidgow@google.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, rmoar@google.com,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 6:11=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Thanks for the report, and sorry this seems to have broken.
>
> I've not been able to reproduce this locally yet, but I'm looking into it=
.
>
> In the meantime, a few questions if you have time:
> - Does this happen with CONFIG_KUNIT=3Dy as well as CONFIG_KUNIT=3Dm?

Yes. CONFIG_KUNIT=3Dy or CONFIG_KUNIT=3Dm it doesn't matter. Both options
leads to being stuck in initramfs forever.

> - Does this patch fix it?
> https://lore.kernel.org/linux-kselftest/20230225014529.2259752-1-davidgow=
@google.com/T/#u

Yes. The patch by this link fixes the issue. Thanks.


Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
