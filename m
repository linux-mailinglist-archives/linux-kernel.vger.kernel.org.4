Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6BC6299F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKONUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKONT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:19:59 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01DFDF81
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:19:56 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id i9so9390823qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqSw1STIrgEfF90AoY00i5XQJEVJceY+3h3yWQf0Gbg=;
        b=EcP0sGvaS8LPWnb8m0crQa0KEDaf6UIs3w0kd8EzZzTpWtn5eUJFs3SBNLyEvTe6UT
         Qd9HO+DGxOTJqFU3R34+P5vK5pfYXb2/POZ3cYh+CaaLsCcmtuPo+EKbX5/wXdt2T1YZ
         OmvZjwDBpkNyA5WMbG7fd3HGucGzo2BJU1HS4MFSoJIgZtD4CBLCyS+GUO3z6DFsbRTg
         EbttUYv99uRHEMADDwE+UQyQj1SYcnyEmRaBSJM/t3/PfwYd6OmdVzbBdwopAiTqSL6u
         aWqbZS9PKSBEwZI5/x3PdxvOBLPiiVpL+rJrCqWcpsyODk4T0ghxv9x/8WQusYrxL/Ou
         HYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqSw1STIrgEfF90AoY00i5XQJEVJceY+3h3yWQf0Gbg=;
        b=AQTM9rQJpe6kQmEr7JBAXtyDoKQOLUV/I6NOnKcxAdod/GL5g5L+bzmsN1L+4f28WN
         61m4LCNeCy3OEYzAOXQbC7i6f3XjbMWwYonOdLot2P1W2c0CVYPHb8pTPMuZUZmx5wer
         IkWj0HvRdZM3Rdg6E2EMQz/HXPBsutTLw1jz+Z5ABpETBx8qBhUHQWVX6CHXZjIFqSSV
         d9bHZY6RXw+P92+dPOTCGHVzzkoHcTRj4L2saQc6g4zN3e0JqlEvekkjvtb30i2di4AV
         zZlO6cZmxHL0dGpY0ASmKCc1G8Ikc5U2fp7biFwubzB+AQlpr+2YAUglHANXRWCeV7Dz
         B2lA==
X-Gm-Message-State: ANoB5pnTZKzKFOr05KbR0gFevAlhhfyWP3RcuUQ365ZI1qoasCqSyfe+
        JD93UCGcyH+jt87HpV5QX8zYm1V1m5h2Exb/jE4=
X-Google-Smtp-Source: AA0mqf7HszXbBuJQgkYN5GwzsvTbvODgCNNsbbryhyp2e7ekQpIagXFmK38WzMYyKFp5aXrffPIc/UKHK3iK9rE/s9U=
X-Received: by 2002:a37:b405:0:b0:6fa:2060:13f8 with SMTP id
 d5-20020a37b405000000b006fa206013f8mr15146286qkf.772.1668518395701; Tue, 15
 Nov 2022 05:19:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:974:b0:4bb:77c4:357 with HTTP; Tue, 15 Nov 2022
 05:19:55 -0800 (PST)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <tannermichael605@gmail.com>
Date:   Tue, 15 Nov 2022 05:19:55 -0800
Message-ID: <CA+DEpxkojNo4G22bjc-GaTOzbpRYs1ydZ5sfD-PMHY=LGEHXBA@mail.gmail.com>
Subject: re Lieber Freund,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:734 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5020]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tannermichael605[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tannermichael605[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ich habe deine E-Mail erhalten. Die besten W=C3=BCnsche f=C3=BCr Sie und Ih=
re
Familie. Ich bin immer noch =C3=BCberrascht, warum Sie sich entschieden
haben, Ihren Familienerbfonds aufzugeben. Ich m=C3=B6chte Ihnen nur
mitteilen, dass die Bankbeh=C3=B6rde dar=C3=BCber nicht gl=C3=BCcklich ist.

Ich warte derzeit darauf, von Ihnen zu h=C3=B6ren, um weitere Einzelheiten
zu erfahren.

Dein,
Ken Lawson
