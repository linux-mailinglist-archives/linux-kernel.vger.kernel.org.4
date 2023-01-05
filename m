Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9082F65EFDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjAEPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjAEPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:20:14 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034EF012
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:19:28 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4b6255ce5baso76263047b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Suhmqgu21wfHApsykkJ0Rj+pzQZlrFeJmSf3lLSlcdA=;
        b=AHtQuubGg4Ezke366hx9y69ajjdkSgDGkl6yCaSi5Pc1os0Ht4r1OKQ/3oGBSHTKOs
         vPDwP6ncE/EgJMb/w462zIW8nsZSS1CPbw8CApxm5psig+ahV7eDyL8pgzTV12sMgeS/
         591eZcs3or5fXX5Gss6i9V781Il/50o14pkUh/Ve1j7kS4yW2P9h70UUbRYKCxsyzl5R
         O1VzfwcVZ7ZGEE4jsfkK0ekZW7gdHt9iYHrv3hi44NsAKYmDEtqCwXfjQcgQDjr2xAI5
         NzOHp0w3HvcrC3yZxq0UAeukb20dyU4OUorBXsWZ6wqu+3cqiluIwLWfKRzDumMYXAKU
         ZTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Suhmqgu21wfHApsykkJ0Rj+pzQZlrFeJmSf3lLSlcdA=;
        b=CztjTTsV9DNuLZXZfOxwoJPRmn5Ha3y+CIuUFS81JqvjHEPYPN+X38QF1Cb/yg4tV7
         cg/W48Dq0Y8WNsYP+fEcvt1yuVc7c9XebA2ugW2Izq5xMqFTrIVvecVpLwjurFUkgtir
         ieqNelvKZzaO1mT4JGgZToQop0NdzjWzNoB7y0slxQ2f8Al1XAmPue4WOdyirl6mIhGq
         BnOOKRhzOgq+DVf/VUmGXJxIegavyd7+gb1yUlQkPkLTImAp9n5gKviMDtIV8DAMJ0Sf
         8ylG9Bi4ekloAVXsYbY4LPZsj0HYDq0fxldGvwfkHaCkzEW90Bqpj1Ct8m4tVb+ZuUcg
         irVA==
X-Gm-Message-State: AFqh2krj+a0ojpF7GoOGjRb2hrY9sdjsZL/hHBGir1C7XdHxDRvvhq54
        d8xWl/8O6FU2Ox1r7oVlK1DNGQvd0UhPSNF27j7FX0yjyJI/Jg==
X-Google-Smtp-Source: AMrXdXtIk4tZvLRwKu/thAPdpITXaAoOTIYzclWssY5YILZIN1rG5n7pRwxw5feOXPHIe5GXtSufzpWmG1H881QmsAc=
X-Received: by 2002:a0d:ea8d:0:b0:3cc:5892:fd07 with SMTP id
 t135-20020a0dea8d000000b003cc5892fd07mr5894828ywe.420.1672931967832; Thu, 05
 Jan 2023 07:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20230103164359.24347-1-ysionneau@kalray.eu> <20230103164359.24347-21-ysionneau@kalray.eu>
 <daaf8c33-a981-25c5-2b23-38c59fd20ae2@siemens.com>
In-Reply-To: <daaf8c33-a981-25c5-2b23-38c59fd20ae2@siemens.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Thu, 5 Jan 2023 18:19:16 +0300
Message-ID: <CANXV_XznREmhh-6m_QPqc9up5x4Kd8EU70jg7TdXD1PuLmAhiw@mail.gmail.com>
Subject: Re: [RFC PATCH 20/25] kvx: gdb: add kvx related gdb helpers
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>
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

On 03.01.23 17:43, Yann Sionneau wrote:
> * lx-kvx-virt-to-phys

I think it might be a good idea to implement lx-kvx-virt-to-phys as
the translate-vm command for the kvx arch. The details of the page
walk used for translation of a particular address and page's
attributes values might be useful for debugging purposes.

On 03.01.23 17:43, Yann Sionneau wrote:
> * lx-kvx-page-table-walk

It seems to be a good candidate to be implemented as an
arch-independent command.
