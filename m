Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563816D902A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjDFHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjDFHI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:08:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511493D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:08:38 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 184AB3F202
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680764883;
        bh=u92lfurfYYp1af2K26TOzdjWbKa5zPlLBBByPP70/Uw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YeZaN316tECObcQwvjqzXOjFwEj0RhaDiXYW0ZiPeZieE2S4dD9PkSfTpDS96jTKo
         LtviaAc8iJsWmo9ff29ef6EAzjTG80xFBVLn8CoMuDy7flJJkiTWhoNPf/ngIbwrub
         pTsujgariquIzWmvKGV/Ad4mQqo9DA1QKt4BSYrVK+XGQplVpJm+TOa2gTdkUBRpcR
         Os6Ejx/qUJU16sVAu99z7Bv9VHpsV0Jjf0+ZXJPCzvYAAnJVfg4/bXfaHhcvys8Xzk
         yauETqL44bCsUjpI4CLkdliHtzFiLkImXBRgF1LG8hdIS+gC/ZDD0LNruddQatBoSX
         gSuDlKJ1Ks15Q==
Received: by mail-yb1-f198.google.com with SMTP id c67-20020a254e46000000b00b88f1fd158fso10062240ybb.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680764882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u92lfurfYYp1af2K26TOzdjWbKa5zPlLBBByPP70/Uw=;
        b=Jp2BozZWFWbcr4abHbQEhoXwph3Kq5I6vIsDJKfJg0CaVWyrODNUK5tpYZUXpk63DY
         S3wN2FB61DFfIupkW3PAEGgcd8lETx27mBTY6DtJi7EQ08LSAylnyvkGs7fEJnCxIiF/
         9c/LwQ7wTs5iPAUXhs3nqVv+ZBqCr8Jaw5BrAwJkQA+nxGGmdo4mOZVWW3XI/e7Rnqmw
         GHp7GPLmpW7kMYFU5++LDXon+YZwz+lOU8zu0y3St6VfPYyH05LOuq74ILhK+OUReYjC
         ORXYQO9WDNG+ucu7kSXo9abMQHyIfQ7JwlpShbr8wELWG+Uj2HSmMajNpoleLNINLC0I
         O53g==
X-Gm-Message-State: AAQBX9fzLlWlBbXE/LygQXyKclmgd2G3H62kv0K5d0jHX7030Ui4C/Et
        mp4Do6J8sQgm7e5qRHPn5fzEe8nlPcI8fFwz+B++/uYjapIoMha7sxCQqXKWtSUlllNmdt5RCFA
        rBOycdPyG9i4uJPiiajPaXxC/gqYy7aIi8zy8GT2m4PTTh91FrZsG9sDB5A==
X-Received: by 2002:a25:7689:0:b0:b75:9519:dbcd with SMTP id r131-20020a257689000000b00b759519dbcdmr1443377ybc.12.1680764882160;
        Thu, 06 Apr 2023 00:08:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZtraXMmp0doeDwepKZup22JQwNcOgfF6PwPn9eVvhfkn2nvHNZ94AW1UziM+HyXKGATsjraDmaHZuFqOLdC+Y=
X-Received: by 2002:a25:7689:0:b0:b75:9519:dbcd with SMTP id
 r131-20020a257689000000b00b759519dbcdmr1443367ybc.12.1680764881955; Thu, 06
 Apr 2023 00:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230404122652.275005-1-aleksandr.mikhalitsyn@canonical.com> <ZC49UDfayQ+XJRUt@google.com>
In-Reply-To: <ZC49UDfayQ+XJRUt@google.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 6 Apr 2023 09:07:51 +0200
Message-ID: <CAEivzxe9v9z8YcJaE9n7snd2eEEaKZeCZHDdfm+1bgJ0_2H7Mw@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: SVM: small tweaks for sev_hardware_setup
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 5:32=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please tag patches with RESEND when re-sending the exact patches with dif=
ferent
> To/Cc fields.  Not a big deal, but I blinked a few times trying to figure=
 out
> if I really had two copies, or if it's just time for me to log off for th=
e night :-)

Hi Sean,

yep, I'm sorry about that. First time I've sent patches without proper
CC's by mistake.

Kind regards,
Alex
