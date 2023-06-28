Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD774108E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjF1L4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:56:54 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35889 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbjF1L4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7B5D23200970;
        Wed, 28 Jun 2023 07:56:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 28 Jun 2023 07:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687953410; x=1688039810; bh=su
        OYyOOiYnPW3dgD5wOYsyC0d04znfjBtqYR9JY6ZOM=; b=C1HFR0IA6bdOZxp8bh
        vszM5qlHyAFTy6xxv3WH3NY52nBeGDujWxj5f06z6KNUX+LGBt3xtKXNUS+J9Erl
        ESmzNO/I6UXeZSq9ObLY8kyJYyD5e7umhpOONvcO2hVsBTUD+13+Qo1pJ+c5w033
        1XBcnior9c41oWLEzlQEsPa2FnM2IlPxqMWpNp5nFg0boQo9V3frFoqCDZp9sQmT
        EfGtzCqsbOWms9ZVuHhteLDC43CJoVflBjHYD10DNdjvydH2US7npWnX9EI0sOtN
        JfVkkrj/9+1Bo8TqnK9ewDw+kq1Ml+zJXusmurQWacpsuGJju9Io2TYGv0UrWBXB
        RzWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687953410; x=1688039810; bh=suOYyOOiYnPW3
        dgD5wOYsyC0d04znfjBtqYR9JY6ZOM=; b=qsT7CW5SM+d4idVsCoObIoZG3ecPj
        TfpqtxpD7bl4QpV3FisO4VBsdsm2G1krrD3bjMTFS9enTNfYmWdztyJOMWhrqJrk
        hQqvdsZ1k5ck5DPBkKY+iWGm5EEul3yIm/vnfWAcS6FDt8qPbT4zx8IUCvm/0uJn
        xIFsb1a0opOpjRVHOzziWsXdo1TSc768vV3jy/MFLhhmeRdNRhH8Mi0DXQeRu8n7
        26F1sXXnpybsyWc/LJTjy1Oud6pF2H+RkeCepU6v0RQCkoCH6lnpRGjQPLlpym0a
        +yxQqtgDlo103TJKvGhvnPx9XwAj8oUX5DoKPB6PTDIhueOc/6TFLu73w==
X-ME-Sender: <xms:ASCcZPmCEAbJO8DB-ZIj9lmhwbAFqAOeJ0FIzOktSIBypjbeYReLHA>
    <xme:ASCcZC2WNV5CdyjNtOFTRkO7RgANQuuTH0-ogG4V1_VpxTljQr89nBLZ1iq6ss8bE
    KWxcu6z9v20DfcAjYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ASCcZFq3mbB88WpLQ1LtYbzT66MZauWybBzPcsbHjxsm2kl31gzFYg>
    <xmx:ASCcZHlZCaQ5rmU3RGVcetcZfTTsvksygyF986zgo60F7yF3YJtWiw>
    <xmx:ASCcZN2SLeS5-siqCYSFJzqZMjKZGAOmgjrkRn4ZbO71B0Gch_0kfw>
    <xmx:AiCcZLA-0_Hwh4Acy0pngHgzuV0qL-eGf2WkcS4lP-kRL1Drl9s-bQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C4CE0B6008F; Wed, 28 Jun 2023 07:56:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <2a1220fc-777c-4611-9f75-3a8e07a04850@app.fastmail.com>
In-Reply-To: <20230628112958.45374-1-dg573847474@gmail.com>
References: <20230628112958.45374-1-dg573847474@gmail.com>
Date:   Wed, 28 Jun 2023 13:56:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Chengfeng Ye" <dg573847474@gmail.com>, scott.branden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023, at 13:29, Chengfeng Ye wrote:
> As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
> context, other process context code should disable irq or bottom-half
> before acquire the same lock, otherwise deadlock could happen if the
> timer preempt the execution while the lock is held in process context
> on the same CPU.
>
> Possible deadlock scenario
> bcm_vk_open()
>     -> bcm_vk_get_ctx()
>     -> spin_lock(&vk->ctx_lock)
> 	<timer iterrupt>
> 	-> bcm_vk_hb_poll()
> 	-> bcm_vk_blk_drv_access()
> 	-> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
>
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock, which reported the following
> warning when analyzing the linux kernel 6.4-rc7 release.

The timer function does not seem to be performance critical at all,
it might be nicer to just move it into process context using
a delayed workqueue instead of a timer.

     Arnd
