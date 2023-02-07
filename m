Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2E68E1D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBGU1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:27:41 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643F1F5D1;
        Tue,  7 Feb 2023 12:27:39 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p26so45643531ejx.13;
        Tue, 07 Feb 2023 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdt3r8F0nSwJUtUlnjS+OscQHvPRPPKG/eygJQ/b7P4=;
        b=lDRCVQVqITuizkFMENZplglVXc0Yrp+P61RobQiuR1vksbK8bAHO4a0w1h7ISVbKv3
         LGwRnr8tXOkWMLNUdIPB3rmNPExk7RN3fZYcvILINOIcCb2uY/9R86KBru9kIMKaybT4
         wR3gj7LO7AiUyJO3LMllLjLI2QJar6AKjYBabYFdq4PQWiqbFjGY/6OZqSb53k0qXUIn
         AoNlIGOLXDo5dSIZaO6y+lHrPer5evJTqKVC43mhcpTorohlMs9xioy8yaBWv3T/NJkG
         UjR2J7lXolby9bzugSe5O978mltKf9TdDJUjhZczy2EbRffyfQ9/EsNDQtyQT+s8hAJQ
         EJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pdt3r8F0nSwJUtUlnjS+OscQHvPRPPKG/eygJQ/b7P4=;
        b=p2Bnp9f0Q4Z0klbQgkd9HEoLt0mvJrikkBzucZAHP1Y2gXMxJnHtRk7eqrg8FbCwof
         xw42kZRP4TZuICLprDdd5Q0iR0t49PZTIThJAQFTKHRKa3JbiJzRFEARKAg6NRKVtGvN
         DiDs7rq1upTPIPHru+x3w9rQ60W0d3xfkNquX2peluB8ZjZH0YIZOvZE8aDps+lE+zq3
         7w9xNnPckTCgZGLjzlyJqKY200HqE0MOj0AWST9DcpvcNR3umX2c0qy7vNrI7rfkBw3N
         Wq44KxcmZjD/X60du6XXHFUYMx0hPsZjMF66cg+6V9NPgMq+wp6yV9H7LAe5SEpXN8tl
         OviQ==
X-Gm-Message-State: AO0yUKWHBiIF342xRyqiiZLJhm6aDCzXp8D01sgBeW0L7WMujAbSXy6h
        pxncKAgPihPlv6XCdMH3flE=
X-Google-Smtp-Source: AK7set/taA3xBa9SnogtEBJBflPUblm2ZUlhPWAZ9lM9iKHPhDJEaVjLS7VApSbP3At8rFIMZsPoEQ==
X-Received: by 2002:a17:906:6453:b0:884:4806:c39 with SMTP id l19-20020a170906645300b0088448060c39mr4546153ejn.11.1675801657927;
        Tue, 07 Feb 2023 12:27:37 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id qt17-20020a170906ecf100b0085fc3dec567sm7443202ejb.175.2023.02.07.12.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 12:27:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Feb 2023 20:27:35 +0000
Message-Id: <CQCM3WH323TM.19ARH3F75R3C7@vincent-arch>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        "Finn Behrens" <fin@nyantec.com>
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for
 {Unique,}Arc
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Carlos Bilbao" <carlos.bilbao@amd.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-2-boqun.feng@gmail.com>
 <718cd090-1a0b-d485-c595-f14ea1d41d9d@amd.com>
In-Reply-To: <718cd090-1a0b-d485-c595-f14ea1d41d9d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 7, 2023 at 7:03 PM UTC, Carlos Bilbao wrote:
> On 2/7/23 12:52, Boqun Feng wrote:
>
> > This allows printing the inner data of `Arc` and its friends if the
> > inner data implements `Display` or `Debug`. It's useful for logging and
> > debugging purpose.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
>
>
> s/Reviwed/Reviewed
Ops! this is my fautl! I will review the version 2.
