Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D36CCDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjC1XXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC1XWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD12705;
        Tue, 28 Mar 2023 16:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7CFA619FE;
        Tue, 28 Mar 2023 23:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ABDC4339C;
        Tue, 28 Mar 2023 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680045722;
        bh=co5fEGaVszuv812QVnnlYJe69TgJtRpilCHulLW9qFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPq81Ti0mF/9qwl4/eRRFfUBShZlyQA3FnMwB+u1M2XJOQ+xrey4dhCmnRNcnPSPg
         HAUKzsSuCaK3bkjXtpKUbfwAcFSrJRb9Qt5Q2VSI7OpPsdQymqLlXC1cPaVyOlWXN6
         DUQzO3Usg4EgT8EElxDYX0KbnWBZeOR5vhAcwzwM2qVto+zL19m7fniC83E1vq1XFP
         TBKJWr0vb57mOoCydY9QEWC0B2J2plJz/11gD+YKmfw6yFTWx5mskBaGHMvqNqekhB
         lNjoqR8Ssb7h4ohgwmZkk3g7iX0DaS6WwfYZ74fuM/SOTWvxmJzqRFIuQdBbzi4Xqe
         HknP9mKYD+rDg==
Received: by mail-lf1-f41.google.com with SMTP id j11so17856955lfg.13;
        Tue, 28 Mar 2023 16:22:02 -0700 (PDT)
X-Gm-Message-State: AAQBX9eKzJ2bj5qca/KbbMHhg4BhbOJ8Tk7TQ9h1qiXp+qIQ0g0sC0Om
        +bVTBRkrAMLLxU3ltz3itnB0UPPwW1VTFv8sVgk=
X-Google-Smtp-Source: AKy350bnP+To9f0vTNF3FRw9YcJvrhq6/6Y+OpkYwHV7o8Y8kbD9xs0OWp/mam3rNGg33T/z4SyQSdTTEjJi4E7sW2M=
X-Received: by 2002:ac2:44a6:0:b0:4eb:d25:8686 with SMTP id
 c6-20020ac244a6000000b004eb0d258686mr3182315lfm.3.1680045720118; Tue, 28 Mar
 2023 16:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
 <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de>
In-Reply-To: <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Mar 2023 16:21:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7JZDps_fTHyCabjfG4YjzDVEW_41u6d+9mdc2CAJv_Kw@mail.gmail.com>
Message-ID: <CAPhsuW7JZDps_fTHyCabjfG4YjzDVEW_41u6d+9mdc2CAJv_Kw@mail.gmail.com>
Subject: Re: [PATCH resent 0/2] md/raid: Adjustments for two function implementations
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-raid@vger.kernel.org,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Maciej Trela <Maciej.Trela@intel.com>,
        Neil Brown <neilb@suse.de>, Shaohua Li <shli@fb.com>,
        cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 2:20=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> Date: Mon, 20 Mar 2023 17:28:05 +0100
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   raid1: Fix exception handling in setup_conf()
>   raid10: Fix exception handling in setup_conf()

The two functions look good to me as-is. I don't think anything is
broken except that the code analysis tool complains. I don't think
it is necessary to make these changes.

Thanks,
Song
