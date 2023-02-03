Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0E689C51
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjBCO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjBCO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:56:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB39EE07
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:56:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so4850137wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GE8LRefBbCr+vfDK+OAPRXSUgs+NOR142JeKY5u24zc=;
        b=lQ+Bfh6OkWkCBU99Jb4AoJvJIG7HKtjAaLqAEaz2ki2xFEV18ywmHNcz5VmpBDmjmJ
         SXtSu30qXHHM+Udai2mJHBuBUC7LChxZMBrDiJXjE99Li5JAznexcjJX449U96AFIssl
         jThvEaitV1aiToqDuEiKLWc1n1+h1/JdtRq/ie3dNJF3DbTX9ycYSzLaNnpAaU49/Ftx
         pZBkJQgONJawVE3PgRv1N5Wz9xxO4VeLm0JEbus+Ir+YzE42tl4pgeEAJh2tEj+cR6N5
         /x/FRUtqP9cUFaBVwIa3I5zkSbNXH7ovXJ5dJ988FbHmoKLCkWmjQhGP0rCl6+biA9aV
         gaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE8LRefBbCr+vfDK+OAPRXSUgs+NOR142JeKY5u24zc=;
        b=wRjWjD+pWvHP0Vv8o/SuDUFwWnP3kNTNSFclOeOy+1IDjpE6QLng0gwRT9BQpkpqK7
         XnHPcZiOctRV9aORDvbJBehy/slBoyGY/1tT0tW9eW06cpJur44+evQizIzA8m7hT1f+
         Tjy9pJBbIzoxoSmSzeXbg5H3EsIokOYqExbk3XS8cdAo6WgnHiUrQdLhfkfGelUXjEHx
         qv+ZEUwQz/WTlT0EBNcrKuo/YNp9Lcz/HqO32H9kGMq//DexFpQnkfGl23tN/RJnzbLp
         kA9hsBgw38Ao7C7MHlqwLE+XJfbfDYCTS9HcmhyHhDtXYhAqK0u8b3KG9XXSupNRuGzb
         wKJg==
X-Gm-Message-State: AO0yUKUTUOxiiVCyjt6U7Lu3HAVpg9QAZoQcKPHs/w66rTN4QVIEeBkk
        0MLH9SqXc76FyeT3G+dVj98z/tT5zIns7pBJOR5xl6YED8oTsA==
X-Google-Smtp-Source: AK7set/hydzP0dXLoWgVSTnW+bbYDLJg0Zp3X0fwDhpfSHGwr5RZxb4gFuIIBVQQ1gks/JrOIf9JxjGcoq9+9rZXulo=
X-Received: by 2002:a5d:6481:0:b0:2bf:b373:149a with SMTP id
 o1-20020a5d6481000000b002bfb373149amr397802wri.355.1675436172859; Fri, 03 Feb
 2023 06:56:12 -0800 (PST)
MIME-Version: 1.0
Sender: dareadja5@gmail.com
Received: by 2002:a05:6020:4710:b0:259:ad88:21bb with HTTP; Fri, 3 Feb 2023
 06:56:12 -0800 (PST)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Fri, 3 Feb 2023 14:56:12 +0000
X-Google-Sender-Auth: XsYMg48CSVVgdrD4EWG4jSd7Jsw
Message-ID: <CAE9bZtNJU58hibyfSYAcMuTSc1B_Qq0rag54mPxZC9pGq_MD8g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dia duit a st=C3=B3r, an bhfuair t=C3=BA mo theachtaireacht roimhe seo?, Go
raibh maith agat.
