Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3A6DA618
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjDFXP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDFXP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:15:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC36E82;
        Thu,  6 Apr 2023 16:15:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id f188so29259198ybb.3;
        Thu, 06 Apr 2023 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680822924; x=1683414924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXUdQboTgq9TFHD5xYoyvY+r2FwQ208ps3K2xaFR8lE=;
        b=J6b622BG1gXLhYxaAqxI60m8PJ9dpsAToqn8/bw060Mj/WjKMcb27A1PZJYYjqSCKk
         YL6wmKKpHtgdGoycmJbzHzIJIgn+59IyJp8pThkSZKSWQdQkUAR6uLU+czmpZN0BeQeB
         NPspe/NghvLZFvp5EmPwgPiXGHd8Zu9qLgFsD3STX3QRgJUu3vArhQino/s/3xCgorHR
         7kqCgVu20gjAqzHsBHvul2OPC33FH3OjqgNe/AntOQqaI9PeSC5N3Z1R2PjF8aAckbE0
         +hboL72q0gnjzKiA0rKnHpfe1Q0LG7KahOe5cMq2ReXDFo4Tb8dsjRCNbctusBUDx7Lm
         4d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680822924; x=1683414924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXUdQboTgq9TFHD5xYoyvY+r2FwQ208ps3K2xaFR8lE=;
        b=8DLXq4d3CTJae4C3c85yLJhukG2XvdULYBjJ3TvK+M/cV6tVjN+GWdxO/Tni8kstkI
         vfMAGtTebQZS8px8EH3c2/ZlHN5d92oZ0zCoL+ED6RPL3YuTy+AoMySAhKfQsTPmfUyC
         +MtWJWkDv/6V8ykg9jK4Wk9uQAMz6DGJ+BLOeh2z65SzvuDRXmETqvHTQsn3DIJBCKWq
         nb7NkkbQpo5IRjGexqR9K0OXaM6bLATFj5YZPdYuAKGhAJTMUHOUwtY7ilzDXzY54Qls
         cvgiuBZHXOtMSvXogwhM58G3nnIZr50xK90Xk5CtqnTiBEoBd4iWxgx+vqL1b6xcWuRd
         uAzw==
X-Gm-Message-State: AAQBX9efxw4wXlGg6bJ6ZnIjyEvjpkDqurrr/EOpXbBeZLelpDPGA7xW
        8N2oS2/sic+K0SC9bhnrKITq8kAlBXo4O1ZpzgI=
X-Google-Smtp-Source: AKy350ZNun7osiWw0y3G6kLtDI8UN4MscjAjaiAX1u0K0V2HPrGHlxAyY2wLPbLZDvojx1cmJe4gYK8hJbzkO28NnV0=
X-Received: by 2002:a25:be11:0:b0:b4c:9333:293 with SMTP id
 h17-20020a25be11000000b00b4c93330293mr552544ybk.11.1680822923678; Thu, 06 Apr
 2023 16:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230329233921.16729-1-technoboy85@gmail.com>
In-Reply-To: <20230329233921.16729-1-technoboy85@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 7 Apr 2023 01:15:12 +0200
Message-ID: <CANiq72n+bqNaJbsHEK+eu_W2_CGb_yGWu_Oc6K9pe524N1W03g@mail.gmail.com>
Subject: Re: [PATCH] rust: fix bindgen arguments
To:     technoboy85@gmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo,

On Thu, Mar 30, 2023 at 1:39=E2=80=AFAM <technoboy85@gmail.com> wrote:
>
> bindgen renamed some arguments to be more inclusive.
> Detect if bindgen uses the new syntax and use it,
> otherwise fallback to the previous one.

We will be updating to a new `bindgen` version soon-ish, at which time
I will perform the change from one to the other directly, instead of
having to handle both cases.

But thanks for this patch!

Cheers,
Miguel
