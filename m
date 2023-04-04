Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF93E6D6705
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjDDPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjDDPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:17:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB844C10
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:17:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-544f7c176easo619754287b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680621465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIjj3GIjaRDLMLJjHwmTZj8tsqi4Af4bi2atCwj3M48=;
        b=iNHmpfaD3MdX21OJ834IMqVUpprvvMsk1JFv1JKzMpKchNRqwI6xQ4EEXL4ZdPnUDW
         J88Po8Zqn9GrZq4R3UnyLGJpskRi+4zgijqwc9l16W5vReAokU9C3l1HNxwIibhpL3R7
         +uQ6PSSjT6I3wDuIe+E+7eP/loQGpvjUIE0FzcVz9WQ6dSBRDWQ/O3n9MuPe0Qu48mZX
         IiaSAh5VHvbQ7qRItecxICeSWfab4heOrVe7ZgVBeH4EZidWEP9op70h3muEehfT431l
         H2d2AvcNDlFlJyzy9YQPxy+37jpS9pKRA2dAcGrMhw9e/rd2hFiDGzPLne/XWkBL/LD7
         pfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680621465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIjj3GIjaRDLMLJjHwmTZj8tsqi4Af4bi2atCwj3M48=;
        b=MPDzfrFc1EWogICIYDe5BlDuJCc5iE2KPucPulr3ZVmx2Fvad/z+6vPs5ndqYEPFAY
         ojWSw4Xe/Wc1vjmaBgpyRZ86Vq1GBZraYWZK6VIj0m3S+ZvIOXCqrAwSPai52c5Ph0GF
         WtJz3VAz05Ap5k1XwIQ/61mYO8bv4fzvBkv93MlZZ30baBIeXSdtMNYerlcS9/ooV4D1
         AVxCc+feV3KKRd62aX8qOY1mtJK/Riru/oXWJ3wtG6yXIwSX+fp0fBIo3+Uf3bu+mOH0
         ULNARiTjKf7xeeL9y5W61Jwqg729qXWjaQs1kNbYuA8CwvMCWwxhax7nU3rhjiFBTGdO
         bAKQ==
X-Gm-Message-State: AAQBX9evUd/0L0F2AJ5fr6qWjuagSE8TFzdpBfC2/y1+76fKtXF96koY
        m/GA0PFF42YE7LSkVHZvF4+l/fCZtHh8acmPSrc=
X-Google-Smtp-Source: AKy350YHM8w/mrJP6qnVsKs84lsok5KsCbyvHUPSg1SRDnkgpyZq7yxIQpGUAsK0u7LRjz0sgkad7UuYh0MYLI70viU=
X-Received: by 2002:a81:bd09:0:b0:546:4456:78f9 with SMTP id
 b9-20020a81bd09000000b00546445678f9mr1741135ywi.3.1680621464930; Tue, 04 Apr
 2023 08:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230404002601.24136-1-yq882255@163.com>
In-Reply-To: <20230404002601.24136-1-yq882255@163.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 4 Apr 2023 16:17:33 +0100
Message-ID: <CACvgo53mV7Aoe+omtSF0BNg+gVOWqDQ_QAmMkhikjQw-vF55Xw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Revert lima fdinfo patchset
To:     yq882255@163.com
Cc:     dri-devel@lists.freedesktop.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qiang Yu <yuq825@gmail.com>,
        Erico Nunes <nunes.erico@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 at 08:13, <yq882255@163.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> Upstream has reverted the dependant commit
> df622729ddbf ("drm/scheduler: track GPU active time per entity""),
> but this patchset has been pushed to drm-misc-next which still
> has that commit. To avoid other branch build fail after merge
> drm-misc-next, just revert the lima patchset on drm-misc-next too.
>

The bug/revert is unfortunate, although we better keep the build clean
or Linus will go bananas ^_^

Fwiw for the series:
Acked-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
-Emil
