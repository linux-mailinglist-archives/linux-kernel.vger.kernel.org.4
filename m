Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D364B733C7C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFPWjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFPWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:39:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A49230EA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:39:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so25426f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686955157; x=1689547157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6yO5E1Fnji0gLtVb0JItaj1n3aQ72Rg3bnTHn9vsqc=;
        b=DFQ0s0IokUfrPqYJnqd6amdi4/9M9ETLsq1Yq8k0+59kAL853QuOUog4pf0bcvdNB1
         N2TUO7hwNPtSMZsBQmLM07BAqVwrihL5jDofOqhTQD4v/Hvteqqa904B/x7aFG/5k9x3
         qQvOvVMUU1c7aRQ/FDx87XU+JvEkX0sj8OGuaHhoV1HgYyHVCGH7pPv8pGH994DKK2q7
         Vf6CLf8iNCxNAj2cbUmGRuZX3zA2YFPntY52k2KFPBv3XlnkTTq/4DEvPnQk3D/Eb6Lo
         S66KTS+ooI3cKcTlNfg1EUfVQ1dHhpd1JXUC1aiiNcyMe5jt76SHs/VNI7gfGzv/FHP9
         El6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955157; x=1689547157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6yO5E1Fnji0gLtVb0JItaj1n3aQ72Rg3bnTHn9vsqc=;
        b=Z7+jJhRb68HYVFMRMxfYwN0P2oD8FxTbtOudgLmXrV2n87gghRMvrIVlCHgzS9rpAL
         I9+k6fpYgUe4Dm1rXjfsEkyRZBrprT7sXUlAen3B3PqmQtO3h2HUlMgYwUgC8CFxkOPl
         pWkLNW10OarunhTQcc/W2Aj1OPy6eEZqwfPk/GPYlxomFJUxymYbGWc5y0Pm/Vn5QUi5
         NXDsVEzZ0Xuhl4jsTXwqhIVKuJkoj937cRGRuELHUoI06RGBFABfz9jwRNIBUXIOo8u8
         4yqGE3Ka5SFs75mYnX7gW4dvQiwGtBXMUPjh1uzJGsup7Y/WvPCWc5FFPY+nnmvildpR
         dtmw==
X-Gm-Message-State: AC+VfDzMoVh/b8FqG1RKcoul/LvtcQ68sbieWO45tQ5XO6At0DScVo+G
        3uQ2+r68nAQZqXpcmW3GfPquYYjsExypDh3K95ttRUPWWOBwAjI5tyA=
X-Google-Smtp-Source: ACHHUZ7fxnuOo8AsjX5kB7d+HDQMpXyOaKIug3jxbMPTnMlwW7UJexmxSRZqvkDRhZqLnaL98S8z7sc2M0jCoYITzEs=
X-Received: by 2002:adf:e7d1:0:b0:311:9a5:2d63 with SMTP id
 e17-20020adfe7d1000000b0031109a52d63mr2210911wrn.42.1686955156857; Fri, 16
 Jun 2023 15:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com> <648e22d2-d455-4439-a00d-4042077a8571@sirena.org.uk>
In-Reply-To: <648e22d2-d455-4439-a00d-4042077a8571@sirena.org.uk>
From:   Jim Wylder <jwylder@google.com>
Date:   Fri, 16 Jun 2023 17:39:05 -0500
Message-ID: <CAEP57O9c2Ano4qU5V4EK3ePoBHz+N1xFDo8ULEvidPFnBX+0cw@mail.gmail.com>
Subject: Re: [BUG] _regmap_raw_write() - divide-by-zero
To:     Mark Brown <broonie@kernel.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for causing the grief.

For the description would it be something like "Max transfer size
supported on a write"?
Or does that still not describe it correctly?

Jim

On Fri, Jun 16, 2023 at 5:14=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Jun 16, 2023 at 02:58:24PM -0700, Russ Weight wrote:
>
> > The origination of the regmap->max_raw_write value is here:
> > https://github.com/torvalds/linux/blob/4973ca29552864a7a047ab8a15611a58=
5827412f/drivers/base/regmap/regmap-spi-avmm.c#L663
> > > .max_raw_write =3D SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
>
> > SPI_AVMM_VAL_SIZE is defined as 4, and MAX_WRITE_CNT is defined as 1
>
> This should add in some headroom for the value too.
>
> We should also fix the max_raw_write comments since it's a bit confusing
> between users and buses, though AFAICT nothing outside the core ever
> checks.
