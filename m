Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF86437CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiLEWO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiLEWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:14:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FAFD16
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:14:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so1779665ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztioCWCXz3brIbYSz03sWEv3lSAH+FMBaXr9H3qounw=;
        b=FILmw3y0mvGVsUqu/1CAG/gwWlyt+9RDa2C1r0bXQIEclKwVzpL5of6NrPK2F+xcFj
         KaEuYhf/DIgbro/pqtkvrCOyrG6pEpDWenLGy9hkI3loRS2g+FmvZOhMnJ9pkO9lOgHV
         kW99s5G1/q7Ije1FGFdI2FUBzUdtacBUNH30Y4R6ohTTOlrOR/UzYBywp5gCkK3RpjUF
         7f6vakDCtDU8pB744Z+DD9U8mHctRO9KzZPRLF5nAdvv3wAoD8RaoT0AzTpEzp5d6k5R
         EC8Wf8tDAudEr95g2+jIq0rKHHOmD4B1G4sD04EjBm8HSD2Yz/6Os+XL16tttrrH5hTd
         ZVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztioCWCXz3brIbYSz03sWEv3lSAH+FMBaXr9H3qounw=;
        b=Zee6jEQBOjJwdubbtHYiYB8hV+K7eMAJkReqFgjv0i24MAeQBR6RuoPn7nT7v4a/IQ
         KG1Vu5yo6LoW3Yx9Udv9QGZg9uTEvaWESxwGaYglRwqxAtwv3UxkkVsuX2qk9qsC8aEC
         Hd6p6jbuM4Y3anScSqrbE3zi5l8XmG9PlbjMdmhj58gC9KiwLzdjfmzXp7h1aUzadMfk
         6NAbq/U6uy2fDorTfExFBxGzvFom3JXc/s18RckyMjOYbZdyPdSFJVB1VFJFMvVMixVz
         Fxu8G2g3sF31jt7ZQlFnQ7mp+JBjrACMEGV1tyuTWwxFu/7B7sc3W/Z/cn02RhliU82s
         rHww==
X-Gm-Message-State: ANoB5plC9t7PIZYvMJPOaVZ8nJ/mx+dF++ceX4vRhYo2rxggq2wXuRJy
        kq0OJYhWQwyYPDZG6V2KQMg7W5Quy1JMo9jule60Yrgcqzg=
X-Google-Smtp-Source: AA0mqf7b7wJRrThmcDMScZF/SnIKUcfiqpPR+HwHjEX+vGCJLwa781w3XIv+Z0UnMEk2dvO66gM92DgmOAihd9vWD/w=
X-Received: by 2002:a17:906:6093:b0:78d:b37c:83d9 with SMTP id
 t19-20020a170906609300b0078db37c83d9mr55185953ejj.637.1670278461544; Mon, 05
 Dec 2022 14:14:21 -0800 (PST)
MIME-Version: 1.0
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
 <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
In-Reply-To: <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Tue, 6 Dec 2022 09:14:11 +1100
Message-ID: <CAEYL+X8opFs47DMM=St42-piw9j4Ha7CP75YeFCP67pgtRn7fQ@mail.gmail.com>
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver (GQR)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> MAINTAINTERS file:

> CHAR and MISC DRIVERS
> M:      Arnd Bergmann <arnd@arndb.de>
> M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> S:      Supported
> F:      drivers/char/
> F:      drivers/misc/

Should I re-send the patches to those then?
