Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73BC7346B0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFROtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFROtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:49:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C4C1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 07:49:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9b2b7109dso17815441cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687099787; x=1689691787;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/su32Ngja94J1ttbqMyQB6YKuGK7hm0/nnbGvRroi8E=;
        b=i8BwQWZddpqtZfrrjttTMmYzIxTNN44rfeMdW0Vs15qIyaCzjz3ryhzHm28IJMY2Di
         Nne8uUNTmJe3x/OBuSzKfGj8D1CgimvUZtzWYqHUdIOb97bKC4isFwJgaGWpa3KYpVZt
         uyg/SUXpfQ79KzRX2wJytXN6wZ9Eio3j7MHIEDxAyKolFxg+2cR5PCopfqo9EF4V8U9Z
         P3iCzSJ0giRecKAxvWAG1VV7rO7NKvwOMXi6oIH9D+Zl1CBLdgfbmgjxK7UbGovrEwL+
         g+kWp5u3rwom/k3Q4Om9hcMyDliSLPvUCEZPTtrKzQcuHW2wL7DnG7q8z2dKHYBILqES
         zrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687099787; x=1689691787;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/su32Ngja94J1ttbqMyQB6YKuGK7hm0/nnbGvRroi8E=;
        b=CmQ8DOZN2B/ViLyX160FlrRWBB5YtOOI8UKM3sgSZ0iY1aJ2/slMi6rVK/RjbTx1vV
         wMflaCSaEhuio/tFHi1dHQPIM+EoehAD1v4GlCiXsXXIvMMsQ15MiJupKgMIQCDQ0H9V
         zUe3LOdT8Qcv66gzFqEBFeIDxv4ZtFM3JuHbAAggqQxs0yL+5iwMgi2PEAI1rPW8OSCV
         azZW296KQdc1bYDNV4ZHauJJcDYCcp1xDz+baLNDNABNjTkiCiuRDtZU1DjXZMsLiu7J
         21GKoJUN+Z08EB6zHWiXmVXHtUZMsHLFGcmfXLKyciCQjfIqXvghGcGTefBGc8m9j6e/
         Px0A==
X-Gm-Message-State: AC+VfDwI6WBqCGMdK7JvFGEHNH+vDarid5TJSDQMiNrLFaHgzdetmQgb
        AX1xzQHVRy1xDXD4wFhQlt8b1DdTFJvU9Tzfy2U=
X-Google-Smtp-Source: ACHHUZ5EGu9Asjwy8VrvKgSEkDhbjG77cf/Pcls4sZWjgd2T2c2Xs5aUuvN2h97uPy7Xtk6YoM+CRWkK4f9Wtx8/BQo=
X-Received: by 2002:ac8:5dcc:0:b0:3f4:f44d:9674 with SMTP id
 e12-20020ac85dcc000000b003f4f44d9674mr8904359qtx.67.1687099787103; Sun, 18
 Jun 2023 07:49:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:abe:250f:0:b0:373:c116:da7 with HTTP; Sun, 18 Jun 2023
 07:49:46 -0700 (PDT)
Reply-To: choipark90@yahoo.com
From:   Choi Park <ubacustormerscar@gmail.com>
Date:   Sun, 18 Jun 2023 15:49:46 +0100
Message-ID: <CAGMLrsWsUwrX6=uH1NdJM4TZxAGmbQViZyw9CBRP2yr_bd_ZFw@mail.gmail.com>
Subject: investment partners
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Hello I just and to know if we can you can partner with  my partner
from Hong Kong  to invest in your country if you are interested get
back to me for details
Mr Choi Park
