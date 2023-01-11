Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB3666698
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjAKW6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjAKW6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:58:32 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A82630;
        Wed, 11 Jan 2023 14:58:32 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C4FD35BF;
        Wed, 11 Jan 2023 22:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C4FD35BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673477911; bh=lJ6Sc4vHKnE+DK4kGng+1yRZw9B1pnC9tO9CfSOnakk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FNOiD6vIRWV/eTbylEkVLr8EcWuemugyS641onWEWIBoK1wS+3f6IPL11K2CgnTv8
         skpyAbf4+BgrMkX0WIJrx+0waHGjKuSVdS6zpjRUFLVjvcGBCl71vqeczJ1KBveuG8
         tDI9N5J3rFlgFeglVpjWbHwRbKQ0mTb6TzHLN2By1T4KTCYZyF1dGWIkxb42bhREXQ
         8qAvT4YA425I2EHGEEKrQPGX1b0kTGkJbl+UYuSV4DeQhAdsBP4QbLzwicUSujX0ux
         obmosfZ+VUP8sEoGvUYsiIfaesfbgUOA0SIHaKHwxsRaAqq7v6/F17gFm6112VcNcx
         TpaLKNOD7O1tQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fabio Fantoni <fantonifabio@tiscali.it>
Cc:     federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabio Fantoni <fantonifabio@tiscali.it>
Subject: Re: [PATCH] doc:it_IT: fix of 2 typos
In-Reply-To: <20230101155548.12350-1-fantonifabio@tiscali.it>
References: <20230101155548.12350-1-fantonifabio@tiscali.it>
Date:   Wed, 11 Jan 2023 15:58:31 -0700
Message-ID: <878ri8wueg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Fantoni <fantonifabio@tiscali.it> writes:

> Fix of 2 typos spotted reading documentation in italian
>
> Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>
> ---
>  .../translations/it_IT/process/maintainer-pgp-guide.rst         | 2 +-
>  Documentation/translations/it_IT/process/submitting-patches.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
