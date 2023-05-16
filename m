Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA877057D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEPTra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPTr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:47:28 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79467BE;
        Tue, 16 May 2023 12:47:13 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1684266429; bh=kS06qhDO4SuIPjXTCQd5ri72irx1DJTv1Uk+i6GpwGs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=xn/yjWqqhVOfJWo4wMwSsEXEfyJYKmZgxCmzubpJMDYJ5QRJLaRzPUd3tuhdHHtHH
         JCkDKPZpK8XjTtu/EztjVbyyKmEeROQBjF6HFojbg1sWdeJdivxBJ7VpTNjv03idRf
         oqsqVbcNcl9IW8kV/amAEV2RaOV+n8bOMefnCVGGRrmtQhWoXHQUolGO6+pp+vdjRU
         ZPs87cck+2eOr/VVJUqj1Q+WP34dJsUDPmxbF2OF5Aiw7NzIylnxMEC8joCYobU7h7
         TTr1dyWNh39FcMBho/IMJ1Fn5yQPdllpQqd0hhx5rBq3hEDPIpjOrlnboQB9g9LIoU
         JGliQsv/mrhCg==
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+b68fbebe56d8362907e8@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] wifi: ath9k: don't allow to overwrite ENDPOINT0
 attributes
In-Reply-To: <20230516150427.79469-1-pchelkin@ispras.ru>
References: <20230516150427.79469-1-pchelkin@ispras.ru>
Date:   Tue, 16 May 2023 21:47:08 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871qjgcb43.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Pchelkin <pchelkin@ispras.ru> writes:

> A bad USB device is able to construct a service connection response
> message with target endpoint being ENDPOINT0 which is reserved for
> HTC_CTRL_RSVD_SVC and should not be modified to be used for any other
> services.
>
> Reject such service connection responses.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Reported-by: syzbot+b68fbebe56d8362907e8@syzkaller.appspotmail.com
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
