Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6501D6B68B2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCLRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCLRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:15:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB07F2BF0E;
        Sun, 12 Mar 2023 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678641323; i=w_armin@gmx.de;
        bh=bT0qbOKNV3PxF+7AOrJHLJameeroN49w62tBkUP56So=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=eGd8CQI8fwOTWqi14wklO9zDC6A9f/6b2qhS8Ldqo6kmq7rykyAYQV7DQAoU/F5Q1
         EdkW/AreEw2w8M9unxyAs/LJhe0VJbUIJmGd4OMNMSrpCE/1CmvC5EwWb6RnLSDcBx
         vjAw+f/rpjxyRlWolBFOReh1tJ4XGin2vUdpBD13OBCG0QafDebgG+y+b/c0jTxCGh
         fTwQGqRUD4vUhj0WEXWCMzaQDtEo+Stl6aoL/C3hVac8rulS58MMN5GwAY8wvcCMj9
         /kPI2Nf1BYE7SFavhClwmG4ITs4dcrypo4kaef6QGITcR+UFgihvhx9oA6eOeRt7Zh
         8QKBEFjK2A6tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1q5VQU2pyn-00WIja; Sun, 12
 Mar 2023 18:15:23 +0100
Subject: Re: [PATCH v2 0/4] ACPI: SBS: Fix various issues
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225115144.31212-1-W_Armin@gmx.de>
Message-ID: <d2660362-dc25-e75f-394b-1997bd062933@gmx.de>
Date:   Sun, 12 Mar 2023 18:15:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230225115144.31212-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:p/v1vP6rhEUaDRQt24WPBBTE+TzHL/cTwCeGIsmH7i2ur2hOuQJ
 6v0lKw5EqsV8vi9v0pJ45WflZ4gyHyGkOEIZhGp1VQ0LgR7P4kkQaea2mqs0IgTFDYLCEpo
 uqhr0Ari3KmTl2sgA2Fp5zZ0eRYWQf8xytpTC2jH5/kxhE9TVbvW3/yqtGgMD85HAN5jm3G
 CRPHtZ+1xULAeqWXLq30g==
UI-OutboundReport: notjunk:1;M01:P0:xSrQQc2HOUo=;/EybnV2+tZEtmVoq1UExYavqUdM
 KQcdpoPjG9Yzf+yeFw0RwkakIq6zi9wHbG+QsFjD/h1zqY02rgvm6B6pvGX3lwHlgKI5EQv6s
 dSvFoYsLGUf3US+5RE6Wd42ke/1uTnmuxiarmimUAw99onAqboZlaC3sbJv6/hjaQeBc2kvk+
 OjeBCrFgoa2l7MSibvKA4RvCqJ3spAI/98ti+GJSR0lYCusq0wtPyIUCObKKO8ps3s6GkvYl/
 MLqab+bB5KWdZsnMC7HrtjgIOaypqaJK0nX5U8OCxdPZHdU2HqXz7tQchwQ3kmaLYOWuBhzpj
 46TJQy1Bp+VK0KcbyV06TYJ2HgOfz0MTHM/pbkKFNE9UXEp0hW9r28cWFVTCxWgn0E82xLiP0
 KuFniRaKwQeNnIRIZHm4Y/n9DQltu5tTH4UN/BiNtrczcZAX/pykTDD1VytcmieH7tT5PUI7K
 VxGVOAqvyv6w5eFK/F/EYhQ4Z+HQRr8CP0oB9WZOReGh9H/O85prVaBVLaQC3kTyVzvhCBBPb
 k4U/9z98+rEQx1Lyx2hOtPUutwHdHIrnOnA7TbG3XuhgnYHZVGCW5cgc2Q9i6/bN6ACPd2OiV
 JgjF6be5O/A7E2Hzb20CcSHFxsTO1ge9TTisnZXOx6TnS9rl+V52nxMtysRLakLvxfnIE9h0m
 i7CpIgSEYsm5rN5ikmzMxLt9bNx8gsi2L7bxYpRnASJonVMlOFsA+mOBt27TzB1uwaAJN7A6D
 Qr3UnhHGPRc75GODBMgYRcHCbTcfD8JobHeS7x2HmFEP9tZIHnxPZlrScsnCABzh+Cqdh2XfF
 jDAzUrYASI+m4nb5Y87mqA7hNGh3C8Z93OXr+p6M1llxS647TpU76wqiDHUbXGteBrUPzGjrW
 c/IgLom0adpzqFvq1WwdyK5Jou/AxkCdqlPnKlKQ0VdE4mXEVc3YHfsNtFVOp0a1HZEZVGbXN
 Kf81t0B2PuC4mKlrW+Sjd6cvyqU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.02.23 um 12:51 schrieb Armin Wolf:

> On my Acer Travelmate 4002WLMi, the system locks up upon
> suspend/shutdown. After a lot of research, it turned out
> that the sbs module was the culprit. The driver would not
> correctly mask out the value used to select a battery using
> the "Smart Battery Selector" (subset of the "Smart Battery Manager").
> This accidentally caused a invalid power source to be selected,
> which was automatically corrected by the selector. Upon
> notifing the host about the corrected power source, some batteries
> would be selected for re-reading, causing a endless loop.
> This would lead to some workqueues filling up, which caused the
> lockup upon suspend/shutdown.
>
> The first three patches fix a stacktrace on module removal caused
> by some locking issues. The last patch finally fixes the
> suspend/shutdown issues.
>
> As a side note: This was the first machine on which i installed Linux,
> to finally fixing this took ~5 years of tinkering.

What is the status of this patchset? Should i use a SRCU notifier chain
for the query notifiers? I would really like to see this getting fixed,
as it prevents me from using linux on this machine.

Armin Wolf

> ---
> Changes in v2:
> - make acpi_ec_add_query_handler() static to fix warning
>
> Armin Wolf (4):
>    ACPI: EC: Add query notifier support
>    ACPI: sbshc: Use ec query notifier call chain
>    ACPI: EC: Make query handlers private
>    ACPI: SBS: Fix handling of Smart Battery Selectors
>
>   drivers/acpi/ec.c       | 44 ++++++++++++++++++++--------------------
>   drivers/acpi/internal.h | 10 ++++-----
>   drivers/acpi/sbs.c      | 27 ++++++++++++++++---------
>   drivers/acpi/sbshc.c    | 45 ++++++++++++++++++++++++++---------------
>   4 files changed, 74 insertions(+), 52 deletions(-)
>
> --
> 2.30.2
>
>
