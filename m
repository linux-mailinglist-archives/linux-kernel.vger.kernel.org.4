Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BFB6DC74F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDJNg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:36:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733E4EF2;
        Mon, 10 Apr 2023 06:36:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 99A0A5C00E1;
        Mon, 10 Apr 2023 09:36:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 10 Apr 2023 09:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681133780; x=1681220180; bh=Hc
        /zM6us12owjQAwpTXjH6fFrHxn+l06I2QCZ7puQjY=; b=ih5xW5HVZfx0inArLx
        gJQkJ13yTugobR+WROEywTumHayolrlDRYJKjropWd3y0tLePPVN7V3f3fX+lSal
        NnIdAjYw0Zg/Ggl6wewFyBgw6eUjRVs0ZvbJc8n68Pga2vkFGrW8HJWer0nYonMc
        /HwgYKt+uODdl1mkGyCxb/Fk8SvETH/EoN8VIhwQhwRHmLr3ZTpvYpARNIOUCdWQ
        F6qi0w3sY6Gl+gCzRpMpymNtR2h+8pDwzGNyhLN06BRnd3eN3FOf3+THuk4JRyMk
        VmP/COMlDl7e3SHa+6FWq+bt7O5SCdZLuOiRtdvNQDJQQpqlYtjQ8NPY6eaxgH+N
        3vGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1681133780; x=1681220180; bh=Hc/zM6us12owj
        QAwpTXjH6fFrHxn+l06I2QCZ7puQjY=; b=VY3fCXC65WhFf5bteDH8gYKFF1ayu
        NGWJja8KgJW3dImeDFBrR7E7m5p95VnDNHXCoiU+6R+Tp5H3cWPKL105TkwoF1CY
        1NaGrZB0VcDk036R9aYkysxITDncwWV9IQrVjLUo4G1JcXOYxnTpUX/onfXIC7bV
        9EKqk8nErZhIkplSwqYBdW1eCeYGbDljSlXfideJglsK+rtegZyi2UImKM9nTP1v
        is92FYJxT6xg/JkUWv8746i7bSqrOD56ZzPaPPPtWRMN81v4HlWzMlgedeBnnK9d
        VWrDkXToaywBdyx6KbLVYwW4kkyh7XSrKgimrbLjnGFm9ARJZkED1bj3A==
X-ME-Sender: <xms:1BA0ZNa51HxaUNXasLhbIvo-R3FBAzbJBXStorJvUVRjultDkVrntQ>
    <xme:1BA0ZEaAx3IDtWzbc0-YVyEEetvpmVEjHUjijBZDS1nizmhafiimYv8IPrTrWDmM0
    -qXCzT5_F4mWfqBXvE>
X-ME-Received: <xmr:1BA0ZP_ZGAjG8osL1hk2sraMVAFpVfKYOeOBUGgk_w1asrcVFYy-ZgmYtrLwrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:1BA0ZLpXZyQCW5q4spEkOQYz6jcBGa3Xz0i8cKDgFdLO6qgXedFXmQ>
    <xmx:1BA0ZIo6jcA_hf407eeluHwset_GZlOq4yIhVavNDNU-YsYHCBGdMQ>
    <xmx:1BA0ZBSF2ALMnkv-giKnNhNVyNW0Go67hgCVldClyfKWYmiNcG3AAQ>
    <xmx:1BA0ZDX5HGZXK4eSuEzBf2jjs5ct8928lPxS4WAkpcD_SwISI3fi5w>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 09:36:18 -0400 (EDT)
Date:   Mon, 10 Apr 2023 07:36:16 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Per-process flag set via prctl() to deny module loading?
Message-ID: <ZDQQ0B35NcYwQMyy@tycho.pizza>
References: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 01:06:00PM +0300, Topi Miettinen wrote:
> I'd propose to add a per-process flag to irrevocably deny any loading of
> kernel modules for the process and its children. The flag could be set (but
> not unset) via prctl() and for unprivileged processes, only when
> NoNewPrivileges is also set. This would be similar to CAP_SYS_MODULE, but
> unlike capabilities, there would be no issues with namespaces since the flag
> isn't namespaced.
> 
> The implementation should be very simple.
> 
> Preferably the flag, when configured, would be set by systemd, Firejail and
> maybe also container managers. The expectation would be that the permission
> to load modules would be retained only by udev and where SUID needs to be
> allowed (NoNewPrivileges unset).

You can do something like this today via STATIC_USERMODEHELPER without
the need for kernel patches. It is a bit heavyweight for a
general-purpose system though.

Tycho
