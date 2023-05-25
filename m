Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078D710976
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbjEYKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjEYKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:07:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61722139
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:07:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso4156241fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685009222; x=1687601222;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LN9v5APMaW9lpD84S2MBrbkkEkF9SlbyeHiB1LCte+Y=;
        b=CeXyKlF3CwbccfQIr6qvXq6T4EmtnKBpmuy7W1+qM3Mc0pvy2RDVjCKLD8tkoE1O1y
         NsuDQrd8edPteYdNG9TjC++taIWO20EKcJH3euRAlUxe8c+Vqy/YFQ+YEqos2FumoZmR
         1MncsrYrKIQ+AYEBffILFdcw7m24zdvoNGF5ME6dWAWSfp07wZOFIaYqAtRaNftTLcja
         8luJO8phSypd7GxWiR0G2O8Du6KOjD5CSq0nwtMnDCZFdUO1sJtIJkb3tvRdyyIgt8d9
         2o6mz7DotYyoYZ8A+QJLG/hUa8puk6F8n+RvsHvdKADdSc4ZVB8EItX6uURhBdLBVL8Z
         qVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685009222; x=1687601222;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN9v5APMaW9lpD84S2MBrbkkEkF9SlbyeHiB1LCte+Y=;
        b=XH7ApBynBu7A4Ge/8J7Ycdd9RQo3IyH926bKLG/uvNzYxD7dkd+1fPT5UW5idYbe4Y
         6pfk75bex1OB5/PQpqMT/cgv35gta1rf3qYqwTeYjb1tao1VHwIkQ+LHZskV6SH8vOqq
         bIYvm3DxWNT7secQrljqpX2xsAvrbLzvlbWCu076B4pZCpF8/2HUDvxK/HFQ2G39qgqP
         fZwWcvh7ql3WqbSEx5RIjJcwYrhz89ghT2zuKGoL96RhJMnwn7ei2Wc08V5fRUi1XhN/
         jzwT1yK6OQ6L3jkQ17ml1tjrm5S7+kJBS3/vOjw3v2hdBM7wCdTBLxXnzQuCqt2jAVRE
         8wGQ==
X-Gm-Message-State: AC+VfDw/k9EMVN5QRhBylnn52LJVMcnaw+4ijCokEdGgxa5aXudn0bBE
        Aoa+ORGkE7YiOnXV1OkXMgZbj3BBkUBt5Lflq9c=
X-Google-Smtp-Source: ACHHUZ69pnitIMS8LE/AhYsynku8kh0En9HiwWFUUor+67Ebxngi1N9C1T8E7Je/XpVa5eruhtW2A0XhPAEBXtJnFDg=
X-Received: by 2002:a2e:9191:0:b0:2ad:d422:f334 with SMTP id
 f17-20020a2e9191000000b002add422f334mr976792ljg.17.1685009222473; Thu, 25 May
 2023 03:07:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:597:b0:3c:6810:c4d9 with HTTP; Thu, 25 May 2023
 03:07:02 -0700 (PDT)
Reply-To: mrsdavisselena@gmail.com
From:   "Mrs.Selena Davis" <koffindoli12@gmail.com>
Date:   Thu, 25 May 2023 10:07:02 +0000
Message-ID: <CAK-htckd8h5AFOs+a4cGKsiDYuOppO01e-p2vfxXtFUuvELxow@mail.gmail.com>
Subject: Lieber geliebter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber geliebter,

Mein Name ist Frau Selena Davis, verheiratet mit dem verstorbenen Dr.
Wilfred Davis. Wir waren 25 Jahre verheiratet und hatten eine Tochter,
die 16 Jahre alt ist.

Mein verstorbener Mann war Gesch=C3=A4ftsmann und Goldh=C3=A4ndler, wurde j=
edoch
von seinen Gesch=C3=A4ftspartnern vergiftet. Und k=C3=BCrzlich sagte mir me=
in
Arzt, dass ich mich einer Operation unterziehen werde (Lungenkrebs)
und dass ich m=C3=B6glicherweise nicht =C3=BCberlebe oder aufgrund meines
Gesundheitszustands l=C3=A4nger als n=C3=B6tig lebe. Liebster Liebhaber, ic=
h
habe Geld von meinem verstorbenen Mann geerbt, er hat das Geld bei
einer Bank hinterlegt.

Nachdem ich meinen Zustand kannte, beschloss ich, diesen Fonds einer
gottesf=C3=BCrchtigen/vertrauensw=C3=BCrdigen Person zu spenden, die als me=
in
Vertreter auftreten und dieses Geld f=C3=BCr Gottes Zwecke und die Art und
Weise verwenden wird, wie ich sie leiten werde.

Ich werde auf Ihre Antwort warten, damit wir diese Transaktion
durchf=C3=BChren k=C3=B6nnen.

Vielen Dank und Gott segne dich
Frau Selena Davis.
