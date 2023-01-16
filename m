Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0966D2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjAPXON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjAPXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:13:32 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90402FCC2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:25 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id cm26-20020a056830651a00b00684e5c0108dso3180297otb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.cerritos.edu; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ+ODOt4MS4tcK6gq4peoEBqRUoVFWADJV2EWJ+gklg=;
        b=lcQbHx3YBxGmVPnRdajnHbFVLPMBzjP/BP3hXR5Phgqn6X8f40b2nSYKVAGN7xGxjp
         LDBfVJ5HO8x5crozzrSR4VE8AL/wDfSiYq/JFOLS9fmbBNTxgK9IadWPptuG3vp7C1c+
         9p+yFlbuHnA2lQxelaaT48ZAOJyT/7kYoRURg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ+ODOt4MS4tcK6gq4peoEBqRUoVFWADJV2EWJ+gklg=;
        b=m9IqXHPoID4Q09+kDxKsOBtcmQuub0n2G9hFVHGoLVU9xCrBX4cKZGf0dlaPFBMqmE
         4KHqpLrOrv1LSxUt4c80BUyC+clfEwpYmJeBoc7J2U/asCeLSxn2CENciiRY0k3LNecG
         Y8wYRhYVnPDRW3wd76mjmMo0ANfxmf3xltU191EXIDoxPXCxU5iwfX3t77WLzHZkriGt
         oeE+9kbfl4WAetqLsSnSKVaonuBFb4bnapcRdcJ6d/hjE71TgHXE1+S44U/+CXes1LAR
         DJ7AtZD2bocc5C8sUcQ4Q8l5tnyGh7UJA99peuS7h69YXKMHOm/uvzb7c2NxRjAcRGg2
         GB8g==
X-Gm-Message-State: AFqh2kpRLOO7CHlu0uqpfINuDF2rDjH5psNjIuIw25ub0Flon8HclmSr
        GutCDN5INLiJTUilGTtCQ+qLxNLMz092oGBdHtpNJge/U8cVqmtr
X-Google-Smtp-Source: AMrXdXv9zDSZmw7fkNM/HX3BuLc05P3IcJflL86clF0YIVuagxEJ4Zv2D9qAlCexs2yQzxU46eocZLuZgaKOXDrXVu0=
X-Received: by 2002:a05:6830:1be6:b0:66c:68e5:84c5 with SMTP id
 k6-20020a0568301be600b0066c68e584c5mr42365otb.321.1673910624848; Mon, 16 Jan
 2023 15:10:24 -0800 (PST)
MIME-Version: 1.0
References: <CAPOgqxFva=tOuh1UitCSN38+28q3BNXKq19rEsVNPRzRqKqZ+g@mail.gmail.com>
 <20230116195357.2jq7q262tongxw52@t-8ch.de>
In-Reply-To: <20230116195357.2jq7q262tongxw52@t-8ch.de>
From:   Amy Parker <apark0006@student.cerritos.edu>
Date:   Mon, 16 Jan 2023 15:10:25 -0800
Message-ID: <CAPOgqxFtH4Ezb1xVm3kOLBnOnQfpbs4==Kpefhaxz4JhOObqOA@mail.gmail.com>
Subject: Re: Kernel builds now failing
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:54 AM Thomas Wei=C3=9Fschuh <linux@weissschuh.ne=
t> wrote:
> I expect this to be due to a change in make 4.4 that ignores SIGPIPEs [0]=
.
> So programs called from make will not receive a SIGPIPE when writing to
> a closed pipe but instead an EPIPE write error.
> `find` does not seem to handle this.

Thank you so much for the clarification! I've also seen reports of
other tools not handling it (such as `yes').

>
> This behavior in make is new and I can't find a reasoning for it.
> It also breaks other softwares builds.

Are you aware of active discussion regarding this on Savannah, or
should I go and report the effects there?

> For now you can disable CONFIG_IKHEADERS and the build should work
> again.

Alright, thanks. Did that, and re-ran my kernel build (allmodconfig).
All works now.

> [0] make 4.4 was packaged for ArchLinux on 5th of January, so it would
> fit the timeline.

Yep, running Make 4.4.
