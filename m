Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97606E6663
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjDRNwP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDRNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:52:13 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7E1FE1;
        Tue, 18 Apr 2023 06:52:11 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-505050c7217so793646a12.0;
        Tue, 18 Apr 2023 06:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825930; x=1684417930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJRH6MtpszAsNh9ZnkW0N2dXCcXquwx5N3uveFAhEIs=;
        b=VIhOg15MtqZPXl8jbsWMh9RH81ZXs5KXv4Z48eywptxlAE15eofUv4ENiQhvEQUOno
         IFHpdQfCokKOmMlK5fkeEsvIHSkHt1mO+8fC73OkrSBxdd+KiCXsnQxfIOL7oeyu/uZs
         jq32Ma5ID72aBfbAKNxxGuFGVlyMq/ZKZKXuVKsg3TLWonrTM7OjXExwDmGlY5ivM1pL
         UVItO4VPezNfpd30w7bCYIMLCuQPgHGJV/pvnmBOgeeNoW7ylzHmwGlq2vMgQJub+z2j
         vMb1Nm/czNIOTUFdkLgmXX9lWZvTqc/0bhQP1zQqeJUjqeY++Ycm8uVPTpg61TcuMcKA
         fA6g==
X-Gm-Message-State: AAQBX9cpPVe9UIMl3RbkZ0zise55dLwyod0Z3O0w4cEOilVtWOdipjSj
        cKHsA9gF7Y14XOHNb68V+R9ima81IeRvZP3EFnjGlgv1
X-Google-Smtp-Source: AKy350Y+DiNkOq83V2KJTZqfYiO6xDEFdz5+m6qu4Dm4oBMnQ6paSt5ka4TkS1voaKLaDuPEoYVKipKytLo716jLuUQ=
X-Received: by 2002:a05:6402:354a:b0:502:1f7b:f069 with SMTP id
 f10-20020a056402354a00b005021f7bf069mr14698925edd.2.1681825930024; Tue, 18
 Apr 2023 06:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org> <b09deeb1-31c8-ba08-86ce-614349f33b92@linaro.org>
In-Reply-To: <b09deeb1-31c8-ba08-86ce-614349f33b92@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:51:59 +0200
Message-ID: <CAJZ5v0gb=wcmYPufWrJDkPoBKKJhZQHP9mJtKoRps1EV470ONw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Thermal zone device structure encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 3:17 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> I think I addressed your comments from V2.
>
> Is it fine if I merge this series in the thermal/bleeding-branch ?

This series is mostly Intel thermal material, so I'd prefer to take it
via thermal-intel when ready.

Thanks!
