Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8524A5FA3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJJSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJJSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:54:55 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5CE14003;
        Mon, 10 Oct 2022 11:54:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 690762D5;
        Mon, 10 Oct 2022 18:54:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 690762D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665428093; bh=RPD/xnSjj1tDtInobws6ol1rUKg0qLDyurC4L4goiCM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LGbmbTZ3tJBotifMgJY//blSpOdICDlOwKYJ+SyoHs2QoT8JxFwVBWuF4RVo96+ar
         aVi5kSQ7iEWogBk1myFwjeTN7G2MS8maASVGcg1QFYKA6YMDezXnF7ueKnuzzCENpA
         1R7TjusX+KU7qrbsDQlbuNC9hatccUs6cgQvARB0DWUrExH1Ytz/BrxkEUaKoWX02l
         74AnGdzKlnZvejd0CZKSHl0a677FIqY20BxQ7LqB51epYwnprySvsrYB5+ABnJrfDB
         lAkwW8SKVXzELzcrhseVtJ4FhXkC8pJtVbCEYXgPyiIAtFCm2kxc6YgvB8KVFX9XYp
         jjBSRtXk3XMKw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     akiyks@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        skhan@linuxfoundation.org, yejiajian2018@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: Re: [PATCH v4] Documentation/mm/page_owner.rst: delete frequently
 changing experimental data
In-Reply-To: <20221005145525.10359-1-caoyixuan2019@email.szu.edu.cn>
References: <89aed08f-1e0b-258c-516d-97a30fd02840@gmail.com>
 <20221005145525.10359-1-caoyixuan2019@email.szu.edu.cn>
Date:   Mon, 10 Oct 2022 12:54:52 -0600
Message-ID: <874jwbqzk3.fsf@meer.lwn.net>
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

Yixuan Cao <caoyixuan2019@email.szu.edu.cn> writes:

> The kernel size changes due to many factors, such as compiler
> version, configuration, and the build environment. This makes
> size comparison figures irrelevant to reader's setup.
>
> Remove these figures and describe the effects of page owner
> to the kernel size in general instead.
>
> Thanks for Jonathan Corbet, Bagas Sanjaya and Mike Rapoport's
> constructive suggestions.
>
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  Documentation/mm/page_owner.rst | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Applied, thanks.

jon
