Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8467FBC8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 00:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjA1XGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 18:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA1XGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 18:06:32 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3923F76D
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 15:06:30 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v19so7155879qtq.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zRDkCfe2ZsuAWmw97O91W1dQYxv9ep54isn6vJP1xpU=;
        b=Ik4CLMvm55yDuvffczq0ZMtaxXt4VLvV8Gw7R3VaVkdNEI3l1k6mX3NvbglwjNWFMR
         WrfWcu3oMyG9QQ3FujR0cp4bUONhD92KEaIWjGsnLtLXwmC7Gy5ntW1/eYF9sPN+HTWJ
         6eRKAnaqJK79HSsYc/NyEr9aw6o+rAcunOjupspLZjQ5LtybgAbu2R1E9eTFKMnlLXy7
         2kHfyiCchmGDUJLnlPZhvXlbnPUm7Z06syKwfFuh9WYr2OOxKL9WRZ5aVPXk14NSUZ8J
         jPY5ZilgzEZSgWlBm1v5uGjKhZ+hiVe2n77WvWawhL8AZOHEjJE/mVLjr6PLDxvDIa4X
         Wwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRDkCfe2ZsuAWmw97O91W1dQYxv9ep54isn6vJP1xpU=;
        b=2s67EfneOCqPJ/sBDfp1Jwciio6N0c7ypOGxRj+7/RU1OQ53sqnW7FvUKVWsHhQEbY
         sPS0h2/OXYq7sFdA19ldivp9+kUhpGbXyj9RZ8sadHIWnps576sRXr58+ZzclhDjFHi6
         ufpyNOsYJK5yzFa4qnyjUZPjZAn5sW5BwGC9RVuQd07V+EhQt5m6fhq9kI9SOhoFU8of
         reUrqgYjkNW7WNVwmMjxohVa4S4zbH5FYP46bKNB7URg5zKAHXYNXIrLLkEgmwrwUdkR
         PwMwGhETRHBGJDIneVtPd3FySdrP3yCnqOmYr0FvorLYGxS5M8deplump17TCGfkmJwE
         X2YQ==
X-Gm-Message-State: AFqh2kqSDN3Swlh4j7Qz38IaMsCtTq/3SMu9lZeXyZ/qOoFzzrlDEcoN
        cldRjqaKe5/ksaA0OvEJJSe058FOkfRjUGpcPg==
X-Google-Smtp-Source: AMrXdXvcb07vhtHyDNPOF5kJE88/Pela9Gm958gIhQWCyNVlVtcmXO8+s9AJ0RmT5QedETPwknN+r6XoU5e2MgMni90=
X-Received: by 2002:a05:622a:1b1e:b0:3a8:abc:c68d with SMTP id
 bb30-20020a05622a1b1e00b003a80abcc68dmr2483513qtb.66.1674947189808; Sat, 28
 Jan 2023 15:06:29 -0800 (PST)
MIME-Version: 1.0
Sender: abdullahimaryam841@gmail.com
Received: by 2002:ad4:568f:0:b0:537:6f82:db81 with HTTP; Sat, 28 Jan 2023
 15:06:29 -0800 (PST)
From:   "Warren E. Buffett" <warrenebuffettx@gmail.com>
Date:   Sun, 29 Jan 2023 00:06:29 +0100
X-Google-Sender-Auth: _v47vT8fmAKps-YXLu7vdFHe_a8
Message-ID: <CA+PsKKKmx98EE4PYMfF0PZ8DXNLXY1N68+TDdSGtS9cX+0Y8mw@mail.gmail.com>
Subject: GEWONNENE SPENDE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Lieber Gewinner,

Mein Name ist Warren E. Buffett, ich bin ein amerikanischer
Wirtschaftsmagnat, Investor und Philanthrop. Ich bin der
erfolgreichste Investor der Welt. Ich glaube fest an =E2=80=9EGeben w=C3=A4=
hrend
des Lebens=E2=80=9C. Ich habe eine Idee, die sich nie ge=C3=A4ndert hat, da=
ss Sie
Ihr Verm=C3=B6gen einsetzen sollten, um Menschen zu helfen, und ich habe
beschlossen, {2.500.000,00 Euro} zwei Millionen f=C3=BCnfhunderttausend
Euro an zuf=C3=A4llig ausgew=C3=A4hlte Menschen auf der ganzen Welt zu spen=
den.
Wenn Sie diese E-Mail erhalten, sollten Sie sich zu den Gl=C3=BCcklichen
z=C3=A4hlen, da Ihre E-Mail-Adresse bei einer zuf=C3=A4lligen Suche online
ausgew=C3=A4hlt wurde.

Bitte melden Sie sich bald bei mir, damit ich wei=C3=9F, dass Ihre
E-Mail-Adresse korrekt ist.

Besuchen Sie diese Website:
https://en.wikipedia.org/wiki/Warren_Buffett oder google
Mein Name f=C3=BCr weitere Informationen: (Warren Buffett).

Ich freue mich auf ihre Antwort.
Aufrichtig,
Herr Warren Buffett
Gesch=C3=A4ftsf=C3=BChrer: Berkshire Hathaway

http: //www.berkshirehathaway.com/
