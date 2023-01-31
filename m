Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B7682189
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjAaBux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjAaBuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:50:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7376827D51;
        Mon, 30 Jan 2023 17:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC04B818EB;
        Tue, 31 Jan 2023 01:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E63C433D2;
        Tue, 31 Jan 2023 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675129848;
        bh=HJKQNx3fRNZxY4vArUZ3gyzU1g+TgmgDu91AsEma7fU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=BYCJ3rqx9l7r6aU/XtyjH1qX9OpzR8tcJVNxwc/TYKyMS7wdPP6rOhvQbL0Tl/3le
         YnMgP9YUsQ231YFBzcnAU/mgH8senEXopHLHvGYi+ewk6ULldHRWqiwdPj0ofNJlct
         b2fEZoj42/q4gxGMInOT7C3CPP9OwfaB7EQaMhprQQtE8nlBCQnfQx6ktgatduEq1V
         khk04yxPBLZbCbRqa+MflBwxYYo0I9nOWoRTla9EkS4iAKTEN7ayj2tvuHLYPxDmz5
         HPJZ00oWHobw4bIvIdijoK1JRALjF98zN8Fpp/U6i/hyXZqXQLrsU5P/Tqpq4xo9Yr
         tO1WSsJOC0lPg==
Received: by mail-oi1-f173.google.com with SMTP id s17so741869ois.10;
        Mon, 30 Jan 2023 17:50:48 -0800 (PST)
X-Gm-Message-State: AO0yUKWsGHcdSRXGWLV8hUobe5obNV8hjOz1tYQQReUTOoR5ATY3rQB2
        ArgPh20PK+D8kl6sLwjNhtwsugGEBNnCLMNGdT0=
X-Google-Smtp-Source: AK7set/9JPR6cjJv9xRhT55XiUVtS1vUYh0zXL9sqR/YYWtSHfzMq6iNEDp3sn11Va8aKXFqLrKFxxmnv6MWnYBfxDs=
X-Received: by 2002:a05:6808:1402:b0:378:57fb:de1f with SMTP id
 w2-20020a056808140200b0037857fbde1fmr307671oiv.215.1675129847919; Mon, 30 Jan
 2023 17:50:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Mon, 30 Jan 2023
 17:50:47 -0800 (PST)
In-Reply-To: <CAH2r5msGoRGzKbjFUJQ9HBivb0ia8-bakeVzeDknEmCQd5yd-A@mail.gmail.com>
References: <CAH2r5msGoRGzKbjFUJQ9HBivb0ia8-bakeVzeDknEmCQd5yd-A@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 31 Jan 2023 10:50:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8FuOVZhfbJoQejEvSa0SmnMix15LqLwNrVwdcP-ZMgTg@mail.gmail.com>
Message-ID: <CAKYAXd8FuOVZhfbJoQejEvSa0SmnMix15LqLwNrVwdcP-ZMgTg@mail.gmail.com>
Subject: Re: [PATCH] cifs: update Kconfig description
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-01-31 10:12 GMT+09:00, Steve French <smfrench@gmail.com>:
> There were various outdated or missing things in fs/cifs/Kconfig
> e.g. mention of support for insecure NTLM which has been removed,
> and lack of mention of some important features. This also shortens
> it slightly, and fixes some confusing text (e.g. the SMB1 POSIX
> extensions option).  See attached.
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
>
> --
> Thanks,
>
> Steve
>
