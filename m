Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B263B48B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiK1V5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiK1V5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:57:33 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1362F67E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:57:31 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a17so6680592qvt.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhp9JseacTp8Y1aGYJHSK7od8sdJspM6eNyMXZ71Mu8=;
        b=ijTPc2YmZeXgwbZon8pdfqQUKQqb9ZBT2T6KNuoQwColvpB5KPF+xignuRoAu7gfYq
         LcIqfmMXpifcJxWgB3ZApS7jSJwfchIEJQFRWEr/eLshcTczY6zUkRgBs5mxq2T9S1YU
         ulB3NITHrstylTL7DM+neAGkNZ5hdePfkVksATLjATBVvUIofZ+fiHKOZXE0AsLMkoXk
         k8oE/9rzby+VS5H30SC1qNNCSQHbMo41zhEZ/XlCOgyJ/Iikrh4JFRSagtwz2D7wQlMh
         iIQErLJM7pL6+SRpYaKkul28r8xIsAsxzv5bVfW4mES1VjU2wwuoKqHzCBT7uRz6P4m4
         l2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhp9JseacTp8Y1aGYJHSK7od8sdJspM6eNyMXZ71Mu8=;
        b=ls24MzUZPWPYuHiiptOx3qkLO0M29kARYj0thJ6aUbnQ+pFOP/jgsyKZSLxc+PEaX9
         SKNzqHOteCFocpLixR5OzpMZjhEQ7T6Pt50vEzkggRkUtUremp7HyBuHS+t7sLc2e9mw
         HWa1q8ksQZNd0HAN1p0pT1iDHhzKAmExneTuV0jXTjJzMnAW1UqOkbAvlEg/SJkrIR2r
         GHrKEtSQkHbcMXZNMRBkR/mhKrg6KUdBEMyVMZhPWA9nKrQTWYlxubYf8qK6StLd3uNE
         eXobmxinWrb21grwFvEGa52tW/WvkE0ErDRoCXIO+4oM9dYz3SQ4tESPdbaoJwMQtM3I
         vBiw==
X-Gm-Message-State: ANoB5pl9cphFo0HdBU0wzRooa9/Osyhim6WrPdEkavelYyomDgIe+vV4
        JO3vISEIx1mRHUI7Wv1ol4NyuFClo9QwLkIH6x0=
X-Google-Smtp-Source: AA0mqf4A3oy0IMo6+W7HaeMB0trjakN4UMThY3KIE63wJhB+GIm2m5+Nc5w+w6APXnZc7MA4/mGxtCeGEUuK9/7okkM=
X-Received: by 2002:a0c:fed0:0:b0:4af:aa40:5986 with SMTP id
 z16-20020a0cfed0000000b004afaa405986mr31582720qvs.51.1669672650852; Mon, 28
 Nov 2022 13:57:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5149:0:b0:4c6:9fa1:37de with HTTP; Mon, 28 Nov 2022
 13:57:30 -0800 (PST)
Reply-To: markanna1047@gmail.com
From:   Collins Mark <cm667993@gmail.com>
Date:   Mon, 28 Nov 2022 22:57:30 +0100
Message-ID: <CAAgmm5dfNZU9GMVvt1i47mFPV7iEU5LZ+9CRLCQE7fC_H16wkw@mail.gmail.com>
Subject: Darlehen
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f34 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8038]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markanna1047[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cm667993[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cm667993[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Brauchen Sie einen Kredit? Sie stecken in einer Finanzkrise oder
brauchen Geld, um sich selbstst=C3=A4ndig zu machen? Ben=C3=B6tigen Sie ein
Darlehen, um Ihre Schulden zu begleichen oder Rechnungen zu bezahlen
oder ein Gesch=C3=A4ft zu gr=C3=BCnden? / Neujahrsdarlehen? Wir bieten alle
Arten von DARLEHEN zu 3 % Jahreszins an. Um sich zu bewerben,
kontaktieren Sie uns noch heute: E-Mail: markanna1047@gmail.com
