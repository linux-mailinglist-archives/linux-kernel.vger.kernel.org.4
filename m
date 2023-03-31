Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04EC6D2122
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjCaNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjCaNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:06:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49BC1A943
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:06:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5D05032001C6;
        Fri, 31 Mar 2023 09:06:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 09:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680267980; x=1680354380; bh=9O
        1JcQqo20yKPuqiCknMEqxH4gwPXCjxEftI6MqW5Ig=; b=Wkjq1ts2PuYyGvPCuU
        qe8XVRnLk9kKiHW7MdhMi2tDXqFGs1ZENmEtTY6Ah8nXVv9UjbKlOOj95UJfT0sA
        AXhDGYXn44rBNr0F/J5kFsbXom1YgSh5YXPXZVX9GiUiIYtnwezYq2XtRzCdZz+G
        Djkps6hlgGmKfZ6FypoJo9U/YYaf84WCH/gZmiBq2pV5Agx/COJu33uV+A1UQIFI
        9UF0cTfL0d0FhVErs5OrAfmX5Wwi9c6jhb4bJk3MfaRGE9uswSQJnG4Vzl2zDfPw
        NqdB2W/LCcytb0vROHg7Ysh0OZitTQsMU+hQ3RqBQkUT6gzXnD9fOq/IKs3dVVI9
        NQSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680267980; x=1680354380; bh=9O1JcQqo20yKP
        uqiCknMEqxH4gwPXCjxEftI6MqW5Ig=; b=NgP7H3Gd1fAlbQkd/IOmeCNsyr4fW
        Ob2rB25HJzErPhwU6X9pr28Az5eeU7ofaHI2rcXWeIS6Fz1aSLXOxAD1I4YteyW4
        U61ZZnwSv3zGUB8IglSHJX1hhaty+4g7kG80+MIlPLHGkm349kevViVxQhi9cpvP
        9M5W7O7TGHWfjdc74mnL4ls0APjLucV8spS+CKV5cLZNCtKTM+YS6/Cf4nqr82AU
        BcAbUTEsdeA8TYWCROoh/ufN9NV5cHQfRHUexEkzuxvWddLY7m9xPUM7KRUvNiG3
        eadDiV4IQdUp5Q+7lgIN4l4LEj98C4E5L3XA8L4bCs7r9K50VYzocty/Q==
X-ME-Sender: <xms:zNomZAEOMcPhXAvJk9hb3xhnez_CGkrtjfvHGMH5H_ktLUOmclhsMQ>
    <xme:zNomZJX4WT1Jphdx3C_H4eBJuwZpFsjrtzHesP8n0LJeS8r2IayjKzfXfY2_shfrh
    TrIZlUSv_jeD1shpYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zNomZKINYUsVHvHzMyVj6dXy2B1lqppBnVK6qZLIVovTofP8NGnsAw>
    <xmx:zNomZCHGzZw1yJP2PZ0li4rlThn_ZbdNdsRqYsUm4iVn9KFHAOicQw>
    <xmx:zNomZGXGTiQxE5ByNp_12jS7yNaZSlIKLRPfbBDKI-tkesjiDN1-cA>
    <xmx:zNomZPd8sb12vS-K8osmUiLab6zm6kGyBUpLzTxYHw7G5nEO7gf4sA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BBCF5B6008D; Fri, 31 Mar 2023 09:06:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <900066e4-fd5c-4645-bf04-9c27561516a9@app.fastmail.com>
In-Reply-To: <CAMZdPi8ZMfLTHaEn2LbXvuen=Rb68KrWJmgbq9Miou_RDi=Btg@mail.gmail.com>
References: <20230320152319.665592-1-loic.poulain@linaro.org>
 <20230330114242.GC434339@google.com>
 <242a5400-b5e6-4707-af88-1d695e114f78@app.fastmail.com>
 <CAMZdPi8ZMfLTHaEn2LbXvuen=Rb68KrWJmgbq9Miou_RDi=Btg@mail.gmail.com>
Date:   Fri, 31 Mar 2023 15:06:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Loic Poulain" <loic.poulain@linaro.org>
Cc:     "Lee Jones" <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Use of_io_request_and_map() for IO mapping
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, at 15:22, Loic Poulain wrote:
> On Thu, 30 Mar 2023 at 14:45, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Mar 30, 2023, at 13:42, Lee Jones wrote:
>> > On Mon, 20 Mar 2023, Loic Poulain wrote:
>>
>> Thanks for pinging me. I would indeed expect this to cause
>> problems, as syscon mappings are likely to be used in a way
>> that is not entirely clean, with other devices defining
>> overlapping ranges.
>
> Isn't syscon exactly here to address that collision/overlapping issue?
> From a syscon perspective, it seems to be handled correctly at least
> since the mapping is only setup once, with the first user device (in
> syscon_node_to_regmap). Or are you thinking about non syscon devices
> overlapping the syscon area?

I meant them overlapping with other devices. Ideally this should
not exist, but most likely we have to deal with dtb files where
some other device does overlap with a syscon.

     Arnd
