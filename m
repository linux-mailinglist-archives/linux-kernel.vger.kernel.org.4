Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08676A5CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjB1QMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1QML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:12:11 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A230EB5;
        Tue, 28 Feb 2023 08:12:05 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C9DA1103;
        Tue, 28 Feb 2023 17:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1677600722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMyAtlujt0L0cMyshMqhEj9CXvje1bkovuz0G81iQOo=;
        b=hnBro2ddPp3iX8s3YpHLRnOwSChsDYQdEVGzdvh9UtzmWfPdJOQaLj3TUzR9kJg+52oH9V
        WyvASHJZ06L+S0Im0PGabf5nlzwGc57EFZdwXyGwW557annuzH/HkAJX/SgkJvXz6rw0/2
        04/r7mj511krIS/KN9/rXF3/Xf2b+jVEMTbah0aC87xnFOHoicoqL0fSh8hcQXEorxQmXt
        nE9Qc8krBcZyAXoNfcilvZvq+Ob5eIqXK/XG1a96d+NB9k5y2SUB3Disg6EpMI0gGQn03p
        GrKqDO0l3ysY7tPAN5ToRsQ+P4Nu4CV/zEss/kxAMsb5fW0PnPuuoBBEwq9k9w==
MIME-Version: 1.0
Date:   Tue, 28 Feb 2023 17:12:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 16/20] irqchip/irq-sl28cpld: remove MODULE_LICENSE in
 non-modules
In-Reply-To: <20230228130215.289081-17-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
 <20230228130215.289081-17-nick.alcock@oracle.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e90b7152f0e5c819be8baf8af7874e3f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-02-28 14:02, schrieb Nick Alcock:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Michael Walle <michael@walle.cc>
