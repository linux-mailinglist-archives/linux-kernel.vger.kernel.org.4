Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD58E6392EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKZA50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKZA5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:57:24 -0500
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8A59861
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:57:20 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-3a7081e3b95so55338367b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5grRhzDgJlRek3REBN4Xq7JrHQXLu+Ef9bolVS8SjU=;
        b=pE0EE204QfApPu07hlxe/IrT+Gm/y11be9zBrZdOYSL+bBqM1erl7U5oS71+H35vu2
         eXRyT0ojbcq2Bg4rRLEcIySXE9tb/2nC3ei/G0Tf+rk0GPWJlUve1vVvJ94nNaGJlSPQ
         HZjWYwaMNZXUOOQJHfTOdp9nqTC+8jR3CvHZTwE6r9sPmygjUhd8H+NvRqNgHWugZAU5
         LSnWqs0An87WicfBt40uqu+nFq+xug2ymSnj5sxUswWKt740EFlc5QxlK/U7PwJK/8J7
         hsXM1FD9iCXzAdQQtMPY5BxaogktlP9UPn0kFOhP6YfHOHgE2fogq175p+TO16CjMqiu
         hHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5grRhzDgJlRek3REBN4Xq7JrHQXLu+Ef9bolVS8SjU=;
        b=7+CnO5qoHf8KWygRWn57ila+x5sOdj7y3Ga7e9qwqtBQr4mqGoVuCosxq/uANA7Rbw
         7j9muCjPOik0alPDeSNbPISJYKqNj7o+c3O5WqgArwXZzMK7DfL3sy7Jc36Saw4h2Ma6
         MapbfDpoRZO2WsQrVQ9BAT6r8Ou7mbZuhsoj40OIlWvG20l//Lz835v2JLbzbtOhfSEy
         NWjc3zBwjB7g4lXM1z5ObOdb2JLM4mC2C3Ye6U/m8lPxvZeyWX3PI2LV2Q29CBPpGarM
         0xO/AplvecyfpRnZ85BAah0KekUi11yMF3RMZSzkWLWTQQHZrtMcsp7nsimptdsp39Xp
         bSaQ==
X-Gm-Message-State: ANoB5pn33gwfYSzUIUSJT5B4OH+nsLZFia+cGcngmPpfYQmgL85vKj0p
        aKFQFgUQ7EXa8MTtDbUlcgEHfsQnEx+7ZjWirjw=
X-Google-Smtp-Source: AA0mqf6519474Zb6Fw0+w/vk47jdpLurX7zacFH9X6nEc11h8MTVafeCt4mmLkr8bCbehMaJTQGk24GKYx4ygMQIAh4=
X-Received: by 2002:a81:1915:0:b0:3bf:9e45:1139 with SMTP id
 21-20020a811915000000b003bf9e451139mr693756ywz.267.1669424239908; Fri, 25 Nov
 2022 16:57:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:6b07:b0:ef:f5dc:12ae with HTTP; Fri, 25 Nov 2022
 16:57:19 -0800 (PST)
Reply-To: samsonvichisunday@gmail.com
From:   Pastor Experience <experiencepastor@gmail.com>
Date:   Sat, 26 Nov 2022 01:57:19 +0100
Message-ID: <CAKLjfSGQ0EQCCdF7YKPN=G1xXQ8ihhntG9V=HG0d9wOOz++DMQ@mail.gmail.com>
Subject: INVITATION TO THE GREAT ILLUMINATI SOCIETY.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_LOAN,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [experiencepastor[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
INVITATION TO THE GREAT ILLUMINATI SOCIETY
CONGRATULATIONS TO YOU....
You have been chosen among the people given the opportunity this
November to become rich and popular by joining the Great ILLUMINATI.
This is an open invitation for you to become part of the world's
biggest conglomerate and reach the peak of your career. a worthy goal
and motivation to reach those upper layers of the pyramid to become
one among the most Successful, Richest, Famous, Celebrated, Powerful
and most decorated Personalities in the World???
If you are interested, please respond to this message now with =E2=80=9CI
ACCEPT" and fill the below details to get the step to join the
Illuminati.
KINDLY FILL BELOW DETAILS AND RETURN NOW.....
Full names: ....................
Your Country: .................
State/ City: .............
Age: ....................
Marital status: ....................
Occupation: ....................
Monthly income: ....................
WhatsApp Number: ......
Postal Code: .....
Home / House Address: .....
For direct Whats-App Messages : + 356 7795 1054
Email : samsonvichisunday@gmail.com
NOTE: That you are not forced to join us, it is on your decision to
become part of the world's biggest conglomerate and reach the peak of
your career.
Distance is not a barrier.
