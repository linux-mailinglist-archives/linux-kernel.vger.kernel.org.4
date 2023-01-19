Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6E673ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjASQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjASQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:29:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45AB58657;
        Thu, 19 Jan 2023 08:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0AF0ACE24E4;
        Thu, 19 Jan 2023 16:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD29C433EF;
        Thu, 19 Jan 2023 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674145746;
        bh=Y5UiC66tqjbPnVN0nMB0hJCiOc1aq8w1rujscyAbAOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pBEWI2cZxBjwWoG76BSiadQrL5rjRWkcrWf+0CgygDYfm1QuBPzaVVfdmo+xoN+W2
         8KJCTBBG+25CHcDO+7Dc/PZ9UQnxvagbdyUyPVP2eXMICKzNAsTPWg2MAyrDaG/4qI
         o7AolPMH3wfdckZancCh1UwUVs3zBuJfDABJ0Q+0viKdCtSAGY1QqG4LflyFK96C5N
         Eylb3IvU8AGHTvcqjlfJMC1u9CrcxIOb0c3KU+VrQrnNFNk3xffavpy7AZ9yXglLbx
         cqmNkMaznpvv6ByiO99+g8ljW1W9Mq2Digz3bQu0dTWWD9YNmUPc0zxTcliC1ms4gH
         nP3Ek6GR2iJiA==
Received: by mail-yb1-f171.google.com with SMTP id 66so3220700yba.4;
        Thu, 19 Jan 2023 08:29:06 -0800 (PST)
X-Gm-Message-State: AFqh2kpYG8ao8O7ljSb7ERREcJOaTsSbKhKeBtmB5I1eQfPcIeI2fMQB
        1bVO8IhAjspQ4MXSti/KEf2Gk8fvc7iBOnvMchM=
X-Google-Smtp-Source: AMrXdXtaiaQPjHwUwKJVxb9BtKPFxfA/UNiZ4AIsS8iQjR5R8XxfhbuY1rB1EJe1OUu9UVA4FmofH0FqpMv0XKKEgJo=
X-Received: by 2002:a25:e407:0:b0:754:e501:8b51 with SMTP id
 b7-20020a25e407000000b00754e5018b51mr1433625ybh.197.1674145745379; Thu, 19
 Jan 2023 08:29:05 -0800 (PST)
MIME-Version: 1.0
References: <1674145568-31513-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1674145568-31513-1-git-send-email-quic_jhugo@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 19 Jan 2023 18:28:38 +0200
X-Gmail-Original-Message-ID: <CAFCwf13SAQMu1ssTtDHru5KSRMb2g_x-K_GBJn5bSG21_QYXdg@mail.gmail.com>
Message-ID: <CAFCwf13SAQMu1ssTtDHru5KSRMb2g_x-K_GBJn5bSG21_QYXdg@mail.gmail.com>
Subject: Re: [PATCH] docs: accel: Fix debugfs path
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 6:26 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> The device specific directory in debugfs does not have "accel".  For
> example, the documentation says device 0 should have a debugfs entry as
> /sys/kernel/debug/accel/accel0/ but in reality the entry is
> /sys/kernel/debug/accel/0/
>
> Fix the documentation to match the implementation.
>
> Fixes: 8c5577a5ccc6 ("doc: add documentation for accel subsystem")
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  Documentation/accel/introduction.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/accel/introduction.rst b/Documentation/accel/introduction.rst
> index 6f31af1..11cade5 100644
> --- a/Documentation/accel/introduction.rst
> +++ b/Documentation/accel/introduction.rst
> @@ -69,7 +69,7 @@ The accelerator devices will be exposed to the user space with the dedicated
>
>  - device char files - /dev/accel/accel*
>  - sysfs             - /sys/class/accel/accel*/
> -- debugfs           - /sys/kernel/debug/accel/accel*/
> +- debugfs           - /sys/kernel/debug/accel/*/
>
>  Getting Started
>  ===============
> --
> 2.7.4
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Thanks,
Oded
