Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49AA6ED37F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjDXR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDXR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:27:59 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1E65B3;
        Mon, 24 Apr 2023 10:27:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f8af6dfa9so68363087b3.2;
        Mon, 24 Apr 2023 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682357275; x=1684949275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdA6Byrf0lwX48iKKvuKILJgKE3LwYes2nbzbUPvwjQ=;
        b=agMcbw5SWjFyUNOdq3N/KwNnq+uqHSf5o3sbylnzE5ky2sFKTCZSs+WFh2HzT+bNaH
         ZoFfdDq+rKPPYtIQI+umDFZzxOnH+MWAK1lxkD1bSXCaQbTIaRDBjEDFe91H7Clyp9DB
         rdQyoWU5D8EukOUTyc00eHJCNq3df/0yVGLfZD1Gjhf4CzODaHHgF9Ic4sQN/E8NJiQY
         XfSXEHTxmWoRAjOwog+uCm6QiushxVNXzd7QuHB/cElgrSFkLpcU18dLGTITWRl80Hhn
         eP401N7XdDccXWEp0NzzrN3An82kdM5T1cG7Ibi4G7xMoTFQTqz5mYP82XBm37wkoLck
         yY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682357275; x=1684949275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdA6Byrf0lwX48iKKvuKILJgKE3LwYes2nbzbUPvwjQ=;
        b=Loz+N9YrllD6zcDLVXJjL5FACmtbxx/EZsFfGQDTVyYBQGBlZwAL4ICF033BJPMYxS
         hXydM157f96jaOFN3xpNe85thcNGhaIfwRu96m07Io4CEqPNgL4hd3WC838h9caALnu5
         JCCgEMm9znTo559Ub0GfYagcS+S2UGDeqhb/pYovfuJ78k56IwZlmKlkQdg6HRyHQUln
         9ipfF33SXNnggAxwyeO6aUHa3yJSv9rE1ElqEO5fwf/QJ2+MT591+sg31UrSIlSomNcm
         6Xbolt3Fl5VYdxST0Jg0vsiB8VhrgjYx4B0g0SQeZ5orHT508SmNG4GzBsPdjlWsyu7G
         A4DQ==
X-Gm-Message-State: AAQBX9dR/WwHiOtOvKnOePZlBRJnU8ZXO+/4hiOWXQuJFQOufyGr67F3
        aTCllvf+IJT4DZ2LXD+0cXsqJwprrvIxI/X8JPg=
X-Google-Smtp-Source: AKy350asbRHC8PDsiNKQs25dnFEaXtgJXtPjtNM7+i463aoBFsKoTYo1Y2MFtqEoiWXRuZufmD63t5ux/BXRK0Udszg=
X-Received: by 2002:a0d:d5c2:0:b0:54f:b93f:759d with SMTP id
 x185-20020a0dd5c2000000b0054fb93f759dmr8545103ywd.43.1682357273559; Mon, 24
 Apr 2023 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221016182349.49308-1-masahiroy@kernel.org> <20230424162110.11082-1-lrh2000@pku.edu.cn>
In-Reply-To: <20230424162110.11082-1-lrh2000@pku.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 24 Apr 2023 19:27:42 +0200
Message-ID: <CANiq72=Kb6ckhU8Ss9=Dg4Zn11Us+DLbKnNWAVaTb-nv7Y=ARA@mail.gmail.com>
Subject: Re: [PATCH] scripts: Remove ICC-related dead code
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     torvalds@linux-foundation.org, masahiroy@kernel.org, arnd@arndb.de,
        bp@alien8.de, dave.hansen@linux.intel.com, devel@acpica.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mingo@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, rafael@kernel.org,
        robert.moore@intel.com, terrelln@fb.com, tglx@linutronix.de,
        trix@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 6:22=E2=80=AFPM Ruihan Li <lrh2000@pku.edu.cn> wrot=
e:
>
> Intel compiler support has already been completely removed in commit
> 95207db8166a ("Remove Intel compiler support"). However, it appears that
> there is still some ICC-related code in scripts/cc-version.sh. There is
> no harm in leaving the code as it is, but removing the dead code makes
> the codebase a bit cleaner.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
