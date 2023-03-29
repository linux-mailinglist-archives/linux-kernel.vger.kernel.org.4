Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0E6CF66B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjC2WeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjC2WeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:03 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7E4C28;
        Wed, 29 Mar 2023 15:33:37 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5445009c26bso320880257b3.8;
        Wed, 29 Mar 2023 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680129211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6LTpXnaShPp/aMOnarhhdVl/37J/Widlt3z574l3DQ=;
        b=hDaZdrk41ASjkEzCvgtAYPEY93vGhSPpacpR5s/Iztg0al+4OR9WwyGQjxhSKHq7UO
         LzcKz4yfdWeaSB1y70SzSaGoDXpvTCY9d8st7Iwxx/nMcsvNqg6IzabV6eDouXNXfzad
         RuOtcr1o2yH+CieYYJhc1J4qsk6NKkwUxlpMccU+BTKG8HqgUvs0COGL18+HDOlY5r9X
         VzM6DiBkqh/bI8W37K1rHojR3GgmN6zNN9vQSzG6JZDkctQS9CeeRrkpxaQPMnl4qKy+
         DnebD7e5l++CV0kpc5EDL3X4pmKdBRmTKKbcDrE9qD+HA7TgOEMZD/xw+1Ctid4mAphM
         TU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680129211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6LTpXnaShPp/aMOnarhhdVl/37J/Widlt3z574l3DQ=;
        b=GNx/v8HyFz1JlHx0Ej1oVyjUsrRCb0x8BmmY544/dCSCZge34+BHvphEaHeBFUjc4v
         vFUPrieU/h52ii8+Kamwu1Qzmsk2JIa5TsSZZImG2ns3RISbhj7mJsoM6AYvj9yDZnyp
         8gFBL/AJdyWrTNAHruz1VnzZi0NN6veWo+GbKm+DSNcaOFPcFt+xvTfaQC6GezNeCBWD
         C7QnhIFgiCqfLW64/Xpl60dGzfv6p22EaxVIl1I8uIKK1zwqAiDbfQrjCNf/ojhKVjow
         +oc99KoLMptqxdj18utN1ByQ0Us4PcjWrXRj64FHXRh+MVzPgsFwv4qr5W495qUBgSAJ
         qwQw==
X-Gm-Message-State: AAQBX9dutHbUcRlBElOtvn2nJCWyQ/upERW0gJNyXutKrUWaEkkvnYq/
        SyBkJhGYK2poU5ORxlWkn8NtEkCIcCGB/yK8tj8=
X-Google-Smtp-Source: AKy350aXIUrzCs9LU5BXnUcMqWrHW+cLIALFyiDM1Dcp1H4b4wNsQcU8byHZ7G6UXIIDugN6++uSfCCMcUetOHypZH0=
X-Received: by 2002:a81:ac46:0:b0:533:8f19:4576 with SMTP id
 z6-20020a81ac46000000b005338f194576mr10246162ywj.0.1680129211333; Wed, 29 Mar
 2023 15:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-1-3900319812da@asahilina.net> <0849f870-2d95-8c3a-c7dc-2b18dcee4c65@gmail.com>
 <CANiq72ko9tY4dsK9Srte2oYQp8G=PMyLDTOR33-yNTVXmfyzeA@mail.gmail.com> <2a10a97f-70ba-5216-a527-067deda6a94e@gmail.com>
In-Reply-To: <2a10a97f-70ba-5216-a527-067deda6a94e@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 30 Mar 2023 00:33:20 +0200
Message-ID: <CANiq72n=B+OTU+gp6bVExvxhqFiuT=0A7y56AG6A4xSWXG22Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] rust: error: Rename to_kernel_errno() -> to_errno()
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
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

On Wed, Mar 29, 2023 at 8:16=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Ah, yes, they were supposed to have my email with it. I wasn't that
> livened up when I sent them.

No problem at all! And thanks for reviewing!

Cheers,
Miguel
