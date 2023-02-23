Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B893B6A03B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjBWIUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjBWIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:20:51 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C52332E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:20:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CB6AC5C0108;
        Thu, 23 Feb 2023 03:20:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Feb 2023 03:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677140449; x=1677226849; bh=02AbWLrrCN
        pDShXJ5QA4VOqofZs/r/twV5gBaABxXE8=; b=FOuQ7aDnBB05Q+RrO9L2puGpfE
        X+HhFepduCiDOrWL7CUkSMd3GisDCAyLdDBfjUFXUcAp6pObXp+kKCv2DHUVPOD0
        fAy7w2UZVjmMukGKXrwrdtlOUYqpHoI3SN8Lx49PkbA1i/vuh16c7Nj8CPPW5X21
        OASPZZVzeBA4ti9FKd5Y4thmP0d4hJZqttGbwsMXVMRi/y96yUSihHrQX4Pw3RrV
        WyzCwvKhq1U7JJGf9hPJJ4Ldp0vcUN5J8aXHvQCm76VaG/9KacAUfSMQxD+AEmTd
        bwT2d93sq0akgrHgWdzCrLG9N3heBwXJJQ4+zfjLm/+sNJ5i+Gkxy16k950Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677140449; x=1677226849; bh=02AbWLrrCNpDShXJ5QA4VOqofZs/
        r/twV5gBaABxXE8=; b=ptbk2MLW1gbHAxExty2xlv1Pm/vb/QrqYH29NnG2axP0
        shr3h4pWv3WYhN8d8/CSjPLl7yRsv/RSN5c3pI9tbmbz7WUDsCFu8bNQy1kDcm+S
        ADKZyquNhz7OFLqsv+j9Js0QC4g4c3Wle+rGl3d40KPLJcsGPV7UyBpq5KE0573N
        RfDcyS8yrnH7uvqICnR77S5bMNP8MWiQBzgoEmjW036C2vk6nEYAsiU8SPIkyruI
        cgO28Xt/4kbs8cKkPOFkkxRBabhBx86+7QENPaLIY6EDDoVo1BU618u54GKL8x+d
        DEdgdRk6e5wdJ1NGbqiGi27vulbInqJJea3FZATzVQ==
X-ME-Sender: <xms:4SH3YyjTxvClqvt2VC2fcYSlDPEIRsB8DvsYCjvvnMhFTR50rSZFWw>
    <xme:4SH3YzD0M8cgU6AsDsaCKW5FjvDNaoxTcWAGOTKV7rTe_Nych68jIOrghibqDjUEh
    a6Zsx_8nPJBgFDiRFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudektddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4SH3Y6FwIjIvxu2V3Od38-3ATYpEcdq3rO_TgfQQpkhdGGEixv211w>
    <xmx:4SH3Y7QGKgExZBmjWlmxIgneN3C4jQ2rNOCaQ-PgM1bb79cmvbNKyg>
    <xmx:4SH3Y_xWHsO8NQevCUvRQyHYQQFzICET0FZVyB63_cKLtVUllLv-4g>
    <xmx:4SH3Y_9IPTg6XqmBKWMOk5vJqeFF_TbxmVdQFBnRkLXv-RzKYEMWrQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79AF2B60086; Thu, 23 Feb 2023 03:20:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <86e99adb-eccd-4c78-8128-b3690aa559c9@app.fastmail.com>
In-Reply-To: <20230222085013.32331-1-jirislaby@kernel.org>
References: <20230222085013.32331-1-jirislaby@kernel.org>
Date:   Thu, 23 Feb 2023 09:20:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, "Jiri Kosina" <jikos@kernel.org>,
        "David Sterba" <dsterba@suse.com>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/2] tty: ipwireless: move Kconfig entry to tty
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, at 09:50, Jiri Slaby (SUSE) wrote:
> The ipwireless' Kconfig entry is currently sitting in char/pcmcia. But
> the driver is in tty/. So move the entry to tty/ too.
>
> First, it makes sense to have the entry along the driver. Second, whole
> char/pcmcia is about to pass away.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This is clearly correct

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

In Dominik's list from
https://lore.kernel.org/all/Y07d7rMvd5++85BJ@owl.dominikbrodowski.net/

he had listed this driver as 'some activity in 2021', but all I can
find are treewide cleanups (mostly from you) after some work by David
in 2008 and Dominik's own PCMCIA rework in 2010. My guess is that
most likely this driver can be removed entirely, but you and David
are the ones who know if there are still users.

     Arnd
