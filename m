Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418AC6C29EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCUFgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCUFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:36:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AAE23113;
        Mon, 20 Mar 2023 22:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95D45CE17D2;
        Tue, 21 Mar 2023 05:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0881BC43445;
        Tue, 21 Mar 2023 05:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679376949;
        bh=s5cxi3vBYPopF7yjDCUtxPDF8fdIuesps6hIFllnDjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KL4QZxlGrFVoE985gXUj7IbRKh972tNxg0JznuQkhgHIgYuTvUf3ZGtPxdF27aW56
         uc4fiKIyXYb0csx8CZaiCHcRn6DQMUKDWdPe/m4q3xkH5Liy2u999DvqXJ2DUBtw4H
         rdZVsQssz+fFR9b7uhBxltDuMQUxA0flVnssY/kro1vTVNWlNg5lJcuxxUoGCXciwq
         8/CtOsf4BGx8j9YhOEg0Cl+YZGZz4db6GI1nnLA97jOrLmOD7XK15E/5yr6IyDeSIf
         TXFk72o4TyZIY15B6NAPrrejgNI0PXmRB586oiy7YAl95bCaOaFAma6lQ6x6E8GMqc
         ghMzEWfcgEdBQ==
Received: by mail-oi1-f175.google.com with SMTP id be16so10419588oib.0;
        Mon, 20 Mar 2023 22:35:48 -0700 (PDT)
X-Gm-Message-State: AO0yUKWdNsPdRQC2Ov8VnPfkfBVhkvmLOcqASw830TcU9YPL1gcyC4AV
        TVDMp941BjmDJh0yPNEXugViVVOlLuizohuAnZ8=
X-Google-Smtp-Source: AK7set8Z+eqRSLz9ByeMe/2jMVRnNT3vLlmGVlKLQCFDuXvqLj4NlFoRDR8CQez8SUx7fG6o30r1CS3/57/6RwXCndM=
X-Received: by 2002:a05:6808:119:b0:384:a13:952a with SMTP id
 b25-20020a056808011900b003840a13952amr271776oie.11.1679376948257; Mon, 20 Mar
 2023 22:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230311114248.36587-1-adobriyan@gmail.com>
In-Reply-To: <20230311114248.36587-1-adobriyan@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Mar 2023 14:35:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQakj8dEGUwkpXQPv4fJTHuOwu6o4F+B7ViCF+AJRm25g@mail.gmail.com>
Message-ID: <CAK7LNAQakj8dEGUwkpXQPv4fJTHuOwu6o4F+B7ViCF+AJRm25g@mail.gmail.com>
Subject: Re: [PATCH 1/3] menuconfig: delete shadows, prepare for vertical
 space reclaim
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 8:43=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> Shadows consumes precious vertical lines, simply delete them.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/kconfig/lxdialog/checklist.c |  2 --
>  scripts/kconfig/lxdialog/dialog.h    |  1 -
>  scripts/kconfig/lxdialog/inputbox.c  |  2 --
>  scripts/kconfig/lxdialog/menubox.c   |  2 --
>  scripts/kconfig/lxdialog/textbox.c   |  2 --
>  scripts/kconfig/lxdialog/util.c      | 22 ----------------------
>  scripts/kconfig/lxdialog/yesno.c     |  2 --
>  7 files changed, 33 deletions(-)


I do not have a strong opinion about the shadow.

If you do this, please remove
dialog_info::shadow as well.








--
Best Regards
Masahiro Yamada
