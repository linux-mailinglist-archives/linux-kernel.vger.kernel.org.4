Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18D5E81C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiIWSbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiIWSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:31:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E6127C87;
        Fri, 23 Sep 2022 11:31:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BCEA5735;
        Fri, 23 Sep 2022 18:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BCEA5735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663957885; bh=V0Z6GlxqUPJctrf114q9gAUq4nMo8XX8VCTNDTMwRx0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BumvCMWAEdYJ4yHdsnKP1XQWL7F/VdIIxC3cZcCUUS9uAo8Rf7Rpk7puBrQZs6Qvk
         KGXdy4yhMuIfpci6GLwi10kEN6+NUihhlZEYFA728Lne5VkglRifaA9id7v24FYtbv
         if5kxP3gFbiOacIu4gb4u4MuhC0+CzBFH/Ho+mjFTkisdjmtdxfVKmaJo+aj1kIk4Q
         YIcN3LxoQpc4rZ59co/VDoAP9CZAJTYx/IbxAx+hAJzfm37QjStuoFISSzc7NZCc/n
         yQBNB9ztbXOJ9lkom+mTY2Di09czKVFb5GbbtFTydq+QDPSHBO9sWOQmGSphOgzefc
         rc5LOsxAQlzHQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Vernet <void@manifault.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/7] docs: promote the title of process/index.html
In-Reply-To: <Yy3yjxs4Ylwpn2ue@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-2-corbet@lwn.net>
 <Yy3yjxs4Ylwpn2ue@maniforge.dhcp.thefacebook.com>
Date:   Fri, 23 Sep 2022 12:31:24 -0600
Message-ID: <87sfkilz7n.fsf@meer.lwn.net>
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

David Vernet <void@manifault.com> writes:

> On Thu, Sep 22, 2022 at 02:41:32PM -0600, Jonathan Corbet wrote:
>> ...otherwise Sphinx won't cooperate when trying to list it explicitly in
>> the top-level index.rst file
>> 
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>
> Should the commit summary title say:
>
> docs: promote the title of process/index.rst
>
> In other words, s/html/rst

Duh ... not quite sure where I went off the rails there...

> Otherwise:
>
> Reviewed-by: David Vernet <void@manifault.com>

Thanks,

jon
