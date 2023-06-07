Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F015726193
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbjFGNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjFGNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:43:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633491BD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:43:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2564ced644bso1492231a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686145385; x=1688737385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sc6oDuMQqA77zEuTXlGxY+5xTNJd3tJz5tFxJrSncI=;
        b=Yc6TaVlSOePyfJpy5ZMkaZVTEFw2kVMvMh01nMiNq7+qRqQzsphROcxLLsrdk2qNNz
         yzfPXwDldYQIPA05zfPDGypIUO957rl63i2tq5nuTFIbhU9sY75Z3pmN7bnvJcao9D5+
         Cn0Cp77HrJ+AnIns2XgYFJJm7rCLsjcMvO+HeQI2JJ33ZGubYA2SGjPRVhBf5WQuHkEb
         ZqwTbOHkxTirCr10R6gSDA+sz8g2gqmYUrrIro12vZiOiID+pIq7+bnD4MGMI4Sx+4N7
         ZfTliR6QvTxrXnzyUqIDrulb9xEcn2HeWPZHMBSwByHH5fVuTQ/EGNE0UOUKzZnombNK
         7rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145385; x=1688737385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sc6oDuMQqA77zEuTXlGxY+5xTNJd3tJz5tFxJrSncI=;
        b=PvrRxPPf0SJS25gAoizDt9YrJ29csT4FBuGDxG3ngq5+zUuA8PKia/txh4qxb6HHs0
         /GaIbwLW2bqGAsfSPGo0tQG5FxkJ3ZYRFvAUh3Rn41ThQ9AqKzRQm7OrRGZEEMY/gi7S
         7TkTvBdqO+gvtkuEQ6lmhONlGmGnkssQqVlvV1vhdAT3MMOkpCAE0Sejl50DapiTZA3m
         8l/94d0IPMi3TA8CEaX+WjbredMufgfSq8P4Dfu+3DQUkTcyKD6+d9H1c0fApOF0Qv4A
         +/tckmSiN51gNmsW7FmzYm4ru9duI9UU77uGzByj0Q8kxzJhi1+IwF7teTotsHMtgwVN
         +7gQ==
X-Gm-Message-State: AC+VfDwXGGTKDWn3b2aoOxCtiet58mvrLvxzw54O4KBrWj0R6kCLT6hq
        c+StVQwTZObvEhjaPqpob1EY6czNnB9f1HrYc65inhBm
X-Google-Smtp-Source: ACHHUZ6ueBMsOraSeNkQ+dIhqvh7wgUM+5IzVoX/hnYfUfYOkuo58O5a5J6yAFNuT0YJISl9i09NyHOEurspmWkjdNs=
X-Received: by 2002:a17:903:32d1:b0:1ac:6b92:a775 with SMTP id
 i17-20020a17090332d100b001ac6b92a775mr5808150plr.6.1686145384769; Wed, 07 Jun
 2023 06:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5A6MoDDLmQHoFCvewjpuPhC8_nbOVrKZR9d8Fn1d+3VgQ@mail.gmail.com>
 <20230607053758.GA20425@lst.de> <CAOMZO5AmGHHs-aiBJz5rDO6bV0f2sNjOYkqQDewGPOvw_zQ=5w@mail.gmail.com>
 <20230607133730.GA21195@lst.de>
In-Reply-To: <20230607133730.GA21195@lst.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Jun 2023 10:42:53 -0300
Message-ID: <CAOMZO5A9d=sn4gnQDcJxALnPggy-Swm=HssG1D03YvR1m7y0_A@mail.gmail.com>
Subject: Re: rootwait regression in linux-next
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Christoph,

On Wed, Jun 7, 2023 at 10:37=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Hi Fabio,
>
> I guess we need an ENODEV for that last case as well.  Please try this
> patch:

Yes, this one fixes the issue, thanks!

Tested-by: Fabio Estevam <festevam@gmail.com>
