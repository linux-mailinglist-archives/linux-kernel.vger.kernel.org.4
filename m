Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330C687659
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBBH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBBH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:27:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712C068106;
        Wed,  1 Feb 2023 23:27:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so1066071edv.3;
        Wed, 01 Feb 2023 23:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1GINEHnv1gu6lznwNAhoMfT9UtzwsG0ur+qj4v5n9o=;
        b=VccljSJOxO09q3vStd2j/BKsk0yx0mMDZz0tfQUMDz+bgivwtxNZzaBhWmMH3AqnGR
         dPcVn7GZkTRwpHLBfaVijDFvFVqo1OZm5ap8tS6ZpQRzZtTRMNjjFX+saenQV0RHEyc9
         ADnx3bXXwj4zBQ2fE+aUAtFI9DbId3WBknIk09O035J9KZNRrSsBuMoFJCtoKg1rivDf
         5QAGSS/Khx4oRhIfvQZ+TCmkffco+iiK1ndUl6YVscTl419g25vLocpZmgYI3dO5lw6M
         bSaGakyAOXOmEvZh+zCTgHpJbHmZh62k/ks0Z7dAOI/VvMxNF7LQvPazW9cR74tXy/Vp
         BV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y1GINEHnv1gu6lznwNAhoMfT9UtzwsG0ur+qj4v5n9o=;
        b=YaKjFznM6HD21Jpy95iah9Ozwrb0LXQaQJm7cFN67VSgkmMZT7uSmI+BEFb09SvKSH
         25/0EodNxky2C59Z5uxP1aesihmiQreTXYGFi/ybrWALcMohwXNMdiUOIS8V0A61BGa7
         szglBHO2QTTDD+i0b1RC8ba9V2EFkl5+7NfR35Pv3KcASKVy8KrGUcXVccXj2Sj02y1s
         LhFlt5gfZ3JDJS4YbWfcd6TGa3eDVT/YkeG/flkuyED+Ejsm4YUQkhX0YID3bA15CpJY
         xeSF+sI6wSJ/jm5Cb/Xpfr3En1E9mlyg/cDM0rRycRONUXIYxp+DHL0mN7FWpANuYYAq
         VtiQ==
X-Gm-Message-State: AO0yUKWJv5xviedYfUFxGvJuOQz7R8TtPJVKZw3EAz2agGgnxihb9Sd7
        iwfaBGEzDCJOO62AIdu/OAhoIYSBBywTYpPr
X-Google-Smtp-Source: AK7set/wWkhOxY8QrAHVg6gJn4n5qWwY2uvAJjUUddtOBq1alUQRNOCbJ1DZdmimHYmgdFJkoWVt6g==
X-Received: by 2002:a05:6402:3219:b0:4a2:223d:4514 with SMTP id g25-20020a056402321900b004a2223d4514mr5631397eda.8.1675322833723;
        Wed, 01 Feb 2023 23:27:13 -0800 (PST)
Received: from localhost ([169.150.196.150])
        by smtp.gmail.com with ESMTPSA id b4-20020a50b404000000b004a245350e0fsm5966713edh.36.2023.02.01.23.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 23:27:13 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 02 Feb 2023 08:27:08 +0100
Message-Id: <CQ7WDMLZJV70.39ULEVF528YB8@vincent>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: MAINTAINERS: Add the zulip link
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.14.0-38-gb2afc8117fb7
References: <CANiq72mGk72tvLx+uH-puXZ=MvAA9dzNVqTXYmPq2iadwYuyWA@mail.gmail.com> <20230201184525.272909-1-boqun.feng@gmail.com>
In-Reply-To: <20230201184525.272909-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 1, 2023 at 7:45 PM CET, Boqun Feng wrote:
> Zulip organization "rust-for-linux" was created 2 years ago[1] and has
> proven to be a great place for Rust related discussion, therefore
> add the information in MAINTAINERS file so that newcomers have more
> options to find guide and help.
>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3DxVaMQkgCA9rspjV8bh=
WDGqAn4x78B0_4U1WBJYj1PiA@mail.gmail.com/ [1]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>


> v2 -> v3:
>
> 	*	Commit message improvement per Miguel.
> 	*	Reorder the line after "B:" as suggested by Miguel.
>
> v1 -> v2:
>
> 	* 	As suggested by Greg KH, add commit message.
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42fc47c6edfd..80fc5f050f28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18222,6 +18222,7 @@ L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://github.com/Rust-for-Linux/linux
>  B:	https://github.com/Rust-for-Linux/linux/issues
> +C:	zulip://rust-for-linux.zulipchat.com
>  T:	git https://github.com/Rust-for-Linux/linux.git rust-next
>  F:	Documentation/rust/
>  F:	rust/
> --=20
> 2.39.1

