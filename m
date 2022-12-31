Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFF659F62
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 01:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiLaARb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 19:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiLaAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 19:17:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA16E0C6;
        Fri, 30 Dec 2022 16:17:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n12so10948346pjp.1;
        Fri, 30 Dec 2022 16:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBVDRYvlIyw7nKQw7Az4PKfCh+WoofTwZ7w2r+i0doA=;
        b=M6mLM319O5fKXRxTYtRN9WEsWSN1euXSHYTidNuE0VT5NvTeacEin18hX4kaNqoQ+g
         3nqlxsIfvGbT7TlB3HnnqBwqzyuZP3zk85aGb/zKzZcGNF/Ryr5YQPbQy+GqF0WKgWIR
         3uz9QYq4qMUqFt7UhtkOo8Nt91+KnpIjd1FBCiwQpGim8sxv0rxku1EqAT2NgbnRj2JH
         K7QEclKt0rSzPF3/DcKcQPOUyW8dErzhhe9D5z1subrhV/TaerLGiVu0av2+hxHekvFc
         yacpJ7XeLUKNoKkpjIisc0YcRiSOT45eeTejuEW0NoCsEEBqmf7Qfg5yVWibt4yxB/XU
         EC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBVDRYvlIyw7nKQw7Az4PKfCh+WoofTwZ7w2r+i0doA=;
        b=JZO9z90dhGO1M4O+z4A9kFU8eauNZ/ofgRmMhBrR290ZwCh1GaZiu3tgr+VuNfrv09
         3xz3UQc+vPz6idEE9tkSvcVuCsyY2BFFjgiI367Arr1nc5Ah8EH2/B3bdFJHo3K2t1ti
         Aj+M3Op7fIlVYFKhfZYM4kJuoQkhXhRjyTPNTgwyuNfW8K9dHPmgMGWfTkGIvmCmOnBn
         jFk2Op3/qJ9+jYzBhQczYJUukI4TvnqX7kOrAwmUPwXRYsmhfIm6k9ttxXthiDtCojVx
         hHqcQIB+240+JBJChUogV9Sno7/x03DlFlYNtT0UstXa8fS1cm5hf2Ou8J5rIGIyX8Cd
         4btQ==
X-Gm-Message-State: AFqh2krx7jBO2/M/2yWyGturdo1VLanORttBMnCpoPGHzzJudd/CybxS
        bORcpJpAli5ZPh9IeWwI5ic=
X-Google-Smtp-Source: AMrXdXvbAEFVLVZ6LKXesNGWNHPSmy7dg7XURIB/+rOZlKPnHOzg4jJ2hGoXKdpzMTNefsSn//z62g==
X-Received: by 2002:a17:903:48b:b0:192:84aa:a247 with SMTP id jj11-20020a170903048b00b0019284aaa247mr17051088plb.30.1672445847371;
        Fri, 30 Dec 2022 16:17:27 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b00188a908cbddsm15458823plh.302.2022.12.30.16.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 16:17:27 -0800 (PST)
Message-ID: <3e30ecf7-ebf5-c2cd-f6b6-dc5d6e5cdb71@gmail.com>
Date:   Sat, 31 Dec 2022 09:17:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221230173127.59553-1-federico.vaga@vaga.pv.it>
Subject: Re: [PATCH V2] doc:it_IT: align Italian documentation
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221230173127.59553-1-federico.vaga@vaga.pv.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Federico,
Minor nit on embedded latex code. Please see below.

On Fri, 30 Dec 2022 18:31:27 +0100, Federico Vaga wrote:
> Translation for the following patches
> 
> commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for process substitution")
> commit 5372de4e4545 ("docs/doc-guide: Put meta title for kernel-doc HTML page")
> commit 4d627ef12b40 ("docs/doc-guide: Mention make variable SPHINXDIRS")
> commit 7c43214dddfd ("docs/doc-guide: Add footnote on Inkscape for better images in PDF documents")
> commit 615041d42a1a ("docs: kernel-docs: shorten the lengthy doc title")
> commit cbf4adfd4d19 ("Documentation: process: Update email client instructions for Thunderbird")
> commit e72b3b9810dd ("maintainer-pgp-guide: minor wording tweaks")
> commit ea522496afa1 ("Documentation: process: replace outdated LTS table w/ link")
> commit 93431e0607e5 ("Replace HTTP links with HTTPS ones: documentation")
> commit e648174b53f1 ("Documentation: Fix spelling mistake in hacking.rst")
> commit 602684adb42a ("docs: Update version number from 5.x to 6.x in README.rst")
> commit 489876063fb1 ("docs: add a man-pages link to the front page")
> commit 0c7b4366f1ab ("docs: Rewrite the front page")
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
> V1 -> V2 fix typo in footnote link
> 
>  .../translations/it_IT/admin-guide/README.rst |  2 +-
>  .../it_IT/doc-guide/kernel-doc.rst            |  2 +
>  .../translations/it_IT/doc-guide/sphinx.rst   | 14 ++-
>  Documentation/translations/it_IT/index.rst    | 93 +++++++++----------
>  .../it_IT/kernel-hacking/hacking.rst          |  2 +-
>  .../translations/it_IT/process/2.Process.rst  | 15 +--
>  .../it_IT/process/7.AdvancedTopics.rst        |  8 +-
>  .../translations/it_IT/process/changes.rst    | 11 +++
>  .../it_IT/process/email-clients.rst           | 67 ++++++++-----
>  .../it_IT/process/kernel-docs.rst             |  4 +-
>  .../it_IT/process/maintainer-pgp-guide.rst    |  4 +-
>  11 files changed, 127 insertions(+), 95 deletions(-)
> 

[...]

> diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
> index e80a3097aa57..5dd751349adc 100644
> --- a/Documentation/translations/it_IT/index.rst
> +++ b/Documentation/translations/it_IT/index.rst
> @@ -1,13 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  .. _it_linux_doc:
>  
>  ===================
>  Traduzione italiana
>  ===================
>  
> -.. raw:: latex
> -
> -	\kerneldocCJKoff
> -

Removing this latex code would make Italian translation pages in
translations.pdf one-half spacing (when built on systems with
necessary packages for CJK translations), which would make them
look sparse.

Please keep it.

For your reference, here is a list of related commits in this are:

  - f7ebe6b76940 ("docs: Activate exCJK only in CJK chapters")
  - 77abc2c230b1 ("docs: pdfdocs: One-half spacing for CJK translations")

        Thanks, Akira 

>  :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
>  
>  .. _it_disclaimer:

[...]
