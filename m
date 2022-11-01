Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC2615444
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKAVaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiKAVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:30:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3C1DF3E;
        Tue,  1 Nov 2022 14:30:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8EDE365;
        Tue,  1 Nov 2022 21:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8EDE365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667338202; bh=Whjgo1/LcTcPlcW4445jRDYE5vq2NPEo3QUgeSSwdlQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g46ySEfodXVUkzI/4hXZe33PCUn92FRck2p4svSpul/MRPGSsnBI1q5qN3OneXrNA
         u5NT8Wca9TSPorTr5GVcE+urRIWgC1V3sRNMtqS9XdqDUuswp1EVt+0QFS43zzWfFV
         FrbMoQOyBfNkhP5Nto7qIkWA2NQxyj712UROGMghEfa4+nM40CXjM6IoFUsUDCT790
         RpXd1Qw3NMTYHyNoIo/eFZ6YyC1Azm35nRyKkkdBDLiB3c6jIEa2JKnVtgdm993IRv
         9K1v3A7vYMr3/T0xo5Jjn+H83hvrLkqb+2RyXJ5ckqWAvMejR6/7UGb/2vXYmpvt0u
         xFL4xO5XzyrCg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, bagasdotme@gmail.com, willy@infradead.org,
        akiyks@gmail.com, miguel.ojeda.sandonis@gmail.com,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v3 0/2] Documentation: Start Spanish translation and
 include HOWTO
In-Reply-To: <20221024145521.69465-1-carlos.bilbao@amd.com>
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
Date:   Tue, 01 Nov 2022 15:30:01 -0600
Message-ID: <87wn8ext0m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Spanish is the second most spoken language in the world. This patch set
> starts the process of translating critical kernel documentation into the
> Spanish language.
>
> Link to v2: https://lkml.org/lkml/2022/10/13/866
> Changes since v2:
>   - Apply improvements proposed by Miguel Ojeda
>   - Added Reviewed-By of Miguel Ojeda for first commit
>   - Added Reviwed-By of Bagas Sanjaya for second commit
>
> Changes since v1:
>   - Added me as MAINTAINER
>   - Fixed warnings of kernel test robot
>   - Use imperative form in second commit
>   - Improved minor translation details
>
> Carlos Bilbao (2):
>   Documentation: Start translations to Spanish
>   Documentation: Add HOWTO Spanish translation into rst based build system
>
>   Documentation/translations/index.rst          |   1 +
>   .../translations/sp_SP/disclaimer-sp.rst      |   6 +
>   Documentation/translations/sp_SP/howto.rst    | 617 ++++++++++++++++++
>   Documentation/translations/sp_SP/index.rst    |  80 +++
>   MAINTAINERS                                   |   5 +
>   5 files changed, 709 insertions(+)
>   create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>   create mode 100644 Documentation/translations/sp_SP/howto.rst
>   create mode 100644 Documentation/translations/sp_SP/index.rst

I went to apply this series just now, and got the following from "git
am":

WARNING: Message contains suspicious unicode control characters!
         Subject: [PATCH v3 2/2] Documentation: Add HOWTO Spanish translati=
on into rst based build system
            Line: +estable m=C3=A1s reciente del kernel, y no est=C3=A1n in=
teresados =E2=80=8B=E2=80=8Ben ayudar a probar
            ---------------------------------------------------------------^
            Char: ZERO WIDTH SPACE (0x200b)
         If you are sure about this, rerun with the right flag to allow.

Any idea what the story is there?  Could I get a resend without that
problem?

Thanks,

jon
