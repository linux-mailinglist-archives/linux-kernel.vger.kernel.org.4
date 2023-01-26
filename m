Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591567CF85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAZPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAZPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:13:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89322EB79
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:13:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d30so3466580lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc6ZwBnEHfllxJYiT753cJcnxMfaeJjttvRk6qoxRnQ=;
        b=F1wBM/+4TMypuSmQSIBzjeRJFFyaHQ/0qchQXZcr/y1UPvy/oKavxAnQCmS3lMrKM7
         LvRmeNXxA8/YJyJtwlt+EfqApeBOS0bN+KqQTMl4fzvJg+5okFap0FyU2HcYivlwX858
         qJRjg/XQg2t84NUMvaqnxn9c8QaDbakgQCqK9jS+Qq9WsTcsvio+93agkPl9RN5xn2LE
         G3P1osGYD4WVgvIHIPPRZ2XNTdw9DorvlnCrVtwQLAeiTJ3qxPQdPyOuVQeR9cXBhHo0
         cqF61Q7e7j9g4UPI+q8h+AKnriHt2Ynt2P2a8DNsuK9vqUgNOIitUN4UYT/Yjc31D9Tn
         I/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hc6ZwBnEHfllxJYiT753cJcnxMfaeJjttvRk6qoxRnQ=;
        b=e/8h2wHyoeRVv8p1OnJQYw1h06qzJ7NEq6/Do6v0tXW0ZGbSbBbu4rSj2/So8pfDA7
         XZrtcyOwzBPDyxqe82BgBcnknjVfoSD1AGweXmpWIdz57vePu9pJDPclEaWSi5kKCinu
         A8WIbXGoL+ulLeIt0ysZyGFYqCboliy9A/uoyBikF/2/zGVaVKqb/J2jtwEefeV2gIso
         TdRXIRHhRbONHlOT/l/RQ40bwCiG21jnqCwODYv3SR5RpLf+p5RWcoA1wb2l0rsIH8MS
         arjzJUJlfOKZ6b9I8PpAV9T5UPFr0x213cb5DrLgH0ta8cBiGqaXCj6fF2b60QvgzuZT
         xY8g==
X-Gm-Message-State: AFqh2kqwrSeZXgrIcllDYL/Q8+EWOjl1qysD7JEcdf0Z7QqY8lCO0327
        xLoFxE9r9bruzdpX4E4EQqwNY5jbETAdGZ4RkBI=
X-Google-Smtp-Source: AMrXdXuXLi2sgAvR7DVwDeHXnP46pNcE98/obdzUFlb01kXRVZpGWgVhlaA5MI4hdvDdc/Mj43YUXtaznXztN/mcpBk=
X-Received: by 2002:ac2:5596:0:b0:4cb:334f:85ef with SMTP id
 v22-20020ac25596000000b004cb334f85efmr1675146lfg.67.1674746004845; Thu, 26
 Jan 2023 07:13:24 -0800 (PST)
MIME-Version: 1.0
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm> <Y9E5Cg7mreDx737N@redhat.com>
 <CAFLxGvwHRK3vyXiCv5ELvrDSEkcDgV5c6pNnWgWhcATfp1dedA@mail.gmail.com> <Y9KVHnHnig4jwNPx@work-vm>
In-Reply-To: <Y9KVHnHnig4jwNPx@work-vm>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 26 Jan 2023 16:13:11 +0100
Message-ID: <CAFLxGvyMncqjkEXiOqenQu+rZW46RP7UorXs36+awmgnBxTGhA@mail.gmail.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 3:58 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Richard Weinberger (richard.weinberger@gmail.com) wrote:
> > On Wed, Jan 25, 2023 at 3:22 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > Any virtual device exposed to the guest that can transfer potentially
> > > sensitive data needs to have some form of guest controlled encryption
> > > applied. For disks this is easy with FDE like LUKS, for NICs this is
> > > already best practice for services by using TLS. Other devices may no=
t
> > > have good existing options for applying encryption.
> >
> > I disagree wrt. LUKS. The cryptography behind LUKS protects persistent =
data
> > but not transport. If an attacker can observe all IO you better
> > consult a cryptographer.
> > LUKS has no concept of session keys or such, so the same disk sector wi=
ll
> > always get encrypted with the very same key/iv.
>
> Are you aware of anything that you'd use instead?

Well, I'd think towards iSCSI over TLS to protect the IO transport.

> Are you happy with dm-verity for protection against modification?

Like LUKS (actually dm-crypt) the crypto behind is designed to protect
persistent data not transport.
My fear is that an attacker who is able to observe IOs can do bad things.
