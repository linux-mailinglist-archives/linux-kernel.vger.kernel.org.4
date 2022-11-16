Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF162B3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiKPHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiKPHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:05:27 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566BFDFC4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:05:23 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3EC7314C1;
        Wed, 16 Nov 2022 08:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668582321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ACw+MD/B1TA8RX2XQBckEQj0id2BHcGOPvN40A1EfY=;
        b=buyiwPsKCGznSrN5dwTAoWBxVK6TWOatfNP8UUhuBmeLF0APaC8AwqLVz6JOqqggAsKI0Z
        e/87WKk5d4Y890wFHF0yxFJq0BqKzx/76W4kmBLngIaJZTAikQ91YmDbC6nrOvS0VsgJev
        Rn7f4Ndxcgp5gaRoaYYwLYIDdGhcenaad9xV2cXXETvJvu2Sjmm5ecF3iZnDJ9/h+Ydhfg
        JUUSNrhjLHO4h8VxCc1w4e7keAkX5LqnZivISnRat9JQjUf2V+FA/uEWBD9xBlRV+WuTSK
        yHDZpp6+Mxwgf+Ta8X9SUwTtIESNq2PuTTPUD9UCx6rqze7PzZUPLkhDxrDvnA==
MIME-Version: 1.0
Date:   Wed, 16 Nov 2022 08:05:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: sl28cpld: Replace irqchip mask_invert with
 unmask_base
In-Reply-To: <20221112152701.41990-1-aidanmacdonald.0x0@gmail.com>
References: <20221112152701.41990-1-aidanmacdonald.0x0@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b7a66606addbc38a0c356a56ce4c37ff@walle.cc>
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

Am 2022-11-12 16:27, schrieb Aidan MacDonald:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
