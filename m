Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBAD62354C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKIVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKIVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:00:55 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00930F78;
        Wed,  9 Nov 2022 12:59:31 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9C053735;
        Wed,  9 Nov 2022 20:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9C053735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668027571; bh=hoB/n5Y+UJ+AWFbI6oAkTagIGsPeSuHx16WFyuj7V4s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DC4rAh/4/pUCFgAGKmaXa+Wwk1K2ucK2kG3/xjKPLeUxP+GqMmeBahxqH5iz3imOx
         MfkhuexTWLTZOEE1JUCOyfpHqi6IUFZ4RcHq85i+mN9FoCQS+3a6MI+SXZyoC9/Zsj
         Vih30P6RY2lLPDzF56EXkbNuMEW4ki/rA2oXL5tSVFL1JIEhZ8996IeiHJAX/cZvLd
         k4aTFv8v2Rz/Wc52Hf6uQWu5P1ctCtY1/xYxPlqtLmIwJ/PplQyah3PndgFMp11S6h
         dmO1nIhx+PqRtcx/wIaWKIFFIgVqN5dfYHqDuxhZfM3LAMf8G1YxHwl+VaHW4DHU2r
         5pN8204AC8UBA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] debugfs: small Documentation cleaning
In-Reply-To: <20221104003835.29472-1-rdunlap@infradead.org>
References: <20221104003835.29472-1-rdunlap@infradead.org>
Date:   Wed, 09 Nov 2022 13:59:31 -0700
Message-ID: <87y1sjj13g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Fix punctuation in a parenthetical phrase.
> Add 2 article adjectives and change one from "an" to "a".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  Documentation/filesystems/debugfs.rst |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
