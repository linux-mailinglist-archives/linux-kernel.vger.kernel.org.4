Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C79724BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbjFFSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjFFSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:50:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5536EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:50:46 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E3543F15B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686077445;
        bh=ZBMK+DdZXFCRFi5Z/MVobjT4mwItd0TF7QfSBIyRNYM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mHf/l9DVLNuZu8eEjcBx5Qm56t7Mik+HTIDZh41XKRBqWrk2qf2lQoJxtv09ia2tm
         FBPHLtePOZiu24f01Bos9p6SM05WH/0RsW0PPEwUFtoMA1EPAZKH59agGFdMOGu9Dq
         bi+iQlPEa6IH15VeC3B4HLxsi+CtYErz6Z7NXxCfRIWXSBuH7y8zg+m0739DBhvqRs
         WSleRgNOG/gZznhjfBU79X+79qFycVUE3NMDyupUF81e8NRQZIgqTho8H4wa2HSV/I
         oMlW+ee9AmJaR4qYlAyXD+XeY339s3l4eGJD4dkBNkG7NgwXNuAQo7nxaScUpVP9vU
         QwYS6D/EkPQLQ==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-565a1788f3fso105693047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077443; x=1688669443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBMK+DdZXFCRFi5Z/MVobjT4mwItd0TF7QfSBIyRNYM=;
        b=WxP+KgjwfoBkcAgKonNdosddUcaovmGLSuTvZg1Z8qaHGYj8lZ7SSe2VZ1UuSCjI7I
         zXHK6a7eOEgKuC8JoVY147pZaKMAqN6keZCuClQ+qQh7Ncvr+k+Ksn58rDhKONMsknMS
         lTZKVlenMhi5Zm10XSz2fG1i5ytmlVINrBtcMfrIQ9A1EO8HkcDeuOtZUx+H8GNNOXko
         WLZUe6qcgJ92IzLhbABL/DrOFbVnSms7YOfSSXHvcVRzlvxdz6kAd8RZEW/d8KalNuDc
         ms0pDiFWTWN5Sj/3rUeBWH3QnCbHljOas/+/qF+Ol8H8fhufkE/a+qVs8YUzqUZKxEyw
         cHog==
X-Gm-Message-State: AC+VfDyfXV7cfvxkeYvwt8IR8DTkh5lT5NFCP95azpasIJyyBQb+13Jo
        YB88LPAt2/ABjYR4ivN2Rp6KMDmerw1A3K7MG5JYRdIM0PIvOngpXnIzLM+7ORbqk0K3Hh8mC0s
        N0kbuW59kohVPjA+Vb12JtksbY3Q1+HgAA50kS8EFY1pVTHpJXG/qWHo+FfLb1tDheagw
X-Received: by 2002:a0d:df93:0:b0:567:2891:a2ec with SMTP id i141-20020a0ddf93000000b005672891a2ecmr2847085ywe.22.1686077443442;
        Tue, 06 Jun 2023 11:50:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eG8FXdCtl3Jo2AHE6KMXFNu+4hALAAsTlXcmSnAR6Is4KRsx+SE5FovsuMWhsnejikrGXFCTSV6j866OLXwU=
X-Received: by 2002:a0d:df93:0:b0:567:2891:a2ec with SMTP id
 i141-20020a0ddf93000000b005672891a2ecmr2847070ywe.22.1686077443171; Tue, 06
 Jun 2023 11:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com> <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
In-Reply-To: <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 6 Jun 2023 20:50:32 +0200
Message-ID: <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Paul Moore <paul@paul-moore.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > pr_warn message clearly says that GID should be printed,
> > but we have UID there. Let's fix that.
> >
> > Found accidentaly during the work on isolated user namespaces.
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v2: __kuid_val -> __kgid_val
> > ---
> >  security/safesetid/lsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'm assuming you're going to pick this up Micah?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Dear Paul!

Thanks for your review!

Gentle ping to Micah Morton :-)

Kind regards,
Alex

>
> > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > index e806739f7868..5be5894aa0ea 100644
> > --- a/security/safesetid/lsm.c
> > +++ b/security/safesetid/lsm.c
> > @@ -131,7 +131,7 @@ static int safesetid_security_capable(const struct =
cred *cred,
> >                  * set*gid() (e.g. setting up userns gid mappings).
> >                  */
> >                 pr_warn("Operation requires CAP_SETGID, which is not av=
ailable to GID %u for operations besides approved set*gid transitions\n",
> > -                       __kuid_val(cred->uid));
> > +                       __kgid_val(cred->gid));
> >                 return -EPERM;
> >         default:
> >                 /* Error, the only capabilities were checking for is CA=
P_SETUID/GID */
> > --
> > 2.34.1
>
> --
> paul-moore.com
