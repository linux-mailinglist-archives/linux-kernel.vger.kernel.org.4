Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928374147C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjF1PDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjF1PDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:03:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC03A10D5;
        Wed, 28 Jun 2023 08:03:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98e011f45ffso474652066b.3;
        Wed, 28 Jun 2023 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687964615; x=1690556615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wS0/tVVfYmWAxxo37y+v0M6HIvge1vajIKiOpWu/wQ=;
        b=ME6xclwZwAKxvdbSiH7N5rG8ryo5U4E538D0nnDMbunKQdRXYX78PbUueytpfqLFhB
         nm08tVIGha1qYoNPECIqFEOr8sams/BfwupmWtLEwvaZJUuaKt5dth9n41ZkWYLW0OBF
         58vvJ9OclwmfZLNmoRSfzZrfs9sEBCIKTLFU59hrHX525xL9UnaJKwT/8RozQJWOIbYS
         Hn52ieE/PTBNEveYm0ZQ5w38seM577yXEC2AFMLmrOg60VLG2wH5q1Tr1UpzIHIuhT4C
         0QxQRRt7Op67cHEbPJjCJETKBf7cX9JIXGomfJtJeRl04FaW9ZXeIv7oFBWv9Xz80Pns
         aw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964615; x=1690556615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wS0/tVVfYmWAxxo37y+v0M6HIvge1vajIKiOpWu/wQ=;
        b=UvnIajN4KnO2WL323bENQcwoaDqRkp+wSSl9rycdpZGad2pynKuFSn84VQvETEhRS9
         3p9vMun9Yh519QcohpdZzCSKzT6ldZjA7n99Kcr6qiQks/asUQ6G0dG8RaQ3PHvy10p/
         i9rHn7JfLCCWlNabUuVePoMi487Qvgh0aoRM5g/UhVunYgrdef/NjfepqZtNYr8h25aX
         3HxZxCaB082rJxJaOxzl1bsQMAWuV7sQ5Yjb5JWGBFAOjDAGVAnJ+JzDQuzOyzzrWhnD
         ikSLbMYh555UDG9PcxkYGCCPlqjDHgqcYLAUVxZn8cQ6OpZC/177SBJAyR6ubp82EjMY
         PvmA==
X-Gm-Message-State: AC+VfDyrHetMobcKKMdnZ0wXaDcPPHSZ7I3uhXUIOICNG3Oo57a74ti7
        lZzuyDKLmWreANZVBI6+wuVeL8amyYdmGu0NzCHYK9sM
X-Google-Smtp-Source: ACHHUZ4bDstTP1DqJWuzHP2Nrm5f9oBvhMa44NotmxDjlNg0QAlbZg/QasCcLY/KGLdkWShNGNYgTSRq+ocENqiQQrA=
X-Received: by 2002:a17:907:6d1d:b0:992:4a1b:30e2 with SMTP id
 sa29-20020a1709076d1d00b009924a1b30e2mr3237054ejc.7.1687964614906; Wed, 28
 Jun 2023 08:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230628011439.159678-1-linux@treblig.org> <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey> <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
 <ZJxGFBzuhU8t5rcx@gallifrey>
In-Reply-To: <ZJxGFBzuhU8t5rcx@gallifrey>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 28 Jun 2023 10:03:22 -0500
Message-ID: <CAH2r5ms1UE4vAuakBLuayv1CXw3sC_OcuhtCrz5mV_ftR+=rjg@mail.gmail.com>
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>, krisman@collabora.com,
        Tom Talpey <tom@talpey.com>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linkinjeon@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 9:40=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
> > > Actually, would you be ok with smb_unicode_common ?  The reason is th=
at
> > > you end up with a module named unicode_common  that sounds too generi=
c.
> >
> > I'd suggest make it generic and move it to fs/nls/. I'd run it by the n=
ls
> > maintainers, but I don't think there are any.
>
> Steve & Tom - would you be OK with that?

Yes - absolutely

> (Copying in Gabriel Bertazi, owner of fs/unicode; although this isn't
> utf-8)

Unicode UCS-2


--=20
Thanks,

Steve
