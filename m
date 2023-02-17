Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0969AB74
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBQM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBQM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:27:03 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AD26605C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:27:00 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id t2so234042ilm.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SCaWCJFu+kQ6aYpJSur8vSOLT6u8BSUnkVg9ZbTVJ1w=;
        b=oKiWyQZ/8W1DnFy+0gahyJT7r3yJpivs80am/ky9koA2gSEUBPdG6HSNA9b15etF6i
         KI8NqkXM6yq9S6eSLcDzdH5lz68ISZI+IMsZPRiqQA+N6OeKifHv8bd1diayEYnK2qd7
         9iJHQjOVEjMZe0/5QS/DJR/mCU6CugrNtf6DJDMl0bqGGPmmafrnz3adQ2ssUZOovdBH
         mqmudAsSBuTBoQniyIoeXbaajpzyiQcJqKz1NYXjFv1Cqf0Swr/pbRF0inW0buzlfEnr
         CKS5UHMDOZdhVdT3onQV1Rf3pjuNyEZr8L5pJrrvOZqBS7ywrnDWcaHywflHaBRa6GND
         8GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCaWCJFu+kQ6aYpJSur8vSOLT6u8BSUnkVg9ZbTVJ1w=;
        b=RRKmewre/SAgc5zO4aEMcNYEgDwP9c1I4pfMEwsQI36cSPnvX02DbxrXIV8cvbpAVf
         P2jrzhbwVi+cD7E3pinwfVgeBK2OjXJt3zKHTItKI0YwN8Mc9vV2H9FmqjCzGNytkaTD
         iY7ueALfq083oSJSqshTHhZbg/tGYU6f1tImbMOK9mKi1Omj9qWKAXLsc9pQwkwwha5g
         8GPdtC+SnEBTzelb8Sw/9Opx6XUrNcHy/CQQ65FLphQ+RauINKqS+EHKuOHflMalug5H
         70eEw3LQwgKofAU7cJu6xetmMtxzO/W91sKX0DRmtQvwLGLFYlwDcFj35XVGHyA5MbIs
         Jj3Q==
X-Gm-Message-State: AO0yUKUpYdswn2/ZTJAK9QL9b/ZS50HCpc1Tgg4LzzM6JWLugOpKYDOH
        2EibDdCg6h/MYaqizy1MQXHwoQPoJPFhfWs3Aqc=
X-Google-Smtp-Source: AK7set+onVhjTE2eO+C4Sfrq9YcgvRJqoKKcwh0JHwYrlI/XWKxITJYWa091zNsxff/6kndmbv0KPvkpMr5oV23hitM=
X-Received: by 2002:a05:6e02:be5:b0:313:babd:fa78 with SMTP id
 d5-20020a056e020be500b00313babdfa78mr208682ilu.3.1676636819754; Fri, 17 Feb
 2023 04:26:59 -0800 (PST)
MIME-Version: 1.0
Reply-To: vera.wilfried145@gmail.com
Sender: godsonwilliams140@gmail.com
Received: by 2002:a02:1142:0:b0:3c5:16ea:873 with HTTP; Fri, 17 Feb 2023
 04:26:59 -0800 (PST)
From:   Vera Wilfried <vera.wilfried145@gmail.com>
Date:   Fri, 17 Feb 2023 13:26:59 +0100
X-Google-Sender-Auth: H0WjXD1eVXyKRQMNrjDP61xcyO0
Message-ID: <CA+gcwbmeHboBRe_DkmCS6ZGOcWKCp84NgoMdd2u4gMc56_XKpg@mail.gmail.com>
Subject: Compliment of the season
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo,

Ich bin Miss Vera Wilfred, ich bin ein 22-j=C3=A4hriges Waisenm=C3=A4dchen,=
 das
hei=C3=9Ft, weil ich keine Eltern habe, habe ich etwa (10.500.000,00
US-Dollar) zehn Millionen, f=C3=BCnfhunderttausend US-Dollar.

Was ich von meinem verstorbenen Vater geerbt habe, hat er den Fonds
auf ein Fest-/Streukonto bei einer der besten Banken hier im Land
eingezahlt.

Mein Vater benutzte meinen Namen als seine einzige Tochter und sein
einziges Kind f=C3=BCr die n=C3=A4chsten Angeh=C3=B6rigen des Fonds.

Zweitens, bei Ihrer uneingeschr=C3=A4nkten Zustimmung, mit mir zu diesem
Zweck zusammenzuarbeiten, bekunden Sie bitte freundlicherweise Ihr
Interesse, indem Sie mir antworten, damit ich Ihnen die erforderlichen
Informationen und Einzelheiten zum weiteren Vorgehen zukommen lassen
kann. Ich werde Ihnen 20 % des Geldes f=C3=BCr Ihre Hilfe anbieten.

M=C3=B6ge Gott Sie f=C3=BCr Ihre prompte Aufmerksamkeit segnen. Meine beste=
n und
lieben Gr=C3=BC=C3=9Fe an Sie und Ihre ganze Familie, wenn Sie mich f=C3=BC=
r weitere
Einzelheiten kontaktieren.

Ich brauche Ihren Assistenten, der mir hilft, diesen Fonds in Ihrem
Land zu investieren. Kontaktieren Sie mich jetzt f=C3=BCr weitere
Informationen.
Vielen Dank

Vera Wilfred.
