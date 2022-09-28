Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E25EE308
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiI1R0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiI1R0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:26:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2036D4CA3D;
        Wed, 28 Sep 2022 10:26:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 85EC75C0111;
        Wed, 28 Sep 2022 13:26:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 28 Sep 2022 13:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664385966; x=
        1664472366; bh=hvRRc96g0zU7fiaw/+EoB+ReNWXMWxl5JTUje5UVqUM=; b=V
        +e/g/Xqis9DbqJa+q9GPQ0hACCGpTJSamjJt/ncuP8sLNaEp/l4zByDKVdgzHQaa
        bDzWkw7a8rHIuGLz7xXapEu6h3mSPk7eI2jwObOepWZIfPAv+/G/737rrFIcIUWv
        bVltq3fIERJV1enl81wtVm70JVm69Gs/Q5HpssIVm7CMTKw8XnvQcD7qnIA1FYe/
        O8wJaD6DyU71/DcffKQiq1qQQ1cxK19jxqYIMfkI390fzmc0CP29qg45c/XXPefb
        AtNX0+qcIHsVlmQpKTedPRdOQ1OCq24fuixfVxK5Ortgv1vtqgT3FW4J54bYyjet
        34/HkZYMqI8be9L3f+HSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664385966; x=
        1664472366; bh=hvRRc96g0zU7fiaw/+EoB+ReNWXMWxl5JTUje5UVqUM=; b=M
        m+nzeSwerikrof9f0nRHh+K7406eTAB2Lf3feeWgBUmJ2BvA2LUf03OOF4Wy+LC9
        buXRAf+CPxf8WeGiXmAv6P0jJgsRLTqImLvrGZrwE0r2XP2jX9boEUHGZ3ySBros
        SEWerqxq+D969d7mYThcdtSXyJd9Ja9Fiyhfeg9gy7ZPV/mHlbThitW9LGO5ut1W
        QRJ15YbxkufIuX/qh9/9Qw1hko6EQh+MXQhSp1zyzAQHiXhb2b4j6+N4MBkZWBex
        X9TjL6vZwmydqX/I/IaAX+06eD901Rztn04miGNXwwGmB1mDLjulkiVkv8cF7yzU
        Bqa0YPwkXwe4W1vvxdJtQ==
X-ME-Sender: <xms:roM0Y8vp_lnu1Uj8ITcOFoUT1VuRRyvtpKD9OcArxLWBfYM6CFMp6w>
    <xme:roM0Y5cJsDABs7kinvL4Apa3-9dqQV7wmHrXsb_3hHOOJU56_Twt-jpdiROWmSDBK
    z35w6hKaIzbpqeXB04>
X-ME-Received: <xmr:roM0Y3wXJqTjFqvuKHNFT8Z8oPQPCkbVDrOF1TPXxXOHPF2CDzww6k7HUKCyTRuI1dM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffoffkjghfgggtgfesthhqmhdtredttdenucfhrhhomhephghi
    lhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgrnhgulhgvrhdrohhrgheqnecugg
    ftrfgrthhtvghrnhephfduteelieelleeuueegfeevffetleeiffetledtgfffgeeigfel
    tdettddugeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepfihftgesfihftghhrghnughlvghrrdhorhhg
X-ME-Proxy: <xmx:roM0Y_PThJADrpVo96omRa_wqvxdi2-bCRJrdmLnj5ikOABhAjccww>
    <xmx:roM0Y89UQjlcJQrnXbheskfoBjUqz54hBzE6Cu45EhmYULimFwJshQ>
    <xmx:roM0Y3WyKiszAUga0lldA2MjT2zKPJe85BG7OI3dY7SHsc4bg8OAMw>
    <xmx:roM0YwTXuVVmgJ6H5m_BKUqOPRV2slPmWf4wiTNLkopbC9JwsVJ9BQ>
Feedback-ID: ica594744:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Sep 2022 13:26:05 -0400 (EDT)
From:   Will Chandler <wfc@wfchandler.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix empty version number when building outside of a git repo
Date:   Wed, 28 Sep 2022 13:26:04 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <87A1F5B6-3F60-4988-8BA6-A993E5789C80@wfchandler.org>
In-Reply-To: <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2022, at 5:21, John Garry wrote:

> This looks ok. But did you consider going back to same flow as pre-7572=
733b8499 to avoid a Makefile check, like:
>
> ---8<----
>
> CID=3D
> TAG=3D
> if test -d ../../.git -o -f ../../.git
> then
> TAG=3D$(MAKEFLAGS=3D make -sC ../.. kernelversion)
> CID=3D$(git log -1 --abbrev=3D12 --pretty=3Dformat:"%h" 2>/dev/null) &&=
 CID=3D"-g$CID"
> elif test -f ../../PERF-VERSION-FILE
> then
> TAG=3D$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
> fi
> if test -z "$TAG"
> then
> TAG=3D$(MAKEFLAGS=3D make -sC ../.. kernelversion)
> fi
>
> --->8---
>
> The evaluation for $TAG is not really needed in the first leg since the=
 fallback does the same thing, but just added for clarity.

I think that would be fine as well. I don't have a strong opinion on whic=
h one
is easier to follow.

Looking at this more closely, there is a slight difference between the tw=
o
approaches. In the problem scenario my patch will always use `make kernel=
version`,
while pre-7572733b8499 starts with PERF-VERSION-FILE if available, fallin=
g
back to the Makefile.

With the old approach PERF-VERSION-FILE could be used to manually
override the version, but this is inconsistent with how the version is
generated when building in a git repo. Is this relevant?

