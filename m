Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B444E60B377
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiJXRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiJXRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:05:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791271BE906;
        Mon, 24 Oct 2022 08:41:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8BD5380;
        Mon, 24 Oct 2022 15:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8BD5380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666625486; bh=vZo3NaYsiE4RanH8vOQyZKSWOWK7Vzqu0+FoP0/zdwA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ezPh9lFrN1o9z3MW3QSR9z2xR5JNxeKE/vbdXfbc/ZHSP+sOGFOr0CuHZO/2cBen+
         sySuuJqk7shTuQN1lrzcvPWO3aPW0JydJ+A0/QIMJOI4iA4mJsK9X3HJEf92jRFaK2
         E1ralKytvQZgFVplDCTBomtQxS+5OsTGIWNSj+vCFNnLwehrx359/HWt7G06seq7KN
         sGhyn/rGejPk8p5O37jSUgnZFJo/qJjB6s9zyQ1clO1pRia75WVdbS6oW/FHgfEsEJ
         J6+zBfkt6NYxju9xJV03PKM8OxO5KAAS/UuiXmaelru6iYDJnftyKzQLqZpMRldwIv
         AxqfCqd3aop3g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
In-Reply-To: <87a65lfdqb.fsf@meer.lwn.net>
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
 <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
 <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
 <Y1aovvn7dAyo1nuW@casper.infradead.org> <87a65lfdqb.fsf@meer.lwn.net>
Date:   Mon, 24 Oct 2022 09:31:25 -0600
Message-ID: <875yg9fdbm.fsf@meer.lwn.net>
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


Resending without the screwy address that my mailer decided to put in
for Alex, sorry for the noise.

Jonathan Corbet <corbet@lwn.net> writes:

> [Adding some of the other folks interested in translations]
>
> Matthew Wilcox <willy@infradead.org> writes:
>
>> I think we're better off following BCP 47:
>> https://www.rfc-editor.org/info/bcp47 rather than the libc locale format.
>> That will imply renaming it_IT to simply "it", ja_JP to "ja" and
>> ko_KR to "ko".  The two Chinese translations we have might be called
>> "zh-Hant" and "zh-Hans", if the distinction is purely Traditional vs
>> Simplified script.  If they really are region based, then they'd be
>> zh-CN and zh-TW.
>>
>> I think you're right to conflate all dialects of Spanish together, just
>> as we do all dialects of English.
>>
>> Jon, this feels like policy you should be setting.  Are you on board
>> with this, or do you want to retain the mandatory geography tag that
>> we've been using up to now?
>
> I want to go hide somewhere :)
>
> I'd kind of prefer to avoid renaming the existing translations, as that
> is sure to create a certain amount of short-term pain.  But I guess we
> could do that if the benefit somehow seems worth it.
>
> Of course, if we're thrashing things, we could also just call them
> "Italian" (or "Italiano"), "Chinese", and so on.  I don't *think*
> there's a need for the names to be machine-readable.  We should stick
> with ASCII for these names just to help those of us who can't type in
> other scripts.
>
> If asked to set a policy today, my kneejerk reaction would be to leave
> things as they are just to avoid a bunch of churn.  But I don't have a
> strong opinion on how this naming should actually be done, as long as we
> can pick something and be happy with it thereafter.  What do the
> translation maintainers think?
>
> Thanks,
>
> jon
