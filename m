Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE765D697
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjADOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbjADOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:53:38 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42AAC7E;
        Wed,  4 Jan 2023 06:53:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B873784;
        Wed,  4 Jan 2023 14:53:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B873784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672844016; bh=LBViN6C2IxVDdMCa0dttz1clC/S4Z1tQCswt2WcU1BY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X53x2rU3rdcW42+JCBcQLLipYTujPo3ZGt8l/3jnHBGGEDj3tGdRu9gj+zw6JA3Iw
         6H1QbcoYKA8gHpizTpD4NHWDj6lQBATm+WkSGdTA3ZBvedzVlN7/Fm2bgILR31JbzW
         zLocnmeDYlZfgRDuJyfjEc4m3vx0piWdC3eIKOzn1u1aZHx5DQFsAYXlhwPIw5sEXp
         h5n2UTaA1A1kRJW5MHsdqR8fJb496lZUOb63NU9kVCt8/TPUi4Pi8XmAeqK5DC5YIv
         b078oNu9M4I8RSL5+ZWfDTaKnXjhWQvWp9J+v0ZUYbW6I7ijJTqo93gb1WGOQcI5h2
         mqOICGuKMqczA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <CANiq72n3qnWwDjp0E1xY1m15qhMHz8_AXcL9hstVM8Xwfi=pbw@mail.gmail.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com>
 <87wn64fq7d.fsf@meer.lwn.net>
 <CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com>
 <87h6x7cfiy.fsf@meer.lwn.net>
 <CANiq72n3qnWwDjp0E1xY1m15qhMHz8_AXcL9hstVM8Xwfi=pbw@mail.gmail.com>
Date:   Wed, 04 Jan 2023 07:53:35 -0700
Message-ID: <874jt6cpw0.fsf@meer.lwn.net>
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

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> I think I understand now what you meant by "fail more gracefully". I
> thought you meant fail with a better/proper message given versioning
> information or similar, but you primarily meant avoid breaking the
> entire docs build if the Rust part fails, right?

Both would be nice, but not breaking the docs build would be at the top
of my list.

Thanks,

jon
