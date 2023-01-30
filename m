Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9451B68177E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjA3RVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbjA3RVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:21:34 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151340BDD;
        Mon, 30 Jan 2023 09:21:32 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id x4so14939203ybp.1;
        Mon, 30 Jan 2023 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pvdRVAjZEizr7aPmLWgfZD7eFme7nU37G9R8b4oPGLs=;
        b=M7lx3PQUAlT1VdeEkY0TlHwtIJc24Ezdz+vnV2ki2WwtjSuj1F7BP222dTAqsTiD/U
         4uJefQq6vxTrFimecjOgb5JYvf+buAC/7MwPywoaNVx7Ly+KUcpH5gRd8e1c0w9/8x5V
         ks6QdPIOOW2yQG1UT6lz0S3ypDmA+Fsfu3HBI1I/p81SOZlwmceLVnWBSjteDToEkPl6
         ZmAKuqe6K4if6gXG8MfQL4TAoejhPNXjvAIq032oTSwfDXingz73SeFveUdHD/UM91zt
         2/S0kTXY9TyvnR65GE2tcuMQQpuci30qBcpl2cu7L9bay5ToUQrG25//t/gpnDqAzscK
         MShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvdRVAjZEizr7aPmLWgfZD7eFme7nU37G9R8b4oPGLs=;
        b=j4GzQ8sek9iY2cKlqQwwRPVrZBkr1krmEiC7Oa0RrMLCe725+ubc/8u88ejUvtf5yk
         rP3HK4RI739jlQU6zrdxVFDpftBryNECoEyyBpUkHuNwsda6GUS82SdBOPqsDzDeNikc
         kgcotLQ9UMv65OcLOuIyi9t1tljVXpz818XMk89ScQMSJnNIW7pryan6KX3q4doGVdKX
         YoziHMOJt/fLeCNz3vpxVrKoHBTnrXo9sEsYwtLFsyWH4XSR7A0xQMS4xxWwkm6mW8d4
         S4mSpWdq1rseVET3UMEZK+HnymzfdadFYK/NHRVY0BJ1cK7iNONqoaVxPvZu1L0pk6Hj
         IsTw==
X-Gm-Message-State: AO0yUKWb1gddaNYZpOXv5GQ8w1M+T5VzUj7twgsyn6E3k8Zqce9Lc07G
        Y318SaDsBwsiVanBZVVFdS5Mtu0R7qTZXqXod9dWXHRgc6e10Q==
X-Google-Smtp-Source: AK7set9WH/i+D5qIE0eLHBunL4gN+76M7Ab8ttc6rXQLZenJqkgm25cjGRJloIeg7I1Viisu3Q4e1cKTg4Uh7rBvhGA=
X-Received: by 2002:a25:f810:0:b0:80b:e64e:2196 with SMTP id
 u16-20020a25f810000000b0080be64e2196mr1985390ybd.328.1675099291253; Mon, 30
 Jan 2023 09:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-4-wedsonaf@gmail.com>
 <20230127140319.22af6060.gary@garyguo.net> <CANiq72kXNvQ-GY-uw24s_1NmQ5G12Cu+JfYKFQ0rC-4Fnm8o8Q@mail.gmail.com>
 <CQ3S1YW1TFJ0.KGRDY0XZGSL4@vincent>
In-Reply-To: <CQ3S1YW1TFJ0.KGRDY0XZGSL4@vincent>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 30 Jan 2023 18:21:20 +0100
Message-ID: <CANiq72mk6sdZgz1sXH8f4_uyvyy4KPdE4amK8LPt6DYXTLw6_g@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the unit type
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 12:13 PM Vincenzo Palazzo
<vincenzopalazzodev@gmail.com> wrote:
>
> From what I remember the feeling was positing into hace `strict_provenance`
>
> Here is the last meeting  that was back in August
> https://rust-lang.zulipchat.com/#narrow/stream/213817-t-lang/topic/Stabilizing.20strict.20provenance.20APIs.3F

Thanks Vincent! Yeah, as far as I understand Gary was in that meeting
(in October).

If there has not been anything after that, then I guess it is still
the case that provenance will probably happen (for better or worse,
depending on the perspective :) and that a subset of the APIs may get
stabilized first.

Cheers,
Miguel
