Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8C619C56
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiKDP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiKDP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:58:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5331238
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:58:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g127so6284866ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GOCvKBk73rXwJdH10UVm8XT+XirTgz33E1TKjrN/Uzo=;
        b=S13sSmJHhU9uqm4XvT9OL6pehs+UCX9nYh0JsgCnCNL3r06ZnNWVXYEn3sz99QL4za
         XZxQbpw9ZOEfmwaVH17bVKYf9hYHh0z5IeYiUcQKp8Z0LPAjt0svElsdu6EwBJ79Ut1I
         /9aphTHHu5ki574nB4/XpPWmiA/Kg7MwvUXCiuGJ9lzRw0sr+l81FPEYtCdE+GaePNNB
         kr5/DRUAsXJWmVDQyCnfv8OUAuBqhe4oF+JM2puk5++w0l6UeqWXsMA060ieDIaH7b/z
         24DHjT2sYrvI6qfpjenj0wry3HYZnijKh1PpPx44ncOIkQahEj9wF6YjpKziLayGSrhD
         Nhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOCvKBk73rXwJdH10UVm8XT+XirTgz33E1TKjrN/Uzo=;
        b=kqVew2TdRHzu/q5PuDHaeqsDxE/E1DJGestrKrbleE5sxMIEEFxqAtaQ+962ENH624
         YgZADX2x+U2PWbDyvZRjgxZqqCm0W4SP1VU7ZxHuB2OnxR4N1yOzRO1NqEh8XLEmIb+B
         iRgM+fZHqCOKP9QcV+qPGytCL3WCui0Z2NdXSr4g9GQLvUCcjaipvMH/mr4fKYGsLKSB
         0SFfnAFvWmX8RITi5WU43s3kyWK+UHRD9J1fztUM1gCGIYG9vV+t9UhbILCbHw2B5yyq
         4VmaQSkwA30hedmXrUq/u3vKZSuj+YrhAtkFixyTda+DkeH4EC0091bjG9MsyrZo1e7w
         JkMw==
X-Gm-Message-State: ANoB5pmjJ0DdU8FPstE1MKsa6yDpTXQnzouyqE6ophGM6mJEvdaZjp2v
        kIiS+3F1DqYAPa2aBZOHiPveP/FzZEty8BXQyuE=
X-Google-Smtp-Source: AA0mqf5Ukk8+sfk8xmM8o/W5XNYFiLtQAYm7aN7OSgzge3Hh58dZS0Z/3gyUwERCX42sdGqiLnafroz7zjOdZ2C6eoM=
X-Received: by 2002:a25:d60f:0:b0:6d3:ac57:7e27 with SMTP id
 n15-20020a25d60f000000b006d3ac577e27mr80077ybg.540.1667577530290; Fri, 04 Nov
 2022 08:58:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:6892:0:0:0:0 with HTTP; Fri, 4 Nov 2022 08:58:49
 -0700 (PDT)
Reply-To: smithisabela76@gmail.com
From:   Smith Isabella <bigfellooow@gmail.com>
Date:   Fri, 4 Nov 2022 16:58:49 +0100
Message-ID: <CAJa=SusVc9hA7e-tpq5FZpdqofj0_S4jECjZhfGN-_EVdeHT4Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Dobry dzie=C5=84,

Prosz=C4=99, czy mog=C4=99 ci zaufa=C4=87. Jestem pani Smith Isabella, prac=
uj=C4=99 w
Wells Fargo Bank, pisz=C4=99 do ciebie z mojego biura, co b=C4=99dzie bardz=
o
korzystne dla nas obojga. Odkry=C5=82em porzucon=C4=85 sum=C4=99 15 milion=
=C3=B3w dolar=C3=B3w
na koncie nale=C5=BC=C4=85cym do jednego z naszych zagranicznych klient=C3=
=B3w, kt=C3=B3ry
niestety straci=C5=82 =C5=BCycie w wypadku samochodowym wraz z rodzin=C4=85=
. nasi
urz=C4=99dnicy bankowi czekali, a=C5=BC kt=C3=B3rykolwiek z krewnych zg=C5=
=82osi si=C4=99 z tym
roszczeniem, ale nikt tego nie zrobi=C5=82 od lat. Je=C5=9Bli jeste=C5=9B
zainteresowany, mo=C5=BCemy zebra=C4=87 te =C5=9Brodki i podzieli=C4=87 si=
=C4=99 nimi po 50%.

Po potwierdzeniu tej wiadomo=C5=9Bci i wyra=C5=BCeniu zainteresowania udzie=
l=C4=99
wi=C4=99cej informacji. Prosz=C4=99 o jak najszybsze poinformowanie mnie o
swojej decyzji.

Czekam na twoj=C4=85 piln=C4=85 odpowied=C5=BA: smithisabela78@gmail.com

Pozdrowienia,
Pani Smith Izabela
