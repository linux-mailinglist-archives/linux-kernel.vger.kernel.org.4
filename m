Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66FD65CD87
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjADHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjADHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:15:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792F17E1F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:15:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w203so5582372pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dlc-ui-edu-ng.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh8EDekJmhMLShCyWmCdcD6wys81NqC9ot9tSgw4w5o=;
        b=IRz3Cj5OAAupp8dEpn2rKhSM1BpwouMmYDywnfUHdoNfKmqAxnmVZqAbftXs24eq1W
         nVNk1B77PWdmOMiQpxSbARhYndqW3BxZG3EWCoE/Aq0R91J/AX0fh1Bpw+ripwiDKQxM
         /cYBradDORsIyQM1OeBd9/4T6QnzAeKohkt10TbckqEotwUkEdfOS4CixZcceWVhkpM2
         2+lqD8M9WCGKe21aG82pyuAcPjhaSDzmgwNBT0tRnQHyaDWSgLiszm+DRyf2a/aAw4YK
         2lbScR5PeCuk5t0et1p6XawPxgz80eMPoPCNUiz+0oZ2wP6KZ4YbttFErwSMGzMa6B+8
         EboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh8EDekJmhMLShCyWmCdcD6wys81NqC9ot9tSgw4w5o=;
        b=YK4CjQzsmk7DOKFjzGFEYfUFoz9J69VCISY4/cR+RzaLOs0EdFlL9YUhD1GbPQ4u1h
         BUENjFWKZ1bixMbNSDbJnmGd+REamP9a8/frSIDePX/0320IG6SfNi7w6b0RZWkex2dm
         USQCqvfumAnormGXc1IT3BUmu/1563899Zq5eCCa91iS37XohElxhmefYggn53CMcsgd
         M3Mwr6gEFWGOyysnBuGzf32uGuj/CJD79GE2mxCpwwA0WdeQDFnBdGQj/l+GQ5zOHdy7
         RFinRPQikzigBxiyxqopeI/8rLVDPi2O31+ca0S8JK5qXGPOrOyDD0rjrmCBXswjrwuH
         cdxA==
X-Gm-Message-State: AFqh2kqA4HPLrgCcI8cTuSyKwzyPRIvMiQQH18Ra/6ezNokRCc7x3WfF
        2tg0S77xGKtkKaogGIqYYgMXwDFiqvXxRuoTiWR6HVPEyhq9dDkDUnwo7JMut+MKmq8TFclJOAo
        77yLIHrDZ/fU0qDctixSN2aITYqdDt2d4xQ==
X-Google-Smtp-Source: AMrXdXuhXIUyqMeTVBZ20TtY+O2w05lrcgmhUmlgKkQbKuM/QJLwq3QGZwFT4gRTYCYH4K3l11HiBy6b6C1achmZZf0=
X-Received: by 2002:a63:fe06:0:b0:492:23d5:1e3a with SMTP id
 p6-20020a63fe06000000b0049223d51e3amr2655520pgh.386.1672816543679; Tue, 03
 Jan 2023 23:15:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e212:b0:381:f7c0:aa2 with HTTP; Tue, 3 Jan 2023
 23:15:42 -0800 (PST)
Reply-To: cilimajeannette8@gmail.com
From:   Jeannette Chilima <e019361.aizojie@dlc.ui.edu.ng>
Date:   Wed, 4 Jan 2023 07:15:42 +0000
Message-ID: <CAJAErSpnEKLZFeBhOSdE42-FoJM4yW_bu5ntjg3=dUGTXd2Kxw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

How are you,I hope you are doing well,My name is Jeannette Chilima a
lovely girl and i believe we can get acquainted, so if it interests
you, please reach me back here for further communications. I stop here
awaiting your respond.

Regards
Jeannette Chilima

Please contact me direct to my email address for me to send you my
pictures and further communications.

--=20



UNIVERSITY OF IBADAN COMMENCES ADMISSION INTO ITS OPEN DISTANCE LEARNING=20
PROGRAMME FOR THE 2021/2022 ACADEMIC SESSION

In a bid to increase access=20
to the UI , the General Public should be informed that suitably qualified=
=20
candidates can now apply for admission into University of Ibadan through=20
the Open Distance Learning mode for the 2021/2022 Academic Session at:

**=20
<https://modeofstudy.ui.edu.ng>*https://modeofstudy.ui.edu.ng
*
For=20
enquires and support, WhatsApp/Call: Nike: +234 810 481 2619, Kehinde: +234=
=20
816 204 3939


--=20
This email and any attachments are confidential and may also be privileged.=
=20
If you are not the addressee, do not disclose, copy, circulate or in any=20
other way use or rely on the information contained in this email or any=20
attachments. If received in error, notify the sender immediately and delete=
=20
this email and any attachments from your system. Emails cannot be=20
guaranteed to be secure or error free as the message and any attachments=20
could be intercepted, corrupted, lost, delayed, incomplete or amended.=C2=
=A0*The=20
University of Ibadan, Distance Learning Centre* <http://dlc.ui.edu.ng/>=C2=
=A0and=20
its subsidiaries do not accept liability for any damage caused by this=20
email or any attachments.Any view(s) or opinion(s) expressed in this e-mail=
=20
are those of the sender and do not necessarily coincide with those of the=
=20
organisation.
Please consider the environment before printing this e-mail!
