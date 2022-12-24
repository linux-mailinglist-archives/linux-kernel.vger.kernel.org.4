Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFEF655AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiLXP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:58:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB9DF38;
        Sat, 24 Dec 2022 07:58:26 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2FD41EC04F0;
        Sat, 24 Dec 2022 16:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671897505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH1CwpCRTc9lLm3gQNAiJm2XrM1hMo0obr08FMOdHs8=;
        b=DoFb3++m/bWjXCZbPJtZD/ca+AelGVDqpqG92XaS7lG6t46BQB8tsvMxTMGPG7GoNEvOMN
        8tXD6hIfPmD0VppVnwLt3tYN+h5BmR30aqOD2+QJZHHz1KLAArNOcOmJBPnQTV6K5S3TSz
        ogdlkuV8odiaiF0gyn0lZlp8YOC+UjU=
Date:   Sat, 24 Dec 2022 16:58:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <Y6chm9khdG4pmNhN@zn.tnic>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221224154842.o4ngrwmskduowttm@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 04:48:42PM +0100, Pali Rohár wrote:
> Do you think that it is fully illogical to never inform and ignore
> userspace projects which are under active maintenance and are using
> kernel APIs and kernel drivers which somebody decided to remove?

How is one supposed to find those userspace projects?

Lemme repeat my question: is there a logic/rule somewhere which says to
inform *you* when this driver gets removed?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
