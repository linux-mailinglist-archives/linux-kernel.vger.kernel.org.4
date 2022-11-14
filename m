Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE76286FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiKNRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiKNRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:25:30 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB33FEC;
        Mon, 14 Nov 2022 09:25:29 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso8382523wmp.5;
        Mon, 14 Nov 2022 09:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk/31HBoHkJxXf6djtc/uU3Q17y+7Ai7L4MxYQ2v+II=;
        b=g8mZnZPo6BMZp/rO2sSmm7nno6qdY04agupGdzm1RfJnCQR1mOfnVEIzqTzlCCvGcc
         yDVZZHbTgr0gN0PygihzscJS53GmE/rcHshrFn49iCBIzZ5ahRLZzTKQu0VnTKBTRmJ4
         NT6i75a0Nv8uZkzOVUPu/sVGEuRcO6fvSRPMarnMbyAcjVPYprGcfjV9fKjQBLXdN0J7
         CGV/d39/uXFq9y/8TidkN9JKzGTNUJapBojGNMub8/vV0L1qwFfQPnbSzqRyUMmKRvl7
         5j+l9A2ifT8FSEteJCLIqC20SdhAuV5sqbTxAqHi/YyYzE6d2BSmJ2vX4OxhdSg1G2xd
         0xaw==
X-Gm-Message-State: ANoB5pmjFWRWof+sndrR0PRAB1d9xXA1orupo17xTu+AKoXZdxg3AFqn
        C5cMwWS+em7vyULZlPkCb28=
X-Google-Smtp-Source: AA0mqf5HMC/eh9L0x7KAEkhUl/NoLQhWWWi547gKmrlakHepkposHqlYkLyXePIcH39s31ZOffkfaA==
X-Received: by 2002:a05:600c:818:b0:3cf:54f4:eea with SMTP id k24-20020a05600c081800b003cf54f40eeamr8933017wmp.105.1668446728117;
        Mon, 14 Nov 2022 09:25:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b002368a6deaf8sm10265378wrb.57.2022.11.14.09.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:25:27 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:25:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 07/28] rust: macros: take string literals in `module!`
Message-ID: <Y3J6BetkCdIw7LbZ@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-8-ojeda@kernel.org>
 <Y3JU5xAGv3bNG7q2@liuwe-devbox-debian-v2>
 <CANiq72mE5=R4fv4Qee+hEkuXSHPjO3RzmOU45mqE3ztJ8XfS4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mE5=R4fv4Qee+hEkuXSHPjO3RzmOU45mqE3ztJ8XfS4A@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:46:05PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 14, 2022 at 3:47 PM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > What's the rationale behind allowing UTF-8? Why not stick with ASCII
> > only?
> 
> The reason is that there are already some cases on the C side.
> 
> For authors, there are about 158 non-ASCII in the kernel tree (if I
> grepped correctly), e.g.:
> 
>     MODULE_AUTHOR("漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>");
>     MODULE_AUTHOR("Martin Povišer <povik+lin@cutebit.org>");
>     MODULE_AUTHOR("Jérôme Pouiller <jerome.pouiller@silabs.com>");
>     MODULE_AUTHOR("Uwe Kleine-König <u.kleine-koenig@pengutronix.de>");
> 
> There are also a few descriptions too, e.g.:
> 
>     MODULE_DESCRIPTION("NAND flash driver for OLPC CAFÉ chip");
>     MODULE_DESCRIPTION("NHPoly1305 ε-almost-∆-universal hash function");

Okay. That's fair enough.

Thanks,
Wei.

> 
> Cheers,
> Miguel
